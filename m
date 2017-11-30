From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: renesas_sdhi: enable R-Car D3 (r8a77995) support
Date: Thu, 30 Nov 2017 14:09:38 +0100
Message-ID: <CAPDyKFrxgrp5wt82AtW9YtzwRn0+fO2Db4T=-Bu0OT2-zOkVYA@mail.gmail.com>
References: <1511971606-580-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1511971606-580-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1511971606-580-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 29 November 2017 at 17:06, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Whitelists for internal DMAC implementation.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 41cbe84..396ae8a 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -255,6 +255,7 @@ static const struct soc_device_attribute gen3_soc_whitelist[] = {
>          { .soc_id = "r8a7795", .revision = "ES1.*" },
>          { .soc_id = "r8a7795", .revision = "ES2.0" },
>          { .soc_id = "r8a7796", .revision = "ES1.0" },
> +        { .soc_id = "r8a77995", .revision = "ES1.0" },
>          { /* sentinel */ }
>  };
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
