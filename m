Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37E8C41513
	for <linux-mmc@archiver.kernel.org>; Sat,  5 Aug 2023 03:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjHEDP1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Aug 2023 23:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHEDPU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Aug 2023 23:15:20 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9118C4EE2
        for <linux-mmc@vger.kernel.org>; Fri,  4 Aug 2023 20:15:17 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56c4457c82eso1841494eaf.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Aug 2023 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691205317; x=1691810117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdRLfV4DSjo6NuAp3G0Z9YBsmLluT1U9pYT+QCm2Ogw=;
        b=Sirb95geXOpdF+w/pVzPoQoiCURDTSuciOvn/xUei5K3StbbKfG9M9SWWEJA6J8KXW
         2Pdu8HvmQP+5V+NXfwzERYjQ7of36NJWN65NM7hwyB1fdGhyXt2V2nzzPNo7sc3dKOUj
         H9ETNR/cjSxuMB4y9dkfqhV84Ch1c7BEnDmaWD0I8kXJ/r6kvINdyrx1D97Aw7kLMlok
         1FBUpcFV0j54uWg0DwZpQAeAU2kgJnCz+3GeIEKCC6l4QckkNfOvi/klhWAZ5/Z+UpGz
         RQG+9MdYLIa289mgJtDhKk1PhXLXDpk7FaRD9y0QS2xEhxi0Ee2vHnOVwB15DQyy7ZSu
         l9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691205317; x=1691810117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdRLfV4DSjo6NuAp3G0Z9YBsmLluT1U9pYT+QCm2Ogw=;
        b=WH+M+RYx7ygRtkvx3UKPDaHE7NeTWNXSkBaB96JJBQxf8hIeDvyUhLi6Po6tbUN4Xi
         Z1kvNUPEERm2NC1O/wFWlR5KLN21wkxw2QVF0lrrvxr3rnIHeV/gk6+zpLMONMecFNr7
         f74A9GUZh1nLaj76AAMf6tg2Ro9BN/glrYYgP802Qrbe0aoe12sd29Oc7ONaqYTqaEE7
         J+XcBrS2/P601v8vwu33fFKTQMhNdE+565injiW2eTqnqLvcjKrwGoHW/JQgmezHoEEr
         2bmQ0AFtFQ20zi1mmSkSSNvnxuNSXUUdPDvPyT+kkNiibJWWJqPOp5bQ/HE+twEnD72c
         t2Mw==
X-Gm-Message-State: AOJu0YwjDourxoYxZSxLk4CBcUfE5nl3nI6zxe2eGLGSu+hQ9MYZJ8oM
        UMyCtrphrKbhzuor7McOI1S2+g==
X-Google-Smtp-Source: AGHT+IHzW5Dh9evbuaAvm6UO7LWse/VuKTkLwUY6Eyif2RtvDcFf9wUdYu+dWABgQoDwdkeE2gAtHw==
X-Received: by 2002:a05:6358:5284:b0:134:c682:213f with SMTP id g4-20020a056358528400b00134c682213fmr3883804rwa.31.1691205316886;
        Fri, 04 Aug 2023 20:15:16 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:e1a0:2f9c:e6f9:e66c])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001b864add154sm2412145plf.154.2023.08.04.20.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 20:15:16 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Fri, 04 Aug 2023 20:14:47 -0700
Subject: [PATCH RFC v2 3/4] riscv: dts: thead: Enable BeagleV Ahead eMMC
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-th1520-emmc-v2-3-132ed2e2171e@baylibre.com>
References: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
In-Reply-To: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691205312; l=980;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=fq1uqgjhziV70k9ct30okgNDov04CSkcqVTv+e1VQgM=;
 b=xot9eapxH2cUSYpXQoibI8Z4Ff4UD4GK5A3fDmYWMiila2+9XbnG2Rse6zZNWn3UKb70c0va1
 AiqYKQdIC4iBvQL1X269HN0jdo6Y/rlkz5B+PqnyS6gCAcsFHaH9S3n
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add properties to the emmc node and enable it and set the frequency for
the sdhci clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index c315e5bd3d2d..f93c11754639 100644
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
@@ -59,3 +63,16 @@ &dmac0 {
 &uart0 {
 	status = "okay";
 };
+
+&mmc0 {
+	max-frequency = <198000000>;
+	non-removable;
+	mmc-hs400-1_8v;
+	thead,io-fixed-1v8;
+	no-sdio;
+	no-sd;
+	thead,pull-up;
+	bus-width = <8>;
+	status = "okay";
+
+};

-- 
2.34.1

