From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix quirk2 overwrite
Date: Thu, 14 Nov 2019 15:00:07 +0100
Message-ID: <CAPDyKFrrzNXxYywPW8cAZN86jBPoOFWt295o9ANm+0BrF4dehg@mail.gmail.com>
References: <1573736352-3597-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573736352-3597-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen.Hristev@microchip.com
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ludovic Desroches <Ludovic.Desroches@microchip.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 14 Nov 2019 at 13:59, <Eugen.Hristev@microchip.com> wrote:
>
> From: Eugen Hristev <eugen.hristev@microchip.com>
>
> The quirks2 are parsed and set (e.g. from DT) before the quirk for broken
> HS200 is set in the driver.
> The driver needs to enable just this flag, not rewrite the whole quirk set.
>
> Fixes: 7871aa60ae00 ("mmc: sdhci-of-at91: add quirk for broken HS200")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Applied for fixes, adding a stable tag, thanks!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-of-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 496844a..5fe6684 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -389,7 +389,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>         pm_runtime_use_autosuspend(&pdev->dev);
>
>         /* HS200 is broken at this moment */
> -       host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
> +       host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>
>         ret = sdhci_add_host(host);
>         if (ret)
> --
> 2.7.4
>
