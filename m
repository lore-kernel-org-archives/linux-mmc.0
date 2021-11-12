Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21EEC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Nov 2021 12:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A3C60F70
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Nov 2021 12:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhKLMsz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Nov 2021 07:48:55 -0500
Received: from smtp2.axis.com ([195.60.68.18]:31740 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234899AbhKLMsy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 12 Nov 2021 07:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1636721164;
  x=1668257164;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=NclBtNPNw9Vr+khtvDfxrz42JW1fwjkBn5TPduy+D2o=;
  b=pCzV64F7PYUwAzf59PdMGk+2XLCq676plyq6LSp2slmmBk5OCKoMAijB
   TcEKbXfnp4DW+rfmuh/I63v6T6wiPg7tZ5mw46hAKoZJtJgiYyGM09vxp
   7Psa2xGOtxmcIsYvII2KvoQR4JpaKRGAYul8BtShLqS4hRNeohbK4yLfh
   rlzerxPtgEGwOXesP4IZXiaW+Fjc6dh9kpSCfa1EM/wxbctR6urjHqm9v
   vAigUy5n64IAGGnd4hWHiZI7y0woVtfS8Z5s4rOGCFX7n5NyiL1u+qRzr
   S09OZC3qhEEg+2i9SJIYrkbo2vzdY0PFM5k8OuSWhT5r2eRr1BKL3lpi/
   w==;
Date:   Fri, 12 Nov 2021 13:46:02 +0100
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel <kernel@axis.com>, Doug Anderson <dianders@google.com>
Subject: Re: [PATCH] mmc: dw_mmc: Avoid hung state if GEN_CMD transfer fails
Message-ID: <20211112124602.GA23161@axis.com>
References: <20211103182716.28419-1-marten.lindahl@axis.com>
 <20211111154020.GA21634@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211111154020.GA21634@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 11, 2021 at 04:40:20PM +0100, Vincent Whitchurch wrote:
> On Wed, Nov 03, 2021 at 07:27:16PM +0100, Mårten Lindahl wrote:
> > If we get a data error during a block transfer command, a stop command
> > (CMD12) is normally initiated. But this does not work for the general
> > command (CMD56), but instead the action is ignored and an uninitialized
> > command struct is used for the stop action, with unexpected result.
> > 
> > Fix this by adding a check for GEN_CMD when preparing stop transmission.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> >  drivers/mmc/host/dw_mmc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 6578cc64ae9e..988c32e93e03 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -335,7 +335,8 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
> >  	    cmdr == MMC_WRITE_BLOCK ||
> >  	    cmdr == MMC_WRITE_MULTIPLE_BLOCK ||
> >  	    cmdr == MMC_SEND_TUNING_BLOCK ||
> > -	    cmdr == MMC_SEND_TUNING_BLOCK_HS200) {
> > +	    cmdr == MMC_SEND_TUNING_BLOCK_HS200 ||
> > +	    cmdr == MMC_GEN_CMD) {
> >  		stop->opcode = MMC_STOP_TRANSMISSION;
> >  		stop->arg = 0;
> >  		stop->flags = MMC_RSP_R1B | MMC_CMD_AC;

Hi!
> 
> While this fix looks correct for CMD56, the "Data transfer mode"
> sections of the eMMC and SD specifications list several more data
> commands, all of which can be aborted by CMD12, but which aren't handled
> in the if above.
> 
> If I'm not mistaken, those will also result in an uninitialized stop
> command being sent in the case of an error, since the driver calls
> send_stop_abort() on any data error.
> 
> Is there a reason why those other commands should not be in the list
> above, or should we fix this list so that CMD12 is initialized for all
> data commands except SD_IO_RW_EXTENDED?

I agree that there are more commands that according to the specification
should be included in the list. The most obvious ones that I identify are:
CMD26, CMD27, CMD30, CMD46, and CMD47.

But the reason why I added just CMD56 is that I have an easy way to test
this specific command, and which was how I saw the need for this fix.

My suggestion is to separate adding the other commands to one (or more)
separate patch(es), to when there are good test cases for those.

Kind regards
Mårten
