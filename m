From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dw_mmc: add support for pre_req and post_req
Date: Mon, 18 Apr 2011 14:10:55 +0900
Message-ID: <4DABC7DF.6020809@samsung.com>
References: <4D9D7024.2030404@samsung.com>
 <20110416161634.GB17935@S2100-06.ap.freescale.net>
 <4DABC42F.30405@samsung.com> <20110418051022.GC18623@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:32583 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab1DRFNA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2011 01:13:00 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJU00MO815MAN40@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Apr 2011 14:12:58 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJU004RX15MV0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Apr 2011 14:12:58 +0900 (KST)
In-reply-to: <20110418051022.GC18623@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

Hi Shawn,

Shawn Guo wrote:
> 
> 	if (slot->host->use_dma) {
> 		if (dw_mci_pre_dma_transfer(slot->host, mrq->data,
> 					&slot->host->next_data) < 0)
> 			mrq->data->host_cookie = 0;
> 

Ok..I understood yours..:) i'll check and test..
Thanks for your comment.

Regards,
Jaehoon Chung

