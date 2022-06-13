Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAF5CCA47F
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jun 2022 20:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348592AbiFMUq4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350982AbiFMUqS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2022 16:46:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852256321
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so9838246pjo.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9KwEdpp4EHLmLSRu+DnyxFCT3lhc8K5jJavvVNa3rlA=;
        b=zSwz8WVMIHQg4oW9WeNDAAG5c28m66VAZlfBU6xtkU745PQiZZKb0NcxZvtV6OdkA6
         jUmkiKU8oM8vJK4s/n2KFz6UJAj1iDwZUD8xAOzILfe3tgYLzMuvnpcJThY+AbQ7YXi3
         Ynh+4YuX0oQL0e53nznCoFck6OFTtO7NpTtjRzEXj2n2woXhWgaJnILc1UDimQklqLRD
         Hkw2Uu/hmWIoe9DNuZIw7PPhaGlRGq2mPhevdDdQeXGKjxjnwPk7hFdTd4UoRVmOoKBl
         jxtcDBq7meFjO12gTG+DmzvVoN0VtNZWTLr/yJlpdHGc8myRpgahFhOzdF9jc4M5qV+k
         uN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9KwEdpp4EHLmLSRu+DnyxFCT3lhc8K5jJavvVNa3rlA=;
        b=kHr/0nWm7TrufBc4PqsslPk9UbnLQrS0JvP+QQ40Y1uJsJ4GbOXqtWpoPd5ieuxRyj
         v92PL8zY8b6ZLC3q/Dfy9v/VeUGTuZ5Yf3UWUYfwDjecxQUhLIshBbyybuVc+4aMTrGU
         uwxQltmWIyK5oxqgvAHXL8670ToFWzlMppOULRVViH60Q13K98aBbZCtApMzFrdInX67
         U/ZBOVwLL1rtW944SstOmkdbBsDax6B2LYYaM+nLziYQ8rOLEZnkMT69wo2UMc2cq0YW
         85793Ezr2GTOzwbLUxlJBMXREK3XjUsd74cigoWClNDhnhXtxTH9fvk+zhZvu+YLQKMc
         KVfw==
X-Gm-Message-State: AJIora9YJjfgmuH8gPVoZMTnG9P7NSEZ5tEPuiFhVhXQRc/GuWEIBWLH
        dWRQ2VslxRH7MbyHpTUDOspmrg==
X-Google-Smtp-Source: AGRyM1tKqZ68i4YqpSOiqrY85fOOj1ouN0z23ZiBd+JkShEORj/QXiO7j6X0hHfdYvo6dAeKagS/FA==
X-Received: by 2002:a17:90a:9481:b0:1e8:7bbf:fa9a with SMTP id s1-20020a17090a948100b001e87bbffa9amr417565pjo.164.1655150252722;
        Mon, 13 Jun 2022 12:57:32 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:32 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 05/15] dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible
Date:   Mon, 13 Jun 2022 12:56:48 -0700
Message-Id: <20220613195658.5607-6-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add the AMD Pensando Elba SoC system registers compatible.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index fb784045013f..2267f8828e9e 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -38,6 +38,7 @@ properties:
               - allwinner,sun8i-h3-system-controller
               - allwinner,sun8i-v3s-system-controller
               - allwinner,sun50i-a64-system-controller
+              - amd,pensando-elba-syscon
               - brcm,cru-clkset
               - freecom,fsg-cs2-system-controller
               - hisilicon,dsa-subctrl
-- 
2.17.1

