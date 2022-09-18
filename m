Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7845BC32771
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Sep 2022 13:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIRNFR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Sep 2022 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIRNFQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Sep 2022 09:05:16 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2497F11174
        for <linux-mmc@vger.kernel.org>; Sun, 18 Sep 2022 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663506314; x=1695042314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ViaUNsrYfZkBY9rhZHdHRHZGQhij64ZkG01DodxtrBM=;
  b=IlXyJsKVkvFcvpo6zR5u04d721bs8UT0kzMJFu3zL5PpAufJFHTGBKfI
   aT/9u3LbPKz5jo/j1ass6WC4HFmT5rLM1QXbQ7lHR7GF/pmPPxtz6l2Mv
   dJJW28brtAvkq4SBLjEeAXulZzgbQcYCXtJK20ypo8f7JrSCU+D9yMLlM
   iPuY1CDXDBpxBcNn81tE4MgHmPI6U6V8tggNM3Ld+g0KzhRQ0J0vQQbjD
   VCU3YxxUIHI749FbnqWgHYrIYdZYgMsvPSzsGN+AoOiwdfpdFcJ0HD4X2
   mT4B2itwTFXplkahFYFiFERMGG48iHneibK1jOfz6oU2d83MFFBKaAqVl
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,325,1654531200"; 
   d="scan'208";a="323743566"
Received: from mail-mw2nam04lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2022 21:05:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0LX18SQdMw0PLTkKUdGhjRWE7m4V6UFn01gP7CwA83+c/Ufg+1pPcMOPW8/w1zV9kHT4Tjm/5VL8bW0FPkdGZSzsGhZk5cJP6i6BrcIZkXp40nXHZMtyDOJn5SMXqpj4pfPqsEBCjZ1SMgHIRjNygGgtHjKbq515aDlZjGmQ56mDmOCRf3Up+Z7zWNWXKTOmgWVy9cX6wO934VDN5wVyrtM4tvkRWRZgVf1XR2GXsj4NBWKmAAS71gDfb3SG5VB4e1vqLScJZn81rHoserDvHE+SuFYLrs3SXsFtxANGWa/d5E9dVkghi9k+mH5qrfg+8lHsQ5wyAHMZoY9aV84hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQlc9IHsuKWROLyYbD1ksKeA+y28o7hcWTU5LI0dsq8=;
 b=GBO47FupbSncr9CT0polMehBprPKKLNA+LzD3jOX9ohTZ9wYvLUbeZrWDTrr8SeQijrkdzY5kdhSvaR2/iqk6+NTOynIihj4Yj+sORTicUxbmO0cZIfQ1PgDEJd6NZCDWgTi3jmQr3WL49iPv2xx/zRfRSH5+GxIAaUfr/FRO306YA9U/PKY4zs+S19vp4Q5O9YdnGbHFhCZOGa83VOrFHug6oVBUrH81382FSs5cgmBLdEdBplHaC2KKs2345SKftMGDi+vGIDScUV4ycGFd1H0pAM6kYvBg45/92alSv27xbQ/oIgagUJxfWEEMT3T8x+cSoP68m2aFfsL/q5xMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQlc9IHsuKWROLyYbD1ksKeA+y28o7hcWTU5LI0dsq8=;
 b=HGA/0cTG5Wr+TwZ6yCwtz10Ij2GCEElA18ZwHF9zJ5QgC+FToz1hnUNLdh8NM5dhrXGGSoUwcQBv9PKucckNgxyZrFJUsbz3kR2+M5yWS6M0SXfBPvKEztitqBz5qE9FhGLCHcRa9Knug+jhHTZbTGjZl9Q0QwmuntY0WLoHGvA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7902.namprd04.prod.outlook.com (2603:10b6:a03:3bd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Sun, 18 Sep
 2022 13:05:10 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7%3]) with mapi id 15.20.5632.019; Sun, 18 Sep 2022
 13:05:10 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
CC:     "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] mmc-utils: mmc_cmds.c: fix warning on uninitialized
 'cnt'
Thread-Topic: [PATCH v2] mmc-utils: mmc_cmds.c: fix warning on uninitialized
 'cnt'
Thread-Index: AQHYy1wW4gq/uX4+2E6KavAZzPS/ga3lJg3A
Date:   Sun, 18 Sep 2022 13:05:10 +0000
Message-ID: <DM6PR04MB6575419E8BFAF47BF81E96C8FC4A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <DM6PR04MB657537960D8614C467F6708CFC4A9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <20220918124210.1127345-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20220918124210.1127345-1-giulio.benetti@benettiengineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7902:EE_
x-ms-office365-filtering-correlation-id: 14ac5f8d-61e8-452c-c5be-08da99766b1a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eei88X+oCdLcUHr8p4XYYAm8XxluGGUnG0IKAvupb7dChnCLs+/uLs1GiANTE3x/Z+RpwLVvQa6dSFlEg7KwZhVpgIncLDaHOELr5hIWIH6A63H7JM2K513cr041uOKgfIGUb6PUZWoQ/P1uYzmN/tnpzInPUmaoatdoanDMiiwt8a6bgzsVeiBRF+vTjIM6n7tDqnQo/sj6ag1XyyfwEN3wdNs7i3xbcYhzs2pxAJIxYWWNs6LaV/gZYzqrGFSunII3KyhHo4g4REQqq+CZDrH6sfrHooJZJcDCU5jyHl73LiWG8c/8KwGJHCigCJPQx4IFHjozUaBTdYl4OZzkKNzmX9l1GW3bm9buYb+KbbpLRF9zc8VYkrhZy885iy3e+EMiEwdtyBYDpH6ExhYg2QQi/r2ezaU45YPyjwxdLA3yOWO01/Syq5VKKIwePJ3VtfaIrZaXyiLPIbT+imA87cLef2AqAJgNZvMFsLlGQrUS30QH8sNfWE11f2VRL3W7wkBlVZB+1JbPaQOW+aZ+1qq8y74NMvQkQgd7MIvaRSBy1YDLR+JRquc31cLk0tXjlyyxMqCLTGXD+UKy6rJC8HperHLaoo0VZxap5nf+khYKd6irA7azDFX8n20+tI1E/n9dHP8Rujw21O5qXmBABBiJ2LkfLE3uHHSxZ7ixVFLn/5P23kgVo9PcybHttqJn08B+GuRR8EWsRKL4UoT6u6dtFRDUoyLgkoS48Y0bdtPKWMtnRvk98ZHKBKM/g0IbhnB2G2+erkr5xbHjlJTwPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199015)(8936002)(8676002)(64756008)(66556008)(9686003)(66476007)(55016003)(86362001)(66446008)(33656002)(82960400001)(83380400001)(5660300002)(186003)(7696005)(66946007)(6506007)(52536014)(2906002)(4744005)(26005)(4326008)(76116006)(38070700005)(41300700001)(38100700002)(478600001)(71200400001)(122000001)(316002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wApmRZaXIKN6zdogAnqmWERgFiFgLKFRNx/6Hns8AVSf4AugXsAbtoil4xhd?=
 =?us-ascii?Q?6qP+JVSOWU3WDCrCaAUPbEzEbHLzAgqvIoKvyT8e3pQ6N6t6B3YX/VoPJfQP?=
 =?us-ascii?Q?mFgpUENkGHijiWxI6n56nAibjS/rPVY+d5P2QLcrfaTOB1YadwwHfyGR5Jgv?=
 =?us-ascii?Q?O66EaDU3HM6wTzN7bYq0YEwmp8CCbgEgHcNOLqal1dMR9w5s3oeKqXSo6Yy1?=
 =?us-ascii?Q?46LMGlRJvAW40/hJv3Ut8+Q44j1HTqbYOBDh3tg7MNIq8nl+FnAaWnhf4a4u?=
 =?us-ascii?Q?7IH+LFjMANOpZ0S6JYwFeYeSeWDISP30khOjGwJ9rFlbwM2lTDcO4uWgaTtN?=
 =?us-ascii?Q?7B1SE9Ki5ny8QqEy/DW234e/aB2PZIBLv2+mRs0+MTnw60c4syKr0jmbA6FH?=
 =?us-ascii?Q?jLrl+i7OveKW9nqv4q0fngFp7obaGudwOis2mo2k3NJ3TjGlASPEVvZOSnS4?=
 =?us-ascii?Q?LHn3KjfhvrYgSWGI3w+Bug1YrE8j5nPFN+MRAc/P+hNoezCJXMju0WrrQWV9?=
 =?us-ascii?Q?JrFANZcxH49saQqsjyPdrGXZGYJu5DLvoTtCkSLtDFor5boEjH68Bcu5bFsd?=
 =?us-ascii?Q?fqkOudu8NLFAR0+j6c79kBYfp/R/UxRYZAZH0DDLdZ3N+Sr0FlfsiNVnGtSv?=
 =?us-ascii?Q?rnZnQp8lEES5wXmW543uMT2i8KekPd4tVf2Y403PI/aDczRzX4Uwv/ERP8NU?=
 =?us-ascii?Q?NI9+Q6/AnOHwH+2TB6urht/yXc9YlaPpd7WJofImzP/8sNhs12RiB6qBlikc?=
 =?us-ascii?Q?626M8OE0PeCCjC+8GPEpQ6bgu16n2bFH6sqc+n7QKMgR/X0vNUb22z1ZsVJp?=
 =?us-ascii?Q?k7C3qJZoVkUgkYlDPqU9lzaW/5726cjUPKiHRcnvRG+2jzhsHeaMI/ceWJ79?=
 =?us-ascii?Q?07Bpf+0USvVT99crJm6lpdhp90bY9G3XF82WTi5LyzaWagIUfXAZoezhv7Kj?=
 =?us-ascii?Q?js3AEBSdP8NrsTBqIcNH/BoIgWSRnTV0Rg8i+yM+CCein8MaM3kPo4k4CSOy?=
 =?us-ascii?Q?1oXFNmvDGjAAoEV9XI3Ljhy6M0UDDylfOcbJMC3j+SmS0toBOOByCw/yoMoH?=
 =?us-ascii?Q?kvbSMBmgaXpTy47OSXt01/n3YmfCARAiIHgdsj8nBw3An8xwZc8aLro9CWXc?=
 =?us-ascii?Q?SDn3rLTckfE0x7Xw948YPNH8PgMMPmEr2xkkvCpjWHJ3erwzg3DVw2PVuLOW?=
 =?us-ascii?Q?6fsH7KAquBSSKSxg8doh6uqE/J7+C0bgeCgcV8An/oMtxatzBtIO1f1av7rB?=
 =?us-ascii?Q?Kj/CliLqhL6ICkxy3DzdMeWSHXlU0b7AidIMvRBIuOPfoX4zskDH9ePNdMDC?=
 =?us-ascii?Q?BPpd4O/5mEU/eI6XZtDZcrVwHKg7MPKb+jnlShcBoNFd9xeNOrT640hCSrDC?=
 =?us-ascii?Q?h7DZomngTcx+10bqdyPsnaV6o8IB5plInQVVUjxmY5xPyaqd5GL+8huOfi/M?=
 =?us-ascii?Q?UNhQL6/NRsr6NHBlDa7gfZDgi8YBYoHeORdBg0MkWcIucYP8OSxdPXoDFqRY?=
 =?us-ascii?Q?CyWaaBWJcewGoACiPM8A6FgGaoKL8v7j5Yg6v0InU6qVcSO7dJKGdIGuwB8Q?=
 =?us-ascii?Q?IPdVYLqLdocJshzp/huIwDpfRb4dyXafjaVutl4u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ac5f8d-61e8-452c-c5be-08da99766b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2022 13:05:10.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JOrIGbgPqYC5Hd61KYxN0nRHzxNKqXGvoRkXLv/3p63rUVjpuqIeM4opRf50lQbcScxvMti3EUy9+jfqXHKjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7902
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

You forgot to include your commit log.
Also no need to include the module name - just mmc-utils: fix warning on un=
initialized 'cnt'

Please feel free to add my reviewed-by once you do.

Thanks,
Avri

>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
> V1->V2:
> * prefix subjet with 'mmc-utils:' as pointed by Avri Altman
> ---
>  mmc_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 12b7802..777d649 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2436,7 +2436,7 @@ int do_rpmb_write_block(int nargs, char **argv)
>         int ret, dev_fd, key_fd, data_fd;
>         unsigned char key[32];
>         uint16_t addr;
> -       unsigned int cnt;
> +       unsigned int cnt =3D 0;
>         struct rpmb_frame frame_in =3D {
>                 .req_resp    =3D htobe16(MMC_RPMB_WRITE),
>                 .block_count =3D htobe16(1)
> --
> 2.34.1

