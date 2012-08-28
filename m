From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] mmc: omap_hsmmc: cleanup the bitmap definitions of
 Interrupt Register
Date: Tue, 28 Aug 2012 16:23:29 +0300
Message-ID: <20120828132327.GZ27166@arwen.pp.htv.fi>
References: <1346159947-3194-1-git-send-email-svenkatr@ti.com>
 <1346159947-3194-2-git-send-email-svenkatr@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Re7H+V5lQR2Zv/pu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:48214 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752024Ab2H1N1k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 09:27:40 -0400
Received: by lbky2 with SMTP id y2so3046342lbk.17
        for <linux-mmc@vger.kernel.org>; Tue, 28 Aug 2012 06:27:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346159947-3194-2-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balbi@ti.com


--Re7H+V5lQR2Zv/pu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 28, 2012 at 06:49:07PM +0530, Venkatraman S wrote:
> Define the most frequently used bitmasks of the Interrupt Enable /
> Interrupt Status register with consistent naming ( with _EN suffix).
>=20
> Use meaningful concatenation of bitfields for INT_EN_MASK, which shows
> which interrupts are enabled by default.
> No functional changes.
>=20
> Signed-off-by: Venkatraman S <svenkatr@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mmc/host/omap_hsmmc.c | 51 ++++++++++++++++++++++++-------------=
------
>  1 file changed, 29 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 57e86a4..03c2362 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -79,28 +79,16 @@
>  #define CLKD_SHIFT		6
>  #define DTO_MASK		0x000F0000
>  #define DTO_SHIFT		16
> -#define INT_EN_MASK		0x306E0033
> -#define BWR_ENABLE		(1 << 4)
> -#define BRR_ENABLE		(1 << 5)
> -#define DTO_ENABLE		(1 << 20)
>  #define INIT_STREAM		(1 << 1)
>  #define DP_SELECT		(1 << 21)
>  #define DDIR			(1 << 4)
> -#define DMA_EN			0x1
> +#define DMAE			0x1
>  #define MSBS			(1 << 5)
>  #define BCE			(1 << 1)
>  #define FOUR_BIT		(1 << 1)
>  #define DDR			(1 << 19)
>  #define DW8			(1 << 5)
> -#define CC			0x1
> -#define TC			0x02
>  #define OD			0x1
> -#define ERR			(1 << 15)
> -#define CMD_TIMEOUT		(1 << 16)
> -#define DATA_TIMEOUT		(1 << 20)
> -#define CMD_CRC			(1 << 17)
> -#define DATA_CRC		(1 << 21)
> -#define CARD_ERR		(1 << 28)
>  #define STAT_CLEAR		0xFFFFFFFF
>  #define INIT_STREAM_CMD		0x00000000
>  #define DUAL_VOLT_OCR_BIT	7
> @@ -109,6 +97,25 @@
>  #define SOFTRESET		(1 << 1)
>  #define RESETDONE		(1 << 0)
> =20
> +/* Interrupt masks for IE and ISE register */
> +#define CC_EN			(1 << 0)
> +#define TC_EN			(1 << 1)
> +#define BWR_EN			(1 << 4)
> +#define BRR_EN			(1 << 5)
> +#define ERR_EN			(1 << 15)
> +#define CTO_EN			(1 << 16)
> +#define CCRC_EN		(1 << 17)
> +#define CEB_EN			(1 << 18)
> +#define CIE_EN			(1 << 19)
> +#define DTO_EN			(1 << 20)
> +#define DCRC_EN		(1 << 21)
> +#define DEB_EN			(1 << 22)
> +#define CERR_EN		(1 << 28)
> +#define BADA_EN		(1 << 29)
> +
> +#define INT_EN_MASK		(BADA_EN | CERR_EN | DEB_EN | DCRC_EN | \
> +		CIE_EN | CEB_EN | CCRC_EN | BRR_EN | BWR_EN | TC_EN | CC_EN)
> +
>  #define MMC_AUTOSUSPEND_DELAY	100
>  #define MMC_TIMEOUT_MS		20
>  #define OMAP_MMC_MIN_CLOCK	400000
> @@ -453,7 +460,7 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_h=
ost *host,
>  	unsigned int irq_mask;
> =20
>  	if (host->use_dma)
> -		irq_mask =3D INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE);
> +		irq_mask =3D INT_EN_MASK & ~(BRR_EN | BWR_EN);
>  	else
>  		irq_mask =3D INT_EN_MASK;
> =20
> @@ -673,8 +680,8 @@ static void send_init_stream(struct omap_hsmmc_host *=
host)
>  	OMAP_HSMMC_WRITE(host->base, CMD, INIT_STREAM_CMD);
> =20
>  	timeout =3D jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> -	while ((reg !=3D CC) && time_before(jiffies, timeout))
> -		reg =3D OMAP_HSMMC_READ(host->base, STAT) & CC;
> +	while ((reg !=3D CC_EN) && time_before(jiffies, timeout))
> +		reg =3D OMAP_HSMMC_READ(host->base, STAT) & CC_EN;
> =20
>  	OMAP_HSMMC_WRITE(host->base, CON,
>  		OMAP_HSMMC_READ(host->base, CON) & ~INIT_STREAM);
> @@ -765,7 +772,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host=
, struct mmc_command *cmd,
>  	}
> =20
>  	if (host->use_dma)
> -		cmdreg |=3D DMA_EN;
> +		cmdreg |=3D DMAE;
> =20
>  	host->req_in_progress =3D 1;
> =20
> @@ -988,11 +995,11 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_hos=
t *host, int status)
>  	data =3D host->data;
>  	dev_vdbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
> =20
> -	if (status & ERR) {
> +	if (status & ERR_EN) {
>  		omap_hsmmc_dbg_report_irq(host, status);
> -		if (status & (CMD_TIMEOUT | DATA_TIMEOUT))
> +		if (status & (CTO_EN | DTO_EN))
>  			hsmmc_command_incomplete(host, -ETIMEDOUT);
> -		else if (status & (CMD_CRC | DATA_CRC))
> +		else if (status & (CCRC_EN | DCRC_EN))
>  			hsmmc_command_incomplete(host, -EILSEQ);
> =20
>  		end_cmd =3D 1;
> @@ -1002,9 +1009,9 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_hos=
t *host, int status)
>  		}
>  	}
> =20
> -	if (end_cmd || ((status & CC) && host->cmd))
> +	if (end_cmd || ((status & CC_EN) && host->cmd))
>  		omap_hsmmc_cmd_done(host, host->cmd);
> -	if ((end_trans || (status & TC)) && host->mrq)
> +	if ((end_trans || (status & TC_EN)) && host->mrq)
>  		omap_hsmmc_xfer_done(host, data);
>  }
> =20
> --=20
> 1.7.11.1.25.g0e18bef
>=20

--=20
balbi

--Re7H+V5lQR2Zv/pu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQPMZPAAoJEIaOsuA1yqRExWsP/1hk8JjdJsobIPPJPv/UAr6Q
K9H1PEyR4LAz2c1+AXpv+PFi7RxLryRH4h+RweYZ8uzkyUF0iRr+2z/Mzzye079q
wk7j2FVrk4UQC7wHYmsifH50Ob4LHLR0zcjyl7ftCZDxRjvcw7dnJ7m/3vAL6kc5
YAAOuRQywBHD564j8+ySH8eA4bXs6VAxnR7kKvB84CPuylsmwB9gel2xuk2Cdj4g
AOjsdnGcos4Ypyj/4Xh08lZ+KkbZSZyKGAq+GrayzahhH0+l/B37XmpEKiTQSe8y
7QDKMT2YE+8/PSe5t3yAdzd/QjeFtDZD02ERtj197gvBGNa7GBDChNYhBe56jwrX
+jDBDD/1m9OLq31UiXX+TSXUCGo11z24qqgu6qoWGXcV1wPy7YC3zZkIsn6tEhsy
SBM1PR4RglUIkhENQyfdNwhsdll9qmAvyTS8pLgl2CM+mIy8GkoonYg3CuD8XGPV
VOfEOhOWkvzmNdvEQv6qzxEXbd9UG8HYWiZ7KCJTYOxlPS+9Sam44Gs/mX5QA0X/
SyN1JCCXSagEgw4tpNOkYbtZ4zsGYp9W+vSXUfZ+3+4cZ0JQZI5ksgFrGiJXHCME
t3H+4aDNDOj3Q0oyTdZnuC6rNAPdwnCPxF/0szba1H5Q9seDktfRZAxq/TfukaZt
FvHIuY1xIctB44v2mwxV
=yR/B
-----END PGP SIGNATURE-----

--Re7H+V5lQR2Zv/pu--
