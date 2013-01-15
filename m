From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [mmc:mmc-next 5/29] drivers/mmc/core/slot-gpio.c:123:2: error:
 implicit declaration of function 'devm_gpio_request_one'
Date: Tue, 15 Jan 2013 15:02:34 +0800
Message-ID: <20130115070232.GA32113@S2101-09.ap.freescale.net>
References: <50f47c91.EClSUIYzYIJ/Mlr9%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:48014
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752734Ab3AOHCN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jan 2013 02:02:13 -0500
Content-Disposition: inline
In-Reply-To: <50f47c91.EClSUIYzYIJ/Mlr9%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Jan 15, 2013 at 05:45:53AM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
> head:   e35219140bbf0b6efcd8feb93fa6e9cb2df5bc08
> commit: 8733ba654cd9ad0396ac081b4858bfa0a29c5519 [5/29] mmc: slot-gpio: use devm_* managed functions to ease users
> config: make ARCH=blackfin TCM-BF537_defconfig
> 
> All error/warnings:
> 
>    In file included from arch/blackfin/include/asm/gpio.h:321:0,
>                     from include/linux/gpio.h:45,
>                     from drivers/mmc/core/slot-gpio.c:12:
>    include/asm-generic/gpio.h:298:10: warning: 'struct gpio_chip' declared inside parameter list [enabled by default]
>    include/asm-generic/gpio.h:298:10: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
>    include/asm-generic/gpio.h:304:35: warning: 'struct gpio_chip' declared inside parameter list [enabled by default]
>    drivers/mmc/core/slot-gpio.c: In function 'mmc_gpio_request_ro':
> >> drivers/mmc/core/slot-gpio.c:123:2: error: implicit declaration of function 'devm_gpio_request_one' [-Werror=implicit-function-declaration]
>    drivers/mmc/core/slot-gpio.c: In function 'mmc_gpio_free_ro':
> >> drivers/mmc/core/slot-gpio.c:216:2: error: implicit declaration of function 'devm_gpio_free' [-Werror=implicit-function-declaration]
>    cc1: some warnings being treated as errors
> 
Thanks for the reporting.  I'm working on a fixing inside gpio headers.

Shawn

