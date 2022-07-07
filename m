Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71FCC43334
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jul 2022 12:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiGGMAm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jul 2022 08:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiGGMAY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2022 08:00:24 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD3D31200
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jul 2022 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657195196; x=1688731196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NNM+mZYFKM6ctFtN1CD+UDIUmSmZr7CaC6ZixEoVG8g=;
  b=Hv1ns1zEiRmrm9S5+Su6Ii/syic5BVnrYVVKrq0D0Huup4e0qWpbB5t2
   KyxJewBg+32iCTrYyapttBWkiMc2P/rZ/4kGgrKJkERSim2+w0bj9iRDF
   kNLgHb2Fg7qr3KHbHnbXQEw27/Jt5blBk9HrzC0SqrFm0intsMA9d22AS
   ju6GmvLeqbUztUj07hF/iLYIUFT07BqQi71CP4SmnzWX51RnuseTxPN6G
   MQVvuKb5CF/r077K0ddpRQ/rjsVIVWnMdGV9k4TaSx0OdscVIRyHcQ56S
   06JBeL8eRl78e//ace7jBiXZ2yflv9KcnBbZqu1ErUkFb+arpEyx1/xlC
   A==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650902400"; 
   d="scan'208";a="205785466"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2022 19:59:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFVbRAZyWAiT7w9L6S/sRObdmP9uvK0+TPvkDb6fnlRl26j5HYKUDLakByuCB4gbcxoyAB85wBlHdvcazXQcSH/iW5cbSWiV8ViJNjgPdWssDjgrhBL9CB5nKPwpMl8ErC1RsWxFYH8lOgAlTmM/wghltYexod1d3bY+brQkYVkdipu7fusLwN9lSPGeQgcAL01eA3u7UBPAMcccRIwofxXkkBW/pkS/T7jsBEDNnn+K9D4+Z1rR/Ih3LmQAgfvcKPq8NNyEBnsGICeMnzstIDxh7p3EpfZNUQBZHHTRk93wSi84JgD1tuf6hfHfEj+ePcEfwzqsCMddSdRz8uq5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TG/3ClYMD6IxK1L4pEasP3HXNjfp0cNoUgb7GSEMpA=;
 b=RK4oto+QOopfPfm28sMPdZXuoaVuG+c3A60eQ2XCFIDkEtd6lPqFzOmmzVDx9n+Q8CFBI2X4VmelFEQeEm1J7ntNyEGVk+GVtpddB6th3G/eLxsqFuvKg61fd3OlK2HDh521ewBFMMSjWxxvDTGqta2q2WzCDHWn69/X77KM3b1AlKU6SL2Br1VfUuLuZUuIsPF5w+QwttonsXPUYyeSz+eaWbbVBlEOoPpZOInsg64bKxDofUMUciXJ/jbDbeK1HCFoMLSY5yJ95IkL4z5C2fmvepvjIwA/9OqEme8FucXRMCLJiu1GsQ4TZIIEBurKDSThBvpVrv9Iaeo3qZMK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TG/3ClYMD6IxK1L4pEasP3HXNjfp0cNoUgb7GSEMpA=;
 b=C1kNPTT0o06Q5OZO5ILaCKxTDzO8AnqdR8OTHDfFAWLn5pdkm1aewrzG/aQdokksc4ApLZKUEdOLIpN98bc/NRnKE+N5iPy0DtFZMOJmkDNeTSTCZ3bzBEdECsR4SHLMRn0aiGLV6PkxMm6Ni6UI4w7UXGlSVGz6Yf+dF4ovfF4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5466.namprd04.prod.outlook.com (2603:10b6:5:10b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Thu, 7 Jul 2022 11:59:53 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 11:59:53 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7QAPwi0AABQpUuABmc8nMAACAULg
Date:   Thu, 7 Jul 2022 11:59:53 +0000
Message-ID: <DM6PR04MB65750D9A332093DBA5B30BDAFC839@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <AM5PR0701MB2964D76967437E61EF42731DEF839@AM5PR0701MB2964.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB2964D76967437E61EF42731DEF839@AM5PR0701MB2964.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2148a2b9-c81c-48e4-42e4-08da60103407
x-ms-traffictypediagnostic: DM6PR04MB5466:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46OM+nJawW5XXY8y4qDmFggOG2CtycmkfjYbQk55l580NDA/jOCQ0uiI/4lvH77ljEj4Y6xrDmMI5u1Z8yAkeQRhS/yo0y7uDaEVrxaLWud71CiGS9f+SJO+RPDGrB2wSFTdAzIJUzPwZTzvHFm6DbbATaNdfRa6RRV6toG396iKw6QQKLxWjtQiu3rvigqcUCigrx/3chw/RvBAhNGSdY8zqTEa1T6B+dRyd/ztPlnkwKUI0fQEqUNDr+KZlKFpRKLkR8U6RERSEEvLAbPQqzXuGSCgBkjUG9G+bg6ubIsLQ4WfP8Z0Dvnq8yEFmcM+99Yj4MeCcMZDCYu+Fs/RfzfhPl/gNG7lZI2ER4kgFEJvWaaK/ryi+mvSMN3muorAyGay5mCJ6hoXSHqZsy+pxtmmefF2n6E42NCY/LaWMbWTiAjj9HGjxISROcnaiBy971T4r7XrwIqvF+YKGTT+Rw04QFoMD5euijQSfirjwq9uG/33dAbuh19dqlbWUw0QFOPVYNWqbPjc1x5LW0A6baXZRlhTeapwvir2W1hkKizhCatJqlPjqaDbSaYOugi7iez6Ue5BMiwIlRfffPf/s72vv1uGUEKhk0FFWhwF5xuvBkcNxQn3mhlodXko8IxoksPn1bNCdYW6gdyjjmWaYXN8kPHVwUGGhCZgagO/azSYBLybHlvM//duNsCW/8V33gm7hVKrKZ/3ZkAbQWBT+4O523GSflMdr2qcZ39WDyr0qIgtmWOwItbYuZ8mQkVaklBG8VEQL3FcpMravtFGeGEkgzQyRrdxkDq32LmU+7704EttDVJLQDn9aWhYFE+WlhQZ2AcAdnrOGorRhS8WgotfTLGWpFIq+oPvPh77E80=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(33656002)(55016003)(76116006)(5660300002)(82960400001)(2906002)(122000001)(4326008)(6506007)(7696005)(478600001)(38070700005)(53546011)(66946007)(66556008)(38100700002)(8676002)(66476007)(66446008)(64756008)(186003)(83380400001)(54906003)(66574015)(110136005)(26005)(9686003)(966005)(316002)(41300700001)(8936002)(52536014)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?dzQAQEp/A7FPucU7F4R9ZZWlGetjofLs4ofjJOqo2k+XhKwIfJ4sYDO5+b?=
 =?iso-8859-2?Q?4f5ojnjDS1EqhMBHP6RrjUuHjRmI/A5PUk5jPJ1tOPejzURxaULmL+LAz9?=
 =?iso-8859-2?Q?UBX/Udcy6xMqOPG3YGYLW0P6STkQGIK9Fk+tXv13UmafvuSEAc/3mkSHF4?=
 =?iso-8859-2?Q?ChQYePOkzjCqUBnwMMg58LINu2p1LrnSEvSgSj3lPQ7dHwGcSIAxCyF62b?=
 =?iso-8859-2?Q?lfknOS+3v/RSygb6YH04z6wgl7bDH0uWPC+exS4KYaG6chY93PAV8mdb8U?=
 =?iso-8859-2?Q?kSSQBVcTEq/mJPOFo5TSNlzzkG5ZyXe5KfS937k1XR24lAHNBFPxpT6Ad3?=
 =?iso-8859-2?Q?J9oWaQ9FDT9vqsHi7z/uM00+OCKUgwIhSSWQ3KTXiKSyccTV7zvqHifY/5?=
 =?iso-8859-2?Q?nubBeav441fZBCv8lpbiNqe+UUU7KsghspQ/UyZI6eTwL1gLCXR1uxk5TZ?=
 =?iso-8859-2?Q?T24upzwJeLrCWt8xLS9jnii9DiDHeVDr0CP63XnrY7O1hqgjZg3Lt2FLgQ?=
 =?iso-8859-2?Q?vdaR1Df/6sDwbT/Alb1QcX1TNpz9AF+CjnvkyuK0lz7tEUq1SVVMC/XRvs?=
 =?iso-8859-2?Q?BDlVNqTBCBFBZL7zj/QvIe8HG+7xtlwrXU19mJnHG/595w4bA3KXz5idem?=
 =?iso-8859-2?Q?thvxnucYjJtNdDdTu1p1kLtsWy+eLwJsadi1X3CYAs/HNZtg6TqNB0MSkw?=
 =?iso-8859-2?Q?5MEpDN8nmkO4CI8Z3+jKTxRVL3QoBNKTOqfRHOW/fvVMxwTPHTtkykAslK?=
 =?iso-8859-2?Q?yGN77WQ/jEwRYXeRnJpGjoytPFU+fGAhEaYwitg4n4BRO7hJzBKDNK+A2P?=
 =?iso-8859-2?Q?yqZA4z1PoMT7VNwLMXucBbN6Hh050wEGMD+doz1SqeEu5H/0Pm4aJ1x7TT?=
 =?iso-8859-2?Q?ktK2BiEr2RplMB+cuYhEbuNg+S6IbOWSof3/2De6NS2X8ViCOF6p5zqCDV?=
 =?iso-8859-2?Q?AlVA3wD3+mx/sqc8MA6CmdNq01Kce9oA/Pi6HQmYhjZO22YqXRWYFQ3puV?=
 =?iso-8859-2?Q?Izqb3waxQaKRqtf4zMVsn+rcd/itY988ConYZk/xpK0E65u6nl4c85WPED?=
 =?iso-8859-2?Q?Q2kbPKTAUv3NNScf92d0N2gYmZT/UjIB+BR4gtSGwAUZjXzx+Mo4iJy1Dl?=
 =?iso-8859-2?Q?WyBL4BleRzJf+O62wbDexchtjX/L+rOKsbM5RtxpbOtXHzLWj50uFPEBDU?=
 =?iso-8859-2?Q?dNE6T2y3yTFdyukpYmB5CPIN5BvndM4U331FMMMW3H7ws1sGZnvbb1q6Rn?=
 =?iso-8859-2?Q?rrULPvPPrQRhSkHosllImDXfbnbcm7Dvf05BNb03N4mOeLBQ8iNCLn/K1R?=
 =?iso-8859-2?Q?HKRWGnRtW/rAfC/gPz0a8MjvCCwMhVUxJP+S5jZcBMwbeQGEhhcBBs0VZi?=
 =?iso-8859-2?Q?0lU399qUEmg5lQQkqVVmKQD97JLvwBaLBzzzIQdahECBjgvREgOTgBgnku?=
 =?iso-8859-2?Q?Vlc4KsXzATh2RLEH2JFokJ9nGzFncKa8syhV7cE2kAt/2dVy75PsWxCiwI?=
 =?iso-8859-2?Q?Ic0XIpcrkAaZPcSWH5bbloG57kXLQeO0xCCU9j1qYCo5GrJVe9YqjyvssR?=
 =?iso-8859-2?Q?nk6C4v9TxCCSmgy7G+4x+1J6VcFB0GbU93tUfufWL4DNBuH3rMG/+rw27n?=
 =?iso-8859-2?Q?DJxFlwD9KKS4o/BRNGBC3Gxp/N8TYduOiO?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2148a2b9-c81c-48e4-42e4-08da60103407
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 11:59:53.4355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDD3tsnmCFayO1PSFyAKXQqRuFuOn7ghzI3SJtAt0u1xeP2MUb/ks42iDUBA476fNhGdW6coc8Ag2yutJrhC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5466
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Hi everyone,
>=20
> If I may ask if there is any update on the state of the merge since I can=
't see
> anything in the git log.
I am following this - Ulf didn't pick it up yet.
Will ping you once he will.

Thanks,
Avri

>=20
> Best regards,
> Bruno Mati=E6
>=20
> -----Original Message-----
> From: Matic, Bruno (Nokia - DE/Ulm)
> Sent: Wednesday, June 29, 2022 9:33 AM
> To: Avri Altman <Avri.Altman@wdc.com>; linux-mmc@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Christian L=F6hle
> <CLoehle@hyperstone.com>
> Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
>=20
> Hi Avri,
>=20
> That is ok, I will wait.
>=20
> Best regards,
> Bruno Mati=E6
>=20
> -----Original Message-----
> From: Avri Altman <Avri.Altman@wdc.com>
> Sent: Tuesday, June 28, 2022 11:56 PM
> To: Matic, Bruno (Nokia - DE/Ulm) <bruno.matic@nokia.com>; linux-
> mmc@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Christian L=F6hle
> <CLoehle@hyperstone.com>
> Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
>=20
> Hi Bruno,
> Thank you for your patch.
>=20
> > Add the check if the whole firmware was loaded.
> > Cleaned up the leftovers of handling the file in chunks.
> >
> > Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
> Christian proposed a fix to do_ffu about a week ago, see e.g.
> https://www.spinics.net/lists/linux-mmc/msg70961.html.
>=20
> Would you mind waiting for few more days to allow it to finalize, And the=
n
> rebase your change and resend?
>=20
> Thanks,
> Avri
>=20
> > ---
> >  mmc_cmds.c | 69
> > +++++++++++++++++++++++++++---------------------------
> >  1 file changed, 34 insertions(+), 35 deletions(-)
> >
> > diff --git a/mmc_cmds.c b/mmc_cmds.c
> > index 70480df..e64c747 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -2812,7 +2812,6 @@ int do_ffu(int nargs, char **argv)
> >         __u8 *buf =3D NULL;
> >         __u32 arg;
> >         off_t fw_size;
> > -       ssize_t chunk_size;
> >         char *device;
> >         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
> >         __u32 blocks =3D 1;
> > @@ -2925,45 +2924,45 @@ int do_ffu(int nargs, char **argv)
> >         multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> > MMC_CMD_AC;
> >         multi_cmd->cmds[3].write_flag =3D 1;
> >
> > -do_retry:
> > -       /* read firmware chunk */
> > +       /* read firmware */
> >         lseek(img_fd, 0, SEEK_SET);
> > -       chunk_size =3D read(img_fd, buf, fw_size);
> > +       if (read(img_fd, buf, fw_size) !=3D fw_size) {
> > +               fprintf(stderr, "Could not read the whole firmware file=
\n");
> > +               ret =3D -ENOSPC;
> > +               goto out;
> > +       }
> >
> > -       if (chunk_size > 0) {
> > -               /* send ioctl with multi-cmd */
> > -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> > +do_retry:
> > +       /* send ioctl with multi-cmd */
> > +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> >
> > -               if (ret) {
> > -                       perror("Multi-cmd ioctl");
> > -                       /* In case multi-cmd ioctl failed before exitin=
g from ffu mode
> */
> > -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3])=
;
> > -                       goto out;
> > -               }
> > +       if (ret) {
> > +               perror("Multi-cmd ioctl");
> > +               /* In case multi-cmd ioctl failed before exiting from f=
fu mode */
> > +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> > +               goto out;
> > +       }
> >
> > -               ret =3D read_extcsd(dev_fd, ext_csd);
> > -               if (ret) {
> > -                       fprintf(stderr, "Could not read EXT_CSD from %s=
\n", device);
> > -                       goto out;
> > -               }
> > +       ret =3D read_extcsd(dev_fd, ext_csd);
> > +       if (ret) {
> > +               fprintf(stderr, "Could not read EXT_CSD from %s\n", dev=
ice);
> > +               goto out;
> > +       }
> >
> > -               /* Test if we need to restart the download */
> > -               sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> > -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] <=
< 8 |
> > -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] <=
< 16 |
> > -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] <=
< 24;
> > -               /* By spec, host should re-start download from the firs=
t sector if
> > sect_done is 0 */
> > -               if (sect_done =3D=3D 0) {
> > -                       if (retry > 0) {
> > -                               retry--;
> > -                               fprintf(stderr, "Programming failed. Re=
trying... (%d)\n",
> > retry);
> > -                               goto do_retry;
> > -                       }
> > -                       fprintf(stderr, "Programming failed! Aborting..=
.\n");
> > -                       goto out;
> > -               } else {
> > -                       fprintf(stderr, "Programmed %d/%jd bytes\r", se=
ct_done *
> > sect_size, (intmax_t)fw_size);
> > +       /* Test if we need to restart the download */
> > +       sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> > +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
> > +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
> > +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
> > +       /* By spec, host should re-start download from the first
> > + sector if
> > sect_done is 0 */
> > +       if (sect_done =3D=3D 0) {
> > +               if (retry > 0) {
> > +                       retry--;
> > +                       fprintf(stderr, "Programming failed. Retrying..=
. (%d)\n", retry);
> > +                       goto do_retry;
> >                 }
> > +               fprintf(stderr, "Programming failed! Aborting...\n");
> > +               goto out;
> >         }
> >
> >         if ((sect_done * sect_size) =3D=3D fw_size) {
