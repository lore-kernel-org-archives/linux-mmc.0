From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Subject: Re: [PATCH] mmc: core: Set correct bus mode before card init
Date: Fri, 16 Sep 2011 08:57:07 +0200
Message-ID: <4E72F343.3040201@stericsson.com>
References: <1316101838-22660-1-git-send-email-ulf.hansson@stericsson.com> <20110916020522.GA3691@lovegaga>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:44440 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750828Ab1IPG5e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2011 02:57:34 -0400
In-Reply-To: <20110916020522.GA3691@lovegaga>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Aaron,

On 09/16/2011 04:05 AM, Aaron Lu wrote:
> Hi Ulf,
>
> I'm not familiar with mmc, but I've some questions on sd below.
>
> On Thu, Sep 15, 2011 at 05:50:38PM +0200, Ulf Hansson wrote:
>> Earlier all cards where initiated with bus mode set as OPENDRAIN, and then
>> later switched to PUSHPULL. According to the MMC/SD/SDIO specifications only
>> MMC cards use OPENDRAIN during init. For both SD and SDIO the bus mode shall
>> be PUSHPULL before attempting to init the card.
> AFAIK, there is no open drain mode in sd, and the sd host controller
> actually does not care about this setting(sdhci_set_ios does not
> manipulate bus_mode stored in ios).

We are currently using a ARM PL18X derivative with added SDIO support 
meaning we have one host controller for both MMC, SD and SDIO. This 
means that we have to take action on the open drain bit in our host 
driver (mmci.c) and set it as indicated by the framework. During card 
detection (and likewise during reinitialization after being powered off 
due to power save features), the former implementation actually sets 
open drain as default, meaning that open drain is set during early card 
detection of both MMC, SD and SDIO cards/devices, and then later 
switched to push pull which we believe is not correct for SD and SDIO.

>> The consequence of having incorrect bus mode can lead to not being able
>> to detect the card. Therefore the default behavior have now been changed to
>> PUSHPULL in mmc_power_up, and will only be temporarily switched when trying
>> to attach or init a MMC card.
> Do you see any sd cards that failed to be detected due to the incorrect
> bus_mode setting?

We have not seen any SD card fail due to this, but the SDIO device we 
have connected (WLAN) does fail to be detected if bus mode is 
incorrectly set to open drain during card detect (mmc_rescan).

>
> Anyway, your patch removed an unnecessary call to mmc_set_bus_mode which
> should have no effect if the underlying controller is sdhci.

Great, thanks for your feeback! :o)

Best Regards

Stefan Nilsson
