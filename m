Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C200CC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 10:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 785A064F45
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 10:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCQKmX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Mar 2021 06:42:23 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:32384
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230255AbhCQKmP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Mar 2021 06:42:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC/bXRU8kjMAdwSArTtcrbCc5e+lKtoISsabnWpD6RqdEYTis4pP8ZjFbO+PQ0W98TheFOQscCBTaqAM4dqCctPStzYOy30HXglIW4J3Az9KDPCrDI7ZdIE5NYybZj/76OeGWea/xDCkWhy+TI/qf5tO13Gpvci40ZhBEc8Yw7uE8z1XnISqLIgGIgXyH9iYeNLO5UCgkxCLf0m+v51usYZ3dP+TxP0nWG6oL4zi5LnVmzg7SbFPBsEcLNphtLIhI3/E1IZxHMMDL6+t66siiCbNuq+dGDNKavHAAZ6fAa9JtueKGGJAFyOXI2cy4VGFhEfIzKiz8OgeTvZOoiPlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYKnZ1THCDqaz/5+AZ8N2d5WexrR78gZwP3+WC2Kauw=;
 b=djAKn4pQfuNV6YlIw+tG3XfQSABwwJjBjuIpENYjwyviiYrbpmad4Uo16VcRBx7n1gAuYgIdKnxAuqvjgpzuqxZEeDv8O2jsOwWh5IuKqgQFNi0JutfJXTbTSYC/ItaVCIJl3MCFNXO1Ct39XFMhJ+drZwJtxe3jfGym/SXifMnWK6aoVWv2JCEJ/gSSBQCouqjChbmpAS9NpdLtRkreQ1zqGDDL8uBbbSnrK/hvWrHG66+v0sDPFPJ5GYxFKuwqRZzFXFwwsgJrXtwYzQrSwV/pJNJoHHVog5YZdpWmIDAv56CMvYq4klrBgBNeCu4gACnmzrBlRWgPwu4aRkvcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYKnZ1THCDqaz/5+AZ8N2d5WexrR78gZwP3+WC2Kauw=;
 b=4LO4NirA1T3JM0YduJDvACrlIMGrJm4GNyHTy9DohakQibqsE31dHC/1DYKZopoj3AUQAhKqMdfUGz12PASA53CDHvqMu2Kf8BP5/QWkPSfcSnJ9692Scgbjw2f2TJPTe2LP63iGyl6figawu3AzTeFJBP1Iu4bdWZtoLKhf91U=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (2603:10b6:208:1aa::10)
 by BL0PR08MB5396.namprd08.prod.outlook.com (2603:10b6:208:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 10:41:58 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::18c0:fc4a:5ba4:406e]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::18c0:fc4a:5ba4:406e%6]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 10:41:58 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Chris Ball <chris@printf.net>, Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH RESEND V4] mmc-utils: let FFU mode use CMD23 and CMD25
Thread-Topic: [PATCH RESEND V4] mmc-utils: let FFU mode use CMD23 and CMD25
Thread-Index: AdcbGibuMOh4v7r0RO6jCsoOYUQWEA==
Date:   Wed, 17 Mar 2021 10:41:58 +0000
Message-ID: <MN2PR08MB63973BF8F3C6959487BF5707B86A9@MN2PR08MB6397.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Enabled=true;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SetDate=2021-03-17T10:39:28Z;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Method=Privileged;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Name=Public;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ActionId=b997c3bb-3ae2-426e-90bd-0998215eca0b;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ContentBits=0
authentication-results: printf.net; dkim=none (message not signed)
 header.d=none;printf.net; dmarc=none action=none header.from=micron.com;
x-originating-ip: [147.161.165.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86041eef-238d-477e-c065-08d8e9314a97
x-ms-traffictypediagnostic: BL0PR08MB5396:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR08MB5396D5D8A12DF78A151D3DF9B86A9@BL0PR08MB5396.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S5Ff1mqFB3QG6K6bxyzQSEJUpFBVC0+QwPfbZqOtExcWavxGNNnjjpSU/05HLy85X/bsnJoknDZDkCRtCaf0Ac7Zx0KQ5GdPrqtuX6MTZzpXClDiiZmyh9OUOKVhs6qjhqL6sjiZdLlvDmOOH8ulwt+ZsBrerryBqP2u3xmdTgWPCv24gUAuZxRs3BTi44LS/CcDfCb79rSfUBp/EcTWFg+vIkGKHu1Oo6D3fKPUYhjnqNeVBYdJcqhpeaCmo5NIdP7QAwlwZ6QOE5hzTOPiW64ZgL4TJyhhQ8fiVmPRxl2gTw/IzE1n3cMgeKYgnTKTs1C++CnBbjX0hQ5OIT4VrCO1hu69sII7QknJRKA+nPhoKU3TdOxM7vkVrVdsYmeGfYxR97kTr7vDTI7crdZrrOfkNZbN1o70BTCfiX1Hvz+uLVkWUVzxUK3wTgMWLRkAwgKq2IRNBJpnOb1m+Off1/VZI0pTA3DkKoqzlKdCCD/5Rd++VmgsAOHiJLGjYmka3J5zUMAGOMOgg/m47yT3KdkM/iSlK/u4iOYqCRxg4rmJpPVhEM39x5SHddAp7vWb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR08MB6397.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(64756008)(83380400001)(76116006)(316002)(5660300002)(71200400001)(8936002)(33656002)(26005)(66446008)(186003)(66556008)(66476007)(110136005)(66946007)(9686003)(86362001)(55016002)(478600001)(8676002)(52536014)(2906002)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jJO84y5QPQq6MhKKLvu1MUDxcWBJXnXNKJORl56+XP4PC4SF6s5pJFbVmCKQ?=
 =?us-ascii?Q?HQ3rClpPG7hq8nLDxLUYB6gBPiA6YDV/qFW5n+nk0iYF93wdkCMOO6O2HoJd?=
 =?us-ascii?Q?looEdwbw/1uGKq+wfNEAWFZ9+7Ymsr6r6B0dafFBsTnAtvpqKRGCoA66temz?=
 =?us-ascii?Q?q/yRBCIIOCfDvK2dTMBR7fdJuavF5NGT7kz1mQ8T7Qitbd2aMJn3lJP47Ko9?=
 =?us-ascii?Q?37vGLnpFwdL7RrFu+u0lfc7RkiCx05KOVZGlkcp7HjWoAlOlBWovsY0XsBJb?=
 =?us-ascii?Q?p1Zn/Ip37l0Iuy4yKxRXtbTBlrZwwrPHt1CeR+9uQNCitd17E2VvxIu/Oetf?=
 =?us-ascii?Q?POoIbg7p6wZW8idlclqbqk9IvIDTXCQcuREqyCqYG6tUJCU14hDaaV+Xpnxm?=
 =?us-ascii?Q?FFAQ5oTmBP/9dkvG+AOoB5ZCLYvc+SfesDRQQd5vlB2sybJ2rMeWMtWMoCDu?=
 =?us-ascii?Q?oaWnoCSTABU8mdDBxO4VDvGYzucrMO9XodBmTifkT+rukhaOWF7GjWxHv7zc?=
 =?us-ascii?Q?5FqwFpjMwy+t/ISXwn+sALVs85WdnlM9Fkms3/YGu/UhqFdgRIwE1aQ7miML?=
 =?us-ascii?Q?FXfvsyuTnp7jlJCuBz+z0gXIJK4OW21l14fnVRq/giaI2CZK0Wffwul/Bjlm?=
 =?us-ascii?Q?B7ycWrLa0aOrfcwl6rM3BbZ2pjyMf7hvdY7iqbgCcJdgKKLtqDc/3kgX3i/f?=
 =?us-ascii?Q?QZyRR7enTQ01Dx+zdYGAnHSOdY7r/WA4YIC6BMgTzZxmcG63p/WgjAg2lYP7?=
 =?us-ascii?Q?XAggn16dCKCBit+li/FXpBjYgO0e3snWMvGgMnn/NrvteJhNl/UFpDpaLEpG?=
 =?us-ascii?Q?CCadfKS0SbqrEeBZwRcW8OvMDpl3H0/9hdpiH+XZheatT3bmNyrsn5yVeDPo?=
 =?us-ascii?Q?HbIpGTmtQXkjrqfwag9N3ihYXVV90/2jrrJWxYUIzCCluLxtbnpwW++86m1a?=
 =?us-ascii?Q?oXCrgqCZbOWZBoJd4iSuZWTfIETclQA1H8keb7uWJQoW8Efe71Jq2RTfN2By?=
 =?us-ascii?Q?lLw4sW++pYYsy1fpTgkRNtFIA3/RA0flbcEsbRFLG1avHtdHgEkNNb/qdWUN?=
 =?us-ascii?Q?wH8ZPIVFYztO24YbXPZDB7Y1RWWG60ZjtWxKxbeva5NS704186fq7JBmD1Qu?=
 =?us-ascii?Q?oJTAOHystAkwuedqKZIDqxAdHFl1pO8argkxAEPJ0U+IOT3NCZc0HTzptOPM?=
 =?us-ascii?Q?fSMRjGeWmXRwgXcvNnNsRk8VziYNfTguliptfaTrbdaZ/og6mrw7r8bBaU1X?=
 =?us-ascii?Q?sBSd1+UcuxeuRXFhX4+7hSwdBjwofYtqDUezFi//iP4nRztj/8aqTougwVuY?=
 =?us-ascii?Q?QfcuVe5HFHadJqZDhvAQLDFB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR08MB6397.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86041eef-238d-477e-c065-08d8e9314a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 10:41:58.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GC4gQJD8P2puIBcrf/ZHuyam2LhyFQ00cAfGKuQPwKq323WOdWEwg4crA8vHGEqSOqyILny9AO8s8U+avtFAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR08MB5396
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

