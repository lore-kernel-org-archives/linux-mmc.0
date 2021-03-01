Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BBDC433DB
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 23:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D4C601FE
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 23:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhCAX1p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Mar 2021 18:27:45 -0500
Received: from smtp1.axis.com ([195.60.68.17]:45208 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240247AbhCAWcT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 1 Mar 2021 17:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1614637937;
  x=1646173937;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=gx141MXHrqlrpx6Y6kWEeEhS4c/SaCjVD3BTygN2Cqg=;
  b=JES4lhowFPXgNt7p2CJSynPmAOJb/eCbiy22Qrf8LQiV9ApWe8RnaJ/E
   23s47FHtY+fZa3EUVu7B0VPVfoUc2Kb4nUE0bEZMNN1D+2w3NCz9NO6P8
   hBGs0eeJ52PSqDOcu+/Gjg+YmVoRlYTHioN04G6p5I4cXGO1oVCxRkxge
   5n6GcxOfmb/TONp+umN3T3ymQFu/WHjFDCRN9rVOqIqUS8Lds4q9dDgXD
   yaZl9MTlrok07AZvWyW+jl+wCfkcAMHj8cU29ZPYG8IPFckWgpbaEzN4k
   TzYXBL68nggT6zX2q3GM4RKtVzbq5H5wz0vrP758eGa4k2ilh+22HA3DH
   g==;
Date:   Mon, 1 Mar 2021 23:30:08 +0100
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: Try power cycling card if command request times out
Message-ID: <20210301223008.glrdupzdgfnb2fwg@axis.com>
References: <20210216224252.22187-1-marten.lindahl@axis.com>
 <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com>
 <8a6bf147-d449-d32e-1969-ef9463859b9b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a6bf147-d449-d32e-1969-ef9463859b9b@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian!

Thank you for your comments!

On Mon, Mar 01, 2021 at 11:40:03AM +0100, Adrian Hunter wrote:
> On 1/03/21 10:50 am, Ulf Hansson wrote:
> > + Adrian
> > 
> > On Tue, 16 Feb 2021 at 23:43, Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >>
> >> Sometimes SD cards that has been run for a long time enters a state
> >> where it cannot by itself be recovered, but needs a power cycle to be
> >> operational again. Card status analysis has indicated that the card can
> >> end up in a state where all external commands are ignored by the card
> >> since it is halted by data timeouts.
> >>
> >> If the card has been heavily used for a long time it can be weared out,
> >> and should typically be replaced. But on some tests, it shows that the
> >> card can still be functional after a power cycle, but as it requires an
> >> operator to do it, the card can remain in a non-operational state for a
> >> long time until the problem has been observed by the operator.
> >>
> >> This patch adds function to power cycle the card in case it does not
> >> respond to a command, and then resend the command if the power cycle
> >> was successful. This procedure will be tested 1 time before giving up,
> >> and resuming host operation as normal.
> > 
> > I assume the context above is all about the ioctl interface?
> > 
> > So, when the card enters this non functional state, have you tried
> > just reading a block through the regular I/O interface. Does it
> > trigger a power cycle of the card - and then makes it functional
> > again?
> > 
> >>
> >> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> >> ---
> >> Please note: This might not be the way we want to handle these cases,
> >> but at least it lets us start the discussion. In which cases should the
> >> mmc framework deal with error messages like ETIMEDOUT, and in which
> >> cases should it be handled by userspace?
> >> The mmc framework tries to recover a failed block request
> >> (mmc_blk_mq_rw_recovery) which may end up in a HW reset of the card.
> >> Would it be an idea to act in a similar way when an ioctl times out?
> > 
> > Maybe, it's a good idea to allow the similar reset for ioctls as we do
> > for regular I/O requests. My concern with this though, is that we
> > might allow user space to trigger a HW resets a bit too easily - and
> > that could damage the card.
> > 
> > Did you consider this?
> > 
> >>
> >>  drivers/mmc/core/block.c | 20 ++++++++++++++++++--
> >>  1 file changed, 18 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> >> index 42e27a298218..d007b2af64d6 100644
> >> --- a/drivers/mmc/core/block.c
> >> +++ b/drivers/mmc/core/block.c
> >> @@ -976,6 +976,7 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
> >>   */
> >>  static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
> >>  {
> >> +       int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
> >>         struct mmc_queue_req *mq_rq;
> >>         struct mmc_card *card = mq->card;
> >>         struct mmc_blk_data *md = mq->blkdata;
> >> @@ -983,7 +984,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
> >>         bool rpmb_ioctl;
> >>         u8 **ext_csd;
> >>         u32 status;
> >> -       int ret;
> >> +       int ret, retry = 1;
> >>         int i;
> >>
> >>         mq_rq = req_to_mmc_queue_req(req);
> >> @@ -994,9 +995,24 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
> >>         case MMC_DRV_OP_IOCTL_RPMB:
> 
> SD cards do not have RPMB.  Did you mean eMMC?
> 

No, you are right. This action should be excluded from 'case MMC_DRV_OP_IOCTL_RPMB'.

> 
> >>                 idata = mq_rq->drv_op_data;
> >>                 for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
> >> +cmd_do:
> >>                         ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
> >> -                       if (ret)
> >> +                       if (ret == -ETIMEDOUT) {
> >> +                               dev_warn(mmc_dev(card->host),
> >> +                                        "error %d sending command\n", ret);
> >> +cmd_reset:
> >> +                               mmc_blk_reset_success(md, type);
> 
> mmc_blk_reset_success() is called upon success, not failure.  The reset will
> not be attempted twice in a row, for a given type, without a "success" in
> between.
> 

Ok, yes I see. This line and the cmd_reset label should be removed, and if
mmc_blk_reset fails we should break, not retry.

Kind regards
Mårten

> >> +                               if (retry--) {
> >> +                                       dev_warn(mmc_dev(card->host),
> >> +                                                "power cycling card\n");
> >> +                                       if (mmc_blk_reset
> >> +                                           (md, card->host, type))
> >> +                                               goto cmd_reset;
> >> +                                       mmc_blk_reset_success(md, type);
> >> +                                       goto cmd_do;
> >> +                               }
> >>                                 break;
> >> +                       }
> >>                 }
> >>                 /* Always switch back to main area after RPMB access */
> >>                 if (rpmb_ioctl)
> >> --
> >> 2.11.0
> >>
> > 
> > Kind regards
> > Uffe
> > 
> 
