Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64F9C43334
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Jun 2022 07:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiF2HdP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2HdO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2022 03:33:14 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150130.outbound.protection.outlook.com [40.107.15.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FD313D5B
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jun 2022 00:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mrkb0vGTwliOdva0zF7z5EkN2rbe8rSPL2cw/L1ZEG5Wt0XKOFbLPO6/rdyqK8fbCwYvXFcdTXisLww8TyFbpTmANzHNWRMTqvR/6R9n8OkD3H9udoiPgHk1KiPgI/2o85D2oL8KIhE7pWGm0NXuJi4OAZA6pF9pZfq+GehwViKvL4u6jpeqooeAtBHWtFWI5lgIJhk1hP8pI1n7xnZt145ehM9ArmdHHGfDWBZSascJu3Sd9dUsQisnFMKipVJAoDeCcn588aRHUjyOkZ3kQ2m52+z34VaDYQf8id3KobHV5DGlkna4y5cNSNQwqS59V0Jrli3e2IgrCbtnRNEMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eVqWozBZFMxcM8jPQCVVEF0CRVWGhLJRWhau5UeQDY=;
 b=DS6+A5PHc4TipaWMyt7ucAq6AT/abtEUbD8Cu6iq+Ni40zd/A8iTX/qFAUWYD8z2yvUqFU/sEfKDyGgPhUEU3LBonv59iECKBRxW0kmXtqc18iPSfoR71CnbkuJfZeuyssJJXgCSTLYCrcHdfUzXCmxzpJmD73WnreiWiJMBnMzduXci7mRkTNDFiJIsqhutK9lz4lly6Ns5J7pIHxxT46f+CdJOLk7b1u76E7XleOHP6RGtQKcHzh+eIAQjGwrZHo+8edwAIWNJnK37JKiHPLwSaQpE0XUToUxWpDhsJ41NXeU83NuhVFkO6aY7IQ0QuM8a1fq3h217t8AwpEGHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eVqWozBZFMxcM8jPQCVVEF0CRVWGhLJRWhau5UeQDY=;
 b=Yxcd225FP0LpbvGHi9MnrbVZJ1Q19/RA+LN/BVXp7SLW6iQN4hC0+JysOUY8aighCac2Dudi38watNrCC5GmaOR1e7bJdbUx+yG6iCzojv055rqaW5T++qf7jCKl7saXMU/DYPVQVRRGtTjXGlUi9H4vwZg3rqokdBQNGuU8RVk=
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 (2603:10a6:203:4e::11) by DB7PR07MB5751.eurprd07.prod.outlook.com
 (2603:10a6:10:56::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 07:33:10 +0000
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::3593:a351:dfd5:7f98]) by AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::3593:a351:dfd5:7f98%4]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 07:33:10 +0000
From:   "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7QAPwi0AABQpUuA=
Date:   Wed, 29 Jun 2022 07:33:10 +0000
Message-ID: <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd8840d4-adf5-4726-07d3-08da59a19e51
x-ms-traffictypediagnostic: DB7PR07MB5751:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qG8sZEHy3czkgn+l7U8zo/+Rfa706CgERTdBhQUc7Oo/3D4KZMd6P7CtXu9u2cyi8wJ7y5PInFt5T9azMt7ZS1P3lHXsvwYLSnjaLYuQWXn7Fedu94GszutNlLn/RRSri2RicgPRRhVWJY8Cvush2hM7SQ0JVC53OmCsA2jeVUQW+t2XHfmPTBI64d/h7mHSVQ+scbSoBB/p1SlUyjZooCVr2rQELTR42RpsNSWnShFSfcfFSXes2BXilaw02RVWJ6vonlmGpZ01pzl46RXeHwG3uIGFN1+Ucls3bSbURTWPETXyxDHDeNS1pTELJHC1m9RiTHSmZOIYP1z3kgiIh1j6HSBeFHoDMjARQfzVaHqvy7gMv2KSpTkleAQLwxf0cpudzTbU+ZCU6h/ldlwAbV8oclfZbL1reiniTHn7mQELhHdXcpR07QAm4g8i/3q5CcNox/dLyB1oHgkGovbwPADBubrc7VTMFtI+qy/uvLu1zgmG4XNlqw1pmUMpUr2r8V4el/wGVyBSilMu3PEORXALAE1ceLluL9NmY59W+YmLHoP5Rd7UHEJNrgvPfiUrBwYZi/a+vXdzlncBqqcwf5y2NdzOxK+q3M04p7sOPZO0I/4rOvnpWgewl4tzflWtnqoYBXm9UqfyBPgGu6PjOkn9qRIEpOxZynVDvfk/PkdDSEyguDwWPX5bhWtkQvGg3tM1+YKg0SVn/KzhZtpj/j+9df1bSDYVDgkPLr8Nri8KlE2SrIvwK0NRQYA8RjC/uceLGT+CfS1smPZIsPYIJEcjyeiSUgvkvn8kNFxCeLoKKFlFgS9PGgtYMHAWvFCb0gZZZdSNE95i3AYJZ1LKSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0701MB2964.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(33656002)(86362001)(38100700002)(41300700001)(53546011)(6506007)(83380400001)(7696005)(38070700005)(82960400001)(66574015)(122000001)(9686003)(186003)(54906003)(110136005)(478600001)(76116006)(8676002)(4326008)(316002)(966005)(71200400001)(64756008)(66476007)(66946007)(66556008)(66446008)(5660300002)(2906002)(52536014)(8936002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Pxxz19QvPHTUtYORr2lalat56UHCzyzUeZzuxr8Ns2d1A/MYaG0X6kJbXb?=
 =?iso-8859-2?Q?mHONtDlNINZ/wygU2W2AvXuk63qMb+LeFsTCLCTJb+ZYX+ov4HTbClBYtS?=
 =?iso-8859-2?Q?dgZGeyuG462rvnkrVVpg4BZh7tIZ3mNnT/jX4cw5rSkmbKx6JOyW0NvLir?=
 =?iso-8859-2?Q?N4m6NwBfMqPWWiOBtcmMO2qq+U95vtezijdbrwjNrMTfusgxrXyNK35ee8?=
 =?iso-8859-2?Q?9s8PXI+ItqFG1tEN2Z8Yi3uWhsm8iN+MmXRbzVybkC/+AwFcLRVcqazw2V?=
 =?iso-8859-2?Q?vv++4OmAQJi1RzsAG0vcS+O0LTM8TjEuHQTnefAlzXTHWFILEGnwbctnPP?=
 =?iso-8859-2?Q?GFc2HHQ9vEcLUw36eiYQI613DlG2IjgFRf7VikOLSW705MTIhMqfGH/74G?=
 =?iso-8859-2?Q?xRPkaNFi2bAHzlTWvgZly+6XTGan2IMnait8xXOamALMw4uzdNSZEAfjzW?=
 =?iso-8859-2?Q?dcWZ/dvznuFmhC2yqt9STp+T55m7bHOvYyQ1+q7ZA3/kwpKI4ASfvNTun/?=
 =?iso-8859-2?Q?xECUV0C75kYz0apkUD/a0ThJriefhhmuOlV2vjdozvdvvtqQ+yddeYvIhf?=
 =?iso-8859-2?Q?8dbXzvnEUUe3yH/rKrfEoiSfHakJHRrap4uuRnjoknY7ZP8qeoyevHaG3s?=
 =?iso-8859-2?Q?iwrqp/QgB3ggJghNXgiMUlfIjiXwgAHNI/z7zqBk/SNh9zEvs3X+VhqeaR?=
 =?iso-8859-2?Q?RwcXpotOLUQXpDGaUjmX3L3LlL9OFWWskuDdyaA/Zf8hhEsZNfEDA2N7mS?=
 =?iso-8859-2?Q?F98fSb5rgHapHnL2jhPGFOveF8O0JcPoXmy+cyNGT/yUQW/vxdo9cisogj?=
 =?iso-8859-2?Q?+8cM1QxcrJIDn1W8Eq9M4pAKOeLc8mvkThoT5BZYY2ZWGbNvqtzeXylgQ0?=
 =?iso-8859-2?Q?BGY4oeVANzsKpGhsuGJ2t2vLWPgALqIJiA4GRVrgPwIwl4dghpMf9yzvSB?=
 =?iso-8859-2?Q?33CelcG4EyQCRvsp3REHyH2+1FQ4CloSgSmDKZtAc4RbP0O6M7jRyNH99U?=
 =?iso-8859-2?Q?DQ6VNRPg5VJLg3Rnl3KIrRgCNjAyg/TfA0j5tZ+PO6VDR/0FIwtr75G+x6?=
 =?iso-8859-2?Q?Rn11n72GQx1t2x8z15nHR9TQCl+ZrQ9Av7oqw8VZKGt1clfOt2efK6mRCS?=
 =?iso-8859-2?Q?RdpcVt4gd/D6FxDHLyBWD5tp+7POYpI2EZ2Z+nFwnZGgRSA3Wn28yVVeiy?=
 =?iso-8859-2?Q?j43iWWXsSAS+uD1dLtyva2aEBdbrSGNkBgpWd+XAI4ZX4aW/OK14eoZgCk?=
 =?iso-8859-2?Q?FoRhbF34nKtM+WcF4xrLwCMbyNjhxeEPuRyoDVz5ZqYwaJjjmBYIw681WM?=
 =?iso-8859-2?Q?RFntkICSvOVekJe4p2SQaE+SRUsG78kX9xJdtXTEZL1t+KM4d4Lt4xN3b4?=
 =?iso-8859-2?Q?2JDNatHoiyL3VFDw318y4AjB98/RSrv92H5M0r2z+qRmZA1rKxz0FsjuVO?=
 =?iso-8859-2?Q?XYhw51CZF03tInSGtThI6L5kX/cQK/jcV47ATDBm/WEcsWHWxGr3NnWWdT?=
 =?iso-8859-2?Q?LzRirfpeTU9aGUTCKtD+qvvgCzi6Kd86IzVbMZfSkxLiz7tQpl4ia/biIw?=
 =?iso-8859-2?Q?3BfQhaPf5ScEaFqE0boo+doKwK8VuilidVbpHc0OhagVFttLLzrutBFhCt?=
 =?iso-8859-2?Q?LYztwPyTERosQcZa4riZlO6sYKfuOgmtVb5nsw46kckR/ssM4uwnPz82L6?=
 =?iso-8859-2?Q?wQu3WHFLUetUsyOkqPZ6oM2TW77CHKU9/INCCl5E?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0701MB2964.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8840d4-adf5-4726-07d3-08da59a19e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 07:33:10.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvl1OpV7YvTVWcus7WQUIWkxEBOa4bB+UuShWM/6rjEiJ8nLxaZqVQUenfetUl4Ku5qtHVt+f23bps4HpaDTuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5751
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Avri,

That is ok, I will wait.

Best regards,
Bruno Mati=E6

-----Original Message-----
From: Avri Altman <Avri.Altman@wdc.com>=20
Sent: Tuesday, June 28, 2022 11:56 PM
To: Matic, Bruno (Nokia - DE/Ulm) <bruno.matic@nokia.com>; linux-mmc@vger.k=
ernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>; Christian L=F6hle <CLoehle@hypers=
tone.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling

Hi Bruno,
Thank you for your patch.

> Add the check if the whole firmware was loaded.
> Cleaned up the leftovers of handling the file in chunks.
>=20
> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
Christian proposed a fix to do_ffu about a week ago, see e.g. https://www.s=
pinics.net/lists/linux-mmc/msg70961.html.

Would you mind waiting for few more days to allow it to finalize, And then =
rebase your change and resend?

Thanks,
Avri

> ---
>  mmc_cmds.c | 69=20
> +++++++++++++++++++++++++++---------------------------
>  1 file changed, 34 insertions(+), 35 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 70480df..e64c747 100644
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
> @@ -2925,45 +2924,45 @@ int do_ffu(int nargs, char **argv)
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
> +               fprintf(stderr, "Could not read the whole firmware file\n=
");
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
from ffu mode */
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
> +               if (retry > 0) {
> +                       retry--;
> +                       fprintf(stderr, "Programming failed. Retrying... =
(%d)\n", retry);
> +                       goto do_retry;
>                 }
> +               fprintf(stderr, "Programming failed! Aborting...\n");
> +               goto out;
>         }
>=20
>         if ((sect_done * sect_size) =3D=3D fw_size) {
