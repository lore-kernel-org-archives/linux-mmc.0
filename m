Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0F3C433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jul 2022 11:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiGGLGi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jul 2022 07:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiGGLGh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2022 07:06:37 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20132.outbound.protection.outlook.com [40.107.2.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FE057261
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jul 2022 04:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpx1i0JDIMhvFpft04FjrnbVgPdIeIAe8XESqSWAyW8Glaa9/UAn1HeEeOOfbqzVI91waWEDiZ0mCY+8wBORhHzSvP5LVdHjZu4XDCtKvEhUicxr6Dy+IQu56UAILKsRxCbiOCBEIL9wsn+fgwKayKg+xF5a/GhAjGwqz8/V+SIWkvsJuuUWzl56NcUz8zPjuPKSPlPcuXr3nvQmkFcRwI1+Wlm8pLrbAjlIAFiv8XcilhyfE0j2zCxkeVAWBdP/I3DGowDkwgg7mL/AphIbsGKsfL1uIwZIapwm8JJ5nr5lbU4kmCOt80z8RBc4CIB2+BOj9h0Iz1ttPeWaRtp6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYt1sbKBHNOecxJQQBpOULSKEvDJnpZwywq5yOy9//M=;
 b=nrMcOKkBkKzDJuucrN4I3xeQdmKoE+9fmVWW0RCKb8oPBr3+2I2zB72OYnPULe7D2RYtqZJ7bLWrsl2ZBGNMZHj5YsN7ZIzDzjRGyMO8OgBBUg3cNLdrxbbzUxoT45S2iOQEoia0YRt7UOJnK0BDCG6LP49pxbu/UITsFiXBK+9ZxPdPYsO/9CjYXzqzcB4MDrfZMxqBcCUvnK4YFvngECodqlzx3oOR/veS3PL0aorWAeM9WJDn0jXj3Ey3sv4I8gdlCv/bZEO/M6SZjXTtQoeHuG9lLQ4cznKKqDawanNHH7WLezgpRwisU9E9kAHx5S+TLmIoDRq1g4XDUnQMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYt1sbKBHNOecxJQQBpOULSKEvDJnpZwywq5yOy9//M=;
 b=XQOoyeEqQNGQ5GwlCfX+VQLZCyWQt09IZrUkqXBzrz9XZ2rhh9/34xXdvXzrkg06QlU19JBZXEKgHzNuLysiv4NuIpWykrGXDsvYz+3F7Dbu9AgFhA1f+UvyKekhcy2+LY+1N2EJonHhPH3nPdhN98sf9p14ZT4UN8pRk+Khqjc=
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 (2603:10a6:203:4e::11) by DBBPR07MB7561.eurprd07.prod.outlook.com
 (2603:10a6:10:1ef::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.5; Thu, 7 Jul
 2022 11:06:33 +0000
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::3593:a351:dfd5:7f98]) by AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::3593:a351:dfd5:7f98%4]) with mapi id 15.20.5417.015; Thu, 7 Jul 2022
 11:06:33 +0000
From:   "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7QAPwi0AABQpUuABmc8nMA==
Date:   Thu, 7 Jul 2022 11:06:33 +0000
Message-ID: <AM5PR0701MB2964D76967437E61EF42731DEF839@AM5PR0701MB2964.eurprd07.prod.outlook.com>
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb46f936-cbf5-47d1-cab5-08da6008c0c6
x-ms-traffictypediagnostic: DBBPR07MB7561:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNSeTCP1kwS3qY2cI1wu8fNEECT0zvdHCYcWg8h1sjpmRxSyPyLKtVj02+cW6yYbrIauta0drUXLLQB8BkHF8SqK20WKw4O8jLeuswggqBCCen9TaQaUzYrLDKOK6tAfsAS54fMRRZ5OV6TnTq5vIpLmNpz1C8wa4IKSZtS3l9uBMuoJfV6Tv8IqyzrXAx1Bn1NGUqKrglpas+0ZTsejAnzP4c4WxdQ5JdfmcIMyrp9nx+AvHR2q7Ey4ioWPEI29WUxGDYzbT8kpXJ55xDdc3yUtyDnWN+AXlxkE/9BtaWxyawpcDmgB4cth75Li+5kd1s5Jx/tH1k8PnUHrktBmJab96QbJgN6qdmh/vW2Dg2UtHYvEM99LCAUtUp6jP/7dj3S2v/MQ5bvxixGtSn2S8Asjo//8zS4ZGuH2HpY2j54UK77wxb2vYLWa5nh1DRSLcVozg17Fps2xhLW0EqQKZejnut/BTOCVwLAnxVPoZp7yOmbYMNGXXC7lSIIijQOsdVQuGf6en55ldTqNF9u2C1XvjtZTRn5xvzWIA6I6XKrQgQfLBh+Nd1a0SUhE6QKMhViey+GZutN6V3COcTXlQ/KjSWbVnL09IyocQi0Im+CKUApmQtznd7axnOnv39WiTYXRHbl2AtynhCSYAodhoFBck4vnR7tYOyunJU3qrSHKHbCQcPZ3o3XBi59BESJtO5rAylbJdKivPBRQBXVt6uGFcX6rSfXgIbrdnM/TWIyKUNLR1vbdBtGsxq2UuMizGcmfgk2Yz4k66BVhb1w3TaRofXdNPMGaWvdfcxrqeky5tltG9pKZQOcqZiTJ2CGBuMInHz8GME1qL9PevX4brmlUOq5IQ6nfa3MzqRgP6rTZ/dafUpxm3G88wexDYmDo9Gdb+D1TuNKzCSsckvn9tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0701MB2964.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(8936002)(5660300002)(38070700005)(38100700002)(122000001)(52536014)(41300700001)(54906003)(110136005)(966005)(82960400001)(186003)(316002)(6506007)(53546011)(478600001)(7696005)(26005)(8676002)(66556008)(9686003)(4326008)(83380400001)(66446008)(64756008)(66574015)(76116006)(2906002)(66476007)(86362001)(66946007)(71200400001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?K7Rn32lEEusZc1V8Z8002phgaqpPceUk1dQG0kSl8YPOBNG02n1ip1eVoV?=
 =?iso-8859-2?Q?X8I5GqGZ1FUpLYtWsFdbOYCzydHZUzBkCNF38Zndlxsrbz8g7k0MKYXs+U?=
 =?iso-8859-2?Q?W+nQ0QO94OPErbijIdBvOPBFIrpAIkM0m+gklKGJ/eUuHWx2UXBELbDM+Z?=
 =?iso-8859-2?Q?Iq7T1vEPZTrrR/nQoUZxe979xus3e9fBf0lHyQFIoe5gElEZKTZdheMz2b?=
 =?iso-8859-2?Q?yNoLFcCpNRs4a2yHeZjEB7F/QVk/eXGKw1XLYgnZLBfqPjLFjkq4xIQ6LB?=
 =?iso-8859-2?Q?xvH31SpFkAKNGjLRP6aXi7fFyNmfW4/xkLxLKPz0s/vYD7suFKf2JRCdmW?=
 =?iso-8859-2?Q?zc3hUAdvlZ+IdRwK8ZAtoAaLODQOpHTyCmD5Ed6IaIxmNxHs7UgOhrelPz?=
 =?iso-8859-2?Q?TBLKwi4jGhpxwZK6gbWiWGnBfOaZF24WvwTiXskufOltdCD0Ps70sgV8w+?=
 =?iso-8859-2?Q?VznplGH1On8fwlZVULOjMxk7WbXSiEQHX6Tr1JGzGSfAZHFkqvZZu2e7Vn?=
 =?iso-8859-2?Q?WjGxpMuc5B+XzKh91P/0x7yVbHwJFK9N38GdlPjj/M0ymiDtyEjXHuZIAQ?=
 =?iso-8859-2?Q?wShOecSM6cLQmjlporPHoJmsl8n7eq3b8HfB69Gu9DjfYyo0kQKry/wUwm?=
 =?iso-8859-2?Q?SRGjlLoS8KW6b0lPmLGshScR+W01n+0knIDshj1yG0wWsW2muqKsnkN9YW?=
 =?iso-8859-2?Q?or+QfvuzQjjSFHPR6+QoKsG/C9iYuP9LPQ96jlYIPf47iM1GJ1ctIvdfFh?=
 =?iso-8859-2?Q?GtKnb+6uWjtXanEABFfFKCiak+CcxtXrhNSsibEZRv5IF85kRp7cxwAiKH?=
 =?iso-8859-2?Q?BbaowFabFo/nM4uB+cR0NPfLacptsluPUyAWd/AjJ4MonpicOc+hYEwoja?=
 =?iso-8859-2?Q?SU8R1pPmN8uQXfK0iACdiP5+uv4bOAPV0mafW+q3QNMVg+zXh+/1GNYxu4?=
 =?iso-8859-2?Q?ytUJHmgZiThPrwdWepUetDkpdzuXQVQme8W2PEB8U9980nJtzraZrdfIIk?=
 =?iso-8859-2?Q?uS+ROlRILbYQUv25T123RcDlVeG4m4FtTDBaINUEFJh96gcmtFC908o+dM?=
 =?iso-8859-2?Q?ywk1xEZ4geqwnovflpujTQSa1h+u4wEXwhMYJrZDZDInYemc0Rcg0/PhCR?=
 =?iso-8859-2?Q?EtgL8vBR81U91mJXvOUYeeJqmnp5j5LSGEKeAuQNwXMhKwMozLmBbmoGQh?=
 =?iso-8859-2?Q?i4T+DeVRq9+qbwkc+5yjnmxgGj7Yn7vJlkFJaNfXSGCxAi4x74VDOaDXhs?=
 =?iso-8859-2?Q?Nkfrk5N1lvaSx+/Ftr6eiUgiqWSZk9idgbIxwxF0DAw0PmbeZ3vBm0RU31?=
 =?iso-8859-2?Q?xKL/wroz0N7OkoRIM7iKfLfH5nlOOSuMg7QcfHbrXtVQ5v2Jd/YJvO9Xub?=
 =?iso-8859-2?Q?FrU+KuNozsgJTSy6SC0yxNA+vE1gb8rZdBzUvffN1fzpieLZRdzxItqR6T?=
 =?iso-8859-2?Q?LLooYJCSUUGtrfbhxYB1XYSS4CxC8t8Wf2MsKyYDz8VkZiIz7h7I+JXYbz?=
 =?iso-8859-2?Q?6rcTtcRHli26IjSw9SQ8BwSsa6N394mKH5riJPABBm5dbyOtrh7bY15UaH?=
 =?iso-8859-2?Q?3Lakmy1lZTNKyFNL9oD5L/nXadW0fDRFZ5ocbMSrk25f86wZaTVhLGKchm?=
 =?iso-8859-2?Q?DgbOichDDns8ZymITGai4r/nUVUZXlsi13?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0701MB2964.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb46f936-cbf5-47d1-cab5-08da6008c0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 11:06:33.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /a2csj36CQ2+jp3JIePvWbDbzPTZQ16RVOc3VnojXPQ88v9lZHhV34S5A0FZTkc/v+0H2cWHziHVN6VSfKTDmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7561
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi everyone,

If I may ask if there is any update on the state of the merge since I can't=
 see anything in the git log.

Best regards,
Bruno Mati=E6

-----Original Message-----
From: Matic, Bruno (Nokia - DE/Ulm)=20
Sent: Wednesday, June 29, 2022 9:33 AM
To: Avri Altman <Avri.Altman@wdc.com>; linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>; Christian L=F6hle <CLoehle@hypers=
tone.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling

Hi Avri,

That is ok, I will wait.

Best regards,
Bruno Mati=E6

-----Original Message-----
From: Avri Altman <Avri.Altman@wdc.com>
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
>  mmc_cmds.c | 69
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
