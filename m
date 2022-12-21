Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27116C10F1B
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Dec 2022 05:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiLUFJL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Dec 2022 00:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiLUFJK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2022 00:09:10 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82358201AA
        for <linux-mmc@vger.kernel.org>; Tue, 20 Dec 2022 21:09:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byBn+cMcAf8EMcgDHlzAijt/fo2fDVjcjpiZ5OQGVHo7+KNH3RMRungv5aIaBuOhgnQePQYr1ahk43yLp5T9zE+iF6Q9os6aL2PdZMUgJTYQsNNKaQmKWdnrZ80b4/89VERlHM9eLCsqIHiAMSKKNxHSseGNROCMkTrwx+1s6znojkYNLzDT7UbDfXaqAaWr0F5m/Zpjeza9ayGJHUVoUYi8uVf+I7MfqaZhIByu1lCyfJCEOn81XY3d6LduiZC7vi989o76wbUee1sbe1pVH7UBbN5/p2eF+7oZ7PMe4dYy16U29FS1zvNAjJnz14nWOKPb6Du9Pz2KDjx/7RAz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYY8/a9nd6l2ZHWwj/ZQ3YOyQQfcfAJzqBKSlGbCp4Q=;
 b=PeraxcGsEBKXc8D7CVg0As54/m1K/hJBrIVZhFDVyCE5KZbF8ldvpQcluyHQmp5StZS9sr2MNh5TBrbDUhi70/Uuy/4B3e2kTIiBoHmeERJMz/8B3kQUybr/zHCvlW0hj4hHzX6GwH/AmKdU/vXFMyb8PoY2PhLcaPTmStOWc6DYx1YxNmHMTCvav/L6JgwYa3LO6zN0R/iFu15DPbyPOx06z7uchR7vLPZTidKemjb4kR9HeGT0XsuOdOjT+xona5ECNpESFoHJDhPhiMV6rAnqeKQokFAPS1eRO2Nyo2KHPCM7soOkMBoscUwUL42+EGhccerhhrwDamiTwA5Y0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYY8/a9nd6l2ZHWwj/ZQ3YOyQQfcfAJzqBKSlGbCp4Q=;
 b=xUhLU88zoeFuMQ/2Jw8vqUaIm+7yI/3SgEXKbYPaMUuhHInFSyJgCHrcwxZ3SktD4u5EZFfuROXhAxNv1MflQsWKUfmSr7Vmhv/V7F04q/xymUkXYpf3JQHtlHVijh3nRWVActOaJ+OhOXgrM34MnBViKUGWqbnk/V/M4KNJxIA=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Wed, 21 Dec
 2022 05:09:02 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::4dd6:decd:f064:fab9]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::4dd6:decd:f064:fab9%6]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 05:09:02 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Marek Vasut <marex@denx.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] mmc: sdhci-of-arasan: Override
 SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
Thread-Topic: [PATCH] mmc: sdhci-of-arasan: Override
 SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
Thread-Index: AQHZFPpVYHx01PZ0LkqAwW/6LG+h6g==
Date:   Wed, 21 Dec 2022 05:09:02 +0000
Message-ID: <BY5PR12MB425809920721B2CBC5A4F517DBEB9@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20221025191500.149167-1-marex@denx.de>
 <2b523371-7eeb-25f2-8879-76bbf028f4bb@intel.com>
 <c3d62448-fd1c-066c-aa53-2df7eae1555d@denx.de>
In-Reply-To: <c3d62448-fd1c-066c-aa53-2df7eae1555d@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|PH8PR12MB8432:EE_
x-ms-office365-filtering-correlation-id: cfcb1e1a-f48d-4012-e151-08dae31179b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXsOOs9P8dKEQSWqRocXEqVq3orJVHL+oftybF4SXEvw+xKnDlECHSs87tTE8VKa3detuXjBdHVu4pOieA3Imd3NokDHLYQV4RnBzHR+1yRDIEu6CKamf4echL6E4424tCSNt+l3dJU5Rc5fZ5lD4JDxrJ9IRCKPWTB58YsXdIbwrspy6HEOigBNn2XBA6WrIvWC080iv5lobV1aoSyYy74jU3rX91nJXwFjf42QqhAg4MafRBwdsWMg4GOWjTbUtmsd4oO6DCuYfZ57Vbmjl5FqcwJBO6iSC8+TAf49a17xH+cTxCTlErtVWHdMKbszMsH5i9nMpeUGmMDPCYJw1PbKJqI9ojDH20PPZfvYiiDFj9YJk3z0Ur0Qn2kGlaVtrB/Ea7Prblg9bqOdsVjhawoo7TYTDHEpvxPxdXX9utdkUZva94/SMFSf3XFrboO/3qmSuVtPqbMCJfW7gdln/NwYq6qDpL0o6fZ+pcxDRtlgRoPehQM9+EUXXXLYRcsH83iO8rO55qyRRDd5AEj85QqE+kIjrdhHwM8gNzcjHcgZRY/7Wkf9+7kOxupMFZI7kWVg9qPsAnE2lTZeAPYe+tiNJDuGowsESsat0XN1y7AbOqsQ8ai5Th9aaG8ijSXZXy3JXToSW3xBvXG+v+HmZTGCcLxheXCKrxPx/Q5jfL8eDswo1p7tGLqL61rBKJj92/xjqo1Q5gWonoJKumnaZmY+Wjkya55zBqE1PtJA/G+kaRFMzZpCpgor2QJXicJBMk/V8zZaBqcAPDEhYz9g/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199015)(478600001)(53546011)(186003)(26005)(7696005)(8676002)(966005)(6506007)(66476007)(71200400001)(66946007)(4326008)(54906003)(76116006)(110136005)(66446008)(66556008)(316002)(64756008)(122000001)(9686003)(38100700002)(83380400001)(52536014)(55016003)(2906002)(8936002)(5660300002)(41300700001)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlUrVnVFVFpxYk5EbkRDY2JoZHI2U0E3MDhOQWRNSFFHelFxNWVkWW03ZnBQ?=
 =?utf-8?B?VnZjSkcwZUdLdk1kMGZ0cXBFRXZCdTBhendnUnEvY09wQ1hQd2VlNWh4NEZs?=
 =?utf-8?B?Z2N2a0pKdXNpSFVuM0UzZi80c1dVb3oyTUpscHQ4L3hFZGtyNjVWOUJQK3Z4?=
 =?utf-8?B?R1oybDRtZXNOaHBvd1RTakR3ekgrdUNDT204ZGdITmFaMC9KZXlIK0NJaFhm?=
 =?utf-8?B?S2crWlNBaFB4dUJScGliSFdpeGxGNjVKa2JNOTVUWTQxVlJLSEtpd2czOEdG?=
 =?utf-8?B?cTNwOU9OUDJ4WmovZ2pPSDJNdUNCSkdVdkwycTlaTVRpMERmN1N0MnZBL3JT?=
 =?utf-8?B?a2pwa3JrTmFKUk5uQ210SFc2eDZWK0NoeldraFlwVisvaFc3TUkvc2FvblVE?=
 =?utf-8?B?dVRBVUhnQ0dVN0dkSFhpZ3I2elNqQmZ3NVBpMjFnRGtPSExldXVCRTVwdDRP?=
 =?utf-8?B?c0ZkZUFZcWRGT1FZYWd2NHQvYUFPTXI4c3ZYSkQ3RGlHTjlXVzlQUkN6RUtt?=
 =?utf-8?B?eHV1emRPR21XRU1PVlU4R2gwdWIvYXhKQnpxRkpNZXNqb2FGcTFpdmxIRTdt?=
 =?utf-8?B?UXhna1l4RWVXbHFNRGhLQk9NdFM0K3FYcWRhM2Q4NHhURkxFWTY5K1E4RTNP?=
 =?utf-8?B?aWNjQnlJOXU4MHdXcnJGbFprTDdqRURoU204TlB5aDR0Z3JXY0I4NTgzL2Rz?=
 =?utf-8?B?dVFMZW1wVTROdzY4RVlNZ1Ivb0JBc05HZGlNVTlOVDQ2T05LTWVlWVBCalFG?=
 =?utf-8?B?YTRNRmlzTUVkTGRJeFBrMWl0Nzh4THNYYlVDK3lBT2w3dU1oU2cvVjdIZmZT?=
 =?utf-8?B?T2VaMXd6QnduRzdKRkJaOWhDNXB5NkxzVFdSUkU2VDdCdDRsRTAyRmszMEhO?=
 =?utf-8?B?L2tJR1YyMVhWOEw4bS9UVS9LcjNvL2JpaDFCdTFVYnV4Yys1eG16U0VQUGZa?=
 =?utf-8?B?TXJSM21MSmVrMUp5L3F6ZTNpRW9MV3luWWlGOWc5aXpIRW9udk0xWm9HVDdl?=
 =?utf-8?B?SmlVeDUwTjBaVnRvUXdUdDhVSkZqb3liN1JyaXR5NkI0YnlVSjNqaXp6eFRR?=
 =?utf-8?B?KzNtMUNKR2gzT0JHa3orZzV2UGRwNVFDeHk3OUZkMnE4Rm5qUGZoclBmc3FT?=
 =?utf-8?B?d0NpN1JBalVxVng4ZmhDOTNhTVhRWm10R01qVmtLTkpsR0JuWFcvWmpRZytY?=
 =?utf-8?B?TEcwN1ZidlFWU2NnRTR1c2E1ZXVCQ25KVzFNeUp1ZzQrZVJHK0FCblJsRWZR?=
 =?utf-8?B?YXFDb2VuSHluenN2TlpUYzFDa011U04zQmxVR2I3YjVEOG9RV3ZvRlFCeU5G?=
 =?utf-8?B?VmlRVVZMZzFoNWJZaVdHb05zMGIycFRIWVYwZS9nZTQ1bmlYVGplU3NuZGc5?=
 =?utf-8?B?UWpjcU1qUkpVbEtOYTJuUkp4SStka2ZxZjFNVm81RnFQYkQvUHFNMGZWNld1?=
 =?utf-8?B?L1Q1ZDZhQjFrMzhUWkdrcFltMG1CU3MzTlc4dE15UlhkckhiM2hYRW4yc0Jk?=
 =?utf-8?B?WFpTNDNRbUdrTVhQVHN3MERNdlJMcEVraVN4YVpuUmxRZnRBYlA2d0pJWUN2?=
 =?utf-8?B?UEJFWEtMUVBwWEhsVTEydGpXTjZFa1BYM2VCRkZneDUwMGh1SEwvUG44OTZh?=
 =?utf-8?B?RUEwUlZXN3NnT0htT2FZL0Z3NnRQNVE3czJSNTNIalVhZVp4MmhRMG9ueUV2?=
 =?utf-8?B?blkzWWJnYTlGWTlBTWtNY0NlRXJ1VXh3SHg1ajJpN2xSUm1TdnE3VFZlRTB3?=
 =?utf-8?B?bXozQThOdmcyTEZLVWtjbkpCajNrZ1N1SUR1ZmJiU0ZWSEV1U3gxSGxneDNS?=
 =?utf-8?B?anE2OVJoaFFyMFB5RTI3QVVURFMzSUM3dFFSdkRGelh2NVNmOFZpZ3pLM25w?=
 =?utf-8?B?VEFRT3B3UzBoSU0rZVIyeCt1SGpnM3dwYkc3MnY0WlRFMXh6QzdBOGRmYytk?=
 =?utf-8?B?bnN3VTlhbmFjS0MyK3NYSnhlTHUwanNvQnIyQXFoZ2hGQXY0aHlIRFdDMVRU?=
 =?utf-8?B?NytsemJySzJTQnRTc2g2SEE1RUZoMjNKdU4zMWVmTVdqRkExdXJtcTRDTkty?=
 =?utf-8?B?WmI3aWdqbHBaTjJUNGc1YnloRkN6dkEvcS93cXFhUjhhUlBvQlhTTUhyMk1P?=
 =?utf-8?Q?lYI0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcb1e1a-f48d-4012-e151-08dae31179b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 05:09:02.1371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4M1P6DMWOOJPXWNpG80hYI7GZsOOY6c0Ty2KyWtm4SanGP25bcr70+DQP7vPTPAax4QhuZvPb8xFdHpdyFOpEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyNiwgMjAy
MiAyOjUwIFBNDQo+IFRvOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47
IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1pY2hhbCBTaW1layA8bWljaGFsLnNp
bWVrQHhpbGlueC5jb20+OyBVbGYgSGFuc3Nvbg0KPiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBtbWM6IHNkaGNpLW9mLWFyYXNhbjogT3ZlcnJpZGUNCj4gU0RIQ0lfUkVUVU5JTkdfVElN
RVJfQ09VTlRfTUFTSyBvbiBaeW5xTVANCj4gDQo+IENBVVRJT046IFRoaXMgbWVzc2FnZSBoYXMg
b3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gUGxlYXNlIHVzZQ0KPiBwcm9wZXIg
anVkZ21lbnQgYW5kIGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBs
aW5rcywgb3INCj4gcmVzcG9uZGluZyB0byB0aGlzIGVtYWlsLg0KPiANCj4gDQo+IE9uIDEwLzI2
LzIyIDA4OjA3LCBBZHJpYW4gSHVudGVyIHdyb3RlOg0KPiA+IE9uIDI1LzEwLzIyIDIyOjE1LCBN
YXJlayBWYXN1dCB3cm90ZToNCj4gPj4gT24gWGlsaW54IFp5bnFNUCwgdGhlIHJlZ19jYXBhYmls
aXRpZXMgKFNESU8pIFJlZ2lzdGVyDQo+ID4+DQo+ID4+IGh0dHBzOi8vd3d3LnhpbGlueC5jb20v
aHRtbGRvY3MvcmVnaXN0ZXJzL3VnMTA4Ny9zZGlvX19fcmVnX2NhcGFiaWxpdA0KPiA+PiBpZXMu
aHRtbCMNCj4gPj4gQWJzb2x1dGUgQWRkcmVzcyAgMHgwMEZGMTYwMDQwIChTRDApDQo+ID4+IFJl
c2V0IFZhbHVlICAgICAgIDB4MjgwNzM3RUM2NDgxDQo+ID4+DQo+ID4+IHJlYWxseSByZWFkcyAw
eDIwMDczN0VDNjQ4MSAuIFRoZSBpbnRlcmVzdGluZyBwYXJ0IGlzIHRoZSB0b3AgMzINCj4gPj4g
Yml0cywgd2hpY2ggYXJlIFNESENJX0NBUEFCSUxJVElFU18xID0gMHgyMDA3LiBUaGUgbWlzc2lu
ZyAweDgwMCBpcw0KPiA+PiBTREhDSV9SRVRVTklOR19USU1FUl9DT1VOVF9NQVNLPTAsIHdoaWNo
IG1ha2VzIHRoZSBTREhDSSBjb3JlDQo+IGRpc2FibGUNCj4gPj4gcmV0dW5pbmcgdGltZXIuDQo+
ID4+DQo+ID4+IEZpeCB0aGlzIHVwIGhlcmUgYnkgZXhwbGljaXRseSBzZXR0aW5nIHR1bmluZ19j
b3VudCB0byA4IGFzIGl0IHNob3VsZA0KPiA+PiBiZSwgb3RoZXJ3aXNlIGFuIGVNTUMgbWlnaHQg
ZmFpbCBpbiB2YXJpb3VzIHRoZXJtYWwgY29uZGl0aW9ucw0KPiA+Pg0KPiA+PiBOb3RlIHRoYXQg
dGhlIGRpZmYgaXMgYmVzdCBzaG93biB3aXRoIC13IG9wdGlvbiwgdGhpcyBtYWtlcyBpdA0KPiA+
PiB2aXNpYmxlIHdoYXQgaGFwcGVuZWQgd2l0aCAhc2RoY2lfYXJhc2FuLT5oYXNfY3FlIGNvbmRp
dGlvbmFsLCB3aGljaA0KPiA+PiBpcyBwbGFjZWQgYmV0d2VlbiBzZGhjaV9zZXR1cF9ob3N0KCkg
YW5kIF9fc2RoY2lfYWRkX2hvc3QoKSBjYWxscy4NCj4gPj4gU2luY2Ugc2RoY2lfYWRkX2hvc3Qo
KSBpcyBhbHNvIGEgc2VxdWVuY2Ugb2YgdGhlc2UgdHdvIGNhbGxzIGFuZA0KPiA+PiBob3N0LT50
dW5pbmdfY291bnQgbXVzdCBiZSBvdmVycmlkZW4gYmVmb3JlIGNhbGxpbmcNCj4gPg0KPiA+IG92
ZXJyaWRlbiAtPiBvdmVycmlkZGVuDQo+IA0KPiBGaXhlZA0KPiANCj4gPj4gX19zZGhjaV9hZGRf
aG9zdCgpLCBjYWxsIHRoZSB0d28gY2FsbHMgc2VwYXJhdGVseSBhbmQgZG8gYWxsIHRoZQ0KPiA+
PiBhZGp1c3RtZW50cyBiZXR3ZWVuIHRoZW0gaW4gZWl0aGVyIGNhc2UuDQo+ID4+DQo+ID4+IFNp
Z25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiA+PiAtLS0NCj4gPj4g
Q2M6IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQo+ID4+IENjOiBBZHJp
YW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gPj4gQ2M6IFVsZiBIYW5zc29u
IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+PiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+ID4+IFRvOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+ID4+
IC0tLQ0KPiA+PiAgIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMgfCA1NyArKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAtDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDM4
IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+PiBiL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4gPj4gaW5kZXggMzk5N2NhZDFmNzkzZC4uNDY1NDk4ZjJh
N2MwZiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4u
Yw0KPiA+PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5jDQo+ID4+IEBA
IC0xNTIxLDM3ICsxNTIxLDU2IEBAIHN0YXRpYyBpbnQgc2RoY2lfYXJhc2FuX3JlZ2lzdGVyX3Nk
Y2xrKHN0cnVjdA0KPiBzZGhjaV9hcmFzYW5fZGF0YSAqc2RoY2lfYXJhc2FuLA0KPiA+PiAgICAg
IHJldHVybiAwOw0KPiA+PiAgIH0NCj4gPj4NCj4gPj4gLXN0YXRpYyBpbnQgc2RoY2lfYXJhc2Fu
X2FkZF9ob3N0KHN0cnVjdCBzZGhjaV9hcmFzYW5fZGF0YQ0KPiA+PiAqc2RoY2lfYXJhc2FuKQ0K
PiA+PiArc3RhdGljIGludCBzZGhjaV9hcmFzYW5fYWRkX2hvc3Qoc3RydWN0IHNkaGNpX2FyYXNh
bl9kYXRhDQo+ICpzZGhjaV9hcmFzYW4sDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPj4gICB7DQo+ID4+ICAgICAgc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QgPSBzZGhjaV9hcmFzYW4tPmhvc3Q7DQo+ID4+ICAgICAgc3RydWN0IGNxaGNp
X2hvc3QgKmNxX2hvc3Q7DQo+ID4+ICAgICAgYm9vbCBkbWE2NDsNCj4gPj4gICAgICBpbnQgcmV0
Ow0KPiA+Pg0KPiA+PiAtICAgIGlmICghc2RoY2lfYXJhc2FuLT5oYXNfY3FlKQ0KPiA+PiAtICAg
ICAgICAgICAgcmV0dXJuIHNkaGNpX2FkZF9ob3N0KGhvc3QpOw0KPiA+PiAtDQo+ID4+ICAgICAg
cmV0ID0gc2RoY2lfc2V0dXBfaG9zdChob3N0KTsNCj4gPj4gICAgICBpZiAocmV0KQ0KPiA+PiAg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPj4NCj4gPj4gLSAgICBjcV9ob3N0ID0gZGV2bV9r
emFsbG9jKGhvc3QtPm1tYy0+cGFyZW50LA0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2l6ZW9mKCpjcV9ob3N0KSwgR0ZQX0tFUk5FTCk7DQo+ID4+IC0gICAgaWYgKCFjcV9ob3N0
KSB7DQo+ID4+IC0gICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0KPiA+PiAtICAgICAgICAgICAg
Z290byBjbGVhbnVwOw0KPiA+PiAtICAgIH0NCj4gPj4gKyAgICAvKg0KPiA+PiArICAgICAqIE9u
IFhpbGlueCBaeW5xTVAsIHRoZSByZWdfY2FwYWJpbGl0aWVzIChTRElPKSBSZWdpc3Rlcg0KPiA+
PiArICAgICAqDQo+ID4+ICsgICAgICoNCj4gaHR0cHM6Ly93d3cueGlsaW54LmNvbS9odG1sZG9j
cy9yZWdpc3RlcnMvdWcxMDg3L3NkaW9fX19yZWdfY2FwYWJpbGl0aWVzLg0KPiBodG1sIw0KPiA+
PiArICAgICAqIEFic29sdXRlIEFkZHJlc3MgIDB4MDBGRjE2MDA0MCAoU0QwKQ0KPiA+PiArICAg
ICAqIFJlc2V0IFZhbHVlICAgICAgIDB4MjgwNzM3RUM2NDgxDQo+ID4+ICsgICAgICoNCj4gPj4g
KyAgICAgKiByZWFsbHkgcmVhZHMgMHgyMDA3MzdFQzY0ODEgLiBUaGUgaW50ZXJlc3RpbmcgcGFy
dCBpcyB0aGUNCj4gPj4gKyAgICAgKiB0b3AgMzIgYml0cywgd2hpY2ggYXJlIFNESENJX0NBUEFC
SUxJVElFU18xID0gMHgyMDA3LiBUaGUNCj4gPj4gKyAgICAgKiBtaXNzaW5nIDB4ODAwIGlzIFNE
SENJX1JFVFVOSU5HX1RJTUVSX0NPVU5UX01BU0s9MCwgd2hpY2gNCj4gPj4gKyAgICAgKiBtYWtl
cyB0aGUgU0RIQ0kgY29yZSBkaXNhYmxlIHJldHVuaW5nIHRpbWVyLg0KPiA+DQo+ID4gQXJlIHlv
dSBhd2FyZSB0aGF0IGNhcHMgY2FuIGJlIGNoYW5nZWQgaW4gRFQgdmlhICJzZGhjaS1jYXBzIiBh
bmQNCj4gPiAic2RoY2ktY2Fwcy1tYXNrIiA/DQo+IA0KPiBObywgSSB3YXNuJ3QgYXdhcmUgb2Yg
dGhvc2UuDQo+IA0KPiBJcyB0aGF0IHRoZSBwcmVmZXJyZWQgYXBwcm9hY2ggdG8gdGhpcyBmaXgs
IG92ZXIgaGFuZGxpbmcgaXQgaW4gdGhlIGRyaXZlciA/DQo+IA0KPiBJIHRoaW5rIHRoZSBkcml2
ZXItc2lkZSBmaXggd291bGQgYmUgcHJlZmVyYWJsZSwgYmVjYXVzZSBpdCBhbHNvIGZpeGVzIHN5
c3RlbXMNCj4gd2hpY2ggdXNlIGxlZ2FjeSBEVHMgd2l0aG91dCB0aGUgc2RoY2ktY2FwcyBwcm9w
ZXJ0aWVzLCB3aGljaCB3b3VsZCBiZSBhbGwNCj4gWnlucU1QIHN5c3RlbXMgdGh1cyBmYXIuDQo+
IA0KPiAoYW5kIEkgd291bGQgYWxzbyBzdGlsbCBwcmVmZXIgdG8gZ2V0IGZlZWRiYWNrIGZyb20g
WGlsaW54IG9uIHdoeSBkb2VzIHRoZQ0KPiB2YWx1ZSBzcGVjaWZpZWQgaW4gVUcxMDg3IG5vdCBt
YXRjaCB3aGF0IGlzIHJlYWQgb3V0IG9mIHRoZSBoYXJkd2FyZSkNClJlc2V0IHZhbHVlIG9mIHRo
ZSByZXR1bmluZyB0aW1lciBjb3VudCBpcyBzZXQgdG8gMHgwIHZpYSBaeW5xTVAgRlNCTCwgd2Ug
aGF2ZQ0KYW4gRVJSQVRBIGZvciB0aGUgc2FtZS4NCmh0dHBzOi8vc3VwcG9ydC54aWxpbnguY29t
L3MvYXJ0aWNsZS82ODU1MD9sYW5ndWFnZT1lbl9VUw0KDQpYaWxpbnggcmVjb21tZW5kYXRpb24g
aXMgdG8gcHJvZ3JhbSB0aGUgYXBwcm9wcmlhdGUgdmFsdWUgaW4gdGhlIHJldHVuaW5nDQp0aW1l
ciBjb3VudCBmaWVsZCBiYXNlZCBvbiB0aGUgc3BlY2lmaWMgcmVxdWlyZW1lbnRzIHZpYSBEVCBw
cm9wZXJ0eS4NCg0KUmVnYXJkcw0KU2FpIEtyaXNobmENCg==
