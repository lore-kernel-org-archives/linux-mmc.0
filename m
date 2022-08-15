Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BCBC00140
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 12:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiHOMML (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 08:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbiHOMMC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 08:12:02 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FF924BEC
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 05:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660565520; x=1692101520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j429PhL3j+oRwsBAA+mRMj3ry7XSa/Ll7lA/CZzBIF0=;
  b=T9LZwGjzzrVJle4204JLgzfMo6qjDs/fW+6EjQUn2eyk873ABkuQpT1a
   6suDB/3WS95cREj+Wx7T9nsd0WXcpvlNPPGpuohVgVMwSUOU1TJ7Z6TTF
   LdxWkVa3KkUAwfI3qtZHRzpw7FfhSviYDHQwDQt5XJkgP4/G8bol7/WNL
   yYbLKixF2moHvOtjmrluhwJeSo/ZcspBmVQhAwgulWNlW8vuNNF2eFhWa
   IdvtHrmD5A/ZINzieBie6fG7L//J4d0yPXifyaytB5yJGkZYhmS+aozyF
   lHgPhYMJ5NlzEDypOMH5NUjZ+q0hcAXH2HsRfXYhnlC2u0CGknaMBW23D
   g==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654531200"; 
   d="scan'208";a="313005407"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2022 20:11:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bs1CeOw2N1AwzHPWoRlKTZ86jRRiMTB3kk0jD4TyRUB4gt3rMRiXX2Vd3d8wGe9OQpOK4CVvk1S/cDw+CM58LolNWlS2JN4xRhMR42+fN5MUXFzl5A7wbcVq0ZmdEVum6/X41QpNCXoKxTd0y/zhHpj3q5tPb7ziuPhj14NHve+gpAhNCj6z0PQA10xdnynF2DhsEfKFBU7xyVb0cLEyJfIM4f7icIsVF5u/8H+Rg17lYdXjlYckl08O1dNiL1sH64hMtquHSOHJDkbN9Saxc8btXSsoYzITPmnvWXph7fFOO17yQLqfMTgai/6rtFyPj+YNLv5uG55EvRIYB64acA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW2LLbcH/+N2pCIeYPQI7Iv9JxvbaAAf8YbUdwn3sVw=;
 b=JZ6vu2W7USlb+zvCmFaqGpzsMNJaLmc8SYLmUdgKPBkmR8WRZJdNdJkYLsJQQZp+/kU8DrljGhFj9rGcKNQnC++kuoqzJ77Mc5UQTHTbQiLhcj+hs0FdJL0Hg0OW9hbMtIHOabHKqItFBqdvW4xCY9wym5TkowdP6GF2wxkdkZBlICFsOOmDivbCwOsG9yJDI47X27zC84v+g2+bGy0FQhKvQ39gODoC9lnrNyKCQOW+FEb4ygGp+lLKb+VaINNBZQgbgqzaKB/MkOaz3WhPYj89UNjBDPdjXaZgvR9bHHMj6qN1tR8bJDbkPfIffjyjVQU/VVtnRq4RY1kmO8c2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW2LLbcH/+N2pCIeYPQI7Iv9JxvbaAAf8YbUdwn3sVw=;
 b=a4Me3ZDfFMOG3kb0m8oHDXbenQGuUpldJH5rgN+U8rL3pRLI1jPCTTjBC5s3v2p4PJghRGAnPur5g8c+7ZAtmBcY8VCj80LT3+WvAa9HL1ZoAe7l8Tw+U711kIPwL+VIrrc6vdT3DKNXlzrkfgIveVruiN0OR550fWYtVCqevmc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR04MB1147.namprd04.prod.outlook.com (2603:10b6:3:a6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Mon, 15 Aug 2022 12:11:57 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%9]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 12:11:56 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7QAPwi0AABQpUuABmc8nMAACAULgAlKINPAAMpvpoAUetmXQAAXdPWA=
Date:   Mon, 15 Aug 2022 12:11:56 +0000
Message-ID: <DM6PR04MB65756EA45A10629F2EA8A870FC689@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <AM5PR0701MB2964D76967437E61EF42731DEF839@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65750D9A332093DBA5B30BDAFC839@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB29641DB9207CDDD1DB273075EF8F9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65759D709D6C45AFD03EB4B1FC8E9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB296429322BA0EEB2CE0B23FBEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB296429322BA0EEB2CE0B23FBEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85cc6a5a-78d8-4371-174f-08da7eb7593c
x-ms-traffictypediagnostic: DM5PR04MB1147:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5YC9KvCaEH8hFXHNilgnhvsKEBFh8lOb4PtPRTsxwycwlx7jpkZTFsCtV1CFR/u5y+bFCh4k/q3hi+1DoZMIaPR8CAdkE/fvvu88tIFpBHaMdJsHShpHhO9H0L/3o2XHGECPsHltdt8VCIsxR7F/FIn7DVtIoMUCmOu+k/B5HBUmHw0VQoKz2j2Ra0GhAn+nF0VtEqIWKfQZREFBBqeTB+NuVkLOF5yynN1tBTlOMLv3KslUo8m6KrZfzslFvQnHhsdYVaUzpCMqzzqa0Jghge7SinWE1ecN4vt1RFXze1WBxHIgWCaMe0dVxi+V9HlXBGVmppiPRXZYFcbA7VhDaazG7a/WsDJ4AU1oqpzWyW9tZvDfG2DLZmdOPDJQnndq8MQ+6fIdLSPbWnvsXoXiSocpdpP8/pNExj7gJxApm7RlH0bEbn/hnPS1hUzpCA46ssWyBOEwePPVTqbuNAJADvM+Lzm3OLa9f+hO1oomdmTrbid9Z0eSXKlkfa6f+pkhKO9y9gQjSlclDaVGGIGbwLuMfA0Svg3a0mLPljBs9HJ5h++H2Af033ALIrAzThezXaUNWBfYlnQJEdGBSeu4bLeQFZ4Vcq2pxLBkg1Esob7QhTLjuyVtN2wUtS0Jfvzxf6QyiI0nfmNAe3Ds/o5Jm3fS19webadeGUSOzOBb1/2OyEnRqmxWD7fnHUU3m2nJX7jnRW9O6uOeTtW67+C0TpAy3EVxxciCvem8Jk8YGHG+xsDQaQCWv4rdgMpv45KQA1K2TVqgQiLC47zwRDdHGnz3wRhbnhO3NL3Rk25tERk9f0KgV0J0k2QCqMMPeAOW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(33656002)(9686003)(26005)(83380400001)(71200400001)(478600001)(186003)(66476007)(66446008)(64756008)(8936002)(4326008)(110136005)(316002)(54906003)(66556008)(66946007)(8676002)(76116006)(82960400001)(5660300002)(2906002)(55016003)(41300700001)(7696005)(38100700002)(6506007)(52536014)(86362001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Omcs5aiktbfBlN2oPPCdHRIfxVDwZcjXiA0+voG78NzFntJdl/FYk6+4xl?=
 =?iso-8859-2?Q?r39do0ACSj1ZKbIHgjtWNPwtQl2FSY5GACNHYuuIm8ZadBRgPLqY1z0rnb?=
 =?iso-8859-2?Q?zH8uOG0rgSQB3GNyS0XWuQFHPwFdcctTUjqiw6rWdJI/QRg0L6547mdE/e?=
 =?iso-8859-2?Q?V50azmdvjxfo32B0488v2laOHIBUjd20iZzgpyjI+HOMf3qgC44HPk8GJp?=
 =?iso-8859-2?Q?LFvd0OgVQJV2EWnoV6hRaOoDYvjrEaxr4waCWeff+YvsG+8xPHvFWC4WuB?=
 =?iso-8859-2?Q?ry0vMJ7VnxydpqVbsuWxm9MnKiA8ly709MAYYAh4AePioXI6tG/mBUjIUO?=
 =?iso-8859-2?Q?sX/8G/wg1V1+59PG9WUifHjSLkuMqWEqYNmpnnEiQ49xAWN6U2ZcKgBh0N?=
 =?iso-8859-2?Q?/smCXyS4lRZIseaiZRKSFlxrXUfd1Zh3vxa9zWPfHaawJF77Ir/4h9uDYN?=
 =?iso-8859-2?Q?zmb+rT77qqCrqP28WCyyS+9pX0Q4kEr2H3NfqOzcDxcjenPzVa5/xqeHGW?=
 =?iso-8859-2?Q?UJd1Ik3RHlzkysJlWgSUyC9HoXdY27Ll8Aiw+Xj95LsKbfX/MRMaYS/GmC?=
 =?iso-8859-2?Q?si9xiMXJeJAUm5OWbKLEMhKlxTOyewVKEauopbJq/Ei3IjkMWZNrpuIniQ?=
 =?iso-8859-2?Q?07uSHKwkA0p8SRVuJyCNWjCdtA6VpCuUzG8XEugh8WTdHeOmImbwa/CjuH?=
 =?iso-8859-2?Q?vnrZTDSqarpy0Dlkyl95JmB9Z48N0uJ5TET4WXuJc0IhtItIXad+g7AE4y?=
 =?iso-8859-2?Q?sIgGcQEkwHYGGR7/Jn4a3zPuKAMD/VTjKcSwgv+TMw8rOPktZs8OjxVR9c?=
 =?iso-8859-2?Q?l5ZxGBLJBpzHEnX8bHNO5b5Pwe77kUvlQwU3jnhSwef4aqxj4Lph+mBynS?=
 =?iso-8859-2?Q?8BR+0tv14OYWfb8v9mVmcsakc03tQMvHvcMGu0HHr7ymXM7naMJ9CtOcVs?=
 =?iso-8859-2?Q?zP9QpqSDG6kUXk8VKag5TQmWCb7XO08jZ8izkdRlMs41IX71CfEWMsHmpA?=
 =?iso-8859-2?Q?eqeSevXMjFCqGUlY3byMM5m6Yz0hsbpGPdUakM6vOznbGrTialQWQIt3Qn?=
 =?iso-8859-2?Q?8LWzYJdqv4/rD2FtgkY9kjS7nMZTuw+vcp/QYo3K26e8oeDM1EtKpZwfd6?=
 =?iso-8859-2?Q?UMsYQAvChvmxsj9HmUtjKg/J4DVnKvboOMKSuopD2Arm5ieheCLv/pR3Zb?=
 =?iso-8859-2?Q?nH5bYIExVxgkZq1WXuBA1gifETfgQMKcWKdyGoyIMx1n1vcCGR77/y5qkA?=
 =?iso-8859-2?Q?VPtQdnMzoHiYkajQn68Vdm1pDFmJdQoIvwFePuiLgOv28ytStwpHPtDGhp?=
 =?iso-8859-2?Q?pEveSEY5MJCMZ14FVvP0QQHVAxEac7WGeT7fan0LjN2LW7FOqh2agROqVZ?=
 =?iso-8859-2?Q?xRJ1j62BGHZDV6TbtvIsV1fAYwFctUJwvDtn2ajX7D2fnaKQRsIGeCxkc2?=
 =?iso-8859-2?Q?j4JTQdMG3ghuKmEOwMMgqkky7UoPY6wRWgUiI/9GhU7Bgr1A+GNu+WzqHY?=
 =?iso-8859-2?Q?Q0WilKW85YOU+zxJK2I6kD0+tu0m9Gi8Q/oSTAOqf7ovLbKkgyOXITfDII?=
 =?iso-8859-2?Q?86vgNfBO5VY6ET7lpttP9bDpkpR4uH+J2NKFR4NSz9hjmwGf9hnmXuKCc/?=
 =?iso-8859-2?Q?xuRit1z6de7n+kBsxf8KAoJuSeChM+XIi9?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?dRldkgugJRkqk6mDZuFsg1y51/NhJMoxRKWgjyXfuUIRXuxnY4ztV7ZzGP?=
 =?iso-8859-2?Q?w6wxPd1Znwk7NaNKXkI0zc156XBPchO250li0lTPS1oCANOffQMj5hrAkQ?=
 =?iso-8859-2?Q?YQP76qkPrJ27JzlPCPUqLgHddM3qxPhcIjuH4IA2U9qRl/T2v2IMQ9WP/l?=
 =?iso-8859-2?Q?19GNAqngK49r5/9IOvgMpx7p4tRJT2QyxT62VYk00tP72yYJ+I0bV9+0Kp?=
 =?iso-8859-2?Q?MZ6UEDij3+9/7S/Zdr0rp8cJUy8u6rHB4CBq6vp9WlSYr5rEd3G1jA9G7t?=
 =?iso-8859-2?Q?5pjx/ZT6lxhnj3rJ72OL6PC7ZBM8zPvvtfgkWGythYop2cw/mbTTq68VWx?=
 =?iso-8859-2?Q?kpdm6ELPsWPNrFozS4x6ch3AzFfl87vtjPX3szgOxZXVgugWbpzuaDiVwJ?=
 =?iso-8859-2?Q?7eJPzk1wJeoI8X+9hSPYWjdGp5fBjR/lVagHYmJ0WrW1ju5NR6mhFl8zb6?=
 =?iso-8859-2?Q?zqNJI1PF9HHSA6Eoih59tbhvALhu9UitpexWm2ih4eSNq++WLFcCdEsNmg?=
 =?iso-8859-2?Q?R99Qf3HUQebdyo5ygmqa2v6bq+WIo9K68rzAk8KEeTNmt35JIxM+tGb8vH?=
 =?iso-8859-2?Q?Z2IK7CIq5KZag2VasVWvdz0DG1JNWTRuO15UYoxN8xh3K2atsVTmJeb6+r?=
 =?iso-8859-2?Q?syYCCE/8TRfSqPW4gKkPp8oz495mwpadkvAzEQAIcI+yuE5RJ/xn+kZFtC?=
 =?iso-8859-2?Q?4LrYiT011q26N7TGGX2NQ0TuVtB5MyQDrNkAp+WQnLbzk3/8Ku6aTZoICf?=
 =?iso-8859-2?Q?jHoDhyN12ERBs8UcCVRQYk/oZJRLnbFyricERiEDRRCGGz3YoPk2VTqFE6?=
 =?iso-8859-2?Q?lgCQhviTHXDgKn0NzO09x2zDDbFvnwU9tR5h+wkXAx7kpXooAzbSuFdc9w?=
 =?iso-8859-2?Q?hId59CJ79i/UUh/Pp699GC0Yf+KojOMcI/+hv7bjn+6u0Ad4/thIcu41ju?=
 =?iso-8859-2?Q?SmG3fxEzfrwsTkMcWR9ytxHjDGxCs+K6Le7saqamxb7xlibTszQ3wAVL7I?=
 =?iso-8859-2?Q?9O5+fJrhlH4cs77Wc=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cc6a5a-78d8-4371-174f-08da7eb7593c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 12:11:56.7102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QbxlynJXkeh08EldP5ivyuJcj+Hp6LKf92a+zaFvEOe2+wRaQLTirk/1HRWsotxAafO0IB/PuN/CjmppJhUz/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1147
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Hi everyone,
>=20
> Comments are in-line bellow.
>=20
> >Bruni hi,
> >Thank you for your patch.
> >
> >> Hi everyone,
> >>
> >> Here is the rebased patch.
> >>
> >> Add the check if the whole firmware was loaded.
> >> Cleaned up the leftovers of handling the file in chunks.
> >>
> >> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
> >>
> >> ---
> >>  mmc_cmds.c | 67
> >> +++++++++++++++++++++++++++---------------------------
> >>  1 file changed, 33 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/mmc_cmds.c b/mmc_cmds.c
> >> index 8d7910e..d017b64 100644
> >> --- a/mmc_cmds.c
> >> +++ b/mmc_cmds.c
> >> @@ -2812,7 +2812,6 @@ int do_ffu(int nargs, char **argv)
> >>         __u8 *buf =3D NULL;
> >>         __u32 arg;
> >>         off_t fw_size;
> >> -       ssize_t chunk_size;
> >>         char *device;
> >>         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
> >>
> >> @@ -2926,45 +2925,45 @@ int do_ffu(int nargs, char **argv)
> >>         multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> >> MMC_CMD_AC;
> >>         multi_cmd->cmds[3].write_flag =3D 1;
> >>
> >> -do_retry:
> >> -       /* read firmware chunk */
> >> +       /* read firmware */
> >>         lseek(img_fd, 0, SEEK_SET);
> >> -       chunk_size =3D read(img_fd, buf, fw_size);
> >> +       if (read(img_fd, buf, fw_size) !=3D fw_size) {
> >> +               fprintf(stderr, "Could not read the whole firmware fil=
e\n");
> >> +               ret =3D -ENOSPC;
> >No space left?
> >
> Here I would propose to use perror instead of fprintf - something like:
>         perror("Could not read the firmware file: ");
> This will also propagate the errno from read.
Agreed.

>=20
> >> +               goto out;
> >> +       }
> >>
> >> -       if (chunk_size > 0) {
> >> -               /* send ioctl with multi-cmd */
> >> -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> >> +do_retry:
> >> +       /* send ioctl with multi-cmd */
> >> +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> >>
> >> -               if (ret) {
> >> -                       perror("Multi-cmd ioctl");
> >> -                       /* In case multi-cmd ioctl failed before exiti=
ng from ffu
> mode */
> >> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]=
);
> >> -                       goto out;
> >> -               }
> >> +       if (ret) {
> >> +               perror("Multi-cmd ioctl");
> >> +               /* In case multi-cmd ioctl failed before exiting from =
ffu mode */
> >> +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> >> +               goto out;
> >> +       }
> >Why do we need this hack?
> >Why would the last command is prone to fail?
> >If there is no good reason - Lets remove this hack - as a 2nd patch in t=
his
> series.
> If I assume correctly you refer to repetition of third command after a fa=
ilure.
> This was left as-is since I understood that first and second command can =
fail,
> but the device
> should not remain in upgrade mode in case of failure.
OK.

>=20
> >
> >>
> >> -               ret =3D read_extcsd(dev_fd, ext_csd);
> >> -               if (ret) {
> >> -                       fprintf(stderr, "Could not read EXT_CSD from %=
s\n",
> device);
> >> -                       goto out;
> >> -               }
> >> +       ret =3D read_extcsd(dev_fd, ext_csd);
> >> +       if (ret) {
> >> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", de=
vice);
> >> +               goto out;
> >> +       }
> >>
> >> -               /* Test if we need to restart the download */
> >> -               sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> >> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] =
<< 8 |
> >> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] =
<< 16 |
> >> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] =
<< 24;
> >> -               /* By spec, host should re-start download from the fir=
st sector if
> >> sect_done is 0 */
> >> -               if (sect_done =3D=3D 0) {
> >> -                       if (retry > 0) {
> >> -                               retry--;
> >> -                               fprintf(stderr, "Programming failed. R=
etrying... (%d)\n",
> >> retry);
> >> -                               goto do_retry;
> >> -                       }
> >> -                       fprintf(stderr, "Programming failed! Aborting.=
..\n");
> >> -                       goto out;
> >> -               } else {
> >> -                       fprintf(stderr, "Programmed %d/%jd bytes\r", s=
ect_done *
> >> sect_size, (intmax_t)fw_size);
> >> +       /* Test if we need to restart the download */
> >> +       sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> >> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
> >> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
> >> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
> >> +       /* By spec, host should re-start download from the first
> >> + sector if
> >> sect_done is 0 */
> >Can we use here be32toh or get_unaligned_be32 or something instead?
> Tried to look into it - none of the functions fit the need, input must be=
 an
> int.
> Best I can offer is to write a macro - something along the lines:
>         #define le32toh_array(p) (p | *(&p+1) << 8 | *(&p+2) << 16 | *(&p=
+3) <<
> 24 )
>         sect_done =3D
> le32toh_array(ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
Then better leave it as it is

Thanks,
Avri

>=20
> >
> >> +       if (sect_done =3D=3D 0) {
> >> +               if (retry > 0) {
> >If (retry--)
> Agreed - will be done in v2.
>=20
> >
> >> +                       retry--;
> >> +                       fprintf(stderr, "Programming failed. Retrying.=
.. (%d)\n",
> retry);
> >> +                       goto do_retry;
> >>                 }
> >> +               fprintf(stderr, "Programming failed! Aborting...\n");
> >> +               goto out;
> >>         }
> >>
> >>         if ((sect_done * sect_size) =3D=3D fw_size) {
> >>
> >> Best regards,
> >> Bruno Mati=E6
> >
> >Thanks,
> >Avri
> >
