Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E98C433FE
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Oct 2022 09:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJWJNR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 Oct 2022 05:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJWJNO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Oct 2022 05:13:14 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1895172B67;
        Sun, 23 Oct 2022 02:13:11 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 1C5F93FF91;
        Sun, 23 Oct 2022 09:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666516389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j9mrW/hduerytVdojlo3APh7PbXTuuPGsPr25UCn24I=;
        b=dtlIyWt2wZtE5M2hRo/zHb4KJqEPhBhZHm4bw2e9lKXBhlre/YjTRlZmw9M+zDFA8+aQos
        eIGyauZJl4MreJ5uItrhMuMup7QTTWfDdGF/H4KnN/5kIThqqfffeGY9ef9pVxkJTjqvHp
        GuFh9cuqHQpDbG2akYpg3RAyUWtSogQ=
Received: from frank-G5.. (fttx-pool-80.245.79.234.bambit.de [80.245.79.234])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 26A6B10009F;
        Sun, 23 Oct 2022 09:13:08 +0000 (UTC)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] Add mmc-support for mt7986
Date:   Sun, 23 Oct 2022 11:12:40 +0200
Message-Id: <20221023091247.70586-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mail-ID: 34b86ec0-a10f-4bc5-a043-30f82e5b58c6
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


Frank Wunderlich (4):
  dt-bindings: mmc: mtk-sd: add mt7986
  arm64: dts: mediatek: mt2712e: swap last 2 clocks to match binding
  arm64: dts: mt8183: drop drv-type from mmc-node
  arm64: dts: mt7622: drop r_smpl property from mmc node

Nícolas F. R. A. Prado (1):
  dt-bindings: mmc: mtk-sd: Set clocks based on compatible

Sam Shih (2):
  dt-bindings: mmc: Add compatible for Mediatek MT7986
  mmc: mediatek: add support for MT7986 SoC

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 137 ++++++++++++++----
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   6 +-
 .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   1 -
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |   1 -
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   1 -
 drivers/mmc/host/mtk-sd.c                     |  14 ++
 6 files changed, 124 insertions(+), 36 deletions(-)

-- 
2.34.1

