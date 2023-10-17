Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F08CDB474
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Oct 2023 20:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjJQUpo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Oct 2023 16:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344481AbjJQUpl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2023 16:45:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76327125
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 13:45:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5859a7d6556so4596109a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697575531; x=1698180331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bR/IFAv1lnI0y6g+8jA+bwtSS6VCFSGKbX2JFhOV5b0=;
        b=hLak6oa9RY60EQrK8i3SH1/pDUCuPdydHyVU7ftfjwpftwTbO1QhwDjVMwG7VQEsyC
         5UK+5KX6O2058TXJKLXMxJH6Hskpmi5IjICmRfTXNcadfPoi+GNAjSt7IwfRo2DH0xpz
         4pmkOsn6QNaiMALImz73SU9jdh5HJCfpvQa+ny6bJg69A0xuJnEPpwDh+pYSfsDsIV2b
         WojQsQcj5ty6+uyLytCv+tV61v/jfz0NYa4LV9NvGNT+PHmmWC0px2HJ8EuGICjtd15K
         IGX7RntGbcPRK1CI0q3vm10z1XBfT3d1DlzcIN8MXjUEGAI9eAmaZ1RkPUy2KpawQui7
         SfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575531; x=1698180331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR/IFAv1lnI0y6g+8jA+bwtSS6VCFSGKbX2JFhOV5b0=;
        b=u7MWQr/0YMvy1d6vHzDqvhSrq7TGoho0qDRgbzrzcO81cLS8e7NdbpDFxm56i0drew
         sHtMFLMwhAA1vC5hb8EyWr5lGKHdYdVmMQAlPchGA4PgWmfe2k1HQcKdnJG2m2PfM/rb
         Rdf4TVsOy+/50NPTdVfkEYIMTUUHTmavPYxnemwzgwgMV9sOf9QhUm/bpIVv/plsLuxt
         NGeJfwo9ArD2SybXUAGXtwz1r+2xzMiTxtav6mzdJEz6ujdrm6vMuOVtmMEyy5pNc75H
         cIMZO6rYFmEoFRIab60xuEELeOjJ4B/7ZezkljH/SXQ53p6NzODvsGmUTvCxkFzFONLL
         QCEg==
X-Gm-Message-State: AOJu0Yw+cR5JczYcQo8BTPJFek3vmOy3INRHR5hLYDL8mmGOGzWBAW0c
        JiUSZhvZO++xVCAsihg09D9Ikw==
X-Google-Smtp-Source: AGHT+IG73caoxqESTeHk5XR1yvgGOUSKaOSDSG943bozBwmE7lSRPCi9n15GPtaVf1K5N2iNcWWPlg==
X-Received: by 2002:a17:90a:31b:b0:27d:50a:f8a6 with SMTP id 27-20020a17090a031b00b0027d050af8a6mr3293077pje.10.1697575530940;
        Tue, 17 Oct 2023 13:45:30 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:51d6:dcd6:63ef:52e9])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a6b8300b0027b168cb011sm1906553pjj.56.2023.10.17.13.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:45:30 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Tue, 17 Oct 2023 13:43:52 -0700
Subject: [PATCH v2 6/7] riscv: dts: thead: Enable BeagleV Ahead eMMC
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231017-th1520-mmc-v2-6-4678c8cc4048@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697575515; l=933;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=vNFZt2gizhpsjzH9MAKHp09E78+qWWf2znY/lpZAKnk=;
 b=j5MwipA9159XueCAdESnb2EitXe9gLx6ENZSvmnLtlql41q832inr6iR4u+oaVwFG7pwLGGN0
 Vi3eKERq18FDVLSmbURSHVWxMLqysL2SMc3AwBaEAzRyYd2aeL6EEmC
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add properties to the emmc node and enable it and set the frequency for
the sdhci clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index 70e8042c8304..bf55319ba950 100644
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
@@ -59,3 +63,13 @@ &dmac0 {
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
+	status = "okay";
+};

-- 
2.34.1

