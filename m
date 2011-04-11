From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 11 Apr 2011 13:55:46 +0900
Message-ID: <4DA289D2.7010501@samsung.com>
References: <4DA2633C.5000103@samsung.com>
 <20110411030453.GA20437@pengutronix.de> <4DA28098.9020202@samsung.com>
 <20110411044022.GD20437@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:32956 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab1DKE5e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 00:57:34 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJH00IYW1RUVME0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 11 Apr 2011 13:57:30 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJH00AGD1RU1K@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 11 Apr 2011 13:57:30 +0900 (KST)
In-reply-to: <20110411044022.GD20437@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Wolfram Sang wrote:
>> I just think good that remove the host...(any crash didn't occur).
>> there is not special reason.
> 
> Look at the mmc-core code, please (host.c). Compare what remove_host does and
> what add_host does before it fails. What do you think?

Ok..i'm looking at the mmc-core code(host.c)
mmc_add_host does devices_add(), then run start_host().
mmc_remove_host does stop_host().

You means that didn't run start_host() before add_host failed.
I think that need not to run stop_host. right?

To use mmc_free_host, better than mmc_remove_host.

Regards,
Jaehoon Chung

> 
> Regards,
> 
>    Wolfram
> 

