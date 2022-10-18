Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B19C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 12:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJRMCc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJRMAi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 08:00:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CEE9B842
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666094408; x=1697630408;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QFBdAhm7XJFTBmo43e8CJUkxzUYrDbEkS7HBAYvKi1w=;
  b=OpcmkpLG0+EGmNTecUej0qg/dhqoyFFCK0QvP2ADHv9G1HUK9nns124h
   1xwaPVgNUZcTyCXHRRUlUkEW5euSVJnpMlnlieRFWF2SNJskRF2yfkN0C
   +1a917V52mF/BIAj4a2HEI2m57ltsN+PkASpmjdfsSSi6j+uq+1wM3sha
   1fmKNw0quZNOxpbzUVNDyikxgrLlS7BFuoCroqLaLc2XzOpVZ9Ph37ZXz
   m2E5SBAZKkoaMOJnT14ieiJOF7vkO/j8yraP0/of0Kqdu/2t6ub3PUH7f
   QYGp+kk8fiWq5Xim+UygiYAKLcBFhf4ANfzLnqRDn3iIwjncT2ddKoo/H
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="318438423"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 20:00:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEnEUnE10zUHjK9WhK4xd3kFfNWseKuqCco3EnHAduFNNHrCgPoXic7BxaElb8JYNBO3yi5bZWxw1cZDVY4mT6kIlf6P0nZe/NZLdmWtEbf/JTVuZJvPnFASgtojjfI8QF/tXKE491hmetQFPlshpvXHWpRN1TZ+jCpv4+Yy99s1xkM8QLs1EnixyqdOLHD6bqNdiGGfClwOqC9Vi5o1R3wJX4mjeKK6LTV0Q51XZAcXex0rzTockfzY8xyAe2YtFbonQSDWEpQwWS1/UuqCfHGQjBTCUI2oiP7Q75aUTcO5mNkpCfZbeCxbHFOFYQE+4Ihre/afQUIluj6Mb0ssAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUTvruJPlHrwS4oja5oEqFQojLKrKc8cq8kkFFMM3Yo=;
 b=ULWCN286i9sKQTBiSRe5Mqzjjw8fXjsevK06XEjntJGlOfaW9y8lGhoQ+cmXGPVqdVMADYj2S1a5XkpGsm/RbquNevIOnWUZgyWJGNOwUjDbL1b+sn2X1iTq0IHqIL9txevFVJ2Vr+E2FuePX2NxHV6adjs04RegY37aznlqI90gEUX7ji2F//o0NAYH0f7vI+T6chXrNiPZ/GY9eNy5tXD56JSjzNglJrPLz8KYSKprUWF32z6/w46EzT2DwW1+JoXu3RvzSxkFef13tFenEyQMhVVM+VaIei1hfLhiRQQpqSeFCt67pIZkk205qw8KPf/sqpSCjou+8RslSb/hcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUTvruJPlHrwS4oja5oEqFQojLKrKc8cq8kkFFMM3Yo=;
 b=Yz2n6VSr+VPo1tD6JelKD7E+6AuP3ub6N7GuTWPFZtzY/dcfl6UUrC9gah6n4m+UJ3AnMloFM19mzwWagqs6ryqJW8SWURwSHE4nsv7qhSvCSuSQjgE5PbwFWKygMJ0qQoJ5QvgfJjRwyBUNSp4wwaWkL9K4k7A5NL6HmpMbHV4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB8390.namprd04.prod.outlook.com (2603:10b6:a03:3d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Tue, 18 Oct 2022 12:00:04 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 12:00:04 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCHv3] mmc-utils: Add CMD0 softreset and preidle command
Thread-Topic: [PATCHv3] mmc-utils: Add CMD0 softreset and preidle command
Thread-Index: Adji6F9Xd6Mb4HZSSc+1/wyKJmAOBgAAJvQg
Date:   Tue, 18 Oct 2022 12:00:03 +0000
Message-ID: <DM6PR04MB65759CC2DF13BD5259EFBDD8FC289@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <0657285aa7c64cbe89f9275fd5598345@hyperstone.com>
In-Reply-To: <0657285aa7c64cbe89f9275fd5598345@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB8390:EE_
x-ms-office365-filtering-correlation-id: 4e041e9d-5f01-42b4-14db-08dab1004ad8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hkarM9hR7pFnr2mgt2WEdABj+X9N4d2fjOgP1vbBllQnnM8YPCe5yTBxhC+8eVyWZM7h3n3stVIAmdlas3Xwe6hCNv0xorA/ZS3+pqc1O4YSxfoqI00vEIijPmlCiWZCbQy21FyZyOl6MXMzAbW/GELObSbo6OKwp9yAVoMiwrVLfL+SYLAUei72F18RI8dxA9PuOiDGYpkEhhIj8+FtcmrpMd0aOGo36OEd36VUcg8+Wq9lMzIhMAzDX56nzcOA8AK2+ZiKfTawSGt1aIaDPvAlR9Yk3YGZF3F3ooRAFbMno1wkq7tl2foedC4hdX7HaJrEeEPOtMMuw+qRwGrmZ6moOyYz2kpf1p3WY7Dx3U86hiF93QEaPObSuQL7+WBFRk9QL/x25Rzxvx0qOq0p75i8ODwO/H/PbyO+Xn/2Tf/+vzOi1ft+pG/kn1BohVuJDc/1G54hXNhcc4QMhyaY7od48rqBbsUCY2zEa6szYwJrM4W6cBwFtAUurne/homwIs4dlXUvwBlc61YLU9EJn5lJiAIuvvW6kGlFlu+/fyCD3ISVvLNP/3zl2QBFplx8X8W27dEftoshLWbExj6lcQmX4n2/Y/94cNp1G7cGusXzjvhvH132LYNJ2CSiYejWE/272qGS9rzrSmztJj7UL0I3Edv+Jybyi1M/nJisR1AtxkHo9Lviin7A+jo0R804eWqBwctLs3A83gYkmPdOsX5DYEwvom+xMx5BgiVzyZOerhoFBB2hFXShA3uYbh+S72mjWcMukbB9zsh/t0+TA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(83380400001)(186003)(38070700005)(2906002)(33656002)(478600001)(71200400001)(55016003)(38100700002)(122000001)(82960400001)(86362001)(7696005)(9686003)(26005)(6506007)(76116006)(66556008)(66476007)(66446008)(8676002)(64756008)(66946007)(41300700001)(110136005)(5660300002)(52536014)(8936002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LjDK25+VWHFPKUEiW2lUBEroUC8KZMR/1NgqDl77FmG6LMt3e6BSbCzRQ/?=
 =?iso-8859-1?Q?i3KkuCbrHoT/FlGmq0VZ+HNPDG8AU8fgKwUjgGARt9xY3jAZXdDIU5cC0w?=
 =?iso-8859-1?Q?fcbyb09GbKyy5hpmMlmj1Qp8FWbQm13G9Q8iMl8hgqsbxETx9Ci/x0gvFl?=
 =?iso-8859-1?Q?PdztLSgfSfwmiKTwrkQs6oRtgxfDTiMjacI2yccwS1yyluX7Kvuvy6rUvS?=
 =?iso-8859-1?Q?VZ8VvfZ6ZIwwKn59gggalsuA3YhEAcuqZ424dC0dYe2Wzz14F1NuyAmEfy?=
 =?iso-8859-1?Q?bD08qSvZlluL1uRvolEfa7x4sA17ltKbZZumbPOpvm/QY1dWyzBO+rQfv2?=
 =?iso-8859-1?Q?bm7D8qOSQSEGCaALCEAuqJM05RyUuzSW1p/lJ1vVqQVG++9HrSWpSQggFw?=
 =?iso-8859-1?Q?TJmPCyNXIjPRDTNO46lHWsdQR/VZf8G4VVh0xN2RFAB27RwRkjRAbPwFyu?=
 =?iso-8859-1?Q?1KAKESEd+fPDCV7o1ygz1lScpd2oGPhAya7abvV7xu0HJDG3Os4szgs3D8?=
 =?iso-8859-1?Q?cFuCjBDyHpTo3tuclxPbY5bPU3MeVYEgWd+loPgViB0xp5OVgT/vzaJqVM?=
 =?iso-8859-1?Q?HKR8cTdq3rfT2kAfGzD09c+ay8bdzeRRw5IknSvOKoVi3dCIRpYf1qRvqQ?=
 =?iso-8859-1?Q?ftQ6twE3ZuvDh+LUr+bY9tJ9+HCjv8ChF8vQfNV/Azv5r+lSbk00QbOZ2u?=
 =?iso-8859-1?Q?sm0KoYyk8fxF0ub4Dt/oZVskXMw5sF9ZvZIkW976MRGL2f0dsrLFjXbMUT?=
 =?iso-8859-1?Q?RgTL2VpePjaru1hCvthWVCBt0FdJnKVc/JCHLHks5qZ9P9/x2bazqCvNQy?=
 =?iso-8859-1?Q?3f48se3/8Vbq3U/1e9jVATLB1782EgET0caIm/7oyZfJfK9sjQM/S3lupd?=
 =?iso-8859-1?Q?7rSfBlemKBXYsFY+PPLXt5J+7EW4a5qS5aDC2hdatWBLGIIFGRTbmUkNSt?=
 =?iso-8859-1?Q?iOZG5/jFV06me7v24ppHPcfEPuhMrsrfZtkSoi367ENpttNv/GTR2UeCZL?=
 =?iso-8859-1?Q?GeFpD1moj1+91lJJQBNjfxBUOGiwoKMXk8qUWhkz6hA9m1r34ceZL5nbYM?=
 =?iso-8859-1?Q?gr/4OIsDd5b7dJyCps+rc520uWgH5tdh0shz1nKQKr+Gw2ZXB89LvpgOGO?=
 =?iso-8859-1?Q?SHqVqKgINY8tH5ZCbqap/EiRvbWBEqfPyliq5LS5WFLWlBqcpGHFxbkD/x?=
 =?iso-8859-1?Q?JPNGyTFhTj3bArHia3XhCHQFX1cMjZCkz0aXGlgJL4w623ATO+s9kAuliN?=
 =?iso-8859-1?Q?Wp/mHC66hE4wAZKZFHQ09IMSH/kTCMRH1nGGCreHO5E/EXQOUJ1Ga5LMFA?=
 =?iso-8859-1?Q?vKbJg+HeweNTVkj5UoIjiybvirmp8HHwxg97pABjojlxkLSPV6xxghaCzR?=
 =?iso-8859-1?Q?MfbqDOa0UfGSLtnwBHTb0TBb4QEkoFR2oqfSY1ajgyl1u9C6GixqhsiuyV?=
 =?iso-8859-1?Q?U0FPNG3VugVSXMHW3DlwyMLJjkgveTsyySJt7rUULsrxRSct+VxyLRXqv2?=
 =?iso-8859-1?Q?TqQOGezkGWgvf/zwUVIQMXHvtnNCtzDSNBRm8o4b0pIFeUvnfzDPxZv1jO?=
 =?iso-8859-1?Q?7uwEN5nWlWgskKHdAH/I2vbZ91rgRafzZDgCrP0AihGJCGbn60GGgNQpG+?=
 =?iso-8859-1?Q?p9G/EDupbF4kJ86u3V1WyEFT3eVJeXUqkQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e041e9d-5f01-42b4-14db-08dab1004ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 12:00:03.9981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R92E4PIa969PYddMv/cB3X1409V4w9bF9tbE3jr9Qr7AdDct+M67okAHrueGbwgFnmYBM6Fmi9Dtw5hIeRsMMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8390
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> CMD0 may be used to see if the hardware can handle a UHS card that
> completed the voltage switch. If a UHS card has problems coming back up
> after CMD0 your hardware may not support a hard reset properly.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
> -v3: Make internal cmd0 helper static
> -v2: Use macro for cmd0 argument
> Note: A previous version has been discussed as
> mmc-utils: Add softreset command for issuing CMD0 but with the addition o=
f
> preidle I considered this to be a different patch
>  mmc.c      | 10 ++++++++++
>  mmc.h      |  5 +++++
>  mmc_cmds.c | 51
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |  2 ++
>  4 files changed, 68 insertions(+)
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
> index daff62c..6511dbc 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -21,6 +21,9 @@
>  #include <linux/mmc/ioctl.h>
>=20
>  /* From kernel linux/mmc/mmc.h */
> +#define MMC_GO_IDLE_STATE         0   /* bc                          */
> +#define MMC_GO_IDLE_STATE_ARG          0x0
> +#define MMC_GO_PRE_IDLE_STATE_ARG      0xF0F0F0F0
>  #define MMC_SWITCH             6       /* ac   [31:0] See below        R=
1b */
>  #define MMC_SEND_EXT_CSD       8       /* adtc                         R=
1  */
>  #define MMC_SEND_STATUS                13      /* ac   [31:16] RCA      =
  R1  */
> @@ -226,6 +229,7 @@
>=20
>=20
>  /* From kernel linux/mmc/core.h */
> +#define MMC_RSP_NONE   0                       /* no response */
>  #define MMC_RSP_PRESENT        (1 << 0)
>  #define MMC_RSP_136    (1 << 1)                /* 136 bit response */
>  #define MMC_RSP_CRC    (1 << 2)                /* expect valid crc */
> @@ -234,6 +238,7 @@
>=20
>  #define MMC_CMD_AC     (0 << 5)
>  #define MMC_CMD_ADTC   (1 << 5)
> +#define MMC_CMD_BC     (2 << 5)
>=20
>  #define MMC_RSP_SPI_S1 (1 << 7)                /* one status byte */
>  #define MMC_RSP_SPI_BUSY (1 << 10)             /* card may send busy */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 2957aa9..5fe7c2a 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -3044,3 +3044,54 @@ out:
>         close(dev_fd);
>         return ret;
>  }
> +
> +static void issue_cmd0(char *device, __u32 arg) {
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
> +int do_softreset(int nargs, char **argv) {
> +       char *device;
> +
> +       if (nargs !=3D 2) {
> +               fprintf(stderr, "Usage: mmc softreset </path/to/mmcblkX>\=
n");
> +               exit(1);
> +       }
> +
> +       device =3D argv[1];
> +       issue_cmd0(device, MMC_GO_IDLE_STATE_ARG);
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
> +       issue_cmd0(device, MMC_GO_PRE_IDLE_STATE_ARG);
> +
> +       return 0;
> +}
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 0f7c004..faab362 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -47,3 +47,5 @@ int do_read_cid(int argc, char **argv);  int
> do_read_csd(int argc, char **argv);  int do_erase(int nargs, char **argv)=
;  int
> do_general_cmd_read(int nargs, char **argv);
> +int do_softreset(int nargs, char **argv); int do_preidle(int nargs,
> +char **argv);
> --
> 2.37.3
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

