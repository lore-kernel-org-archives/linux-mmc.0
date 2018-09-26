From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Allow building PWRSEQ_SD8787 with LIBERTAS_SDIO
Date: Thu, 27 Sep 2018 01:48:38 +0200
Message-ID: <CAPDyKFqOWu=uQWteB02bG2y3zCyQ2B1zGE+7nKyCn47O-30-hQ@mail.gmail.com>
References: <20180924085632.448693-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924085632.448693-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 24 September 2018 at 10:56, Lubomir Rintel <lkundrak@v3.sk> wrote:
> The sd8686 "libertas" SDIO adapter's power is controlled with WLAN_RST
> and WLAN_PD pins -- pretty much the same way as sd8787. Allow building
> the power sequencing driver along with the libertas Wi-Fi driver.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index 42e89060cd41..2f38a7ad07e0 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -14,7 +14,7 @@ config PWRSEQ_EMMC
>
>  config PWRSEQ_SD8787
>         tristate "HW reset support for SD8787 BT + Wifi module"
> -       depends on OF && (MWIFIEX || BT_MRVL_SDIO)
> +       depends on OF && (MWIFIEX || BT_MRVL_SDIO || LIBERTAS_SDIO)
>         help
>           This selects hardware reset support for the SD8787 BT + Wifi
>           module. By default this option is set to n.
> --
> 2.19.0
>
