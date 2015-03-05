From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] mmc: sirf: update sdhci_sirf_execute_tuning procedure
Date: Thu, 5 Mar 2015 13:54:15 +0800
Message-ID: <CAGsJ_4x8HVAOFr95hxT47aoadm6xyvdBCt+ZU05Lamfjz2xFPg@mail.gmail.com>
References: <1424015031-24676-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:46977 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbCEFyg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 00:54:36 -0500
Received: by pabli10 with SMTP id li10so39798152pab.13
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2015 21:54:36 -0800 (PST)
In-Reply-To: <1424015031-24676-1-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, weijun yang <york.yang@csr.com>, Barry Song <baohua.song@csr.com>

ping Ulf....


2015-02-15 23:43 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> From: weijun yang <york.yang@csr.com>
>
> For the original tuning code, delay value is set to SD Bus Clock Delay
> Register (SD_CLK_DELAY_SETTING) as (val | (Val << 7) | (val << 16)),
> which means CLK_DELAY_IN1, CLK_DELAY_IN2 and CLK_DELAY_OUT are the
> same and with 128 steps. This is doubtful. In CSR design specification
> documents CS-304575-DR-3H, this issue is clarified, the delay[13:0] in
> SD_CLK_DELAY_SETTING is simplied to the concatenation of {CLK_DELAY_IN2,
> CLK_DELAY_IN1}.
> Besides, for CMD19 tuning, no need to set CLK_DELAY_OUT([22,16]
> of SD_CLK_DELAY_SETTING).
>
> Signed-off-by: weijun yang <york.yang@csr.com>
> Signed-off-by: Barry Song <baohua.song@csr.com>
> ---
>  drivers/mmc/host/sdhci-sirf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
> index f6f82ec..4331409 100644
> --- a/drivers/mmc/host/sdhci-sirf.c
> +++ b/drivers/mmc/host/sdhci-sirf.c
> @@ -56,7 +56,7 @@ static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
>         int tuning_seq_cnt = 3;
>         u8 phase, tuned_phases[SIRF_TUNING_COUNT];
>         u8 tuned_phase_cnt = 0;
> -       int rc, longest_range = 0;
> +       int rc = 0, longest_range = 0;
>         int start = -1, end = 0, tuning_value = -1, range = 0;
>         u16 clock_setting;
>         struct mmc_host *mmc = host->mmc;
> @@ -68,7 +68,7 @@ retry:
>         phase = 0;
>         do {
>                 sdhci_writel(host,
> -                       clock_setting | phase | (phase << 7) | (phase << 16),
> +                       clock_setting | phase,
>                         SDHCI_CLK_DELAY_SETTING);
>
>                 if (!mmc_send_tuning(mmc)) {
> @@ -102,7 +102,7 @@ retry:
>                  */
>                 phase = tuning_value;
>                 sdhci_writel(host,
> -                       clock_setting | phase | (phase << 7) | (phase << 16),
> +                       clock_setting | phase,
>                         SDHCI_CLK_DELAY_SETTING);
>
>                 dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
> --
> 1.9.1
>
