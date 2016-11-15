From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v7 08/14] mmc: sdhci-msm: Implement set_clock callback
 for sdhci-msm
Date: Tue, 15 Nov 2016 11:27:27 -0800
Message-ID: <20161115192727.GD25626@codeaurora.org>
References: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
 <1479103248-9491-9-git-send-email-riteshh@codeaurora.org>
 <20161114193004.GI5177@codeaurora.org>
 <3c1a7c72-0ac1-8ed0-87fc-238331f0645b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3c1a7c72-0ac1-8ed0-87fc-238331f0645b@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 11/15, Ritesh Harjani wrote:
> On 11/15/2016 1:07 AM, Stephen Boyd wrote:
> >On 11/14, Ritesh Harjani wrote:
> >
> >>+}
> >>+
> >>+/* sdhci_msm_set_clock - Called with (host->lock) spinlock held. */
> >>+static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
> >>+{
> >>+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> >>+	int rc;
> >>+
> >>+	if (!clock) {
> >>+		msm_host->clk_rate = clock;
> >>+		goto out;
> >>+	}
> >>+
> >>+	spin_unlock_irq(&host->lock);
> >>+	if (clock != msm_host->clk_rate) {
> >
> >Why do we need to check here? Can't we call clk_set_rate()
> >Unconditionally?
> Since it may so happen that above layers may call for ->set_clock
> function with same requested clock more than once, hence we cache
> the host->clock here.
> Also, since requested clock (host->clock) can be say 400Mhz but the
> actual pltfm supported clock would be say 384MHz.

clk_set_rate() detects the same rate being set even after it
internally rounds the rate. We're not going to touch the clk
hardware if 400 is requested once but 384 is what's set and then
400 is requested again. Caching the rate here in the driver can
lead to problems too if the driver is out of sync with the clk
hardware state, so it's best to avoid doing anything fancy here
and just let the framework handle duplicates.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
