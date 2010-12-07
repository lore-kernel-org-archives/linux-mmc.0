From: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [PATCH 1/5] mmc: msm_sdcc: Fix possible circular locking
 dependency warning
Date: Tue, 07 Dec 2010 10:15:53 -0800
Message-ID: <1291745753.8000.3.camel@c-dwalke-linux.qualcomm.com>
References: <1291719316-23948-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:34811 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab0LGSQJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 13:16:09 -0500
In-Reply-To: <1291719316-23948-1-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, san@google.com, linux-arm-msm@vger.kernel.org

On Tue, 2010-12-07 at 16:25 +0530, Sahitya Tummala wrote:
> In the context of request processing thread, data mover lock is
> acquired after the host lock.  In another context, in the completion
> handler of data mover the locks are acquired in the reverse order,
> resulting in possible circular lock dependency warning. Hence,
> schedule a tasklet to process the dma completion so as to avoid
> nested locks.

Can you provide and example of the warning ? Not in the commit, but in
this thread.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

