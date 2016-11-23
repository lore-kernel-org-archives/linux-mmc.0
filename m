From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v9 02/16] clk: qcom: Move all sdcc rcgs to use
 clk_rcg2_floor_ops
Date: Wed, 23 Nov 2016 11:00:18 -0800
Message-ID: <20161123190018.GD25626@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
 <1479710246-26676-3-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41728 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933649AbcKWTAX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 14:00:23 -0500
Content-Disposition: inline
In-Reply-To: <1479710246-26676-3-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, andy.gross@linaro.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com

On 11/21, Ritesh Harjani wrote:
> From: Rajendra Nayak <rnayak@codeaurora.org>
> 
> The sdcc driver for msm8996/msm8916/msm8974/msm8994 and apq8084
> expects a clk_set_rate() on the sdcc rcg clk to set
> a floor value of supported clk rate closest to the requested
> rate, by looking up the frequency table.
> So move all the sdcc rcgs on all these platforms to use the
> newly introduced clk_rcg2_floor_ops
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
