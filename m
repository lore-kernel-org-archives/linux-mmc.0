From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Adding callback in sdhci_calc_clk for geting clk divider
Date: Thu, 11 Aug 2016 19:22:52 +0530
Message-ID: <1470923574-411-1-git-send-email-riteshh@codeaurora.org>
References: <a48103a7-1aa2-b9e2-527c-c7237a9ea9c0@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59430 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbcHKNxO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Aug 2016 09:53:14 -0400
In-Reply-To: <a48103a7-1aa2-b9e2-527c-c7237a9ea9c0@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

Hi Shawn, 

I have added the callback inside sdhci_calc_clk and removed the quirk.
Do you think this will be the right approach? 
Please let me know for more pointers otherwise.

Regards
Ritesh

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

