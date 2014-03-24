From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/7] mmc: dw_mmc: exynos: don't use if clock isn't available
Date: Mon, 24 Mar 2014 15:39:10 +0900
Message-ID: <000901cf472b$c3742b90$4a5c82b0$%jun@samsung.com>
References: <001c01cf450e$51ba0d40$f52e27c0$%jun@samsung.com>
 <532FB25C.6000700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46484 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaCXGjN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Mar 2014 02:39:13 -0400
In-reply-to: <532FB25C.6000700@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>

On Mon, March 24, 2014, Jaehoon Chung wrote:
> Hi, Seungwon.
> 
> On 03/21/2014 11:03 PM, Seungwon Jeon wrote:
> > Adds checking whether the clock is valid.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/host/dw_mmc-exynos.c |   14 +++++++++++---
> >  1 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> > index a67e784..89aa019 100644
> > --- a/drivers/mmc/host/dw_mmc-exynos.c
> > +++ b/drivers/mmc/host/dw_mmc-exynos.c
> > @@ -117,7 +117,12 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
> >  static int dw_mci_exynos_setup_clock(struct dw_mci *host)
> >  {
> >  	struct dw_mci_exynos_priv_data *priv = host->priv;
> > -	unsigned long rate = clk_get_rate(host->ciu_clk);
> > +	unsigned long rate;
> > +
> > +	if (IS_ERR(host->ciu_clk))
> > +		rate = host->bus_hz;
> > +	else
> > +		rate = clk_get_rate(host->ciu_clk);
> >
> >  	host->bus_hz = rate / (priv->ciu_div + 1);
> how about this?
> host->bus_hz /= (priv->ciu_div + 1);
> 
> host->bus_hz is already set to "host->bus_hz" or "clk_get_rate()" into dw_mmc.c.
OK. It would be better.

Thanks,
Seungwon Jeon

> 
> Best Regards,
> Jaehoon Chung
> >  	return 0;
> > @@ -196,8 +201,11 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >  		mci_writel(host, CLKSEL, priv->sdr_timing);
> >  	}
> >
> > -	/* Don't care if wanted clock is zero */
> > -	if (!wanted)
> > +	/*
> > +	 * Don't care if wanted clock is zero or
> > +	 * ciu clock is unavailable
> > +	 */
> > +	if (!wanted || IS_ERR(host->ciu_clk))
> >  		return;
> >
> >  	/* Guaranteed minimum frequency for cclkin */
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

