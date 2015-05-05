From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/6] mmc: davinci: Constify platform_device_id
Date: Tue, 5 May 2015 10:36:21 +0200
Message-ID: <CAPDyKFrpTiztS1UrMQRXX4o9=s1L7qzX9JTdNNHQUrx5sa5aiA@mail.gmail.com>
References: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34823 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030868AbbEEIgW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 04:36:22 -0400
Received: by qkhg7 with SMTP id g7so100985935qkh.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 01:36:21 -0700 (PDT)
In-Reply-To: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 1 May 2015 at 17:49, Krzysztof Kozlowski <k.kozlowski.k@gmail.com> wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Thanks, applied all patches (1->6). The last one I updated the prefix
in commit message header to "sdhci".

Kind regards
Uffe

> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 1625f908dc70..ea2a2ebc6b91 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1161,7 +1161,7 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
>         mmc_davinci_reset_ctrl(host, 0);
>  }
>
> -static struct platform_device_id davinci_mmc_devtype[] = {
> +static const struct platform_device_id davinci_mmc_devtype[] = {
>         {
>                 .name   = "dm6441-mmc",
>                 .driver_data = MMC_CTLR_VERSION_1,
> --
> 2.1.4
>
