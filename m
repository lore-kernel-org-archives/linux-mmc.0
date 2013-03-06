From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: update check code for cd-broken or
 nonremovable card
Date: Wed, 6 Mar 2013 12:13:20 +0800
Message-ID: <CADz5_gJ1MSFJK=4gspEBQKGPiPUBV0yC5G4WZa5h-kLeZN0Qjg@mail.gmail.com>
References: <1362130829-4677-1-git-send-email-kliu5@marvell.com>
	<1DB98640-1C4C-457F-B555-3E5152B95AC6@nvidia.com>
	<CADz5_gLteMpVcw28WUoX1B_W0hNpzqGiV+UuzJFo_+9ptRmXVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:48779 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab3CFENV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Mar 2013 23:13:21 -0500
Received: by mail-ob0-f171.google.com with SMTP id x4so3230550obh.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 Mar 2013 20:13:21 -0800 (PST)
In-Reply-To: <CADz5_gLteMpVcw28WUoX1B_W0hNpzqGiV+UuzJFo_+9ptRmXVA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>
Cc: Kevin Liu <kliu5@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>

2013/3/1 Kevin Liu <keyuan.liu@gmail.com>:
> 2013/3/1 Philip Rakity <prakity@nvidia.com>:
>>
>> On Mar 1, 2013, at 9:40 AM, Kevin Liu <kliu5@marvell.com> wrote:
>>
>>> in function sdhci_request:
>>> 1. If quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION is selected, there is no
>>> card detection available and polling must be used. Gpio detect must
>>> _not_ be supported under this case.
>>> Change the sequence to check SDHCI_QUIRK_BROKEN_CARD_DETECTION first,
>>> which make code more clear.
>>> 2. nonremovable card should be also assumed always present.
>>>
>>> in function sdhci_enable_irq_wakeups:
>>> 1. nonremovable card should be also assumed no insert/remove wakeup
>>> needed like some sdio cards which is nonremovable and can wakeup host
>>> only by card int.
>>>
>>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>>> ---
>>> drivers/mmc/host/sdhci.c |   30 ++++++++++++++++--------------
>>> 1 file changed, 16 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index c94fd6c..e4ada0d 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1337,19 +1337,20 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>>
>>>       host->mrq = mrq;
>>>
>>> -     /*
>>> -      * Firstly check card presence from cd-gpio.  The return could
>>> -      * be one of the following possibilities:
>>> -      *     negative: cd-gpio is not available
>>> -      *     zero: cd-gpio is used, and card is removed
>>> -      *     one: cd-gpio is used, and card is present
>>> -      */
>>> -     present = mmc_gpio_get_cd(host->mmc);
>>> -     if (present < 0) {
>>> -             /* If polling, assume that the card is always present. */
>>> -             if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>>> -                     present = 1;
>>> -             else
>>> +     /* If polling/nonremovable, assume that the card is always present. */
>>> +     if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
>>> +                     (host->mmc->caps & MMC_CAP_NONREMOVABLE)) {
>>> +             present = 1;
>>> +     } else {
>>> +             /*
>>> +              * Firstly check card presence from cd-gpio.  The return could
>>> +              * be one of the following possibilities:
>>> +              *     negative: cd-gpio is not available
>>> +              *     zero: cd-gpio is used, and card is removed
>>> +              *     one: cd-gpio is used, and card is present
>>> +              */
>>> +             present = mmc_gpio_get_cd(host->mmc);
>>> +             if (IS_ERR_VALUE(present))
>>>                       present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
>>>                                       SDHCI_CARD_PRESENT;
>>
>> Hi Kevin
>>
>> does it make sense to move this logic to a more generic function (static inline ?)
>> int sdhci_card_present ()
>>
>> and encapsulate all the logic there for gpio cd, present state (card is there) etc.
>>
>> Philip
>>
>
> Philip,
>
> Good idea...Will call the function "sdhci_do_get_cd" introdunced in my
> previous patch. Thanks!
>

This patch has been updated and added to below patchset.
[PATCH 0/3] mmc: core/sdhci: enhance card detect code ([PATCH v3 3/3]
mmc: sdhci: update check code for cd-broken or)
So it can be ignored.

Thanks
Kevin
