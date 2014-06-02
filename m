From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/5] mmc: sdhci-esdhc-imx: add f_max field to private data
Date: Mon, 2 Jun 2014 08:40:38 +0200
Message-ID: <20140602064038.GP15686@pengutronix.de>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
 <1400848384-3226-2-git-send-email-s.hauer@pengutronix.de>
 <20140601074540.GC11061@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59190 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbaFBGkm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jun 2014 02:40:42 -0400
Content-Disposition: inline
In-Reply-To: <20140601074540.GC11061@dragon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Sun, Jun 01, 2014 at 03:45:43PM +0800, Shawn Guo wrote:
> > @@ -594,7 +592,7 @@ static inline void esdhc_pltfm_set_clock(struct=
 sdhci_host *host,
> >  {
> >  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >  	struct pltfm_imx_data *imx_data =3D pltfm_host->priv;
> > -	unsigned int host_clock =3D pltfm_host->clock;
> > +	unsigned int host_clock =3D clk_get_rate(imx_data->clk_per);
>=20
> Will this bring the issue that commit a974862faee1 (mmc: sdhci-esdhc-=
imx:
> fix access hardirq-unsafe lock in atomic context) fixed back to us?

Probably, yes, because the =A7%$&"$$ sdhc driver still uses spinlocks.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
