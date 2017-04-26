From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v9 07/16] mmc: sdhci-msm: Add get_min_clock() and
 get_max_clock() callback
Date: Wed, 26 Apr 2017 16:44:43 -0500
Message-ID: <20170426214443.GA32019@hector.attlocal.net>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
 <1479710246-26676-8-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479710246-26676-8-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 21, 2016 at 12:07:17PM +0530, Ritesh Harjani wrote:
> This add get_min_clock() and get_max_clock() callback
> for sdhci-msm. sdhci-msm min/max clocks may be different
> hence implement these callbacks.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

This patch needs to be picked up for stable as 4.9 is currently broken w.r.t.
MMC on Qualcomm platforms.

Fixes: d84be51d1c1d ("mmc: sdhci-msm: Enable few quirks")

Regards,

Andy Gross
