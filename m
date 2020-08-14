Return-Path: <SRS0=tY5E=BY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D870BC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Aug 2020 01:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15D220838
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Aug 2020 01:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QZFjyqkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHNBov (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:44:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22178 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726546AbgHNBou (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Aug 2020 21:44:50 -0400
X-UUID: 29e5d8f9d22743ed920101afc580e7c6-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9ZnEnu6K897ao5P0qrIaTQj+7R2GblfoAxUk/BmTKVs=;
        b=QZFjyqkgGL5FkmNYeNsRFLcwbjBc+8Z2OXLFhclfTd3IwiTHFbOgGqxKYydscbAmR6c/xacGHciBs0Eg90G68jNlQLyKsXPr2lsnoEPbrtYLrWWA3IGztQ5P/g60HAlpg7MSTjaroOUkwvgPPk8KY0LXamljfSudjqDQr/cIEyc=;
X-UUID: 29e5d8f9d22743ed920101afc580e7c6-20200814
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 781860604; Fri, 14 Aug 2020 09:44:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Aug 2020 09:44:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 09:44:44 +0800
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
Subject: [v5,0/3] mmc: mediatek: add optional reset property
Date:   Fri, 14 Aug 2020 09:43:43 +0800
Message-ID: <20200814014346.6496-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

V2VuYmluIE1laSAoMyk6DQogIG1tYzogZHQtYmluZGluZ3M6IEFkZCByZXNldHMvcmVzZXQtbmFt
ZXMgZm9yIE1lZGlhdGVrIE1NQyBiaW5kaW5ncw0KICBhcm02NDogZHRzOiBtdDc2MjI6IGFkZCBy
ZXNldCBub2RlIGZvciBtbWMgZGV2aWNlDQogIG1tYzogbWVkaWF0ZWs6IGFkZCBvcHRpb25hbCBt
b2R1bGUgcmVzZXQgcHJvcGVydHkNCg0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tbWMvbXRrLXNkLnR4dCB8ICAyICsrDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDc2MjIuZHRzaSAgICAgICAgIHwgIDIgKysNCiBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jICAg
ICAgICAgICAgICAgICAgICAgICAgfCAxMyArKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspDQoNCi0tDQoyLjE4LjANCg==

