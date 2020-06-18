Return-Path: <SRS0=gCHa=77=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA6DC433E1
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Jun 2020 03:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4AD21841
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Jun 2020 03:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgFRDeR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Jun 2020 23:34:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44962 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgFRDeQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Jun 2020 23:34:16 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F7121A0045;
        Thu, 18 Jun 2020 05:34:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D6D871A0079;
        Thu, 18 Jun 2020 05:34:07 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CADD8402B3;
        Thu, 18 Jun 2020 11:33:59 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org,
        s.trumtrar@pengutronix.de, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4 2/3] dt-bindings: clock: Correct mmc node name in i.MX35 binding
Date:   Thu, 18 Jun 2020 11:22:57 +0800
Message-Id: <1592450578-30140-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592450578-30140-1-git-send-email-Anson.Huang@nxp.com>
References: <1592450578-30140-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Nodename should be "mmc" instead of "esdhc" in i.MX35 clock binding
to avoid below build error:

Documentation/devicetree/bindings/clock/imx35-clock.example.dt.yaml:
esdhc@53fb4000: $nodename:0: 'esdhc@53fb4000' does not match '^mmc(@.*)?$'

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New patch, to fix build error when patch #1 is added.
---
 Documentation/devicetree/bindings/clock/imx35-clock.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx35-clock.yaml b/Documentation/devicetree/bindings/clock/imx35-clock.yaml
index bd871da..3e20cca 100644
--- a/Documentation/devicetree/bindings/clock/imx35-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx35-clock.yaml
@@ -130,7 +130,7 @@ examples:
         #clock-cells = <1>;
     };
 
-    esdhc@53fb4000 {
+    mmc@53fb4000 {
         compatible = "fsl,imx35-esdhc";
         reg = <0x53fb4000 0x4000>;
         interrupts = <7>;
-- 
2.7.4

