From: Jeongbae Seo <jeongbae.seo@samsung.com>
Subject: [PATCH 0/5] ARM: S5PV310: Add support HSMMC for S5PV310/S5PC210
Date: Thu, 16 Sep 2010 17:36:58 +0900
Message-ID: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:43165 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab0IPIxq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Sep 2010 04:53:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, kgene.kim@samsung.com, akpm@linux-foundation.org

This patch adds support HSMMC for S5PV310/S5PC210.

[PATCH 1/5] ARM: S5PV310: Add HSMMC support and SDHCI configuration
[PATCH 2/5] ARM: S5PV310: Add HSMMC support into S5PV310 and S5PC210
[PATCH 3/5] ARM: SAMSUNG: Modified to change of bus width and host caps
[PATCH 4/5] ARM: SAMSUNG: Add clock types into platform data
[PATCH 5/5] sdhci-s3c: Add support no internal clock divider in host controller
