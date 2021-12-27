Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6F1C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Dec 2021 13:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhL0NcN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Dec 2021 08:32:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39446
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234045AbhL0NcK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2021 08:32:10 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DE005405F2
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640611926;
        bh=S+o/cTHgVGk8oN2RoEmSgbuWSZI8JE9I4STOFcdfAwY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=H7xFfzqhJgWiWgLPVBZVs352pW5pdN18/SoZjtMmlz+Mi+orE8+9AdezVbfakbCY9
         txWgiE0i7B7p3Y8r3CWBuFlFNTLAk35IUbCH/TwwgWQiRtXyslnNq+MrSVhqTWrP86
         f0gLSeaSAV+VEEkFnqiYKSJH1yWX5grIS83DqjBpZoOAqKZ7iLvioRJ8QGNF+tbopI
         T/j6J+bRZ7Z9MEraGQ1qMqp9O/ie8Zo3N0vYgba94367142qmnCARf8cyYQoX48vyS
         Y3JdeBxHmR8eQ4g347a4d6WqU/kT9MtWRQo4Rzim7cJvSGi9GP09mS1fKKKe6Rid7Q
         2XCO9ZNFffD8A==
Received: by mail-lj1-f197.google.com with SMTP id o11-20020a2e90cb000000b0022dd251d30aso1344903ljg.8
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 05:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+o/cTHgVGk8oN2RoEmSgbuWSZI8JE9I4STOFcdfAwY=;
        b=jroEUct104AkHtmzYew9mWDpEFFiEAa66hGTTAA11ahX+jhuxd9+EJtmYU37sj4kF+
         hkyf0x6bTy20VnHZZw44D432BrdLQ6lMwLEWkLJd17tQfU6NX8q5KtdpkRUDtWG+Sd8F
         t5DTKlXhRobpkCyt1KDWFLA/MUQSfqx3zQHfkYS5GhDZZau48RT+8qUwOZtjbkP6JnEs
         +B2F5Dl5wqWsAuS5x+JxpxthQJ6NUsJlmsG+gAmKZH5AgdjONqYH2UL1qI9EZdEZ/VVf
         WGDe7Nb1iea0GVF3NsnTluFjylQbHumTNcAzZF6nkj4dBYY2YTxkCn96TQApxDPEKqYG
         o4ew==
X-Gm-Message-State: AOAM5307lXzk2NtO4QuNSLfJvGOLKtP3L7FTgOAZgujs8VRHqp7mAy+T
        rAa97gzD4GoDaNuksU5erYQZ/Q5L1r1WnZmEAZ100CjApGgF5EVq9wz2p5Ab62KXkpT21W1Bp2k
        kcjrshHtzLPRejmghwX8T2Ci0yI6OKPjaf80OTA==
X-Received: by 2002:a2e:90cb:: with SMTP id o11mr4607897ljg.158.1640611926166;
        Mon, 27 Dec 2021 05:32:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfR0HHsehFPMnWJ0yUHJl8w0VYLiWVXHnAJyeoCCtKtnHHUQOP+KGCTsRZ/23U6d9NTCKISg==
X-Received: by 2002:a2e:90cb:: with SMTP id o11mr4607878ljg.158.1640611925634;
        Mon, 27 Dec 2021 05:32:05 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d14sm1433510lfg.18.2021.12.27.05.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:32:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 03/19] dt-bindings: altera: document Arria 5 based board compatibles
Date:   Mon, 27 Dec 2021 14:31:15 +0100
Message-Id: <20211227133131.134369-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add new compatible for Arria 5 based boards.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 0d62c2bde053..3d7a2f699279 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -16,6 +16,8 @@ properties:
     oneOf:
       - description: Arria 5 boards
         items:
+          - enum:
+              - altr,socfpga-arria5-socdk
           - const: altr,socfpga-arria5
           - const: altr,socfpga
 
-- 
2.32.0

