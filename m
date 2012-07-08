From: merez@codeaurora.org
Subject: Re: [PATCH v8 2/2] mmc: support packed write command for eMMC4.5   
        device
Date: Sun, 8 Jul 2012 05:12:17 -0700 (PDT)
Message-ID: <ed6366950474fb35cac89881648fb9e9.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:14310 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2GHMMS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jul 2012 08:12:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>

One minor comment below:

> @@ -1278,9 +1609,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
*mq, struct request *rqc)
>  			    (card->ext_csd.data_sector_size == 4096)) {
You can use mmc_large_sec here (instead of card->ext_csd.data_sector_size
== 4096)

Thanks,
Maya

-- 
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum




