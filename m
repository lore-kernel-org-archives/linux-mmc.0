From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 8/9] esdhc-4 esdhc: fsl esdhc driver based on platform
 sdhci api
Date: Tue, 7 Sep 2010 12:28:17 +0200
Message-ID: <20100907102817.GA7534@pengutronix.de>
References: <1283334533-12793-1-git-send-email-r65037@freescale.com>
 <20100906104729.GB2617@pengutronix.de>
 <A88EF4D64D8447468743DC1503C0B6CA0787D4@zch01exm22.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44604 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab0IGK2U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Sep 2010 06:28:20 -0400
Content-Disposition: inline
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0787D4@zch01exm22.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

for easier reading, I removed the parts of the code we were not talking
about.

> > +static unsigned int sdhci_fsl_get_ro(struct sdhci_host *host) {
> > +	struct sdhci_fsl_host *fsl_host =3D sdhci_priv(host);
> > +
> > +	return fsl_host->pdata->wp_status(host->mmc->parent);
> > +}
>=20
> Is there really no way to route the WP-GPIO to the SD_WP pin of the
> controller (sigh)? Still, I'd think we can be more abstract by using the
> gpiolib and just pass the gpio number in the platform-data?
> [<Zhu Richard-r65037>] Up to now, refer to the limitations of the HW
> design on the different boards, the WP-GPIO mechanism is used.
> About the more abstract method by passing the GPIO number in the
> platform-data.
> Do you means that just pass the GPIO number in the sdhci_pltfm_data
> defined in sdhci_pltfm_data.h file?

Yes, sdhci_pltfm.h would need such a member.

> I don't think we can do that, because the WP-GPIO pins maybe different
> refer to different boards.

Sure, the original information which GPIO the current board uses must
come from some kind of platform_data-struct special to the board in
question. The main thing I was after is that a gpio-number might be
enough for that, no need for a function pointer. The handling of that
GPIO could then be taken into sdhci-esdhc.c (should be generic, request
it and set it to input).

> > +
> > +static void sdhci_fsl_set_clock(struct sdhci_host *host, unsigned int
>=20
> > +clock) {
> > +	/*This variable holds the value of clock divider, prescaler */
> > +	int div =3D 0, prescaler =3D 1;
> > +	int clk_rate =3D 0;
> > +	u32 clk;
> > +	unsigned long timeout;
> > +	struct sdhci_fsl_host *fsl_host =3D sdhci_priv(host);
> > +
> > +	if (clock =3D=3D 0) {
> > +		host->clock =3D 0;
> > +		clk =3D readl(host->ioaddr + SDHCI_CLOCK_CONTROL);
> > +		writel(clk & (~FSL_SDHCI_CLOCK_HLK_EN),
> > +				host->ioaddr + SDHCI_CLOCK_CONTROL);
> > +		return;
> > +	}
> > +
> > +	clk_rate =3D clk_get_rate(fsl_host->clk_input);
> > +	clk =3D readl(host->ioaddr + SDHCI_CLOCK_CONTROL) &
> ~FSL_SDHCI_CLOCK_MASK;
> > +	/* precaler can't be set to zero in CLK_CTL reg */
> > +	clk |=3D (prescaler << 8);
> > +	writel(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);
> > +
> > +	if (clock =3D=3D sdhci_fsl_get_min_clock(host))
> > +		prescaler =3D 0x10;
> > +
> > +	while (prescaler <=3D 0x80) {
> > +		for (div =3D 0; div <=3D 0xF; div++) {
> > +			int x;
> > +			if (prescaler !=3D 0)
> > +				x =3D (clk_rate / (div + 1)) / (prescaler
> * 2);
> > +			else
> > +				x =3D clk_rate / (div + 1);
> > +
> > +			dev_dbg(&fsl_host->pdev->dev, "x=3D%d, clock=3D%d
> %d\n",
> > +					x, clock, div);
> > +			if (x <=3D clock)
> > +				break;
> > +		}
> > +		if (div < 0x10)
> > +			break;
> > +
> > +		prescaler <<=3D 1;
> > +	}
> > +	dev_dbg(&fsl_host->pdev->dev, "prescaler =3D 0x%x, divider =3D
> 0x%x\n",
> > +			prescaler, div);
> > +	clk |=3D (prescaler << 8) | (div << 4);
> > +
> > +	/* Configure the clock control register */
> > +	clk |=3D readl(host->ioaddr + SDHCI_CLOCK_CONTROL)
> > +		& (~FSL_SDHCI_CLOCK_MASK);
> > +	clk |=3D FSL_SDHCI_CLOCK_HLK_EN;
> > +	writel(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);
> > +
> > +	/* Wait max 10 ms */
> > +	timeout =3D 5000;
> > +	while (timeout > 0) {
> > +		timeout--;
> > +		udelay(20);
> > +	}
> > +	writel(clk | FSL_SDHCI_CLOCK_SD_EN, host->ioaddr +=20
> > +SDHCI_CLOCK_CONTROL);
> > +
> > +	host->clock =3D (clk_rate / (div + 1)) / (prescaler * 2); }
>=20
> Do you know if there is an improvement over the set_clock-routine in
> sdhic-of-esdhc.c?
> [<Zhu Richard-r65037>] Accepted.

Does that mean there is one or there is none? :)

> > +
> > +static void sdhci_fsl_set_bus(struct sdhci_host *host, unsigned int=20
> > +bus_width) {
> > +	u32 ctrl;
> > +
> > +	ctrl =3D readl(host->ioaddr + SDHCI_HOST_CONTROL);
> > +
> > +	if (bus_width =3D=3D MMC_BUS_WIDTH_4) {
> > +		ctrl &=3D ~FSL_SDHCI_CTRL_8BITBUS;
> > +		ctrl |=3D SDHCI_CTRL_4BITBUS;
> > +	} else if (bus_width =3D=3D MMC_BUS_WIDTH_8) {
> > +		ctrl &=3D ~SDHCI_CTRL_4BITBUS;
> > +		ctrl |=3D FSL_SDHCI_CTRL_8BITBUS;
> > +	} else if (bus_width =3D=3D MMC_BUS_WIDTH_1) {
> > +		ctrl &=3D ~SDHCI_CTRL_4BITBUS;
> > +		ctrl &=3D ~FSL_SDHCI_CTRL_8BITBUS;
> > +	}
>=20
> I'd be careful with the 8Bit-mode for now. We need some to deal with it
> correctly in sdhci.c first.
> [<Zhu Richard-r65037>] Are there some problems in the 8bits bus_width in
> sdhci.c file?
> I find that the sdhci.c had been support the 8bits bus_width.

Yes, it was added recently, but it might have issues. See here:

http://thread.gmane.org/gmane.linux.kernel.mmc/3370

> > +	host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA
>=20
> Why did you add all the DMA-stuff and mark it as broken then?
> Is there a problem with the engine?
> [<Zhu Richard-r65037>] The ADMA is broken, and I still can't find the
> root cause.
> I would enable the ADMA feature later.
> Up to now, the Simple DMA and PIO mode are enabled.

Ok, thanks. Better to leave all ADMA stuff out for now, then.

Did you have the chance to test/review my RFC yet?

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyGE8EACgkQD27XaX1/VRsLLACguUa5RRWjaV0qeCF+rFXfnkeI
7IMAoLvTPy2X6p/MZirFaK3xbZyiKeI6
=VTpz
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
