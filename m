Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8340CC4321E
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Dec 2021 16:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhLIQtj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:49:39 -0500
Received: from smtp1.axis.com ([195.60.68.17]:29380 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232330AbhLIQtj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 9 Dec 2021 11:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639068366;
  x=1670604366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xC1yVcJidOYb3sYC0Yy+7z0iS9qJa5C+eZgbknuzhGU=;
  b=PysbgVachrQjg3F8GHkHf7dJO3/ZEIoHjtw6oD5aqvjMi381ySzebpZN
   l18YQba1Y7Lg2ckN44BsCCkXxJumQCdUPMEt8iYg+2gZw0+MQ6xR43MLU
   NP0Xpz3XDwRYN7c7LuOMqUWICnuBQdUgcwJMjK1+X2I98ixnsOBegO8O4
   oj64ecy1ggUO61Kz28W5YrlSs4bsc8HIXuAJ5IY3/akUK32Cc/mWOytni
   sfWSQ9eIZXiRPQP7v7TCk68pfH5bVC1m16WqzQcyCPJ7oFTbwdkeAut98
   aMe/XGXLQXHuR4HT75cr+TS2nT5LFbeC5Gchpoxy7a9m2TY90j0GlmqXK
   g==;
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
Subject: [PATCH v3 1/4] dt-bindings: mmc: exynos-dw-mshc: Add support for ARTPEC-8
Date:   Thu, 9 Dec 2021 17:45:55 +0100
Message-ID: <20211209164558.13729-2-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211209164558.13729-1-marten.lindahl@axis.com>
References: <20211209164558.13729-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The ARTPEC-8 SoC has a DWMMC controller that is compatible with the
Exynos 7 version v2.70a. The main differences from Exynos 7 is that it
does not support HS400 and has extended data read timeout.

Add compatibility string "axis,artpec8-dw-mshc" for ARTPEC-8.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---

v2:
 - Change compatible string vendor prefix

 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index 0419a63f73a0..753e9d7d8956 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -22,6 +22,8 @@ Required Properties:
 	  specific extensions.
 	- "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
 	  specific extensions having an SMU.
+	- "axis,artpec8-dw-mshc": for controllers with ARTPEC-8 specific
+	  extensions.
 
 * samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
   unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
-- 
2.20.1

