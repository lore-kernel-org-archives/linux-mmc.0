From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v4 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Thu, 16 Feb 2012 09:09:45 +0900
Message-ID: <004301ccec3f$4a4e9320$deebb960$%jun@samsung.com>
References: <000b01ccdc0a$0336abc0$09a40340$%jun@samsung.com>
 <fd4b8ef9df0d19e20c07923077937231.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:40664 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab2BPAJr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 19:09:47 -0500
In-reply-to: <fd4b8ef9df0d19e20c07923077937231.squirrel@www.codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org

Maya Erez <merez@codeaurora.org> wrote:
> > @@ -1065,12 +1075,60 @@ static int mmc_blk_err_check(struct mmc_card
> > *card,
> >  	if (!brq->data.bytes_xfered)
> >  		return MMC_BLK_RETRY;
> >
> > +	if (mq_mrq->packed_cmd != MMC_PACKED_NONE) {
> > +		if (unlikely(brq->data.blocks << 9 != brq->data.bytes_xfered))
> > +			return MMC_BLK_PARTIAL;
> > +		else
> > +			return MMC_BLK_SUCCESS;
> > +	}
> > +
> >  	if (blk_rq_bytes(req) != brq->data.bytes_xfered)
> >  		return MMC_BLK_PARTIAL;
> >
> >  	return MMC_BLK_SUCCESS;
> >  }
> I think it would be best to keep the request length (brq->data.blocks << 9
> or blk_rq_bytes(req)) in a variable and use it in the original if above.
> This way you can avoid doubling the exit points from the function.
In case of packed command, brq->data.blocks contains the sum of blocks for individual request.
That means blk_rq_bytes(req) doesn't represent all packed length bytes.
And "brq->data.blocks << 9" is not idential to blk_rq_bytes(req) in non-packed command.
"brq->data.blocks" is overwritten during request preparation by the following reasons.
- brq->data.blocks > card->host->max_blk_count
- disable_multi
- do_rel_wr
So "brq->data.blocks << 9" is not good choice for request length  in non-packed command.

Thanks,
Seungwon Jeon

> Thanks,
> Maya Erez
> Consultant for Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

