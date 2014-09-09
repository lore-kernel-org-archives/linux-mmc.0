From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: add support for ARM64
Date: Tue, 9 Sep 2014 08:51:48 +0200
Message-ID: <CAPDyKFqk1pwGFuitE0Fk1pqyP_FZiQK1=5OtGUM9Zw6Mp_rWXw@mail.gmail.com>
References: <1409307891-16523-1-git-send-email-alim.akhtar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409307891-16523-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Bresticker <abrestic@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 29 August 2014 12:24, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> There are upcoming ARM64 SoCs with dw_mmc host controller.
>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index a43295c..72dd6c2 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -580,7 +580,7 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
>         depends on HAS_DMA
> -       depends on ARC || ARM || MIPS || COMPILE_TEST
> +       depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST

Before enabling this, wouldn't it be better to add the needed support
in dw_mmc first? Or there are no changes needed?

There are also ongoing development and discussions for exynos7, which
I guess relates to this?
http://www.spinics.net/lists/linux-mmc/msg28294.html

Kind regards
Uffe
