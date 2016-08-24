From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 3/9] mmc: sdhci-msm: add pltfm_data support to get
 clk-rates from DT
Date: Wed, 24 Aug 2016 09:56:25 -0700
Message-ID: <20160824165625.GF15161@tuxbot>
References: <1471581384-18961-1-git-send-email-riteshh@codeaurora.org>
 <1471581384-18961-4-git-send-email-riteshh@codeaurora.org>
 <20160823043121.GC26240@tuxbot>
 <06f079ca-6785-6512-5807-f773a60a5f79@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <06f079ca-6785-6512-5807-f773a60a5f79@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Mon 22 Aug 23:35 PDT 2016, Ritesh Harjani wrote:

> Hi Bjorn,
> 
> 
> On 8/23/2016 10:01 AM, Bjorn Andersson wrote:
> >On Thu 18 Aug 21:36 PDT 2016, Ritesh Harjani wrote:
> >
> >>This adds support for sdhc-msm controllers to get supported
> >>clk-rates from DT. sdhci-msm would need it's own set_clock
> >>ops to be implemented. For this, supported clk-rates needs
> >>to be populated in sdhci_msm_pltfm_data.
> >>
> >>Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> >>---
> >> .../devicetree/bindings/mmc/sdhci-msm.txt          |  1 +
> >> drivers/mmc/host/sdhci-msm.c                       | 71 ++++++++++++++++++++++
> >> 2 files changed, 72 insertions(+)
> >>
> >>diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >>index 485483a..6a83b38 100644
> >>--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >>+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >>@@ -17,6 +17,7 @@ Required properties:
> >> 	"iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
> >> 	"core"	- SDC MMC clock (MCLK) (required)
> >> 	"bus"	- SDCC bus voter clock (optional)
> >>+- clk-rates: Array of supported GCC clock frequencies for sdhc, Units - Hz.
> >>
> >> Example:
> >>
> >>diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> >>index 85ddaae..2bf141b 100644
> >>--- a/drivers/mmc/host/sdhci-msm.c
> >>+++ b/drivers/mmc/host/sdhci-msm.c
> >>@@ -74,6 +74,11 @@
> >> #define CMUX_SHIFT_PHASE_SHIFT	24
> >> #define CMUX_SHIFT_PHASE_MASK	(7 << CMUX_SHIFT_PHASE_SHIFT)
> >>
> >>+struct sdhci_msm_pltfm_data {
> >>+	u32 *clk_table;
> >>+	size_t clk_table_sz;
> >>+};
> >
> >Rather than calling this "platform data", just call it
> >sdhci_msm_freq_table and make it:
> Going ahead this sdhci_msm_pltfm_data will be needed to store
> other stuff as well, hence it will be preferable to have it as pltfm_data
> only.
> 

Ok, that's fine then.

[..]
> >
> >Adding this as a requirement breaks existing platforms/dtbs, you may
> >force it for 8996 if you can detect that, but you should not change it
> >for existing platforms.
> Ok, good point and thanks for catching it.
> Actually I checked all arch/arm64 dts files and could only see 8916.dtsi.
> But I think there would be changes required for arch/arm dts files as well.
> 
> In that case I will add clk entries to other boards as well.
> I will check and see if I can get any of this board to test it on as well.
> 

In the upstream kernel you should be compatible with older DTBs, so
while it's good that you're adding this to the arm dts files, the code
should continue to function without this property - e.g. by falling back
to default values or skipping the new functionality.

(Unless there's a really really good reason for breaking this
compatibility)

Regards,
Bjorn
