From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 1/4] mmc: host: Register changes for sdcc V5
Date: Wed, 2 May 2018 10:28:14 +0200
Message-ID: <CAPDyKFq9vbCB_g+JYDPnm3M1yuZ3wTv3oq-zBDgo1ev+3bFLSw@mail.gmail.com>
References: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org> <1525171153-24476-2-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525171153-24476-2-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Jeremy McNicoll <jeremymc@redhat.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Harjani Ritesh <riteshh@codeaurora.org>, vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 1 May 2018 at 12:39, Vijay Viswanath <vviswana@codeaurora.org> wrote:
> From: Sayali Lokhande <sayalil@codeaurora.org>
>
> For SDCC version 5.0.0, MCI registers are removed from SDCC
> interface and some registers are moved to HC. This change is
> to support MCI register removal for msmfalcon. New compatible
> string "qcom,sdhci-msm-v5" is added for msmfalcon to support
> this change.

To simplify review, I would recommend to split this up in a few more
pieces, a few re-factoring while the final change adds the
qcom,sdhci-msm-v5 support.

>
> Change-Id: I0febfd9bb2222436a8eff20c20107dd4180c9781
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |   5 +-

Please move DT changes into separate patches and make sure to sent it
to DT maintainers as well.

>  drivers/mmc/host/sdhci-msm.c                       | 485 +++++++++++++++------
>  2 files changed, 365 insertions(+), 125 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index bfdcdc4..c2b7b2b 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -4,7 +4,10 @@ This file documents differences between the core properties in mmc.txt
>  and the properties used by the sdhci-msm driver.
>
>  Required properties:
> -- compatible: Should contain "qcom,sdhci-msm-v4".
> +- compatible: Should contain "qcom,sdhci-msm-v4" or "qcom,sdhci-msm-v5".
> +                For SDCC version 5.0.0, MCI registers are removed from SDCC
> +                interface and some registers are moved to HC. New compatible
> +                string is added to support this change - "qcom,sdhci-msm-v5".
>  - reg: Base address and length of the register in the following order:
>         - Host controller register map (required)
>         - SD Core register map (required)
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index bb11916..d4d432b 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c

[...]

>
> +struct sdhci_msm_offset {

I think a better idea is to create a struct sdhci_msm_variant and make
it contain all the variant specific data. So, not only the offsets,
but other variant data as well.

More comments below.

> +       u32 core_mci_data_cnt;
> +       u32 core_mci_status;
> +       u32 core_mci_fifo_cnt;
> +       u32 core_mci_version;
> +       u32 core_generics;
> +       u32 core_testbus_config;
> +       u32 core_testbus_sel2_bit;
> +       u32 core_testbus_ena;
> +       u32 core_testbus_sel2;
> +       u32 core_pwrctl_status;
> +       u32 core_pwrctl_mask;
> +       u32 core_pwrctl_clear;
> +       u32 core_pwrctl_ctl;
> +       u32 core_sdcc_debug_reg;
> +       u32 core_dll_config;
> +       u32 core_dll_status;
> +       u32 core_vendor_spec;
> +       u32 core_vendor_spec_adma_err_addr0;
> +       u32 core_vendor_spec_adma_err_addr1;
> +       u32 core_vendor_spec_func2;
> +       u32 core_vendor_spec_capabilities0;
> +       u32 core_ddr_200_cfg;
> +       u32 core_vendor_spec3;
> +       u32 core_dll_config_2;
> +       u32 core_ddr_config;
> +       u32 core_ddr_config_2;
> +};
> +
> +struct sdhci_msm_offset sdhci_msm_offset_mci_removed = {
> +       .core_mci_data_cnt = 0x35c,
> +       .core_mci_status = 0x324,
> +       .core_mci_fifo_cnt = 0x308,
> +       .core_mci_version = 0x318,
> +       .core_generics = 0x320,
> +       .core_testbus_config = 0x32c,
> +       .core_testbus_sel2_bit = 3,
> +       .core_testbus_ena = (1 << 31),
> +       .core_testbus_sel2 = (1 << 3),
> +       .core_pwrctl_status = 0x240,
> +       .core_pwrctl_mask = 0x244,
> +       .core_pwrctl_clear = 0x248,
> +       .core_pwrctl_ctl = 0x24c,
> +       .core_sdcc_debug_reg = 0x358,
> +       .core_dll_config = 0x200,
> +       .core_dll_status = 0x208,
> +       .core_vendor_spec = 0x20c,
> +       .core_vendor_spec_adma_err_addr0 = 0x214,
> +       .core_vendor_spec_adma_err_addr1 = 0x218,
> +       .core_vendor_spec_func2 = 0x210,
> +       .core_vendor_spec_capabilities0 = 0x21c,
> +       .core_ddr_200_cfg = 0x224,
> +       .core_vendor_spec3 = 0x250,
> +       .core_dll_config_2 = 0x254,
> +       .core_ddr_config = 0x258,
> +       .core_ddr_config_2 = 0x25c,
> +};
> +
> +struct sdhci_msm_offset sdhci_msm_offset_mci_present = {
> +       .core_mci_data_cnt = 0x30,
> +       .core_mci_status = 0x34,
> +       .core_mci_fifo_cnt = 0x44,
> +       .core_mci_version = 0x050,
> +       .core_generics = 0x70,
> +       .core_testbus_config = 0x0CC,
> +       .core_testbus_sel2_bit = 4,
> +       .core_testbus_ena = (1 << 3),
> +       .core_testbus_sel2 = (1 << 4),
> +       .core_pwrctl_status = 0xDC,
> +       .core_pwrctl_mask = 0xE0,
> +       .core_pwrctl_clear = 0xE4,
> +       .core_pwrctl_ctl = 0xE8,
> +       .core_sdcc_debug_reg = 0x124,
> +       .core_dll_config = 0x100,
> +       .core_dll_status = 0x108,
> +       .core_vendor_spec = 0x10C,
> +       .core_vendor_spec_adma_err_addr0 = 0x114,
> +       .core_vendor_spec_adma_err_addr1 = 0x118,
> +       .core_vendor_spec_func2 = 0x110,
> +       .core_vendor_spec_capabilities0 = 0x11C,
> +       .core_ddr_200_cfg = 0x184,
> +       .core_vendor_spec3 = 0x1B0,
> +       .core_dll_config_2 = 0x1B4,
> +       .core_ddr_config = 0x1B8,
> +       .core_ddr_config_2 = 0x1BC,
> +};
> +
>  struct sdhci_msm_host {
>         struct platform_device *pdev;
>         void __iomem *core_mem; /* MSM SDCC mapped address */
> @@ -156,8 +232,72 @@ struct sdhci_msm_host {
>         wait_queue_head_t pwr_irq_wait;
>         bool pwr_irq_flag;
>         u32 caps_0;
> +       bool mci_removed;
> +       const struct sdhci_msm_offset *offset;
>  };
>
> +/*
> + * APIs to write to vendor specific registers which were there in the core_mem
> + * region before MCI was removed.
> + */
> +u8 sdhci_msm_vendor_readb_relaxed(struct sdhci_host *host, u32 offset)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       void __iomem *base_addr;
> +
> +       if (msm_host->mci_removed)
> +               base_addr = host->ioaddr;

I would rather use a separate set of functions, which you assign at ->probe().

That may speed things up a little bit, as you don't need to check for
"mci_removed", each time in these read/write functions.

> +       else
> +               base_addr = msm_host->core_mem;
> +
> +       return readb_relaxed(base_addr + offset);
> +}

[...]

>  static const struct of_device_id sdhci_msm_dt_match[] = {
>         { .compatible = "qcom,sdhci-msm-v4" },
> +       {.compatible = "qcom,sdhci-msm-v5"},
>         {},
>  };
>
> @@ -1430,6 +1651,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         u16 host_version, core_minor;
>         u32 core_version, config;
>         u8 core_major;
> +       const struct sdhci_msm_offset *msm_offset;
>
>         host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
>         if (IS_ERR(host))
> @@ -1445,6 +1667,15 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         if (ret)
>                 goto pltfm_free;
>
> +       if (of_find_compatible_node(NULL, NULL, "qcom,sdhci-msm-v5")) {
> +               msm_host->mci_removed = true;
> +               msm_host->offset = &sdhci_msm_offset_mci_removed;

I would suggest to extend your array of "struct of_device_id" to use
the .data member to store all the variant specific data (such as the
offsets for example).

Then you can use of_device_get_match_data(), to get the variant data.

> +       } else {
> +               msm_host->mci_removed = false;
> +               msm_host->offset = &sdhci_msm_offset_mci_present;
> +       }
> +       msm_offset = msm_host->offset;
> +

[...]

Kind regards
Uffe
