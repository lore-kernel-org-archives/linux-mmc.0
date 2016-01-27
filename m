From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: arasan: sdhci-of-arasan: Remove no-hispd and
 no-cmd23 quirks for sdhci-arasan4.9a
Date: Wed, 27 Jan 2016 15:15:52 +0100
Message-ID: <CAPDyKFoHrzJVPDR+tz8vrF50yvyxgnFes7tRDe1S6+TV8yVj3Q@mail.gmail.com>
References: <1450877391-3029-1-git-send-email-rsahu@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35783 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933172AbcA0OPx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 09:15:53 -0500
Received: by mail-yk0-f169.google.com with SMTP id y137so18738668yka.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jan 2016 06:15:53 -0800 (PST)
In-Reply-To: <1450877391-3029-1-git-send-email-rsahu@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rameshswar Prasad Sahu <rsahu@apm.com>
Cc: Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jon Masters <jcm@redhat.com>, patches <patches@apm.com>, kgondkar@apm.com

On 23 December 2015 at 14:29, Rameshswar Prasad Sahu <rsahu@apm.com> wrote:
> From: Rameshwar Prasad Sahu <rsahu@apm.com>
>
> The Arason SD host controller supports set block count command (cmd23)
> and high speed mode. This patch re-enable both of these features that
> was disabled. For device that doesn't support high speed, it should
> configure its capability register accordingly instead disables it
> explicitly.
>
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 75379cb..5d9fdb3 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -172,11 +172,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto clk_disable_all;
>         }
>
> -       if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
> -               host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> -               host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> -       }
> -
>         sdhci_get_of_property(pdev);
>         pltfm_host = sdhci_priv(host);
>         pltfm_host->priv = sdhci_arasan;
> --
> 1.7.1
>
