From: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: tegra: use mmc_of_parse to get the support of
 standard MMC DT bindings
Date: Fri, 22 Feb 2013 10:07:39 +0800
Message-ID: <1361498859.2330.1.camel@jlo-ubuntu-64.nvidia.com>
References: <1361343902-15223-1-git-send-email-josephl@nvidia.com>
	 <1361343902-15223-3-git-send-email-josephl@nvidia.com>
	 <Pine.LNX.4.64.1302212333330.10403@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.1302212333330.10403-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 2013-02-22 at 06:44 +0800, Guennadi Liakhovetski wrote:
> Hi Joseph
>=20
> On Wed, 20 Feb 2013, Joseph Lo wrote:
> >  static int tegra_sdhci_buswidth(struct sdhci_host *host, int bus_w=
idth)
> >  {
> > -	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > -	struct sdhci_tegra *tegra_host =3D pltfm_host->priv;
> >  	u32 ctrl;
> > =20
> >  	ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
> > -	if (tegra_host->is_8bit && bus_width =3D=3D MMC_BUS_WIDTH_8) {
> > +	if (host->mmc->caps =3D=3D MMC_CAP_8_BIT_DATA &&
>=20
> Don't you want to check for just one bit? -=C5=A0caps can contain mul=
tiple=20
> flags set:
>=20
> +	if ((host->mmc->caps & MMC_CAP_8_BIT_DATA) &&
>=20
Ah, yes. Thanks for your review.

Joseph
