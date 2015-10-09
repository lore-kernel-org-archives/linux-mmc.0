From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: Fix init_card in 52Mhz
Date: Fri, 9 Oct 2015 10:29:57 +0200
Message-ID: <CAPDyKFpa4RZJaEEaVuhceOeOeQg_OWKwsXvFWf9ZLkyTgWfx7A@mail.gmail.com>
References: <1444288147-24013-1-git-send-email-chaotian.jing@mediatek.com>
	<CAPDyKFqrjP3-y+ucm5ybwXefsDLOYcPF9XqMciwhRkjD5NXLBg@mail.gmail.com>
	<56166988.20900@intel.com>
	<CAPDyKFoWWMXC-DECqhw=EXerid5toWKxr4uLq0WevPo8LrrDqw@mail.gmail.com>
	<56177381.9020509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56177381.9020509@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Fabio Estevam <fabio.estevam@freescale.com>, Johan Rudholm <johan.rudholm@axis.com>, Gwendal Grignou <gwendal@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

[...]

>>> Then you need to remove the hw_reset test from mmc_test.  Refer:
>>>
>>>         http://marc.info/?l=linux-mmc&m=144360165906544&w=2
>>>
>>
>> I realize that the test becomes a bit different, but I don't think it's useless.
>>
>> If we add a check for MMC_CAP_HW_RESET and verify that the
>> host->ops->hw_reset exists, then we can assume that the "hw_reset"
>> sequence has executed. And if mmc_init_card() fails, that would
>> probably mean that the reset also failed, right?
>
> In the test case, the card is in a working state.  Generally I would then
> expect reinitialization to work irrespective of whether or not the hardware
> is actually reset.

That's not always the case. I have seen many strange things happening
while trying to re-initialize/reset the card. :-)

>
> Here are some other options:
>         1. have mmc_test hook the host->ops->hw_reset() fn and do the send_status
> itself.
>         2. have mmc_test set a flag on the card that it is being tested
> and only do the send_status if the flag is set

I assume that both 1) and 2) still means we need to manage the
scenario with re-tuning, which I rather would like us to prevent.

Unless we find a way to call mmc_set_initial_state() before doing the
reset, as that would disable re-tuning...

>         3. remove the send_status call and rename the mmc_test from "eMMC hardware
> reset" to just "Reset test (doesn't check hw reset did reset)"

That's would work and perhaps this is the best way to go as we would
then also be able to use the test for SD-cards. Let's do this then!

Kind regards
Uffe
