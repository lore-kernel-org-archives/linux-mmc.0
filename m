From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3] mmc: dw_mmc: add hw_reset support
Date: Wed, 20 Jan 2016 13:24:01 +0900
Message-ID: <569F0BE1.50801@samsung.com>
References: <1452733682-3164-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1452733682-3164-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi, Shawn.

On 01/14/2016 10:08 AM, Shawn Lin wrote:
> This patch implement hw_reset function for DesignWare
> MMC controller. By adding this feature, mmc blk can
> do some basic recovery.
>=20
> Set the following resets:
> software reset =E2=80=93 BMOD[0] for IDMAC only
> DMA reset=E2=80=93 CTRL[2]
> FIFO reset =E2=80=93 CTRL[1] bits
>=20
> Program the CARD_RESET register with a value of 0 for the bit
> corresponding to the card number; This programming asserts the
> RST_n signal and resets the card. After a minimum of 1 =CE=BCs, de-as=
serts the
> RST_n signal and takes the card out of reset. The application can pro=
gram
> a new CMD only after a minimum of 200 us
>=20
> This implementation can be easily tested by cutting off->On vmmc
> while doing data accessing in background to simulate that case.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>=20
> ---
>=20
> Changes in v3:
> - reset for each slot
> - simply the commit msg
>=20
> Changes in v2:
> - remove unecessary mb
> - reduce time cost for hw_reset
> - combine SDMMC_CTRL_DMA_RESET and SDMMC_CTRL_FIFO_RESET
>=20
>  drivers/mmc/host/dw_mmc.c | 29 +++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.h |  3 +++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 7128351..fddbcb6 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1477,6 +1477,34 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>  	return present;
>  }
> =20
> +static void dw_mci_hw_reset(struct mmc_host *mmc)
> +{
> +	struct dw_mci_slot *slot =3D mmc_priv(mmc);
> +	struct dw_mci *host =3D slot->host;
> +	int reset;
> +
> +	if (host->use_dma =3D=3D TRANS_MODE_IDMAC)
> +		dw_mci_idmac_reset(host);
> +
> +	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_DMA_RESET |
> +				     SDMMC_CTRL_FIFO_RESET))
> +		return;
> +
> +	/*
> +	 * According to eMMC spec, card reset procedure:
> +	 * tRstW >=3D 1us:   RST_n pulse width
> +	 * tRSCA >=3D 200us: RST_n to Command time
> +	 * tRSTH >=3D 1us:   RST_n high period
> +	 */
> +	reset =3D mci_readl(host, RST_N);
> +	reset &=3D ~(SDMMC_RST_HWACTIVE << slot->id);
> +	mci_writel(slot->host, RST_N, reset);

I will pick this patch, after change "host" instead of "slot->host".=20
(I will change it when i apply this.)

Thanks!

Best Regards,
Jaehoon Chung

> +	usleep_range(1, 2);
> +	reset |=3D SDMMC_RST_HWACTIVE << slot->id;
> +	mci_writel(slot->host, RST_N, reset);
> +	usleep_range(200, 300);
> +}
> +
>  static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *=
card)
>  {
>  	struct dw_mci_slot *slot =3D mmc_priv(mmc);
> @@ -1563,6 +1591,7 @@ static const struct mmc_host_ops dw_mci_ops =3D=
 {
>  	.set_ios		=3D dw_mci_set_ios,
>  	.get_ro			=3D dw_mci_get_ro,
>  	.get_cd			=3D dw_mci_get_cd,
> +	.hw_reset               =3D dw_mci_hw_reset,
>  	.enable_sdio_irq	=3D dw_mci_enable_sdio_irq,
>  	.execute_tuning		=3D dw_mci_execute_tuning,
>  	.card_busy		=3D dw_mci_card_busy,
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index f695b58..a14b7fc 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -46,6 +46,7 @@
>  #define SDMMC_VERID		0x06c
>  #define SDMMC_HCON		0x070
>  #define SDMMC_UHS_REG		0x074
> +#define SDMMC_RST_N		0x078
>  #define SDMMC_BMOD		0x080
>  #define SDMMC_PLDMND		0x084
>  #define SDMMC_DBADDR		0x088
> @@ -169,6 +170,8 @@
>  #define SDMMC_IDMAC_ENABLE		BIT(7)
>  #define SDMMC_IDMAC_FB			BIT(1)
>  #define SDMMC_IDMAC_SWRESET		BIT(0)
> +/* H/W reset */
> +#define SDMMC_RST_HWACTIVE		0x1
>  /* Version ID register define */
>  #define SDMMC_GET_VERID(x)		((x) & 0xFFFF)
>  /* Card read threshold */
>=20
