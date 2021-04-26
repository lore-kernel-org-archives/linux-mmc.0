Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D2DC433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 12:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586EA60FD9
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 12:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhDZMHM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:07:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:8829 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhDZMHM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2021 08:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619438829; x=1650974829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KU8liGm2BjYIGq1OSYazsaMCNs+V/CgjvT4wioGgVYc=;
  b=b43Zhk32bREaiod08AK/vS9+bIkcfp8sYIpon6n5DxwzNLdcUpO36kia
   8Q8xriSAJoH0JRiPmcu11HT2JjQY87wxkk7b0kdkd0lAJ8evQ4jkd/uXr
   ltlrzPVYtEKi8bxO6ie67/EHPsjDQ2Fmn6DI3iQfANZUXZo1OehvRkwfV
   /zzZ4DP34eDbS8Lw8+w+iChVWE057KEXdNVibM7hvKMjI7PbptuA1ZJmk
   7d6FJlgwsuMZt7+OZlvI65ZwuVzXubeGJp8fV2N3CLDg1bWmc59KX/2VZ
   9ssB8qBp0Uz7OCMlW6Eltw43kgG5trDlPpu/z18iyZ+hfRqX3agAkCrOs
   Q==;
IronPort-SDR: M+lxKbTolg1vBVHk7/uKaKrtI3NtT27BE4sdWtBVzL12skkiiPP4Aa76Pm8xkFKwxUJANI57pT
 ry0Kz3TQE/9w49MY+FW2i/5SIwca4AWxZSo8284891UV506AX65dq0zt/s2ACaBdT8pxz/unQh
 FxGe0RITwSusKugoiPY/BEc40yYjscA0NbdjOFrHjexgoSjIIwj6P3Vi93DB8bt/HwEhZX/Z2P
 yc1gHEDbd/UCFYeufnxhOvyePkgAJhMBjQUp7KAcd+PD1Hg8hY6oZUeqPEo5fyt0RcpYTlql9v
 K4w=
X-IronPort-AV: E=Sophos;i="5.82,252,1613404800"; 
   d="scan'208";a="270183526"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 20:07:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf3iS7XfUWlPun/svSJuWjDzNjbyjqdeHqeVFgKW9QuCj0AqiOlfn53MMjOgvbyp4523iiycZWB6tiPNOSB/juvg6wBFNVq4a56jNez9+HFAMAFQW0UD2+d4AECsGhZ7UEl1V+4KYx/dUv/8IeE8juwGzVvzQvw1YdO5zD4aCl7nfxvebc4+mC76spAFx1GbxySpRyzQGMIGbXdnXJFMQ1YJxeyPjspvgr8Cc2C86ofrz3WRn741WJb0Xy77DNX69Mklkumw7xptF4xPiXG5kBxb0/UNnHOUJ1v9XbZhlamiH4OL5MgIE+nsc5yeUJULV0AByAg6BkWHn0ugQgbLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU8liGm2BjYIGq1OSYazsaMCNs+V/CgjvT4wioGgVYc=;
 b=ESzmfoEXC8g3ZQJMdWA2ZFRK2yH7cxS5khzdESqOmWRjewT8pzqgi61WHDTXMY88X0X+3PSSqVyyZynwaPvDcDG/e9T3kv+fpzfN1uEzFL6pnhQWRbobB6tGNH32emKG+ETmgBylWMtm2sLY3Rxn5BWCcTicgicjCpkHa5IFk6FlxQ3VEum5Buy77aoJ0NWwwUJinsN7CQQ1JU8qLTLCMGrV7iBYidoMLYpq0WqSxvxiA1okjS1bAn85zpuuMZc5tcN1y1C6hP1jIsKDyUOIkom2tIH0R3dXwGBn2oMcXIAYKR4NSoYvD7FvTkOeZcSD/MP5pkekSlf6pRP/9IcSCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU8liGm2BjYIGq1OSYazsaMCNs+V/CgjvT4wioGgVYc=;
 b=HSe36urhD/F6tUSlmuZaV3wVpTE6qxt2skA9V+kaGpecd+YUDEJ9qVGvy7h4aNP6UpNust678z2uB+t4tsEtkeOFlQfPW6pu0+Ceefc28HAxnG5CcpemPwWPgqQIe/etBOtSxFWZT+v9p97OF0lVDItUZCNZubGa9aQVVOtYZgE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4489.namprd04.prod.outlook.com (2603:10b6:5:24::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Mon, 26 Apr 2021 12:06:26 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%5]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 12:06:26 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 0/2] Do not flush cache when it is disabled
Thread-Topic: [PATCH v5 0/2] Do not flush cache when it is disabled
Thread-Index: AQHXOZiUvG1wkimcKUa5QLpTGaEbZarGjjCAgAAnljA=
Date:   Mon, 26 Apr 2021 12:06:26 +0000
Message-ID: <DM6PR04MB6575508EE12B03E0C2CD7814FC429@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210425060207.2591-1-avri.altman@wdc.com>
 <CAPDyKFpZhk-kDpuA1m-E4RXHMXbG72S=OW07XrLzP0-9Q_Gu9g@mail.gmail.com>
In-Reply-To: <CAPDyKFpZhk-kDpuA1m-E4RXHMXbG72S=OW07XrLzP0-9Q_Gu9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [188.64.207.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87265e1e-0530-4239-de12-08d908abb802
x-ms-traffictypediagnostic: DM6PR04MB4489:
x-microsoft-antispam-prvs: <DM6PR04MB4489A44779056F0EBF0F6860FC429@DM6PR04MB4489.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oAiuM8HkNc8LRup/GSEHYT5u6SEGqOuctPmZ7tCWE3xhZlk/Cie/hfBwOOjFlYnly6fuPIJY8yM4chN/Fa1OHmsrj61bfCYUT9hfqQsgnsj906i0t01XE1uUvGDy1kicH6d9Dx+OFTsb4SvyaBS2/hyrb7SKeqU0lNR2sE2+rZ/AtePY73dJWHZFnf9Ty04lllCd6tcRx3E9llVo7jrXa0PPPgwBitG03ScbbMWCd44VRGKDtCkqNZ3di8IRXG4eS1llTwqlQmsEhwEokAf5npsAjGaeDcq8A1wR4t1scSIKLkyLdydDOAxjKbeZ/HV7g5aV8yp/NBfGNQI3CrDY9RvS8gqEXn8jaxERu7hPpj7XV1PxlSC+N86r2eTdavc3giIER84gH+Se0oRFsEs6sb1eBrqPg1ea4ltYmfSmPXGNfUHUJEkJhbClwWIdaPMHgeCkkahevmf32q3qxWZhCKRJcF+ZbvI3gOCqBC4ncOuDb3QxcmFDSnj3Q7iqLBqFk6SANtzNViTfFWnZOx7K1PlBwM3l/IJKk41K5mzzTCFKDTaXY3cymVvv7z5HoG+l5GNaVehrGa6m0MDtkMLUKAJLfYwj6x9L6HINadBW+so=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(76116006)(6916009)(9686003)(8936002)(86362001)(478600001)(6506007)(66946007)(71200400001)(4744005)(4326008)(54906003)(38100700002)(7696005)(2906002)(186003)(122000001)(26005)(33656002)(66476007)(83380400001)(55016002)(52536014)(64756008)(5660300002)(8676002)(66446008)(66556008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z0FzMm5XZ1Nja3pjQmNRbktMMHZzR3JBY1hFeFNSZ1JIeGNTa0ZXNUpQOGhs?=
 =?utf-8?B?UkRyc0dFQkMwdzNtZWJwdndjbWVwSmZLSnJlN01qZCthSUVha3M2RDcvZzJM?=
 =?utf-8?B?eWRGVU1mSFEva1ZMbWg0RXRTa01tNVlTZGk3ODc3MHZNcEVJZ2FtYW9lZzFt?=
 =?utf-8?B?RCt3VFAvSVJpSHJGa0ltQkxmazZqVDdjSjZtZkw0QkdkaVR6U05mV2VNNlJv?=
 =?utf-8?B?cVY2a2JaNnI2SlhBejhxMGJUcmpHeGhSRjB6N3VvUXBFcEV2cGkwMWFEQXRw?=
 =?utf-8?B?K0FLb3c2T2VmeE10VmRkYnJRcXJTeW1FR3FyRmJUYk9wU3lZd1ZlR2lYVmVk?=
 =?utf-8?B?Yml4Wi96NXk4aUdXQStZOXFTMVlMMlZsVm8wQXo3bXpEUXd3bWUzNTU4Ly8x?=
 =?utf-8?B?eVVqNllVTkpOSE5jMzBWSmNUemdmYWR5TUIvbjRORjFYeEdjaGVnK0pvelIy?=
 =?utf-8?B?U2l1bGhuK2lsU1pGZlovVlNmbmlkaVBwak1NQWRHQit6L2NIeWpGd1Y1eDdF?=
 =?utf-8?B?RytrSnBLOGpBNEViUkswK0lrUzg3UHNOeTczeHQ3R3pSMzhVN2RLaFVvZXBL?=
 =?utf-8?B?RWR0S3pTMU1sb1Y5eE5uODYxZ3dkemNxVExmY2YxZi9WcFJsZVRJdmExbGp3?=
 =?utf-8?B?enhyN2V3UFNmbHRuaGo2OC90cEhkT3VWTFh0T2JRMUxWWkNKTzgxbEF2ZzBu?=
 =?utf-8?B?TlV2WHVCM3FvZXZ3UHhscTJLMFZsaWx4VWlRb29vViswZjB5dmRPU2VtT1VL?=
 =?utf-8?B?NElqOVFCNTRZcGhSYjJtR015eVJvQXZuU290SkV3SDQ3VVBPVkV1d2pMM1Z2?=
 =?utf-8?B?WVJjRFovY0l0REUyZi9taENUTEp4WGhqUHExdndaV2YwYytJSEVTQnE4a1U2?=
 =?utf-8?B?aDdqNDFNbXNYK1U5dC9KYmRmc3VWaHJ2V3UrQWFGSnBjMlRJckNacS9IUHdp?=
 =?utf-8?B?MnBhejZyWGZLb0x5Sm80OXhPSzd5eXgxVEFwb05NUTF3NW1CQXVqdFhwMHNv?=
 =?utf-8?B?VitKUEY5Rm9hVzhjblFLUml4R1BxSGxKUTZTd0lTQXhxQzhyR2tXWjlGQldI?=
 =?utf-8?B?K25JNUQyQXh4OUV6eVBzVE5DaVhEQ3NkY2FDMGxwdHhOMzlXenNRQW1tQ29z?=
 =?utf-8?B?ejJCRUZmYkx3V3pOSXl2UCtFNnJrUTBPUzJOeDJaWG1TWU12SWdvSGNTd0RI?=
 =?utf-8?B?WGttU0pmUGJJak1nK2MzZDBWUXJ1dG8yKzNFWDc5WE5jcFlkS3VDYjZseEpm?=
 =?utf-8?B?RzQ3MGFXRDh6WFNoQkFsTFJZMHNic0VYYW9SNllOdXF3U3N1blJSVC9JTzQx?=
 =?utf-8?B?Uk1rL05RU1JzaEdwTnZZRGZ0KzhBZHZYR055NnFhNnhNSVYrTERqYWM3U0dj?=
 =?utf-8?B?cktIY1hmbVZ4TWFSc2ZCdUxvTHVYUkVTNmY0YTVCcjA5VDFRUkhVTHJjOXZY?=
 =?utf-8?B?QnJSVEhOMTc1S0VzZDNqUS9EZEhDT3hNZUlwdHhGQU9LREpPVFVuZFF2OHV6?=
 =?utf-8?B?ajRrZkE1S0pHejY3R0dTTjFmNFZucmhOUVFkRWIwOS85OG52K0g3Zy81TnJW?=
 =?utf-8?B?c3gyakoxTTZ1azY1eFFRc29jZzR4NlFNQ3N3VmdoMm82aWJVMVdIeUhwSTNG?=
 =?utf-8?B?RGxQWmxvYWJ4SHIxOStGOWtVbUpKb1g5WkNJcnpLNk1peG9jbTliWGxlSzRI?=
 =?utf-8?B?S0hEWXE2OXhrNmU3LzRFRU1BWWM5NndBcStjNmdDalpDTE1qT1ZGM1pvRUdv?=
 =?utf-8?Q?8SbmQPIxrbMVvKfXQX5IZ9GTl/IOs3Yk8RO0Lkc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87265e1e-0530-4239-de12-08d908abb802
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 12:06:26.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+XmC+yqhNMnykZT1+r8dQyjRkmY/c65KwN04yqOQ98uth9fRzJzsJ83AvQL5wyKElV8SNyBqpBgfF0vdrF6Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4489
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBOb3JtYWxseSwgSSB3b3VsZCBhcHByZWNpYXRlIHRoaXMgc3BsaXQgb2YgdGhlIHBhdGNoZXMs
IGJ1dCBzaW5jZQ0KPiB0aGVzZSBhcmUgbWF0ZXJpYWwgZm9yIHN0YWJsZSBrZXJuZWxzIEkgZGVj
aWRlZCB0byBzcXVhc2ggdGhlIHBhdGNoZXMuDQo+IA0KPiBJIGFsc28gdG9vayB0aGUgb3Bwb3J0
dW5pdHkgb2YgdXBkYXRpbmcgdGhlIGNvbW1pdCBtZXNzYWdlIGEgYml0IGFuZA0KPiBkaWQgYSBt
aW5vciBjbGVhbnVwIGluIHRoZSBjb2RlLiBQbGVhc2UgaGF2ZSBhIGxvb2sgYXQgbXkgbmV4dCBi
cmFuY2gNCj4gYW5kIHllbGwgYXQgbWUgaWYgdGhlcmUgaXMgc29tZXRoaW5nIHlvdSBkb24ndCBs
aWtlLg0KTG9va3MgZmluZS4gVGhhbmtzIGEgbG90LA0KQXZyaQ0KDQo+IA0KPiBTbywgYXBwbGll
ZCBmb3IgbmV4dCBhbmQgYnkgYWRkaW5nIGEgc3RhYmxlIHRhZywgdGhhbmtzIQ0KPiANCj4gS2lu
ZCByZWdhcmRzDQo+IFVmZmUNCg==
