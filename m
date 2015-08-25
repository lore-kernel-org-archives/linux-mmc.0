From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sirf: corrent quirk according to real chips
Date: Tue, 25 Aug 2015 14:06:23 +0200
Message-ID: <CAPDyKFov0HYcsvKdSfngYd8LvJx1E0hSwkqk_Ji=0n6KBskNxA@mail.gmail.com>
References: <1439362773-32515-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36582 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529AbbHYMGX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:06:23 -0400
Received: by iodv127 with SMTP id v127so183036200iod.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:06:23 -0700 (PDT)
In-Reply-To: <1439362773-32515-1-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>

On 12 August 2015 at 08:59, Barry Song <21cnbao@gmail.com> wrote:
> From: Barry Song <Baohua.Song@csr.com>
>
> the current quirk set is for an old FPGA, and this patch corrects
> quirks according to real SoC.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Thanks, applied for next. I took the liberty of changing the prefix of
commit message header into "mmc: sdhci-sirf:"

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-sirf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
> index 0110bae..8842945 100644
> --- a/drivers/mmc/host/sdhci-sirf.c
> +++ b/drivers/mmc/host/sdhci-sirf.c
> @@ -161,8 +161,8 @@ static struct sdhci_pltfm_data sdhci_sirf_pdata = {
>         .quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>                 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>                 SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> -               SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> -               SDHCI_QUIRK_DELAY_AFTER_POWER,
> +               SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>
>  static int sdhci_sirf_probe(struct platform_device *pdev)
> --
> 1.9.1
>
