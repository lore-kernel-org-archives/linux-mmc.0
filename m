Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE6EC433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 08:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625A7613B1
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 08:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350030AbhDNIQz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 04:16:55 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24912 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350029AbhDNIQu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 04:16:50 -0400
X-UUID: d79b0cec56a64d80b7ab9bcdcac021af-20210414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7jpjr1gQD0+v/riKyIsAYDYr4J35y59pp8ISXpasrc0=;
        b=Xmi/YMT+PsMmq0eRjoMCWAfqZIYNPoq6OBfHlIQt2HUNkFGoM32VgjeUbmcmh8RtMxOc0ru2vv71UbzbBiwHxotqAXrU+mnZ49Gl4y9ZYVCy7nY2P51fe70SunpdTKURjI9jYPEIRHdrGdCXj6b6I9RmHx7py2J60Z/znMVvPxY=;
X-UUID: d79b0cec56a64d80b7ab9bcdcac021af-20210414
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 567662278; Wed, 14 Apr 2021 16:16:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Apr 2021 16:16:19 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 16:16:18 +0800
From:   Peng Zhou <peng.zhou@mediatek.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wulin Li <wulin.li@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        <devicetree@vger.kernel.org>, Peng Zhou <Peng.Zhou@mediatek.com>
Subject: [PATCH RESEND v3 2/3] arm64: dts: Mediatek: MT6779: add mmc node with ICE setting
Date:   Wed, 14 Apr 2021 16:04:29 +0800
Message-ID: <20210414080427.21272-3-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210414080427.21272-1-peng.zhou@mediatek.com>
References: <20210414080427.21272-1-peng.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-TM-SNTS-SMTP: 2B5E27920E4219DE0A1538CEC2CBCAB45305A94956FA8017228314AC0799A50D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogUGVuZyBaaG91IDxQZW5nLlpob3VAbWVkaWF0ZWsuY29tPg0KDQpBZGQgbW1jIG5vZGUg
d2l0aCBJbmxpbmUgQ3J5cHRvIEVuZ2luZSAoSUNFKSBmb3IgTWVkaWF0ZWsNCmVNTUMgY29udHJv
bGxlciBvbiBNVDY3NzkuDQoNClNpZ25lZC1vZmYtYnk6IFBlbmcgWmhvdSA8UGVuZy5aaG91QG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0
c2kgfCAxNCArKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCsp
DQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNp
IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDY3NzkuZHRzaQ0KaW5kZXggOWJkZjUx
NDU5NjZjLi45MjQ2ZTU5ZmE0YTYgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210Njc3OS5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
Njc3OS5kdHNpDQpAQCAtMjQyLDYgKzI0MiwyMCBAQA0KIAkJCSNjbG9jay1jZWxscyA9IDwxPjsN
CiAJCX07DQogDQorCQltbWMwOiBtbWNAMTEyMzAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ2Nzc5LW1tYyI7DQorCQkJcmVnID0gPDAgMHgxMTIzMDAwMCAwIDB4MTAwMDA+LA0K
KwkJCQk8MCAweDExZjUwMDAwIDAgMHgxMDAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDEwMSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCWNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RP
UF9NU0RDNTBfMD4sDQorCQkJCTwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX01TREMwPiwNCisJCQkJ
PCZpbmZyYWNmZ19hbyBDTEtfSU5GUkFfTVNEQzBfU0NLPiwNCisJCQkJPCZpbmZyYWNmZ19hbyBD
TEtfSU5GUkFfQUVTX1VGU0ZERT47DQorCQkJY2xvY2stbmFtZXMgPSAic291cmNlIiwgImhjbGsi
LCAic291cmNlX2NnIiwNCisJCQkJImNyeXB0byI7DQorCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
CisJCX07DQorDQogCQltZmdjZmc6IGNsb2NrLWNvbnRyb2xsZXJAMTNmYmYwMDAgew0KIAkJCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LW1mZ2NmZyIsICJzeXNjb24iOw0KIAkJCXJlZyA9
IDwwIDB4MTNmYmYwMDAgMCAweDEwMDA+Ow0KLS0gDQoyLjE4LjANCg==

