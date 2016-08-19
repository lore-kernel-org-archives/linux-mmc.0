From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 1/9] mmc: sdhci-msm: Change poor style writel/readl of
 registers
Date: Fri, 19 Aug 2016 16:02:43 +0300
Message-ID: <07883c83-edca-de9e-61b6-ab5116017f1e@intel.com>
References: <1471581384-18961-1-git-send-email-riteshh@codeaurora.org>
 <1471581384-18961-2-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6476 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754171AbcHSNHP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 19 Aug 2016 09:07:15 -0400
In-Reply-To: <1471581384-18961-2-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, bjorn.andersson@linaro.org, shawn.lin@rock-chips.com, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org

On 19/08/16 07:36, Ritesh Harjani wrote:
> This patch changes the poor style of writel/readl registers
> into more readable format. Also to avoid mixed style format
> of readl/writel in sdhci-msm driver.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


