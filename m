From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] mmc: core: Fixup Oops for SDIO shutdown
Date: Tue, 02 Jul 2013 09:15:44 -0600
Message-ID: <51D2EEA0.1050804@wwwdotorg.org>
References: <1372762381-18832-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:56389 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab3GBPPr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jul 2013 11:15:47 -0400
In-Reply-To: <1372762381-18832-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Jaehoon Chung <jh80.chung@samsung.com>

On 07/02/2013 04:53 AM, Ulf Hansson wrote:
> Commit "mmc: core: Handle card shutdown from mmc_bus" introduced an
> Oops in the shutdown sequence for SDIO.
> 
> The drv pointer, does not exist for SDIO since the probing of the SDIO
> card from the mmc_bus perspective is expected to fail by returning
> -ENODEV.
> 
> This patch adds the proper check for the pointer before calling it.

Tested-by: Stephen Warren <swarren@nvidia.com>

Thanks!
