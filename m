Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE578C77B7F
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Apr 2023 13:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbjDGNAH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240534AbjDGM74 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Apr 2023 08:59:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E7BAD34
        for <linux-mmc@vger.kernel.org>; Fri,  7 Apr 2023 05:59:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t4so37008455wra.7
        for <linux-mmc@vger.kernel.org>; Fri, 07 Apr 2023 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680872394; x=1683464394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUmOIxvTfzN/vGXSwBwDqutiowJ/QbUaHMK8ehs6bJ0=;
        b=Wx5r6rwoZXIrXBsodMUM0oII/5nipadhyGy6LHtFD+bB5yZjumtsv4QneVp0SBZlYK
         EP2Ng+ZOMLwIwTZ8ljMgdOKNDwLICtVoOp6+QWwgzXJdTky87OjW8pYOgmN3EqwoTdjq
         bniT5A+2hwsiahPETKGJQxe1dhH3cYn2EUawUyPFQFutmCa9wMYmImPuZtRdLQf6Yx7f
         ekqIrj60MXo1MSas3WS7rtqGPnhN9Lu0+uSSXpIgBDX5LyzVM/fg047O5ADZ+hHKFChf
         uxU3kC4CaX0D2nJqFP1qRtxoLePe/++yhC9McgUyAymTga45UysulDKvRS+WPy2Jk841
         G92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872394; x=1683464394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUmOIxvTfzN/vGXSwBwDqutiowJ/QbUaHMK8ehs6bJ0=;
        b=ZNCuaCDmzFEc/DhAlaVN36YTzpG3R21IsoYcep/zCeJ9kJquqtdKwCj2uDfnKBZmZb
         cZ3uRql1dPVBMjwK0GlPrKuUYJdZCsEfxIk2KiXO4TYZZhb4mAWnB/Mvmefennp0CKRm
         8sRa5LrC/lZLilAI+6vG3+DGHrkfqPdGD9ltN4eneSUF8AQNOl0aUaO0/pIHKfoiS42V
         tJBrH6JZxbb5LQ85LGYaQPkOzT2nzOid0pXOPjmBSLVk2DvcZLH3Og/qzzRXvjHXAC9v
         tYy5M21puoKGw2ndE5pQrk5o/ThHHqHq3PBhnS336u4YiIcPSQpX+JB5PCBDY403txb3
         Ngbg==
X-Gm-Message-State: AAQBX9fIDAhLkyASkztiO/06WPvZ+oKBd2sgRpJxK5EM/Y4gbBsUs0bp
        t/0L+WfluIOX9w2lEobhH22DBA==
X-Google-Smtp-Source: AKy350aU5oyIMQNJHKB2Q7i2iktd547uIw2cnWKNsd/AChoC9Z5ZjLNanzFJpOzwSjJwcwg8elCIFg==
X-Received: by 2002:a5d:440f:0:b0:2ce:aa73:4960 with SMTP id z15-20020a5d440f000000b002ceaa734960mr1151038wrq.5.1680872394222;
        Fri, 07 Apr 2023 05:59:54 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t4-20020a5d6a44000000b002e558f1c45fsm4471446wrw.69.2023.04.07.05.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:59:53 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 14:59:30 +0200
Subject: [PATCH v5 11/12] arm64: dts: mediatek: add cpufreq support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v5-11-1883c1b405ad@baylibre.com>
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=thd5AdegnYYpCr5cvUhR9vmXYqLF1bam1m97/2vSMvw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkMBO7mlVygoKoHzDLc4skrgvWXMffmUB2OTqvE1Pi
 c3wcQU6JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZDATuwAKCRArRkmdfjHURW/wD/
 919ZvcBWotpNTzA2QakuXWR8YpgHzJv5llnmMuVSbhBbh98pYJEpyrCdApt/o0bQ/uIRm5pkF60WSm
 8ZJ7SXU6o2qiBf/gmARfVUhXHMQilV8rCLWY/i533DB7NAGSR3641+5YUwcKW28WuhiNpH6p+0NC3K
 7trOW4KYf5i1PGss8QxCNWPHZzBO38y+QlmHQEo+UnmuBlA8ZPsnPMg2huqM9o80mrsYrhuY4+3UMH
 vWeInJFh9FitTBqjrE3dhuqu8ARfdpC/xlg6FlwOPVmNAEww1g5xth+44gh92VO7ppRL7+86ZEb4cM
 H9HVVm/UUXOmjuM4Qt8hBBQJ0tjz6sWSsQ4op9PaUCGgyosrZuh7DC4HtDMXyXgUmplQ95udNEXpdY
 f16gCioiIcveLbisi7y1ZLbtEhOO07DN5Ky1u5o5/7eYNLjMwjfK7gr4j90jEesvhW2QKpBdqIb1p+
 fNT4MKHSFAAUPFSoIXludMBQJC2y8K81qgGeHQo1I9RvFAF3m72PsA0S3Qu3MLYahHunihh1AQx6yQ
 taahWZkbNOu/mDMJeI29FKFhLlmLh/AG93+/XSdjOS8/Z8OM+GExcPp4bQdR0k0vUYYE6vpaYMi95M
 NqmK5xInj549swvCtQciPhpvZw+qTpSgs60jzuGbzUnlKAFBswFG4IY+PY7g==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In order to have cpufreq support, this patch adds proc-supply and
sram-supply for each CPU.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 431078f8670e..d723838ed49b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -88,6 +88,26 @@ optee_reserved: optee@43200000 {
 	};
 };
 
+&cpu0 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
 &ethernet {
 	pinctrl-0 = <&ethernet_pins>;
 	pinctrl-names = "default";

-- 
2.25.1

