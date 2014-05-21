From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v2 1/3] mmc: tegra: disable UHS modes
Date: Wed, 21 May 2014 01:43:42 +0100
Message-ID: <86egzormf5.fsf@void.printf.net>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
	<1397689719-28882-1-git-send-email-abrestic@chromium.org>
	<1397689719-28882-2-git-send-email-abrestic@chromium.org>
	<537B9022.20709@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45695 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbaEUAnt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 20 May 2014 20:43:49 -0400
In-Reply-To: <537B9022.20709@wwwdotorg.org> (Stephen Warren's message of "Tue,
	20 May 2014 11:25:54 -0600")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Andrew Bresticker <abrestic@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, May 20 2014, Stephen Warren wrote:
> On 04/16/2014 05:08 PM, Andrew Bresticker wrote:
>> Program TEGRA_SDHCI_VENDOR_MISC_CTRL so that UHS modes aren't advertised
>> in SDHCI_CAPABILITIES_1.  While the Tegra SDHCI controller does support
>> these modes, they require Tegra-specific tuning and calibration routines
>> which the driver does not support yet.
>
> What's the status of patches 1 and 2 in this series? I assumed they'd be
> applied to the MMC tree. I've had them applied to my local development
> tree for a while now, so in case this helps:
>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>
>
> (I thought I wrote that before, but I can't find it, so I must have
> forgotten to)

We've been waiting for a very large sdhci patchset from Russell to
land before merging other sdhci patches, but I think we're running
out of time for that -- so we'll merge this one way or another within
a few days.

Thanks,

- Chris.
-- 
Chris Ball   <http://printf.net/>
