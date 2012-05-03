From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 04/29] regulator: fix devm_regulator_put() to call regulator_put() explicitly
Date: Thu,  3 May 2012 17:05:33 +0200
Message-ID: <1336057558-11031-5-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59345 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757315Ab2ECPGD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 May 2012 11:06:03 -0400
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

devres_destroy() doesn't call the release() method, it only destroys the
resource. The caller should take care to release the associated object
itself.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e70dd38..fdeabba 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1429,6 +1429,7 @@ void devm_regulator_put(struct regulator *regulator)
 {
 	int rc;
 
+	regulator_put(regulator);
 	rc = devres_destroy(regulator->dev, devm_regulator_release,
 			    devm_regulator_match, regulator);
 	WARN_ON(rc);
-- 
1.7.2.5

