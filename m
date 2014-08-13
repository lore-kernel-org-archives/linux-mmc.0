From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Remove architecture dependency
Date: Thu, 14 Aug 2014 03:51:43 +0530
Message-ID: <CAGOxZ51_cr_j5vWrNO_ZnfAQsvt8zfEjQZC2f-nWv4w9b5R1kQ@mail.gmail.com>
References: <1407951153-918-1-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407951153-918-1-git-send-email-abrestic@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Doug Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Andrew,

On Wed, Aug 13, 2014 at 11:02 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> The dw_mmc host may also be present on non-ARC/ARM SoCs (e.g. MIPS)
> and the driver itself does not appear to depend on any particular
> architecture(s).
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  drivers/mmc/host/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index a565254..15b110a 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -563,7 +563,6 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
>
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
> -       depends on ARC || ARM

I am not sure if just removing _depends_ is good vs adding another
architecture(s) dependency here.
There are n number of places in Kconfig where this _depends_ runs up
to well over 10 entries.
What about config like MMC_DW_EXYNOS and MMC_DW_K3 which depends on
MMC_DW? Is it ok to expose them as well for architectures which might
not contains these variants?

One way I found this useful, one need not worry about finding MMC_DW
in there arch default menu-config, this will just appear, go and
select it.

Lets see what others think about this.

>         help
>           This selects support for the Synopsys DesignWare Mobile Storage IP
>           block, this provides host support for SD and MMC interfaces, in both
> --
> 2.1.0.rc2.206.gedb03e5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
