Return-Path: <SRS0=cOhd=DH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3957C47425
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Sep 2020 08:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C432184D
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Sep 2020 08:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n9UTJ+yV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgI3Ib3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Sep 2020 04:31:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47426 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbgI3Ib2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2020 04:31:28 -0400
X-UUID: 56abb9944fe540d3a5e9f02f5d8c22d7-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0Ehsd84DhPcJo2TiyXzbI+msjs3dkjwBe4EhIOpRVKA=;
        b=n9UTJ+yVH2BTaapciqu8e/9BqaCEKR3+y9sgdJ3AwgWFyvizGmzPDE9rCX+9YfTS9y8O15eaQw2wJQzudVWi68USq26RQFWmNSgCAZULNbQeA9RVDrKQaEBndHgJ+ar3YdKMrTGSrDBwGru+wbL38R9sKMs13EUtEqFlK5ECskY=;
X-UUID: 56abb9944fe540d3a5e9f02f5d8c22d7-20200930
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1786876965; Wed, 30 Sep 2020 16:31:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 16:31:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 16:31:22 +0800
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
Subject: [PATCH v3 2/4] mmc: dt-bindings: add support for MT8192 SoC
Date:   Wed, 30 Sep 2020 16:31:18 +0800
Message-ID: <20200930083120.11971-3-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930083120.11971-1-wenbin.mei@mediatek.com>
References: <20200930083120.11971-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

TVQ4MTkyIG1tYyBob3N0IGlwIGlzIGNvbXBhdGlibGUgd2l0aCBNVDgxODMuDQpBZGQgc3VwcG9y
dCBmb3IgdGhpcy4NCg0KU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRp
YXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210
ay1zZC55YW1sIHwgMTUgKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbA0KaW5kZXggN2Y4OWNiZGM1MmE1Li44MWQyOTUx
YmZjMzcgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1j
L210ay1zZC55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1j
L210ay1zZC55YW1sDQpAQCAtMjksMjYgKzI5LDM3IEBAIHByb3BlcnRpZXM6DQogICAgICAgLSBp
dGVtczoNCiAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10NzYyMy1tbWMNCiAgICAgICAgIC0g
Y29uc3Q6IG1lZGlhdGVrLG10MjcwMS1tbWMNCisgICAgICAtIGl0ZW1zOg0KKyAgICAgICAgLSBj
b25zdDogbWVkaWF0ZWssbXQ4MTkyLW1tYw0KKyAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4
MTgzLW1tYw0KIA0KICAgY2xvY2tzOg0KICAgICBkZXNjcmlwdGlvbjoNCiAgICAgICBTaG91bGQg
Y29udGFpbiBwaGFuZGxlIGZvciB0aGUgY2xvY2sgZmVlZGluZyB0aGUgTU1DIGNvbnRyb2xsZXIu
DQogICAgIG1pbkl0ZW1zOiAyDQotICAgIG1heEl0ZW1zOiA0DQorICAgIG1heEl0ZW1zOiA4DQog
ICAgIGl0ZW1zOg0KICAgICAgIC0gZGVzY3JpcHRpb246IHNvdXJjZSBjbG9jayAocmVxdWlyZWQp
Lg0KICAgICAgIC0gZGVzY3JpcHRpb246IEhDTEsgd2hpY2ggdXNlZCBmb3IgaG9zdCAocmVxdWly
ZWQpLg0KICAgICAgIC0gZGVzY3JpcHRpb246IGluZGVwZW5kZW50IHNvdXJjZSBjbG9jayBnYXRl
IChyZXF1aXJlZCBmb3IgTVQyNzEyKS4NCiAgICAgICAtIGRlc2NyaXB0aW9uOiBidXMgY2xvY2sg
dXNlZCBmb3IgaW50ZXJuYWwgcmVnaXN0ZXIgYWNjZXNzIChyZXF1aXJlZCBmb3IgTVQyNzEyIE1T
REMwLzMpLg0KKyAgICAgIC0gZGVzY3JpcHRpb246IG1zZGMgc3Vic3lzIGNsb2NrIGdhdGUgKHJl
cXVpcmVkIGZvciBNVDgxOTIpLg0KKyAgICAgIC0gZGVzY3JpcHRpb246IHBlcmlwaGVyYWwgYnVz
IGNsb2NrIGdhdGUgKHJlcXVpcmVkIGZvciBNVDgxOTIpLg0KKyAgICAgIC0gZGVzY3JpcHRpb246
IEFYSSBidXMgY2xvY2sgZ2F0ZSAocmVxdWlyZWQgZm9yIE1UODE5MikuDQorICAgICAgLSBkZXNj
cmlwdGlvbjogQUhCIGJ1cyBjbG9jayBnYXRlIChyZXF1aXJlZCBmb3IgTVQ4MTkyKS4NCiANCiAg
IGNsb2NrLW5hbWVzOg0KICAgICBtaW5JdGVtczogMg0KLSAgICBtYXhJdGVtczogNA0KKyAgICBt
YXhJdGVtczogOA0KICAgICBpdGVtczoNCiAgICAgICAtIGNvbnN0OiBzb3VyY2UNCiAgICAgICAt
IGNvbnN0OiBoY2xrDQogICAgICAgLSBjb25zdDogc291cmNlX2NnDQogICAgICAgLSBjb25zdDog
YnVzX2Nsaw0KKyAgICAgIC0gY29uc3Q6IHN5c19jZw0KKyAgICAgIC0gY29uc3Q6IHBjbGtfY2cN
CisgICAgICAtIGNvbnN0OiBheGlfY2cNCisgICAgICAtIGNvbnN0OiBhaGJfY2cNCiANCiAgIHBp
bmN0cmwtbmFtZXM6DQogICAgIGl0ZW1zOg0KLS0gDQoyLjE4LjANCg==

