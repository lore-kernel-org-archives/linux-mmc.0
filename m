Return-Path: <SRS0=OPc0=BX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFB8C433E1
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Aug 2020 09:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF3B20866
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Aug 2020 09:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HbQYefQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMJHX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:07:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36026 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726048AbgHMJHW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Aug 2020 05:07:22 -0400
X-UUID: a4cf335fea674575ba5035840ca2ff7c-20200813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xVTG3i3NZ+1cOXWR7yCUvveG4pS/BEjPy1kRWzM1V+Y=;
        b=HbQYefQ5NBkj3GDSJjtA/+x89HH/uN9Yv9L3ly/W4/gvuarutfb2vNlrPZLg+hUXhePRF+S3577BM3GK8xakxrDrAmCASUihsnYgb/8nVg/tnMeGVY4wr4BPBNvqDlhrg4rvVN+VxiEENfCa7iD9847kXX8JxJ9R0nVHnWgvllA=;
X-UUID: a4cf335fea674575ba5035840ca2ff7c-20200813
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 259483423; Thu, 13 Aug 2020 17:07:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 Aug 2020 17:07:17 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Aug 2020 17:07:16 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [v4,0/3] mmc: mediatek: add optional reset property  mmc: mediatek: add optional module reset property  arm64: dts: mt7622: add reset node for mmc device Documentation/devicetree/bindings/mmc/mtk-sd.txt |  2 ++ arch/arm64/boot/dts/mediatek/mt7622.dtsi         |  2 ++ drivers/mmc/host/mtk-sd.c                        | 13 +++++++++++++ 3 files changed, 17 insertions(+)
Date:   Thu, 13 Aug 2020 17:06:15 +0800
Message-ID: <20200813090618.28009-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

LS0NCjIuMTguMA0K

