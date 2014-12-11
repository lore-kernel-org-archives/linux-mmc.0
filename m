From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH V2 0/4] mmc: sdhci: Disable re-tuning for HS400
Date: Thu, 11 Dec 2014 16:29:51 +0800
Message-ID: <548955FF.7070903@intel.com>
References: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41418 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932397AbaLKI36 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Dec 2014 03:29:58 -0500
In-Reply-To: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 12/06/2014 01:25 AM, Adrian Hunter wrote:
> Hi
> 
> Here is V2 of patches to disable re-tuning for HS400.
> 
> As described in patch 4, re-tuning for HS400 has to be done
> in HS200 mode, but there is no support for that, so re-tuning
> needs to be disabled until support is added.
> 
> Changes in V2:
> 
> 	Added "mmc: sdhci: Simplify use of tuning timer"
> 	patch.
> 
> 	Changed "mmc: sdhci: Disable re-tuning for HS400"
> 	so that the tuning timer is not started instead
> 	of stopping it when HS400 mode is selected.
> 
> 
> Adrian Hunter (4):
>       mmc: sdhci: Tuning should not change max_blk_count
>       mmc: sdhci: Add out_unlock to sdhci_execute_tuning
>       mmc: sdhci: Simplify use of tuning timer
>       mmc: sdhci: Disable re-tuning for HS400

For patch 1-3: Reviewed-by: Aaron Lu <aaron.lu@intel.com>

Thanks,
Aaron

> 
>  drivers/mmc/host/sdhci.c  | 66 ++++++++++++++++++++++++++++++-----------------
>  include/linux/mmc/sdhci.h |  1 +
>  2 files changed, 43 insertions(+), 24 deletions(-)
> 
> 
> Regards
> Adrian
> 

