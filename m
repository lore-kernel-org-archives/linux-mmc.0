Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422AAC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Sep 2021 09:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB396109F
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Sep 2021 09:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhIJJ3U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Sep 2021 05:29:20 -0400
Received: from smtp2.axis.com ([195.60.68.18]:36060 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231818AbhIJJ3U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Sep 2021 05:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1631266090;
  x=1662802090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oFkeBzeWHDGsbkBsv/xxJlmdXpsni/5087Oboj1aZeE=;
  b=GV9bFw0sqHXOr2nUOP+/lBFhAqY8Y6VknwFd4gn+Rn52g8ERg2n95r6n
   3MeMK3oF+eluuNoQWtsw+Rsrm8dgLAiZZOTwfMs6SlUBVPDvrS68MayDs
   FWx20QuVQ7pqnks0bVemnfpOEBWLl4RO+Qjt0DODWfvfKzRxmt0rDy/tl
   AbVhwQylzI3iVV8KQ7t9+E583wJIjr1b0bFBPMcVvRjOZtWHNsxqX4+fw
   eZ24BEGAoP1Kz4BoSISjWBKhFRFWBJfb/DDYOLGBra8ohPJyLrBey4ser
   XLw9r9glF/O9UKryTI8CdAVm0VSCKRqlN/zJri7HUoP2J6kDS3JmUHxkr
   A==;
Date:   Fri, 10 Sep 2021 11:28:08 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Doug Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        kernel <kernel@axis.com>, linux-mmc <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: dw_mmc: Support more time for data read timeouts
Message-ID: <20210910092808.GA6893@axis.com>
References: <20210827085634.21225-1-marten.lindahl@axis.com>
 <CAPDyKFr7rFKhCcg56zhUDn+BSnKd-y93wJLFX20zXYFZwH2jnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFr7rFKhCcg56zhUDn+BSnKd-y93wJLFX20zXYFZwH2jnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 06, 2021 at 06:36:33PM +0200, Ulf Hansson wrote:
> On Fri, 27 Aug 2021 at 10:56, Mårten Lindahl <marten.lindahl@axis.com> wrote:
> > For data read transfers a data transfer over timer (dto_timer) is
> > started to make sure the data command can be completed in cases the Data
> > Transfer Over (DTO) interrupt does not come. This timer was originally
> > introduced as a quirk in commit 57e104864bc48 ("mmc: dw_mmc: add quirk
> > for broken data transfer over scheme"), but is since a while back part
> > of the running code.
> >
> > The dto timer picks the DATA_TIMEOUT value in the TMOUT register for its
> > timeout, which will give a max timeout of approximately 84 + (10 spare)
> > milliseconds on a 200MHz clock. But this register is not intended to be
> > used like that, since it is a counter for data read timeouts (DRTO) and
> > response timeouts (RTO), which will result in error interrupts in case
> > of data read and response delays.
> >
> > The TMOUT register is always set with a full value for every transfer,
> > which according to the manual (and with 200MHz clock) will give a full
> > DRTO of:
> > ((TMOUT[10:8] -1) * 0xFFFFFF + TMOUT[31:11] * 8) / 200000000 => ~587 ms
> >
> > But as the same register is used for the dto_timer, the dto_timer will
> > always have a fixed timeout.
> >
> > Instead of always setting a fixed value in TMOUT register, we can use
> > data->timeout_ns for the DRTO interrupts that actually matches what was
> > provided per requested command. Likewise we can also use timeout_ns for
> > the dto_timer, which will allow a max timeout of 587 ms, instead of the
> > fixed 94 ms. Furthermore, if a data error interrupt comes, it shouldn't
> > be necessary to wait for the dto_timer before we finish the command, but
> > instead we can handle it in the interrupt handler.
> >
> > Lets fix this. In most cases data->timeout_ns values are given, but in
> > case it is not given, the maximum (default) timeout for the dto_timer,
> > and the DRTO, is set to approximately 587 ms.
> >
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> 
> As this touches common dw_mmc code, I would appreciate some
> tests/reviews to be done before I apply this. Therefore I looped in
> some of the people who have been involved with dw_mmc lately.
>
> + Doug, Shawn and Vincent (maybe they can also help to review/test this change). 

I have the same hardware as Mårten (ARTPEC-8) so I don't think my
testing would add much.  We'd ideally need someone with a different
platform to help to test this.

As for the patch itself, it would perhaps be helpful if it were broken
down into three separate patches (not necessarily in the order listed
below) since it's doing three different things:

(1) Increasing the length of the software timeout.

This is the primary reason for the patch since the driver is clearly
using a wrong value for the software timeout for the entire transfer
which is lower than the timeouts required by eMMC chips' TAAC/NSAC and
the controller's timeout for (IIUC) one block.

We haven't seen any problems in practice (yet) though.

(As an aside, if I'm reading the eMMC specs correctly, the TAAC/NSAC
 applies to each block of a multi-block transfer.  If that's the case,
 then the entire transfer could, at least in theory, take several
 seconds.

 Is the data->timeout_ns calculated by mmc_set_data_timeout() supposed
 to be a per-block timeout or a timeout for the entire transfer?)

(2) Not waiting for DRTO on errors.

When attempting to increase the length of the software timeout as in (1)
or to remove it entirely, one realizes that the driver actually depends
on the software timeout to prevent hanging indefinitely when CRC errors
are received during tuning.  It's unclear if this is something specific
to our version of the IP or if this is an old regression in the driver
(given that the driver apparently used to work fine without a software
timeout at some point of time on some platforms.)

So increasing the software timeout length will make each failing step in
tuning take half a second which would increase boot time significantly,
so that's why I think the early exit is needed.

(3) Reducing the length of the hardware timeout.

I *think* this is also to reduce initialization time if there are some
transfers which are meant to time out (without any other errors) which
would now take longer to time out after (1), but this part of the change
could use a bit more rationale.
