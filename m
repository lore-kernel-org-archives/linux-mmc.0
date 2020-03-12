Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067D9C1975A
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491332071B
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ZeUfR5IU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgCLOz3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:55:29 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:56969 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgCLOz2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 10:55:28 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: /2LqKV2qybmAZOLZXIfMpa5QVhKA4AWQidxoERMzT6mzWPlt8DhF9kZIFMqgPwUW7aWnK430bu
 Geu0Oi368wPwPg0i1X/VHWAbI+j6nXHLmuQA/2yxGJRUt3xnBvc5TJEbcWplFYScLzWgDo7u42
 Wgzop+MvKg2OGgUw8GOLhQmErX1FiwhZEo7RVMfkzL8MuTyr3b56SK+1A+J0qQOJeV/jwb8WWJ
 6jsa3wy6XYLtTHUBBrE6Okvn++xWxmBlnBU5Hq68cGFUaqgJwpz2+RJF0EbMKc6Lk1122vWaor
 sh8=
X-IronPort-AV: E=Sophos;i="5.70,545,1574146800"; 
   d="scan'208";a="68632617"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Mar 2020 07:55:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Mar 2020 07:55:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Mar 2020 07:55:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHB9W0m1Do8Bxz7kOp7FVI9xzltpEVZDrPEtEYSo1g9EW3UFA9Uorftxj4itHcwm0l76OoKjvUtqlAxkdryl7sDnol38nzQ7ySvxVBkNKKwgU1UMohpDqpkN+vpaFHaxr76eWgEaL0ubIKpFkhVNybSdYatahOfQfiweRLXMIXco0YdC6OcBqIBZXvVWgcmtqjzTGKjng3gIO1fSCjH58DYNqN0kTYyG47Ge9L1jH+ffe6JXa4A+CAWnizht958NNXMzp7gUi+8gZuuea5O10zcXS93bTtzBkAotrOT2GMfugitUorpc1tDryz6pn6i97ctiVQjKaVd7CqJ1U3qXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+TobI91BvPcgD1zQGyl/Gwy9oZPqN9/Dah756QRSWo=;
 b=EqB5umjmHxBnsnX+ICmGQbGqdlKHOCnjs/HzfFkwtQBFrpooHZEJki5s9v6m+FoOLVXOp9ZJRYABWcbB2TKfUwxgzb6B8u5rpf8KwK5rglEx4qUOxZQe7ZFINP3LmIRTsFzt7dDNfN5a93zdwafTQYQawP34Yw4zezQle9wH9gYxSzwp93svU77Ocg/D8KghVv3YuPKsiixnt/QYhoVjcbOgBANF7lxC9DHhxkqqZRFah+IdrJIxXM9tkAto2NmxRy66zFqAgTSjGuXgYBwOUL5Q+BTOBAFxUbg+eBL2OJgPqdy/AGJXl4TqYpLNhe/1FbKSFoakrYHsqye+uq4NXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+TobI91BvPcgD1zQGyl/Gwy9oZPqN9/Dah756QRSWo=;
 b=ZeUfR5IUljyCC61KREJe4DiYvvBexfbJx2kqTRX3VKkxjoiHI+0LSppXTIGB1yUSerROTuRWNeIWUS7HmJmjdnPEXk+LET5GB4aDDJJPuNhS8LZeNojQJuu5gwvBKNhSSISiYv0BSVgWcn3fXZYaaFcrAqQdRafjs4mIGTHaECM=
Received: from BY5PR11MB3895.namprd11.prod.outlook.com (2603:10b6:a03:18e::21)
 by BY5PR11MB4193.namprd11.prod.outlook.com (2603:10b6:a03:1c8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 14:55:15 +0000
Received: from BY5PR11MB3895.namprd11.prod.outlook.com
 ([fe80::c09b:2e03:b941:13c5]) by BY5PR11MB3895.namprd11.prod.outlook.com
 ([fe80::c09b:2e03:b941:13c5%5]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 14:55:15 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <Tudor.Ambarus@microchip.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: Display clock changes for debug
 purpose only
Thread-Topic: [PATCH] mmc: sdhci-of-at91: Display clock changes for debug
 purpose only
Thread-Index: AQHV+HqhVonJfj9ooEG0j49qskyYOKhFC4MA
Date:   Thu, 12 Mar 2020 14:55:15 +0000
Message-ID: <6291bd95-3d11-4b19-4346-9e1f06918993@microchip.com>
References: <20200312142904.232822-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200312142904.232822-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33707f5e-78bb-450c-7771-08d7c6955fce
x-ms-traffictypediagnostic: BY5PR11MB4193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4193DC2D36B47C8AC2182FB4EFFD0@BY5PR11MB4193.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(66446008)(8936002)(110136005)(54906003)(76116006)(316002)(66476007)(5660300002)(81156014)(91956017)(31696002)(81166006)(64756008)(2906002)(66556008)(66946007)(8676002)(53546011)(6506007)(478600001)(31686004)(4326008)(86362001)(107886003)(71200400001)(36756003)(6512007)(6486002)(2616005)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4193;H:BY5PR11MB3895.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0MG9TA6T9jwhJXpGdsuPOBqlilo0tbXoeMmLOVLbCk05jAu0pA79AkSNvy8bUQh7ZgPC56VHS5AEnoj8cZ9n2YTrvDDUi5yVE2pmH+h+4CEVcFejGEAhGzo+rU5gZcigl/dxa1z+ckziWla74J6fs8ssNFqfBknXA4zdOhr2HzYH3BSmbauslwUm5LUBZjwqBfRtsCZG4vYtthihk4liN/eXiL2sivNluGM21DwhFGr7UsyTM5lf9YeCRE+f/e8p6NOUG4YUp+6H/kOKNwN1crnGnE2QJ+tUv1BYW4W5SESfbSB+aK3FvXRch/4WwKMM5sgHvWlM3HxiDhl7KHjuiaKGwvA+VA5yIs3EaWKGJexpdZIO/ejTECMlS9kFZNG3Sw/eBNJi1+UgTW7wuoU2XqWqG7zUwG9BWVdrX5IU3nFJdPlhrRxi3hP2+pHFbyeY
x-ms-exchange-antispam-messagedata: 2PTHya+ZKnc9Wg3XL/6Hi1YDuVWDeKQnpCBhLDQGPsOPgDR17x/ZB1MuUCOho4BI9sF7OwS9no5F8m+99INXchlad2hbwdfp5W7N/HJzEbyZrx013DcpTih+Anml1Xk+XM9glg/rMxzL0CF4XodPkA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <711D53F63E292640B160FC04CBDF5811@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 33707f5e-78bb-450c-7771-08d7c6955fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 14:55:15.4948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tA3KDyl+j1PNmCiIc3zDT5T+ipmdF6xLySgGbR6orFcNJiHg8/s6BXPSGcw9NbDM+p7YpAgsdGSDhnBunpUwJWUaOayf3jt67abt2CvzeAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4193
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gMy8xMi8yMDIwIDM6MjkgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6DQo+IEZy
b206IENyaXN0aWFuIEJpcnNhbiA8Y3Jpc3RpYW4uYmlyc2FuQG1pY3JvY2hpcC5jb20+DQo+DQo+
IFRoZSBzZGhjaV9hdDkxX3NldF9jbGtzX3ByZXNldHMoKSBmdW5jdGlvbiBpcyBjYWxsZWQgbXVs
dGlwbGUgdGltZXMNCj4gYXQgcnVudGltZSBhbmQgdGhlIG1lc3NhZ2VzIGFyZSBzaG93biBvbiB0
aGUgY29uc29sZS4gRGlzcGxheSBjbGsgbXVsLA0KPiBnY2sgcmF0ZSBhbmQgY2xrIGJhc2UgZm9y
IGRlYnVnIHBvcnBvc2Ugb25seS4NCg0Kcy9wb3Jwb3NlL3B1cnBvc2UNCg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBDcmlzdGlhbiBCaXJzYW4gPGNyaXN0aWFuLmJpcnNhbkBtaWNyb2NoaXAuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5j
b20+DQoNCkFja2VkLWJ5OiBMdWRvdmljIERlc3JvY2hlcyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWlj
cm9jaGlwLmNvbT4NCg0KVGhhbmtzDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1vZi1hdDkxLmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1vZi1hdDkxLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWF0OTEuYw0KPiBpbmRleCBh
YjJiZDMxNGEzOTAuLjg4ZjE3YWJiNjlhNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1vZi1hdDkxLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hdDkx
LmMNCj4gQEAgLTIwNCw4ICsyMDQsOCBAQCBzdGF0aWMgaW50IHNkaGNpX2F0OTFfc2V0X2Nsa3Nf
cHJlc2V0cyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgCS8qIFNldCBjYXBhYmlsaXRpZXMgaW4g
cm8gbW9kZS4gKi8NCj4gICAJd3JpdGVsKDAsIGhvc3QtPmlvYWRkciArIFNETU1DX0NBQ1IpOw0K
PiAgIA0KPiAtCWRldl9pbmZvKGRldiwgInVwZGF0ZSBjbGsgbXVsIHRvICV1IGFzIGdjayByYXRl
IGlzICV1IEh6IGFuZCBjbGsgYmFzZSBpcyAldSBIelxuIiwNCj4gLQkJIGNsa19tdWwsIGdja19y
YXRlLCBjbGtfYmFzZV9yYXRlKTsNCj4gKwlkZXZfZGJnKGRldiwgInVwZGF0ZSBjbGsgbXVsIHRv
ICV1IGFzIGdjayByYXRlIGlzICV1IEh6IGFuZCBjbGsgYmFzZSBpcyAldSBIelxuIiwNCj4gKwkJ
Y2xrX211bCwgZ2NrX3JhdGUsIGNsa19iYXNlX3JhdGUpOw0KPiAgIA0KPiAgIAkvKg0KPiAgIAkg
KiBXZSBoYXZlIHRvIHNldCBwcmVzZXQgdmFsdWVzIGJlY2F1c2UgaXQgZGVwZW5kcyBvbiB0aGUg
Y2xrX211bA0KDQoNCg==
