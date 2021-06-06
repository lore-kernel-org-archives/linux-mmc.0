Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C8C47096
	for <linux-mmc@archiver.kernel.org>; Sun,  6 Jun 2021 06:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D30613DF
	for <linux-mmc@archiver.kernel.org>; Sun,  6 Jun 2021 06:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFFGEN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 6 Jun 2021 02:04:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61916 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFGEM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Jun 2021 02:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622959343; x=1654495343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RPcUPvi+BR+7kJMs+y+a997NwrdmklLZDtKMy3gqkvs=;
  b=TYkYcURKUlfAs1l7SGS5s+zmu1Yzq5MCkM7Z2VjJnbIYp80kervHYn6S
   pKmg1Uq9ZotAXRSfsaRk9vuBuyrNGYT9VF6UVC5UC8Y1MWxXsS4YdqDWX
   nJRnh+x1wta8/tc8Yli3XdSTT0YC1ZxPzDmi+uXcHS63+ynrkHhnm4bDN
   /jyCPH+ytsdK6a+5FRv2ucmY7C2kMxnb3fJQNXXxfjn7nWbCBa4vKPTOH
   cRjpg8PkMxegOCGUu6w106BpfaraVcfOWGE2etW2n/pMxh0t7j/x2TmVA
   bpWOEvApehv/rGhwG/XkzjsWFP+QsEuojzTGecxQioL+vkxHE79IrTk2Z
   g==;
IronPort-SDR: cumlb/aehMRxLRkcxNbeMYP0ZCdy+z+A2fFtoUhGID+tCEVBj0IKf7DVbL0pnQqEb5ttem1Psk
 vrbCUjYbw8bSfVh0FZ+yOg4gYBsgPOcoxqUnQba7mbJqnjAmAXxAI9lytgoO4bZtcrarNe96RF
 8t9BRRI/ttXgh23uHLhjG5xvZPX3Iz/rYNNrAWUSvUpjbhCr9iBJsI247FqvQTUCHZPoaQhUPh
 Lt6jR78uo39+ksJvHBNU+/heRaqN1GOHctDYXitghYCU48qPdGNJWPShQESew/vmd5S3xyMNB0
 wog=
X-IronPort-AV: E=Sophos;i="5.83,252,1616428800"; 
   d="scan'208";a="175673270"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2021 14:02:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh1AMYXDks72X9xtBBHWBu6YaiuvJkDol7tJsQZ3zkyCECnqSufkRChyeFUkf4w0j+e+HK0ovLU28gmxlK5A4KXNiftWpkorterG5NZpq1rD88+ng99MpITmPEXTh8z6OrcTrhcQwgEUsG2SvSW6TEz87Uoim1MlhXlsfC0sQutGVa6U4fDqbdytqmb3n2Vp6cfbSDPHpQ+LC8EBfivHKBPxvWSKWzYk0eD7tFUtSE1ehsjIDqGhA2AG8dKNECEwCKgsV9ja5bYskwrKLj+Jg4sPSJvLCjCcCTSZT71iXswmxMxuTP7FEF9BPW/noDqasUP8ktsTQgpoM26SbieVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPcUPvi+BR+7kJMs+y+a997NwrdmklLZDtKMy3gqkvs=;
 b=objUwKrGSr20bTKPtf5z2z8sImJRo9dwQQFlwqNQftKaT+DxXXvefJvkG+3kmx+130tSSaelcEX/B5ciWCro0P0YNOvX5uArzeMPKKwEjOa0FfwQujHolcjDEmQeMcMh2Aluv5hhPrdHQ7mSA7sLuEFm39KY1lNYfAF2sF84LWvvSF2pgtBu/VEN7jErxb/csoxTfe7NPl5v3zdd/IbdRD5wNHvZfuHwMMminbiYujEz8hqmGEi3EJ8XGDF2JO1mOcOavKuKGiRT+n/OP0k1qaZL6l3bziImfmd0waso6tZ1IY7/KTlB3xsItl0tNG4sTTnFzHJRrG0gKwvcTJ0E5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPcUPvi+BR+7kJMs+y+a997NwrdmklLZDtKMy3gqkvs=;
 b=jwTIBCAnP5884LEBKV9YmA5Bkw5boVig+1Rv1eWWERCuQZGYkP6WUftS2PoRRDc4UuYzwfYk0M8o5yT2ZGQmyuuqYNHGb9wQH/EleRfIYLAptLvCwaIyHbhp2FuFQMa6xT9W1SKfMZ51q2OjLcxjflolRvWIUWMsKdkdt2NBns8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR04MB1098.namprd04.prod.outlook.com (2603:10b6:4:45::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Sun, 6 Jun 2021 06:02:22 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::78af:772c:a69a:95a0]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::78af:772c:a69a:95a0%7]) with mapi id 15.20.4195.029; Sun, 6 Jun 2021
 06:02:22 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: RE: Who assigns SDIO vendor IDs?
Thread-Topic: Who assigns SDIO vendor IDs?
Thread-Index: AQHXWaAGytu/AXdw9kOkuTlH+8AjPKsGf44Q
Date:   Sun, 6 Jun 2021 06:02:22 +0000
Message-ID: <DM6PR04MB657522F2F6C3F0612C8A32B5FC399@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210514171233.qerhkjn3redivien@pali>
 <20210528002111.wei44qtoptgj6mlo@pali>
 <CAPDyKFoBaSFSrFFPkYaChcAGHBnxpe=74TbKNqNH6_sh=47ooQ@mail.gmail.com>
 <20210605001621.n3krry7qjhiieb6j@pali>
In-Reply-To: <20210605001621.n3krry7qjhiieb6j@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88b9e819-4307-4e0c-8d5d-08d928b0a68b
x-ms-traffictypediagnostic: DM5PR04MB1098:
x-microsoft-antispam-prvs: <DM5PR04MB109809996AD347F5FBEC63E5FC399@DM5PR04MB1098.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RdTYf+8S7wcZpVIygucVwPYCYH5BQEoCirusIhTY56Ot4XUsyXxo8/uftzVvSt6ClsLDL7AJqCAmNyc9aIiD1iR2JqcRDcu0ypZDvKA0OiR6fS4yfgSidInkL/0LUXqWumIGIYW/iUfttcpMNoA78nWu7LV12ndeDWJVjsy0qN4db5soCfuX3rEubfnzf0OrlsrEbIM3fZs8QHqeoPhpLLvWiJ8U1AcTShQ0hQ9WYnGdHE9VS2UOJoM3KCpTKoQhTisMYizamIkHkWcxo405GCXiRYqm/8h0UD+NiRuMJfKPW+nFmjjrw5LQJz3GZTLmLU4opAwdLMg2+4tejlVnfb0DH6kZ1+ZlFVM2ha/IoKvFu1skFptUgVT1jntlXgaKNczCkg/kkb1TeauZhHsae9uQso1u17V2aBhTCq5qjrWn0tbyq5H1PeYtp4cTsZDIBt9dWksQaggeGbj3ZqDDrNM27cb6eFk+tzy8xvJ2JMNhVu2XSi/N/o/jUgbHW7Dy2Q0XoJ2FNL/o1ewH15GuAPc/8A+SAj6mMEWCQPNQs0/idPjewJJ+9GIq7Ao7tGxDGCDAzY0EFd9ch3ej6QQHbNReJzRnjIf/nrcSC5zvY/0yn0FKk4CSRfPOFvDAlBgI4jZk7do5lNkHL7KMPRNdLnvBR90+BZYFH0S0szCiolp06xDtVdWnuSF6I6uXBcOwPZjW7TOZb0HpO1bC8dxZmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(376002)(366004)(346002)(15974865002)(71200400001)(122000001)(38100700002)(966005)(478600001)(7696005)(52536014)(2906002)(5660300002)(110136005)(8676002)(4326008)(8936002)(9686003)(66946007)(66556008)(66446008)(66476007)(64756008)(55016002)(83380400001)(66574015)(26005)(186003)(86362001)(33656002)(76116006)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bnNYQTUrQkxKV29SYS9mZE90RkVMVExOL1BEeW82U24rc2JSaC94S3FUaDRs?=
 =?utf-8?B?NU9iNmlIQU9xdXU0RmRGQi9MUGplS2ZFbHlsQnhOSHk2TFN1c2ZUeHhuYnE3?=
 =?utf-8?B?ckpUUDB5bUFYRmhoMkY0aHpkb2t4VUx4aG1oZVZTVjVuSjgyVlFiQ0FxeVJ4?=
 =?utf-8?B?NmFHZmJlU242M1lEZ2M0ZmhKWlp2ejh3a0FUc3IxS1dvTnlLZTZtWHQzTkZp?=
 =?utf-8?B?MTU5QjhmYXgyUzBvMi9LV1A0akdLK2VPYUJ1WFdGRFpIdjBjcDh6bzRnZzIz?=
 =?utf-8?B?bEZwcmlaYzBDdjdXU0xLaU5oY0dVSFhMUE5WZzVIekRPbElBVm1COTBFQkJN?=
 =?utf-8?B?NlVocGhuY0tUclZub05vTDVWNDZsanpQZ3JOMVljamkvTXZSUlZxeExLVHBE?=
 =?utf-8?B?dk0rUDRGakFLaVZwNWVlNXhTQk84RlRVRjRLMW1DenREMnh4bDNIQnU5RzRL?=
 =?utf-8?B?ZkxvMTlXQVJNS0s2cHhXMWJTaHNvQXR0UjBkU3U0UkJHbjhkK05uOFFRWW9D?=
 =?utf-8?B?T3l6MUNWZzRXeDBFWERIQ3Via3N6WG9GWC9kdzduVCtDZTc0YkFtZmEwdWlH?=
 =?utf-8?B?YVQ2NjZVUGhVR0tFOE1MSHZtbXlxaWxMbzYrdml6b0w2SThmQ3o1bnZEeGor?=
 =?utf-8?B?cWVpNjMwM1dhc1dEaHl0U3plQTIzZlYweHlqQXpHK2M0L3UyaVdUMERRVEZ6?=
 =?utf-8?B?VWN1UVR1K3c3bmhjaVdnYnNlREx3YW5pcDU1bDNZcU82Njlob21jQUFPQWNo?=
 =?utf-8?B?cDI1cFFSS29IV01aWXAzYWM3VVB1amV6QkNZc2N5NnQyOFVmR1l6aTF1aFZ3?=
 =?utf-8?B?YnlaczZRMHRvQXVQSGpYdWxjakhaczllNEkvSWJidkhORFcxdVBWdGZVUUlm?=
 =?utf-8?B?Mkc4MDVjaElXb2JDNzZrMjN5aFEwNDdyUjFpdHh3MjluWlQrUmVPcUNlajg4?=
 =?utf-8?B?cXJOVG1CbC9wT3U4UitNZ3BWS2l6ZlZnOHdKRTNxbXFPN3NMbFMwQ3o1R3Mr?=
 =?utf-8?B?OFRISm9hbXVhb1lLVVBXM1VHVnlzQ25FWWQwaWJrWWl5SGh3dk9WQkJBUFha?=
 =?utf-8?B?ZjViT0Npc0NDTGJ1RUN6SjNDZlF6em5lQmNtTVZNZXJ5UTUxaW9DSXdYOXpI?=
 =?utf-8?B?VEo2OTlXVVovekdOaXYwMStXQ1NYbUN5U3JaaUl6VEZJUTFGNWhVOVcvR2VS?=
 =?utf-8?B?aWtaNk5peFplbitnZ1ZrNEVRWWVRWS9ZTWNmdnl2MlZBaXpCNi91TmZOeHRK?=
 =?utf-8?B?WGpXdGdRYVgxbGhFRStETHdKTWxKSHhQb1I4eWVEYU5zRTZhbzlRT1pBSDlC?=
 =?utf-8?B?M1Z4ZktFQWF5Y2h6YXZwY1ZJUDVQMHAzbkthYzYxSHYwZjVKeHdad0JTOFdy?=
 =?utf-8?B?SVphamY4Sy92NU4vT2FOSU5pOGZabDliUi80WG84RndZdncxR1dEMHUwRFV1?=
 =?utf-8?B?RmpDaEorc09ya2QyZkhaejVKbEFJN1dBRm13WDBwMmsrQXdtUnVYQWhCMmlM?=
 =?utf-8?B?Y1N2dnVLN01rczBLY000OVVFcGl5WjlrMDNHR2Q4QUNGNURFODFXd3h3bDhK?=
 =?utf-8?B?Ky84TWxNak5zQmJVdHlVdmRoa2plcnRmMG9scUZmT2Uvd3hXejVXUzRxTEJa?=
 =?utf-8?B?U1FzRU8rN1ljSVRZQ01sRWZjZGZnbGhaUUxQOWo1VzFpaFRseFRaU3hJRE5k?=
 =?utf-8?B?QWNiaXlEWnEvNVpQUjgwaVdnK256cFN5ZVNnTW5XR3I3dTlHR1Rpd05RSTBs?=
 =?utf-8?Q?7S2n5Ie4KQx15k1vlPh1Eoc9p8qNTNUu3DgfBj6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b9e819-4307-4e0c-8d5d-08d928b0a68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2021 06:02:22.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPU6lruBul9pEmuVAwLCKC3kACskqO9DTSwRkjdIHhLfV970bxAFYWRgqUagoXKJ0Fgvze05KRQu/rDLrlqO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1098
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBPbiBGcmlkYXkgMjggTWF5IDIwMjEgMTA6MTk6MzUgVWxmIEhhbnNzb24gd3JvdGU6DQo+ID4g
T24gRnJpLCAyOCBNYXkgMjAyMSBhdCAwMjoyMSwgUGFsaSBSb2jDoXIgPHBhbGlAa2VybmVsLm9y
Zz4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSGVsbG8gVWxmISBEbyB5b3Uga25vdyBzb21ldGhpbmcg
YWJvdXQgU0RJTyB2ZW5kb3IgSUQgYXNzaWdubWVudD8NCj4gPg0KPiA+IEkgYW0gc29ycnksIGJ1
dCBJIGRvbid0IGtub3cuDQo+ID4NCj4gPiBJZiB5b3UgaGF2ZSBhIGNvbnRhY3QgYXQgdGhlIFNE
IEFzc29jaWF0aW9uIChzZGNhcmQub3JnKSwgSSB3b3VsZA0KPiA+IHN0YXJ0IHRvIGFzayB0aGVy
ZSB0byBzZWUgaWYgdGhhdCBjYW4gYmUgYSB3YXkgZm9yd2FyZC4NCj4gDQo+IEkgZG8gbm90IGhh
dmUgYW55IGNvbnRhY3QgaGVyZS4NCj4gDQo+IFNvIEkgdGhvdWdodCB0aGF0IG9uIGxpbnV4IG1t
YyBtYWlsaW5nIGxpc3QgY2FuIGJlIHNvbWVib2R5IHdobyBrbm93cw0KPiBzb21ldGhpbmcgYWJv
dXQgaXQuLi4NCj4gDQo+ID4gSSBoYXZlIGxvb3BlZCBpbiBBdnJpIGFzIHdlbGwsIG1heSBoZSBj
YW4gaGVscCBpbiBzb21lIHdheS4NCkkgd2lsbCBhc2sgYXJvdW5kLg0KDQpUaGFua3MsDQpBdnJp
DQoNCj4gPg0KPiA+IEtpbmQgcmVnYXJkcw0KPiA+IFVmZmUNCj4gPg0KPiA+ID4NCj4gPiA+IE9u
IEZyaWRheSAxNCBNYXkgMjAyMSAxOToxMjozMyBQYWxpIFJvaMOhciB3cm90ZToNCj4gPiA+ID4g
SGVsbG8hDQo+ID4gPiA+DQo+ID4gPiA+IEkgd291bGQgbGlrZSB0byBhc2sgaWYgc29tZWJvZHkg
a25vd3Mgd2hvIGFzc2lnbnMgU0RJTyB2ZW5kb3IgSURzPw0KPiA+ID4gPg0KPiA+ID4gPiBJbiBT
RElPIFNpbXBsaWZpZWQgU3BlY2lmaWNhdGlvbiBWZXJzaW9uIDMuMDAgYXZhaWxhYmxlIGZyb20g
d2Vic2l0ZQ0KPiA+ID4gPiBodHRwczovL3d3dy5zZGNhcmQub3JnL2Rvd25sb2Fkcy9wbHMvIGlu
IHNlY3Rpb24gMTYuNg0KPiBDSVNUUExfTUFORklEIGlzOg0KPiA+ID4gPg0KPiA+ID4gPiAgIFRo
ZSBUUExNSURfTUFORiBmaWVsZCBpZGVudGlmaWVzIHRoZSBTRElPIENhcmQncyBtYW51ZmFjdHVy
ZXIuIE5ldw0KPiA+ID4gPiAgIGNvZGVzIGFyZSBhc3NpZ25lZCBieSBib3RoIFBDTUNJQSBhbmQg
SkVJREEuIFRoZSBmaXJzdCAyNTYgaWRlbnRpZmllcnMNCj4gPiA+ID4gICAoMDAwMGggdGhyb3Vn
aCAwMEZGaCkgYXJlIHJlc2VydmVkIGZvciBtYW51ZmFjdHVyZXJzIHdobyBoYXZlDQo+IEpFREVD
DQo+ID4gPiA+ICAgSURzIGFzc2lnbmVkIGJ5IEpFREVDIFB1YmxpY2F0aW9uIDEwNi4gTWFudWZh
Y3R1cmVycyB3aXRoIEpFREVDIElEcw0KPiA+ID4gPiAgIG1heSB1c2UgdGhlaXIgZWlnaHQtYml0
IEpFREVDIG1hbnVmYWN0dXJlciBjb2RlIGFzIHRoZSBsZWFzdA0KPiA+ID4gPiAgIHNpZ25pZmlj
YW50IGVpZ2h0IGJpdHMgb2YgdGhlaXIgU0RJTyBDYXJkIG1hbnVmYWN0dXJlciBjb2RlLiBJbiB0
aGlzDQo+ID4gPiA+ICAgY2FzZSwgdGhlIG1vc3Qgc2lnbmlmaWNhbnQgZWlnaHQgYml0cyBzaGFs
bCBiZSB6ZXJvICgwKS4gIEZvciBleGFtcGxlLA0KPiA+ID4gPiAgIGlmIGEgSkVERUMgbWFudWZh
Y3R1cmVyIGNvZGUgaXMgODloLCB0aGVpciBTRElPIENhcmQgbWFudWZhY3R1cmVyDQo+IGNvZGUN
Cj4gPiA+ID4gICBpcyAwMDg5aC4gSWYgYSBTRElPIGNhcmQgbWFudWZhY3R1cmVyIGRvZXMgbm90
IGN1cnJlbnRseSBoYXZlIGENCj4gPiA+ID4gICBUUExNSURfTUFORiBhc3NpZ25lZCwgb25lIGNh
biBiZSBvYnRhaW5lZCBhdCBsaXR0bGUgb3Igbm8gY29zdCBmcm9tDQo+ID4gPiA+ICAgdGhlIFBD
TUNJQS4NCj4gPiA+ID4NCj4gPiA+ID4gU28gSURzIDB4MDAwMCAtIDB4MDBGRiBhcmUgYXNzaWdu
ZWQgYnkgSkVERUMgMTA2IGFuZCBiZWNhdXNlIEpFREVDDQo+IDEwNg0KPiA+ID4gPiBjb250YWlu
cyBvbmUgcGFyaXR5IGJpdCwgaXQgbWVhbnMgdGhhdCBvbmx5IDEyOC1yZXNlcnZlZCBJRHMgYXJl
DQo+ID4gPiA+IGF2YWlsYWJsZSBmb3IgU0RJTyB2ZW5kb3IgaWRzIGFuZCB0aGV5IHdlcmUgYWxy
ZWFkeSBhc3NpZ25lZC4gVGhpcyBpcw0KPiA+ID4gPiBiYXNpY2FsbHkgY2xlYXIgYW5kIGxpc3Qg
b2YgdGhlc2UgKGlkLCB2ZW5kb3IpIHR1cGxlcyBjYW4gYmUgZmluZCBpbg0KPiA+ID4gPiBKRURF
QyAxMDYgcHVibGljYXRpb24uDQo+ID4gPiA+DQo+ID4gPiA+IEJ1dCB3aG8gYXNzaWducyByZW1h
aW5pbmcgU0RJTyB2ZW5kb3IgSURzIDB4MDEwMCAtIDB4RkZGRj8gUENNQ0lBDQo+ID4gPiA+IHdl
YnNpdGUgaHR0cDovL3d3dy5wY21jaWEub3JnLyBpcyBhbHJlYWR5IGRvd24gYW5kIGFjY29yZGlu
ZyB0bw0KPiBVU0ItSUYNCj4gPiA+ID4gcHJlc3MgaW5mb3JtYXRpb24gZm91bmQgaW4gZG9jdW1l
bnQgVVNCX0lGXzAxMjEyMDEwLnBkZiBmcm9tDQo+IGFyY2hpdmUNCj4gPiA+ID4NCj4gaHR0cHM6
Ly93ZWIuYXJjaGl2ZS5vcmcvd2ViLzIwMTYwMzA0MTIxOTM4aWZfL2h0dHA6Ly93d3cudXNiLm9y
Zy9wcmVzDQo+IHMvVVNCX0lGXzAxMjEyMDEwLnBkZg0KPiA+ID4gPiBVU0ItSUYgYWNxdWlyZWQg
UENNQ0lBIGFzc2V0cyB3aGljaCBwcm9iYWJseSBtZWFucyBhbHNvIGFzc2lnbmluZw0KPiBQQ01D
SUENCj4gPiA+ID4gdmVuZG9yIElEcy4NCj4gPiA+ID4NCj4gPiA+ID4gSW4gYXJjaGl2ZSBvZiB3
d3cucGNtY2lhLm9yZyBpcyBhdmFpbGFibGUgdmVyeSBvbGQgbGlzdCBvZiB2ZW5kb3IgSURzOg0K
PiA+ID4gPg0KPiBodHRwczovL3dlYi5hcmNoaXZlLm9yZy93ZWIvMjAwNTEyMDIxMDQxNDEvaHR0
cDovL3d3dy5wY21jaWEub3JnL3R1cGwNCj4gZWlkLmh0bQ0KPiA+ID4gPg0KPiA+ID4gPiBJIGhh
dmUgdHJpZWQgdG8gZmluZCBzb21lIGluZm9ybWF0aW9uIGFib3V0IFBDTUNJQSBvciBTRElPIHZl
bmRvcnMNCj4gYW5kDQo+ID4gPiA+IElEcyBhc3NpZ25tZW50IG9uIFVTQi1JRiB3ZWJzaXRlIGh0
dHBzOi8vd3d3LnVzYi5vcmcvIGJ1dCB0aGVyZSBpcw0KPiA+ID4gPiBhYnNvbHV0ZWx5IG5vdGhp
bmcuDQo+ID4gPiA+DQo+ID4gPiA+IFNvIGhhcyBzb21lYm9keSBhbnkgY2x1ZSB3aGF0IGhhcHBl
bmVkIHdpdGggUENNQ0lBIGFuZCBpdHMgcmVsYXRpb24NCj4gd2l0aA0KPiA+ID4gPiBTRElPIHZl
bmRvciBJRHM/DQo=
