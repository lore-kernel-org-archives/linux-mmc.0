From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH V2 11/16] mmc: omap_hsmmc: ensure pbias configuration is
 always done
Date: Thu, 29 Sep 2011 19:10:30 +0530
Message-ID: <CANrkHUYp-6a+qBZLk7SL9zHoy0wKuoYYYVEo0yb5=qzzicGepQ@mail.gmail.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
	<1304673255-31634-12-git-send-email-adrian.hunter@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:56023 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754585Ab1I2Nkd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Sep 2011 09:40:33 -0400
In-Reply-To: <1304673255-31634-12-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>

On Fri, May 6, 2011 at 2:44 PM, Adrian Hunter <adrian.hunter@nokia.com>=
 wrote:
> Go through the driver's set_power() functions rather than
> calling regulator_enable/disable() directly because otherwise
> pbias configuration for MMC1 is not done.
Hi Chris,

Are you OK to queue this patch as bug fix. Rest of the patches of this
series is either
merged or not needed. Should I rebase and repost this alone ?

=46WIW:
Acked-by: Balaji T K <balajitk@ti.com>

>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 17 ++++++++---------
> =A01 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 4f6e552..8aa9440 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -445,15 +445,14 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc=
_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* framework is fixed, we need a workar=
ound like this
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (which is safe for MMC, but not in g=
eneral).
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (regulator_is_enabled(host->vcc) > 0=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_enable(host->=
vcc);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_disable(host-=
>vcc);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->vcc_aux) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (regulator_is_enable=
d(reg) > 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulat=
or_enable(reg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulat=
or_disable(reg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (regulator_is_enabled(host->vcc) > 0=
 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->vcc_aux && regulator_is_=
enabled(host->vcc_aux))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int vdd =3D ffs(mmc_slo=
t(host).ocr_mask) - 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_slot(host).set_powe=
r(host->dev, host->slot_id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A01, vdd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_slot(host).set_powe=
r(host->dev, host->slot_id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A00, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
