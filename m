From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 3/3] mmc: sirf: fix the capbility to support DDR50
Date: Mon, 5 Oct 2015 12:57:01 +0200
Message-ID: <CAPDyKFo7nRd_+uYd8_-=BT-SxtdQPkGdT3cPyT2fqkhjBwXv_A@mail.gmail.com>
References: <1443960253-4082-1-git-send-email-21cnbao@gmail.com>
	<1443960253-4082-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32978 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbJEK5C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2015 06:57:02 -0400
Received: by wiclk2 with SMTP id lk2so114269242wic.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Oct 2015 03:57:01 -0700 (PDT)
In-Reply-To: <1443960253-4082-3-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Weijun Yang <york.yang@csr.com>, Barry Song <Baohua.Song@csr.com>

On 4 October 2015 at 14:04, Barry Song <21cnbao@gmail.com> wrote:
> From: Weijun Yang <york.yang@csr.com>
>
> According to hardware spec, validate DDR50 mode
> for SDXC.
>
> Signed-off-by: Weijun Yang <york.yang@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-sirf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
> index 8842945..f5488c4 100644
> --- a/drivers/mmc/host/sdhci-sirf.c
> +++ b/drivers/mmc/host/sdhci-sirf.c
> @@ -50,7 +50,8 @@ static u32 sdhci_sirf_readl_le(struct sdhci_host *host, int reg)
>         if (unlikely((reg == SDHCI_CAPABILITIES_1) &&
>                         (host->mmc->caps & MMC_CAP_UHS_SDR50))) {
>                 /* fake CAP_1 register */
> -               val = SDHCI_SUPPORT_SDR50 | SDHCI_USE_SDR50_TUNING;
> +               val = SDHCI_SUPPORT_DDR50 |
> +                       SDHCI_SUPPORT_SDR50 | SDHCI_USE_SDR50_TUNING;
>         }
>
>         if (unlikely(reg == SDHCI_SLOT_INT_STATUS)) {
> --
> 1.9.1
>
