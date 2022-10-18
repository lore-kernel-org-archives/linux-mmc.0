Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F22C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 10:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJRKRJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJRKRI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 06:17:08 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5D7ACA0A
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666088224; x=1697624224;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=SlS2fJ8mAIGU79O7jHm18hZospfs33Uda+WIL7miWxo=;
  b=HBCoMC13fH/JsXpELea1xJalyVvUxDtytmJGsTcYMEQ3chkP1quySR6J
   K46+27jrUjl0bzUv5Qt9ZAZO9v06N7RikRkCYDHN6fJ+GczIH5NnwWg9B
   MTlNUdtlXYWAudc/7vIUHf/vy/cTEo4oPg9x/rSMWlvvZDxjXs3815V9T
   jC6p0mm1CLTKIWlILdJ/wzF+8oERBd1/TejJMAxIlCX19iTCcZY/0i3wk
   WgawflG2rVn2CRHt1KnOMGRb39UhxP/hagM8ePDScme5jjygvMFgF8Ws/
   9mkdnv5odRZxdL07YrqYAZrJQohPjCVOGHOmmN3q3L6O3KamyWVWLERzj
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="214109412"
Received: from mail-dm3nam02lp2043.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.43])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 18:17:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MybbjvGsss9KuppOA7DHjJ7OmY57ZxQn+YUNHQH9fCDiaeaaAT8OyFmCEW+LIhDT9wRIT3ty8Gsj3Ha0O86lvONIkd25zTV2rPnkuNm8pU82IXV/ucLLlpsY+CLUJRE6B/FU/TprUa2LyLlAxyuIBjCFQ+RfKslWk1JoZV7KRrpOnSk70bXYlhThmaCx0a3Httf2FMp6riUd4RTYpDJxBLQaRTa9QT7vO+0WVeHCt1S1xhCui4HO4mP+cNqXXLFS1iceCWiWptJUD16T/9ihX3UqDmSNu9uQ1zPWydR6/s+7g32Xf9IGItYd/BYLAuWce/cawyU1k+a7NuidBHf6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwycxuCKKH3UiSA40TtS4E6kA4kcW9bi+E7kKGOMjCA=;
 b=JkmHkT2z8xzTaiH1OBRHSgOspCjA34+MlLm5Pl3JZO8dc3/DzGzY/3N+dDk+6uTg6wD9RgExV5O5x8fbBxQuuTqg384OnAFsWjQwvcs2xkpDROLu9RI7v0DoMYGCDXJ1bxRZcdWz0AdnUdoYtfrhUXSjLPhgAvSulXS9L62HiHVkyzSWm01vhExlHmDVnOtUyFtfXBgXjhtRZuigrJR/m828ny55v4E94KdvQuACkS5q2Q1tVd3Wrfz2tVLX3D2MUNiEJTnTxuO7I/Yuv1zQmT5J3I3ZP/MMfIIpiWWKyhvzWAZocNvE24cwdcGpK0hK5QFVdQZYwfG1Kd3ZDz2/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwycxuCKKH3UiSA40TtS4E6kA4kcW9bi+E7kKGOMjCA=;
 b=FbgKWrpL1MTfN8TDGLzUesfPBxv5CN3GGtH1rbIV/yOnARX+aTrxxLRgGgw7XPnzUwSooWolIUwi0Z2B/gFdCyDRDZmnuiPBm5ahRTL3LAGXK95WHmUDOR0gh/SmyeA03Ha+NO1BYb+3b7us92q6G6adnnGBFFrH/3RP9dB5MIw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6542.namprd04.prod.outlook.com (2603:10b6:5:1bc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Tue, 18 Oct 2022 10:17:02 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 10:17:02 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Add CMD0 softreset and preidle command
Thread-Topic: [PATCH] mmc-utils: Add CMD0 softreset and preidle command
Thread-Index: Adji0bdh7EK1ICQ5RKCr0hZaXnhBxwACFRNQ
Date:   Tue, 18 Oct 2022 10:17:02 +0000
Message-ID: <DM6PR04MB65755703A2192C405B9196E3FC289@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <452efc77cda34926a1b2147e754e6455@hyperstone.com>
In-Reply-To: <452efc77cda34926a1b2147e754e6455@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6542:EE_
x-ms-office365-filtering-correlation-id: 443c1952-03b4-4c8b-88a1-08dab0f1e63b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4AhN9jJhuclAshThNtcYWEnKkGcZ6LBR3RNSm2Lo9zGKKkHOzvHQsZvc8jPitVFuKpEGioKYcNBJ4N2mNiQygL3QKz59hmADtVVK0dTpAFGUt9qaARYiP6fxMUKz//KZZ8QEwfyDjbp5QTC+5VVDTBvXY+ZIQYCuJ5SJzs2py3TNYdQDJmDwLs7+hP8FaVPe5jCrnhMXCJd1gOTVa9kxnOzBlIBag90weUsUf0rnoUay5uKrYp1pO7D7F6BFSSqLkDZ2YIz5zhvwiqNCAd97YKzFeCNboB7ut7M2MD1SyvTqqu4vYQaJdbKBo9WPnmv+Q7cYuDVtD6WrNLkDXe1Nrv7jHwabM4gxiGMmgOMSrnKiKf/P7mT1g1fni3zvQ4KVznAuv6Evf1w6+dCrT+Tub0bJl2aHq1KniFo2DvQ5lhS7GaRGepgJkEliQYd3GpGEkeEL+DNfeRLLnof37/VqTKkxjRSMKVw5lwuJqAEOmcS7y9PQj1tDFOo92yV66n2xoDMyo6SGFVpKHNbAuIVIa0c3HPKRQQSSd1kR63aqOX4Mg4hfrCxhp6D6Wduxx0maAe+MNNAYO9tFXdFKLdlhr/sZ62QV8C8d7ycNCkZYvEg5bPh+KnmUAIas0UpBw6EmnpbbuU4xLOSM1flPsJcgTaNh/4r4TRmSfMijNQg9sWyaKVOU/90IBsQp2uZBZs5U6Cup7irnYsp7Xp5Xpu7C7KPsfZS6N+i9usQsYMuUyzPRKpAz2VT20ivAFSrFJH+oM95PossB2qNQN9KHrVDk8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(186003)(38070700005)(83380400001)(86362001)(5660300002)(38100700002)(122000001)(2906002)(82960400001)(52536014)(64756008)(8936002)(55016003)(8676002)(41300700001)(478600001)(26005)(9686003)(7696005)(316002)(6506007)(66446008)(66476007)(66556008)(66946007)(76116006)(71200400001)(110136005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l7injPvqH5I+vLCxEnUVr2xsdTBO/KyOpn/Yvhd1HGWR3ctXlKN1UKnyf8?=
 =?iso-8859-1?Q?2cbK/RwnVbKPCNviGeChv4ErmNzNMUScGrU43OGssrh9CLU1wXA+igaoyG?=
 =?iso-8859-1?Q?IzaTd/VhAT3kT1dKlfEOtnALa5iMp0mznM6A/DIxW/IbLvYINJ3zOZuv8N?=
 =?iso-8859-1?Q?niLQ7UgCJVAWwSj5hhQCVJfqN/pFOaTPfXU7PRZAkChFfV+c3EXvbX7Tq+?=
 =?iso-8859-1?Q?1mhXIiGt82IVhDD7FY4RhA1fbsSYXqZQCRDYA/vsNMd3MgGagwK8UfQUrh?=
 =?iso-8859-1?Q?ti6WqbEliQM7yXZsfozUyMPuVzSGx1TbxcrSeENpwTlBIIOPB/Ebxqz74T?=
 =?iso-8859-1?Q?q33KJ8C+dEThHkWajg5oBPbylvrisXaP6wZSIMApuJ9ofPJhXta0N5Uv/U?=
 =?iso-8859-1?Q?fvIVjd4hIEA5vjKDisRkhczmofCGccsA9pEADMOaMSRcr8i8BV7GC3SRmV?=
 =?iso-8859-1?Q?jJplj+a0RqqQmnCC1YpnKeDYpP4clDCgmS+N/PY/lK6YVYEm6Xua2N7nZm?=
 =?iso-8859-1?Q?JQmT4U7UTI7Emj1zcLK8eXN50DygzBIwjh3uD832OzKJL1+vDThf8a+WRD?=
 =?iso-8859-1?Q?UpgSkogIIbVVbCZjLmo6GJil4pTXwLYTZcORBiaq7YGW9Y6hTfvkzEv7Fk?=
 =?iso-8859-1?Q?brKZutsUbiTBayGogSkSEdecZS+lioHImARt9SwEkUvB9HjVVxcxv4ii8k?=
 =?iso-8859-1?Q?YfflBaejarDwIT6+w958E1Dg0r0xnM6yrUXWIAtXfu+lTUjl0jotqHaUN1?=
 =?iso-8859-1?Q?T1AhqjOnIwgWOuDRfP1fjCuhonu2S+VDasM346MSnEBg7TG9tf16P5/i28?=
 =?iso-8859-1?Q?RDQQVAUKTbXib8iUt2L2N+I6FR5/uUYnf06kPXHIVd2iT4NjAa3A0FuKVe?=
 =?iso-8859-1?Q?bLKbt+gMuwnuR/owjGaD0O1f3b3IOiwoVmtdWmZEYDmEihcuubOdTQq+sK?=
 =?iso-8859-1?Q?ri+tWW9Yccs8MY8Y+XzFipz9LOSnOBBycd643nOKuTrTWI0LLQa8d+yTxY?=
 =?iso-8859-1?Q?MmZfP1jHiw/3tW58xaQE6v00aODIznnSI1NRyWBeYo6wv4rsJ0u6j+epLn?=
 =?iso-8859-1?Q?e88pZnno6TLxBDtBKfAQ/W6pxXS30d33TAQJZVi1fDeEpW+yJ+XOngVtsx?=
 =?iso-8859-1?Q?HmRYOqWikxgvtLqXglD3hzNAf8uMkcDjMIBTOTvde6RX95lpVnG9CeNkfx?=
 =?iso-8859-1?Q?cn57mlv8PLTKXQ1iH5V+N0xO4qeVjmComnuycvKm0ni7Vqb3eFbBxP0sXs?=
 =?iso-8859-1?Q?RyRK6kSlS/9mqXwfWx1N08+q6QIXdpYrffs9j7JPqmzwvQojU5KyKYu/h/?=
 =?iso-8859-1?Q?JTKISoYkC9oQeLRdXNuHL4Jhr0fNtOIvqaIz6cAfeKdkHZzV4VEj4JwcjJ?=
 =?iso-8859-1?Q?1tbHVdGu3+egSf3oXCoB+EGf35gDiYSLQjNs/c/7dk64akbrhWqtcPfW1S?=
 =?iso-8859-1?Q?UMxgbSEGAyDNcERlNOmTwy49y/uCgk1TV+tot/uqw5iOMr6LUwjUhVhBpA?=
 =?iso-8859-1?Q?mWllrI+HUEpEceEPxiOM6X2gCMZroWPsZori0WrxCseMxvTqjvaaS38P/n?=
 =?iso-8859-1?Q?ynkSLj90UGRN/bvdCsGJKzFlVZFnfvbrSWkftWHJaYH3AgRNdkGSdNdSkS?=
 =?iso-8859-1?Q?Vi3PNAdnOxois5PCzgLmoMOphKSahOws0P?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443c1952-03b4-4c8b-88a1-08dab0f1e63b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 10:17:02.2302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUyHBGqzPn+MWNfMPVdyG5xhwhC0lect62aU/GLQfB4fHwuA17D3bqd3TRsXFcM155DzfLs8IH9iRQc6ehutJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6542
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,
> CMD0 may be used to see if the hardware can handle a UHS card
> that completed the voltage switch. If a UHS card has problems
> coming back up after CMD0 your hardware may not support a hard
> reset properly.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Please flag your patch as 'RESEND' - we already discuss it on July - is it =
not?

> ---
>  mmc.c      | 10 ++++++++++
>  mmc.h      |  3 +++
>  mmc_cmds.c | 51
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |  2 ++
>  4 files changed, 66 insertions(+)
>=20
> diff --git a/mmc.c b/mmc.c
> index 6c56387..50493f3 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -245,6 +245,16 @@ static struct Command commands[] =3D {
>                 "be 1.",
>         NULL
>         },
> +       { do_softreset, -1,
> +         "softreset", "<device>\n"
> +         "Issues a CMD0 softreset, e.g. for testing if hardware reset fo=
r UHS
> works",
> +         NULL
> +       },
> +       { do_preidle, -1,
> +         "preidle", "<device>\n"
> +         "Issues a CMD0 GO_PRE_IDLE",
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
> index 2957aa9..ed2be69 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -3044,3 +3044,54 @@ out:
>         close(dev_fd);
>         return ret;
>  }
> +
> +void issue_cmd0(char *device, __u32 arg)
Static void?

> +{
> +       struct mmc_ioc_cmd idata;
> +       int fd;
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       memset(&idata, 0, sizeof(idata));
> +       idata.opcode =3D MMC_GO_IDLE_STATE;
> +       idata.arg =3D arg;
> +       idata.flags =3D MMC_RSP_NONE | MMC_CMD_BC;
> +
> +       /* No need to check for error, it is expected */
> +       ioctl(fd, MMC_IOC_CMD, &idata);
> +       close(fd);
> +}
> +
> +int do_softreset(int nargs, char **argv)
> +{
> +       char *device;
> +
> +       if (nargs !=3D 2) {
> +               fprintf(stderr, "Usage: mmc softreset </path/to/mmcblkX>\=
n");
> +               exit(1);
> +       }
> +
> +       device =3D argv[1];
> +       issue_cmd0(device, 0x0);
Maybe use GO_IDLE_STATE macro?

> +
> +       return 0;
> +}
> +
> +int do_preidle(int nargs, char **argv)
> +{
> +       char *device;
> +
> +       if (nargs !=3D 2) {
> +               fprintf(stderr, "Usage: mmc preidle </path/to/mmcblkX>\n"=
);
> +               exit(1);
> +       }
> +
> +       device =3D argv[1];
> +       issue_cmd0(device, 0xf0f0f0f0);
Maybe use GO_PRE_IDLE_STATE macro?

Thanks,
Avri

> +
> +       return 0;
> +}
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 0f7c004..faab362 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -47,3 +47,5 @@ int do_read_cid(int argc, char **argv);
>  int do_read_csd(int argc, char **argv);
>  int do_erase(int nargs, char **argv);
>  int do_general_cmd_read(int nargs, char **argv);
> +int do_softreset(int nargs, char **argv);
> +int do_preidle(int nargs, char **argv);
> --
> 2.37.3
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

