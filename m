From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [MXS MMC 5/5] Add an appropriate MODULE_ALIAS
Date: Wed, 7 Dec 2011 20:34:16 +0800
Message-ID: <20111207123415.GO5550@S2100-06.ap.freescale.net>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <b1c45bfdbc9323b2a6c50ce213a3e895aeea2b2f.1323177907.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b1c45bfdbc9323b2a6c50ce213a3e895aeea2b2f.1323177907.git.LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Dec 06, 2011 at 02:41:30PM +0100, Lothar Wa=DFmann wrote:
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> ---
>  drivers/mmc/host/mxs-mmc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 0003d03..1ba08ae 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -886,3 +886,4 @@ module_exit(mxs_mmc_exit);
>  MODULE_DESCRIPTION("FREESCALE MXS MMC peripheral");
>  MODULE_AUTHOR("Freescale Semiconductor");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:mxs-mmc");

Acked-by: Shawn Guo <shawn.guo@linaro.org>

--=20
Regards,
Shawn
