Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A636EB64DC
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jun 2023 19:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjFYTS0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jun 2023 15:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFYTS0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jun 2023 15:18:26 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F81B3
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jun 2023 12:18:17 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id C8EB6615E2;
        Sun, 25 Jun 2023 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1687720318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=95R2PdMvXWYk6kmQoK82DSLDIGUfDs+//q4F16BXYtM=;
        b=dRNGu2MARH/swPgMCibgu5UMnKgzQB2hcMe3QNYJAjX1OGwbItma/hXxL9SmSqRN7GWRDf
        iBa7F7cKJfXjVUttwbrYjSu27gBjztCngFje4E3W98caC2LYrB0lAUSLDkCryWHskntdM/
        +06TjSARQoPzqBTP0GTsBFCXM44CBC4=
Received: from frank-G5.. (fttx-pool-217.61.151.158.bambit.de [217.61.151.158])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id D7DCC3603F2;
        Sun, 25 Jun 2023 19:11:56 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/2] Fix emmc hs400 mode on mt7986
Date:   Sun, 25 Jun 2023 21:11:49 +0200
Message-Id: <20230625191151.7808-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 1459b5f2-88f7-4804-8036-8a7bda31a940
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Eric boots linux directly from ATF without using uboot. In this corner
case clocks for emmc hs400 mode are not correctly setup.

Fix this by adding assigned-clocks and assigned.clock-parents to mmc node.

Eric Woudstra (1):
  arm64: dts: mt7986: fix emmc hs400 mode without uboot initialization

Frank Wunderlich (1):
  dt-bindings: mmc: mtk-sd: update assigned-clocks/clock-parents for
    mt7986

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 4 ++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi         | 4 ++++
 2 files changed, 8 insertions(+)

-- 
2.34.1

