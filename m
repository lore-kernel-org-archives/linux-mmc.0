From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v8 2/2] mmc: support packed write command for eMMC4.5 device
Date: Mon, 09 Jul 2012 08:52:49 +0900
Message-ID: <009701cd5d64$c7dc2aa0$57947fe0$%jun@samsung.com>
References: <ed6366950474fb35cac89881648fb9e9.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:65391 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab2GHXwv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jul 2012 19:52:51 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M6V00GTS8ZDTDD0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Jul 2012 08:52:49 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M6V00IMI9018O00@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Jul 2012 08:52:49 +0900 (KST)
In-reply-to: <ed6366950474fb35cac89881648fb9e9.squirrel@www.codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>

Sunday, July 08, 2012, Maya <merez@codeaurora.org> wrote:
> One minor comment below:
> 
> > @@ -1278,9 +1609,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
> *mq, struct request *rqc)
> >  			    (card->ext_csd.data_sector_size == 4096)) {
> You can use mmc_large_sec here (instead of card->ext_csd.data_sector_size
> == 4096)
Yes, but this line is kept due to another issue related with 4KB sector. 

Thanks,
Seungwon Jeon

> 
> Thanks,
> Maya
> 
> --
> Sent by consultant of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

