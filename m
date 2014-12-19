From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-sirf: add sirf tuning function (cmd 19)
Date: Fri, 19 Dec 2014 11:26:45 +0100
Message-ID: <CAPDyKFpLunVm7eJMuTVGixPnvUzgTdn=ZA1-Ee6qf3xTOJA0hA@mail.gmail.com>
References: <1417694960-5664-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:49904 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbaLSK0q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 05:26:46 -0500
Received: by mail-qg0-f45.google.com with SMTP id f51so429221qge.18
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 02:26:45 -0800 (PST)
In-Reply-To: <1417694960-5664-1-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 4 December 2014 at 13:09, Barry Song <21cnbao@gmail.com> wrote:
> From: Minda Chen <Minda.Chen@csr.com>
>
> Add manual tuning function in CSR atlas7 SoC. It is mainly used
> for the UHS-I SD card working SDR50 SDR104 mode.
>
> The tuning principle can be seen in SD spec part1 v3.01 4.2.4.5
> (tuning command).
>
> SD host send the cmd19 and set the delay value(0-127).
> and the sdcard return 64 bytes data. If the data is same with
> the tuning data. The delay value is valid. Execute this commmand
> 128 times. And calculate the longest window of the valid values.
> The value in the middle of this window is the best value.
>
> Signed-off-by: Minda Chen <Minda.Chen@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Thanks! Queued for 3.20.

I adopted the call for mmc_send_tuning() to take the host instead of
the card as parameter.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-sirf.c | 71 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
> index dd29d47..e458d18 100644
> --- a/drivers/mmc/host/sdhci-sirf.c
> +++ b/drivers/mmc/host/sdhci-sirf.c
> @@ -15,7 +15,9 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include "sdhci-pltfm.h"
>
> +#define SDHCI_CLK_DELAY_SETTING 0x4C
>  #define SDHCI_SIRF_8BITBUS BIT(3)
> +#define SIRF_TUNING_COUNT 128
>
>  struct sdhci_sirf_priv {
>         struct clk *clk;
> @@ -49,7 +51,76 @@ static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>
> +static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +       int tuning_seq_cnt = 3;
> +       u8 phase, tuned_phases[SIRF_TUNING_COUNT];
> +       u8 tuned_phase_cnt = 0;
> +       int rc, longest_range = 0;
> +       int start = -1, end = 0, tuning_value = -1, range = 0;
> +       u16 clock_setting;
> +       struct mmc_host *mmc = host->mmc;
> +
> +       clock_setting = sdhci_readw(host, SDHCI_CLK_DELAY_SETTING);
> +       clock_setting &= ~0x3fff;
> +
> +retry:
> +       phase = 0;
> +       do {
> +               sdhci_writel(host,
> +                       clock_setting | phase | (phase << 7) | (phase << 16),
> +                       SDHCI_CLK_DELAY_SETTING);
> +
> +               if (!mmc_send_tuning(mmc->card)) {
> +                       /* Tuning is successful at this tuning point */
> +                       tuned_phases[tuned_phase_cnt++] = phase;
> +                       dev_dbg(mmc_dev(mmc), "%s: Found good phase = %d\n",
> +                                mmc_hostname(mmc), phase);
> +                       if (start == -1)
> +                               start = phase;
> +                       end = phase;
> +                       range++;
> +                       if (phase == (SIRF_TUNING_COUNT - 1)
> +                               && range > longest_range)
> +                               tuning_value = (start + end) / 2;
> +               } else {
> +                       dev_dbg(mmc_dev(mmc), "%s: Found bad phase = %d\n",
> +                                mmc_hostname(mmc), phase);
> +                       if (range > longest_range) {
> +                               tuning_value = (start + end) / 2;
> +                               longest_range = range;
> +                       }
> +                       start = -1;
> +                       end = range = 0;
> +               }
> +       } while (++phase < ARRAY_SIZE(tuned_phases));
> +
> +       if (tuned_phase_cnt && tuning_value > 0) {
> +               /*
> +                * Finally set the selected phase in delay
> +                * line hw block.
> +                */
> +               phase = tuning_value;
> +               sdhci_writel(host,
> +                       clock_setting | phase | (phase << 7) | (phase << 16),
> +                       SDHCI_CLK_DELAY_SETTING);
> +
> +               dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
> +                        mmc_hostname(mmc), phase);
> +       } else {
> +               if (--tuning_seq_cnt)
> +                       goto retry;
> +               /* Tuning failed */
> +               dev_dbg(mmc_dev(mmc), "%s: No tuning point found\n",
> +                      mmc_hostname(mmc));
> +               rc = -EIO;
> +       }
> +
> +       return rc;
> +}
> +
>  static struct sdhci_ops sdhci_sirf_ops = {
> +       .platform_execute_tuning = sdhci_sirf_execute_tuning,
>         .set_clock = sdhci_set_clock,
>         .get_max_clock  = sdhci_sirf_get_max_clk,
>         .set_bus_width = sdhci_sirf_set_bus_width,
> --
> 2.2.0
>
