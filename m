From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Build breakage in sdhci-s3c
Date: Fri, 2 Dec 2011 11:58:07 +0000
Message-ID: <20111202115807.GJ8245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55617 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754311Ab1LBL6J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2011 06:58:09 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sangwook Lee <sangwook.lee@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linaro-dev@linaro.org, linux-mmc@vger.kernel.org

The mmc and therefore -next currently fail to build on Samsung platforms
due to commit 666b6a (mmc: sdhci-s3c: Add pm_caps into SD/MMC host)
which added use of a new field pm_caps in the platform data without
actually adding that field to the struct.  I guess there's a separate
patch floating about somewhere which adds the field but it's not in
-next and both commits should be going in via the same tree to avoid
bisection breakage - ideally both the field and its use should be added
as part of a single commit.
