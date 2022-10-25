Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792D9C04A95
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 07:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiJYHmt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 03:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiJYHmq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 03:42:46 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC5415627F;
        Tue, 25 Oct 2022 00:42:44 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout1.routing.net (Postfix) with ESMTP id 7CE83403E1;
        Tue, 25 Oct 2022 07:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666683762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f/hGfrwnMhOVRX7cm/mY3k2KPSFfRkFZFxpavcHfejc=;
        b=Nm/E7WnAuZ3Ps2L3++5tumhrmHVB9IaL7vb907rsL9ohxuu9pGBSxWmEcIwlev12m0d/6s
        y5i6EfsULUw+5Y/eQlZ42fDSZE6tpCoc9yLJ97+UesUgGwNfE0cfPMFHfQruDPnCWd/0kB
        H/qlv9cSsLp9el50IDdsVJsMb2aoIhY=
Received: from frank-G5.. (fttx-pool-217.61.152.57.bambit.de [217.61.152.57])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 55801360310;
        Tue, 25 Oct 2022 07:42:41 +0000 (UTC)
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
Subject: [PATCH v4 0/6] Add mmc-support for mt7986
Date:   Tue, 25 Oct 2022 09:42:32 +0200
Message-Id: <20221025074238.18136-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mail-ID: d27fab61-19f8-4c93-835c-c4d13b36beb1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

I've noticed the mtk-sd binding needs a bit more work get into a more
clean state.

There are 2 properties missing that maybe need to be added later or
dropped from devicetrees:
drv-type (which is used in mt8183-kukui.dtsi and set to <2>)
and
r_smpl (used in mt7622-rfb1.dts and mt7622-bananapi-bpi-r64.dts, both
times set to <1>)

i don't know their function and boundaries and i do not find them in
driver. I guess they are added by accident, so i removing them in the
patches 5+6.

v2:
- add compatible based binding
v3:
- solve "not" statement in binding and reorder if statements,drop mt8183
- added patches removing invalid properties (not in driver)
v4:
- squashed part 1 (compatible) and 3 (SoC specific clock config)
- new mt7986 clock bindings based on info from mtk
- re-add mt8183 reg boundary

Frank Wunderlich (3):
  arm64: dts: mediatek: mt2712e: swap last 2 clocks to match binding
  arm64: dts: mt8183: drop drv-type from mmc-node
  arm64: dts: mt7622: drop r_smpl property from mmc node

Nícolas F. R. A. Prado (1):
  dt-bindings: mmc: mtk-sd: Set clocks based on compatible

Sam Shih (2):
  dt-bindings: mmc: Add support for Mediatek MT7986
  mmc: mediatek: add support for MT7986 SoC

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 149 ++++++++++++++----
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   6 +-
 .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   1 -
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |   1 -
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   1 -
 drivers/mmc/host/mtk-sd.c                     |  14 ++
 6 files changed, 136 insertions(+), 36 deletions(-)

-- 
2.34.1

