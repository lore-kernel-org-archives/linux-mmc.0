From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 04 Apr 2011 13:13:45 +0900
Message-ID: <4D994579.10301@samsung.com>
References: <4D993199.1060206@samsung.com>
 <20110404034753.GA1428@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53068 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab1DDEPL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 00:15:11 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJ400JWA1596O60@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 04 Apr 2011 13:15:09 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJ400MWR159K4@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 04 Apr 2011 13:15:09 +0900 (KST)
In-reply-to: <20110404034753.GA1428@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Wolfram Sang wrote:
> On Mon, Apr 04, 2011 at 11:48:57AM +0900, Jaehoon Chung wrote:
>> Sometimes we can't add the device,but we didn't check any error status.
>> Need to check error status for mmc_add_host.
> 
> Thanks, this is correct, but...
> 
>> -	mmc_add_host(mmc);
>> +	ret = mmc_add_host(mmc);
>> +	if (unlikely(ret))
>> +		goto err_free_mmc;
> 
> ... you are leaking the irq and the lcd_classdev here.

Thanks for your comment, i will resend the patch.

> 
> Regards,
> 
>    Wolfram
> 

