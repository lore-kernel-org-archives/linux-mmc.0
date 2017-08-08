From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sunxi: fix support for new timings mode only SoCs
Date: Tue, 8 Aug 2017 12:37:37 +0200
Message-ID: <CAPDyKFoddXKr19FZWs0ybxhDvEUnp357r3QEBJBEhDani3HR2A@mail.gmail.com>
References: <20170808070903.16898-1-icenowy@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35745 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdHHKhj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2017 06:37:39 -0400
Received: by mail-qt0-f175.google.com with SMTP id p3so17330710qtg.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2017 03:37:38 -0700 (PDT)
In-Reply-To: <20170808070903.16898-1-icenowy@aosc.io>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

On 8 August 2017 at 09:09, Icenowy Zheng <icenowy@aosc.io> wrote:
> The A83T MMC support code introduces the timings mode switch, however
> such a switch doesn't exist on new SoCs with only new timings mode.
>
> Only execute the switch if the SoC really have the timings mode switch,
> to fix the regression shown on new timings mode only SoCs (A64, H5,
> etc).
>
> Fixes: b0600daebf31 ("mmc: sunxi: Support controllers that can use
>                       both old and new timings")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes in v2:
> - Slightly adjusted the format of the Fixes: line/
> - Added review tag from Chen-Yu.
>
>  drivers/mmc/host/sunxi-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 020547e5fa45..7447d41833ee 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -789,7 +789,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>                 clock <<= 1;
>         }
>
> -       if (host->use_new_timings) {
> +       if (host->use_new_timings && host->cfg->has_timings_switch) {
>                 ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
>                 if (ret) {
>                         dev_err(mmc_dev(mmc),
> --
> 2.13.0
>
