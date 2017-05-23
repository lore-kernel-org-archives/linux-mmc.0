From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [RFT PATCH] mmc: tmio: make sure SDIO gets reinitialized after
 resume
Date: Tue, 23 May 2017 12:15:05 +0000
Message-ID: <TY1PR06MB0992573FB717D7C90373F1FDD8F90@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <20170519123052.26565-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170519123052.26565-1-wsa+renesas@sang-engineering.com>
Content-Language: ja-JP
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Yasushi SHOJI <yashi@atmark-techno.com>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram-san,

> From: Wolfram Sang
> Sent: Friday, May 19, 2017 9:31 PM
>=20
> To achieve that, we set the registers in the generic HW reset routine
> which gets called at both, init and resume. We also make sure to move
> SDIO initialization before reset gets called in probe().
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> This patch addresses a report I got from Shimoda-san. I can't really test=
 it
> because the SDIO cards I have all require MMC_PM_KEEP_POWER to suspend an=
d
> that we don't support. So, I send this out to ask for testing. At least i=
t
> didn't cause regressions for the setup I used. To make testing easier, th=
is
> is *not* put on top of Simon's SDHI DMA rework patches, so it should appl=
y
> on current upstream and development branches.

Thank you for the patch!
Hayakawa-san tested this patch on both H3/Salvator-X and E2/ALT.

So,
Tested-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

Best regards,
Yoshihiro Shimoda

>  drivers/mmc/host/tmio_mmc_pio.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_=
pio.c
> index a2d92f10501bdd..5e87fcaa99d430 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -229,6 +229,12 @@ static void tmio_mmc_reset(struct tmio_mmc_host *hos=
t)
>  	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
>  		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
>  	msleep(10);
> +
> +	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
> +		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
> +		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
> +	}
> +
>  }
>=20
>  static void tmio_mmc_reset_work(struct work_struct *work)
> @@ -1221,6 +1227,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_hos=
t,
>  	if (_host->native_hotplug)
>  		pm_runtime_get_noresume(&pdev->dev);
>=20
> +	_host->sdio_irq_enabled =3D false;
> +	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
> +		_host->sdio_irq_mask =3D TMIO_SDIO_MASK_ALL;
> +
>  	tmio_mmc_clk_stop(_host);
>  	tmio_mmc_reset(_host);
>=20
> @@ -1237,13 +1247,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_hos=
t,
>=20
>  	_host->sdcard_irq_mask &=3D ~irq_mask;
>=20
> -	_host->sdio_irq_enabled =3D false;
> -	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
> -		_host->sdio_irq_mask =3D TMIO_SDIO_MASK_ALL;
> -		sd_ctrl_write16(_host, CTL_SDIO_IRQ_MASK, _host->sdio_irq_mask);
> -		sd_ctrl_write16(_host, CTL_TRANSACTION_CTL, 0x0001);
> -	}
> -
>  	spin_lock_init(&_host->lock);
>  	mutex_init(&_host->ios_lock);
>=20
> --
> 2.11.0
