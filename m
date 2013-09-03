From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 4/4] mmc: mmci: Save and restore register context
Date: Tue, 03 Sep 2013 11:53:02 +0200
Message-ID: <5225B17E.8090908@linaro.org>
References: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org> <1378200576-13413-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:39948 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817Ab3ICJxH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 05:53:07 -0400
Received: by mail-bk0-f53.google.com with SMTP id d7so1950086bkh.26
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 02:53:05 -0700 (PDT)
In-Reply-To: <1378200576-13413-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>

On 09/03/2013 11:29 AM, Ulf Hansson wrote:
> If a corresponding power domain exists for the device and it manages
> to cut the domain regulator while the device is runtime suspended,
> the IP loses it's registers context. We restore the context in the
> .runtime_resume callback from the existing register caches to adapt
> to this siutuation.
>=20
> We also want to make sure the registers are in a known state while
> restoring context in the case when the power domain did not drop the
> power, since there are restrictions for the order of writing to these
> registers. To handle this, we clear the registers in the
> .runtime_suspend callback.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>



>  drivers/mmc/host/mmci.c |   43 +++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 82afcd3..97e541b 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -62,6 +62,7 @@ static unsigned int fmax =3D 515633;
>   * @signal_direction: input/out direction of bus signals can be indi=
cated
>   * @pwrreg_clkgate: MMCIPOWER register must be used to gate the cloc=
k
>   * @busy_detect: true if busy detection on dat0 is supported
> + * @pwrreg_nopower: bits in MMCIPOWER don't controls ext. power supp=
ly
>   */
>  struct variant_data {
>  	unsigned int		clkreg;
> @@ -76,6 +77,7 @@ struct variant_data {
>  	bool			signal_direction;
>  	bool			pwrreg_clkgate;
>  	bool			busy_detect;
> +	bool			pwrreg_nopower;
>  };
> =20
>  static struct variant_data variant_arm =3D {
> @@ -109,6 +111,7 @@ static struct variant_data variant_u300 =3D {
>  	.pwrreg_powerup		=3D MCI_PWR_ON,
>  	.signal_direction	=3D true,
>  	.pwrreg_clkgate		=3D true,
> +	.pwrreg_nopower		=3D true,
>  };
> =20
>  static struct variant_data variant_nomadik =3D {
> @@ -121,6 +124,7 @@ static struct variant_data variant_nomadik =3D {
>  	.pwrreg_powerup		=3D MCI_PWR_ON,
>  	.signal_direction	=3D true,
>  	.pwrreg_clkgate		=3D true,
> +	.pwrreg_nopower		=3D true,
>  };
> =20
>  static struct variant_data variant_ux500 =3D {
> @@ -135,6 +139,7 @@ static struct variant_data variant_ux500 =3D {
>  	.signal_direction	=3D true,
>  	.pwrreg_clkgate		=3D true,
>  	.busy_detect		=3D true,
> +	.pwrreg_nopower		=3D true,
>  };
> =20
>  static struct variant_data variant_ux500v2 =3D {
> @@ -150,6 +155,7 @@ static struct variant_data variant_ux500v2 =3D {
>  	.signal_direction	=3D true,
>  	.pwrreg_clkgate		=3D true,
>  	.busy_detect		=3D true,
> +	.pwrreg_nopower		=3D true,
>  };
> =20
>  static int mmci_card_busy(struct mmc_host *mmc)
> @@ -1759,6 +1765,41 @@ static int mmci_resume(struct device *dev)
>  #endif
> =20
>  #ifdef CONFIG_PM_RUNTIME
> +static void mmci_save(struct mmci_host *host)
> +{
> +	unsigned long flags;
> +
> +	if (host->variant->pwrreg_nopower) {
> +		spin_lock_irqsave(&host->lock, flags);
> +
> +		writel(0, host->base + MMCIMASK0);
> +		writel(0, host->base + MMCIDATACTRL);
> +		writel(0, host->base + MMCIPOWER);
> +		writel(0, host->base + MMCICLOCK);
> +		mmci_reg_delay(host);
> +
> +		spin_unlock_irqrestore(&host->lock, flags);
> +	}
> +
> +}
> +
> +static void mmci_restore(struct mmci_host *host)
> +{
> +	unsigned long flags;
> +
> +	if (host->variant->pwrreg_nopower) {
> +		spin_lock_irqsave(&host->lock, flags);
> +
> +		writel(host->clk_reg, host->base + MMCICLOCK);
> +		writel(host->datactrl_reg, host->base + MMCIDATACTRL);
> +		writel(host->pwr_reg, host->base + MMCIPOWER);
> +		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
> +		mmci_reg_delay(host);
> +
> +		spin_unlock_irqrestore(&host->lock, flags);
> +	}
> +}
> +
>  static int mmci_runtime_suspend(struct device *dev)
>  {
>  	struct amba_device *adev =3D to_amba_device(dev);
> @@ -1767,6 +1808,7 @@ static int mmci_runtime_suspend(struct device *=
dev)
>  	if (mmc) {
>  		struct mmci_host *host =3D mmc_priv(mmc);
>  		pinctrl_pm_select_sleep_state(dev);
> +		mmci_save(host);
>  		clk_disable_unprepare(host->clk);
>  	}
> =20
> @@ -1781,6 +1823,7 @@ static int mmci_runtime_resume(struct device *d=
ev)
>  	if (mmc) {
>  		struct mmci_host *host =3D mmc_priv(mmc);
>  		clk_prepare_enable(host->clk);
> +		mmci_restore(host);
>  		pinctrl_pm_select_default_state(dev);
>  	}
> =20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

