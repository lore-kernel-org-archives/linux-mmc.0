From: Jeongbae Seo <jeongbae.seo@samsung.com>
Subject: [PATCH V2 0/3] ARM: S5PV310: Add support HSMMC
Date: Wed,  6 Oct 2010 15:00:43 +0900
Message-ID: <1286344846-21244-1-git-send-email-jeongbae.seo@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:46583 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512Ab0JFGJe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Oct 2010 02:09:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, kgene.kim@samsung.com, akpm@linux-foundation.org, cjb@laptop.org

This patch support HSMMC for S5PV310 and S5PC210.
And addressed comments from Marek.

Changes since v1:
- Added drive strength handling in each SDMMC channel
- Separated to board specific and common changes

[PATCH V2 1/3] ARM: S5PV310: Add support HSMMC and SDHCI configuration
[PATCH V2 2/3] ARM: S5PV310: Add HSMMC platform data
[PATCH V2 3/3] ARM: S5PV310: Add support HSMMC on SMDKV310 and SMDKC210
