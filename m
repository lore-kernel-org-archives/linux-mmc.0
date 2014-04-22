From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH RFC 00/12] Add Qualcomm SD Card Controller support.
Date: Tue, 22 Apr 2014 08:58:32 -0400
Message-ID: <53566778.5090603@codeaurora.org>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:59733 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbaDVM6k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Apr 2014 08:58:40 -0400
In-Reply-To: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: linux-mmc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, agross@quicinc.com, linux-arm-msm@vger.kernel.org

Hi Srini,

On 04/21/2014 05:43 PM, srinivas.kandagatla@linaro.org wrote:

> This patches are tested in PIO mode on IFC8064 board with both eMMC and
> external SD card. I would appreciate any feedback/suggestions on the overall
> approach.

Is a non-upstream device tree needed to reproduce your test setup? If so could
you please point to or post it?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
