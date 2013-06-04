From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/4] mmc: core: Let the mmc_bus handle suspend|resume
 sequence
Date: Tue, 04 Jun 2013 18:53:45 +0900
Message-ID: <51ADB929.9030705@samsung.com>
References: <1369918391-15277-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55644 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab3FDJx2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2013 05:53:28 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNV00BUB4T39QL0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Jun 2013 18:53:27 +0900 (KST)
In-reply-to: <1369918391-15277-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 05/30/2013 09:53 PM, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> The MMC/SD/SDIO cards are registered on the mmc_bus and should from a power
> management perspective be controlled from there. As of today each and every
> host driver needs to issue mmc_suspend|resume_host from their respective
> .suspend|resume methods, which seems like an unnecessary requirement to
> put on them.
> 
> This patch set moves the responsiblity to suspend the cards into the mmc_bus.
> In this patch set, the mmc_suspend|resume_host functions are not removed, but
> will instead always return successful. As a separate patch build on top of
> this patch set, we shall remove the API:s together with updating each and
> every host driver.
> 
> Ulf Hansson (4):
>   mmc: core: Remove unnecessary check for the remove callback
>   mmc: core: Validate suspend prerequisites for SDIO at SUSPEND_PREPARE
>   mmc: core: Push common suspend|resume code into each bus_ops
>   mmc: core: Initiate suspend|resume from mmc bus instead of mmc host
> 
>  drivers/mmc/core/bus.c  |   28 ++++++++++++++-
>  drivers/mmc/core/core.c |   87 ++++++++---------------------------------------
>  drivers/mmc/core/core.h |    1 +
>  drivers/mmc/core/mmc.c  |    4 +++
>  drivers/mmc/core/sd.c   |    4 +++
>  drivers/mmc/core/sdio.c |   48 +++++++++++++++++++++++---
>  6 files changed, 94 insertions(+), 78 deletions(-)
> 

