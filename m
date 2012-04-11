From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Get rid of of_have_populated_dt() usage
Date: Wed, 11 Apr 2012 19:35:02 +0530
Message-ID: <CANrkHUb2qu-f-MtfPhedFib7fJ+NxNvdKwBxObfGRoypxh0pkA@mail.gmail.com>
References: <1334138593-9692-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1334138593-9692-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: cjb@laptop.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, Rob Herring <rob.herring@calxeda.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 11, 2012 at 3:33 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> of_have_populated_dt() is not expected to be used in drivers but
> instead only in early platform init code.
> Drivers on the other hand should rely on dev->of_node or of_match_dev=
ice().
> Besides usage of of_have_populated_dt() also throws up build error as=
 below
> which was reported by Balaji TK, when omap_hsmmc is built as a module=
=2E
>
> ERROR: "allnodes" [drivers/mmc/host/omap_hsmmc.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
>
> So get rid of all of_have_populated_dt() usage in omap_hsmmc driver a=
nd
> instead use dev->of_node to make the same dicisions as earlier.

Looks good to me
Reviewed-by: Balaji T K <balajitk@ti.com>

>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Reported-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Balaji TK <balajitk@ti.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index ecc9521..4254b6f 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -252,7 +252,7 @@ static int omap_hsmmc_set_power(struct device *de=
v, int slot, int power_on,
> =A0 =A0 =A0 =A0 * the pbias cell programming support is still missing=
 when
> =A0 =A0 =A0 =A0 * booting with Device tree
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (of_have_populated_dt() && !vdd)
> + =A0 =A0 =A0 if (dev->of_node && !vdd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0if (mmc_slot(host).before_set_reg)
> @@ -1564,7 +1564,7 @@ static void omap_hsmmc_set_ios(struct mmc_host =
*mmc, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * can't be allowed wh=
en booting with device
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * tree.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!of_have_populated_dt(=
))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !host->dev->of_node) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * The=
 mmc_select_voltage fn of the core does
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * not=
 seem to set the power_mode to
> --
> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
