From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-sirf: fake version and capbility registers
Date: Tue, 5 May 2015 10:35:31 +0200
Message-ID: <CAPDyKFowrRx7gUhP1hZs7qxH7Sw5LomgKnBZzs-zAmcVYzqbjw@mail.gmail.com>
References: <1430122514-6541-1-git-send-email-21cnbao@gmail.com>
	<1430122514-6541-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34161 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965262AbbEEIfc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 04:35:32 -0400
Received: by qkgx75 with SMTP id x75so101216248qkg.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 01:35:32 -0700 (PDT)
In-Reply-To: <1430122514-6541-2-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>

On 27 April 2015 at 10:15, Barry Song <21cnbao@gmail.com> wrote:
> From: Weijun Yang <Weijun.Yang@csr.com>
>
> chips have some issues for version and capbility registers, here we fake
> them.
>
> Signed-off-by: Weijun Yang <Weijun.Yang@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Thanks, applied!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig      |  1 +
>  drivers/mmc/host/sdhci-sirf.c | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index b1f837e..d5e107b 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -219,6 +219,7 @@ config MMC_SDHCI_SIRF
>         tristate "SDHCI support on CSR SiRFprimaII and SiRFmarco SoCs"
>         depends on ARCH_SIRF
>         depends on MMC_SDHCI_PLTFM
> +       select MMC_SDHCI_IO_ACCESSORS
>         help
>           This selects the SDHCI support for SiRF System-on-Chip devices.
>
> diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
> index 2201f76..0110bae 100644
> --- a/drivers/mmc/host/sdhci-sirf.c
> +++ b/drivers/mmc/host/sdhci-sirf.c
> @@ -43,6 +43,39 @@ static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>
> +static u32 sdhci_sirf_readl_le(struct sdhci_host *host, int reg)
> +{
> +       u32 val = readl(host->ioaddr + reg);
> +
> +       if (unlikely((reg == SDHCI_CAPABILITIES_1) &&
> +                       (host->mmc->caps & MMC_CAP_UHS_SDR50))) {
> +               /* fake CAP_1 register */
> +               val = SDHCI_SUPPORT_SDR50 | SDHCI_USE_SDR50_TUNING;
> +       }
> +
> +       if (unlikely(reg == SDHCI_SLOT_INT_STATUS)) {
> +               u32 prss = val;
> +               /* fake chips as V3.0 host conreoller */
> +               prss &= ~(0xFF << 16);
> +               val = prss | (SDHCI_SPEC_300 << 16);
> +       }
> +       return val;
> +}
> +
> +static u16 sdhci_sirf_readw_le(struct sdhci_host *host, int reg)
> +{
> +       u16 ret = 0;
> +
> +       ret = readw(host->ioaddr + reg);
> +
> +       if (unlikely(reg == SDHCI_HOST_VERSION)) {
> +               ret = readw(host->ioaddr + SDHCI_HOST_VERSION);
> +               ret |= SDHCI_SPEC_300;
> +       }
> +
> +       return ret;
> +}
> +
>  static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
>  {
>         int tuning_seq_cnt = 3;
> @@ -113,6 +146,8 @@ retry:
>  }
>
>  static struct sdhci_ops sdhci_sirf_ops = {
> +       .read_l = sdhci_sirf_readl_le,
> +       .read_w = sdhci_sirf_readw_le,
>         .platform_execute_tuning = sdhci_sirf_execute_tuning,
>         .set_clock = sdhci_set_clock,
>         .get_max_clock  = sdhci_pltfm_clk_get_max_clock,
> --
> 2.3.5
>
