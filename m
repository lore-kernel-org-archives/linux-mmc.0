From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: core: Add packed command for eMMC4.5 device
Date: Thu, 17 Nov 2011 11:23:16 +0900
Message-ID: <004b01cca4cf$dd318f60$9794ae20$%jun@samsung.com>
References: <e56e6a44db4d8a0103825c1cc909f125.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <e56e6a44db4d8a0103825c1cc909f125.squirrel@www.codeaurora.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: merez@codeaurora.org
Cc: svenkatr@ti.com, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Maya Erez wrote:
> 
> > +			if (reqs >= 2) {
> > +				mmc_blk_packed_hdr_wrq_prep(mq->mqrq_cur, card, mq, reqs);
> > +				if (rq_data_dir(rqc) == READ) {
> > +					areq = &mq->mqrq_cur->mmc_active;
> > +					mmc_wait_for_req(card->host, areq->mrq);
> Packing read requests requires preparation of two requests. After sending
> the header we wait for its completion before sending the next request
> (mmc_wait_for_req is used). Therefore, if we try to pack 2 read requests
> we might end up with worse performance in comparison to sending each
> request by itself (which allows the preparation of one request while the
> other is sent).
> I suggest to check the size of the packed commands list and in case it is
> less than 3 send the requests one by one. If you move mmc_blk_chk_packable
> to queue.c after the first fetch this change should be very easy and can
> be done by removing the requests from the packed_list and calling issue_fn
> for each one of them.

Sending header for packed read which doesn't require nand program
unlike normal data, so it may not spend long time.
Which point you think is the overhead of packed two-requests
in comparison to individual request?
> 
> Thanks,
> Maya Erez
> Consultant for Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
