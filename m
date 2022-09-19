Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA3DECAAD3
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Sep 2022 21:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiISVtC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Sep 2022 17:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiISVtB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2022 17:49:01 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED8B4363F
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2022 14:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663624140; x=1695160140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QpluqrnhpVThbRGq/k+JdDjI7UiA6zScieZty9TeuEw=;
  b=jceJMdTgcmHfozRNDktC2t3NAx+6QMoX4XEGgFvug8W1TVsXd8a3Iavl
   vUJE3aQOGN6cCdZnRpS80PQCtDf7Jo6eFqLQ91rLGYu3YWIkX2uzp3ylz
   w8BKrYSAReMOLHHGk3Qdsn5FuXwpQG4M7cClopTmP0guZg6We1xwyrBgU
   tMNMqCrdMGGqy5q/Bww/M7wzyNdyyeJjX9AJ2J5zjhwjyud/lWmqBNQO4
   XEpU0Go8g48JYejjTr4M0ew++fru/6Ka7GRX133Zd+kKnfqUjoVDJk8Wd
   8YPFxO78qCtYh8G2TcJTyM/dNvo0dcDDgm2ZCHyYPG1/YRFu/LgrwHe0A
   A==;
X-IronPort-AV: E=Sophos;i="5.93,328,1654531200"; 
   d="scan'208";a="323852432"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2022 05:48:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoExdrU2DjN0+ds6gR9YuqCuf4uGLCta4hLUi2I6gO6mA4wN5ekJFRIcM2tHr4b32tziuOXt8/spWhXG8cnA7R4OXuk0HY3OiTL3OackLkFB+2cwFbpMagHf0pMjgQxgGKeQO75/pjLIj3h7xC85Hw++23LtmRHQhH590mCrMSck9qLIrmh6+CpqtZ2MrTCrVkAk8wI27a5A9+0NRFU3zr44Qw81Uq1Nyxk6Xgo49dh1FfVNvBQgGw8uXsFCn4LN2m3x1XFg9AxUnvhZRYgZNFv8M2LmTxL9qG2Z/kGQJsGzOcEGOJkxLCRJ0KuVZ5m4L+HDQM6KNk7wnn48DtstJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSHU/zWTJBRz9h24gamNA9zewNahgYK7jVWRCjwAJiU=;
 b=hBncjq5udFoGpsa+GdGAknDaQJU5Sb73zkgULGDuU97kDofZ4xgDZHYyVj2B4xiUO2knHcUTPm71GTZwQY/Z/0nH+LdYC8ctG6A7+vDtLLZOgnBBeZKhk0Hjx2rtU/tkLFoVR7SfSfOP45SBj6LJEtnNLeJF6mJADRuGzS1H75CfD/N0pNRHQG/zSEg75fPrO+LWS0HBx286NsV4BbcKITyuccn6C4oYQMbgs5Y3j5TA7aeI5LNDg2OGzPa0TMDAEPIDo/ehTbFenokZZu0GQoHckj2DgXi15NBOYoUO0q5iU3Fjq5cUjnwy4B0UL9EoRD1jZX0BqeFeR08k4gFrcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSHU/zWTJBRz9h24gamNA9zewNahgYK7jVWRCjwAJiU=;
 b=c9zHsbqVBzX2sZ2ct+tSRueTxRjymtiY8yrl+txvWd2pKPHauOHOdHSMfF6vXuTcMkD/24RbQYCjd4I/0ZwcT+hoAKpuRk16EVGkrloHiflhkQXmJ9iKoGYciuzOh0U3fIysrOuJoIBE7XHneoM+BWXPnaTmioWoCbeBeA8na0w=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CY4PR04MB0345.namprd04.prod.outlook.com (2603:10b6:903:42::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Mon, 19 Sep 2022 21:48:57 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 21:48:57 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Bruno Matic <bruno.matic@nokia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "jakob.rossler@nokia.com" <jakob.rossler@nokia.com>,
        "aarne.heinonen@nokia.com" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct ffu in case of unsupported
  MODE_OPERATION_CODES
Thread-Topic: [PATCH] mmc-utils: correct ffu in case of unsupported
  MODE_OPERATION_CODES
Thread-Index: AQHYzEOVE1e8g7Sl5UmW+071XDkLu63nRp2ggAADYnA=
Date:   Mon, 19 Sep 2022 21:48:57 +0000
Message-ID: <DM6PR04MB657501FE8AC5E9937FB96AE8FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220919161852.28072-1-bruno.matic@nokia.com>
 <DM6PR04MB65754366E4FFD588A9EAEB27FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65754366E4FFD588A9EAEB27FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CY4PR04MB0345:EE_
x-ms-office365-filtering-correlation-id: a6748c2e-5ae4-49e3-b5b2-08da9a88c12f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Db7vp2068tx5xgTgCRiVFLtaWlophda6e3YrwrBtKo0XvrJlWqIyWRFf9VeL/YFVuisdSr+ecNfqBUkjbxqW+7T+D4Ma9PDhjUVKS7qYJzvbfYX89tbGNItlEcvqiLKxT1aavWTfVS4IndczWYrmFwG+5bmfFH0MDgwh+C+25sc+iZCHB0Mna9xJi9QARhdPLFjARKKaC4kpYQ+ZJpF3HRkD9r0c+80KG07nvfShNQY9rjng8WUelM8lZ4CwR6FvUzlKwpJanMbUtzk6jHBys8Z8B4Hmnb+O7qwALsniU8Ug6i6jWHjaw2jcsW4oGvx7ZGmMmkZsUa5DfnuL4a/fNypZ1SSnI77c5yy/ewraHm1f9sppgc1Aw/dFV+7xM8HV8oDHJM1d8yFBrfezx3aRHM/qeCHFApPTtHzLcG9KB82tFE8mYsux90GKEeREg2CNE2Dfabks7vH1gdEEmhBQoMCR9krrYlVgWcolh3q1hkJ2s1wZuGioB5yOMFbEBIrybp+ImZ0db8l95ORYOJgC8n/HWVbl7piHMy0XkrxNmIzCVC6Z2DvdtyB6PJycRkeIRBDCDIv32mdutOwBF9/3KXM/qI0V5AWB7hQmLRNrsL8IFLmAVgPEIiENA+ADc7RvrEKgp8q2BDlrzQ7U51fnMo5y8dxps0wVdvlNQPF1wGCbR9CURe0em3h9NrDRmf0ZeI+0fZfrDmqLopmC0riG3uUHZM/VVuDNCyPa23fh13+OJRR3EIEdRgLcqxWFpn7UXqGa3YBxyW5gExkwk2AffA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199015)(66476007)(66446008)(33656002)(122000001)(86362001)(38100700002)(38070700005)(82960400001)(55016003)(2906002)(5660300002)(478600001)(66946007)(66556008)(4326008)(64756008)(52536014)(110136005)(8676002)(8936002)(76116006)(316002)(296002)(54906003)(186003)(83380400001)(41300700001)(71200400001)(2940100002)(7696005)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kN1YQ95ezBQpsILUZ3GNna/vCYVW1WNGNd+BZ+3cGnFZVrycKH5P5GIQl5fu?=
 =?us-ascii?Q?sMEf5ODMRlj2jG58uZA6jf1wz7ER1raUGbql2/2KiKXqBdGWvQnUXgp5ihCp?=
 =?us-ascii?Q?82c3TVtT2qBwaN9AdvnpRdrbuBQGYdtcf5/qeUnEa3DVsuoAjggA07qBka9x?=
 =?us-ascii?Q?auIp1VS6oN7ukkGFnDWbVXrUqHfgh/Ow5OO006u/K4OzikvA6KXTFT3ekmHs?=
 =?us-ascii?Q?k4VaknUssFoEG6Vst/8D1cGdCROkYpAt6WyB1bhE6MBeJ9xFxwkybxmFXiZN?=
 =?us-ascii?Q?jyI2sOiSuZ0XF6LMMs6t5t906A4tlmPyBMLASOgR5XjcHFD1On/S0IafNhb+?=
 =?us-ascii?Q?rUSPPxwAspGzlKlmEK0U+cReV/2aZ1Cp+H3IE3lz5PFh69OU4Yfp//P8Sc0f?=
 =?us-ascii?Q?9GO38eHZHodW0qhz7erU3V829AKWc6iZsZpI5HNMHnO9ouWLHEAUQE7Awsoi?=
 =?us-ascii?Q?+Wekffjdlj3akTxq82Mbe05Gks0Q09mrru/6p09KLEqIN3o81N8hDqELe7Lz?=
 =?us-ascii?Q?K4lHAXJ5nJMTMGiBykFCh4GFjHoXLjp94k1RhirTohHKNEx2ZzGo8GfSaK6y?=
 =?us-ascii?Q?+FJ/gmG9KdTLR1HtCHbzihvjkeN+hNTRARsTLYOoUxqND4DfWiGdVPenI8iB?=
 =?us-ascii?Q?97D3qCSs8UxhbINb/5d6g4ijMiBmWdY3h3sCEIJ0bebOIMk+XrAizwAD2TWY?=
 =?us-ascii?Q?8cM5jtDv6FJI2h/1+UjPWpdPysa3kIwHtOT0prpRrR5ZBJGqlq4+tpwL+C3B?=
 =?us-ascii?Q?z4qhSR+6d8SRjC99MY8gSD45vJmbzlEjGsNpDkUMGUw7yyQDQG/v/1/yyj9U?=
 =?us-ascii?Q?qzU1/Ypi5D8hTsRcLuxUmpe+Vji/YumcOMwU4q7y2DLCCVYkFcg/Xdeogop0?=
 =?us-ascii?Q?EzUsQri2ciirvr5sqc2TKkMRgFE1LCkEhZ14miJ9PONmK0iNy9h2XXRuzWYY?=
 =?us-ascii?Q?NNOuCHuIen2pdO7GOIt2goSFZAJxnOucjdx2bPUeDdOQTLi7b2a+ipDf/vlg?=
 =?us-ascii?Q?hj0QcjUTFOA2bDq16vHLW+I+CPpI823325W86oAI9OgrHl/kKDNk3YjYQAvA?=
 =?us-ascii?Q?Dumbi3KqaDGDLFc2uFhb2gx4uFhtDaeREBgtrjr8NfKbaW6F/AFBW6OPZVZk?=
 =?us-ascii?Q?Ld4l6cUSCXa9vjzQyzV2/0tOghAMcVf4KvnlA3DChDaf8/TBalJ/MXo2pK9X?=
 =?us-ascii?Q?6/fXOtnfQs7q4MIEGi3GqFelt0afKBd2Wr8fL2cvtd0FQnkhn1nnJw7lBqUk?=
 =?us-ascii?Q?pYb05I4ho1j7Mqtpv6MYPcePPvXWjmdAG7t7ufxAie2SFFvlZJd+ts7dsMjt?=
 =?us-ascii?Q?0PCnfTv5IAGzBgzULVlynK89Pro6BERuxmDuuIGMjzGZtmmzyPwPJdtYUbjh?=
 =?us-ascii?Q?Np6n5M8eqBo63Heu3sPjtI2UP64+tmZJpbchVBnoNAEfm8n0h8sFyrPawwCb?=
 =?us-ascii?Q?h3LUtj6inGg/gH6sw8CqRIIlqn31NskBovl6DQgWtpadc67zc56mdZM5Ir9c?=
 =?us-ascii?Q?4Lf4/UVqYJwoMVJAs0XYjHBfAY1H/ahFeLK4jkQhHCWh8vBbgQaTw+QtyWgz?=
 =?us-ascii?Q?TCMMMxuvnFieXJ0JuW9wjYKawSefXuMx9UaH3aFN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6748c2e-5ae4-49e3-b5b2-08da9a88c12f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 21:48:57.3237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3REX2uIomoXRLvnFORTF5SOaEfZN0EK6QqZ0SLZCQpqo2Mq5QC+eVnP7bPjU9X1pO8SCQlKnk6jB9CLihxtOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0345
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>=20
> > Move up the return in case MODE_OPERATION_CODES is not supported.
> > According to the specification when MODE_OPERATION_CODES is not
> > supported no checks should be done against NUM_OF_FW_SEC_PROG.
And I wasn't able to find in your code, where you are skipping the check ag=
ainst sect_done,
In case MODE_OPERATION_CODES field is not supported.

Thanks,
Avri

> >
> > Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
> > ---
> >  mmc_cmds.c | 82
> > ++++++++++++++++++++++++++++--------------------------
> >  1 file changed, 42 insertions(+), 40 deletions(-)
> >
> > diff --git a/mmc_cmds.c b/mmc_cmds.c
> > index ef1d8c6..81fdc7e 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -2897,6 +2897,13 @@ do_retry:
> >                 goto out;
> >         }
> >
> > +       /* check mode operation for ffu install*/
> > +       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> You haven't read the ext_csd yet....
>=20
> Thanks,
> Avri
>=20
> > +               fprintf(stderr, "Please reboot to complete firmware
> > + installation on
> > %s\n", device);
> > +               ret =3D 0;
> > +               goto out;
> > +       }
> > +
> >         ret =3D read_extcsd(dev_fd, ext_csd);
> >         if (ret) {
> >                 fprintf(stderr, "Could not read EXT_CSD from %s\n",
> > device); @@ -
> > 2927,49 +2934,44 @@ do_retry:
> >                 goto out;
> >         }
> >
> > -       /* check mode operation for ffu install*/
> > -       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> > -               fprintf(stderr, "Please reboot to complete firmware ins=
tallation on
> > %s\n", device);
> > -       } else {
> > -               fprintf(stderr, "Installing firmware on %s...\n", devic=
e);
> > -               /* Re-enter ffu mode and install the firmware */
> > -               multi_cmd->num_of_cmds =3D 2;
> > -
> > -               /* set ext_csd to install mode */
> > -               multi_cmd->cmds[1].opcode =3D MMC_SWITCH;
> > -               multi_cmd->cmds[1].blksz =3D 0;
> > -               multi_cmd->cmds[1].blocks =3D 0;
> > -               multi_cmd->cmds[1].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE =
<<
> 24)
> > |
> > -                               (EXT_CSD_MODE_OPERATION_CODES << 16) |
> > -                               (EXT_CSD_FFU_INSTALL << 8) |
> > -                               EXT_CSD_CMD_SET_NORMAL;
> > -               multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_=
R1B |
> > MMC_CMD_AC;
> > -               multi_cmd->cmds[1].write_flag =3D 1;
> > -
> > -               /* send ioctl with multi-cmd */
> > -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> > +       fprintf(stderr, "Installing firmware on %s...\n", device);
> > +       /* Re-enter ffu mode and install the firmware */
> > +       multi_cmd->num_of_cmds =3D 2;
> >
> > -               if (ret) {
> > -                       perror("Multi-cmd ioctl failed setting install =
mode");
> > -                       /* In case multi-cmd ioctl failed before exitin=
g from ffu mode */
> > -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3])=
;
> > -                       goto out;
> > -               }
> > +       /* set ext_csd to install mode */
> > +       multi_cmd->cmds[1].opcode =3D MMC_SWITCH;
> > +       multi_cmd->cmds[1].blksz =3D 0;
> > +       multi_cmd->cmds[1].blocks =3D 0;
> > +       multi_cmd->cmds[1].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> > +                       (EXT_CSD_MODE_OPERATION_CODES << 16) |
> > +                       (EXT_CSD_FFU_INSTALL << 8) |
> > +                       EXT_CSD_CMD_SET_NORMAL;
> > +       multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> > MMC_CMD_AC;
> > +       multi_cmd->cmds[1].write_flag =3D 1;
> >
> > -               ret =3D read_extcsd(dev_fd, ext_csd);
> > -               if (ret) {
> > -                       fprintf(stderr, "Could not read EXT_CSD from %s=
\n", device);
> > -                       goto out;
> > -               }
> > +       /* send ioctl with multi-cmd */
> > +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> >
> > -               /* return status */
> > -               ret =3D ext_csd[EXT_CSD_FFU_STATUS];
> > -               if (ret) {
> > -                       fprintf(stderr, "%s: error %d during FFU instal=
l:\n", device, ret);
> > -                       goto out;
> > -               } else {
> > -                       fprintf(stderr, "FFU finished successfully\n");
> > -               }
> > +       if (ret) {
> > +               perror("Multi-cmd ioctl failed setting install mode");
> > +               /* In case multi-cmd ioctl failed before exiting from f=
fu mode */
> > +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> > +               goto out;
> > +       }
> > +
> > +       ret =3D read_extcsd(dev_fd, ext_csd);
> > +       if (ret) {
> > +               fprintf(stderr, "Could not read EXT_CSD from %s\n", dev=
ice);
> > +               goto out;
> > +       }
> > +
> > +       /* return status */
> > +       ret =3D ext_csd[EXT_CSD_FFU_STATUS];
> > +       if (ret) {
> > +               fprintf(stderr, "%s: error %d during FFU install:\n", d=
evice, ret);
> > +               goto out;
> > +       } else {
> > +               fprintf(stderr, "FFU finished successfully\n");
> >         }
> >
> >  out:
> > --
> > 2.29.0

