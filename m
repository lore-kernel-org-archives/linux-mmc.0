Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AD1C43334
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 12:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiGRMZP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiGRMZO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 08:25:14 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CEE222
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 05:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658147111; x=1689683111;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=p37MpsRfojYhHDKi0MUowrdJ7jjAodxgbCtep32Ijds=;
  b=Kodt4McHbyA+uay52gzGXVx5Z33S2CrQRt3wnIDJg+CbQ6hU/GbXK9Er
   nijiHhg5K7opdqBiHIe5ONxgQ75OVvKR2WU6Difwq2fVGiM2B0CsmBtVh
   RCy1rF305/cVGPfXQRgU6dFUwLthrjhXOTOZq3m9prRb8le1bvSYYty++
   9IgUKPFsR36xtcJyEtLWFzmsiLS2oU6b86CkZjX/z4u5BqKVu3p6RYUA9
   tnXTgWHGUKrwkC27w8gaiBwERKkEQ0+/QM+7BqRKcapvWsA4VCMsQwUFo
   vB/O/xXkTQL+KNyh1nlG+vCVDo+3/be12Os99AsCNh5z+KvPTbuh6EC/j
   w==;
X-IronPort-AV: E=Sophos;i="5.92,281,1650902400"; 
   d="scan'208";a="206043933"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2022 20:24:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pzje+CV7APo5bPIr+iJ6FmLxScbEG4CJCa2k+gkR/IIGzUJSsBRt6TQgsbydDuWnl0SW9YqCc8tAPnV3DZLKvybcSBYI5aG0P7SfOYn6/VCbULSL9AFx6kDAwHNEpaNfzYVrN7EsujZ5mKvpsFrX14kz5jbSkwA/xgXRkj6auTe88hI32F8GSYYGAmK73ujloGhNW2BbkKEUyp4uX8hJaJOePBqKrsAYPxs+k9UZnG3dDPG4M1RRUbK+pxFfgnjOsd2tNSPkAY4/lNQk1cTG48G+RZGzX2pg9ywt22duI27oMSn6k6UNmUT2VWWE3lGKhVOo33NUD8ahnIsM33bP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uoo6mWDJkNCz4GmdQvTRWEix70OhqwEgvY4ojsTg44U=;
 b=kJV/Pf6Y585LDouMzyLnwR7sy/vMDHzzlnBNlEQvZdyIThfROkuP6LGoTu+fjJMhea4ggvDsDyNJeYsAdUz3EgWYlBiYSjpqSTFI1dYDt6GeKveGPJcQt7jEX6EVaSLIOgfn4JCWdLZXo2taMC5vG8Fz712xHnFP+N/hwXGiAY/BR0PEjEGZ10p8i2yuIcrGBjthaV7XHwT3CtfKmfT7cDglufzLdoCEkIAc4JT/BMRwX5yE/vjrpYHNG3jjewmbHiDTTO3uur0owDM6gkfSE06rtSbcw82McW+qGd1wc6FrpgoexkIpJ5FKqZ9J8Hjpik9kCQIQSv8jbvyTfaFJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uoo6mWDJkNCz4GmdQvTRWEix70OhqwEgvY4ojsTg44U=;
 b=HgXMVRXkZ7V0duMy7xn1DBzk+5otAtW5TqNIScsZeSYg8CJ0dTNOfZrQ+UcWSJcXQe8CKoz2iYNJZcv6IbzdBSDfwkiWXBGDzcE7o7x46wcIIVNx6Sp34gzJwaFF3GjknhNeUb6JhyfK/iqsCG/zHMiI/Bay591fXheL3pih/+U=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6421.namprd04.prod.outlook.com (2603:10b6:a03:1e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 12:24:46 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%9]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 12:24:46 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Christian Loehle <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Add softreset command for issuing CMD0
Thread-Topic: [PATCH] mmc-utils: Add softreset command for issuing CMD0
Thread-Index: AdiaoDZBaBhbwaxFRXm22iF8+GujggAAGung
Date:   Mon, 18 Jul 2022 12:24:46 +0000
Message-ID: <DM6PR04MB6575A42E7EFD93C235BD5AA7FC8C9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <fee2ce51a200442f90bea0668466a2b1@hyperstone.com>
In-Reply-To: <fee2ce51a200442f90bea0668466a2b1@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e795bdc5-cf2d-48ec-8c9d-08da68b88055
x-ms-traffictypediagnostic: BY5PR04MB6421:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CGwLDCVDNg042CjAkIYA50/qcHsZ9kCMhhh/Lc8OFuw0H9OwPaxV/I9p7KrXu8+wBcClhqJDVoIsRHVd3bmh4UulZWXdV564t32uH+vYB9vIBWY8zwXBuEqjjv7v30HG/hgVtCif2RZbXTKV1p52QYp4Mcp9l7FnIPBrepBKOk5DKxeZw8cDpNDuZ9XCW30P2dF30DQsfY/gnj/LAWNHMtvzqU2dU2vytENW5Xn0ivs5+lXbCzs0oXhvR7Z3mZbdMNIld2kUPuBrS+S7i8JG44w/uvDqDyzkfoPw4ZAVvjmGeZh/9d18h6BYaSshX/46Tm3yHAQR3wg8Zdk/29WCgjY7upxpFr2XCumovlKTpQJj5UVIDGESnFLJgfVbx6xOrtTkycsHZ0C40s5Igd7iPYInkU3Jc4+VovYzi+i7uKMVV9tgE2LD8GPJG0JtinGrsDDRNqpA+riR8dJtvh1fhXAMWVG+1p844gHcqwwuzwBgTLYl5mPz/VYpW/6PXEO2dANL1B5ENUSk/TXy2avbEAT+6EystN5XH712HEnG5/ZJ0EKKRv0NVDv2JwV/4zF1cogGUjEJgOAjZUU2NoyAHUE5PsyttT1rycMzpOdNxuWVFC7vkmiGk3u8aJivWl4d66GWgg9FEo101Ysvbl9ayhC/DYCIgVd0TkWG16DXC+FaIVdOxDfmbltzsK1WJtxwl8Kd5l37/U0PPU5JBt4XvEj0wECoQ9aNHzSjG7JZm+rY0w8bw4B8JjAcUQw1VAKC9nG8kuXrAbieQydi+mClgdP1uknEs6xNN9OR9q9Fcubl/UzTNtvae5GvcoEevRY4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(33656002)(86362001)(8936002)(52536014)(38100700002)(8676002)(55016003)(66556008)(66476007)(38070700005)(66446008)(64756008)(66946007)(76116006)(6506007)(110136005)(82960400001)(7696005)(316002)(26005)(83380400001)(41300700001)(9686003)(186003)(478600001)(5660300002)(122000001)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dnq6SR7OFtxCJRO5mPzgUkJe5Tc0/Ls48HgMpRMME31Oeff+Knyt8+oyiDc8?=
 =?us-ascii?Q?TQJZa6VP6cxJfcS+nFGKm5MEbSrTrN1TAx5CYW09N7pxTvH/Q8G2s1KZ8h/x?=
 =?us-ascii?Q?H4KuNnzUqy0c7VneSllmjPlZTePpH93EQGM+mzrr0Bu3zD12RCqwtXPwT5JY?=
 =?us-ascii?Q?950miYCgqQHjt+5i10Qmy9wzSiwlCdxM9gRWkGnCF3CJ+RT/0U1qz1yy37wI?=
 =?us-ascii?Q?ZAPlrGG3ZtUreEJlgEEgGrYhkTX3IzPTZwI7AlKHuVRuSchoFp03Eh+6b+c8?=
 =?us-ascii?Q?XncjRe4nQARaGlqTUs4+mx6Qy5Z5mPDoiwmarL+ljZDfrxn7BvMxFU6BRyP4?=
 =?us-ascii?Q?xfNmd+iPryhz3/NIP/TsoPi3nTzEVN8IvAJNc3A8RzOvhPvobi8oA77WzwxM?=
 =?us-ascii?Q?MvmuChpIO0BOJkWZvvzVD5IE86y4QMzT6zshSMIDrWX32IuwRkTcm5l6DRDF?=
 =?us-ascii?Q?ZxoMLm4IcjtDbY8Rdta0t8ATuvRSwESFmnDl3Pu44WdXviaXOCDM8Yfyj6Hn?=
 =?us-ascii?Q?WQPonQnWOnOzmpL1TlMhGs//JgOcWxuHSk4nRyeeOtBjM0OMpQergutg84Oo?=
 =?us-ascii?Q?K8BcghVpWhqVeiYckAlIyrHfN7CBuDFpNKd1syZuDqO8JVQtKTHHFEYugYYA?=
 =?us-ascii?Q?BdMRJtV8tRcsaD8iSDvchjon9X/UL5nJFcJIkrSErtcfC+0m5DRkDFJ6M+SU?=
 =?us-ascii?Q?gJQ1azs/ucPj7WSBMQq87dSez5dQtNdxi6LEogEKbzNnBhtXCSqeOESGztYM?=
 =?us-ascii?Q?x2B2zC8wytOdqyNjw9M9kstC9rrcm7LNsOkXoZm8Q2ulbtgjmneGpD+yKkvr?=
 =?us-ascii?Q?TcdJp1SMbnLMQV+ieABu5AdeMnjTsM13QIsdd7TreB1m6NSMXKCydhTBWy6i?=
 =?us-ascii?Q?O4RXJtLDALtdxnQqYcT6oQohzqwfCE1X3wq2CnqSUM3AzOnyuNsuQl4lzFyu?=
 =?us-ascii?Q?bV/EfB9LbO899nIMKQ7yRTzDYxt7hFaJHV4ZeHk3Hjnu1CYcI/g+LZT8cNe8?=
 =?us-ascii?Q?OBBTT4bcy9yN8IADhQmut6Ef2SVFhdfErzO/o762wACbzq7RZx8KesBltJcU?=
 =?us-ascii?Q?e+Lj52vTcMz0fTd2KovEr+oQp779zFlpkShCPo1wWqQRi7ZmYmCU958Fl4m8?=
 =?us-ascii?Q?AS5V1HwGxQbS+EPFkgsneMtk8zLdKjf0sq9Hqr5+cqy55mSuZ4G7K7RQVb1F?=
 =?us-ascii?Q?tH17XRTSzlwzXfXamz3kht2PmoWhUdEtf9s9U3uxYUm9X0e1e0iS5O6GuBkj?=
 =?us-ascii?Q?p3K2eM6/40SSVBuBTszcHJzUn6ACkC34TyEgYadjQLSAUQFNNsCCv7JGJHxu?=
 =?us-ascii?Q?LoJH0m53kkrVJR5+0CmZmL/3tZQWBa29Bv62oOy8H13Pb8cQxBllocQkJi+n?=
 =?us-ascii?Q?JZPFHdp28wgA+c/6AXAAzgVbXilbq+UZMoWHoLzDC0x3odj1XBwbzzOxHg67?=
 =?us-ascii?Q?HhP8zVrNDzNUaCagt6GpCMaleze5LaPsmRNUKdwGtNFoVKg9ak/+j7m4K0cC?=
 =?us-ascii?Q?/6r82Swirt28GGZN9sABb+RTLwgtsVhxcUl1SzMnxhkL9pBZfx6rTAQBr0BJ?=
 =?us-ascii?Q?PKOOo3evo6x3vN1UjC/S8sN14umHPn8AenCNjR4o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e795bdc5-cf2d-48ec-8c9d-08da68b88055
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 12:24:46.2083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIsfUGnzaNgpg4eGBOVUAlot5YmfcMEXGGnhV9Of19mWAKfCU8qdJJpG35qNYOfwBrDkfcgtH0lsNcgoMPk++A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6421
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

>=20
> CMD0 may be used to see if the hardware can handle a UHS card
> that completed the voltage switch. If a UHS card has problems
> coming back up after CMD0 your hardware may not support a hard
> reset properly.
I think it's a useful addition, not just for that reason.
Specifically to test hw-reset support, I think you should use the GO_PRE_ID=
LE_STATE option.

>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  mmc.c      |  5 +++++
>  mmc.h      |  3 +++
>  mmc_cmds.c | 30 ++++++++++++++++++++++++++++++
>  mmc_cmds.h |  1 +
>  4 files changed, 39 insertions(+)
>=20
> diff --git a/mmc.c b/mmc.c
> index 6c56387..ba2c883 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -245,6 +245,11 @@ static struct Command commands[] =3D {
>                 "be 1.",
>         NULL
>         },
> +       { do_soft_reset, -1,
> +         "softreset", "<device>\n"
> +         "Issues a CMD0 softreset, e.g. for testing if hardware reset fo=
r UHS
> works\n\n",
> +         NULL
> +       },
>         { 0, 0, 0, 0 }
>  };
>=20
> diff --git a/mmc.h b/mmc.h
> index daff62c..9796d2e 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -21,6 +21,7 @@
>  #include <linux/mmc/ioctl.h>
>=20
>  /* From kernel linux/mmc/mmc.h */
> +#define MMC_GO_IDLE_STATE         0   /* bc                          */
>  #define MMC_SWITCH             6       /* ac   [31:0] See below        R=
1b */
>  #define MMC_SEND_EXT_CSD       8       /* adtc                         R=
1  */
>  #define MMC_SEND_STATUS                13      /* ac   [31:16] RCA      =
  R1  */
> @@ -226,6 +227,7 @@
>=20
>=20
>  /* From kernel linux/mmc/core.h */
> +#define MMC_RSP_NONE   0                       /* no response */
>  #define MMC_RSP_PRESENT        (1 << 0)
>  #define MMC_RSP_136    (1 << 1)                /* 136 bit response */
>  #define MMC_RSP_CRC    (1 << 2)                /* expect valid crc */
> @@ -234,6 +236,7 @@
>=20
>  #define MMC_CMD_AC     (0 << 5)
>  #define MMC_CMD_ADTC   (1 << 5)
> +#define MMC_CMD_BC     (2 << 5)
>=20
>  #define MMC_RSP_SPI_S1 (1 << 7)                /* one status byte */
>  #define MMC_RSP_SPI_BUSY (1 << 10)             /* card may send busy */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 12b7802..c027cfa 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -3039,3 +3039,33 @@ out:
>         close(dev_fd);
>         return ret;
>  }
> +
> +int do_soft_reset(int nargs, char **argv)
> +{
> +       int fd;
> +       char *device;
> +       struct mmc_ioc_cmd idata;
> +
> +       if (nargs !=3D 2) {
> +               fprintf(stderr, "Usage: mmc status softreset
> </path/to/mmcblkX>\n");
> +               exit(1);
> +       }
> +
> +       device =3D argv[1];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       memset(&idata, 0, sizeof(idata));
> +       idata.opcode =3D MMC_GO_IDLE_STATE;
> +       idata.flags =3D MMC_RSP_NONE | MMC_CMD_BC;
How about adding all 3 flavors of soft-reset: GO_IDLE_STATE, GO_PRE_IDLE_ST=
ATE, and BOOT_INITIATION.
There can be 3 different command, that calls the same __soft_reset helper, =
or whatever.
What do you think? =20

Thanks,
Avri

> +
> +       /* No need to check for error, it is expected */
> +       ioctl(fd, MMC_IOC_CMD, &idata);
> +       close(fd);
> +
> +       return 0;
> +}
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 0f7c004..c112a95 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -47,3 +47,4 @@ int do_read_cid(int argc, char **argv);
>  int do_read_csd(int argc, char **argv);
>  int do_erase(int nargs, char **argv);
>  int do_general_cmd_read(int nargs, char **argv);
> +int do_soft_reset(int nargs, char **argv);
> --
> 2.36.1
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

