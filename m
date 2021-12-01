Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F3C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Dec 2021 15:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351079AbhLAPlr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Dec 2021 10:41:47 -0500
Received: from smtp2.axis.com ([195.60.68.18]:16713 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351080AbhLAPlq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Dec 2021 10:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638373105;
  x=1669909105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JWSctjhkZdPxSDwn5yAHNL/RyvKgrdS6Vr/fjE741Vs=;
  b=XnIXv+SPDsqvYIUvF8yyLy5HUUh539Z3/g6OP0EMd8JJgVmvFYCd+JbZ
   YYJ5Ruhf0aIuOMyPqulPknvY9zJR14IZ6BvivxpMwE9gZsPV9OFOpezed
   Q6O6DmXQJ0OYhggRP4zfsy0L91OQ/863W4zuEYNoOCWfYZdYF1dErpcq6
   FrLthszYeYEK2oB7qIsSf8WdlBAmk9oODhzHuegnf47YNNlbVmCRDeLY7
   GwLoxg9/9YuL5VS7dmh+JtuN3CyegCHWYKHjIAzOX+kw5V9hY2cdUaFmK
   t3XeA5/oo9IyEcaUF8SexMiNLHc+25q/F34x8W0FHUgMXhtcUjubFaiLz
   w==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 1/4] dt-bindings: mmc: exynos-dw-mshc: Add support for ARTPEC-8
Date:   Wed, 1 Dec 2021 16:38:01 +0100
Message-ID: <20211201153804.27655-2-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211201153804.27655-1-marten.lindahl@axis.com>
References: <20211201153804.27655-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The ARTPEC-8 SoC has a DWMMC controller that is compatible with the
Exynos 7 version v2.70a. The main differences from Exynos 7 is that it
does not support HS400 and has extended data read timeout.

Add compatibility string "samsung,artpec8-dw-mshc" for ARTPEC-8.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index 0419a63f73a0..161be451a1f0 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -22,6 +22,8 @@ Required Properties:
 	  specific extensions.
 	- "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
 	  specific extensions having an SMU.
+	- "samsung,artpec8-dw-mshc": for controllers with ARTPEC-8 specific
+	  extensions.
 
 * samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
   unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
-- 
2.20.1

