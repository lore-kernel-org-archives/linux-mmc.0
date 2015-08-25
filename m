From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Kconfig: Add dependency on GPIOLIB for MMC_SDHCI
Date: Tue, 25 Aug 2015 14:04:25 +0200
Message-ID: <CAPDyKFqgLonYZT86ixOAwJ3G5tsozxee6dEs+QRFYzwOWFUNNQ@mail.gmail.com>
References: <6906e34b62f162018984a5fbd12b3ef6cd5e3a29.1438839562.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33688 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbbHYMEZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:04:25 -0400
Received: by igfj19 with SMTP id j19so9426260igf.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:04:25 -0700 (PDT)
In-Reply-To: <6906e34b62f162018984a5fbd12b3ef6cd5e3a29.1438839562.git.michal.simek@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Scott Branden <sbranden@broadcom.com>, Weijun Yang <Weijun.Yang@csr.com>, Andrew Bresticker <abrestic@chromium.org>, Jean Delvare <jdelvare@suse.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, addy ke <addy.ke@rock-chips.com>, Stephen Boyd <sboyd@codeaurora.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Kevin Hao <haokexin@gmail.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>

On 6 August 2015 at 07:39, Michal Simek <michal.simek@xilinx.com> wrote:
> Add GPIOLIB dependency for MMC_SDHCI.
>
> Problem was observed after adding the patch
> "mmc: sdhci-of-arasan: Call OF parsing for MMC"
> (sha1: 16b23787fc709fe60c5d2bd05927b1a3da33d4e9) which calls
> mmc_of_parse() -> mmc_gpiod_request_cd() (slot-gpio.c) which
> calls devm_gpiod_get_index() which returns -ENOSYS.
>
> Error log:
> sdhci-arasan ff160000.sdhci: parsing dt failed (4294967258)
> sdhci-arasan: probe of ff160000.sdhci failed with error -38
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> After RFC here https://lkml.org/lkml/2015/7/24/371
> adding dependency on MMC_SDHCI.
>
> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index fd9a58e216a5..5519803c124b 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -38,6 +38,7 @@ config MMC_PXA
>  config MMC_SDHCI
>         tristate "Secure Digital Host Controller Interface support"
>         depends on HAS_DMA
> +       depends on GPIOLIB
>         help
>           This selects the generic Secure Digital Host Controller Interface.
>           It is used by manufacturers such as Texas Instruments(R), Ricoh(R)
> --
> 2.3.5
>
