From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] mmc: omap_hsmmc: Add small delay after enabling power
Date: Fri, 12 Sep 2014 09:26:54 +0200
Message-ID: <5412A03E.8060307@denx.de>
References: <1410444665-24492-1-git-send-email-sr@denx.de> <CAPDyKFp9JKb=XOo5m7YQEQFbF4Rtn_DKP2ia3jCBMhRa6aJVZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.180]:56392 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbaILH0T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Sep 2014 03:26:19 -0400
In-Reply-To: <CAPDyKFp9JKb=XOo5m7YQEQFbF4Rtn_DKP2ia3jCBMhRa6aJVZQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Thorsten Einsbein <thorsten.eisbein@head-acoustics.de>, Balaji T K <balajitk@ti.com>

On 11.09.2014 16:15, Ulf Hansson wrote:
> On 11 September 2014 16:11, Stefan Roese <sr@denx.de> wrote:
>> From: Thorsten Einsbein <thorsten.eisbein@head-acoustics.de>
>>
>> On the TAO3530 (OMAP3530 based) we noticed that some SD cards are not
>> detected reliably upon bootup (timeout). Especially the SanDisk Ultra
>> 8GiB seems to be problematic here. The SanDisk Extreme also has this
>> problem on this platform, but not that often. A Samsung 8 GiB type 6
>> doesn't show this problem at all.
>>
>> This patch now adds a short delay after enabling the power on the slot.
>> With this delay all cards are detected reliably.
>
> Is this delay related to regulator ramp up/down time? Then I think it
> maybe should be a part of the regulator code/DT.

Thanks for this feedback. Yes, adding "regulator-enable-ramp-delay" to 
the regulator(s) solves this issue too. I wasn't aware of that one.

The patch can be dropped.

Thanks,
Stefan

