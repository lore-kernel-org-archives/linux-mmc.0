From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/3 v3] mmc: sh_mmcif: calculate best clock with parent clock
Date: Tue, 21 Apr 2015 16:07:37 +0300
Message-ID: <1433253.xXE7ok9ACb@avalon>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com> <87r3rdubmv.wl%kuninori.morimoto.gx@renesas.com> <CAMuHMdUM4Cizij6q+6o9mADF_UjkzpZSvsUCdG+Y=PHo=A_qLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:54751 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbbDUNH3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Apr 2015 09:07:29 -0400
In-Reply-To: <CAMuHMdUM4Cizij6q+6o9mADF_UjkzpZSvsUCdG+Y=PHo=A_qLw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, kobayashi <keita.kobayashi.ym@renesas.com>

Hello,

On Tuesday 21 April 2015 12:31:21 Geert Uytterhoeven wrote:
> On Tue, Apr 21, 2015 at 10:31 AM, Kuninori Morimoto wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > MMCIF IP on R-Car series has parent clock which can be set
> > several rate, and it was not implemented on old SH-Mobile series
> > (= SH-Mobile series parent clock was fixed rate)
> > R-Car series MMCIF can use more high speed access if it setup
> > parent clock. This patch adds parent clock setup method,
> > and r8a7790/r8a7791 can use it.
> > 
> > renesas,mmcif already contain renesas,mmcif-r8a7790/r8a7791 on
> > compatible string. So there is no update for binding Document.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> > 
> > diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> > index 5282c5b..6ae836b 100644
> > --- a/drivers/mmc/host/sh_mmcif.c
> > +++ b/drivers/mmc/host/sh_mmcif.c
> > @@ -224,6 +225,12 @@ enum mmcif_wait_for {
> >         MMCIF_WAIT_FOR_STOP,
> >  };
> > 
> > +struct sh_mmcif_parent_clk {

I'm not sure I would call this parent clock. It refers to the frequency of the 
functional clock provided to the MMCIF, there's no concept of parent there. 
True, the clock referenced by the MMCIF DT node is an MSTP gate clock, and 
frequency control is implemented in the MSTP clock parent, but that hardware 
architecture is internal to the CPG and shouldn't be considered by the MMCIF.

> > +       unsigned int max; /* if exist: R-Car has MMC CKCR on CPG */
> > +       unsigned int min; /* if exist: R-Car has MMC CKCR on CPG */
> > +       u32 clkdiv_map;  /* see CE_CLK_CTRL::CLKDIV */
> > +};
> > +
> >  struct sh_mmcif_host {
> >         struct mmc_host *mmc;
> >         struct mmc_request *mrq;
> > @@ -249,6 +256,7 @@ struct sh_mmcif_host {
> >         bool ccs_enable;                /* Command Completion Signal
> >         support */
> >         bool clk_ctrl2_enable;
> >         struct mutex thread_lock;
> > +       const struct sh_mmcif_parent_clk *parent_clk;
> > 
> >         /* DMA support */
> >         struct dma_chan         *chan_rx;
> > @@ -257,8 +265,16 @@ struct sh_mmcif_host {
> >         bool                    dma_active;
> >  };
> > 
> > +static const struct sh_mmcif_parent_clk mmcif_gen2_parent_clk = {
> > +       .max = 97500000,
> > +       .min = 12187500,
> > +       .clkdiv_map = 0x3ff,
> 
> Shouldn't this come from private data in the CPG clock driver, which
> supplies the parent clock? Then the mmcif driver will be independent from
> the parent clock.

The real question is where the constraint comes from. The Gen2 datasheet 
documents the MMC clocks maximum frequency as 97.5 MHz in the CPG section. 
However, I have a feeling the constraint doesn't come from the DIV6 which 
should be able to output higher frequencies, but from the MMCIF, the clock 
distribution tree, or both.

There's also the option of specifying the admissible clock range in DT, either 
in the CPG node or the MMCIF node.

> > +};

-- 
Regards,

Laurent Pinchart

