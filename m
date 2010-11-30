From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC Patch] SDHCI: add quirk for data timeout value when card busy.
Date: Tue, 30 Nov 2010 20:37:03 +0900
Message-ID: <4CF4E1DF.5000000@samsung.com>
References: <4CF4961C.5020606@samsung.com>
 <20101130095618.GA6408@pengutronix.de> <4CF4CE48.7040102@samsung.com>
 <20101130105435.GB6408@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50667 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679Ab0K3LhW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 06:37:22 -0500
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LCP00KQJ49PPNC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Nov 2010 20:37:06 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LCP008U249PD5@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Nov 2010 20:37:01 +0900 (KST)
In-reply-to: <20101130105435.GB6408@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, matt@console-pimps.org

>> Maybe, happen for all sdhci-controllers...
> 
> My point is: If it is needed for all SDHCI-controllers, we don't need a
> quirk and can apply your code unconditionally.
> 

You're right. But i'm not sure, happen for all sdhci-controller. 
so i send to RFC patch..
I also hope apply my code unconditionally.

the reason using quirk...every card didn't happen this issue..
if not happen this issue, we need not set timeout value..at that time..

when needs, entered and set timeout value..(conditionally)


>> Card is configurable with eMMC spec..But sdhci-controller didn't
>> support that card. So SDHCI controller need to use quriks..
> 
> Can we find out if this is a general issue?
> 

Hmm..i'm sure you can find out this issue..
Have ever find out this issue(similar case)..anybody?

> Regards,
> 
>    Wolfram
> 

