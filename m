Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41388C7EE25
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Jun 2023 08:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbjFII0i (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Jun 2023 04:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbjFIIZ4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2023 04:25:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF22B3C31
        for <linux-mmc@vger.kernel.org>; Fri,  9 Jun 2023 01:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686299098; x=1717835098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fgicPNlJI3ZJ5d/FzuL5E2yPE3uIZJQfEUyw7cRuXQA=;
  b=WJszgEwLiqIQ0D5EF5mYlOBJM0bBGV2MXQuFkOhFwIt/TSV8AklLiB1r
   R3d6lZLADRnSBD1KGr9GBc/ex7fFNpOXi+EURRQ+wrVhZa2WrAocqNj6m
   9MdQCB+k8WvBirsmVDDxnpRB8hB+6L35a+kAu1UzN4ySraxxjffVIOrmC
   /oC76IbaO2qPmhP2H8y1uNWihGh9Ds9s9g3Lyn5FkUA1XoJwM81bhACm1
   rG8jVFZ6Sjy2+MvpAHZyjct8vuQd+Ml988p5O3eSvjgtBl9McisurMvZr
   gtIi9cj1ywmgVblbUawPJ4xByUBUhu0TxYQEmFlvR11FcJTf2LN8FSbnK
   A==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681142400"; 
   d="scan'208";a="339145652"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2023 16:24:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLsU1EgnXy7+T2VgEkIq/v9zIuCFl2HGzitIh0vBsp3u2UmwNtv2ldN6er/HacHoODRS8eryjDyOQdS7sUdAqsmLuFkg3JVU2a8TqJz0GURiRqClyJYnLwsgqxYwJnTD4UMOTFj3Lxla10bZJY8e8XMAm4t2a7U5ohG4jC8tIOX7fCalkD+TGr272oEqJNPo6Qr32VtgUgv81Y89t+aUXKXBPIv8MQtY/8JujHJRM7U+HcQPoOenJt/2dc/ttow6Mo20hO/VOtjGlDxO47MkTtJV22LxriD7XyvMgjqPQAmly+YyKB/g4bGzK8Z/ydKCDBJatVYB1x8U3qFLqdyEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgicPNlJI3ZJ5d/FzuL5E2yPE3uIZJQfEUyw7cRuXQA=;
 b=FgZRWddjU+n9yALTdqqZnY7p2bSjIfhC62U9Aet1Uzfz+R4xxAYYRE0waCYA7mHERlm0gcMgy+YZyisqJMYXePbdQIzOeRvT2Z6amaGy/+3ASwZw+OV9Q6aAkrWvBsGo3ZsTBJFoGqKVbcsj7/UjkLYVIz5um1nn91AkEc0jD8FOvO5wo7UJmaH1NM64MjJXvE4DvgJ5Z+uUhaoG20G/hypwDmTblnh+aCyR98wLykM+Ykcc7sjbUAq3rpwQPMdXSBGpjjyqV9NJpUc30bzJmNDbusQtY33skVS4m2NBa0RERWG20LZ6Wu1cMxQDucrSl7Oj02ycE80lCLtMJicruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgicPNlJI3ZJ5d/FzuL5E2yPE3uIZJQfEUyw7cRuXQA=;
 b=otRlgrLyi9Lc9UaegulGQxtsyncOBTonJwFoKeAQodxoKijULCZsRME/NU+QaiOlyD+ZevlOQiwYmzqxclPl0k6jSWb1hWvSqEbxaQBelw8RplDCdzkxrhdAtk81KcPXJoR5ev2emly0e2f5htduIcxanIfmL40TZsSa4USUaaU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM8PR04MB7944.namprd04.prod.outlook.com (2603:10b6:8:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Fri, 9 Jun 2023 08:24:56 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1a88:334:dff7:848a]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1a88:334:dff7:848a%4]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 08:24:56 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Assert MMC_IOC_MULTI_CMD in compile time
Thread-Topic: [PATCH] mmc-utils: Assert MMC_IOC_MULTI_CMD in compile time
Thread-Index: AQHZjhu2TNJRxC3eOkSLbtr8urehZq+BiHgAgACyvRA=
Date:   Fri, 9 Jun 2023 08:24:56 +0000
Message-ID: <DM6PR04MB65752A351ED34AD54A0F4522FC51A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230524084224.558-1-avri.altman@wdc.com>
 <CAPDyKFpHin4yj=bGO6bQBmTZPTPyR8jh7FUSh22zL0J-igTbEw@mail.gmail.com>
In-Reply-To: <CAPDyKFpHin4yj=bGO6bQBmTZPTPyR8jh7FUSh22zL0J-igTbEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM8PR04MB7944:EE_
x-ms-office365-filtering-correlation-id: 09c2fc53-775c-488c-6994-08db68c301e4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 74e6qwmDlmfizIt4sTtrE+s4uVtw/zneUN7u4I0O42nzYsO+HV9NQpUxf/9htyDt02YYpsjMpb6UzcAKD5agZaTRtGqIkXm5U1SPHMwrw82xZ+2/4PI9aIheZBoYLytpPel3DTDxGUBH5lWRGpGA/h67hvJG9VvvTOTiR9i+Sx8ZbnnuGQMEjNIPGYgczt5gB6keJRsoO3cWev9dzbB/zVJc8MpovK0+X8VfNdFvI9DAj0wkghwrCKMywmp12egwvdqrGSrNkAssiG93jw8I2QwOqTYnwJH4JCrj84OtdoTSYG0sgSI0olDS2FX+Ye116jFwHgnCWsrTomXoFywQbT3pbjTHbyFzNRdSGmsmbDT9s1wRG1y7WHKnnKaMe0Kbc/V6LXRgGj7DXPdlyAql+fw0WwfawkkTN/xCQzpd68PH81uyF7qDTHN3ntvNXXgWNPS9Y5Ud0z4cVru6fxCAYrmTnZMtchUTCMmEfRx421vxrb+BobTcl1NnrBHaO1xcQsJ/VMurJ1CdlLlFt5cyAWGDz7TJWyhYB9bs9ktUPc0ev81xNi7QAARabxCN8hqt31Y0qqijya2O6NdIi5LoSH0ODtUOMxepuKqvmllNUaJE3n7wAtdqyfgX3FgLSy76
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(38070700005)(2906002)(4744005)(8676002)(5660300002)(52536014)(8936002)(41300700001)(316002)(6916009)(4326008)(66446008)(66476007)(64756008)(66556008)(66946007)(76116006)(66899021)(71200400001)(7696005)(478600001)(6506007)(9686003)(38100700002)(86362001)(83380400001)(186003)(33656002)(55016003)(82960400001)(122000001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmVuSVB5UGRrT3NkOXlrZDZ1ZHFRazI0ZWtYZFJuMmJGWDltd0NNT1FRbkFM?=
 =?utf-8?B?U1ZxZVYxeDJHRG9nYlhKSWo5Ny9kYkExSnNFOUpibDd0NWNvM2RMZ1dTNC9a?=
 =?utf-8?B?K1lycHlBU2k2QkMzQ3kzNmkxV2FZOEdCRXJKWDRNemh3NlFDV01rdTJySTJ3?=
 =?utf-8?B?dFhoTWtvMzVaNm9JS2htbFBMVDRWcWFuaVpBb2sxbkprQ3QxeDBIYjNqejVZ?=
 =?utf-8?B?dWkwMkIvNDFvS1FaYnMvL3NPcFBZelBXS0podkJqSEhNeHhxdGdtMmF3N1pl?=
 =?utf-8?B?RUkxM2gvV2pETGRHRzllUjV4YW9hdjlZbnJ6d0ltYlZ0aTF1MTNEMlFjYWcw?=
 =?utf-8?B?c1Bha3kxM2VGU3ZtZXVGY0xydVpTNmcrUWhLTDZZSjhjZGFienp5WG9qTFNy?=
 =?utf-8?B?S0o1VG9NOGFTMmdBakprcmJad01zNWkzcWdIN1IwdDNVbzQxTWFHYWh0UzNE?=
 =?utf-8?B?SXlFRzhsa0JjbFlCZFZHMS81NVFBNm5wempIV3dRYUtRa29WeC8wSkp2b3dr?=
 =?utf-8?B?SkVmLzNmT0pwN0w2UEZPWEZUaUxLVHhoY0ZScWRzQnlrNDB6alpRc3gzT3dt?=
 =?utf-8?B?T1dFbWRxR3hKTG5zM2dQOWt0b0pkWVg5NEZkYUxyY0J6K2g4a0Q1amkrc01z?=
 =?utf-8?B?aEV4SXB3SHpmT1ppSmQveXBNT2JjMlVxMFFVR2hzUHdva0M2VXh6RFNJbjBM?=
 =?utf-8?B?TFRPL3NwMWdsN28yLzBQNmhCR2txS2ljWEVLalB3cjZsa1NaWnI3RFROV1ZK?=
 =?utf-8?B?LyszTHdoNmVNYSs5TGdZZE1ZU3ljSU9VN3YwT05hSnlkdHNpZFIwU2RIVnhJ?=
 =?utf-8?B?R2VSanhLQUdsWFhPNzkxUHR2ZzhzNWdQdUNuOE1MeWZ2Skc0MURxOUVYYTgw?=
 =?utf-8?B?WjRhN3RoMitPbE9WRGQ5Z2c3N3ZlU0d6MDBxMHNaOWRzaDFOOWZWbkg0Nm9Y?=
 =?utf-8?B?WXlVOUJUd0dndkoybjJlbzRIY3VhZndIVE5zNWptL2NhV2tQVkE2aTJvaDV0?=
 =?utf-8?B?NWo0R0kwNkdPdElNWXRueEdQYS8rSHlTN3d0a1h2S3VXekVsdXhUUDV5aUdV?=
 =?utf-8?B?TXE4dVMzN3dDdHlJdkt4bFhBY2xTWnFSM2NpT21EM2J2OHNFZzRqWFZxZ1cx?=
 =?utf-8?B?Zkp5NXk5M2lyOGI2MUtLOHNvTC9FWXYrS0VpNGJMUWhNMDhLK1p6WHgxZzZi?=
 =?utf-8?B?Yi80QmMrRTExWkQyWGxsc1NhUkxFL0RJWWpYK3c3eHNUWlRYWE1GcnZaU05i?=
 =?utf-8?B?R2pQZGhSbVZVL213RkZUWGVBSHdkd0dOeC90ZVV1ek9NSWZteDlzbVVYelht?=
 =?utf-8?B?S1lTWkZvcnNoVUVIM29ZZEt1V3hnTnE2Wm9mM2hkZGw4SUtmQ1pXeWdNMnR3?=
 =?utf-8?B?Qm9zUXV4VjNxTjh6Vk5QUnZINkx4ZEhFdDlWM1hsdDhmSnhOMG4xZW15T25X?=
 =?utf-8?B?T3FnZWtkOFBwWTNIc3pJVjVsdGpTN0xXaGhnelpKY3ZMaldyZlA1cXdzOEdx?=
 =?utf-8?B?VXg0aXZNNU16cUZqeDBBMFBlVUJmeVpkeWVJdVg5cHAySSt2K2tyNVVHQ3R1?=
 =?utf-8?B?eE00R0FyY3lheDFCK0djNkF0dWVYclhvRUhDWndFQUk2cTJKREY2N25hcnFq?=
 =?utf-8?B?OFkxSGNZVjR1TkhydjlYZjFvb29iTmdyT0g4bk9EUDd3R0FNbUNQUCtaYWw3?=
 =?utf-8?B?RWhOMEJjUWg2Qlk2TjY3aDdacVFheE5vNVZ1cEp1Y2dsZUxXaFR2czErZFlr?=
 =?utf-8?B?akhNOGRIaFZVb2crcnFSenVtKzRLbElya2d6MERHT2Q2cHJUZDFqNW5HSlRP?=
 =?utf-8?B?VDFZdGRkVUE1VC9ybUZXL1dyWmN2Y21ybTNjcWxYUDVXWUdYTDh6WW14dExU?=
 =?utf-8?B?a1huR1pSWWtpN3E0ZjlVZm5vcGZhMkpaR3p5K25hQkI3Z2JOVGpSSmp6V1la?=
 =?utf-8?B?TmVLdkFwaldqYTVTVFhqMTNwRC9zYmtPNVZKd1U0bXlBRU4rQWt2RWh3bkYz?=
 =?utf-8?B?azRuTmpyejdSbjhJNks4eWhYZjhxeVZlak5nM3ppWHhVczh6c0xsZXpIMkZu?=
 =?utf-8?B?UCsvZ2ZKcDdOT2lkdXJVR3REd1FWRHhLc3RmQ1ZTVHNZRzJIR0l3MkhYbXdN?=
 =?utf-8?Q?Vna8TEvqnxO6Z4W8dH/bt9VkL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uvRu0DrjdhNbVB8gwG/bj2bRM/MHAWTIpytkLBjsKEekBBc710gJwbya9RRbGJKd87bK0FtNvA+rOP7Mo3KG7vZrG6RuBxQaNSmYLL1P1zZFyKm0Q1ugVdWFjZfO4UbUGaTi8/WfQhP4WXPiLMvqmUfJr9ozEIzYVC/ZOXQMZ2yJZlN+hTNwHHZObt0S72KwG7tN9rYLKU7dBvp7SFDeKvVzpDNfnAEH8knAqaW93/EJr9mS2iT9pmk3CSin3YnocNPzxN1uF4SLWWkjBBKXzizOYALGjVCKEZELqg4vjdRkN6XoaIIUqA49XcyIKpFK9YC00vjnnXixBCWw8T4j2s4GXqs8ApzTLm/lhCmkKefWQ2+IfwAAHRyYuO1hQUlWY+TappCDZVW0Fa4CIl8RWA/OPfPDpdp1Kgr3qyvWJqnaEDXMZv5psJFL+G3xbVN8ybDKo5CDd59mOad3Uoh0s6tLG0iyW+XuZQJs2PBGu/anE6gIdssrpu8tJXuxJZK5kV4JTnat/wJxKTIfitCu8+tLPN6UIpeVCMjEL9RhDsmpWwcN7r4emrEUuIZpLMjee27a+1pZn6lv5ig9h7K4Rybdr7o3nxVKlVIBR3aLd50CjipUhykScN4ziayEPC4AmQUcv+qKhXw8Ob+ayc/A/nDUbccDrwsbNGT9vHHY66jlCs1CnUe3VlZinmRs0yftOkIfUHdCFRm7w+BlmibV2PA8fp1hViDHDdhp4HlVpjwuN53r9WogtaBdFkxxkLapEUT9iPNgvNwZc6P2lNn+tMszzFGM5vWqKAWqHg8KSt8OrRZbCbCLRiEH8rcl8/BD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c2fc53-775c-488c-6994-08db68c301e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 08:24:56.2356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdQV9QjCQXwO//TupFIcvxcwS6f/cssCpzDaCH2ZtV1AbpFDmkeRzcZOeIPrOcTL8KQJgBaagtxfjSoKQ+PsvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7944
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiA+ICB7DQo+ID4gICNpZm5kZWYgTU1DX0lPQ19NVUxUSV9DTUQNCj4gPiAtICAgICAgIGZwcmlu
dGYoc3RkZXJyLCAibW1jLXV0aWxzIGhhcyBiZWVuIGNvbXBpbGVkIHdpdGhvdXQNCj4gTU1DX0lP
Q19NVUxUSV9DTUQiDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgIiBzdXBwb3J0LCBuZWVk
ZWQgYnkgRkZVLlxuIik7DQo+ID4gLSAgICAgICBleGl0KDEpOw0KPiA+ICsjZXJyb3IgIm1tYy11
dGlscyBuZWVkcyBNTUNfSU9DX01VTFRJX0NNRCBzdXBwb3J0Ig0KPiANCj4gTWF5IEkgc3VnZ2Vz
dCB0aGF0IHdlIGhhdmUgb25lIHBsYWNlIGluIHRoZSBmaWxlIHRvIGRlYWwgd2l0aCB0aGlzLg0K
PiBQZXJoYXBzIHB1dCBpdCBpbiB0aGUgdG9wIG9mIHRoZSBmaWxlLCBpbW1lZGlhdGVseSBhZnRl
ciAjaW5jbHVkZSINCj4gc2VjdGlvbi4NCj4gDQo+IE1vcmVvdmVyLCB0aGUgTU1DX0lPQ19NVUxU
SV9DTUQgc3VwcG9ydCB3YXMgYWRkZWQgaW4gdjQuNCwgc28gYWRkaW5nDQo+IHRoYXQgaW5mb3Jt
YXRpb24gYXMgcGFydCBvZiB0aGUgZXJyb3IgbWVzc2FnZSB3b3VsZCBiZSBnb29kIHRvbyBJIHRo
aW5rLg0KRG9uZS4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiA+ICAjZWxzZQ0KPiA+ICAgICAg
ICAgaW50IGRldl9mZCwgaW1nX2ZkOw0KPiA+ICAgICAgICAgaW50IHNlY3RfZG9uZSA9IDAsIHJl
dHJ5ID0gMywgcmV0ID0gLUVJTlZBTDsNCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
