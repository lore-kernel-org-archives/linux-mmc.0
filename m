Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C28C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Dec 2021 11:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhLTLal (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Dec 2021 06:30:41 -0500
Received: from smtp1.axis.com ([195.60.68.17]:35875 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhLTLak (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Dec 2021 06:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639999840;
  x=1671535840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m7w3lLdKoUfAR0nJ1tvA01UJzJGAKbV5arB46f/0v90=;
  b=n1L4o+s9Ijwtr6jjqvYqzK+xDB4f1D7DdEPpPE+6sATgjQsRe2pu9zVq
   U3U3vRnBW6AI/kpjUCIps0CCxFzMAC/Js+WgpNOworwgSsOB5/QIBv8TY
   wFjTPtdU34LC+Xh+svxtfTtVAhihZlLf4hTDt5F5OZQ8cez3lm9XJgXzx
   E/BpOS0Hn496xQ4OFaEULTKD1wPWorNBjc4ywtHGT67fNwtwmpXS8qZDO
   GCUiSQHhGFsJmMP2PmDKZLlthNdUPSYhzxRs4aQyg9+/sVfsLt1TiE4N3
   PpD4AiQd/j8RL6mQcIcOXs+iQNu1X8pNs16B272BPtOM7A+u/hxl32cwf
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/4] dt-bindings: mmc: exynos-dw-mshc: Add support for ARTPEC-8
Date:   Mon, 20 Dec 2021 12:30:23 +0100
Message-ID: <20211220113026.21129-2-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211220113026.21129-1-marten.lindahl@axis.com>
References: <20211220113026.21129-1-marten.lindahl@axis.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
---

v2:
 - Change compatible string vendor prefix

v3 -> v4:
 - Add Krzysztof's Reviewed-by tag

v5:
 - Add Rob's Acked-by tag

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

