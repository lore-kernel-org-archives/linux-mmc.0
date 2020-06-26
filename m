Return-Path: <SRS0=oKGY=AH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD32C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 16:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28F12053B
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 16:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lIjxaqlG";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mI0vlXeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFZQA7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:00:59 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:44545 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgFZQA6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2020 12:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593187258; x=1624723258;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=yKujsTbxii9cR/15vMRWEGrW5VAWVJ1MxHh+YbvzrIY=;
  b=lIjxaqlGos8UmQisdin7AAJP/zgYaGvhmNGz5Jvz9yI7NzTU8OI4kAYS
   J1w6DpsBJBd05H8DTIlSJq+eQ6u27tRzpla68trvZNmlcHMvEVnsK3f4b
   0NtTvEpQCxLdW9MXUOTfuu7VUw9SYKP2bHpuq1Ru4UqBWbfEzMs9kDBWf
   5WP+hrChlxqFdghDfA5d6avb/qal8dMW6wxq1A1MwPLG0IYm5V0mb14vl
   vra8eKscXMFqKR4liyZDARvYWGe2rDoDg8ogY3LOK4sgJ+w5lX5nPfJft
   /8tipjce97QZMlk7/qADABPRbQtbl1OLBXQl6LthFJi9i+apMwmLkCFhV
   Q==;
IronPort-SDR: UuWBJnrWMmRKMP9IdpBdcJFBznD++pzSiy0LnNZa0gPeJ6SLiAnIrnembLeO6fWol2RMbzX84E
 EFChKP0JWPJKnkC/rMaVZkHs+8lnNnImOBPe2dBihbcRl2EJixFnpGxSLEi85HhSZuHXxXE+MA
 9ycqs8eWKhRfW8azhjAPke9nfSQqq4An8iifZ/T7kSYExcKBQwA6doQOh/SGALDPwCVN3gSAn2
 ngkjJXrzstF072dAYuFOAlmy9HzempmYbLe+Z5I5Y/jC8wiIXtlzkvO1Zj+7vAcEiQ9nMsUBVT
 0Z0=
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="81020054"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2020 09:00:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Jun 2020 09:00:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 26 Jun 2020 09:00:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI754VQEMRotUFJsFYkb3h0+K0k5RpX7NsJiP85N3dHqT4WmV7LKSfotxPA4zabAQKqFlU9T+q8YOxWtk0EmgykATWse+FeV2zBNKgBp/xf5oXezCqJi9B73LXHl+YWPcYZk7ID0nbN1Ktv1RYhEfPJUK90ZVADtZ+lUur28xe+qHEiAg93LWxISd69/N4WInKOqIrA5c6qvRh9hrwLBrIms7gavTzMMfuEYONcseO7gL1HphbCIZJq8buc5/9G6+/SBHojdUeqrh6opFum+CUhaN64piFvJSwnBk9LVv4LU22Mstk0luuLT/W4jhneHoBANfB3oOQYj49gBtqAioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKujsTbxii9cR/15vMRWEGrW5VAWVJ1MxHh+YbvzrIY=;
 b=Wy2osGyOLbRQ2xy7oIvRo5Sq9xyPbWKDzitZCxm4ut7xeqPsMbo9DLBE9WDzEdzTgr7+DJ6c8HpX5bTiCkV7ZEuiiXcC3MaOR/EOve0U3Qh8QfLEHdgc7fugINobs2h3Aor+UbcT5233D22TXkhPrWFwWxo5uGn00Kmn+wfSccvkekqNJAaR52JoCxPaFjHA1DdiNMxzOgCDij73WrDYRHSU6pUYBTdMAnA2TLLZXz8N5PawSf/i/tqja4shPfdSaRR4Xs/fyLiSTLy/fQj5OoekSWN6OIzrvnNA/YW3MMvFlijkrDllGjBcMzP52UCyXY+f+nWW9esz9/tqg0THtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKujsTbxii9cR/15vMRWEGrW5VAWVJ1MxHh+YbvzrIY=;
 b=mI0vlXeUVnM+sO7qurHxAmg1CP9As4RAE95fEmlvJHmsbcYfKeQ6oMdKPmF/9QxVnerO4EmTSsguBMc75zvxAqlkL59PI1baROUZNTQjArqtGfLOHgQjRcxF6zoUCDKHUul1Jq5/IeY7Yf2Q+EgUUjJkIViq8DYohMF+As9xENQ=
Received: from BYAPR11MB2999.namprd11.prod.outlook.com (2603:10b6:a03:90::17)
 by BY5PR11MB3944.namprd11.prod.outlook.com (2603:10b6:a03:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Fri, 26 Jun
 2020 16:00:56 +0000
Received: from BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::996a:3417:7ea7:2b8f]) by BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::996a:3417:7ea7:2b8f%7]) with mapi id 15.20.3131.020; Fri, 26 Jun 2020
 16:00:56 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>
Subject: Clock selection before switching mode for eMMCs
Thread-Topic: Clock selection before switching mode for eMMCs
Thread-Index: AQHWS9L5oVjpL72UjU6cEwCTLROh2A==
Date:   Fri, 26 Jun 2020 16:00:56 +0000
Message-ID: <7768906b-7916-39be-08e9-0a5d0f6bf69e@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.76.24.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33f80ee4-87bf-4926-0cae-08d819ea1c74
x-ms-traffictypediagnostic: BY5PR11MB3944:
x-microsoft-antispam-prvs: <BY5PR11MB39442A575C669C0BD90D2034E8930@BY5PR11MB3944.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1b6qqAkD/iyEAQPv7oTO99G9vNM6hVmNj145okubSWWoi1PatLvLO6tpE/Mec3xZVtp8cIt18QljUYxoKMyZYVf/vWIcrJ3RJrPN3fHgvH8byvLFpqhYLf2NceccFGvPZP+bdN8Mr2nuwswXEoDwFFXp/nKeffHBdct6+6SdWy4vhOtDunbiXIhgiM4qPvBp/gmg4sJvEIuHwt2OZhwXQSJIovBiRZM+MMJ2uGx8YrYQ4VQDi8AT0xMCe9K+BwubgeIfcDT/rozIofsXw5IKv+25c1HdMqMPHU+mI0Ekvk0IpPcuoZCT2qVvu+wJoQpmD8HaC2ZV5MlNybp3zABbQF6synv3XhcuMFQaADTkI0xAhMU5TkdfEGxRCPXV6levM4dhMterbOYMa25LGOnyzVtjDlZmDjyyInbkAnGytgS/5cIa9QFNos9vyrO4dRVMEkqUZmVG8N6klSdfPgJwDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(39860400002)(376002)(346002)(316002)(110136005)(36756003)(31686004)(86362001)(91956017)(76116006)(5660300002)(66946007)(966005)(8676002)(66476007)(66556008)(64756008)(66446008)(31696002)(2616005)(6506007)(2906002)(478600001)(71200400001)(186003)(6486002)(6512007)(26005)(83380400001)(8936002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: I75MK2n0eYsV388VPXzYiBWWUYBp4mGvi7rRJa+cy1ZdpnhjEc+bzh9bVofWQk2o9FMAADVfleyUxah69F6t3W08FyTog04mKnAsLbwtc6BgX5q2ePMMQAzmR1oc75T4T1F0Sci+LH+1X2r9mcJpCdIgYx+F1dP1PPWwxY5vszetl2Lj3ZNO9A2PF7ul1DQcoQQLBAodfczkQom7O06b8N3di8e5eR7mt3Vh/7WO8jfUujYlIdPlulWHdRK3kQehcPMif5A9+X9K1ZecgEfldzse7f+nGhIPjKKH9RMfxN5NuFjzOXVOzfN6tG+c+gFRrEYOxgEVHUn6P/q0gzXpYt6V7d5/TDgpIVmF4VSTSwhbq+IJ/87nXVugOkEsxGR6wtAi7ypLaO4AhB68Lu4LJfYNbKFuG8WQaJp0zKIkwJwX+QrFVj0UfwKLU9rNYUrIxo6aHOic39T2Qe2XTL0jeDXGFvfBcJzJN7+U4j8JpAM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CCEB47C584E8249A37E698DEEEDEDE5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f80ee4-87bf-4926-0cae-08d819ea1c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 16:00:56.2604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uUoYB7pgFIRl/oI8M/TBMrxsDhwZF5FpFDt/4zgm+2RJ1027F7NTO80gPfbnReUAzu2adjSW57xOV7gZZv11BY0iOaxybEhq8qxSxfFXMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3944
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGVsbG8gVWxmLCBBZHJpYW4sIGFuZCBhbnlvbmUgaW50ZXJlc3RlZCwNCg0KT24gb3VyIEFUOTEg
cHJvZHVjdHMgd2UgaGF2ZSBhbiBTRC9NTUMgYmxvY2sgd2l0aCBhbiBpbmNsdWRlZCBETEwgdGhh
dCANCmRvZXMgbm90IGxvY2sgaWYgdGhlIFNEIGNsb2NrIGlzIG5vdCBjb25maWd1cmVkIGRlcGVu
ZGluZyBvbiBzcGVlZCANCm1vZGVzLCBsaWtlIGhpZ2ggc3BlZWQgcmVxdWlyZXMgMjUgTWh6LCBI
UzIwMCByZXF1aXJlcyAxMDAgTWh6LCBldGMuDQoNCkFsbCB0aGUgc3BlYyBhbmQgdGhlIGNvZGUg
Y29uZmlndXJlcyBldmVyeXRoaW5nIGF0IDQwMCBrSHogYW5kIHRoZW4gDQptb3ZlcyB0byBoaWdo
IHNwZWVkLCBldGMuIGFuZCBpbiB0aGUgZW5kICwgdGhlIGNsb2NrIGlzIHJhaXNlZC4NCldoaWxl
IHRoaXMgaXMgcGVyZmVjdGx5IGZpbmUsIG9uIG91ciBibG9jayB3ZSBuZWVkIHRvIHJhaXNlIHRo
ZSBjbG9jayANCmZpcnN0IGFuZCBjaGFuZ2UgdGhlIHNwZWVkIG1vZGUgYWZ0ZXIuDQoNCk5hbWVs
eSwgaW4gdGhlIGZ1bmN0aW9uIG1tY19zZWxlY3RfdGltaW5nICwgaWYgd2UgY2FsbCBmaXJzdCAN
Cm1tY19zZXRfYnVzX3NwZWVkIHRoZW4gb3VyIERMTCB3aWxsIGxvY2sgY29ycmVjdGx5IHdoZW4g
c2VsZWN0aW5nIHRoZSANCm1vZGUuIElmIHdlIHNlbGVjdCB0aGUgbW9kZSBmaXJzdCwgb3VyIGNs
b2NrIGlzIHN0dWNrLg0KDQpNeSBxdWVzdGlvbiBpcyBhY3R1YWxseSBob3cgKGlmIHBvc3NpYmxl
KSAgd2UgY291bGQgZG8gYSBxdWlyayBpbiB0aGUgDQptbWMgc3VjaCB0aGF0IG91ciBibG9jayB3
aWxsIHdvcmsgY29ycmVjdGx5Lg0KU28gSSB3b3VsZCBuZWVkIGEgbGl0dGxlIGd1aWRhbmNlIGFi
b3V0IHdoZXJlIHRvIHBsYWNlIHN1Y2ggcXVpcmssIGlmIGl0IA0Kd291bGQgYmUgYWNjZXB0ZWQg
b3Igbm90LCBhbmQgd2UgYXJlIGZvcmNlZCB0byBiZSBpbmNvbXBhdGlibGUgd2l0aCB0aGUgDQps
aW51eC1tbWMgc2RoY2kgLg0KDQpJIGhhdmUgc2VlbiBzb21lIHBhdGNoZXMgZm9yIHNvbWV0aGlu
ZyBzaW1pbGFyIGEgZmV3IHllYXJzIGFnbyBbMV0gb24gDQp0aGUgTUwsIGJ1dCB0aGV5IHdlcmUg
bGVmdCBmbG9hdGluZyBpbiB0aGUgZW5kLCBzbyB0aGF0IGlzIHdoeSBJIGFtIA0KYXNraW5nLCB3
aGljaCB3b3VsZCBiZSB0aGUgcHJvcGVyIHdheSB0byBkbyB0aGlzLg0KDQpUaGFua3MgIQ0KRXVn
ZW4NCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvNzEyNzQ0MS8NCg==
