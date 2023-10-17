Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42227CDB474
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Oct 2023 20:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbjJQUpq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Oct 2023 16:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjJQUpj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2023 16:45:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DEB11A
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 13:45:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so3351626b3a.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697575528; x=1698180328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhR9frpmu/yAUsLJSS2gpg1w0JSCDYrDF2EFLnkclH4=;
        b=AFT+/dHWRxUR3sfND5zipJY/NIX4nZu0FNYNEO7TwwgUoUEd48u/yqbF60YsZEZJ9w
         4B0wyVWF5Pu+GipcJGNm/+pEUXYXWjHAlbCSDh5IbgZBmHzuK8DBR9J5+UfCdgwGJ9/7
         mn+rOcV34Xce7DlT39xll4bXjhJ7IwZtFsRQT3Dt0XOAeObngJVhCqZPACVevlcCHBeQ
         ANwBKrxJ0l7BeJi0pm2KOyQGlhFaOuKXfexHNmnDkVllv47gnp4uWFTvXiS5m49KJBMQ
         UiowSchR0e8k/ix3UNLMdm/YX1z4pyA+ae7CT14Bb8sZLmxcLyYwtGAGlt4X5b0t8F1M
         a6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575528; x=1698180328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhR9frpmu/yAUsLJSS2gpg1w0JSCDYrDF2EFLnkclH4=;
        b=fyqtJ2EDORPTP4zTeIbi/DHCNPEAQ94J01cNRzy4FTPWNhB2c4qTGTUkQTDGiIVEnP
         NFDNce67pTF4eOLnZQ5xySCHWqF+fgmoUy2tSa+5OUkwYtnesEm9g2RZw7e6NmfDYiG3
         vfAqSZM0CGEGwteXnfTQEq/jc3YdHzVGCxIQtxIxOKoDmGYR2ldV2CYHuXelNXUpLFiz
         BK5WVrXen/ktvJwmyJBW7LwsFIU3Z0X4HjqR6AQpn+EvZd6B0rdq9YDobEn11/yZbhGz
         8Se4CmvfkKR7LolYfPdUjlTC/YWHAY8vSdasNytmyFZFw7XR5DYN9mUClocYmTuzpvNG
         YXCg==
X-Gm-Message-State: AOJu0YyaGJbQaRpuKJWccUyErmGCXmGXilgguwdx2odI5rLtioSBLWIx
        /eym+K3Vtn5ZKebFhbEX+Qhtcw==
X-Google-Smtp-Source: AGHT+IE7E/rW2mbc6xNEhKDqX9w4aYvx/W8/zfByPnf9rcrtNEjn1LkUl36z7pQ7qVPNU4UJBZy+Cw==
X-Received: by 2002:a05:6a20:72ab:b0:15d:684d:f514 with SMTP id o43-20020a056a2072ab00b0015d684df514mr3481188pzk.6.1697575528704;
        Tue, 17 Oct 2023 13:45:28 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:51d6:dcd6:63ef:52e9])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a6b8300b0027b168cb011sm1906553pjj.56.2023.10.17.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:45:28 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Tue, 17 Oct 2023 13:43:51 -0700
Subject: [PATCH v2 5/7] riscv: dts: thead: Add TH1520 mmc controller and
 sdhci clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231017-th1520-mmc-v2-5-4678c8cc4048@baylibre.com>
References: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
In-Reply-To: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697575515; l=1256;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=BOuTsoiS4wD+cP61c2nYQjChDl2neNVnlaTjhPPnjNo=;
 b=dcjpH9D4/iuzxXetEkXlXo86ynK58hWjYsp59cgxdD/sG0SgXrxZ439+HwU+bql+QBAfc0iv0
 l9K6iCBFRIzATnT9moU6vrLC7rmog09qtMRbIBbp7o96+Fr82mQl/EW
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add nodes for the SDHCI fixed clock and the first mmc controller which
is typically connected to the eMMC device.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ff364709a6df..ee0711352790 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -134,6 +134,13 @@ uart_sclk: uart-sclk-clock {
 		#clock-cells = <0>;
 	};
 
+	sdhci_clk: sdhci-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <198000000>;
+		clock-output-names = "sdhci_clk";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -292,6 +299,14 @@ dmac0: dma-controller@ffefc00000 {
 			status = "disabled";
 		};
 
+		mmc0: mmc@ffe7080000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7080000 0x0 0x10000>;
+			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+		};
+
 		timer0: timer@ffefc32000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32000 0x0 0x14>;

-- 
2.34.1

