From: Rameshwar Sahu <rsahu@apm.com>
Subject: Re: [PATCH] mmc: host: arasan: sdhci-of-arasan: Remove no-hispd and
 no-cmd23 quirks for sdhci-arasan4.9a
Date: Tue, 5 Jan 2016 15:55:52 +0530
Message-ID: <CAFd313ziJ_zgxQ11J6e=ueRLFKXFOsDPg_evRDK2FGQC5rOmfA@mail.gmail.com>
References: <1450877391-3029-1-git-send-email-rsahu@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:32964 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbcAEKZx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jan 2016 05:25:53 -0500
Received: by mail-io0-f177.google.com with SMTP id q21so182068852iod.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 Jan 2016 02:25:53 -0800 (PST)
In-Reply-To: <1450877391-3029-1-git-send-email-rsahu@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com, Kaustubh Gondkar <kgondkar@apm.com>, Rameshwar Prasad Sahu <rsahu@apm.com>

Hi Ulf,

On Wed, Dec 23, 2015 at 6:59 PM, Rameshswar Prasad Sahu <rsahu@apm.com> wrote:
> From: Rameshwar Prasad Sahu <rsahu@apm.com>
>
> The Arason SD host controller supports set block count command (cmd23)
> and high speed mode. This patch re-enable both of these features that
> was disabled. For device that doesn't support high speed, it should
> configure its capability register accordingly instead disables it
> explicitly.
>
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
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

Any comment on this patch ??
