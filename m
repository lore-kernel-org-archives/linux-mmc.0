From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci-pci-o2micro: Add hardware tuning for eMMC
Date: Fri, 15 Dec 2017 09:58:24 +0100
Message-ID: <CAPDyKFqBTRd2OzmFNhZaOGueZ_0cZcfLaGg2tsO4W38Kfy-CFg@mail.gmail.com>
References: <CY4PR04MB047375B124358A33FB077C6EED3C0@CY4PR04MB0473.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:40254 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbdLOI6Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Dec 2017 03:58:25 -0500
Received: by mail-it0-f68.google.com with SMTP id f190so17305767ita.5
        for <linux-mmc@vger.kernel.org>; Fri, 15 Dec 2017 00:58:25 -0800 (PST)
In-Reply-To: <CY4PR04MB047375B124358A33FB077C6EED3C0@CY4PR04MB0473.namprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: LinuxPatchCommit <LinuxPatchCommit@bayhubtech.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shirley Her (SC)" <shirley.her@bayhubtech.com>

On 4 December 2017 at 10:39, LinuxPatchCommit
<LinuxPatchCommit@bayhubtech.com> wrote:
> Dear All,
>
> For O2micro/Bayhubtech SD Host DeviceID 8620, eMMC HS200 mode is working at 1.8v and it uses hardware tuning. The hardware tuning only needs to send one tuning command instead of multiple tuning commands with software tuning.

Could you please re-write this changelog.

This is suppose to tell people why this change is needed, what it does
and how. And skip the "Deal All.. thing", it's not something that
belongs in the changelog.

Moreover, could you make sure to have a valid author of the patch,
"LinuxPatchCommit" isn't a valid author. :-)

>
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 276 ++++++++++++++++++++++++++++++-----
>  1 file changed, 239 insertions(+), 37 deletions(-)

Regarding these changes, lot's of them are just whitespaces or tab
changes. Can you please remove all of them and if you really want
those kind of changes, send a separate patch for that.

This helps to review the code, so I am stopping here for now and
waiting for better version that is easier to review.

Kind regards
Uffe

>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 14273ca00641..2a7ffd240497 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -16,22 +16,223 @@
>   */
>
>  #include <linux/pci.h>
> -
> +#include <linux/platform_device.h>
> +#include <linux/regulator/fixed.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/delay.h>
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
>  #include "sdhci-pci-o2micro.h"
>
> +static void sdhci_o2_start_tuning(struct sdhci_host *host) {
> +       u16 ctrl;
> +
> +       ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +       ctrl |= SDHCI_CTRL_EXEC_TUNING;
> +       if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
> +               ctrl |= SDHCI_CTRL_TUNED_CLK;
> +       sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +       /*
> +        * As per the Host Controller spec v3.00, tuning command
> +        * generates Buffer Read Ready interrupt, so enable that.
> +        *
> +        * Note: The spec clearly says that when tuning sequence
> +        * is being performed, the controller does not generate
> +        * interrupts other than Buffer Read Ready interrupt. But
> +        * to make sure we don't hit a controller bug, we _only_
> +        * enable Buffer Read Ready interrupt here.
> +        */
> +       sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
> +       sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE); }
> +
> +static void sdhci_o2_end_tuning(struct sdhci_host *host) {
> +       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE); }
> +
> +static inline bool sdhci_data_line_cmd(struct mmc_command *cmd) {
> +       return cmd->data || cmd->flags & MMC_RSP_BUSY; }
> +
> +static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request
> +*mrq) {
> +       if (sdhci_data_line_cmd(mrq->cmd))
> +               del_timer(&host->data_timer);
> +       else
> +               del_timer(&host->timer);
> +}
> +
> +static void sdhci_o2_set_tuning_mode(struct sdhci_host *host, bool hw)
> +{
> +       u16 reg;
> +
> +       if (hw) {
> +               // enable hardware tuning
> +               reg = sdhci_readw(host, O2_SD_VENDOR_SETTING);
> +               reg &= (~O2_SD_HW_TUNING_ENABLE);
> +               sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
> +       } else {
> +               reg = sdhci_readw(host, O2_SD_VENDOR_SETTING);
> +               reg |= O2_SD_HW_TUNING_ENABLE;
> +               sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
> +       }
> +}
> +
> +static u8 data_buf[64];
> +
> +static void sdhci_o2_send_tuning(struct sdhci_host *host, u32 opcode) {
> +       struct mmc_command cmd = { };
> +       struct mmc_data data = { };
> +       struct scatterlist sg;
> +       struct mmc_request mrq = { };
> +       unsigned long flags;
> +       u32 b = host->sdma_boundary;
> +       int size = sizeof(data_buf);
> +
> +       cmd.opcode = opcode;
> +       cmd.flags = MMC_RSP_PRESENT | MMC_RSP_OPCODE | MMC_RSP_CRC;
> +       cmd.mrq = &mrq;
> +       mrq.cmd = &cmd;
> +       mrq.data = &data;
> +       data.blksz = size;
> +       data.blocks = 1;
> +       data.flags = MMC_DATA_READ;
> +
> +       data.timeout_ns = 150 * NSEC_PER_MSEC;
> +
> +       data.sg = &sg;
> +       data.sg_len = 1;
> +       sg_init_one(&sg, data_buf, size);
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +
> +       sdhci_writew(host, SDHCI_MAKE_BLKSZ(b, 64), SDHCI_BLOCK_SIZE);
> +
> +       /*
> +        * The tuning block is sent by the card to the host controller.
> +        * So we set the TRNS_READ bit in the Transfer Mode register.
> +        * This also takes care of setting DMA Enable and Multi Block
> +        * Select in the same register to 0.
> +        */
> +       sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
> +
> +       sdhci_send_command(host, &cmd);
> +
> +       host->cmd = NULL;
> +
> +       sdhci_del_timer(host, &mrq);
> +
> +       host->tuning_done = 0;
> +
> +       mmiowb();
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       /* Wait for Buffer Read Ready interrupt */
> +       wait_event_timeout(host->buf_ready_int, (host->tuning_done == 1),
> +                          msecs_to_jiffies(50));
> +
> +}
> +
> +static void sdhci_o2_reset_tuning(struct sdhci_host *host) {
> +       u16 ctrl;
> +
> +       ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +       ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> +       ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
> +       sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2); }
> +
> +static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32
> +opcode) {
> +
> +       int i;
> +
> +       sdhci_o2_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
> +
> +       for (i = 0; i < 150; i++) {
> +               u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +               if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
> +                       if (ctrl & SDHCI_CTRL_TUNED_CLK) {
> +                               pr_info("%s: HW tuning ok !\n",
> +                                       mmc_hostname(host->mmc));
> +                               host->tuning_done = true;
> +                               return;
> +                       }
> +                       pr_warn("%s: HW tuning failed !\n",
> +                               mmc_hostname(host->mmc));
> +
> +                       break;
> +               }
> +
> +               mdelay(1);
> +       }
> +
> +       pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
> +               mmc_hostname(host->mmc));
> +       sdhci_o2_reset_tuning(host);
> +
> +}
> +
> +static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode) {
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       int current_bus_width = 0;
> +
> +       /*
> +        * This handler only implements the eMMC tuning that is specific to
> +        * this controller.  Fall back to the standard method for other TINMING.
> +        */
> +       if (host->timing != MMC_TIMING_MMC_HS200)
> +               return sdhci_execute_tuning(mmc, opcode);
> +
> +       if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
> +               return -EINVAL;
> +
> +       /*
> +        * o2 sdhci host didn't support 8bit emmc tuning
> +        */
> +       if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> +               current_bus_width = mmc->ios.bus_width;
> +               mmc->ios.bus_width = MMC_BUS_WIDTH_4;
> +               mmc->ops->set_ios(mmc, &mmc->ios);
> +       }
> +
> +       sdhci_o2_set_tuning_mode(host, true);
> +
> +       sdhci_o2_start_tuning(host);
> +
> +       __sdhci_o2_execute_tuning(host, opcode);
> +
> +       sdhci_o2_end_tuning(host);
> +
> +       if (current_bus_width == MMC_BUS_WIDTH_8) {
> +               mmc->ios.bus_width = current_bus_width;
> +               mmc->ops->set_ios(mmc, &mmc->ios);
> +       }
> +
> +       host->flags &= ~SDHCI_HS400_TUNING;
> +       return 0;
> +}
> +
>  static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)  {
>         u32 scratch_32;
> -       pci_read_config_dword(chip->pdev,
> -                             O2_SD_PLL_SETTING, &scratch_32);
> +       pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
>
>         scratch_32 &= 0x0000FFFF;
>         scratch_32 |= value;
>
> -       pci_write_config_dword(chip->pdev,
> -                              O2_SD_PLL_SETTING, scratch_32);
> +       pci_write_config_dword(chip->pdev, O2_SD_PLL_SETTING, scratch_32);
>  }
>
>  static void o2_pci_led_enable(struct sdhci_pci_chip *chip) @@ -40,23 +241,19 @@ static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
>         u32 scratch_32;
>
>         /* Set led of SD host function enable */
> -       ret = pci_read_config_dword(chip->pdev,
> -                                   O2_SD_FUNC_REG0, &scratch_32);
> +       ret = pci_read_config_dword(chip->pdev, O2_SD_FUNC_REG0, &scratch_32);
>         if (ret)
>                 return;
>
>         scratch_32 &= ~O2_SD_FREG0_LEDOFF;
> -       pci_write_config_dword(chip->pdev,
> -                              O2_SD_FUNC_REG0, scratch_32);
> +       pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG0, scratch_32);
>
> -       ret = pci_read_config_dword(chip->pdev,
> -                                   O2_SD_TEST_REG, &scratch_32);
> +       ret = pci_read_config_dword(chip->pdev, O2_SD_TEST_REG, &scratch_32);
>         if (ret)
>                 return;
>
>         scratch_32 |= O2_SD_LED_ENABLE;
> -       pci_write_config_dword(chip->pdev,
> -                              O2_SD_TEST_REG, scratch_32);
> +       pci_write_config_dword(chip->pdev, O2_SD_TEST_REG, scratch_32);
>
>  }
>
> @@ -104,8 +301,7 @@ static void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
>         scratch_32 |= 0x00CC;
>         pci_write_config_dword(chip->pdev, O2_SD_CAP_REG0, scratch_32);
>         /* Set DLL Tuning Window */
> -       ret = pci_read_config_dword(chip->pdev,
> -                                   O2_SD_TUNING_CTRL, &scratch_32);
> +       ret = pci_read_config_dword(chip->pdev, O2_SD_TUNING_CTRL,
> +&scratch_32);
>         if (ret)
>                 return;
>         scratch_32 &= ~(0x000000FF);
> @@ -137,8 +333,7 @@ static void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
>         scratch_32 |= 0x30000000;
>         pci_write_config_dword(chip->pdev, O2_SD_CAPS, scratch_32);
>
> -       ret = pci_read_config_dword(chip->pdev,
> -                                   O2_SD_MISC_CTRL4, &scratch_32);
> +       ret = pci_read_config_dword(chip->pdev, O2_SD_MISC_CTRL4,
> +&scratch_32);
>         if (ret)
>                 return;
>         scratch_32 &= ~(0x000f0000);
> @@ -151,6 +346,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>         struct sdhci_pci_chip *chip;
>         struct sdhci_host *host;
>         u32 reg;
> +       int ret;
>
>         chip = slot->chip;
>         host = slot->host;
> @@ -164,6 +360,22 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>                 if (reg & 0x1)
>                         host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>
> +               if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
> +                       ret = pci_read_config_dword(chip->pdev,
> +                                                   O2_SD_MISC_SETTING, &reg);
> +                       if (ret)
> +                               return -EIO;
> +                       if (reg & (1 << 4)) {
> +                               pr_info("%s: emmc 1.8v flag is set,
> +                                       force 1.8v signaling voltage\n",
> +                                       mmc_hostname(host->mmc));
> +                               host->flags &= ~(SDHCI_SIGNALING_330);
> +                               host->flags |= SDHCI_SIGNALING_180;
> +                       }
> +               }
> +
> +               host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
> +
>                 if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
>                         break;
>                 /* set dll watch dog timer */
> @@ -191,8 +403,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>         case PCI_DEVICE_ID_O2_8320:
>         case PCI_DEVICE_ID_O2_8321:
>                 /* This extra setup is required due to broken ADMA. */
> -               ret = pci_read_config_byte(chip->pdev,
> -                               O2_SD_LOCK_WP, &scratch);
> +               ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
>                 if (ret)
>                         return ret;
>                 scratch &= 0x7f;
> @@ -202,8 +413,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>                 pci_write_config_byte(chip->pdev, O2_SD_MULTI_VCC3V, 0x08);
>
>                 /* Disable CLK_REQ# support after media DET */
> -               ret = pci_read_config_byte(chip->pdev,
> -                               O2_SD_CLKREQ, &scratch);
> +               ret = pci_read_config_byte(chip->pdev, O2_SD_CLKREQ, &scratch);
>                 if (ret)
>                         return ret;
>                 scratch |= 0x20;
> @@ -224,16 +434,14 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>                 pci_write_config_byte(chip->pdev, O2_SD_ADMA2, 0x08);
>
>                 /* Disable the infinite transfer mode */
> -               ret = pci_read_config_byte(chip->pdev,
> -                               O2_SD_INF_MOD, &scratch);
> +               ret = pci_read_config_byte(chip->pdev, O2_SD_INF_MOD, &scratch);
>                 if (ret)
>                         return ret;
>                 scratch |= 0x08;
>                 pci_write_config_byte(chip->pdev, O2_SD_INF_MOD, scratch);
>
>                 /* Lock WP */
> -               ret = pci_read_config_byte(chip->pdev,
> -                               O2_SD_LOCK_WP, &scratch);
> +               ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
>                 if (ret)
>                         return ret;
>                 scratch |= 0x80;
> @@ -243,8 +451,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>         case PCI_DEVICE_ID_O2_SDS1:
>         case PCI_DEVICE_ID_O2_FUJIN2:
>                 /* UnLock WP */
> -               ret = pci_read_config_byte(chip->pdev,
> -                               O2_SD_LOCK_WP, &scratch);
> +               ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
>                 if (ret)
>                         return ret;
>
> @@ -319,15 +526,13 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>                 if (ret)
>                         return ret;
>                 scratch_32 &= ~(0xE0);
> -               pci_write_config_dword(chip->pdev,
> -                                      O2_SD_CAP_REG2, scratch_32);
> +               pci_write_config_dword(chip->pdev, O2_SD_CAP_REG2, scratch_32);
>
>                 if (chip->pdev->device == PCI_DEVICE_ID_O2_FUJIN2)
>                         sdhci_pci_o2_fujin2_pci_init(chip);
>
>                 /* Lock WP */
> -               ret = pci_read_config_byte(chip->pdev,
> -                                          O2_SD_LOCK_WP, &scratch);
> +               ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
>                 if (ret)
>                         return ret;
>                 scratch |= 0x80;
> @@ -336,8 +541,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>         case PCI_DEVICE_ID_O2_SEABIRD0:
>         case PCI_DEVICE_ID_O2_SEABIRD1:
>                 /* UnLock WP */
> -               ret = pci_read_config_byte(chip->pdev,
> -                               O2_SD_LOCK_WP, &scratch);
> +               ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
>                 if (ret)
>                         return ret;
>
> @@ -369,11 +573,9 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>                 }
>
>                 /* Set Tuning Windows to 5 */
> -               pci_write_config_byte(chip->pdev,
> -                               O2_SD_TUNING_CTRL, 0x55);
> +               pci_write_config_byte(chip->pdev, O2_SD_TUNING_CTRL, 0x55);
>                 /* Lock WP */
> -               ret = pci_read_config_byte(chip->pdev,
> -                                          O2_SD_LOCK_WP, &scratch);
> +               ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
>                 if (ret)
>                         return ret;
>                 scratch |= 0x80;
> --
> 2.14.1
