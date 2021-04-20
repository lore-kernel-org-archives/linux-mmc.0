Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4DCC433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 13:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6640F613B1
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 13:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhDTNX0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:23:26 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36059 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhDTNX0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Apr 2021 09:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618924981; x=1650460981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mD7e1Sok/EpNCUZuSCvTmrS/4K65HEedTp/Vv2SAHTA=;
  b=rZybl/jZ5JiUuiOiXUkVxtRGKqc0MKNI0+jlEUSMoS3G3OudJ4ntoudw
   7pQMcEiXePUQtv7cOdJX1/+m5FrJi2d9pxQED3EEOAuIWnRyuSeleinQl
   EY6KbCHIL1FHKg4HTxxR67jTcixw1rSDfQ7CWWve6UQT84puLLE6njceu
   tX+1vPY40nTS7IWQ8GgtMK2NBLl13G3nEe1mrOj1kfjOt8zZ+Ulfo4/2P
   RgtvoT7G3GhiJoc6MzX2oRmtO0CCl9gdAy4bnfjukgrYqfGf/R6F96JBw
   QWyQwRe71CMoN3A3AG+ad4lWC4nzj1uMDmVK2K+IRYTXcx0FDydzvuHAw
   Q==;
IronPort-SDR: HrHnlN3ncmRFTsN2YByUyJvD5bhzgF32Wov1aZ3oaCGJGIM7sv+i2IyR18Z4lM7rG4eRxlFc/W
 sjNv6EoLGFKkbqKAKaag8qc2kSkOg3aaCwvMYNMByssR64oh1K5Epg2H2au96pqjgxdw0Q4GTY
 zSeM9/JIMuuhdBMXR4IE/5Qa5D/fSbozQhXczQboAUe8rmOD+oONtlOURsvL1niEyOOZqJvhYg
 POPF4HvgqPNNmCNf5evjXHPM/F45yA07MrKDLpoTJR+f1Ej2HKE1xxeQPXusWLCYC5rS0kw/re
 onU=
X-IronPort-AV: E=Sophos;i="5.82,237,1613404800"; 
   d="scan'208";a="269470382"
Received: from mail-sn1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.57])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 21:23:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXOjKrAH86nouUSnkXc4Cl+9bIDFpKhj/DimpWkLPfG4p4YJTTNI/zNlBR6TtVAbKxc+EpT2uyG27buPR1T5DLP6obIfQvWKeDAb4K5m2bLYW5cwHQ9S/wUQiXySDWmatoeeZew8CrVa1spx0SdsbxBNr1X5WkMRApXpu76VZOC3MgJsiyjjLTl6wkijs4aZLG5/n296VfgqhKiu5zbErQQwHo6WbWiDSzqBdQlOxm3/zkipk0/BJur5+Z12CBVLfqU745Y2MpHmby0WHQQ4lNIOBVg7cpbOshc2dZZ5QojZ+ISrJ5aNdPV/lk8d+HgUNJ9CXFMTJbkNWHY2ggAxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD7e1Sok/EpNCUZuSCvTmrS/4K65HEedTp/Vv2SAHTA=;
 b=VlaA7pi8ZBbfn5hD3u4/sM+X9bjzcdJ3V2MpXW//dYJDZjPQMptGJSLg71DVOb/oJA0gx1GVZ5doH/5MmKdxo8pbLp40i42zOWV91D6KgVpO3sj7dapVIeqr6Fgh8VvfnZbgbqoUoFGBH/cDUJRmSVJjQVlfogN3hYJUGYJ5WQiLu2Sl1ooBKW1d4/Qtr8FOOek2yijQAiU0GRLzYcJOZJe6yJDR30EQNpDGf+FLt6A8MPkFv1qNcAtxmhsHH3Ncz688ljmrsD+vqtm5lYG+W7qhfUkqJfJERhKDzQgikQHW9NyxLjoN6ngNqE+zw/17CgugkHoXpb1ez38Be4wlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD7e1Sok/EpNCUZuSCvTmrS/4K65HEedTp/Vv2SAHTA=;
 b=vwp06LQST1QkJAnQOgV+aVqGajWKG0pMoo35XqR6qKFVBI9gZuY1YOkW5st2UUWie6IIARGagqv9uPs+74dHoXNE2ERXUDYqPHdqvEbdkT57azt1dAt45WpAcZWO4R/LIFMiaqPsgwFS3f3A1EXiftHdNjMCqq9SzNyj+Llk/Pw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6140.namprd04.prod.outlook.com (2603:10b6:5:12c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Tue, 20 Apr 2021 13:22:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 13:22:52 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brendan Peter <bpeter@lytx.com>
Subject: RE: [PATCH v3 1/2] mmc: block: Issue flush only if allowed
Thread-Topic: [PATCH v3 1/2] mmc: block: Issue flush only if allowed
Thread-Index: AQHXNamO4qwHFqGV5UGPU5sSHCBzdqq9QwQAgAAh/7A=
Date:   Tue, 20 Apr 2021 13:22:52 +0000
Message-ID: <DM6PR04MB6575DE38D3B919171549A1D0FC489@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210420055306.4858-1-avri.altman@wdc.com>
 <20210420055306.4858-2-avri.altman@wdc.com>
 <a55b7fe7-0d84-a9a6-8f64-6f1632cffcc4@intel.com>
In-Reply-To: <a55b7fe7-0d84-a9a6-8f64-6f1632cffcc4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41034b1a-347f-42f4-714e-08d903ff6704
x-ms-traffictypediagnostic: DM6PR04MB6140:
x-microsoft-antispam-prvs: <DM6PR04MB61407904BD1224DF380DA2F0FC489@DM6PR04MB6140.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L2ssCy6cCmKSlDCpvD79mqFOouf3Yi/DRtCLE91PGtrGqxdxiPYuK7KsUgPQvCRgE0Ce/QEwQ9NI7FS4vl/VD9/fhvr3sqOyoKMDzCjDNhPP+3vI2ep1AOc9vGtIlHo5TEjEBGwqUuc6CS6wZ41QYZj0KMhEd6o3sTpUD9MjmAhqmZZkSytztft+TwK4fcD/32aifyQMJ+bdRQImXFSN6KcpKxJRYx7XpzEREatheawRKUac1+KvT84zjalsCgLva2mzN0n4KBvQs5O0vFyGXE2nTrt2x2bemtmwav5f06Nz9QV/MAaOsIMpgj411DkFhQYbWWqr/CZU7UVxv4tcu4M5jqFJ/j3+M7QmNV83kHYiUDFfbMOaLsreiIYEZaDvnDuVG/ccR/vSKES3Pva9GMbpp6zcnxCa4j3NXEf2Z+0OULsjzYWSCdSra3qJSpmdzhRReGEpCsOw7gOBIhjSoiWX/frobQTnf2jdi4cu0490q2rghtT7nk6sjsFynF+igrSeOx2gwFS34jlQnzyoRtAlIlSuw3XgvluXi4/koGFhZmwThQD/dKNhyZF7avDXRvVymPaSSILUUKR9ftPRVvztUGOcWCwzUMqIobO0znA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(376002)(366004)(346002)(71200400001)(26005)(66556008)(64756008)(186003)(66446008)(83380400001)(33656002)(316002)(478600001)(2906002)(8676002)(7696005)(38100700002)(76116006)(4326008)(86362001)(110136005)(52536014)(122000001)(66946007)(55016002)(6506007)(5660300002)(8936002)(9686003)(53546011)(54906003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bjVaSFhIc2lqZVNhb1cybUxHa2dVUEhOSVRvYUlKTGM4Nit1WkhDOVJHa1ZV?=
 =?utf-8?B?NlNvd2phUW5nd0xoZ2h5V2lROWVLMmhoZFlhZmV5K1g0ZDg4RE9lOHBleUI1?=
 =?utf-8?B?Q1lrY1hYZE02NkVnd0pybEJETUs5ajVnTWZRSUJRZTZTRnhLOUk3MjQxQ2Vp?=
 =?utf-8?B?SGhCbFZ0TXArTUlGbTI2a1VqSHpmWEEyaHBhcG1VQWhTM29aNWVwZW5EWld6?=
 =?utf-8?B?Rm54MjNjaVBTZjRKdlBBVzIyOFJzQVhhM2taTVA5QklxbTJCaGZici84ZzFN?=
 =?utf-8?B?NlBGTUpiSldUa0pXTTZCRXBMTnhsemlJQ1FiZWtjcU9aY1ZKM1NlN25yckJR?=
 =?utf-8?B?cEIwVTl4bzE1YTVVTHhDRG02RDU0ZE5lcG9nTE5kTnJWdk9vangrM2VidE13?=
 =?utf-8?B?dFgvVk9tWVh1UHlzT3pWay8vTU1XclVEUm5YL0t4SE9TUVl2L1doNzFtYysr?=
 =?utf-8?B?K3ZETTRaVkt1aTVWVFE4dHNROWh3WEZWY2p6ZHNZY0R5U2N1ZVNISHE2RVdq?=
 =?utf-8?B?WlVMVzJFdGtYM0VEVk1CUFFnNXdDcTBjbjlRU1FBbmoxSmJrQkpJaHhHRS9W?=
 =?utf-8?B?eDhacEZpNmNlSG5Id0hSZWx1cjFrR3JvcjRhQ1JBNUJvN2lGZFdMNkw3TUtt?=
 =?utf-8?B?VDh5bGl0ZFdOZTVBekw3V09RTWZxVjF1Ry9HNjhId2puajRVVGhaa2ExUlpx?=
 =?utf-8?B?Mzc0SXVPekxBMDJRemVjTDdmRjVLaVU3MUxqMHhPRGNIamU1U2REMjBpTjl4?=
 =?utf-8?B?eFkwNFQ4NVg0RWIzMERMWUp1SnZ4QXYwWlZwN1VlSnZjdXN5eUdGS0ZCUG1r?=
 =?utf-8?B?OHpuMDl0a1JiY2dVZzk1VlZzd2N5UlBFUHE4Q2w5S0l4TWxYTXRHa0V5NjdV?=
 =?utf-8?B?ZGFKZ3M0aW15OURvRWxCRmNqZU5KNUlJbURKMFFpQlVwQk0zZWZqbnJ6aTFa?=
 =?utf-8?B?c1VGbHhwdmdZVis1NHk0RlNlbEhGODY4ZkcxR1ZvcTZkK2ZCdnlmeU95K3RE?=
 =?utf-8?B?OEV0RHBaMFhoSEcyY1VLSTVXYXpYaUZEZEhPd1RueGFkSTB1TDlGeCtzak1m?=
 =?utf-8?B?SXJkT1V4d1h3WDFQZDBTeStmaGFzelowVGZsWnpRTXFGT0Y2c2lFTUN2T1pW?=
 =?utf-8?B?ckhjR0xWbGxZYmhWSHk5OE9Rblo4YWZYbzRpRk1OYUN6SVRLWndqWEVhcDBy?=
 =?utf-8?B?SGt6REpEWXMxeGZ5YVF1TElLSWM5cExPR1FvWGY0amw3SXV5RCtxUVZLQUc3?=
 =?utf-8?B?enJ2S0QzQTRkTDNscWhiOTJPc1E0QzhKcHlyejNBaG1ZOTI0MkpiRnlqVmwy?=
 =?utf-8?B?dDdXUkhZSVczT1V1QXFidExxWlNvS0hYWG03dHNWS0ZqWDFqVU5GbzJ3VDVk?=
 =?utf-8?B?Y2hMK1dpRCt5R1dtTDI1Z3BBeFVkWWVTQWhnRkFnUkNUSWxraitsam0xYUk5?=
 =?utf-8?B?QUwwWlVMZ043VHFYWnNuQ090c2J4UUprWWUrNE9xTzU5c3F3RmVqeDIzbE9i?=
 =?utf-8?B?ZGVSRGt3c3gxb2FhOEpvQkV2NTZpZ3QwRitQbTZNVW1BN0tpRXlSNUphZHNF?=
 =?utf-8?B?MTFNYlVOTThpcW1CKzFQNHU1V3E5dGYrNVkvZnFxTldhTFdKWjRUZHkrcXln?=
 =?utf-8?B?SVhTMmd0blpyVXZvbklrbU9JY1hQckNUMFY3OEZIc1BZbkpQUmtVRUVaWWlE?=
 =?utf-8?B?Z3VyQXViay8wVFQxUXFRa2pmWUxTd0pWN1FwMys5WUZkTXcvWkJOY1lBUnlj?=
 =?utf-8?Q?bLcpN3e1V0YSz9im95IxqfqQhlWlhGFdCAvZ2oI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41034b1a-347f-42f4-714e-08d903ff6704
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 13:22:52.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwL3XaX7q0NhPjyww3yyqI9rCyKsr7UiWu6wYdTzaKNt4iVExhJhwvsh0Xy2iqB/E4qvfcV+hnWfBxvJPpS3sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6140
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

IA0KPiBPbiAyMC8wNC8yMSA4OjUzIGFtLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBUaGUgY2Fj
aGUgbWF5IGJlIGZsdXNoZWQgdG8gdGhlIG5vbnZvbGF0aWxlIHN0b3JhZ2UgYnkgd3JpdGluZyB0
bw0KPiA+IEZMVVNIX0NBQ0hFIGJ5dGUgKEVYVF9DU0QgYnl0ZSBbMzJdKS4gV2hlbiBpbiBjb21t
YW5kIHF1ZXVlaW5nIG1vZGUsDQo+IHRoZQ0KPiA+IGNhY2hlIG1heSBiZSBmbHVzaGVkIGJ5IGlz
c3VpbmcgYSBDTURRX1RBU0tfIERFVl9NR01UIChDTUQ0OCkgd2l0aCBhDQo+ID4gRkxVU0hfQ0FD
SEUgb3AtY29kZS4gIEVpdGhlciB3YXksIHZlcmlmeSB0aGF0IFRoZSBjYWNoZSBmdW5jdGlvbiBp
cw0KPiA+IHR1cm5lZCBPTiBiZWZvcmUgZG9pbmcgc28uDQo+ID4NCj4gPiBmaXhlczogMWU4ZTU1
YjY3MDMwIChtbWM6IGJsb2NrOiBBZGQgQ1FFIHN1cHBvcnQpDQo+ID4NCj4gPiBSZXBvcnRlZC1i
eTogQnJlbmRhbiBQZXRlciA8YnBldGVyQGx5dHguY29tPg0KPiA+IFRlc3RlZC1ieTogQnJlbmRh
biBQZXRlciA8YnBldGVyQGx5dHguY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEF2cmkgQWx0bWFu
IDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL2Js
b2NrLmMgICB8IDcgKysrKysrKw0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL21tYy5jICAgICB8IDIg
Ky0NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9tbWNfb3BzLmggfCA1ICsrKysrDQo+ID4gIDMgZmls
ZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxv
Y2suYw0KPiA+IGluZGV4IDhiZmQ0ZDk1YjM4Ni4uNWI2NTAxZmM5ZmI3IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUv
YmxvY2suYw0KPiA+IEBAIC0xNDc2LDYgKzE0NzYsMTEgQEAgc3RhdGljIGludCBtbWNfYmxrX2Nx
ZV9pc3N1ZV9mbHVzaChzdHJ1Y3QNCj4gbW1jX3F1ZXVlICptcSwgc3RydWN0IHJlcXVlc3QgKnJl
cSkNCj4gPiAgICAgICBzdHJ1Y3QgbW1jX3F1ZXVlX3JlcSAqbXFycSA9IHJlcV90b19tbWNfcXVl
dWVfcmVxKHJlcSk7DQo+ID4gICAgICAgc3RydWN0IG1tY19yZXF1ZXN0ICptcnEgPSBtbWNfYmxr
X2NxZV9wcmVwX2RjbWQobXFycSwgcmVxKTsNCj4gPg0KPiA+ICsgICAgIGlmIChtbWNfY2FyZF9t
bWMobXEtPmNhcmQpICYmICFtbWNfZmx1c2hfYWxsb3dlZChtcS0+Y2FyZCkpIHsNCj4gPiArICAg
ICAgICAgICAgIGJsa19tcV9lbmRfcmVxdWVzdChyZXEsIEJMS19TVFNfT0spOw0KPiA+ICsgICAg
ICAgICAgICAgcmV0dXJuIC1FUEVSTTsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICAgICAgIG1y
cS0+Y21kLT5vcGNvZGUgPSBNTUNfU1dJVENIOw0KPiA+ICAgICAgIG1ycS0+Y21kLT5hcmcgPSAo
TU1DX1NXSVRDSF9NT0RFX1dSSVRFX0JZVEUgPDwgMjQpIHwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgKEVYVF9DU0RfRkxVU0hfQ0FDSEUgPDwgMTYpIHwNCj4gPiBAQCAtMjIyNiw2ICsyMjMx
LDggQEAgZW51bSBtbWNfaXNzdWVkIG1tY19ibGtfbXFfaXNzdWVfcnEoc3RydWN0DQo+IG1tY19x
dWV1ZSAqbXEsIHN0cnVjdCByZXF1ZXN0ICpyZXEpDQo+ID4gICAgICAgICAgICAgICBzd2l0Y2gg
KHJlcV9vcChyZXEpKSB7DQo+ID4gICAgICAgICAgICAgICBjYXNlIFJFUV9PUF9GTFVTSDoNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gbW1jX2Jsa19jcWVfaXNzdWVfZmx1c2gobXEs
IHJlcSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQgPT0gLUVQRVJNKQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBNTUNfUkVRX0ZJTklTSEVEOw0K
PiANCj4gVXNpbmcgYW4gZXJyb3IgY29kZSBmb3IgdGhpcyBjYXNlIHNlZW1zIGEgbGl0dGxlIGZy
YWdpbGUuDQo+IA0KPiBIb3cgYWJvdXQgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAgICAgICAgICAg
ICAgICAgY2FzZSBSRVFfT1BfRkxVU0g6DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICht
bWNfYmxrX2NhY2hlX2Rpc2FibGVkKG1xLT5jYXJkKSkgew0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGJsa19tcV9lbmRfcmVxdWVzdChyZXEsIEJMS19TVFNfT0spOw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBNTUNfUkVRX0ZJTklTSEVEOw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9
IG1tY19ibGtfY3FlX2lzc3VlX2ZsdXNoKG1xLCByZXEpOw0KPiANCj4gDQo+IHN0YXRpYyBib29s
IG1tY19ibGtfY2FjaGVfZGlzYWJsZWQoc3RydWN0IG1tY19jYXJkICpjYXJkKQ0KPiB7DQo+ICAg
ICAgICAgcmV0dXJuIG1tY19jYXJkX21tYyhtcS0+Y2FyZCkgJiYgIW1tY19mbHVzaF9hbGxvd2Vk
KGNhcmQpOw0KPiB9DQpEb25lLg0KDQpUaGFua3MsDQpBdnJpDQo=
