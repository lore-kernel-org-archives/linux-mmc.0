Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9135C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 10:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJRKuN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJRKuM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 06:50:12 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3263F9AFA1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666090211; x=1697626211;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=04Ow7Q7I+WWdzJhfnnGa5Sp3fJLF5QCPxVzBdNUVOEU=;
  b=FmxyUwaJylic/x9buFP4tvF3ry/m1Lcaymf82E/ld0uKPOeCnyGC9XWr
   ooJ+YxAXmtsVmeg0lHXxXJbRFNlFEG2lW0Pajss8efEr8pN9fY0bUurQU
   y4ZuApbdh1zV6cp/I+nyvkk5LMGU7mBQq3OPt/Zoz7lKDklAWNXf0PT6k
   G2QSZcmQVxzzOr0ttd6O5Mnq2oixC65qC28jkTb7o4P73faAp6PO7eJxa
   SZdgfuQJNUgWlEsOW7EW4STkeVNvpoixtTL/Xt7JcRG51f7VGIGRcU+Dt
   4Dd5wHf34ZPmQ8GMBFnNJuDYsxpKtiWAzU6W0vDPj/FlFjmJc+QCIxF0B
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="326219048"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 18:50:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Msy4817ofYjMKEA4gwnPH6WSjW3as48kq9GTpzyEcllEHsA+CTO7wRSsPrGa1UmlebNM+8/jtpvqjdbvnhJlpl8hn+I/9InJLmDRxEoejdhUDoDu5qnXlE8PSAccPSmuugJ9FMZqwzVjsg4w8Ke7U7EKVt03fRHTO86Eq62HT8IU0y1wyzFpnSbcC27I6SdNDwc2qN1o0xW9e8nxa4eXb42Oy2OfAx64a5lTFODjkd2I90ctPuS5B1PqD8P6ypzBEwbi7lfcL6ISDtsVhtCIUEWN5qn7d4k2U/YpiTfDWxLBoqItHr7aFafeMFz0aiTIROCuqVrs4aUj5tAKD3CWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuX9eUWiofitpB5zXF7zA+YHtNTCnfEMyZqK/QeqNzs=;
 b=EPBPyScgrt4KujVLTLJWsnpZxjizDj21PrqBOd/JJLj3PYHo/2DLVWcrLYfx6OHk6HJLeSqfN9YlshfbNN95Dualp3W7GCynFwJ5x1LCBygr2TL1Tz07YuIlv9x3lTb7icT7opomBKy7GFPvu8sMbDUOaERSO1ZTgVHMbuEjIysy96Sp4o1FWVVXnHXjcjr9OFDv7M3OU44hQBm88f50NN89/iUxlszQJAer7JSGT7PNL2AJ9REbn07Ra9wyPPGFgWb+i9Hs3+VWYqFzjeiY9ZYLsk5OjbmHkO120N5ZxSxAdWTdl+6pR0CUSpIpnaQ/e7Iq4BXIV3vEEFHiBPgZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuX9eUWiofitpB5zXF7zA+YHtNTCnfEMyZqK/QeqNzs=;
 b=abpzjxDCRmJbBEf1CBVkaCE5h5KRmpgPKg3n/+znRyykjyifw3LOYVYzQMYkJbIukRKq3jlNllYqG06rJRoJS6LfkpWGXC8e91OOpeHxMv+yLt+8bQkDWTKLdzFuxxO727p6vyCxOjJEuQ7brsXeNmrnyr58tcAYsNS71n/tb+Q=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6954.namprd04.prod.outlook.com (2603:10b6:5:24c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Tue, 18 Oct 2022 10:50:08 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 10:50:08 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCHv2] mmc-utils: Add CMD0 softreset and preidle command
Thread-Topic: [PATCHv2] mmc-utils: Add CMD0 softreset and preidle command
Thread-Index: Adji3jrc3gUSbE0uQsWCbLHtmguQSgAAQdEA
Date:   Tue, 18 Oct 2022 10:50:08 +0000
Message-ID: <DM6PR04MB65754624F249384AA618DB47FC289@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <333eee173dfc4765a866537b863945cb@hyperstone.com>
In-Reply-To: <333eee173dfc4765a866537b863945cb@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6954:EE_
x-ms-office365-filtering-correlation-id: a30a4cd8-9461-4c56-2d25-08dab0f6860c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4EHemlVbyBENDoG5UCl/MkbGeZFMaTLSFPt7CwV3Vtvnv3fcGjIX5RJdUP0oHVj1T7Z1hRedDVemQmsQSwAsM+v4EhqgfKO6O7Z14qUBvyx2Z8lmJwRS4SIzG72UFAF5qtPHj0mwFmSoJI9PXNJhtmz3tqTduLWOgAd1YO9z3mtTaI9ftBAtvmYAXgTNb1ZzKm3hr7R+e2RQEf/sMkP4zBuUzkvP8NczAKqafgMVECYwbmlfzd8W/4pnyE81fivsSZrk1PBVSrPWlbh3hTBkUUOtcm5v5UZTfR5Lc+otNEE1WmPVRBvUhy0NIZ3vRFNvlFhOsE7f6LqNVdK74E5wpH2BSyYXWT0goTjBL6qJ6xMi5xMEXzlZyPv4qp1jxFhT1UrzQhJjqqklyG2LDjQHMrBKhZbDkeCHmVRYDSn7RIWefGx5z8VV2pValSeHb/1BD3SZMVt2SEtebnxTH288vj+nE1mRcAEdk9c5MhAm6JNQ4LQk+Gd+pIYV2djKEIIxKt+0E1EDhy4RnD8Zuj897u83dOY+Zx67l6aNGB/A7k4CyMTiBqsYOTPbE3x1hlSMddVMYPh4gmJikN7ExSGzsxPtga5TPrYEGVnLhrMcsATejA7rJUFmasxSrOoopG7YvhP0TDyXAAUnHQfjf+zKb3jU7iansssQGmSHhfGUwPGJwtSFISClSfrmmoWetpl/sktJ/f4Jh/tURCHVcyW58QaUXjFNyzvOQGzGeiHnSPj5Z8+BOS/tGFtfHmtkBzQDtYuCsMcqZqKFnjQiQZtSbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199015)(66476007)(2906002)(8676002)(64756008)(66446008)(38100700002)(8936002)(5660300002)(52536014)(41300700001)(66556008)(86362001)(33656002)(82960400001)(122000001)(38070700005)(9686003)(26005)(6506007)(7696005)(110136005)(186003)(71200400001)(478600001)(66946007)(55016003)(76116006)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?G1LIsfZPsDcBw8Xuz0Ro1ZLOJK+91jUk5o+4dFcZZNyk7qzeLjNzsHRrGY?=
 =?iso-8859-1?Q?kU0H0oZyOFJpBiKl/2zLs6Q5TR1GjPnODv0pWcOSk/lUDjDmimLT3X6fuI?=
 =?iso-8859-1?Q?ZBltljXChkdrEEdNi92LOowjoX+c7WCjps3QtiGVnZ+h6wqwaRrXvzjEpF?=
 =?iso-8859-1?Q?dDFOfYy+x3OpeNCavPb0KexPuNB/WyFM9ooZ6bQYkFGr/oTtQ+RDdjlHuf?=
 =?iso-8859-1?Q?IMg4m4QecJfgzVFGLI0TuDs38TmBTiijmvn2lspyWftZyJ0Ap+NSn4DLrn?=
 =?iso-8859-1?Q?TEm1luHV/5YsJj4U+bTF/IlIcuCoO3jz+unjxAwsqC9iIuvQY1nJXM8+9X?=
 =?iso-8859-1?Q?YRzfB72szYohXw82sl/bYthuiyWuChP4oUngqCzmFQe++7Q2dEr1rbTGh3?=
 =?iso-8859-1?Q?XVXjsXIc90p/OnZWanTh10t3nCUyE4fVYp8QcdLD3a3NOHdMizvF9FBJij?=
 =?iso-8859-1?Q?Ul6k4WLOb+eMQZq9Hi7ttR9u9WADIUqVxQMtpd/wB8r84qDGhRk8w3Mfzx?=
 =?iso-8859-1?Q?/cK7nDD6PnrNruo6jKuHPFyDnfTaSBij37aRuaPNtG16gCGSUpM60Sq2LD?=
 =?iso-8859-1?Q?MgHUUvpLjCOcvV7nQRXZbZWA7esLm71HFZXBcSBDh+lwTJvhpFXaj89M1/?=
 =?iso-8859-1?Q?iYAo1oUkJYswsI+Lyodv3Vw7VwYPJocbM1k9LKu/VEc+656u7DgT9PD+Cp?=
 =?iso-8859-1?Q?Q71qYXie1AVcjXwX6ZZBC/x/jIxkte2Dv0OMVModbBL+hHlJ69+49rZnRj?=
 =?iso-8859-1?Q?MAxCioi4DDfenzRdTzMmfdN2yA7I8BQkxy0R02ysHOLGbIx31nsOvm35qc?=
 =?iso-8859-1?Q?Sloy8MRwsuYY9ejerJOYsagg4c/glCGS+A10e0dAwNyfWfUfT62wzgbTZO?=
 =?iso-8859-1?Q?YMHPJNqHSCqkeSfALrTPAjvlxBY3eW1szuLu6i+dgPyn4Rrq1nYeTP5J0/?=
 =?iso-8859-1?Q?p9+pxENGH6H4xvwfpgK4bSOrg3G2eJarZRpLgyN2NTZjobqntl3djiDtEr?=
 =?iso-8859-1?Q?dxLRaGJbrc9laapkI1lXZDksz+8Y1Ckv6xYzpNnAx+T5IYe6zYhWTCPGP4?=
 =?iso-8859-1?Q?u3Wx8nSlvEMmC055N6RLM5dBOcjE/ge+V0HnNKvpQZnysSonDPPd60KgjK?=
 =?iso-8859-1?Q?FPVjDGCAfRYW0TUbp4DqX93xtjwSGvWMNURqi0nSBi4qvE1Yx1D0OcwwEp?=
 =?iso-8859-1?Q?dBnw3lE9/B3uh5jwHfWx2SpC3lAQiXwUDw4W5FBRmLlgnDXnHTUW/I4H4m?=
 =?iso-8859-1?Q?jcWN5IHWhHo1AHTRcA6UZYX8WQ7/pLCKYjYtbddC3zPGcLD3eWPvQqrFhl?=
 =?iso-8859-1?Q?3rQjCt4FauDFNJg8La2ugaBPgJiNIzLB72EBVg91D1DqMI8yWFBX2alc1g?=
 =?iso-8859-1?Q?s0IfyfHgPYZ4xtHV6/YOWI7dCg2M3/d0i2hmYVZ2y5V8qQ/kb/POUSXa6t?=
 =?iso-8859-1?Q?S2oJHVQxqWh3ZxcAhPh0rFvoFMpr2qLZfvYkc/x9Y8xLIJUlyIVxf0g058?=
 =?iso-8859-1?Q?WAbY9fWVqCJN4MhXVc+O35mbkOVVwB3TRFeUz5lXkD4iwp+/GiClkSq278?=
 =?iso-8859-1?Q?64OiM0zUF6zhMFr9HjneWZwW3NjPqwewCWnICPcNUXkNxKAEnw0xN7HtZ8?=
 =?iso-8859-1?Q?2bjEnX98AsHHmxyYCoH0mEW6EqWVBaVikZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30a4cd8-9461-4c56-2d25-08dab0f6860c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 10:50:08.3578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: coUeYi1f08BdAwneqDTZvd8D1MOkZ3vEMsY3Xh9JLu/gOPXyeqZDVqDC8LAu98Uj4QTqa54grOW0xJRW0CdnYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6954
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> CMD0 may be used to see if the hardware can handle a UHS card
> that completed the voltage switch. If a UHS card has problems
> coming back up after CMD0 your hardware may not support a hard
> reset properly.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
> -v2: Use macro for cmd0 argument
> Note: A previous version has been discussed as
> mmc-utils: Add softreset command for issuing CMD0
> but with the addition of preidle I considered this to be
> a different patch
> mmc.c      | 10 ++++++++++
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
> index 2957aa9..94e30e0 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -3044,3 +3044,54 @@ out:
>         close(dev_fd);
>         return ret;
>  }
> +
> +void issue_cmd0(char *device, __u32 arg)
Static ?


Thanks,
Avri

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

