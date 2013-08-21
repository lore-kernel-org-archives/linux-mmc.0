From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH 02/14] mmc: dw_mmc: exynos: add variable delay tuning sequence
Date: Wed, 21 Aug 2013 07:58:43 -0700
Message-ID: <CANEJEGseG+5S+S=er23qi4TgvwknQsJ0o0p9rMsOVH2g7SnXxA@mail.gmail.com>
References: <002701ce9e75$3eca9870$bc5fc950$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:33554 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab3HUO6o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 10:58:44 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so1070495oag.35
        for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2013 07:58:44 -0700 (PDT)
In-Reply-To: <002701ce9e75$3eca9870$bc5fc950$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>

On Wed, Aug 21, 2013 at 6:49 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Implements variable delay tuning. In this change,
> exynos host can determine the correct sampling point
> for the HS200 and SDR104 speed mode.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |  124 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 124 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 866edef..90f9335 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -14,8 +14,10 @@
>  #include <linux/clk.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/dw_mmc.h>
> +#include <linux/mmc/mmc.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
> +#include <linux/slab.h>
>
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
> @@ -150,6 +152,127 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>         return 0;
>  }
>
> +static inline u8 dw_mci_exynos_get_clksmpl(struct dw_mci *host)
> +{
> +       return SDMMC_CLKSEL_CCLK_SAMPLE(mci_readl(host, CLKSEL));
> +}
> +
> +static inline void dw_mci_exynos_set_clksmpl(struct dw_mci *host, u8 sample)
> +{
> +       u32 clksel;
> +       clksel = mci_readl(host, CLKSEL);
> +       clksel = (clksel & ~0x7) | SDMMC_CLKSEL_CCLK_SAMPLE(sample);
> +       mci_writel(host, CLKSEL, clksel);
> +}
> +
> +static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)

Hi Seungwon,
I rewrote the dw_mmc HS200 tuning code for ChromeOS-3.4 kernel with
this series of patches:
    https://gerrit.chromium.org/gerrit/#/c/57997 CHROMIUM: mmc:
dw_mmc: move struct dw_mci_slot to public header
    https://gerrit.chromium.org/gerrit/#/c/58269  CHROMIUM: mmc:
dw_mmc: move dw_mci_set_timeout() to dw_mmc.h
    https://gerrit.chromium.org/gerrit/#/c/57996/  CHROMIUM: mmc:
dw_mmc: add execute_tuning hook
    https://gerrit.chromium.org/gerrit/#/c/57861 CHROMIUM: mmc:
dw_mmc: add HS200 tuning feature

This code was reviewed and approved by Alim Akhtar.

Most of the differences I don't care enough about to quibble. But the
handling of "clksmpl" was difficult to read and understand.  I added a
lot of comments so the next person without access to Samsung's
confidential and incomplete Exynos manuals could have a small chance
of debugging this code.

In particular look at dw_mci_exynos_execute_tuning() and
find_median_of_5bits() in this patch:
    https://gerrit.chromium.org/gerrit/#/c/57861/9/drivers/mmc/host/dw_mmc-exynos.c

Is there some reason you would NOT want to use find_median_of_5bits()
and related code?

thanks,
grant

> +{
> +       u32 clksel;
> +       u8 sample;
> +
> +       clksel = mci_readl(host, CLKSEL);
> +       sample = (clksel + 1) & 0x7;
> +       clksel = (clksel & ~0x7) | sample;
> +       mci_writel(host, CLKSEL, clksel);
> +       return sample;
> +}
> +
> +static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
> +{
> +       const u8 iter = 8;
> +       u8 __c;
> +       s8 i, loc = -1;
> +
> +       for (i = 0; i < iter; i++) {
> +               __c = ror8(candiates, i);
> +               if ((__c & 0xc7) == 0xc7) {
> +                       loc = i;
> +                       goto out;
> +               }
> +       }
> +
> +       for (i = 0; i < iter; i++) {
> +               __c = ror8(candiates, i);
> +               if ((__c & 0x83) == 0x83) {
> +                       loc = i;
> +                       goto out;
> +               }
> +       }
> +
> +out:
> +       return loc;
> +}
> +
> +static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
> +                                       struct dw_mci_tuning_data *tuning_data)
> +{
> +       struct dw_mci *host = slot->host;
> +       struct mmc_host *mmc = slot->mmc;
> +       const u8 *blk_pattern = tuning_data->blk_pattern;
> +       u8 *blk_test;
> +       unsigned int blksz = tuning_data->blksz;
> +       u8 start_smpl, smpl, candiates = 0;
> +       s8 found = -1;
> +       int ret = 0;
> +
> +       blk_test = kmalloc(blksz, GFP_KERNEL);
> +       if (!blk_test)
> +               return -ENOMEM;
> +
> +       start_smpl = dw_mci_exynos_get_clksmpl(host);
> +
> +       do {
> +               struct mmc_request mrq = {NULL};
> +               struct mmc_command cmd = {0};
> +               struct mmc_command stop = {0};
> +               struct mmc_data data = {0};
> +               struct scatterlist sg;
> +
> +               cmd.opcode = opcode;
> +               cmd.arg = 0;
> +               cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +               stop.opcode = MMC_STOP_TRANSMISSION;
> +               stop.arg = 0;
> +               stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
> +
> +               data.blksz = blksz;
> +               data.blocks = 1;
> +               data.flags = MMC_DATA_READ;
> +               data.sg = &sg;
> +               data.sg_len = 1;
> +
> +               sg_init_one(&sg, blk_test, blksz);
> +               mrq.cmd = &cmd;
> +               mrq.stop = &stop;
> +               mrq.data = &data;
> +               host->mrq = &mrq;
> +
> +               mci_writel(host, TMOUT, ~0);
> +               smpl = dw_mci_exynos_move_next_clksmpl(host);
> +
> +               mmc_wait_for_req(mmc, &mrq);
> +
> +               if (!cmd.error && !data.error) {
> +                       if (!memcmp(blk_pattern, blk_test, blksz))
> +                               candiates |= (1 << smpl);
> +               } else {
> +                       dev_dbg(host->dev,
> +                               "Tuning error: cmd.error:%d, data.error:%d\n",
> +                               cmd.error, data.error);
> +               }
> +       } while (start_smpl != smpl);
> +
> +       found = dw_mci_exynos_get_best_clksmpl(candiates);
> +       if (found >= 0)
> +               dw_mci_exynos_set_clksmpl(host, found);
> +       else
> +               ret = -EIO;
> +
> +       kfree(blk_test);
> +       return ret;
> +}
> +
>  /* Common capabilities of Exynos4/Exynos5 SoC */
>  static unsigned long exynos_dwmmc_caps[4] = {
>         MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
> @@ -166,6 +289,7 @@ static const struct dw_mci_drv_data exynos_drv_data = {
>         .prepare_command        = dw_mci_exynos_prepare_command,
>         .set_ios                = dw_mci_exynos_set_ios,
>         .parse_dt               = dw_mci_exynos_parse_dt,
> +       .execute_tuning         = dw_mci_exynos_execute_tuning,
>  };
>
>  static const struct of_device_id dw_mci_exynos_match[] = {
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
