Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882F1C07E95
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 06:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FA5619B5
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 06:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhGGGvp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Jul 2021 02:51:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62662 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhGGGvo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jul 2021 02:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625640544; x=1657176544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wY9FpF391Kz4pzqkwyyAxjKEJn/LN0WLW87qEbzrfpw=;
  b=ZEXrzlfaoIQRIJWYRZSKLeIQWADPasPsmXLH3M/CS4XQaXSyPux0g7NJ
   RnSpi5wKReWDIvw5EFiRGiElu9mMCysv31WJWMNYuxDEVLH7Hi+wSz9oU
   q5r+HxF1Ch1m0PwE5yL6NpTZPMuNQH+RCW3V3n1xygA4t1AhFH8KT2HAQ
   AfrACKePP5UGqL+YJvAArOLaJ0QBGA6Y2G+Hf1mUXWfBnyoX0EAM2v5xz
   1Kzv+VfyVEuzApnpyvSIkFWMWHUc96vLA+RL91Zrj+PEyqEUWRU1y0+Ed
   AadPD2FqMo31VaZCox33FLfLXydEeZAVs7Qa7tlJV9l26v/nlmYZr4sby
   g==;
IronPort-SDR: EJ918LaIc2LAGXtcJjqzcMjq+Q+srPY7j4n1zWGzABM9Ihc3MUn9a1PCltwY/0v3r6NFCEZySY
 Qdgppk8SebJtd2stTAvjOJZfre58H7vse5K3tY9sRntYLo20eGhCg0eRRS9NqaoNOYjMRJGMqK
 /+nUUGqUzG0jqjJxFYPuFVz8TkopKTK3lCfVQFL9f0sf+y0fqwWA4lL8QuycEiO59JP6u2Da6O
 bbRHtbCvlu8g5uqiB3OGDA7/l7Ik9ZLYb6XBl9ynRfTulINqtBVqaHG8uFXU5y5QvhqMPAFq98
 X9g=
X-IronPort-AV: E=Sophos;i="5.83,331,1616428800"; 
   d="scan'208";a="173905933"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2021 14:49:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp9qfF62BxnRkU8Kqmxxvmfh07Wp6D7OTdX48mKu0H53IZSaZykr0zJArF38Zk63TlLUFCfpQt+HVboFlToMOXhdYztiCGcX3d/T5HYZKLl3kCoYMUfjIPg2X6ojCKqFfluwsN9oZWBCYlYlv+GH651xKSOj4XNGOG/fxeUuYvGXQWdWI2oW0bTQDPTn2yEvfGVfMQ5QdgSYHy/Px5UgzF8dHUoT7DQhjHbljqPH/32cfHNDijJEjxio8ZGWcM3SGYD96yS2dL4u8CsYXf9AIub4gPAhVhp5uZkEkYuZiiIU47k4uz4FnArOIPMaoZie91q+FlWxSs7MwSOa+gcnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY9FpF391Kz4pzqkwyyAxjKEJn/LN0WLW87qEbzrfpw=;
 b=nVpfW5zUf62MV9GeyIUZJC+gYIkFtGbWFC4VcUAnlkHKvREEjEplb7EUPDAQVdDSwz9IU/IXeZKiASZXXuWH67rn2qqxsLd3caJmUAnIevENhJj58KNgW0fjxV+LAEpBgeNrBaXc4R2YUInrJSEWqRa5D85SBry2MzxBdvI0QIriOToDiGhg/pDveO2eVJm1fYJIJ0quCSVC5j2UhbwX3F3gMstfNyAgNY5cm5scdSjP7z2WDAta+hzxCuhGb+EO8uIFHlnIvXKTCGcPqIqYUM+i16LgWGxvZDEtnRoZeHUWVkgJqEBMQs0qOQP3jU257z9Sxw7fMxWTuLniKN7LvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY9FpF391Kz4pzqkwyyAxjKEJn/LN0WLW87qEbzrfpw=;
 b=UCrOIpkNLuxrWmJarF202R2iL/SuEEpwRWLsXQ7Tkw2WKaibt7hE8nsEhsUzUq+95JSomcwEiNBnYBJtOPS/o+JWiigjgPXRKtKdZlrFlDuDY2ho6cqOxVlmGCPZ1aYzD3uiXO1W82reMPsQR/M5Ttk4gSAy+wf83e7RXj2b2HU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4490.namprd04.prod.outlook.com (2603:10b6:5:22::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20; Wed, 7 Jul 2021 06:49:04 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ccfd:eb59:ccfe:66e4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ccfd:eb59:ccfe:66e4%5]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 06:49:04 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Topic: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Index: AQHXbl0Q77+Qfc7HWE6ez2HIF5qrJas1omGlgAAGD4CAAADv5IABbwLg
Date:   Wed, 7 Jul 2021 06:49:03 +0000
Message-ID: <DM6PR04MB6575B0049B98254E77BA447EFC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com>
 <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hyperstone.com; dkim=none (message not signed)
 header.d=none;hyperstone.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78b2b002-534f-486e-641a-08d941134f56
x-ms-traffictypediagnostic: DM6PR04MB4490:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM6PR04MB4490B46F9BA787AB8830AB19FC1A9@DM6PR04MB4490.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHt7ze9XGNDqGl5JdyLvcaCC/Pa682mYDh3aZSaahlxl+Y0kGL8PFCvdjlKZ5NVZvkk/dpPrHjqmEdbWf4dBRJynQy+ggoY+k9wxGMDjk2e1w6m8xNC80h265tmZ9ItiIhscmBHiggXOKpNXTysLn96Pm6jey1qPu+aR2H74zdej966B4pnM3FA5nQdWD+DsGFogqclteQyNn5uUJxt6oCwwhH8GnNQTz1d1hTkpgRjEGEU14EXu8UwE8oUqSfBeK+/X5P/MnfvjzC+GufaQYXRGGVLAtF5kx13f8D8iT8cIU80iUDyCurkxlxLfmIU77DxkOor3y5aJ1Z8sa7z5QStZyuYicl1QcjQfzqhfXhMmDhV+F/OWQLDLeFvtCYw3faULkiRnkj1FcP4t6ZAon7dE+UOGCpMS88cfwfiWot1qbiVaTxUurHZ/tC06Vde7Z5Oonc8ZIvbL5UyCaC81ZweiPfEMhKw8wlyEtlNy/zKIN3dbcyrEGqDfqRXjk/w+5oVB3jNDsF3/0VkGzsDXiahzwdJFfhdVFkqmZbVCUz8pUDn41J3P3d4t793lyUbBGL17RX/ZxB3Fl3hd5vfsTuqu7zOl8wcG9j8PDb1s9bjiJ8RMYHFUGLIosCUcY1lHaV7ZqGZr5EIEdylGpAzVyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(478600001)(4326008)(110136005)(54906003)(316002)(8676002)(122000001)(9686003)(71200400001)(2906002)(33656002)(55016002)(5660300002)(8936002)(7696005)(186003)(76116006)(66946007)(52536014)(6506007)(66476007)(66446008)(64756008)(86362001)(66556008)(83380400001)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2ZzTGNyRnFvTUZ4aE13bGtWVUM0dStlTHlkTDd0SG1pclpjblFQSzA2cnpZ?=
 =?utf-8?B?OWJXY2U2ZmVoVURSa3RORDBDV0xnZENqUHBlM0dUOVVDYmlNRWE4Q1pFZGkv?=
 =?utf-8?B?Q3ZCZ2tVRXpYaXBNaVlxdUJtZS8rMUQ3NkRVcGs1OTVvWXJuMytqcjh4Q200?=
 =?utf-8?B?Vmxld3lpU3NOUWJtSDgwMlZBd2JUbGdzRGNvU2JWRlpPRWNtNWVFM3c1K01W?=
 =?utf-8?B?TllzVDdEVHZHSnVEVk12SzRTNjFNT1ViUDRLNFBJM3VzbnJhTDhZNVgwMWt0?=
 =?utf-8?B?N2s5VGxjVUtjNG9kWjRQSkYxL0tYWnpseXlXYU5tT2o5Zlg0ak9KckVtU0or?=
 =?utf-8?B?cmVRU1VoVFRJSXZxWDRkbW9za3ZoNGhnWEtOMlVCMEhJOXNtdTJaVEt4SE5T?=
 =?utf-8?B?dDZ1c3hoR3pSNmJFWHVTNzBrRXA1U0JWS0oxS3BEV3BIMXZ3ZFI0UmxZZmhv?=
 =?utf-8?B?N2NvTEdvanpFbWIrQzdid1VIUUVDWmE1R3VVeXJDOHJ4bzdBLy9VU01RM0p6?=
 =?utf-8?B?SVoxQ3JSV3U3WWlxYWFBcFJ0RGh2VkVLY09ZTnE1YXR1QnlaYUNKci9FamNS?=
 =?utf-8?B?ZzYva0FJNVBPS2xzQkhxV3l4Z0xVbEtyZFZNVGZtM09abnJVUXRqdFZUNlNh?=
 =?utf-8?B?aVk4ZlpIWjJoQy9yYWw2dzJlcGxNRjZ1MlVuai9lYXUxdVByM3JyQ1RnVnFO?=
 =?utf-8?B?MVBqa0FnQzFvQmROTmxxL2REN1NLZDdMMlp5MHRMaWI4ZFMwOWJHSWtzS0l1?=
 =?utf-8?B?TEZvY0JWd1lnK3VCbjZjQjhWcUUvTHB4NVZCeU4yNEpyV29NblhxQ2xSUFZr?=
 =?utf-8?B?akx2V2U5RUc4Ykl1NTlpMzNoSy9BNFVQcjhVU1hXSlU1Z3lLdjhrM1NOR3R4?=
 =?utf-8?B?WWNZRUVxQzBLbVQ1eGwvQWsxYVdtOUVRWUF1aGkxZlUzTXJrWllaKzA3VWVl?=
 =?utf-8?B?MFBQMVdJQUp1ZUhMYjFwSlYxaGRaWHRDKzR5NHBYT1BVeGZKZ3BjT043aGZm?=
 =?utf-8?B?aUZGU043ZnI1Zkh2bHVHMk9wZGxWaXp2ZjlMNXAvTHdCQ0ppMy9TRmFzdDVs?=
 =?utf-8?B?c3RPNEQrN1c0b0Qwb09qTTBXUkZ2UDROb0xZdUxLR2pOYTQ5Njk4NUhIUmEx?=
 =?utf-8?B?SzlQYzdMWExPRzlkZHZUQnovMjRDejJJMVMvMTdFa2xDeGh3M3ZHVEx0YU1X?=
 =?utf-8?B?VXdUWDYvNStVaXd4MGpEbnpwYnhHWjEyS3RKQm1SRitnYWRBbjRweVdRUzNi?=
 =?utf-8?B?eVVMSlN5N1paYUtZYUdxZ1pBVzIzbkFiQ3RnYUM5SWVTMGdrbnVQY0ZXTjBM?=
 =?utf-8?B?eTQyck9HNjRmZjZ3bEJIWlVMVVk2UGZLNGJiK2xCWWFiUGYwb0VYd2FvTVN5?=
 =?utf-8?B?WVpHQXNlN0I2R0Vua0R4VkZYWWxiaEN4NVdyNXNHREpUUUhqRWRHYWR0d1B4?=
 =?utf-8?B?T1lqUDJQVVRIMS9hRkVKYk1qZU4zdDZlMmlBV1EyK0lSWW1yUTV1WmxpVGlq?=
 =?utf-8?B?dzBFd2xpdm8wT2NpajdiOVpucGxSUlhvY3dtYzJBeGJyMFZ4U253UU1DRnFL?=
 =?utf-8?B?REk4MUlDaFVFZmRSdmlkUUVhMmdnY09SMmtvYXh6RWI0eS8vSyt4RGlnU3ZF?=
 =?utf-8?B?c0ZkdU9TWjd4dERDSXdzTnVMLzZEMzhrNUhwZXJsa3YzOTM3NEhaRGE1Y1B3?=
 =?utf-8?B?MnNUNjk0NU5aQk1RSlZvWU5SWmdkNjQzM2FGNmt0eVdkd0wzeXVLY1o3a3o3?=
 =?utf-8?Q?KJrstLZzo5n/nkfksDV32/shTs/OPORGB883QNV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b2b002-534f-486e-641a-08d941134f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 06:49:03.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MpqjsLIwvrMx65vyJhU1pE2m0+ohcs/4qx+elw9ca7AQvnSxx/UxhRQ7pMYSXPoRkDOMUhEJ+gKRSUJpTZ9+4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4490
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksDQo+ID5XaGF0IGV4YWN0bHkgYXJlIHlvdSB0cnlpbmcgdG8gZG8gd2l0aCB0aGUgdXNlciBz
cGFjZSBwcm9ncmFtIHRocm91Z2gNCj4gPnRoZSBtbWMgaW9jdGwgd2l0aCBhbGwgdGhlc2UgY29t
bWFuZHM/IFRoZSBtbWMgaW9jdGwgaW50ZXJmYWNlIGlzIG5vdA0KPiA+ZGVzaWduZWQgdG8gYmUg
dXNlZCBsaWtlIHRoYXQuDQo+ID4NCj4gPkluIHByaW5jaXBsZSwgaXQgbG9va3MgbGlrZSB3ZSBz
aG91bGQgc3VwcG9ydCBhIGNvbXBsZXRlDQo+ID5yZS1pbml0aWFsaXphdGlvbiBvZiB0aGUgY2Fy
ZC4gSSBhbSBzb3JyeSwgYnV0IG5vIHRoYW5rcyEgVGhpcyBkb2Vzbid0DQo+ID53b3JrLCBidXQg
bW9yZSBpbXBvcnRhbnRseSwgdGhpcyBzaG91bGQgYmUgbWFuYWdlZCBzb2xlbHkgYnkgdGhlDQo+
ID5rZXJuZWwsIGluIG15IG9waW5pb24uDQo+IA0KPiBEb2luZyBpbml0aWFsaXphdGlvbiBpdHNl
bGYgdGhyb3VnaCBpb2N0bCBpcyBzaWxseSwgSSBhZ3JlZSwgYW5kIGRvZXMNCj4gbm90IHdvcmsg
b24gb3RoZXIgZW5kcy4gVGhpcyBwYXRjaCBpcyBub3QgYWJvdXQgdGhhdC4gaXQganVzdCBleHBs
aWNpdGx5IGRpc2FibGVzDQo+IGFueSBDTUQxMyBwb2xsaW5nIGZvciBUUkFOIGZvciBzb21lIG9m
IHRob3NlIGNvbW1hbmRzLiB0aGUgYmVoYXZpb3INCj4gZm9yIHN1Y2ggY29tbWFuZHMgdGh1cyBp
cyB0aGUgc2FtZSBhcyB3aXRob3V0IHRoZSBwYXRjaC4NCj4gVGhlIHJlYXNvbiBmb3IgdGhpcyBw
YXRjaCBpcyB0byBub3QgcnVuIGludG8gdGhlIHJhY2UgY29uZGl0aW9uIHRoYXQgYQ0KPiBmb2xs
b3dpbmcgKGlvY3RsKSBjb21tYW5kIHdpbGwgYmUgcmVqZWN0ZWQgYmVjYXVzZSB0aGUgY2FyZCBp
cyBpbiBlLmcuIFBST0cNCj4gc3RhdGUNCj4gb2YgYSBwcmV2aW91cyBpb2N0bCBjb21tYW5kLiBB
cyBzdGF0ZWQgZWFybGllciwgSSBlbmNvdW50ZXJlZCB0aGlzIGEgbG90IHdoZW4NCj4gZG9pbmcg
YSB1bmxvY2sgZm9yY2UgZXJhc2UgLT4gbG9jay9zZXQsIGluIGJvdGggc2NlbmFyaW9zLCBpc3N1
ZWQgYXMgdHdvIHNpbmdsZQ0KPiBpb2N0bCBjb21tYW5kcyBhbmQgYnVuZGxlZCB0b2dldGhlci4N
CkFyZSB5b3UgdXNpbmcgbW1jLXV0aWxzPyANCkNhbiB5b3Ugc2hhcmUgZXhhY3RseSB0aGUgc2Vx
dWVuY2Ugb2YgY29tbWFuZHMgeW91IGFyZSBzZW5kaW5nPw0KDQo+IEJ1dCB0aGlzIHJhY2UgY29u
ZGl0aW9uIGV4aXN0cyBvbiBhbnkgKG5vbi1SMWIvIFJQQk0pIGN1cnJlbnRseS4gQXMgdGhlcmUg
aXMNCj4gbm8gQ01EMTMgcG9sbGluZyBoYXBwZW5pbmcgYWZ0ZXIgdGhlIHJlc3BvbnNlIChvciB3
aGVuZXZlciB0aGUgZHJpdmVyDQo+IG1hcmtzDQo+IHRoZSByZXF1ZXN0IGFzIGRvbmUpLCB0aGUg
Y2FyZCdzIHN0YXR1cyBpcyB0aGVyZWZvcmUgZ2VuZXJhbGx5IHVua25vd24uDQpBZ2FpbiwgY2Fu
IHlvdSBzaGFyZSB0aGUgc2VxdWVuY2Ugb2YgdGhlIGNvbW1hbmRzIHlvdSBhcmUgdXNpbmc/DQoN
ClRoYW5rcywNCkF2cmkNCg0KPiANCj4gU28gaW4gc2hvcnQgSSBkb247dCB3YW50IHRvIGRvIGFu
eXRoaW5nIHRvbyBjcmF6eSBmcm9tIHVzZXJzcGFjZSwgYnV0IHRoZQ0KPiBhbHRlcm5hdGl2ZSBu
b3cgaXMgdG8gZG8gbGlrZSAxMDBtcyBzbGVlcHMgaW4gdGhlIGhvcGUgdGhhdCB0aGUgY2FyZCBp
cw0KPiBhY3R1YWxseSBmaW5pc2hlZCB3aXRoIHRoZSBpc3N1ZWQgY29tbWFuZCAobm90IGp1c3Qg
dGhlIGhvc3QgZHJpdmVyIHNvIHRvDQo+IHNheSkuDQo+IA0KPiBLaW5kIFJlZ2FyZHMsDQo+IENo
cmlzdGlhbg0KPiBIeXBlcnN0b25lIEdtYkggfCBMaW5lLUVpZC1TdHJhc3NlIDMgfCA3ODQ2NyBL
b25zdGFueg0KPiBNYW5hZ2luZyBEaXJlY3RvcnM6IERyLiBKYW4gUGV0ZXIgQmVybnMuDQo+IENv
bW1lcmNpYWwgcmVnaXN0ZXIgb2YgbG9jYWwgY291cnRzOiBGcmVpYnVyZyBIUkIzODE3ODINCg0K
