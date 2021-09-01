Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9BBC4320E
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Sep 2021 09:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7391560FED
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Sep 2021 09:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbhIAJrQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:47:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53750 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S243815AbhIAJrQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2021 05:47:16 -0400
X-UUID: cb231d3310e64a7391004a4d10a40223-20210901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xVsxgE7GKxjgfU/Zld7CtYTFK84M8bj0y+dUluxvmEw=;
        b=tw4GPlWWcS+06CHnnXLQ2/o7MMgW3t1RBH0tglZG8AUI+O9a1xbkS1W3GbGoyALutxObtC3Acz9D9n3BWHGoJJ7Cul/DmXgtt6OgWOU/kg4wI5foOY17KjoFKmTx1cgMvXnJkO9lGG80HwZzkaMUywj/m9ytVcmPvOtLFRl7uOw=;
X-UUID: cb231d3310e64a7391004a4d10a40223-20210901
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1001387453; Wed, 01 Sep 2021 17:46:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Sep 2021 17:46:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Sep 2021 17:46:15 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Sep 2021 17:46:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3qUEYmGF6ERE+ocIQZnR1RnJm9akoc0JH96BfqxAW4/LsNuJ/JYWaTreXI0l37Auh75MfxDnSnLVJUSGSWw/1udNUWDkgBp4ynqyzmpm6vpXRKMQIYod6//sZ5OwrvFgEgb9IransAXR/7+uWDIk9WeQkbM3bQFouqJhBvCwHU2VUbZAIwNmuC7Qb686JoA27vmlHb5MCaVumYAMKx5V76WN7eTq7DU/4/zBEy5rN2grJeKKKDPbHTnXxWUB1Q0fkjSNv8vgMF9tHG/NUVwKP+pBPU1GPV60fcq38vHHBNzHCuW6B35kFf2lys71pHFD9iQrkADXPvzssfXKcUs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xVsxgE7GKxjgfU/Zld7CtYTFK84M8bj0y+dUluxvmEw=;
 b=TaJWaB1h2Ugt/Itbe1GyExu+4XTCsNonx+0mwfM6IYZfkbrlAlkvjaFpT2cJL3EOB3BvP75EaO7d6bfKowF0AiKUYTT2azWQrE3o4/KGNr+id8TFgdQC1dyKJ94fLKObRTaOw1bukuueRXOvrxs76Yw19CixM7vIUJyFDQb4xGxIDe8YT8b2TEX2WakmimGHKnIB/QZqDwwNkqqb/RPPogDVWEPL7e8gk7RmXx+1irUCqNUt8zMg/nD6WAbBY7A4GZLCw94BY0C9lupuIt4uheBClAy8rjZD5ZwjaPjkdg/fkvsbgek0Nt7t8f0Rihms5djYyKuQkN2zs1moKhAXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVsxgE7GKxjgfU/Zld7CtYTFK84M8bj0y+dUluxvmEw=;
 b=I6Wue1QO/13dHch9yVb6jNypi2ZQTDobET/Rcv1hfbFdZjVN8PGvyVHAs0sqeSD0L2MKKqr4kSmsfOSwiTHOMniwIjyp4x+W4vNks1m2Ltv7x/z77aW8COhGhgHWt8c+QwsVO7W80mGNpXWhS/4Ihbd5/TF84K896HSb18jW6DI=
Received: from KL1PR03MB6032.apcprd03.prod.outlook.com (2603:1096:820:8b::7)
 by KL1PR0302MB5268.apcprd03.prod.outlook.com (2603:1096:820:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 09:46:05 +0000
Received: from KL1PR03MB6032.apcprd03.prod.outlook.com
 ([fe80::f1f3:9e9b:be83:21c9]) by KL1PR03MB6032.apcprd03.prod.outlook.com
 ([fe80::f1f3:9e9b:be83:21c9%8]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 09:46:05 +0000
From:   =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 2/2] mmc: mediatek: Add HS400 online tuning support
Thread-Topic: [PATCH v1 2/2] mmc: mediatek: Add HS400 online tuning support
Thread-Index: AQHXmzp/ny8ijKoWf0WGcXWPHCfb0quO9QWA
Date:   Wed, 1 Sep 2021 09:46:05 +0000
Message-ID: <96c6f4163eaa5b8c7bc03d546ae9fdf9249061bb.camel@mediatek.com>
References: <1630065205-7618-1-git-send-email-wenbin.mei@mediatek.com>
         <1630065205-7618-3-git-send-email-wenbin.mei@mediatek.com>
In-Reply-To: <1630065205-7618-3-git-send-email-wenbin.mei@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e25d45c-92b9-427b-6e94-08d96d2d5136
x-ms-traffictypediagnostic: KL1PR0302MB5268:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1PR0302MB5268544EF486832B0CD68C4A98CD9@KL1PR0302MB5268.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vtOi7MRJbDGCCouPplhSg1yV00YDH0lNUYsPinjrFBzs37z9a8powLLL630ecbrEiUQ1S/xKzem4myy26E6p/TmWVswE10ezPVKNVUknudk9GbdBiV6LqLoGaYArTsenRCFvIzFmF0b4epcTAcz+KsS8uZq/0MenXe7MRV8LYUrrI857V5dR7Dsb0eRJ5pDitHvnakx0H14cxZ0nSXakIOEGsrSZvcSrxqtJnjIwFn5GEKHFhxp+Sr3QEIZCQG36ZWfj+S3WWkU6O78CWTcqfhD4Wo43RGquEvF6m0kufk90e1lbkAC3HTucC2lBqJah+P2YOIgKKJoMlnhbeOCRtlV30k6BXXLl4+mMmC/a99xdio5QT0i9k1HGguXbNspKPtz3z48CLGc4OlcszcYD7jbMxJ+Om8QLCBSDtNYHvAvnCB/SSUMmH6oY3JHyhxbO/90H9OA2B8kPqd2sf9gmNuG9zmKGsu1UDNCkQfFUs6AidGrR+GvdLqwWNtD8B2l5t9BlFKU4dLiKk88amekRSAhYu0QQejknN+4BYin7sjq/BPl+uZIxwhrDWvHFzdxeNhgJFeSqhZAxHQXrxrevdIcTs//A7DklOpMFxRV+2+7QVaJAXn5lBUA1KHha4KgLVymH2Q6HPhVDERDq9K0rsJnzMWRYLzPx+on1+WARzCWh0kyTULBcbD2IpinXm7d2m+VG82UMbgJBJtaG6DOkJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6032.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(64756008)(66556008)(6512007)(66946007)(66476007)(5660300002)(76116006)(91956017)(6486002)(110136005)(4326008)(8936002)(8676002)(2616005)(85182001)(2906002)(498600001)(26005)(6636002)(54906003)(186003)(36756003)(86362001)(7416002)(71200400001)(6506007)(83380400001)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFhWcUc1Q1dRS0FiTFJFZ1h6TlNGRlZRTnJqUlRjaXA3dzEvWVJBVmpuMGxM?=
 =?utf-8?B?QS9ZNEFwVFIvYi81RVhUV3JFam9FUDR1OVgzRnRUYTB1YlZ5Z2RJUk5pckhP?=
 =?utf-8?B?MTdPNHgrS3BKcWpQS1FFemhtRFFxWEFtTTVlQ3NGQlJYWld5ZlpYOGVTd3dV?=
 =?utf-8?B?UTgyTDdlS2tZNTVQVjZTZnY1Nm1HeXZEYnJ2ODlHUnBERU5mUnljdHk3UGF4?=
 =?utf-8?B?NHE5WTQxOUVBblVJREoxS0Z1eHpzYmtmRVFwZDkyNDBUb2tWeFhHR0JaRUFk?=
 =?utf-8?B?WDluc0p5OHJJMHhLZDhNNmlUV1Y3UDJBbHFjOHIyNjJ0ZDNNK1NRSDVxdmFY?=
 =?utf-8?B?V2NVQTFVdGgwN21xcUJrVGFsM1ExRWE5WnYwV3RwejRNc3QrNE5TOUhla2hr?=
 =?utf-8?B?SmsyVEJJOFJ1dGdxdVM3NWowMWUvc2xRZ1pvbFRxN0k5RVpLL0lnUjhaMk1h?=
 =?utf-8?B?aWZ6MVIvS1RvWlVZMVZZdHZvYzhRcjFqd1VjWlJvSnJUdTVpcUZJVTh1dDZB?=
 =?utf-8?B?N0k1bjlIUnVPTlFFUE1SZEhUK2ZWQ2JqdHNZcGZ2WHowVnlvZE04b1JQdEZP?=
 =?utf-8?B?RFRLMWVvTzRmN2xZektmUUVrOVpPMEtrajhVeGxHZHJxaU1SL2NDa1RGcWpK?=
 =?utf-8?B?RzExbkM0SDJoeWpWTGl5MWZaQ3JIakxEYzROdmg5aXhrSDQzcWYzdWtHQnRC?=
 =?utf-8?B?Y2R0Y2tOVGZJYWZMS3lyc0ppZ1dLenUva2tzOEtyYWsxcmdwckZFcmRSOXJZ?=
 =?utf-8?B?U3RCWGU3N3lGTzFkL0crbDJIWlNFWUF4RUdXUFA5N3IrTm1sTm1oeFovQVpr?=
 =?utf-8?B?eWtPRENiZlROV1ZzNUtYMlpNRkdHMnNKS290UjBMK0VjZE9jVWoySitONlpP?=
 =?utf-8?B?L2pPdml4ZGdrczJmT1JjQjhOTExNaFF3aWl3UnhuMFFiaGZrZUJhTVlMQit4?=
 =?utf-8?B?ckJmb2tjZDkwK3BJZkRGMktVZ3pGbmVVak05bWhlUkRsK0QzTjc4N21CMGd2?=
 =?utf-8?B?RFJDbCsvV0U1VjJqenQ2LzQ0cTAyekhydmY4dXVSL1BMQU5zaHVPQXZZOTFh?=
 =?utf-8?B?T2lSTnk3RDlYK2plNitWUVQ2eG1pRWJBYkVuc3Z5Y3MwaGdwYW5VVkVZdzg4?=
 =?utf-8?B?YVo1STBLUzBRN2VlRDNiSEM5MzdyZm9yandScHdhSjN3WG1VcnZnY2tQTVpN?=
 =?utf-8?B?WFprODNkcGhHM0tJMi9leWh3TDNHNTNOTXBMN3BwTTA1ZTR4MW5QckxCa2Nz?=
 =?utf-8?B?RlV4QlhVZkF4MkNmRUxJTXFKSVR1SFpxUGp6YnRjeEdMQSthaThHVWk5NjVh?=
 =?utf-8?B?UDNNRTJqeE1iZFdVOE1naG5lTlpJcTVIUVFqSDJZNEw0Y0QrVFhNcUJoTTJm?=
 =?utf-8?B?NHE1a21YMlhPbFcyS0RvQldSS0dWZjhmVWRMYnRqd0diNHpWYnlqMDU1dUdP?=
 =?utf-8?B?NUZmeUtxMnZlMGdxVEg1Zk1NbUFhQzcwZDhQQ0ZvQTIwREIrYUdrU092ZHpQ?=
 =?utf-8?B?R0xWMXE3Nm5WRTc0NGJRQzZmelNlVWpya2hnejIvZnFCQmpyU3lvUUN0SFVP?=
 =?utf-8?B?d2d1SGs0MFhQNkZCL09oeGx4L2FYRkRrNXF0dnNJd1FyUmVFRk5nOVJadmlG?=
 =?utf-8?B?UTZxVWhFc3lsZFZSVDZITUVEZmxOUU0wZnlKaURFZFo1STErYk5DK3lnYlJU?=
 =?utf-8?B?RjZpQXAzN1cvMjU5T2FYTTQ4M2M3akMyM3pFNTFYYTRWRXE2N1N0M0JZZ3lC?=
 =?utf-8?Q?ScfyyoCo3myFnyOQuz8/2Sc9jXLNGy5R1XKA2Op?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D62A97C4C599784C838CC15B1D93EA4B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6032.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e25d45c-92b9-427b-6e94-08d96d2d5136
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 09:46:05.2446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPp2NUy2YxqHWGY+ZbijbeRbUQVNQ/84Bb4UX2rRtS5xEarde8x0GOI7LDKOhSYUIERxHc8eS5UEAuhaj8GkVvnGVJqjwrn8rMgHFPE0DpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5268
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gRnJpLCAyMDIxLTA4LTI3IGF0IDE5OjUzICswODAwLCBXZW5iaW4gTWVpIHdyb3RlOg0KPiBE
dWUgdG8gdGhlIGluZmx1ZW5jZSBvZiB0aGUgY29ybmVyIElDIGFuZCB2Y29yZSB2b2x0YWdlLCBm
b3IgdGhlDQo+IHN0YWJpbGl0eQ0KPiBvZiBIUzQwMCBtb2RlLCB3ZSBBZGQgSFM0MDAgbW9kZSBv
bmxpbmUgdHVuaW5nIHN1cHBvcnQgZm9yIG1lZGlhdGVrDQo+IG1tYw0KPiBob3N0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRpYXRlay5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9tbWMvY29yZS9tbWMuYyAgICB8ICAgOCArKysrDQo+ICBkcml2ZXJzL21t
Yy9ob3N0L210ay1zZC5jIHwgMTE4DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0NCj4gIGluY2x1ZGUvbGludXgvbW1jL2hvc3QuaCAgfCAgIDMgKysNCj4g
IDMgZmlsZXMgY2hhbmdlZCwgMTI3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYyBiL2RyaXZlcnMvbW1jL2NvcmUv
bW1jLmMNCj4gaW5kZXggODM4NzI2Yi4uZjA2YmU3ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9t
bWMvY29yZS9tbWMuYw0KPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jDQo+IEBAIC0xMjIy
LDYgKzEyMjIsMTQgQEAgc3RhdGljIGludCBtbWNfc2VsZWN0X2hzNDAwKHN0cnVjdCBtbWNfY2Fy
ZA0KPiAqY2FyZCkNCj4gIAltbWNfc2V0X3RpbWluZyhob3N0LCBNTUNfVElNSU5HX01NQ19IUzQw
MCk7DQo+ICAJbW1jX3NldF9idXNfc3BlZWQoY2FyZCk7DQo+ICANCj4gKwlpZiAoaG9zdC0+b3Bz
LT5leGVjdXRlX2hzNDAwX3R1bmluZyAmJiBtbWNfY2FuX2V4dF9jc2QoY2FyZCkpIHsNCk5vIG5l
ZWQgdG8gY2hlY2sgIm1tY19jYW5fZXh0X2NzZChjYXJkKSIgYXQgdGhpcyBwb2ludC4NCj4gKwkJ
bW1jX3JldHVuZV9kaXNhYmxlKGhvc3QpOw0KPiArCQllcnIgPSBob3N0LT5vcHMtPmV4ZWN1dGVf
aHM0MDBfdHVuaW5nKGhvc3QsIGNhcmQpOw0KPiArCQltbWNfcmV0dW5lX2VuYWJsZShob3N0KTsN
Cj4gKwkJaWYgKGVycikNCj4gKwkJCWdvdG8gb3V0X2VycjsNCj4gKwl9DQo+ICsNCj4gIAlpZiAo
aG9zdC0+b3BzLT5oczQwMF9jb21wbGV0ZSkNCj4gIAkJaG9zdC0+b3BzLT5oczQwMF9jb21wbGV0
ZShob3N0KTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyBi
L2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gaW5kZXggNGRmYzI0Ni4uZjVhYzcxMSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiArKysgYi9kcml2ZXJzL21t
Yy9ob3N0L210ay1zZC5jDQo+IEBAIC0yNTgsNiArMjU4LDcgQEANCj4gICNkZWZpbmUgTVNEQ19Q
QURfVFVORV9SRF9TRUwJICAoMHgxIDw8IDEzKSAgIC8qIFJXICovDQo+ICAjZGVmaW5lIE1TRENf
UEFEX1RVTkVfQ01EX1NFTAkgICgweDEgPDwgMjEpICAgLyogUlcgKi8NCj4gIA0KPiArI2RlZmlu
ZSBQQURfRFNfVFVORV9ETFlfU0VMICAgICAgICgweDEgPDwgMCkJLyogUlcgKi8NCj4gICNkZWZp
bmUgUEFEX0RTX1RVTkVfRExZMQkgICgweDFmIDw8IDIpICAgLyogUlcgKi8NCj4gICNkZWZpbmUg
UEFEX0RTX1RVTkVfRExZMgkgICgweDFmIDw8IDcpICAgLyogUlcgKi8NCj4gICNkZWZpbmUgUEFE
X0RTX1RVTkVfRExZMwkgICgweDFmIDw8IDEyKSAgLyogUlcgKi8NCj4gQEAgLTMwMSw2ICszMDIs
MTEgQEANCj4gICNkZWZpbmUgUEFEX0NNRF9SRF9SWERMWV9TRUwgICAgKDB4MSA8PCAxMSkgICAg
IC8qIFJXICovDQo+ICAjZGVmaW5lIFBBRF9DTURfVFhfRExZICAgICAgICAgICgweDFmIDw8IDEy
KSAgICAvKiBSVyAqLw0KPiAgDQo+ICsvKiBFTU1DNTBfUEFEX0RTX1RVTkUgbWFzayAqLw0KPiAr
I2RlZmluZSBQQURfRFNfRExZX1NFTAkJKDB4MSA8PCAxNikJLyogUlcgKi8NCj4gKyNkZWZpbmUg
UEFEX0RTX0RMWTEJCSgweDFmIDw8IDEwKQkvKiBSVyAqLw0KPiArI2RlZmluZSBQQURfRFNfRExZ
MwkJKDB4MWYgPDwgMCkJLyogUlcgKi8NCj4gKw0KPiAgI2RlZmluZSBSRVFfQ01EX0VJTyAgKDB4
MSA8PCAwKQ0KPiAgI2RlZmluZSBSRVFfQ01EX1RNTyAgKDB4MSA8PCAxKQ0KPiAgI2RlZmluZSBS
RVFfREFUX0VSUiAgKDB4MSA8PCAyKQ0KPiBAQCAtNDQ4LDExICs0NTQsMTMgQEAgc3RydWN0IG1z
ZGNfaG9zdCB7DQo+ICAJYm9vbCB2cW1tY19lbmFibGVkOw0KPiAgCXUzMiBsYXRjaF9jazsNCj4g
IAl1MzIgaHM0MDBfZHNfZGVsYXk7DQo+ICsJdTMyIGhzNDAwX2RzX2RseTM7DQo+ICAJdTMyIGhz
MjAwX2NtZF9pbnRfZGVsYXk7IC8qIGNtZCBpbnRlcm5hbCBkZWxheSBmb3IgSFMyMDAvU0RSMTA0
DQo+ICovDQo+ICAJdTMyIGhzNDAwX2NtZF9pbnRfZGVsYXk7IC8qIGNtZCBpbnRlcm5hbCBkZWxh
eSBmb3IgSFM0MDAgKi8NCj4gIAlib29sIGhzNDAwX2NtZF9yZXNwX3NlbF9yaXNpbmc7DQo+ICAJ
CQkJIC8qIGNtZCByZXNwb25zZSBzYW1wbGUgc2VsZWN0aW9uIGZvcg0KPiBIUzQwMCAqLw0KPiAg
CWJvb2wgaHM0MDBfbW9kZTsJLyogY3VycmVudCBlTU1DIHdpbGwgcnVuIGF0IGhzNDAwIG1vZGUg
Ki8NCj4gKwlib29sIGhzNDAwX3R1bmluZzsJLyogaHM0MDAgbW9kZSBvbmxpbmUgdHVuaW5nICov
DQo+ICAJYm9vbCBpbnRlcm5hbF9jZDsJLyogVXNlIGludGVybmFsIGNhcmQtZGV0ZWN0IGxvZ2lj
ICovDQo+ICAJYm9vbCBjcWhjaTsJCS8qIHN1cHBvcnQgZU1NQyBodyBjbWRxICovDQo+ICAJc3Ry
dWN0IG1zZGNfc2F2ZV9wYXJhIHNhdmVfcGFyYTsgLyogdXNlZCB3aGVuIGdhdGUgSENMSyAqLw0K
PiBAQCAtMTE5MCw3ICsxMTk4LDggQEAgc3RhdGljIGJvb2wgbXNkY19jbWRfZG9uZShzdHJ1Y3Qg
bXNkY19ob3N0DQo+ICpob3N0LCBpbnQgZXZlbnRzLA0KPiAgCWlmICghc2JjX2Vycm9yICYmICEo
ZXZlbnRzICYgTVNEQ19JTlRfQ01EUkRZKSkgew0KPiAgCQlpZiAoZXZlbnRzICYgTVNEQ19JTlRf
Q01EVE1PIHx8DQo+ICAJCSAgICAoY21kLT5vcGNvZGUgIT0gTU1DX1NFTkRfVFVOSU5HX0JMT0NL
ICYmDQo+IC0JCSAgICAgY21kLT5vcGNvZGUgIT0gTU1DX1NFTkRfVFVOSU5HX0JMT0NLX0hTMjAw
KSkNCj4gKwkJICAgICBjbWQtPm9wY29kZSAhPSBNTUNfU0VORF9UVU5JTkdfQkxPQ0tfSFMyMDAg
JiYNCj4gKwkJICAgICAoaG9zdC0+aHM0MDBfdHVuaW5nICYmIGNtZC0+b3Bjb2RlICE9DQo+IE1N
Q19TRU5EX0VYVF9DU0QpKSkNClRoZSAoaG9zdC0+aHM0MDBfdHVuaW5nICYmIGNtZC0+b3Bjb2Rl
ICE9DQo+IA0KTU1DX1NFTkRfRVhUX0NTRCkgd2lsbCBhbHdheXMgYmUgZmFsc2UuDQpjaGFuZ2Ug
aXQgdG8gIWhvc3QtPmhzNDAwX3R1bmluZyBpcyBlbm91Z2guDQo+ICAJCQkvKg0KPiAgCQkJICog
c2hvdWxkIG5vdCBjbGVhciBmaWZvL2ludGVycnVwdCBhcyB0aGUgdHVuZQ0KPiBkYXRhDQo+ICAJ
CQkgKiBtYXkgaGF2ZSBhbHJlYXkgY29tZSB3aGVuIGNtZDE5L2NtZDIxIGdldHMNCj4gcmVzcG9u
c2UNCj4gQEAgLTEyODcsNyArMTI5Niw4IEBAIHN0YXRpYyB2b2lkIG1zZGNfY21kX25leHQoc3Ry
dWN0IG1zZGNfaG9zdA0KPiAqaG9zdCwNCj4gIAlpZiAoKGNtZC0+ZXJyb3IgJiYNCj4gIAkgICAg
IShjbWQtPmVycm9yID09IC1FSUxTRVEgJiYNCj4gIAkgICAgICAoY21kLT5vcGNvZGUgPT0gTU1D
X1NFTkRfVFVOSU5HX0JMT0NLIHx8DQo+IC0JICAgICAgIGNtZC0+b3Bjb2RlID09IE1NQ19TRU5E
X1RVTklOR19CTE9DS19IUzIwMCkpKSB8fA0KPiArCSAgICAgICBjbWQtPm9wY29kZSA9PSBNTUNf
U0VORF9UVU5JTkdfQkxPQ0tfSFMyMDAgfHwNCj4gKwkgICAgICAgKGhvc3QtPmhzNDAwX3R1bmlu
ZyAmJiBjbWQtPm9wY29kZSAhPQ0KPiBNTUNfU0VORF9FWFRfQ1NEKSkpKSB8fA0KU2FtZSBhcyBh
Ym92ZSwgY2hhbmdlIGl0IHRvIGhvc3QtPmhzNDAwX3R1bmluZw0KPiAgCSAgICAobXJxLT5zYmMg
JiYgbXJxLT5zYmMtPmVycm9yKSkNCj4gIAkJbXNkY19yZXF1ZXN0X2RvbmUoaG9zdCwgbXJxKTsN
Cj4gIAllbHNlIGlmIChjbWQgPT0gbXJxLT5zYmMpDQo+IEBAIC0yMjUxLDYgKzIyNjEsMTA2IEBA
IHN0YXRpYyBpbnQgbXNkY19wcmVwYXJlX2hzNDAwX3R1bmluZyhzdHJ1Y3QNCj4gbW1jX2hvc3Qg
Km1tYywgc3RydWN0IG1tY19pb3MgKmlvcykNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAr
c3RhdGljIGludCBtc2RjX3NlbmRfY3hkX2RhdGEoc3RydWN0IG1tY19jYXJkICpjYXJkLCBzdHJ1
Y3QgbW1jX2hvc3QNCj4gKmhvc3QpDQo+ICt7DQo+ICsJc3RydWN0IG1tY19yZXF1ZXN0IG1ycSA9
IHt9Ow0KPiArCXN0cnVjdCBtbWNfY29tbWFuZCBjbWQgPSB7fTsNCj4gKwlzdHJ1Y3QgbW1jX2Rh
dGEgZGF0YSA9IHt9Ow0KPiArCXVuc2lnbmVkIGludCBsZW4gPSA1MTI7DQo+ICsJc3RydWN0IHNj
YXR0ZXJsaXN0IHNnOw0KPiArCXU4ICpleHRfY3NkOw0KPiArDQo+ICsJZXh0X2NzZCA9IGt6YWxs
b2MobGVuLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWV4dF9jc2QpDQo+ICsJCXJldHVybiAtRU5P
TUVNOw0KPiArDQo+ICsJbXJxLmNtZCA9ICZjbWQ7DQo+ICsJbXJxLmRhdGEgPSAmZGF0YTsNCj4g
Kw0KPiArCWNtZC5vcGNvZGUgPSBNTUNfU0VORF9FWFRfQ1NEOw0KPiArCWNtZC5hcmcgPSAwOw0K
PiArCWNtZC5mbGFncyA9IE1NQ19SU1BfU1BJX1IxIHwgTU1DX1JTUF9SMSB8IE1NQ19DTURfQURU
QzsNCj4gKw0KPiArCWRhdGEuYmxrc3ogPSBsZW47DQo+ICsJZGF0YS5ibG9ja3MgPSAxOw0KPiAr
CWRhdGEuZmxhZ3MgPSBNTUNfREFUQV9SRUFEOw0KPiArCWRhdGEuc2cgPSAmc2c7DQo+ICsJZGF0
YS5zZ19sZW4gPSAxOw0KPiArDQo+ICsJc2dfaW5pdF9vbmUoJnNnLCBleHRfY3NkLCBsZW4pOw0K
PiArCW1tY19zZXRfZGF0YV90aW1lb3V0KCZkYXRhLCBjYXJkKTsNCj4gKwltbWNfd2FpdF9mb3Jf
cmVxKGhvc3QsICZtcnEpOw0KPiArDQo+ICsJa2ZyZWUoZXh0X2NzZCk7DQo+ICsNCj4gKwlpZiAo
Y21kLmVycm9yKQ0KPiArCQlyZXR1cm4gY21kLmVycm9yOw0KPiArCWlmIChkYXRhLmVycm9yKQ0K
PiArCQlyZXR1cm4gZGF0YS5lcnJvcjsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+
ICtzdGF0aWMgaW50IG1zZGNfZXhlY3V0ZV9oczQwMF90dW5pbmcoc3RydWN0IG1tY19ob3N0ICpt
bWMsIHN0cnVjdA0KPiBtbWNfY2FyZCAqY2FyZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgbXNkY19ob3N0
ICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCj4gKwlzdHJ1Y3QgbXNkY19kZWxheV9waGFzZSBkbHkx
X2RlbGF5Ow0KPiArCXUzMiB2YWwsIHJlc3VsdF9kbHkxID0gMDsNCj4gKwlpbnQgaSwgcmV0Ow0K
PiArDQo+ICsJaWYgKGhvc3QtPnRvcF9iYXNlKSB7DQo+ICsJCXNkcl9zZXRfYml0cyhob3N0LT50
b3BfYmFzZSArIEVNTUM1MF9QQURfRFNfVFVORSwNCj4gKwkJCSAgICAgUEFEX0RTX0RMWV9TRUwp
Ow0KPiArCQlpZiAoaG9zdC0+aHM0MDBfZHNfZGx5MykNCj4gKwkJCXNkcl9zZXRfZmllbGQoaG9z
dC0+dG9wX2Jhc2UgKw0KPiBFTU1DNTBfUEFEX0RTX1RVTkUsDQo+ICsJCQkJICAgICAgUEFEX0RT
X0RMWTMsIGhvc3QtDQo+ID5oczQwMF9kc19kbHkzKTsNCj4gKwl9IGVsc2Ugew0KPiArCQlzZHJf
c2V0X2JpdHMoaG9zdC0+YmFzZSArIFBBRF9EU19UVU5FLA0KPiBQQURfRFNfVFVORV9ETFlfU0VM
KTsNCj4gKwkJaWYgKGhvc3QtPmhzNDAwX2RzX2RseTMpDQo+ICsJCQlzZHJfc2V0X2ZpZWxkKGhv
c3QtPmJhc2UgKyBQQURfRFNfVFVORSwNCj4gKwkJCQkgICAgICBQQURfRFNfVFVORV9ETFkzLCBo
b3N0LQ0KPiA+aHM0MDBfZHNfZGx5Myk7DQo+ICsJfQ0KPiArDQo+ICsJaG9zdC0+aHM0MDBfdHVu
aW5nID0gdHJ1ZTsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgUEFEX0RFTEFZX01BWDsgaSsrKSB7DQo+
ICsJCWlmIChob3N0LT50b3BfYmFzZSkNCj4gKwkJCXNkcl9zZXRfZmllbGQoaG9zdC0+dG9wX2Jh
c2UgKw0KPiBFTU1DNTBfUEFEX0RTX1RVTkUsDQo+ICsJCQkJICAgICAgUEFEX0RTX0RMWTEsIGkp
Ow0KPiArCQllbHNlDQo+ICsJCQlzZHJfc2V0X2ZpZWxkKGhvc3QtPmJhc2UgKyBQQURfRFNfVFVO
RSwNCj4gKwkJCQkgICAgICBQQURfRFNfVFVORV9ETFkxLCBpKTsNCj4gKwkJcmV0ID0gbXNkY19z
ZW5kX2N4ZF9kYXRhKGNhcmQsIG1tYyk7DQo+ICsJCWlmICghcmV0KQ0KPiArCQkJcmVzdWx0X2Rs
eTEgfD0gKDEgPDwgaSk7DQo+ICsJfQ0KPiArCWhvc3QtPmhzNDAwX3R1bmluZyA9IGZhbHNlOw0K
PiArDQo+ICsJZGx5MV9kZWxheSA9IGdldF9iZXN0X2RlbGF5KGhvc3QsIHJlc3VsdF9kbHkxKTsN
Cj4gKwlpZiAoZGx5MV9kZWxheS5tYXhsZW4gPT0gMCkgew0KPiArCQlkZXZfZXJyKGhvc3QtPmRl
diwgIkZhaWxlZCB0byBnZXQgRExZMSBkZWxheSFcbiIpOw0KPiArCQlnb3RvIGZhaWw7DQo+ICsJ
fQ0KPiArCWlmIChob3N0LT50b3BfYmFzZSkNCj4gKwkJc2RyX3NldF9maWVsZChob3N0LT50b3Bf
YmFzZSArIEVNTUM1MF9QQURfRFNfVFVORSwNCj4gKwkJCSAgICAgIFBBRF9EU19ETFkxLCBkbHkx
X2RlbGF5LmZpbmFsX3BoYXNlKTsNCj4gKwllbHNlDQo+ICsJCXNkcl9zZXRfZmllbGQoaG9zdC0+
YmFzZSArIFBBRF9EU19UVU5FLA0KPiArCQkJICAgICAgUEFEX0RTX1RVTkVfRExZMSwNCj4gZGx5
MV9kZWxheS5maW5hbF9waGFzZSk7DQo+ICsNCj4gKwlpZiAoaG9zdC0+dG9wX2Jhc2UpDQo+ICsJ
CXZhbCA9IHJlYWRsKGhvc3QtPnRvcF9iYXNlICsgRU1NQzUwX1BBRF9EU19UVU5FKTsNCj4gKwll
bHNlDQo+ICsJCXZhbCA9IHJlYWRsKGhvc3QtPmJhc2UgKyBQQURfRFNfVFVORSk7DQo+ICsNCj4g
KwlkZXZfaW5mbyhob3N0LT5kZXYsICJGaWFubCBQQURfRFNfVFVORTogMHgleFxuIiwgdmFsKTsN
Cj4gKw0KPiArCXJldHVybiAwOw0KPiArDQo+ICtmYWlsOg0KPiArCWRldl9lcnIoaG9zdC0+ZGV2
LCAiRmFpbGVkIHRvIHR1bmluZyBEUyBwaW4gZGVsYXkhXG4iKTsNCj4gKwlyZXR1cm4gLUVSQU5H
RTsNCnJldHVybiAtRUlPIHRvIGluc3RlYWQgb2YgLUVSQU5HRS4NCj4gK30NCj4gKw0KPiAgc3Rh
dGljIHZvaWQgbXNkY19od19yZXNldChzdHJ1Y3QgbW1jX2hvc3QgKm1tYykNCj4gIHsNCj4gIAlz
dHJ1Y3QgbXNkY19ob3N0ICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCj4gQEAgLTIzNzcsNiArMjQ4
Nyw3IEBAIHN0YXRpYyB2b2lkIG1zZGNfY3FlX3Bvc3RfZGlzYWJsZShzdHJ1Y3QNCj4gbW1jX2hv
c3QgKm1tYykNCj4gIAkuY2FyZF9idXN5ID0gbXNkY19jYXJkX2J1c3ksDQo+ICAJLmV4ZWN1dGVf
dHVuaW5nID0gbXNkY19leGVjdXRlX3R1bmluZywNCj4gIAkucHJlcGFyZV9oczQwMF90dW5pbmcg
PSBtc2RjX3ByZXBhcmVfaHM0MDBfdHVuaW5nLA0KPiArCS5leGVjdXRlX2hzNDAwX3R1bmluZyA9
IG1zZGNfZXhlY3V0ZV9oczQwMF90dW5pbmcsDQo+ICAJLmh3X3Jlc2V0ID0gbXNkY19od19yZXNl
dCwNCj4gIH07DQo+ICANCj4gQEAgLTIzOTYsNiArMjUwNyw5IEBAIHN0YXRpYyB2b2lkIG1zZGNf
b2ZfcHJvcGVydHlfcGFyc2Uoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gIAlv
Zl9wcm9wZXJ0eV9yZWFkX3UzMihwZGV2LT5kZXYub2Zfbm9kZSwgImhzNDAwLWRzLWRlbGF5IiwN
Cj4gIAkJCSAgICAgJmhvc3QtPmhzNDAwX2RzX2RlbGF5KTsNCj4gIA0KPiArCW9mX3Byb3BlcnR5
X3JlYWRfdTMyKHBkZXYtPmRldi5vZl9ub2RlLCAibWVkaWF0ZWssaHM0MDAtZHMtDQo+IGRseTMi
LA0KPiArCQkJICAgICAmaG9zdC0+aHM0MDBfZHNfZGx5Myk7DQo+ICsNCj4gIAlvZl9wcm9wZXJ0
eV9yZWFkX3UzMihwZGV2LT5kZXYub2Zfbm9kZSwgIm1lZGlhdGVrLGhzMjAwLWNtZC0NCj4gaW50
LWRlbGF5IiwNCj4gIAkJCSAgICAgJmhvc3QtPmhzMjAwX2NtZF9pbnRfZGVsYXkpOw0KPiAgDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tYy9ob3N0LmggYi9pbmNsdWRlL2xpbnV4L21t
Yy9ob3N0LmgNCj4gaW5kZXggZmYxYTI1MS4uNzU1MmQ1ZSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9tbWMvaG9zdC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaA0KPiBA
QCAtMTYyLDYgKzE2Miw5IEBAIHN0cnVjdCBtbWNfaG9zdF9vcHMgew0KPiAgCS8qIFByZXBhcmUg
SFM0MDAgdGFyZ2V0IG9wZXJhdGluZyBmcmVxdWVuY3kgZGVwZW5kaW5nIGhvc3QNCj4gZHJpdmVy
ICovDQo+ICAJaW50CSgqcHJlcGFyZV9oczQwMF90dW5pbmcpKHN0cnVjdCBtbWNfaG9zdCAqaG9z
dCwgc3RydWN0DQo+IG1tY19pb3MgKmlvcyk7DQo+ICANCj4gKwkvKiBFeGVjdXRlIEhTNDAwIHR1
bmluZyBkZXBlbmRpbmcgaG9zdCBkcml2ZXIgKi8NCj4gKwlpbnQJKCpleGVjdXRlX2hzNDAwX3R1
bmluZykoc3RydWN0IG1tY19ob3N0ICpob3N0LCBzdHJ1Y3QNCj4gbW1jX2NhcmQgKmNhcmQpOw0K
PiArDQo+ICAJLyogUHJlcGFyZSBzd2l0Y2ggdG8gRERSIGR1cmluZyB0aGUgSFM0MDAgaW5pdCBz
ZXF1ZW5jZSAqLw0KPiAgCWludAkoKmhzNDAwX3ByZXBhcmVfZGRyKShzdHJ1Y3QgbW1jX2hvc3Qg
Kmhvc3QpOw0KPiAgDQo=
