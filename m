Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD5EC41535
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Nov 2023 02:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjKBCtn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Nov 2023 22:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbjKBCtl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Nov 2023 22:49:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86971A6
        for <linux-mmc@vger.kernel.org>; Wed,  1 Nov 2023 19:49:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc131e52f1so13276445ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 01 Nov 2023 19:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698893366; x=1699498166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnDZGk512Fn6FcfRLVRqtgZTjSOOBJwTCzWACAW0uhY=;
        b=MVBwdtE22oU/EkqEguSUqZF1KYRN5UxJbzTyRNn8fzuqZvj+MYqAosKsycO5wulOZE
         h6I8tExe+jaCjNOZykpoHsX6A4CteP5l8eZyCthHlHUeBocT0MJPW6VwE3GjJ2JWU314
         aJEwTwonMNzMRoFKmCMSNxn6x1tLVETIpgS4Ck9JghDn7rsdt/uHK1rP4by8mnyav8jy
         56VQTADy3D7E93zEaI1E4CuNzXerwVA/xBX7YMLzac6uj4lZupT1vDwH4L2PwsHsHbzX
         fxzt4+zSlKVsxrIhDOD+yWNUXSr918GfEhBf1IVmOF6JAcmODjag40FlmpuMOvvVoSXZ
         3HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698893366; x=1699498166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnDZGk512Fn6FcfRLVRqtgZTjSOOBJwTCzWACAW0uhY=;
        b=KC/C47YvJdV5pXIe62I6fgxCQlA/wMFPQIF7PJHh/sOG6i7Zul+I2rv6o0GXrKlUd2
         0TImwJDGZFrmWBnaMbjqRorpH5mjkr0dfty7Ce0LUMyuh8+jcqw596YnMJrJg88FvKg0
         x2mVJCwDyol1t6DlhoZUs5aufDkWeq1yXudkdsj1XDikSRgnODSFQ1E3X/ghoqFFAY8T
         IBRmz1J9r6/8kj4kYAuu81azUECewGh78UIN6noolsRITlVSzQFQ6WLz2tQ17wwx5nQn
         lbUzlaQfOUtO5GK8wmq9e2hvGXAz6hU7XPTQXKHjGr5JOYfd1MnIPr59JwGAEI6IbLDQ
         5HPw==
X-Gm-Message-State: AOJu0Ywpd7u2oqRX13ezx35IjCspcPiRi8D/l9jAjY6OcsWlvD+xXH/q
        g3iRJMduEbIiRjCgtvLQE8PWlg==
X-Google-Smtp-Source: AGHT+IFotN+N+05ghfeh6n+nIwmS9iXKFbCoDtCFHfdCTkyZqRbHe40loI/Ve+moBfFjdnP9WDRB8A==
X-Received: by 2002:a17:902:dac9:b0:1cc:5ce4:f64b with SMTP id q9-20020a170902dac900b001cc5ce4f64bmr11068897plx.8.1698893366171;
        Wed, 01 Nov 2023 19:49:26 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:7e4c:4d4e:6943:bc0f])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001b850c9d7b3sm1925787plf.249.2023.11.01.19.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 19:49:25 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Wed, 01 Nov 2023 19:48:58 -0700
Subject: [PATCH v4 7/7] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-th1520-mmc-v4-7-86e0216b5994@baylibre.com>
References: <20231101-th1520-mmc-v4-0-86e0216b5994@baylibre.com>
In-Reply-To: <20231101-th1520-mmc-v4-0-86e0216b5994@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698893345; l=1102;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=vZkA/Rp2zWEJvsAGA/badfpHmHgx6/3DqqLzYe2IxQc=;
 b=8GSfHaYjbAvdqR5aNak0qxCYTox6ynEJYklYiqEqs75Ahp961sktUsZMwhbfP69H8eDCKd2iX
 Qb0BX3cam5JBwzRquUhN8ceX4V+t4liKW0/NNfG/NOH4PRVtvHtorW+
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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

