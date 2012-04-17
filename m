From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Fix check for mmc dt node
Date: Tue, 17 Apr 2012 15:41:44 +0530
Message-ID: <CANrkHUa9yNye7b12=VEFPsMg7JdQnE6BvE_7sW+1PfgyWFH+mw@mail.gmail.com>
References: <1334656449-12142-1-git-send-email-jaswinder.singh@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:41530 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932116Ab2DQKLr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Apr 2012 06:11:47 -0400
Received: by lbbgf7 with SMTP id gf7so9685694lbb.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Apr 2012 03:11:44 -0700 (PDT)
In-Reply-To: <1334656449-12142-1-git-send-email-jaswinder.singh@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, cjb@laptop.org

On Tue, Apr 17, 2012 at 3:24 PM, Jassi Brar <jaswinder.singh@linaro.org=
> wrote:
> Proper check should be if the hsmmc driver got its platform_data
> via devicetree, and not if the devicetree is populated for the
> platform.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>

Hi,
Similar patch by Rajendra is in mmc-next

http://git.kernel.org/?p=3Dlinux/kernel/git/cjb/mmc.git;a=3Dcommit;h=3D=
3d9bc09d825f72ef119a94615e0de6baea86981f

> ---
>
> The patch is more than a nit-pick because upstream doesn't yet have d=
t
> nodes for mmc on OMAP while the driver wrongly assumes it does.
> Which isn't a problem until you use some low-end sdhc card
> (Transcend 8GB Class-4 in my experience) which fails to re-initialize=
,
> OCR[30] set, if the first attempt fails due to delay at certain times
> during the probe (for ex, simply enable CONFIG_REGULATOR_DUMMY).
> Apparently such cards need proper 0v->1.8v power cycle to recover
> (another Class-10 card does recover after ~10 attempts by the host).
>

Is this issue seen while booting with device tree or non device tree ?

> While this simple patch gets us through the problem, it also tells
> that adding mmc dt nodes without PBIAS setup callbacks in place
> (without which we can't switch off the regulator or do 1.8v -> 3.3v
> switch) is probably not a safe option.
>
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A06 ++++--
> =A01 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index c628b95..b5ca4593 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -138,6 +138,7 @@ struct omap_hsmmc_next {
>
> =A0struct omap_hsmmc_host {
> =A0 =A0 =A0 =A0struct =A0device =A0 =A0 =A0 =A0 =A0*dev;
> + =A0 =A0 =A0 struct =A0of_device_id =A0 =A0*of_dev;
> =A0 =A0 =A0 =A0struct =A0mmc_host =A0 =A0 =A0 =A0*mmc;
> =A0 =A0 =A0 =A0struct =A0mmc_request =A0 =A0 *mrq;
> =A0 =A0 =A0 =A0struct =A0mmc_command =A0 =A0 *cmd;
> @@ -249,7 +250,7 @@ static int omap_hsmmc_set_power(struct device *de=
v, int slot, int power_on,
> =A0 =A0 =A0 =A0 * the pbias cell programming support is still missing=
 when
> =A0 =A0 =A0 =A0 * booting with Device tree
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (of_have_populated_dt() && !vdd)
> + =A0 =A0 =A0 if (host->of_dev && !vdd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0if (mmc_slot(host).before_set_reg)
> @@ -1550,7 +1551,7 @@ static void omap_hsmmc_set_ios(struct mmc_host =
*mmc, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * can't be allowed wh=
en booting with device
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * tree.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!of_have_populated_dt(=
))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !host->of_dev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * The=
 mmc_select_voltage fn of the core does
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * not=
 seem to set the power_mode to
> @@ -1837,6 +1838,7 @@ static int __devinit omap_hsmmc_probe(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0host =A0 =A0 =A0 =A0 =A0 =A0=3D mmc_priv(mmc);
> =A0 =A0 =A0 =A0host->mmc =A0 =A0 =A0 =3D mmc;
> =A0 =A0 =A0 =A0host->pdata =A0 =A0 =3D pdata;
> + =A0 =A0 =A0 host->of_dev =A0 =A0=3D match;
> =A0 =A0 =A0 =A0host->dev =A0 =A0 =A0 =3D &pdev->dev;
> =A0 =A0 =A0 =A0host->use_dma =A0 =3D 1;
> =A0 =A0 =A0 =A0host->dev->dma_mask =3D &pdata->dma_mask;
> --
> 1.7.4.1
>
