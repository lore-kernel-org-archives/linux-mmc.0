From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Don't send clock off command if power is off
Date: Sun, 22 Mar 2015 17:46:46 +0530
Message-ID: <CAGOxZ52OWucMh_HjWnZnhN=c7C3TXeQ4aV-GAe5XXtRbu0r2Kg@mail.gmail.com>
References: <1426874420-25103-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:35240 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbbCVMR1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Mar 2015 08:17:27 -0400
In-Reply-To: <1426874420-25103-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Doug,

On Fri, Mar 20, 2015 at 11:30 PM, Doug Anderson <dianders@chromium.org> wrote:
> We've already seen that it causes failures if we try to send the
> "SDMMC_CMD_UPD_CLK" command when power is off to the system.  Here's
> another case where we were doing it: we were sending an
> SDMMC_CMD_UPD_CLK to set the clock to 0 when the card was already
> powered off and the clock was already at 0.  Let's avoid that command
> and avoid problems.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 47dfd0e..aeec698 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1172,8 +1172,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>                 break;
>         case MMC_POWER_OFF:
> -               /* Turn clock off before power goes down */
> -               dw_mci_setup_bus(slot, false);
> +               /* Turn clock off before power goes down; only if powered */
> +               if (slot->host->vqmmc_enabled)
> +                       dw_mci_setup_bus(slot, false);
>
vqmmc_enabled is always _true_ when entering MMC_POWER_OFF case..right?
Is this done for extra protection? Or do you have a case where vqmmc
is OFF and driver still calls dw_mci_setup_bus from here?

>                 if (!IS_ERR(mmc->supply.vmmc))
>                         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
