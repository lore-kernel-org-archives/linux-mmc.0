Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149F1C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Dec 2022 09:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiLVJUK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Dec 2022 04:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiLVJUI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2022 04:20:08 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865142182B
        for <linux-mmc@vger.kernel.org>; Thu, 22 Dec 2022 01:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzyaL0zkqsxokxMDFRE9w5qdXMmOtOhHYHjQXqjObw6fReHQ+jZyeaiSFFahxmCxM5vMbh6fVjUlrF+KLjcXX2FlvDaA7sJkk2aHBLiWVSoq8/4eFmTHcU4K7UOjDYYOifA/TSRdTXXj6SG24ZX1aurf+9zxUqhF9Ni1h7p9yg96GqVguZiOntMW4cBZjzKCRhpqAshWsU8N0qHaK1HZ/FfZMlFFVy8HfSWizmRYgQEr0IGJizWBmXszVohZvGI87oUtzYH+r6TQNnoyl4YE/N5Z4C+8+k0PKarBkftT1hBS45H0WIaefAaezSg7SfammrMFZ5qkX65B86X+Qrs3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIYop1eJseH+OkEhBBIIIZvBpjxclrLasQa95z2kbFk=;
 b=YLPwcfn/SChzb9HNnQapYZgl2h0W7ThIRqrw112ooo2outtVmbnWylLmmmJg/lnsagpHkmTGDUKhVUCvvfluidYr3lkXxq2JRCKdeabyT2iP6cnuMRMrwfRIRauA2QmcQn4j5+q5+OAkU2MIt/mXU+MV6GFc+G0tZmFLMrh3Naqh7IcnCdJ+62tN+8bu17u7i8F+d/8kVkTIwgObGKSCTWnkyKNlK9K+P3SjmRngywa0Cu/hMBC7opCuUMZQ0wIiG0qx47SgUOpuxqjDoBlVJmy1+c8nomSNMorxAFXh0kYo586jaNBqbhwjuyNhxG8M1mkbj9shZLupaGgIR8sJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIYop1eJseH+OkEhBBIIIZvBpjxclrLasQa95z2kbFk=;
 b=srs3/r94uxIDqHTWiLXes8/YP5OpiJDJvfpyHm/Ad5dgrQLtBKujViIWOLX3X2S7hmv/sGj44igHdhcyJlWnieZIbiURAxPqvQ4PYiG1HPd4ZrfjAfAOHlYC6Il9lYAKzr04DCBvqZ18T8aD2yj9QBu5vsoLO9dxf2y5bt9rdFY=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 09:20:05 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::4dd6:decd:f064:fab9]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::4dd6:decd:f064:fab9%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 09:20:05 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Marek Vasut <marex@denx.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Goud, Srinivas" <srinivas.goud@amd.com>
Subject: RE: [PATCH] mmc: sdhci-of-arasan: Override
 SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
Thread-Topic: [PATCH] mmc: sdhci-of-arasan: Override
 SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
Thread-Index: AQHZFPpVYHx01PZ0LkqAwW/6LG+h6q54FlsAgAGJfsA=
Date:   Thu, 22 Dec 2022 09:20:05 +0000
Message-ID: <BY5PR12MB42584370EDE593D8DBB42CF8DBE89@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20221025191500.149167-1-marex@denx.de>
 <2b523371-7eeb-25f2-8879-76bbf028f4bb@intel.com>
 <c3d62448-fd1c-066c-aa53-2df7eae1555d@denx.de>
 <BY5PR12MB425809920721B2CBC5A4F517DBEB9@BY5PR12MB4258.namprd12.prod.outlook.com>
 <8b9d6dd1-01fa-5ae1-072e-c5dc7f8b553e@denx.de>
In-Reply-To: <8b9d6dd1-01fa-5ae1-072e-c5dc7f8b553e@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|DM4PR12MB6567:EE_
x-ms-office365-filtering-correlation-id: d6bfa546-dc31-4ce8-6dda-08dae3fdb64b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tmi3rlTfUfkz/PoalfhndbPvetFEmXsYfc7T+77XTqST5Z6UUYDqrt+P7Q9V6sOeTJz4XTzgpV1xxYpp5L2twYjd+u12j4ZtOz1Jdb3FfQJ30VUJe4IpBHX5F3eNhjJMZfyQmLLYgMaBgIlBU1pmcEmSGshlqYrCRA7K1NhamhF5ls4q2bv+/CJDUEJWvJ0ZLGUP0lOdx5+PmKmc6HfX0MA0eQwLjAxj5sSUepAi2bYad9RXafrNo6a1ZIcKF5DM5aWsovQd2AuRx8iHYfnHE0rCz7k8D0awQI9o5yBTExXKFddyniBFy2oBWWmTXOfsR1D6aKMpNzUeYHgUUIA0H6hpF0C6yE5mD/J3iYLb/j7W79AlVtzyw1TzGKZ1C2ITTk/A/tulpio48/qaSpKSb19M+5mahHs19avRv1xrpxdttV0ltvvxUi3ZWKFkR8rpWBzWbl7BNVndWaVKGzLK+fnT6mVFkJoZx/LoT8c3a2I0RIsXAh8FlzkiZcIGBS5k7d6O/25ByOM/r/6sPTCZqfiDndLUPDaFuSyzkMsxEe3AKdnUIVjfAdKHFeT/bQJWpsmCIaG716IiyRXd8PUHsoTEZVUI/7cCyFcEyzzTRjbhDaRlwhoArEwG6/Sg8OfmI0EAE2v/x3hUb2GzQv568OK6+KTZErDuflfAFr/3+cPfytGuc2ugFJHRTjy+DLFkkWW5QYYy2SGVRcZ/RSt9/B2OjOsWMtBKN+PM0LC4U9U5rM0Uy0PWw8B/Hkf1WXGaU+15iQV/ySoChp/KT1uBzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199015)(2906002)(186003)(41300700001)(26005)(7696005)(53546011)(38100700002)(6506007)(478600001)(9686003)(966005)(66556008)(8676002)(64756008)(66946007)(122000001)(86362001)(4326008)(316002)(66446008)(66476007)(76116006)(38070700005)(54906003)(110136005)(71200400001)(33656002)(52536014)(55016003)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmlTcmh0ZEFobnVBb0IvSEZmeXRKN3RsQnAyV3dya2hKeFpGZFB1L2owdGhk?=
 =?utf-8?B?SmdSeGVIOEs0SlVNMVA1cG9iSHpsZm0xWkkzb3MrQWNvQ3NJVnYzcXFWQjJH?=
 =?utf-8?B?T0ZjQXNFQnQ1Mkc1UTdtOXcxYTZhLzVHelFvQVZEZ1lkR3g5RkpRZmIzWk5J?=
 =?utf-8?B?L0E2dDhEVWVxSWkwSkd4dG1CcVc0REJtVWlwSEs2M1RKNUM4T3QwOFlzZHJV?=
 =?utf-8?B?c2tvUTdWblJPYlJqK29EWllld2lRdW5kTlJaSUIwZllqWFM1ak83VWpoOGpE?=
 =?utf-8?B?MDZ6V3U5djhRa3pGUStjcndXdHNXYVY1Z2g4Y2huRE5FN1hFa0FKRzVqMzhZ?=
 =?utf-8?B?akxXR3dLZThldTExZnFGTmJaaUhEenVETjhkZDlVQ3V1dFJmMHllWWc3Vkdi?=
 =?utf-8?B?Q3hub2tIV3I0R2c0UTJLVExLUjd4dHJIMDN0b1dEOWZpYld1bERWOTlTQVlW?=
 =?utf-8?B?WVNzR2x4cGVYcmg2VkpaRVFtMkNhMlhnMW1zV0R5L0d4djdIWnZISzBwWndp?=
 =?utf-8?B?alFVVGRLZGlseDFwS3JYMHR4MzIxeXJGeUpRV3FuSktta0c3Z3oyYXV5T3lj?=
 =?utf-8?B?NnpnZXRJd0dFU0VzNTErM2pPT25jd3NNMDhJR2Y4U0xGY3RZYU9iaUJpMEE0?=
 =?utf-8?B?VEdHNzgwa2ZUM2dUSksxZkxjUGdWdGJtZVFyeUZyVFFmWHZhNUluQmdzaHhq?=
 =?utf-8?B?cWtxV3NoZkdaRlBIRlBjL0w1RXNHcnRpUkpqRWc2WjF2YjZ5aFpycnJrZUts?=
 =?utf-8?B?Qi90MXRuakV5N3NLdkx0andCMnpxdHUvWG9sckZoOWU1SHpjRm9TNU5sUFBV?=
 =?utf-8?B?TzJsdnArdEJySEplYTdTQ1VnMGcyQTB0V1puOS83V3d2VVpSQjNZMG5UMGcz?=
 =?utf-8?B?STJNYUNoQXp1L2ttM2dDeEF6NnVYazhFdG9HTjBiNDBscHVIdkZOTlprK1dB?=
 =?utf-8?B?RjFZRkQwUERoSVlpVjRVaDBVSDE3cnl1RFZzdVdmMkhZVkxMaTFQTXVFWHhx?=
 =?utf-8?B?U3YvL3I2VmlOVmJFVzBNMk1FQnZvekZPUUE4SnM1NVRhUVFkSXZBQWcvd3ZX?=
 =?utf-8?B?ZjZUQXRycGs1NjNMYWtSUnlPOXZlMDQ5TTBJMFY3TXdvbEdxVVdsQjNBK1E2?=
 =?utf-8?B?YnJVZVRYb0ZpcEQwRkFtbkFVWG13anhtQ1ZKdXBZaWFVZ1FaZWFRbjFRT252?=
 =?utf-8?B?elpiRml6clU1Wmd6VkhDSUtzMkJUcXhBKzQzam96cXZHZXJ0WGtSaEhiaHFR?=
 =?utf-8?B?b2VhV3RsQTkyZ3JZUGt5cXpWUUFsL2ZFRFZVZzhpM0JVVzFqc0FGUHRPdkI0?=
 =?utf-8?B?NDZraHdwZjZjanI2cmlFVUhWUkV5Qkp0bDh5dlNKZnNYTGJFZi9iWDFKUWhC?=
 =?utf-8?B?WWtSUm82SzRQMld2ZXVxdENJMGpHRHltNjB2WFZSOExPWEppbkVldzl0WUJm?=
 =?utf-8?B?ME1RcURpdWNKUDI2d29iQ0lya1V4ZjhyYW1YZE5XQktteTRSNUhRQUZuUk80?=
 =?utf-8?B?SjVkS3E3WEtlaDBpV0txbnkrT1dnODViMDlHVGt0a3Y2cURsUm1BRTY4RnBm?=
 =?utf-8?B?TmtQdDZxRFZXd0Yrcjk1eVQ0dmwzb1F2WlhoNmE3U21kUXZBNnFPUU11cnh3?=
 =?utf-8?B?ZmJGbnV6emJFQkd1OGwwT3BXd2VOWUpJRlBKc3hJT2dqdzJYMjQwemJsYmto?=
 =?utf-8?B?Q2hVUklvMHRzZ1cvT0VpYmtaZy82YWw4OXN1dWROb0FtV201c3lWTko4ZWZn?=
 =?utf-8?B?VjROQzUzeVdjZ25mOHlVbU5FZTc4VDM1dGdGcmpQck1adDRpSzJUREdFYk5Q?=
 =?utf-8?B?dWF2SzR1aDNkVGI5SnVURG1aU2gvZU5aTjVYcjFhenNwd1IvUnFJT0JGWW8r?=
 =?utf-8?B?UUdsWnVtZkovY0RYNW5HVEcrSWdUUlRqcWJpTGsvUXd0R2dCK3F4dW5aWlNt?=
 =?utf-8?B?OXM4U3NuWWsxQ2h0emF4NURaRmFmbEtLL1VEWGkwWS9hYjUvM0xLUEtjNVJD?=
 =?utf-8?B?am5vVmt5UGsxY09xeERPby91MWdmRTVzWkp0S1YwR3YvRjhsamFidDdJSEV4?=
 =?utf-8?B?VVJ0SmdYRCtmNnNFWEtqVTVDaHVMbXFOUmF0YVNIcXhQb1dOcGZhaWd1NU92?=
 =?utf-8?Q?RiSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bfa546-dc31-4ce8-6dda-08dae3fdb64b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 09:20:05.0349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVcCpULrwh5Pi37C6/TLhfi1Kf0cCfhgCC4Gn63+XyUn676T8owZoDtqbaraytuAP7Yv8F3gVfHc3dmt3QsJmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMjEsIDIw
MjIgMzoxMCBQTQ0KPiBUbzogUG90dGh1cmksIFNhaSBLcmlzaG5hIDxzYWkua3Jpc2huYS5wb3R0
aHVyaUBhbWQuY29tPjsgQWRyaWFuIEh1bnRlcg0KPiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5z
aW1la0B4aWxpbnguY29tPjsgVWxmIEhhbnNzb24NCj4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gbW1jOiBzZGhjaS1vZi1hcmFzYW46IE92ZXJyaWRlDQo+IFNESENJX1JFVFVOSU5HX1RJ
TUVSX0NPVU5UX01BU0sgb24gWnlucU1QDQo+IA0KPiBPbiAxMi8yMS8yMiAwNjowOSwgUG90dGh1
cmksIFNhaSBLcmlzaG5hIHdyb3RlOg0KPiA+IEhpIE1hcmVrLA0KPiANCj4gSGksDQo+IA0KPiA+
Pj4+DQo+IGh0dHBzOi8vd3d3LnhpbGlueC5jb20vaHRtbGRvY3MvcmVnaXN0ZXJzL3VnMTA4Ny9z
ZGlvX19fcmVnX2NhcGFiaWwNCj4gPj4+PiBpdA0KPiA+Pj4+IGllcy5odG1sIw0KPiA+Pj4+IEFi
c29sdXRlIEFkZHJlc3MgIDB4MDBGRjE2MDA0MCAoU0QwKQ0KPiA+Pj4+IFJlc2V0IFZhbHVlICAg
ICAgIDB4MjgwNzM3RUM2NDgxDQo+ID4+Pj4NCj4gPj4+PiByZWFsbHkgcmVhZHMgMHgyMDA3MzdF
QzY0ODEgLiBUaGUgaW50ZXJlc3RpbmcgcGFydCBpcyB0aGUgdG9wIDMyDQo+ID4+Pj4gYml0cywg
d2hpY2ggYXJlIFNESENJX0NBUEFCSUxJVElFU18xID0gMHgyMDA3LiBUaGUgbWlzc2luZyAweDgw
MCBpcw0KPiA+Pj4+IFNESENJX1JFVFVOSU5HX1RJTUVSX0NPVU5UX01BU0s9MCwgd2hpY2ggbWFr
ZXMgdGhlIFNESENJDQo+IGNvcmUNCj4gPj4gZGlzYWJsZQ0KPiA+Pj4+IHJldHVuaW5nIHRpbWVy
Lg0KPiA+Pj4+DQo+ID4+Pj4gRml4IHRoaXMgdXAgaGVyZSBieSBleHBsaWNpdGx5IHNldHRpbmcg
dHVuaW5nX2NvdW50IHRvIDggYXMgaXQNCj4gPj4+PiBzaG91bGQgYmUsIG90aGVyd2lzZSBhbiBl
TU1DIG1pZ2h0IGZhaWwgaW4gdmFyaW91cyB0aGVybWFsDQo+ID4+Pj4gY29uZGl0aW9ucw0KPiA+
Pj4+DQo+ID4+Pj4gTm90ZSB0aGF0IHRoZSBkaWZmIGlzIGJlc3Qgc2hvd24gd2l0aCAtdyBvcHRp
b24sIHRoaXMgbWFrZXMgaXQNCj4gPj4+PiB2aXNpYmxlIHdoYXQgaGFwcGVuZWQgd2l0aCAhc2Ro
Y2lfYXJhc2FuLT5oYXNfY3FlIGNvbmRpdGlvbmFsLA0KPiA+Pj4+IHdoaWNoIGlzIHBsYWNlZCBi
ZXR3ZWVuIHNkaGNpX3NldHVwX2hvc3QoKSBhbmQgX19zZGhjaV9hZGRfaG9zdCgpDQo+IGNhbGxz
Lg0KPiA+Pj4+IFNpbmNlIHNkaGNpX2FkZF9ob3N0KCkgaXMgYWxzbyBhIHNlcXVlbmNlIG9mIHRo
ZXNlIHR3byBjYWxscyBhbmQNCj4gPj4+PiBob3N0LT50dW5pbmdfY291bnQgbXVzdCBiZSBvdmVy
cmlkZW4gYmVmb3JlIGNhbGxpbmcNCj4gPj4+DQo+ID4+PiBvdmVycmlkZW4gLT4gb3ZlcnJpZGRl
bg0KPiA+Pg0KPiA+PiBGaXhlZA0KPiA+Pg0KPiA+Pj4+IF9fc2RoY2lfYWRkX2hvc3QoKSwgY2Fs
bCB0aGUgdHdvIGNhbGxzIHNlcGFyYXRlbHkgYW5kIGRvIGFsbCB0aGUNCj4gPj4+PiBhZGp1c3Rt
ZW50cyBiZXR3ZWVuIHRoZW0gaW4gZWl0aGVyIGNhc2UuDQo+ID4+Pj4NCj4gPj4+PiBTaWduZWQt
b2ZmLWJ5OiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gPj4+PiAtLS0NCj4gPj4+PiBD
YzogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gPj4+PiBDYzogQWRy
aWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+ID4+Pj4gQ2M6IFVsZiBIYW5z
c29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+Pj4+IENjOiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPj4+PiBUbzogbGludXgtbW1jQHZnZXIua2VybmVsLm9y
Zw0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICAgIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2Fu
LmMgfCA1Nw0KPiA+Pj4+ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4+IC0NCj4g
Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0p
DQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1h
cmFzYW4uYw0KPiA+Pj4+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+
Pj4+IGluZGV4IDM5OTdjYWQxZjc5M2QuLjQ2NTQ5OGYyYTdjMGYgMTAwNjQ0DQo+ID4+Pj4gLS0t
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+Pj4+ICsrKyBiL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4gPj4+PiBAQCAtMTUyMSwzNyArMTUyMSw1
NiBAQCBzdGF0aWMgaW50DQo+ID4+Pj4gc2RoY2lfYXJhc2FuX3JlZ2lzdGVyX3NkY2xrKHN0cnVj
dA0KPiA+PiBzZGhjaV9hcmFzYW5fZGF0YSAqc2RoY2lfYXJhc2FuLA0KPiA+Pj4+ICAgICAgIHJl
dHVybiAwOw0KPiA+Pj4+ICAgIH0NCj4gPj4+Pg0KPiA+Pj4+IC1zdGF0aWMgaW50IHNkaGNpX2Fy
YXNhbl9hZGRfaG9zdChzdHJ1Y3Qgc2RoY2lfYXJhc2FuX2RhdGENCj4gPj4+PiAqc2RoY2lfYXJh
c2FuKQ0KPiA+Pj4+ICtzdGF0aWMgaW50IHNkaGNpX2FyYXNhbl9hZGRfaG9zdChzdHJ1Y3Qgc2Ro
Y2lfYXJhc2FuX2RhdGENCj4gPj4gKnNkaGNpX2FyYXNhbiwNCj4gPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4+Pj4gICAgew0KPiA+Pj4+
ICAgICAgIHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gc2RoY2lfYXJhc2FuLT5ob3N0Ow0KPiA+
Pj4+ICAgICAgIHN0cnVjdCBjcWhjaV9ob3N0ICpjcV9ob3N0Ow0KPiA+Pj4+ICAgICAgIGJvb2wg
ZG1hNjQ7DQo+ID4+Pj4gICAgICAgaW50IHJldDsNCj4gPj4+Pg0KPiA+Pj4+IC0gICAgaWYgKCFz
ZGhjaV9hcmFzYW4tPmhhc19jcWUpDQo+ID4+Pj4gLSAgICAgICAgICAgIHJldHVybiBzZGhjaV9h
ZGRfaG9zdChob3N0KTsNCj4gPj4+PiAtDQo+ID4+Pj4gICAgICAgcmV0ID0gc2RoY2lfc2V0dXBf
aG9zdChob3N0KTsNCj4gPj4+PiAgICAgICBpZiAocmV0KQ0KPiA+Pj4+ICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gPj4+Pg0KPiA+Pj4+IC0gICAgY3FfaG9zdCA9IGRldm1fa3phbGxvYyho
b3N0LT5tbWMtPnBhcmVudCwNCj4gPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6
ZW9mKCpjcV9ob3N0KSwgR0ZQX0tFUk5FTCk7DQo+ID4+Pj4gLSAgICBpZiAoIWNxX2hvc3QpIHsN
Cj4gPj4+PiAtICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsNCj4gPj4+PiAtICAgICAgICAgICAg
Z290byBjbGVhbnVwOw0KPiA+Pj4+IC0gICAgfQ0KPiA+Pj4+ICsgICAgLyoNCj4gPj4+PiArICAg
ICAqIE9uIFhpbGlueCBaeW5xTVAsIHRoZSByZWdfY2FwYWJpbGl0aWVzIChTRElPKSBSZWdpc3Rl
cg0KPiA+Pj4+ICsgICAgICoNCj4gPj4+PiArICAgICAqDQo+ID4+DQo+IGh0dHBzOi8vd3d3Lnhp
bGlueC5jb20vaHRtbGRvY3MvcmVnaXN0ZXJzL3VnMTA4Ny9zZGlvX19fcmVnX2NhcGFiaWxpdGll
cy4NCj4gPj4gaHRtbCMNCj4gPj4+PiArICAgICAqIEFic29sdXRlIEFkZHJlc3MgIDB4MDBGRjE2
MDA0MCAoU0QwKQ0KPiA+Pj4+ICsgICAgICogUmVzZXQgVmFsdWUgICAgICAgMHgyODA3MzdFQzY0
ODENCj4gPj4+PiArICAgICAqDQo+ID4+Pj4gKyAgICAgKiByZWFsbHkgcmVhZHMgMHgyMDA3MzdF
QzY0ODEgLiBUaGUgaW50ZXJlc3RpbmcgcGFydCBpcyB0aGUNCj4gPj4+PiArICAgICAqIHRvcCAz
MiBiaXRzLCB3aGljaCBhcmUgU0RIQ0lfQ0FQQUJJTElUSUVTXzEgPSAweDIwMDcuIFRoZQ0KPiA+
Pj4+ICsgICAgICogbWlzc2luZyAweDgwMCBpcyBTREhDSV9SRVRVTklOR19USU1FUl9DT1VOVF9N
QVNLPTAsDQo+IHdoaWNoDQo+ID4+Pj4gKyAgICAgKiBtYWtlcyB0aGUgU0RIQ0kgY29yZSBkaXNh
YmxlIHJldHVuaW5nIHRpbWVyLg0KPiA+Pj4NCj4gPj4+IEFyZSB5b3UgYXdhcmUgdGhhdCBjYXBz
IGNhbiBiZSBjaGFuZ2VkIGluIERUIHZpYSAic2RoY2ktY2FwcyIgYW5kDQo+ID4+PiAic2RoY2kt
Y2Fwcy1tYXNrIiA/DQo+ID4+DQo+ID4+IE5vLCBJIHdhc24ndCBhd2FyZSBvZiB0aG9zZS4NCj4g
Pj4NCj4gPj4gSXMgdGhhdCB0aGUgcHJlZmVycmVkIGFwcHJvYWNoIHRvIHRoaXMgZml4LCBvdmVy
IGhhbmRsaW5nIGl0IGluIHRoZSBkcml2ZXIgPw0KPiA+Pg0KPiA+PiBJIHRoaW5rIHRoZSBkcml2
ZXItc2lkZSBmaXggd291bGQgYmUgcHJlZmVyYWJsZSwgYmVjYXVzZSBpdCBhbHNvDQo+ID4+IGZp
eGVzIHN5c3RlbXMgd2hpY2ggdXNlIGxlZ2FjeSBEVHMgd2l0aG91dCB0aGUgc2RoY2ktY2FwcyBw
cm9wZXJ0aWVzLA0KPiA+PiB3aGljaCB3b3VsZCBiZSBhbGwgWnlucU1QIHN5c3RlbXMgdGh1cyBm
YXIuDQo+ID4+DQo+ID4+IChhbmQgSSB3b3VsZCBhbHNvIHN0aWxsIHByZWZlciB0byBnZXQgZmVl
ZGJhY2sgZnJvbSBYaWxpbnggb24gd2h5DQo+ID4+IGRvZXMgdGhlIHZhbHVlIHNwZWNpZmllZCBp
biBVRzEwODcgbm90IG1hdGNoIHdoYXQgaXMgcmVhZCBvdXQgb2YgdGhlDQo+ID4+IGhhcmR3YXJl
KQ0KPiA+IFJlc2V0IHZhbHVlIG9mIHRoZSByZXR1bmluZyB0aW1lciBjb3VudCBpcyBzZXQgdG8g
MHgwIHZpYSBaeW5xTVAgRlNCTCwNCj4gPiB3ZSBoYXZlIGFuIEVSUkFUQSBmb3IgdGhlIHNhbWUu
DQo+ID4gaHR0cHM6Ly9zdXBwb3J0LnhpbGlueC5jb20vcy9hcnRpY2xlLzY4NTUwP2xhbmd1YWdl
PWVuX1VTDQo+ID4NCj4gPiBYaWxpbnggcmVjb21tZW5kYXRpb24gaXMgdG8gcHJvZ3JhbSB0aGUg
YXBwcm9wcmlhdGUgdmFsdWUgaW4gdGhlDQo+ID4gcmV0dW5pbmcgdGltZXIgY291bnQgZmllbGQg
YmFzZWQgb24gdGhlIHNwZWNpZmljIHJlcXVpcmVtZW50cyB2aWEgRFQNCj4gcHJvcGVydHkuDQo+
IA0KPiBXaHkgaXMgdGhlIHJldHVuaW5nIHRpbWVyIGRpc2FibGVkIGZvciBIUzIwMCBtb2RlID8N
CkJhc2VkIG9uIGRpc2N1c3Npb25zIHdpdGggdGhlIFhpbGlueCBJUCBkZXNpZ24gdGVhbSwgdGhl
eSB0b2xkIHJldHVuaW5nIGlzDQpub3QgcmVxdWlyZWQgYXMgWGlsaW54IHVzZXMgRExMIGZvciBo
aWdoZXIgZnJlcXVlbmN5IG1vZGVzLg0KU28sIHdlIGRpc2FibGVkIHJldHVuaW5nIGJ5IGRlZmF1
bHQgZXZlbiBpbiBYaWxpbnggbmV4dCBnZW5lcmF0aW9uIHBsYXRmb3Jtcw0KbGlrZSBWZXJzYWwu
DQpFdmVuIGluIG91ciBpbnRlcm5hbCBQVlQgdGVzdGluZyBhbHNvLCB3aXRob3V0IHJldHVuaW5n
IHdlIGRpZG4ndCBzZWUgYW55IGlzc3Vlcy4NCg0KRGlkIHlvdSBmYWNlIGFueSByZWFsIGlzc3Vl
IHdpdGhvdXQgdGhpcyByZS10dW5pbmc/IElmIHllcywgY291bGQgeW91IHBsZWFzZQ0KcHJvdmlk
ZSBzb21lIGRldGFpbHMgYWJvdXQgdGhlIHRlc3QgY2FzZS4NCg0KUmVnYXJkcw0KU2FpIEtyaXNo
bmENCg==
