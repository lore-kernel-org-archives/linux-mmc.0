From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 10/14] mmc: jz4740: Let the pinctrl driver configure  the pins
Date: Thu, 26 Jan 2017 11:10:37 +0100
Message-ID: <0e03c853297688e19a9ddca239aaa583@mail.crapouillou.net>
References: <201701261459.cfXHvGfn%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <201701261459.cfXHvGfn%fengguang.wu@intel.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com
List-Id: linux-mmc@vger.kernel.org

Hi Kbuild Test Robot,

> 
> drivers/mmc/host/jz4740_mmc.c: In function 'jz4740_mmc_set_ios':
> drivers/mmc/host/jz4740_mmc.c:864:7: error: implicit declaration of 
> function 'gpio_is_valid' [-Werror=implicit-function-declaration]

  if (gpio_is_valid(host->pdata->gpio_power))
  ^~~~~~~~~~~~~

Uuh, I'm sorry about that. Looks like I removed one header too much 
(<linux/gpio.h>).
My fault, lately I was testing with ci20_defconfig which doesn't enable 
this driver.

Should I send a v4?

Apologies,
-Paul
