Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663A5C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 15:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F0C610FB
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 15:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbhITPKu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:10:50 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44106
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241201AbhITPKu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2021 11:10:50 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C1AC040267
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2021 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632150562;
        bh=2AzFw7QWiJnpc3+D+qC2D6oogvLnCMo5bvL1ARpYSXo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GzisCl0VFyuetRRa2ZKFMqFNQd0wVpmc6HjhyxEGWjnRJcmN7kxEV6LZ5viCQqISD
         3/GUXGGIaUCzWKpZ2vgzXds/61Zm9C8e+ZKzYamsv8/mCPk6pC/sR2bND77mFmHRa5
         1SBnyRWIJi7kChZWuNM5fFj5081ws1aOfqedtZ7D7vpXMicZ8HEkgitRBkD62rj/PG
         W6vElJofhpo/ZJ5Liaq60wNYAQgAbPDW5G1Hpmwx3KpsJ/D+HClNs/URSJDWSw57Gf
         4yjaIPR9qLWDkpyXDnS824n0Og1aAlooO3/pLePvAKDUmd0CFQqs4ngN7BLzOalNIt
         3LKNX5tfLqicg==
Received: by mail-wr1-f69.google.com with SMTP id v1-20020adfc401000000b0015e11f71e65so6372744wrf.2
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2021 08:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AzFw7QWiJnpc3+D+qC2D6oogvLnCMo5bvL1ARpYSXo=;
        b=xe6jTlDkwM2Pe9rGgXa5+Yrz82EAJ1VWaqZTZk/LaEU7O0Dn58+C9xOB/TYRCFhhqc
         /A7b3BqgxygE0MVuzh4I5p3GcVkZd6ij9cgrP+7eW/ygM13WRhq4KVdzktALslxuXKU4
         +K8S/8JQC9XC44wjwa4JOgrTgl0yiOJJv/YC1sOBxs1Fy2QWCQa4IeS5H51DfA+jJ+oX
         3ttJdm1oyJMWcSJ2w8UtyduXSXwqfZT8g83l/dPdLwx9PJKUfxSskV7LnOuyBRZt2Oey
         KoDpf1FoxVrdHGxWbOlN62GpCo0qFuSMmRkLThaAHCEP+kL0Q7XpfRIEtWoHRIc4uLPl
         Lq+w==
X-Gm-Message-State: AOAM531fFKHpJr51wm5yi5q+UHQdpc+5aTnzTJ2NcFcH8/MnDhjqcBcz
        6OrrwtROpC6Scpxtpa5Skr5B9PnJPSRrMmjl9dJvWLYKLB1gJal98QAgjPRG/9aMKEM3MhWDrVC
        kIta0aO7s2MhtdQe5DEPdvwF57Dof7t4d5FWHEw==
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr24829313wmj.163.1632150562323;
        Mon, 20 Sep 2021 08:09:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh9HwY7qtDiYuXsvesg74JozhNdGgdehheDKBXdv1dZ+7W5s7qvmts4pXM0X21xET38Gx3ZQ==
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr24829283wmj.163.1632150562129;
        Mon, 20 Sep 2021 08:09:22 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i2sm15803136wrq.78.2021.09.20.08.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:09:13 -0700 (PDT)
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
Subject: [PATCH v3 3/6] riscv: dts: microchip: fix board compatible
Date:   Mon, 20 Sep 2021 17:08:04 +0200
Message-Id: <20210920150807.164673-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to bindings, the compatible must include microchip,mpfs.  This
fixes dtbs_check warning:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: /: compatible: ['microchip,mpfs-icicle-kit'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Use microchip,mpfs for microchip-mpfs.dtsi, suggested by Geert.
---
 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 2 +-
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index 3b04ef17e8da..07f1f3cab686 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "Microchip PolarFire-SoC Icicle Kit";
-	compatible = "microchip,mpfs-icicle-kit";
+	compatible = "microchip,mpfs-icicle-kit", "microchip,mpfs";
 
 	aliases {
 		ethernet0 = &emac1;
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 93730afe6c58..5084b93188f0 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -7,7 +7,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 	model = "Microchip MPFS Icicle Kit";
-	compatible = "microchip,mpfs-icicle-kit";
+	compatible = "microchip,mpfs";
 
 	chosen {
 	};
-- 
2.30.2

