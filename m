Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971DDECDFA1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 13:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiJYNaR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiJYNaN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 09:30:13 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFB0E195F;
        Tue, 25 Oct 2022 06:30:05 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id 09BF96269E;
        Tue, 25 Oct 2022 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666704604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FbSf9twERvETDm4iNLtIwwA/uZDMLwNyqcMb0P1AC4=;
        b=M70gzvNjSVP8os7+u68LOoPoxFjVqN2sNM94ZSip68YoZaZWBiDq6X5/GLh9K5vR4sIDyX
        CXXOQi7DAIeSKHHYbQ1pGknvpu5cFVEpRVwvixzDdRzdhyFOmXTPr+qHjglaOirSs5jLBL
        J2dVYr50qTuaeyR9oO17e9ssuKTku3s=
Received: from frank-G5.. (fttx-pool-217.61.152.57.bambit.de [217.61.152.57])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 9E7CF406DF;
        Tue, 25 Oct 2022 13:30:02 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>
Subject: [PATCH v5 5/6] arm64: dts: mt7622: drop r_smpl property from mmc node
Date:   Tue, 25 Oct 2022 15:29:52 +0200
Message-Id: <20221025132953.81286-6-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025132953.81286-1-linux@fw-web.de>
References: <20221025132953.81286-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: da3b5ec5-4663-4d83-aad4-cc50a829ea61
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This property is not defined in binding and driver.

Fixes: 2c002a3049f7 ("arm64: dts: mt7622: add mmc related device nodes")
Fixes: 0b6286dd96c0 ("arm64: dts: mt7622: add bananapi BPI-R64 board")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v5:
- add fixes-tag
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 1 -
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index d3f9eab2b784..af3fe61e4093 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -235,7 +235,6 @@ &mmc1 {
 	bus-width = <4>;
 	max-frequency = <50000000>;
 	cap-sd-highspeed;
-	r_smpl = <1>;
 	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&reg_3p3v>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 36722cabe626..b74e774c6eba 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -208,7 +208,6 @@ &mmc1 {
 	bus-width = <4>;
 	max-frequency = <50000000>;
 	cap-sd-highspeed;
-	r_smpl = <1>;
 	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&reg_3p3v>;
-- 
2.34.1

