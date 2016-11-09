From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 05/14] mmc: sdhci-msm: Update DLL reset sequence
Date: Wed, 9 Nov 2016 12:43:04 -0800
Message-ID: <20161109204304.GT16026@codeaurora.org>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
 <1478517877-23733-6-git-send-email-riteshh@codeaurora.org>
 <20161108230622.GN16026@codeaurora.org>
 <10d66d21-eebd-45a3-6fb7-72117d860142@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <10d66d21-eebd-45a3-6fb7-72117d860142@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 11/09, Ritesh Harjani wrote:
> Hi Stephen,
> 
> On 11/9/2016 4:36 AM, Stephen Boyd wrote:
> >On 11/07, Ritesh Harjani wrote:
> >>
> >>diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> >>index 42f42aa..32b0b79 100644
> >>--- a/drivers/mmc/host/sdhci-msm.c
> >>+++ b/drivers/mmc/host/sdhci-msm.c
> >>@@ -58,11 +58,17 @@
> >> #define CORE_DLL_CONFIG		0x100
> >> #define CORE_DLL_STATUS		0x108
> >>
> >>+#define CORE_DLL_CONFIG_2	0x1b4
> >>+#define CORE_FLL_CYCLE_CNT	BIT(18)
> >>+#define CORE_DLL_CLOCK_DISABLE	BIT(21)
> >>+
> >> #define CORE_VENDOR_SPEC	0x10c
> >> #define CORE_CLK_PWRSAVE	BIT(1)
> >>
> >> #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
> >>
> >>+#define TCXO_FREQ		19200000
> >
> >TCXO_FREQ could change based on the board. For example, IPQ has
> >it as 25 MHz.
> Actually not sure of the proper way on how to get this freq in driver
> today. We may use xo_board clock but, it is not available for all boards
> except 8996/8916 I guess.
> 
> Also, there is no sdhc for IPQ board and for all other boards
> TCXO_FREQ is same where sdhci-msm driver is used. For that purpose
> this was defined here for sdhci-msm driver.
> 
> Do you think in that case we should keep it this way for now and
> later change if a need arise to change the TCXO_FREQ ?

We've added xo_board (or cxo_board/pxo_board) to all the qcom
platforms upstream, so there should always be something to
reference in the dts and call clk_get_rate() on. So I would add
it to the binding as another clock and then use that instead of
hardcoding the value. That's much more flexible in case this
changes in the future.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
