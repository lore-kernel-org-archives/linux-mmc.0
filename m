From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6 08/14] mmc: sdhci-msm: Implement set_clock callback for
 sdhci-msm
Date: Tue, 8 Nov 2016 14:16:11 +0200
Message-ID: <432247af-a9f1-e9f3-cbc9-09ed262ad3da@intel.com>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
 <1478517877-23733-9-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23769 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752196AbcKHMVM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Nov 2016 07:21:12 -0500
In-Reply-To: <1478517877-23733-9-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, sboyd@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org

On 07/11/16 13:24, Ritesh Harjani wrote:
> sdhci-msm controller may have different clk-rates for each
> bus speed mode. Thus implement set_clock callback for
> sdhci-msm driver.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


