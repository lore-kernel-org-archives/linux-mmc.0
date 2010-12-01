From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC Patch] SDHCI: add quirk for data timeout value when card busy.
Date: Wed, 01 Dec 2010 14:44:58 +0900
Message-ID: <4CF5E0DA.3060300@samsung.com>
References: <4CF4961C.5020606@samsung.com>
 <20101130095618.GA6408@pengutronix.de> <4CF4CE48.7040102@samsung.com>
 <20101130105435.GB6408@pengutronix.de> <4CF4E1DF.5000000@samsung.com>
 <43E4817426ED174AA81263BCECB4351D13200C545E@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:27891 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab0LAFov (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Dec 2010 00:44:51 -0500
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LCQ006HQIMPL740@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Dec 2010 14:44:49 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LCQ002SNIMOFT@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Dec 2010 14:44:48 +0900 (KST)
In-reply-to: <43E4817426ED174AA81263BCECB4351D13200C545E@sc-vexch3.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>

Philip Rakity wrote:
> Can we just remove the quirk for broken timeout and just set the timeout to 0xe in sdhci.c?

you means that set the timeout to 0xe without broken timeout in sdhci.c?

> 
> The problem with the quirk is you need to know when to set it and the problem with the existing quirk is that one has to set it to work with bad cards.

I know when use quirk...and what use one...

> ________________________________________
> From: linux-mmc-owner@vger.kernel.org [linux-mmc-owner@vger.kernel.org] On Behalf Of Jaehoon Chung [jh80.chung@samsung.com]
> Sent: Tuesday, November 30, 2010 3:37 AM
> To: Wolfram Sang
> Cc: linux-mmc@vger.kernel.org; Chris Ball; kyungmin Park; Andrew Morton; matt@console-pimps.org
> Subject: Re: [RFC Patch] SDHCI: add quirk for data timeout value when card busy.
> 
>>> Maybe, happen for all sdhci-controllers...
>> My point is: If it is needed for all SDHCI-controllers, we don't need a
>> quirk and can apply your code unconditionally.
>>
> 
> You're right. But i'm not sure, happen for all sdhci-controller.
> so i send to RFC patch..
> I also hope apply my code unconditionally.
> 
> the reason using quirk...every card didn't happen this issue..
> if not happen this issue, we need not set timeout value..at that time..
> 
> when needs, entered and set timeout value..(conditionally)
> 
> 
>>> Card is configurable with eMMC spec..But sdhci-controller didn't
>>> support that card. So SDHCI controller need to use quriks..
>> Can we find out if this is a general issue?
>>
> 
> Hmm..i'm sure you can find out this issue..
> Have ever find out this issue(similar case)..anybody?
> 
>> Regards,
>>
>>    Wolfram
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

