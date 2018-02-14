From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-iproc: Disable preset values for BCM2835
Date: Wed, 14 Feb 2018 11:38:39 +0100
Message-ID: <CAPDyKFov+8-t1awEQqB+vJxkbVvDKNae=JVUoyZsO3uRj=YeOA@mail.gmail.com>
References: <1518465764-30051-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:54818 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967089AbeBNKik (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Feb 2018 05:38:40 -0500
Received: by mail-it0-f65.google.com with SMTP id p204so2224594itc.4
        for <linux-mmc@vger.kernel.org>; Wed, 14 Feb 2018 02:38:40 -0800 (PST)
In-Reply-To: <1518465764-30051-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Eric Anholt <eric@anholt.net>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, linux-arm-kernel@lists.infradead.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 12 February 2018 at 21:02, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> According to the BCM2835 datasheet there are no preset value registers.
> This wasn't an issue before, because we didn't propagate 1.8V support.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-iproc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 61666d2..0ef741b 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -214,6 +214,7 @@ static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
>                   SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>                   SDHCI_QUIRK_MISSING_CAPS |
>                   SDHCI_QUIRK_NO_HISPD_BIT,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>         .ops = &sdhci_iproc_32only_ops,
>  };
>
> --
> 2.7.4
>
