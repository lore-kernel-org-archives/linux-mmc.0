From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v6 2/3] mmc: core: Support packed write command for eMMC4.5
 device
Date: Fri, 01 Jun 2012 14:51:23 +0900
Message-ID: <000201cd3fba$942df840$bc89e8c0$%jun@samsung.com>
References: <7155413ec18f57c1151a29992be32b1f.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:25361 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab2FAFwA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jun 2012 01:52:00 -0400
In-reply-to: <7155413ec18f57c1151a29992be32b1f.squirrel@www.codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org

Maya Erez <merez@codeaurora.org> wrote:
> > @@ -1313,10 +1609,17 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
> *mq, struct request *rqc)
> >  			 * A block was successfully transferred.
> >  			 */
> >  			mmc_blk_reset_success(md, type);
> > -			spin_lock_irq(&md->lock);
> > -			ret = __blk_end_request(req, 0,
> > +
> > +			if (mq_rq->packed_cmd != MMC_PACKED_NONE) {
> > +				ret = mmc_blk_end_packed_req(mq, mq_rq);
> If a specific request in the packed request consistantly fails, there is
> nothing to stop us from sending the same packed request in an endless
> loop.
There is various error case. This patch reused the existing error handling.
What is that case we need to consider?

Best regards,
Seungwon Jeon

> > +				break;
> 
> Thanks,
> Maya Erez
> Consultant for Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

