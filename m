From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-omap: Fix Tuning procedure for temperatures < -20C
Date: Fri, 18 Oct 2019 12:58:26 +0200
Message-ID: <CAPDyKFo=00NzUUs45bokScp2XUBRaEEvtr4PHWVSXk3x7zV3iQ@mail.gmail.com>
References: <20191010105230.16736-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191010105230.16736-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kishon <kishon@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 10 Oct 2019 at 12:51, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> According to the App note[1] detailing the tuning algorithm, for
> temperatures < -20C, the initial tuning value should be min(largest
> value in LPW - 24, ceil(13/16 ratio of LPW)). The largest value in
> LPW is (max_window + 4 * (max_len - 1)) and not (max_window + 4 * max_len)
> itself. Fix this implementation.
>
> [1] http://www.ti.com/lit/an/spraca9b/spraca9b.pdf
>
> Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 41c2677c587f..083e7e053c95 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -372,7 +372,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          * on temperature
>          */
>         if (temperature < -20000)
> -               phase_delay = min(max_window + 4 * max_len - 24,
> +               phase_delay = min(max_window + 4 * (max_len - 1) - 24,
>                                   max_window +
>                                   DIV_ROUND_UP(13 * max_len, 16) * 4);
>         else if (temperature < 20000)
> --
> 2.19.2
>
