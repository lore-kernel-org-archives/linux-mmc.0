From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] mmc: host: Kconfig: Update SDHCI S3C entry
Date: Wed, 25 Jun 2014 12:08:01 +0200
Message-ID: <4605637.HIkriDj1YF@wuerfel>
References: <1403690286-1264-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56987 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaFYKIM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jun 2014 06:08:12 -0400
In-Reply-To: <1403690286-1264-1-git-send-email-sachin.kamat@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@samsung.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, spk.linux@gmail.com, Doug Anderson <dianders@chromium.org>

On Wednesday 25 June 2014 15:28:06 Sachin Kamat wrote:
> All Exynos4 SoC based boards have SDHCI controller and mostly
> use SD mounted filesystem. Hence it makes sense to default it
> to yes on Exynos4 platform. While at it also fix a couple of
> typos in the help text.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> 

I'm not following that reasoning. We don't normally 'default y'
peripheral drivers at all, but just enable them in the defconfig.

	Arnd
