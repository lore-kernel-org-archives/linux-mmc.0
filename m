Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22662C433DB
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 22:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57CA60232
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 22:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhCAWCb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Mar 2021 17:02:31 -0500
Received: from smtp2.axis.com ([195.60.68.18]:57721 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241119AbhCAWA2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 1 Mar 2021 17:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1614636027;
  x=1646172027;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=vRN3Tbv1NNoCdCjpywaziujMB41EJE5+ffWoaSrPzH8=;
  b=kca5SUoGs0YX079lqLhm4S9YIBlOKjzBMFn0oGhwA7eSOyy75LQ2vilj
   TCP+pcppjWNO+JinSrQ+A3iSV3Vc4XqZ1yE917cOqcWG88ZvY5E2wnqt0
   FxhiedxB/m4B4cRqLDCgXvSKEyOSwmg9/FHgWNWLYPSzFbsJeK3zvZ+i3
   yzW+XZ/4pRJ6/NkvvDOIev/vspsmjisZe9+Aw296AE2sPIuSQYkktesFh
   h2z8GRoEk+eN8UPXvR3vk1dEWei104BClQJJFk4+HH9nkn5i+Nbw1O4Md
   M9ucP5pK53IxoXrgTIB2Nt/DtvhVAPklTqB6kLUKYCuSzmoIyzrAWEMdJ
   A==;
Date:   Mon, 1 Mar 2021 22:59:23 +0100
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel <kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: Try power cycling card if command request times out
Message-ID: <20210301215923.6jfg6mg5ntorttan@axis.com>
References: <20210216224252.22187-1-marten.lindahl@axis.com>
 <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf!

Thank you for your comments!

On Mon, Mar 01, 2021 at 09:50:56AM +0100, Ulf Hansson wrote:
> + Adrian
> 
> On Tue, 16 Feb 2021 at 23:43, Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >
> > Sometimes SD cards that has been run for a long time enters a state
> > where it cannot by itself be recovered, but needs a power cycle to be
> > operational again. Card status analysis has indicated that the card can
> > end up in a state where all external commands are ignored by the card
> > since it is halted by data timeouts.
> >
> > If the card has been heavily used for a long time it can be weared out,
> > and should typically be replaced. But on some tests, it shows that the
> > card can still be functional after a power cycle, but as it requires an
> > operator to do it, the card can remain in a non-operational state for a
> > long time until the problem has been observed by the operator.
> >
> > This patch adds function to power cycle the card in case it does not
> > respond to a command, and then resend the command if the power cycle
> > was successful. This procedure will be tested 1 time before giving up,
> > and resuming host operation as normal.
> 
> I assume the context above is all about the ioctl interface?
> 

Yes, that's correct. The problem we have seen is triggered by ioctls.

> So, when the card enters this non functional state, have you tried
> just reading a block through the regular I/O interface. Does it
> trigger a power cycle of the card - and then makes it functional
> again?
> 

Yes, we have tried that, and it does trigger a power cycle, making the card
operational again. But as it requires an operator to trigger it, I thought
it might be something that could be automated here. At least once.

> >
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> > Please note: This might not be the way we want to handle these cases,
> > but at least it lets us start the discussion. In which cases should the
> > mmc framework deal with error messages like ETIMEDOUT, and in which
> > cases should it be handled by userspace?
> > The mmc framework tries to recover a failed block request
> > (mmc_blk_mq_rw_recovery) which may end up in a HW reset of the card.
> > Would it be an idea to act in a similar way when an ioctl times out?
> 
> Maybe, it's a good idea to allow the similar reset for ioctls as we do
> for regular I/O requests. My concern with this though, is that we
> might allow user space to trigger a HW resets a bit too easily - and
> that could damage the card.
> 
> Did you consider this?
> 

Yes, that is a valid point, and that is why the power cycle is only tried
once. But the conditon for this reset is a -ETIMEDOUT, and this is the part of
this patch where I am myself not sure of if it is enough to check for. Would
this be an error that you could expect to happen with ioctl requests in other
situations also, but not necessarily cause by a stalled card?

Kind regards
Mårten

> >
> >  drivers/mmc/core/block.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 42e27a298218..d007b2af64d6 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -976,6 +976,7 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
> >   */
> >  static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
> >  {
> > +       int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
> >         struct mmc_queue_req *mq_rq;
> >         struct mmc_card *card = mq->card;
> >         struct mmc_blk_data *md = mq->blkdata;
> > @@ -983,7 +984,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
> >         bool rpmb_ioctl;
> >         u8 **ext_csd;
> >         u32 status;
> > -       int ret;
> > +       int ret, retry = 1;
> >         int i;
> >
> >         mq_rq = req_to_mmc_queue_req(req);
> > @@ -994,9 +995,24 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
> >         case MMC_DRV_OP_IOCTL_RPMB:
> >                 idata = mq_rq->drv_op_data;
> >                 for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
> > +cmd_do:
> >                         ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
> > -                       if (ret)
> > +                       if (ret == -ETIMEDOUT) {
> > +                               dev_warn(mmc_dev(card->host),
> > +                                        "error %d sending command\n", ret);
> > +cmd_reset:
> > +                               mmc_blk_reset_success(md, type);
> > +                               if (retry--) {
> > +                                       dev_warn(mmc_dev(card->host),
> > +                                                "power cycling card\n");
> > +                                       if (mmc_blk_reset
> > +                                           (md, card->host, type))
> > +                                               goto cmd_reset;
> > +                                       mmc_blk_reset_success(md, type);
> > +                                       goto cmd_do;
> > +                               }
> >                                 break;
> > +                       }
> >                 }
> >                 /* Always switch back to main area after RPMB access */
> >                 if (rpmb_ioctl)
> > --
> > 2.11.0
> >
> 
> Kind regards
> Uffe
