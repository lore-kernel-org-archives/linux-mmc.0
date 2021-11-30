Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AD2C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Nov 2021 07:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbhK3HqE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Nov 2021 02:46:04 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:12559 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbhK3HqD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2021 02:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638258163; x=1669794163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ybllfgVjyd8QK+22eXF3pZGIXczrqlVBrMQfbSlirQU=;
  b=mfBH+dwIVWysEiTVkWRoNtLEmWjjFxl4zKOz5Ng3kuZon4GI301I1DB5
   6b2p02qLkng3tYhuOreJlnsYJAMpAvCW3Ug/2uMgcVtEY6+zKJKDlfspn
   NmMD2UsLYkz6AbJamQVXIqaXLEfYDIJPpe15SAiHGVwJ9byFciCgpvT2p
   y/CjLm3iBIodqhhcUv6htVxqJbjoZWR2AQWmchnWQNNAXKcz0NvMMDoel
   gGZUyQVnmAdMwKOpidk6m5BryF5QC7UCN4rTtgMUlmtVjVvfBg71pml0M
   NPmskKJACw8zZgTNwbn+GUAF5nw65hpkAvcUeMeMQLAHktRNsGLt94UNK
   g==;
X-IronPort-AV: E=Sophos;i="5.87,275,1631548800"; 
   d="scan'208";a="191818907"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2021 15:42:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReI8o0rVl5ugkNCpwocVhFe0NtgJvF/LqBpmHUxG0MtzUEPNFMasvGJV7GoYdUCPpWwy0vWtJtEFWxyWnq+ECtLQiGfCTJvETsUuCbIzIJQO0o5UI3ierlnRErV6Vb5c2pLtAWHtFUtty1TkarB9vCLjumXVn7KkQ0bmecydYo6lhUaaz1jUdtH/jNwdpSbGPEELiPewnzi2YGoAgQ5JhHWGC+lsIoXMlqiscDEb66W2wVm4oqdFiel+7qDmyteBQM8cAMBG6uvEBwmMy2gyDTvxZp3BPKFA4pnwBXuM1SdehbY/bL7jvaX/6w7e3phF4Njai1YMk5XBR/OxPtEU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igL8cx09U+YMgtO5UKILG9NeLXJh5yF82b3iIW0LPBI=;
 b=RLhz5sYPU14ViVLEeI92Jj2EL9+X77SnOA9oZOHQris812USRIRRPPnMrZ7RNclnO2Z2fuUPkdMJ3rs0Tq7xPnLKJ2SXMCkDCfu4LNiWJ/fzQpOfaVbTmts/6efVdKYsoZ2uJgiCAKlgelaOM8oaWEPrsDuP7enzP0Pi8ezC2CIjjknB0XQYbLAUw/+6Ti88XCtLm+h/+B7fVsAkOrrtgKWHFYyYQsH72ozApVI3KF2tMUqeuxy2g0onT43oM8J7f9VJd6zgNBWB6dAWQN55jyasu6kunN/P8GzOvq4KS4Y+3xHL+2pwgAb708ueXes70JoFT7OM4FtxcySbYv/MYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igL8cx09U+YMgtO5UKILG9NeLXJh5yF82b3iIW0LPBI=;
 b=UNMgJ5lsQrSK1pVcYgAC6LCD6/mqaUUIa28O+SjLmfsjzXUsOSWZ+sc77gmradi2wf1odhCqaTHCpe1looaOrE+JFlVoT+cFxjrtzMaYH0sxy4VPMAG8a48c7iJTbD0mywk7chX9zuEWr8e+QsnwU+71pkoFJdYOpmxC25Rs+3k=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5820.namprd04.prod.outlook.com (2603:10b6:5:167::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Tue, 30 Nov 2021 07:42:42 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::e42a:f71d:aab2:59c9]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::e42a:f71d:aab2:59c9%3]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 07:42:42 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Oleh Kravchenko <oleg@kaa.org.ua>,
        Chris Ball <chrisball@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>
CC:     Bean Huo <beanhuo@micron.com>
Subject: RE: [PATCH v4] mmc-utils: Use printf() to extract and print fw
 version
Thread-Topic: [PATCH v4] mmc-utils: Use printf() to extract and print fw
 version
Thread-Index: AQHX5TiVRd1bztH+Yk+Rqwk6Em6/76wbrvnQ
Date:   Tue, 30 Nov 2021 07:42:42 +0000
Message-ID: <DM6PR04MB657569E423F95B4151E56C80FC679@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20211116105109.3830-1-oleg@kaa.org.ua>
 <20211129154826.23595-1-oleg@kaa.org.ua>
In-Reply-To: <20211129154826.23595-1-oleg@kaa.org.ua>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a53de258-0f93-4d68-085e-08d9b3d4fe14
x-ms-traffictypediagnostic: DM6PR04MB5820:
x-microsoft-antispam-prvs: <DM6PR04MB582061DAF5C20057F6D84859FC679@DM6PR04MB5820.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a5dFqjvVbRH14SRjUTdRM12kQ+G9v32664kLFXx3YgVIKlSsfi9CmvFuWr0EgcCiyWH9Sfb9KDB9Q+1tSq51MQ86nGqbcb5CRcd67I4Nherp4SImpX7sxRYyP9/B8xXcRh5feEbkhGwzN086p9fe1A5vRPz5bX0fM+qJLsZBtOzVp7bMcJB6i689c33HcDXBB8qNdeWpZqxXtkPaR0hSD4AWGcH+vEYtWb/I0xhEs0JGPFsOyOUYhbm03iPusvK8DVMXFjA6iSrUVCvrPLgjBsgXCVYBASfoel7b/tYhMdZMP9T/ah2YjAWwrCAvPACQ2S9n6Xwx4Wb9Je146p8CR9sU9sDMgaWEtAiOWgpFmaGr32jR7B7wYO3krFiBNaEHQxx+oJbIIFC+TVJ6Gkww1+bXu+JMCtyYfK1XYIRB4K2tk18q5n7XVwziBW7ruOFxQ51wIYGteP9CPy7w98bV090GkMEBKTlk9YfGYTEIi8CPeCZfbulSH9UVBWh8uPkYn/aKrD3M4QGSaYGcUmSHRJyi38TaS+3qlp7b1SfoC/GMnMZwW8ChZfysE3b4e6VugshWdR+JzrZLSsVc1CDWrdhNy05ZwlxVoLCDNVz4OD9A2ftNT92NnvJdajv+Ve6bQQYsyiRhD/wl3zaVralQTlQetUAJY8C/K9VxeJvVJr+L8LRLyPD1xxC6bpIWMplxUUh80Od5+16LS7NZiYVjV5SeyumxvkWyDbuTW2QSoPYU57mMdD45vIuPbYNC3ywZBtf2yxSlux/jb3XDmHmYs86UkIvZ17FdRsihHH24ouI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(966005)(508600001)(122000001)(8936002)(38070700005)(26005)(86362001)(7696005)(2906002)(82960400001)(83380400001)(186003)(316002)(71200400001)(5660300002)(55016003)(52536014)(110136005)(66556008)(76116006)(66946007)(66476007)(66446008)(8676002)(64756008)(6506007)(4326008)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2F6kxurdEc9nsgsMwsqCpnjPunZ4yfm6ucuDWOBaDFvSczVeI/jFo8HpaSYu?=
 =?us-ascii?Q?gL9UNIwtRJYocmWdpQJZUd+AmRFVoqrH748+OKM/tFhDQSonT9L9O9cYbDEa?=
 =?us-ascii?Q?CdwiM0JKT2vgu5kS5pdtsOkgCtGvrz65GWkB8hmkyJ71MZ3AvDZGS2qXWR9T?=
 =?us-ascii?Q?g+7EldeR4cH691zfoHYzSgGhK7Msl0WhX/lqrWRQ5IoiW6aG1mHZ5/QzIYMQ?=
 =?us-ascii?Q?xha9pGlPpl6jpe0f0COgeTVKIEX4pjjyiW8wItXhX0Q+mD8/AGclC6XWN3D9?=
 =?us-ascii?Q?p25FmEdlVbPr+ZYtUuy6sgSMJfqEzSQnI9O6Y3SuhJvFoHVICuGZL9mdeF03?=
 =?us-ascii?Q?VOi+0yU2fmYw0hSGgckaNFzqyDs+WebAcQYvV7aVpZoVEPS8EIT2UPWmKsDx?=
 =?us-ascii?Q?J6I6WGBRh1aOO2haaxSxUhCo65Ymh/Ru9z6Ole0dJcYKkjXUTArpO/EBehyA?=
 =?us-ascii?Q?E3ag+bm+zBr8oIfnn+jIh6KTqh9AcA2MrIxBRE31fBY3UjiPKAxg1e/sJWll?=
 =?us-ascii?Q?AM9A9xABZpVGWzsnAxY0tsabveST1T3wP1N8/BwV3ZqZmcEL0OASjv8CxP/O?=
 =?us-ascii?Q?wDYseUZak2JRGh0L49ocm2CZSp1guDW1gjR11xSue2OTogMFuDCQnNuWAHBN?=
 =?us-ascii?Q?OQDv78ke2mIml7jMDfWm7aqXMW/sAzI6Cw+zj2IV/Lieg83TeQAbKrbHf4kx?=
 =?us-ascii?Q?Jh2o7bu6sTKEJx6WzOYO+4DYfh/klutAptpdfqElsa/ku3BJ4R1JZ4TTaAQH?=
 =?us-ascii?Q?rWRv982pGDaDJKw/PirYkWR+7J+nCakk+lKU2SEiBE128/JJLYSggU68G5dU?=
 =?us-ascii?Q?A8igMG8LiA62dF7jGlD+yqq3iY09O8PvjGuZmW7VUctRm3I6xmKJx2OpCctx?=
 =?us-ascii?Q?vSPzFml2Ab4tmJdW1gbIqzaiBMIIZRMPACesCtsG4O3SeOs31ubvt1jLI4BV?=
 =?us-ascii?Q?L3kiU71TCPg++IMvKagdc823ktHdVfWU+XgDQKub+mRB0+VnbaemN6VpVFND?=
 =?us-ascii?Q?diYAFbT706Y35B/8ARQ1zGgOFBbX312LU0DHG9R6SLdh/OtQzvmSbcTHC3g2?=
 =?us-ascii?Q?hjafagpYzRescDLuxcZACvEGBT/q6GqJxRPeAVlySf0+U8f6dFWnoEyK8hoH?=
 =?us-ascii?Q?aqH/OtZO76KTriKGzbzXFOK/dHB2VEx4ZedTpeHCLTdEx8Jhu0B/MkskyeTw?=
 =?us-ascii?Q?OwvCbLlE3/rXov6blGcR886QTTZ1yUX38FhxJwTzCFPEtH4Fsal6xSbBajUb?=
 =?us-ascii?Q?kCtszByZ92s9w3L+SzdHroadybK3S7wE8oOQ9kpU3oWxxQLNortQL0UOjDGI?=
 =?us-ascii?Q?6t6BaVMjkm7tMVJTs6KUUxkLkog8FCE42Inj/K4Zyd7N7I/FyJ+XEXh42+eD?=
 =?us-ascii?Q?rHHzQ8C/kvusIB+S9IDznR0xZt9NcUPsEU1b6ogx1p524BzHgIrcmIoyzQ2U?=
 =?us-ascii?Q?uI1ubhxPN1uGHmpO+0t3CIpOoOoyZ/bV5j2snenoruacrrzfiDdNiBmPcZdt?=
 =?us-ascii?Q?OK0sw4olKFJ76HxPz1WMfbsa2Egk2GdZwuwofxgIdw7mUrMcasHgnRxpj2ur?=
 =?us-ascii?Q?hnASTBHnym4rXeK16qGTG88EtKCqjyysS9etfjZX60DctvM+FHT7NI2PkFvp?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53de258-0f93-4d68-085e-08d9b3d4fe14
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 07:42:42.4998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ues0H2xj4UBHY2AbEze4HyhJZWxtg7JWr18S/Fu3CX3NeIOHbB0zsL2JSzPsGGknHa0zSdgcgS3w+WS0au2DJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5820
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,
>=20
> This patch also fixes a compile error with a newer version of GCC:
> error: '__builtin_strncpy' output may be truncated copying 8 bytes from a
> string of length 511 [-Werror=3Dstringop-truncation]
You are reverting commit 0eea71e4f2 (mmc-utils: Fix for Firmware Version st=
ring printing).
Please use git revert and add an explanation in your commit log.

You might also would like to take a look at the correspondence concerning a=
 different approach to the same issue here - https://lore.kernel.org/lkml/2=
0211114204331.39555-2-huobean@gmail.com/

Thanks,
Avri

>=20
> Signed-off-by: Oleh Kravchenko <oleg@kaa.org.ua>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> ---
>  mmc_cmds.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> PATCH v4
> Update commit message.
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 73bd32a..e07ec94 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1392,7 +1392,6 @@ int do_read_extcsd(int nargs, char **argv)
>         __u32 regl;
>         int fd, ret;
>         char *device;
> -       char lbuf[10];
>         const char *str;
>=20
>         if (nargs !=3D 2) {
> @@ -1834,9 +1833,7 @@ int do_read_extcsd(int nargs, char **argv)
>         }
>=20
>         if (ext_csd_rev >=3D 7) {
> -                memset(lbuf, 0, sizeof(lbuf));
> -               strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], =
8);
> -               printf("eMMC Firmware Version: %s\n", lbuf);
> +               printf("eMMC Firmware Version: %.8s\n",
> + (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
>                 printf("eMMC Life Time Estimation A
> [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
>                         ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
>                 printf("eMMC Life Time Estimation B
> [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
> --
> 2.32.0

