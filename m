From: "S, Venkatraman" <svenkatr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6] mmc: omap_hsmmc: Don't expect MMC1 to always have
	vmmc supply
Date: Wed, 8 Feb 2012 00:04:26 +0530
Message-ID: <CANfBPZ-jcgQM68NW=eHkhv_ny+4_2woNxnDtiAKw8OBRdnecqg@mail.gmail.com>
References: <1328367090-10402-1-git-send-email-rnayak@ti.com>
	<1328367090-10402-7-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1328367090-10402-7-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Sat, Feb 4, 2012 at 8:21 PM, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org> wrote:
> MMC1 is not the only instance that can be used/wired for SD.
> So remove this assumption from the driver.
>
> Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 14 --------------
> =A01 files changed, 0 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 17e264b..97d3065 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -300,7 +300,6 @@ static int omap_hsmmc_set_power(struct device *dev, i=
nt slot, int power_on,
> =A0static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
> =A0{
> =A0 =A0 =A0 =A0struct regulator *reg;
> - =A0 =A0 =A0 int ret =3D 0;
> =A0 =A0 =A0 =A0int ocr_value =3D 0;
>
> =A0 =A0 =A0 =A0mmc_slot(host).set_power =3D omap_hsmmc_set_power;
> @@ -308,15 +307,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host=
 *host)
> =A0 =A0 =A0 =A0reg =3D regulator_get(host->dev, "vmmc");
> =A0 =A0 =A0 =A0if (IS_ERR(reg)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(host->dev, "vmmc regulator missing=
\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 * HACK: until fixed.c regulator is usable,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 * we don't require a main regulator
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 * for MMC2 or MMC3
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->id =3D=3D OMAP_MMC1_DEVID) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(reg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->vcc =3D reg;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr_value =3D mmc_regulator_get_ocrmask(re=
g);
> @@ -358,10 +348,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host=
 *host)
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
> --

Almost all usage of the id field is gone, except for a trivial debug print.
Would be prudent to get rid of it entirely from struct omap_hsmmc_host.
