Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D900FA3740
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Oct 2022 06:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJZGru (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Oct 2022 02:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJZGrs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2022 02:47:48 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9810BB06D
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 23:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666766867; x=1698302867;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9p6hSPysyGY9QzXlWXMvLLIL/iEzgFspSMx3rrRYbhQ=;
  b=bFOPTeuWzwg1/444uVKUO5libn8dRXmKg7tKinDCkhddOauaP2+eE8CH
   t6YrllmBvWKkIK4a2s4d8LIbCEUw0p8gtxNBxbYf3Pwo4e3DKoGCLpmb5
   6NJLGmXqImz+ba+AjqrOK3JiUDwCBUJoMHILKg9G2BrryXwQ6FgTDVG40
   E0SJ+Cq+djA+4T5phV4bmZls1jbyc/jE2YzKIWMqT36D8AA4zGjxzWyoN
   bwQUyzdHG1MU7FMVIE8iFzE20bFSpZ39Nrd9stY7Kuy/WYhrtSF3O5vl/
   NeTceY237LlcQBu4thR1QA+CkQfepnhgBeeT4EbEnkvAtlXQSBew0kTB0
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,213,1661788800"; 
   d="scan'208";a="319086109"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2022 14:47:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zhckm9LjwwGqQ6jW0X+TrzPR4ONfJeuDzqI8+iqbkusFFzOoWDKqzTuPnKJFA9TgCi3a/jkQK4hwi2BxLRoN9eWMgfYOCuqMuFzW1A///512POB2m91KAZdJN9icamkm03pxzQxTDoy3WOYs67CTraife2HvVLRMnlCeyXrKNA56X9BzUqw3cusd2vADLzinBZIaldlHtch/gAtgsyZGZ5bJxDkSQFY/ZLjJAiNFmcdNeSFcrPz08CbqYLEq5x06g5O2puICbmmY15eFaHJyL8YVwL57HbNrH3V7U2aVZn3eZp7uM0tv3LLArGp3UISQxhqudlxy4l1IYcEjgeCXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU4rMIbD6NSn1xsPFS15E363WzfeA3i+PD/EfIPiqkI=;
 b=gzxezuua6JYB9ifzpNBGV7HgyDf38b0s+dyyBf/T8cn4KDtGR1tihqDJhEI0qnZFBxlYp62Nw5Fn5gRhMFCflFDGkGKP/0Vw3Xg4BQwBIDivGl25xZo4xAVnW7ZhDUPRO7IXY81NEPb/TJnPD6nYkY4RLagod6K6cehK5Wu76Y/bCYeTnibIJ9vAJosjBHGa9F4T7ewB5a3MTkeyYmvJ3rcj70QxvQf/ZHLcMGSLcaG2z6pM7eiPpPU5PrA/qMJXnZWbYdmGCM1sTuh7yVRx3A0mUqv2uFEw7QN6bV3EIWzetYxaYlb686Rr2dBwE59pifvMFpxAXJjcEByRITh4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU4rMIbD6NSn1xsPFS15E363WzfeA3i+PD/EfIPiqkI=;
 b=c0foOtXmvJ1+ceg93a5oj7r3mCOBbUQ8ZmybXV5DDmqeM1jRHzqc6pnemroc0bp2gXZvJLp+naKotZmq1TnounbKql9m5nulkMtlhGdyqrYV1t9nUrs+chX10+K1go6/5Vuch5jmpBd8YZfaJcAgyO8OQlMmZAnWTAouQrYT9BU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB8372.namprd04.prod.outlook.com (2603:10b6:510:f3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Wed, 26 Oct 2022 06:47:42 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5746.025; Wed, 26 Oct 2022
 06:47:42 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCHv2] mmc-utils: Implement alternative boot operation
Thread-Topic: [PATCHv2] mmc-utils: Implement alternative boot operation
Thread-Index: AdjorSj2mV2UKSdoTC2L2EHef1IaSwAVfldg
Date:   Wed, 26 Oct 2022 06:47:42 +0000
Message-ID: <DM6PR04MB65758545BDF585D9E62EEBEFFC309@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <660600d1ad5949cea4fc3088a16af634@hyperstone.com>
In-Reply-To: <660600d1ad5949cea4fc3088a16af634@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB8372:EE_
x-ms-office365-filtering-correlation-id: eac1d7b3-07a2-4986-ae66-08dab71dfb40
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ciAxB+FBEdL08wTjclR/UclFOOLnUiVSKJQH5NUPKVUq/8pwwsZU1QBfUlDA63l+i5KfUwG61HKYO5VJgRwUJusCRKfRkbKoFQCm3FO0AXCQ7EFMryUHbfXARNqjFO0cnowmZOJ9+CdzgUFxoyqG4HMcjAMxIiIAEpq5klGinjetjUKNpKHGV2589Z7KpGpOg4Mf9jUy+jZ1po3iDoUjDIkTgXjHsTFBzfgl/bTgZ3fwEDe0EDtJ47yzGKaniQuIaGsbYgzh/jlh5rgdcQUckVToUeyeYm+hBi2qMHpw8/ya+HfRZJ96M6pQKJjLQNQolNAGhLywOjTZnm0mOy784/SENRiV5iiGZVuULVbf/L3mgPuCBFIBzUI5YkC9hxP/t/zbDowrbfzzt/NazcoExfx9uS+GhapEyzIE3aQ6qjep9AtnacZnqPpcVL9UnBYue6bn7tStPjXy38ybT41T1jI7ZWw+jQm6TGVnDN6lJt8iFRDYVgJHawFw/R7NQVpzzUSCHHOmkLaU/SlRnDr/K0A9dS6ktpgbKa15Mw6myR/9yisrkogMewKcVG/fM+qnxkC5sauyk+/yZysqYp4+gdOfSxykZ+UqqX0kinmz16kQdBqdFFYdmYjUryM3SdFa1wONaaj0fqJ+rse5T46UfbauF2Lpxl/M3HCbxjvS+k2BtK1xdDeS59Wz5VKO23cQjFhDAT/XEFyDXPiES1RlGlu1M1BhoAs/Hv3Gy9c6ahQ7UuyLfBRfnMhR2LjcjE+ojO650nthHWAFtHjTn6Bz1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199015)(7696005)(186003)(6506007)(9686003)(26005)(83380400001)(2906002)(55016003)(66476007)(110136005)(478600001)(316002)(71200400001)(66446008)(5660300002)(66946007)(76116006)(64756008)(66556008)(52536014)(8936002)(41300700001)(8676002)(86362001)(33656002)(38100700002)(82960400001)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lFMHCoJ78NvUJ6EquC427WemyNm/rvi+qSAnr1gq/xVCshr5UG7cvgdP5M?=
 =?iso-8859-1?Q?aDgFS/FpXHs7GA2kObmO3FBzSM6wvBX6H4iEAQYx8qkEIaWEmwthEFgsL2?=
 =?iso-8859-1?Q?tJb4z6QLQWqDEEkzTl2ZjDobcBOL7aZk4gkuEyjAZVFyP17FaO1ui71K/h?=
 =?iso-8859-1?Q?ekHChFD2OCxBMt22BYpXE1Fwh6JzloOkxSsjVDMbW30zmJpgwhowSeVv07?=
 =?iso-8859-1?Q?cacnkeA7KeW7VCE+MTstyxVYibKY0Tn5ZYz6UYVGwJ4M/7c+euypVKn8Gg?=
 =?iso-8859-1?Q?o3Jdl1QX+njsHN2L11KwRujkkO9sAoij18wB6++u+B8sZ7sTMYtju02n9n?=
 =?iso-8859-1?Q?WozV+zMmn1wt4XD4vfwH+znrb9LzXfJB9qAi5fIQ3XOACDAeMgc6es4MmW?=
 =?iso-8859-1?Q?VWYfl6ACm8a2/aQscJFFGdMl6OeXlNtXt65c+J7a9t2I7ki6SZK737WtQV?=
 =?iso-8859-1?Q?UlL5wVLl8uoeNsgRgugoiXowl8si7bBvQYQW2ZkxdlXPj2aqJ3pU6rj4UE?=
 =?iso-8859-1?Q?ykdSd/lux2pl90p7UFa/xgGvAuYZyqupEZQs9dRClXUYhz+8vliTKCyfxe?=
 =?iso-8859-1?Q?FO7p1Qe7/w4hfJ4mpr9ensIcRoAFjC7t6KbVPEbrX/b2+uVwcZHBuy7UtE?=
 =?iso-8859-1?Q?4ZjxnUSEMjgchDfom4TxuOe054Y1z5wXFai8VJAOmrAbwdQd4rjgFM0Yvg?=
 =?iso-8859-1?Q?8XbGKZlmcCI4mFWHlq8insvNFSYdU3LlPZuVYqfIPy04EtccJYbZutRr1j?=
 =?iso-8859-1?Q?Ghv+sLHK7PiXKkxsSEchNioww/Z1SvN4QzlSxCtRng03bW5BvIIammK7D4?=
 =?iso-8859-1?Q?9y64+GL9KUp2CM/Ej71FD+oq+d/L/biMA0iEXJ5pskdwZtcQb2/0GnZxd2?=
 =?iso-8859-1?Q?mN0egXciZeEDpelgOOkb0FlZVywVs8vLsFm9MAJVAkrQs+mRIeihw0sThJ?=
 =?iso-8859-1?Q?4HHz3xp7K1fMTB+4vLLGx0JUMITYtUjUk7wNPB6xo8PhlbPwHqOGtps/rP?=
 =?iso-8859-1?Q?wHfg0B/69algIZj6EM3UvYWgbwCXP71lHt95XNaSwlVgqM7ys4FzqIynOk?=
 =?iso-8859-1?Q?rpcFRwSG2jOvociqKs5VhuwmmYsL0h4AGrX+Xxm+BTC8Jm/WaKskcbPaDN?=
 =?iso-8859-1?Q?nXS2BBYTHtDqjL1cWaBoTWqtVHpmeq3DGVAzb/YvDv1EIZLPSG7F2gPE6j?=
 =?iso-8859-1?Q?To0FestCrvIzYLDKA3HRBwHlR+PjZaMiRZLEX2KY8FSRyYPwaOpLWCaCsY?=
 =?iso-8859-1?Q?yThYwFmyznrdXt/KJKwkShDaH0yWHzI0CyxKhzk7OitRo0jOGRtRrJ2TDR?=
 =?iso-8859-1?Q?pggxLJIVJdn8EUxtEATQmnnU9M5oF2EWeLzGBeUvcOBTms30pXcY8qHwOQ?=
 =?iso-8859-1?Q?QVAmdIzBtps9UnMOgZhnJRfrX9MzuVKBcqwwxAqL582nxf5SMxMKNy9g7U?=
 =?iso-8859-1?Q?VRdKfz6yogeCzxsYLQ2zjRuZQRFBhHNK0afV2oVW4bnd+KbBFGTM9GGl2v?=
 =?iso-8859-1?Q?eCAs19dfLy19eIOLJl8ng3cgHECMLAyGfWIBlLR34Yde+7dSFEIMcA5UDh?=
 =?iso-8859-1?Q?YlWq+5Okk3bxdPQ8GIdFGlfFbIVr+weeHDteTKApUsz+2EKoVq5DTi+8up?=
 =?iso-8859-1?Q?mtybC8EU51X0IUzOSmfwdhb9V47tAH4FpB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac1d7b3-07a2-4986-ae66-08dab71dfb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 06:47:42.3288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVo0ED3RjanWsQZo1guWvCqnvYHUEwbPvo+QF7JN4ipdyXt6WqNabgoeRGI9MF+uiKSNAMalHVWUMHYVAaSkyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8372
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Implements the alternative boot operation for eMMCs.
> Note the limitations of the help.
>=20
> This is mostly useful for testing purposes if you set
> up the boot partition configuration correctly.
>=20
> Usage:
> $ sudo dd if=3D/dev/mmcblk2boot0 of=3Dbootdatammcblk count=3D2
> 2+0 records in
> 2+0 records out
> 1024 bytes (1.0 kB, 1.0 KiB) copied, 0.00482308 s, 212 kB/s
>=20
> $ sudo ./mmc boot_operation bootdata /dev/mmcblk2
>=20
> $ diff -s bootdata bootdatammcblk
> Files bootdata and bootdatammcblk are identical
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Few nits below.  Other than that -=20
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
> -v2: Frees, closes, removal of boot_blocks parameter and boot ack check
>  mmc.c      | 12 +++++++
>  mmc.h      |  3 ++
>  mmc_cmds.c | 99
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |  1 +
>  4 files changed, 115 insertions(+)
>=20
> diff --git a/mmc.c b/mmc.c
> index 170ee39..adcd814 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -255,6 +255,18 @@ static struct Command commands[] =3D {
>           "Issues a CMD0 GO_PRE_IDLE",
>           NULL
>         },
> +       { do_alt_boot_op, -1,
> +         "boot_operation", "<boot_data_file> <device>\n"
> +         "Does the alternative boot operation and writes the specified s=
tarting
> blocks of boot data into the requested file.\n\n"
> +         "Note some limitations\n:"
> +         "1. The boot operation must be configured, e.g. for legacy spee=
d:\n"
> +         "mmc-utils bootbus set single_backward retain x8 /dev/mmcblk2\n=
"
> +         "mmc-utils bootpart enable 1 0 /dev/mmcblk2\n"
> +         "2. The MMC must currently be running at the bus mode that is
> configured for the boot operation (HS200 and HS400 not supported at
> all).\n"
> +         "3. Only up to 512K bytes of boot data will be transferred.\n"
> +         "4. The MMC will perform a soft reset, if your system cannot ha=
ndle
> that do not use the boot operation from mmc-utils.\n",
Theoretically, this shouldn't happen unless you send additional cmd0/0x0.
But I guess it's a reasonable decision for the device to make if it doesn't=
 get one, or cmd1.

> +         NULL
> +       },
>         { 0, 0, 0, 0 }
>  };
>=20
> diff --git a/mmc.h b/mmc.h
> index 6511dbc..4de0aae 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -24,6 +24,7 @@
>  #define MMC_GO_IDLE_STATE         0   /* bc                          */
>  #define MMC_GO_IDLE_STATE_ARG          0x0
>  #define MMC_GO_PRE_IDLE_STATE_ARG      0xF0F0F0F0
> +#define MMC_BOOT_INITIATION_ARG                0xFFFFFFFA
>  #define MMC_SWITCH             6       /* ac   [31:0] See below        R=
1b */
>  #define MMC_SEND_EXT_CSD       8       /* adtc                         R=
1  */
>  #define MMC_SEND_STATUS                13      /* ac   [31:16] RCA      =
  R1  */
> @@ -97,6 +98,7 @@
>  #define EXT_CSD_CACHE_SIZE_0           249
>  #define EXT_CSD_SEC_FEATURE_SUPPORT    231
>  #define EXT_CSD_BOOT_INFO              228     /* R/W */
> +#define EXT_CSD_BOOT_MULT              226     /* RO */
>  #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>  #define EXT_CSD_HC_WP_GRP_SIZE         221
>  #define EXT_CSD_SEC_COUNT_3            215
> @@ -107,6 +109,7 @@
>  #define EXT_CSD_REV                    192
>  #define EXT_CSD_BOOT_CFG               179
>  #define EXT_CSD_PART_CONFIG            179
> +#define EXT_CSD_PART_CONFIG_BOOT_ACK   (1 << 6)
Already exist - EXT_CSD_PART_CONFIG_ACC_ACK

>  #define EXT_CSD_BOOT_BUS_CONDITIONS    177
>  #define EXT_CSD_ERASE_GROUP_DEF                175
>  #define EXT_CSD_BOOT_WP_STATUS         174
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 3db17e1..b7efe5a 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -3101,3 +3101,102 @@ int do_preidle(int nargs, char **argv)
>=20
>         return 0;
>  }
> +
> +int do_alt_boot_op(int nargs, char **argv)
> +{
> +       int fd, ret, boot_data_fd;
> +       char *device, *boot_data_file;
> +       struct mmc_ioc_multi_cmd *mioc;
> +       __u8 ext_csd[512];
> +       __u8 *boot_buf;
> +       unsigned int boot_blocks, ext_csd_boot_size;
> +
> +       if (nargs !=3D 3) {
> +               fprintf(stderr, "Usage: mmc boot_op <boot_data_file>
> </path/to/mmcblkX>\n");
> +               exit(1);
> +       }
> +       boot_data_file =3D argv[1];
> +       device =3D argv[2];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open device");
> +               exit(1);
> +       }
> +
> +       ret =3D read_extcsd(fd, ext_csd);
> +       if (ret) {
> +               perror("read extcsd");
> +               goto dev_fd_close;
> +       }
> +       if ((ext_csd[EXT_CSD_PART_CONFIG] &
> EXT_CSD_PART_CONFIG_BOOT_ACK)
> +                       =3D=3D EXT_CSD_PART_CONFIG_BOOT_ACK) {
Redundant rhs?

> +               perror("Boot Ack must not be enabled");
> +               ret =3D -EINVAL;
> +               goto dev_fd_close;
> +       }
> +       ext_csd_boot_size =3D ext_csd[EXT_CSD_BOOT_MULT] * 128 * 1024;
> +       boot_blocks =3D ext_csd_boot_size / 512;
> +       if (ext_csd_boot_size > MMC_IOC_MAX_BYTES) {
> +               printf("Boot partition size is bigger than IOCTL limit, l=
imiting to
> 512K\n");
> +               boot_blocks =3D MMC_IOC_MAX_BYTES / 512;
> +       }
> +
> +       boot_data_fd =3D open(boot_data_file, O_WRONLY | O_CREAT, 0644);
> +       if (boot_data_fd < 0) {
> +               perror("open boot data file");
> +               ret =3D 1;
> +               goto boot_data_close;
> +       }
> +
> +       boot_buf =3D calloc(1, sizeof(__u8) * boot_blocks * 512);
> +       mioc =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> +                          2 * sizeof(struct mmc_ioc_cmd));
> +       if (!mioc || !boot_buf) {
> +               perror("Failed to allocate memory");
> +               ret =3D -ENOMEM;
> +               goto alloced_error;
> +       }
> +
> +       mioc->num_of_cmds =3D 2;
> +       mioc->cmds[0].opcode =3D MMC_GO_IDLE_STATE;
> +       mioc->cmds[0].arg =3D MMC_GO_PRE_IDLE_STATE_ARG;
> +       mioc->cmds[0].flags =3D MMC_RSP_NONE | MMC_CMD_AC;
> +       mioc->cmds[0].write_flag =3D 0;
> +
> +       mioc->cmds[1].opcode =3D MMC_GO_IDLE_STATE;
> +       mioc->cmds[1].arg =3D MMC_BOOT_INITIATION_ARG;
> +       mioc->cmds[1].flags =3D MMC_RSP_NONE | MMC_CMD_ADTC;
> +       mioc->cmds[1].write_flag =3D 0;
> +       mioc->cmds[1].blksz =3D 512;
> +       mioc->cmds[1].blocks =3D boot_blocks;
> +       /* Access time of boot part differs wildly, spec mandates 1s */
> +       mioc->cmds[1].data_timeout_ns =3D 2 * 1000 * 1000 * 1000;
> +       mmc_ioc_cmd_set_data(mioc->cmds[1], boot_buf);
> +
> +       ret =3D ioctl(fd, MMC_IOC_MULTI_CMD, mioc);
> +       if (ret) {
> +               perror("multi-cmd ioctl error\n");
> +               goto alloced_error;
> +       }
> +
> +       ret =3D DO_IO(write, boot_data_fd, boot_buf, boot_blocks * 512);
> +       if (ret < 0) {
> +               perror("Write error\n");
> +               goto alloced_error;
> +       }
> +       ret =3D 0;
> +
> +alloced_error:
> +       if (mioc)
> +               free(mioc);
> +       if (boot_buf)
> +               free(boot_buf);
> +boot_data_close:
> +       close(boot_data_fd);
> +dev_fd_close:
> +       close(fd);
> +       if (ret)
> +               exit(1);
> +       return 0;
> +}
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index faab362..5f2bef1 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -49,3 +49,4 @@ int do_erase(int nargs, char **argv);
>  int do_general_cmd_read(int nargs, char **argv);
>  int do_softreset(int nargs, char **argv);
>  int do_preidle(int nargs, char **argv);
> +int do_alt_boot_op(int nargs, char **argv);
> --
> 2.37.3
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

