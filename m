From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v4 14/15] mmc: sdhci: fix the bug that DDR50 can't work
 for emmc
Date: Thu, 27 Sep 2012 21:50:48 +0900
Message-ID: <CAGxe1ZFpTQf-L=83A4NobKe3K6a9=hrtofg=p3m4cCqdzo88Vw@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-15-git-send-email-keyuan.liu@gmail.com>
	<CAGxe1ZHbBVPyA5rCLS2r02O+2hO7SFUmH69rZuykv7nhPuEbKA@mail.gmail.com>
	<CADz5_g+nT_erUMk9+9XBcOGHeneco5WOuSP5PBsp-NzqQXqxjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50307 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab2I0Mus (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 08:50:48 -0400
Received: by pbbrr4 with SMTP id rr4so3538631pbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Sep 2012 05:50:48 -0700 (PDT)
In-Reply-To: <CADz5_g+nT_erUMk9+9XBcOGHeneco5WOuSP5PBsp-NzqQXqxjQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

On 27 September 2012 00:04, Kevin Liu <keyuan.liu@gmail.com> wrote:
> 2012/9/26 Girish K S <girish.shivananjappa@linaro.org>:
>> On 26 September 2012 20:38, Kevin Liu <keyuan.liu@gmail.com> wrote:
>>> From: Kevin Liu <kliu5@marvell.com>
>>>
>>> Host controller must enable 1.8v signal for UHS modes.
>>> Otherwise UHS modes won't take effect.
>>> But mmc core does NOT switch to 1.8v for DDR50 mode.
>>> So enable the 1.8v signal for mmc DDR50 mode in host
>>> driver.
>>>
>>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c |    9 ++++++++-
>>>  1 files changed, 8 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 50e7a54..e3de041 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1529,8 +1529,15 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>>>                                 ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
>>>                         else if (ios->timing == MMC_TIMING_UHS_SDR104)
>>>                                 ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>>> -                       else if (ios->timing == MMC_TIMING_UHS_DDR50)
>>> +                       else if (ios->timing == MMC_TIMING_UHS_DDR50) {
>>> +                               struct mmc_card *card;
>>> +
>>>                                 ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>>> +                               card = container_of(&(host->mmc),
>>> +                                       struct mmc_card, host);
>>> +                               if (mmc_card_mmc(card))
>>> +                                       ctrl_2 |= SDHCI_CTRL_VDD_180;
>>> +                       }
>> If you want to set the voltage to 1.8. It has to be done from the core
>> layer using the api mmc_set_signal_voltage during the mmc card init.
>> as it is done for 1.2 volts switch. In the comment (mmc_card_init
>> function) it is explicitly mentioned
>> * 1.8V vccq at 3.3V core voltage (vcc) is not required
>> * in the JEDEC spec for DDR.
>> can you please check it. Still if you feel its necessary to change the
>> voltage to 1.8 v, you can do it from mmc_init_card function
>
> In JEDEC spec, there are two emmc device types which support DDR50.
> One type can work under signal 1.2v while the other type work under
> signal 1.8v or 3v. So current code just keep 3v for the second device
> type.
>
> But in SD host spec, 1.8v signal must be enabled for all UHS modes
> taking effect.
> So the fact is, if we use SD host to work with emmc chip, we have to
> select 1.8v in order to enable DDR50. Current code missed this.
>
> Because DDR50 shall can work under both signal 1.8v and 3v according
> to JEDEC spec,  So I don't want to switch to 1.8v in mmc core code.
> It's the host controller requirement that 1.8v signal must be enabled
> in order to enable DDR50, which conflict with emmc spec. So I added
> this in host driver.
I understand. Thanks
>
> Thanks
> Kevin
