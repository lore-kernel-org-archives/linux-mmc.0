From: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [PATCH 3/5] mmc: msm_sdcc: Reset SDCC in case of data transfer
 errors
Date: Tue, 07 Dec 2010 10:33:22 -0800
Message-ID: <1291746802.8000.17.camel@c-dwalke-linux.qualcomm.com>
References: <1291719316-23948-1-git-send-email-stummala@codeaurora.org>
	 <1291719316-23948-3-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:4746 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab0LGSdf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 13:33:35 -0500
In-Reply-To: <1291719316-23948-3-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, san@google.com, linux-arm-msm@vger.kernel.org

On Tue, 2010-12-07 at 16:25 +0530, Sahitya Tummala wrote:
> Reset SDCC in case of data transfer errors to ensure that
> any left over data in FIFOs is flushed out.

Does this cause a problem which you have observed? If so please describe
it in the commit text.

Daniel
-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

