From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] mmc: sdhci-st: Fix modalias to make module
 auto-loading work
Date: Mon, 18 May 2015 11:17:50 +0200
Message-ID: <CAPDyKFoRdQrzy24f1G4jgiGW-dtKyXRv+sQkY2TsHK+=JFbQTw@mail.gmail.com>
References: <1431593987-455-1-git-send-email-zhangfei.gao@linaro.org>
	<1431593987-455-5-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35170 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbERJRv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2015 05:17:51 -0400
Received: by qgew3 with SMTP id w3so38890663qge.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2015 02:17:50 -0700 (PDT)
In-Reply-To: <1431593987-455-5-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Peter Griffin <peter.griffin@linaro.org>

On 14 May 2015 at 10:59, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> Make the modalias match driver name, this is required to make module
> auto-loading work.
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> CC: Peter Griffin <peter.griffin@linaro.org>

Thanks, applied.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 682f2bb..969c2b0 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -509,4 +509,4 @@ module_platform_driver(sdhci_st_driver);
>  MODULE_DESCRIPTION("SDHCI driver for STMicroelectronics SoCs");
>  MODULE_AUTHOR("Giuseppe Cavallaro <peppe.cavallaro@st.com>");
>  MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("platform:st-sdhci");
> +MODULE_ALIAS("platform:sdhci-st");
> --
> 1.9.1
>
