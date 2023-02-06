Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67527C61DA4
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Feb 2023 08:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBFItr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Feb 2023 03:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBFItq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2023 03:49:46 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC0F166E2
        for <linux-mmc@vger.kernel.org>; Mon,  6 Feb 2023 00:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mn2G8rOFUsfk1fWWTQfD0Aj2jF9FXL2q2A5S39oOwN2W/o7EwSTWkjX7EGj00OEo/9fKYEARLgxh7ZuHUwI1eppbORktYinGlmalU8sBuwc5fZQWtu/cAUyLI7iv3QXcR+YsSc1Vv7kgjMCQomV6dkXmVkRSop6rlgVHxNECJ4Qh/nMAVXV3BPf0kupYZM38DwuXmvRp2aOgjBKZ4e3wQ+41R/9FsyojSm9PIlY3yrqz1RnhVjK6WpKs5G6ubI1RJjuB/RD2AoiOmjppwPHLM6qBFtNqdR8a57FtigMhpUY0TjUI2pFLa6IjQkgPcCEUB9VuEp8Mc/oyKqBT7/jOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md2n0DLTMj5s4hGmk7njmx8rhCi8OX4G47fF0s9mGFY=;
 b=A4D3uogezTYouKj4KFPStU04yv4T+Op1Pl9kOf7ahApAnU1lAjia/ivmoYIWgSns2xUZyf2m6jBh+ua9zGdks9feM0FlSrQ2ttVSLWKqmY81M5slenjx7+qzIdxAEz+Tlrufd2sw0rMXpzvAegpibrUtfWoX0ev3GZZikQlt4d59pI2jvFYTydUf79+HV5a889HSYlLruv+mRUqbap5JCpJkimZL+F+IT3qQLrnnhxAm3QUCCtERzLfjUpiAZvbhtTWEKjyirDhh+Azqic1flaO87+Jm2gw2NNMVa14ccpt3ec/4wxq0AwpvOMPncS1AbWaVM6rza3zOQSlSzeExwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md2n0DLTMj5s4hGmk7njmx8rhCi8OX4G47fF0s9mGFY=;
 b=aSyz69hBz1EKHgOdMf5XMBp1iZpvaFhj8nKSyoyyCDMvdEksvL9BKBrSsjdtBFespMHeEzEnt+YJgqRRi/sgRXNSxteLhVXV6fspagR4No3Oxwo7JRNooJoTk8HaF4O2YhYyAyO/8br2oV4w5kpymDSmZ3/o5jVb20KA7DGnmEw=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Mon, 6 Feb
 2023 08:49:34 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::2d8f:8e68:763:c52b]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::2d8f:8e68:763:c52b%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 08:49:34 +0000
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
Thread-Index: AQHZFPpVYHx01PZ0LkqAwW/6LG+h6q54FlsAgAGJfsCAE59VAIA0prmg
Date:   Mon, 6 Feb 2023 08:49:34 +0000
Message-ID: <BY5PR12MB4258767AB962A194FC85085BDBDA9@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20221025191500.149167-1-marex@denx.de>
 <2b523371-7eeb-25f2-8879-76bbf028f4bb@intel.com>
 <c3d62448-fd1c-066c-aa53-2df7eae1555d@denx.de>
 <BY5PR12MB425809920721B2CBC5A4F517DBEB9@BY5PR12MB4258.namprd12.prod.outlook.com>
 <8b9d6dd1-01fa-5ae1-072e-c5dc7f8b553e@denx.de>
 <BY5PR12MB42584370EDE593D8DBB42CF8DBE89@BY5PR12MB4258.namprd12.prod.outlook.com>
 <feb69d12-54a7-7e55-1ec3-b94b845339a3@denx.de>
In-Reply-To: <feb69d12-54a7-7e55-1ec3-b94b845339a3@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|PH7PR12MB6636:EE_
x-ms-office365-filtering-correlation-id: d4298eac-1fb4-41a9-f20c-08db081f11f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +EiNRuvBMAJccdRTugAkAqLJ3MGF30u6fSv+SebhWkro9I5QhpfbCQ07+DjN8LDjO7mf2I94JiKpfJkBKf48VKWBbeNUtz7Sqh4bbRqo3N6eiDnk0zg1P2Md9Pqxj7sPdeES88jsjmJDbkB1W5DM9hdodTpu1SisZbZlA319fBbWZ1+tLQoMvdMN5kqMDTKYduI7VPVPnG0QfbQbjOwr+V7eSkrC44hA0oFKG5M9eOb3toN0xywcntpfEhRkOois2j+h9neNyXIN0tTAsMwrxTjVCu8Hwg/Ez9pVkHgeoyDpCvBJYBhNWbpHDGNSHbzoE3uNTf1pRPZLw6s1ICKFV0resG44ubWLNeyzjMr59LOYvKhXCZbqqMdTG6ek0ACvNCRlx4Gov4k7ItZ9bD8xCAfsv2OdkOE8YuztbIOrNhkAv/A2l1WsSozvWjlDdkI9HW8TtcteoIA1h4Mh7+52brsXyvY/i8aI3DreQzN4e1qIpZ1KfzmRqZBl3fRDRY9yI2aC0WQiZZPCdnFHc1oE2vv81Jj4bFzIoIKIMeg3ZhZ9jikPtZJNZbv5os6upf2LpFesVVYl5Wg1FGEGTBL7VdgwCM2KLDiptIu1bgsH4fWadqDHgV9DBLEN2mH1bKjI+Yaf1yXZF04Yf7BnMVg5oVQqht8CBGXnwkDx0Pf+K1KRd/tHyH7+GiQC+MSIc/0E+wqAdXg1vrmWiFVMsxcnkpFdRvBPs+AVfwRmK3L5EiNPmSRCJv+yPvF5YtGvPCtQakey7OlQ1WBENOxGbwnq/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199018)(38070700005)(83380400001)(55016003)(122000001)(38100700002)(76116006)(8676002)(71200400001)(66946007)(64756008)(66476007)(41300700001)(66556008)(8936002)(52536014)(2906002)(86362001)(66446008)(4326008)(5660300002)(7696005)(6506007)(478600001)(966005)(26005)(316002)(186003)(54906003)(33656002)(110136005)(9686003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2VBZmU0RDBiV2lWZHMxNForeCttbjdCSG1HaHpHS1VEKzdidmM5d0kvQUJw?=
 =?utf-8?B?WXV5WXJsbktiWUs5OU9RKzJ0anBBVEhjNm1kUVUwbGoxOUFnY3BET0VvbGdV?=
 =?utf-8?B?anNsNW1JSFM4ejExSGkzT0NzL0FFNllCQkdFTi9oWWIxajdqM2VrVzd0bU9J?=
 =?utf-8?B?Rm11ZjcvbTVSaU52c2Y3bHo3UUFrTTV6WHQ4bU5ZVVJtU0N1SG5yUlQySXZD?=
 =?utf-8?B?QU9ESlBNa0dxNHZCKzcvV1RoQjZ1R1dSbEdJcmdaKytYTi91UXhIejkwZUtR?=
 =?utf-8?B?OFVaRWx4MDMwOUZtNWtzVWZTaVJ1R2paLzVKQ0RhOGpUbmJNS2J3NGk2V05W?=
 =?utf-8?B?a01PeGNqNU9Pa05LQkpNV09pVXhoVG1EMUZLWVkzU1FzZlpCc216L1d1ODJO?=
 =?utf-8?B?VlBmZzFodkxlRXFkWW10NDQzM00vazQ4QUlrYjRYT0Rvandzb09RcmhsanZn?=
 =?utf-8?B?REFRanhKeFh6cHlNalhEMlVGWFlzejF2QmZQamFFQ0JYMVRmd0JMb05nVHdB?=
 =?utf-8?B?T1kxVEZTS2lzaEJsaUpGQVdtellrWTVZeHlQVkpxMkZWbG9Mbjd1QURvSFNH?=
 =?utf-8?B?d3BkdWRTZVN1alVTRHBtdmlrUWQyeStVK1FlMHdrVU1YVWlQdkJrOVFyS05s?=
 =?utf-8?B?UVh4TGRDVndZNU9nM1Z1c0RrYVFxemxtMU1hN05NOFJmNjZTYkR1aGlONUFB?=
 =?utf-8?B?VmF2UGdqNTdDbUs3N3VoN1phTTY3ajROTXAyS0NtaEZLSExmQ3ZPNG41eFRY?=
 =?utf-8?B?YXNhYU9LZ3k0ZWNuOVJkZUNOcVhqMU4zL3M5TW0wVGFWUHZwREIxeFFkVWJ6?=
 =?utf-8?B?ZnRmdnZVRWhsUDQwUHE0YnJCelM1QWk2V2JOWmFMMjI4Zlh6MUZmcGZwV2Q0?=
 =?utf-8?B?b0N6MUlZeHB5SVhpbGJSUVZlYjVVYVhPSTlCSEZaWGdHczBRaTVBVlpPUHho?=
 =?utf-8?B?cVVaMG1MQi9RZWp6ZnFDN2RsUk14R2d6d0tQQU84VU01WDgzNEZsNDlpcC8r?=
 =?utf-8?B?bENsOCtsVXB6STNxL2x3RzdtQXF2VDEyTFZaU2NPeUhSNlNYVU9MVmY1c0l4?=
 =?utf-8?B?bXEvVGU3OGFIdUZxV2Y4STRrZm1HeElISmVad1RyNFhuODZnK1RNdTVVNDR4?=
 =?utf-8?B?RXMzMTI1OTZCL2ZBaFRwRjZUUlFOZFNVTWpmYUtNblBkQm9CYzlLbnRrRmRJ?=
 =?utf-8?B?ZE0yUElUTU1KeEJzTWN0Y2ZVWnVSWmEvSlNRZlg1VVNrVGovNDdQZFdGa3Va?=
 =?utf-8?B?eGEwMFRDRzRYVVEwQWs3bXhoQzRERGVGOHRKcjhobG8rNi9zVnNYaml2WjBa?=
 =?utf-8?B?SS9DQ0JnSlJVZGFFV0M0SXZFNENxTkZ2bExxRC9ETkMzdXJkUUJpanluNDZq?=
 =?utf-8?B?NEt5L3FNeUx2RTU4czV0dy9ScE1sSkNsSTVseS81R1gzQmlibWFOeUhkSGJi?=
 =?utf-8?B?cmlMWjc3dTNwY1JNQTcrT2lPUkpNbkk5akRIL2tYOTB5NlgyeklJc1RCblBT?=
 =?utf-8?B?b1hrZWowN3QveFF6aFNyZi9mc2pTZWM2Sm4vWTl6SXVsdG9rb2FVeExxa0J2?=
 =?utf-8?B?UzluUEg4OUZEdmU0eG0vRVJaSnZSL1FmelFZZVo0QnkvWE5FSnd3MzdZZGt2?=
 =?utf-8?B?ckg1NjJuNE52a1FLMXZSR1lldVVCcE85aFFTZlJ6OTlaV0UxZmluM1NSVnNy?=
 =?utf-8?B?elE5VW1wbDVxbTBTOHczRTBadE92YitKdktHVTRpbmZmRDhWRnEyTHkzVzdy?=
 =?utf-8?B?d0JIN05zMGFsTXF1OCtjYlFiVVZ1Ry9LNFFsVDFhVUs3RG0zT2xUWUJORitH?=
 =?utf-8?B?SmRYUlRVOUYrcExmUExCVWF4cUpmSE9pV1dFSXFXbUI2SlY2WlphanVZTDlP?=
 =?utf-8?B?bU90Z0FtQjN0SHIzYndUOTRtSURySHhvUE45VVhLNFRTTVpMSHZET0p4amZY?=
 =?utf-8?B?cyttZ0ZiVFlLSldYY0Q2M2JhUUhYdkZUcHl0RlRpUXBjcEltY3BTRFQvOVdY?=
 =?utf-8?B?Um9kRXJUdThpc1QxNmRZLzRTOUxIUXZnWnBGSUZBYWhMT2swNTQzWGFFVkxJ?=
 =?utf-8?B?dmpYM2Y0QzQvMm5xY0IzSmNHTkFreU5IZ3JrKys3aUI2ekpDT2tyVWRYdXQ4?=
 =?utf-8?Q?dAUc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4298eac-1fb4-41a9-f20c-08db081f11f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 08:49:34.0901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bsFo1DEiMRuly9HscexXTIfGb1eUhGwQ7Cay+ZPV1ps0mRFiipXKj9th+8Hx+Uk73kcd3GyZ1pSxZk6fH2wgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSA0LCAyMDIz
IDI6MTcgQU0NCj4gVG86IFBvdHRodXJpLCBTYWkgS3Jpc2huYSA8c2FpLmtyaXNobmEucG90dGh1
cmlAYW1kLmNvbT47IEFkcmlhbiBIdW50ZXINCj4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsg
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2lt
ZWtAeGlsaW54LmNvbT47IFVsZiBIYW5zc29uDQo+IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBHb3VkLA0KPiBTcmluaXZhcyA8
c3Jpbml2YXMuZ291ZEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtbWM6IHNkaGNp
LW9mLWFyYXNhbjogT3ZlcnJpZGUNCj4gU0RIQ0lfUkVUVU5JTkdfVElNRVJfQ09VTlRfTUFTSyBv
biBaeW5xTVANCj4gDQo+IENBVVRJT046IFRoaXMgbWVzc2FnZSBoYXMgb3JpZ2luYXRlZCBmcm9t
IGFuIEV4dGVybmFsIFNvdXJjZS4gUGxlYXNlIHVzZQ0KPiBwcm9wZXIganVkZ21lbnQgYW5kIGNh
dXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3INCj4gcmVz
cG9uZGluZyB0byB0aGlzIGVtYWlsLg0KPiANCj4gDQo+IE9uIDEyLzIyLzIyIDEwOjIwLCBQb3R0
aHVyaSwgU2FpIEtyaXNobmEgd3JvdGU6DQo+ID4gSGkgTWFyZWssDQo+ID4NCj4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbngu
ZGU+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMjEsIDIwMjIgMzoxMCBQTQ0KPiA+
PiBUbzogUG90dGh1cmksIFNhaSBLcmlzaG5hIDxzYWkua3Jpc2huYS5wb3R0aHVyaUBhbWQuY29t
PjsgQWRyaWFuDQo+ID4+IEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBsaW51eC1t
bWNAdmdlci5rZXJuZWwub3JnDQo+ID4+IENjOiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0B4
aWxpbnguY29tPjsgVWxmIEhhbnNzb24NCj4gPj4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gbW1jOiBzZGhjaS1vZi1hcmFzYW46IE92ZXJyaWRlDQo+ID4+IFNESENJX1JFVFVOSU5H
X1RJTUVSX0NPVU5UX01BU0sgb24gWnlucU1QDQo+ID4+DQo+ID4+IE9uIDEyLzIxLzIyIDA2OjA5
LCBQb3R0aHVyaSwgU2FpIEtyaXNobmEgd3JvdGU6DQo+ID4+PiBIaSBNYXJlaywNCj4gPj4NCj4g
Pj4gSGksDQo+ID4+DQo+ID4+Pj4+Pg0KPiA+PiBodHRwczovL3d3dy54aWxpbnguY29tL2h0bWxk
b2NzL3JlZ2lzdGVycy91ZzEwODcvc2Rpb19fX3JlZ19jYXBhYmlsDQo+ID4+Pj4+PiBpdA0KPiA+
Pj4+Pj4gaWVzLmh0bWwjDQo+ID4+Pj4+PiBBYnNvbHV0ZSBBZGRyZXNzICAweDAwRkYxNjAwNDAg
KFNEMCkNCj4gPj4+Pj4+IFJlc2V0IFZhbHVlICAgICAgIDB4MjgwNzM3RUM2NDgxDQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4gcmVhbGx5IHJlYWRzIDB4MjAwNzM3RUM2NDgxIC4gVGhlIGludGVyZXN0aW5n
IHBhcnQgaXMgdGhlIHRvcCAzMg0KPiA+Pj4+Pj4gYml0cywgd2hpY2ggYXJlIFNESENJX0NBUEFC
SUxJVElFU18xID0gMHgyMDA3LiBUaGUgbWlzc2luZyAweDgwMA0KPiA+Pj4+Pj4gaXMgU0RIQ0lf
UkVUVU5JTkdfVElNRVJfQ09VTlRfTUFTSz0wLCB3aGljaCBtYWtlcyB0aGUNCj4gU0RIQ0kNCj4g
Pj4gY29yZQ0KPiA+Pj4+IGRpc2FibGUNCj4gPj4+Pj4+IHJldHVuaW5nIHRpbWVyLg0KPiA+Pj4+
Pj4NCj4gPj4+Pj4+IEZpeCB0aGlzIHVwIGhlcmUgYnkgZXhwbGljaXRseSBzZXR0aW5nIHR1bmlu
Z19jb3VudCB0byA4IGFzIGl0DQo+ID4+Pj4+PiBzaG91bGQgYmUsIG90aGVyd2lzZSBhbiBlTU1D
IG1pZ2h0IGZhaWwgaW4gdmFyaW91cyB0aGVybWFsDQo+ID4+Pj4+PiBjb25kaXRpb25zDQo+ID4+
Pj4+Pg0KPiA+Pj4+Pj4gTm90ZSB0aGF0IHRoZSBkaWZmIGlzIGJlc3Qgc2hvd24gd2l0aCAtdyBv
cHRpb24sIHRoaXMgbWFrZXMgaXQNCj4gPj4+Pj4+IHZpc2libGUgd2hhdCBoYXBwZW5lZCB3aXRo
ICFzZGhjaV9hcmFzYW4tPmhhc19jcWUgY29uZGl0aW9uYWwsDQo+ID4+Pj4+PiB3aGljaCBpcyBw
bGFjZWQgYmV0d2VlbiBzZGhjaV9zZXR1cF9ob3N0KCkgYW5kIF9fc2RoY2lfYWRkX2hvc3QoKQ0K
PiA+PiBjYWxscy4NCj4gPj4+Pj4+IFNpbmNlIHNkaGNpX2FkZF9ob3N0KCkgaXMgYWxzbyBhIHNl
cXVlbmNlIG9mIHRoZXNlIHR3byBjYWxscyBhbmQNCj4gPj4+Pj4+IGhvc3QtPnR1bmluZ19jb3Vu
dCBtdXN0IGJlIG92ZXJyaWRlbiBiZWZvcmUgY2FsbGluZw0KPiA+Pj4+Pg0KPiA+Pj4+PiBvdmVy
cmlkZW4gLT4gb3ZlcnJpZGRlbg0KPiA+Pj4+DQo+ID4+Pj4gRml4ZWQNCj4gPj4+Pg0KPiA+Pj4+
Pj4gX19zZGhjaV9hZGRfaG9zdCgpLCBjYWxsIHRoZSB0d28gY2FsbHMgc2VwYXJhdGVseSBhbmQg
ZG8gYWxsIHRoZQ0KPiA+Pj4+Pj4gYWRqdXN0bWVudHMgYmV0d2VlbiB0aGVtIGluIGVpdGhlciBj
YXNlLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJl
eEBkZW54LmRlPg0KPiA+Pj4+Pj4gLS0tDQo+ID4+Pj4+PiBDYzogTWljaGFsIFNpbWVrIDxtaWNo
YWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gPj4+Pj4+IENjOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4u
aHVudGVyQGludGVsLmNvbT4NCj4gPj4+Pj4+IENjOiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25A
bGluYXJvLm9yZz4NCj4gPj4+Pj4+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gPj4+Pj4+IFRvOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+ID4+Pj4+PiAt
LS0NCj4gPj4+Pj4+ICAgICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5jIHwgNTcN
Cj4gPj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4+Pj4gLQ0KPiA+Pj4+
Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkN
Cj4gPj4+Pj4+DQo+ID4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1v
Zi1hcmFzYW4uYw0KPiA+Pj4+Pj4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5j
DQo+ID4+Pj4+PiBpbmRleCAzOTk3Y2FkMWY3OTNkLi40NjU0OThmMmE3YzBmIDEwMDY0NA0KPiA+
Pj4+Pj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+Pj4+Pj4g
KysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+Pj4+Pj4gQEAgLTE1
MjEsMzcgKzE1MjEsNTYgQEAgc3RhdGljIGludA0KPiA+Pj4+Pj4gc2RoY2lfYXJhc2FuX3JlZ2lz
dGVyX3NkY2xrKHN0cnVjdA0KPiA+Pj4+IHNkaGNpX2FyYXNhbl9kYXRhICpzZGhjaV9hcmFzYW4s
DQo+ID4+Pj4+PiAgICAgICAgcmV0dXJuIDA7DQo+ID4+Pj4+PiAgICAgfQ0KPiA+Pj4+Pj4NCj4g
Pj4+Pj4+IC1zdGF0aWMgaW50IHNkaGNpX2FyYXNhbl9hZGRfaG9zdChzdHJ1Y3Qgc2RoY2lfYXJh
c2FuX2RhdGENCj4gPj4+Pj4+ICpzZGhjaV9hcmFzYW4pDQo+ID4+Pj4+PiArc3RhdGljIGludCBz
ZGhjaV9hcmFzYW5fYWRkX2hvc3Qoc3RydWN0IHNkaGNpX2FyYXNhbl9kYXRhDQo+ID4+Pj4gKnNk
aGNpX2FyYXNhbiwNCj4gPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gPj4+Pj4+ICAgICB7DQo+ID4+Pj4+PiAgICAgICAgc3RydWN0IHNk
aGNpX2hvc3QgKmhvc3QgPSBzZGhjaV9hcmFzYW4tPmhvc3Q7DQo+ID4+Pj4+PiAgICAgICAgc3Ry
dWN0IGNxaGNpX2hvc3QgKmNxX2hvc3Q7DQo+ID4+Pj4+PiAgICAgICAgYm9vbCBkbWE2NDsNCj4g
Pj4+Pj4+ICAgICAgICBpbnQgcmV0Ow0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IC0gICAgaWYgKCFzZGhj
aV9hcmFzYW4tPmhhc19jcWUpDQo+ID4+Pj4+PiAtICAgICAgICAgICAgcmV0dXJuIHNkaGNpX2Fk
ZF9ob3N0KGhvc3QpOw0KPiA+Pj4+Pj4gLQ0KPiA+Pj4+Pj4gICAgICAgIHJldCA9IHNkaGNpX3Nl
dHVwX2hvc3QoaG9zdCk7DQo+ID4+Pj4+PiAgICAgICAgaWYgKHJldCkNCj4gPj4+Pj4+ICAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gLSAgICBjcV9ob3N0ID0g
ZGV2bV9remFsbG9jKGhvc3QtPm1tYy0+cGFyZW50LA0KPiA+Pj4+Pj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpemVvZigqY3FfaG9zdCksIEdGUF9LRVJORUwpOw0KPiA+Pj4+Pj4gLSAg
ICBpZiAoIWNxX2hvc3QpIHsNCj4gPj4+Pj4+IC0gICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0K
PiA+Pj4+Pj4gLSAgICAgICAgICAgIGdvdG8gY2xlYW51cDsNCj4gPj4+Pj4+IC0gICAgfQ0KPiA+
Pj4+Pj4gKyAgICAvKg0KPiA+Pj4+Pj4gKyAgICAgKiBPbiBYaWxpbnggWnlucU1QLCB0aGUgcmVn
X2NhcGFiaWxpdGllcyAoU0RJTykgUmVnaXN0ZXINCj4gPj4+Pj4+ICsgICAgICoNCj4gPj4+Pj4+
ICsgICAgICoNCj4gPj4+Pg0KPiA+Pg0KPiBodHRwczovL3d3dy54aWxpbnguY29tL2h0bWxkb2Nz
L3JlZ2lzdGVycy91ZzEwODcvc2Rpb19fX3JlZ19jYXBhYmlsaXRpZXMuDQo+ID4+Pj4gaHRtbCMN
Cj4gPj4+Pj4+ICsgICAgICogQWJzb2x1dGUgQWRkcmVzcyAgMHgwMEZGMTYwMDQwIChTRDApDQo+
ID4+Pj4+PiArICAgICAqIFJlc2V0IFZhbHVlICAgICAgIDB4MjgwNzM3RUM2NDgxDQo+ID4+Pj4+
PiArICAgICAqDQo+ID4+Pj4+PiArICAgICAqIHJlYWxseSByZWFkcyAweDIwMDczN0VDNjQ4MSAu
IFRoZSBpbnRlcmVzdGluZyBwYXJ0IGlzIHRoZQ0KPiA+Pj4+Pj4gKyAgICAgKiB0b3AgMzIgYml0
cywgd2hpY2ggYXJlIFNESENJX0NBUEFCSUxJVElFU18xID0gMHgyMDA3LiBUaGUNCj4gPj4+Pj4+
ICsgICAgICogbWlzc2luZyAweDgwMCBpcyBTREhDSV9SRVRVTklOR19USU1FUl9DT1VOVF9NQVNL
PTAsDQo+ID4+IHdoaWNoDQo+ID4+Pj4+PiArICAgICAqIG1ha2VzIHRoZSBTREhDSSBjb3JlIGRp
c2FibGUgcmV0dW5pbmcgdGltZXIuDQo+ID4+Pj4+DQo+ID4+Pj4+IEFyZSB5b3UgYXdhcmUgdGhh
dCBjYXBzIGNhbiBiZSBjaGFuZ2VkIGluIERUIHZpYSAic2RoY2ktY2FwcyIgYW5kDQo+ID4+Pj4+
ICJzZGhjaS1jYXBzLW1hc2siID8NCj4gPj4+Pg0KPiA+Pj4+IE5vLCBJIHdhc24ndCBhd2FyZSBv
ZiB0aG9zZS4NCj4gPj4+Pg0KPiA+Pj4+IElzIHRoYXQgdGhlIHByZWZlcnJlZCBhcHByb2FjaCB0
byB0aGlzIGZpeCwgb3ZlciBoYW5kbGluZyBpdCBpbiB0aGUgZHJpdmVyID8NCj4gPj4+Pg0KPiA+
Pj4+IEkgdGhpbmsgdGhlIGRyaXZlci1zaWRlIGZpeCB3b3VsZCBiZSBwcmVmZXJhYmxlLCBiZWNh
dXNlIGl0IGFsc28NCj4gPj4+PiBmaXhlcyBzeXN0ZW1zIHdoaWNoIHVzZSBsZWdhY3kgRFRzIHdp
dGhvdXQgdGhlIHNkaGNpLWNhcHMNCj4gPj4+PiBwcm9wZXJ0aWVzLCB3aGljaCB3b3VsZCBiZSBh
bGwgWnlucU1QIHN5c3RlbXMgdGh1cyBmYXIuDQo+ID4+Pj4NCj4gPj4+PiAoYW5kIEkgd291bGQg
YWxzbyBzdGlsbCBwcmVmZXIgdG8gZ2V0IGZlZWRiYWNrIGZyb20gWGlsaW54IG9uIHdoeQ0KPiA+
Pj4+IGRvZXMgdGhlIHZhbHVlIHNwZWNpZmllZCBpbiBVRzEwODcgbm90IG1hdGNoIHdoYXQgaXMg
cmVhZCBvdXQgb2YNCj4gPj4+PiB0aGUNCj4gPj4+PiBoYXJkd2FyZSkNCj4gPj4+IFJlc2V0IHZh
bHVlIG9mIHRoZSByZXR1bmluZyB0aW1lciBjb3VudCBpcyBzZXQgdG8gMHgwIHZpYSBaeW5xTVAN
Cj4gPj4+IEZTQkwsIHdlIGhhdmUgYW4gRVJSQVRBIGZvciB0aGUgc2FtZS4NCj4gPj4+IGh0dHBz
Oi8vc3VwcG9ydC54aWxpbnguY29tL3MvYXJ0aWNsZS82ODU1MD9sYW5ndWFnZT1lbl9VUw0KPiA+
Pj4NCj4gPj4+IFhpbGlueCByZWNvbW1lbmRhdGlvbiBpcyB0byBwcm9ncmFtIHRoZSBhcHByb3By
aWF0ZSB2YWx1ZSBpbiB0aGUNCj4gPj4+IHJldHVuaW5nIHRpbWVyIGNvdW50IGZpZWxkIGJhc2Vk
IG9uIHRoZSBzcGVjaWZpYyByZXF1aXJlbWVudHMgdmlhIERUDQo+ID4+IHByb3BlcnR5Lg0KPiA+
Pg0KPiA+PiBXaHkgaXMgdGhlIHJldHVuaW5nIHRpbWVyIGRpc2FibGVkIGZvciBIUzIwMCBtb2Rl
ID8NCj4gPiBCYXNlZCBvbiBkaXNjdXNzaW9ucyB3aXRoIHRoZSBYaWxpbnggSVAgZGVzaWduIHRl
YW0sIHRoZXkgdG9sZA0KPiA+IHJldHVuaW5nIGlzIG5vdCByZXF1aXJlZCBhcyBYaWxpbnggdXNl
cyBETEwgZm9yIGhpZ2hlciBmcmVxdWVuY3kgbW9kZXMuDQo+IA0KPiBEb2VzIHRoaXMgcmVxdWly
ZSB0aGUgZU1NQyAiRFMiIGxpbmUgPw0KTm8uDQo+IA0KPiA+IFNvLCB3ZSBkaXNhYmxlZCByZXR1
bmluZyBieSBkZWZhdWx0IGV2ZW4gaW4gWGlsaW54IG5leHQgZ2VuZXJhdGlvbg0KPiA+IHBsYXRm
b3JtcyBsaWtlIFZlcnNhbC4NCj4gPiBFdmVuIGluIG91ciBpbnRlcm5hbCBQVlQgdGVzdGluZyBh
bHNvLCB3aXRob3V0IHJldHVuaW5nIHdlIGRpZG4ndCBzZWUgYW55DQo+IGlzc3Vlcy4NCj4gPg0K
PiA+IERpZCB5b3UgZmFjZSBhbnkgcmVhbCBpc3N1ZSB3aXRob3V0IHRoaXMgcmUtdHVuaW5nPyBJ
ZiB5ZXMsIGNvdWxkIHlvdQ0KPiA+IHBsZWFzZSBwcm92aWRlIHNvbWUgZGV0YWlscyBhYm91dCB0
aGUgdGVzdCBjYXNlLg0KPiANCj4gWWVzLCBvbiBkZXZpY2VzIHdpdGggd2lkZXIgdGVtcGVyYXR1
cmUgcmFuZ2UsIHRoZSBlTU1DIG1pZ2h0IHN1ZmZlciByZWFkDQo+IGZhaWx1cmVzIG92ZXIgdGlt
ZS4NCkR1cmluZyBYaWxpbnggaW50ZXJuYWwgUFZUIHRlc3Rpbmcgd2UgZGlkbid0IHNlZSBhbnkg
aXNzdWVzIHdpdGhvdXQgZG9pbmcgdGhlDQpyZXR1bmluZy4gSWYgeW91IGNhbiBzZWUgdGhlIGlz
c3VlIGF0IGEgcGFydGljdWxhciB0ZW1wZXJhdHVyZSwgcGxlYXNlIGxldA0KdXMga25vdy4NCiAN
CkluIGNhc2UgaWYgdGhlcmUgaXMgYW55IGlzc3VlLCB3ZSBjYW4gbWFrZSB1c2Ugb2YgdGhlIERU
IHByb3BlcnR5IGFzIG1lbnRpb25lZC4NCg0KUmVnYXJkcw0KU2FpIEtyaXNobmEgDQo=
