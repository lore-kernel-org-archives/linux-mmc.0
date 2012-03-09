From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH] drivers: mmc: sdhci-s3c: fix broken compilation for
 non-Exynos SoCs
Date: Fri, 09 Mar 2012 17:07:40 +0100
Message-ID: <00ce01ccfe0e$c1469f50$43d3ddf0$%szyprowski@samsung.com>
References: <1331300667-22566-1-git-send-email-m.szyprowski@samsung.com>
 <4F5A2818.4090104@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47136 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964835Ab2CIQHv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Mar 2012 11:07:51 -0500
In-reply-to: <4F5A2818.4090104@samsung.com>
Content-language: pl
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kukjin Kim' <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>

Hello,

On Friday, March 09, 2012 4:56 PM Kukjin Kim wrote:

> On 03/09/12 05:44, Marek Szyprowski wrote:
> > exynos4_sdhci_drv_data structure is not available on non-Exynos builds,
> > that's why EXYNOS4_SDHCI_DRV_DATA macro has been introduced. This patch
> > fixes commit 67819656 'mmc: sdhci-s3c: Add device tree support' to use
> > that macro. This fixes broken build for pre-Exynos SoCs.
> >
> I think, it is protected by CONFIG_OF and the pre-EXYNOS SoCs is not
> support device tree yet. Could you please let me know the build error
> and build condition?

pre-EXYNOS SoC do not support device tree, but I had to enable flat device
tree support to get them working once in the past and I still have it in my
config. Now I see that kernel boots fine without enabling flat device tree,
but imho the reported issue should be fixed to reduce the amount of work in
the future.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


