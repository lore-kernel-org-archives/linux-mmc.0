From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: Add support for IMG Pistachio
Date: Wed, 19 Nov 2014 12:04:05 +0100
Message-ID: <CAPDyKFp0JA5QR9zx8zE0y=Z7zOSM6pE=Th0GEMcUjKjRVULu_w@mail.gmail.com>
References: <1415904621-26800-1-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:62597 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbaKSLEG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 06:04:06 -0500
Received: by mail-qc0-f172.google.com with SMTP id m20so206720qcx.3
        for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2014 03:04:05 -0800 (PST)
In-Reply-To: <1415904621-26800-1-git-send-email-abrestic@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, James Hartley <James.Hartley@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, Doug Anderson <dianders@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 13 November 2014 19:50, Andrew Bresticker <abrestic@chromium.org> wrote:
> Add support for the DW MMC host found on the Imagination Pistachio SoC.
> Like the DW MMC hosts found on SOCFPGA and Rockchip SoCs, the DW MMC
> host on Pistachio requires the use of SDMMC_CMD_USE_HOLD_REG.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/img-dw-mshc.txt        | 29 ++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc-pltfm.c                    |  6 +++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
> new file mode 100644
> index 0000000..85de99f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
> @@ -0,0 +1,29 @@
> +* Imagination specific extensions to the Synopsys Designware Mobile Storage
> +  Host Controller
> +
> +The Synopsys designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsys dw mshc controller properties described
> +by synopsys-dw-mshc.txt and the properties used by the Imagination specific
> +extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be
> +       - "img,pistachio-dw-mshc": for Pistachio SoCs
> +
> +Example:
> +
> +       mmc@18142000 {
> +               compatible = "img,pistachio-dw-mshc";
> +               reg = <0x18142000 0x400>;
> +               interrupts = <GIC_SHARED 39 IRQ_TYPE_LEVEL_HIGH>;
> +
> +               clocks = <&system_clk>, <&sdhost_clk>;
> +               clock-names = "biu", "ciu";
> +
> +               fifo-depth = <0x20>;
> +               bus-width = <4>;
> +               num-slots = <1>;
> +               disable-wp;
> +       };
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 8b65721..ec6dbcd 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -35,6 +35,10 @@ static const struct dw_mci_drv_data socfpga_drv_data = {
>         .prepare_command        = dw_mci_pltfm_prepare_command,
>  };
>
> +static const struct dw_mci_drv_data pistachio_drv_data = {
> +       .prepare_command        = dw_mci_pltfm_prepare_command,
> +};
> +
>  int dw_mci_pltfm_register(struct platform_device *pdev,
>                           const struct dw_mci_drv_data *drv_data)
>  {
> @@ -90,6 +94,8 @@ static const struct of_device_id dw_mci_pltfm_match[] = {
>         { .compatible = "snps,dw-mshc", },
>         { .compatible = "altr,socfpga-dw-mshc",
>                 .data = &socfpga_drv_data },
> +       { .compatible = "img,pistachio-dw-mshc",
> +               .data = &pistachio_drv_data },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
> --
> 2.1.0.rc2.206.gedb03e5
>
