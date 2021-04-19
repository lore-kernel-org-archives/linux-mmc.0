Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54647C43462
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Apr 2021 12:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207676100A
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Apr 2021 12:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhDSMtZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Apr 2021 08:49:25 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33040 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbhDSMtY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Apr 2021 08:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618836535; x=1650372535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5HQsS3Bruuj6QKYVV3SU9tGJ6t1EXfvOhHXxrOarkqw=;
  b=LYQR2inqG9mPkT3S0zceqUQKnu4WOMmkZrtz7/NarLdOAXQD6w8noE7c
   YqcjajzFwTzibQgf8BZ6SsGzoojcdpdStpuSi8UeQ+L+kWVJMVaDdQyBl
   itSs5N2AAwWBUQFBXg5fa7BdS/ihDkSt4GWEJupTa+BJb1rq49oqhhpTD
   uiPb8ONz+L6rcDm4ofWa5rmZZHIZpoXIb+LkhukH5rl89whOiGfjmViba
   nUj6mS0vxc+/0ncvxHRaKjbkqLsglzzFi7q3xBXKPJmmyNHkQxthfcaz7
   JKJdrlYN5eQniPQ8fKOzudPRLCbYfrS/XrGuqv7kxVOjPxo7MpFl0Y/mc
   w==;
IronPort-SDR: MEtIuguRDxxoT/OznrpGKPSKqdqeAGEv6Mku+SEDZ/ugha9nmj51Q52s7qRGQ3xJuz5ygrwE+J
 hCk1o2kp80Cy9Uf+t2w1QUBvugGl5S/0mlnyorjgaFZ08v4RRchWQ76xp8rI/2nWN9YOQmyJG3
 vcZnHeiPn4yp4X8UE8hix6Jxq7HZ0wxPs3qFsApfCVaL+QFMxPrriJp17GS7HpBXOhlhjzkLuQ
 Kdsdk3snOV2xKDG/Xv0o+hMQgR+TwOrZPv6sdHIzli+tXoZyCp/O8RlmCS+UOcN6mQSNvA0JUu
 Uro=
X-IronPort-AV: E=Sophos;i="5.82,234,1613404800"; 
   d="scan'208";a="165984990"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 20:48:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awW/jMaqY9K6rd2d8wnWR6mTmsMoc0o/NATJ2DXyjNRWzKKZUwFp/eLuGOd29YxTs65wbUjEhWsJJWsvP5Sk8ANBai/C6TuPkgZ+hB6U/tAjvP8k0FvqU1zlb1KHigA7uuypzGJFQw4SLpyJdtX/o6vhMy038GrCytNTYc5YU+gcCmmRtL7T9mcS/axE2M5QrBbhxupKFSZER6laKWy6pfXtXJnzPzRWTKcFSBMb2W5x/UtNQ7gA8QX+UjcsxljoBNr4UMqc+sc5gTNcYA8ymKZ+P7+BTRd1gR1ZItfVasPf9h9O1zrzvJSJratve4o7rwAcL/c+H8W5cKpo8y58MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HQsS3Bruuj6QKYVV3SU9tGJ6t1EXfvOhHXxrOarkqw=;
 b=dTrCkk74aEqCY3QukYPMGh66tlRuflYIoP6J45kTe+ovWcWgrdKQ++uRAKgDValDuEAeJ3cysxo2Muh34xEjIqIGxtDymupdyQdujJdVfHoE72ELQuW4VxYyVg/COWwV/6vEJfpSXrc2YyIMTIiLdzFaIBOHxb0lneP5m4RYo/O9rpeG+3x8YW64z589NJXviYne9f89JvYKSAA18v8kzML5SNcMz7RVGg9EucsR65RjzXWEJ0FOBr6WRHKnpz4p3W+Ghrq49crxqGhZLHBfI+gLUzodsL/GIDGH8GtjeJWew/4f6SmP8VtyboYHZer4Is3DJHN7/IlsH15XdC7ufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HQsS3Bruuj6QKYVV3SU9tGJ6t1EXfvOhHXxrOarkqw=;
 b=dxGadT1r6caRziu+T4Y6a0TOsJG469SlBIyRa2rP7qv0c06ewcZuk2nW0idRkeP2VIWyixuqOwB2eMZngVzcnMlSS6sKHnG6aopqqEchBKPhTuD0+d2QRMOEZ93+Dspgrm3ISSLUtVLf0nKKE+r6Bc0Hj1GMAwW63m9Z0s5MpkY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5081.namprd04.prod.outlook.com (2603:10b6:5:fe::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21; Mon, 19 Apr 2021 12:48:53 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 12:48:53 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Peter <bpeter@lytx.com>
Subject: RE: [PATCH v2 1/2] mmc: block: Issue flush only if allowed
Thread-Topic: [PATCH v2 1/2] mmc: block: Issue flush only if allowed
Thread-Index: AQHXNBgiJh9AhyzBkUSbB86oYQKMUKq7ycoAgAACEtA=
Date:   Mon, 19 Apr 2021 12:48:52 +0000
Message-ID: <DM6PR04MB657548286A24A6B033694691FC499@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210418055953.26959-1-avri.altman@wdc.com>
 <20210418055953.26959-2-avri.altman@wdc.com>
 <CAPDyKFqAdXcVO9=26pTbQyzYprax9-_i0T1XMeXTWAYOMAaovw@mail.gmail.com>
In-Reply-To: <CAPDyKFqAdXcVO9=26pTbQyzYprax9-_i0T1XMeXTWAYOMAaovw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90dd1f80-6589-4d2f-bbbd-08d903317cbc
x-ms-traffictypediagnostic: DM6PR04MB5081:
x-microsoft-antispam-prvs: <DM6PR04MB5081577836A41D4ABEAC0B2FFC499@DM6PR04MB5081.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2waibXOqGGOLUAGWqoqrMDDWB4xUICPycwgKmiQxwrom394gfijLdp3SxUr1N8U1Jxn4ATeK/BuOL1ECkfeKZsp6FkmEEtA1Vg3Wjrc0oZ7e30btrXKPM+tbHGm50J34sVS2a/ydbU7Ct3End7a0RgZfqS4ydegDpf1q/YkUj6V9/VYDHdOu3qoz8Acbp5Xmm8rxXMRezsVGerVLwSjRDiHGiUlAQ9efyXgfu7vzeymV1bNVA6nA4ZXQGI91HtM3B3DesRhGRmg6JVo0m+OKAyOI52ve0B2k7Y+4VRpK4q6Em3PS8S6Dcwxur5Ryl5NMjWYali1bPUmmIV9b+xv91SAq8UAfXAbYSa2bNxNVmZGbfGD73OCXwvLhONDM0XTe4jxBAj8hCEEAPY9ON9mA1B0+MThtpAzwz01VGEw61TqdPdAVCrHUgF6PvhBd6YIUfK+i8GNFhSS/XG5roB5Rua2lWaeYnoZk2OM+XiHVLqXMIzQ9+IHVtWwIPYrHEDhyUHbWo6mD0EYt3LUpI66lLx5OqDNGOQVEVnO4hUGs8S4wWZgjaQ7IU7d1gT9RZsMJliP+Mau2DcFIahjSBxe9obCyyzkrfb9y6iomEzyPNp7Wsey0vA8ujH6X9aRk0g2jjtaiIiOCGjU+9H/pYczBLoP7GX2heHJuAkg0A4oVzC/9ie7QJJem+kCuCpO2BdMW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(4326008)(33656002)(6916009)(5660300002)(71200400001)(26005)(9686003)(55016002)(7696005)(66476007)(186003)(66556008)(66446008)(64756008)(4744005)(2906002)(8936002)(966005)(54906003)(86362001)(122000001)(316002)(38100700002)(52536014)(8676002)(66946007)(478600001)(76116006)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZmRWdzFjb1p5ME4zMWZRc25LYUxsa1VBM0hLNXlLTkFwY1RuVlFtOERFNVcx?=
 =?utf-8?B?QUc0ekIyNW1vQTdMS29XVmVha2JBRFZQRHJiOWkvM2hnQ09UR3A2SzhZNFNr?=
 =?utf-8?B?cG5JbVFCODlJVndZbW5BVjkxYkduWEtIenZ6OHZHMjlBRm5ob3RVb2p3dFlx?=
 =?utf-8?B?Qm1xSkhPMW4xTFNlVVhRM2s0Y1JLTXJCS1VIYlppWWRmQjVVdmZPSVFpOUkw?=
 =?utf-8?B?R3ZpazhFMkoxdTBmcU5XenlOQTByUjh2QzFWWFJqU3RLSFQ2eVQydTB1RGJo?=
 =?utf-8?B?b1VmS2pnY1VvMDBYak9ZRmEva2J6blBYQWZXNkd5eEwrbTlLdHh0TStUOVc5?=
 =?utf-8?B?RXh2WDAybmp0dFR0V0tsdm9JZUVYYmV3NVV1V2FhNjZxeFl1R3JLUnlwRUtC?=
 =?utf-8?B?TDJST2JmaGVkZHBqOGtDMnJ5djdGZFcyTlF5Q1RLaERjdTl4YkpBanZhSmlk?=
 =?utf-8?B?bFJIdkFaR2t3bmxRMDhML3FJYUlNNDBzbXlBRDBqR09qdXdKUWk3UndoYXVt?=
 =?utf-8?B?UW5hZXpvR0N6VFZvVHphbENaZDczWjJidVhOUFdrVFFZOG8wQjREM0pZWjlE?=
 =?utf-8?B?U1JTbk9QMVFiZ0srQW9BY3B3N2lDcWpreVF4NUtCdXUwVk5MT3dwNDZLT3JE?=
 =?utf-8?B?V2xzdmJHaXZRMFBNMlVZOUhnUDV6WEFpWmRURzdOK3NJTThnQ2tMRkJ3WE9Z?=
 =?utf-8?B?NnZYUm92WFlBS1RXYjBFeC9IKy9aQk5vVHJYdWUyQndib2R2RjVlWEE5MTNz?=
 =?utf-8?B?eE8rK2hZeEdDVE5yb0pOaW55QkRWVHhsOGpySG14YjZOWmtXSG1aNjU0RGdp?=
 =?utf-8?B?VkQvbUsvTEd2bWZVSnZObnB3Q2tLRkdJeVJDcVhzWVlVMWZmZ1pMUjZ5bmVC?=
 =?utf-8?B?bFFRSFkxTmFZNkpDV3BvL0tpdDZkeVU1dWhEcUFnV0x3RGFCdmVVc3NDUmNZ?=
 =?utf-8?B?c3htWjZRclk0bVJ1WUVmckNyOFhnelRIMHJVRS91QVRrTGV4WklnYUJiemF5?=
 =?utf-8?B?M3IrUW1DZ2dsYjI1N2N3L3haYVRDNjZHNUpvOEdRY3BJT3ZEaFRjT2lWUmhQ?=
 =?utf-8?B?S2ZGRjVFVFlwUnBocVdUNkVJa0pFMzJNbXVMWldqN21xK0hrVkpCTldhdWY1?=
 =?utf-8?B?cTBLU3JQdjFTMUxWajBwQkZxd1NEREpEVEMrWGh2WVNLWFh2UExZZFByU1pz?=
 =?utf-8?B?QjRoN2k5R01KbjFHUFNJOGY0QWFNOW5wMGNDVjVyUmNESGErVThWci9QK1JL?=
 =?utf-8?B?STdtamk0aXp1aGJMc0N4SWNmdFZoNWR2Q0NKMlIzMlpDa0hUV3NOWkRPTHZQ?=
 =?utf-8?B?Skd6bU5vN3BYdzhBS241a2dLWmZ0bFoxWlg2QUNyeVlXc3JuRzJwS0xXeFUx?=
 =?utf-8?B?QjRscWhUWXhUWjExdHBuMmpESG9TTTFzd3VQUVlnamgzdkQyaE5iWnozRmZt?=
 =?utf-8?B?ZExMeUhaaytQV1NXVXBja3lJems0ZmZnNEF5ZEJDUkNocTN2VE9aNkswVG1m?=
 =?utf-8?B?OE1IbVJpRzVvUEYzUlk4TDFQUnZ6QjdPUjBoVE9ja2t4c0dXZW44OFpJc1pz?=
 =?utf-8?B?M1VvTjFLdGVyZUJ0ZTFWOHVoZFZsTzQzRFRLOEpsNlJMZm1lbkpkVE8xQkY5?=
 =?utf-8?B?WWdCTHJ0T25kVmNPUjRzaDF3N0QzME1rMWhhOEc2Z21Ia0p4bDJERUxJOHBX?=
 =?utf-8?B?cllhbXlybkVnN0M1ek5GUFp1VXBMVkhYRHgwTklHS2lOUWhzbjdzVkQ0WnRm?=
 =?utf-8?Q?7dwrigSqy7yp2rPzu2kpV0S7lja0PLKiSkyDmNE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dd1f80-6589-4d2f-bbbd-08d903317cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 12:48:52.9137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GE+J68Dd03xQViDgofxbpdfkcM2LqAuMB76s0I8O3FotbQg6HZkaLnVN5Yeq9U7DJgo0hmujEiQV2B9leT9M6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5081
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiANCj4gT24gU3VuLCAxOCBBcHIgMjAyMSBhdCAwODowMCwgQXZyaSBBbHRtYW4gPGF2cmkuYWx0
bWFuQHdkYy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIGNhY2hlIG1heSBiZSBmbHVzaGVkIHRv
IHRoZSBub252b2xhdGlsZSBzdG9yYWdlIGJ5IHdyaXRpbmcgdG8NCj4gPiBGTFVTSF9DQUNIRSBi
eXRlIChFWFRfQ1NEIGJ5dGUgWzMyXSkuIFdoZW4gaW4gY29tbWFuZCBxdWV1ZWluZyBtb2RlLA0K
PiB0aGUNCj4gPiBjYWNoZSBtYXkgYmUgZmx1c2hlZCBieSBpc3N1aW5nIGEgQ01EUV9UQVNLXyBE
RVZfTUdNVCAoQ01ENDgpIHdpdGggYQ0KPiA+IEZMVVNIX0NBQ0hFIG9wLWNvZGUuICBFaXRoZXIg
d2F5LCB2ZXJpZnkgdGhhdCBUaGUgY2FjaGUgZnVuY3Rpb24gaXMNCj4gPiB0dXJuZWQgT04gYmVm
b3JlIGRvaW5nIHNvLg0KPiANCj4gQXZyaSwgdGhhbmtzIGZvciB5b3VyIHBhdGNoLiBPdmVyYWxs
IHRoaXMgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IEhvd2V2ZXIgdGhpbmdzIGFyZSBiZWNvbWlu
ZyBtb3JlIGFuZCBtb3JlIG1lc3N5IGluIHRoZXNlIGxheWVycyBvZiB0aGUNCj4gbW1jIGNvcmUu
IEluIHBhcnRpY3VsYXIsIEkgd291bGQgbGlrZSB1cyB0byB0YWtlIGFkdmFudGFnZSBvZiB0aGUN
Cj4gYnVzX29wcyBjYWxsYmFja3MsIHdoZW4gZU1NQyBhbmQvb3IgU0Qgc3BlY2lmaWMgZmVhdHVy
ZXMgbmVlZA0KPiBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb25zLg0KPiANCj4gSSBoYXZlIHBvc3Rl
ZCBhIHBhdGNoIFsxXSwgdGhhdCBtb3ZlcyB0aGUgZU1NQyBjYWNoZSBmbHVzaGluZyBpbnRvIGEN
Cj4gYnVzX29wcyBjYWxsYmFjay4gV291bGQgeW91IG1pbmQgcmViYXNpbmcgdGhpcyBzZXJpZXMg
b24gdG9wIG9mIHRoYXQ/DQpTdXJlLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IEtpbmQgcmVn
YXJkcw0KPiBVZmZlDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
cm9qZWN0L2xpbnV4LQ0KPiBtbWMvcGF0Y2gvMjAyMTA0MTkxMjI5NDMuNjgyMzQtMS11bGYuaGFu
c3NvbkBsaW5hcm8ub3JnLw0KDQo=
