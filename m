Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86BFC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 12:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9BB610D1
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 12:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbhIQMkU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 08:40:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52276 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239003AbhIQMkU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 08:40:20 -0400
X-UUID: 1c422ba6618c42ef9e11a9fe57a2910a-20210917
X-UUID: 1c422ba6618c42ef9e11a9fe57a2910a-20210917
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1749033728; Fri, 17 Sep 2021 20:38:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 17 Sep 2021 20:38:52 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Sep 2021 20:38:50 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yue Hu <huyue2@yulong.com>, Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] mmc: mediatek: Add HS400 online tuning support
Date:   Fri, 17 Sep 2021 20:38:48 +0800
Message-ID: <20210917123851.22741-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Change in v4:
- split driver patch into a core patch and a mtk-sd patch
- use mmc_get_ext_csd function
- move mmc_get_ext_csd() to include/linux/mmc/host.h
- modify some commit message.

Change in v3:
- add detail descripthion for hs400 dly3

Change in v2:
- remove the check "mmc_can_ext_csd"
- change the hs400 tuning condition for "msdc_cmd_done" function and
"msdc_cmd_next" function
- use "-EIO" instead of "-ERANGE"

Wenbin Mei (3):
  dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
  mmc: core: add tuning support for HS400 mode
  mmc: mediatek: Add HS400 online tuning support

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 12 +++
 drivers/mmc/core/mmc.c                        |  8 ++
 drivers/mmc/core/mmc_ops.h                    |  1 -
 drivers/mmc/host/mtk-sd.c                     | 79 ++++++++++++++++++-
 include/linux/mmc/host.h                      |  4 +
 5 files changed, 101 insertions(+), 3 deletions(-)

--
2.25.1


