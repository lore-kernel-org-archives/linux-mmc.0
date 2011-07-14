From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: mmcoops + mmcblk
Date: Thu, 14 Jul 2011 13:28:12 +0900
Message-ID: <4E1E705C.6010403@samsung.com>
References: <20110712063225.GA12742@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18790 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1GNE1r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2011 00:27:47 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LOB00FVC308T270@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 14 Jul 2011 13:27:46 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LOB0043132AWP@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 14 Jul 2011 13:27:46 +0900 (KST)
In-reply-to: <20110712063225.GA12742@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>, 'Andrew Morton' <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>

Hi Simon..

I'm sorry. i didn't understand this mail.
Do you want to implement something with mmcblk and mmc_oops?

Can you explain to me for more information?

Best Regards,
Jaehoon Chung

Simon Horman wrote:
> Hi,
> 
> I am looking over the "[RFC] mmcoops with panic/oops" and is strikes
> me that although platform data is used to limit the area of the MMC
> device to which the oops is witten, the entire device has to belong
> (be bound to) the mmc_oops driver and as such no part of the device
> can be used for anything else.
> 
> I am wondering if I am missing something?
> 
> In particular, I would like to allow a single MMC chip to be
> used both by mmcblk (as a filesystem) and as mmc_oops (a small
> area reserved for writing oops messages).
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

