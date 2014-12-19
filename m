From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 0/4] mmc: sdhci: Disable re-tuning for HS400
Date: Fri, 19 Dec 2014 16:06:45 +0200
Message-ID: <549430F5.5070300@intel.com>
References: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43644 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbaLSOIx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Dec 2014 09:08:53 -0500
In-Reply-To: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 05/12/14 19:25, Adrian Hunter wrote:
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
> 
>  drivers/mmc/host/sdhci.c  | 66 ++++++++++++++++++++++++++++++-----------------
>  include/linux/mmc/sdhci.h |  1 +
>  2 files changed, 43 insertions(+), 24 deletions(-)

Ulf, will you take these?

