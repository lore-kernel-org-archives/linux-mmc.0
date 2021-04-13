Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445AAC433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 16:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6B36128E
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 16:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhDMQv6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Apr 2021 12:51:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41246 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhDMQv6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Apr 2021 12:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618332698; x=1649868698;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OX/tgVtKRQFaATTfNHhN4hgghrtRYmCWhIB1tcq1N7A=;
  b=POWtis6g66KcCRuMjeiPVClOMwQ62WCb7XmUip6KJpC/19bEMjzSvTt+
   j0YRNRX+iUHUkqlg0ogEnfjlHXsfTSVPakxcTDD2WEfQLOGhEn3rS2PFb
   x0+EuyLXu7zXBLGAH1Ku5J49e0PTMaBg3KOUy2b9Qis2Wd4I1MUxT8z9p
   V4V197GnJL6DzL0pEl/v2rCZj/PnAF5kZZ84GwSpO/A1Z7T9WqekGTySh
   dGieONFW8o/8+pq90VptpsFSOw87KbQCGi8PYRhLGlcEeGT2gnDa/dWu+
   MOLUBt3AsT8c2voIP+hvaEu136dDLBS4VeIDBkWRXlxZvl+YqQ73pIdqk
   g==;
IronPort-SDR: V7CSPp1ZOYDt2gl19P8ZV+HCPocw4ORmi7mnEnxsC1A9B1oMCpe6jBQOzPlBSDHl8Scsn15Q84
 yX6NG+fj5COjfYdsPe5pyuAM8HIwmdjxm0mDtCR1rF/jdBZAd0wD4iuC6arf72sfRnMkwEkhNz
 t+2Wka110daICxbzozU9n5Hgc9+BLqgIiUF53BpLf+pd43t/qKWoqGIIQSkNrgdBkxGohgzRWG
 /Xnb9l+wTxawY0NPou7E3VIWpjAxIV9PimrF3LzRbBCJO7R6xgY1jpwq/icZ+CnRIM63juT7t6
 Sa0=
X-IronPort-AV: E=Sophos;i="5.82,219,1613404800"; 
   d="scan'208";a="275567604"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 00:51:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE/3SD8lmc/t1uS0ixAx3/K5yrQRB1kkTynQwhkpfCpgufofGOJyjGX9N95BnWxVR7ObpojeJ6On7ZByxWXSqmwIy6OzAuN6EtqvQC+HuURHwAADkr9bbS/ciRnHzZJ6Th0+M9resDdNzEKfQm9LbqwoIUeoOZQ9e6vXXDS8tLNLd3aP8uoo0uAPDpDiE2EYdHho3Q0591a92NbkPQCx7gqvPGVGz8YSXbKakLR6mwiJmJGw+PvTXQdAEb6SFNJhjzt/d+dHmA1DDfzNLObwU7FuMazWrWY3HHQ1V3kzEUX0PhgLxbJIFyQKnGtZAmCtdohnz4u5xEbAh3Co7Kx+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX/tgVtKRQFaATTfNHhN4hgghrtRYmCWhIB1tcq1N7A=;
 b=iIAQsFlur+rF7NeIJTruIzwCNuRBHj9GjKmLNOhYEm2aq+ptecfQpxuJTVUc+3YfbkXtxuEgKxWJ/gdw7qQvx3gfKSCNzuE0DCGDRRoeoKl/QhblQNe//axYo4/HEW6tmpyuevCUHOucRupK7iyCfjqXN1qceJn4NvGwfqc5OaSF9rahpvi9TKlze7gdVDdwyALhUCeX4a4de8QfOLlk2ZHESlDA96heMVsKHGD9XM81eqT9l5ksgJotFJAcjnmRvi4gri8892MU3rtELJX4xOoDMmSXgKL3FyF7M9hXEcv4vdFQptff6+0XA/BqgsUM+H+hZi6PO/rcuZy3bXGBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX/tgVtKRQFaATTfNHhN4hgghrtRYmCWhIB1tcq1N7A=;
 b=edXvmakldi158SfT1WrE5gIYrthPR0psUBxsqZHplizGp1CY5vcMDzzH9qvhU+tD4/Fa6oDql0EWtmatYUEvCDIBAWA+nSBabjbL8NXrmR35M8V3kr0JpWWpB1YtAsRzgomqWTFtBf0FvcZvmnR7T63aFw0i0YLb9+f4aGq4hqc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7003.namprd04.prod.outlook.com (2603:10b6:5:1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.18; Tue, 13 Apr 2021 16:51:36 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 16:51:35 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
        "tedirkes@micron.com" <tedirkes@micron.com>
CC:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Subject: RE: [PATCH] mmc: add quirk to disable eMMC cache for Micron eMMC v5.0
 cards
Thread-Topic: [PATCH] mmc: add quirk to disable eMMC cache for Micron eMMC
 v5.0 cards
Thread-Index: AQHXMHvvS+/xbAyIjUiY1KcuT/4YvKqyl0aAgAAR+UA=
Date:   Tue, 13 Apr 2021 16:51:35 +0000
Message-ID: <DM6PR04MB657523A7DA3D4AD0A54E08D6FC4F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210408175951.22450-1-scott.branden@broadcom.com>
 <CAPDyKFrBMGjCFCwgaJ1D5f+VJSenp369MDP7KS_PY9JaPYA0Hg@mail.gmail.com>
 <90d986f4-bf72-64a6-62ce-cddcf6da43a9@broadcom.com>
 <74343d16-9894-f203-1401-8fa44d19bac7@broadcom.com>
In-Reply-To: <74343d16-9894-f203-1401-8fa44d19bac7@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eeed4d00-87a8-4579-758f-08d8fe9c6659
x-ms-traffictypediagnostic: DM6PR04MB7003:
x-microsoft-antispam-prvs: <DM6PR04MB7003C1DA95DE80403D7795C6FC4F9@DM6PR04MB7003.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNyGKktmX9a4VqMwzeun3yj7PB2KShaxR6G5KNaKM/c5Vj5ej++rSxCz/44FjIDNFxlDv7uZ3DqvWhfwK94DWEdNFl733PiC2oZg3sIYiakiFqf+u4l3vz3mCDE4+oVZJBL9xxY5oOn0MPb8Q2IOfY0U+Lk9Jw/D1xizeDLv77pjP4viM/UOx7cO2BXUjKD2pDHIAm580sEK5+j15Ie/+ozgnOqtAoLqzSqKs3jORI0j6jJbM+W8A1Mo7l0MP3owrFFXm4hyvN6TbvmUmXwkSqUHtuvOJ9QWMHJ9bfW/NfQlPSNQbDp4CCtfMByD5v8/9ZofS16kj4cwEp0lWCY3sYloDCeVpnMV8mHRWJTW+lE/QoyHGJqU/RUOxP5xJhtnIgz9Fn522HurodFIIETgOOBQI6rhG+hSpA3ZE5Tm5E4EEjBodQPg1cHuh+2ws+99jvfpagFIvuaH6m89Ud1u7SDHKG2g3Hux7O8a6KTVPpiLUQxTE4THgjd6OZwbTZf5UdhU+/CC+obszLEV7lRBcG6H5UqMrL5stRo7S+DrZhLw2YwVWVTay1xR5d10GRvUgAw7stSNfpeLzZPPtKKR/J34jMQVX0n3QrZoVCYlHaLjegS8XaIKlf2pOkMeIGKAlAjFG+YJjjPbU+LytNhnN0p7xfkonmW+jzCd89lGcp7gLE6lZCIv0dRtWi7vxFyAZn3Ft/lEEDaA9T+T86cKA7R42dz8Oy7QwQv53suvFlM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(346002)(366004)(376002)(8676002)(316002)(5660300002)(52536014)(66556008)(122000001)(64756008)(8936002)(478600001)(38100700002)(55016002)(54906003)(2906002)(66946007)(186003)(7696005)(110136005)(71200400001)(53546011)(4326008)(26005)(76116006)(86362001)(66446008)(66476007)(33656002)(83380400001)(966005)(9686003)(6506007)(68124002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OVFMZGtiZXhVNFErK29yYThHQm9MMHk0ODQ3RUpDbWx3UUIxRUc1cGlRZENn?=
 =?utf-8?B?ejNiMnBPL3hOck52bWpBY1hDb3FRRkEyMzY1NmNJcEFJbVJiTXhoK1hOYkxh?=
 =?utf-8?B?ZHFlU0JvcEdUSHZIWkxWRXBSVlM2eEJ5M0k3WnFHdy8xeXJnTDA1eGM3SVhk?=
 =?utf-8?B?SVlVYXhwWEVkZ2xJSW5Db3NRUE9ra1lJanpSaHFXRGNsVHh0cmpFTXl5SW4v?=
 =?utf-8?B?KzAzb0lQancvYS9jN1R2UlZjRndoTkwyaytnQ0lkU0ppS3dNMjRlc29Ja3RB?=
 =?utf-8?B?SUJNY096NlBiUVpvQ0ZDY3lhYTdNNFJibnYwQ2dYZEVVRTVTQ0pjaFFZYkY2?=
 =?utf-8?B?OWJzb1dIUmxLcm5JMXk3Qy9FZXNjaW5LeGJMU0p0THZTb29mdzFSazdyQnJ4?=
 =?utf-8?B?cXlJdDU2YkszV3cydTQvYkRJOFdWbnduUDBwNWhnQmZIdmxVZkUzd092SW9z?=
 =?utf-8?B?MmMxZ0tCWDcyallmNG51RXBWMUlYMXpPNmhra0xwNjhiRjFlQThQWHVVbEsv?=
 =?utf-8?B?d2dhSjgxZ1VIdk9WZFVyZkh4VmpyalBlSW15azhEb2NMcFJ6VXlsV2RNZHZW?=
 =?utf-8?B?TFVPemp0OXBCbEJ2L0RvK3JTRDFzYUdKbHFDM21Wb2VVK1J4MVlUc2ZxMTJO?=
 =?utf-8?B?aEsvQ2xGOVNaWEZ6MlhUWTlNU1M0V3JESkd6RXBwMlYzYmUyRUJabUhoeUFk?=
 =?utf-8?B?MER6MTRIbHdSNVRKeWszTDRvU2xDRzd4SGF2clAzMmRvUVNnTTdYVWtlTk1r?=
 =?utf-8?B?aTVXZk9PTzBtbklic2xOcFd0WG5FZGlJQTE4bnl6Z2dnZE1ObGFCcVViNWQv?=
 =?utf-8?B?emJXd1NiOHpmTVhHNWZ3aHp4dk5zeWVlcTlTamk3VFJvcXFnazVzZEx3TTdk?=
 =?utf-8?B?S0I4cGhXdEp6dGJNc2pZaTJlL1c0akRlaGxkZmZiZnE2NFBrRkNrQ3pZQUxS?=
 =?utf-8?B?Q04wdDIrWVp5KzlyclBHWXdJNXhDRzZVeUlWdGR6WmREQnpneURTRnQ2Nmd0?=
 =?utf-8?B?WHVUY3ZuU0V4ckZ2S0NQc01KdUdsSkRkUTVnRHErb1EraEtOWGpQVEtmVkVE?=
 =?utf-8?B?Um5nWHNlRWc3M1lLR0h4UHBzendBWHBLV2VMOG52K1gyczRuQWRHWWUvV01l?=
 =?utf-8?B?UEwxb2YyTGV3MFBvbGVVbDFjaE9LcmtYOXBvNWxBdm52Rjl4Q0tDUW04NzBQ?=
 =?utf-8?B?clN5MjI2U1NDRENldnJpZkxPZWViT3hMcUJ5QlRCV0F2QlhDdjdGYkJKR2cz?=
 =?utf-8?B?K2l1cmovOVlvSlc4QXhnWVdwL1FhVEhwVU45NmdjMVdIRVFwbHlpdHhXTUE5?=
 =?utf-8?B?dlpLYVdhNHdoTnBvWGFkRlR6WFpHUlllcnUzdmhCQnlHQXp2T3VGUzAvcjdM?=
 =?utf-8?B?RmlIZkpVS2hsWEp6dnVwQ3pXcFRmTFVSY2xLQmpWelB4cEhUQWZTeHJwL3Jz?=
 =?utf-8?B?dmJwdHJZaHU1VDNncmdkQ1FLRjBYelFGbkZObHZKS2hyNSsxWFFzMllBTThQ?=
 =?utf-8?B?MjVOTXU4MkZwSFltZU5Wb1F0Q0wyUG94RHl1ZHo1L2VLSXR5Uzg3Rjc4eEdZ?=
 =?utf-8?B?MFNCNlVVcmxHd1BGL3BXeis1N2tRK1U0S1pGNGVabGh2ZjJOQ256Y2x3cU5F?=
 =?utf-8?B?SUpQcmJvNFBIVGRiQzVPUHVNYVFQL3RVdVRQajVYMFRxdG1Db1ZsR2hxcmE3?=
 =?utf-8?B?cE1XQWU4ZFpGVUNDYUx0dzd6NndHc0NqbmcvR0RibWwwQ1hYdzVRUElhWERk?=
 =?utf-8?Q?7bOY/UfkjeSWW1sIrg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeed4d00-87a8-4579-758f-08d8fe9c6659
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 16:51:35.6664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCm9waTj/8QbL3T13B4NGpZP+5hPXyCxjn18KyvS7CRRisr2uEm5Y+INSUQMgjUMwvXlTdSuF+whf6pu2+s+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7003
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

U2NvdHQgaGksDQpDYW4geW91IHRha2UgYSBsb29rIGF0IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvMjAyMTAzMjIxMzM2NDUuNDkwMS0xLWF2cmkuYWx0bWFuQHdkYy5jb20vDQpJcyB0aGVy
ZSBhIGNoYW5jZSB0aGF0IGl0IHdpbGwgd29yayBmb3IgeW91IGFzIHdlbGw/DQoNClRoYW5rcywN
CkF2cmkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTY290dCBCcmFu
ZGVuIDxzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbT4NCj4gU2VudDogVHVlc2RheSwgMTMgQXBy
aWwgMjAyMSAxODo0Ng0KPiBUbzogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+
OyBCZWFuIEh1byAoYmVhbmh1bykNCj4gPGJlYW5odW9AbWljcm9uLmNvbT47IEx1Y2EgUG9yemlv
IChscG9yemlvKSA8bHBvcnppb0BtaWNyb24uY29tPjsNCj4gdGVkaXJrZXNAbWljcm9uLmNvbQ0K
PiBDYzogQkNNIEtlcm5lbCBGZWVkYmFjayA8YmNtLWtlcm5lbC1mZWVkYmFjay1saXN0QGJyb2Fk
Y29tLmNvbT47IGxpbnV4LQ0KPiBtbWMgPGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+OyBMaW51
eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47
IFZsYWRpbWlyIE9sb3Z5YW5uaWtvdg0KPiA8dmxhZGltaXIub2xvdnlhbm5pa292QGJyb2FkY29t
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbW1jOiBhZGQgcXVpcmsgdG8gZGlzYWJsZSBl
TU1DIGNhY2hlIGZvciBNaWNyb24gZU1NQw0KPiB2NS4wIGNhcmRzDQo+IA0KPiArVHJhdmlzIERp
cmtlcyAod2l0aCBjb3JyZWN0ZWQgZW1haWwpLA0KPiANCj4gIENvdWxkIHlvdSBwcm92aWRlIG1v
cmUgZGV0YWlscyBvbiB0aGUgTWljcm9uIGRhdGEgZXJyb3IuDQo+IA0KPiA+IE9uIDIwMjEtMDQt
MTIgMTI6NDQgYS5tLiwgVWxmIEhhbnNzb24gd3JvdGU6DQo+ID4+ICsgQmVhbiBIdW8sIEx1Y2Eg
UG9yemlvDQo+ID4+DQo+ID4+IE9uIFRodSwgOCBBcHIgMjAyMSBhdCAxOTo1OSwgU2NvdHQgQnJh
bmRlbg0KPiA8c2NvdHQuYnJhbmRlbkBicm9hZGNvbS5jb20+IHdyb3RlOg0KPiA+Pj4NCj4gPj4+
IEZyb206IFZsYWRpbWlyIE9sb3Z5YW5uaWtvdiA8dmxhZGltaXIub2xvdnlhbm5pa292QGJyb2Fk
Y29tLmNvbT4NCj4gPj4+DQo+ID4+PiBJbiBjZXJ0YWluIHJhcmUgY29tYmluYXRpb24gb2Ygb3Bl
cmF0aW9ucywgTWljcm9uIGVNTUMgdjUuMCBjYXJkcw0KPiA+Pj4gbWF5IGV4cGVyaWVuY2UgZGF0
YSBlcnJvcnMgaWYgaW50ZXJuYWwgY2FjaGUgaXMgZW5hYmxlZC4NCj4gPj4+IFRoaXMgbWF5IGxl
YWQgdG8gZU1NQyByZWxhdGVkIGRhdGEgZXJyb3JzLg0KPiA+Pj4gSW50cm9kdWNlIGEgcXVpcmsg
dG8gZGlzYWJsZSBjYWNoZSBvbiB0aGVzZSBlTU1DIGNhcmRzLg0KPiA+Pg0KPiA+PiBDYW4geW91
IHBsZWFzZSBlbGFib3JhdGUgb24gdGhpcywgd2hhdCBjb21iaW5hdGlvbnMgb2Ygb3BlcmF0aW9u
cyBhcmUNCj4gPj4geW91IHJlZmVycmluZyB0byAtIGFuZCB3aGF0IGtpbmQgb2YgZGF0YSBlcnJv
cnM/DQo+ID4+DQo+ID4+IEkgaGF2ZSBhbHNvIGxvb3BlZCBpbiBzb21lIG9mIHRoZSBNaWNyb24g
Z3V5cywgdG8gbGV0IHRoZW0gY2hpbSBpbi4NCj4gPj4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2Zm
LWJ5OiBWbGFkaW1pciBPbG92eWFubmlrb3YNCj4gPHZsYWRpbWlyLm9sb3Z5YW5uaWtvdkBicm9h
ZGNvbS5jb20+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBTY290dCBCcmFuZGVuIDxzY290dC5icmFu
ZGVuQGJyb2FkY29tLmNvbT4NCj4gPj4NCj4gPj4gS2luZCByZWdhcmRzDQo+ID4+IFVmZmUNCj4g
Pj4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvbW1jL2NvcmUvY2FyZC5oICAgfCA1ICsrKysr
DQo+ID4+PiAgZHJpdmVycy9tbWMvY29yZS9tbWMuYyAgICB8IDQgKystLQ0KPiA+Pj4gIGRyaXZl
cnMvbW1jL2NvcmUvcXVpcmtzLmggfCA4ICsrKysrKysrDQo+ID4+PiAgaW5jbHVkZS9saW51eC9t
bWMvY2FyZC5oICB8IDEgKw0KPiA+Pj4gIDQgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMv
Y29yZS9jYXJkLmggYi9kcml2ZXJzL21tYy9jb3JlL2NhcmQuaA0KPiA+Pj4gaW5kZXggN2JkMzky
ZDU1Y2ZhLi4yMmNlYTYzYWMzNTkgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL21tYy9jb3Jl
L2NhcmQuaA0KPiA+Pj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9jYXJkLmgNCj4gPj4+IEBAIC0y
MjIsNCArMjIyLDkgQEAgc3RhdGljIGlubGluZSBpbnQgbW1jX2NhcmRfYnJva2VuX2hwaShjb25z
dA0KPiBzdHJ1Y3QgbW1jX2NhcmQgKmMpDQo+ID4+PiAgICAgICAgIHJldHVybiBjLT5xdWlya3Mg
JiBNTUNfUVVJUktfQlJPS0VOX0hQSTsNCj4gPj4+ICB9DQo+ID4+Pg0KPiA+Pj4gK3N0YXRpYyBp
bmxpbmUgaW50IG1tY19jYXJkX2Jyb2tlbl9jYWNoZShjb25zdCBzdHJ1Y3QgbW1jX2NhcmQgKmMp
DQo+ID4+PiArew0KPiA+Pj4gKyAgICAgICByZXR1cm4gYy0+cXVpcmtzICYgTU1DX1FVSVJLX0JS
T0tFTl9DQUNIRTsNCj4gPj4+ICt9DQo+ID4+PiArDQo+ID4+PiAgI2VuZGlmDQo+ID4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMN
Cj4gPj4+IGluZGV4IDg3NDEyNzFkMzk3MS4uY2Q4M2I3ZjBlNTljIDEwMDY0NA0KPiA+Pj4gLS0t
IGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9t
bWMuYw0KPiA+Pj4gQEAgLTE4MjAsMTIgKzE4MjAsMTIgQEAgc3RhdGljIGludCBtbWNfaW5pdF9j
YXJkKHN0cnVjdCBtbWNfaG9zdA0KPiAqaG9zdCwgdTMyIG9jciwNCj4gPj4+ICAgICAgICAgICog
c3VkZGVuIHBvd2VyIGZhaWx1cmUgdGVzdHMuIExldCdzIGV4dGVuZCB0aGUgdGltZW91dCB0byBh
IG1pbmltdW0gb2YNCj4gPj4+ICAgICAgICAgICogREVGQVVMVF9DQUNIRV9FTl9USU1FT1VUX01T
IGFuZCBkbyBpdCBmb3IgYWxsIGNhcmRzLg0KPiA+Pj4gICAgICAgICAgKi8NCj4gPj4+IC0gICAg
ICAgaWYgKGNhcmQtPmV4dF9jc2QuY2FjaGVfc2l6ZSA+IDApIHsNCj4gPj4+ICsgICAgICAgaWYg
KCFtbWNfY2FyZF9icm9rZW5fY2FjaGUoY2FyZCkgJiYgY2FyZC0+ZXh0X2NzZC5jYWNoZV9zaXpl
ID4gMCkNCj4gew0KPiA+Pj4gICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCB0aW1lb3V0X21z
ID0gTUlOX0NBQ0hFX0VOX1RJTUVPVVRfTVM7DQo+ID4+Pg0KPiA+Pj4gICAgICAgICAgICAgICAg
IHRpbWVvdXRfbXMgPSBtYXgoY2FyZC0+ZXh0X2NzZC5nZW5lcmljX2NtZDZfdGltZSwNCj4gdGlt
ZW91dF9tcyk7DQo+ID4+PiAgICAgICAgICAgICAgICAgZXJyID0gbW1jX3N3aXRjaChjYXJkLCBF
WFRfQ1NEX0NNRF9TRVRfTk9STUFMLA0KPiA+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFWFRfQ1NEX0NBQ0hFX0NUUkwsIDEsIHRpbWVvdXRfbXMpOw0KPiA+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRVhUX0NTRF9DQUNIRV9DVFJMLCAxLCB0aW1lb3V0X21z
KTsNCj4gPj4+ICAgICAgICAgICAgICAgICBpZiAoZXJyICYmIGVyciAhPSAtRUJBRE1TRykNCj4g
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9jYXJkOw0KPiA+Pj4NCj4gPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oIGIvZHJpdmVycy9tbWMvY29y
ZS9xdWlya3MuaA0KPiA+Pj4gaW5kZXggZDY4ZTZlNTEzYTRmLi4yMzk3MmQ4N2M4MmEgMTAwNjQ0
DQo+ID4+PiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oDQo+ID4+PiArKysgYi9kcml2
ZXJzL21tYy9jb3JlL3F1aXJrcy5oDQo+ID4+PiBAQCAtMTE2LDYgKzExNiwxNCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG1tY19maXh1cCBfX21heWJlX3VudXNlZA0KPiBtbWNfZXh0X2NzZF9maXh1
cHNbXSA9IHsNCj4gPj4+ICAgICAgICAgTU1DX0ZJWFVQX0VYVF9DU0RfUkVWKENJRF9OQU1FX0FO
WSwNCj4gQ0lEX01BTkZJRF9OVU1PTllYLA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMHgwMTRlLCBhZGRfcXVpcmssIE1NQ19RVUlSS19CUk9LRU5fSFBJLCA2KSwNCj4gPj4+
DQo+ID4+PiArICAgICAgIC8qDQo+ID4+PiArICAgICAgICAqIEluIGNlcnRhaW4gcmFyZSBjb21i
aW5hdGlvbiBvZiBvcGVyYXRpb25zLCBNaWNyb24gZU1NQyB2NS4wIGNhcmRzDQo+ID4+PiArICAg
ICAgICAqIG1heSBleHBlcmllbmNlIGRhdGEgZXJyb3JzIGlmIGludGVybmFsIGNhY2hlIGlzIGVu
YWJsZWQuDQo+ID4+PiArICAgICAgICAqIERpc2FibGluZyBjYWNoZSBmb3IgdGhlc2UgY2FyZHMg
ZWxpbWluYXRlcyB0aGUgaXNzdWUuDQo+ID4+PiArICAgICAgICAqLw0KPiA+Pj4gKyAgICAgICBN
TUNfRklYVVBfRVhUX0NTRF9SRVYoQ0lEX05BTUVfQU5ZLA0KPiBDSURfTUFORklEX01JQ1JPTiwN
Cj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDE0ZSwgYWRkX3F1aXJrLCBN
TUNfUVVJUktfQlJPS0VOX0NBQ0hFLCA3KSwNCj4gPj4+ICsNCj4gPj4+ICAgICAgICAgRU5EX0ZJ
WFVQDQo+ID4+PiAgfTsNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9t
bWMvY2FyZC5oIGIvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oDQo+ID4+PiBpbmRleCBmOWFkMzVk
ZDYwMTIuLjIyZjI1NmE0ZTU0ZSAxMDA2NDQNCj4gPj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbW1j
L2NhcmQuaA0KPiA+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oDQo+ID4+PiBAQCAt
MjcwLDYgKzI3MCw3IEBAIHN0cnVjdCBtbWNfY2FyZCB7DQo+ID4+PiAgI2RlZmluZSBNTUNfUVVJ
UktfQlJPS0VOX0lSUV9QT0xMSU5HICAgKDE8PDExKSAvKiBQb2xsaW5nDQo+IFNESU9fQ0NDUl9J
TlR4IGNvdWxkIGNyZWF0ZSBhIGZha2UgaW50ZXJydXB0ICovDQo+ID4+PiAgI2RlZmluZSBNTUNf
UVVJUktfVFJJTV9CUk9LRU4gICgxPDwxMikgICAgICAgICAvKiBTa2lwIHRyaW0gKi8NCj4gPj4+
ICAjZGVmaW5lIE1NQ19RVUlSS19CUk9LRU5fSFBJICAgKDE8PDEzKSAgICAgICAgIC8qIERpc2Fi
bGUgYnJva2VuIEhQSQ0KPiBzdXBwb3J0ICovDQo+ID4+PiArI2RlZmluZSBNTUNfUVVJUktfQlJP
S0VOX0NBQ0hFICgxPDwxNCkgICAgICAgICAvKiBEaXNhYmxlIGJyb2tlbg0KPiBjYWNoZSAqLw0K
PiA+Pj4NCj4gPj4+ICAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgcmVlbmFibGVfY21k
cTsgIC8qIFJlLWVuYWJsZSBDb21tYW5kIFF1ZXVlICovDQo+ID4+Pg0KPiA+Pj4gLS0NCj4gPj4+
IDIuMTcuMQ0KPiA+Pj4NCj4gPg0KDQo=
