From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: rtsx: fix tuning fail on gen3 PCI-Express
Date: Wed, 27 Sep 2017 00:24:27 +0200
Message-ID: <CAPDyKFp8eVXHG3TUHdWofTynBsHvvMq4DwH_Q1T7VHkryRukmA@mail.gmail.com>
References: <1506067655-30190-1-git-send-email-rui_feng@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506067655-30190-1-git-send-email-rui_feng@realsil.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: rui_feng@realsil.com.cn
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 September 2017 at 10:07,  <rui_feng@realsil.com.cn> wrote:
> From: rui_feng <rui_feng@realsil.com.cn>
>
> On gen3 PCI-Express we should send command one by one.
> If sending many commands in one packet will lead to a failure.
>
> Signed-off-by: rui_feng <rui_feng@realsil.com.cn>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 38 ++++++++++++++++++--------------------
>  include/linux/mfd/rtsx_pci.h      |  1 +
>  2 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 41b5771..0848dc0 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -618,29 +618,22 @@ static int sd_change_phase(struct realtek_pci_sdmmc *host,
>                 u8 sample_point, bool rx)
>  {
>         struct rtsx_pcr *pcr = host->pcr;
> -       int err;
>
>         dev_dbg(sdmmc_dev(host), "%s(%s): sample_point = %d\n",
>                         __func__, rx ? "RX" : "TX", sample_point);
>
> -       rtsx_pci_init_cmd(pcr);
> -
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CLK_CTL, CHANGE_CLK, CHANGE_CLK);
> +       rtsx_pci_write_register(pcr, CLK_CTL, CHANGE_CLK, CHANGE_CLK);
>         if (rx)
> -               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD,
> -                               SD_VPRX_CTL, 0x1F, sample_point);
> +               rtsx_pci_write_register(pcr, SD_VPRX_CTL,
> +                       PHASE_SELECT_MASK, sample_point);
>         else
> -               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD,
> -                               SD_VPTX_CTL, 0x1F, sample_point);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_VPCLK0_CTL, PHASE_NOT_RESET, 0);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_VPCLK0_CTL,
> -                       PHASE_NOT_RESET, PHASE_NOT_RESET);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CLK_CTL, CHANGE_CLK, 0);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
> -
> -       err = rtsx_pci_send_cmd(pcr, 100);
> -       if (err < 0)
> -               return err;
> +               rtsx_pci_write_register(pcr, SD_VPTX_CTL,
> +                       PHASE_SELECT_MASK, sample_point);
> +       rtsx_pci_write_register(pcr, SD_VPCLK0_CTL, PHASE_NOT_RESET, 0);
> +       rtsx_pci_write_register(pcr, SD_VPCLK0_CTL, PHASE_NOT_RESET,
> +                               PHASE_NOT_RESET);
> +       rtsx_pci_write_register(pcr, CLK_CTL, CHANGE_CLK, 0);
> +       rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
>
>         return 0;
>  }
> @@ -708,10 +701,12 @@ static int sd_tuning_rx_cmd(struct realtek_pci_sdmmc *host,
>  {
>         int err;
>         struct mmc_command cmd = {};
> +       struct rtsx_pcr *pcr = host->pcr;
>
> -       err = sd_change_phase(host, sample_point, true);
> -       if (err < 0)
> -               return err;
> +       sd_change_phase(host, sample_point, true);
> +
> +       rtsx_pci_write_register(pcr, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
> +               SD_RSP_80CLK_TIMEOUT_EN);
>
>         cmd.opcode = opcode;
>         err = sd_read_data(host, &cmd, 0x40, NULL, 0, 100);
> @@ -719,9 +714,12 @@ static int sd_tuning_rx_cmd(struct realtek_pci_sdmmc *host,
>                 /* Wait till SD DATA IDLE */
>                 sd_wait_data_idle(host);
>                 sd_clear_error(host);
> +               rtsx_pci_write_register(pcr, SD_CFG3,
> +                       SD_RSP_80CLK_TIMEOUT_EN, 0);
>                 return err;
>         }
>
> +       rtsx_pci_write_register(pcr, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN, 0);
>         return 0;
>  }
>
> diff --git a/include/linux/mfd/rtsx_pci.h b/include/linux/mfd/rtsx_pci.h
> index a40abaa..84a5dde 100644
> --- a/include/linux/mfd/rtsx_pci.h
> +++ b/include/linux/mfd/rtsx_pci.h
> @@ -334,6 +334,7 @@
>  #define DCM_DRP_RD_DATA_H              0xFC29
>  #define SD_VPCLK0_CTL                  0xFC2A
>  #define SD_VPCLK1_CTL                  0xFC2B
> +#define   PHASE_SELECT_MASK            0x1F
>  #define SD_DCMPS0_CTL                  0xFC2C
>  #define SD_DCMPS1_CTL                  0xFC2D
>  #define SD_VPTX_CTL                    SD_VPCLK0_CTL
> --
> 1.9.1
>
