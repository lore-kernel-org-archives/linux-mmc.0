From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 4/4] mmc: core: Implement mmc_partial_init during
 resume
Date: Tue, 21 Feb 2017 09:40:52 +0200
Message-ID: <42634177-bec7-4968-a313-26714bfa2594@intel.com>
References: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
 <1487577792-12510-5-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1487577792-12510-5-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, linux-kernel@vger.kernel.org, Talel Shenhar <tatias@codeaurora.org>, Maya Erez <merez@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 20/02/17 10:03, Ritesh Harjani wrote:
> This patch adds mmc_partial_init functionality
> combining with CMD5 awake feature to reduce resume
> latency for emmc.
> 
> This is not enabled for HS400 mode, since tuning
> in HS400 is required to be done in HS200 timing.

How does that matter?
