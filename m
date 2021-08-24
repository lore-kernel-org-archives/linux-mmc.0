Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EEBC4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D17161265
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 15:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbhHXP1X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:27:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:55449 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhHXP1X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 11:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629818799; x=1661354799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x8L1RlmpPTImQ3BlyOwQ5fPjpuvun/n+Dk3NsRzPgSI=;
  b=Svjz+6xZ989qFHEm6Ndeb6FcA2Lh/tGZjHkbyFNzB2dB0/ZSILpgItLX
   14EFx03bwWsniwZTyFJyMO4QrN3LrHYxgcPZx7etNLvPcL2B4Ud6K8vwz
   UOweZT4E399iomw0ZkSF3mdjx2qaeGeZWMf7rzgu/4jS1CqaLVUhrxDrN
   2sqFirDl41R4pGDWtqmN9bxJTbyXvSAUHqWcl2j0+aCvGGFCfV3CKuZ/U
   IBTDMJemgm0bkcPcW0QkM6Kgquuxp7xi9mx5EgFeV9Uvx84yn91kArGV8
   eQualnP0pcziW/MH4llEn4548i2Wm0Z/uSOB1bsfDD74F6rYCscTe4jyO
   Q==;
IronPort-SDR: tofQu/kug+M3QHK/RfDwzS52C88BStETSajG+TbZMKeyjIMxFYgmrLl7P1s1phBR5mUASNf8Ot
 sWB6Jdm8wwfOXKoQGzNcwmk3qX6Xx49i7Bh1+GRCRXMRH4boo7JXEVx8CaE37+aKTLbBibnJXo
 BVfy2BeAduVCcFOfVTjRv+E69KYPcMgBVkKutpmpysSxsBNcbwuZAEuPL+5FY1ZO9aEpDQF+09
 BRZ0glp4UnqDiGjLpLxNfiSteGr6ek7ah22cI8v25s46fGkcpKEVe6b8Tm4T3m5m9ZaPdTbles
 OD9r7t9DycdMdgkO3iQzU5nx
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="129393872"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2021 08:26:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 08:26:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 08:26:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ6lRhhs6kTqd3VNo3NRMJAYt5wFVZJpBYTldQ7D8jxF7RQA3wPGf2gNFqgW01Q52y9wsAe2sn8yEEnhhbXrEH73Su8s/qbYgE/NYk7+02uTOBv1WhnwuhoKAbCCz/LP6K9/BtzMVpoihjiDuVmPRcWUK9dB9s11R8bwQQZUX5ZwfH3G3ZGN5uKLfCa6XY4XRKuMrQm01eu0/Gz/+2ge2WEX4XA8D83YeUeFo0070eZ/m5qWtZTrVcLxYvgxYYGFpXIozdQj4xIfQKeRl+7NehLtR4DQKiZpe4a0Zld01Nu4D4d1dc5p8z2okz805tf0+lx0On3RTg7nzAkgWNkGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8L1RlmpPTImQ3BlyOwQ5fPjpuvun/n+Dk3NsRzPgSI=;
 b=NYUXLXj6pFM5Xu86AZ6dbrUR1/842a8NZu7Ly1k+SIMBtrqQjWEoCB/D5yEotRbmDdaOlGLigBN+AUxM+evxWQGxuDxTB4WiHQrF3AO2o+bs+SOlxbPH2nu1HtblRgZAfEZPpSHj9p2vfgi8bcEPD60SHUPkqX4IcPWpe9RyzsNqpxxKxFtL8ozp3r9nd7m4z16XCmVgARkiGF80sYcEASPXDYjYu/VdHQHUdTrX5g68lXOjrSzGJqAH9PVsnmC4pisnH9w9/9DfvD/Lp3bR9jKkmntjKCe61aDhs+JnoeiOhWgSm425wXoyRE1ghjaJQF0f+6HTsjlzjy7Nss05+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8L1RlmpPTImQ3BlyOwQ5fPjpuvun/n+Dk3NsRzPgSI=;
 b=FWHdUIeEJPbBitPB4yD+GKUX/RoLcXdhImAAC+AwjXy40raOsypXgQt6WhmgBJ1tpKbeyAqRbUFXlMOnv2r4S57/DrFFLt7Moe1ABDrhkFQiknv56StDbCyIyOgYGWbFw2O3Qc+8JGPkagmzkpeQ2sn4p3Q5LkFB19zPDPH2vUk=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM4PR11MB5280.namprd11.prod.outlook.com (2603:10b6:5:38b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Tue, 24 Aug 2021 15:26:35 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 15:26:35 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh@kernel.org>
CC:     <ulf.hansson@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Eugen.Hristev@microchip.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: at91: sama5d27_wlsom1: add wifi device
Thread-Topic: [PATCH v3 4/4] ARM: dts: at91: sama5d27_wlsom1: add wifi device
Thread-Index: AQHXmPxszl5tL8IUMEmMTiX1/0qwAg==
Date:   Tue, 24 Aug 2021 15:26:35 +0000
Message-ID: <2ccefcb4-cf6a-a675-4ff3-b7a2d314333a@microchip.com>
References: <20210820092803.78523-1-claudiu.beznea@microchip.com>
 <20210820092803.78523-5-claudiu.beznea@microchip.com>
 <YSTk1pUTAUJLBJQl@robh.at.kernel.org>
In-Reply-To: <YSTk1pUTAUJLBJQl@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2de28813-fd5a-4831-29e5-08d967138f2b
x-ms-traffictypediagnostic: DM4PR11MB5280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB5280CA795373DB3DC897C1D687C59@DM4PR11MB5280.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0/jxjxmm+fdEMjtwFdVZhR6tjWBUZfVyj3UtjE+R6c1WuqPzzpWcn9zeSlyhqcm8jnTu/gI150F6hjYvVuAU78dLPFFBfYjQ0trrDqpDO5rMDUrJyIl0dnLlWAObReOIQ/MdCx0Iz7YJuBerI/CNeWrko3HqHgrDf/a2bLZPPEizIERAjOhYZmv3RtxF83JhfwS1ixqy9uBrE0Qx5I74ZkS50ng4duaZQhzPgcvqqQHdA0Az2z5I2mWm5tWYsII5RlxSwqPu9NFJoSiScm+U26yhj3v/E/zTlAQiJL3oCjHYJNoMVXwpeN0+zQB74/YDPmU5LnXxMaH1B9DXjrRBTQpSMBbdgCZ0TGZQSVEVY/KNjJyVMIIWRGlUheBqBGif2l8at1Qxh8S8aNupw5jUfbTLUSNA0zgbue1mLXjKdG8CZiMAa3VpYiBPbsniSCeF1oi7u/GQ+KXqhIqk1HJS5qexlicIr256zxrLJ3zFJYhJ5mlrat1RNNt0YFsbfQ6uWryE8eMn4FyBdxFXvoBu4Kv74xWAg88SNJ/X9JQskEZZJovCU/2oA+P5QFL8cDzEm9Dy/wHc6EznIUncV6LpBEVDSPYJZMs1sHeSOeD0Lt+MrfBPh82Iveh3ite4asmqku3QB+OFGOgh/zA5FSEql3dK8WYWdIPVbe+wSgjRoB7a4f9a04RWPsKNQ/fcuMGdQ5N3kvoRjzMb9bT7D3bM/5rkU26A0r595I19qrhFbp1IUpTFsuhBW7TEOJeM0TnHkrmZWzezV87Q5PuB9GtUwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(6486002)(186003)(31696002)(54906003)(31686004)(6506007)(38100700002)(36756003)(478600001)(83380400001)(2616005)(122000001)(71200400001)(38070700005)(316002)(6512007)(8936002)(76116006)(107886003)(66476007)(66446008)(66556008)(64756008)(66946007)(6916009)(8676002)(91956017)(86362001)(4326008)(26005)(5660300002)(53546011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjZ6a3pDRkllZDJLZFhDajl6czBoYUdlOXVmSFFHa2ZVd0k4aGlYYWx4TnRh?=
 =?utf-8?B?K2VRVG41YXp0N0dwT1U2MTdIMjg2aXpMS1ZDWnVlempBQ2MrdWRJVXFGYVlK?=
 =?utf-8?B?YW0vd2xCN1VIcy9Wd2M1Q1NqTUxUYkVVY21rVHZlOTlqUXhxWGE2OTJ4Y1Rw?=
 =?utf-8?B?NldTMjgwVXhWdVBTZU9yNTFYWHNrUU92ZzdlNGFpR2tacldzSVdNbmVraXph?=
 =?utf-8?B?Sy9GdTF0Ynd1SFk4eHVhZWIrbTBqb1ZLVHNTZ3ZLcnFpck5NanNtMmg3dzBa?=
 =?utf-8?B?TzUvUG0ybnpOOXlkMnR2YnV5ZzBrWHdFOVJWd0p4TGV5d085ZnJBUGRsVDQw?=
 =?utf-8?B?THQxaFZkZ2k1bXFtS3h2akNDblVCcXJWaWJsV3d5MExvVDdzT0k5NmZMa09M?=
 =?utf-8?B?UEJ0ZWNXMFRxekVhejJ2cmZKL3p4K3dsOFk2R3JtU1pVdnZkaWNEZlZ2bytT?=
 =?utf-8?B?bXpGNUVKV2RhRlZJRUFlUEpEYi9WZVVZZkdKSG95dWdRMEl5Lzh5VmlTZ29i?=
 =?utf-8?B?UndmYzNFbThRYlZUVitqNVZXYmoxWldjWkhzZStBMjhGbHJkbjBSbnV6c0Iz?=
 =?utf-8?B?MTNPMU1JVlJBMlZrTXNmZ0dHQllDQXBXT1Axc1Rsc0kxemUrWWFPUlFkaFhx?=
 =?utf-8?B?MW5YTzl5UGJEd1lUL2JIVHhmZzdNYjR4dGtvUmh1a2pqdHptaEF2RHdZZkxE?=
 =?utf-8?B?RHNzdVBXUEZ6akV3Rll2SlMxd2ovSzN1ZHlPekRHWWZaMlZsUzkvcXZmVTVN?=
 =?utf-8?B?dVZCdUsvVEdqZGRXNU9VWkxLVVM5RkY1TEVxWHB6ejdRSVBJVmNNd0t4YTBv?=
 =?utf-8?B?ZVhmZm52YnpkYW1KejZxclE0Q2h4R09OSlc3bExZREpxV1VsQ1I5S1BHWHcw?=
 =?utf-8?B?NW83TXBZT0h5alJmb2hsdU5LdWQ1V0ZaT202SXU5V3ZmbDhSNFBCUGcxSWwv?=
 =?utf-8?B?U0RINkhaVVVGUHJla3FDNm9reGpWMUllMzEyY3dzNWUwUEw1eE9oTXJZZEZX?=
 =?utf-8?B?M2JKbXVwQlpYN0RRL1NhV3Z6UDRKZnJKZWhyTmRla0FVQ24rN0kxbE9ZNWsx?=
 =?utf-8?B?cmFiWDYrNzFBQ1BWaEhIWk1lVlIvbTVsVzRsU2VuYitNdW9vOWo5UElkNUxD?=
 =?utf-8?B?cGZJbTBRVlJCM09kV01qK09WWEtONG1yRkE4c1NScEJhdEJxV1IxN1JweXlV?=
 =?utf-8?B?dGRkL2pHQ09INCtRSE45OWk0bDlFU3Y1cmZOek8yYWJ2NTVXWUFPVFBPZjRk?=
 =?utf-8?B?MGFDTG5VRU95VHljTFdKdWtac3o3TUpkUHRqWnV4ZFQxNXM2eFB1UnRqMkY3?=
 =?utf-8?B?ei8xQWhUZVZoK3UyZW9EWGZtcDVScDRuSHNoMEc0RWRIU2dyZEZFTXNuS2NI?=
 =?utf-8?B?bEhEZ3V4elY0N0RZVUt6S1htZHZHSDI0dStkc1YwSFkrSFlxVTV6ZUw4MGw0?=
 =?utf-8?B?RVNVN2NlTFBwekNzM2FjYW1OZVhwVy9WWlUvY3RyQzcvMGhLY2NqalhYZkkz?=
 =?utf-8?B?ekF6MW8rRnZ5dmJydTdNbHFHQnZ4cWM2YURYdENVbG1WRlI4YVQydTdMeTh1?=
 =?utf-8?B?NVVqenJJU1J1N1FKMGlkeHFpcFIrNHg1NHZteHRJVHd2amJ0b0dLdUphVll1?=
 =?utf-8?B?K2NSQ0tYWGtnTERDbGJFa293bTBoejNrbkk5Q1lOZUhOTmxCNm5GK2FYd0xC?=
 =?utf-8?B?NVQ1ZFRTOEJYN2UrQzFBdVFlV1R6NlNCdFZqZGFidFJNNXZmMVVrSGlRWmxs?=
 =?utf-8?Q?yQGM7FmQcnGH/CyTPo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E5A952863162B4C9E456A52E15BD396@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de28813-fd5a-4831-29e5-08d967138f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 15:26:35.2116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZcXyY09DMHavYBq8wS+9VKv51Qx73WjEmB8RTllg6rWMO9PbUxIJJitHb/83bXRW5zxcZ5TfuB9qEeKY7/90d4xHvRguAC5n8cvA0ITB4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5280
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gMjQuMDguMjAyMSAxNToyMywgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gRnJpLCBBdWcgMjAsIDIwMjEgYXQgMTI6Mjg6
MDNQTSArMDMwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBGcm9tOiBFdWdlbiBIcmlzdGV2
IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gU0FNQTVEMjcgV0xTT00xIGJv
YXJkcyBoYXMgYSBXSUxDMzAwMCBkZXZpY2Ugc29sZGVyZWQuIEFkZCBwcm9wZXINCj4+IGRldmlj
ZSB0cmVlIG5vZGVzIGZvciB0aGlzLg0KPj4NCj4+IFtldWdlbi5ocmlzdGV2OiBvcmlnaW5hbCBh
dXRob3Igb2YgdGhpcyBjb2RlXQ0KPj4gU2lnbmVkLW9mZi1ieTogRXVnZW4gSHJpc3RldiA8ZXVn
ZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPj4gW25pY29sYXMuZmVycmU6IG9yaWdpbmFsIGF1
dGhvciBvZiB0aGlzIGNvZGVdDQo+PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNv
bGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5l
YSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL2F0OTEtc2FtYTVkMjdfd2xzb20xLmR0c2kgfCA3MSArKysrKysrKysrKysrKysrKysr
KysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDI3X3dsc29tMS5kdHNpIGIvYXJjaC9h
cm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyN193bHNvbTEuZHRzaQ0KPj4gaW5kZXggMDI1YTc4MzEw
ZTNhLi5jN2JjZmQzY2U5MWQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkx
LXNhbWE1ZDI3X3dsc29tMS5kdHNpDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNh
bWE1ZDI3X3dsc29tMS5kdHNpDQo+PiBAQCAtMzAsNiArMzAsMTUgQEAgbWFpbl94dGFsIHsNCj4+
ICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1mcmVxdWVuY3kgPSA8MjQwMDAwMDA+Ow0KPj4g
ICAgICAgICAgICAgICB9Ow0KPj4gICAgICAgfTsNCj4+ICsNCj4+ICsgICAgIHdpZmlfcHdyc2Vx
OiB3aWZpX3B3cnNlcSB7DQo+PiArICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibW1jLXB3cnNl
cS13aWxjMTAwMCI7DQo+PiArICAgICAgICAgICAgIHJlc2V0LWdwaW9zID0gPCZwaW9BIFBJTl9Q
QTI3IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPj4gKyAgICAgICAgICAgICBwb3dlcmRvd24tZ3Bpb3Mg
PSA8JnBpb0EgUElOX1BBMjkgR1BJT19BQ1RJVkVfSElHSD47DQo+PiArICAgICAgICAgICAgIHBp
bmN0cmwtMCA9IDwmcGluY3RybF93aWxjX3B3cnNlcT47DQo+PiArICAgICAgICAgICAgIHBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiArICAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsN
Cj4gDQo+ICdva2F5JyBpcyB0aGUgZGVmYXVsdCwgc28geW91IGNhbiBkcm9wIHRoaXMuDQo+IA0K
Pj4gKyAgICAgfTsNCj4+ICB9Ow0KPj4NCj4+ICAmZmx4MSB7DQo+PiBAQCAtMzEwLDUgKzMxOSw2
NyBAQCBwaW5jdHJsX3FzcGkxX2RlZmF1bHQ6IHFzcGkxX2RlZmF1bHQgew0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICA8UElOX1BCMTBfX1FTUEkxX0lPMz47DQo+PiAgICAgICAgICAgICAgIGJp
YXMtcHVsbC11cDsNCj4+ICAgICAgIH07DQo+PiArDQo+PiArICAgICBwaW5jdHJsX3NkbW1jMV9k
ZWZhdWx0OiBzZG1tYzFfZGVmYXVsdCB7DQo+PiArICAgICAgICAgICAgIGNtZC1kYXRhIHsNCj4+
ICsgICAgICAgICAgICAgICAgICAgICBwaW5tdXggPSA8UElOX1BBMjhfX1NETU1DMV9DTUQ+LA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxQSU5fUEExOF9fU0RNTUMxX0RBVDA+
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxQSU5fUEExOV9fU0RNTUMxX0RB
VDE+LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxQSU5fUEEyMF9fU0RNTUMx
X0RBVDI+LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxQSU5fUEEyMV9fU0RN
TUMxX0RBVDM+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGJpYXMtZGlzYWJsZTsNCj4+ICsg
ICAgICAgICAgICAgfTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgY29uZi1jayB7DQo+PiArICAg
ICAgICAgICAgICAgICAgICAgcGlubXV4ID0gPFBJTl9QQTIyX19TRE1NQzFfQ0s+Ow0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgIGJpYXMtZGlzYWJsZTsNCj4+ICsgICAgICAgICAgICAgfTsNCj4+
ICsgICAgIH07DQo+PiArDQo+PiArICAgICBwaW5jdHJsX3dpbGNfZGVmYXVsdDogd2lsY19kZWZh
dWx0IHsNCj4+ICsgICAgICAgICAgICAgY29uZi1pcnEgew0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgIHBpbm11eCA9IDxQSU5fUEIyNV9fR1BJTz47DQo+PiArICAgICAgICAgICAgICAgICAgICAg
Ymlhcy1kaXNhYmxlOw0KPj4gKyAgICAgICAgICAgICB9Ow0KPj4gKyAgICAgfTsNCj4+ICsNCj4+
ICsgICAgIHBpbmN0cmxfd2lsY19wd3JzZXE6IHdpbGNfcHdyc2VxIHsNCj4+ICsgICAgICAgICAg
ICAgY29uZi1jZS1ucnN0IHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBwaW5tdXggPSA8UElO
X1BBMjdfX0dQSU8+LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxQSU5fUEEy
OV9fR1BJTz47DQo+PiArICAgICAgICAgICAgICAgICAgICAgYmlhcy1kaXNhYmxlOw0KPj4gKyAg
ICAgICAgICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgICAgICAgICBjb25mLXJ0Y2NsayB7DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgcGlubXV4ID0gPFBJTl9QQjEzX19QQ0sxPjsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICBiaWFzLWRpc2FibGU7DQo+PiArICAgICAgICAgICAgIH07DQo+PiAr
ICAgICB9Ow0KPj4gK307DQo+PiArDQo+PiArJnNkbW1jMSB7DQo+PiArICAgICAjYWRkcmVzcy1j
ZWxscyA9IDwxPjsNCj4+ICsgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKyAgICAgYnVzLXdp
ZHRoID0gPDQ+Ow0KPj4gKyAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+ICsgICAg
IHBpbmN0cmwtMCA9IDwmcGluY3RybF9zZG1tYzFfZGVmYXVsdD47DQo+PiArICAgICBtbWMtcHdy
c2VxID0gPCZ3aWZpX3B3cnNlcT47DQo+PiArICAgICBuby0xLTgtdjsNCj4+ICsgICAgIG5vbi1y
ZW1vdmFibGU7DQo+PiArICAgICBzdGF0dXMgPSAib2theSI7DQo+PiArDQo+PiArICAgICB3aWxj
OiB3aWxjQDAgew0KPiANCj4gd2lmaUAwDQo+IA0KPj4gKyAgICAgICAgICAgICByZWcgPSA8MD47
DQo+PiArICAgICAgICAgICAgIGJ1cy13aWR0aCA9IDw0PjsNCj4+ICsgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJtaWNyb2NoaXAsd2lsYzMwMDAiLCAibWljcm9jaGlwLHdpbGMxMDAwIjsNCj4+
ICsgICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+ICsgICAgICAgICAg
ICAgcGluY3RybC0wID0gPCZwaW5jdHJsX3dpbGNfZGVmYXVsdD47DQo+PiArICAgICAgICAgICAg
IGlycS1ncGlvcyA9IDwmcGlvQSBQSU5fUEIyNSBHUElPX0FDVElWRV9MT1c+Ow0KPj4gKyAgICAg
ICAgICAgICBjbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9TWVNURU0gOT47DQo+PiArICAgICAgICAg
ICAgIGNsb2NrLW5hbWVzID0gInJ0YyI7DQo+PiArICAgICAgICAgICAgIGFzc2lnbmVkLWNsb2Nr
cyA9IDwmcG1jIFBNQ19UWVBFX1NZU1RFTSA5PjsNCj4+ICsgICAgICAgICAgICAgYXNzaWduZWQt
Y2xvY2stcmF0ZXMgPSA8MzI3Njg+Ow0KPj4gKyAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7
DQo+IA0KPiBBZ2FpbiwgdGhhdCdzIHRoZSBkZWZhdWx0IHNvIGRyb3AuDQo+IA0KPiBEaWQgeW91
IHJ1biB2YWxpZGF0aW9uIChtYWtlIGR0YnNfY2hlY2spIG9uIHlvdXIgY2hhbmdlcyBiZWNhdXNl
IEkgc2VlDQo+IG11bHRpcGxlIHByb2JsZW1zLg0KDQpObywgSSBoYXZlbid0LiBBcG9sb2dpZXMh
IEknbGwgZG8gdGhlIHByb3BlciBhZGp1c3RtZW50cyBpbiB2My4NCg0KVGhhbmsgeW91IGZvciB5
b3VyIHJldmlldywNCkNsYXVkaXUgQmV6bmVhDQoNCj4gDQo+IFJvYg0KPiANCg0K
