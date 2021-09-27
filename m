Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90232C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6666108E
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhI0Mwc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:52:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40302
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234438AbhI0Mw3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 08:52:29 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AF2D240268
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 12:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747050;
        bh=jeMIEXiKB7wPBA3ymi6+lgomz3wpzPFtflbOU3+5glo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=wE0XwH8WPXph9KdF2juApvUxO+UdLhcnPvuQqEi9W4T9w8WJZEtdC4iL6OHkt0X0G
         rGQt3rAQ+1qFdsTHSTkaKmILUyFy1w3grGyxCCL12KUCw+BWOkElAalBtSnGkFgRDf
         62BayEZqbQA7laTQUDgtrNJaUTCIXKHlo+g1zcDTL8gU9XEyVZCoEIDtFS1m+fgFS1
         a8EkcCQeuQWv9baGN1MxqKBWKPCEogNfAiBX/0XMaW4Gw2DkpNgPDs9Xzm7BroxQth
         pMsegAmg5UI6B0jg1tjruXLw8FMIHcoWlPlLiIY42UHPAaP92kH4RJEAwPB61QxSs0
         5odx2S0nEyJ7A==
Received: by mail-lf1-f70.google.com with SMTP id a28-20020a056512021c00b003f5883dcd4bso15726818lfo.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 05:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jeMIEXiKB7wPBA3ymi6+lgomz3wpzPFtflbOU3+5glo=;
        b=fiYI+UE4mcSxVgLg8IuUQm2TigyaAyx0G7t13ei9x/c6ulOzijSNwAjF1zIlTo3gWT
         1evfMI9S7sVBf+v+Nn4RB6jfgJiJU/eUn2QjTVzZGPcN/uhm4rD1aQ8befI32+GlE4DA
         mgHsPZZc3IjPnlb6Ncvb11UPc2GDYCNoEb9yR2PLu5kk+tyK9n0A6tbU/Q5Pu4MW/65t
         P9qEtxHVUPN7nWphJZUcbFtwMhCK9H6MdWJ/S67xSpazY9/EDm6Iwy/uMyrS3Eq4BrHC
         +yGvrewxIY6UH1z1+oqMMCIhBN+xLzkPSFk1w73OBuIThxDw94dnqBes0SmmSnowX+tW
         gR2Q==
X-Gm-Message-State: AOAM532JOMFMxrluRTTiC/ISzCacWpEr8Py3Y11r5Shk/YHi2rnOiuGg
        a2P45Tfalau/AsCl2mXONyI+Xmyr/6p+9GDrIlFlUcHlqwYgfUvB2a75UB64kicpOF/wIjAwHqv
        n8rg2MSU7sjdM4XspeWLIkOec09oy3dPu10T0cw==
X-Received: by 2002:a2e:140d:: with SMTP id u13mr17389342ljd.298.1632747048870;
        Mon, 27 Sep 2021 05:50:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4XgRv4NIfqOOqXINjjLOjy/LJUFeE0f5kcR1+muR49/z/9l4mGGfT5izyr31+Z/ahcTOfdA==
X-Received: by 2002:a2e:140d:: with SMTP id u13mr17389319ljd.298.1632747048691;
        Mon, 27 Sep 2021 05:50:48 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/6] dt-bindings: mmc: cdns: document Microchip MPFS MMC/SDHCI controller
Date:   Mon, 27 Sep 2021 14:50:39 +0200
Message-Id: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Microchip PolarFire SoC FPGA DTSI uses Cadence SD/SDIO/eMMC Host
Controller without any additional vendor compatible:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible:0: 'cdns,sd4hc' is not one of ['socionext,uniphier-sd4hc']
  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible: ['cdns,sd4hc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v3:
1. Adjust commit msg.
2. Add tags.

Changes since v2:
1. Document vendor compatible instead of dropping it.
---
 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index af7442f73881..4207fed62dfe 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     items:
       - enum:
+          - microchip,mpfs-sd4hc
           - socionext,uniphier-sd4hc
       - const: cdns,sd4hc
 
-- 
2.30.2

