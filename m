From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v6 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Tue, 4 Sep 2018 23:28:50 +0800
Message-ID: <20180904152850.GD17047@intel.com>
References: <20180831225616.29221-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lYVfafuUkPqz/tKz"
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20180831225616.29221-2-jmkrzyszt@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org, linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Peter Rosin <peda@axentia.se>, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devel@driverdev.osuosl.org, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Michael Hennerich <Michael.Hennerich@analog.com>, linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>, Miguel
List-Id: linux-mmc@vger.kernel.org


--lYVfafuUkPqz/tKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Janusz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on gpio/for-next]
[also build test ERROR on v4.19-rc2 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Janusz-Krzysztofik/gpiolib-speed-up-GPIO-array-processing/20180903-174241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
config: arm-cns3420vb_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 
:::::: branch date: 5 hours ago
:::::: commit date: 5 hours ago

All errors (new ones prefixed by >>):

   drivers/mmc/core/pwrseq_simple.c: In function 'mmc_pwrseq_simple_set_gpios_value':
>> drivers/mmc/core/pwrseq_simple.c:49:13: error: passing argument 3 of 'gpiod_set_array_value_cansleep' from incompatible pointer type [-Werror=incompatible-pointer-types]
                value_bitmap);
                ^~~~~~~~~~~~
   In file included from drivers/mmc/core/pwrseq_simple.c:18:0:
   include/linux/gpio/consumer.h:400:20: note: expected 'int *' but argument is of type 'long unsigned int *'
    static inline void gpiod_set_array_value_cansleep(unsigned int array_size,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

# https://github.com/0day-ci/linux/commit/00db98568b73a7b04c5120e5b87934c7355cc015
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 00db98568b73a7b04c5120e5b87934c7355cc015
vim +/gpiod_set_array_value_cansleep +49 drivers/mmc/core/pwrseq_simple.c

5b96fea73 Srinivas Kandagatla      2016-04-14  36  
934f1f483 Javier Martinez Canillas 2015-01-29  37  static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
934f1f483 Javier Martinez Canillas 2015-01-29  38  					      int value)
934f1f483 Javier Martinez Canillas 2015-01-29  39  {
ce0372758 Javier Martinez Canillas 2015-09-21  40  	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
64a67d476 Martin Fuzzey            2016-01-20  41  
64a67d476 Martin Fuzzey            2016-01-20  42  	if (!IS_ERR(reset_gpios)) {
486e66613 Tobin C. Harding         2018-03-26  43  		int nvalues = reset_gpios->ndescs;
00db98568 Janusz Krzysztofik       2018-09-01  44  		DECLARE_BITMAP(value_bitmap, nvalues);
934f1f483 Javier Martinez Canillas 2015-01-29  45  
00db98568 Janusz Krzysztofik       2018-09-01  46  		*value_bitmap = value;
486e66613 Tobin C. Harding         2018-03-26  47  
00db98568 Janusz Krzysztofik       2018-09-01  48  		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
00db98568 Janusz Krzysztofik       2018-09-01 @49  					       value_bitmap);
64a67d476 Martin Fuzzey            2016-01-20  50  	}
934f1f483 Javier Martinez Canillas 2015-01-29  51  }
934f1f483 Javier Martinez Canillas 2015-01-29  52  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--lYVfafuUkPqz/tKz
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
T/0/sSQIoD2KAAA=

--lYVfafuUkPqz/tKz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--lYVfafuUkPqz/tKz--
