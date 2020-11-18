Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5357BC56202
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 03:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07DEB246AA
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 03:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="et+0wT+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgKRD1H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 22:27:07 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5729 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726494AbgKRD1G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 22:27:06 -0500
X-UUID: d4326302193e4e4c993d31cd1f36fc52-20201118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=rVcqz6XUTMam5Rpds84b/f/9khQeZe+z1fGfOnsNnj0=;
        b=et+0wT+BCKH6uuX9XiceZ1Dz9PNpIoYyEc0CFrcAFLekUMG738e8B9ViYtdO6txz0TjZuKkCEULG4fz1nTkZX32UpFsI924Jemk0knjZhZFSGIvuJkz8cEQ8uuIahflERnCEbBwTVsYpnU4GRd19pOkV6d5joLqRzp6+RtwTclM=;
X-UUID: d4326302193e4e4c993d31cd1f36fc52-20201118
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 257648254; Wed, 18 Nov 2020 11:26:58 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 18 Nov
 2020 11:26:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Nov 2020 11:26:54 +0800
Message-ID: <1605670015.11864.5.camel@mhfsdcap03>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add optional cqe off properties
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <irq-linux@rere.qmqm.pl>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        Bradley Bolen <bradleybolen@gmail.com>,
        "Chaotian Jing" <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 18 Nov 2020 11:26:55 +0800
In-Reply-To: <20201116192801.GA1991505@bogus>
References: <20201112075208.28183-1-wenbin.mei@mediatek.com>
         <20201112075208.28183-2-wenbin.mei@mediatek.com>
         <20201116192801.GA1991505@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E0983558C713B21671019A4B5CB7E2E62F2D4A278694AFAB10C6DD3BE75DF4EE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTE2IGF0IDEzOjI4IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCBOb3YgMTIsIDIwMjAgYXQgMDM6NTI6MDZQTSArMDgwMCwgV2VuYmluIE1laSB3cm90
ZToNCj4gPiBBZGQgb3B0aW9uYWwgcHJvcGVydGllcyBmb3IgY3FlIGhvc3RzIHdoaWNoIGFyZSB1
c2VkIHRvIHNldCBjcWUgb2ZmDQo+ID4gZHVyaW5nIHN1c3BlbmQgZmxvdy4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBXZW5iaW4gTWVpIDx3ZW5iaW4ubWVpQG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMtY29udHJv
bGxlci55YW1sIHwgNyArKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21tYy9tbWMtY29udHJvbGxlci55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9tbWMtY29udHJvbGxlci55YW1sDQo+ID4gaW5kZXggYjk2ZGEwYzdmODE5Li40
NTdjOWE4NGI5ODggMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9tbWMtY29udHJvbGxlci55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMtY29udHJvbGxlci55YW1sDQo+ID4gQEAgLTE2NCw2
ICsxNjQsMTMgQEAgcHJvcGVydGllczoNCj4gPiAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ICAgICAg
ICBlbmFibGUgU0RJTyBJUlEgc2lnbmFsbGluZyBvbiB0aGlzIGludGVyZmFjZQ0KPiA+ICANCj4g
PiArICBjcWUtb2ZmLWluLXN1c3BlbmQ6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55
YW1sIy9kZWZpbml0aW9ucy9mbGFnDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAg
QWZ0ZXIgc3VzcGVuZCwgdGhlIG1tYyBob3N0IGlzIHBvd2VyZWQgb2ZmIGJ5IEhXLCBhbmQgYnJp
bmcgQ1FFIHJlZ2lzdGVyDQo+ID4gKyAgICAgIHRvIGRlZmF1bHQgc3RhdGUsIHNvIHdlIGFkZCB0
aGUgZmxhZyB0byByZS1pbml0IENRRSByZWdpc3RlciBhZnRlciByZXN1bWUNCj4gPiArICAgICAg
YmFjay4NCj4gDQo+IFRoZSBkcml2ZXIgY2hhbmdlIGlzIGJlZm9yZSBzdXNwZW5kLCBidXQgdGhp
cyBzYXlzIG9uIHJlc3VtZS4uLg0KPiANCj4gSW4gYW55IGNhc2UsIHRoaXMgc2hvdWxkIGJlIGlt
cGxpZWQgYnkgdGhlIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlLg0KPiANClRoYW5rcyBmb3IgeW91
ciByZXBseSwgSSB3aWxsIGRyb3AgdGhpcyBwYXRjaHNldCwgYW5kIHJlc2VuZCBhbm90aGVyDQpw
YXRjaHNldCBmb3IgdGhpcyBpc3N1ZS4NCj4gPiArDQo+ID4gICAgZnVsbC1wd3ItY3ljbGU6DQo+
ID4gICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9mbGFnDQo+ID4g
ICAgICBkZXNjcmlwdGlvbjoNCj4gPiAtLSANCj4gPiAyLjE4LjANCj4gPiANCg0K

