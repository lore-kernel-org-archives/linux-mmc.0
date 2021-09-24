Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE3EC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 19:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B65610CB
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 19:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbhIXTZ2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:25:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15399 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbhIXTZ1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2021 15:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632511434; x=1664047434;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=CWs1csaab69yZfLyFJso7PqQgEwlwrhyVfgqfKUPyhI=;
  b=ACokYfYgaqRUhHdVtAYVhvtcN6m34eBXgLC6JKh07yAQWaJ7xw184Vr6
   hj2If4p958WCPMIUhdPMviaHJkXcnNwn15PBIvBgImG0Al9sGkLmd137w
   P5V2IR0u4rMG3N26QJ5P2p1A8/LK2Clg0jU4ucj1lo4sdjNyUvUbmA5kC
   tOZyJYi6YoRdDCThSTB6mNKGnbTcFCJZMmjkDXPzlioZDhYJUjYQ9MF+c
   CIliUWRCN+nLbfks91NyyQSs51XBlAZzJdc83GdhiT8ukuHKEPv7NkO88
   7oLIvcG8TQ1frRZ7N7y1btvfhpomGTXNvvX8o1JC+5TIm99S2G0gzSIrG
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,320,1624291200"; 
   d="scan'208";a="284695974"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2021 03:23:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWJ9W0Uv6VHEGn3qoCkj9AFYgwEzOmQFY69IJSLutGguddf2lvhzKD9bCVj/1qKMZmwfgAlKcxFdhhXju+pgRZb425RUM4Xetcq3BtyYTke7m2aSQLmo6Q8dvrG54UGWpHAVPDPfa2h0Aau1IB1uKXwoq2v36bBmLJz7pETJ8VEpVHCizcDJh+nRTDtsvSZ1oqrqtQiIQcuRoodn/kGchbesrBQVbSSuV356TlefYZrzcNu/kkPsXva54g2rpj7vL2fCBcbSmWgQW8XpkTqLvY2nFYEeGSZPEkDW3Xe0RuivXJVBUlqFJqQygDpnGnL4HhBuhqkh3uEE+hYIfXeIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wLFJTr4U5K9SfZ7k7uQckmEWmkgktVMng364airh7zk=;
 b=DN38XVtDGsCZDQ2GWOTOBcJ0UZqQ/LCct77S66VOi+9IrN1QJfmG4R8C/Fb0DU1Li+soV2bK10T1cSo81V8Cm20w7z59suI4bIs9t3y1ddTi0rFeKkpcIrk4wCz1voLDqnmt08Em6Ddsq+lok9uGuMhLB5SSX2o4RHqxc1Y454Xx7D1E+RjZQvfbJak1kmsBqHePuO96OrKm3+6yIfDHhJ8s8QB1tFe+fqFOgJTAEatIt48AmVEdDc6mpBZyCqgz2crCFl8qfcypoJVC/mip6slFuWEU9aE2JTFI+KcG53QeiI0/jWEhs01lDgr7HsT3tCSx+HcG7IG9fUGYarCAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLFJTr4U5K9SfZ7k7uQckmEWmkgktVMng364airh7zk=;
 b=as2Npg4XDjakprF7yz6Kqr6NBUbTJhjNO1ooWSAMHGtdtEwm+Cm/4iRx0lLQIZhs5FBUN2uY54Fh+HpstfXE6IFGtrZZRDBft9HXIP2tSmJ2B3o0Y7gntbpbkru82X3ilzmLpDMbcgI9PwpG+a3dw6NrPvzraVA8NgIUngSqHWo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR04MB0861.namprd04.prod.outlook.com (2603:10b6:3:fa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Fri, 24 Sep 2021 19:23:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59%4]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 19:23:52 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Michael Heimpold <mhei@heimpold.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v3] mmc-utils: One further optimization of trimming
 routine
Thread-Topic: [PATCH v3] mmc-utils: One further optimization of trimming
 routine
Thread-Index: AQHXrlo9n9CRqSpXlkiY8aXWwjUThKuzlosg
Date:   Fri, 24 Sep 2021 19:23:52 +0000
Message-ID: <DM6PR04MB6575735AD7DCEC10236BDDA7FCA49@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210920194633.814-1-mhei@heimpold.de>
In-Reply-To: <20210920194633.814-1-mhei@heimpold.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: heimpold.de; dkim=none (message not signed)
 header.d=none;heimpold.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4c05dd6-44a6-4574-d3f1-08d97f90d7e2
x-ms-traffictypediagnostic: DM5PR04MB0861:
x-microsoft-antispam-prvs: <DM5PR04MB086149FE52E18B240E4D7428FCA49@DM5PR04MB0861.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ktu1hz0diZ9GgdXJh9bM6f3tBMbcLSTjPHQfuaB7A2PDIF/o1CCt6HuLWrIjxrqtOdXX/x++GYhCxjVF+hn/VirCLA1RxP0n27ZHq+GMC4tAUpjBaXcuPvHlyjI4dj27eMz+KuDOGH3P63q06BqC/5//SebrYjhNUyqbNdPJct1cc87HEQ10EDAqN/2Vb615HUsGgnVWS9DtY8G+bsrRJxcHBnNkFVP7NSomefJmp53AcZgFyt/F2Gzl/e5ASwlojdoxF1XAFDLLQUOxYdb9CFqMOzm/m66/eaDjXzK4v7+Zws1Qzmcs3tG5EzkV9IobfWjVxmomDa2xNP0AVbnwBENcZ/Dv6daifZhIiu46VEkFZEE+2+nuZqOGf84sppII/b619V2UqSN+oZlq058dSBUCAN6AUic0Sba4o/vL0x8+iBdMoDqqKjCpS9qZZ1pP530eMvcXtIs0XuO9GjbtDNqrYQsJ/dEBjq+hAnC9NnLZTMlWLWsTYTECYK77n62TMcK5UiieoRFKqlZlvDoQHN5XYzli+byfOU6v3c40LcFaJ2XAKjJ3wZOe82+BNprvb3G6mPiLs/yUqE1DJBNzoGt58VCD6wOyoh76xbKjuaQCAcjlX8mJmTp7exYpHrVq4MctdkW8Ye9H4RVYihG0NmBqMvm76EVT5eimS7KzWR+USyVb9SaL/Cnr5O4Hg7VbgZrJWPE0YOt4dhkVf7mOkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(83380400001)(110136005)(186003)(66476007)(7696005)(76116006)(66556008)(5660300002)(122000001)(6506007)(9686003)(38100700002)(86362001)(4744005)(71200400001)(38070700005)(508600001)(8676002)(2906002)(26005)(33656002)(66446008)(55016002)(66946007)(8936002)(52536014)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fq6T37T3c17r9mvb3QwEdCX4LoeEYCDN/4V/WGuWmzv1nOkqaKRSzaReiJST?=
 =?us-ascii?Q?vm9Ist9Y4WzLeswimuJo2Qj86bby8ixG1fO0GCdHGC9EnSpQcWLXx2ASauC6?=
 =?us-ascii?Q?366pY/hLxzA6vB/dMsrgCNhTatCkWMHJhmbm+mBkcMuI1eJsDpbbj/Ofi0NO?=
 =?us-ascii?Q?ALPFyG3+Xoucb3ofAAv45gsnyF8hgsIvwMsh0nI2zlzRBTegX7lnaSW4TIQI?=
 =?us-ascii?Q?Su09KhqvvPB1wMyc9LmKFQAGXSjG7tGya0CfDpu2hgtvmhTZ4gmnP58Gue3r?=
 =?us-ascii?Q?+aqrvOXXMfciNNMlzVwLqszTi596EkhsSMpUUDAaDvrz5b4/a6+UttkFS9zu?=
 =?us-ascii?Q?PAyVoc5ZjQQp7RpNX7ihs7lMwaGagUYQ/DbbaZV9hcNzlHyMS8im+LqblB5F?=
 =?us-ascii?Q?4B97LSizMzXTLIU1JRTM0ADgafOWgx9VeyEZDrMkwXuIE4hN7UVneOzMLx1q?=
 =?us-ascii?Q?YqUZtYrjHw0a2+ECJAlKcuVTBr2fhWyxp+pZxlHrm2bxiRHhyQYfAKLwAVX/?=
 =?us-ascii?Q?2rSV/V+t3IhIjip7KMR4ZNT0eKaSZW76GtIWjhBv/eAPGM5zwfygpta1RFJR?=
 =?us-ascii?Q?yhKR/bGNQQ1vQ3tZQ/JV6vho2dShnJb02kW8ZWJRxh3mTv7UbZ4zr3FBoF4l?=
 =?us-ascii?Q?uXseyIa0E5gZc/uiwG/xpMkmQ1v2IP9QFCpmfv9MdeZGH+t/lQkHowzzZxiQ?=
 =?us-ascii?Q?uoFa99a0nrQL3uMBrjTpSZfYrwvQZhMQHE3gMq+UR8FwaQ8RHMxIN6bsuJjk?=
 =?us-ascii?Q?z6wwWg80fsZY6628T7qVuCFonceJRYbpNInEOv8ZrRM6pt6A3bZHNwJqUGe1?=
 =?us-ascii?Q?7qob7xfUl6bpDnKOf0c1PqSav9lhgPVf7DcnaYqG3noE8tcQMziQ2ZfZ0vTV?=
 =?us-ascii?Q?KWW+xKfinbUMeUm8ixZElMPFtaqrw99ZGeYzxiKHPdwxPfu78q0kJURTnKUH?=
 =?us-ascii?Q?9von55OiOi3XbxZjJuih+1dC2K8szlhLRR7KlGXI90eYJz7HsR6/fTJXjpEd?=
 =?us-ascii?Q?ZIuZAbw5Xj9EA7WPU5syB8GhNAco/35dYDWyYEfOvCNbU/OkkKLULYSa9CO4?=
 =?us-ascii?Q?OWcaoFs8E/XIknxbo6vPsLwtm//RxN9zfHusN9lfUmOhvdubIZpBmFd0A4th?=
 =?us-ascii?Q?1+XoRHuo209Th5pzaKV9D+YnfT2nocnxmegqaEgqsUc2E+xSFXz7ebWo05iy?=
 =?us-ascii?Q?NsbTllDZff9bDGLFFHzu5rZNxy8uwfANVgmksnDATsyTr5qEBjVev3ruaaBA?=
 =?us-ascii?Q?zXS6jgn9GPo/xJnE2jD8G937N/VpToMZu4nMP+r5o1myDutxtx0boGolq17f?=
 =?us-ascii?Q?lNgGpVA2t55U71fZF1BmIUkH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c05dd6-44a6-4574-d3f1-08d97f90d7e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 19:23:52.1978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9QIIa6BAbjrGw0fA0fzqyZWXDW7rtefrx43e9OeqtylrnGLLapxIVN7h/Ojm+Om0jxuq9S8vJl4M92i2YoWyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0861
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

=20
> The last change to the trimming routine made it more efficient,
> however, we can even get rid of the memmove() as we leave the
> function with strdup() anyway.
>=20
> Signed-off-by: Michael Heimpold <mhei@heimpold.de>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Avri Altman <avri.altman@wdc.com>

> ---
>=20
> While doing some house-keeping, I found this somewhat older
> patch still hanging around (v2 was sent on 2018-12-08).
> I'm just resending to check what's the current opinion
> about it :-)
>=20
>  lsmmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/lsmmc.c b/lsmmc.c
> index 06cc0b8..05d59e8 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -393,10 +393,9 @@ char *read_file(char *name)
>                 start++;
>                 len--;
>         }
> -       memmove(line, start, len);
> -       line[len] =3D '\0';
>=20
> -       return strdup(line);
> +       start[len] =3D '\0';
> +       return strdup(start);
>  }
>=20
>  /* Hexadecimal string parsing functions */
> --
> 2.17.1

