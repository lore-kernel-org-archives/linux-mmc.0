Return-Path: <SRS0=eot0=4F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A3BC7619B
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 04:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B6C22522
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 04:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OnfzpuEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBQENV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:13:21 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60480 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727974AbgBQENU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Feb 2020 23:13:20 -0500
X-UUID: cc2d3fdce6cf4d099ea4e287d2d84ec4-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gA92exK5mTm8/CG4HiiRVWxwEcrPVIB/LJ+HLulMGSQ=;
        b=OnfzpuEVRC5/wb/av/q18nPJsB/WyghKnazSSZxHeQ85bmanzFqbj0r8zSZJX8PIjklJL7R5fmscv2fjDOXGHB0R12IH5Y761+phhRiAvnMcf0G7sYJd0ddaUtCEuud5QPhm7VFSbu+DAzgixEDR+iVVKnnoRh4zVtik0dRUMXA=;
X-UUID: cc2d3fdce6cf4d099ea4e287d2d84ec4-20200217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1491087829; Mon, 17 Feb 2020 12:13:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 12:12:20 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 12:13:01 +0800
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
CC:     <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: [PATCH v2 2/4] [2/4] mmc: mediatek: refine msdc timeout api
Date:   Mon, 17 Feb 2020 12:13:08 +0800
Message-ID: <1581912790-19382-3-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581912790-19382-1-git-send-email-chun-hung.wu@mediatek.com>
References: <1581912790-19382-1-git-send-email-chun-hung.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RXh0cmFjdCBtc2RjIHRpbWVvdXQgYXBpIGNvbW1vbiBwYXJ0IHRvIGhhdmUNCmJldHRlciBjb2Rl
IGFyY2hpdGVjdHVyZSBhbmQgYXZvaWQgcmVkdW5kZW50DQpjb2RlLg0KDQpDaGFuZ2UtSWQ6IElm
NDE5OTVlNGQ4MDZjZGJiYjhjYmNiYzk3MDgwZDk2ZWNlYWJmNDhiDQpDUi1JZDoNCkZlYXR1cmU6
DQpTaWduZWQtb2ZmLWJ5OiBDaHVuLUh1bmcgV3UgPGNodW4taHVuZy53dUBtZWRpYXRlay5jb20+
DQotLS0NCiBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgMzIgKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJp
dmVycy9tbWMvaG9zdC9tdGstc2QuYw0KaW5kZXggMTg5ZTQyNi4uMTI3YjBjZiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCisrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRr
LXNkLmMNCkBAIC02OTgsMjEgKzY5OCwyMSBAQCBzdGF0aWMgdm9pZCBtc2RjX3VucHJlcGFyZV9k
YXRhKHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QsIHN0cnVjdCBtbWNfcmVxdWVzdCAqbXJxKQ0KIAl9
DQogfQ0KIA0KLS8qIGNsb2NrIGNvbnRyb2wgcHJpbWl0aXZlcyAqLw0KLXN0YXRpYyB2b2lkIG1z
ZGNfc2V0X3RpbWVvdXQoc3RydWN0IG1zZGNfaG9zdCAqaG9zdCwgdTMyIG5zLCB1MzIgY2xrcykN
CitzdGF0aWMgdTY0IG1zZGNfdGltZW91dF9jYWwoc3RydWN0IG1zZGNfaG9zdCAqaG9zdCwgdTY0
IG5zLCB1NjQgY2xrcykNCiB7DQotCXUzMiB0aW1lb3V0LCBjbGtfbnM7DQorCXU2NCB0aW1lb3V0
LCBjbGtfbnM7DQogCXUzMiBtb2RlID0gMDsNCiANCi0JaG9zdC0+dGltZW91dF9ucyA9IG5zOw0K
LQlob3N0LT50aW1lb3V0X2Nsa3MgPSBjbGtzOw0KIAlpZiAoaG9zdC0+bW1jLT5hY3R1YWxfY2xv
Y2sgPT0gMCkgew0KIAkJdGltZW91dCA9IDA7DQogCX0gZWxzZSB7DQotCQljbGtfbnMgID0gMTAw
MDAwMDAwMFVMIC8gaG9zdC0+bW1jLT5hY3R1YWxfY2xvY2s7DQotCQl0aW1lb3V0ID0gKG5zICsg
Y2xrX25zIC0gMSkgLyBjbGtfbnMgKyBjbGtzOw0KKwkJY2xrX25zICA9IDEwMDAwMDAwMDBVTEw7
DQorCQlkb19kaXYoY2xrX25zLCBob3N0LT5tbWMtPmFjdHVhbF9jbG9jayk7DQorCQl0aW1lb3V0
ID0gbnMgKyBjbGtfbnMgLSAxOw0KKwkJZG9fZGl2KHRpbWVvdXQsIGNsa19ucyk7DQorCQl0aW1l
b3V0ICs9IGNsa3M7DQogCQkvKiBpbiAxMDQ4NTc2IHNjbGsgY3ljbGUgdW5pdCAqLw0KLQkJdGlt
ZW91dCA9ICh0aW1lb3V0ICsgKDB4MSA8PCAyMCkgLSAxKSA+PiAyMDsNCisJCXRpbWVvdXQgPSBE
SVZfUk9VTkRfVVAodGltZW91dCwgKDB4MSA8PCAyMCkpOw0KIAkJaWYgKGhvc3QtPmRldl9jb21w
LT5jbGtfZGl2X2JpdHMgPT0gOCkNCiAJCQlzZHJfZ2V0X2ZpZWxkKGhvc3QtPmJhc2UgKyBNU0RD
X0NGRywNCiAJCQkJICAgICAgTVNEQ19DRkdfQ0tNT0QsICZtb2RlKTsNCkBAIC03MjIsOSArNzIy
LDIxIEBAIHN0YXRpYyB2b2lkIG1zZGNfc2V0X3RpbWVvdXQoc3RydWN0IG1zZGNfaG9zdCAqaG9z
dCwgdTMyIG5zLCB1MzIgY2xrcykNCiAJCS8qRERSIG1vZGUgd2lsbCBkb3VibGUgdGhlIGNsayBj
eWNsZXMgZm9yIGRhdGEgdGltZW91dCAqLw0KIAkJdGltZW91dCA9IG1vZGUgPj0gMiA/IHRpbWVv
dXQgKiAyIDogdGltZW91dDsNCiAJCXRpbWVvdXQgPSB0aW1lb3V0ID4gMSA/IHRpbWVvdXQgLSAx
IDogMDsNCi0JCXRpbWVvdXQgPSB0aW1lb3V0ID4gMjU1ID8gMjU1IDogdGltZW91dDsNCiAJfQ0K
LQlzZHJfc2V0X2ZpZWxkKGhvc3QtPmJhc2UgKyBTRENfQ0ZHLCBTRENfQ0ZHX0RUT0MsIHRpbWVv
dXQpOw0KKwlyZXR1cm4gdGltZW91dDsNCit9DQorDQorLyogY2xvY2sgY29udHJvbCBwcmltaXRp
dmVzICovDQorc3RhdGljIHZvaWQgbXNkY19zZXRfdGltZW91dChzdHJ1Y3QgbXNkY19ob3N0ICpo
b3N0LCB1NjQgbnMsIHU2NCBjbGtzKQ0KK3sNCisJdTY0IHRpbWVvdXQ7DQorDQorCWhvc3QtPnRp
bWVvdXRfbnMgPSBuczsNCisJaG9zdC0+dGltZW91dF9jbGtzID0gY2xrczsNCisNCisJdGltZW91
dCA9IG1zZGNfdGltZW91dF9jYWwoaG9zdCwgbnMsIGNsa3MpOw0KKwlzZHJfc2V0X2ZpZWxkKGhv
c3QtPmJhc2UgKyBTRENfQ0ZHLCBTRENfQ0ZHX0RUT0MsDQorCQkgICAgICAodTMyKSh0aW1lb3V0
ID4gMjU1ID8gMjU1IDogdGltZW91dCkpOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBtc2RjX2dhdGVf
Y2xvY2soc3RydWN0IG1zZGNfaG9zdCAqaG9zdCkNCi0tIA0KMS45LjENCg==

