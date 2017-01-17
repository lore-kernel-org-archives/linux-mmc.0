From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Re: [RESEND PATCHv1 0/8] mmc: sdhci-msm: Provide support for
 enhanced strobe
Date: Mon, 16 Jan 2017 17:07:51 -0800
Message-ID: <20170117010751.GA25703@mini-rhel.redhat.com>
References: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750782AbdAQBIF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Jan 2017 20:08:05 -0500
Content-Disposition: inline
In-Reply-To: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de

On Tue, Jan 10, 2017 at 12:30:44PM +0530, Ritesh Harjani wrote:
> Hi, 
> 
> Resending this patch series, as no one could review it -possibly due to
> holidays during that time.
> 
> This patch series mainly provides enhanced strobe support to sdhci-msm driver
> along with some additions of HW recommended sequence. This has been tested on
> 8996 based internal target & on db410c.
> 
> Patches 1-3 :- Factors out few functions to be re-used again.
> 	       To also simplify large functions and makes it more readable.
> 
> Patches 4-5 :- Few recommendations based on HW prog. guide.
> 
> Patches 6 :- Clear SDHCI_HS400_TUNING flag after platform_execute_tuning
> 	     so that ->platform_execute_tuning (underlying platform driver) can
> 	     know about HS400 tuning.
> 
> Patch 7 :- Implements an additional step as per HPG for HS400 tuning.
> 
> Patch 8 :- Implements enhanced strobe functionality in sdhci-msm driver.
> 
>

I have included this series in my tree while testing my SDHCI V2 series.

One message did occur which looks new or unfamilar and relatively
harmless,

"sdhci_msm f9824900.mmc: TCXO clk not present (-2) "

Is that something I am missing on my side?  

In anycase,

Tested-by: Jeremy McNicoll <jeremymc@redhat.com>

-jeremy


> Ritesh Harjani (6):
>   mmc: sdhci-msm: Factor out sdhci_msm_hc_select_mode
>   mmc: sdhci-msm: Factor out function to set/get msm clock rate
>   mmc: sdhci-msm: Factor out sdhci_msm_hs400
>   mmc: sdhci: Clear SDHCI_HS400_TUNING flag after
>     platform_execute_tuning
>   mmc: sdhci-msm: Make HS400 tuning follow as per recommeneded HW
>     sequence
>   mmc: sdhci-msm: Provide enhanced_strobe mode feature support
> 
> Subhash Jadavani (1):
>   mmc: sdhci-msm: configure CORE_CSR_CDC_DELAY_CFG to recommended value
> 
> Venkat Gopalakrishnan (1):
>   mmc: sdhci-msm: Reset vendor specific func register on probe
> 
>  drivers/mmc/host/sdhci-msm.c | 356 ++++++++++++++++++++++++++-----------------
>  drivers/mmc/host/sdhci.c     |   6 +-
>  2 files changed, 224 insertions(+), 138 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
> a Linux Foundation Collaborative Project.
> 
