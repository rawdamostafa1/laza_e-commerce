const { remote } = require('webdriverio');

const opts = {
  path: '/wd/hub',
  port: 4723,
  capabilities: {
    platformName: 'Android',
    automationName: 'UiAutomator2',
    deviceName: 'Android Emulator',
    appPackage: 'com.example.laza_app',
    appActivity: '.MainActivity',
  }
};

(async () => {
  const driver = await remote(opts);

  try {
    // انتظار المنتجات
    await driver.pause(4000);

    // فتح أول منتج
    const firstProduct = await driver.$('//android.widget.TextView');
    await firstProduct.click();

    // Add to cart
    const addToCart = await driver.$('~add_to_cart');
    await addToCart.click();

    // فتح Cart
    const cartTab = await driver.$('~cart');
    await cartTab.click();

    console.log('✅ Cart Test Passed');
  } catch (e) {
    console.log('❌ Cart Test Failed', e);
  } finally {
    await driver.deleteSession();
  }
})();
