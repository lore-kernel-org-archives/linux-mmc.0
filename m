Return-Path: <SRS0=po4a=5W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C3AC2BA19
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 13:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE882087E
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 13:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pzqL4h5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgDFNzK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:55:10 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:2304
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726910AbgDFNzK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Apr 2020 09:55:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxprmXZQkicXSloiysV/h2LM+Mgl8qoLNKmPUk52b5c1kP5g5NUKoHrv0Iqyke/kBzUTYo1eEoKnUUrYKnY9N903CyHQPoUr8TAjDzmXUC4R6xGl3m05ixgtHyQtY+1nOUFo7xrA3pv5ZMShdVaAn1V4Udkx2pg/uw5YxAAVmbQ/q/oCBPldhm64R28HShM+ivgspLhEbBCXpJ+IpVKKZGDpYviTyG0UkYvgVUiGM45cpYG42PDycNtTILzd9V+f9EaA2IAvG5aepQL12O8hJ8oU26twCRZjEmTO8LMKmBkCBK8GRIHyw0gkLRcNBuX/8LrZ1U3pMaYfZ+j8H+c3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfYk+T7ztj8tkf80ESi8rb+tlFSMcroZEmsnNXAdqDY=;
 b=TtRlErtXPEWMzp4eZlWYhdm8uqajf3TLMbyS70swf13zYQmQ+8zwui+P/yLolOZ7u8y8QUn9mMF+jldrnER1ZcOZRVqAXE8zWacH+VhY4H8rGwDP14HeEt4DVx17kZMg9o4Cl8OVwLQt9DF6Trk28y4rZv1B5E7VkDUlw8XrqdUJ7/HKXVvB0JC0igEt1e86+revHuQSqN2WkVJIBzqb5Mm+vtne+fi5AHSEliFm3XoiVXIewgssqeaPt/ytoAjtUx936Gg6sNygecu7lD0hSpkSFyW0Qc/csoW7bfH5K66WZ+NIL/HD2cly46xBCah+wGk4XQA5BHqw0bA8awNmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfYk+T7ztj8tkf80ESi8rb+tlFSMcroZEmsnNXAdqDY=;
 b=pzqL4h5gqYOVYGofLyY0HlsvdxyZejP4UzEUMzMa11wzrteHn+PBUhahQzB/1FrWiEf49VqR05LthgNc+2QnZCeE4EnAM/lzLhZ3bHPeDqPBMMcwyxf9NuepM9MdTcROzJjj0LKEZxHqG5O3ZHd5eKfNvb8PASASMYWNzx7NlWM=
Received: from DM6PR02MB4426.namprd02.prod.outlook.com (2603:10b6:5:22::28) by
 DM6PR02MB5962.namprd02.prod.outlook.com (2603:10b6:5:179::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.21; Mon, 6 Apr 2020 13:55:05 +0000
Received: from DM6PR02MB4426.namprd02.prod.outlook.com
 ([fe80::2458:ae1:e813:f217]) by DM6PR02MB4426.namprd02.prod.outlook.com
 ([fe80::2458:ae1:e813:f217%6]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 13:55:05 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v2 3/4] mmc: sdhci-of-arasan: Modify clock operations
 handling
Thread-Topic: [PATCH v2 3/4] mmc: sdhci-of-arasan: Modify clock operations
 handling
Thread-Index: AQHWBlYDfVQqA2G69U+StIaVOIIdzahloRMAgAaHjIA=
Date:   Mon, 6 Apr 2020 13:55:04 +0000
Message-ID: <DM6PR02MB442695A77DAFC7358B9DC6CEC1C20@DM6PR02MB4426.namprd02.prod.outlook.com>
References: <1585546879-91037-1-git-send-email-manish.narani@xilinx.com>
 <1585546879-91037-4-git-send-email-manish.narani@xilinx.com>
 <34dffb3a-aa90-db27-7465-df840d148658@intel.com>
In-Reply-To: <34dffb3a-aa90-db27-7465-df840d148658@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [183.83.137.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b01af45a-b306-4330-e54e-08d7da321c15
x-ms-traffictypediagnostic: DM6PR02MB5962:|DM6PR02MB5962:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB59628A5163060DE30A90A012C1C20@DM6PR02MB5962.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4426.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(478600001)(9686003)(71200400001)(8936002)(66476007)(81156014)(66446008)(64756008)(66556008)(107886003)(8676002)(6506007)(53546011)(81166006)(66946007)(76116006)(5660300002)(33656002)(52536014)(7696005)(26005)(110136005)(54906003)(2906002)(316002)(6636002)(86362001)(186003)(7416002)(55016002)(4326008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73r0F97fLyHjM6HZHcAsnYxapnHPecYiPhR69iJtRA2GdaR9PbY8Oc31IS9Bpe6LGEuyuWPmeIR2QbcuYfEUPQZVua9ExiXgcaneIDxDy9cX2oixBCJzMTh5YVIPD1Pgu6Kyg4cZIvslU64Zv9Lm9rd+v6sObjXdS/C+7Z+bwgbqh5gkbvaEeJSwVqwEYhz38PSXSONr4RDYfezWIf+7/pzMG/ExbYzbmHQIHbWbszdjwa/IY6oSDopI1KYg1W+8/noPnvyhS5sIJFenfavtzJds8PJ3bLBcR5pwXXu+uLWt8BpmbKg7DiWmVedq5BQQgOnsJK1PCAUU9RluJ/HBMRxdTYwm/UvJRVSkjDJ/o4EGKmxcZjfp5QL32gJtGJdYwzQT/nXwV3z7hhVj6x4svsqOdEjKUOkQLGA4eihSRpQXnBKdqLqdvbnUmFqV610U
x-ms-exchange-antispam-messagedata: OF+7fBTir3LlxrBM2RhW8NaeotYI1z2Lin2NtnCz3w6tEmFCdKyRdzWTc+RUNAB7xLyedtrKUUj6P6jBTKzWjJ3e+SKPSEKQOVbErgQmXvMDOHrsaNvj71KrFnlYL5/j6Sf83ZNgCiXcTyymmgjnmA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01af45a-b306-4330-e54e-08d7da321c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 13:55:04.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+RpeKb+AHP73WCQJH5Dylct4WizBcywFrmIk9Vp3REpGLm6+fy6y003v7g7Mub+KhG3WKr0mAn6/PBnWbMxLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5962
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgQWRyaWFuLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5j
b20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyLCAyMDIwIDM6NDAgUE0NCj4gVG86IE1hbmlz
aCBOYXJhbmkgPE1OQVJBTklAeGlsaW54LmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7DQo+
IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IE1pY2hhbCBTaW1law0K
PiA8bWljaGFsc0B4aWxpbnguY29tPg0KPiBDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGdpdA0KPiA8Z2l0QHhp
bGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy80XSBtbWM6IHNkaGNpLW9mLWFy
YXNhbjogTW9kaWZ5IGNsb2NrIG9wZXJhdGlvbnMNCj4gaGFuZGxpbmcNCj4gDQo+IE9uIDMwLzAz
LzIwIDg6NDEgYW0sIE1hbmlzaCBOYXJhbmkgd3JvdGU6DQo+ID4gVGhlIFNESENJIGNsb2NrIG9w
ZXJhdGlvbnMgYXJlIHBsYXRmb3JtIHNwZWNpZmljLiBTbyBpdCBiZXR0ZXIgdG8gZGVmaW5lDQo+
ID4gdGhlbSBzZXBhcmF0ZWx5IGZvciBwYXJ0aWN1bGFyIHBsYXRmb3JtLiBUaGlzIHdpbGwgcHJl
dmVudCBtdWx0aXBsZQ0KPiA+IGlmLi5lbHNlIGNvbmRpdGlvbnMgYW5kIHdpbGwgbWFrZSBpdCBl
YXN5IGZvciB1c2VyIHRvIGFkZCB0aGVpciBvd24NCj4gPiBjbG9jayBvcGVyYXRpb25zIGhhbmRs
ZXJzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFuaXNoIE5hcmFuaSA8bWFuaXNoLm5hcmFu
aUB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFy
YXNhbi5jIHwgMjA4ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxMTkgaW5zZXJ0aW9ucygrKSwgODkgZGVsZXRpb25zKC0pDQo+IA0KPiBXb3VsZCB5
b3UgbWluZCBzcGxpdHRpbmcgdGhpcyBpbnRvIGEgcGF0Y2ggdGhhdCBtb3ZlcyB0aGUgZXhpc3Rp
bmcNCj4gc3RydWN0dXJlcyBmaXJzdCwgYW5kIHRoZW4gYSBzZWNvbmQgcGF0Y2ggdG8gbWFrZSB0
aGUgY2hhbmdlcy4NCg0KTm90ZWQuIFdpbGwgZG8gdGhhdCBpbiBuZXh0IHBhdGNoIHNlcmllcy4N
Cg0KPiANCj4gQWxzbywgSSBub3RpY2UgdGhlcmUgaXMgJ3N0cnVjdCBzZGhjaV9hcmFzYW5fZGF0
YScgYnV0IGFsc28NCj4gJ3N0cnVjdCBzZGhjaV9hcmFzYW5fb2ZfZGF0YSBzZGhjaV9hcmFzYW5f
ZGF0YScuICBUaGlzIGlzIGNvbmZ1c2luZywgc28NCj4gcGVyaGFwcyBhIHByZXBhcmF0b3J5IHBh
dGNoIHRoYXQgcmVuYW1lcyB0aGUgbGF0dGVyIGZyb20gc2RoY2lfYXJhc2FuX2RhdGENCj4gdG8g
c29tZXRoaW5lIGVsc2UgZS5nLiBzZGhjaV9hcmFzYW5fZ2VuZXJpY19kYXRhDQoNCk9rYXkuIEkg
d2lsbCBjcmVhdGUgYSBzZXBhcmF0ZSBwYXRjaCBmb3IgcmVuYW1pbmcgdGhlIHNkaGNpX2FyYXNh
bl9kYXRhLg0KDQpUaGFua3MsDQpNYW5pc2gNCg0K
