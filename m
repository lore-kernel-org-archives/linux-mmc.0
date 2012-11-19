From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v6 11/14] mmc: sdhci: fix the bug that DDR50 can't work
 for emmc
Date: Mon, 19 Nov 2012 16:57:11 +0800
Message-ID: <CADz5_g+ncZdBLQwSh2Vkia+OD7VtXuLtKFsp-z2bM8JJu10Sog@mail.gmail.com>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-12-git-send-email-keyuan.liu@gmail.com>
	<87zk2f7t8h.fsf@octavius.laptop.org>
	<CADz5_gJq9vA1mhabMtupBaBqfNcwGV6TnkaOZwoLocwNgmLPFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63932 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab2KSI5N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 03:57:13 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so2691066wgb.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Nov 2012 00:57:12 -0800 (PST)
In-Reply-To: <CADz5_gJq9vA1mhabMtupBaBqfNcwGV6TnkaOZwoLocwNgmLPFw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, Haojian Zhuang <haojian.zhuang@gmail.com>, cxie4@marvell.com, Philip Rakity <prakity@nvidia.com>, kliu5@marvell.com

2012/11/19 Kevin Liu <keyuan.liu@gmail.com>:
> 2012/11/18 Chris Ball <cjb@laptop.org>:
>> Hi,
>>
>> On Wed, Oct 17 2012, Kevin Liu wrote:
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index c3e786d..522e501 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1529,8 +1529,15 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>>>                               ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
>>>                       else if (ios->timing == MMC_TIMING_UHS_SDR104)
>>>                               ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>>> -                     else if (ios->timing == MMC_TIMING_UHS_DDR50)
>>> +                     else if (ios->timing == MMC_TIMING_UHS_DDR50) {
>>> +                             struct mmc_card *card;
>>> +
>>>                               ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>>> +                             card = container_of(&(host->mmc),
>>> +                                     struct mmc_card, host);
>>> +                             if (mmc_card_mmc(card))
>>> +                                     ctrl_2 |= SDHCI_CTRL_VDD_180;
>>> +                     }
>>>                       sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>>               }
>>>               if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
>>
>> I'm using DDR50 on an eMMC that's only powered by 3.3V (no 1.8V
>> available) with sdhci-pxav3, so it sounds like I don't want to merge
>> this patch?
>>
> This patch is NEEDED for both 3.3v and 1.8v signaling.
> In the SD host spec for host control 2 register, 1.8v signaling enable
> bit must be set in order for UHS-I mode taking effect. Otherwise, the
> DDR50 mode won't take effect on host even it is selected.
> It's the SD host requirement.

In fact, I don't think 3.3v vccq for emmc can work under DDR50 mode
with SD host.
You must enable 1.8v signaling on host for UHS-I modes, but you set
3.3v for emmc vccq. It's conflictable.
The only way for emmc DDR50 to work is to set 1.8v for vccq although
JEDEC spec said both 1.8v and 3.3v are ok.

Thanks
Kevin
