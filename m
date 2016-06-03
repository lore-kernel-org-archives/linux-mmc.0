From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: properly document R-Car versions
Date: Fri, 3 Jun 2016 10:32:47 +0200
Message-ID: <CAPDyKFrs9RaRAp8n7QWx+dtK3sAJZG4Xckxueip=-qXbJc3kpQ@mail.gmail.com>
References: <1462970760-3471-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462970760-3471-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 11 May 2016 at 14:46, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Replace hardcoded values with meaningful names and document what we
> know.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index f750f9494410b0..c3b651bf89cb4a 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -39,6 +39,12 @@
>
>  #define EXT_ACC           0xe4
>
> +#define SDHI_VER_GEN2_SDR50    0x490c
> +/* very old datasheets said 0x490c for SDR104, too. They are wrong! */
> +#define SDHI_VER_GEN2_SDR104   0xcb0d
> +#define SDHI_VER_GEN3_SD       0xcc10
> +#define SDHI_VER_GEN3_SDMMC    0xcd10
> +
>  #define host_to_priv(host) container_of((host)->pdata, struct sh_mobile_sdhi, mmc_data)
>
>  struct sh_mobile_sdhi_of_data {
> @@ -109,14 +115,14 @@ static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
>          *      sh_mobile_sdhi_of_data :: dma_buswidth
>          */
>         switch (sd_ctrl_read16(host, CTL_VERSION)) {
> -       case 0x490C:
> +       case SDHI_VER_GEN2_SDR50:
>                 val = (width == 32) ? 0x0001 : 0x0000;
>                 break;
> -       case 0xCB0D:
> +       case SDHI_VER_GEN2_SDR104:
>                 val = (width == 32) ? 0x0000 : 0x0001;
>                 break;
> -       case 0xCC10: /* Gen3, SD only */
> -       case 0xCD10: /* Gen3, SD + MMC */
> +       case SDHI_VER_GEN3_SD:
> +       case SDHI_VER_GEN3_SDMMC:
>                 if (width == 64)
>                         val = 0x0000;
>                 else if (width == 32)
> --
> 2.8.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
