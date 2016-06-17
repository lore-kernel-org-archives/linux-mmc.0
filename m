From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 02/12] MAINTAINERS: Retain Ulf Hansson as the same maintainer of pwrseq
Date: Fri, 17 Jun 2016 18:09:15 +0800
Message-ID: <1466158165-9380-3-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0084.outbound.protection.outlook.com ([207.46.100.84]:54240
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755394AbcFQKQG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Jun 2016 06:16:06 -0400
In-Reply-To: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, javier@osg.samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Before moving pwrseq drivers from drivers/mmc/core/ to drivers/power/,
they were maintained by Ulf Hansson.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed42cb6..0bc1821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9072,6 +9072,15 @@ F:	include/linux/power_supply.h
 F:	drivers/power/
 X:	drivers/power/avs/
 
+POWER SEQ CORE and DRIVERS
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-mmc@vger.kernel.org
+T:	git git://git.linaro.org/people/ulf.hansson/mmc.git
+S:	Maintained
+F:	drivers/power/pwrseq/
+F:	include/linux/pwrseq.h
+F:	Documentation/devicetree/bindings/power/pwrseq/
+
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-- 
1.9.1

