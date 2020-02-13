Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D23C2BA83
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 07:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAF52073C
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 07:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OFSEFqxU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I3/Gca23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgBMHfU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:35:20 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48131 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgBMHfT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 02:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581579318; x=1613115318;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9TMcAZOoMrlSC7JgJX8fzE293TQuGYGUJNVDel8EHIk=;
  b=OFSEFqxUeQ01/T0i1rwR2F/2R7f8Qnuc/9tvhNolzMdufcOWvb7P8z2r
   nUj027QUmYF9M65J4sPWHqpNglkMn+F1EAZ5+kNnPtZYLP/MrxTwx9YWB
   oOff0nV/Yf64Rw6qyhEoaaTEA6l4zGggTy5j7y4Mww4mG1mDopqi7Au/3
   3UuvILWL5Fqw+I49+7Z6ciMbcXeytgtfIkkLAgI5+Dv6r+ZFr39FG+noW
   yKh7Vd8k1in5M287Ds15w87wYZeZFToKyURWuzIdAo09DaCzqZaLmc+/6
   BAAqNPc4ocYhJF/c/UjJxeCEdSvKVOMb/GaKrTC4sHkvmZ0r+jimn7nQQ
   Q==;
IronPort-SDR: teA6w2H0uky2zRXRoocJRWMecpEOSNJaNCdExNMl38mTDbd8rue/IQSf4PcxAPQ6MKWYtvpuW5
 VIPm1SJ8h8tlVLzQrtnWzOeQYR5W3GayBn+M8/YtbdsngFEK42z3d3798G9D8zuQD0z9XY3sDH
 NrZiV1SGsmN9NmdTflApez4mpreEtK4PiFJr/0LoZkPrxiCxIuna+MCNsDtHwOOFAPLJTftj/9
 xlwbdtUWFnYPQF5B6Uu6y91TGfBONje4F5E85WSFDNWn6S0lghsUNIBmjTF37pFSwApQZxRQnU
 5Cg=
X-IronPort-AV: E=Sophos;i="5.70,436,1574092800"; 
   d="scan'208";a="237772546"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 15:35:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO9VCaswdElki3v4FEaHt6hFIEGOywcBIZBHU/C6+5BH/FnJVR0wz/5BkF8g7VbsNk7E6T68I3ByA6AgRcO0ihYck1miIfuWoYc61S26LMUmCbdJCLKogZYcR631D3RvQPR3qwgpCV/x/Mrd0wlmr2lHy48Td+jRFoAktxGAjld0kxPnVwcATRlmOG32bVwZd3Yz5UDPpE1L0bkUmQl9mzJ3w8zAFiu7YkrYPl0xLAecNizbIcql7UrBBl76FPEwFRhHW3bmirgj+GGLtQwDSpMVtKkxronA2RPKFd2xCkOrAMOcFK4JxBuc4zMOAA3Zmac/eGyWVNdh/C8aVOqAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TMcAZOoMrlSC7JgJX8fzE293TQuGYGUJNVDel8EHIk=;
 b=nA2n6STrZlN88qzGbdZ+qX9B42u4A4s4IcwiteOzXFjxN3eQdX1o7uTtWlOHKD1XJ9zfY4Dzdpmptl2UrwzE9Mh179V3VB+pz01X66VkoiVYD3kk78xkmyevyMYjj2NszxQp86gRwL9cG0xE7BssdTL063JVqcweBxvnmlfNZBQf70wTwgwAH79Y2jcfk5VdDeZhj6+2vfrM7EskBQaajDPabmGfYeSbiusBcU8StXuJ16zdsoKoYts9psxSsxraqVpAgcKv+xIr9dF5cpYzjnqS8jKwH4aCCGTQzOEeATKrJT5dGcHgSpnOz7VsLJRTbmlb1lkIl4ig+F6obETJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TMcAZOoMrlSC7JgJX8fzE293TQuGYGUJNVDel8EHIk=;
 b=I3/Gca23omaLIfmyuWLnK+Uxie/rDnb9b0hLJlSXaFDoxapMmLheiHRWCYvtSotJBB51cgd2uA5LODSzhsI/wnHi/tyo9PYdKwguqyF06RRa6rokM0cxgWsduCDcRZR9KP8ClCAtmgBeZDWHNikrQlCNd//xv6RPr133iS9UcNI=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB5773.namprd04.prod.outlook.com (20.179.20.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 07:35:13 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::3885:5fac:44af:5de7]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::3885:5fac:44af:5de7%7]) with mapi id 15.20.2729.025; Thu, 13 Feb 2020
 07:35:13 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Patrick Oppenlander <patrick.oppenlander@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: mmc-utils mmc tool reports incorrect cache size
Thread-Topic: mmc-utils mmc tool reports incorrect cache size
Thread-Index: AQHV4exJYXl6q7Gmfk+w4x5pciJgX6gYuavg
Date:   Thu, 13 Feb 2020 07:35:13 +0000
Message-ID: <MN2PR04MB6991B0F4431E56BA0C64927AFC1A0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <CAEg67GnNdOBgq=gVH9fDTwT0-KM5+3g8Do5ZnW+y6Q0AY_302A@mail.gmail.com>
In-Reply-To: <CAEg67GnNdOBgq=gVH9fDTwT0-KM5+3g8Do5ZnW+y6Q0AY_302A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e97e2eb-2913-4049-a7e9-08d7b0574362
x-ms-traffictypediagnostic: MN2PR04MB5773:
x-microsoft-antispam-prvs: <MN2PR04MB57733CC1D892C9EE684D8CF8FC1A0@MN2PR04MB5773.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(189003)(199004)(66446008)(55016002)(9686003)(8936002)(81166006)(8676002)(81156014)(86362001)(33656002)(6506007)(186003)(26005)(64756008)(53546011)(2906002)(66476007)(66556008)(66946007)(76116006)(316002)(5660300002)(71200400001)(110136005)(7696005)(966005)(52536014)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5773;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y1G1FvNaUH4sIJv4ZgVgEL8grBZ9l2xIl8j0rFLtspdz5JCOHLfDHlEm9vrEBF60hZ65m9R7ZU6UxpQ1r7Irb43atHvStwyxsK8eVRSnbaa1QiSbpkhz0J3WRp1nyRLfEFyxQwvoVJxa22V0E0/UL62Zoza/BZqj+DTkQsHu8WYJvSBZWoX09sMun2uxUrX/2/E4CfTIw5TnpWvuWYq12Kl7OKcpp/9C6DfCELmtrdER1No4z/KqWUvp7WERrARcLipEtvMwMCIZIXX5RyZLE5grh0cWNmpmTGahjEz6p409grPd6cYGTXeq8Mt737qE/bPEQQBiC9XmR7fwy8vD5FE9uIIrDGnHPeO4zRxG2iRvhZTvriKVTNKSIZq2pSD7ZwaxmgEKx+jiOcC30rGzxC2C+L5LXzhTtNoHLo4cVxqj5Jw68wtxNPy3d+PcBBCWQXwvpVo3tsRazRgQtv4PDI8pHQQqmgcKkNTUklayJ1mD0Pe2vay5DSc8wtkRA5zBQ616VmL6kybgu9QMD/uGTQ==
x-ms-exchange-antispam-messagedata: yeYWT59P68+YwaQb1ezB0VcNaXJb+pm7TmM2N0CBv5nMyeHonK1NQO/GF8TclSqmjXyqItP8f/b94qae6ebU56ztKh9/1k/b3eyeQWYp6gOSkQNTpKLPtr0kz5oFBj8fp5EaLFPkrm42yPv6l/2y1Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e97e2eb-2913-4049-a7e9-08d7b0574362
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 07:35:13.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GorceL1mIsMPl0miBNln8Uor3oNnP8jYoqRZzEgYOKKFgDVqhsRGiDiVJESnRlEfdYffPX4MokKf6BpeA+8wRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5773
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

UGF0cmljayBoaSwNClllcywgaXQgaXMgaGVscGZ1bCwgYnV0IHlvdSBuZWVkIHRvIHN1Ym1pdCB5
b3VyIHBhdGNoIGluIGEgd2F5IGl0IGNhbiBiZSByZXZpZXdlZC4NCk1heWJlIHlvdSBjYW4gbG9v
ayBpbiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y1LjUvcHJvY2Vzcy81LlBvc3Rp
bmcuaHRtbD9oaWdobGlnaHQ9c3VibWl0JTIwcGF0Y2hlcyMNCkZvciBtb3JlIGluZm8uDQoNClRo
YW5rcywNCkF2cmkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51
eC1tbWMtb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1tbWMtDQo+IG93bmVyQHZnZXIua2Vy
bmVsLm9yZz4gT24gQmVoYWxmIE9mIFBhdHJpY2sgT3BwZW5sYW5kZXINCj4gU2VudDogV2VkbmVz
ZGF5LCBGZWJydWFyeSAxMiwgMjAyMCAxMTozNSBQTQ0KPiBUbzogbGludXgtbW1jQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBtbWMtdXRpbHMgbW1jIHRvb2wgcmVwb3J0cyBpbmNvcnJlY3Qg
Y2FjaGUgc2l6ZQ0KPiANCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0
c2lkZSBvZiBXZXN0ZXJuIERpZ2l0YWwuIERvIG5vdCBjbGljaw0KPiBvbiBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhh
dA0KPiB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IEhpLA0KPiANCj4gSSByZWNlbnRs
eSBub3RpY2VkIHRoYXQgJ21tYycgcmVwb3J0cyBjYWNoZSBzaXplIGluY29ycmVjdGx5LiBUaGUg
dW5pdA0KPiBpbiB0aGUgZXh0ZW5kZWQgQ1NEIGlzIGtpbG9iaXRzIHJhdGhlciB0aGFuIGtpbG9i
eXRlcywgc28gZm9yIGENCj4gZGlzcGxheSB1bml0IG9mICdLaUInIGl0IG5lZWRzIHRvIGJlIHNj
YWxlZCBhcHByb3ByaWF0ZWx5Lg0KPiBBbHRlcm5hdGl2ZWx5IHRoZSB1bml0IGNvdWxkIGNoYW5n
ZSB0byBLaWJpdCwgYnV0IEkgdGhpbmsgdGhhdCdzIGxlc3MNCj4gaGVscGZ1bC4NCj4gDQo+IEkn
dmUgYXR0YWNoZWQgYSBwYXRjaCB3aGljaCBmaXhlcyB0aGUgaXNzdWUgJiBpbmNsdWRlcyByZWZl
cmVuY2VzIHRvDQo+IHRoZSByZWxldmFudCBwYXJ0cyBvZiB0aGUgSkVERUMgc3RhbmRhcmQuDQo+
IA0KPiBIb3BlIHNvbWVvbmUgZmluZHMgdGhpcyBoZWxwZnVsLA0KPiANCj4gUGF0cmljaw0K
