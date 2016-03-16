From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 0/4] Add phy support for arasan,sdhci-5.1
Date: Wed, 16 Mar 2016 12:38:00 +0100
Message-ID: <CAPDyKFrxFhaPatQDDSQ=RRmY6_ephJqzcsAf-BZzePA8gJLxeA@mail.gmail.com>
References: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33658 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934302AbcCPLiC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 07:38:02 -0400
Received: by mail-wm0-f47.google.com with SMTP id l68so185832260wml.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 04:38:01 -0700 (PDT)
In-Reply-To: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 7 March 2016 at 16:38, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Phy is mandatory requirement for arasan,sdhci-5.1, so we introduce
> generic phy support for sdhci-of-arasan.
> This version is rebased on Ulf's next to make it applied cleanly.
> Also, we fix some preexisting problems of err handling suggested by Adrian.
>
>
> Changes in v7:
> - split two changes into seperate patches
>
> Changes in v6:
> - rebase on Ulf's next
> - fix some preexisting problems of err handling suggested
>       by Adrian
> - add Rob's Acked-by tag
>
> Changes in v5:
> - remove rpm support from this serise
> - fix some err case for handling phy
>
> Changes in v4:
> - remove suspend/resume_phy
> - add err handle label for system PM callback
> - fix comments of struct sdhci_arasan_data and system PM
>   callback suggested by Michal
>
> Changes in v3:
> - remove phy_init/exit for suspend/resume
> - adjust phy_int/power_on seq to make code more reasonable
>   simplify suspend/resume_phy
>
> Changes in v2:
> - Keep phy as a mandatory requirement for arasan,sdhci-5.1
>
> Shawn Lin (4):
>   Documentation: bindings: add description of phy for sdhci-of-arasan
>   mmc: sdhci-of-arasan: remove disable clk_ahb from sdhci_arasan_resume
>   mmc: sdhci-of-arasan: fix missing sdhci_pltfm_free for err handling
>   mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
>
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       | 20 +++++-
>  drivers/mmc/host/sdhci-of-arasan.c                 | 71 +++++++++++++++++++---
>  2 files changed, 81 insertions(+), 10 deletions(-)
>
> --
> 2.3.7
>
>

Thanks, applied for next!

Kind regards
Uffe
