Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E886DE7D0C0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Sep 2023 01:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjIVBvR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Sep 2023 21:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIVBvQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Sep 2023 21:51:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F757E8
        for <linux-mmc@vger.kernel.org>; Thu, 21 Sep 2023 18:51:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3adc3d94f66so1001520b6e.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Sep 2023 18:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695347469; x=1695952269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdU57Jx9PEmIXARyS6MsKYI5yf8mmNXKxZvGJyz9CZ0=;
        b=QniIRoY87sMEV/oz9MY1HtCu+GALB1T3w0zgnjNUCynTEV+9gbKJGfQS+5nJYpkXlz
         UHB6FumCvDCj3EJJ8l4nVuOtQn8W94SzBi11XsmK4XofsAETnFCUKKtH5PJKfMWBEV4Z
         SHeuU/De+E5v/uhrZqR+zMYO7nf8stxkTcs0+a4UbaOadRnwsPVLwhL/OJk8MtX7ElpV
         nDFJYYwce/cOZaI+GNz8gg/1eTtN/U71vwjuepRW07eflQuRlHV2LGQJkXdDxdvFwbsV
         dQv0bP+R1LLQVXO6uP3CmD5nJCCaTYFsDFN5miteS5CLtCR2wObu1Eca8vvGMsGypJrr
         6Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695347469; x=1695952269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdU57Jx9PEmIXARyS6MsKYI5yf8mmNXKxZvGJyz9CZ0=;
        b=idkeg2dpiQiHqqA7UOT747x6XiJvfmCAdzVN+gp8MIB1W468P0GrAWeCIg8UrQfE2z
         08m554252WOJ7UztrHiEXDv8KqImbed25JU9Vr5HAWYY9Wv8LQ7D5QKsJbstGBx54nrN
         HwsW/oIpaHrCqAhmc+PX4Vz10Yzd+xIdSIP36iQreoFzexzJdDe77OyJxmqJ4QEwcHpV
         9hz81DkswDxGL0YtjTHByJ4vivZ7nfbgnpLKALJ2gBprQxLNQCtpbYWgPzjgGAOBHA/B
         PHAJgP1TFQt3w+5XeKbpxGg9wlaOh9sIZPJINbih6nYGi2BQVMf5l/5jWTuwEZU620/P
         K6DQ==
X-Gm-Message-State: AOJu0Yzo/SQ8zdCXxaopFTG8h+eauUInMTd4OoLUCS0kqMV+5MGozCS5
        AdQCSifmJ/qn1FpKO2gD2x4a8A==
X-Google-Smtp-Source: AGHT+IHBIOCNTfL32DX8sqcPvGCoAvfb0oRHov683BI2vSEw1XFpc+I3dbfeffGIcS9K8qEUO9NE9Q==
X-Received: by 2002:a05:6870:3293:b0:1be:ccce:7991 with SMTP id q19-20020a056870329300b001beccce7991mr7369865oac.13.1695347469207;
        Thu, 21 Sep 2023 18:51:09 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:fa26:6227:be1c:67f0])
        by smtp.gmail.com with ESMTPSA id y10-20020a63b50a000000b0057412d84d25sm1973856pge.4.2023.09.21.18.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 18:51:08 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Thu, 21 Sep 2023 18:49:48 -0700
Subject: [PATCH 1/6] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head TH1520
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230921-th1520-mmc-v1-1-49f76c274fb3@baylibre.com>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
In-Reply-To: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695347467; l=1067;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=lVStiUHxeHbyNt2+zib4d2cdPudtKK6oNMBUQREoPOc=;
 b=Q8id6rVsSYwP6E+iXtE8EEJBdpfTwGmm0EDwKwz276FYyD9CgqZLnz0ACffcwGavDc/d0fScS
 a4r/IUtRvh1A4kShsI9oBwJNbY9Otbdr+VEmtnmc12pL4kS6vyLRKBn
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add compatible value for the T-Head TH1520 dwcmshc controller and add
thead,phy-pull-up property.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index a43eb837f8da..46b768d46712 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -19,6 +19,7 @@ properties:
       - rockchip,rk3568-dwcmshc
       - rockchip,rk3588-dwcmshc
       - snps,dwcmshc-sdhci
+      - thead,th1520-dwcmshc
 
   reg:
     maxItems: 1
@@ -60,6 +61,9 @@ properties:
     description: Specify the number of delay for tx sampling.
     $ref: /schemas/types.yaml#/definitions/uint8
 
+  thead,phy-pull-up:
+    description: Enable weak pull-up on PHY pads
+    type: boolean
 
 required:
   - compatible

-- 
2.34.1

