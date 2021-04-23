Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8579C433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 05:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13E8613F5
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 05:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhDWFcA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Apr 2021 01:32:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18489 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWFcA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Apr 2021 01:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619155884; x=1650691884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E2snjoQ11tZfkEvJilxxedofaM8PfiL8WD8LlXUPLXA=;
  b=VC64xwjFyN/n5GoqOrmfRzlKnDmJts6LjctsjTCUamXIJYBShyAqm22q
   QE+2zZClT80GQ9rHR9uTA2DHzTFWCrp3mS6e8DfRcQBr5bN5NZkZndTSV
   ggJAaIz0SqmzIePV7ZR5LuHQO9gCk1LAX7mx9WJZcOxsbx4XwNDtDMFoV
   1CFQX36OpRgdfw3qpMNbFYfBxTWMoey9aM0hCFUAFPeHcnaAMthst6uUN
   6U1+Msi/7KWmLCJmXAuxlUUY4yTOBFVyAtMbcoZHZiPdFuOpzojYyLui0
   AcUfUAVnoNaiLAJUfxfni1vBuBnzPkT5yj3O1oJqPmB2Q2At7QybPY3qH
   w==;
IronPort-SDR: tBbJbYZbMUmIDTltUSEYrJpIUgrA+g/UGTJpvPo7uFvfwzjq0J/kkOWJilkbXIroWyQAcRAbRo
 cFqiGddaTBZU8Iz72mQSDLZiVUiD04yqBc2icdlxjx6Fjqw9UWNJBkfZwFnzANbmVi8fe6LrMU
 dBdUXZ/N2mu3161I1SClhA9a+n7+mF4V93GWMOSYRUIEwbNYakGVj+mvNxVYrt/fEjeNcwj5Ae
 yxs5ttxxvR1Q5hM0DZcIv5SHPxBFL0CRXgEbtZ7Ql/6y4l9ScX1CaRlGz40ADyZFio+8JZNd+5
 TPg=
X-IronPort-AV: E=Sophos;i="5.82,244,1613404800"; 
   d="scan'208";a="165331254"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2021 13:31:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0Tetdk3hUZURwJLvnSHTc9H+KTyO42jUMA6al+S13ZvndeZdlJaYcxUoOivSnmZIclhEqKMeB2mKjuWaBta0opz7r4K+ffGtr2iXTLaLXl1Cdu3o97vw+XM6b5MEUsA19n/UZuuGUswltxMB0ZYsk5gH3jsJyO+8cKSlC8N7L47b761Pj3uwhCtMtG638Br/kRH+oHxV7rtHDIMCXczpamd6OrH+UluVaN2O1doAx5MSkfHNErLf4vVG4sA62EGDBYr1TCdeLGxeUS46m3SjOFw0ulMmrxcXCgyzXDutt7jvxNlam04nCTtQ8zLTC3iv3DQG9WOHiK6s8Sbk4crDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNmlhDihaw81foBk3HuqVK2rLohJRe2OlA9s3ePtU+U=;
 b=SwERC/r5CL0L5lxsSEcoaEWHzZkAVksQQT7qX1UnxPw2jdc9HVA90dinVLn5+I4hcLPhPaSqTmS/Kcy4cDWz3M6a8okZ0pBZTyC1hGUQ1Ao/C/ITv3cI0mONgKsnxuU3ymnwzvIylMGLwtVScZ0NSGwsBbg29PxwgegvZsZe4vOavBiE11g8tZa1C4OGQNPz1KH1W3JOnz/f+QBLF3b0tzNn0MLL7tUMOJwvdVOvDV/pJWSDSLG6JV+YefxnciCOYLgVrSCUeA8oqg310CfdNiM4+5EeItfIMeV2b4fHae9EhnwfIpbBxFVZ/k0GDJumzlqml+ZNPBuNJfFsn7x7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNmlhDihaw81foBk3HuqVK2rLohJRe2OlA9s3ePtU+U=;
 b=bpyyoVdjJpGr5QBmgm7TyY/AIufOQxUk2lsO7doJ92IZfp9T+RX5he3Di5QnI4lxQMiBXiild64R33tdOFDgM9BOHhprL9vdszYTEtuCLlo7jn7AW6pzSsy2GKYRmK6HF7EJDcryDkQYs0Vbe2mnC+dx+bsJ7inMdgkKdXl2FJE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR04MB0859.namprd04.prod.outlook.com (2603:10b6:3:f6::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Fri, 23 Apr 2021 05:31:21 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%5]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 05:31:21 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "luserhker@gmail.com" <luserhker@gmail.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "kimito.sakata@oracle.com" <kimito.sakata@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        "chris@printf.net" <chris@printf.net>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
Subject: RE: [PATCH RESEND v3] mmc-utils: Re-submit of the erase command
 addition plus remval of MMC_IOC_MULTI_CMD ifndef for erase. Re-committing the
 change per request by Avir.
Thread-Topic: [PATCH RESEND v3] mmc-utils: Re-submit of the erase command
 addition plus remval of MMC_IOC_MULTI_CMD ifndef for erase. Re-committing the
 change per request by Avir.
Thread-Index: AQHXN5JfYd4MGzWFC0OPnwBESIafXarBkC5ggAADoHA=
Date:   Fri, 23 Apr 2021 05:31:20 +0000
Message-ID: <DM6PR04MB6575ABF56616177093F75D80FC459@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210422161255.4610-1-luserhker@gmail.com>
 <DM6PR04MB657557ACD70FF26950CF0B0AFC459@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657557ACD70FF26950CF0B0AFC459@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc8e75a1-476f-458a-7d38-08d9061906f4
x-ms-traffictypediagnostic: DM5PR04MB0859:
x-microsoft-antispam-prvs: <DM5PR04MB0859464805D786EC6484FB08FC459@DM5PR04MB0859.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncEaGMtIaTYvB38lnPdNIDPIKqMj5yjPdxnmKrLCeVFOEZvrQ3uWiYS4Yt06v9n3DSeDtExl2OB4D88EiERs8RH3zMimELAVZG4uSC1FAsS3CoQFDjOxPbJz37vbhEHVv0DHBWlozqQ/fFG7YPXhbYMIbrU0FkiGjlbFSHd8cVecOMUHxrNNW+JhsDZuI1a8EPRUL80VCIeMvsBk7gkReRewvd1rIzoYuIeIVNcFPfXUn7s3U9+DSUN4O6oF8bEwhrd3xTi0Q/zvW2KGwh8ozfLmq8SSARXj3uhBEQhlI70pXKG4A3kWsusuSr3k+XkPTUVXwx98eN1WC9Cc1+tpxl4T/VWHitKSCquoOtw/M0vKwBpSGwtI4AWQUzNNKfSBApwodpQBsUJQxJZ9lOSd7kv6r+6f3gXhuRaGSmvGCkai9rI1+mml7K/LWWtpcFjA5spm08ZJzLxawI6jzCt1v4ekr16AF276ZjFAWxPP5NsHQfYmNAPsg2Br3+yU0E/pfCJgHvvBRc2KUuDmuuWmSdqvcYSe3HfqYdzvQuAK/gusBt5Zl2Yhjkk7sT/gNEhA2aEJEwIZ2/ZfTgCCMZEAiKl2PCOvy8ELo5MhzaOAiDeg4O9pFAckA9OoItgk/VdjIzBq5CdaGiuIWLiCOjxNZ0Po3U5ipWnE8exxsZb1xPEP25U8B7tv1UH/STEURRH0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(66946007)(5660300002)(7696005)(33656002)(6506007)(71200400001)(66556008)(64756008)(38100700002)(66446008)(66476007)(76116006)(110136005)(54906003)(122000001)(86362001)(186003)(2906002)(2940100002)(9686003)(55016002)(316002)(83380400001)(966005)(4326008)(52536014)(478600001)(26005)(8936002)(8676002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FdM8tZbg8uEdfdcSUbfTi4Q1+qrkEDai2xlL8WNlgU8G/+IFIEW74hGtyfD7?=
 =?us-ascii?Q?8yzZsssidtMRlV8RGCSEaWrGEeuAIY0msvcCW0WXdQwqllYvzbrrJIc1tstC?=
 =?us-ascii?Q?Q/u7BuL0nxzF/BhnAn6quNQaZeoPpqBCHa7bmj83q9DhFBbvL4dmY/vzJNRY?=
 =?us-ascii?Q?B3rABQelrBK9cTKULzumSzmDt9/A7L7oP5K4oKpLJRLCEkWSSv8RBE8jPX+F?=
 =?us-ascii?Q?KO9jJ/d4LrzVrIES0fn7RPNF3eDyJTODgsTaJ5u3b2nqQib6jI/oEvPetDvx?=
 =?us-ascii?Q?yx6EKJRZTDud2NfK02syv5D321oqwAL5VtDdz9dHLlJOVmoN94SR6bpdZ7vz?=
 =?us-ascii?Q?bU8YOA3jHaq6KwD3H/HbMUmx8zHpMwz+yJb8uMthgOLGfPAh47gAs7A5m4QG?=
 =?us-ascii?Q?KxIjn/53qxLvqZgyGrWtV3ngGXzS9P0++QvSLYDwztD17lW9SdGyeQLJsCck?=
 =?us-ascii?Q?HDBsSj0Y4KwqmiajAdC+MgZzS5+dcpyhm2UPZTRMhAqUAScPNXeJrH/zsiZB?=
 =?us-ascii?Q?FSul+XYpVQhR06q5bVDtVwFtRnwfYJ6wJ4C+dGA4OHBOt3bZTzpQOLjxbT5Y?=
 =?us-ascii?Q?kjqavK422FECEMvL7UHjSNeLpQrK+RfAsOaAJYXVbRedyz/YBbt+eSsdbt+a?=
 =?us-ascii?Q?84tME1zVUwCclVI7PxEvQU5yRxR1DwxJpbZTfYLjlX4WfRzPVEZMIedwZQsN?=
 =?us-ascii?Q?A/iDxAzvTYrZa/X0zTPo9ce2NwHqbdMTZcjIMLtzWd5/bjDVQuQLe7HB4Wok?=
 =?us-ascii?Q?8rYaxPT+NzyTo//CJwQoD28PbbTkafJcKc6RBvlcYYNUHV/nNhVZyyXLSpqn?=
 =?us-ascii?Q?2kDBM1u5DMf2HXWn7zcPSMgxcQtTKESKaiCVL3Ddm29Yi9KZ8ppyl8gZcksT?=
 =?us-ascii?Q?chPdGdnJVPNEEflIGF+U+rTavre4wqBTpd/JoY8sB5jyLbeOyNE2fdIZM2Ut?=
 =?us-ascii?Q?+217ix0PA4L75lUVj/y44kFruCajHRhw35BQjjJLFLt3RbqHyNCStmBcA5xe?=
 =?us-ascii?Q?j2Aq9UUufsdtCwyAMsJhwwaEea+sTKQ7vgR/G81nlWwxxVlmjebSgX9ZFMQK?=
 =?us-ascii?Q?BpAsaxGcr24tOqa1a7xCA7AcZVoC0cNks9IF48NUJ65tlh5XI9A+5fvhTzr7?=
 =?us-ascii?Q?fFZHVxOOyMzVAin3Ib06hi82jzepH82wNRLbZyRhXA+F98TlzbjPK5OUuzjm?=
 =?us-ascii?Q?pQDwkVvMtfbK5KVlXbit9gIpbfPD0op65MqD1uT9kSu+TRsRMFEm3Ptht/MU?=
 =?us-ascii?Q?WcY6g4vZkaFwUOifQDg9Fpjzo8LbyfzpxP2UlbwzGVF1xRghkxjgkpagKFJm?=
 =?us-ascii?Q?pUc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8e75a1-476f-458a-7d38-08d9061906f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 05:31:20.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbzIwNvVE5vwJnTtUaWCM7ueQE9KFtwQiRC4THl3ik+eOyqQdk+6M8/e4xSgs6LpT3GZLUfYWYxRgVPiKbochQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0859
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+Bean

> > From: Kimito Sakata <kimito.sakata@oracle.com>
> >
> > Signed-off-by: Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
> Hi Kimito,
> Please use a proper subject and commit log body.
> If you don't understand the difference between those two - please ask.
> Also for consistency, you might want to use your oracle mail for your Sig=
ned-
> off-by tag.
> You need to change your git configs for that.
Also, can you refer to this patch submitted by Bean - https://www.spinics.n=
et/lists/linux-mmc/msg63582.html
Are you co-developing this together?

Thanks,
Avri

>=20
> Thanks,
> Avri
>=20
> > ---
> >  mmc.c      |   8 ++++
> >  mmc.h      |  13 +++++-
> >  mmc_cmds.c | 135
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  mmc_cmds.h |   1 +
> >  4 files changed, 156 insertions(+), 1 deletion(-)
> >
> > diff --git a/mmc.c b/mmc.c
> > index f3d724b..eb2638b 100644
> > --- a/mmc.c
> > +++ b/mmc.c
> > @@ -229,6 +229,14 @@ static struct Command commands[] =3D {
> >                 "Run Field Firmware Update with <image name> on <device=
>.\n",
> >           NULL
> >         },
> > +       { do_erase, -4,
> > +       "erase", "<type> " "<start address> " "<end address> " "<device=
>\n"
> > +               "Send Erase CMD38 with specific argument to the <device=
>\n\n"
> > +               "NOTE!: This will delete all user data in the specified=
 region of the
> > device\n"
> > +               "<type> must be: legacy | discard | secure-erase | "
> > +               "secure-trim1 | secure-trim2 | trim \n",
> > +       NULL
> > +       },
> >         { 0, 0, 0, 0 }
> >  };
> >
> > diff --git a/mmc.h b/mmc.h
> > index 5754a9d..e9766d7 100644
> > --- a/mmc.h
> > +++ b/mmc.h
> > @@ -35,7 +35,15 @@
> >  #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr   R1b */
> >  #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr   R1b */
> >  #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   R1  *=
/
> > -
> > +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr   R1  */
> > +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr   R1  */
> > +#define MMC_ERASE              38    /* ac   [31] Secure request
> > +                                             [30:16] set to 0
> > +                                             [15] Force Garbage Collec=
t request
> > +                                             [14:2] set to 0
> > +                                             [1] Discard Enable
> > +                                             [0] Identify Write Blocks=
 for
> > +                                             Erase (or TRIM Enable)  R=
1b */
> >  /*
> >   * EXT_CSD fields
> >   */
> > @@ -62,6 +70,7 @@
> >  #define EXT_CSD_CACHE_SIZE_2           251
> >  #define EXT_CSD_CACHE_SIZE_1           250
> >  #define EXT_CSD_CACHE_SIZE_0           249
> > +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
> >  #define EXT_CSD_BOOT_INFO              228     /* R/W */
> >  #define EXT_CSD_HC_ERASE_GRP_SIZE      224
> >  #define EXT_CSD_HC_WP_GRP_SIZE         221
> > @@ -190,6 +199,8 @@
> >  #define EXT_CSD_REV_V4_2               2
> >  #define EXT_CSD_REV_V4_1               1
> >  #define EXT_CSD_REV_V4_0               0
> > +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
> > +#define EXT_CSD_SEC_ER_EN              (1<<0)
> >
> >
> >  /* From kernel linux/mmc/core.h */
> > diff --git a/mmc_cmds.c b/mmc_cmds.c
> > index 6c24cea..9340e3f 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -2514,6 +2514,141 @@ int do_cache_dis(int nargs, char **argv)
> >         return do_cache_ctrl(0, nargs, argv);
> >  }
> >
> > +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
> > +{
> > +#ifndef MMC_IOC_MULTI_CMD
> > +       fprintf(stderr, "mmc-utils has been compiled without
> > MMC_IOC_MULTI_CMD"
> > +                       " support, needed by erase.\n");
> > +       return -ENOTSUP;
> > +#else
> > +       int ret =3D 0;
> > +       struct mmc_ioc_multi_cmd *multi_cmd;
> > +
> > +       multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> > +                          3 * sizeof(struct mmc_ioc_cmd));
> > +       if (!multi_cmd) {
> > +               perror("Failed to allocate memory");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       multi_cmd->num_of_cmds =3D 3;
> > +       /* Set erase start address */
> > +       multi_cmd->cmds[0].opcode =3D MMC_ERASE_GROUP_START;
> > +       multi_cmd->cmds[0].arg =3D start;
> > +       multi_cmd->cmds[0].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> > MMC_CMD_AC;
> > +       multi_cmd->cmds[0].write_flag =3D 1;
> > +
> > +       /* Set erase end address */
> > +       multi_cmd->cmds[1].opcode =3D MMC_ERASE_GROUP_END;
> > +       multi_cmd->cmds[1].arg =3D end;
> > +       multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> > MMC_CMD_AC;
> > +       multi_cmd->cmds[1].write_flag =3D 1;
> > +
> > +       /* Send Erase Command */
> > +       multi_cmd->cmds[2].opcode =3D MMC_ERASE;
> > +       multi_cmd->cmds[2].arg =3D argin;
> > +       multi_cmd->cmds[2].cmd_timeout_ms =3D 300*255*255;
> > +       multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> > MMC_CMD_AC;
> > +       multi_cmd->cmds[2].write_flag =3D 1;
> > +
> > +       /* send erase cmd with multi-cmd */
> > +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> > +       if (ret)
> > +               perror("Erase multi-cmd ioctl");
> > +
> > +       free(multi_cmd);
> > +       return ret;
> > +#endif
> > +}
> > +
> > +int do_erase(int nargs, char **argv)
> > +{
> > +       int dev_fd, ret;
> > +       char *print_str;
> > +       char **eptr =3D NULL;
> > +       __u8 ext_csd[512], checkup_mask =3D 0;
> > +       __u32 arg, start, end;
> > +
> > +       if (nargs !=3D 5) {
> > +               fprintf(stderr, "Usage: erase <type> <start addr> <end =
addr>
> > </path/to/mmcblkX>\n");
> > +               exit(1);
> > +       }
> > +
> > +       if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
> > +               start =3D strtol(argv[2], eptr, 16);
> > +       else
> > +               start =3D strtol(argv[2], eptr, 10);
> > +
> > +       if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
> > +               end =3D strtol(argv[3], eptr, 16);
> > +       else
> > +               end =3D strtol(argv[3], eptr, 10);
> > +
> > +       if (end < start) {
> > +               fprintf(stderr, "erase start [0x%08x] > erase end [0x%0=
8x]\n",
> > +                       start, end);
> > +               exit(1);
> > +       }
> > +
> > +       if (strcmp(argv[1], "legacy") =3D=3D 0) {
> > +               arg =3D 0x00000000;
> > +               print_str =3D "Legacy Erase";
> > +       } else if (strcmp(argv[1], "discard") =3D=3D 0) {
> > +               arg =3D 0x00000003;
> > +               print_str =3D "Discard";
> > +       } else if (strcmp(argv[1], "secure-erase") =3D=3D 0) {
> > +               print_str =3D "Secure Erase";
> > +               checkup_mask =3D EXT_CSD_SEC_ER_EN;
> > +               arg =3D 0x80000000;
> > +       } else if (strcmp(argv[1], "secure-trim1") =3D=3D 0) {
> > +               print_str =3D "Secure Trim Step 1";
> > +               checkup_mask =3D EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_=
EN;
> > +               arg =3D 0x80000001;
> > +       } else if (strcmp(argv[1], "secure-trim2") =3D=3D 0) {
> > +               print_str =3D "Secure Trim Step 2";
> > +               checkup_mask =3D EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_=
EN;
> > +               arg =3D 0x80008000;
> > +       } else if (strcmp(argv[1], "trim") =3D=3D 0) {
> > +               print_str =3D "Trim";
> > +               checkup_mask =3D EXT_CSD_SEC_GB_CL_EN;
> > +               arg =3D 0x00000001;
> > +       } else {
> > +               fprintf(stderr, "Unknown erase type: %s\n", argv[1]);
> > +               exit(1);
> > +       }
> > +
> > +       dev_fd =3D open(argv[4], O_RDWR);
> > +       if (dev_fd < 0) {
> > +               perror(argv[4]);
> > +               exit(1);
> > +       }
> > +
> > +       if (checkup_mask) {
> > +               ret =3D read_extcsd(dev_fd, ext_csd);
> > +               if (ret) {
> > +                       fprintf(stderr, "Could not read EXT_CSD from %s=
\n",
> > +                               argv[4]);
> > +                       goto out;
> > +               }
> > +               if ((checkup_mask & ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT=
]) !=3D
> > +                                                               checkup=
_mask) {
> > +                       fprintf(stderr, "%s is not supported in %s\n",
> > +                               print_str, argv[4]);
> > +                       ret =3D -ENOTSUP;
> > +                       goto out;
> > +               }
> > +
> > +       }
> > +       printf("Executing %s from 0x%08x to 0x%08x\n", print_str, start=
, end);
> > +
> > +       ret =3D erase(dev_fd, arg, start, end);
> > +out:
> > +       printf(" %s %s!\n\n", print_str, ret ? "Failed" : "Succeed");
> > +       close(dev_fd);
> > +       return ret;
> > +}
> > +
> > +
> >  int do_ffu(int nargs, char **argv)
> >  {
> >  #ifndef MMC_IOC_MULTI_CMD
> > diff --git a/mmc_cmds.h b/mmc_cmds.h
> > index 9d3246c..8331ab2 100644
> > --- a/mmc_cmds.h
> > +++ b/mmc_cmds.h
> > @@ -45,3 +45,4 @@ int do_ffu(int nargs, char **argv);
> >  int do_read_scr(int argc, char **argv);
> >  int do_read_cid(int argc, char **argv);
> >  int do_read_csd(int argc, char **argv);
> > +int do_erase(int nargs, char **argv);
> > --
> > 2.24.1 (Apple Git-126)

