#!/usr/bin/env python3
"""
Laza App - Cart Test
Appium Test Case for adding item to cart flow
"""

import unittest
from appium import webdriver
from appium.webdriver.common.appiumby import AppiumBy
from appium.options.android import UiAutomator2Options
import time

class CartTest(unittest.TestCase):
    def setUp(self):
        # Android device capabilities
        options = UiAutomator2Options()
        options.platform_name = "Android"
        options.platform_version = "11.0"  # Adjust based on your emulator
        options.device_name = "emulator-5554"
        options.app = "/path/to/your/laza_app.apk"  # Update with actual APK path
        options.automation_name = "UiAutomator2"
        options.no_reset = False

        # Initialize driver
        self.driver = webdriver.Remote("http://localhost:4723/wd/hub", options=options)
        self.driver.implicitly_wait(10)

    def tearDown(self):
        if self.driver:
            self.driver.quit()

    def test_add_to_cart_flow(self):
        """Test Case: Open product -> Add to cart -> Open cart -> Verify item exists"""

        # Wait for app to load and assume user is logged in
        time.sleep(3)

        print("Testing add to cart flow...")

        # Navigate to products/home screen
        # Assuming we're already on home screen after login

        # Find and click on first product
        first_product = self.driver.find_element(AppiumBy.ID, "product_item_0")  # Update with actual ID
        first_product.click()

        # Wait for product detail screen
        time.sleep(2)

        # Click add to cart button
        add_to_cart_button = self.driver.find_element(AppiumBy.ID, "add_to_cart_button")
        add_to_cart_button.click()

        # Wait for cart update
        time.sleep(2)

        # Verify success message or cart badge update
        try:
            success_message = self.driver.find_element(AppiumBy.ID, "cart_success_message")
            self.assertTrue(success_message.is_displayed(), "Success message should be shown")
            print("✓ Item added to cart successfully")
        except:
            # Check cart badge/count
            cart_badge = self.driver.find_element(AppiumBy.ID, "cart_badge")
            badge_text = cart_badge.text
            self.assertNotEqual(badge_text, "0", "Cart badge should show item count")

        # Navigate to cart screen
        cart_button = self.driver.find_element(AppiumBy.ID, "cart_navigation_button")
        cart_button.click()

        # Wait for cart screen to load
        time.sleep(2)

        # Verify cart item exists
        cart_item = self.driver.find_element(AppiumBy.ID, "cart_item_0")
        self.assertTrue(cart_item.is_displayed(), "Cart item should be visible in cart")

        # Verify item details (optional)
        item_title = self.driver.find_element(AppiumBy.ID, "cart_item_title")
        self.assertIsNotNone(item_title.text, "Cart item should have a title")

        print("✓ Cart test completed successfully")

if __name__ == '__main__':
    unittest.main()
