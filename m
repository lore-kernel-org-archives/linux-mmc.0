Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804D1C4743F
	for <linux-mmc@archiver.kernel.org>; Sun,  6 Jun 2021 18:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF996141E
	for <linux-mmc@archiver.kernel.org>; Sun,  6 Jun 2021 18:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhFFSKS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 6 Jun 2021 14:10:18 -0400
Received: from out28-76.mail.aliyun.com ([115.124.28.76]:47938 "EHLO
        out28-76.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFFSKR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Jun 2021 14:10:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5747147|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0143001-0.0102113-0.975489;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.KOTSOnf_1623002885;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.KOTSOnf_1623002885)
          by smtp.aliyun-inc.com(10.147.40.2);
          Mon, 07 Jun 2021 02:08:24 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sihui.liu@ingenic.com,
        jun.jiang@ingenic.com, sernia.zhou@foxmail.com,
        paul@crapouillou.net
Subject: [PATCH 1/2] dt-bindings: mmc: JZ4740: Add bindings for JZ4775.
Date:   Mon,  7 Jun 2021 02:08:03 +0800
Message-Id: <1623002884-57244-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623002884-57244-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1623002884-57244-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add the MMC bindings for the JZ4775 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml b/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
index 04ba8b7..546480f 100644
--- a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
@@ -19,6 +19,7 @@ properties:
           - ingenic,jz4740-mmc
           - ingenic,jz4725b-mmc
           - ingenic,jz4760-mmc
+          - ingenic,jz4775-mmc
           - ingenic,jz4780-mmc
           - ingenic,x1000-mmc
       - items:
-- 
2.7.4

