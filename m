From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/4] mmc: tegra: fix reporting of base clock frequency
Date: Tue, 15 Apr 2014 12:25:01 -0600
Message-ID: <534D797D.7030201@wwwdotorg.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org> <1397526163-20126-3-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50937 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbaDOSZE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Apr 2014 14:25:04 -0400
In-Reply-To: <1397526163-20126-3-git-send-email-abrestic@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 04/14/2014 07:42 PM, Andrew Bresticker wrote:
> Tegra SDHCI controllers, by default, report a base clock frequency
> of 208Mhz in SDHCI_CAPABILTIES which may or may not be equal to the
> actual base clock frequency.

Some explanation of why this "may or may not be equal to the actual base
clock frequency" would be nice.

Presumably, it's because the clock frequency is supplied by the clock
controller module, and configuring that happens externally to the SD
controller, so the SD HW has no knowledge of the actual frequency, and
hence simply reports a hard-coded maximum possible clock frequency?

> While this can be overridden by setting
> BASE_CLK_FREQ in VENDOR_CLOCK_CTRL on Tegra30 and later SoCs, just
> set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN and supply a get_max_clock()
> callback to get the actual rate of the base clock.

It's not clear to me from the function name that
sdhci_pltfm_clk_get_max_clock() simply calls clk_get() on the actual
clock. It might be nice to mention that in the commit description.
