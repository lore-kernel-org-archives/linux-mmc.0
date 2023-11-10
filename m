Return-Path: <linux-mmc+bounces-14-linux-mmc=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6762C4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:50:18 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE45DB21896
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65C23D395;
	Fri, 10 Nov 2023 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N9OoLuXD"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52B3D96F
	for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 17:47:05 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E359D8
	for <linux-mmc@vger.kernel.org>; Thu,  9 Nov 2023 22:15:47 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cc56255e3so10459791cf.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Nov 2023 22:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699596946; x=1700201746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnDZGk512Fn6FcfRLVRqtgZTjSOOBJwTCzWACAW0uhY=;
        b=N9OoLuXDk5zKgU1YjwAgcxGhQs/RyW6jIWDT5r3mkHn9JFBAIzX3IVXr+zLqzSqxzg
         Gu7/TkUBtlGInwrt3Jhb3Xx6ecdpqqWS7OniUsW2KK90cKzmRlLKXoT6tfEt+eSEH5+/
         BTgInAw9Xf6ho5ucrztJBHLYs/ftMD+QHPeM+OqDUmhP/s2+4WwVHvVFWk42GbJ3RVD+
         v2WzO886XkLtjjruZ2y9AS13mm1O0kztG3kUrgkn7vO5ckUdylURthqolHaWcXTug+gC
         CxuuZp3MzmJ3/7/tO0zNygc3TIdbh0GXXFFXrvmg9j5Upfj1T8mqlvQ7CkCMLgZh6JPQ
         tF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596946; x=1700201746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnDZGk512Fn6FcfRLVRqtgZTjSOOBJwTCzWACAW0uhY=;
        b=lLVMqHVpquQH6RJNRE3VpBCoGmwyqxuHJGjn7d+iyBV0Wt/JFJmZeLUm6kJV5RrGcX
         zsKwFi4qqUC78LvX4+WzwGPfEuyfnm70vkvOFNX/Z25JddQTKWRqs3KqG32rZ4zXG6Al
         Dpy1YmAxcobzrrtS67/yKJK7BiS81B+BlBNJ7EpWObXrug/kS5NokFOklTawGN86qU/A
         KacqyqhTR3o8W+v5r8oaS3TVS+5IGq51zk1ZR5PS//vBzcQliw37U6xA0mlbGMq3FdEB
         etkKsXZFF/+IqP7z3BH+K8PDXs2Dq22QXjwNb0EIKW3/kQgNt6SRLiDlkkhCObD9C3Dz
         afTA==
X-Gm-Message-State: AOJu0YyBe49EZUZklOrdx5+h9ExL7B6dafzokeBxG+XIDrs7xlBbo119
	2UCUAEM1ku8FMgKyUUF/iRHBpKBwc1I62vDSNe1uJg==
X-Google-Smtp-Source: AGHT+IGTTsahV81/Rw5QlsTpUJVxQ1PAILctgM4NyU6BPo77WHSOVHAuWPMQfe9MkO/AQRFIKwQmIA==
X-Received: by 2002:a17:902:cf01:b0:1c9:d8b6:e7ad with SMTP id i1-20020a170902cf0100b001c9d8b6e7admr11068018plg.56.1699594958186;
        Thu, 09 Nov 2023 21:42:38 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:37 -0800 (PST)
From: Drew Fustini <dfustini@baylibre.com>
Date: Thu, 09 Nov 2023 21:41:17 -0800
Subject: [PATCH v5 7/7] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-th1520-mmc-v5-7-018bd039cf17@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=1102;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=vZkA/Rp2zWEJvsAGA/badfpHmHgx6/3DqqLzYe2IxQc=;
 b=fJaLj8Us7PpYhDPHDt2gAJV0CgQsotNJKZ73gVndaddpreipV21Pv9bXilRM3ODn6eiDa/Ubk
 h7kJ2SCtnDZD8g4t2P9LyI/wn5hmo7COmgWYmsLyqjWJR3zX5ICneL5
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Add mmc0 properties for the eMMC device and add mmc1 properties for
the microSD slot. Set the frequency for the sdhci clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi      | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index a802ab110429..94f1741435a5 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -29,6 +29,10 @@ &apb_clk {
 	clock-frequency = <62500000>;
 };
 
+&sdhci_clk {
+	clock-frequency = <198000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
@@ -36,3 +40,19 @@ &uart_sclk {
 &dmac0 {
 	status = "okay";
 };
+
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

-- 
2.34.1


