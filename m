From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH next] mmc: sdhci-pxav3: Remove checks for optional core
 clock in error/remove path
Date: Wed, 21 Jan 2015 14:21:21 +0100
Message-ID: <CAPDyKFo=PDt4zsJ+odVkmCyws7HttAcUW4p6NbSqoR3S-c6iRA@mail.gmail.com>
References: <1420444759-3812-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:46383 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbAUNVV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jan 2015 08:21:21 -0500
Received: by mail-qc0-f175.google.com with SMTP id c9so13377794qcz.6
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2015 05:21:21 -0800 (PST)
In-Reply-To: <1420444759-3812-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Chris Ball <chris@printf.net>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 5 January 2015 at 08:59, Jisheng Zhang <jszhang@marvell.com> wrote:
> Commit 63589e92c2d9 ("clk: Ignore error and NULL pointers passed to
> clk_{unprepare, disable}()") allows NULL or error pointer to be passed
> unconditionally.
>
> This patch is to simplify probe error and remove code paths.
>
> However, we reserve the core clock checks in runtime suspend/resume code
> because we want a little smaller latency.
>
> This patch can be applied after the sdhci-pxav3 unbalanced pm/clock issues
> patches being merged.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313103.html

I remove these three lines from the commit msg.

>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 4de39fb..63967b8 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -398,8 +398,7 @@ err_of_parse:
>  err_cd_req:
>  err_mbus_win:
>         clk_disable_unprepare(pxa->clk_io);
> -       if (!IS_ERR(pxa->clk_core))
> -               clk_disable_unprepare(pxa->clk_core);
> +       clk_disable_unprepare(pxa->clk_core);
>  err_clk_get:
>         sdhci_pltfm_free(pdev);
>         return ret;
> @@ -418,8 +417,7 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
>         sdhci_remove_host(host, 1);
>
>         clk_disable_unprepare(pxa->clk_io);
> -       if (!IS_ERR(pxa->clk_core))
> -               clk_disable_unprepare(pxa->clk_core);
> +       clk_disable_unprepare(pxa->clk_core);
>
>         sdhci_pltfm_free(pdev);
>
> --
> 2.1.4
>
