Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ECCC433E9
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 17:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A1164DDE
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 17:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhCORAv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:00:51 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:20420
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234767AbhCORAr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 15 Mar 2021 13:00:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz4muOlq5ld1Rr94YwJHjZR65FxnlsTeg6n58usQkWSKy+yZE5t4SSpEg3kzc6Z97uCsL4fOKl7lKR9hnu6YSEC1BJ5fPOyT9QhHxyoXIq707FH/gzqi4yQtmYBATuw/MopCrh441H+fWLImt3j8mK/pIDmgrzprFDev8Z0+n9W6hZWVxu9xVod6LgNw4azy1c5IIJEc17mHjTGjq9KK8V1F/Qma2+DSGHN1+MufBilaXzrUXfV4nRhT8QE/npMm4la5x8/flkNS89YDv+p5ta3xDgBOlB3STxZmGCrXpa44jGrqhSuiH7+N/byhP2R8nqCbQM9gqHNa9kYsIzcdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgRGEVMiWlUqaaqI8I+1FlzI+j/NRrheSQjWAGSp4lU=;
 b=Bd0o5RQKJySqQI4Iow+b3fyEtPypPO6W57Zz8hCxOng9/AWPJwsp394L8I+upWCK9+iaw+qvdslXq2d3K+PkDBUPgzqnyHEd2zCns6Gk+CZZPek6Rzrg5C+hPyJzOu5e847AVxHT9Aub2Fl6botZXtEUD3OI5uVrKgaNHNFhUtJicZ4H5CbA3SHqV2q7NON2VWmX0rPNpjGuClgqcvI5FtZHC1k8vUs2KB9feKY3cJ80MBxcy37GO/8A34zrMF1C1U8mHKfEgFLSpxAQ4Fhsus/F9UdVVesIdaMlUCqB7cOhOYeWyV9d9KNo9LWXXSMEX/S/J885hU5qBW7gr8eg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgRGEVMiWlUqaaqI8I+1FlzI+j/NRrheSQjWAGSp4lU=;
 b=oIjfEGEQHzJUqHH0JrzfM3WeMfXcq8/RxpENSYtez8dZ6VLCvfM7gdsPN+X7MJYBo3N7FZ/I30FbCyoluF/X0Q9eibutmiCGo9tMiX4C36JusJhJIE36075uuLxRH65mhbuhiza8EFzmSohuDRAsyFiWakkdC+zehkjYD5emHvgY8CEaimyn4y3K++inToDtYuRgVLfDTENskVCnq9zUgs3IFCluAPN2Z9KhoocPBH49b3Y9aN032AIehY6JpDNVoDXwSV+Q4fBx67hF+mBFjoS91n6DHbqxI8W6R79oH3RZrdxx1JQsvDz0/zaiM41vW5z7FHoawMQnNQo3MUXNlg==
Received: from BN8PR12MB3556.namprd12.prod.outlook.com (2603:10b6:408:41::29)
 by BN8PR12MB3139.namprd12.prod.outlook.com (2603:10b6:408:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 17:00:43 +0000
Received: from BN8PR12MB3556.namprd12.prod.outlook.com
 ([fe80::78b1:3719:d36:2f3b]) by BN8PR12MB3556.namprd12.prod.outlook.com
 ([fe80::78b1:3719:d36:2f3b%6]) with mapi id 15.20.3912.031; Mon, 15 Mar 2021
 17:00:43 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Khalil Blaiech <kblaiech@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] mmc: sdhci-acpi: Add support for NVIDIA
 BlueField-3 SoC
Thread-Topic: [PATCH v1 1/1] mmc: sdhci-acpi: Add support for NVIDIA
 BlueField-3 SoC
Thread-Index: AQHXFqRbrJDl4sCpM0SDcm8Vo3MluKqEvngAgABU/YCAAALUoA==
Date:   Mon, 15 Mar 2021 17:00:43 +0000
Message-ID: <BN8PR12MB35561363D36DA2E37DBA5461D36C9@BN8PR12MB3556.namprd12.prod.outlook.com>
References: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
 <8236f89c-720e-f8bd-86d0-9654175de659@intel.com>
 <MN2PR12MB361668C9AC2463E1E89478E0AB6C9@MN2PR12MB3616.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB361668C9AC2463E1E89478E0AB6C9@MN2PR12MB3616.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [173.76.169.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 292253b4-6dc2-4c75-9818-08d8e7d3def8
x-ms-traffictypediagnostic: BN8PR12MB3139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB3139E72DC1BCA6CDA1179ACCD36C9@BN8PR12MB3139.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:334;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KcITD5LIOfBYocMUDs6FqbE/oVyaRsh1zBo6PKDv6a91oT9vKaO5F3GeWRwx5mHenzmLEdbD4HHv1143Mhs3Qyy8J4JYigNpOXNHNcSSLrRvDKGThjJG9xETrx8fv2gTWT0QJeB9unCdW2BRdDWzcmkLMIdaZowdIp3jLDW7nLCr5oWXWD3Z+33T3x8gerfc3u24uM4WYTrXTi8/bCn15dCpZ9vv9Zho5+6aBKIx3zB8Cbrg5h2OmYC888ytRXS+4HQ6biRVAf+3W9n7hecOtJeF5r9Qapw70gaPxqorZbKJ+RLoGvdiwz5lQIO4uRiLI96AHPLiL9EZvbxET4SzXrUghVoYvHGwQZf0tpgo7ykOa3AEMdGVYDGhoOi7Lpl3EQ6NcY7PLdIDi6q3gUcKjkC4y8XAD+wgsHVciDeRfNWekDaRIIrwwEKLvoPkYGaKbQ0UFqdq3KKALHT4lx9zd54H37i0L0gPf2miMe1OJCrhwKrq1lPN2gmMws3pf07DjBsQKntCeJ8meebOHmnZbhR50TlhAe7jdSpHJc1ovMYsoDm/WCuKyurvVoc8kxwc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3556.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(9686003)(8936002)(55016002)(5660300002)(86362001)(4326008)(7696005)(66446008)(8676002)(186003)(478600001)(66556008)(53546011)(76116006)(66476007)(6506007)(64756008)(52536014)(66946007)(110136005)(26005)(33656002)(83380400001)(54906003)(2906002)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Q2oyZ1lLM3h0Y1kxU3FhVEZpdGcyV0FCVTdSN1ptQzMrUUE1S1hWdTMyeUsr?=
 =?utf-8?B?OHB0STVSbWJ3ZHd0S3F4cDcxTk8wTHNlbkpjQmZ0WHlYL1BGSFd2UUFuVFJi?=
 =?utf-8?B?L1NOV3BLTWJvdVZjWnJKSWZ2TjZWalZOS0lyUlFETHFDbnNqZFo2bUtoK2JY?=
 =?utf-8?B?RUF0cFdoM3NFMTNXWHE5bXBkV0tTNXk3YUZoYTVzbzAyajV5U2lCSXlmMEJP?=
 =?utf-8?B?Wjg4OUV3K2IxSUNCdVU0WWF2RE92SUxsMDMydGRocHlQNUhMa01OTkwzQkUv?=
 =?utf-8?B?dGp5U3FzcjcxcEU3aFh4ZWZ2R1dBNUcxbjBzQlF3VXJYVC9rYjd5THZ5ODN2?=
 =?utf-8?B?Zm0vZnBHb2h0bWd0dm12cXF0dXlNWWJKUWYwWVlDMDZQQmw0bWF1ZFIxNlV3?=
 =?utf-8?B?bjlhSDgzdXB0R1VIOGc3SUNrSHlneEtKVGZ1aTdtT0IvT2JjcDZhSzMwVU1B?=
 =?utf-8?B?Zjd1VnFsYkxGL2FpZEVlUWpaUlhIbklya2d0ZHBESUVRaGY0RXVqKy9aY2JW?=
 =?utf-8?B?UWMvYjh5NTl3bUMwNkdyOXFzU1FLUFEwamU3alhvRlkweDFHbnUvZE1YWWNp?=
 =?utf-8?B?ZC9mM1YzL2ZmaGNHc1U3ZmpFQ0FDQVJmci9IMHkrT0pISVg5ZGhMdWgrNStO?=
 =?utf-8?B?LzZQcFU5VW5yUmpqekxhN0kyRXlrYWd1ODdsdS9qOUh4RU1YTmVDSEczS0Qz?=
 =?utf-8?B?MktxMTgyLzNEZWl2U3hPeSt3RG40QUFhVjg4RmFzSTNPUk5MaGlieU0ySHFB?=
 =?utf-8?B?QUV1L1BFcjFycXBacUFRN2JhbHpiaU5JNEpYUXE5ODdmc0FiRnRmYXZ0L0do?=
 =?utf-8?B?Z3hEUHlhcUxQZzkwRlB3SnN1alg2QmJUOGxld1ArNVArdWtHSHZsZ2tpTGpF?=
 =?utf-8?B?TGZmM2hISjU0dHJkVFc4OEZ6SjZyOWNrakg3QW9mMVFjaXZhU0VMTU5IODdj?=
 =?utf-8?B?MGZ2VlpTdDRvSmp3bDRCbTFrdVh2aWQxV0FUc2NsMGRSdEZScHVNUm1RZ1Zu?=
 =?utf-8?B?NG5VUVpNRG1aTkU5TEIzM0V5NGFkcVZGV05leWJCS1N1emltVUtjdEhJSTRD?=
 =?utf-8?B?Y05NK0dqMklBdFhEZUhwMkQ3YUx2K3dRY1REMG1XKzdsMHBlbHZTYTQ4aGxt?=
 =?utf-8?B?c3F0aFZHeUZ4amtrcGlaVFJCR3lJRjBDaXNEdTFGTXlUSkwxdU1Db0U1Q2RM?=
 =?utf-8?B?SlN0cEhtUHliN0lSUHg3Y3doMVAvRFQveDFLclgzZVd1cHpYZlQrR1Z2czJS?=
 =?utf-8?B?NWxhV1ZiMU5iMUZHWWU2U2VUdmhiblZZdDRRaEQwL0dxbFREaTdpT2M5UllE?=
 =?utf-8?B?UUhJWkVxK21TQnY2eGtDbVRuRXlQWFlzN0N0UFh1N3ZBN1RFOUtqZnY5ZUxJ?=
 =?utf-8?B?bVNBcTVvS09TWktzSUhQKzJHY1FNc1JUSk1DY1MxUEpWUTViWDV4S3Y2UVpW?=
 =?utf-8?B?WHpzbUE5aVpWYWtZNkpBTXJaME1CTVdsWGNoVUw0MDRBeE5uVWlEZDI2MEdP?=
 =?utf-8?B?RTlveEdwQ0QyTTNyL2dqSCtzTDYxREhmRGNrYVVYV3l4RCtwOTNXVmNoc0V2?=
 =?utf-8?B?Y0F5UzFudkVUcDhjSHYrRWp3S2RlR3dSQ0kxK2VJcDZQbDE3ZGZTemhnU3NC?=
 =?utf-8?B?WCtYbHlLejgwRmIvbU44OW4veFFZSHV2Y1FGc3JPeS8vT3pqUWNIa3V4ZkZC?=
 =?utf-8?B?a1FvVXlXcndNb29BREdOUXlVemRTdGI4REpUalVVcWp3TExmWGpEVE5vVkNB?=
 =?utf-8?Q?KFRmf11EqPph8GEHJwTCqbK1DwNSnUr5jsmeyzG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3556.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292253b4-6dc2-4c75-9818-08d8e7d3def8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 17:00:43.6845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Djh+ptHx6p8CoA0QeYsPyDQetAK0Vy1ZVDipeg4HO6u7WIJygQsvzxh0psAC7do7ANbG9flSwGfWXu/u9Ci68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3139
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

VGhhbmtzIEFkcmlhbi4gWWVzLCBJIGRpZCBjb25zaWRlciBhZGRpbmcgdGhpcyBBQ1BJIHN1cHBv
cnQgaW50byBzZGhjaS1vZi1kd2Ntc2hjLmMsIGJ1dCBub3Qgc3VyZSB3aGljaCBvbmUgaXMgdGhl
IHByZWZlcnJlZCB3YXkuDQpJcyB0aGlzIChzZGhjaS1vZi1kd2Ntc2hjLmMpIHdoYXQgeW91IHJl
Y29tbWVuZD8gSSdsbCBwb3N0IHRoZSByZXZpc2VkIGNoYW5nZXMgaW4gcGF0Y2ggdjIuDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8YWRyaWFu
Lmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTUsIDIwMjEgNDozNCBB
TQ0KPiBUbzogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPjsgVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+Ow0KPiBLaGFsaWwgQmxhaWVjaCA8a2JsYWllY2hAbnZpZGlh
LmNvbT4NCj4gQ2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzFdIG1tYzogc2RoY2ktYWNw
aTogQWRkIHN1cHBvcnQgZm9yIE5WSURJQQ0KPiBCbHVlRmllbGQtMyBTb0MNCj4gDQo+IE9uIDEy
LzAzLzIxIDM6NDggcG0sIExpbWluZyBTdW4gd3JvdGU6DQo+ID4gVGhpcyBjb21taXQgYWRkcyBB
Q1BJIHN1cHBvcnQgZm9yIHRoZSBCbHVlRmllbGQtMyBTb0Mgd2hpY2ggdXNlcw0KPiA+IHRoZSBE
V0NfbXNoYyBlTU1DIGNvbnRyb2xsZXIuIFRoZSBib3VuZGFyeSBjaGVjayBsb2dpYyBpbiBzdGF0
aWMNCj4gPiBmdW5jdGlvbiBkd2Ntc2hjX2FkbWFfd3JpdGVfZGVzYygpIGNvbWVzIGZyb20gc2Ro
Y2ktb2YtZHdjbXNoYy5jLg0KPiANCj4gRGlkIHlvdSBjb25zaWRlciBhZGRpbmcgQUNQSSBzdXBw
b3J0IHRvIHNkaGNpLW9mLWR3Y21zaGMuYyA/DQo+IE90aGVyIGRyaXZlcnMgaGF2ZSB0YWtlbiB0
aGF0IGFwcHJvYWNoLCBzZWUgc2RoY2kteGVub24uYyBvciBzZGhjaS1pcHJvYy5jDQo+IA0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPg0KPiA+
IFJldmlld2VkLWJ5OiBLaGFsaWwgQmxhaWVjaCA8a2JsYWllY2hAbnZpZGlhLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1hY3BpLmMgfCA2NA0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2
NCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1hY3BpLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWFjcGkuYw0KPiA+IGluZGV4IDU0
MjA1ZTMuLjY0NDhlOTRlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
YWNwaS5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1hY3BpLmMNCj4gPiBAQCAt
NzE2LDYgKzcxNiw2OCBAQCBzdGF0aWMgaW50IHNkaGNpX2FjcGlfZW1tY19hbWRfcHJvYmVfc2xv
dChzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICAJLnByaXZfc2l6ZQk9IHNp
emVvZihzdHJ1Y3QgYW1kX3NkaGNpX2hvc3QpLA0KPiA+ICB9Ow0KPiA+DQo+ID4gKy8qIENoZWNr
IERNQSBhZGRyZXNzL2xlbmd0aCBib3VuZGFyeS4gKi8NCj4gPiArc3RhdGljIGlubGluZSBib29s
IGR3Y21zaGNfYWRtYV9ib3VuZGFyeV9vayhkbWFfYWRkcl90IGFkZHIsIGludCBsZW4pDQo+ID4g
K3sNCj4gPiArCXJldHVybiAoYWRkciB8IChTWl8xMjhNIC0gMSkpID09ICgoYWRkciArIGxlbiAt
IDEpIHwgKFNaXzEyOE0gLSAxKSk7DQo+ID4gK30NCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIElm
IERNQSBhZGRyIHNwYW5zIDEyOE1CIGJvdW5kYXJ5LCB3ZSBzcGxpdCB0aGUgRE1BIHRyYW5zZmVy
IGludG8gdHdvDQo+ID4gKyAqIHNvIHRoYXQgZWFjaCBETUEgdHJhbnNmZXIgZG9lc24ndCBleGNl
ZWQgdGhlIGJvdW5kYXJ5Lg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIHZvaWQgZHdjbXNoY19hZG1h
X3dyaXRlX2Rlc2Moc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHZvaWQNCj4gKipkZXNjLA0KPiA+
ICsJCQkJICAgIGRtYV9hZGRyX3QgYWRkciwgaW50IGxlbiwgdW5zaWduZWQgaW50IGNtZCkNCj4g
PiArew0KPiA+ICsJaW50IHRtcGxlbiwgb2Zmc2V0Ow0KPiA+ICsNCj4gPiArCWlmIChsaWtlbHko
IWxlbiB8fCBkd2Ntc2hjX2FkbWFfYm91bmRhcnlfb2soYWRkciwgbGVuKSkpIHsNCj4gPiArCQlz
ZGhjaV9hZG1hX3dyaXRlX2Rlc2MoaG9zdCwgZGVzYywgYWRkciwgbGVuLCBjbWQpOw0KPiA+ICsJ
CXJldHVybjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlvZmZzZXQgPSBhZGRyICYgKFNaXzEyOE0g
LSAxKTsNCj4gPiArCXRtcGxlbiA9IFNaXzEyOE0gLSBvZmZzZXQ7DQo+ID4gKwlzZGhjaV9hZG1h
X3dyaXRlX2Rlc2MoaG9zdCwgZGVzYywgYWRkciwgdG1wbGVuLCBjbWQpOw0KPiA+ICsNCj4gPiAr
CWFkZHIgKz0gdG1wbGVuOw0KPiA+ICsJbGVuIC09IHRtcGxlbjsNCj4gPiArCXNkaGNpX2FkbWFf
d3JpdGVfZGVzYyhob3N0LCBkZXNjLCBhZGRyLCBsZW4sIGNtZCk7DQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyBpbnQgc2RoY2lfYWNwaV9lbW1jX252ZGFfYmZfcHJvYmVfc2xvdChzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2LA0KPiA+ICsJCQkJCSAgICAgIHN0cnVjdCBhY3BpX2Rl
dmljZSAqYWRldikNCj4gPiArew0KPiA+ICsJc3RydWN0IHNkaGNpX2FjcGlfaG9zdCAqYyA9IHBs
YXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ICsJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3Qg
PSBjLT5ob3N0Ow0KPiA+ICsJdTMyIGV4dHJhOw0KPiA+ICsNCj4gPiArCS8qIEV4dHJhIGFkbWEg
dGFibGUgY250IGZvciBjcm9zcyAxMjhNIGJvdW5kYXJ5IGhhbmRsaW5nLiAqLw0KPiA+ICsJZXh0
cmEgPSBESVZfUk9VTkRfVVBfVUxMKGRtYV9nZXRfcmVxdWlyZWRfbWFzaygmcGRldi0+ZGV2KSwN
Cj4gU1pfMTI4TSk7DQo+ID4gKwlleHRyYSA9IG1pbihleHRyYSwgKHUzMilTREhDSV9NQVhfU0VH
Uyk7DQo+ID4gKwlob3N0LT5hZG1hX3RhYmxlX2NudCArPSBleHRyYTsNCj4gPiArDQo+ID4gKwly
ZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9v
cHMgc2RoY2lfYWNwaV9vcHNfbnZkYV9iZiA9IHsNCj4gPiArCS5zZXRfY2xvY2sJCT0gc2RoY2lf
c2V0X2Nsb2NrLA0KPiA+ICsJLnNldF9idXNfd2lkdGgJCT0gc2RoY2lfc2V0X2J1c193aWR0aCwN
Cj4gPiArCS5zZXRfdWhzX3NpZ25hbGluZwk9IHNkaGNpX3NldF91aHNfc2lnbmFsaW5nLA0KPiA+
ICsJLnJlc2V0CQkJPSBzZGhjaV9yZXNldCwNCj4gPiArCS5hZG1hX3dyaXRlX2Rlc2MJPSBkd2Nt
c2hjX2FkbWFfd3JpdGVfZGVzYywNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3Qgc2RoY2lfYWNwaV9jaGlwIHNkaGNpX2FjcGlfY2hpcF9udmRhX2JmID0gew0KPiA+ICsJ
Lm9wcyA9ICZzZGhjaV9hY3BpX29wc19udmRhX2JmLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBzZGhjaV9hY3BpX3Nsb3Qgc2RoY2lfYWNwaV9zbG90X252ZGFfYmZf
ZW1tYyA9IHsNCj4gPiArCS5jaGlwCQk9ICZzZGhjaV9hY3BpX2NoaXBfbnZkYV9iZiwNCj4gPiAr
CS5jYXBzCQk9IE1NQ19DQVBfOF9CSVRfREFUQSB8DQo+IE1NQ19DQVBfTk9OUkVNT1ZBQkxFLA0K
PiA+ICsJLnByb2JlX3Nsb3QJPSBzZGhjaV9hY3BpX2VtbWNfbnZkYV9iZl9wcm9iZV9zbG90LA0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RydWN0IHNkaGNpX2FjcGlfdWlkX3Nsb3Qgew0KPiA+ICAJ
Y29uc3QgY2hhciAqaGlkOw0KPiA+ICAJY29uc3QgY2hhciAqdWlkOw0KPiA+IEBAIC03NDAsNiAr
ODAyLDcgQEAgc3RydWN0IHNkaGNpX2FjcGlfdWlkX3Nsb3Qgew0KPiA+ICAJeyAiUUNPTTgwNTEi
LCBOVUxMLCAmc2RoY2lfYWNwaV9zbG90X3Fjb21fc2RfM3YgfSwNCj4gPiAgCXsgIlFDT004MDUy
IiwgTlVMTCwgJnNkaGNpX2FjcGlfc2xvdF9xY29tX3NkIH0sDQo+ID4gIAl7ICJBTURJMDA0MCIs
IE5VTEwsICZzZGhjaV9hY3BpX3Nsb3RfYW1kX2VtbWMgfSwNCj4gPiArCXsgIk1MTlhCRjMwIiwg
TlVMTCwgJnNkaGNpX2FjcGlfc2xvdF9udmRhX2JmX2VtbWMgfSwNCj4gPiAgCXsgfSwNCj4gPiAg
fTsNCj4gPg0KPiA+IEBAIC03NTcsNiArODIwLDcgQEAgc3RydWN0IHNkaGNpX2FjcGlfdWlkX3Ns
b3Qgew0KPiA+ICAJeyAiUUNPTTgwNTEiIH0sDQo+ID4gIAl7ICJRQ09NODA1MiIgfSwNCj4gPiAg
CXsgIkFNREkwMDQwIiB9LA0KPiA+ICsJeyAiTUxOWEJGMzAiIH0sDQo+ID4gIAl7IH0sDQo+ID4g
IH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUoYWNwaSwgc2RoY2lfYWNwaV9pZHMpOw0KPiA+
DQoNCg==
