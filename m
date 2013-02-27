From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [Question] What does SDHCI_QUIRK_BROKEN_CARD_DETECTION stands for?
Date: Wed, 27 Feb 2013 22:33:15 +0800
Message-ID: <CADz5_gKvGqSFsTiMVMG2jcsXmfESydGfTSzN=sG-WAGkpP6DYw@mail.gmail.com>
References: <CADz5_gKreSB9BvTgBBcjjOOEDMRc2q1s-9VNHfb_+x+9gdADLw@mail.gmail.com>
	<87r4k17toq.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:35161 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760154Ab3B0OdQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Feb 2013 09:33:16 -0500
Received: by mail-oa0-f49.google.com with SMTP id j6so1220548oag.22
        for <linux-mmc@vger.kernel.org>; Wed, 27 Feb 2013 06:33:15 -0800 (PST)
In-Reply-To: <87r4k17toq.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

2013/2/27 Chris Ball <cjb@laptop.org>:
> Hi,
>
> The CC: list seems excessively long here.
>
> On Wed, Feb 27 2013, Kevin Liu wrote:
>> Who can help to answer below question?
>> Which statement is true if quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION is selected?
>> 1. The host controller Present State Register[18] (offset 0x24) can
>> reflect card status (present or not) but can't trigger interrupt when
>> card insert/remove.
>> 2. The host controller Present State Register[18] can't reflect card
>> status at all and can't trigger card insert/remove interrupt either.
>> But have other way out of host controller to detect card like slot
>> gpio.
>> 3. The host controller Present State Register[18] can't reflect card
>> status at all, can't trigger card insert/remove interrupt, and don't
>> have the other ways to detect card like slot gpio. So have to use
>> polling to know card present status.
>
> (3)
>
> The best documentation for this is probably the DT bindings file:
>
> Card detection:
> If no property below is supplied, host native card detect is used.
> Only one of the properties in this section should be supplied:
>   - broken-cd: There is no card detection available; polling must be used.
>   - cd-gpios: Specify GPIOs for card detection, see gpio binding
>   - non-removable: non-removable slot (like eMMC); assume always present.
>
> (SDHCI_QUIRK_BROKEN_CARD_DETECTION maps to broken-cd)
>
Chris,

Thanks for quick answer!
Then if broken-cd/SDHCI_QUIRK_BROKEN_CARD_DETECTION is selected, can I
use host controller Present State Register[18] (offset 0x24) to know
card status (present or not)?

Kevin

> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
