Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4E3C433DB
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 02:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C0E6527B
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 02:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCICMn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Mar 2021 21:12:43 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:60897 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229599AbhCICMY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 21:12:24 -0500
X-UUID: 7aac7ef973de4916bf69e8e418be57eb-20210309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dCFmsNYPIzleSDsBfXxH13W6eZxdLWZWw/Lo40Vf2Ak=;
        b=YtM5W6p6j/nfi4DLPk+542No0Km7OOxugfW2y7UNyHJaAByNfBIVugZnE5ZgzbDdRQY4L/EiNHE7xsKM3SMt0gvYYsQw4urNeVthHoZjKZB9fsD4dOAJ5RXLUtc5gpUc4PY1thfk6MGSRqmwKcF7KkOrFtFnxql05hrtHJUFDUs=;
X-UUID: 7aac7ef973de4916bf69e8e418be57eb-20210309
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 11943099; Tue, 09 Mar 2021 10:12:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS32N1.mediatek.inc (172.27.4.71) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 10:12:16 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Mar 2021 10:12:16 +0800
From:   Peng Zhou <peng.zhou@mediatek.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>
Subject: [PATCH v2 3/4] arm64: dts: Mediatek: MT6779: add mmc node with ICE setting
Date:   Tue, 9 Mar 2021 10:05:51 +0800
Message-ID: <20210309020550.18353-1-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FAEBBAA6E0F71EECC9E685D6FB9A24C36222FC4F6905159FE2B6896E03F077602000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

QWRkIG1tYyBub2RlIHdpdGggSW5saW5lIENyeXB0byBFbmdpbmUgKElDRSkgZm9yIE1lZGlhdGVr
DQplTU1DIGNvbnRyb2xsZXIgb24gTVQ2Nzc5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBQZW5nIFpob3Ug
PHBlbmcuemhvdUBtZWRpYXRlay5jb20+DQotLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210Njc3OS5kdHNpIHwgMTQgKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDY3NzkuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0c2kN
CmluZGV4IDliZGY1MTQ1OTY2Yy4uOTI0NmU1OWZhNGE2IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDY3NzkuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDY3NzkuZHRzaQ0KQEAgLTI0Miw2ICsyNDIsMjAgQEANCiAJCQkjY2xvY2st
Y2VsbHMgPSA8MT47DQogCQl9Ow0KIA0KKwkJbW1jMDogbW1jQDExMjMwMDAwIHsNCisJCQljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1tbWMiOw0KKwkJCXJlZyA9IDwwIDB4MTEyMzAwMDAg
MCAweDEwMDAwPiwNCisJCQkJPDAgMHgxMWY1MDAwMCAwIDB4MTAwMDA+Ow0KKwkJCWludGVycnVw
dHMgPSA8R0lDX1NQSSAxMDEgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJCQljbG9ja3MgPSA8JnRv
cGNrZ2VuIENMS19UT1BfTVNEQzUwXzA+LA0KKwkJCQk8JmluZnJhY2ZnX2FvIENMS19JTkZSQV9N
U0RDMD4sDQorCQkJCTwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX01TREMwX1NDSz4sDQorCQkJCTwm
aW5mcmFjZmdfYW8gQ0xLX0lORlJBX0FFU19VRlNGREU+Ow0KKwkJCWNsb2NrLW5hbWVzID0gInNv
dXJjZSIsICJoY2xrIiwgInNvdXJjZV9jZyIsDQorCQkJCSJjcnlwdG8iOw0KKwkJCXN0YXR1cyA9
ICJkaXNhYmxlZCI7DQorCQl9Ow0KKw0KIAkJbWZnY2ZnOiBjbG9jay1jb250cm9sbGVyQDEzZmJm
MDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1tZmdjZmciLCAic3lzY29u
IjsNCiAJCQlyZWcgPSA8MCAweDEzZmJmMDAwIDAgMHgxMDAwPjsNCi0tIA0KMi4xOC4wDQo=

