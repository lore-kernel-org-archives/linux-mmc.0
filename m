Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC66C6FA82
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Sep 2022 08:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiITIMm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiITIMN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2022 04:12:13 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20132.outbound.protection.outlook.com [40.107.2.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1F2FF
        for <linux-mmc@vger.kernel.org>; Tue, 20 Sep 2022 01:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBdUTpTqMwWCrZlV740M2rxrSM9rjGRZ1hNc2S812IISwUiftfkGpiOieLZUnNX9qdnDssp6bnxXgDQd2iFzIKZy9KUVvIxNzGPRf9ayvLI0hx4i8m7yZPwtW91Gru8oqR4lgGD6+eL9lzSmlkU2vOElLufp9K8V4IOwUb9V5jY+gbOhvq2arMjxD8aCmKw2VyXz4aCf5WwClIomzWd9pDlzrsdX+fSlntFWpfN6ZBHUiSHHHf0FZe0om3D+SS7yR6g1fm8WPc77bRxY8f2CJzFEQ3aXTks0NP1PPntqrZ4voSQ/EAvnkXIQf8JQSNTur8mvbmNJmqZz1wIp69zA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMgtjC+VFs5G4dHD0pTzwi4rb+STaFn1l/e1TGA5Pe4=;
 b=UBluYI3ktyrA/gqAKFJXuaHjadkV9ABXFYrvIqiDynCQupihS7IeGpj0Yg49zlWJARZoVTBulYJqswHHILz1GG+JG16zxrje0MuxIgdenUoKVCo2rysGRWTIFMQtnWv2036CYhn9F8N6bLK4WMowZzBlfWXRWi8/3MTPTOdkSUEUKDxYM994maKB1Yho9GNIV65lbylHpulvENpu+gXfggEZE+cc8Ky3QDSSyTFHUwyizdYjcVUUG/fNy+tfqTvlf3P+jExNoGr6k72xzD0aYpcf/mW1xWE+D2+ccmfiVTYPpzBmWckpDe7Xg5ooa7jnOhvnxAeYOOUBnv/BpwIa9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMgtjC+VFs5G4dHD0pTzwi4rb+STaFn1l/e1TGA5Pe4=;
 b=F5GJ2KWW0iJ4+dpq+mMJikVPQFgpsvMS/erunEkLC+Is9ignI7NMCar/UQV1Ml8S9aHnifzm6yPcgLdbFOvhv8WpJ8662oLiULnZvDFHdDWK9o/31O7QF/h6+rfR+zsbX2dYdmi777b9NQ/oy7QgRtwkUlQw206Y5W/2BxFfyhg=
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 (2603:10a6:203:4e::11) by AM9PR07MB7746.eurprd07.prod.outlook.com
 (2603:10a6:20b:302::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.9; Tue, 20 Sep
 2022 08:09:24 +0000
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::542a:5d98:f0f4:3640]) by AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::542a:5d98:f0f4:3640%7]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 08:09:17 +0000
From:   "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct ffu in case of unsupported
  MODE_OPERATION_CODES
Thread-Topic: [PATCH] mmc-utils: correct ffu in case of unsupported
  MODE_OPERATION_CODES
Thread-Index: AQHYzEOPdhYC3/sfjky26ER0xGS8F63nRxaAgAADn4CAAKem0A==
Date:   Tue, 20 Sep 2022 08:09:17 +0000
Message-ID: <AM5PR0701MB296424D4D1E013CFB88EF0D7EF4C9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
References: <20220919161852.28072-1-bruno.matic@nokia.com>
 <DM6PR04MB65754366E4FFD588A9EAEB27FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB657501FE8AC5E9937FB96AE8FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657501FE8AC5E9937FB96AE8FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR0701MB2964:EE_|AM9PR07MB7746:EE_
x-ms-office365-filtering-correlation-id: d02e6dff-a905-42cb-7844-08da9adf69f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESoHOGkhcJjY0psDI2HL3lWDqDQrU7uDGMuVxnNF/M0ulVQ1/8VOq1iQN3dM9eYM3LqXju4IO+d3bDEc2dStTAf4g2m1FvcAbJj7YV0oELy0jWcROgrAXuTxXJZUNMYW9b6FLtiD4NttdDzZMnjywoYGVOQLkcDRPC5tVaDkT/OtwyLmvDWU76cceSAqCLaMVAfaMZu5N4gQQ32pGpe5+ZuQTueb9FIjcyzrkecDLYD4J87o2FAf5C1LC+nwZx+iGj7qE1NkMT00e8P0aVSIzIKDmUZzVVTqP5laIH7eDIu43HvugCl1r1ZEyuoTewtE4a5wT24n7KUu4At39pfU/4PXD01wXyX56NTclSp5f4i+lON+BVP52r86hH2CIyGB+8S0Dc6lmGLrJTpg+Gf3wsEhZhIt4w3acZ56v3t24Aw6uxiO1ZIe8qTdnt3bNRc5QyvAMLmMSf5If3eExynSbj14kWcPBlU07RuvNnBVVLYMZOp/kdOYfflJciRKELOdBMeb/kmXq/8WwwDN5MHJAnrnRr9t6vxCTP2rhbITryhZIXmXtgakCZsu61AF1Zib4H5oNxvmK1bEk49j6lsv3lfzQUCAlz+gD5ztJx+OH75L/SOb5uyg4Xj04saLIATnqKsmPNGLme0VD2HlnGvRvlnnsuVXPJJN4cpkRfp4j0ixWnSmKNcaxjzZhvHcljWTHsbwX5VaLPUaev6uD1aGTI3zFdTq7cK24unC/BaF9vZX3T3ny13WHizxWe6j638DvDaRsJPYxkh/Y4c5UN1ekA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0701MB2964.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(82960400001)(38100700002)(86362001)(38070700005)(122000001)(33656002)(186003)(8936002)(2906002)(5660300002)(26005)(107886003)(9686003)(53546011)(83380400001)(7696005)(6506007)(8676002)(66476007)(66556008)(64756008)(66446008)(41300700001)(52536014)(4326008)(71200400001)(66946007)(76116006)(55016003)(478600001)(110136005)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?1x8jV4msYcndn80Dcyxx6B/T6PrFAc9GlNxbAG0dB4l8MAjeqzuIBX9SI9?=
 =?iso-8859-2?Q?e/28mrlAwF/L23GfuxlE0eu5BA9IsHb/+v6VAuG6Es0SqRQCD2SOD/ggnT?=
 =?iso-8859-2?Q?nmwqFoNC3Gr5IcTV+o1QgeHe0saigBP+bkoRkYRiHfD/hB49Q/N1U9r2o/?=
 =?iso-8859-2?Q?j3csYbqivPt/KO7br7fiok6RoQi7RgNB/mdaRa72GwgPB3JteCJwqlZkrb?=
 =?iso-8859-2?Q?YuiRyaAEtSB+PnHF2hfm5+TLlQBhcwdb7yfLDnC+N3gX21U/AWSATkxuDu?=
 =?iso-8859-2?Q?o8w6okwAJrE5g0V+Ny+qekuh9GZR+LIBednn3lG4e+pBomR4n1JDo0XkCr?=
 =?iso-8859-2?Q?TVi4djIsWCNS9UBLzUzSDoFK4OIs+sT9eByC1DMjEnWQOblr6g7eEJ+Lry?=
 =?iso-8859-2?Q?PVjIwQlhVBf98ePr4Kb3bj9sN8KoeYhHBOVnB8rdF4Am48MWB93w377Use?=
 =?iso-8859-2?Q?SREfbkT/8x7+8CGi2X6jf+eQu9010aKWEsgJsEz0xYEIgFyvsAIr6xOZ6Z?=
 =?iso-8859-2?Q?o9s1FEV8/8QwUR5adXoMeBCqrgtO14OrAebIxfJn7InlKV3njfX5kgEnzg?=
 =?iso-8859-2?Q?MRKGHtUICyRrK1h98srT01VJ7kuJrfFwOmQMd5Bl5Wlux81VtgX+cbgfN0?=
 =?iso-8859-2?Q?C6inqF4G/YXNKHicL5vC3leb3N/2pzHhaSZ59WcNrpYH+x1cYgEKVRE2ci?=
 =?iso-8859-2?Q?zZuD4Dzn2UkI7SwUKSXjl+HeEp7tdZf+nd3bk1R81es0qRwZNj5X03RItm?=
 =?iso-8859-2?Q?ZH82MK3mcQRamHwkibfQWzkUolFyRm1JI3zamZmygbO1suqLRtZlgqf4yP?=
 =?iso-8859-2?Q?lvv0MIPiDZQWzts2/7pB0P8XLtYMddJGyjVEt9XDnkXWlFdUIJQebFKsaN?=
 =?iso-8859-2?Q?pNThvmGIyhjak3WBaHS4e/9wwZZ6d79ewXw51NTuzyCl702uu+enshf6jw?=
 =?iso-8859-2?Q?2C25FxHeDQdh7f9EBXFJ5WZHFS+Bo0FIKnFZ+1d4H7Kzr8iPqUiolU80He?=
 =?iso-8859-2?Q?awLlqiFITurmo8oKcx+zFpzuyysXvIf3nb+yaFmSjfuwv9dJV5s2RoHXTi?=
 =?iso-8859-2?Q?jHH8QIKK29cIZWjB0tYmr5m7ccAfcYBwdpYrZIQc95N0dHvl4njQd6vj68?=
 =?iso-8859-2?Q?zw3dDQPnid/eI0sjCRZ74vsYv7Ekwm8d5uuByRiKL7KLMMpTcP1SJeJ8vd?=
 =?iso-8859-2?Q?wKZWK9iXhM3xZkH8YZbooix6iasT3XKIdKDsCHmTPAVPCcqpi1U48HUIf0?=
 =?iso-8859-2?Q?9YMO+RHeey+PH2HH1m0RDjR07c/xJrYdiSlWTTOKjGHDWZSaAzh/E3RyBl?=
 =?iso-8859-2?Q?cDRAobChVTg6DjY5IXKAyHE0qwQ2ccshsjzdxMdWwutPNG5EDJ0lyAgfeM?=
 =?iso-8859-2?Q?Nfaf1aRIQqsJ7nRkhiq33rEgISTOXw7hfRPNrlWH5J/qD8x3VyIwP0u+lS?=
 =?iso-8859-2?Q?MnFmE01+MYhLhwUqUBnnIr4apefOquAUggE5C7cswmKs+SdhaNKOOKfUNY?=
 =?iso-8859-2?Q?/fPd4QlEZaBW7xnVqxf7C5psvuhNibMVjbOesFDHa8hh+3JCvgc/nniDP6?=
 =?iso-8859-2?Q?LUv8ExPLLlJ5QgDb4KeUsM4ip+dYHqDHqVO5jkGitaNu85UWI0W+mokjF9?=
 =?iso-8859-2?Q?OQyD2qr9+FccEAEOhnfI63d8QSYpMI5N+C?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0701MB2964.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02e6dff-a905-42cb-7844-08da9adf69f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 08:09:17.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HW0cFHwKVFXeZS0Kj6pL3zG5Q+3suURe6sAnC9+LismXG+wiwAlGNwy4IdvIANHeBwoA1kDYdRxFff9pfYW5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7746
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Avri,

ext_csd is read in line 2789, close to the beginning of do_ffu.
The mode check and skip is done by the following snippet in the patch:
	/* check mode operation for ffu install*/
	if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
		fprintf(stderr, "Please reboot to complete firmware installation on %s\n"=
, device);
		ret =3D 0;
		goto out;
	}
According to the spec when the FFU_FETURES field is 0 then MODE_OPERATION_C=
ODES is not supported
and sect_done checks should be skipped with no error.
Further reads of ext_csd are done in case FFU_FETURES field is 1 - to check=
 the NUM_OF_FW_SEC_PROG value.

I admit that the patch looks ugly but that is because the check was moved u=
p in the code from an if-else block that=20
had to be refactored.

Best regards,
Bruno Mati=E6

-----Original Message-----
From: Avri Altman <Avri.Altman@wdc.com>=20
Sent: Monday, September 19, 2022 11:49 PM
To: Avri Altman <Avri.Altman@wdc.com>; Matic, Bruno (Nokia - DE/Ulm) <bruno=
.matic@nokia.com>; linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org; Rossler, Jakob (Nokia - DE/Ulm) <jakob.rossler@=
nokia.com>; Heinonen, Aarne (Nokia - FI/Espoo) <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct ffu in case of unsupported MODE_OPE=
RATION_CODES

>=20
> > Move up the return in case MODE_OPERATION_CODES is not supported.
> > According to the specification when MODE_OPERATION_CODES is not=20
> > supported no checks should be done against NUM_OF_FW_SEC_PROG.
And I wasn't able to find in your code, where you are skipping the check ag=
ainst sect_done, In case MODE_OPERATION_CODES field is not supported.


Thanks,
Avri

> >
> > Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
> > ---
> >  mmc_cmds.c | 82
> > ++++++++++++++++++++++++++++--------------------------
> >  1 file changed, 42 insertions(+), 40 deletions(-)
> >
> > diff --git a/mmc_cmds.c b/mmc_cmds.c index ef1d8c6..81fdc7e 100644
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
> > +               fprintf(stderr, "Please reboot to complete firmware=20
> > + installation on
> > %s\n", device);
> > +               ret =3D 0;
> > +               goto out;
> > +       }
> > +
> >         ret =3D read_extcsd(dev_fd, ext_csd);
> >         if (ret) {
> >                 fprintf(stderr, "Could not read EXT_CSD from %s\n",=20
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

