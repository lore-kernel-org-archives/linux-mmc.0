From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/3] Fix fixed regulators support
Date: Tue, 13 Nov 2012 09:48:50 +0100
Message-ID: <1352796533-12350-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:55213 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089Ab2KMItQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Nov 2012 03:49:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>

Hello,

I've noticed that the voltage check in regulator_is_supported_voltage()
function was inverted, what resulted in strange side effects. One of
such side effects appeared in sdhci driver, which has some build-in
support for special case of fixed regulators. 

Now, after fixing regulator_is_supported_voltage(), the sdhci driver
stopped working with fixed regulators. The provided patch series fixes
regulator_is_supported_voltage() function and updates sdhci driver to
correctly operate with fixed voltage regulators. The second patch
unifies handling of fixed regulators and regulators with disabled
voltage change due to their constraints. This restores support for such
regulators in sdhci driver (such case is present on Samsung GONI board).

If possible, I would recomment to push those patches to v3.7-rc series.

Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (3):
  regulator: fix voltage check in regulator_is_supported_voltage()
  regulator: threat regulators with constant volatage as fixed
  mmc: sdhci: apply voltage range check only for non-fixed regulators

 drivers/mmc/host/sdhci.c |    2 +-
 drivers/regulator/core.c |    7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
1.7.9.5

