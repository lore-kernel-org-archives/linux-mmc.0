Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B5EE7D0C2
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Sep 2023 01:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjIVBvV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Sep 2023 21:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjIVBvT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Sep 2023 21:51:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009DF1A3
        for <linux-mmc@vger.kernel.org>; Thu, 21 Sep 2023 18:51:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fac346f6aso1450478b3a.3
        for <linux-mmc@vger.kernel.org>; Thu, 21 Sep 2023 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695347473; x=1695952273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPEbvkuSlI+waNlJffRe2ktpor2JpDqdyWj2rz7p8Wk=;
        b=Vtrg0dS1DQ1fJEANRO2Ih5Oofx6xZ3JW6pUPgxrxpY9MuyLUCkQVXH2b6Xe1OdU20s
         EW/PCeLI3B2ZRQkzUu/MWXsa98la71rcNFKIYt0QrHUyAv81YTyDPg0k9jdgQYGAJU1r
         u6R4k3W7G7j4rgFPKNAMha3effvfsZt6RWIxaQGtawTl0BnyE0VOrEajfRmO8MfrusRJ
         IJaBLq/3KcUPIg6jM8DC9JwyvuYyEJLBjAsIoYY18JU62CnU/XY9/TbP1Dbrl86zTGHt
         Rn1u/5ESnMrMc0EZ5WJloKJ63X03htgvdETC0A1EQ3q2hcM4UU9bQYOJokq1An4ifLNz
         Bq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695347473; x=1695952273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPEbvkuSlI+waNlJffRe2ktpor2JpDqdyWj2rz7p8Wk=;
        b=jrUbgLCwH6PcKb0dxL45E9KDZaMC5rPbrBfqntBpYvd2/D0+dt9xkdiQ2D6znN0LBt
         neQH2H3MkGwp1/xHCQzL2IisbfHoWVe1NQ+OXw0IcLFvAeoMwlqYUFjGiwUlPyvOmBEl
         cx/eP6q65TaMAc/p4UhxhzMhxE1yRCjBSk+srciZ751qA0V6MdT0SoLI7S01CULWUf25
         22TO8fz3y+41rBV+KM3YjrV90yIh7ThRTmbyQ8QqPBnBXf9iD/xGIc4IYH6bdwoBBfkQ
         Kou4d4v/h0tZ/V6eCgZRnPurIlYoigdXFyvKV1tQkT1sqyJbT8xrhippl2CbHYYkcOFk
         ANKg==
X-Gm-Message-State: AOJu0YxJk//j0l7SN9m7+CaNUP3ekGBqcJ7SuvpWcyeUczpbftxY94V5
        tTT7wYDV79MCnUXzDeHzzMJckw==
X-Google-Smtp-Source: AGHT+IE4X42yF1HXpuaoHL3ejmIEJ9fFuH2zgYBey6U1orqlaNK7fEzRXNdULELkEbDzi1O+u9EzjA==
X-Received: by 2002:a05:6a00:997:b0:68a:49bc:e0af with SMTP id u23-20020a056a00099700b0068a49bce0afmr8809508pfg.1.1695347473242;
        Thu, 21 Sep 2023 18:51:13 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:fa26:6227:be1c:67f0])
        by smtp.gmail.com with ESMTPSA id y10-20020a63b50a000000b0057412d84d25sm1973856pge.4.2023.09.21.18.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 18:51:12 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Thu, 21 Sep 2023 18:49:52 -0700
Subject: [PATCH 5/6] riscv: dts: thead: Enable BeagleV Ahead eMMC
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230921-th1520-mmc-v1-5-49f76c274fb3@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695347467; l=956;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=e7hYW7QNhal0RaNuGY3AGvE/4Ei4UdLG9Fj7V3U8VKw=;
 b=IYvBWMTKLnO4eGhXZDaLu7J6cKyV/rnBRhIPRir14soBubLYnpWwdB1YUX5SiQQsnHUuOHFn8
 opoUzD3CmAzChvQqTcQdMtI/oVbApUhunFrq/jQQ+eMCvA40mghGlE8
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add properties to the emmc node and enable it and set the frequency for
the sdhci clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index 70e8042c8304..dde645789b7e 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -52,6 +52,10 @@ &uart_sclk {
 	clock-frequency = <100000000>;
 };
 
+&sdhci_clk {
+	clock-frequency = <198000000>;
+};
+
 &dmac0 {
 	status = "okay";
 };
@@ -59,3 +63,14 @@ &dmac0 {
 &uart0 {
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
+	thead,phy-pull-up;
+	status = "okay";
+};

-- 
2.34.1

