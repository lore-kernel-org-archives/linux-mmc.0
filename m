From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v6 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Tue, 4 Sep 2018 23:28:18 +0800
Message-ID: <20180904152817.GC17047@intel.com>
References: <20180831225616.29221-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180831225616.29221-2-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy
List-Id: linux-mmc@vger.kernel.org

Hi Janusz,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on gpio/for-next]
[also build test WARNING on v4.19-rc2 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Janusz-Krzysztofik/gpiolib-speed-up-GPIO-array-processing/20180903-174241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__
:::::: branch date: 9 hours ago
:::::: commit date: 9 hours ago

>> drivers/mux/gpio.c:25:9: sparse: Variable length array is used.
--
>> drivers/i2c/muxes/i2c-mux-gpio.c:29:9: sparse: Variable length array is used.
   include/linux/device.h:685:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/device.h:685:13: sparse: not a function <noident>
   include/linux/device.h:685:13: sparse: call with no type!

# https://github.com/0day-ci/linux/commit/00db98568b73a7b04c5120e5b87934c7355cc015
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 00db98568b73a7b04c5120e5b87934c7355cc015
vim +25 drivers/mux/gpio.c

2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  21  
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  22  static int mux_gpio_set(struct mux_control *mux, int state)
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  23  {
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  24  	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
00db98568 drivers/mux/gpio.c     Janusz Krzysztofik 2018-09-01 @25  	DECLARE_BITMAP(value_bitmap, mux_gpio->gpios->ndescs);
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  26  	
00db98568 drivers/mux/gpio.c     Janusz Krzysztofik 2018-09-01  27  	*value_bitmap = state;
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  28  
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  29  	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
00db98568 drivers/mux/gpio.c     Janusz Krzysztofik 2018-09-01  30  				       mux_gpio->gpios->desc, value_bitmap);
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  31  
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  32  	return 0;
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  33  }
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  34  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
