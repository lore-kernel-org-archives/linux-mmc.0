Return-Path: <SRS0=5vaz=BW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85AAC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 09:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E50208B3
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 09:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lEdPDb2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHLJib (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:38:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5035 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726942AbgHLJib (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2020 05:38:31 -0400
X-UUID: 816964cb39464f43bae2a25323e408b8-20200812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nJC5LfTN/6T01ytb031u5VjOdx8ebwn9dtG+2//ns3g=;
        b=lEdPDb2lT6tbgtVqTakidShlXPgybWACU6rz/tWRveWJ305LCU9p+zao+SrVO0uSuQC4zdVj148sESgr0ReUC/XI48oRWVOJ8SN7czXJtOxURRxdVc3pb7MfKMKJ+J9miruu7KERgFX6jNefj/utHjmbhi4mdJhpXvj7+C97oRs=;
X-UUID: 816964cb39464f43bae2a25323e408b8-20200812
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1470046484; Wed, 12 Aug 2020 17:38:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Aug 2020 17:38:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Aug 2020 17:38:24 +0800
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
Subject: [PATCH 1/3] mmc: dt-bindings: Add resets/reset-names for Mediatek MMC bindings
Date:   Wed, 12 Aug 2020 17:37:24 +0800
Message-ID: <20200812093726.10123-2-wenbin.mei@mediatek.com>
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

QWRkIGRlc2NyaXB0aW9uIGZvciByZXNldHMvcmVzZXQtbmFtZXMuDQoNClNpZ25lZC1vZmYtYnk6
IFdlbmJpbiBNZWkgPHdlbmJpbi5tZWlAbWVkaWF0ZWsuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0IHwgMiArKw0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tbWMvbXRrLXNkLnR4dA0KaW5kZXggOGE1MzJmNDQ1M2YyLi4zNWRhNzJkZTdhYWMg
MTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1z
ZC50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNk
LnR4dA0KQEAgLTQ5LDYgKzQ5LDggQEAgT3B0aW9uYWwgcHJvcGVydGllczoNCiAJCSAgICAgZXJy
b3IgY2F1c2VkIGJ5IHN0b3AgY2xvY2soZmlmbyBmdWxsKQ0KIAkJICAgICBWYWxpZCByYW5nZSA9
IFswOjB4N10uIGlmIG5vdCBwcmVzZW50LCBkZWZhdWx0IHZhbHVlIGlzIDAuDQogCQkgICAgIGFw
cGxpZWQgdG8gY29tcGF0aWJsZSAibWVkaWF0ZWssbXQyNzAxLW1tYyIuDQorLSByZXNldHM6IFBo
YW5kbGUgYW5kIHJlc2V0IHNwZWNpZmllciBwYWlyIHRvIHNvZnRyZXNldCBsaW5lIG9mIE1TREMg
SVAuDQorLSByZXNldC1uYW1lczogUmVzZXQgbmFtZXMgZm9yIE1TREMuDQogDQogRXhhbXBsZXM6
DQogbW1jMDogbW1jQDExMjMwMDAwIHsNCi0tIA0KMi4xOC4wDQo=

