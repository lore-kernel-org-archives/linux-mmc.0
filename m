Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B89BC4167D
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbjKJRqd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345942AbjKJRpk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Nov 2023 12:45:40 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124774EC6
        for <linux-mmc@vger.kernel.org>; Thu,  9 Nov 2023 22:13:26 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc0e78ec92so12945015ad.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Nov 2023 22:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699596806; x=1700201606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frioRiPhaekRnCE/0ENvI5wkvdspg2jE1Z81EEiVDoc=;
        b=1Zf56glgIe/JnDJGp3+ThDIqmshIGLMKGM8YG7FGSgW/ga0/m4roq7TDlt9uKFSUaY
         dQinCq963kZx7Hpq7gRUP9xOU8W+mYvjUsY1M2VtYVw/1tpsfFf+1++jtDt2cvZ/5fkd
         72xXy6xSeHDNFJG+v2G/3PZfQhmvW7VtQuESXQVejSpJIrDna12rgSMI8dZGIaqRj9CA
         uFUdssYV4DLWRQgh8jXqF071oQtuKu8nMrXqvr7obwPHNSy5QakKIxrzGiP+Ay3EQcht
         yO8w2Z71G9WTHFMDn+rJN36mriQMh6qZcUb4B7Dq8heVDPJjdGbtOCxvXJ7+2L4O8G1G
         Nz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596806; x=1700201606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frioRiPhaekRnCE/0ENvI5wkvdspg2jE1Z81EEiVDoc=;
        b=d4sD1nl/orROhfdNMm+SP9eHZfqQ+Aj4XsT2IZDuWbETzm3Kr6VGznlrj4UGCYGURa
         6QhovA0GlE3MkdLJqgNdd/+PZQQhreDblH0bi/yMHqp8SHqVs286oxpS3VGAsISV3SSi
         UU7OcvzmXMMTLrgU4ysFWjI0KNloKBhUuTJw7rn0wB+JBjUW5ylk0LHD3L2UxL46smMh
         InjgQ6gJt6qYIb7AEMqF1c5IRMmAvlJuXoh8aabkBjkLm4NYDKdePL7lxNkxXDaaL6d/
         Ok7XIAY6DIixhXgcZwjUm0OyRTp1q/nWKbBMYjgHPZoKQLeZqpEqeIwRhovU3RXnAKVw
         U01w==
X-Gm-Message-State: AOJu0YwDel44WurFoYQ7z+UZYwTMQzu5aAXmExWbq982g+6K+w1r0rDl
        s5xqB9MBRlC6S/IGXk7D4Rwu6UbWrfEWwBhuqIK6RQ==
X-Google-Smtp-Source: AGHT+IEPm64O/kPii92CwhwQe1YfvABcclwau/EBIc09Nos6a3An9QWe0GQ8ouZ4SdnmIGy2UbbfeA==
X-Received: by 2002:a17:903:41cd:b0:1cc:6fa6:ab62 with SMTP id u13-20020a17090341cd00b001cc6fa6ab62mr7777004ple.29.1699594954577;
        Thu, 09 Nov 2023 21:42:34 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:34 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Thu, 09 Nov 2023 21:41:15 -0800
Subject: [PATCH v5 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-th1520-mmc-v5-5-018bd039cf17@baylibre.com>
References: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
In-Reply-To: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=1608;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=118IOeI3EDHQnRGvuv5ewuNsGEAnYvxtIZdzQTMEyXk=;
 b=yeOrLz+tWTsGAfXBiTlsUCM457E2vnWs1IdM64XT3ndoS1ZsuBso99iSFBRWZAC6Hpujod2vK
 xZA5w+PGj/PAXAJNWux4UMW0MTSz3dqYn8V63Datq2uZLRYpXMPuJ8B
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add node for the SDHCI fixed clock. Add mmc0 node for the first mmc
controller instance which is typically connected to the eMMC device.
Add mmc1 node for the second mmc controller instance which is typically
connected to microSD slot.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ff364709a6df..f5ec9326c4b8 100644
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
@@ -292,6 +299,22 @@ dmac0: dma-controller@ffefc00000 {
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
+		mmc1: mmc@ffe7090000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7090000 0x0 0x10000>;
+			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+		};
+
 		timer0: timer@ffefc32000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32000 0x0 0x14>;

-- 
2.34.1

