const { remote } = require('webdriverio');

const opts = {
  hostname: '127.0.0.1',
  port: 4723,
  path: '/',   // 👈 مهم جدًا

  capabilities: {
    platformName: 'Android',

    'appium:automationName': 'UiAutomator2',
    'appium:deviceName': 'Android Emulator',
    'appium:appPackage': 'com.example.laza_app',
    'appium:appActivity': '.MainActivity',
    'appium:noReset': true,
  },
};

(async () => {
  const driver = await remote(opts);

  try {
    const email = await driver.$('~login_email');
    await email.setValue('test@appium.com');

    const password = await driver.$('~login_password');
    await password.setValue('123456');

    const loginBtn = await driver.$('~login_button');
    await loginBtn.click();

    await driver.pause(3000);
    console.log('✅ Auth Test Passed');
  } catch (e) {
    console.log('❌ Auth Test Failed');
    console.log(e);
  } finally {
    await driver.deleteSession();
  }
})();
