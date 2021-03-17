Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4964BC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 20:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063F064F33
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 20:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhCQUED (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:04:03 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:62817
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233351AbhCQUDa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Mar 2021 16:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huj/EE9iTgNi9VNJQc+iKI/FtBTWuCuWrJSGqpantolw9435azVSC4Mk/QUxuwik5ywouVw2swz43ruW3tGk1Kqk4v36RnOpGE8yHsTbidwtScgKfFqkUc/lceyMzyjSQDwTg6eetySHi7pAA7Pgl110fTcJvlf1OXn5dyIW5OtYLRvAFvJdLb03HjSUCwcu1rHx0385GmoBqndYqUQ3Tm2NwJxjgyWiWC/pG95r0Q7hIrEups/qGRrLFwKN+OoyR9LaUcDV5z/EVogzaoEex8x0Yg6WSAwCp+Pb8BiZh+dxCisF16B7V+4Jy6cG4UAEOtmgFqutx7AUYH6GYZh6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16R7k/vHmCdZRi7ZpaEBS7Faq2O98toQ9Hq7sARC1P0=;
 b=Aly2edkHknDgUclk2FgKsPeLKCWdcyWZmIyfeneMqkOYh1rkQO6DlqG+nA8V+dU1hms4t2ehgE3vb03N15YzDOa7x8TLSgtQKUNhxwLWNwxw/7PkkatOgQcv9TWoAgOPImpuOdpIHgmnw9E8ZDmjgxKNDBUExWDPgkCzeBnCF9xTpZIMmq+w6CJEs3rV0AjlrrVuD+FpLP2a+yAQ2ayeC4yk8qloHYpAQFAx2Fe8OVjtT2IC797nDxT4bE2B+Q1C0JndiggpQSKyroJxnwX3Ua4LZoaGooAS+i7MztLG6xdN0nc5Aun/8+0YlYl5PEKvQmnPL/2slEhg+wCn6LHfAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16R7k/vHmCdZRi7ZpaEBS7Faq2O98toQ9Hq7sARC1P0=;
 b=LHRImBCJgW3hJEmalF/Q6SsRAmK4zROJAP9jAkbbM/r7inZCAWku5CBzQBxtu1XrLYUMPIzMuB6x2gAAR2um9louETmUmXle5DT/8TttVE3yOvdW0pZB190f/HhI8ksyt7pt6ajglQ1e6dXOFMXiyRKcK42mQExTe9ipvV/6JRhuePA40gDRU5496dxYfzg5gJxTG/dw4eaDtj9dqHqgsI+TTv2g0Y1WsluTglPcDz0Ge7DoROWxfemEgGvvMF3o+Af4gEdP0lhHqe0iJBdmkyoDo4nRzA9t1pBelHfrHdzS9qvoT0Emg23esTm3IU3Po1rH25mj7DrYTkFX/Cd3vg==
Received: from BYAPR12MB3557.namprd12.prod.outlook.com (2603:10b6:a03:ad::31)
 by BY5PR12MB4817.namprd12.prod.outlook.com (2603:10b6:a03:1fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 20:03:28 +0000
Received: from BYAPR12MB3557.namprd12.prod.outlook.com
 ([fe80::5cba:37fd:e15:2d50]) by BYAPR12MB3557.namprd12.prod.outlook.com
 ([fe80::5cba:37fd:e15:2d50%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 20:03:28 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] mmc: sdhci-acpi: Add support for NVIDIA
 BlueField-3 SoC
Thread-Topic: [PATCH v1 1/1] mmc: sdhci-acpi: Add support for NVIDIA
 BlueField-3 SoC
Thread-Index: AQHXFqRbrJDl4sCpM0SDcm8Vo3MluKqEvngAgABU/YCAAALUoIAAXOCAgAMwX2A=
Date:   Wed, 17 Mar 2021 20:03:28 +0000
Message-ID: <BYAPR12MB3557199EC1DDEDB07F30DC0AD36A9@BYAPR12MB3557.namprd12.prod.outlook.com>
References: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
 <8236f89c-720e-f8bd-86d0-9654175de659@intel.com>
 <MN2PR12MB361668C9AC2463E1E89478E0AB6C9@MN2PR12MB3616.namprd12.prod.outlook.com>
 <BN8PR12MB35561363D36DA2E37DBA5461D36C9@BN8PR12MB3556.namprd12.prod.outlook.com>
 <040a6307-9fba-0185-f913-a81816f1da62@intel.com>
In-Reply-To: <040a6307-9fba-0185-f913-a81816f1da62@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [173.76.169.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46386063-2e83-4fcd-ceda-08d8e97fbb49
x-ms-traffictypediagnostic: BY5PR12MB4817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB48172A4FC6001402D69A690DD36A9@BY5PR12MB4817.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f+6vZINBe07sZrfIPtgjWKtlXM7eTMzcQ7IbEmTRBx8EO+1ZmiRc0zVZi4736FqwV2eYCJdFLrNNS9vSWVg5ShDG4ppDvov6aG9IbxdOw6IgsCJhl3dpT62eNDDKzgb8YgyTFUZTG4Kzt4eCAvQq6jBkh2BF9YQ09diVSl5QK3IiXe4dC4ydn2MNtEyaaULIDKe9uiBlCRu4LMxyMyqKpFL+4ng88szBCvQNyiQoD2r5hsOoa17ermByujstxiiKKjDnC0Q3lJHbA900G9jVlCiuA5I+iTJUiHeCDWamJK4jP+5dqwBN0aExUrisJgyBjzi6dAB35XBJXBv5BpT7M0RnFz5ZLYMbkJ1bhP/XfiRY1yU5vN8ObYhinGBaPX4GfZV3ITLf+YF1jcG8kqxUXcQMLzn6BO43mIPrnLRaSgI00Rrrh4xsYj6gtEtwaywrE0HbHPhtnKnlrIeosnkx8W8MhU1ySv82+xeOycqwAFfD92HMGQOc7a0LOJTHedBh7vx+ARGet11hfvPBuM8Ajq0R8fP0R8PJkpyhPYn+PwuF4jPf8K8QlYETgLKuESkN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(54906003)(52536014)(66476007)(8676002)(64756008)(5660300002)(9686003)(8936002)(66946007)(110136005)(7696005)(66556008)(26005)(316002)(53546011)(76116006)(71200400001)(4744005)(83380400001)(478600001)(33656002)(6506007)(4326008)(2906002)(55016002)(186003)(86362001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bVFidWJGSEhBdFZyYm9BUVd6Zy9mMHFvb1VVT3BOZzRtTFkxaE1NY2tFSjRj?=
 =?utf-8?B?Y2E3bExHaDAveW1iY1ZLTnhxdzErTndoMEVITjV0aThSN0NCakhzeXMvT1Vt?=
 =?utf-8?B?QThOK0RuU25JaEZPVnFaMDJpLzZyNm4zc1BySG9NZzlGSTBDUVpXeENINW1X?=
 =?utf-8?B?a0RPdHBkMzl1RkRVM0hyWDBWaWdSWVcvemZYdEdhTFI1VXpmeEh6eUV4dWR2?=
 =?utf-8?B?S1RSSXExY0VhRlBSUVptbWFYeXJYTFRyZklnZSszMFJmcEZ6UmY0T21tczFY?=
 =?utf-8?B?ZHM1WkZPOFJ6ZzBYZGl5a1hTUzNxUjZubi9qRHBqZ1RySzRoUEF6djdwdU1P?=
 =?utf-8?B?aEFRZjYyUGVvTXF0R0RzQndFcHZIdjRIa2xMbzJQWFZuV3BHUjRFMmpiVkVy?=
 =?utf-8?B?a2p1K0JVRFZNZkwxMWt1bEdQLzBIdDY3akhDWGdiN2FzMkJ0U043S1haYkVC?=
 =?utf-8?B?RmpVTWQwaDRrZUFqb2NKVjR0UE5Kd0hJb0w2UGNxRjVONzFqTDd3WXNZelRa?=
 =?utf-8?B?b1hEK1N5NUxhSnZWSjBDYXp4dkdTekpkRVkvL1c0cWdXV1FXUzllby9aL1A3?=
 =?utf-8?B?SWdkZ0huVjBXKzVLT2NXKzNHTXdhQThiSVZma2pPNnBWZEp4RW1nc0xSeVZx?=
 =?utf-8?B?eVI5WGpvUy9oLzB4QWZjTzhDNCtQeXpLUWxxai9SbXVHR0dpRDcwMG5RcjBv?=
 =?utf-8?B?bnZXMW9HRm9aYmxGNjBMQzh2YkFCRnBqbUtEYW9OTHhoVHFaOExqRXhrdzBB?=
 =?utf-8?B?WkMzRTRDR3NBWEhMYzVaalJTczJLN3BCSDhHN0x6bnh6MEdqbVAwQXdJbHo0?=
 =?utf-8?B?ckxJS01yWjRLVDRCUEY5UTByZjl0OGxXMzZnbGV6RlgxYWZlbk1BQ0t6U2VF?=
 =?utf-8?B?WEhsSWwrVExOODVBMENlZUd5VUtJSVQ2c2xBenk4MmQ0TnkzdnVjN0RtNEdC?=
 =?utf-8?B?bUNuMkJJQS80UkZ3ZFBBRGtWRTZSaTdmekhsU2tldGhDM3BtbWVOUGV4QnhY?=
 =?utf-8?B?WCtZcWxiMWJhazZ2WDFlVTBNcmgzaHdLVFR6Ty9jZHdUenB4azYyWUlsa3VO?=
 =?utf-8?B?dW1QaDVkVUFZYUprazJWUFBwT2JaRWU4ckpPcWtnZGZxNHlwbTBpNDU4ZDhC?=
 =?utf-8?B?R3d0emlTaFRXdmlVaXphejBjRFZHdkg3SEp4eDBtUTFKWGMzMnpQQm8zWFFw?=
 =?utf-8?B?dEQvTnB1N1FsRGUvcTdrWjlqblRVeVZSVEFJM3N4OUhnaEFQZFdEOU9xMXdM?=
 =?utf-8?B?bURxS1hNZTRXOWtyY1AvTmJ5VTBGRlNOTHg1Y0M4TFBhU29iN09jWkJad1lF?=
 =?utf-8?B?WDRHRWVrQTdMWmQ2YUVSSGFWL1hUUW10NEh1UFp2VGIzUlY0OWNxWDVHQXV6?=
 =?utf-8?B?MVl0RWlpUGZXeTFxSEpuZEx4Z2ZaMWlZblkreW9UbGRMQ3p6anFveWRpd0ZU?=
 =?utf-8?B?ZFJsdjB1aDRRTUxuOW5NeU5aR3RhMUdyUUxPNE5EeWZpMHFkZU1hODBUTTV4?=
 =?utf-8?B?SnUxMHFST1VTWC9lMVdRYXRISDA5ZzFlWHpHZ0IxSU56dG44NzNCMXpKRGVR?=
 =?utf-8?B?cEY5a3hsTkRVTjQ4VG9LN05YbkhCd3U3L0hSQnI5d1pJTVBIZ21nWGwzelF3?=
 =?utf-8?B?QnpIUEhvRGZ3WmhQengyT2l1dE1QUjA1bzhuazhWMWRyZXRwSm54OVBvNTho?=
 =?utf-8?B?bk84VFI0MnM2MmhzTHFJd3V1RTI1L3d3cG1INE40WmFWajNFOXJXODd6SnNJ?=
 =?utf-8?Q?YUoEFRnKLEpeDP3qrCzA7qeZmT+cwXiV0zEkixj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46386063-2e83-4fcd-ceda-08d8e97fbb49
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 20:03:28.3750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUo7GPlJxZd+HLBYIKJuLe04YicDqMhCbJ9kmb3hDN4LT3t6VeRthtyX9jfz6Mvovi8DBETFjtURhQonHF4/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4817
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJp
YW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAxNSwgMjAyMSAzOjIw
IFBNDQo+IFRvOiBMaW1pbmcgU3VuIDxsaW1pbmdzQG52aWRpYS5jb20+OyBLaGFsaWwgQmxhaWVj
aCA8a2JsYWllY2hAbnZpZGlhLmNvbT47DQo+IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5h
cm8ub3JnPg0KPiBDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgTGludXggS2VybmVsIE1h
aWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjEgMS8xXSBtbWM6IHNkaGNpLWFjcGk6IEFkZCBzdXBwb3J0IGZvciBOVklE
SUENCj4gQmx1ZUZpZWxkLTMgU29DDQo+IA0KPiBPbiAxNS8wMy8yMSA3OjAwIHBtLCBMaW1pbmcg
U3VuIHdyb3RlOg0KPiA+IFRoYW5rcyBBZHJpYW4uIFllcywgSSBkaWQgY29uc2lkZXIgYWRkaW5n
IHRoaXMgQUNQSSBzdXBwb3J0IGludG8gc2RoY2ktb2YtDQo+IGR3Y21zaGMuYywgYnV0IG5vdCBz
dXJlIHdoaWNoIG9uZSBpcyB0aGUgcHJlZmVycmVkIHdheS4NCj4gPiBJcyB0aGlzIChzZGhjaS1v
Zi1kd2Ntc2hjLmMpIHdoYXQgeW91IHJlY29tbWVuZD8gSSdsbCBwb3N0IHRoZSByZXZpc2VkDQo+
IGNoYW5nZXMgaW4gcGF0Y2ggdjIuDQo+IA0KPiBZZXMsIHRoYXQgaXMgZ2VuZXJhbGx5IHByZWZl
cnJlZCBJIHRoaW5rLg0KDQpUaGFua3MgQWRyaWFuLiBQb3N0ZWQgIltQQVRDSCB2Ml0gbW1jOiBz
ZGhjaS1vZi1kd2Ntc2hjOiBhZGQgQUNQSSBzdXBwb3J0IGZvciBCbHVlRmllbGQtMyBTb0MiIGZv
ciB0aGlzIGNoYW5nZS4NCg==
