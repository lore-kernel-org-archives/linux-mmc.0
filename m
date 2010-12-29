From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: RE: [RFC] sdhci: use ios->clock to know when sdhci is idle
Date: Wed, 29 Dec 2010 14:45:21 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A47331E86F6E@shsmsx501.ccr.corp.intel.com>
References: <1293023621-3077-1-git-send-email-tardyp@gmail.com>
	<41EFD7A46E18724CAB128DAD00733480193D2AE61C@shsmsx502.ccr.corp.intel.com>
 <AANLkTinYWODS785AefQ7hV+urPkAn1+En-fZEaFQygLG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinYWODS785AefQ7hV+urPkAn1+En-fZEaFQygLG@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>, "Yuan, Hang" <hang.yuan@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Maxim Levitsky <maximlevitsky@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Ohad Ben-Cohen <ohad@wizery.com>
List-Id: linux-mmc@vger.kernel.org

>> Another question is why to call pm_runtime_get/put when ios-clock changes?
>Is it based on
>> Linus Walleij's aggressive clock gating framework patch? Linus' patch doesn't
>gate SDIO cards.
>runtime_suspend of sdhci should *not* gate the sdio card. It should
>only gate the sdhci.
>An sdio bus inactive does not mean that the sdio card is inactive.
>(think wifi Idle, bluetooth idle, ethernet idle)
>
>We need to suspend the sdhci as soon as the sdio bus is inactive,
>which is what clock gating framework is trying to detect. 

If the wifi sdio card enters into some low power state which will not use the sdio bus, then the wifi driver can notify the sdhci host controller driver to power down the host controller only by calling the pm_runtime_put() and pm_suspend_ignore_children(). That is, it can be handled well in the current runtime pm framework. So, why we have to move to the 'aggressive clock gating framework'?

Also, I noticed that in the current 'aggressive clock gating framework' patch, the clock gating of SDIO card has been disabled (please reference code and comments of function mmc_host_may_gate_card() in that patch). That means, if discard the runtime PM framework and move to the aggressive clock gating framework, then all the SDIO cards (including the wifi sdio card) will fail to notify its host controller to enter into any low power mode.

Thanks.

Regards,
Yunpeng
