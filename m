From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2 6/6] mmc: omap_hsmmc: Don't expect MMC1 to always have
 vmmc supply
Date: Tue, 21 Feb 2012 17:43:54 +0530
Message-ID: <CANfBPZ89Wdu2hWRU2XiPpWpU-BMbs3Z+yhNoR7hp4MH3vRYfbg@mail.gmail.com>
References: <1329818589-10062-1-git-send-email-rnayak@ti.com> <1329818589-10062-7-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:38849 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755163Ab2BUMOR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Feb 2012 07:14:17 -0500
In-Reply-To: <1329818589-10062-7-git-send-email-rnayak@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, balajitk@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On Tue, Feb 21, 2012 at 3:33 PM, Rajendra Nayak <rnayak@ti.com> wrote:
>
> MMC1 is not the only instance that can be used/wired for SD.
> So remove this assumption from the driver.
>
> Now that all the mmc id based usage is removed, get rid
> of all the DEVID defines and also the 'id' field from the
> omap_hsmmc_host structure.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Tested-by: Venkatraman S <svenkatr@ti.com>
> Tested-by: Balaji T K <balajitk@ti.com>

=46or the whole series,
Acked-by: Venkatraman S <svenkatr@ti.com>

> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 31 ++-------------------------=
----
> =A01 files changed, 2 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 17e264b..e3eb9d4 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -106,17 +106,6 @@
> =A0#define SOFTRESET =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
> =A0#define RESETDONE =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>
> -/*
> - * FIXME: Most likely all the data using these _DEVID defines should=
 come
> - * from the platform_data, or implemented in controller and slot spe=
cific
> - * functions.
> - */
> -#define OMAP_MMC1_DEVID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
> -#define OMAP_MMC2_DEVID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> -#define OMAP_MMC3_DEVID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
> -#define OMAP_MMC4_DEVID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03
> -#define OMAP_MMC5_DEVID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04
> -
> =A0#define MMC_AUTOSUSPEND_DELAY =A0100
> =A0#define MMC_TIMEOUT_MS =A0 =A0 =A0 =A0 20
> =A0#define OMAP_MMC_MIN_CLOCK =A0 =A0 400000
> @@ -164,7 +153,6 @@ struct omap_hsmmc_host {
> =A0 =A0 =A0 =A0void =A0 =A0__iomem =A0 =A0 =A0 =A0 *base;
> =A0 =A0 =A0 =A0resource_size_t =A0 =A0 =A0 =A0 mapbase;
> =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_lock; /* Pre=
vent races with irq handler
> */
> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0id;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0dma_len;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0dma_sg_idx;
> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 bus_mode;
> @@ -300,7 +288,6 @@ static int omap_hsmmc_set_power(struct device *de=
v,
> int slot, int power_on,
> =A0static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
> =A0{
> =A0 =A0 =A0 =A0struct regulator *reg;
> - =A0 =A0 =A0 int ret =3D 0;
> =A0 =A0 =A0 =A0int ocr_value =3D 0;
>
> =A0 =A0 =A0 =A0mmc_slot(host).set_power =3D omap_hsmmc_set_power;
> @@ -308,15 +295,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_=
host
> *host)
> =A0 =A0 =A0 =A0reg =3D regulator_get(host->dev, "vmmc");
> =A0 =A0 =A0 =A0if (IS_ERR(reg)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(host->dev, "vmmc regulator mis=
sing\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 * HACK: until fixed.c regulator is usab=
le,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 * we don't require a main regulator
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 * for MMC2 or MMC3
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->id =3D=3D OMAP_MMC1_DEVID) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(reg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->vcc =3D reg;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr_value =3D mmc_regulator_get_ocrmas=
k(reg);
> @@ -324,8 +302,8 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_h=
ost
> *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_slot(host).ocr_mas=
k =3D ocr_value;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(mmc_slot(host).o=
cr_mask & ocr_value)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"MMC%d ocrmask %x is not
> supported\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 host->id,
> mmc_slot(host).ocr_mask);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"MMC ocrmask %x is not
> supported\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_slot(host).ocr_mask);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_sl=
ot(host).ocr_mask =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -358,10 +336,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_=
host
> *host)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> -
> -err:
> - =A0 =A0 =A0 mmc_slot(host).set_power =3D NULL;
> - =A0 =A0 =A0 return ret;
> =A0}
>
> =A0static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
> @@ -1791,7 +1765,6 @@ static int __init omap_hsmmc_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0host->dev->dma_mask =3D &pdata->dma_mask;
> =A0 =A0 =A0 =A0host->dma_ch =A0 =A0=3D -1;
> =A0 =A0 =A0 =A0host->irq =A0 =A0 =A0 =3D irq;
> - =A0 =A0 =A0 host->id =A0 =A0 =A0 =A0=3D pdev->id;
> =A0 =A0 =A0 =A0host->slot_id =A0 =3D 0;
> =A0 =A0 =A0 =A0host->mapbase =A0 =3D res->start;
> =A0 =A0 =A0 =A0host->base =A0 =A0 =A0=3D ioremap(host->mapbase, SZ_4K=
);
> --
> 1.7.1
>
