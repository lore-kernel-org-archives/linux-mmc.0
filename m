Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044ECC43334
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jun 2022 21:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiF1Vzy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiF1Vzx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2022 17:55:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319CF1AF1C
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jun 2022 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656453352; x=1687989352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QoVFQu5HfRofalsNMuJbAKFCTFRiDra7o0/ffTAa0RY=;
  b=nIBRoVZYN0TMgnyCZ6yTTfrUtqI1NI9fZCC0n2LJZ06rlnPVszFLyYjd
   yz8UnVrdt90i5xwqrntBHFg/dP43rcgas4+pntSvz+HUW9y2gb7LVeS58
   vCiYMRA5Hb7Pq/caNug/HYIWzsCXp5KOQ2AxF95H9hmkuZj+ioEJ0R+/I
   x9IuCapFEPxDpSpXpuLn0d/GnlMN2bWexx3NumJQguE1a0KuWqdnWCu6n
   MYvv0D6cL3G9egUxAYJrnHYQSFKtm8s5RORrYp2h5YcZnkP4S/4hSsL4S
   0M9PPpCUwsyJdao0xBNSnNr5lIPJq8PJtEAg0lw+aNR2hF/jbsQZ9Q8EM
   w==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650902400"; 
   d="scan'208";a="203004529"
Received: from mail-mw2nam04lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 05:55:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvzOFfXdqa4vpbJDkc0IFEL2g/pLF9npsdfJEvv9bIy06XuwY7xelSIZHWtTF/HepiByHgQQQnmUjhYb7nlBdyukE0bb/IMIlYG0xTO3s9v30JYc+NMDjUhuxF/z5EurjGd/vx1lYSbrvrBTQ/TpueZFuxTq4YkBVqpUKlylYDx9nynr3TK9UyN89s+ii/lwq608wQcusTHRWToathNSy9ixP8oG3wHjSR8G3Bu9pDsPXo+V09wS5QgD3zoL3/bf8EJ8eP3v7CAj/UPm1HES+h+2LLyLOEdCw2wRJH1MCFmqIsDiHro3+0cU/Io9T9cacJsbyzydrsTyJYRT0N0pcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5+wjD8F7AUs7ExOQghSrcyaIj3MpuFYOiWyo3dtoy0=;
 b=Uh5X+evJMaNm/D+WjqYvXaC/Xd6NHC2Q2qtu3foxBj6mVOP8F9b6N5czckuUCtfNjKHMhdm/V7igWCZD61CsrqYaGMmGEzPuRmPlm3ZpH8mE7qxlcQlG3QUSnkYhQSAUhlmxuMbkkU4DtxFF3/BLd4zmWZsesamAgbdE7O5wHBr5sqaZUf1nk+eRBuFvsaUL1yjAmXjiTdtDpDMgp3Ldna9kKXJc6NCUgNFBb4xjI18hN5SIOA8tXKkLRuagfmWwUsmyB/Sxy9yA1+I3y++Vuod9LMrnDLibHW5C4jB+iB1fT4OI6XgTqky4jLBtUxHC0Zuoepuqm4vV2A8bdrEOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5+wjD8F7AUs7ExOQghSrcyaIj3MpuFYOiWyo3dtoy0=;
 b=RDmSPkcpXxRwT7dMqa7M+6y2UQ3gSbzuIc3DT7y9wwkvc9N8CYh2Xy+GB9VopyYaXIX0T9f62nZ5M2ZTVWI/Wc7wD3pTwDq2BwW7bnJK4qAidcIugD29j0xjIYaE7QO9FZ+q85iE320L3B1R8U9M9V0gPHHe0WbXGMPQAgOiheE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CY4PR0401MB3588.namprd04.prod.outlook.com (2603:10b6:910:90::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Tue, 28 Jun
 2022 21:55:47 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 21:55:47 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7QAPwi0A
Date:   Tue, 28 Jun 2022 21:55:47 +0000
Message-ID: <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca66c460-f71d-456b-0874-08da5950f54f
x-ms-traffictypediagnostic: CY4PR0401MB3588:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMrxERQHJanpoE7Zwrs0ym3Rrcfg85iAUqG1Pxgskvj1LvRm64A17OqGQdZHSLz8oX+QGNWD9KAgle66zkz0MzJenNk7o8amtIvksi5pjm9S5TdqBc9iYFeJVdcUJ1NzL1vuaEKR3CSmuiZi4aERFNJ/SkDgMWl4f+XfW7XkKKRRE6NVdbG7g7+YfA28/lbKxx1D0aVqNgBZFOvskJXE09OtEeZMOre2sYnySsZ0MrnCclGDc884tItazcx/QK/NqbLci8yi3qrtKxF1dafWkkxIfTtetznJ9K2fpIL/cdctXZRIa2OaA6wNy225Xu2Q2RO5szFGw1AHHiDk/Bw5PVmXSyqCr26wm4qPcKaoe40Vw17Pkj66VOCFJfszfAV4i/ohK0NaxgwKRa6Z4MS7XShp43be0vZEcPT7trCmC8oSlEi4Wq2RrU2Q1zzynC482/419En4Pz8MVXcGHX7HC1SkR0NAuVZedOW51E0IPN302v/CYHglVQEjohZdO0QGNc2Gy/nKf6iYcdy2YYjmkXC0WWkHQ0jPkss+i/hRzxlNjmAjaMYoiE31O4kXa9HSWLl6EdCzwOvkskHoEFbpQQT9cn9hiQk707OxRcWyZelQMJiNtu/DPWCiMdKWDXVNDbFLHo49aHhgo0RvO9qyiwKfiHaeYPjpXEriYMrLSFdMHyTOSgJGJgAjUM92stflThV8p9PPOgXaMDaFzbP41Xuw1NqMI+djd0orQKgZUDji+PUL+rTKctZy3GbvQzD7LGSGFsMOm6rEFFIZ4NNz6N3SA/184o7L5hNHrhRsPPLGpsfkYlQBu1GbctN303tRcnKgH+vXeEdCw6G0LqKT+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(9686003)(38070700005)(41300700001)(38100700002)(76116006)(66476007)(7696005)(66556008)(33656002)(186003)(8676002)(2906002)(26005)(110136005)(64756008)(316002)(54906003)(66446008)(8936002)(6506007)(52536014)(4326008)(122000001)(55016003)(83380400001)(478600001)(86362001)(71200400001)(966005)(66946007)(82960400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K2PGlwbuMJ6EJE6S0MHe2NwBkvhK46T50Py/0WkX+oF5kNifBC8E8sgxBO?=
 =?iso-8859-1?Q?mvIkps7pICdqxIKWn+VPDxtEizPSoOZlB4SQr6yjCkAiJCCRHsIBHJzLAe?=
 =?iso-8859-1?Q?wSC4Qy/rk5s3hfW/i6xYVPghIB2O7BZRxWgARRF4MVyT8ikbnqi91v+h4T?=
 =?iso-8859-1?Q?uNNQBcivE4cdwYzZSP1ipqNZlsgrw/O9uYEOwafYtRJkcs8kVvuLI+cneN?=
 =?iso-8859-1?Q?82dprqUYsdig/HNz+EQnJqv1gK0bbm0Z+EBZAdh4+TdhE6r6+lk4tatm8M?=
 =?iso-8859-1?Q?6B3YkWGRA77qCsFksD5vaM5hMCMH4km9LVARJbQiw1GIq3RsshzzbTpjRx?=
 =?iso-8859-1?Q?rSpfl7wcLU6gsXHUccP4KHMBxAseXDLTMETPCBRhDqTxe5tYKS+82NEchj?=
 =?iso-8859-1?Q?r6nozeiwYrko+Wmmf+AlzTUP7XmkDt5qM7vDdZMijN3WIc6bXWv76tV2KE?=
 =?iso-8859-1?Q?bbVQIqtcopVdjLOsKFeQI+9adXojP98VOECjLW6l3vr3Iaup+QhQEujEzW?=
 =?iso-8859-1?Q?jEQVF8psMM2ZGQ90VeowCqiJIzhzDm84f2BuA8r7tJxXv/GV9UEXO5uluY?=
 =?iso-8859-1?Q?lPe9cvkAVwBod4/9clTNPtzcRUFCrAss8m6efrQLm0W9XCTykGJfz88eXD?=
 =?iso-8859-1?Q?gpXG+Tva0Q0eZkbMftpt/yxp/a4JsrO8XVf5o+kEN80pOCh7lMjLZ221UC?=
 =?iso-8859-1?Q?iDyjZPNhSLXPIyS6jcf/gEiPLWs3BY4HznMOrXBX4rwzhLZUF3bZCuE/zv?=
 =?iso-8859-1?Q?yf29/N5m2seYCohCN18sOgAyvMXsY1SazUHX+KfUJZpIY0Ndn/oZDV1lTQ?=
 =?iso-8859-1?Q?C9eLqjveCAR21Mdn3R9zbteeXqxoPp8HsANswzoE8bNGnnci4gRsblmZ7h?=
 =?iso-8859-1?Q?eLvpJmlQtjQKUUxIiR7V06Qr2wzsLkfJIfwM8JnHBwnack1otsc/Vedj+k?=
 =?iso-8859-1?Q?uS8ffR5uCkQMDgEwaonZktZ0sHP/sZAri7pO7C6pfl5/qTCY/yZFOiQgaM?=
 =?iso-8859-1?Q?1UYE016YqBiFIQuZZDj4FNtbbKQ3+GQttbqDUBnOMHnxMs4NRRupc/kQQF?=
 =?iso-8859-1?Q?SxAwbXUr2qvT2nQEhciiR8+uEK2tow6YltbTIVqny8XEkj0a8wKyrkwc7x?=
 =?iso-8859-1?Q?8/2VbZBRX2+d93xjnIMVDpcfXlQqOZdrV06MGvILB/JJATYMIlSQg0xE6A?=
 =?iso-8859-1?Q?0PYqU7A1UuFOj717Rr7wLaHYUbfL5h06UN03MJFjLW4otZorFDK4soUwNb?=
 =?iso-8859-1?Q?5fwCSRFmDhf/2LmDh1DIvqSDD2SkIzVD8/RxnB6pFsk5bjAIJfI1aBbLLV?=
 =?iso-8859-1?Q?aFDwwyET0V3BA+w8l8YGjz4e8VdQfukOHWpTsoYSHA6mVWUWsPy+oX14jo?=
 =?iso-8859-1?Q?o1C7fSoe8KVXNjGQop46ZNKomf9hx9Ph2qKgLPedQJA3VMVJBbJuvhovIF?=
 =?iso-8859-1?Q?Kh3nqeRJ9FvTcufT7PY318gjtTaykuXtYNOGTZ3rtA/E8s/JkXIsWB7whs?=
 =?iso-8859-1?Q?MzPy+ggvWUtGUJaDdY82EciNwT2BeNwg84Cuo9jsPd7KQq0SYkYFW7USGq?=
 =?iso-8859-1?Q?n8COD4Jl6Ar2dtojUbUamc984An+e6ewdF+vIRqNlY3HcBJClD5C5DoWUD?=
 =?iso-8859-1?Q?GJhhaAyPN64J1cqgsVR/oRM2vTxRdGkCa4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca66c460-f71d-456b-0874-08da5950f54f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 21:55:47.4043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRoAidNAQ3DKxrdIin9s5K0h8h7wLzetkiBItLZFDaZFlDuOmIJ8WM+BY1leLZLJO5pUHnps7IS7Z24dXg1ICA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3588
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Bruno,
Thank you for your patch.

> Add the check if the whole firmware was loaded.
> Cleaned up the leftovers of handling the file in chunks.
>=20
> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
Christian proposed a fix to do_ffu about a week ago,=20
see e.g. https://www.spinics.net/lists/linux-mmc/msg70961.html.

Would you mind waiting for few more days to allow it to finalize,
And then rebase your change and resend?

Thanks,
Avri

> ---
>  mmc_cmds.c | 69 +++++++++++++++++++++++++++---------------------------
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
>         multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
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
> +       /* By spec, host should re-start download from the first sector i=
f
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
