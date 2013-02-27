From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [Question] What does SDHCI_QUIRK_BROKEN_CARD_DETECTION stands for?
Date: Wed, 27 Feb 2013 22:58:54 +0800
Message-ID: <CADz5_g+mVSChCojV2tfaXBX2GNnqjkRSSn2+CkvGk8shCP3+dA@mail.gmail.com>
References: <CADz5_gKreSB9BvTgBBcjjOOEDMRc2q1s-9VNHfb_+x+9gdADLw@mail.gmail.com>
	<87r4k17toq.fsf@octavius.laptop.org>
	<CADz5_gKvGqSFsTiMVMG2jcsXmfESydGfTSzN=sG-WAGkpP6DYw@mail.gmail.com>
	<87ip5d7rjj.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61379 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592Ab3B0O6z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Feb 2013 09:58:55 -0500
Received: by mail-oa0-f46.google.com with SMTP id k1so1298448oag.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Feb 2013 06:58:54 -0800 (PST)
In-Reply-To: <87ip5d7rjj.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

2013/2/27 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Wed, Feb 27 2013, Kevin Liu wrote:
>> Thanks for quick answer!
>> Then if broken-cd/SDHCI_QUIRK_BROKEN_CARD_DETECTION is selected, can I
>> use host controller Present State Register[18] (offset 0x24) to know
>> card status (present or not)?
>
> sdhci.c:
>
>         present = mmc_gpio_get_cd(host->mmc);
>         if (present < 0) {
>                 /* If polling, assume that the card is always present. */
>                 if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>                         present = 1;
>                 else
>                         present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
>                                         SDHCI_CARD_PRESENT;
>         }
>

I just want to confirm this code:)
Then when SDHCI_QUIRK_BROKEN_CARD_DETECTION is selected, read register
SDHCI_PRESENT_STATE is _not_ reliable.
I'm clear now.

Thanks
Kevin
