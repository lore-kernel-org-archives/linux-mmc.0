Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84812C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Dec 2021 13:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhL0Nfz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Dec 2021 08:35:55 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54538
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234196AbhL0Nfx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2021 08:35:53 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 52A5A3FFDB
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612152;
        bh=SHDOTqD45fkOcgdIZOrzabWTlwg9fQB3mqCZYwiASwc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Q3FslC6lesIAV88C7ZW/jyt4KbTp+Bv33AUsKlaF568VrgMz2xl2I63btQ0XQstw4
         7i3NbcM/KRs6dB7iARVg/iXAAbGivirjgLSPfRVlCxfTstDSl+cP0ZYj1eq7RJd5oY
         JnSSwVhFyVaoV2ew7/r0Qo9mO0vz1+w2O6klNdxfVINcCqA0RXr4qbkNbLso8OYbc8
         lItcf7QgdLeSve6MHti8kExUsJfK6h4hjpiYsdNV/fmQJPiEFNBIffAD/HVIfvVMb3
         qmWgSL2u0C1c5P/ssnuJ+KW2REAn9u1kNwxPExiWNBGxtwP3ppfTc0jlGQGYq3eFZQ
         awundG1tuw0bw==
Received: by mail-lj1-f199.google.com with SMTP id z9-20020a2e3509000000b0022d8e7f5889so4607654ljz.16
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 05:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SHDOTqD45fkOcgdIZOrzabWTlwg9fQB3mqCZYwiASwc=;
        b=WhH9jxRXEEWXWQ7OSatHTr0Vy+QF9G8T2mE7f7JMm0QibyNFLELHoHLkixsJOl3zVs
         7/uq6j9Sja/4UE2py2KEe541sQWbF3gb4swuKXfNhHKIJDP/OmJgWqngBJKXv6hS8t7s
         VYLL+mpc+xUYzACfU8UsdVVyE8p5PFWYJYjFOQqnpF9W0At/EWx+4kIIq0WiT3nTxLXu
         5pgDniP5sVArnXjVpPKG3NXzZK173IpBmpg9t5aeSmHV4Vdtnxn7Fetz38kq1FAEuE5v
         9MT3HAZ6nIODKMOEW6o+6TLDZlaqudecOzg4b4U4WPqaAbX4ACuIACNMnL5KfxHG/U01
         UfWQ==
X-Gm-Message-State: AOAM532sU4/sF8B9PfehNdNJEyf34IRZ2gN1ymulQ+UN7lrAWz6JvsIz
        uVNA8WNVs5E3BwkYh5V2o2jjIZF+YipGs4hu64D6pfnT8Bs5aKhb7DOIpdcNeuC0mZJ3mUrazOO
        uMXqcFJDxh21u5rPDXfyll9NVZ1EVacItZzDzUw==
X-Received: by 2002:ac2:51bc:: with SMTP id f28mr15038331lfk.222.1640612150083;
        Mon, 27 Dec 2021 05:35:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz74YnaGqeKHmwR3S7E74UQQMqDX12yIAKinwFN3GzO62zbbfUGRpdn19Zp2pmz0D3CIOT/OA==
X-Received: by 2002:ac2:51bc:: with SMTP id f28mr15038324lfk.222.1640612149924;
        Mon, 27 Dec 2021 05:35:49 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id h21sm829100lfu.253.2021.12.27.05.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:35:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 06/19] dt-bindings: altera: document Stratix 10 based board compatibles
Date:   Mon, 27 Dec 2021 14:35:32 +0100
Message-Id: <20211227133545.135049-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add new compatible for Stratix 10 based boards.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index f4e07a21aaf5..5e2017c0a051 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -43,6 +43,12 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Stratix 10 boards
+        items:
+          - enum:
+              - altr,socfpga-stratix10-socdk
+          - const: altr,socfpga-stratix10
+
       - description: SoCFPGA VT
         items:
           - const: altr,socfpga-vt
-- 
2.32.0

