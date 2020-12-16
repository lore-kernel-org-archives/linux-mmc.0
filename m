Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DE4C4361B
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 10:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3EF2333E
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 10:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgLPKnJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Dec 2020 05:43:09 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:41304 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725294AbgLPKnI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2020 05:43:08 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BGAfsb9014384;
        Wed, 16 Dec 2020 02:42:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=2D3nlgUKSr40OZ/Tt4nd1ULrk3H9uSeBqTKSBGT8/LE=;
 b=kKPZnP22/LDw4Gdf6m4tsI/Pe3fHst6mGvcQ4pP894aroIAJpX/g3uvhTa0i8cHoqbZ+
 b2UruZbNyi4uReWL8IWrkmyjaXENporUno0VOckSnY1+4hBqtNJtXmLAEt2ghTWf1UsK
 rPwSswHGc5Rv3p3tB3t/0p9+ILNastrvuo35JpAAxiwND54nIc7aqUWfidpwSm1JQTIN
 9lVe0qBgDpS7K1HhZUC2kfZLVPNI3GVPqxwAyqo9R5apfcNPUozTD8SZm77k5jTnOpu1
 +ED8wPr/uCp2vErpRYyiM665a53x+xFqwtz1TqN+VLRlJH47lOPyFFcl5kQZXcFFaxtE pA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 35cv3t3s50-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 02:42:20 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Dec
 2020 02:42:19 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Dec
 2020 02:42:19 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 16 Dec 2020 02:42:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1MRwY3NSXJYVA3kJLANed1BFWzztLMrHxTjvP3baNx6HiQ18xeD4YkfmDLCBPf/WaOWwv85oV9VoXFXIwK0X44tyqKcFZt+t1/QPVplpA3HwXxLPspBMhXgzqcFxUnh/l351baImXXQDER1D14bmwPAVaXVm/HCd63DGJchMU/Brj2KMhWel+n5YJ29DMlIkImb1jJhOzSkD011zj3mCf3qlnc4TbXKsUAp9fqhNFcYy9dzJna8bVc8Uzs/KfdGMqvXI5cqfsJPVWcPOhLZ7NmZdWxGPa/4SD2QPmXHHeKsn8yroBdGl82erub0EmkulIXa9tngd9CrojAfYhJfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D3nlgUKSr40OZ/Tt4nd1ULrk3H9uSeBqTKSBGT8/LE=;
 b=jtXF37ITs4o9HV8l/Gd3hqQKAQ+b3Byw47fbKLuDxm8qSpSIfE+WpFKHbARU3h1sPhU9ZXzLwg2trxwC+pwJUR6Rnwi5+/iCKWon8QlUg/9YGqbIxoFRzsfxyHfkTyDm6DOx1mP5PDUasLzB7iDtvH1nUF7WGXE4xKpcVSKE0XuWf299LBquhzLasqhiN7jrfIavEMaQw2G9HEvmWFDgmjeUyYwG+16bODs11RA6+anrvseDXsNEgC+zk0ILjJseumrqQYnF333J/wBc72RSvQ3LPUpZ4L6T1iqqBBe5zbPCE1uzLj1WvE6yHWbtZgsKJW9HkmiqMJRM7FOoC8tEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D3nlgUKSr40OZ/Tt4nd1ULrk3H9uSeBqTKSBGT8/LE=;
 b=FSh++C3nFlkZVsiwuV41cF8l3rmn5P6vdL3F7ZIsjgrmn/Qp6ZOuq6Za+7x0fRpXlFmzK8B7xsVdFR4AQRVV9+9wCkfhR2gd6hVL8tMdUlLpLpkoiZ+586n4idVmoG0fHviz0dtoXahqkzR/FPeG5KBSZDUu++KWIxTRGdhspv0=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1189.namprd18.prod.outlook.com
 (2603:10b6:903:113::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.21; Wed, 16 Dec
 2020 10:42:16 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::f513:d620:a2c:744a]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::f513:d620:a2c:744a%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 10:42:16 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Topic: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Index: AQHWzJBGAAft6IQ2BkOkVnoLREcZc6nxyUkAgAXb/lCAAHB2AIAACZ6ggAFrHgCAAALOcA==
Date:   Wed, 16 Dec 2020 10:42:16 +0000
Message-ID: <CY4PR1801MB2070AE5FDA2AC539DD85D3CCDEC50@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com>
 <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
 <CY4PR1801MB207090582E5E763F3672153BDEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFpvRgsE3biXZncbR_qfU4+9Z1mf7fCB=aAchH7hTsq+Vw@mail.gmail.com>
In-Reply-To: <CAPDyKFpvRgsE3biXZncbR_qfU4+9Z1mf7fCB=aAchH7hTsq+Vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [27.59.203.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4776802-2ac1-4a99-dc38-08d8a1af41c4
x-ms-traffictypediagnostic: CY4PR18MB1189:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB118998B0360236FDFB4CBF5EDEC50@CY4PR18MB1189.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjO/XQSPm6ke6mBG2DAvVypJd42qxbT57N1FYsScBZ6StVYWo07dOlA9gsq57sRZWDoRIauPM70q4Mc/8b17wAI8c2w2pHG0rRzuHw7id1lIY6KYjx6+EjdtML7bPN4K7sd+MXx9prPC1RIuh4R9DMKKgYwbZdyheSVrv9jsfH1uGNhndLlKRZsr+CAxyXiw2Zqr+SaL5mbEdtvO0uGs79tNNaO6Q1Y6PK/Dsssq2nSCsW+O1c57xlzFBYuMA96xy2Njkc6ngKk5kJ3nLtHRaD6P/d1aEBYxUBOU3ZM4bSGIb6AtcN5+EL5hFReHOUXykS5jQUUftS3KHYrtg1GSmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(55016002)(316002)(54906003)(86362001)(26005)(64756008)(66476007)(4326008)(6506007)(83380400001)(66946007)(8676002)(2906002)(71200400001)(33656002)(7696005)(66556008)(76116006)(8936002)(5660300002)(9686003)(186003)(6916009)(66446008)(478600001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NkxUYjhwVUJYNWZxUS9FZU4xYjVZZTMxTkM4b2tsNFFBYThFU3hGVGlKY2hY?=
 =?utf-8?B?THJyZTFKL3Mvb3M5Wnp3ZXExbysyZnY4cWhzalh3QUExcGZBOHkvc1Z2VEVG?=
 =?utf-8?B?dWIzR0s3b205dWswSXpONGorcm1XUlhWd2dsU2c3ejB6QUgwSEtycE52VVZT?=
 =?utf-8?B?M09TcS9oSEFwY25MdXFXRjUzUm1lRGM3VlVvK0g0TVdMeWZrMS8venpOdWZ4?=
 =?utf-8?B?dGJzT3RkMVFCY241UFJqTVE3REhOMnFyNDdQanBzMXBaTUVTL2hJeHBTaDIz?=
 =?utf-8?B?TmZrY3Nzc1FzUlp3ckx6OWtnbjdPMDR6cm1GSVN5T1paWksrNWd3VXNsWFY0?=
 =?utf-8?B?N1M2VkRxTHE2Wmx4OVd2RnNudnJXQkdZUEowN1FZZ0JkOCtYZjFzc3BJZnpQ?=
 =?utf-8?B?dWpsZzB4ZHJ1YUovNTBISERqZENpZmhWNW01eitldzVaRmV5dzdUb1p1REV5?=
 =?utf-8?B?NTdQRHRWbSszMkQ2b0RRUm5EbGc3R2JjWXFBTmlvNzVtQ21BbHBwT2FzMDlI?=
 =?utf-8?B?ZC9pYUJUWHE4aUlsb0Y3Vlh1dDZhVm92U2IwTTNkRkdmZFJWTC9iN3A4ajkx?=
 =?utf-8?B?L0c5UWlqbTNmSlpZV3FWQi9XWlB2ZVdNNC9mRnNld3RrQWxVOFlHbmhaWUxo?=
 =?utf-8?B?Mm1ZVlVvMm9VZStaV2VHNlVaSFRFUi8vRm4ydWkwY0s1QnZqdjFGWEVKaWFm?=
 =?utf-8?B?WWJiUVcwckRycnB0bytuWkVrb0pURy9FbmxIdkorOWI5YU5CSjJ4UnR5UlFo?=
 =?utf-8?B?QVRlajNGRnVFREZuQzF5dkIxR3QzOFUzK0JVcGMvNmZyQVFyQjkwa1pNUWU1?=
 =?utf-8?B?Szk1WTBVZUV1ZFlUR0QwNFlKWmFsV25hOUx4WC9IcytPTkhKVHkwVm51elNE?=
 =?utf-8?B?c3dPK3NOZCswMVl0WGxMZzdJOGgwdU9KMlVtRDQ2czlWOVRGbS9zd2tUb2xQ?=
 =?utf-8?B?L29Ucm56blM3dmVjYTV4NU41bUp1WThpb2Nod3ZlNWwrUGZWRnBFNHVqV2cx?=
 =?utf-8?B?S2EvSkswdzVhaHBNTk9Xd3BjMnh5bWwzOFVoekhHSGZiaWlxSGFKQ2p2MTND?=
 =?utf-8?B?UkdWZ3lOM0FNaDdGYm9TZlZ1NERhN0hmc1gxWWU1eCtZTVBFZ20za3ZJUFl0?=
 =?utf-8?B?cFhUM3RTeCtJWWVSVnE1OGxYdWVEWVpIT1pmZGNpdWpEOUprazdZMVZTQW1R?=
 =?utf-8?B?ZmlhV05TZ0xwako0RDhtSzJrT2kvWG9BaDlHcDFZV3JpTzA2M2gyZ2FreExI?=
 =?utf-8?B?ZGUveXJyaFFjanQxdDA0eUs4WDJ1UVg1aDlST1c4Q29Vb3pZRWhHc3IwS0Mx?=
 =?utf-8?Q?cA/aS0/yxGZL0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4776802-2ac1-4a99-dc38-08d8a1af41c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 10:42:16.6145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qSDMlyF0Hx2ug/9Kpp/D3Pwz6oYMV6F3WLMqzAOFEtCb/BOkcgTQMda3dRCE2sBK1JIwzx9azTXjTabs63dow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1189
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_04:2020-12-15,2020-12-16 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFVsZiBIYW5zc29uIDx1bGYu
aGFuc3NvbkBsaW5hcm8ub3JnPg0KPlNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMTYsIDIwMjAg
MzoyNyBQTQ0KPlRvOiBCaGFza2FyYSBCdWRpcmVkbGEgPGJidWRpcmVkbGFAbWFydmVsbC5jb20+
DQo+Q2M6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPjsgQ29saW4gQ3Jvc3MNCj48
Y2Nyb3NzQGFuZHJvaWQuY29tPjsgVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgU3Vu
aWwgS292dnVyaQ0KPkdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgbGludXgtbW1jQHZn
ZXIua2VybmVsLm9yZzsgTGludXgNCj5LZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgQ2hyaXN0b3BoIEhlbGx3aWcNCj48aGNoQGxzdC5kZT4NCj5TdWJq
ZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCAxLzJdIG1tYzogU3VwcG9ydCBrbXNnIGR1bXBlciBi
YXNlZCBvbg0KPnBzdG9yZS9ibGsNCj4NCj5bLi4uXQ0KPg0KPj4gPj4gPg0KPj4gPj4gPkl0IGxv
b2tzIGxpa2UgdGhlIGFib3ZlIEkvTyByZWFkL3dyaXRlIGludGVyZmFjZSBmb3IgcHN0b3JlIGlz
DQo+PiA+PiA+aW50ZW5kZWQgdG8gYmUgdXNlZCB3aGVuIHRoZSBwbGF0Zm9ybSBpcyB1cCBhbmQg
cnVubmluZyBhbmQgbm90DQo+PiA+PiA+ZHVyaW5nIGENCj4+ID5wYW5pYywgY29ycmVjdD8NCj4+
ID4+ID4NCj4+ID4+ID5JZiBzbywgSSBkb24ndCBnZXQgd2h5IGl0IGNhbid0IHVzZSB0aGUgcmVn
dWxhciBibG9jayBpbnRlcmZhY2UsDQo+PiA+PiA+YXMgYW55IG90aGVyIGZpbGUgc3lzdGVtIGRv
ZXMsIGZvciBleGFtcGxlPw0KPj4gPj4gPg0KPj4gPj4NCj4+ID4+IFRoZSBwc3RvcmUgcmVhZCBh
bmQgd3JpdGUgb3BlcmF0aW9ucyBhcmUgdXNlZCBhcyBwYXJ0IG9mIHBzdG9yZQ0KPj4gPj4gZmls
ZSBzeXN0ZW0gbW91bnRpbmcgdG8gcmV0cmlldmUgdGhlIHN0b3JlZCBsb2dzIGZyb20gTU1DIHBs
YXRmb3JtDQo+PiA+PiBiYWNrZW5kIGFuZCB0byBtYW5hZ2UgcHN0b3JlIHJlYWQvd3JpdGUgY291
bnRlcnMuIFNsZWVwaW5nIHdvdWxkIGJlDQo+PiA+PiBhbGxvd2VkIGR1cmluZyB0aGlzIHRpbWUu
IFdoZXJlYXMsIHBzdG9yZSBQQU5JQyB3cml0ZSB3aWxsIGJlDQo+PiA+PiBjYWxsZWQgaWYgdGhl
cmUgaGFwcGVucw0KPj4gPmEgY3Jhc2ggaW4gdGhlIHN5c3RlbS4gU2xlZXBpbmcgaXMgTk9UIGFs
bG93ZWQgYXQgdGhpcyB0aW1lLg0KPj4gPj4NCj4+ID4+IEl0IHNlZW1zIHlvdSBhcmUgbWl4aW5n
IHRoZSBzbGVlcGluZyBwYXRocyBvZiB0aGUgbW1jcHN0b3JlIHdpdGgNCj4+ID4+IHRoYXQgb2YN
Cj4+ID5hdG9taWMgcGF0aC4NCj4+ID4NCj4+ID5ObywgSSBhbSBub3QgbWl4aW5nIHRoZW0sIGJ1
dCBxdWVzdGlvbmluZyB0aGVtLg0KPj4gPg0KPj4gPkZvciB0aGUgbm9uIGF0b21pYyBwYXRoLCBJ
IGRvbid0IHVuZGVyc3RhbmQgd2h5IHRoZSBwc3RvcmUgZmlsZQ0KPj4gPnN5c3RlbSBtb3VudGlu
ZywgZXRjLCBkZXNlcnZlcyB0byBiZSBtYW5hZ2VkIHRocm91Z2ggaXRzIG93biBzcGVjaWZpYw0K
Pm9wcz8NCj4+ID5BcmUgdGhlcmUgYW55IHNwZWNpZmljIHJlYXNvbnMgZm9yIHRoaXMgdGhhdCBJ
IGFtIG1pc3Npbmc/DQo+PiA+DQo+Pg0KPj4gU2VlbXMgZ2VuZXJpYyB3YXkgaXMgdW5kZXJnb2lu
ZyBzb21lIGNoYW5nZXMuIEtlZXMgYWxyZWFkeSBBQ0tlZCB0aGUNCj4+IG1tY3BzdG9yZSByZWdp
c3RyYXRpb24gdGhyb3VnaCBibG9jayBkZXZpY2UgcmVnaXN0cmF0aW9uLg0KPj4NCj4+ID5JbiBw
cmluY2lwbGUsIGZvciBub24gYXRvbWljIHBhdGgsIEkgd291bGQgcmF0aGVyIHNlZSB0aGF0IHRo
ZSBwc3RvcmUNCj4+ID5maWxlIHN5c3RlbSBzaG91bGQgYmUgYWJsZSB0byBiZSBtb3VudGVkIG9u
IHRvcCBvZiBhbnkgZ2VuZXJpYyBibG9jaw0KPj4gPmRldmljZSBwYXJ0aXRpb24gLSB3aXRob3V0
IHJlcXVpcmluZyB0aGUgYmxvY2sgZGV2aWNlIGRyaXZlciB0byBpbXBsZW1lbnQNCj5zcGVjaWZp
YyBwc3RvcmUgb3BzLg0KPj4gPg0KPj4NCj4+IFNjb3BlIHRvIGFuc3dlciB0aGlzIGlzIG91dCBv
ZiBtbWNwc3RvcmUgZHJpdmVyLiBQc3RvcmUvYmxrIGRyaXZlcg0KPj4gaGF2ZSB0byBhbnN3ZXIg
dGhpcy4NCj4NCj5ZZXAsIEkgYW0gb3BlbiB0byBkaXNjdXNzIHRoaXMgbW9yZS4NCj4NCj4+DQo+
PiA+Pg0KPj4gPj4NCj4+ID4+ID4+ICsNCj4+ID4+ID4+ICtzdGF0aWMgdm9pZCBtbWNwc3RvcmVf
cGFuaWNfd3JpdGVfcmVxKGNvbnN0IGNoYXIgKmJ1ZiwNCj4+ID4+ID4+ICsgICAgICAgICAgICAg
ICB1bnNpZ25lZCBpbnQgbnNlY3RzLCB1bnNpZ25lZCBpbnQgc2VjdF9vZmZzZXQpIHsNCj4+ID4+
ID4+ICsgICAgICAgc3RydWN0IG1tY3BzdG9yZV9jb250ZXh0ICpjeHQgPSAmb29wc19jeHQ7DQo+
PiA+PiA+PiArICAgICAgIHN0cnVjdCBtbWNfcmVxdWVzdCAqbXJxID0gY3h0LT5tcnE7DQo+PiA+
PiA+PiArICAgICAgIHN0cnVjdCBtbWNfY2FyZCAqY2FyZCA9IGN4dC0+Y2FyZDsNCj4+ID4+ID4+
ICsgICAgICAgc3RydWN0IG1tY19ob3N0ICpob3N0ID0gY2FyZC0+aG9zdDsNCj4+ID4+ID4+ICsg
ICAgICAgc3RydWN0IHNjYXR0ZXJsaXN0IHNnOw0KPj4gPj4gPj4gKyAgICAgICB1MzIgb3Bjb2Rl
Ow0KPj4gPj4gPj4gKw0KPj4gPj4gPj4gKyAgICAgICBvcGNvZGUgPSAobnNlY3RzID4gMSkgPyBN
TUNfV1JJVEVfTVVMVElQTEVfQkxPQ0sgOg0KPj4gPj4gPk1NQ19XUklURV9CTE9DSzsNCj4+ID4+
ID4+ICsgICAgICAgbW1jX3ByZXBfcmVxKG1ycSwgc2VjdF9vZmZzZXQsIG5zZWN0cywgJnNnLCBv
cGNvZGUsDQo+PiA+PiA+TU1DX0RBVEFfV1JJVEUpOw0KPj4gPj4gPj4gKyAgICAgICBzZ19pbml0
X29uZSgmc2csIGJ1ZiwgKG5zZWN0cyA8PCBTRUNUT1JfU0hJRlQpKTsNCj4+ID4+ID4+ICsgICAg
ICAgbW1jX3NldF9kYXRhX3RpbWVvdXQobXJxLT5kYXRhLCBjeHQtPmNhcmQpOw0KPj4gPj4gPj4g
Kw0KPj4gPj4gPj4gKyAgICAgICBtbWNfY2xhaW1faG9zdChob3N0KTsNCj4+ID4+ID4NCj4+ID4+
ID5TbywgdGhpcyB3aWxsIHVzZSBzZXZlcmFsIGxvY2tzLCB3aGljaCBtYXkgYmUgYSBwcm9ibGVt
LCByaWdodD8NCj4+ID4+ID4NCj4+ID4+DQo+PiA+PiBObywgYXMgc2FpZCBhYm92ZSBsb2NrcyBh
cmUgcHJlc2VudCBvbiBob3N0IGRyaXZlciB3aWxsIGJlIGRyb3BwZWQNCj4+ID4+IGluIENPTkZJ
R19NTUNfUFNUT1JFIHBhdGguDQo+PiA+DQo+PiA+UGxlYXNlIGhhdmUgYSBsb29rIGF0IHRoZSBj
b2RlIGltcGxlbWVudGluZyBtbWNfY2xhaW1faG9zdCgpLiBJdCdzDQo+PiA+bm90IGp1c3QgYSBz
aW1wbGUgc3Bpbl9sb2NrLCBidXQgdGhlcmUgaXMgYWxzbyBhIHdhaXRfcXVldWUgYW5kDQo+PiA+
cnVudGltZSBQTSBiZWluZyBtYW5hZ2VkIGZyb20gdGhlcmUuDQo+PiA+DQo+PiA+Pg0KPj4gPj4g
Pk1vcmVvdmVyLCBpZiB0aGVyZSBpcyBhbiBvbmdvaW5nIEkvTyByZXF1ZXN0IChvciBhbnkgb3Ro
ZXIgYWN0aXZlDQo+PiA+PiA+Y29tbWFuZC9yZXF1ZXN0IGZvciB0aGF0IG1hdHRlciksIHRoZW4g
dGhlIGhvc3QgaXMgYWxyZWFkeSBjbGFpbWVkDQo+PiA+PiA+YnkgdGhlIG1tYyBjb3JlLiBOb3Jt
YWxseSwgd2Ugd291bGQgdGhlbiB3YWl0IGZvciB0aGF0IHJlcXVlc3QgdG8NCj4+ID4+ID5iZSBj
b21wbGV0ZWQsIHRvIHRyaWdnZXIgdGhlIHJlbGVhc2Ugb2YgdGhlIGhvc3QgYW5kIHRoZW4gYWxs
b3cgdXMNCj4+ID4+ID50byBjbGFpbSBpdA0KPj4gPmhlcmUuDQo+PiA+PiA+DQo+PiA+PiA+SG93
ZXZlciwgYmVjYXVzZSBvZiB0aGUga2VybmVsIHBhbmljLCBJIGFzc3VtZSBpdCdzIHF1aXRlIGxp
a2VseQ0KPj4gPj4gPnRoYXQgYW55IG9uZ29pbmcgcmVxdWVzdCB3aWxsIG5vdCBiZSBjb21wbGV0
ZWQgYXQgYWxsLCBhcyBJUlFzIG1heQ0KPj4gPj4gPm5vdCB3b3JrLCBmb3IgZXhhbXBsZS4NCj4+
ID4+ID4NCj4+ID4+ID5JbiBvdGhlciB3b3Jkcywgd2UgbWF5IGJlIGhhbmdpbmcgaGVyZSBmb3Jl
dmVyIHdhaXRpbmcgdG8gY2xhaW0gdGhlDQo+aG9zdC4NCj4+ID4+ID5Vbmxlc3Mgd2UgYXJlIGx1
Y2t5LCBiZWNhdXNlIG9mIG5vIG9uZ29pbmcgcmVxdWVzdCwgYWx0aG91Z2ggd2UNCj4+ID4+ID53
b3VsZCBzdGlsbCBoYXZlIHRvIHN1Y2NlZWQgd2Fsa2luZyB0aHJvdWdoIGFsbCB0aGUgbG9ja2lu
ZywgZXRjLA0KPj4gPj4gPmluDQo+PiA+bW1jX2NsYWltX2hvc3QoKS4NCj4+ID4+ID4NCj4+DQo+
PiBJIGFncmVlIHdpdGggeW91ciBjb25jZXJucyBhYm91dCBzcGluX2xvY2ssIHdhaXRfcXVldWUg
YW5kIHJ1bnRpbWUgUE0NCj4+IGluIG1tY19jbGFpbV9ob3N0KCksIGJ1dCBub3QgdGhlIG9uZ29p
bmcgcmVxdWVzdHMgcHJlc2VuY2UuIFRoZXkgbXVzdA0KPj4gaGF2ZSB0ZXJtaW5hdGVkIGNsZWFu
bHkgdGhyb3VnaCBob3N0LT5vcHMtPnJlcV9jbGVhbnVwX3BlbmRpbmcoaG9zdCkNCj4+IGJlZm9y
ZSByZWFjaGluZyBtbWNfY2xhaW1faG9zdCgpLg0KPj4NCj4+IEkgd2lsbCBjb21lIHVwIHdpdGgg
c29tZXRoaW5nIHRvIGFkZHJlc3MgdGhlc2UgaW4gdGhlIG5leHQgcGF0Y2guDQo+Pg0KPj4gPj4N
Cj4+ID4+IGhvc3QtPm9wcy0+cmVxX2NsZWFudXBfcGVuZGluZyhob3N0KSB3YXMgaW50cm9kdWNl
ZCB0byBjbGVhbiB1cCB0aGUNCj4+ID4+IGhvc3QtPm9wcy0+cXVldWVkDQo+PiA+PiBhbmQgb25n
b2luZyByZXF1ZXN0cy9jb21tYW5kcy4gVGVybWluYXRpbmcgb25nb2luZyByZXF1ZXN0cyBpcyBu
b3QNCj4+ID4+IGEgY29tcGxpY2F0ZWQgdGhpbmcgZm9yIHRoZSBob3N0IGRyaXZlcnMuDQo+PiA+
DQo+PiA+V2VsbCwgSSBkb24ndCBhZ3JlZS4gUmVzZXR0aW5nIHRoZSBob3N0IGNvbnRyb2xsZXIg
c2hvdWxkIG5vdCBiZSBhDQo+PiA+YmlnIHByb2JsZW0sIGJ1dCBJIGFtIG1vcmUgd29ycmllZCBh
Ym91dCB3aGF0IHN0YXRlIHRoaXMgd2lsbCBicmluZyB0aGUNCj5lTU1DL1NEIGNhcmQgaW4uDQo+
PiA+DQo+Pg0KPj4gSSBhbSBub3Qgc3VyZSB3aHkgYXJlIHlvdSBzYXlpbmcgaG9zdCBjb250cm9s
bGVyIHJlc2V0LiBObyB3YXJlIGhvc3QNCj4+IGNvbnRyb2xsZXIgcmVzZXQgd2FzIHBlcmZvcm1l
ZCBhcyBwYXJ0IG9mIHRoZXNlIHBhdGNoZXMuDQo+Pg0KPj4gPkl0IHNvdW5kcyB0byBtZSB0aGF0
IHRoZSBvbmx5IG9wdGlvbiBpcyB0byB0cnkgdG8gcmVseSBvbiB0aGUNCj4+ID5tbWNfY2xhaW1f
aG9zdCgpIHRvIGFjdHVhbGx5IHN1Y2NlZWQuIFRoaXMgbWFrZXMgaXQgY2VydGFpbiB0aGF0DQo+
PiA+dGhlcmUgaXMgbm8gb25nb2luZyByZXF1ZXN0IHRoYXQgbmVlZHMgdG8gYmUgdGVybWluYXRl
ZC4gT3RoZXJ3aXNlLA0KPj4gPnRoaW5ncyB3aWxsIGp1c3QgZmFsbCBhcGFydC4NCj4+ID4NCj4+
DQo+PiBBZ3JlZS4gU2VlbXMgSSBuZWVkIHRvIGNyZWF0ZSBhbiBhbHRlcm5hdGUgcGF0aCB0byBm
b3JjZWZ1bGx5IGdhaW4NCj4+IGFjY2VzcyB0byB0aGUgaG9zdCBmb3IgdGhlIGNhc2Ugb2YgcGFu
aWMgd3JpdGUuIEFzIHlvdSBwb2ludGVkIG91dA0KPj4gbW1jX2NsYWltX2hvc3QoKSwgbW1jX3Jl
bGVhc2VfaG9zdCgpIGFuZCBydW50aW1lIFBNIGNhbiBjcmVhdGUgaXNzdWVzLg0KPj4NCj4+ID5U
aGUgcXVlc3Rpb24gaXMsIGNhbi9zaG91bGQgd2UgcmVseSBvbiBtbWNfY2xhaW1faG9zdCgpIHRv
IHN1Y2NlZWQgaW4NCj4+ID50aGlzIHBhdGg/IE1heWJlIGl0IHdpbGwgd29yaywgaW4gY2FzZXMg
d2hlbiB0aGVyZSBpcyBubyBvbmdvaW5nDQo+PiA+cmVxdWVzdCwgYXMgaXQgbWVhbnMgdGhlIGhv
c3Qgc2hvdWxkIGJlIGF2YWlsYWJsZSB0byBiZSBpbW1lZGlhdGVseQ0KPj4gPmNsYWltZWQuIEFs
dGhvdWdoLCB0aGVuIHRoZSBwcm9ibGVtIGVuZHMgdXAgd2l0aCBydW50aW1lIFBNLCBhcyBpZg0K
Pj4gPnRoZSBob3N0IGlzIGF2YWlsYWJsZSBmb3IgY2xhaW1pbmcsIGl0J3MgbGlrZWx5IHRoYXQg
dGhlIGhvc3QgaXMgcnVudGltZQ0KPnN1c3BlbmRlZC4uLg0KPj4gPg0KPj4NCj4+IEFuIGV4dHJh
IGNoZWNrIGNhbiBiZSBhZGRlZCB0byBzZWUgaWYgaG9zdCB3YXMgcnVudGltZSBzdXNwZW5kZWQg
YWhlYWQNCj4+IG9mIHBhbmljIHdyaXRlIGF0dGVtcHQuDQo+DQo+V2hhdCBpZiB0aGF0IGlzIHRo
ZSBjYXNlLCBzaG91bGQgd2UganVzdCByZXR1cm4gYW4gZXJyb3I/DQo+DQpZZXMuDQoNCj5Nb3Jl
b3ZlciwgZXZlbiB0aGUgZGV2aWNlIGJlbG9uZ2luZyB0byB0aGUgbW1jIGNhcmQgY2FuIGJlIHJ1
bnRpbWUNCj5zdXNwZW5kZWQgdG9vLiBTbyBpZiB0aGF0IGlzIHRoZSBjYXNlLCB3ZSBzaG91bGQg
cmV0dXJuIGFuIGVycm9yIHRvbz8NCj4NCg0KWWVzLCBzYW1lIGhlcmUuDQoNCkFzc3VtaW5nIC0+
cmVxX2NsZWFudXBfcGVuZGluZygpIHByb3Blcmx5IHRlcm1pbmF0ZXMgdGhlIG9uZ29pbmcgRE1B
IHRyYW5zZmVycywNCm1tY19jbGFpbV9ob3N0KCkgYW5kIG1tY19yZWxlYXNlX2hvc3QoKSBjYW4g
YmUgZHJvcHBlZCBpbiBwYW5pYyB3cml0ZSBjYXNlDQphcyBpdCBoYXMgdGhlbiBleGNsdXNpdmUg
YWNjZXNzIGZyb20gdGhlbiBvbi4NCg0KDQo+Wy4uLl0NCj4NCj4+ID4+ID5bLi4uXQ0KPj4gPj4g
Pg0KPj4gPj4gPkhhdmluZyBzYWlkIHRoZSBhYm92ZSwgSSBhbSBub3QgZW50aXJlbHkgY29udmlu
Y2VkIHRoYXQgaXQgbWFrZXMNCj4+ID4+ID5zZW5zZSB0byBzdXBwb3J0IHRoaXMsIGF0IGFsbC4N
Cj4+ID4+ID4NCj4+ID4+ID5Ob3Qgb25seSwgd2lsbCB0aGUgc3VwcG9ydCBiZSBoaWdobHkgZnJh
Z2lsZSBmcm9tIHRoZSBtbWMgY29yZQ0KPj4gPj4gPnBvaW50IG9mIHZpZXcsIGJ1dCB0aGVyZSBp
cyBhbHNvIGEgc2lnbmlmaWNhbnQgY29tcGxleGl0eSBmb3IgYW4NCj4+ID4+ID5tbWMgaG9zdCBk
cml2ZXIgdG8gc3VwcG9ydCB0aGlzIChhdCBsZWFzdCBpbiBnZW5lcmFsKS4NCj4+ID4+ID4NCj4+
ID4+DQo+PiA+PiBJIGFtIG5vdCBzdXJlIGlmIHRoZSBjb21tZW50cyBvbiBob3N0IGRyaXZlciBj
b21wbGV4aXR5IGlzIHRydWUuDQo+PiA+PiBUZXJtaW5hdGluZyBvbmdvaW5nIHJlcXVlc3RzIGFu
ZCBpbnRyb2R1Y2luZyBwb2xsaW5nIGZ1bmN0aW9ucyBvbg0KPj4gPj4gaG9zdCBkcml2ZXJzIHNo
b3VsZCBiZSBzdHJhaWdodCBmb3J3YXJkLiBOb25lIHRob3NlIHdvdWxkIGRpc3R1cmINCj4+ID4+
IHRoZSBjb3JlIGZ1bmN0aW9uYWxpdHkuIFRoZXkgYXJlIGNvbXBsZXRlbHkgaW5kZXBlbmRlbnQu
DQo+PiA+DQo+PiA+SSB0aGluayB5b3UgYXJlIHVuZGVyZXN0aW1hdGluZyB0aGUgcGFydCB3aXRo
IHRlcm1pbmF0aW5nIG9uZ29pbmcNCj4+ID5yZXF1ZXN0cy4gSXQgc291bmRzIHRvIG1lIHRoYXQg
eW91IHJlYWxseSBoYXZlbid0IGJlZW4gdGVybWluYXRpbmcNCj4+ID5hbnkgcmVxdWVzdHMgYXQg
YWxsLCBidXQgcmF0aGVyIGp1c3QgZG9pbmcgYSByZXNldCBvZiB0aGUgbW1jDQo+PiA+Y29udHJv
bGxlciAod2hpY2ggaXMgd2hhdCBJIG9ic2VydmVkIGluIHBhdGNoMikuDQo+PiA+DQo+Pg0KPj4g
Tm8sIGl0J3Mgbm90IHRydWUuIEkgYW0gbm90IGRvaW5nIGFueSByZXNldC4gUGxlYXNlIHBvaW50
IG1lIHRvDQo+PiBzcGVjaWZpYyBjb2RlIHNuaXBwZXQgd2hlcmUgeW91IGhhdmUgb2JzZXJ2ZWQg
dGhpcy4NCj4NCj5JIHdhcyBsb29raW5nIGF0IHBhdGNoMiBhbmQgdGhlIC0+cmVxX2NsZWFudXBf
cGVuZGluZygpIGNhbGxiYWNrIHRoYXQgeW91DQo+aGF2ZSBhc3NpZ25lZCB0byBjdm1fcmVxX2Ns
ZWFudXBfcGVuZGluZygpLg0KPg0KPkluIHRoZXJlIHlvdSBjbGVhciBhIHBvdGVudGlhbGx5IHJ1
bm5pbmcgRE1BIGpvYiwgd2hpY2ggaXMgKmtpbmQqIG9mIGEgcmVzZXQgb2YNCj50aGUgY29udHJv
bGxlci4gTW9yZSBpbXBvcnRhbnRseSwgaXQncyBkZWZpbml0ZWx5ICpub3QqIHRlcm1pbmF0aW5n
IGFuIG9uZ29pbmcNCj5yZXF1ZXN0LCBpbiBhIHdheSB0aGF0IHlvdSBjYW4gZXhwZWN0IHRoZSBl
TU1DL1NEIGNhcmQgdG8gYmUgcmVhZHkgZm9yIG5ldw0KPmNvbW11bmljYXRpb25zIGFmdGVyd2Fy
ZHMuIFRoaXMgaXMgbXkgbWFpbiBwb2ludC4NCj4NCg0KSSBhbSBub3Qgc3VyZSB0aGF0IGNsZWFy
aW5nIGFuIG9uZ29pbmcgRE1BIHdpbGwgcmVzZXQgdGhlIGNvbnRyb2xsZXIuIFRoZXNlIGFyZSBo
b3N0DQpjb250cm9sbGVyIHNwZWNpZmljLiBUaGUgaWRlYSBpczogVG8gZHJvcCBvbmdvaW5nIHRy
YW5zZmVycywgd2hhdGV2ZXIgYSBob3N0IHNvZnR3YXJlDQpoYXMgdG8gZG8gaXQgd2lsbCBkb2Vz
IHRocm91Z2ggdGhpcyBjbGVhbnVwIGZ1bmN0aW9uLiBXZSBtYXkgbm90IGdlbmVyYWxpemUgdGhp
cywNCnByb3ZpZGluZyBhIGhvb2sgYW5kIGxldHRpbmcgZWFjaCBob3N0IGNvbnRyb2xsZXIgaGFu
ZGxpbmcgaXQgc2VlbXMgYmV0dGVyLg0KDQo+S2luZCByZWdhcmRzDQo+VWZmZQ0KDQpUaGFua3Ms
DQpCaGFza2FyYQ0K
