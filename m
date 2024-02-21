Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6808565E
	for <linux-mmc@vger.kernel.org>; Wed, 21 Feb 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541177; cv=none; b=aKPtKqK7glVY8XCkR44EvA/8BqgRLa1Oxl5uQGD5M+keRTznPCorI6f2a2eMwNX+mmsXlW+t/xLk7ebpS8Q6kFLCfOFsOFEV00X/HL+1cFVNwLqDd18nMlzq2c81aUy1Psg/1Q5meI+5FSNBBynI7Wga3TUhXXMEU6v5TSKkLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541177; c=relaxed/simple;
	bh=DKgFR5UMRp9EKcFZpaIwUbAD9DncQAJ1hysxOHZFt3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QjJygv8PBwzajc/v6IDJD3F9d78iRsuLqyEba9DHG7uEBNhlSmjAi8AdoLUeVFkt1ZeOQIhnzVl0pvzQ+QfEE9XHUpD/ll+dk5ArogOwEqS1fHuPVsCfL0thMppPf5/taKnIkA4Ij7bPDAEQ6hj2FmDUXzg47nv0Tf5NwB8URlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rcrba-0004P2-05; Wed, 21 Feb 2024 19:46:06 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: ulf.hansson@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add default and 100mhz state
Date: Wed, 21 Feb 2024 19:46:02 +0100
Message-Id: <20240221184602.3639619-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

Some devices support only the default and the 100MHz case, add the
support for this to the binding to avoid warnings.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 82eb7a24c857..e47253e4eac4 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -173,6 +173,11 @@ properties:
           - const: state_100mhz
           - const: state_200mhz
           - const: sleep
+      - minItems: 2
+        items:
+          - const: default
+          - const: state_100mhz
+          - const: sleep
       - minItems: 1
         items:
           - const: default
-- 
2.39.2

