Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9A4C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 13:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A72661184
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 13:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhKINap (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 08:30:45 -0500
Received: from smtp2.axis.com ([195.60.68.18]:14287 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235585AbhKINao (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 9 Nov 2021 08:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1636464479;
  x=1668000479;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=w7fZdFR17OmM6mUNCNSmp11QOlrORncM/faNI+ahf1U=;
  b=bUfhNMOp8S5LVPQAWsZovjHZLMRvhMdrhnoKPX5f5iPzzL+LfQo4koDG
   YDHTowECJZ97emGTZxBeRfRjcmCWDNzsKRgE2ymFsw6douFE+EO0cZ0Hn
   V1cN8Be8U3ALETsKLM0QAabBPDceLYzRBr3v98fkpIi/zmmd3wWKywk1o
   uisQqpEHuiOa4A4FfQF3FEwRVatNd0QSUyVozDFiMRComZIiw2H0vSf4V
   huRJpyp2tQGyE1GyJSnGrP9q1R9aAeh/PT36cRAiB4ksgKD0OwTnyogLx
   vIuTKaFYnv1C2pUvEPf7gqwrfd7aJy1VEnfaTMOVDtOnSzZkBj4E3yRKr
   A==;
Date:   Tue, 9 Nov 2021 14:27:57 +0100
To:     Jaehoon Chung <jh80.chung@samsung.com>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Doug Anderson <dianders@google.com>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: Allow lower TMOUT value than maximum
Message-ID: <20211109132757.GA8103@axis.com>
References: <CGME20211108113655epcas1p1b3621396703dffc16f0bca0d5f108c18@epcas1p1.samsung.com>
 <20211108113637.3699-1-marten.lindahl@axis.com>
 <9cbaceb0-e238-490f-477f-5d0615401a45@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cbaceb0-e238-490f-477f-5d0615401a45@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Nov 09, 2021 at 12:46:17AM +0100, Jaehoon Chung wrote:
> Hi Marten,

Hi Jaehoon!

> 
> On 11/8/21 8:36 PM, Mårten Lindahl wrote:
> > The TMOUT register is always set with a full value for every transfer,
> > which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
> > Since the software dto_timer acts as a backup in cases when this timeout
> > is not long enough, it is normally not a problem. But setting a full
> > value makes it impossible to test shorter timeouts, when for example
> > testing data read times on different SD cards.
> > 
> > Add a function to set any value smaller than the maximum of 0xFFFFFF.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> > 
> > v2:
> >  - Calculate new value before checking boundaries
> >  - Include CLKDIV register to get proper value
> > 
> >  drivers/mmc/host/dw_mmc.c | 32 +++++++++++++++++++++++++++++++-
> >  1 file changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 6578cc64ae9e..6edd7a231448 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -1283,6 +1283,36 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> >  	mci_writel(host, CTYPE, (slot->ctype << slot->id));
> >  }
> >  
> > +static void dw_mci_set_data_timeout(struct dw_mci *host,
> > +				    unsigned int timeout_ns)
> > +{
> > +	unsigned int clk_div, tmp, tmout;
> > +
> > +	clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
> > +	if (clk_div == 0)
> > +		clk_div = 1;
> > +
> > +	tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz,
> > +			       NSEC_PER_SEC * clk_div);
> > +
> > +	if (!tmp || tmp > 0xFFFFFF) {
> > +		/* Set maximum */
> 
> "Set maximum value about all Timeout"?

Do you mean just changing the comment here? Or do you wonder about the
0xFFFFFF check? 0xFFFFFF is the upper limit for this HW timer. If we
want to support a longer timer than this, a software timer should be
used, but in a separate patch.

> 
> > +		tmout = 0xFFFFFFFF;
> > +		goto tmout_done;
> > +	}
> 
> It doesn't need to use "goto". Instead, if-else can be used.

If you prefer it I can change goto to if-else

> 
> > +
> > +	/* TMOUT[7:0] (RESPONSE_TIMEOUT) */
> > +	tmout = 0xFF; /* Set maximum */
> 
> To prevent a confusion, how about add "Set a maximum response timeout"
> And this line can be removed.

But if removing the lines above, the comment will also be removed. I see
your point, but couldn't there be more confusion by merging both fields
into one line? My intention was to specify the TMOUT register fields
separately to make it more clear.

> 
> > +
> > +	/* TMOUT[31:8] (DATA_TIMEOUT) */
> > +	tmout |= (tmp & 0xFFFFFF) << 8;
> 
> tmout = (0xFF | ((tmp & 0xFFFFFF) << 8));
> 
> The entire code can be below
> 
> if (!tmp || ....)
> 	tmout = 0xFFFFFFFF;
> else 
> 	tmout = (0xFF | ((tmp & 0xFFFFFF) << 8));
> 
> writel(TMOUT, ...)
> 
> How about this?

I agree that this is smaller code, but as I said above it may not be
clear that there are more than one field in the TMOUT register. Wouldn't
it raise questions about the 0xFF?

Kind regards
Mårten

> 
> Best Regards,
> Jaehoon Chung
> 
> > +
> > +tmout_done:
> > +	mci_writel(host, TMOUT, tmout);
> > +	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%06x",
> > +		timeout_ns, tmout >> 8);
> > +}
> > +
> >  static void __dw_mci_start_request(struct dw_mci *host,
> >  				   struct dw_mci_slot *slot,
> >  				   struct mmc_command *cmd)
> > @@ -1303,7 +1333,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
> >  
> >  	data = cmd->data;
> >  	if (data) {
> > -		mci_writel(host, TMOUT, 0xFFFFFFFF);
> > +		dw_mci_set_data_timeout(host, data->timeout_ns);
> >  		mci_writel(host, BYTCNT, data->blksz*data->blocks);
> >  		mci_writel(host, BLKSIZ, data->blksz);
> >  	}
> > 
> 
