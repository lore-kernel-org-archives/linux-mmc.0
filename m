From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 11 Apr 2011 13:16:24 +0900
Message-ID: <4DA28098.9020202@samsung.com>
References: <4DA2633C.5000103@samsung.com>
 <20110411030453.GA20437@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:55448 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab1DKESL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 00:18:11 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJG00C9KZY8I100@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 11 Apr 2011 13:18:08 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJG00G2AZY81V@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 11 Apr 2011 13:18:09 +0900 (KST)
In-reply-to: <20110411030453.GA20437@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Wolfram Sang wrote:
> On Mon, Apr 11, 2011 at 11:11:08AM +0900, Jaehoon Chung wrote:
>> Sometimes we can't add the device,but we didn't check any error status.
>> Need to check error status for mmc_add_host.
>> And Missing regulator disable/put. Fixed them.
> 
> Is there any special reason you don't want to answer the open question from the
> last two reviews?

Sorry..i didn't find your questions. So i didn't answer anything.
You asked "why removed host?" right?

I just think good that remove the host...(any crash didn't occur).
there is not special reason.

> 
>> [PATCH v4] : merged for v3 [PATCH 1/2] and [PATCH 2/2] reviewed on Wolfram Sang
> 
> This should go below the dashed line (---)
> 
>    Wolfram
> 

