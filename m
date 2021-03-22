Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A915C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 22:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A14619A5
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 22:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVWsJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 18:48:09 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:2556
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230095AbhCVWsD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 18:48:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I85fmeq5X0xiltDw0Fuo7jjH2gguA3CVolVDYXZ3u4qHIRR47wPf77Z11C6mF7Rm7YC+J9p+9eN7ZpyZe+hLvz1cnW29fCiXw3vm2hyxAsxezedp/rsBwKgmO3EMjjfjeZdRB0Jatr4PT7feLnVX8++woqaca3b/QyBBIK8xnQaRxlzwEPrjHLqffzmh2NGl9dYNrvYRKWkjK17utO6sHjuuyrtZHLyADPrroRUaaYfhT1hdl7fmWet/I0kEalOUlFiCr0ZqahKGu59jQPIVrQbQfp0I5szoMvB4pRVBsoqEzdzihCFVZfK2SNFJ9T6DPcUvDyiOCbSRwPN8/yPSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXAACne6nSJKldoWfvVpftnogW8BQ0SS1AmshSrVR14=;
 b=Ytng1iU8C0nmEXaAinm4ZhNac8X3EMM8aeEboJCsGUXj0EnasZb2D2GhC0oFaFWh0GY+sqCO3s7MOsxhuOgbo1YRLzIbMTouk1Bgo3qGYe3Gne3s+fQnllTFREcmuimEi/6Jr7tCeJH0ZNLLzc+NTZxijOG5qOCDMsLw2Vzg3xkynkaCov+8Sb/OduoLTvv8cze5h6XDCrOedNRO6OIocYm+KpuHxD7MVCQiMadOXxXCF/UP+/T07Ha5ovPELKumr/pUjhabh6ljyxYdOagMKc9lKQhdg/bS6DoWnayVnwJ8tLsC3zF3v1jYIwKHWVi355oo1fytruzrroaWdXmOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXAACne6nSJKldoWfvVpftnogW8BQ0SS1AmshSrVR14=;
 b=Wygab4R52DqRF1N4XPhqD91nbZIOojTtqE3hOd5jIoV/krD5CEOzkwZ0Fm5+9yxH1uBZEO9MtK3ySCp4PxSsCs1MnJj055xHPVw3i5pTgKemiVrD8U8ukJZjXR+ZLGpKFVuwV1KKD2ZiqtBtKJySq68aehVrt7d5kat1cqQRZ2AaKBPtftM4kfUkb2TR4yWur61gNoVLzlvvEfUt1/UPQL9FAI3D/O5fmFB3a8Op127+PD5CPDqQaNH8uCTGOUvSVD6T8Y2K1GBoY1fcZUrHh+0iDu9cjj1K93jWCYX7nzGZCAd1rn0z9EkyC46ezfWbAYJXO9/XAcRplTDNgJbedg==
Received: from MN2PR12MB3565.namprd12.prod.outlook.com (2603:10b6:208:c2::24)
 by MN2PR12MB3136.namprd12.prod.outlook.com (2603:10b6:208:d1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 22:48:01 +0000
Received: from MN2PR12MB3565.namprd12.prod.outlook.com
 ([fe80::7093:3ff0:8030:d3ed]) by MN2PR12MB3565.namprd12.prod.outlook.com
 ([fe80::7093:3ff0:8030:d3ed%7]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 22:48:01 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: sdhci-of-dwcmshc: add ACPI support for
 BlueField-3 SoC
Thread-Topic: [PATCH v2] mmc: sdhci-of-dwcmshc: add ACPI support for
 BlueField-3 SoC
Thread-Index: AQHXGrrnmsxRDSsOTUGr3Ir2I4RWzqqLXlMAgABmfHCABAdiAIAA2Ogw
Date:   Mon, 22 Mar 2021 22:48:01 +0000
Message-ID: <MN2PR12MB356568531421801177461CFCD3659@MN2PR12MB3565.namprd12.prod.outlook.com>
References: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
 <1615936797-245197-1-git-send-email-limings@nvidia.com>
 <CAPDyKFpvuKU50T1UXfo-H5=gesOwqH4rW4sok4sYOZBgFijt2g@mail.gmail.com>
 <BN8PR12MB3556CA0C1635FFFD50390CDED3689@BN8PR12MB3556.namprd12.prod.outlook.com>
 <CAPDyKFqnUDCOmJe0aH7USXrAwktB1-GYz-MAr04dHF7iEG10DA@mail.gmail.com>
In-Reply-To: <CAPDyKFqnUDCOmJe0aH7USXrAwktB1-GYz-MAr04dHF7iEG10DA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [173.76.169.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 942810c7-d479-4c0a-3405-08d8ed848c37
x-ms-traffictypediagnostic: MN2PR12MB3136:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3136390861B2181D75BC6771D3659@MN2PR12MB3136.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0d/nLo2of+nkP0urxbJdk4ty7fI69zLNH0k9I53yLVbMnR7UX6Jrk5bZKJURYh0wPdq2pcUJUs2Pt3356YE8/a5tpUYk/4e0HE8CYwQwAHXttPSLYbOfVKaYGOV71cgqAcj5w/ZsgIfjbufy6hedLnjDXy2adz+1U5baAaoYZKhOb+gyaX9tZ1uTY9I/fZjgVzTiihFdEoQvAtgq7agUUOAVQbWPDiygKmWL/XvIRo92eSjjM+7tJnSxViLePhQ0XkSFXqaLl+tmK/BlhWYEg0lapE2qANGkswfRzlhr3WxB2nHfkHbuRtl1Mx768q2ZM/BRy/zqQdh0fKOWhuiJM7L6u9pzbeo23acw4BXnc3Otfo0U4xBH8qbWsSRYGxF59IWflaghB0vjS/srddSsqdCdm0AXzOBonxKtVPAIKLC/gUgrdx/GL68DHC38YXgPbxkyAhjYyhCO8sV68pN4qoOCdgKazDTCzxDe7Mc/X5G7s666bVElyuj/ZoyoJeCr7A61cARoBUAsGcE7mrRLgdLqkd81FXTNBEgxiywbbSpqyTzCPdpwLDE+EITipFMSQ6ze09N2cbiFvwb/rfoKLTDxVRg7MxWXqZvAWm1lRvqvmEZDLtlh6NM0a3zqWD8BsDoSgHkRTV1ZNmks0H8gfWWIv7BS4FXBhGsjHraCvKAmmqZC02Qk7AxQliworaj7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(66946007)(71200400001)(7696005)(76116006)(33656002)(8936002)(6916009)(8676002)(5660300002)(186003)(2906002)(64756008)(86362001)(66556008)(66446008)(66476007)(26005)(6506007)(478600001)(54906003)(316002)(52536014)(55016002)(83380400001)(9686003)(53546011)(4326008)(38100700001)(4744005)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Vzg2d2VvZDJOSHQwaS9qbDVhQkE2TDhKUEZ4N09Gb0t5dHhKOHRaYzlwOFJ5?=
 =?utf-8?B?Z2JURDN5aWNuYTNpR1dmb09KbU00QXZ4TnIwenJTemZwRnZEZzhsVDR6c09u?=
 =?utf-8?B?WTJSNDQ0VHdxUldMRkN1RjZZcUNTMUdSdm1jeEJkNXFxU3ZDSDNGTHE4alox?=
 =?utf-8?B?QnY1Wm5UdW5sSE96YU5JcndEMUc2SUFpMFphZ3h2SGZCSy8xOEVqVlVsdE53?=
 =?utf-8?B?Y0RKbUZiYVZvMHNMbTRqUmxBQnl6L1VVU3YybkRuZmkxc0tzb21TcnJjUW9n?=
 =?utf-8?B?Y0tBbWY5YWZha3lHTFBpUnl0TTg2V2ppRHdscWtYbjQwUkNuNDlYTDd3dndJ?=
 =?utf-8?B?S2cwM0hxQlVodUpsbWtyNW9kcFhNaWtyUGx6ZndlaHBYYTdyWUJaRXhyUkdy?=
 =?utf-8?B?aklvaWtaVDkwdTgwZVhPSk1oY0pzZ3lXRlJlK2tFc0pTR1BoaFFzQkRoSXNu?=
 =?utf-8?B?R1VYOVQvZzJKaDBoZFN4V3ZLSEhsMzNUZEVlZWZqR0lFZXlILzU5ZldmTTZp?=
 =?utf-8?B?d29oYWF5TGJpbkN2ZjdIZ0lvTGlWQkM2RU1BdHF4KzNDb2lFUk5XVzYxYWw1?=
 =?utf-8?B?eklqWWp4bUxWVXBpR1dLQzc4aDlKd3VmTXlkdXRaNERseUExUUR1d3Y1M2Ew?=
 =?utf-8?B?d1hkNEd6a3VYL1VoWmxDOHo0WkZVVERjYk1aVmNxeVVMT1pQdzNwNjJCUXB5?=
 =?utf-8?B?UC9qQk0xV2VCUU9xdXFnOForaytEd1JhRW1LL01pdTB1ZDB5T1EzNmE3akpG?=
 =?utf-8?B?U2FDemJJdmxETktodlBKMU9MUS9sQisxSU51eXl4Y2lmcytZdm41QXR6NFdu?=
 =?utf-8?B?R1poMEZkRExBNjFNQW5lS1JQWnR1ZWZWWHh0SFJkb0s1WDc2WlFxaXpCd1Ix?=
 =?utf-8?B?TEZwbEFrQVAycXE3YldlMlIvVGlVaUhpVlQ3WERMUXE0WHRKN2tYVE5pVHVl?=
 =?utf-8?B?NHp4VWs2MTZBUi81bFJIM3NxcUxFdGhwZXZrODZ5TEIwTDVWVVM1UGRjQVVp?=
 =?utf-8?B?d3NZeGsxd00vUmhMWGpKZkxSRnlXVytVMUtLdHRici85U3EyOStEOTdGNmM3?=
 =?utf-8?B?V1RnNER6UEtUQUhJUjBndVNwS3BlRmxmY2pvU1ptU2d2bitCYjBDNFo1OEFV?=
 =?utf-8?B?OENNNEkvakFjVFhrWXNPRUFIRExmTlZZTW0wUndoN0tTYk5sWlNFZitNZEJa?=
 =?utf-8?B?MFhmZkZXRURQQTZNb1Era2NqQ2c5V3J4VzJzMjB1Wlk1eHFiSHdqaVFFQUx5?=
 =?utf-8?B?VHhwbitHelRRV0ZLTUR0WUNUZ0J1TDcvdlRBdTNmcXRvdWhxeTV3aXVja0Yv?=
 =?utf-8?B?NlRIc2pWQ0VabTdWWEZCR0JHK2dPQWRiWVRwcDFadUcwZTEyVU5yNnBQd2NQ?=
 =?utf-8?B?YWRzTGZ6c2NZYkdweWF3RzVFeUJMeEFuQ3VqemZPN1h3bEY1bkUzV0RRMm9q?=
 =?utf-8?B?U0V3aktiR2htMW5ocDRXckhFZXFYMzZ1TnllUVRMNXlYVHhOODNrejJ4Tlcx?=
 =?utf-8?B?VnJoS1JSRkNaTjhGVldZczczOXkzeTU3NGcwTXQ0NHVKQW1Ud1dTdFJUM0xO?=
 =?utf-8?B?U0l1Vk5hcG5iTWhzeE04M3RTS3pYdCtVcjRuaG1aaGFXaktQZTdwZ1pVYXVC?=
 =?utf-8?B?LysveXZXM2thcFVHQnNZcktWTzRGUm5IZ0lnTjM0TUZPajhvT0k4Vm00S2Er?=
 =?utf-8?B?bE5SYWl3MEJ2dEtOTFhnMVpJZXpVdHlXQm5pWW45bEtHc2NYTE9GTmRWT3VH?=
 =?utf-8?Q?SHDgt3TlOe4+ktU7hikT64+CdCY6u7pnRKsbRR9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942810c7-d479-4c0a-3405-08d8ed848c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 22:48:01.5240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVXkd292aOtpWkTb+MrPP0ITabaCiKYXmkWGxANakkyYO5bKd9EVFXnYRhY1QwRquxrR96zeBKR/b34Mf2QO/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3136
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVsZiBIYW5zc29uIDx1bGYu
aGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDIyLCAyMDIxIDU6NTEg
QU0NCj4gVG86IExpbWluZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNvbT4NCj4gQ2M6IEFkcmlhbiBI
dW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgS2hhbGlsIEJsYWllY2gNCj4gPGtibGFp
ZWNoQG52aWRpYS5jb20+OyBsaW51eC1tbWMgPGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+OyBM
aW51eA0KPiBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBtbWM6IHNkaGNpLW9mLWR3Y21zaGM6IGFkZCBB
Q1BJIHN1cHBvcnQgZm9yDQo+IEJsdWVGaWVsZC0zIFNvQw0KPiANCj4gT24gRnJpLCAxOSBNYXIg
MjAyMSBhdCAyMToyMywgTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IFVmZmUsDQo+ID4NCj4gPiBDYW4gSSBjb25maXJtIHdoZXRoZXIgeW91IG1lYW50IHRo
ZSAnbWFzdGVyJyBicmFuY2ggb3Igc29tZSBvdGhlcg0KPiBicmFuY2g/DQo+ID4gSSBkaWQgYSBy
ZWJhc2Ugb2YgbWFzdGVyIGFuZCBkaWRuJ3Qgc2VlIFNoYXduIExpbidzIGNoYW5nZXMgaW4gdGhl
IHNkaGNpLW9mLQ0KPiBkd2Ntc2hjLmMNCj4gDQo+IGdpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC91bGZoL21tYy5naXQgbmV4dA0KDQpUaGFua3MhIFJlYmFzZWQgYW5kIHBv
c3RlZCB2My4NCg0KPiANCj4gWy4uLl0NCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
