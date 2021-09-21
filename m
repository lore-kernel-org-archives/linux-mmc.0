Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FC7C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 10:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE50561181
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 10:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhIUKHE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:07:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:46545 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhIUKHB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2021 06:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632218733; x=1663754733;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=MHtIQu5ARkIuxurd1Etbo6+zjrTtcCwrKQl7eXgFkCU=;
  b=PDJ4IpvrCqaPjYibiHv1ynztb3FTJ9nN9fYFa2oi0D0vJewl4iaQyZAb
   qeYSyFphxluNuNkus/5inEpK/Wwm0MMjdaljWF5/pNBkJAIUHEyZOk++l
   COE8dpvFAqhubsAMhOlTG+rsaSqBAcXwij/DII0SyCzUY/IbM7Z8OV1jY
   yd5pD57VRMrkQx0kde29Sud46r6tPRziCkpmtomuEg7lpieUH5YJbDJI3
   roddmYsFXLQVI6r++lrdNQ2kfK1s4HIGq81hbMx8g1oDA9hQ+HC1P7yPL
   940OsAlJhZpbyk/DR9NHkGiW+CnunB94ACmKt/PZ6ON/jPW2fNcbX0WWX
   w==;
IronPort-SDR: n+Mv+AX2wBoujDv0Q+/avb8grPugCG6V0Scl7eySYJUaAQauNvNsNk0WnJDkH5htL6UN9854L4
 qlDePNe9ZxpBDfL9N54/86DieZzJRfgkJc/zeFhxp7NP1YS7BQNT1ie7vFme3kEzzueMnfSsf1
 9FoTMAyeKe6kL4dQRfS3wMda7okwJxDGUIVqbHwhiB5G9XAw/lz+lvyqTE39QWWE+l1KQt5oo8
 NdPtLxUt860FvopWCI548wtZLQU2zKWRqn6g2mR8o5p3vZsJXFREK7Inl7el5Dm2bvZIT0hJhe
 siBcrxdP3VacpB1BOC2PV/hM
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="144954812"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Sep 2021 03:05:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Sep 2021 03:05:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Tue, 21 Sep 2021 03:05:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khdMxG1xbG7rdERdrmFAvHaukK17Jf/QZEYg0mVTizedtOoIcwMmMml5ymuqNg8B7BUwHWryOV13uzs3fA6TN1K/Apo+wOHXWa3Fq5oSNSO0g8TGKhSEJGQSt9BLK+SDWzd/MYDoFBKF/YiTELu+dOr5Fxkt6RzW+UspR4T3knS9JmnBqhm2UBh4rXJptC0UOAnvXxyr1eeUX+vjhWk/SEMGWN5nNDCE1y8lC6hA9IlOH0qfEwT92yyV01DGPHEtfyLMtxLCDkRtqGim/MqrGGzIxS098JCbz5CDCbPvAKMPojBAW4Y7ERDyFItJsHecwwsxdzVkGDOJQSq4ac3HUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MHtIQu5ARkIuxurd1Etbo6+zjrTtcCwrKQl7eXgFkCU=;
 b=kEDCoVe5ovkeDSPBBJhsQeHhraYP+YnHTSIeZ+cNGgl9wVFCKDic6hgb6Y6DlGhWZld3SGi+6PAcEwgs/5NHtUY/klaFdH/EJM2al8zMVZ8O1ieGO1Fr5XF6NepBG23l8yO7YxzMZVJr1736xJcMWFwCO3o8hVCynjATzy0330qPNJoY8YgavBlzA+DhgOaRyDFS4JTAqcjr5EOk1Dp11NH67a1OYqM2jng2Hcaqpsvm4UumepX+ImLut1DPARmoyIxBSLlvLlBTrwD1AXaP8hWmBef3/3IVw1FE43eLPJgELhuAwo2MEGBHRErqESNsbvePwxebU2Eyz1WZ57/ZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHtIQu5ARkIuxurd1Etbo6+zjrTtcCwrKQl7eXgFkCU=;
 b=LzelMsjBSFqG+8PVPnyGkRA5FgHSBjIHqLqzORKkRzMvpoyFeUD5Qt8jq6yV/g12T6FHqmqB2yWMhu6u1ZKryYo+ler22SXhM6qacxH5YWHGgUw6VKBYsmsrRag0bqecxOLV31atx+2tqNZYGoKfc5UemtCr3Eup74hbyDOAEac=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MW3PR11MB4521.namprd11.prod.outlook.com (2603:10b6:303:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 10:05:30 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::c02e:ee5e:8da8:b99e]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::c02e:ee5e:8da8:b99e%7]) with mapi id 15.20.4523.019; Tue, 21 Sep 2021
 10:05:30 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert@linux-m68k.org>, <yamada.masahiro@socionext.com>,
        <piotrs@cadence.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 3/6] riscv: dts: microchip: fix board compatible
Thread-Topic: [PATCH v3 3/6] riscv: dts: microchip: fix board compatible
Thread-Index: AQHXrjGBE+j4P7jIgEKKZtGhx9XcE6uuRAaA
Date:   Tue, 21 Sep 2021 10:05:29 +0000
Message-ID: <6091f8ac-1482-ee5b-b5a4-3917ab8b7fba@microchip.com>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
 <20210920150807.164673-3-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210920150807.164673-3-krzysztof.kozlowski@canonical.com>
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
x-ms-office365-filtering-correlation-id: 21d02ddf-e615-4227-aa4e-08d97ce757bd
x-ms-traffictypediagnostic: MW3PR11MB4521:
x-microsoft-antispam-prvs: <MW3PR11MB4521B29A926A19EB7D81E17F98A19@MW3PR11MB4521.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XurNaMj9RC6nNbe4T5pfp+cbrPesog70VEmhlarrkHkkJYFbUBrGNvqQqy5hG07iPw+JTayygkYPeYFu89X66MkwTr/McFqDknW0TUB/3QXNWL+FIgMjnls2ymskTsFCX4bIZYeTKHj2HCOxgV8WXFl9tYMePPGWuGeUEVptkYVmIsj4Q3tq3XKexdlL5+Lx7jnwii9hA7Z2YTogYy89dPQy6kvEPgvHEzgvsBz39PDlMGQIszabnPcbmCQnmaxSwfylYuZ9Y6boGP3IfVO/k7Sh7OjftT5x/jIfnIw19AObbXGb+J3xGfrRIAIOOYSWLBvFZUdNAYfshKRAUYpNtdbxmVD4q9t6Fui5CUCX9fzNVWcr2mAINcXNLQD3uu06PCRMtRjwYo10VcVCgMyXD7B/VmHtMU4QgPdksnlI/RYXXv5ZFlorOKO/R4Cli1wy/AeYa9wnLi5MHiX4G7p/5W+VKVHlJT4+cYUyadKoCDzPBSQ88TMySceGfAVwuColKeZtuVk0gyJb6EVe4EEAcZRLIuCDUNLDUjgO+usW4ZaGYMUn6lbz0Ku3fj1PhjrCmdBz8dy4t+PsKDU6IvvZI8Mhgy/7o8iHu5N6dRL/91HCfY0YijCgsA2Ef8CmTKudP3Y+i9GY9KaSL+3165tcVvHKQCvKDD55qjBhB1NdASeDk4QKoRZwMJPJcsBlht1p0gHsUDdWPcH+7oYPpu4ble89zer4WaPaPC6DlgaVOnVtC33NrPfO5PQh6sIVq6JOojW3c9lmM80do9/C3rau7zfQKDIufj85kQaZ0AfokNs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66446008)(5660300002)(6486002)(508600001)(38100700002)(122000001)(36756003)(8936002)(31686004)(66946007)(66476007)(2616005)(186003)(921005)(110136005)(38070700005)(86362001)(6512007)(316002)(53546011)(91956017)(71200400001)(76116006)(26005)(83380400001)(7416002)(6506007)(64756008)(2906002)(31696002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEZ5c24rRWYxb2dTdFdMYUU4RnpGL09EUktBOEQvMkpVTGJ3UHBnS2F4ei9W?=
 =?utf-8?B?ajBUUEVFVk1EQ04xKzJWWTVPV3hoalJ2VDJaK2ZTSWpzeFpMbStNZm45OTJn?=
 =?utf-8?B?U0YyWngxL2JZbzNsV29SdzFnNFdlN0VJNTMyVnVka2lCQ2lVMkpjSlF4ZXQx?=
 =?utf-8?B?YXRObXJtNkNrZ0ZpUCszRGZ6bEk3WllORDh6d25NcWxsV0R2ejQ2Sm45YlJi?=
 =?utf-8?B?a2pDRzROd2RHcjNVWUd5VG15T29vN3h1QzJzRjA5TDk1eGRSL0hpYUxXUW9H?=
 =?utf-8?B?Y2hhTHkzQ0Y1YWlpa2RndGhZUGJLMjNPb3hEOWpiN0J5TlN2OUU1ZjlIR01a?=
 =?utf-8?B?NXFhZHkxUVZRcG1FaDE0YTZJZkgrNmU2b1lYdXVvTFJ4UU94akd5QmU3a05m?=
 =?utf-8?B?dUkvdUxnMVQ3Y0d3UzFuRVBjNEtkTDFhUFhKOU1MUGU4OHZXS2JSSVBsc2Z3?=
 =?utf-8?B?cVUrcm5iVDhVU2Z3OS8wTkV4ZjYxQjhVMmZTdnR6aGtWbDZwU1dMcU9pN28z?=
 =?utf-8?B?TFlpMXE5dWhiRkRtSnJEVjk1elArM3ZXb1pabWowTDIrc2pYaHlxMlFTN3NY?=
 =?utf-8?B?b1ZzR0o3bkdFU0s2U3NyU1o0c1B6QVY5VGZSRVJ4eGJEeGpDVzAwOUU4WStZ?=
 =?utf-8?B?M1o1UE1takFZc0JxdnpDM1ZTMGlwa01rNEFJcWdYNURQUkllY0hFKzlXZm5B?=
 =?utf-8?B?N1JsMkszUkZVV2l4VUdLQ1U0Z2dGTXpjODRUeU5SZTlraFZHaXJyUzU5VlpZ?=
 =?utf-8?B?d2JITUlCY3IrMllKcVEreWkvc2R6UGhDWklsSHZwOFpKdytOeE1TalBoODNt?=
 =?utf-8?B?elJKOXhTcEk2RXY0dEY0R2xzRyswTHhpL29hTWQ2WjRZZVgveFB0bVRFdWJq?=
 =?utf-8?B?L1hBRVJaKzE3dnB2dVEweEN4Sy9VNGZUcFlZSitmMVI3eGxzRGt2OVJFZkFy?=
 =?utf-8?B?cEVmS0xrUUlXNVduUFNuZkZmMnlIcVI5U1NmT0xYMGFVNkJqaWRCMERkek9t?=
 =?utf-8?B?em9scG10aVAvNFYvWWZMN3Q2endIcE1DRWVZZWdxbDVqb3lZenVLUjNhWUNP?=
 =?utf-8?B?RFE2eVZzb280SjJ6NUxTYWF5V2U1TlRYWUt2dmllcFVHdjNuUlJDVEV4d2N1?=
 =?utf-8?B?ZVBYUU1Nd2xsZmdKSUwyT05ocC9XS3dIa1ZvTHRLc01yS3lvMnVPR2kvVHVp?=
 =?utf-8?B?Yk12UmMxZDJQMi8zZGNVcnI3aHRJK3NqOHdCUkZwSExDNHh1TTNJeE1tQlJB?=
 =?utf-8?B?MHFiWVc2KzRRaHFWQ0VLY2o5NTFOWU5qZjNXQVFtR2ovaGcwUXYxOVBUZlgz?=
 =?utf-8?B?VDZZVEc4VVBpQ0g5YTNlbndHcjczVjR5ZVhIakViV1l6c05yeEs2M3M0NUN4?=
 =?utf-8?B?RStuTFN6QkhPaFYrcXlCcWpHVW1kZ0hwZGZOcG9MZStPQldyMnJUYTU0eC9Y?=
 =?utf-8?B?VDUxZlV3UU1lcjYzM0lvZXJiMTF1cmU1ZUJNVnloVnhqYUFIUndiQ0RLMjJ5?=
 =?utf-8?B?T1RNVjRLQXBCNXlDNndORnRFR004Unc5UVl1YVJrUzRFUGFKbXhFdnMyUXdm?=
 =?utf-8?B?aHRVamgxK2N3MytCRDRSK0FORTMyUWhHbVgvMkhTTk9xUVdGOFlINGZ1aHpK?=
 =?utf-8?B?cm8rNDZxc1c5QmJaYTJjcStpU296ZnkrbzBQUUFETFRWZnd6eTdRVThmYXFX?=
 =?utf-8?B?ditRcUVwTXdpeURrVkhVNWtvRDFsRE5LVTBERDFhc045TW9idHoyN2IrMUx2?=
 =?utf-8?Q?DnJKR/yohk1BNCkZTU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2B1282FF43CD749B8BF0436BD5AE255@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d02ddf-e615-4227-aa4e-08d97ce757bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 10:05:29.8912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZT++ontP/LXuHneZMUlVrqzSrJDIfHYOF90+WgcVgIvlKt+dIGFum624dtNZhhiI4ZsI6h96WYCw7ZdbQqnhVSa9b0lXxImN/4ErwXRfxto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4521
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gMjAvMDkvMjAyMSAxNjowOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IEFjY29yZGluZyB0byBiaW5kaW5ncywg
dGhlIGNvbXBhdGlibGUgbXVzdCBpbmNsdWRlIG1pY3JvY2hpcCxtcGZzLiAgVGhpcw0KPiBmaXhl
cyBkdGJzX2NoZWNrIHdhcm5pbmc6DQo+DQo+ICAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9j
aGlwL21pY3JvY2hpcC1tcGZzLWljaWNsZS1raXQuZHQueWFtbDogLzogY29tcGF0aWJsZTogWydt
aWNyb2NoaXAsbXBmcy1pY2ljbGUta2l0J10gaXMgdG9vIHNob3J0DQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAY2Fub25pY2FsLmNv
bT4NCj4NCj4gLS0tDQo+DQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IDEuIFVzZSBtaWNyb2NoaXAs
bXBmcyBmb3IgbWljcm9jaGlwLW1wZnMuZHRzaSwgc3VnZ2VzdGVkIGJ5IEdlZXJ0Lg0KPiAtLS0N
Cj4gICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy1pY2ljbGUt
a2l0LmR0cyB8IDIgKy0NCj4gICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2No
aXAtbXBmcy5kdHNpICAgICAgICAgICB8IDIgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yv
Ym9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWljaWNsZS1raXQuZHRzIGIvYXJjaC9y
aXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMtaWNpY2xlLWtpdC5kdHMNCj4g
aW5kZXggM2IwNGVmMTdlOGRhLi4wN2YxZjNjYWI2ODYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWljaWNsZS1raXQuZHRzDQo+ICsr
KyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWljaWNsZS1r
aXQuZHRzDQo+IEBAIC0xMCw3ICsxMCw3IEBADQo+DQo+ICAgLyB7DQo+ICAgICAgICAgIG1vZGVs
ID0gIk1pY3JvY2hpcCBQb2xhckZpcmUtU29DIEljaWNsZSBLaXQiOw0KPiAtICAgICAgIGNvbXBh
dGlibGUgPSAibWljcm9jaGlwLG1wZnMtaWNpY2xlLWtpdCI7DQo+ICsgICAgICAgY29tcGF0aWJs
ZSA9ICJtaWNyb2NoaXAsbXBmcy1pY2ljbGUta2l0IiwgIm1pY3JvY2hpcCxtcGZzIjsNCj4NCj4g
ICAgICAgICAgYWxpYXNlcyB7DQo+ICAgICAgICAgICAgICAgICAgZXRoZXJuZXQwID0gJmVtYWMx
Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlw
LW1wZnMuZHRzaSBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZz
LmR0c2kNCj4gaW5kZXggOTM3MzBhZmU2YzU4Li41MDg0YjkzMTg4ZjAgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kNCj4gKysr
IGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaQ0KPiBA
QCAtNyw3ICs3LDcgQEAgLyB7DQo+ICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiAg
ICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gICAgICAgICAgbW9kZWwgPSAiTWljcm9jaGlw
IE1QRlMgSWNpY2xlIEtpdCI7DQo+IC0gICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbXBm
cy1pY2ljbGUta2l0IjsNCj4gKyAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtcGZzIjsN
Cj4NCj4gICAgICAgICAgY2hvc2VuIHsNCj4gICAgICAgICAgfTsNCj4gLS0NCj4gMi4zMC4yDQo+
DQpSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5PGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0K
DQo=
