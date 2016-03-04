From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: tegra: implement memcomp pad calibration
Date: Fri, 4 Mar 2016 15:02:18 +0200
Message-ID: <56D9875A.4080800@intel.com>
References: <1456779385-18996-1-git-send-email-dev@lynxeye.de>
 <1456779385-18996-2-git-send-email-dev@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45385 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754272AbcCDNF5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Mar 2016 08:05:57 -0500
In-Reply-To: <1456779385-18996-2-git-send-email-dev@lynxeye.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

On 29/02/16 22:56, Lucas Stach wrote:
> The Tegra30+ SDMMC module has memcomp pads that are used to
> automatically find and set the correct drive strength settings to
> the sdmmc pads. The calibration needs to be manually kicked off
> when the card signal voltage is changed, after the card clock is
> supplied again.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
> This commit allows signal voltage changes on my Tegar30 Beaver to
> succeed, making UHS-I modes work.
> ---

Doesn't apply cleanly, but otherwise looks OK.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

