Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E6FC25B49
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Oct 2023 21:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjJWVHP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Oct 2023 17:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjJWVHN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Oct 2023 17:07:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F08D7D
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 14:07:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso3084252b3a.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 14:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698095228; x=1698700028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEp58o5jHhf4WpbbQN22nWQx0p8/zKOYMNnof7eHdFk=;
        b=uB7dqgWvV0QmjXatbQPRtYihGtkW7reO7o/ncSxsUyohOWO8KxijcbemBK6IBRGD1M
         DGLZPNFjtfagjAX9nj+CT/MUl2sbb9U5WDLCU0JH9TNckSoo4I6Fi/Ewx37wJhM9gF4y
         VmJp2zkHEAqesdiQ52l6tbqHoYrZWp0guCptNZZtQhznNbaVvVsOItS/MCsRLL0Fd7fp
         x/dCwfZ49CqAAGFVBbPaNuyEXkgUNot5scn6KUihRPqPUfLT74I2tInbgBPTIqhIF1tb
         oaETbsHvMm0cc2yL0uqfOADb8K3uuOLn60aRVSsBQmv752Udxc6Abu+b1qiYeT78OHdy
         sQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095228; x=1698700028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEp58o5jHhf4WpbbQN22nWQx0p8/zKOYMNnof7eHdFk=;
        b=Nq+xl1qZiTXVU5h5MEBznSPSnOq2JZI3H4v9eFBZu9qsV/jtN48j/bEy1804wTlBYk
         IBqp4Q+mBD+ICT2gsLOzmeT9/9zKJVdrSXGu6t//1JfORmo6bDznZSSWbaKO2w38sNQi
         y3TnlD/txbrrLDl5vNohxoMxFlSAub7ijFdbfudUn0m5buUt3N9g+ew3iG2ydYn5V2Ie
         +4egTvvFgNtSFLdglV+gO8W2iWOLVdC2EICAWxP/95J92nbEkUQFyjnCdZYeneaZoG9f
         Wp57UCBjfHZFS82T0WYMLIl5Pr63RRPfdIj5MmHQHrpgRRRYHjk7aB72lKofj/S/ZTVV
         l0EA==
X-Gm-Message-State: AOJu0Yyz71LAmatNCQ7lIXltr1tH+OfxfdnTydwz2fhZIiWZGYqKU2Kz
        QyZBQD6hZQU/2j9XOv5b0hfBSw==
X-Google-Smtp-Source: AGHT+IHg2DJovAjqpJT0F2jI+QTk8wrRUPX+s+/oRc6HVoE46LtmMtUe6Ux/OkxysbrGwtvFIKXQNA==
X-Received: by 2002:a05:6a00:2d8a:b0:6b3:6bc6:68d1 with SMTP id fb10-20020a056a002d8a00b006b36bc668d1mr8143052pfb.11.1698095228217;
        Mon, 23 Oct 2023 14:07:08 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:b9a0:8714:407c:4146])
        by smtp.gmail.com with ESMTPSA id k28-20020aa79d1c000000b006bde2480806sm6573066pfp.47.2023.10.23.14.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:07:07 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Mon, 23 Oct 2023 14:07:02 -0700
Subject: [PATCH v3 1/7] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-th1520-mmc-v3-1-abc5e7491166@baylibre.com>
References: <20231023-th1520-mmc-v3-0-abc5e7491166@baylibre.com>
In-Reply-To: <20231023-th1520-mmc-v3-0-abc5e7491166@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698095224; l=752;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=N4XyeVof9hR52mLfjwIJ/Ek5oPrydhGBm0Gy7EtJsFw=;
 b=XlUrixYReEkCaKM92PMn6rpZ7EjDKaegEVrHET11pyZ3p0c0MiitT0fAg0daqcrqIaa30x6bC
 sTTU5RTzPioADAd93OlwzXiMMqK5rS1emB3BmrleXQS2zxyqd/EnGdi
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add compatible value for the T-Head TH1520 dwcmshc controller.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index a43eb837f8da..42804d955293 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -19,6 +19,7 @@ properties:
       - rockchip,rk3568-dwcmshc
       - rockchip,rk3588-dwcmshc
       - snps,dwcmshc-sdhci
+      - thead,th1520-dwcmshc
 
   reg:
     maxItems: 1

-- 
2.34.1

