From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v3 4/5] OMAP: hwmod data: Add dev_attr and use in the host driver
Date: Thu, 24 Feb 2011 11:30:04 +0530
Message-ID: <AANLkTimOpry8DrY19cYEoRo=WcFfzLyHHoAT_59Z5nFv@mail.gmail.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com> <1298483231-29622-5-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1298483231-29622-5-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-mmc@vger.kernel.org

Kishore,

On Wed, Feb 23, 2011 at 23:17, Kishore Kadiyala <kishore.kadiyala@ti.co=
m> wrote:
> Add a device attribute to hwmod data of omap2430, omap3, omap4.
> Currently the device attribute holds information regarding dual volt =
MMC card
> support by the controller which will be later passed to the host driv=
er via
> platform data.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0 =A09 +++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 12 ++++++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 16 ++++++++++++++=
++
> =A0arch/arm/plat-omap/include/plat/mmc.h =A0 =A0 =A0| =A0 10 ++++++++=
++
> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
4 ++--
> =A05 files changed, 49 insertions(+), 2 deletions(-)
>

<<snip>>

>
> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-om=
ap/include/plat/mmc.h
> index e5de5d4..7853130 100644
> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -43,6 +43,13 @@
>
> =A0#define OMAP_MMC_MAX_SLOTS =A0 =A0 2
>
> +/* omap_hwmod integration data */

What is omap_hwmod integration data ? Pls clarify.

> +#define OMAP_HSMMC_SUPPORTS_DUAL_VOLT =A0BIT(1)
> +
> +struct mmc_dev_attr {
> + =A0 =A0 =A0 u8 flags;
> +};
> +
> =A0struct omap_mmc_platform_data {
> =A0 =A0 =A0 =A0/* back-link to device */
> =A0 =A0 =A0 =A0struct device *dev;
> @@ -71,6 +78,9 @@ struct omap_mmc_platform_data {
>
> =A0 =A0 =A0 =A0u64 dma_mask;
>
> + =A0 =A0 =A0 /* Integrating attributes from the omap_hwmod layer */
> + =A0 =A0 =A0 u8 controller_dev_attr;
> +
> =A0 =A0 =A0 =A0/* Register offset deviation */
> =A0 =A0 =A0 =A0u16 reg_offset;
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 078fdf1..160cc95 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1555,7 +1555,7 @@ static void omap_hsmmc_set_ios(struct mmc_host =
*mmc, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (host->id =3D=3D OMAP_MMC1_DEVID) {
> + =A0 =A0 =A0 if (host->pdata->controller_dev_attr & OMAP_HSMMC_SUPPO=
RTS_DUAL_VOLT) {

Where is pdata->controller_dev_attr getting populated? I don't see the
dev_attr from the
hwmod database used anywhere in this patch.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Only MMC1 can interface at 3V witho=
ut some flavor
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * of external transceiver; but they a=
ll handle 1.8V.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> @@ -1647,7 +1647,7 @@ static void omap_hsmmc_conf_bus_power(struct om=
ap_hsmmc_host *host)
> =A0 =A0 =A0 =A0u32 hctl, capa, value;
>
> =A0 =A0 =A0 =A0/* Only MMC1 supports 3.0V */
> - =A0 =A0 =A0 if (host->id =3D=3D OMAP_MMC1_DEVID) {
> + =A0 =A0 =A0 if (host->pdata->controller_dev_attr & OMAP_HSMMC_SUPPO=
RTS_DUAL_VOLT) {

Ditto.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hctl =3D SDVS30;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0capa =3D VS30 | VS18;
> =A0 =A0 =A0 =A0} else {
> --
> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
