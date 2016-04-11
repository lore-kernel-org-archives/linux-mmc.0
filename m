From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] qcom: sdhci-msm: enable the DLL clock
Date: Mon, 11 Apr 2016 15:33:16 +0200
Message-ID: <CAPDyKFr7dWOxb_o7b9AyEWYSROtjdktPXwKexAjBGaFw5M-Fig@mail.gmail.com>
References: <1459842403-4052-1-git-send-email-ssambang@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35132 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933063AbcDKNdW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2016 09:33:22 -0400
Received: by mail-vk0-f53.google.com with SMTP id t129so126132114vkg.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2016 06:33:17 -0700 (PDT)
In-Reply-To: <1459842403-4052-1-git-send-email-ssambang@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sreedhar Sambangi <ssambang@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, qca-upstream.external@qca.qualcomm.com, Ivan Ivanov <ivan.ivanov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

+ Adrian

On 5 April 2016 at 09:46, Sreedhar Sambangi <ssambang@codeaurora.org> wrote:
> The DLL clock has to be enabled until the correct
> clock frequency is delivered to DLL
> '1'(default) - DLL clock is disabled
> '0' - dll clock has legacly clock enable.
>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> Signed-off-by: Sreedhar Sambangi <ssambang@codeaurora.org>

Adrian Hunter is the maintainer for sdhci, next time make sure to post to him.

As this seems like fairly trivial change I decided to pick it up
anyway. So applied for next!

Note, that I changed the prefix of the commit message header to "mmc".

Thanks and kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4695bee..95b8b70 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -43,6 +43,9 @@
>  #define CORE_DLL_CONFIG                0x100
>  #define CORE_DLL_STATUS                0x108
>
> +#define CORE_DLL_CONFIG2       0x1b4
> +#define CORE_DLL_CLK_DISABLE   BIT(21)
> +
>  #define CORE_VENDOR_SPEC       0x10c
>  #define CORE_CLK_PWRSAVE       BIT(1)
>
> @@ -326,6 +329,10 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>         writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
>                         | CORE_CK_OUT_EN), host->ioaddr + CORE_DLL_CONFIG);
>
> +       /* Write 0 to DLL_CLOCK_DISABLE bit of DLL_CONFIG_2 register */
> +       writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG2)
> +               & ~CORE_DLL_CLK_DISABLE), host->ioaddr + CORE_DLL_CONFIG2);
> +
>         /* Wait until DLL_LOCK bit of DLL_STATUS register becomes '1' */
>         while (!(readl_relaxed(host->ioaddr + CORE_DLL_STATUS) &
>                  CORE_DLL_LOCK)) {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
