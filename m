Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA64EC2D0A3
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 07:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896B9221FE
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 07:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgKLHwQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 02:52:16 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43907 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbgKLHwQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2020 02:52:16 -0500
X-UUID: 043c44a4ea624b9ea6b5f30c84e81022-20201112
X-UUID: 043c44a4ea624b9ea6b5f30c84e81022-20201112
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2054585594; Thu, 12 Nov 2020 15:52:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Nov 2020 15:52:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 15:52:09 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <irq-linux@rere.qmqm.pl>, Wenbin Mei <wenbin.mei@mediatek.com>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v1 0/3] Set cqe off during suspend flow
Date:   Thu, 12 Nov 2020 15:52:05 +0800
Message-ID: <20201112075208.28183-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Wenbin Mei (3):
  dt-bindings: mmc: Add optional cqe off properties
  arm64: dts: mt8192: Add cqe off flag
  mmc: core: Set cqe off during suspend flow
---
This patch depends on
[PATCH v7 3/4] arm64: dts: mt8192: add mmc device node

Please also accept this patch together with [1]
to avoid build and dt binding check error.
[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=364279
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 7 +++++++
 arch/arm64/boot/dts/mediatek/mt8192-evb.dts               | 1 +
 drivers/mmc/core/host.c                                   | 2 ++
 drivers/mmc/core/mmc.c                                    | 5 +++++
 include/linux/mmc/pm.h                                    | 1 +
 5 files changed, 16 insertions(+)

--
2.18.0


