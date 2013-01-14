From: kbuild test robot <fengguang.wu@intel.com>
Subject: [mmc:mmc-next 5/29] drivers/mmc/core/slot-gpio.c:123:2: error:
 implicit declaration of function 'devm_gpio_request_one'
Date: Tue, 15 Jan 2013 05:45:53 +0800
Message-ID: <50f47c91.EClSUIYzYIJ/Mlr9%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62592 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757267Ab3ANVpy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jan 2013 16:45:54 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
head:   e35219140bbf0b6efcd8feb93fa6e9cb2df5bc08
commit: 8733ba654cd9ad0396ac081b4858bfa0a29c5519 [5/29] mmc: slot-gpio: use devm_* managed functions to ease users
config: make ARCH=blackfin TCM-BF537_defconfig

All error/warnings:

   In file included from arch/blackfin/include/asm/gpio.h:321:0,
                    from include/linux/gpio.h:45,
                    from drivers/mmc/core/slot-gpio.c:12:
   include/asm-generic/gpio.h:298:10: warning: 'struct gpio_chip' declared inside parameter list [enabled by default]
   include/asm-generic/gpio.h:298:10: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
   include/asm-generic/gpio.h:304:35: warning: 'struct gpio_chip' declared inside parameter list [enabled by default]
   drivers/mmc/core/slot-gpio.c: In function 'mmc_gpio_request_ro':
>> drivers/mmc/core/slot-gpio.c:123:2: error: implicit declaration of function 'devm_gpio_request_one' [-Werror=implicit-function-declaration]
   drivers/mmc/core/slot-gpio.c: In function 'mmc_gpio_free_ro':
>> drivers/mmc/core/slot-gpio.c:216:2: error: implicit declaration of function 'devm_gpio_free' [-Werror=implicit-function-declaration]
   cc1: some warnings being treated as errors

vim +/devm_gpio_request_one +123 drivers/mmc/core/slot-gpio.c

   117		ret = mmc_gpio_alloc(host);
   118		if (ret < 0)
   119			return ret;
   120	
   121		ctx = host->slot.handler_priv;
   122	
 > 123		ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
   124					    ctx->ro_label);
   125		if (ret < 0)
   126			return ret;
   127	
   128		ctx->ro_gpio = gpio;
   129	
   130		return 0;
   131	}
   132	EXPORT_SYMBOL(mmc_gpio_request_ro);
   133	
   134	/**
   135	 * mmc_gpio_request_cd - request a gpio for card-detection
   136	 * @host: mmc host
   137	 * @gpio: gpio number requested
   138	 *
   139	 * As devm_* managed functions are used in mmc_gpio_request_cd(), client
   140	 * drivers do not need to explicitly call mmc_gpio_free_cd() for freeing up,
   141	 * if the requesting and freeing are only needed at probing and unbinding time
   142	 * for once.  However, if client drivers do something special like runtime
   143	 * switching for card-detection, they are responsible for calling
   144	 * mmc_gpio_request_cd() and mmc_gpio_free_cd() as a pair on their own.
   145	 *
   146	 * Returns zero on success, else an error.
   147	 */
   148	int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
   149	{
   150		struct mmc_gpio *ctx;
   151		int irq = gpio_to_irq(gpio);
   152		int ret;
   153	
   154		ret = mmc_gpio_alloc(host);
   155		if (ret < 0)
   156			return ret;
   157	
   158		ctx = host->slot.handler_priv;
   159	
   160		ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
   161					    ctx->cd_label);
   162		if (ret < 0)
   163			/*
   164			 * don't bother freeing memory. It might still get used by other
   165			 * slot functions, in any case it will be freed, when the device
   166			 * is destroyed.
   167			 */
   168			return ret;
   169	
   170		/*
   171		 * Even if gpio_to_irq() returns a valid IRQ number, the platform might
   172		 * still prefer to poll, e.g., because that IRQ number is already used
   173		 * by another unit and cannot be shared.
   174		 */
   175		if (irq >= 0 && host->caps & MMC_CAP_NEEDS_POLL)
   176			irq = -EINVAL;
   177	
   178		if (irq >= 0) {
   179			ret = devm_request_threaded_irq(&host->class_dev, irq,
   180				NULL, mmc_gpio_cd_irqt,
   181				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
   182				ctx->cd_label, host);
   183			if (ret < 0)
   184				irq = ret;
   185		}
   186	
   187		host->slot.cd_irq = irq;
   188	
   189		if (irq < 0)
   190			host->caps |= MMC_CAP_NEEDS_POLL;
   191	
   192		ctx->cd_gpio = gpio;
   193	
   194		return 0;
   195	}
   196	EXPORT_SYMBOL(mmc_gpio_request_cd);
   197	
   198	/**
   199	 * mmc_gpio_free_ro - free the write-protection gpio
   200	 * @host: mmc host
   201	 *
   202	 * It's provided only for cases that client drivers need to manually free
   203	 * up the write-protection gpio requested by mmc_gpio_request_ro().
   204	 */
   205	void mmc_gpio_free_ro(struct mmc_host *host)
   206	{
   207		struct mmc_gpio *ctx = host->slot.handler_priv;
   208		int gpio;
   209	
   210		if (!ctx || !gpio_is_valid(ctx->ro_gpio))
   211			return;
   212	
   213		gpio = ctx->ro_gpio;
   214		ctx->ro_gpio = -EINVAL;
   215	
   216		devm_gpio_free(&host->class_dev, gpio);
   217	}
   218	EXPORT_SYMBOL(mmc_gpio_free_ro);
   219	

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
