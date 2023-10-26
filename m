Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23652C25B48
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Oct 2023 10:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjJZKHE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Oct 2023 06:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZKHD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Oct 2023 06:07:03 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099E9195
        for <linux-mmc@vger.kernel.org>; Thu, 26 Oct 2023 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698314821; x=1729850821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qAe7pJ7Dy503fvSd5HaDJsXPc+hiZzhcidQA2/tn6C4=;
  b=NNinc021Zsg/M+sGio16zs5VHSh1J/NqWn/3ixgcVnfGDKLOVYkaQ+gi
   LJ+063Fny2N6m/734aTUxRTa9k0jQ95/Q7zYxhqPXp8adSIenIweHGAQt
   8CRUglrSgdKH4TaWMMr7VKA/xqfQHotyinOF/UN1isq6K6L5p2KDNbjyD
   El10k5PWf3ZMR1R74oSrmIqCHBz/PyhzpckyMP23eZxnVeLp86PVt6PSe
   1HTJsW+ZwQZ92soxQWjVqhqBhDj7duRuRRf21MPQ1A09s3kQCboUvJosQ
   gWBfEzgxxNpm4KAQEfUcrS64tiX82DknxWrfaCVcx6yD/RlAYyc/nCkHi
   g==;
X-CSE-ConnectionGUID: XW2CxndZSASKysVB+NjJLA==
X-CSE-MsgGUID: EKxBLEtIQI6L00YFrsjYfQ==
X-IronPort-AV: E=Sophos;i="6.03,253,1694707200"; 
   d="scan'208";a="681933"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2023 18:06:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8RbTzO1dMDhz7aMVloL9fJ4YE3Hc33tMPDIxpppc4scXrEuynuLtu4WqYi1TrHPUWGmuA8hSNY9SC8bYAY+1KiW6ryFhDwA6quVU7/n0siwZ3n6uVTWi5F5PgOTky/nriS5RJ82jnG45T0u4Yh3hneV2RewVs1+aC/CaE34qAfSHP375NAEp8TGdROmJ/GFWPfOrYxA5Kydlc6jKyM86HuR0alcyTmNXmNl7DFfdrCL0pKRAgKbFfM/UxchvzYSMtaUr7W8ywzJtSGqYL5fGT6iM+ehXCbRcO/lBswiOkxMNxGf3c26Yk41ST6Ub2bcDfEepirkNHwRdSathkgtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAe7pJ7Dy503fvSd5HaDJsXPc+hiZzhcidQA2/tn6C4=;
 b=EJtYyyyrhPVRu4H/+/WJ2H+/sj0AHcK0h1Q+yCHCsqa0FOrS/VNIFdmFZ68UM0/tW7RVTd+HPh7tgw/dfPiRJLCLrm3oz9B00abCiMYrQbza0wcd09mC7//MatKUBwzHZka9Dj9xH9oYF96Zd0wp61mE7GsjN0uIgoUAk4sc0CWw7ooCQM+R04M7WkkIOLtSwVKwTKMREfA34QDTswD2rNqe4Z4AkgrNENHEcRJbQha5v50aOqQWaHIvFRZ9SUa2hx615HZlmCYDGLZULEcxm9MgWkrLmME4HFa/QD39VOA7YgoxAixDNFP98eWXQNWHu1QZLrqu1ZkE2jcVNE+tmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAe7pJ7Dy503fvSd5HaDJsXPc+hiZzhcidQA2/tn6C4=;
 b=JOEizpmmiPer2+hpKhi+Uoxno/yenkQ6J9AhlqzkF0AammmzqY3wnRY+mhrB9Qj61p3GxtcmaHVBc2rp0MxuXker25KiG7ikygQ0nbG4wVZTyjwZV4JNhWCv8WEVDSMNiZKBi6HrOQA3Nahap9InytAZn+aQR1WvFEzaoG+pNj4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB7949.namprd04.prod.outlook.com (2603:10b6:408:154::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 10:06:55 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 10:06:55 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Subject: RE: [PATCH v3 0/2] mmc: host: Disable auto-cmd12 during ffu
Thread-Topic: [PATCH v3 0/2] mmc: host: Disable auto-cmd12 during ffu
Thread-Index: AQHaBzbqNmSV3psEX0OZ5ivOaOYF7bBbwSuAgAAUEiA=
Date:   Thu, 26 Oct 2023 10:06:55 +0000
Message-ID: <DM6PR04MB6575743E1EBDC899206E9A9AFCDDA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231025113035.1881418-1-avri.altman@wdc.com>
 <afdada50-cdcb-4edb-a026-c872e1914e43@intel.com>
In-Reply-To: <afdada50-cdcb-4edb-a026-c872e1914e43@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB7949:EE_
x-ms-office365-filtering-correlation-id: 16e52c60-1300-4af8-4a1e-08dbd60b4893
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: npDaypQUFp+L6pTCRFFDCf9J/llvI1CWOOmp/3o+FsLpFGzZJKhMCUN/BDe7WHs/COPVmYk/jWbJdRcUe2B+DouV3fb6rtPz0KrjqSMKi67+j19kmBrT/mcUeOD4Ce7CuyvwBUJj59ZAVK4Qa7H8F8N4iDU+4u+67DdvG5mrnnrUffbHAqFSa5Cf8kEyNSpTym8jUqif6SAnR3DlKoWkPrD1i/b80Uo9J8Kbpdjv5X5/gG0Y/HbSx8Ygn/ON5XMfTgefUgtBXpvp2t6/c77bHpIaM/Ks1F7dsJgblSplvhQJBhTKwkeXRleTi8T4vnxFLoooIvx9MhoJm2JQJgUns5AATelDGM/0NzYYDUbXkJjnUqMErwH+0JfNy7LQ36qw2CRKn7ZLFKQBicmmQVcch5Q5eECBqC4b/dxAuBMUByXnKXIWniAh8ArdHMmY8q5V3n0AczqmJoNQdzHtxprCwXmD6Sgy2MaAp4yeaW4HgghLUDAUveHulUezkHn8BCct7/eJQBBYNkCm1I+vWKbhYDpj8OSm22vew+3bUH6aCv+SBJN9W6Q9Nkv4UQW4j2lJJU3IWmBVa8UPKJ6UhgxP6NzP+HksFUwnhQ+xvChfQgYDQWxlpCNyoSPBgWBwLIgL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38070700009)(55016003)(6506007)(9686003)(71200400001)(53546011)(478600001)(7696005)(33656002)(86362001)(122000001)(82960400001)(38100700002)(2906002)(54906003)(64756008)(66946007)(83380400001)(26005)(66476007)(66446008)(41300700001)(316002)(8936002)(4326008)(110136005)(52536014)(5660300002)(66556008)(8676002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmNpNHIvYXJHMDNhMzFuVVBZeVdsRmp2RGwrYVdWaFQ2TkVlbmFJc09iSkZV?=
 =?utf-8?B?dmNuL2hOTENpVTNIMXg3Wk1MK3JsQmxpLzk5Y0dMbjBnQVkwSXJrVXUyenpi?=
 =?utf-8?B?c1Fzb3YyRnRscncrVGdWT2VEYUxXbGtRejM4Q2V2N1ppazlVMXFaT3o0MW9y?=
 =?utf-8?B?aWdaYUlSeTM5VjJNRUdSS0UwOUcxeGczaTgzK2NJaDJnQWVKQUtRbXY5STd1?=
 =?utf-8?B?YWw1SWZtV1hUWUtSSXl2bkx1ZDc0Tkh4emlGa2t3MHMyVk1lb1E3TERYSis0?=
 =?utf-8?B?M1IwcjZzUzZWNFBpcE1ISDBBMzZpY0svbWVuQ3RkcnNyc2I4bkNzVVpVWGVM?=
 =?utf-8?B?L3A4dDIxQy9NOWY0QURMbW44emlJZ3JJeUNsbUQzLzBKeW5hWnZVbVl3WTBs?=
 =?utf-8?B?cTIzTHlYN3F0V295Y3J6UFVvV213S1R4QnlqaURnMUdwaXFvOHl0M1dIY2Ez?=
 =?utf-8?B?cnB2dFdHK1FIOHlvZE0wcFZjc0JBTlowRHpjcWNHV3djZ3M2bG9aR1dMVEtJ?=
 =?utf-8?B?OXhHb3lZeHcwL2NmdDk5VWRtVWlWVGoxTE13TFBjYXYzOUNxaDRQT1lPNmNV?=
 =?utf-8?B?QzJqVFRzTW4rRTNma0VNZEF3Q2t3eHNYd1FEeVREZmsyOHVuVnVTa2hMRncx?=
 =?utf-8?B?K3hiWmo0Z3BRYXE3eE5BOUV4WG9kSG54b2Q3a1lTMW5CTjFNZG9kc21sNWNu?=
 =?utf-8?B?NUlXTktUTUR1cnpESWlMNzRzMVVhYlZGVGg2c0xEQTNhU2MvZVZtZGxCdUh4?=
 =?utf-8?B?WDRsUVNwVTl3bnhFcmQ3cTg1QjNRcSs0c2dSejN2bGdlOUYrSUwxUFVySjV3?=
 =?utf-8?B?WVJQNjZNZE0rVjVlSTNxRlpmcUsvOUJxWWd3aDRnYlRPRWVXNTNEOFRsZDVC?=
 =?utf-8?B?OERZSTVxNEJiWVJlUlo1Smxhb3ZZNHJ5R3R4bjJ2VVRwVU9OL25PL2dFcytq?=
 =?utf-8?B?MEZWeDY0ZmgxcHJUZmNMdERoYVlqK1FrSUtlbDBrcGVwZnRDU08zVjk3UmMx?=
 =?utf-8?B?RmhxYzgxdTZFMDY4aDJhMWliVUJjcFFUNTdlZ296TTlmbThHSHF3dkx4bkNW?=
 =?utf-8?B?T21OWm9sL2RUcGhsNTM1ejFIYkJqZGRPUDEvaE5kVlVTcDlYRVE0S1ZzVU5i?=
 =?utf-8?B?ckE1ZW4zMVVueEpuZDRqWUM1bkJyNjdtT1pXRzNIeXF5bTI3bWpjYjhPUVcz?=
 =?utf-8?B?aFFHdnRmMUJXMlp3bm5aOFVsKzFIcWhzRmIzQyt1ZjN3cVJpSHM1aXRLa3Jr?=
 =?utf-8?B?ZDJnWmFUT0tzWXNZMGF3b2s3RVpnWmhvUkpCc0dUL2J4USs0UExXdHRXemJ3?=
 =?utf-8?B?eG1IUDk1OHlTSUJTQmxYNHpab1hYYnVIRnFmbmZ1TkxQQnE1U3ZKZGJIZDBK?=
 =?utf-8?B?aElTVkJqZUpFSXU4T2QxUUVGMnVjeHRvbnphdGhSRmZ1a1RQZzl0b2FQSUtk?=
 =?utf-8?B?c204VXRMWENYU25hVHpJZ2VjQlVvUXNEOUxPbW1VTnQvL1MxRm1Jc1VNeDVO?=
 =?utf-8?B?QStmOGRQdnduUE5Yby9mRGxLMWhUSVB5Njl6L2loNGpTbExjR0dSV2EyQk9H?=
 =?utf-8?B?NmFXeG1GckhobC9UUDFJV2Q3ZWsvS2x1am5KOStFdnhHSjUzNmJ0eXQ1MFVz?=
 =?utf-8?B?d0JHbjFmdFNjSEsyOWh4QzlqZ21DVlNjYnI3VWZJVWZoRWgzR0lxZjMrZ3pk?=
 =?utf-8?B?YWVZNWRoc3JKaVhFVmRHTUVCUVFkNUQ1dlRpQ1FCZFRTbWVIcFMva2lUSU8z?=
 =?utf-8?B?cVpLTFR3LzVRZy9ZRkpQS1NDa2dLbi9iaXZxdlhGd3VQSi9tQXBIMTdaL2FL?=
 =?utf-8?B?L21JSEFLOTJqU2JPWnR5R1ZtbFpJVEtlRnRZbm5qcHlXSXVja2tycXNLSVl3?=
 =?utf-8?B?eXcwZXBLTGRyQk8xOWloeGppVldqWUZ5WXF1eW9RYlRhdC9UT2t3V1lFT2lm?=
 =?utf-8?B?ZVJSVTgrT3ZxNVJMOXFWMXdCanN2ZXdIUytPMTMwTjVkejdzbm4yR0NSMjlz?=
 =?utf-8?B?cVlPWEZyb1FSMzBTSmF6R1BBT09UdXVkcGcwNndDR3A0RzBNQ1M1VjBHL3NZ?=
 =?utf-8?B?UWRQUzJmZ3ZmSDB1c3ptWkhkSkRPMklETFgvMUVGSFd1Z05uUXE2SENSNlBK?=
 =?utf-8?Q?5PsZuqdd1BIOHyxPrSQ8SseRQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HTUARuOpKOWj/fTJdGA15CrX5sPmGEWciBXlBN4NwYV7s3lz2PV3Un/DuKP76EqqMNh3aARAkqp8l4p4N5MFlRUPNI6Olbkqqc1JbIRj2FeJ7YqssRXg8yuLMaPBH8bUWvKtO8VBMABuhU1zw+y3nxBcDFADU09djKRvWgwi50BRe6qXjo8Tn6uXz+ProZx9JOpJGUMfA8fTgkLB/PphLR9cSRdPTzgEOXPbSrTbAn58f/L8+nR58tnKt8Mt7M/+m6CVWUgjsG+b2LpxS1to2mIBIeGTPROv7hfCW+EL0GmzBTjyHe658F4q++XhKCGNnn4XzpiSyO7moiBOlsNGObmXUtWmn3oHNI2EW8UlcOYzx+lZF2Ni4xpz8k5HxeTH64lW5Ol5HngoPAw0LQwbbOBrU/5jDX1uxZn/Umt5hWGBvYIaHRg5zUOkKYxG+W63Glb8tdbETkC7M5gHRb2e66gMG8Lu0eg/CsdQ/UsWtIatwfYqauLHB26VYZGUN15OHySE1RpFROYHSGavnWZhhUlReIeO+UaOjNohe0dfCHtbO/eB0QEeyn6pr2K/3FQd7Z2f3plLzZ/KH8d3aLbIywIaQnckoAyFu/2YY8v26XfpnLgdYNxwjHrfEbcLtc5SGymsHrmG80+bgCtJR8RKaSaYq8++IbpJXnOV1rdsfGvktYzavsPGQn/m4EkIoG+sd7Jm0J8alfR344Lk7gvbcj0BFfLIQ2psYzfeHihDLR/x3UTRnd5dRqpD15xd6nsbqVFWNc6ntxPz8g8MSL3MVqo9Lsr3lpkPgXlI1xP6EAK1tXmYEoJZIaB0DzjrpZ6NP5P/4t55FA1kPRs66fhsikGrcJf4iBtGHGorNunNJG5NIdopoJJy7CZRC1dquBRiTkI13OQBAjdlbJAxYzsTMw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e52c60-1300-4af8-4a1e-08dbd60b4893
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 10:06:55.3267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wfn89s+kfzf4d/ylU+N8WjB95EzZqlyMuAF9l6dkrAXg/Y+Z4vLgBAsF22ouiI4HPu6CrRGhe0mEbcclW6ROrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7949
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBPbiAyNS8xMC8yMyAxNDozMCwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4gRmllbGQgRmlybXdh
cmUgVXBkYXRlIChmZnUpIG1heSB1c2UgY2xvc2UtZW5kZWQgb3Igb3BlbiBlbmRlZCBzZXF1ZW5j
ZS4NCj4gPiBFYWNoIHN1Y2ggc2VxdWVuY2UgaXMgY29tcHJpc2VkIG9mIGEgd3JpdGUgY29tbWFu
ZHMgZW5jbG9zZWQgYmV0d2VlbiAyDQo+ID4gc3dpdGNoIGNvbW1hbmRzIC0gdG8gYW5kIGZyb20g
ZmZ1IG1vZGUuDQo+ID4NCj4gPiBTb21lIHBsYXRmb3JtcyBnZW5lcmF0ZSBhdXRvIGNvbW1hbmQg
ZXJyb3IgaW50ZXJydXB0IHdoZW4gaXQgc2hvdWxkbid0LA0KPiA+IGUuZy4gYXV0by1jbWQxMiB3
aGlsZSBpbiBjbG9zZS1lbmRlZCBmZnUgc2VxdWVuY2UuICBJIGVuY291bnRlcmVkICB0aGlzDQo+
ID4gaXNzdWUgd2hpbGUgdGVzdGluZyBmd3VwZCAoZ2l0aHViLmNvbS9md3VwZC9md3VwZCkgb24g
SFAgQ2hyb21lYm9vaw0KPiB4MiwNCj4gPiBhIHF1YWxjb21tIGJhc2VkIFFDLTdjLCBjb2RlIG5h
bWUgLSBzdHJvbmdiYWQuIEluc3RlYWQgb2YgYSBxdWlyaywgbWFrZQ0KPiA+IHN1cmUgaXQgZGlz
YWJsZSBhdXRvLWNtZDEyIHdoaWxlIGNsb3NlLWVuZGVkIGZmdSBpcyBpbiBwcm9ncmVzcy4NCj4g
DQo+IEkgdGhpbmsgSSBtaXN1bmRlcnN0b29kIHRoaXMgYmVjYXVzZSBJIHdhcyB0aGlua2luZyB0
aGF0IGF1dG8tY21kMTINCj4gd2FzIGJlaW5nIHVzZWQgd2l0aCBhbiBvcGVuLWVuZGVkIHNlcXVl
bmNlLCBhbmQgdGhhdCBpdCB3YXNuJ3QNCj4gd29ya2luZyB3aXRoIEZGVS4gIEhvd2V2ZXIgaXQg
c2VlbXMgbW1jLXV0aWxzIGlzIHVzaW5nIGEgY2xvc2VkLWVuZGVkDQo+IHNlcXVlbmNlLg0KWWVz
LCBtbWMtdXRpbHMsIGZ3dXBkLCBhcyB3ZWxsIGFzIG90aGVycyAtIHVzZXMgY2xvc2UtZW5kZWQs
DQpBbmQgdW5saWtlIHJwbWIgLSBpdCBzZW5kcyBjbWQyMyBhcyBwYXJ0IG9mIHRoZSBmZnUgc2Vx
dWVuY2UuDQoNCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhlIHRoZSBob3N0IGNvbnRyb2xsZXIgZHJp
dmVyIGRvZXNuJ3Qga25vdyB0aGF0LA0KPiBiZWNhdXNlIHRoZSBpb2N0bCBpbnRlcmZhY2UgZG9l
cyBub3QgdXNlIG1ycS5zYmMgYW5kIHRoZQ0KPiBTRVRfQkxPQ0tfQ09VTlQgY29tbWFuZCBpcyBz
ZW50IHNlcGFyYXRlbHkuICBUaGVuIHdoZW4gdGhlDQo+IE1VTFRJX1dSSVRFDQo+IGNvbW1hbmQg
aXMgaXNzdWVkLCB0aGUgaG9zdCBjb250cm9sbGVyIGRyaXZlciB0cmVhdHMgaXQgYXMgb3Blbi1l
bmRlZA0KPiBhbmQgd2lsbCBlbmFibGUgYXV0by1jbWQxMiBpZiB0aGUgY29udHJvbGxlciBzdXBw
b3J0cyBpdC4NCj4gDQo+IElmIHRoYXQgaXMgdGhlIGNhc2UsIGl0IHdvdWxkIGJlIGJldHRlciB0
byBmaXggdGhlIGlvY3RsIGhhbmRsaW5nDQo+IGFuZCBtYWtlIGl0IHVzZSBtcnEuc2JjIGluc3Rl
YWQgb2YgaXNzdWluZyBTRVRfQkxPQ0tfQ09VTlQgc2VwYXJhdGVseS4NCldlIGNhbiBkbyB0aGF0
Lg0KT24gdGhlIG90aGVyIGhhbmQsIHRoaXMgZG9lc24ndCBoYXBwZW4gb24gb3RoZXIgcGxhdGZv
cm1zLg0KRnd1cGQgaGFzIGp1c3QgcmVjZW50bHkgc3dpdGNoZWQgdG8gY2xvc2UtZW5kZWQsIGJ1
dCBtbWMtdXRpbHMgaXMgdXNpbmcgY2xvc2UtZW5kZWQgbW9kZSBmb3IgbWFueSB5ZWFycywNClBl
cmZvcm1pbmcgZmZ1IHN1Y2Nlc3NmdWxseSBvbiBtYW55IGRpZmZlcmVudCBwbGF0Zm9ybXMuDQpN
eSB1bmRlcnN0YW5kaW5nIGlzLCB0aGF0IHRoZSBodyBzaG91bGQgcmVhbGl6ZSB0aGF0IGNtZDIz
IGhhcyBqdXN0IHNlbnQgcHJpb3IgdG8gY21kMjUgYW5kIGF2b2lkIHRoaXMgYXV0by1jbWQxMi4N
Cg0KR29pbmcgYmFjayB0byB5b3VyIHByb3Bvc2FsLCB3ZSBjYW4gaWdub3JlIGNtZDIzIGluIGNs
b3NlLWVuZGVkIGZmdSwgYnV0IGV2ZW50dWFsbHksDQp3ZSB3aWxsIG5lZWQgdG8gY2hhbmdlIG1t
Yy11dGlscyBhbmQgZnd1cGQgdG8gc3RvcCBzZW5kIGNtZDIzLg0KDQpQbGVhc2UgbGV0IG1lIGtu
b3cgaWYgdGhpcyBpcyBhY2NlcHRhYmxlLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+ID4NCj4g
PiB2MiAtPiB2MzoNCj4gPiAgLSBmaXggYW4gaXNzdWUgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0
IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+DQo+ID4gdjEtPnYyOg0KPiA+ICAtIEF0dGVuZCBB
ZHJpYW4ncyBzdWdnZXN0aW9ucw0KPiA+DQo+ID4gQXZyaSBBbHRtYW4gKDIpOg0KPiA+ICAgbW1j
OiBjb3JlOiBNYXJrIGNsb3NlLWVuZGVkIGZmdSBpbiBwcm9ncmVzcw0KPiA+ICAgbW1jOiBob3N0
OiBtc206IERpc2FibGUgYXV0by1jbWQxMiBkdXJpbmcgZmZ1DQo+ID4NCj4gPiAgZHJpdmVycy9t
bWMvY29yZS9ibG9jay5jICAgICB8IDM0DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1tc20uYyB8IDI0ICsrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L21tYy9ob3N0LmggICAgIHwgIDEgKw0K
PiA+ICBpbmNsdWRlL2xpbnV4L21tYy9tbWMuaCAgICAgIHwgIDEgKw0KPiA+ICA0IGZpbGVzIGNo
YW5nZWQsIDYwIGluc2VydGlvbnMoKykNCj4gPg0KDQo=
