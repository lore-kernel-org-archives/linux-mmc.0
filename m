Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3AFC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Dec 2021 21:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhLHVIZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:08:25 -0500
Received: from smtp2.axis.com ([195.60.68.18]:45831 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236037AbhLHVIZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Dec 2021 16:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638997493;
  x=1670533493;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=DGK9XEt1aEm76L0x0Ug5M8TPT3GfMlbVsBIFV31De0s=;
  b=glOQoJ6+m2ptka/fkW1Unalz3+cqOq5gGljxBHwhz9a+vIMJiiKYK3I0
   oMjELHSGhHyd1kldoVrNhwJoLHZ5zdUoOM2Jo9jx+h4sO2Sm7CinPzjGY
   nh7/csZo0jg8iA1Z+YvKPclrJyNWrpnoG4nTiUiVDEjZ8kioCIUvmE85G
   3RsbtqHurOju6u+kLiVcAzI5QzHYndbeqdZkNFu+OqJO+HU0itkM947+N
   jrtA+Bad4rbXOUyZaGwuBquLV7Wq6t3Ck+bhl3ubi1CErGwChzUVZGuRw
   seBGwa0tfNBas3Gm024AXwWKVjSgKb2CyyR2FVoHSYpnKNkoZ4QFrZaih
   g==;
Date:   Wed, 8 Dec 2021 22:04:51 +0100
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Doug Anderson <dianders@google.com>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] mmc: dw_mmc: Add quirk for extended data read
 timeout
Message-ID: <20211208210451.GA9552@axis.com>
References: <20211206142929.26729-1-marten.lindahl@axis.com>
 <20211206142929.26729-4-marten.lindahl@axis.com>
 <CAPDyKFqB9EV9ZGwnJ+dddJGMXUpv8OpvgY5ta_a_=_An=Ca2SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFqB9EV9ZGwnJ+dddJGMXUpv8OpvgY5ta_a_=_An=Ca2SQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Dec 08, 2021 at 03:41:24PM +0100, Ulf Hansson wrote:
> On Mon, 6 Dec 2021 at 15:29, Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >
> > Current dw_mci driver supports a TMOUT register which consists of a 24
> > bit field (TMOUT[31:8]) for the DATA_TIMEOUT. The maximum value of this
> > field is 0xFFFFFF, which with a 200MHz clock will give a full DRTO of:
> >
> > 0xFFFFFF / 200000000 => ~84 ms
> >
> > However, the ARTPEC-8 SoC DWMMC IP version has a TMOUT register with an
> > extended DATA_TIMEOUT field, which supports longer timers for the DRTO.
> > In this version the DATA_TIMEOUT field is split into two, which with the
> > same 200MHz clock as above will allow a maximum timeout of:
> >
> > ((TMOUT[10:8] -1) * 0xFFFFFF + TMOUT[31:11] * 8) / 200000000 => ~587 ms
> >
> > Add a quirk to support this. The quirk is enabled for ARTPEC-8 SoCs.
> >
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> >
> > v2:
> >  - Removed unnecessary comment
> >  - Change 1<<0 to BIT(0)
> >
> >  drivers/mmc/host/dw_mmc-exynos.c |  5 +++++
> >  drivers/mmc/host/dw_mmc.c        | 33 ++++++++++++++++++++++++++++----
> >  drivers/mmc/host/dw_mmc.h        |  6 ++++++
> >  3 files changed, 40 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> > index 86486e6659de..1b625642c5b4 100644
> > --- a/drivers/mmc/host/dw_mmc-exynos.c
> > +++ b/drivers/mmc/host/dw_mmc-exynos.c
> > @@ -127,6 +127,11 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
> >                                 DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
> >         }
> >
> > +       if (priv->ctrl_type == DW_MCI_TYPE_ARTPEC8) {
> > +               /* Quirk needed for ARTPEC-8 SoCs */
> > +               host->quirks |= DW_MMC_QUIRK_EXTENDED_TMOUT;
> > +       }
> > +
> >         host->bus_hz /= (priv->ciu_div + 1);
> >
> >         return 0;
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index f2a14a434bef..45ea9fd97a6a 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -1289,6 +1289,7 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
> >  {
> >         u32 clk_div, tmout;
> >         u64 tmp;
> > +       unsigned int tmp2;
> >
> >         clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
> >         if (clk_div == 0)
> > @@ -1301,10 +1302,28 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
> >         tmout = 0xFF; /* Set maximum */
> >
> >         /* TMOUT[31:8] (DATA_TIMEOUT) */
> > -       if (!tmp || tmp > 0xFFFFFF)
> > -               tmout |= (0xFFFFFF << 8);
> > -       else
> > -               tmout |= (tmp & 0xFFFFFF) << 8;
> > +       if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT) {
> 
> Adding an option for dealing with quirks, should be avoided if
> possible. That's because we want to avoid sprinkling common dw_mmc
> code with variant specific code, as it will sooner or later turn into
> a nightmare to maintain.
> 
> In this case, I suggest you look into extending the struct
> dw_mci_drv_data with some new callback (perhaps ->set_data_timeout())
> and then implement it for your variant.
> If that callback is present, it should take precedence over the
> generic dw_mci_set_data_timeout(), if you get what I mean.

Hi Ulf!

Thanks! That's a good idea. I will implement the callback approach
instead of a quirk for this patch. It will be two callbacks; one for the
set_data_timeout(), and one for the set_drto().

> 
> Moreover, if some common dw_mmc code needs to be called from your
> callback, I suggest we make that code available through exported
> dw_mmc library functions instead.
> 
I don't think I need to export anything for this patch.

Kind regards
Mårten

> > +               /*
> > +                * Extended HW timer (max = 0x6FFFFF2):
> > +                * ((TMOUT[10:8] - 1) * 0xFFFFFF + TMOUT[31:11] * 8)
> > +                */
> > +               if (!tmp || tmp > 0x6FFFFF2)
> > +                       tmout |= (0xFFFFFF << 8);
> > +               else {
> > +                       /* TMOUT[10:8] */
> > +                       tmp2 = (((unsigned int)tmp / 0xFFFFFF) + 1) & 0x7;
> > +                       tmout |= tmp2 << 8;
> > +
> > +                       /* TMOUT[31:11] */
> > +                       tmp = tmp - ((tmp2 - 1) * 0xFFFFFF);
> > +                       tmout |= (tmp & 0xFFFFF8) << 8;
> > +               }
> > +       } else {
> > +               if (!tmp || tmp > 0xFFFFFF)
> > +                       tmout |= (0xFFFFFF << 8);
> > +               else
> > +                       tmout |= (tmp & 0xFFFFFF) << 8;
> > +       }
> >
> >         mci_writel(host, TMOUT, tmout);
> >         dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%#08x",
> > @@ -2005,9 +2024,15 @@ static void dw_mci_set_drto(struct dw_mci *host)
> >         if (drto_div == 0)
> >                 drto_div = 1;
> >
> > +       if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
> > +               drto_clks = (((drto_clks & 0x7) - 1) * 0xFFFFFF) +
> > +                       ((drto_clks & 0xFFFFF8));
> > +
> >         drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
> >                                    host->bus_hz);
> >
> > +       dev_dbg(host->dev, "drto_ms: %u\n", drto_ms);
> > +
> >         /* add a bit spare time */
> >         drto_ms += 10;
> >
> > diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> > index 771d5afa3136..3b6510d4a684 100644
> > --- a/drivers/mmc/host/dw_mmc.h
> > +++ b/drivers/mmc/host/dw_mmc.h
> > @@ -118,6 +118,7 @@ struct dw_mci_dma_slave {
> >   * @part_buf: Simple buffer for partial fifo reads/writes.
> >   * @push_data: Pointer to FIFO push function.
> >   * @pull_data: Pointer to FIFO pull function.
> > + * @quirks: Set of quirks that apply to specific versions of the IP.
> >   * @vqmmc_enabled: Status of vqmmc, should be true or false.
> >   * @irq_flags: The flags to be passed to request_irq.
> >   * @irq: The irq value to be passed to request_irq.
> > @@ -223,6 +224,8 @@ struct dw_mci {
> >         void (*push_data)(struct dw_mci *host, void *buf, int cnt);
> >         void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
> >
> > +       u32                     quirks;
> > +
> >         bool                    vqmmc_enabled;
> >         unsigned long           irq_flags; /* IRQ flags */
> >         int                     irq;
> > @@ -274,6 +277,9 @@ struct dw_mci_board {
> >         struct dma_pdata *data;
> >  };
> >
> > +/* Support for longer data read timeout */
> > +#define DW_MMC_QUIRK_EXTENDED_TMOUT            BIT(0)
> > +
> >  #define DW_MMC_240A            0x240a
> >  #define DW_MMC_280A            0x280a
> >
> 
> Kind regards
> Uffe
