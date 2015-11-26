From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/2] sdio: Prevent re-tuning conflicting with custom sleep
Date: Thu, 26 Nov 2015 14:58:38 +0200
Message-ID: <565701FE.9010403@intel.com>
References: <1430232341-8307-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31621 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbbKZNBt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 08:01:49 -0500
In-Reply-To: <1430232341-8307-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Arend van Spriel <arend@broadcom.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 28/04/15 17:45, Adrian Hunter wrote:
> Here are 2 patches that allow brcmfmac to awake from a
> custom sleep state that conflicts with re-tuning.
> 
> The first patch adds sdio_retune_hold_now() and
> sdio_retune_release(). They are used in the 2nd patch
> to prevent re-tuning for the 'wake-up' command.
> 
> 
> Adrian Hunter (2):
>       mmc: core: Add functions for SDIO to hold re-tuning
>       brcmfmac: Prevent re-tuning conflicting with 'wake-up'
> 
>  drivers/mmc/core/host.c                        |  6 ++++++
>  drivers/mmc/core/host.h                        |  1 +
>  drivers/mmc/core/sdio_io.c                     | 13 +++++++++++++
>  drivers/net/wireless/brcm80211/brcmfmac/sdio.c |  6 ++++++
>  include/linux/mmc/sdio_func.h                  |  3 +++
>  5 files changed, 29 insertions(+)

Hi

These patches still apply and are still needed.
Can they be applied?

Regards
Adrian

