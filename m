Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EF1C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 15:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7856E60F9D
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 15:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbhITPK3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:10:29 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39876
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241162AbhITPK2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2021 11:10:28 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CFDF94018F
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2021 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632150540;
        bh=RrUHW9qWnN4ubyMN56WONJrQMAnYJXVEP7VdjrUGoI4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=AFOM6TcHjSb05N9wnmVVk1u0W60SnXAKhn8eO5V+/9/e2NPCKMg5XylKOafVa9Lz1
         oqR+Xe/BXXVd2ooH7qnLXYTWmzLssyTv3gtDFLFkW9oDxiqQNKkg8Fj+otyeU3XPA6
         NC8T6/pqJ72uQYXFcqckXpY/yHzswwN5pL0UqXzbP+PCUqTjHzuT8AFAeHiTfjLOC6
         5jjcMMS3wVfDCumkBtLpClI3XA2Sk2yZOBGVYUvgmXRzrlyf+CRwanKxIFoWfCZgbC
         4JxwgZCdoQkaKUcBB3ohPQhB7rulMVndO8KmGLRIuuG6NDoUFk3HUB4WDVb8HJKPvy
         GOW0Q7R1plg4Q==
Received: by mail-wr1-f69.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so6347201wrp.16
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2021 08:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RrUHW9qWnN4ubyMN56WONJrQMAnYJXVEP7VdjrUGoI4=;
        b=NjlgN+7g61vGqwsZYvx5vncNX6hywZEfjezlDOaOcYHfh4aW+g6YaNfPwwxbPxXXCj
         Cfj+0dU+uoudHHFWM6Un4Z/PINaHpcVpgjAM7zFnH0MDG2t7YISruojwq2U9gJXlPV0t
         gMNpIcSGcxNm12u89FzU8p6RcjN5ojXqkPJ43OF7tfTsA3nDLS7V1+rmhVzi3mI6xprE
         gxCIGW8phxlM01DUoqQuYdVBlq5AHzlOon43eEk5mBfUXwPvGzdrDvurDAR3eXbW4Qzc
         UGgiqgVTC9/MKoERqejotE3jNf1N/J7aSDbNiwMMd3ZD/hn/cupd7E/kbck5UcqhM2CZ
         mu9A==
X-Gm-Message-State: AOAM532oDPHIaOCM0uclYH8Ylwt0d0JMY/8F6KER5kNgee9qlieAWVJp
        Qy4MadsKzPGXADTyrzEuCC/PS//7lKTmGL1rVko5YYivnCUxnbXzrs/W/N7shhJI/nkzWW3GaI0
        +P7LHroA3Sb6KIkQTOzdeq8jjbb6sqj73LdqYIQ==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr23903304wmh.125.1632150540257;
        Mon, 20 Sep 2021 08:09:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9q96BO6SmIHFGad+uos8pAFJ1J9kCDWwhrXRWKfSkT84ucEy7lcgN0Rquc/RlyJ/PH3RBzA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr23903276wmh.125.1632150540071;
        Mon, 20 Sep 2021 08:09:00 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i2sm15803136wrq.78.2021.09.20.08.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:08:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/6] dt-bindings: mmc: cdns: document Microchip MPFS MMC/SDHCI controller
Date:   Mon, 20 Sep 2021 17:08:02 +0200
Message-Id: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Microchip MPFS Icicle Kit uses Cadence SD/SDIO/eMMC Host Controller
without any additional vendor compatible:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible:0: 'cdns,sd4hc' is not one of ['socionext,uniphier-sd4hc']
  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible: ['cdns,sd4hc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

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

