Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E79C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 14:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E366115A
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 14:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhIUOQ6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Sep 2021 10:16:58 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30957 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhIUOQ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2021 10:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632233729; x=1663769729;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Be8LRiUWGW2CKHthT6n1MLOydtf6vls27/xGJKNOSFU=;
  b=UmKXGRO0FiusSjoOXclJJ6+SDMhPfCC4paHLUKx3DZvDMP6y2RZcFPAt
   QHFbX0U7lcqMaXNA8DItRv6tKYvl2KjAFeOOmeMa2ELCC6dj80IhntPML
   hgv+ijKYsfcxiLdT88qi0gjFDhTt+PcDBkPNGNyHZFJ9vYJP+Htnzt2p/
   +fH5dSFYkxHjCqlRfjyCPcl180KoRt0ciuHI0HNge/wrrH7dJ+mwf8JjQ
   jtEF1prSLQj68afg9PsR5ph/gzwDWEhBRSPZuUUGzXcFMrTI9AlEDvfAj
   tI/JqQwzNWH6EFricydm9fZ4nmWgxbG8JWbv4i88JN2nfwUSwogtBCOzz
   A==;
IronPort-SDR: aGB5V9gVtQqrDZm4nlwx9hjPNubcQS15viz3u+/hBufQAPxSW1YfqO8X7jD5vF1o0UfLZlXoTT
 8/Q6jg4EIaqlQahFTDidy53lF6zU+7jybUcrr3AwodPIkxZoihYw6HTak2GLk6mwxu/Eq6YuYI
 j5G+v6E3hd6m5nDOGcpfLXBkckBKB61cZrY+RbdW9uMKSrnOA0PtZ8j52GBahehnOxuuhZ/fP/
 dHDXfkpZT6Dm2m7DYM+hEeHo/FJQ4mmEwfMnk7idIi0nVMhBL2oj7qz7bzTqZKDabp9lw+TG7D
 38jJtoOzlrm6wQTKXy6NjcF4
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="137363980"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Sep 2021 07:15:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Sep 2021 07:15:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Tue, 21 Sep 2021 07:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/fIPJktKWS8oLPbVGto2vNTj8lnfXFl4Lu0HYuU9xNGp1krRrrlzuGeT+DGlb+PXO/pUthSUNmhmI36iNl3z5fXmPYr04Ehhw5/g+T/vblH0xyGzOLyTojduhfpUPUUM/fmrHLBiIiAlNuuyBsgnaEh/VjRN9evdKl5GfD0Aky6+xxuULXlcACgvnG02zKQLRidEaMRfldnF2mwa7QjsaDStIngzFCo1TVaW9FhWqOkJ36cRBt9AhV1Sjm3IitpFTQTHh/etYk7mcRjaK47saR40n3tnzqr8JNnyyUmhnpmqLsuAEQ3bglTDrqx/GWBv/DajcLuPql61CVvsYlx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Be8LRiUWGW2CKHthT6n1MLOydtf6vls27/xGJKNOSFU=;
 b=af5haEXsFNFuooM9bDLvbRwz/rvDKpXEV9Ml3+MWTMk0gueDLG7fTmTf7CuIZqRL+6M5l2OR2mqBH+4GZQ3VMELJBjDpCQTa2jIJ6JfD1lokHbeClJ+6ybF+hG16eEZaa/9jqhAULGvEEO2GL6/sEInAegAQWcifeAUDBXoxOw6IXu41edfR76haF1BMcX8Sbmq3tcWfvlyGI7Z7wkm99maiq70fccygF1BGAKZeVBBDhGQrDTNX7kPafGSUMuHEkTfELkmZh0hgxLbcPNJF4BT8rrKbbCeUjeptT5gI2dLpk0V5IazK99JllZp8c9MJwkmWhDRblHB+dl03ufg7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be8LRiUWGW2CKHthT6n1MLOydtf6vls27/xGJKNOSFU=;
 b=gYiGKGX2xYPq8Q8AjupIqHiOYghZf9o6wytZJei8ArPQkkLp229LsUN8jJI97YaAEUs+9rjysjic94qQTjXxtzKVM9BPNlmfTGrYTDKo8EaoqF0RoLFsOzcFC7BQ8PW3VGZICE8W7hXvtnFNSCsQByCA5oSqKCokWq5GCgGDAHs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MWHPR1101MB2078.namprd11.prod.outlook.com (2603:10b6:301:4e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 14:15:23 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::c02e:ee5e:8da8:b99e]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::c02e:ee5e:8da8:b99e%6]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 14:15:23 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert@linux-m68k.org>, <yamada.masahiro@socionext.com>,
        <piotrs@cadence.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 4/6] riscv: dts: microchip: drop duplicated MMC/SDHC
 node
Thread-Topic: [PATCH v3 4/6] riscv: dts: microchip: drop duplicated MMC/SDHC
 node
Thread-Index: AQHXrjGL7H7SjRHDDkuJmN4bIc9/5KuuTdgAgAAVdwCAACaIAA==
Date:   Tue, 21 Sep 2021 14:15:22 +0000
Message-ID: <83f737ee-0332-0303-6fa8-d5595097ce88@microchip.com>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
 <20210920150807.164673-4-krzysztof.kozlowski@canonical.com>
 <b83355ee-cce3-0a7d-a048-147dcb44b012@microchip.com>
 <d79c4aee-2c57-91a8-3bc5-b8d989ed41e1@canonical.com>
In-Reply-To: <d79c4aee-2c57-91a8-3bc5-b8d989ed41e1@canonical.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fdeaa6a-9b7b-4bec-b552-08d97d0a403c
x-ms-traffictypediagnostic: MWHPR1101MB2078:
x-microsoft-antispam-prvs: <MWHPR1101MB20785BE2AB05C987AD1B43DA98A19@MWHPR1101MB2078.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5z6ABMn91xl7wXR/+lIa8QIhAkdxel95ZxyvcUGZ1IcSouIMpiP7JrMks7naL1NbYtcv8gci3LEYp3Wpz3vspx8d5So5HpaWkKxH7EyZpQlSc4ykTm7fdgPYK/cmFQCDaDUQypJJ67L6IzoCjtTAAl2LhJNG339qcOizHEEdFHBoZ+COIzb4DLEda5yK4l9l6RxtT9V1rKzCK0+tPZVqnRppqNSz+fTn400P3w0o02NYEZr/ZfPlix4qNB/USHUkWEe6BC+yZuDF9MXzF/Hr3D3Xrt03N+CoHd3o/qdQyoX0KFQLg47svaKuzlvuKHlD/xUGToKnjpx7n+LZYj/Dyu12AuDkiHe3H14Uc+NoC3aYyVtm8KUTxqeF78O7AUgGs884SIzjkk6kDA49BJs0J/qtj5OJwZ1XXqgdc0b8SBUrh53QXHGQItwNj3fBd3uCUWIATWp4EQwyi+XsSpHIl33LsOD4DDCFPJkx0j9LKfrMVBNVaL+Id/G8FiKGwLv3WeobtWZ0/D3oeT77/DSblM8JxCAoPv4ScdSd91TiF9zhQjC4JGHTGzKwAQzbJCYWXk20l1PKIW3+OR6XmWymfLtFiC9RDKmMpqtG0hlopb6IleHXvgK/QNJ32qCAM8ECf6lch/dMwV3z0WYqAsPhkyISTUQwlMTJG8ItJPE0jvlAeXH1vDG25eQC4Psm2XHvCON/sNtS93ypc8ddJg+qLXDSW98rrXesNEcC3TXxQKytRtpC2RNvhKlycWi+cIldDqm6OUE3ywn/zRVhlZnXR/9SpSDAnIqqJPJ4cjJ6/Uk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(7416002)(83380400001)(64756008)(6486002)(2906002)(8676002)(186003)(76116006)(36756003)(91956017)(66946007)(31696002)(66476007)(508600001)(66556008)(6512007)(71200400001)(921005)(66446008)(316002)(86362001)(5660300002)(53546011)(6506007)(26005)(8936002)(38100700002)(122000001)(38070700005)(31686004)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVgvNVo4YXFnZVB6d1l0aWZKR3pYNTRYakoyV1BmN2U0TmhucTBUbHM2N2hv?=
 =?utf-8?B?U2dhT0ZaZDJZeEVpNjVPSzhRWkMxcERuN2htYlFIUmlqTG1sS1dTRDh3RG9F?=
 =?utf-8?B?K1ZRYk5nQ01SL2IyOVlHcUNwOHBicGZ1ZFozeHJmYmxxaFhJcDlIUHBCMmNY?=
 =?utf-8?B?dkQzcGQra2g2dmpZNUFGRHhzaHJQM2h0bU85bkRFdjB6QXNURlhBMGgrNXNP?=
 =?utf-8?B?RnpTL01UTWRoRWZGZnZveGRNQ3BLdWtCZ2Z1VlFnQ29qN25RNTYweTZSbnZJ?=
 =?utf-8?B?czN5ck5zK1ltOHQ3QVJNN3J6cEJXMTJhdUpSZWpvUXk0TjdoekUzRTY3K0M0?=
 =?utf-8?B?Yzd6S1owMDFvckZjOHQvU2tiN0tKbHBQTjlvVy9PVzFxM25xQ0VGT0RQSUpH?=
 =?utf-8?B?bUVUNmluVGhrN2g5cHRHRWpvYkVnWEZ2QlAwVXJkT1JIWEt0cW8raDZLOFZh?=
 =?utf-8?B?N1hlTTNMNUw0cVpJcWxVZnlMSUhJcWlzeFBTSEpycFRrdm41djdTbFc0RGhJ?=
 =?utf-8?B?MHpMSis5Sm5GOEhNMSt2L1NjS0lUUjBCM3hsTHI4Z0VBQmUzeUZiS3V2dmI2?=
 =?utf-8?B?R1VzS3cxbkdBWjRpdzNvQldSMk9LOUlzMTJEbTl1dVFwV292clowbGVUNGxz?=
 =?utf-8?B?OThNOXd4TEVwQzc2Nko5Vzc2aGk5U2c5ZTRIQXlacGFteTNKbU0yQ0h0V3J5?=
 =?utf-8?B?YTg3ajgrZDE2MWFyZ0ZSY2gvVjY3dm9OTzFDNEdTZ0JUWEFhdFFDQmM4MUQ2?=
 =?utf-8?B?SXlLdW9naXBsOHlLR1hwa0lRbVUxU0YvWndrTi9IV3RJQisrWGpEamI4YU9Q?=
 =?utf-8?B?MGRDMG9aSFZOcldoY080MDlua3V4c3YxUmN5QUUyKzdFcFBQWDdVTjBhNGNa?=
 =?utf-8?B?RmRmUjg1bU1yZXF6Ymw3TkV2SkIxQzZlQVBmbll0cDA0RHRSbElJZGxUOS9M?=
 =?utf-8?B?UFZOc1k5N0pNdXl0ME5iZEVpbi9OS1MvVGVyZHdMQ1hWTWRIT2NtWWpKVGJ0?=
 =?utf-8?B?alR3eW5XdjdRTWsxK25nV29VV1hPV09CQ1BPeDhaQmZ6bnVMWXNSS1VZS0Zl?=
 =?utf-8?B?ZTJmMm9OVnFlMGZhTFZKR0ZFTnFjT3hqVGl2WlBuZG1QNEpodzN1QTRjaHZ3?=
 =?utf-8?B?QnlCdlc5Uk1ITC8zM29MdzljWXlpSlV0ZHVobFdTM2lTbWEvZURYMVFTRDJw?=
 =?utf-8?B?SnRES0c5MUhlbmgrZHB5amtIbUo0b0p1MjZMYyt4OGFoWlFwM3N2NWFLc00w?=
 =?utf-8?B?RVFhKzVLSlFaS3c5ZlJhSnBHZDJRUGRFUHVhc0RFV0tRUThPSXdKaG1oYXZB?=
 =?utf-8?B?QkEvdWhMVGx2ZGczbVR1UFk2WU1HVUdQTEE3Ulp3UlE4ZEM2ZEI1REFGcGx1?=
 =?utf-8?B?MHEzTGtiQUZxeDRtdEJKWmlhREdiTDI0elN3QWlNbnQ1eHRISWFuVDVMd0t6?=
 =?utf-8?B?aGQzbVE1b1BIQ2FtTWdaQ3MyakU1WTdhdHFxa283NFFObGRLY0ZOanNlS0hS?=
 =?utf-8?B?cDBCdG5KMytJdkxQSW02Ym1sUXlzM2V5U0FyQTYvV1hrY1ZsdUNOSW9HdE9V?=
 =?utf-8?B?WkJrV2VqZ0t3b1Y0MkUzVERsbWwrdDhnSVRPWEdWT0tjQ3dvV1NPVVhPc09X?=
 =?utf-8?B?Y3hrdG4xMEpXb3QvWVZnMlovVURSb0IwRVNLVSs1TlIyRHJldHNJaHlMSVlN?=
 =?utf-8?B?ME9RVXRmUFJMREthYjE5ZERHdWlRQ2lHS0RoM0JEaWdwU0RUSjBHdFpJa0dE?=
 =?utf-8?Q?rBCGUYi6G1jc9E0n8gBd/AwuAj0yxTm9bH/SKEE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <89BF20B7511A3244B66826CC39B45A8E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdeaa6a-9b7b-4bec-b552-08d97d0a403c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 14:15:22.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJgYVWSQz4CSfr30370sl0ik9/9C7D8VBB/06FGus8PqsviaJO8dyomvlM8xVyj5BmKV7oM04/2iTyjsfOYDrOaJra3R64JCaRLRaMamWws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2078
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gMjEvMDkvMjAyMSAxMjo1NywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IE9uIDIxLzA5LzIwMjEgMTI6NDAsIENv
bm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMjAvMDkvMjAyMSAxNjowOCwg
S3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUNCj4+Pg0KPj4+IERldmljZXRyZWUgc291cmNlIGlzIGEgZGVzY3JpcHRpb24gb2Yg
aGFyZHdhcmUgYW5kIGhhcmR3YXJlIGhhcyBvbmx5IG9uZQ0KPj4+IGJsb2NrIEAyMDAwODAwMCB3
aGljaCBjYW4gYmUgY29uZmlndXJlZCBlaXRoZXIgYXMgZU1NQyBvciBTREhDLiAgSGF2aW5nDQo+
Pj4gdHdvIG5vZGUgZm9yIGRpZmZlcmVudCBtb2RlcyBpcyBhbiBvYnNjdXJlLCB1bnVzdWFsIGFu
ZCBjb25mdXNpbmcgd2F5IHRvDQo+Pj4gY29uZmlndXJlIGl0LiAgSW5zdGVhZCB0aGUgYm9hcmQg
ZmlsZSBpcyBzdXBwb3NlZCB0byBjdXN0b21pemUgdGhlIGJsb2NrDQo+Pj4gdG8gaXRzIG5lZWRz
LCBlLmcuIHRvIFNESEMgbW9kZS4NCj4+Pg0KPj4+IFRoaXMgZml4ZXMgZHRic19jaGVjayB3YXJu
aW5nOg0KPj4+ICAgICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBm
cy1pY2ljbGUta2l0LmR0LnlhbWw6IHNkaGNAMjAwMDgwMDA6ICRub2RlbmFtZTowOiAnc2RoY0Ay
MDAwODAwMCcgZG9lcyBub3QgbWF0Y2ggJ15tbWMoQC4qKT8kJw0KPj4+DQo+Pj4gU2lnbmVkLW9m
Zi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBjYW5vbmljYWwu
Y29tPg0KPj4+DQo+Pj4gLS0tDQo+Pj4NCj4+PiBDaGFuZ2VzIHNpbmNlIHYxOg0KPj4+IDEuIE1v
dmUgYWxzbyBidXMtd2lkdGgsIHN1Z2dlc3RlZCBieSBHZWVydC4NCj4+PiAtLS0NCj4+PiAgICAu
Li4vbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWljaWNsZS1raXQuZHRzICAgfCAxMSArKysrKysr
LQ0KPj4+ICAgIC4uLi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaSAgICB8
IDI4ICstLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWljaWNsZS1raXQuZHRzIGIvYXJj
aC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMtaWNpY2xlLWtpdC5kdHMN
Cj4+PiBpbmRleCAwN2YxZjNjYWI2ODYuLmZjMWU1ODY5ZGYxYiAxMDA2NDQNCj4+PiAtLS0gYS9h
cmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy1pY2ljbGUta2l0LmR0
cw0KPj4+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZz
LWljaWNsZS1raXQuZHRzDQo+Pj4gQEAgLTUxLDggKzUxLDE3IEBAICZzZXJpYWwzIHsNCj4+PiAg
ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPj4+ICAgIH07DQo+Pj4NCj4+PiAtJnNkY2FyZCB7
DQo+Pj4gKyZtbWMgew0KPj4+ICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+Pj4gKw0KPj4+
ICsgICAgICAgYnVzLXdpZHRoID0gPDQ+Ow0KPj4+ICsgICAgICAgZGlzYWJsZS13cDsNCj4+PiAr
ICAgICAgIGNhcC1zZC1oaWdoc3BlZWQ7DQo+Pj4gKyAgICAgICBjYXJkLWRldGVjdC1kZWxheSA9
IDwyMDA+Ow0KPj4+ICsgICAgICAgc2QtdWhzLXNkcjEyOw0KPj4+ICsgICAgICAgc2QtdWhzLXNk
cjI1Ow0KPj4+ICsgICAgICAgc2QtdWhzLXNkcjUwOw0KPj4+ICsgICAgICAgc2QtdWhzLXNkcjEw
NDsNCj4+PiAgICB9Ow0KPj4+DQo+Pj4gICAgJmVtYWMwIHsNCj4+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaSBiL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kNCj4+PiBpbmRleCA1MDg0
YjkzMTg4ZjAuLjgzYmMxNDg2MDk2MCAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3Qv
ZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5kdHNpDQo+Pj4gKysrIGIvYXJjaC9yaXNjdi9i
b290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaQ0KPj4+IEBAIC0yNjIsMzkgKzI2
MiwxMyBAQCBzZXJpYWwzOiBzZXJpYWxAMjAxMDQwMDAgew0KPj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4+PiAgICAgICAgICAgICAgICAgICB9Ow0K
Pj4+DQo+Pj4gLSAgICAgICAgICAgICAgIGVtbWM6IG1tY0AyMDAwODAwMCB7DQo+Pj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJjZG5zLHNkNGhjIjsNCj4+PiAtICAgICAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4MjAwMDgwMDAgMHgwIDB4MTAwMD47DQo+Pj4g
LSAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmcGxpYz47DQo+Pj4g
LSAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDw4OCA4OT47DQo+Pj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+PiAtICAgICAg
ICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsa2NmZyA2PjsNCj4+PiAtICAgICAgICAgICAg
ICAgICAgICAgICBidXMtd2lkdGggPSA8ND47DQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAg
Y2FwLW1tYy1oaWdoc3BlZWQ7DQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgbW1jLWRkci0z
XzN2Ow0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgIG1heC1mcmVxdWVuY3kgPSA8MjAwMDAw
MDAwPjsNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBub24tcmVtb3ZhYmxlOw0KPj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgIG5vLXNkOw0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAg
IG5vLXNkaW87DQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgdm9sdGFnZS1yYW5nZXMgPSA8
MzMwMCAzMzAwPjsNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPj4+IC0gICAgICAgICAgICAgICB9Ow0KPj4+IC0NCj4+PiAtICAgICAgICAgICAgICAg
c2RjYXJkOiBzZGhjQDIwMDA4MDAwIHsNCj4+PiArICAgICAgICAgICAgICAgbW1jOiBtbWNAMjAw
MDgwMDAgew0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJjZG5z
LHNkNGhjIjsNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHgyMDAw
ODAwMCAweDAgMHgxMDAwPjsNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVw
dC1wYXJlbnQgPSA8JnBsaWM+Ow0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJy
dXB0cyA9IDw4OD47DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICBwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZj
bGtjZmcgNj47DQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgYnVzLXdpZHRoID0gPDQ+Ow0K
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGRpc2FibGUtd3A7DQo+Pj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgY2FwLXNkLWhpZ2hzcGVlZDsNCj4+PiAtICAgICAgICAgICAgICAgICAgICAg
ICBjYXJkLWRldGVjdC1kZWxheSA9IDwyMDA+Ow0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAg
IHNkLXVocy1zZHIxMjsNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBzZC11aHMtc2RyMjU7
DQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgc2QtdWhzLXNkcjUwOw0KPj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgIHNkLXVocy1zZHIxMDQ7DQo+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICBtYXgtZnJlcXVlbmN5ID0gPDIwMDAwMDAwMD47DQo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4+ICAgICAgICAgICAgICAgICAgIH07DQo+
Pj4gLS0NCj4+PiAyLjMwLjINCj4+Pg0KPj4gSGkgS3J6eXN6dG9mLA0KPj4gU2VlbXMgSSBtaXNz
ZWQgbW9zdCBvZiB0aGlzIHNlcmllcyBvdGhlciB0aGFuIHRoZSBuZXcgdmVuZG9yIG5hbWUgaW4g
dGhlIFYxLg0KPiBVbmZvcnR1bmF0ZWx5IHlvdXIgbmFtZSBkb2VzIG5vdCBhcHBlYXIgYXMgbWFp
bnRhaW5lciBmb3IgdGhlc2UgZmlsZXMNCj4gYW5kIGdldF9tYWludGFpbmVycy5wbCBicmluZ3Mg
aXQgb25seSBzb21ldGltZXMgYXMgYSAtLWdpdCBmYWxsYmFjay4NCj4gQWxzbyBmZXcgYWRkcmVz
c2VzIGZyb20gdGhhdCAtLWdpdCBmYWxsYmFjayBhcmUgbm9uIHdvcmtpbmcsIHNvIEkgYW0gbm90
DQo+IGFsd2F5cyBDYy1pbmcgdGhlbS4gU29ycnkgZm9yIHRoYXQsIEknbGwgdHJ5IHRvIENjIHlv
dSBvbiBuZXh0IE1pY3JvY2hpcA0KPiBSSVNDLVYgc3VibWlzc2lvbnMsIGhvd2V2ZXIgeW91IHNo
b3VsZCBwcm9iYWJseSBhZGQgYSBwcm9wZXIgcGxhdGZvcm0NCj4gbWFpbnRhaW5lciBlbnRyeSAo
c2ltaWxhcmx5IHRvIEFSTS9BUk02NCBzdWJhcmNoaXRlY3R1cmVzKS4NClllYWgsIEkganVzdCB1
c3VhbGx5IHJlYWQgZXZlcnkgbWVzc2FnZSBhbmQgaGFwcGVuZWQgdG8gbWlzcyBwYXJ0IG9mIHRo
ZSANCnNlcmllcy4NClNlZW1zIGxpa2Ugbm9uZSBvZiBteSBjb3dvcmtlcnMgYXJlIGxpc3RlZCBh
Z2FpbnN0IHRoZSBkZXZpY2UgdHJlZSBzbyANCkknbGwgZ2V0IHNvbWVvbmUgYWRkZWQuDQo+PiBX
ZSBoYXZlIGJlZW4gcmVkb2luZyB0aGUgZGV2aWNlIHRyZWUgZm9yIHRoZSBtcGZzL2ljaWNsZSBr
aXQgcGFydGx5IGR5ZQ0KPj4gdG8gc29tZSBjaGFuZ2VzIHdlIG1hZGUgdG8gdGhlIGRlc2lnbi4g
UHJldmlvdXNseSBTRCBhbmQgZU1NQyB3ZXJlDQo+PiBkaWZmZXJlbnQgRlBHQSBkZXNpZ25zIGJ1
dCBub3cgYm90aCBhcmUgaW4gdGhlIHNhbWUgZGVzaWduIGFuZCBtYW5hZ2VkDQo+PiBieSB0aGUg
Ym9vdGxvYWRlciwgZGVwZW5kaW5nIG9uIHdoZXJlIGl0IGZpbmRzIHRoZSBpbWFnZSB0byBib290
IGZyb20uDQo+PiBTaW5jZSB0aGVuIHdlJ3ZlIGp1c3QgYmVlbiB1c2luZyB0aGUgZm9sbG93aW5n
IHNpbmdsZSBlbnRyeSBpbiB0aGUgLmR0c2k6DQo+Pg0KPj4gICAgICAgICAgIG1tYzogbW1jQDIw
MDA4MDAwIHsgLyogQ29tbW9uIG5vZGUgZW50cnkgZm9yIGVtbWMvc2QgKi8NCj4+ICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJjZG5zLHNkNGhjIjsNCj4+ICAgICAgICAgICAgICAgcmVnID0g
PDB4MCAweDIwMDA4MDAwIDB4MCAweDEwMDA+Ow0KPj4gICAgICAgICAgICAgICBjbG9ja3MgPSA8
JmNsa2NmZyBDTEtfTU1DPjsNCj4+ICAgICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwm
cGxpYz47DQo+PiAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8UExJQ19JTlRfTU1DX01BSU4g
UExJQ19JTlRfTU1DX1dBS0VVUD47DQo+IEknbGwgc3dpdGNoIHRvIDIgaW50ZXJydXB0cy4NCj4N
Cj4+ICAgICAgICAgICAgICAgYnVzLXdpZHRoID0gPDQ+Ow0KPj4gICAgICAgICAgICAgICBjYXAt
bW1jLWhpZ2hzcGVlZDsNCj4+ICAgICAgICAgICAgICAgY2FwLXNkLWhpZ2hzcGVlZDsNCj4+ICAg
ICAgICAgICAgICAgbm8tMS04LXY7DQo+PiAgICAgICAgICAgICAgIGRpc2FibGUtd3A7DQo+PiAg
ICAgICAgICAgICAgIG1heC1mcmVxdWVuY3kgPSA8MjAwMDAwMDAwPjsNCj4+ICAgICAgICAgICAg
ICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gSSB1bmRlcnN0YW5kIHlvdSBwcmVmZXIgdGhlbiB0
aGUgbW1jIG5vZGUgdG8gYmUgYWN0aXZlPyBCZWZvcmUgdGhlIERUDQo+IGhhZCBTREhDIG9uZSBl
bmFibGUsIHNvIG15IHBhdGNoIGRpZCBub3QgaW50cm9kdWNlIGNoYW5nZXMgKGV4Y2VwdA0KPiBt
ZW50aW9uZWQgaW50ZXJydXB0KS4NCj4NCj4gSSBjYW4gY2hhbmdlIGl0IHRvIG1tYyBhYm92ZSB3
aXRoIHlvdXIgZXhwbGFuYXRpb24uDQpJdCdzIG5hbWVkIG1tYyBidXQgaXQgd29ya3MgZm9yIGJv
dGggU0QgY2FyZCBhbmQgZU1NQywganVzdCBkZXBlbmRzIG9uIA0Kd2hhdHMgc2VsZWN0ZWQgZHVy
aW5nIGJvb3QuIEknbSBub3Qgc3VyZSB3aGF0IGlzIHRoZSBhcHByb3ByaWF0ZSB0aGluZyANCnRv
IGFjdHVhbGx5IG5hbWUgdGhlIG5vZGUgaW4gdGhpcyBjYXNlLCBtYXliZSB5b3Uga25vdyBiZXR0
ZXIgdGhhbiBJIGRvPw0KID4gcGF0Y2ggZGlkIG5vdCBpbnRyb2R1Y2UgY2hhbmdlcw0KWWVhaCwg
SSBqdXN0IGZpZ3VyZWQgdGhhdCBpZiBjaGFuZ2VzIGFyZSBiZWluZyBtYWRlIHRoZW4gaXRzIHdv
cnRoIA0Kc3dpdGNoaW5nIHRvIHRoZSBzaW5nbGUgZW50cnkgbm93IHJhdGhlciB0aGFuIHdhaXRp
bmcgYW5kIGRvaW5nIGl0IGluIGEgDQpmZXcgd2Vla3MgdGltZS4NCj4NCj4NCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg0KDQo=
