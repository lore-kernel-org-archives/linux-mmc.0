From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: Export card RCA register to sysfs.
Date: Thu, 15 Mar 2018 11:23:41 +0100
Message-ID: <CAPDyKFp_OAnoyTw1Lx+L0Yqt+z+vkwAGqkDz2Qiip-gdCg4e7A@mail.gmail.com>
References: <1520398902-23012-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520398902-23012-1-git-send-email-harish_kandiga@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 7 March 2018 at 06:01, Harish Jenny K N <harish_kandiga@mentor.com> wrote:
> This patch exports RCA register to sysfs which will help in
> reading the disk identification information.
>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Changes in v2:
> - Used 0x%04x to display 16 bit register
>
>  drivers/mmc/core/mmc.c | 2 ++
>  drivers/mmc/core/sd.c  | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 208a762..6f8ebd6 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -792,6 +792,7 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
>  MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
>  MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
>  MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
> +MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
>  MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
>
>  static ssize_t mmc_fwrev_show(struct device *dev,
> @@ -848,6 +849,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
>         &dev_attr_raw_rpmb_size_mult.attr,
>         &dev_attr_rel_sectors.attr,
>         &dev_attr_ocr.attr,
> +       &dev_attr_rca.attr,
>         &dev_attr_dsr.attr,
>         &dev_attr_cmdq_en.attr,
>         NULL,
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 62b84dd..2ecd098 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -676,6 +676,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>  MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
>  MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
>  MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
> +MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
>
>
>  static ssize_t mmc_dsr_show(struct device *dev,
> @@ -709,6 +710,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
>         &dev_attr_oemid.attr,
>         &dev_attr_serial.attr,
>         &dev_attr_ocr.attr,
> +       &dev_attr_rca.attr,
>         &dev_attr_dsr.attr,
>         NULL,
>  };
> --
> 1.9.1
>
