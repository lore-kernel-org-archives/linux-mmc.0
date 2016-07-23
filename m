From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Do not reset the controller if no card in
 the slot
Date: Sat, 23 Jul 2016 11:37:48 +0200
Message-ID: <CAPDyKFpyCfjhngmVxuaBbUdg-qE7C1Y=+1Ojsu18Liu-kqnJmw@mail.gmail.com>
References: <1466785499-7563-1-git-send-email-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38627 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbcGWJhv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Jul 2016 05:37:51 -0400
Received: by mail-wm0-f45.google.com with SMTP id o80so94979064wme.1
        for <linux-mmc@vger.kernel.org>; Sat, 23 Jul 2016 02:37:50 -0700 (PDT)
In-Reply-To: <1466785499-7563-1-git-send-email-georgi.djakov@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, iivanov.xz@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On 24 June 2016 at 18:24, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> The controller does not clear the "reset bit" when it is reset without
> a card in the slot. Because of this, the following error message is seen
> while booting with no plugged SD card.
>
> mmc1: Reset 0x1 never completed.
>
> Add the SDHCI_QUIRK_NO_CARD_NO_RESET quirk to avoid this.
>
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index ac5700233e12..c613137ae91e 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -477,6 +477,7 @@ static const struct sdhci_ops sdhci_msm_ops = {
>
>  static const struct sdhci_pltfm_data sdhci_msm_pdata = {
>         .quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> +                 SDHCI_QUIRK_NO_CARD_NO_RESET |
>                   SDHCI_QUIRK_SINGLE_POWER_WRITE,
>         .ops = &sdhci_msm_ops,
>  };
