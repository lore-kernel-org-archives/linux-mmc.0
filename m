From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: core: Add packed command for eMMC4.5 device
Date: Thu, 17 Nov 2011 18:20:51 +0900
Message-ID: <000001cca50a$33d6e880$9b84b980$%jun@samsung.com>
References: <1319712841-28579-1-git-send-email-tgih.jun@samsung.com>
 <4EC39B3E.1010300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18127 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab1KQJUz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2011 04:20:55 -0500
In-reply-to: <4EC39B3E.1010300@codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Sahitya Tummala' <stummala@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, dh.han@samsung.com

Sahitya Tummala wrote:
> Hi,
> 
> On 10/27/2011 4:24 PM, Seungwon Jeon wrote:
> >
> > +static int mmc_blk_packed_err_check(struct mmc_card *card,
> > +			     struct mmc_async_req *areq)
> > +{
> > +	struct mmc_queue_req *mq_mrq = container_of(areq, struct mmc_queue_req,
> > +						    mmc_active);
> > +	int err, check, status;
> > +	u8 ext_csd[512];
> > +
> > +	check = mmc_blk_err_check(card, areq);
> > +
> > +	if (check == MMC_BLK_SUCCESS)
> > +		return check;
> > +
> > +	if (check == MMC_BLK_PARTIAL) {
> > +		err = get_card_status(card,&status, 0);
> > +		if (err)
> > +			return MMC_BLK_ABORT;
> > +
> > +		if (status&  R1_EXP_EVENT) {
> > +			err = mmc_send_ext_csd(card, ext_csd);
> > +			if (err)
> > +				return MMC_BLK_ABORT;
> > +
> > +			if ((ext_csd[EXT_CSD_EXP_EVENTS_STATUS + 0]&
> > +						EXT_CSD_PACKED_FAILURE)&&
> > +					(ext_csd[EXT_CSD_PACKED_CMD_STATUS]&
> > +					 EXT_CSD_PACKED_GENERIC_ERROR)) {
> > +				if (ext_csd[EXT_CSD_PACKED_CMD_STATUS]&
> > +						EXT_CSD_PACKED_INDEXED_ERROR) {
> > +					/* Make be 0-based */
> > +					mq_mrq->packed_fail_idx =
> > +						ext_csd[EXT_CSD_PACKED_FAILURE_INDEX] - 1;
> > +					return MMC_BLK_PARTIAL;
> > +				} else {
> > +					return MMC_BLK_RETRY;
> > +				}
> > +			}
> > +		} else {
> > +			return MMC_BLK_RETRY;
> > +		}
> > +	}
> > +
> > +	if (check != MMC_BLK_ABORT)
> > +		return MMC_BLK_RETRY;
> > +	else
> > +		return MMC_BLK_ABORT;
> 
> The current code does not return other errors (MMC_BLK_CMD_ERR,
> MMC_BLK_ECC_ERR and MMC_BLK_DATA_ERR) returned by mmc_blk_err_check().
> Why not return check here?
Currently retry is taken in case of other errors.
But some case needs to be split.
> 
> > +}
> > +
> >   static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> >   			       struct mmc_card *card,
> >   			       int disable_multi,
> > @@ -1126,6 +1187,207 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> >   	mmc_queue_bounce_pre(mqrq);
> >   }
> >
> > +static u8 mmc_blk_chk_packable(struct mmc_queue *mq, struct request *req)
> > +{
> > +	struct request_queue *q = mq->queue;
> > +	struct mmc_card *card = mq->card;
> > +	struct request *cur = req, *next = NULL;
> > +	struct mmc_blk_data *md = mq->data;
> > +	bool en_rel_wr = card->ext_csd.rel_param&  EXT_CSD_WR_REL_PARAM_EN;
> > +	unsigned int req_sectors = 0, phys_segments = 0;
> > +	unsigned int max_blk_count, max_phys_segs;
> > +	u8 max_packed_rw = 0;
> > +	u8 reqs = 0;
> > +
> > +	if (!(md->flags&  MMC_BLK_CMD23)&&
> > +			!card->ext_csd.packed_event_en)
> > +		goto no_packed;
> > +
> > +	if (rq_data_dir(cur) == READ)
> > +		max_packed_rw = card->ext_csd.max_packed_reads;
> > +	else
> > +		max_packed_rw = card->ext_csd.max_packed_writes;
> > +
> > +	if (max_packed_rw == 0)
> > +		goto no_packed;
> > +
> > +	if (mmc_req_rel_wr(cur)&&
> > +			(md->flags&  MMC_BLK_REL_WR)&&
> > +			!en_rel_wr) {
> > +		goto no_packed;
> > +	}
> > +
> > +	max_blk_count = min(card->host->max_blk_count,
> > +			card->host->max_req_size>>  9);
> > +	max_phys_segs = queue_max_segments(q);
> > +	req_sectors += blk_rq_sectors(cur);
> > +	phys_segments += req->nr_phys_segments;
> > +
> > +	if (rq_data_dir(cur) == WRITE) {
> > +		req_sectors++;
> > +		phys_segments++;
> > +	}
> > +
> > +	while (reqs<  max_packed_rw - 1) {
> 
> What if the number of requests exceeds the packed header size defined?
Currently not considered.
That case is maximum r/w depth from eMMC device is wrong, right?
It may not happen in practice. But the limit may need to restricted.
> 
> > +		next = blk_fetch_request(q);
> > +		if (!next)
> > +			break;
> > +
> > +		if (rq_data_dir(cur) != rq_data_dir(next)) {
> > +			blk_requeue_request(q, next);
> > +			break;
> > +		}
> > +
> > +		if (mmc_req_rel_wr(next)&&
> > +				(md->flags&  MMC_BLK_REL_WR)&&
> > +				!en_rel_wr) {
> > +			blk_requeue_request(q, next);
> > +			break;
> > +		}
> > +
> > +		req_sectors += blk_rq_sectors(next);
> > +		if (req_sectors>  max_blk_count) {
> > +			blk_requeue_request(q, next);
> > +			break;
> > +		}
> > +
> > +		phys_segments +=  next->nr_phys_segments;
> > +		if (phys_segments>  max_phys_segs) {
> > +			blk_requeue_request(q, next);
> > +			break;
> > +		}
> > +
> > +		list_add_tail(&next->queuelist,&mq->mqrq_cur->packed_list);
> > +		cur = next;
> > +		reqs++;
> > +	}
> > +
> > +	if (reqs>  0) {
> > +		list_add(&req->queuelist,&mq->mqrq_cur->packed_list);
> > +		return (reqs + 1);
> > +	}
> > +
> > +no_packed:
> > +	mq->mqrq_cur->packed_cmd = MMC_PACKED_NONE;
> > +	return reqs;
> > +}
> > +
> >
> >   static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
> >   			   struct mmc_blk_request *brq, struct request *req,
> >   			   int ret)
> > @@ -1163,15 +1425,33 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
> >   	int ret = 1, disable_multi = 0, retry = 0, type;
> >   	enum mmc_blk_status status;
> >   	struct mmc_queue_req *mq_rq;
> > -	struct request *req;
> > +	struct request *req, *prq;
> >   	struct mmc_async_req *areq;
> > +	u8 reqs = 0;
> >
> >   	if (!rqc&&  !mq->mqrq_prev->req)
> >   		return 0;
> >
> > +	if (rqc)
> > +		reqs = mmc_blk_chk_packable(mq, rqc);
> > +
> >   	do {
> >   		if (rqc) {
> > -			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> > +			if (reqs>= 2) {
> > +				mmc_blk_packed_hdr_wrq_prep(mq->mqrq_cur, card, mq, reqs);
> > +				if (rq_data_dir(rqc) == READ) {
> > +					areq =&mq->mqrq_cur->mmc_active;
> > +					mmc_wait_for_req(card->host, areq->mrq);
> > +					status = mmc_blk_packed_err_check(card, areq);
> > +					if (status == MMC_BLK_SUCCESS) {
> > +						mmc_blk_packed_rrq_prep(mq->mqrq_cur, card, mq);
> > +					} else {
> > +						goto check_status;
> > +					}
> > +				}
> > +			} else {
> > +				mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> 
> We must use disable_multi variable instead of directly calling this
> function with 0 value because there are some cases where disable_multi
> is set to 1 (for example, it is set for error case MMC_BLK_ECC_ERR).
This part is origin code for non-packed case. 
It just is moved to else statement.
if (rqc) {
-	mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);

> 
> > +			}
> >   			areq =&mq->mqrq_cur->mmc_active;
> >   		} else
> >   			areq = NULL;
> > @@ -1179,6 +1459,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
> >   		if (!areq)
> >   			return 0;
> >
> > +check_status:
> >   		mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
> >   		brq =&mq_rq->brq;
> >   		req = mq_rq->req;
> > @@ -1192,10 +1473,32 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
> >   			 * A block was successfully transferred.
> >   			 */
> >   			mmc_blk_reset_success(md, type);
> > -			spin_lock_irq(&md->lock);
> > -			ret = __blk_end_request(req, 0,
> > +
> > +			if (mq_rq->packed_cmd != MMC_PACKED_NONE) {
> > +				int idx = mq_rq->packed_fail_idx, i = 0;
> > +				while (!list_empty(&mq_rq->packed_list)) {
> > +					prq = list_entry_rq(mq_rq->packed_list.next);
> > +					if (idx == i) {
> > +						/* retry from error index */
> > +						reqs -= idx;
> > +						mq_rq->req = prq;
> > +						ret = 1;
> > +						break;
> > +					}
> > +					list_del_init(&prq->queuelist);
> > +					spin_lock_irq(&md->lock);
> > +					ret = __blk_end_request(prq, 0, blk_rq_bytes(prq));
> > +					spin_unlock_irq(&md->lock);
> > +					i++;
> > +				}
> > +				break;
> > +			} else {
> > +				spin_lock_irq(&md->lock);
> > +				ret = __blk_end_request(req, 0,
> >   						brq->data.bytes_xfered);
> > -			spin_unlock_irq(&md->lock);
> > +				spin_unlock_irq(&md->lock);
> > +			}
> > +
> >   			/*
> >   			 * If the blk_end_request function returns non-zero even
> >   			 * though all data has been transferred and no errors
> > @@ -1254,7 +1557,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
> >   			break;
> >   		}
> >
> > -		if (ret) {
> > +		if (ret&&  (mq_rq->packed_cmd == MMC_PACKED_NONE)) {
> >   			/*
> >   			 * In case of a incomplete request
> >   			 * prepare it again and resend.
> > @@ -1267,13 +1570,37 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
> >   	return 1;
> >
> >    cmd_abort:
> > -	spin_lock_irq(&md->lock);
> > -	while (ret)
> > -		ret = __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
> > -	spin_unlock_irq(&md->lock);
> > +	if (mq_rq->packed_cmd != MMC_PACKED_NONE) {
> > +		spin_lock_irq(&md->lock);
> > +		while (ret)
> > +			ret = __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
> > +		spin_unlock_irq(&md->lock);
> > +	} else {
> > +		while (!list_empty(&mq_rq->packed_list)) {
> > +			prq = list_entry_rq(mq_rq->packed_list.next);
> > +			list_del_init(&prq->queuelist);
> > +			spin_lock_irq(&md->lock);
> > +			__blk_end_request(prq, -EIO, blk_rq_bytes(prq));
> > +			spin_unlock_irq(&md->lock);
> > +		}
> > +	}
> >
> >    start_new_req:
> >   	if (rqc) {
> > +		/*
> > +		 * If current request is packed, it need to put back.
> > +		 */
> > +		if (mq->mqrq_cur->packed_cmd != MMC_PACKED_NONE) {
> > +			while (!list_empty(&mq->mqrq_cur->packed_list)) {
> > +				prq = list_entry_rq(mq->mqrq_cur->packed_list.prev);
> > +				if (prq->queuelist.prev !=&mq->mqrq_cur->packed_list) {
> > +					list_del_init(&prq->queuelist);
> > +					blk_requeue_request(mq->queue, prq);
> > +				} else {
> > +					list_del_init(&prq->queuelist);
> > +				}
> > +			}
> > +		}
> >   		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> 
> We must use disable_multi variable instead of directly calling this
> function with 0 value because there are some cases where disable_multi
> is set to 1.
This part is also origin code for non-packed case.
> 
> >   		mmc_start_req(card->host,&mq->mqrq_cur->mmc_active, NULL);
> 
> I think these two statements must come under else part of above if
> condition. Please check.
This two statements are applicable regardless of packed command.

Best regards,
Seungwon Jeon.
> 
> Thanks,
> Sahitya.
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.


