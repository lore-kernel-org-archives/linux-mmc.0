Return-Path: <SRS0=a44q=BH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811E6C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jul 2020 11:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532A120656
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jul 2020 11:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HM2xCILz";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jVJWSS6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgG1LC0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:02:26 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:2097 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgG1LC0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jul 2020 07:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595934144; x=1627470144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RAIuHZMnYsJwBxdMQOs9QQxzFctJKrEZzvlkMR+0+pc=;
  b=HM2xCILznL3OXolNI/hQ+Q0SxORAh8CPnhmRYZCNsaK9RZ17pBLoV6w5
   G6RasRlWp6WtWD5SAZe0ogEp0efE1PpB/wwVTtSLuKJxo8BQ14kYl7OSM
   vfVNowGZU15EzWp52CSALaxR+oG1JZ+I7hxKmShTWJbeCOBCJPmQiBP5/
   4MTN/xldrh9H/x2bdOjNkMgUWn+lPsPywg5NMR1+FRM1b3IPAxpR3sseJ
   DuyDqT7A1fG9olc3gnK8WGjmqcO3I6kJa8SOPnebdCcG1Ykf9AgLWClHC
   AXPzM/hhq6w5awb31fdoEpbxWWgk9zmxmFvcJXaeyjmZneZe/9M2J8CdI
   Q==;
IronPort-SDR: u5bp6vmT06O9g9dKCssxAbmaFM5H76ivKPiQYHe5zuTi2/f9isZxkP3rR5lGEYQXBfUm9r1QHj
 VE2zXRes/kWoxO+2soPOS/BiCO/Bg85ZvCWuDFQiDJFKaX7LHjWMJTFJMBMiYCFtIqDlEi893V
 JZ9JKuorp9dthCSDnRR87CrTQvd1a8lTokv7wUuLGjY8C8zJ9EaJdmdFWhTnOD1KXR0mVs1kxy
 zA8G/0vNoFeBgy6GWjV6nBFzyTkB58EoPtvj6Ah1bIduUkvnHfrhKk4gLwt3B6x/jWaHI4eOT4
 cGE=
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="84853061"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2020 04:02:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 28 Jul 2020 04:02:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 28 Jul 2020 04:02:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VROxO4zkJQ527viR+q7Zdyg3czpvDXemzYlFBfqAKtvCRp/RdNpYI/k/Wrde/epP6iLDoZwEyp7948vLh/OJPugFSJJZOoX9/agZVFO3Afk8kFqzv49T4NuHk4tAwqJlUAeKhy2h2clvxZ97BqGCC1K0jFQPpKZM70epoXl7GQ516G8jufWTDdCCaOptiBoFjMIBO2HfyApCsuvUt/P1bWMX+5TxCPqCrLm9fd6kUlW9mGwZnw25DZWKYTn5uM/vmp9O4EUT9536VBLspK4yw59e5px9ILOmkJW7gg7JNxaLNOaoS6PvqbUvJXwq1IGpS0k/3WIVWl0q/dDvltgc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAIuHZMnYsJwBxdMQOs9QQxzFctJKrEZzvlkMR+0+pc=;
 b=CK6jme9qJHkI+lGiYLj6sHA4E2tRScSgOOaqWQl8Q0/fSwyzUTokkPoVhfquAQcDgTBf/frpWpARWUJZs1m3M0BvQifjLDNQK7zcEm+ZlAXiOXNP7L/WVWB4NwSm533sDUM4fphLvnFMeKewMvSJMOVvy3mgnbVgp4UwJHXWw2dT/JLDaupom5usH+7feTIKceM6v3hrstHQAeE1tnZ8fOprptUgAFm5b1SBlELVLOSM4lL4JPLeoVN+sk+nvbT3VtHjQs+JDcw8cym8aBtwjlvTdN6g+B+AFjHmiauNOxBWe1+ifMXplH0lier7g0i8kNGyKfy9cqXbafi1UCPu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAIuHZMnYsJwBxdMQOs9QQxzFctJKrEZzvlkMR+0+pc=;
 b=jVJWSS6fuNgPBp+FnEDMRHjmDm8W2aKLBtea2cSpan/XDwzb6slPsgYvlKwci4WursHuFy1rsBZ7yCm4D5tic8nz1C5ZS/BgkFbtTnZxAyrNhAswG1QvvHQZuLEcHl9OmY5N3+ZlXCdy36jdyeAKCj7YURLnnpq8ZeRoPVHK5Kc=
Received: from BYAPR11MB2999.namprd11.prod.outlook.com (2603:10b6:a03:90::17)
 by BYAPR11MB2757.namprd11.prod.outlook.com (2603:10b6:a02:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 28 Jul
 2020 11:02:22 +0000
Received: from BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::996a:3417:7ea7:2b8f]) by BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::996a:3417:7ea7:2b8f%7]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 11:02:21 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <ulf.hansson@linaro.org>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: mmc: sdhci-of-at91: handover maintenance to
 Eugen Hristev
Thread-Topic: [PATCH] MAINTAINERS: mmc: sdhci-of-at91: handover maintenance to
 Eugen Hristev
Thread-Index: AQHWVc/M1QIaZcTqdEqPsOa00K5WTakWkT6AgAZgQgA=
Date:   Tue, 28 Jul 2020 11:02:21 +0000
Message-ID: <9528a121-2f14-2cc4-8610-6561f4e1a31c@microchip.com>
References: <20200709085331.8145-1-ludovic.desroches@microchip.com>
 <CAPDyKFq5gCA1f=XVVepi93wotn4uR8JHcRh4JoFt-Preg4ATjg@mail.gmail.com>
In-Reply-To: <CAPDyKFq5gCA1f=XVVepi93wotn4uR8JHcRh4JoFt-Preg4ATjg@mail.gmail.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.121.125.159]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3c9e16d-9cf2-4053-69ec-08d832e5b3e1
x-ms-traffictypediagnostic: BYAPR11MB2757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB27574E501AE633B6376551A5E8730@BYAPR11MB2757.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ykpKK5nQbXpgseejjtfsweyXt+pnHvbpvo4LHh3/fgLA3k6QooXzq+ciPsfvCIp+yzynTpOAPsQF3uT7I6HK9PKp7dOdA7WjTNkGy4N9aqNqMD7aFtBtrvOA3dtkPk1oSXEDJXAP+TIePY5unUl5FAfgeMYoYIRlLQNmn1ct1tH1pmbFluyNptDCH0FveBre0mH726VfHeBojEeFohCW6ibMpkw4v98//bre1+dwAjYuAH1IqVryeMMD3uxDRx1UxuNrpNQwPVdbO+skkL2XuirlBRvciLhG/xZULjgYkLW+LqmThRYut3hzi3wKhH7643N09xxfK8xmWd8B5Hwam769+B0r8IjMTkztutibRyI7yELjtIaRDbVYW0eMect0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(8676002)(2906002)(4744005)(6512007)(71200400001)(66446008)(66946007)(66476007)(66556008)(64756008)(186003)(31696002)(5660300002)(478600001)(4326008)(36756003)(86362001)(91956017)(76116006)(6506007)(53546011)(26005)(83380400001)(6636002)(6486002)(31686004)(316002)(110136005)(2616005)(8936002)(54906003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: J+RlNVQAThbK3gQhC+WP+zQbp73yYt9QS+xaMNDRyQsR4notMwnpeYHdop50Ah2RT/R8zw1dt2PUH1Q9irj7mhqP3WUU1g6XvDksCJZGee7ssK4uLcJxduSsPo4BTvLr8aN5jP1AIZKF08SfnYnpRWbfcQkXXFKji3kr+wjOrEs3jM6hAsqjsGM9AUOmDzHRu+WD1i7cjGdwI+3szcmxur+FaqT0ioiglPfbUrSKfR7weyXPQCXnhtd4GOIdY/KdADCxn+xen1ar7/e9zTgvSpdvwknWzSl8KGFFwMh/qU6L5wGwC6LVueLBg+z8Mn9ek2DPQozEz3X5ZFQWa6/z2vW2TFIQZZU7Y9k2gvFNteqPUUFXSqLfjxCbmH43OAg+T0z/IS98tGi9x5tl2Uhvjft+dPIkdA89KkT8/Ay3DopgA59JvjGhY3e+7zJJ5ddiSJS1TQ4StzObUnYcgvkn+icKXtc1HJMs9uAG5H9HdGia2UzPP0l6+Om0Z7QHwRM7
Content-Type: text/plain; charset="utf-8"
Content-ID: <5507349E33617D4289D26996F5613D49@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c9e16d-9cf2-4053-69ec-08d832e5b3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 11:02:21.8050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZjXLee5+Kba+cxnmpUfFYZBNiM6+70IWc+3kc5MiCPPzVaFsPZyv/yTf9GFKIAr2Vwkr9U9NJw+GfF1x+1HeJnUeVogmoPG64NjT0qnZGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2757
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gMjQuMDcuMjAyMCAxMjo0MCwgVWxmIEhhbnNzb24gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVGh1LCA5IEp1bCAyMDIwIGF0IDExOjAzLCBM
dWRvdmljIERlc3JvY2hlcw0KPiA8bHVkb3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlwLmNvbT4gd3Jv
dGU6DQo+Pg0KPj4gQXMgRXVnZW4gaGFuZGxlcyB0aGUgc29mdHdhcmUgZm9yIGJvb3Rsb2FkZXJz
IGFuZCBuZXcgcHJvZHVjdHMsIGhhbmRvdmVyDQo+PiB0aGUgbWFpbnRlbmFuY2UgdG8gaGltLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IEx1ZG92aWMgRGVzcm9jaGVzIDxsdWRvdmljLmRlc3JvY2hl
c0BtaWNyb2NoaXAuY29tPg0KPiANCj4gSSBhbSBva2F5IHdpdGggdGhpcywgYnV0IGFtIHdhaXRp
bmcgdG8gYXBwbHkgdW50aWwgSSByZWNlaXZlIGFuIGFjayBmcm9tIEV1Z2VuLg0KDQpBY2tlZC1i
eTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQo+IA0KPiBL
aW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPiANCj4+IC0tLQ0KPj4gICBNQUlOVEFJTkVSUyB8IDIgKy0N
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4+IGluZGV4IGM4N2I5
NGU2YjJmNi4uZGFmY2ZhNjI2Yzc2IDEwMDY0NA0KPj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4+ICsr
KyBiL01BSU5UQUlORVJTDQo+PiBAQCAtMTUzNzYsNyArMTUzNzYsNyBAQCBGOiAgICAgIGRyaXZl
cnMvbW1jL2hvc3Qvc2RoY2kqDQo+PiAgIEY6ICAgICBpbmNsdWRlL2xpbnV4L21tYy9zZGhjaSoN
Cj4+DQo+PiAgIFNFQ1VSRSBESUdJVEFMIEhPU1QgQ09OVFJPTExFUiBJTlRFUkZBQ0UgKFNESENJ
KSBNSUNST0NISVAgRFJJVkVSDQo+PiAtTTogICAgIEx1ZG92aWMgRGVzcm9jaGVzIDxsdWRvdmlj
LmRlc3JvY2hlc0BtaWNyb2NoaXAuY29tPg0KPj4gK006ICAgICBFdWdlbiBIcmlzdGV2IDxldWdl
bi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+PiAgIEw6ICAgICBsaW51eC1tbWNAdmdlci5rZXJu
ZWwub3JnDQo+PiAgIFM6ICAgICBTdXBwb3J0ZWQNCj4+ICAgRjogICAgIGRyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktb2YtYXQ5MS5jDQo+PiAtLQ0KPj4gMi4yNC4wDQo+Pg0KDQo=
