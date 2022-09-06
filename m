Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BBCECAAA1
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Sep 2022 07:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiIFH5R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Sep 2022 03:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiIFH5M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2022 03:57:12 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80103.outbound.protection.outlook.com [40.107.8.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B8871704
        for <linux-mmc@vger.kernel.org>; Tue,  6 Sep 2022 00:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O86wWG5ToFiZVOw/3IquZ9nsT+tLJc0n7wm7cUWmKqBsiIXtGMx/CJjdQcV9kfoZ7awrgVGvtk3kAhfHz6mb+FHsjmxVhUBoBDwadARZECbFyfS8odjb8pmG1EaCGVUHtVUt4lSwGy/6kHKfk64/tY5M9gA4t5TnEjXHv3df1kBBmDZ6b5b5+Q1duzW0+DnuOI9Pz+U314/JZNERXvbwpwMYMILUnh8tpPchx/D5PdYBb4NQ+f8t+cJ7uk/h2c3jthS+h9rxK3cqsRznSaS364P7fb8nhQPIiOME+nNamTzA29onOJx0J9eoEtK+33mT81PeG1DDIdvCr2nykJICeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1+tLR+NyNTlNF0imk3C/29IYdYhpm/zzjye1L+iaGg=;
 b=e+c3Ob0EmR2A6HY0WczMX5gGGUgEgclvaW57KFf374RgTdoyzwq+Hbl3RmvXsv28LgZM3O4YzGfgLYFBEM37QtLYCvy5E0bM4wt+s+eBh/C6oW+5ZUMyrudz5DLDGwcWL+dPF07VdgFFWFFBDvEYDsFd349E/OaEEw2beG3HIiW8WHjRmDkj7Tm7skz57lZ2ARRXqYjQPFQquR+S2wiQjlQAdY/jkWaArrmCSWh5DEebHxQQedDKSvEYVXFmsIOBaHSmM5bTE50RcnwWm/Fz2BhnQgKAHQjjO8pzZn8ZxUR+uxJwmEkBozqQITMmn6DpLIUD28r9/BJud/miVaCcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1+tLR+NyNTlNF0imk3C/29IYdYhpm/zzjye1L+iaGg=;
 b=i9tYJdFRoVkhPn2UEuu4rRAQ0sEL6soqWnVPrYa8wYg9bjcph3WPLOsJELQd1oGg9JJJbaxO06LfAu2r6uQy0r0jWttiL+jQ0nQgv337bteoVUfEZBh935N5s1brsebxdX9EbQJkIFo7qDE5hWUil1S1Iwro8WcE5xvmExhylh0=
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 (2603:10a6:203:4e::11) by DBBPR07MB7627.eurprd07.prod.outlook.com
 (2603:10a6:10:1e8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 07:57:07 +0000
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::542a:5d98:f0f4:3640]) by AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::542a:5d98:f0f4:3640%7]) with mapi id 15.20.5612.012; Tue, 6 Sep 2022
 07:57:07 +0000
From:   "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7QAPwi0AABQpUuABmc8nMAACAULgAlKINPAAMpvpoAUetmXQAAXdPWAAAhdXwAAFcYuABEITekA=
Date:   Tue, 6 Sep 2022 07:57:06 +0000
Message-ID: <AM5PR0701MB296476E9ECCB3979A93EB4F0EF7E9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <AM5PR0701MB2964D76967437E61EF42731DEF839@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65750D9A332093DBA5B30BDAFC839@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB29641DB9207CDDD1DB273075EF8F9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65759D709D6C45AFD03EB4B1FC8E9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB296429322BA0EEB2CE0B23FBEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65756EA45A10629F2EA8A870FC689@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964D0B47A64F62402ECC43BEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A94E6D218F2272AF0659FC689@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575A94E6D218F2272AF0659FC689@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR0701MB2964:EE_|DBBPR07MB7627:EE_
x-ms-office365-filtering-correlation-id: 340d50f6-460a-4e68-2535-08da8fdd64e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FNeT9blHwnFLSRtdHMPLw+amGc45mUbcXzoY16xfqHTSA71wxKrBEBEY2hWOtCMBsLI5aQFcr2Cze9Nv7YjdXIkw8qWs3+qMk6xrKl++uoX3aAvsMD+KFD3l2p8p/dBpHhVG5qXlU4DMgQmlJj7+k1iwcwKRTKI3dklEcJ91VwkZU4eYcu2yVlirOD7sLMROltae1HYpW/IS/LBsz53eDlI9qIiQ0Rr4mBzMeRXTOx3YYq88JFF34HYONsP44U+iXIHBcukFw0ryJvU0TW050YaaGTuObYE6PYJcj5mL+VALTS0iny5i/47U09yCC+SvTp8+miGMKidw5uZR5zcW/gb616vbpqkBx4tWbyUTyOQkYfacjQB9vXmH2f4lmxWu28IPz2cjHWjJcP2jlIFlvfB5Z06C1hwhdZ9RfIz3evkdEnQD6XPJAwAHJmG7tFE+9iFTTl7S2EslADkrPA2qunKWEOR4dtWawAVk76AnX6Pu/K7zOj4KPoxuQesj6SYKC1z7coUE75PMSePc2DFxdurzvlBJYN3jam3eLbUdIObx74czdFRX/Hi+UQn8CkoSeGetZp3s7JW/sNn4KKrfar9I5a1Qx5sTjlUz17wrGa2Wvs+MUsHNss8xiyyNMlC3rJtPw9FJESFM31alcRMsXSNhdCo+6GCmuJTkHLHr+glSp5lF5aroprMEpIjU9f1WMs1tXe3NvwWWYuLACv5Sef4EcTd7c7R3s5czHl0+4OEgB6uCHjbU7WJ5FOGo6t342mtizfD6z44LIBqhMtqRbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0701MB2964.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(8936002)(52536014)(186003)(83380400001)(9686003)(54906003)(2906002)(55016003)(5660300002)(41300700001)(26005)(53546011)(86362001)(33656002)(107886003)(71200400001)(6506007)(7696005)(478600001)(38070700005)(82960400001)(76116006)(4326008)(66946007)(8676002)(64756008)(66446008)(66476007)(66556008)(316002)(110136005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?g4YYR201MgA94kj9GygEjkMhpXwqsDFaiJWZozcg0GYOvA6jRse4v3LgEq?=
 =?iso-8859-2?Q?P6VsJcKrdO75xJqD1XfShAPq3VWQAeKtL+dj97j6CbMD8m1zSPmNYKwsgJ?=
 =?iso-8859-2?Q?STC/UItw57niwKJtNE20yDhvvcAgkhpIGZahWBaXUL4cfMUP4PwM3KqDss?=
 =?iso-8859-2?Q?p5NLGLmo2x6PZdZPGQGCLXR/k11xWIE6TZVLtmBKBIIUdLy4nvOrpssD6p?=
 =?iso-8859-2?Q?7JjuDkg+3qpSFdWPAIbEApuPB22YDAhovcygIUEbzKLpoKWQzQQ8dHBO+Q?=
 =?iso-8859-2?Q?9xvaPyQjJa99VZmrwveOe6oUrvaXZ0UQ68XzzoBKRhMwNitngl2EB4fVAV?=
 =?iso-8859-2?Q?zBnzk1Cwv3cpyzxqTUqBQ3aB6ChsCj2QyD5ORMM4fr1MmehlMacY8W9zEu?=
 =?iso-8859-2?Q?cX9D+I9kHF0TxI0uNWPiIjv5zrZISZ19MNA4XMT/gscyaJDSFpQaYIK/Ux?=
 =?iso-8859-2?Q?4G2IBCbj3ka6faO8Dc/SqLe/ffalj5chEtBNN9q8uUSOXxeUfn+CuK8bYc?=
 =?iso-8859-2?Q?xyEYLwNn6AqvdvE/oh0mHcK87ikSbCq6afYntuyHU94EuZKLaogrQp31M+?=
 =?iso-8859-2?Q?45SFwYcpGgdmr4kvAsj9D/lg/Yq3vnnpVwG+ORDgcu4XJYFH/Iqnt91hnI?=
 =?iso-8859-2?Q?6+yGqtApfj38p1Ag3iKYkLWhTtYLc8P1XzJUQsOSj3ihubV2D3eRn/HgiC?=
 =?iso-8859-2?Q?nGiamfGEycyLXB7tjMUk3STgJkURQgRU/nc+YQ4tBeMZYlzrN6ywQi4Z4W?=
 =?iso-8859-2?Q?+HIoKHI+gp8LrpaYvXBO91eJb6gEvctc/kLAvGr0WgG29tP858APeX5Mqd?=
 =?iso-8859-2?Q?Rp5RW+pL/w6QAyyw12q3MUGlifCkB77dHBdehC2lnGzFJTvraOENBR42tx?=
 =?iso-8859-2?Q?HTjd+cPUMBYqye9Hxqm3ZoBpVuIq+Hq0bGxsMVctgyQMHcA8zv3ZqCzllq?=
 =?iso-8859-2?Q?bc7kioRw4a5tw0HYucirB1ah5g7koDLuWP5X+6xsjmYXD3k4XIEt9CzTU0?=
 =?iso-8859-2?Q?R6UlQHi4XBDk5EPlONQDfjuWfikv9AlnBWw/Xh2Dy7wTEzJEenn3CKoc35?=
 =?iso-8859-2?Q?ZR9t2mNq+aMUup0VChhbnbAPbl9N8DJk0Cl11HMGo+vhMgBG0yVjwaMWf/?=
 =?iso-8859-2?Q?ByNE7hVmfDff5BMwNxpuD4jBPS+XNuaBFrd/tgw3APi2Ns/9FI9QYM2yQg?=
 =?iso-8859-2?Q?6rnuwLjr6uy97We0zfH0MENuVMc7fG56oVWjSd8CBe8oSpkCRwZ3BrtyFO?=
 =?iso-8859-2?Q?yMdsWy4ShiUFrmzN0wBkrdbO3rJ/o94XZt1pID0NT3JOjy7ekZ06fjAldR?=
 =?iso-8859-2?Q?mWKz3xgE/DrjCogfv5Gql6mlaLWsmpWBuEGq/Zatwya/NKVKPLEbVgTjqc?=
 =?iso-8859-2?Q?QScnMNGhPJRRJaJjRykVsP5BeGhxWr9LfXgJI3RGDgF68QGTjk0oLUmM0Y?=
 =?iso-8859-2?Q?YRPuND8ybkPsSAZPXWclusiZ3XV+R7wzF3YWvR6I/fiwDKO2NuUws7vgaK?=
 =?iso-8859-2?Q?agZ6fIsWWYBiQBKaPYsU8C9yr0VTbT742ZIA9XRfzgJTTi+wAMTs1HQr+z?=
 =?iso-8859-2?Q?e5AUMlGxQuW6M8KlLrXCvxee7O/wnXntfXpGtdv/yplHeV03V7tRMPcrQR?=
 =?iso-8859-2?Q?UOsZZdZEq1cN4IBOX/bGl7TtR8VQyzJh9S?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7627
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Will keep it in mind.

Best regards,
Bruno Mati=E6

-----Original Message-----
From: Avri Altman <Avri.Altman@wdc.com>=20
Sent: Monday, August 15, 2022 5:52 PM
To: Matic, Bruno (Nokia - DE/Ulm) <bruno.matic@nokia.com>; linux-mmc@vger.k=
ernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>; Christian L=F6hle <CLoehle@hypers=
tone.com>; Rossler, Jakob (Nokia - DE/Ulm) <jakob.rossler@nokia.com>; Heino=
nen, Aarne (Nokia - FI/Espoo) <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling

>=20
> Hi everyone,
> As said, here is the reworked patch.
>=20
>=20
> Add the check if the whole firmware was loaded.
> Cleaned up the leftovers of handling the file in chunks.
>=20
> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Please try in the future to properly mark your spins ( -v option of format-=
patch) - would be easier to follow.

Thanks,
Avri=20

> ---
>  mmc_cmds.c | 66=20
> ++++++++++++++++++++++++++----------------------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 70480df..7d37e93 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2812,7 +2812,6 @@ int do_ffu(int nargs, char **argv)
>         __u8 *buf =3D NULL;
>         __u32 arg;
>         off_t fw_size;
> -       ssize_t chunk_size;
>         char *device;
>         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
>         __u32 blocks =3D 1;
> @@ -2925,45 +2924,44 @@ int do_ffu(int nargs, char **argv)
>         multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |=20
> MMC_CMD_AC;
>         multi_cmd->cmds[3].write_flag =3D 1;
>=20
> -do_retry:
> -       /* read firmware chunk */
> +       /* read firmware */
>         lseek(img_fd, 0, SEEK_SET);
> -       chunk_size =3D read(img_fd, buf, fw_size);
> +       if (read(img_fd, buf, fw_size) !=3D fw_size) {
> +               perror("Could not read the firmware file: ");
> +               ret =3D -ENOSPC;
> +               goto out;
> +       }
>=20
> -       if (chunk_size > 0) {
> -               /* send ioctl with multi-cmd */
> -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +do_retry:
> +       /* send ioctl with multi-cmd */
> +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>=20
> -               if (ret) {
> -                       perror("Multi-cmd ioctl");
> -                       /* In case multi-cmd ioctl failed before exiting =
from ffu mode
> */
> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> -                       goto out;
> -               }
> +       if (ret) {
> +               perror("Multi-cmd ioctl");
> +               /* In case multi-cmd ioctl failed before exiting from ffu=
 mode */
> +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> +               goto out;
> +       }
>=20
> -               ret =3D read_extcsd(dev_fd, ext_csd);
> -               if (ret) {
> -                       fprintf(stderr, "Could not read EXT_CSD from %s\n=
", device);
> -                       goto out;
> -               }
> +       ret =3D read_extcsd(dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> +               goto out;
> +       }
>=20
> -               /* Test if we need to restart the download */
> -               sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << =
8 |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << =
16 |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << =
24;
> -               /* By spec, host should re-start download from the first =
sector if
> sect_done is 0 */
> -               if (sect_done =3D=3D 0) {
> -                       if (retry > 0) {
> -                               retry--;
> -                               fprintf(stderr, "Programming failed. Retr=
ying... (%d)\n",
> retry);
> -                               goto do_retry;
> -                       }
> -                       fprintf(stderr, "Programming failed! Aborting...\=
n");
> -                       goto out;
> -               } else {
> -                       fprintf(stderr, "Programmed %d/%jd bytes\r", sect=
_done *
> sect_size, (intmax_t)fw_size);
> +       /* Test if we need to restart the download */
> +       sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
> +       /* By spec, host should re-start download from the first=20
> + sector if
> sect_done is 0 */
> +       if (sect_done =3D=3D 0) {
> +               if (retry--) {
> +                       fprintf(stderr, "Programming failed. Retrying... =
(%d)\n", retry);
> +                       goto do_retry;
>                 }
> +               fprintf(stderr, "Programming failed! Aborting...\n");
> +               goto out;
>         }
>=20
>         if ((sect_done * sect_size) =3D=3D fw_size) {
> --
> 2.29.0

