Return-Path: <linux-mmc+bounces-9-linux-mmc=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C87BC4167B
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:49:09 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1DAB21017
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2BB3C69D;
	Fri, 10 Nov 2023 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i1cK7we5"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155943A29A
	for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 17:46:51 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBD2524C
	for <linux-mmc@vger.kernel.org>; Thu,  9 Nov 2023 22:14:07 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-da2e786743aso1862530276.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Nov 2023 22:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699596846; x=1700201646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSa6NAVY2VMgd1nmwOwphCO64qKVXCiZUmGbVj1XUeM=;
        b=i1cK7we5DTt214a5ulPm2LtIJ8geLPzN7OpKOFSzM5A7mfs4zlQVveyfoSmsxg6KWV
         sKZIRAHojJ1mOh2lfxzRFJAUE4s2MTpCxH7opJu6OPeMD8Kds5+4uAGhvJFK/1GgkgN4
         n8Z88ZSwrOH1Ro4PN1I9vJDJad44Ev+e6tzP7/jBxYll24Mmr7FsU24TBEnya7JmgqYh
         FwQkTV39oSHrD1M6pmLJg8NvK3bbaSCAtv2i6i5/Ro0vY+pQEeQK9BVNU8ZYSqv1Orhd
         NKG3uPjsnM3Xv2c7VwBv8tgOaWDU5S3TgX83nKoMvKuYQSo6DdDDpJiQYe0yyIThPwKe
         Ejeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596846; x=1700201646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSa6NAVY2VMgd1nmwOwphCO64qKVXCiZUmGbVj1XUeM=;
        b=BJv3GQQQwq8nQ/Cq5uSa6dmU2jlNvggEYa8+DYYaNBzuVswgZ9FrXwkiAVOUk0q21T
         XkQBb2KUyKkgXFhEoacNwXPPP8OXz8uXNZSp8Na+NHVgdP5P95i4zzUFIK92xRV659t4
         tsOlM8BGP/+nzxAKXTkU1/syMfaV0B3knK2EyuEgH0gFthZLroWi+LmJPjEImcRvS9ey
         5TYAbVrlatTr6z0y/lmxM53r1UJJKKjBfa6NJ9gIupRnwhbXXL9yVCDzhPsnSpe35MKa
         F/TFVNPMIhfKQ2eWlSP60FgFcBbKGepVXGg22WVHpl5K+4cnJIYf6F3nU+JH34s7sEEr
         JiBg==
X-Gm-Message-State: AOJu0Yw6yCFsPzsB1dK6bRQ0Z72IZ3BkcLwEDpuaKf1DthAEYBKpiJ5u
	la/WEp91AdEYJD1ivSLhRINJvkapmiKZhtsPyQeo9w==
X-Google-Smtp-Source: AGHT+IHc2dzth6LKzC6h7TBn2/SL7V+OAEY7bksLZRGZnVrvIoOC/yuSFZMolHtPmyTWRt1rlElQlA==
X-Received: by 2002:a9d:7a83:0:b0:6c4:897a:31d0 with SMTP id l3-20020a9d7a83000000b006c4897a31d0mr7519725otn.24.1699594956388;
        Thu, 09 Nov 2023 21:42:36 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:36 -0800 (PST)
From: Drew Fustini <dfustini@baylibre.com>
Date: Thu, 09 Nov 2023 21:41:16 -0800
Subject: [PATCH v5 6/7] riscv: dts: thead: Enable BeagleV Ahead eMMC and
 microSD
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-th1520-mmc-v5-6-018bd039cf17@baylibre.com>
References: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
In-Reply-To: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=1108;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=4bgo3aK3cuR26cRWBbMVA6MrvhUqOJ8As8gzvmDCzhs=;
 b=lALKEKj8Qm8uCPZT94ZeDZCapEMna2PJb7qYfmxdtsiIiPu5ZBsq1ZTsCjmwM7LQeHswhFuMT
 bUj9CkooLlrCm59R+vpdz5OfJa2nhKLJZ6dvleve4V8ZDgXFGGMNDkz
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Add mmc0 properties for the eMMC device and add mmc1 properties for
the microSD slot. Set the frequency for the sdhci clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index 70e8042c8304..f91d94f95510 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -48,6 +48,10 @@ &apb_clk {
 	clock-frequency = <62500000>;
 };
 
+&sdhci_clk {
+	clock-frequency = <198000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
@@ -56,6 +60,22 @@ &dmac0 {
 	status = "okay";
 };
 
+&mmc0 {
+	bus-width = <8>;
+	max-frequency = <198000000>;
+	mmc-hs400-1_8v;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&mmc1 {
+	max-frequency = <198000000>;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };

-- 
2.34.1


