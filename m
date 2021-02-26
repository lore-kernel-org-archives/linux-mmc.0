Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DCCC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Feb 2021 09:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E10E601FC
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Feb 2021 09:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBZJZ2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Feb 2021 04:25:28 -0500
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:17064
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230227AbhBZJXT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 26 Feb 2021 04:23:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJF6mc8r9qHtYqO96VUPJsbonoK754rNXwrR+BkmZTgrciDjgLquMmEQ7tnUcZrywv5Urk9t/vWjzjnDyTUW/FhJtMeOphRjz7t64neeni00XFdRgfqmY5OZaK9WNbLSaM6gaGt5qBwVAQaOlF+Graq+vZUE9KLqy8u6ghm7XL501OyXdcIneqPYR8YvRLCwzcw0bgJgRXWpn5yA85hEFQVaLpUiinWELZOoC2MSFiKwFJMOsr05gfodq2Gl2Fu94BdpqwlYUmyLprwMQ8fxbzgE68gHlX2VygrNHLxjD9zU/9uogP/qKa4Mazw14/BJ30blhq871Fe+H0Ud9vKI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5cataTPO7YvNP3I3wXoQ5fauMAaWg5eZ0e015nEusI=;
 b=bra5ZmfuhCJY4WHUSQTZfnWq1EG81gaP4tl8EGhHFWk8BydHnPMeImt+jt88BRERKJiSM23kDEePyR1sxtqXUXN+54AHvAKEZoGkKPkdGx8nFCCNIuv/upJS9tdOkfiR8iVfcq81oOd/Sv5bgKzye4udhU/3PGWed0TGuO9w0Rrs0WwNWC/CvUCNUmYhBz1IrF4ZqDXY8cEjd4HRruYr9ADE3N0cUk/8rsWH4ty8IXPAEUm7vYW+d6CLVVB/nAKWQiR1p52F0RR37Glr779jxAcIkfsYsZTzyvzoGZ3ZA2fnNIwEmgElhoWIAEQfV+L0WVNKpYkcJ+B7MDpdCkphRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5cataTPO7YvNP3I3wXoQ5fauMAaWg5eZ0e015nEusI=;
 b=H0CcLwF3BRU94w7335juZriZGGeVQyQSS1X4qtmAivPgxhqqOaepXdLz3hTABaT/3Vt5+jHdQMaVDnWAee5JoVvEuhfLRtSuiToHneysT9AI/JGUx9OBkM06yJX8vmMu2k1OaFuGnyYJTZwV5sAarZI1OqroBYY5d8lj4oEZ4K8=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (2603:10b6:208:1aa::10)
 by MN2PR08MB6432.namprd08.prod.outlook.com (2603:10b6:208:1a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 09:22:21 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::18c0:fc4a:5ba4:406e]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::18c0:fc4a:5ba4:406e%5]) with mapi id 15.20.3890.023; Fri, 26 Feb 2021
 09:22:21 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Chris Ball <chris@printf.net>, Avri Altman <Avri.Altman@wdc.com>
CC:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Yaniv Agman <yaniv.agman@sandisk.com>,
        Avi Shchislowski <avi.shchislowski@sandisk.com>
Subject: RE: [PATCH V3] mmc-utils: let FFU mode use CMD23 and CMD25
Thread-Topic: [PATCH V3] mmc-utils: let FFU mode use CMD23 and CMD25
Thread-Index: AdTvoXWOn75nh0U7Ta2A6hwTLWaWDoQ4/WyQ
Date:   Fri, 26 Feb 2021 09:22:21 +0000
Message-ID: <MN2PR08MB6397DB58E881F03AE2AEEA82B89D9@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <MN2PR08MB5951783BA8508D7C50907044B82E0@MN2PR08MB5951.namprd08.prod.outlook.com>
In-Reply-To: <MN2PR08MB5951783BA8508D7C50907044B82E0@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_066f97f8-1f65-4440-afff-6cc790915837_Enabled=true;
 MSIP_Label_066f97f8-1f65-4440-afff-6cc790915837_SetDate=2021-02-26T09:21:48Z;
 MSIP_Label_066f97f8-1f65-4440-afff-6cc790915837_Method=Privileged;
 MSIP_Label_066f97f8-1f65-4440-afff-6cc790915837_Name=Non-Business;
 MSIP_Label_066f97f8-1f65-4440-afff-6cc790915837_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_066f97f8-1f65-4440-afff-6cc790915837_ActionId=acb21e49-4abf-4034-8b81-4ca3c5c94631;
 MSIP_Label_066f97f8-1f65-4440-afff-6cc790915837_ContentBits=0
authentication-results: printf.net; dkim=none (message not signed)
 header.d=none;printf.net; dmarc=none action=none header.from=micron.com;
x-originating-ip: [147.161.165.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f6e9db3-92b2-4466-8e2e-08d8da380575
x-ms-traffictypediagnostic: MN2PR08MB6432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR08MB6432699F53786AF0DF729CBCB89D9@MN2PR08MB6432.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 71aY4lUuE4GPKqC3hnx17A/Y9hTlFWuW4r6BXE0o6tPC1Mv81nXjuFDz2ONpwNLrx8Qq+6ytxpY1jTLgeriMySZ8TtCEeAbKwB1GuTrkd5lq0wX0WdVc8g5wD1+rnd6K8GzTxHKePX5sBb6pt7MOrcKtdaJJA8Zz3GAKsuTLTCWHzFnoeRD96+iBGCRd/vOLaJODdcdnZUYYDuuaRWiyZ1xGsPtV6JAWPjNoq1RXgqA/JsKcpuTO6CWXpf289PbMAxOg2xdrX15uZMj9e8PjlyNj/voDqANBIF2TBuMtnHmbYSAL6RSN6jJKqJGscpCTVuXM2wgp22lIk0K9EQiq3btk1AjbZS3Vo4GXe6nh92pLhSZABsSn68tEaOsRBgjjJvY2FuPc3darT7/IdGpPTpm5+n+7zKFhtbyoAwx54YX/nlnNcGQfa6clkG4GhKMQyizc08PMW0jAUMKLJhHrL7I7Tvey4wJsYFHYuLt6/DneFYAXGDlCIMaAt6wMxM2vaWeLXuQJiN5YpjwLTdHtcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR08MB6397.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(66556008)(66476007)(55016002)(64756008)(66946007)(8936002)(26005)(5660300002)(186003)(316002)(66446008)(76116006)(54906003)(52536014)(110136005)(8676002)(4326008)(33656002)(86362001)(2906002)(9686003)(71200400001)(83380400001)(6506007)(7696005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qLKQDvUSba6zyYkb12PnAG0Zgl36/qvvDa98g1mzjJ3PATvN6pSmQVhn8RqY?=
 =?us-ascii?Q?Ek3P1mnn4ROfupxJLgj7qr/HXSYZS+npavZPT5X13CCy/YqGit4TKxzyrQBN?=
 =?us-ascii?Q?Ri7kuQcMsSEm7M4WZlEJAp32vgjKLegEe/diO1x48m5oOQXEUxUNMbx3Xp+i?=
 =?us-ascii?Q?G5pK1XYXW4mPYYBathVF0LuopSgnnleodNkv3KT5wlE6bXJDW/8ZUJqLZs+6?=
 =?us-ascii?Q?xUokTqIRvMP0rDmKePn5gOM0eaJETeZEHzMZzdcK+Qgp0HK5NXiMraJNKcLm?=
 =?us-ascii?Q?NoMJINLT6h33O95R25BX9mfOMadfH1lFfnRVrDWdMzhagr0k5Esh4tZAAD9N?=
 =?us-ascii?Q?OsRYvEPVVDOYMfz6hQie70Jw3I3D7yYgfroylsTZVUrjANStyQHOJVbs270E?=
 =?us-ascii?Q?4qY6JwbRavITgkLN8yQ4DTcHDpD8joXWiK2ackoO/SEZoiBh7fyyaJ/HgwLX?=
 =?us-ascii?Q?HPJ6aYDYbC8sC3cjUtRNIjSHawZzVX/uBSi+JD6nPqdLWl/pmwNJbaWMV4XV?=
 =?us-ascii?Q?Pv+WcDXw1IeOvJItCdtdtPew08FTmA7d7VsY+f9D5AbRhvHH1w+Fa0Q2Jjoh?=
 =?us-ascii?Q?SvZegG/HYreCOXthDKdE5v4sxM8gk9iOtmCDP+ElretTmMSBcCqj0FGBKhj7?=
 =?us-ascii?Q?2gbKSPiW14669rYL9CjZr7Hlsg2/pHYRDhaF7L5fG8DWP09wKlu78u7fA1W7?=
 =?us-ascii?Q?jyUkXU+Ta51szUwmMJUszq9vsE3Pu4TmSPzgZgZKSNQmek1JJfNL7OYTvF6w?=
 =?us-ascii?Q?/KpvMadSSe5siWt3Wba3ZqqqKmH+6Bx4L8RjlQSu7cK0IBM6G2hfP0LXTvjC?=
 =?us-ascii?Q?5duBpKTM9YefPpEJawz9e/QO91XEVNoWJajeMjCcu+TJ650RVe1USkkOnum0?=
 =?us-ascii?Q?PaOSWNr4e5Qk3ahD4aHfLNy9jtk69rbStFT7pGYvpxSviVWKsUgVcaCWInlN?=
 =?us-ascii?Q?lBR+ZfTVcbSuPoSMG2jdUNF1VxBHjRpOeXy0XR7I2KOo3TQKG1Hom0oDCmov?=
 =?us-ascii?Q?2bO2FWfZhzS4xD5kM28H6Cd71sFBc9wnTu0HBvX6cV6xxl3DVnI5/WYcYHJE?=
 =?us-ascii?Q?IEswzNoGUWLfCPVAabxZNfxb6/RcptN/EEEqu9ZWnTi9SWuuvwT3y7b8acD+?=
 =?us-ascii?Q?jClcON41BY7OxeBOWnQ7VDJy3Uhmymd1+TiagYiovAxDGXHNT3Pl0fjyopvt?=
 =?us-ascii?Q?vKByTf5tFB8wxucbUApDBQp/7+Gvv37RFd2OFzBkrWKtPQ9tos1VCKue+iY3?=
 =?us-ascii?Q?/mOHrM03G8CJxJwAQO1Wm7E6DwrHz9nKQtOxXA9mfyz/QM3diUdeS08waYVw?=
 =?us-ascii?Q?pSg5gTCLDgCvwAAhgeXuXr75?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR08MB6397.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6e9db3-92b2-4466-8e2e-08d8da380575
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 09:22:21.6424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSq3rzPoBLUNctuf99eYuoaCP27ATZXR7+urQhrBqyIIIHfSinNavS6YQEyZ7AbLcfv4NmHfVAmf0SClGOT9Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6432
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Chris,

I have sent this patch almost two years ago and reviewed by Avri.
I am not sure why this patch not yet mainlined.

This is gentle reminder.
Do I need to resend the patch?

Thanks,
Shiva

> Subject: [PATCH V3] mmc-utils: let FFU mode use CMD23 and CMD25
>=20
> As per specification, the host can use either CMD24 or CMD25 in
> closed-ended or open-ended way.
> CMD25 is better option as it can flash the firmware image in one go.
>=20
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
>=20
> ---
>=20
> V3:
>    - Checking the firmware size with MMC_IOC_MAX_BYTES
>=20
> ---
>=20
> V2:
>    - Removed optional parameter '-c'
>    - FFU mode use CMD25 instead of CMD24
>    - CMD25 used as closed-ended
> ---
>  mmc.h      |  2 ++
>  mmc_cmds.c | 70 ++++++++++++++++++++++++++++++------------------------
>  2 files changed, 41 insertions(+), 31 deletions(-)
>=20
> diff --git a/mmc.h b/mmc.h
> index 285c1f1..a4cbba4 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -25,10 +25,12 @@
>  /* From kernel linux/mmc/mmc.h */
>  #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
>  #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
> +#define MMC_STOP_TRANSMISSION    12   /* ac                      R1b */
>  #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
>  #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
>  #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value
> */
>  #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
> +#define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
>  #define MMC_WRITE_BLOCK		24	/* adtc [31:0] data addr	R1  */
>  #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
>  #define MMC_SET_WRITE_PROT	28    /* ac   [31:0] data addr   R1b */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 19a9da1..43e1f8b 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2414,12 +2414,13 @@ int do_ffu(int nargs, char **argv)
>  	int sect_done =3D 0, retry =3D 3, ret =3D -EINVAL;
>  	unsigned int sect_size;
>  	__u8 ext_csd[512];
> -	__u8 *buf;
> +	__u8 *buf =3D NULL;
>  	__u32 arg;
>  	off_t fw_size;
>  	ssize_t chunk_size;
>  	char *device;
> -	struct mmc_ioc_multi_cmd *multi_cmd;
> +	struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
> +	__u32 blocks =3D 1;
>=20
>  	if (nargs !=3D 3) {
>  		fprintf(stderr, "Usage: ffu <image name> </path/to/mmcblkX>
> \n");
> @@ -2439,14 +2440,6 @@ int do_ffu(int nargs, char **argv)
>  		exit(1);
>  	}
>=20
> -	buf =3D malloc(512);
> -	multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> -				3 * sizeof(struct mmc_ioc_cmd));
> -	if (!buf || !multi_cmd) {
> -		perror("failed to allocate memory");
> -		goto out;
> -	}
> -
>  	ret =3D read_extcsd(dev_fd, ext_csd);
>  	if (ret) {
>  		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
> @@ -2471,9 +2464,17 @@ int do_ffu(int nargs, char **argv)
>  	}
>=20
>  	fw_size =3D lseek(img_fd, 0, SEEK_END);
> +	if (fw_size > MMC_IOC_MAX_BYTES || fw_size =3D=3D 0) {
> +		fprintf(stderr, "Wrong firmware size");
> +		goto out;
> +	}
>=20
> -	if (fw_size =3D=3D 0) {
> -		fprintf(stderr, "Firmware image is empty");
> +	/* allocate maximum required */
> +	buf =3D malloc(fw_size);
> +	multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> +				4 * sizeof(struct mmc_ioc_cmd));
> +	if (!buf || !multi_cmd) {
> +		perror("failed to allocate memory");
>  		goto out;
>  	}
>=20
> @@ -2483,14 +2484,19 @@ int do_ffu(int nargs, char **argv)
>  		goto out;
>  	}
>=20
> +	/* calculate required fw blocks for CMD25 */
> +	blocks =3D fw_size / sect_size;
> +
>  	/* set CMD ARG */
>  	arg =3D ext_csd[EXT_CSD_FFU_ARG_0] |
>  		ext_csd[EXT_CSD_FFU_ARG_1] << 8 |
>  		ext_csd[EXT_CSD_FFU_ARG_2] << 16 |
>  		ext_csd[EXT_CSD_FFU_ARG_3] << 24;
>=20
> +	/* prepare multi_cmd for FFU based on cmd to be used */
> +
>  	/* prepare multi_cmd to be sent */
> -	multi_cmd->num_of_cmds =3D 3;
> +	multi_cmd->num_of_cmds =3D 4;
>=20
>  	/* put device into ffu mode */
>  	multi_cmd->cmds[0].opcode =3D MMC_SWITCH;
> @@ -2501,37 +2507,42 @@ int do_ffu(int nargs, char **argv)
>  	multi_cmd->cmds[0].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> MMC_CMD_AC;
>  	multi_cmd->cmds[0].write_flag =3D 1;
>=20
> +	/* send block count */
> +	multi_cmd->cmds[1].opcode =3D MMC_SET_BLOCK_COUNT;
> +	multi_cmd->cmds[1].arg =3D blocks;
> +	multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_AC;
> +
>  	/* send image chunk */
> -	multi_cmd->cmds[1].opcode =3D MMC_WRITE_BLOCK;
> -	multi_cmd->cmds[1].blksz =3D sect_size;
> -	multi_cmd->cmds[1].blocks =3D 1;
> -	multi_cmd->cmds[1].arg =3D arg;
> -	multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_ADTC;
> -	multi_cmd->cmds[1].write_flag =3D 1;
> -	mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf);
> +	multi_cmd->cmds[2].opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
> +	multi_cmd->cmds[2].blksz =3D sect_size;
> +	multi_cmd->cmds[2].blocks =3D blocks;
> +	multi_cmd->cmds[2].arg =3D arg;
> +	multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_ADTC;
> +	multi_cmd->cmds[2].write_flag =3D 1;
> +	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf);
>=20
>  	/* return device into normal mode */
> -	multi_cmd->cmds[2].opcode =3D MMC_SWITCH;
> -	multi_cmd->cmds[2].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> +	multi_cmd->cmds[3].opcode =3D MMC_SWITCH;
> +	multi_cmd->cmds[3].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
>  			(EXT_CSD_MODE_CONFIG << 16) |
>  			(EXT_CSD_NORMAL_MODE << 8) |
>  			EXT_CSD_CMD_SET_NORMAL;
> -	multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> MMC_CMD_AC;
> -	multi_cmd->cmds[2].write_flag =3D 1;
> +	multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> MMC_CMD_AC;
> +	multi_cmd->cmds[3].write_flag =3D 1;
>=20
>  do_retry:
>  	/* read firmware chunk */
>  	lseek(img_fd, 0, SEEK_SET);
> -	chunk_size =3D read(img_fd, buf, 512);
> +	chunk_size =3D read(img_fd, buf, fw_size);
>=20
> -	while (chunk_size > 0) {
> +	if (chunk_size > 0) {
>  		/* send ioctl with multi-cmd */
>  		ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>=20
>  		if (ret) {
>  			perror("Multi-cmd ioctl");
>  			/* In case multi-cmd ioctl failed before exiting from ffu
> mode */
> -			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
> +			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
>  			goto out;
>  		}
>=20
> @@ -2558,9 +2569,6 @@ do_retry:
>  		} else {
>  			fprintf(stderr, "Programmed %d/%jd bytes\r",
> sect_done * sect_size, (intmax_t)fw_size);
>  		}
> -
> -		/* read the next firmware chunk (if any) */
> -		chunk_size =3D read(img_fd, buf, 512);
>  	}
>=20
>  	if ((sect_done * sect_size) =3D=3D fw_size) {
> @@ -2597,7 +2605,7 @@ do_retry:
>  		if (ret) {
>  			perror("Multi-cmd ioctl failed setting install mode");
>  			/* In case multi-cmd ioctl failed before exiting from ffu
> mode */
> -			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
> +			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
>  			goto out;
>  		}
>=20
> --
> 2.17.1

