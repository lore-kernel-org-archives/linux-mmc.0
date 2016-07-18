From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Do not reset the controller if no card
 in the slot
Date: Mon, 18 Jul 2016 10:46:19 -0700
Message-ID: <20160718174619.GI13516@tuxbot>
References: <1466785499-7563-1-git-send-email-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35310 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbcGRRqY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2016 13:46:24 -0400
Received: by mail-pf0-f174.google.com with SMTP id x72so7776741pfd.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2016 10:46:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1466785499-7563-1-git-send-email-georgi.djakov@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, iivanov.xz@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org

On Fri 24 Jun 09:24 PDT 2016, Georgi Djakov wrote:

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

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
>  	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> +		  SDHCI_QUIRK_NO_CARD_NO_RESET |
>  		  SDHCI_QUIRK_SINGLE_POWER_WRITE,
>  	.ops = &sdhci_msm_ops,
>  };
