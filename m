Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F8C7EE23
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 06:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbjEXGu7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 02:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbjEXGue (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 02:50:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E9B199C
        for <linux-mmc@vger.kernel.org>; Tue, 23 May 2023 23:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684910932; x=1716446932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wY+p0PjgySGyTIe/3nDkS8eebNy1Vz5YEEHkS3FUZyA=;
  b=ET/Qt4yg3fZ5oImEPo//BMaz9MdCFbedBrLSulQa6K+PibIDJKoLIoOF
   2qqNTJzl3aHxiLDPMoj6LK1YIimeGbKvuJsBKWTA6IfnG4jGeAmTer2OJ
   M0+7oNihROTXc3HkCZz0VUu90OoqMYslzF3hlrrjtW0U6kYJcavZM5JUB
   /O43vVH5pXdl2iP2hhHlBIZwE6X90VGc4y+wiBG/FzywM2EZgneJJ/yjP
   90J/SqN+vR3fK3sWvyzFekHiJjEcIJWLfgsTRIUV3ogA8oW1CHfL5Fp3K
   1mPxJfKgqdhpsYStVsGeyFbtqzK/+Angzonc1K4ENQfrtcWYrJ93tZO9h
   w==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681142400"; 
   d="scan'208";a="236456224"
Received: from mail-mw2nam04lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2023 14:48:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUsTXpUaPrw1hSk/SzyejFk6P6m0uyRKQkdYD6EPl0WEflKXFgdt98za9bnSuh9hx6JdHpiReScjWM910F+ojayo0mFkHFERX5n19gFOvW/7vxvgfx2UO9FWTX66XBZ38q/K8tm7fsUXrSzh+eOAQnIlnLPSqanRcIooYOdFFr3Qv+V+jYrcPboGUY3uLUIB1mfRpBF6Rppk0D74hL1Hnc5xPk9JLxpqoBU2iox4EZLR+mBMJUiq97ecrI1JRJoQFvlfMx7WVr5IjZuqHtVkftjxoKEtbAgzEQnkFV7NfKzkgzDs56rwLywFOKxryngiZjcubWunKVbUyeU++Q2K7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5ncTooLZaHhh7WBor/oh3IX9etuyFanzSozSU522Q0=;
 b=icKSgNiUzeYHeP6BTYqV0RJYi2YhfdMwleWLFLZWXnm5p1tyqc8p/2wIUol7/iDCmpouHPwe7kplYkLPkG1nK864PXeukK6G0ksGGa9LCNJYL40JK263RVLSnhL8XMP9nSDXE9f/OVecB/b7JnNUHTcOZLAWauMzZki3x4HBtShzgl0dKfrakhy01BDt4KUneKYJEseBUUtNsVH41/z6Ew6jU49c/LkJyTfebpY0OCw+pxXsJ0RI1Jwe4Gkjmorued4RAzFs7Qgsp/3OuYzv9An9jHVTTtRtooUUW5QcEKy2ahl1IoDSMSjZC4mkhhUyDtr1Fglpodn1OHxmP93/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5ncTooLZaHhh7WBor/oh3IX9etuyFanzSozSU522Q0=;
 b=qj8n+T/4yTvMaiIFdBuTVvEWDXzc/n6SsFtxZDMFHi1T+miQ2PldipAIHBkTFoITc/HlEMkqHrc0bTa/qSDNPeQBdeEVndmIjdryXNNzOEncydF91jN86Z81nhIJjOT0gFEfv8EiV4NXYqlWwcbBgP366ffqxOt6u9K3wPElKC0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB8425.namprd04.prod.outlook.com (2603:10b6:303:144::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15; Wed, 24 May 2023 06:48:49 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 06:48:49 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Enrico Jorns <ejo@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 3/3] mmc-utils: do not hide CID manufacturer information
Thread-Topic: [PATCH 3/3] mmc-utils: do not hide CID manufacturer information
Thread-Index: AQHZjPc+AoW8Kr6GW0OeCWjQ0R6I/69o/YKA
Date:   Wed, 24 May 2023 06:48:49 +0000
Message-ID: <DM6PR04MB6575F75B6FFCA7D6D0AA0835FC419@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230522214818.2038252-1-ejo@pengutronix.de>
 <20230522214818.2038252-3-ejo@pengutronix.de>
In-Reply-To: <20230522214818.2038252-3-ejo@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB8425:EE_
x-ms-office365-filtering-correlation-id: 87e408ee-71ea-4ee1-0dd2-08db5c22ee07
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gNYzdiPzFdNvf30pFptvrryj1Y9VYiDVcA12NUeDgNMsj507U7ezfAGBkX6TXSGCa2nmk++4PlxyqXIpTHCoaBKk/VMQAXofO4ieqXZSlUddAxR2h55cP9kG5aQNkfQXUVT2NTR31PqF7RZqWHnhMoDmZ+uGNKGQkwHIGmLtBVYTByVMTmcWazKOa82I76V5Nho2Ln+9nVwARnLEclOG8i1egOQzA0HRh4MQWHTkDH68byTMdpVifXSvroJCSsb0HDrG+czkcSATOskh4jQk5SBCvQ1ilJjnunRpkcpaeyg3VqHM0ZhiusGNz2WVL6MviJN3RC8u3e/28WPYb009MltBeZZ3IASSgXgiwk8vyqDeJhE4dZeoWDv1qc0Y2zF8x3kEQ1PETOYjk4/M5YpcV7z/4BIRRko4DY10NTyR4wOD4M0yUS82D+dhwMRU7iNqw+9pNtWZX1bLwyZeSx28F4QTyniXCk+dgxEZveqnbnc54Anr666Yc095o9BWt55ywmh2sMqQ5K1S+EhnHMpDV7VZZ//KHJfMXTjtGMZdCbEXR+xiX+yjTqXIwk4iKZF7Q7VE0ME8a1idSD0DfzBmNxlKHnES4rjcJnJPdapKqvEBH+jDrl24miWxN705tgB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(5660300002)(52536014)(2906002)(8936002)(316002)(66556008)(4326008)(64756008)(66446008)(66946007)(66476007)(76116006)(8676002)(478600001)(33656002)(83380400001)(110136005)(71200400001)(186003)(26005)(6506007)(9686003)(41300700001)(55016003)(38070700005)(86362001)(38100700002)(7696005)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hgKhAYOjpHMzLCYa+nYR7egjCOPPw4sawG31xzG3bhlZ+h0HEQn3XE/u+H4E?=
 =?us-ascii?Q?+GqU2tP+JovO9GeOleGx5zMz9WT11A6whg6rnQspX6GSz2uWsHc+4Fmu4Lfm?=
 =?us-ascii?Q?mju3nm7qbsWn6joMR2F4RWw2IrS5+ZlPCO369BTAq7F9zJ5e2zgxrEJHZnkQ?=
 =?us-ascii?Q?q7oAjTN7hPaWHU2N5I3/m+CwnS48oguif1DdYseKjVcXjXJWo6/uSKSNDOKX?=
 =?us-ascii?Q?0kOn4rhhNcc7F/envuE2m0Tonngc86hxtFhvkTvPvE1zGF/vA21sqpTinKyT?=
 =?us-ascii?Q?V+5uiG2QHR6u+9O30ZJx5+QuQQRANmTHc967lqqtvxcdv5GDeksJp9ejoQE2?=
 =?us-ascii?Q?poQPojwCH5XX8vDOHvRA+biE9c5dII4ZczKELWJm0TuJbDqFNShGWOr3/Tgj?=
 =?us-ascii?Q?7y8L1Ue3RkQbxyPGq2LB1OkqxYLEQRg70eA4ZFs4AaVuLklWYktK14zyOP3N?=
 =?us-ascii?Q?jcSfoZ85c+bOzaFTrCa8iB/PXTPulg2ZOmyhg9jcUOAarFPjrafYfaJMLm5n?=
 =?us-ascii?Q?Yej5WYFSjRp5mtlIwG2yeEc4fmIo1ovV1p3ZTolUYfj9aSxh64dqejgwEK0K?=
 =?us-ascii?Q?CCSkizsbJF3d+xw/LGR1JuhKWri2BrUxLtywG1kJHdG3IAqlnVRvPf8i8tF4?=
 =?us-ascii?Q?shOc9k8dgTBRqegfSc/13enFlxYJgx3yDus5G1myswKILMUnojXsa8GvcHDW?=
 =?us-ascii?Q?NpHbGxsvFINFWq8dTAgrqOGG+KzO9p/UjlOzhIT2fZWS6lcE+Z0tbu8MYxt4?=
 =?us-ascii?Q?rG2znzCcu0u1c7hR1nEp16HyRBk2U+Oji4aXcNaBQOx75NYoVlZ9leHHN2HW?=
 =?us-ascii?Q?u+tfmbVNC6+QpjGQK9piXb75rW8AbTLiPEWreVkNNsV5Hb+rn9fhvVwltsWh?=
 =?us-ascii?Q?3Il/4tsPVr3CpQhphHwZ8xWD7vTR9hvvN9l8Xnwyp9kTPbXZYFcn1zpwYA99?=
 =?us-ascii?Q?xP+FBdCrnzP4kqk7ABNohxsOQokLgjUrOBZQrU7FhRyVtH/19gni8/Woy0Rn?=
 =?us-ascii?Q?AlRUp0cHQ0JmyeMKV1WLmph5HeYmrx8S6YvRGgcKhXE1bz8rKkyYaqCZ/Axr?=
 =?us-ascii?Q?wBbhwML1nRblhilFK5u15GOBwPlD7de9mB/mWR9v9p9nTFBwSzbPybnkEoNv?=
 =?us-ascii?Q?8IYdydRErhIvknd9s9liFT17H0rdGbu2poCC84PCEERq5XJBR/kaHeeRzTl7?=
 =?us-ascii?Q?wQC0SjOeC9q72aQVHmJtsxWPNvOMkx2OtpJJeHG4PTjNSYNbJdLqKlbfhyYs?=
 =?us-ascii?Q?mIzL4rVUiW4Jnv4e9+G7scZWE0nEYcGlLYqANmLyqLngmDP4bGlgvUWXLOiq?=
 =?us-ascii?Q?KN3YKPfH6f2r/B//Qu2bjXQ78q9gQLV8yB7rJo1t5DzHHFBkrkXIATcaYpz2?=
 =?us-ascii?Q?pnOf5QJfQVVVnwvuCI5wufX8gwnOtiVs+TLIzkDZ9UtWiOCmQTZIMn36kusl?=
 =?us-ascii?Q?cIBzoL60Wov2W45ALoKmOMpqhuxeU23UwXUrfYgGe3cBmHolueHCO4ve8jVg?=
 =?us-ascii?Q?lcZR7S2wSMzddDFWJuWGeYV8qFQi3mLjoRHOEae2VLaVOSZ9bJsITD3s76tZ?=
 =?us-ascii?Q?tKes49tUOwLXg244r8rx5dcu93Br+E3OALAXTTet?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KGd2JMR6dc58q5de3CHHXcvmnTCoVGEEAr0hHIsiWT9U72DhbE4er3M7+LsuUU0pZRwC1NeSkzb0nfq7Bc97lMeIU6CDMGoeaQHku4PRNf3GZSt7gSGyEtW9WhbkMwXLUaPBY0iL2ccFWyLW93t0Rhg21NiUPBRQiLDyi3DxFaWz76VxiP+zZM07v9gLloV0nt+uK+UTRpiS00Y9cbUn1qQf0oktX/iEOQgwR5X8MCvTjyh5vqVbkqVJWoof6y1smsYv/3NGd4O2/zkDVzXSPqRmO68wOXGCLt/jidYHMF+KTHXVcKEDpBS+DxnOt1Y/ql4AwF8NtwIrKUMy5TTNR53HPtLm1gWgQsVbZW+zE9aV5qNfUc2GVNtFYLqLn93GxO7DcHb0hpUuVsttJNV1MHMdIrBsqXsXoiffcPLi01Ph78wTwBEPpICJvcBL8/1qPiTqu8/BH4A8paNhBvYBOewB3gOEQ3BmOkPmeCpBlaX6kNOY21e+4UBcuA2nWQyKuIDv320f8fprRyF/TCwpFOJMiAaowdHGmtrTLPVB17tGDnk0bRXYU2Ns+ndX9cDHzspFLMP6t61X0n+tn9Bo0f3UbuA0QFwP109X5z6LuiyfogRUBLxUm8GEb/cmtuWQklahQHP24z3BSaF022yNsw2DD/cUV0ve/OhxdRrgJgwPLnBxpMfQDBg0YKE1vHvNJ5khGlaMtOJ+SJwjVTTKA1LAkl12kyAPHgpqJgY543RYBDPjEX2eLFJcRAOUYEiXteql5BDhOGTvsRKCwyBYh6Q2NbtOV0tv/iA+a7nGfT254g1bN4wnAWdGyDIor8QyOaykfTZl7Jo5FWO2oQpS6TdzrZa1CYuWOQYAjrOXv6o=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e408ee-71ea-4ee1-0dd2-08db5c22ee07
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 06:48:49.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZMd/U54t4YTwwyUgO0qexiH21LfvPR079W8ctaFPSyrzr5oF7xPLr2jJzY6EHVCWLxKWW6QIFOwPVLrJMtWyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8425
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Reading the MID just to convert it to 'Unlisted' is quite unhelpful for a=
n info
> command.
> Due to the (constantly increasing) amount of valid MIDs it is quite unlik=
ely to
> we have it in the database already anyway.
>=20
> Thus simply always print the manufacturer ID as 0xNN and understand the
> manufacturer name as an additional information held in parenthesis.
>=20
> Signed-off-by: Enrico Jorns <ejo@pengutronix.de>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  lsmmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lsmmc.c b/lsmmc.c
> index cea43af..54c3167 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -636,10 +636,10 @@ void print_mmc_cid(struct config *config, char *cid=
)
>                 printf("\tCRC: 0x%02x\n", crc);
>         } else {
>                 if (config->mmc_ids[mid])
> -                       printf("manufacturer: '%s' 0x%01x\n",
> -                              config->mmc_ids[mid], oid);
> +                       printf("manufacturer: 0x%02x (%s) oid: 0x%01x\n",
> +                              mid, config->mmc_ids[mid], oid);
>                 else
> -                       printf("manufacturer: 'Unlisted' 0x%01x\n", oid);
> +                       printf("manufacturer: 0x%02x (Unlisted) oid:
> + 0x%01x\n", mid, oid);
>=20
>                 printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor=
);
>                 printf("serial: 0x%08x\n", psn);
> --
> 2.39.2

