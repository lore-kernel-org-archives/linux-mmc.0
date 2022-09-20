Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0985FC54EE9
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Sep 2022 12:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiITMzu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Sep 2022 08:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiITMz2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2022 08:55:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02F186E4
        for <linux-mmc@vger.kernel.org>; Tue, 20 Sep 2022 05:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663678488; x=1695214488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OM55D65GJ21vlhPfg4Mq+ZuPC+SBGzkgFvwSqv8TuN4=;
  b=IpvTNFHLNJXZVKDm/M8hkag8d1s8bJJDMgUyRjTyZZ5HnQmRXjABT6jZ
   H18fz3wTRDKCOOoB1gY4RiJs41LOaAQ8DPxQDRLQQJokoyellrPlfZprk
   RA/tXI87lefFVvBti8udq9/f0JDwmtmPiWHn+WoEpyH71l3J1ppUow3BU
   OoCiZWsgN/dQQVf6C4m85nV5HFeFFuzz4IHaMqkXKR++TGL3uh9LEodQD
   HMyNDaBigMtqLPk+hWRBHB9QF4oE/sZhBVbfibYkfif93GYFahGOVO0Yx
   igVyizijYEXsqJNztX+FQXQM/UtB5ewCx3ffU5SPhKcOO1e1Dcv9uHmjt
   w==;
X-IronPort-AV: E=Sophos;i="5.93,330,1654531200"; 
   d="scan'208";a="323916413"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2022 20:54:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afGlq4251LQxBw20YPTxQoV7NSVfVUy1LvepXGKcRcW592yVD5NIeCkoM0eeJsaUrPQvFLW5IX9vgdvp5JwnnS1iGny4A0GzC4KjabEkmOel1AY7QEj40OMaAeoiqp3YnOiB3G+Fevl0EFlN5UWzfmjzHTax7nt5+D4l8Owl9fgSHvyF1/0BgoRWY80dEA3tOGHGGBYmkAiKixkCAOhJIrv+MVx4svr6zimtyRoVdl4OnSdLyBVBB6TcqvLOMBywDbIhOipN4WXmtSrzaU6L88i2Um37rYku1hmSneyNKZZC3R1n6gsWEPcajk4UQeQus8s0G6SwgwReVn4Fitqc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKprNuCEblKzm5ZYZcrY4mJbrI0K3hg+Dus1KWAilGE=;
 b=cN2t7bcyvknpJsR/xWjd4ums+8vfQtcsbUNdBPiwtcjM9Q+IzsgOxSoWhPU2uIxzQ9w4BKK1Aow4AtzuH1vMsdpAScVJrH2Jle5Jv1XYLHh3Oyq3CeDzIBh5omcl7K0KFl9E+m28n6mCQHeopj8q3hvnx9B4RCF/xVMmTQSGVLUoRVBbhRVIS1YTIrQhTdV79kG2AswGrKThsXCkmaEuI70I6uZ6PfNm769prM8okFckUtBQseyE07YKO81xKZrPLH4RHfEDHNAzhSfJLwzqeHYPHFhgbs4pIjIU0aWWO75eTZeZEJcBzf7voqUuuTzMF1jSOdF4Z+jBfy+48LjoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKprNuCEblKzm5ZYZcrY4mJbrI0K3hg+Dus1KWAilGE=;
 b=NWxCuWcMAc7qE/OAOumQmy/AVQ4IE6ULHf6V6rK8Po+S9WojRixtuf0XYQV+sbmubPejQ+vDiINaGCsetCxOiFeZnhi027tSKO+IRJPoEkgub1Xno79Ze9aajNEPHPiD0j9wAHXnGddMnUroFVqkU4rrFZcSIxps7BukUk1nW00=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN4PR04MB8399.namprd04.prod.outlook.com (2603:10b6:806:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Tue, 20 Sep
 2022 12:54:44 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7%3]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 12:54:43 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bruno Matic <bruno.matic@nokia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "jakob.rossler@nokia.com" <jakob.rossler@nokia.com>,
        "aarne.heinonen@nokia.com" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH v2] mmc-utils: Fix ffu in case of unsupported
 MODE_OPERATION_CODES
Thread-Topic: [PATCH v2] mmc-utils: Fix ffu in case of unsupported
 MODE_OPERATION_CODES
Thread-Index: AQHYzO9FK6xXI6BbFUGUgvDZfbLof63oRh/Q
Date:   Tue, 20 Sep 2022 12:54:43 +0000
Message-ID: <DM6PR04MB657522EA8E6540BC77D19E15FC4C9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <DM6PR04MB65750F5EE2E1C9D2CC103A64FC4C9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <20220920124749.24073-1-bruno.matic@nokia.com>
In-Reply-To: <20220920124749.24073-1-bruno.matic@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SN4PR04MB8399:EE_
x-ms-office365-filtering-correlation-id: 20e0ff17-e9cc-4c60-a42a-08da9b074a47
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7XZ7EIU6gYNa5JgpcpZ77GSrJfh70nn+wp+O8KfwCGeTumlfcARhrNnf3oNTBP+JRiHymkIYs/I77DmSkOknFM+S1FK4nU3ac0M1aRLrK5SzygO2c5yzJxUKZ58Hf60s8/wmhR2XhunVfnemuOwo014z82lwAKZBMWNhjTvC/o+tIImhG01OSLkxs/6/NNEOdakKYzWxr4NxrtOIAMKopAMxFXg67HnyXwXZNiIWK7NHKdSamfpys2CZyXYZpWDOQuU8qBw4KAxEsPDqsJsPeLMcdQ3saEcaOR3LNxZKVbIU1UWBZKIohY0hAickC+izshp0p+/0vGANxqsCFmNEqE3ZSCSYJrV5tuWoSnfwiNEN5hD8WlHWjB5x+XRDgRMXvGeNSagkQgdEbqn7QfpYX9ACh4e7/4am0JL8bzMTK/X86kjm36Weu8T1svsgyxxiHlTiSgk5iKqLaeDT8DzybZWcLQCMj8rOSGGLJZ57jSnIKKETXNQRzDGmTawrw4f0m6Lnv0G5HiFv2fVkzK8Pea+GW+JdUv1infuEvVpCgnz8p63SbhN/Ln68/q1aaWCRzuH23WbyCMyDdJJZlF1b1A22aBNHS2yF/ndseYKblQB72v86FWnpebeiDRSlM7byAxlnt5SMejCCZDCEKbYZVurSN5xdi1OGJX/zRd4fdwd67dYhiDBqWUATaYEVanfOgf1vdrtBQYDU3x57fEv/aaeIJZ0sHbjr5y03+nsUCMc4/VgF9HFW+ttKknYF5+LEPqoS3WiIxW+Al2XS2a/oUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(6506007)(478600001)(8676002)(54906003)(83380400001)(26005)(9686003)(186003)(41300700001)(5660300002)(2906002)(296002)(55016003)(64756008)(66476007)(316002)(110136005)(52536014)(66446008)(8936002)(66556008)(4326008)(71200400001)(66946007)(76116006)(7696005)(38100700002)(122000001)(33656002)(38070700005)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RModk0EmGeAtcxLrdLR7SMOGxqAqzXMuF9Ms4TcX5kY91A+UVoaQ1K7OVfYi?=
 =?us-ascii?Q?aEfy1bBcSDlBgqj84+hg1QntqGhLdWLlI/2QBH6UYV8SO9Xc+5oiCr2vJ7tm?=
 =?us-ascii?Q?Mjxe0tSzobkCIKNRLH8rodAwS1eOmNB8KNQgAQ6rlQq9gRwUTfPrjAAsybPY?=
 =?us-ascii?Q?pXbTb1IgKcgB/YKBhRoGmsAl2hasCyG7b/UF3NTlILEnImGLGMxn5WbBNNrS?=
 =?us-ascii?Q?m+79uXR1Pwfz5haQcVupcCMfIqAW60Xfnh4je9BNxA5lfY/mUJug60tbOrA7?=
 =?us-ascii?Q?hEU/Mh8SbQw0JjFLhrjq2hxK4YDqol8N2WinDRDUiVa1rOVCxUZ1dIimm83O?=
 =?us-ascii?Q?9aGKoVrPWHmjdUeDGXzQNFqolb+3z3/8umsjxo14DnP6FYcn3MNexQDR1wFJ?=
 =?us-ascii?Q?xdi7mG5KGYfa57Es4PV789tLwEpu8/3KGMc3EoSyAoOFPSEWl09BOvWeSbo4?=
 =?us-ascii?Q?Qomiv+mASV0e2ZudBGwVhKw5vH4Kjq57ruDc8NBslgXZLiLuSgd+m3Lj+PMT?=
 =?us-ascii?Q?M5eW8NBSw7Erm3fxpPZd4dxEcaMvRjkO82Xd2GyhboaDDkIXFs8lZjQPzC0y?=
 =?us-ascii?Q?hPvAzgR392/VgIPZnTLlbL+poExJAwV1H+NviPDyy+4zimO1YQoFKCnp5Ogk?=
 =?us-ascii?Q?T+E+/I+tr0wZc4lm1Q8dH8Naa77JwDZzgnhWT1SXVs/c+P2aZBws4/j+DnQ2?=
 =?us-ascii?Q?oHwIew4Hu4mUOAOGQLfQ6jIj30iZU3BDb0eam0RC2R0baTRMQ76qFhl2Siko?=
 =?us-ascii?Q?JORiChg+fqxPcWUkR0EN/gPCu7ebecG8nCwiIz244cEh+rZO3evzZLL41JvM?=
 =?us-ascii?Q?3kBmeka0+5SBJdO3YAW6ltkdhwvQ0yirysPJGPWahspRweZDSR0QGNJjH3d9?=
 =?us-ascii?Q?2lTOpXO8fU72XEpPKTUbCc18wGslkuq901lsnQZXOmMQ4Ebk/FW+J7rxELXB?=
 =?us-ascii?Q?4V78cXMb5H2C9bS6bBWST97CpIzfu9TikozTic5izvchLPf4mbcbJDUaF7ex?=
 =?us-ascii?Q?2sz0KVmxMKUR7mJuhSm8t/4MB8mr9zfhsd6KbRLihEVANC+kAaPshFEqsdR4?=
 =?us-ascii?Q?Os7zIQr08U7QIE6AtVf+6oX8NuCm0itvzCwfwXd2eFwb9xQ2ALUBW9zJQPla?=
 =?us-ascii?Q?ZDQ5GVaHn+aOBeGOo2tmufMkAeJapQH4eLfNe4TRRjDZqJnoAlXJADXAJuaW?=
 =?us-ascii?Q?ySioixNCcMRcloTzXo0jAfDo4U1snbitzqrXmYy0ACIsMoFlREUm+An9k3FY?=
 =?us-ascii?Q?ABkpqDLyaH0O1/8AzOyee4GTO25Iu6Jkrmjlic25/YaZnfJjXPXdRIr75/n3?=
 =?us-ascii?Q?WPXTTFSnguVrl65ExXWbU/jJvf6rEP+k9pxoLZcoTA+SHm4lMzEXxEZZv6nA?=
 =?us-ascii?Q?+kzuHdLKOcH40AZdiBPyaUILTnOP90bjbuct1q0zgbWZLvVFWxz+PpBizb90?=
 =?us-ascii?Q?2gYvO1TbVJ/hOOEC0yP3nS7ny+9kDKcRalJBYXAJOeBYzxD/6PDQPDRhRhz4?=
 =?us-ascii?Q?rvJsy0Gq8azdGEMvMAivEIXI4RexzPCJK/xDtbGuwyruk2g7zF2lp4pT9rat?=
 =?us-ascii?Q?u6To05mV0SO4Rx6G9dqeAckewOARYGYEE9qFpAbX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e0ff17-e9cc-4c60-a42a-08da9b074a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 12:54:43.9319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXvDfiUfpiKSa7+i9WBOn1Q8u9nXw4GFMUsxVrxHwBHxLO9eaWmw/rRSL2iKh8jqW6/Ab1wCIRTywhzSFvUOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8399
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>=20
> Move up the return in case MODE_OPERATION_CODES is not supported.
> According to the specification when MODE_OPERATION_CODES is not
> supported no checks should be done against NUM_OF_FW_SEC_PROG.
>=20
> Changes in v2:
>   - better explanation in the comment
Fixes: 89cd01ed865a (mmc_utils: add ffu support)

Thanks,
Avri

>=20
> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
> ---
>  mmc_cmds.c | 85 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 40 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index ef1d8c6..a3740ab 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2897,6 +2897,16 @@ do_retry:
>                 goto out;
>         }
>=20
> +       /*
> +        * By spec - check if mode operation codes are supported in ffu
> features,
> +        * if not then skip checking number of sectors programmed after i=
nstall
> +        */
> +       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> +               fprintf(stderr, "Please reboot to complete firmware insta=
llation on
> %s\n", device);
> +               ret =3D 0;
> +               goto out;
> +       }
> +
>         ret =3D read_extcsd(dev_fd, ext_csd);
>         if (ret) {
>                 fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e); @@ -
> 2927,49 +2937,44 @@ do_retry:
>                 goto out;
>         }
>=20
> -       /* check mode operation for ffu install*/
> -       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> -               fprintf(stderr, "Please reboot to complete firmware insta=
llation on
> %s\n", device);
> -       } else {
> -               fprintf(stderr, "Installing firmware on %s...\n", device)=
;
> -               /* Re-enter ffu mode and install the firmware */
> -               multi_cmd->num_of_cmds =3D 2;
> -
> -               /* set ext_csd to install mode */
> -               multi_cmd->cmds[1].opcode =3D MMC_SWITCH;
> -               multi_cmd->cmds[1].blksz =3D 0;
> -               multi_cmd->cmds[1].blocks =3D 0;
> -               multi_cmd->cmds[1].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE <<
> 24) |
> -                               (EXT_CSD_MODE_OPERATION_CODES << 16) |
> -                               (EXT_CSD_FFU_INSTALL << 8) |
> -                               EXT_CSD_CMD_SET_NORMAL;
> -               multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1=
B |
> MMC_CMD_AC;
> -               multi_cmd->cmds[1].write_flag =3D 1;
> -
> -               /* send ioctl with multi-cmd */
> -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +       fprintf(stderr, "Installing firmware on %s...\n", device);
> +       /* Re-enter ffu mode and install the firmware */
> +       multi_cmd->num_of_cmds =3D 2;
>=20
> -               if (ret) {
> -                       perror("Multi-cmd ioctl failed setting install mo=
de");
> -                       /* In case multi-cmd ioctl failed before exiting =
from ffu mode */
> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> -                       goto out;
> -               }
> +       /* set ext_csd to install mode */
> +       multi_cmd->cmds[1].opcode =3D MMC_SWITCH;
> +       multi_cmd->cmds[1].blksz =3D 0;
> +       multi_cmd->cmds[1].blocks =3D 0;
> +       multi_cmd->cmds[1].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> +                       (EXT_CSD_MODE_OPERATION_CODES << 16) |
> +                       (EXT_CSD_FFU_INSTALL << 8) |
> +                       EXT_CSD_CMD_SET_NORMAL;
> +       multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> MMC_CMD_AC;
> +       multi_cmd->cmds[1].write_flag =3D 1;
>=20
> -               ret =3D read_extcsd(dev_fd, ext_csd);
> -               if (ret) {
> -                       fprintf(stderr, "Could not read EXT_CSD from %s\n=
", device);
> -                       goto out;
> -               }
> +       /* send ioctl with multi-cmd */
> +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>=20
> -               /* return status */
> -               ret =3D ext_csd[EXT_CSD_FFU_STATUS];
> -               if (ret) {
> -                       fprintf(stderr, "%s: error %d during FFU install:=
\n", device, ret);
> -                       goto out;
> -               } else {
> -                       fprintf(stderr, "FFU finished successfully\n");
> -               }
> +       if (ret) {
> +               perror("Multi-cmd ioctl failed setting install mode");
> +               /* In case multi-cmd ioctl failed before exiting from ffu=
 mode */
> +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> +               goto out;
> +       }
> +
> +       ret =3D read_extcsd(dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> +               goto out;
> +       }
> +
> +       /* return status */
> +       ret =3D ext_csd[EXT_CSD_FFU_STATUS];
> +       if (ret) {
> +               fprintf(stderr, "%s: error %d during FFU install:\n", dev=
ice, ret);
> +               goto out;
> +       } else {
> +               fprintf(stderr, "FFU finished successfully\n");
>         }
>=20
>  out:
> --
> 2.29.0

