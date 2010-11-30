From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC Patch] SDHCI: add quirk for data timeout value when card busy.
Date: Tue, 30 Nov 2010 19:13:28 +0900
Message-ID: <4CF4CE48.7040102@samsung.com>
References: <4CF4961C.5020606@samsung.com>
 <20101130095618.GA6408@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34138 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233Ab0K3KNb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 05:13:31 -0500
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LCP00KYW0EHRUE0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Nov 2010 19:13:29 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LCP00A8P0EHTR@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Nov 2010 19:13:29 +0900 (KST)
In-reply-to: <20101130095618.GA6408@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, matt@console-pimps.org

Hi Wolfram.

Maybe, happen for all sdhci-controllers...

Card is configurable with eMMC spec..But sdhci-controller didn't support that card.
So SDHCI controller need to use quriks..

Thanks,
Jaehoon Chung

Wolfram Sang wrote:
> Hi,
> 
> On Tue, Nov 30, 2010 at 03:13:48PM +0900, Jaehoon Chung wrote:
>> This patch is added quirks for data timeout value.
>>
>> Some card have problem when suspend/resume.
>> CMD6(switch command) to switch the bus to high speed mode 
>> and to set the bus width.
>>
>> After resuming, the card was initialized...in that time, some
>> card need set a correct timeout value.
>> so we add SDHCI_QUIRK_SET_DATA_TIMEOUT_VAL.
> 
> If this is a flaw of the _card_, why do we need a controller quirk here?
> Shouldn't this happen for all sdhci-controllers?
> 
> Kind regards,
> 
>    Wolfram
> 

