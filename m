Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80DDC433DB
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 02:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B6D6527B
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 02:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCICNP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Mar 2021 21:13:15 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:2073 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229589AbhCICNP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 21:13:15 -0500
X-UUID: d55bf50da1714c48b98a191f0886a46e-20210309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HzSZXHmvNwYWi91TrlbB7npR6sCw+tpyWz5uepOikxY=;
        b=FMVq/xKtTjAst6TW9SzdBg1+JYETzqHfj4dkkTWnLTpi3nyCVf16WTr2u190jJY2PoXiLPpS8u5g7lJPks1UWyqnc3wKIoKeaBlZXX+dxsPfMKa/m48Fo/3s2wb4UCCD+GDmzngOkqCtQItlUc+1dJAReTh9TRKmhsRdkWKp15M=;
X-UUID: d55bf50da1714c48b98a191f0886a46e-20210309
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2056281069; Tue, 09 Mar 2021 10:13:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS32N1.mediatek.inc (172.27.4.71) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 10:13:09 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Mar 2021 10:13:02 +0800
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
Subject: [PATCH v2 4/4] dt-bingdings: mmc: Mediatek: add ICE clock
Date:   Tue, 9 Mar 2021 10:06:50 +0800
Message-ID: <20210309020649.582-1-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C7B9C1C986416529397245BF9289F010393F971BF14FF786B312334AFAD522B82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RG9jdW1lbnQgdGhlIGJpbmRpbmcgZm9yIGNyeXB0byBjbG9jayBvZiB0aGUgSW5saW5lIENyeXB0
byBFbmdpbmUgKElDRSkNCm9uIE1lZGlhdGVrIFNvQ3MuDQoNClNpZ25lZC1vZmYtYnk6IFBlbmcg
WmhvdSA8cGVuZy56aG91QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwgfCA2ICsrKystLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbA0KaW5kZXggMDE2MzBiMGVjZWE3
Li5hODFjMTRjODg5MDYgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbW1jL210ay1zZC55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbW1jL210ay1zZC55YW1sDQpAQCAtMzcsNyArMzcsNyBAQCBwcm9wZXJ0aWVzOg0KICAg
ICBkZXNjcmlwdGlvbjoNCiAgICAgICBTaG91bGQgY29udGFpbiBwaGFuZGxlIGZvciB0aGUgY2xv
Y2sgZmVlZGluZyB0aGUgTU1DIGNvbnRyb2xsZXIuDQogICAgIG1pbkl0ZW1zOiAyDQotICAgIG1h
eEl0ZW1zOiA4DQorICAgIG1heEl0ZW1zOiA5DQogICAgIGl0ZW1zOg0KICAgICAgIC0gZGVzY3Jp
cHRpb246IHNvdXJjZSBjbG9jayAocmVxdWlyZWQpLg0KICAgICAgIC0gZGVzY3JpcHRpb246IEhD
TEsgd2hpY2ggdXNlZCBmb3IgaG9zdCAocmVxdWlyZWQpLg0KQEAgLTQ3LDEwICs0NywxMSBAQCBw
cm9wZXJ0aWVzOg0KICAgICAgIC0gZGVzY3JpcHRpb246IHBlcmlwaGVyYWwgYnVzIGNsb2NrIGdh
dGUgKHJlcXVpcmVkIGZvciBNVDgxOTIpLg0KICAgICAgIC0gZGVzY3JpcHRpb246IEFYSSBidXMg
Y2xvY2sgZ2F0ZSAocmVxdWlyZWQgZm9yIE1UODE5MikuDQogICAgICAgLSBkZXNjcmlwdGlvbjog
QUhCIGJ1cyBjbG9jayBnYXRlIChyZXF1aXJlZCBmb3IgTVQ4MTkyKS4NCisgICAgICAtIGRlc2Ny
aXB0aW9uOiBjcnlwdG8gY2xvY2sgdXNlZCBmb3IgZGF0YSBlbmNyeXB0L2RlY3J5cHQgKG9wdGlv
bmFsKS4NCiANCiAgIGNsb2NrLW5hbWVzOg0KICAgICBtaW5JdGVtczogMg0KLSAgICBtYXhJdGVt
czogOA0KKyAgICBtYXhJdGVtczogOQ0KICAgICBpdGVtczoNCiAgICAgICAtIGNvbnN0OiBzb3Vy
Y2UNCiAgICAgICAtIGNvbnN0OiBoY2xrDQpAQCAtNjAsNiArNjEsNyBAQCBwcm9wZXJ0aWVzOg0K
ICAgICAgIC0gY29uc3Q6IHBjbGtfY2cNCiAgICAgICAtIGNvbnN0OiBheGlfY2cNCiAgICAgICAt
IGNvbnN0OiBhaGJfY2cNCisgICAgICAtIGNvbnN0OiBjcnlwdG8NCiANCiAgIHBpbmN0cmwtbmFt
ZXM6DQogICAgIGl0ZW1zOg0KLS0gDQoyLjE4LjANCg==

