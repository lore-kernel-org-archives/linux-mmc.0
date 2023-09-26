Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EB2E7E631
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 13:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjIZNPP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIZNPO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 09:15:14 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C50E4
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695734108; x=1727270108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MGeBy/YCn4zhq7cbaCy/eIgZ8p62rUFdkko7IagG0XM=;
  b=Ny1QqE/MuT1LQL/dYQwaUbP7RhBWayPMlcWBgcXrWB7ZRojp06XZhpjU
   aBmNSFkQW9ar2uNm9i3sy4aL1Oytvz/YMW1LynBO1O/sDdecZCbIOoOjO
   Ti0Mwt7X8M7yB2c5E8gfh2BXtjV6Z/WXGWPzwtfn1t+eG/tADK1Z0LFvZ
   lG5mPhg/uMvu7XWAphDH7Rmoy9Tq7xc57ywL3kuSwatMsjosFvYRMY3An
   s3DyWgfblcmYhrQrCIM7GME2GrqrU3Y+O5UDEqD8XMHoRr45EfHtpR/C1
   +Yp6h8GUvuYfcZDSF9jr/MWQws5n0saEVYRzIkbjQKQvcswGhmP01mVQ2
   A==;
X-CSE-ConnectionGUID: 5CAQlim5TmS1DqpYz1FBlg==
X-CSE-MsgGUID: MAtpemJOTri17QlPrG7jBA==
X-IronPort-AV: E=Sophos;i="6.03,177,1694707200"; 
   d="scan'208";a="244982747"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2023 21:15:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLcH9W/z8wCC7gNl97R0bOSK5N6dPFHgbeW2F2WPojLvUFjXXIh2HreP2/eCrPzGV6JlitAKc8eas3qeMu1nv6pcHS5xs9+1E6OPCLHr7VjcOrJvyHIf+UjBWqUWVYwMSIwCNzRyxzM6SYG4mPWLGyp/Ko7rFpO3trc83BwRf7eS77wlqwxGxQcLQAX4UKWLsCmQexlzy/O93BSFhLQkTReE06xsFAv3Q6XZ+6+Y31sJqHVhqoQM5Kb9p9yyu1Xjw7PTrJSqAL0wi4AI5RxaKDa6RNXj7SiFRGDM49i2sC+AlQwImA4GQl08VvenG52seQrQxjKj3ASfOSm9q6V2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGeBy/YCn4zhq7cbaCy/eIgZ8p62rUFdkko7IagG0XM=;
 b=Qn/XxFY4PXdoI8eoNp2YfsYtJhWnCamFqD+tpJ76nuC+HpebzJ2S3LQhElsyJepQb+P9d9lWQsn6RNXd9hFF2HI37tyicHJ2Aod1U9MOgc9bDhKwzV8Vra1QwlS38E+oRtAabpLaf/pn1DaBdGz5yv/dZ9VOimwBkkfssPsPwzNVZzeu/tOxnq/CxYZDf5k+2+132mPU8Rhop0m/zJPzQkd+knVY+v0o5/5Dc9hAGpufwN7m+vDvHKXk+7vaE1KH3yPbwq4pG26C3SWMlPyH+Y4Y99etKrf9kgznwkH5CesVMyAu7T9zQxUamXi5eYMb8uUPIwUniO8HmWuOTFjA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGeBy/YCn4zhq7cbaCy/eIgZ8p62rUFdkko7IagG0XM=;
 b=OGUY8Q5lLPV9Td6o9PvU6RsfOwVp0EdMWNjUNk22R7LL6HkPpmh5RvNG20B0qc58lESnO+MnBbN1Pcx8a/HSOSsmbYr8aDxPhdP+9gVkN4UYQqtpUfTLC4SE8oHUn79cTOhHghkDJj7crmnCqqEG4kT6+OFhiFWY4DtBZCr8600=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7263.namprd04.prod.outlook.com (2603:10b6:a03:29e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Tue, 26 Sep
 2023 13:15:04 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 13:15:04 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] mmc-utils: fix potential overflow
Thread-Topic: [PATCH v2] mmc-utils: fix potential overflow
Thread-Index: AQHZ8Hr+DtR06PZDkU+GsSkMx0NJtLAtFcdw
Date:   Tue, 26 Sep 2023 13:15:04 +0000
Message-ID: <DM6PR04MB65754B607C982D38804CA3CCFCC3A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230926131128.3771508-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20230926131128.3771508-1-giulio.benetti@benettiengineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7263:EE_
x-ms-office365-filtering-correlation-id: 8265a660-a40d-411c-1615-08dbbe9298e4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDuKZpXmANcAa4Cs86yZKQn76mcSSXdKnZmWL6gPPZVfIfIn1gRlLKA2ex2fi51GTzrc/8cVIhjc3MztO2xHdSszExdP9xciePILNcbRhtfV0bYtBAzXgmXy+hBQLC7D5ne0XdllZkKWHcFKpzGGQjATwohzOhDReggljXVR2HaScJVfQcbSZAxQ2+3dEQ4Cn00Ouxm5V5PmQG1D553T/c/zkTXetBiz0MeN6wloqtMDyM5+T96b95h/Bh8IzLPw7M9XJnOpM0IBpLfYDxiA3ZLXir1/6+yXD99LG0Z6PArVv1KSyRsdkXVc02ScZkTlN8topIGJgNQQU/hcK2c7TA57ba1dYS2VGLCPeUC+j/deicq/2ZK2CpjhYNtWjHgvd+7X6jVE5SycTuDxpl277Ly90FaUGEk6Bb+hklV3EmsaU/UJqQyY5As3QuaLOhvsTNkJw9Rc9+ZnkkbIh7jl2O+DHpnRTNUqxwijXQxv7ssMDFMhlwNnMckYwAmbV8mWZP3YE23YCePp2Fsu1Lud/hsI+oGOs3N01lxX0lsBpxA7q0XM78bjbMUbGdTDGBiEAScXrul1lrwYyBqrxhH7LPyYJ8rjwOkFZZ+saDvj7H2wfeTzEBPz785NLkutV1Ej
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(66476007)(8936002)(5660300002)(41300700001)(4326008)(8676002)(66946007)(66446008)(76116006)(64756008)(66556008)(52536014)(316002)(55016003)(122000001)(82960400001)(6916009)(83380400001)(38070700005)(38100700002)(2906002)(26005)(478600001)(6506007)(71200400001)(86362001)(7696005)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aitlWmVFekw3Wm5iT1dXdS9pYlZZR24zTDYvM3UzeEdBbm5pSmU1UURMTFVt?=
 =?utf-8?B?eXlEbWRmU0JhWFp1M0dMbVpBQ3NlWnNmTDRoNjFmVWdib0dsMW13b1k4cExD?=
 =?utf-8?B?VytiMHM1SFRUcGNXU3BQT3N1TythZE5nUU9KUzE0Z3UrNFlBMDF4MktXSmpS?=
 =?utf-8?B?VWRKNmNsVDVFV1R3V1lxa29rcC9NUVE2UjA1b2tReFZvMWJXMy9jZjVEWDhq?=
 =?utf-8?B?NTFvR1VQdUZWZmYvSUdIMUlOeDRFOFNIdXhUdEFlM2NsOG9IWUMveWw5ZXRy?=
 =?utf-8?B?d3B0bmFGVXdkeUhJdlpIQ3RtcVA4Z3JyY0pLWHYxUGRnTFlEejNDdGNRYzJN?=
 =?utf-8?B?QkxJNDBBaTZydXF0dmwxR0NJcVBZc2c3N3pCY254dFlEYzNqYVdHSmJRenIv?=
 =?utf-8?B?UTBUOXNhZ0V0bjJNWWhkS09yc2pmRS85TDAwek9EVmlmZzZnSmNudk1ScFpw?=
 =?utf-8?B?Z3ZDb21sQzduMG1jbGkxQUliMWR5aUkxclN2UUl6aFNyT2xoZGUxeVpFcFow?=
 =?utf-8?B?QnJaY0xCbHhxb1lLZVlieGVUcEx3WG45L0M2akU5TkszMGtBTWhMdlBzSXI4?=
 =?utf-8?B?cVdhRml5aElEVU42MGFtbjJVS1pTR0l4cnpTaDBZYk1DakRPcE5Ba2FmVnov?=
 =?utf-8?B?d3NzelFEUmhyb1N3STdLbEY2ZEw0SXZwQlhON2w3b0NhZGo1TkhSaHFRTm1R?=
 =?utf-8?B?MWx2cWFkR1BhZzZudzRZekZoYlM5eDVMQ2E1WHpDOVFUMnVTdjM2UDMzb0Vm?=
 =?utf-8?B?NTJ2MGIvQXFqdTM5ckRVVCtmRGY4ayt1ZmxHNmRRUmtna1N0WER0dnJKa3Ny?=
 =?utf-8?B?TjFYVWhKaVhkQTFxd25lcmdnRWhuR0Y1anZQeE0veFpiV3l4R00yWlg4MUtV?=
 =?utf-8?B?a0hVWTkyUCtMMXpyeDVrcXF1VWJzOXRvS1RRUm1WY1B0MnRtcThUbXIxTVEr?=
 =?utf-8?B?NG51c0c0RDFvZG5maXpzVHFGV0pEVSs4ZUZCQnU1VFg3eHJzdEJxT0F3eVNM?=
 =?utf-8?B?djNWV012MU1qSFF5Rk5hd1NtTnZ3TXJlaE5ESW1iUjgwdWwrd3N6VUx2NEcw?=
 =?utf-8?B?QmNTTlpJcXlHTWxwQXdGdndwTXdlNGdFNzgzRTByQVpjVUtlTkFOMkxDeTN0?=
 =?utf-8?B?K2tDRk1EbkZRU3p1RHJjVlh5VkJ5czBxOVVndzIwSDRZemlIL0VOZ1ZYY0Ur?=
 =?utf-8?B?Vi9XL3cwa1RYWTlDZ2IxcnNvZ0dSTGdLSjJnbWdGR0IrSStDYVBDWTZRTllD?=
 =?utf-8?B?KzFmdHg0bVJGd2N3cGlKR3dDV04vVytIZzdYbnBVUndrVW9IN2w1SmF3dDFh?=
 =?utf-8?B?NkFHVFJWcHJwY1c1T3ZKczNBaU1JWDZjbXFlQWNWamlLOTVWb0lCNjQxVG14?=
 =?utf-8?B?UWxZYnZsQkk3dGp4c2xDTDlhMTVKTzB4LzFXTUszNVNseVRha3RnWncrckJ6?=
 =?utf-8?B?ZjdHbTFkVm5EVFdpRjh5QnB0YUI2WTYramowR2x0MlFPRjVPRkwvYnhKc08y?=
 =?utf-8?B?WktGQ3kxb3gyUFZIT21RR3NUcER0UjdEU1F4YXBiWHpCREFwQS9EWk5YZWF5?=
 =?utf-8?B?U3dsbzJxQm5hRGFnYTAyM3o2WFFJVTNlVHlZeXV0T3Q4eVlJejJRMkg1U2lh?=
 =?utf-8?B?RmlkYmxNS2xyM3kzUWEzdDdpNU10N0QxenNMKzIwb1FZVnZZQnEyT0FxVjJH?=
 =?utf-8?B?OHFqMDljV05KbUxPNDR2VTV0elFkaUw5N2NDNFlyWC9qbHl2QUpBeTlybE5n?=
 =?utf-8?B?a3VKNVFDbXdCb0JFS0s2cnJSbGpyVVh1Zy9PekN3TSt4enljK3dtdytscEpF?=
 =?utf-8?B?bFNpcm5GK1gwVGdHM2ZVcmhpTGZMSENCRHprejFOUW51a1YvMk5RSXp3M1N2?=
 =?utf-8?B?MUorMHBUNUkxWWo1TWVYZ2RGeVNBRW1xSUVENFhWWmRYWFN6WW10QkNUZnMv?=
 =?utf-8?B?c0h2YjdsRDRUYTAzS2U3cjZYRXNXSi9qV09mZEJhTk5xRTZwN08xQjZvK2Zj?=
 =?utf-8?B?cXRleHF6SEhSYkNXVy9HZHgvVFhadkpaL1VXd2lObnBtOEZaV2o5MDAwS3lz?=
 =?utf-8?B?Rm41amtRNlZ2SkpaYlBOMDRlOE5uRTZOVU5hWCtqM0R5TGowQ0FiUGhPYStK?=
 =?utf-8?Q?cR/su3Uhbzgb6c3PTbildZ570?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Dz8a6VZSz3u7HezE3PogxQS3gVJhp53Q5MdCVGWwXpCXYarY1WK++YoSc9ReFvVuOyXL2MEa23EaXJJe6aZ4m6eX7pPVj/9Z+P1dULmL3/TD+/vNey8wSGCL7ECQvb9MjATHYsX7KwRUXQTLaJdhd0ZmNBToZgW00SwbV9AbdGw/2QgluX1kJVma/6LvlNBVCrFM0xBYASP30vTD6sC03r36kdHy2LY5CRRYUiaEG37LpZpmT2gLHTE5KnmHCq636gq5KXsXouTaXGPUK3rZiNEliWgJdi2C2lu/xxA16ZFAptBMnNtb1E71Wg0MYwVGd3kiRhfVJucm8jeyZk6Q/P3R7qoFUF2U69PFtFPZYJQukxyPPTXNo7jKuO4/zm2/GShmlj5PZe1p2Eqe7JkHjJVrjJ+igYWMhxhQ0vPYiz/3ac9m/MGhG7KmTi3ts1jARuTVe7TQckQKWaBT7wPsb1TCeeiDlZ7oekBHKC+9xHFyH/fHIdpGHJfdgzG4gx9lXvJW4uznxnzrVTmiJP3aEREWUbq2jZuVhSc2AHVogrxfkuOyiRLXvFVWYb89SQ6zgWov0E9MZ8Ok1RUgePCkBhL6zZQim9SUmjEVJxdoURasg6X/Kdl7sta8nceWhAsgQRiSZQ+ISedlNST/ZGtcJQ+2ZjgNxkv6tpoV7a44ZvDRLy+/batlW/u6GnLdg5aINANcsA5SI9p1Km9CQXlcL6spDPSoMLCSc9ac3Xo9mWmKUMU8Uj88Sfx+GqJSxsVZ3lzqr7XlfpMqzTrG2Miej3pbiNVObTgUhUGIvQzIBuPkI73GNZZM5bTT85+t9JFt7EJOD1doXl4LPWUP6pgb6Q==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8265a660-a40d-411c-1615-08dbbe9298e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 13:15:04.2129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8tyJsjv6BV4/B7MueuiCR4oA59MThLYKLWI+JElwLVlDyVPC7G+NOHsx790RU8PHt2c08q8x0rgyoFpnPbfKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7263
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBCdWlsZGluZyB3aXRoIF9GT1JUSUZZX1NPVVJDRT0zIHJlc3VsdHMgaW46DQo+ICAgICAgICAg
ICAgICAgICAgZnJvbSBtbWNfY21kcy5jOjIwOg0KPiBJbiBmdW5jdGlvbiDigJhyZWFk4oCZLA0K
PiAgICAgaW5saW5lZCBmcm9tIOKAmGRvX3JwbWJfd3JpdGVfa2V54oCZIGF0IG1tY19jbWRzLmM6
MjIzMzo4Og0KPiAvaG9tZS9naXVsaW9iZW5ldHRpL2JyX3JlcHJvZHVjZS9hNTM5MjJjNWRiM2U2
MDVhNWU4MWU1M2MwMzRmNDUwMTdlDQo+IGJiN2RiNy9vdXRwdXQvaG9zdC9taXBzZWwtYnVpbGRy
b290LWxpbnV4LQ0KPiBnbnUvc3lzcm9vdC91c3IvaW5jbHVkZS9iaXRzL3VuaXN0ZC5oOjM4OjEw
OiBlcnJvcjog4oCYX19yZWFkX2FsaWFz4oCZIHdyaXRpbmcNCj4gMjI4IG9yIG1vcmUgYnl0ZXMg
aW50byBhIHJlZ2lvbiBvZiBzaXplIDMyIG92ZXJmbG93cyB0aGUgZGVzdGluYXRpb24gWy0NCj4g
V2Vycm9yPXN0cmluZ29wLW92ZXJmbG93PV0NCj4gICAgMzggfCAgIHJldHVybiBfX2dsaWJjX2Zv
cnRpZnkgKHJlYWQsIF9fbmJ5dGVzLCBzaXplb2YgKGNoYXIpLA0KPiAgICAgICB8ICAgICAgICAg
IF5+fn5+fn5+fn5+fn5+fg0KPiBtbWNfY21kcy5jOiBJbiBmdW5jdGlvbiDigJhkb19ycG1iX3dy
aXRlX2tleeKAmToNCj4gbW1jX2NtZHMuYzoyMDg3OjE5OiBub3RlOiBkZXN0aW5hdGlvbiBvYmpl
Y3Qg4oCYa2V5X21hY+KAmSBvZiBzaXplIDMyDQo+ICAyMDg3IHwgICAgICAgICB1X2ludDhfdCAg
a2V5X21hY1szMl07DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgXn5+fn5+fg0KPiAvaG9t
ZS9naXVsaW9iZW5ldHRpL2JyX3JlcHJvZHVjZS9hNTM5MjJjNWRiM2U2MDVhNWU4MWU1M2MwMzRm
NDUwMTdlDQo+IGJiN2RiNy9vdXRwdXQvaG9zdC9taXBzZWwtYnVpbGRyb290LWxpbnV4LQ0KPiBn
bnUvc3lzcm9vdC91c3IvaW5jbHVkZS9iaXRzL3VuaXN0ZC5oOjI2OjE2OiBub3RlOiBpbiBhIGNh
bGwgdG8gZnVuY3Rpb24NCj4g4oCYX19yZWFkX2FsaWFz4oCZIGRlY2xhcmVkIHdpdGggYXR0cmli
dXRlIOKAmGFjY2VzcyAod3JpdGVfb25seSwgMiwgMynigJkNCj4gICAgMjYgfCBleHRlcm4gc3Np
emVfdCBfX1JFRElSRUNUIChfX3JlYWRfYWxpYXMsIChpbnQgX19mZCwgdm9pZCAqX19idWYsDQo+
ICAgICAgIHwgICAgICAgICAgICAgICAgXn5+fn5+fn5+fg0KPiANCj4gVG8gd29yayBhcm91bmQg
dGhpcyBsZXQncyBjaGVjayBpZiB0aGUgcmV0dXJuIG9mIHJlYWQoKSBpcyBsb3dlciB0aGFuIHRo
ZSBuYnl0ZQ0KPiByZXF1ZXN0ZWQgaW5zdGVhZCBvZiBub3QgZXF1YWwuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBHaXVsaW8gQmVuZXR0aSA8Z2l1bGlvLmJlbmV0dGlAYmVuZXR0aWVuZ2luZWVyaW5n
LmNvbT4NClJldmlld2VkLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCg0K
PiAtLS0NCj4gVjEtPlYyOg0KPiAqIGNvcnJlY3RlZCBjb21taXQgbG9nDQo+IC0tLQ0KPiAgbW1j
X2NtZHMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tY19jbWRzLmMgYi9tbWNfY21kcy5jDQo+IGlu
ZGV4IDEwZDA2M2QuLmFlN2I4NzYgMTAwNjQ0DQo+IC0tLSBhL21tY19jbWRzLmMNCj4gKysrIGIv
bW1jX2NtZHMuYw0KPiBAQCAtMjA2NSw3ICsyMDY1LDcgQEAgaW50IGRvX3Nhbml0aXplKGludCBu
YXJncywgY2hhciAqKmFyZ3YpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlIGlmIChyID4gMCkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCArPSByOyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+IC0gICAgICAgICAgICAgICB9
IHdoaWxlIChyICE9IDAgJiYgKHNpemVfdClyZXQgIT0gbmJ5dGUpOyAgICAgICBcDQo+ICsgICAg
ICAgICAgICAgICB9IHdoaWxlIChyICE9IDAgJiYgKHNpemVfdClyZXQgPCBuYnl0ZSk7ICAgICAg
ICBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiAgICAgICAgICAgICAgICAgcmV0OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgfSkN
Cj4gLS0NCj4gMi4zNC4xDQoNCg==
