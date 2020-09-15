Return-Path: <SRS0=xq36=CY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEA7C43461
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358FB20732
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Dl1+pVDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIOGNn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 02:13:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44321 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726197AbgIOGNY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 02:13:24 -0400
X-UUID: 2c88b2d0c0a343d0a363eeceeb207d1a-20200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iHk/Tb8hmYsRyxGTjsN+iuA08DZBLpkgjndj3Jtnz5o=;
        b=Dl1+pVDAF0qAv0GimU5TaPG9A8HBzxoKtNUSfS13aXxpYGsi8r1HngPiS4fPVbYr9MY61O7hZlaU2S9sAdi2ZGkL7najwMrac34LO6fKDwNOBX7w0gs23tSD0NuIbBOsXAVP13YrzsiKtbH/1v7OX63P4kPfsgL7vGsoXSOX3gY=;
X-UUID: 2c88b2d0c0a343d0a363eeceeb207d1a-20200915
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2037843499; Tue, 15 Sep 2020 14:13:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Sep 2020 14:13:19 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Sep 2020 14:13:19 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [RESEND 1/3] mmc: dt-bindings: add support for MT8192 SoC
Date:   Tue, 15 Sep 2020 14:11:08 +0800
Message-ID: <20200915061110.25833-2-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200915061110.25833-1-wenbin.mei@mediatek.com>
References: <20200915061110.25833-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

TVQ4MTkyIG1tYyBob3N0IGlwIGlzIGNvbXBhdGlibGUgd2l0aCBNVDgxODMuDQpBZGQgc3VwcG9y
dCBmb3IgdGhpcy4NCg0KU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRp
YXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210
ay1zZC50eHQgfCA2ICsrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tbWMvbXRrLXNkLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvbXRrLXNkLnR4dA0KaW5kZXggMjZhOGYzMjBhMTU2Li42NDIyYWQ3ZDQzOWQgMTAwNjQ0DQot
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC50eHQNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnR4dA0KQEAg
LTEwLDcgKzEwLDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAtIGNvbXBhdGlibGU6IHZhbHVl
IHNob3VsZCBiZSBlaXRoZXIgb2YgdGhlIGZvbGxvd2luZy4NCiAJIm1lZGlhdGVrLG10ODEzNS1t
bWMiOiBmb3IgbW1jIGhvc3QgaXAgY29tcGF0aWJsZSB3aXRoIG10ODEzNQ0KIAkibWVkaWF0ZWss
bXQ4MTczLW1tYyI6IGZvciBtbWMgaG9zdCBpcCBjb21wYXRpYmxlIHdpdGggbXQ4MTczDQotCSJt
ZWRpYXRlayxtdDgxODMtbW1jIjogZm9yIG1tYyBob3N0IGlwIGNvbXBhdGlibGUgd2l0aCBtdDgx
ODMNCisJIm1lZGlhdGVrLG10ODE5Mi1tbWMiLCAibWVkaWF0ZWssbXQ4MTgzLW1tYyI6IGZvciBt
bWMgaG9zdCBpcCBjb21wYXRpYmxlIHdpdGggbXQ4MTgzDQogCSJtZWRpYXRlayxtdDg1MTYtbW1j
IjogZm9yIG1tYyBob3N0IGlwIGNvbXBhdGlibGUgd2l0aCBtdDg1MTYNCiAJIm1lZGlhdGVrLG10
Njc3OS1tbWMiOiBmb3IgbW1jIGhvc3QgaXAgY29tcGF0aWJsZSB3aXRoIG10Njc3OQ0KIAkibWVk
aWF0ZWssbXQyNzAxLW1tYyI6IGZvciBtbWMgaG9zdCBpcCBjb21wYXRpYmxlIHdpdGggbXQyNzAx
DQpAQCAtMjcsNiArMjcsMTAgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAJImhjbGsiIC0gSENM
SyB3aGljaCB1c2VkIGZvciBob3N0IChyZXF1aXJlZCkNCiAJInNvdXJjZV9jZyIgLSBpbmRlcGVu
ZGVudCBzb3VyY2UgY2xvY2sgZ2F0ZSAocmVxdWlyZWQgZm9yIE1UMjcxMikNCiAJImJ1c19jbGsi
IC0gYnVzIGNsb2NrIHVzZWQgZm9yIGludGVybmFsIHJlZ2lzdGVyIGFjY2VzcyAocmVxdWlyZWQg
Zm9yIE1UMjcxMiBNU0RDMC8zKQ0KKwkic3lzX2NnIiAtIG1zZGMgc3Vic3lzIGNsb2NrIGdhdGUg
KHJlcXVpcmVkIGZvciBNVDgxOTIpDQorCSJwY2xrX2NnIiAtIHBlcmlwaGVyYWwgYnVzIGNsb2Nr
IGdhdGUgKHJlcXVpcmVkIGZvciBNVDgxOTIpDQorCSJheGlfY2ciIC0gQVhJIGJ1cyBjbG9jayBn
YXRlIChyZXF1aXJlZCBmb3IgTVQ4MTkyKQ0KKwkiYWhiX2NnIiAtIEFIQiBidXMgY2xvY2sgZ2F0
ZSAocmVxdWlyZWQgZm9yIE1UODE5MikNCiAtIHBpbmN0cmwtbmFtZXM6IHNob3VsZCBiZSAiZGVm
YXVsdCIsICJzdGF0ZV91aHMiDQogLSBwaW5jdHJsLTA6IHNob3VsZCBjb250YWluIGRlZmF1bHQv
aGlnaCBzcGVlZCBwaW4gY3RybA0KIC0gcGluY3RybC0xOiBzaG91bGQgY29udGFpbiB1aHMgbW9k
ZSBwaW4gY3RybA0KLS0gDQoyLjE4LjANCg==

