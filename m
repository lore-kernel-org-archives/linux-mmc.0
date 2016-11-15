From: "Y.B. Lu" <yangbo.lu@nxp.com>
Subject: RE: [PATCH v3] mmc: sdhci-of-esdhc: fixup PRESENT_STATE read
Date: Tue, 15 Nov 2016 06:12:01 +0000
Message-ID: <DB6PR0401MB2536A311EE5215FBC9DE0397F8BF0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1479136348-30706-1-git-send-email-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479136348-30706-1-git-send-email-michael@walle.cc>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, yangbo lu <yangbo.lu@freescale.com>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Michael Walle [mailto:michael@walle.cc]
> Sent: Monday, November 14, 2016 11:12 PM
> To: linux-kernel@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org; Ulf Hansson; Adrian Hunter; yangbo lu;
> Michael Walle
> Subject: [PATCH v3] mmc: sdhci-of-esdhc: fixup PRESENT_STATE read
>=20
> Since commit 87a18a6a5652 ("mmc: mmc: Use ->card_busy() to detect busy
> cards in __mmc_switch()") the ESDHC driver is broken:
>   mmc0: Card stuck in programming state! __mmc_switch
>   mmc0: error -110 whilst initialising MMC card
>=20
> Since this commit __mmc_switch() uses ->card_busy(), which is
> sdhci_card_busy() for the esdhc driver. sdhci_card_busy() uses the
> PRESENT_STATE register, specifically the DAT0 signal level bit. But the
> ESDHC uses a non-conformant PRESENT_STATE register, thus a read fixup is
> required to make the driver work again.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> Fixes: 87a18a6a5652 ("mmc: mmc: Use ->card_busy() to detect busy cards in
> __mmc_switch()")
> ---
> v3:
>  - explain the bits in the comments
>  - use bits[19:0] from the original value, all other will be taken from
> the
>    fixup value.
>=20
> v2:
>  - use lower bits of the original value (that was actually a typo)
>  - add fixes tag
>  - fix typo
>=20
>  drivers/mmc/host/sdhci-of-esdhc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-
> of-esdhc.c
> index fb71c86..74cf3b1 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -66,6 +66,19 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>  			return ret;
>  		}
>  	}
> +	/*
> +	 * The DAT[3:0] line signal levels and the CMD line signal level
> are
> +	 * not compatible with standard SDHC register. The line signal
> levels
> +	 * DAT[7:0] are at bits 31:24 and the line signal level is at bit
> 23.
> +	 * All other bits are the same as in the standard SDHC register.
> +	 */
> +	if (spec_reg =3D=3D SDHCI_PRESENT_STATE) {
> +		ret =3D value & 0x000fffff;
> +		ret |=3D (value >> 4) & SDHCI_DATA_LVL_MASK;
> +		ret |=3D (value << 1) & 0x01000000;
> +		return ret;
> +	}
> +

[Lu Yangbo-B47093] This is the proper fix.

Acked-by: Yangbo Lu <yangbo.lu@nxp.com>

>  	ret =3D value;
>  	return ret;
>  }
> --
> 2.1.4
