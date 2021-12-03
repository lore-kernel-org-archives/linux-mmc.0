Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D93C4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 12:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380673AbhLCMGY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Dec 2021 07:06:24 -0500
Received: from smtp2.axis.com ([195.60.68.18]:28139 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhLCMGX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Dec 2021 07:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638532980;
  x=1670068980;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=yj/0xNzd5mKJtxPQc4qwK79KpAgK+A6FMJkVDzGH4Bk=;
  b=MsTxrN8hYYCRgGPPStN2DTIQ4TSW+Kkg6GSE5LWOGVN/vvfurrb/0Iqr
   UJ0eCbBkqp3gni6PNnGHTlRd60PKQMDq6iRiPJIkSpD7BX0i8HPNQ8Mec
   vs6BQTtD2CEqcbMBFcMCXginHvDfUirfzCujtwtJ5ana2FrfjbWGhMCd5
   RVQsosljlrJZLsp1HOcrWPUfOpnJk8y0TsCnx0rlpRc71QnWlCSdhUVJG
   RoETOfg9ka1fHIfy6kUcuDkTW1o2B+CxHYOoiu3Sd1m3DPyQIxKC7KYZ8
   8Mhky6Np1MYgIrhlFFDF8hzqiU7jc4oFw0F7gfgoWKOqpK8izvZsn1Bbd
   g==;
Date:   Fri, 3 Dec 2021 13:02:58 +0100
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Doug Anderson <dianders@google.com>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH 3/4] mmc: dw_mmc: Add quirk for extended data read timeout
Message-ID: <20211203120258.GB23260@axis.com>
References: <20211201153804.27655-1-marten.lindahl@axis.com>
 <20211201153804.27655-4-marten.lindahl@axis.com>
 <2875d5c8-dc98-0e3c-41b8-c71bd439ced4@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2875d5c8-dc98-0e3c-41b8-c71bd439ced4@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Dec 02, 2021 at 09:39:30AM +0100, Krzysztof Kozlowski wrote:

Hi Krzysztof!
Thanks for looking at this!

> On 01/12/2021 16:38, Mårten Lindahl wrote:
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
> >  drivers/mmc/host/dw_mmc-exynos.c |  5 +++++
> >  drivers/mmc/host/dw_mmc.c        | 33 ++++++++++++++++++++++++++++----
> >  drivers/mmc/host/dw_mmc.h        |  7 +++++++
> >  3 files changed, 41 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> > index cae7c94b5d6e..6ae9c0ec1282 100644
> > --- a/drivers/mmc/host/dw_mmc-exynos.c
> > +++ b/drivers/mmc/host/dw_mmc-exynos.c
> > @@ -127,6 +127,11 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
> >  				DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
> >  	}
> >  
> > +	if (priv->ctrl_type == DW_MCI_TYPE_ARTPEC8) {
> > +		/* Quirk needed for ARTPEC-8 SoCs */
> > +		host->quirks |= DW_MMC_QUIRK_EXTENDED_TMOUT;
> > +	}
> > +
> >  	host->bus_hz /= (priv->ciu_div + 1);
> >  
> >  	return 0;
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index f2a14a434bef..45ea9fd97a6a 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -1289,6 +1289,7 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
> >  {
> >  	u32 clk_div, tmout;
> >  	u64 tmp;
> > +	unsigned int tmp2;
> >  
> >  	clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
> >  	if (clk_div == 0)
> > @@ -1301,10 +1302,28 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
> >  	tmout = 0xFF; /* Set maximum */
> >  
> >  	/* TMOUT[31:8] (DATA_TIMEOUT) */
> > -	if (!tmp || tmp > 0xFFFFFF)
> > -		tmout |= (0xFFFFFF << 8);
> > -	else
> > -		tmout |= (tmp & 0xFFFFFF) << 8;
> > +	if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT) {
> > +		/*
> > +		 * Extended HW timer (max = 0x6FFFFF2):
> > +		 * ((TMOUT[10:8] - 1) * 0xFFFFFF + TMOUT[31:11] * 8)
> > +		 */
> > +		if (!tmp || tmp > 0x6FFFFF2)
> > +			tmout |= (0xFFFFFF << 8);
> > +		else {
> > +			/* TMOUT[10:8] */
> > +			tmp2 = (((unsigned int)tmp / 0xFFFFFF) + 1) & 0x7;
> > +			tmout |= tmp2 << 8;
> > +
> > +			/* TMOUT[31:11] */
> > +			tmp = tmp - ((tmp2 - 1) * 0xFFFFFF);
> > +			tmout |= (tmp & 0xFFFFF8) << 8;
> > +		}
> > +	} else {
> > +		if (!tmp || tmp > 0xFFFFFF)
> > +			tmout |= (0xFFFFFF << 8);
> > +		else
> > +			tmout |= (tmp & 0xFFFFFF) << 8;
> > +	}
> >  
> >  	mci_writel(host, TMOUT, tmout);
> >  	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%#08x",
> > @@ -2005,9 +2024,15 @@ static void dw_mci_set_drto(struct dw_mci *host)
> >  	if (drto_div == 0)
> >  		drto_div = 1;
> >  
> > +	if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
> > +		drto_clks = (((drto_clks & 0x7) - 1) * 0xFFFFFF) +
> > +			((drto_clks & 0xFFFFF8));
> > +
> >  	drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
> >  				   host->bus_hz);
> >  
> > +	dev_dbg(host->dev, "drto_ms: %u\n", drto_ms);
> > +
> >  	/* add a bit spare time */
> >  	drto_ms += 10;
> >  
> > diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> > index 771d5afa3136..071f4479f166 100644
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
> > @@ -223,6 +224,9 @@ struct dw_mci {
> >  	void (*push_data)(struct dw_mci *host, void *buf, int cnt);
> >  	void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
> >  
> > +	/* Workaround flags */
> 
> No need for this comment - you already described the field in kerneldoc.

Ok, will remove it.

> 
> > +	u32			quirks;
> > +
> >  	bool			vqmmc_enabled;
> >  	unsigned long		irq_flags; /* IRQ flags */
> >  	int			irq;
> > @@ -274,6 +278,9 @@ struct dw_mci_board {
> >  	struct dma_pdata *data;
> >  };
> >  
> > +/* Support for longer data read timeout */
> > +#define DW_MMC_QUIRK_EXTENDED_TMOUT	(1<<0)
> 
> BIT()

Will fix.

> 
> > +
> >  #define DW_MMC_240A		0x240a
> >  #define DW_MMC_280A		0x280a
> >  
> > 
> 

Kind regards
Mårten
> 
> Best regards,
> Krzysztof
