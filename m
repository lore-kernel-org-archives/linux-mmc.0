Return-Path: <SRS0=5vaz=BW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841C2C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 09:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EEF208B3
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 09:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MBy7+yIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgHLJif (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:38:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26618 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727808AbgHLJie (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2020 05:38:34 -0400
X-UUID: cc2330fe2d444d0c914485b9a5d50b91-20200812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n8qTjuU/K0cDmRH8kbn9OnRMWaTi0JfPivM4HICkFOk=;
        b=MBy7+yIrK00Juy+njlK/GuqyFo2Wz4/pImlPVYvMJWBqW7dMfSrJl77l0G7NZkw9z7nZ53LguO9CYEgiGylQK1p7gIkKu0YJFCYJbg55t/7ufx8eSh+C6ahv2sXpeHOixTRv/xWeuNN7Yc1JDh3vjdPvnUGprrSHQsV0BkxR35g=;
X-UUID: cc2330fe2d444d0c914485b9a5d50b91-20200812
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2102756466; Wed, 12 Aug 2020 17:38:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Aug 2020 17:38:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Aug 2020 17:38:26 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [PATCH 3/3] mmc: mediatek: add optional module reset property
Date:   Wed, 12 Aug 2020 17:37:26 +0800
Message-ID: <20200812093726.10123-4-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200812093726.10123-1-wenbin.mei@mediatek.com>
References: <20200812093726.10123-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIGEgb3B0aW9uYWwgcmVzZXQgbWFuYWdlbWVudCBmb3IgbXNkYy4NClNv
bWV0aW1lcyB0aGUgYm9vdGxvYWRlciBkb2VzIG5vdCBicmluZyBtc2RjIHJlZ2lzdGVyDQp0byBk
ZWZhdWx0IHN0YXRlLCBzbyBuZWVkIHJlc2V0IHRoZSBtc2RjIGNvbnRyb2xsZXIuDQoNClNpZ25l
ZC1vZmYtYnk6IFdlbmJpbiBNZWkgPHdlbmJpbi5tZWlAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9tbWMvaG9zdC9tdGstc2QuYyB8IDEzICsrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdl
ZCwgMTMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tdGst
c2QuYyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCmluZGV4IDM5ZTdmYzU0YzQzOC4uMmIy
NDNjMDNjOWIyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KKysrIGIv
ZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KQEAgLTIyLDYgKzIyLDcgQEANCiAjaW5jbHVkZSA8
bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KICNpbmNsdWRlIDxs
aW51eC9pbnRlcnJ1cHQuaD4NCisjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCiANCiAjaW5jbHVk
ZSA8bGludXgvbW1jL2NhcmQuaD4NCiAjaW5jbHVkZSA8bGludXgvbW1jL2NvcmUuaD4NCkBAIC00
MzQsNiArNDM1LDcgQEAgc3RydWN0IG1zZGNfaG9zdCB7DQogCXN0cnVjdCBtc2RjX3NhdmVfcGFy
YSBzYXZlX3BhcmE7IC8qIHVzZWQgd2hlbiBnYXRlIEhDTEsgKi8NCiAJc3RydWN0IG1zZGNfdHVu
ZV9wYXJhIGRlZl90dW5lX3BhcmE7IC8qIGRlZmF1bHQgdHVuZSBzZXR0aW5nICovDQogCXN0cnVj
dCBtc2RjX3R1bmVfcGFyYSBzYXZlZF90dW5lX3BhcmE7IC8qIHR1bmUgcmVzdWx0IG9mIENNRDIx
L0NNRDE5ICovDQorCXN0cnVjdCByZXNldF9jb250cm9sICpyZXNldDsNCiB9Ow0KIA0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbXRrX21tY19jb21wYXRpYmxlIG10ODEzNV9jb21wYXQgPSB7DQpAQCAt
MTUxNiw2ICsxNTE4LDEyIEBAIHN0YXRpYyB2b2lkIG1zZGNfaW5pdF9odyhzdHJ1Y3QgbXNkY19o
b3N0ICpob3N0KQ0KIAl1MzIgdmFsOw0KIAl1MzIgdHVuZV9yZWcgPSBob3N0LT5kZXZfY29tcC0+
cGFkX3R1bmVfcmVnOw0KIA0KKwlpZiAoIUlTX0VSUihob3N0LT5yZXNldCkpIHsNCisJCXJlc2V0
X2NvbnRyb2xfYXNzZXJ0KGhvc3QtPnJlc2V0KTsNCisJCXVzbGVlcF9yYW5nZSgxMCwgNTApOw0K
KwkJcmVzZXRfY29udHJvbF9kZWFzc2VydChob3N0LT5yZXNldCk7DQorCX0NCisNCiAJLyogQ29u
ZmlndXJlIHRvIE1NQy9TRCBtb2RlLCBjbG9jayBmcmVlIHJ1bm5pbmcgKi8NCiAJc2RyX3NldF9i
aXRzKGhvc3QtPmJhc2UgKyBNU0RDX0NGRywgTVNEQ19DRkdfTU9ERSB8IE1TRENfQ0ZHX0NLUERO
KTsNCiANCkBAIC0yMjczLDYgKzIyODEsMTEgQEAgc3RhdGljIGludCBtc2RjX2Rydl9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAoSVNfRVJSKGhvc3QtPnNyY19jbGtf
Y2cpKQ0KIAkJaG9zdC0+c3JjX2Nsa19jZyA9IE5VTEw7DQogDQorCWhvc3QtPnJlc2V0ID0gZGV2
bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUoJnBkZXYtPmRldiwNCisJCQkJ
CQkJCSJocnN0Iik7DQorCWlmIChQVFJfRVJSKGhvc3QtPnJlc2V0KSA9PSAtRVBST0JFX0RFRkVS
KQ0KKwkJcmV0dXJuIFBUUl9FUlIoaG9zdC0+cmVzZXQpOw0KKw0KIAlob3N0LT5pcnEgPSBwbGF0
Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KIAlpZiAoaG9zdC0+aXJxIDwgMCkgew0KIAkJcmV0ID0g
LUVJTlZBTDsNCi0tIA0KMi4xOC4wDQo=

