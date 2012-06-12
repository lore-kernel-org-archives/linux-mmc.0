From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] mmc: dt: Deduplicate binding docs by referencing mmc.txt
Date: Mon, 11 Jun 2012 23:39:40 -0600
Message-ID: <4FD6D61C.2030003@wwwdotorg.org>
References: <87bokp5lv2.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43500 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab2FLFjl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 01:39:41 -0400
In-Reply-To: <87bokp5lv2.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arndb@arndb.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>

On 06/11/2012 08:01 PM, Chris Ball wrote:
> Now that we have common bindings for MMC, rewrite the individual
> bindings to inherit from mmc.txt and describe their differences.

The Tegra portion,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

(Well, all of it looks fine really at a brief glance!)

Note that I've renamed nvidia-sdhci.txt in my for-next branch, but I
believe git will merge that without any issue.
