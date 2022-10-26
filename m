Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D476CC38A2D
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Oct 2022 07:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiJZHCE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Oct 2022 03:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiJZHBs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2022 03:01:48 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4976938687
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 00:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666767705; x=1698303705;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=7zaYVwlxQApMBfEBiP7qASl3hF+dpGSEmltsEnJ65ls=;
  b=kRGcl4okYmT/B68nty1fTNwJeKnaWPJVrlF5NtmhjBa8AU7YSfMKcb+A
   swROeMMLz/ItvtDRki032jleGk4sDZol83SdkX1s4A1wFo7pbsRSBDFah
   nxS73nFx5hrWfoDxtcU1rb32Ym2kInutu6X4C+f/WKl8TD3+ir8O/jXMA
   XaZGYW2X/66ry5eMToDel2nNNLu7JUJt5rwRO5g6ORkfUuuZFaC2eaFhm
   4PML78MwCor+K5BBpl84x13JVw1Qjt4ytR38WHHOks6Cof7j05qli++oX
   RMVWnpyWagKXAYJRd+Q95RPKBSUk+iZYQ3uz934JFsO5LsvyHUKxBz3wd
   g==;
X-IronPort-AV: E=Sophos;i="5.95,213,1661788800"; 
   d="scan'208";a="319087086"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2022 15:01:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEMixKHaWOM4yOg4qyo/Xe2+8jX3aviYKGCSuI2oJOYlgj9we/S2avZkCcbawBYsYkZecPr07korT3C96X8eTSAHnJg+99xDIg878NATTgFT0QO3F//7nuy+7LljOtqVBcIndqXCsUtQM+NatNjPLsu2xPNzMwBmR/YqWmWdHaVCxlwS/vg3wfryYvwvFVlWuQgWOWpPlT/jha1CYmW9l5lYUnnrq44ThqtAZTwEn80qVP4/q4glXu950NHf5BzyOFJBXyghX3GKgazCFSM1OKa3ybXefTAt7LJlEWY+9+35xpiR+ynxFIx4Eby9YM/odl//lL+LFy6D6eWDKeb32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O+8FIKKlhFmooC2vRSkDvScz8BDTMl0Qx6kosvQvI8=;
 b=YFIKzEF+QbQl/ZSgeWo5PhVYjZI7kuSFN2zrT61ulRkjusXVP/ZpErL17QgLjLXuyKZV5HwtSPUYKV5C+tW5IL/7OnZo/bNTvPEEghZKoutTP8kNeix0dsXOaOMZCXVHBxH0VGXWXuTrqZLGabqEcWRz4O3LWVELZ+9HWoztzVx8sGBzjckY4d+RNy39LvtmUB8DLCNBCJXSDFP+SAEyf+wE80D/Qpn1O7Jzb/RTqi98W/+VdqPuqp02HMZT3KYqyno3QJSotVfiGOHshkQPHgcAH0/+oOLmqhyZx1Nf2SkHRtGN6g/LBgV67EGpZ7h4D9MU7KkvYa6qMIwaurajMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O+8FIKKlhFmooC2vRSkDvScz8BDTMl0Qx6kosvQvI8=;
 b=vwr17kZ9NMJdZzXHdEr63RT0sjnR59YAGJlVRdy3VDQ06owLBkuMOOfE3H1ucBknjaGNP1He4JKYB8Pj5tuZB6dkGy/FngwVfyPfkWmToWqrAxif5pFBSXzp0F1Y+MiE5Ep8OWL5WyTt4YEFe6sixJQx/s9iRKtdrtHFouefMKE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CY4PR04MB0422.namprd04.prod.outlook.com (2603:10b6:903:bd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Wed, 26 Oct 2022 07:01:40 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5746.025; Wed, 26 Oct 2022
 07:01:40 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCHv2] mmc-utils: Implement alternative boot operation
Thread-Topic: [PATCHv2] mmc-utils: Implement alternative boot operation
Thread-Index: AdjorSj2mV2UKSdoTC2L2EHef1IaSwAVfldgAAFZPjA=
Date:   Wed, 26 Oct 2022 07:01:40 +0000
Message-ID: <DM6PR04MB65753BA8C55225E33CAC08CBFC309@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <660600d1ad5949cea4fc3088a16af634@hyperstone.com>
 <DM6PR04MB65758545BDF585D9E62EEBEFFC309@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65758545BDF585D9E62EEBEFFC309@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CY4PR04MB0422:EE_
x-ms-office365-filtering-correlation-id: 3e04e8d7-08c6-4452-754b-08dab71feedc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VSYmcdaouYGUKgR5WkLgsvkR+gvV432CgMQE3U2LKqDk1dqSj2rKtW1b+CECbQu7Fvd2JCs8H4TD7l4FQQdqYPuve2Yu7LpMC1EvoGlN06kCNJvdIii7rBefJi90ubuEFt5VVsJfTnnc93tJ/CdSf+eu9TBCditt0jn/cZ8AH+FG+N0fRmMeasVI2XOGKiwMgAAY45jGGslGrAeFvFTOsZGKScLveRSPPlg8o7rtqfjS4ZyUy7XzVfAwqg9lKTb7OvIB2OiMECu0OOiTzshxso3/uV5dSFSJLjq11WBCDeXV6HIP2mvvdMrtYc2QNRWHA8mp+y3mGFh8m+m6yHkk29Nj4IbT4tW/l8P4yjpVXepAn5tFs0SyfhJE89R7DILZcBfm3uqNj3q3zKrFfIxQXTX2Hzd8ZvIVpAcVbpYaDXwayHvFMweHA2GyH1HSh0TyIulapIU/a8B8qeGDphvoK4+17XOCAib3d4vK8exOb1VZgWhGiLnjkEbPd0yXCwXr71rBnKOgZkTozK+sHAlExJl6r1WTvlDr7xFL5dEh1UV5BUYDXdSAL8Yz2i7VjciEFc3WyJbwyb/jVuoMaBFdi8v8qTjxKZkyVgFD3CA8N59SJLeEF+I7YSzv1ae+8i40Rh6epuQBqTC7kQ8n5x3XMkGdlHBJvBewwbR/Iqym4iYakb5YbsyGcLKUOcmJrK1PRbioMC6msxEAQuj7ncWfcGYYIP0Y5NMb6+fk0MHtM2ZVaQ9zRaG4OBo3GTELFNZJKRzgXVvxIpFp4TqxdjT/Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(66946007)(76116006)(66476007)(64756008)(83380400001)(38070700005)(66446008)(478600001)(66556008)(8936002)(8676002)(52536014)(41300700001)(71200400001)(5660300002)(316002)(33656002)(55016003)(186003)(2906002)(110136005)(9686003)(2940100002)(122000001)(38100700002)(7696005)(82960400001)(86362001)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4XKOU3egb3uFOKibuZOsm4Wu+Omur1m7K3vyQBUN+FdqY9wDfXrvnKXD74?=
 =?iso-8859-1?Q?T82w/979LJbHGBKlNBAiqRC8OHyjc1TbBGmRB4wF5itUt1jAXke9wLF4Y0?=
 =?iso-8859-1?Q?yXemZgm+INFKRotjalAdi+/gJSdFVhw5jww6Bp7FKHj7ema0Z/ekS2LTgn?=
 =?iso-8859-1?Q?6eZrxMzOj0EVighZK6r2HDRAe8tZOgm9F4BkU54Tp1cRYSKHDCgX5LOy+C?=
 =?iso-8859-1?Q?x+CmwssI8WFp6tS7vpD30WwdH8RHqdLXAn7D9rw0xcw210yieWqzd4R0aW?=
 =?iso-8859-1?Q?UuNMnf2libUuFXMaI24FgFSCAXpyUl7Hb4ctlVSHhYREZcDCk49k+Ubiv7?=
 =?iso-8859-1?Q?3lKJG29j4+rjvKOSkp7+7UYAouRscwBb3Mtas2JhSwuA19wxpMBvgrV5UV?=
 =?iso-8859-1?Q?M10MW9WfSsuxIKyQysmf53hwten47BjJhgaa7p1nkp1pg49eyhCXS3KbdD?=
 =?iso-8859-1?Q?wcO5+pEQGIfPvCwZb2PplBk4VsVZMrehlMlYjhzs41CDO6+gbOTvJ5T7he?=
 =?iso-8859-1?Q?sG1sGfq/6VggllEa758wJJLCj7e8CCfxtX7TA85tRfnKw21UwupKD+mF1G?=
 =?iso-8859-1?Q?W3a0QwtO7rLaTIKg1+XWfH4nV0hc9sQPafkCWaoqyafaKjgS7WEh6b7Wwq?=
 =?iso-8859-1?Q?rQrIp1197PZ/AZx2PrNW8P07/dlRL4EqRYkDCQYL+YQEJOeg/ONIG63+6Z?=
 =?iso-8859-1?Q?uEM2u69WjLCc14uBb2rHPdryJ9YamaCgFIjbeVULSA35mAnIWS1Wkm6JiB?=
 =?iso-8859-1?Q?zU+auUi0bnyMxo8aaQZFxVsDyAUTPTHXcum7mNaZjN30LF0zIXf6ZIraRP?=
 =?iso-8859-1?Q?xdTI+Qziii5/4iGtoHfnBduJz97nmDrKCpafJFH0oH2Op9CjrpCfhVI+EX?=
 =?iso-8859-1?Q?EyGP7ru2xdFReJ/KxX10oA3Epk2TneKiendRidqaY1klIJmWeuZVU9Togh?=
 =?iso-8859-1?Q?RSEysrS1cuRj0VTF7mLmVArMyC9NNP+84Kajtkb0j5nEUmf5ZwZeqwZeSR?=
 =?iso-8859-1?Q?lmRLSjPm9l6pxpi2QLr/mYmOvTfcBalpQo6xZTOS6Mggrmy7UEAhmAfo0K?=
 =?iso-8859-1?Q?CT8va6kT1x16dX4eDfaq5ug/K5pv2c/H6/GIvLmuTy00WVcDUJQxytnxQ5?=
 =?iso-8859-1?Q?/q0gYV7vH46axhW9RVcYAWShKiO7gXIHqssrw0s8uhED52WTj/rP0B5+V9?=
 =?iso-8859-1?Q?JYJ0t8kz1KkdjB8xmtjEifhcTDGbFeux02UmuXCPzKJ/ut8wyx13Ri292a?=
 =?iso-8859-1?Q?SOE89Zv0SkM3FneSQ4lDzp0fBxTwgUy55AjiPV/5CS+WmQzeNHCiZ7dr23?=
 =?iso-8859-1?Q?4ehF6AY0GFyzdzAdSTorCliDzalffIEnesUDlmbfgXXa6uiJfPX96ea1rM?=
 =?iso-8859-1?Q?aHHRP0rTx01D4ALYXczXrmoHiuma9m78uB80chAIilsUF7fRILsgFgzSMR?=
 =?iso-8859-1?Q?WHLP45ne+MdlW+5wuW9WjkqmbrVdjuM8lzhL7FmX7yb8VpPILz7/c6SfNq?=
 =?iso-8859-1?Q?Y6d0xHffAQElj5qmXdRN2ULKOrb7IEx4x9UaGBaXfZ7O/bqveCKd9EE4Jn?=
 =?iso-8859-1?Q?uF54k3YNToEzSzYg8v7RhekyvfclxT0F+47gqW3rv6ppHguq514dU5L1vu?=
 =?iso-8859-1?Q?2PZKq5LCiVztPDC9TDarReKL9j1XqoDLmI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e04e8d7-08c6-4452-754b-08dab71feedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 07:01:40.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U94/AI4gcpQyklDbN/IJEwb9iUhBignnDTFS0SRoi3MgkQQHP5KpT2KCAf7fSZWfqcsVuR1D0IHiAsNaSkvxPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0422
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


> > Implements the alternative boot operation for eMMCs.
> > Note the limitations of the help.
> >
> > This is mostly useful for testing purposes if you set up the boot
> > partition configuration correctly.
> >
> > Usage:
> > $ sudo dd if=3D/dev/mmcblk2boot0 of=3Dbootdatammcblk count=3D2
> > 2+0 records in
> > 2+0 records out
> > 1024 bytes (1.0 kB, 1.0 KiB) copied, 0.00482308 s, 212 kB/s
> >
> > $ sudo ./mmc boot_operation bootdata /dev/mmcblk2
> >
> > $ diff -s bootdata bootdatammcblk
> > Files bootdata and bootdatammcblk are identical
> >
> > Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> Few nits below.  Other than that -
Sorry - you also forgot to add the check of alternative boot support:
(ext_csd[EXT_CSD_BOOT_INFO] & EXT_CSD_BOOT_INFO_ALT)

Please do.

Thanks,
Avri
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
>=20
> > ---
> > -v2: Frees, closes, removal of boot_blocks parameter and boot ack check
> >  mmc.c      | 12 +++++++
> >  mmc.h      |  3 ++
> >  mmc_cmds.c | 99
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  mmc_cmds.h |  1 +
> >  4 files changed, 115 insertions(+)
> >
> > diff --git a/mmc.c b/mmc.c
> > index 170ee39..adcd814 100644
> > --- a/mmc.c
> > +++ b/mmc.c
> > @@ -255,6 +255,18 @@ static struct Command commands[] =3D {
> >           "Issues a CMD0 GO_PRE_IDLE",
> >           NULL
> >         },
> > +       { do_alt_boot_op, -1,
> > +         "boot_operation", "<boot_data_file> <device>\n"
> > +         "Does the alternative boot operation and writes the
> > + specified starting
> > blocks of boot data into the requested file.\n\n"
> > +         "Note some limitations\n:"
> > +         "1. The boot operation must be configured, e.g. for legacy sp=
eed:\n"
> > +         "mmc-utils bootbus set single_backward retain x8 /dev/mmcblk2=
\n"
> > +         "mmc-utils bootpart enable 1 0 /dev/mmcblk2\n"
> > +         "2. The MMC must currently be running at the bus mode that
> > + is
> > configured for the boot operation (HS200 and HS400 not supported at
> > all).\n"
> > +         "3. Only up to 512K bytes of boot data will be transferred.\n=
"
> > +         "4. The MMC will perform a soft reset, if your system cannot
> > + handle
> > that do not use the boot operation from mmc-utils.\n",
> Theoretically, this shouldn't happen unless you send additional cmd0/0x0.
> But I guess it's a reasonable decision for the device to make if it doesn=
't get
> one, or cmd1.
>=20
> > +         NULL
> > +       },
> >         { 0, 0, 0, 0 }
> >  };
> >
> > diff --git a/mmc.h b/mmc.h
> > index 6511dbc..4de0aae 100644
> > --- a/mmc.h
> > +++ b/mmc.h
> > @@ -24,6 +24,7 @@
> >  #define MMC_GO_IDLE_STATE         0   /* bc                          *=
/
> >  #define MMC_GO_IDLE_STATE_ARG          0x0
> >  #define MMC_GO_PRE_IDLE_STATE_ARG      0xF0F0F0F0
> > +#define MMC_BOOT_INITIATION_ARG                0xFFFFFFFA
> >  #define MMC_SWITCH             6       /* ac   [31:0] See below       =
 R1b */
> >  #define MMC_SEND_EXT_CSD       8       /* adtc                        =
 R1  */
> >  #define MMC_SEND_STATUS                13      /* ac   [31:16] RCA    =
    R1  */
> > @@ -97,6 +98,7 @@
> >  #define EXT_CSD_CACHE_SIZE_0           249
> >  #define EXT_CSD_SEC_FEATURE_SUPPORT    231
> >  #define EXT_CSD_BOOT_INFO              228     /* R/W */
> > +#define EXT_CSD_BOOT_MULT              226     /* RO */
> >  #define EXT_CSD_HC_ERASE_GRP_SIZE      224
> >  #define EXT_CSD_HC_WP_GRP_SIZE         221
> >  #define EXT_CSD_SEC_COUNT_3            215
> > @@ -107,6 +109,7 @@
> >  #define EXT_CSD_REV                    192
> >  #define EXT_CSD_BOOT_CFG               179
> >  #define EXT_CSD_PART_CONFIG            179
> > +#define EXT_CSD_PART_CONFIG_BOOT_ACK   (1 << 6)
> Already exist - EXT_CSD_PART_CONFIG_ACC_ACK
>=20
> >  #define EXT_CSD_BOOT_BUS_CONDITIONS    177
> >  #define EXT_CSD_ERASE_GROUP_DEF                175
> >  #define EXT_CSD_BOOT_WP_STATUS         174
> > diff --git a/mmc_cmds.c b/mmc_cmds.c
> > index 3db17e1..b7efe5a 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -3101,3 +3101,102 @@ int do_preidle(int nargs, char **argv)
> >
> >         return 0;
> >  }
> > +
> > +int do_alt_boot_op(int nargs, char **argv) {
> > +       int fd, ret, boot_data_fd;
> > +       char *device, *boot_data_file;
> > +       struct mmc_ioc_multi_cmd *mioc;
> > +       __u8 ext_csd[512];
> > +       __u8 *boot_buf;
> > +       unsigned int boot_blocks, ext_csd_boot_size;
> > +
> > +       if (nargs !=3D 3) {
> > +               fprintf(stderr, "Usage: mmc boot_op <boot_data_file>
> > </path/to/mmcblkX>\n");
> > +               exit(1);
> > +       }
> > +       boot_data_file =3D argv[1];
> > +       device =3D argv[2];
> > +
> > +       fd =3D open(device, O_RDWR);
> > +       if (fd < 0) {
> > +               perror("open device");
> > +               exit(1);
> > +       }
> > +
> > +       ret =3D read_extcsd(fd, ext_csd);
> > +       if (ret) {
> > +               perror("read extcsd");
> > +               goto dev_fd_close;
> > +       }
> > +       if ((ext_csd[EXT_CSD_PART_CONFIG] &
> > EXT_CSD_PART_CONFIG_BOOT_ACK)
> > +                       =3D=3D EXT_CSD_PART_CONFIG_BOOT_ACK) {
> Redundant rhs?
>=20
> > +               perror("Boot Ack must not be enabled");
> > +               ret =3D -EINVAL;
> > +               goto dev_fd_close;
> > +       }
> > +       ext_csd_boot_size =3D ext_csd[EXT_CSD_BOOT_MULT] * 128 * 1024;
> > +       boot_blocks =3D ext_csd_boot_size / 512;
> > +       if (ext_csd_boot_size > MMC_IOC_MAX_BYTES) {
> > +               printf("Boot partition size is bigger than IOCTL
> > + limit, limiting to
> > 512K\n");
> > +               boot_blocks =3D MMC_IOC_MAX_BYTES / 512;
> > +       }
> > +
> > +       boot_data_fd =3D open(boot_data_file, O_WRONLY | O_CREAT, 0644)=
;
> > +       if (boot_data_fd < 0) {
> > +               perror("open boot data file");
> > +               ret =3D 1;
> > +               goto boot_data_close;
> > +       }
> > +
> > +       boot_buf =3D calloc(1, sizeof(__u8) * boot_blocks * 512);
> > +       mioc =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> > +                          2 * sizeof(struct mmc_ioc_cmd));
> > +       if (!mioc || !boot_buf) {
> > +               perror("Failed to allocate memory");
> > +               ret =3D -ENOMEM;
> > +               goto alloced_error;
> > +       }
> > +
> > +       mioc->num_of_cmds =3D 2;
> > +       mioc->cmds[0].opcode =3D MMC_GO_IDLE_STATE;
> > +       mioc->cmds[0].arg =3D MMC_GO_PRE_IDLE_STATE_ARG;
> > +       mioc->cmds[0].flags =3D MMC_RSP_NONE | MMC_CMD_AC;
> > +       mioc->cmds[0].write_flag =3D 0;
> > +
> > +       mioc->cmds[1].opcode =3D MMC_GO_IDLE_STATE;
> > +       mioc->cmds[1].arg =3D MMC_BOOT_INITIATION_ARG;
> > +       mioc->cmds[1].flags =3D MMC_RSP_NONE | MMC_CMD_ADTC;
> > +       mioc->cmds[1].write_flag =3D 0;
> > +       mioc->cmds[1].blksz =3D 512;
> > +       mioc->cmds[1].blocks =3D boot_blocks;
> > +       /* Access time of boot part differs wildly, spec mandates 1s */
> > +       mioc->cmds[1].data_timeout_ns =3D 2 * 1000 * 1000 * 1000;
> > +       mmc_ioc_cmd_set_data(mioc->cmds[1], boot_buf);
> > +
> > +       ret =3D ioctl(fd, MMC_IOC_MULTI_CMD, mioc);
> > +       if (ret) {
> > +               perror("multi-cmd ioctl error\n");
> > +               goto alloced_error;
> > +       }
> > +
> > +       ret =3D DO_IO(write, boot_data_fd, boot_buf, boot_blocks * 512)=
;
> > +       if (ret < 0) {
> > +               perror("Write error\n");
> > +               goto alloced_error;
> > +       }
> > +       ret =3D 0;
> > +
> > +alloced_error:
> > +       if (mioc)
> > +               free(mioc);
> > +       if (boot_buf)
> > +               free(boot_buf);
> > +boot_data_close:
> > +       close(boot_data_fd);
> > +dev_fd_close:
> > +       close(fd);
> > +       if (ret)
> > +               exit(1);
> > +       return 0;
> > +}
> > diff --git a/mmc_cmds.h b/mmc_cmds.h
> > index faab362..5f2bef1 100644
> > --- a/mmc_cmds.h
> > +++ b/mmc_cmds.h
> > @@ -49,3 +49,4 @@ int do_erase(int nargs, char **argv);  int
> > do_general_cmd_read(int nargs, char **argv);  int do_softreset(int
> > nargs, char **argv);  int do_preidle(int nargs, char **argv);
> > +int do_alt_boot_op(int nargs, char **argv);
> > --
> > 2.37.3
> >
> > Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing
> > Director: Dr. Jan Peter Berns.
> > Commercial register of local courts: Freiburg HRB381782

