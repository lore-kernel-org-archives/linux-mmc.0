From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 3/9] mmc: sdhci-msm: add pltfm_data support to get clk-rates from DT
Date: Mon, 12 Sep 2016 09:33:25 +0200
Message-ID: <2575923.JUIzEdKygq@wuerfel>
References: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org> <1472033024-14890-4-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1472033024-14890-4-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, bjorn.andersson@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday, August 24, 2016 3:33:38 PM CEST Ritesh Harjani wrote:
>  #define CMUX_SHIFT_PHASE_SHIFT 24
>  #define CMUX_SHIFT_PHASE_MASK  (7 << CMUX_SHIFT_PHASE_SHIFT)
>  
> +struct sdhci_msm_pltfm_data {
> +       u32 *clk_table;
> +       int clk_table_sz;
> +};
> +
>  struct sdhci_msm_host {
>         struct platform_device *pdev;
>         void __iomem *core_mem; /* MSM SDCC mapped address */
> @@ -83,6 +88,7 @@ struct sdhci_msm_host {
>         struct clk *bus_clk;    /* SDHC bus voter clock */
>         struct mmc_host *mmc;
>         bool use_14lpp_dll_reset;
> +       struct sdhci_msm_pltfm_data *pdata;
>  };
>  
>  /* Platform specific tuning */
> 

Just noticed this. Please don't add another structure, just put the
new members into struct sdhci_msm_host directly.

We only need platform_data structures for drivers that also work
with old-style board files, which this one doesn't.

	Arnd
