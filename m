Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D5C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Feb 2021 10:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7123564DA1
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Feb 2021 10:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBZKtx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Feb 2021 05:49:53 -0500
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:25824
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230134AbhBZKts (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 26 Feb 2021 05:49:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6lSmCHWdQJU89H+t248B01BxyOnpuhBoonlOqhUzcdI22pvagEvc0NLMxCEsBKCkNKoc3bHHiLrBlnwLCTewVljOovK2j6Lrvtxs0aoWbat/58ClvA4EnxiK7vj2mbYUmOXEeQ0HO9poC1HwMVtkdpR/Njw05Sv/eHchgJCyRQ8PnbixbK55pp8Yj0p5aecfYbKfc07Tf4GwVgDDVloWYarWAOiSgaTjAH9/ROBkliGfzQ+iROPMGYdjlbRylCsagoecfb4nWXnDwXewv7mJIdr/FCABcVNqvXlqUBg0/FEUVjeuzknG5u8PR9VKjxPlJ47wO1eHrRktYQIxq71dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYKnZ1THCDqaz/5+AZ8N2d5WexrR78gZwP3+WC2Kauw=;
 b=CJabQ2fI2Lapl8NQL6yGlNzAD/IoIoN+rr/ZIKx7s2L52dkwJLfZxSO7fxlzfJJPo9iSn3VXAUJ5iTdkw/O4tPVkQ+5ayDMN+R/kWvRgytxP0mHZQIOsMW4AvK2gKAw+fU1AuLdY4QzDZxJABCImYCxbN2BYDBSsqr5p1a3GJwHnEpGkejmRqCO71jkw/Xkj7CWIh8IFwzExs93DggEnEFaOfacmzQMRRVRB93+MUGvPV0zgzCI2kAEv7cxhbA/rKmLgyoe1qhyzxRN1fbsrz4A2yRl89C0dKJFzBWgFCZHHSXJhAYYHQVHCgcgXFQgcKBaCHx3Y5Ezlgo2yvysOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYKnZ1THCDqaz/5+AZ8N2d5WexrR78gZwP3+WC2Kauw=;
 b=n5MPc4rEjVIzRQD/4YzxGdWQPBSpbDZYKC6SUO7MsQYzbHZl1itqBHV678mx7acaKm7t+Eqx1nlULsnTe3+bFFRFGTgSZjd2/lIL6qVCx566rcc8xqMjInnwm8jmAZ/ygb9DJgAe7JAviNMOQgawXZXPJ0AbNWBD48Fp2O8Uo4A=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (2603:10b6:208:1aa::10)
 by BL0PR08MB4596.namprd08.prod.outlook.com (2603:10b6:208:59::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 26 Feb
 2021 10:48:50 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::18c0:fc4a:5ba4:406e]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::18c0:fc4a:5ba4:406e%5]) with mapi id 15.20.3890.023; Fri, 26 Feb 2021
 10:48:49 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Chris Ball <chris@printf.net>, Avri Altman <Avri.Altman@wdc.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Yaniv Agman <yaniv.agman@sandisk.com>
Subject: [PATCH v4] mmc-utils: let FFU mode use CMD23 and CMD25
Thread-Topic: [PATCH v4] mmc-utils: let FFU mode use CMD23 and CMD25
Thread-Index: AdcMLIzMwlW+HZh4T2+HYnF4Hwb+yQ==
Date:   Fri, 26 Feb 2021 10:48:49 +0000
Message-ID: <MN2PR08MB6397D3F27F7FB8E6405E8C4EB89D9@MN2PR08MB6397.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Enabled=true;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SetDate=2021-02-26T10:43:20Z;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Method=Privileged;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Name=Public;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ActionId=872f5b95-17f1-4993-81a0-452ef6f8118d;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ContentBits=0
authentication-results: printf.net; dkim=none (message not signed)
 header.d=none;printf.net; dmarc=none action=none header.from=micron.com;
x-originating-ip: [147.161.165.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 194c5552-701b-478f-540c-08d8da4419d3
x-ms-traffictypediagnostic: BL0PR08MB4596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR08MB459645FA031752640E990DC8B89D9@BL0PR08MB4596.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dGbSGCWTbnJtPwWLQYm8ropLdAE2Yg33kggB1zqXFxyNgdiWJYUdcTujimIMFx6IPwK8jRwm20eisUNAWZAEQDnCYUdEtR73n1RKl+Z/NSFGtAsi4ha+TYn4C+1F5FRIM9TCQEOI4jo41AoWM+aE00OT7Jl4CRyqb5FqoHV7vxTKcgU9UXBrXa65JtQCBoQ5doBTGEBcawZAbR057lH5Kt9iIAfOELVNkfdNFUOnvRi74ZpRQ6wRZcChSlExnkz3bVzGoxEQ+63vqJAkBAAjdtfAPiNQTEoeUKOtSUqSaYWg+12yomvl5y/+RcmMtPs5x0/+17UoDYP/WMiTKMPBtIe7IW0ygNIcoO5YGoNqrRbgqh1sz4HUrqRmLs6u7ObmDTAAeAewAVly+pDtaKP6uTE2EAShZYwtgVch4iFBRrdBK32mIkO/WyXdaBpqCKi2c6K6fa7LhK+pnmuE12IydK2mOLvZldjFjGDP2MwdrfuYgiUzNzNIBthCW24u3UlJZ64bV3zsef92EIJqrkc/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR08MB6397.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6506007)(7696005)(186003)(83380400001)(52536014)(64756008)(8936002)(66446008)(4326008)(2906002)(8676002)(33656002)(66556008)(5660300002)(478600001)(66476007)(86362001)(71200400001)(26005)(55016002)(76116006)(54906003)(316002)(110136005)(9686003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gEUZt+FmFXPNNx9lqCNXEu7TU003SgBZhFqKZKiMqWGAyBrNr/8VHX78e1YH?=
 =?us-ascii?Q?CrTmgwrqoPH2cw1Yvl4jH6GHnsm1zwfQe7u/S0gB4yPQGH5p20pYtkBEsEKn?=
 =?us-ascii?Q?XmtPBGenz+jxe9hEiESO7oCY9w3u+He6e8n2FKU9cJjRHuWG8WfM42jRpwei?=
 =?us-ascii?Q?4yuLMMHZSfVZXI+dVRTubiFZbk3do9PuWkzJX9uYH9IemRfhJeGGPy7qnrvY?=
 =?us-ascii?Q?NSR67dDbwblkqCEfoIIT8+Dki8Iylh86xV03wBlyKg+GpzUwh2H6h/0DUU//?=
 =?us-ascii?Q?hsSGH6of6CkebBsM7FgZJ1xWdrVh8jpFPnHCXRTasz8TiJaK8FzFamPe8b+R?=
 =?us-ascii?Q?SCqR/NLULDPLf2CS//PRK0ElDA2ADCiN+M0wNDC48Cdcf2/bPTb/uXzSbqNX?=
 =?us-ascii?Q?8PLppCoqLQ9Q4m5NKVQtNnjLaEy/9XnNxiPHHYGemncuSkSTAuIBAJnzeUXT?=
 =?us-ascii?Q?/L2dzIv6aSzDuLfuGW1ijDisGy4gnFYihZ7Ivc5LtRYMqRSSfMdJmy83HA7j?=
 =?us-ascii?Q?1tVrEIiNWLYe1Xc4jYZU4tf5qB75Sfl5Lxem9G1ZEyxj/Lf9+V16CrGG9KCM?=
 =?us-ascii?Q?eP+CSsBSCpi2uN7npKHF0TJBO8I07gcNV/9xWkA+2TUxxJmlfzOiFmuwlgt2?=
 =?us-ascii?Q?tGkDyjcu6WOJ9d6mpQ5sEPDQklBitoWtRiOxMfmGNJ+VEoVY6J9s+kSU6loC?=
 =?us-ascii?Q?SRiZBBxwfmrpjaEHMUkftp+1eA7YI/XGNeV6DRnffKHasVKg8hiXBxvbhZuz?=
 =?us-ascii?Q?JgKX6cowhad1YuX87jfpfm18mG3REx/bAgt9uCKxd9jhZYNBP+d7TY/B5r5v?=
 =?us-ascii?Q?+5epOMgCexrtfzEQrUH7TDjavyg/ivnO4BkCHgohI7qPvP6BKY+1wWF9PbKl?=
 =?us-ascii?Q?B3ePFBTMTQmYMnFLrMKNWVI+smIq/2lkTSTkzNQ14mI33VRFRv9r4lB46uGd?=
 =?us-ascii?Q?iFBnzwXGDAMArI8ZjnCei1+xzrU3Wqu4paNzN4mKQV5l9MXHhXnaJ9Qlhhhj?=
 =?us-ascii?Q?bH76QMcaHVPk0siomU/v9IHHeJs6zWi09Y7BeDNlqvG3HZ5FsVAeWIGcpiOB?=
 =?us-ascii?Q?3zHsd1g1O1Vju3akJA8mvjgYdIdHPSUhNbaDAiRMRD3uJaRfF6V3dZKHEdMr?=
 =?us-ascii?Q?U8Ttp+K91D0VIefDdzyIWN37MTMbL+O+pskg1ah4MxVndqaBZImlhkyoSX69?=
 =?us-ascii?Q?QLGdWrjMqjdTZnY9zWbXGtbEa+z1KvQbQhPqR1q1lDX7Qd4gmiMrceBjc0mf?=
 =?us-ascii?Q?XTq8pP7+LJGxztG9CokYiClSHFIkU+yhZQHymw8Na003zVl6lXL+a5mhotyX?=
 =?us-ascii?Q?SqEL//A3YDVBVrFooNPDJ13h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR08MB6397.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194c5552-701b-478f-540c-08d8da4419d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 10:48:49.8278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nv3ehJ+Jg0fb7kp+zFpvpD8HaKamkmyLTHKZTBSIsw9XxiEfiizOgnjtFiqtPRdq1M3F9+aIy827RBzwiQ7HHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR08MB4596
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As per specification, the host can use either CMD24 or CMD25 in
closed-ended or open-ended way.
CMD25 is better option as it can flash the firmware image in one go.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Tested-by: Bean Huo <beanhuo@micron.com>
---
V4:
   - Removed MMC_STOP_TRANSMISSION, as it is not used in this patch
   - Added reviewed and tested by from Bean Huo
V3:
   - Checking the firmware size with MMC_IOC_MAX_BYTES
V2:
   - Removed optional parameter '-c'
   - FFU mode use CMD25 instead of CMD24
   - CMD25 used as closed-ended

 mmc.h      |  1 +
 mmc_cmds.c | 70 ++++++++++++++++++++++++++++++------------------------
 2 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/mmc.h b/mmc.h
index 648fb2672d6f..cf2d4766a16d 100644
--- a/mmc.h
+++ b/mmc.h
@@ -29,6 +29,7 @@
 #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
 #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
+#define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
 #define MMC_WRITE_BLOCK		24	/* adtc [31:0] data addr	R1  */
 #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
 #define MMC_SET_WRITE_PROT	28    /* ac   [31:0] data addr   R1b */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb371892c521..6e6c09ae3b85 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2446,12 +2446,13 @@ int do_ffu(int nargs, char **argv)
 	int sect_done =3D 0, retry =3D 3, ret =3D -EINVAL;
 	unsigned int sect_size;
 	__u8 ext_csd[512];
-	__u8 *buf;
+	__u8 *buf =3D NULL;
 	__u32 arg;
 	off_t fw_size;
 	ssize_t chunk_size;
 	char *device;
-	struct mmc_ioc_multi_cmd *multi_cmd;
+	struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
+	__u32 blocks =3D 1;
=20
 	if (nargs !=3D 3) {
 		fprintf(stderr, "Usage: ffu <image name> </path/to/mmcblkX> \n");
@@ -2471,14 +2472,6 @@ int do_ffu(int nargs, char **argv)
 		exit(1);
 	}
=20
-	buf =3D malloc(512);
-	multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
-				3 * sizeof(struct mmc_ioc_cmd));
-	if (!buf || !multi_cmd) {
-		perror("failed to allocate memory");
-		goto out;
-	}
-
 	ret =3D read_extcsd(dev_fd, ext_csd);
 	if (ret) {
 		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
@@ -2503,9 +2496,17 @@ int do_ffu(int nargs, char **argv)
 	}
=20
 	fw_size =3D lseek(img_fd, 0, SEEK_END);
+	if (fw_size > MMC_IOC_MAX_BYTES || fw_size =3D=3D 0) {
+		fprintf(stderr, "Wrong firmware size");
+		goto out;
+	}
=20
-	if (fw_size =3D=3D 0) {
-		fprintf(stderr, "Firmware image is empty");
+	/* allocate maximum required */
+	buf =3D malloc(fw_size);
+	multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
+				4 * sizeof(struct mmc_ioc_cmd));
+	if (!buf || !multi_cmd) {
+		perror("failed to allocate memory");
 		goto out;
 	}
=20
@@ -2515,14 +2516,19 @@ int do_ffu(int nargs, char **argv)
 		goto out;
 	}
=20
+	/* calculate required fw blocks for CMD25 */
+	blocks =3D fw_size / sect_size;
+
 	/* set CMD ARG */
 	arg =3D ext_csd[EXT_CSD_FFU_ARG_0] |
 		ext_csd[EXT_CSD_FFU_ARG_1] << 8 |
 		ext_csd[EXT_CSD_FFU_ARG_2] << 16 |
 		ext_csd[EXT_CSD_FFU_ARG_3] << 24;
=20
+	/* prepare multi_cmd for FFU based on cmd to be used */
+
 	/* prepare multi_cmd to be sent */
-	multi_cmd->num_of_cmds =3D 3;
+	multi_cmd->num_of_cmds =3D 4;
=20
 	/* put device into ffu mode */
 	multi_cmd->cmds[0].opcode =3D MMC_SWITCH;
@@ -2533,37 +2539,42 @@ int do_ffu(int nargs, char **argv)
 	multi_cmd->cmds[0].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	multi_cmd->cmds[0].write_flag =3D 1;
=20
+	/* send block count */
+	multi_cmd->cmds[1].opcode =3D MMC_SET_BLOCK_COUNT;
+	multi_cmd->cmds[1].arg =3D blocks;
+	multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
 	/* send image chunk */
-	multi_cmd->cmds[1].opcode =3D MMC_WRITE_BLOCK;
-	multi_cmd->cmds[1].blksz =3D sect_size;
-	multi_cmd->cmds[1].blocks =3D 1;
-	multi_cmd->cmds[1].arg =3D arg;
-	multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
-	multi_cmd->cmds[1].write_flag =3D 1;
-	mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf);
+	multi_cmd->cmds[2].opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
+	multi_cmd->cmds[2].blksz =3D sect_size;
+	multi_cmd->cmds[2].blocks =3D blocks;
+	multi_cmd->cmds[2].arg =3D arg;
+	multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	multi_cmd->cmds[2].write_flag =3D 1;
+	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf);
=20
 	/* return device into normal mode */
-	multi_cmd->cmds[2].opcode =3D MMC_SWITCH;
-	multi_cmd->cmds[2].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+	multi_cmd->cmds[3].opcode =3D MMC_SWITCH;
+	multi_cmd->cmds[3].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
 			(EXT_CSD_MODE_CONFIG << 16) |
 			(EXT_CSD_NORMAL_MODE << 8) |
 			EXT_CSD_CMD_SET_NORMAL;
-	multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-	multi_cmd->cmds[2].write_flag =3D 1;
+	multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	multi_cmd->cmds[3].write_flag =3D 1;
=20
 do_retry:
 	/* read firmware chunk */
 	lseek(img_fd, 0, SEEK_SET);
-	chunk_size =3D read(img_fd, buf, 512);
+	chunk_size =3D read(img_fd, buf, fw_size);
=20
-	while (chunk_size > 0) {
+	if (chunk_size > 0) {
 		/* send ioctl with multi-cmd */
 		ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
=20
 		if (ret) {
 			perror("Multi-cmd ioctl");
 			/* In case multi-cmd ioctl failed before exiting from ffu mode */
-			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
+			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
 			goto out;
 		}
=20
@@ -2590,9 +2601,6 @@ do_retry:
 		} else {
 			fprintf(stderr, "Programmed %d/%jd bytes\r", sect_done * sect_size, (in=
tmax_t)fw_size);
 		}
-
-		/* read the next firmware chunk (if any) */
-		chunk_size =3D read(img_fd, buf, 512);
 	}
=20
 	if ((sect_done * sect_size) =3D=3D fw_size) {
@@ -2629,7 +2637,7 @@ do_retry:
 		if (ret) {
 			perror("Multi-cmd ioctl failed setting install mode");
 			/* In case multi-cmd ioctl failed before exiting from ffu mode */
-			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
+			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
 			goto out;
 		}
=20
--=20
2.25.1
