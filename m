From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: stop building qcom dml as module
Date: Mon, 21 Aug 2017 14:33:55 +0200
Message-ID: <CAPDyKFoVTASsnmx_Dz4MdPxVQOFVL=d6xQHiT3DVRBRJphRamw@mail.gmail.com>
References: <20170810145418.4430-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170810145418.4430-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 10 August 2017 at 16:54,  <srinivas.kandagatla@linaro.org> wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> It does not make sense for qcom dml code to be a seperate module, as
> this has just 2 helper functions specific to qcom, and used directly by
> mmci driver, so just compile this along with main mmci driver.
>
> This would also fix issues arrising due to Kconfig combinations between
> mmci and qcom dml.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/mmc/host/Kconfig         | 2 +-
>  drivers/mmc/host/Makefile        | 5 +++--
>  drivers/mmc/host/mmci_qcom_dml.h | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5755b69..3345384 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -15,7 +15,7 @@ config MMC_ARMMMCI
>           If unsure, say N.
>
>  config MMC_QCOM_DML
> -       tristate "Qualcomm Data Mover for SD Card Controller"
> +       bool "Qualcomm Data Mover for SD Card Controller"
>         depends on MMC_ARMMMCI && QCOM_BAM_DMA
>         default y
>         help
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 4d45471..ef12fd2 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -2,8 +2,9 @@
>  # Makefile for MMC/SD host controller drivers
>  #
>
> -obj-$(CONFIG_MMC_ARMMMCI)      += mmci.o
> -obj-$(CONFIG_MMC_QCOM_DML)     += mmci_qcom_dml.o
> +obj-$(CONFIG_MMC_ARMMMCI) += armmmci.o
> +armmmci-y := mmci.o
> +armmmci-$(CONFIG_MMC_QCOM_DML) += mmci_qcom_dml.o
>  obj-$(CONFIG_MMC_PXA)          += pxamci.o
>  obj-$(CONFIG_MMC_MXC)          += mxcmmc.o
>  obj-$(CONFIG_MMC_MXS)          += mxs-mmc.o
> diff --git a/drivers/mmc/host/mmci_qcom_dml.h b/drivers/mmc/host/mmci_qcom_dml.h
> index 6e405d0..9df32eb 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.h
> +++ b/drivers/mmc/host/mmci_qcom_dml.h
> @@ -15,7 +15,7 @@
>  #ifndef __MMC_QCOM_DML_H__
>  #define __MMC_QCOM_DML_H__
>
> -#ifdef CONFIG_MMC_QCOM_DML
> +#if IS_ENABLED(CONFIG_MMC_QCOM_DML)

Because you change CONFIG_MMC_QCOM_DML beeing a bool instead of
tristate, then I don't think you need to change this to IS_ENABLED().

Correct!?

>  int dml_hw_init(struct mmci_host *host, struct device_node *np);
>  void dml_start_xfer(struct mmci_host *host, struct mmc_data *data);
>  #else
> --
> 2.9.3
>

Otherwise this looks good to me.

Kind regards
Uffe
