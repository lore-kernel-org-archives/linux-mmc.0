From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Subject: Re: [PATCH] mmc: core: Fixup Oops for SDIO shutdown
Date: Tue, 2 Jul 2013 13:58:56 +0300
Message-ID: <51D2B270.8000603@nvidia.com>
References: <1372762381-18832-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:18875 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3GBK7A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jul 2013 06:59:00 -0400
In-Reply-To: <1372762381-18832-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Warren <swarren@wwwdotorg.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 07/02/2013 01:53 PM, Ulf Hansson wrote:
> Commit "mmc: core: Handle card shutdown from mmc_bus" introduced an
> Oops in the shutdown sequence for SDIO.
> 
> The drv pointer, does not exist for SDIO since the probing of the SDIO
> card from the mmc_bus perspective is expected to fail by returning
> -ENODEV.
> 
> This patch adds the proper check for the pointer before calling it.
> 
> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
> Reported-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Hi,

That fixes it, thanks.

Tested-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
