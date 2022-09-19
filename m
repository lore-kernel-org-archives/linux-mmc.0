Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84BDECAAA1
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Sep 2022 17:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiISRXY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiISRXY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2022 13:23:24 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150137.outbound.protection.outlook.com [40.107.15.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E310A3A4B3
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2022 10:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3QRWzKiHES3j368wRQ8G0q6AVCKG1MsBB4ylegAn4A3w4l8xpBmSUS3uwr0QN/h37njbBzfbOjsUbsit0RsiH1fYeXhUwMe33Ay6SZgWcPqxyG8e2jNZbbFU0QNhgm1tSdvO76pIId9yoHNF+yhHjfuN7AH7W4arP9iEkCHyyEiD+Y5tc4rT49MZprnGuXq8fKpPeaLfUHQ+h/554gyhWbFmNLp23frB5JQzbW4Q7U1Xi8nzBpjThV+f4EnMEOXF0IY36XFNCKO/+XkVmshzSB3AkVE07vFK5FihRDmFoO4R0Ni8OrG8zy4EF8/Rw/4i3Aqsa/O1H6qrp5aMsK5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRHHuU5xC23xWemfI0jA9+NhgVbGuULb4eqVHXJa3BE=;
 b=jSaBOVYpc67omYe/JhiLOUh/kNVeezpwxdNB9ecKWQhd0H99JvKaO78zvKRirlwoQdeYDpUjyNWyy9dQwY6SxA6iEgI2OjFPwj6LXe+VV2oniY9duA9he4ugqoNKztmabZQ4/uN1812uN1xu1/z92V5e4FJa9zYsWKx7STDm4X90WLfw2QingLjEWM9Nsf397+T0Eu3EoVORdCBqcZ7vFJI/LSMxewtB0FscYD86kXi3brNLlm4U0rS9SgHypn+5biQmchW6kfOk+rCqgV53gpSVL74jFDPdQiedPayqGthHQla3ZtwOKRbouNK65fAgSOGyz9sO8uE2IKFAQGvEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRHHuU5xC23xWemfI0jA9+NhgVbGuULb4eqVHXJa3BE=;
 b=ODCiIQMr/mVS4CB6yxef2B4w8Sl34lh/RZ0rgT3OlgrR7rQ883+d6HoWJF7W7fOzIN/lOvMnuUX310R//4o7l5owK1I8ObES6p2mPHt+PKomNmJDciqY5T5ICmB8OuZb8VXeLC+OXExMY+jiFR+7MoejzD79KcNYdP//Tw0O3iM=
Received: from HE1PR0702MB3610.eurprd07.prod.outlook.com (2603:10a6:7:7f::27)
 by DB9PR07MB8499.eurprd07.prod.outlook.com (2603:10a6:10:36c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Mon, 19 Sep
 2022 17:23:20 +0000
Received: from HE1PR0702MB3610.eurprd07.prod.outlook.com
 ([fe80::9bb7:bf55:ae2d:bee3]) by HE1PR0702MB3610.eurprd07.prod.outlook.com
 ([fe80::9bb7:bf55:ae2d:bee3%6]) with mapi id 15.20.5654.011; Mon, 19 Sep 2022
 17:23:19 +0000
From:   "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
To:     "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct ffu in case of unsupported
  MODE_OPERATION_CODES
Thread-Topic: [PATCH] mmc-utils: correct ffu in case of unsupported
  MODE_OPERATION_CODES
Thread-Index: AQHYzEOPJ/2/a6osnE6M+VZvdb9TLa3m/25w
Date:   Mon, 19 Sep 2022 17:23:19 +0000
Message-ID: <HE1PR0702MB3610EC6EF02982BCD66E0DB5804D9@HE1PR0702MB3610.eurprd07.prod.outlook.com>
References: <20220919161852.28072-1-bruno.matic@nokia.com>
In-Reply-To: <20220919161852.28072-1-bruno.matic@nokia.com>
Accept-Language: fi-FI, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0702MB3610:EE_|DB9PR07MB8499:EE_
x-ms-office365-filtering-correlation-id: 5d784ab8-9d2f-41ff-96bf-08da9a63a5a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RL0Rp7qcL2a51Z6jiMTiTSbVKQ2844V4Ez0uOXCSbrkLCG/S4cJyRQe/MRxThu6l88vSB+Q2FQulBZy/bcn12T/qb+bLXuXlxo2VsXqEea6D6kxx2NRN9EaeYV62fniQXVCzieC3u7Q+0FOFsdIepPcrJIrMDZ/Ws8XnCLqYEPU2Mv6TV4mDa2DyJErsqf2oDg6zb1leT4Azs9hV1zUrZ3CDAnaHpfuaApnnfdQfd0J71O6B9a2YC2atulE3gTD6SIwY3okU8FLX1uNgVPVgQZpVSKbRMzTX++CTk8a7p+S8xuRbJyurcqQyFoL8sdN34LVV0gzjLCJ++tgQqIldzf5lKFzwo4XYpT9XelQ2o9GgPIYj4MwTAIvDqVswbn6rcNwxsnW3xCwn31rDjmIfI7q5JlOGMKWmDTd5Bg2mqo9iMnr4U6PWrsoEqZj6YLLY93tYZHj/TkZlK0Cva4pb47hl8oKu0tqQQJJB5N6TmdktCp/KQHEpaGL9L05kGIh6Q4rg74dGe7T7G4usPnpaayOat7grluLDjIUvHja/uMgUaJ+RHl3eBuE8Y8X4AR1wk+IrWdrWBy8zWC76b2HISEgSSmWhEhebmsOrLAgqNYjQzQVY3IDX9YT18natXhDuTEZjGxIXvDl8Qv1mMBO9JEVtmW+QYwme5kuED8P7+tXcNtFwoVwV89qkkPHkHWeXLx+ZzSwNuNw/rg9oqcw9SlzJLBq+vGduF8o9+iLaxu1K6O70kCCt60k0d7N4XmjCiz5uU9GCav2VrlVQv3B7vA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0702MB3610.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199015)(38100700002)(122000001)(86362001)(33656002)(83380400001)(82960400001)(38070700005)(186003)(2906002)(7696005)(9686003)(6506007)(55016003)(478600001)(41300700001)(71200400001)(26005)(53546011)(107886003)(5660300002)(54906003)(110136005)(52536014)(8936002)(316002)(8676002)(4326008)(76116006)(64756008)(66946007)(66556008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JBFC0rhVBGB4piNO5Li+OkUD1OXxpvK+4XYH16xcwAo4yLkye/52jGr3EEqV?=
 =?us-ascii?Q?Z4d4nvXHSU02m0M08Sz1dnNb5OkVYt19CyoJcsGlh4feCtXJVGEiSQoosZNW?=
 =?us-ascii?Q?RWNY3S70OUvcuYzgxA1j4HfmXsISZzaxudYV9ql21F4tF7C8HbvgHYf9K9h1?=
 =?us-ascii?Q?eWyysSgeMTcNlCPgXsdZpImIfFpHky4xeq4UPrdoe3yH+Pv3DGFIfls5mR68?=
 =?us-ascii?Q?cOh42oPDIHoIzDW9uevpQbyRBiDwhDznqzfoZwX7b4OagNAlQX5JcSMf6JuA?=
 =?us-ascii?Q?QxqTAa8GuBXSX51xHTlQd0poLiksMnOHA9QXESLhLB3q5rsgD1rE6D+Bb93j?=
 =?us-ascii?Q?PQ+clFOiSBuLbqkodKBY1pHOmMEqQ7t/oT68zYZ79xYe06R6aLL23VkMqxwe?=
 =?us-ascii?Q?8tVFAmERkajbjNxpadjJ5KAHR+pZ5HXZGV6uVqCOGQqtzRNT1gISt/aWPLKt?=
 =?us-ascii?Q?l5yDrzCVywG76JsRUfyJJTtc3z0hrDihiDun+jzf634tM2sJ0n+AFZymo09H?=
 =?us-ascii?Q?w1hxADduENpjNcNQcW+IPsPkwqy4IIf3zoMogO/lwyEY0OMC8S3/7jDSZE8Z?=
 =?us-ascii?Q?I7jooazpqFw9BEw0Orw3YvOWESUfnNwUdXhMZqthUGdzkjsXNlCRwJtWha4K?=
 =?us-ascii?Q?PI84rmaYP0GpKGyVYtF5k2bC6V0c34qs1zk5nbUxedNqVNiY1ePphTWCu1bg?=
 =?us-ascii?Q?/tS4dlQiimsepsNQ02JcBRXo2JLP/WpZs9r8/st8lMlFzw2jHgJ/13X+XiNQ?=
 =?us-ascii?Q?hpFzkSmpA/kpGUADg10VVSOKqilWmUk4N4t4NYmein5ABP6vFwei3RZ8jW7z?=
 =?us-ascii?Q?A0xATlZlVEfZj1ELPUi/gVmpvKuQQz4ntaeGeeNzwPHmkCMy1H80AqWXWz6j?=
 =?us-ascii?Q?Q7WCuNfGvHC0Q3NZ8bbkVHW9nnS3zIjP0iHzZ+9k88w4/PAVYNq0zs71fP8T?=
 =?us-ascii?Q?qLTfPcSijPxqkMTKpzW3CyJLtvtlns6PQY/43Y/i5uDNI+pJuWtLwFvno2FB?=
 =?us-ascii?Q?9/Iwf+QKtwmJYeB7wwm2JQM8wkiWl7aRJlTA2kD4zy9mYiy938/IGUmAWV8b?=
 =?us-ascii?Q?g5K0Vme7iIzWrhxsZ0Mci3UPEPxZL38/K+/vpEMNo1dm8FlSMtBRz0bALeSO?=
 =?us-ascii?Q?SjgHrlIVHvMUlRKbT1dCZriQA/g1C1jFwuq80npHpIJJfwz5qHZWwBoA7DTB?=
 =?us-ascii?Q?PQoJJOfpfFYeFXnP2Gqeknu2uknhtIVn9zkawZW/IpGeho5mxsxf146oqiAc?=
 =?us-ascii?Q?cNuZjjcNg7CPh5z1g4sGn6MxRkFbvW6CXIl+pcKua9oaZlZ95uOj3yRAk+dr?=
 =?us-ascii?Q?gNxIhMP1Zm5Bhk4RQhAKi36unpP7NJpbMQltJdOHQQkD2MvMnO1VHjZudpLg?=
 =?us-ascii?Q?bquCrupkFvSumt01kDpm+GYR+C42KW8oaCwSuhlanG7oqeS0/hDErO+1AJRx?=
 =?us-ascii?Q?4DJR/0TjLROiid5Qad68tn4Rtve/sm1yKvGWbgq5x5QRKqCq5HQnJ/he02i2?=
 =?us-ascii?Q?1cWO31LDE7EJsB6Vka7qE2kOsGH9rUCRuJ9tBTAdk3NgQG5979iaTOxdOw3o?=
 =?us-ascii?Q?vDXw8f2CurS/tUeWIivl+imtOreTSRWuVr6Lt5pp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8499
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adding detail to the description, the functionality of patch from Bruno is =
described in JESD84-B51A, Chapter 6.6.18, especially in 6th paragraph.
--
Aarne Heinonen

-----Original Message-----
From: Bruno Matic <bruno.matic@nokia.com>=20
Sent: Monday, September 19, 2022 7:19 PM
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org; avri.altman@wdc.com; Rossler, Jakob (Nokia - DE=
/Ulm) <jakob.rossler@nokia.com>; Heinonen, Aarne (Nokia - FI/Espoo) <aarne.=
heinonen@nokia.com>; Matic, Bruno (Nokia - DE/Ulm) <bruno.matic@nokia.com>
Subject: [PATCH] mmc-utils: correct ffu in case of unsupported MODE_OPERATI=
ON_CODES

Move up the return in case MODE_OPERATION_CODES is not supported.
According to the specification when MODE_OPERATION_CODES is not supported n=
o checks should be done against NUM_OF_FW_SEC_PROG.

Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
---
 mmc_cmds.c | 82 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index ef1d8c6..81fdc7e 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2897,6 +2897,13 @@ do_retry:
 		goto out;
 	}
=20
+	/* check mode operation for ffu install*/
+	if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
+		fprintf(stderr, "Please reboot to complete firmware installation on %s\n=
", device);
+		ret =3D 0;
+		goto out;
+	}
+
 	ret =3D read_extcsd(dev_fd, ext_csd);
 	if (ret) {
 		fprintf(stderr, "Could not read EXT_CSD from %s\n", device); @@ -2927,49=
 +2934,44 @@ do_retry:
 		goto out;
 	}
=20
-	/* check mode operation for ffu install*/
-	if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
-		fprintf(stderr, "Please reboot to complete firmware installation on %s\n=
", device);
-	} else {
-		fprintf(stderr, "Installing firmware on %s...\n", device);
-		/* Re-enter ffu mode and install the firmware */
-		multi_cmd->num_of_cmds =3D 2;
-
-		/* set ext_csd to install mode */
-		multi_cmd->cmds[1].opcode =3D MMC_SWITCH;
-		multi_cmd->cmds[1].blksz =3D 0;
-		multi_cmd->cmds[1].blocks =3D 0;
-		multi_cmd->cmds[1].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
-				(EXT_CSD_MODE_OPERATION_CODES << 16) |
-				(EXT_CSD_FFU_INSTALL << 8) |
-				EXT_CSD_CMD_SET_NORMAL;
-		multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-		multi_cmd->cmds[1].write_flag =3D 1;
-
-		/* send ioctl with multi-cmd */
-		ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+	fprintf(stderr, "Installing firmware on %s...\n", device);
+	/* Re-enter ffu mode and install the firmware */
+	multi_cmd->num_of_cmds =3D 2;
=20
-		if (ret) {
-			perror("Multi-cmd ioctl failed setting install mode");
-			/* In case multi-cmd ioctl failed before exiting from ffu mode */
-			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
-			goto out;
-		}
+	/* set ext_csd to install mode */
+	multi_cmd->cmds[1].opcode =3D MMC_SWITCH;
+	multi_cmd->cmds[1].blksz =3D 0;
+	multi_cmd->cmds[1].blocks =3D 0;
+	multi_cmd->cmds[1].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+			(EXT_CSD_MODE_OPERATION_CODES << 16) |
+			(EXT_CSD_FFU_INSTALL << 8) |
+			EXT_CSD_CMD_SET_NORMAL;
+	multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	multi_cmd->cmds[1].write_flag =3D 1;
=20
-		ret =3D read_extcsd(dev_fd, ext_csd);
-		if (ret) {
-			fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
-			goto out;
-		}
+	/* send ioctl with multi-cmd */
+	ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
=20
-		/* return status */
-		ret =3D ext_csd[EXT_CSD_FFU_STATUS];
-		if (ret) {
-			fprintf(stderr, "%s: error %d during FFU install:\n", device, ret);
-			goto out;
-		} else {
-			fprintf(stderr, "FFU finished successfully\n");
-		}
+	if (ret) {
+		perror("Multi-cmd ioctl failed setting install mode");
+		/* In case multi-cmd ioctl failed before exiting from ffu mode */
+		ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+		goto out;
+	}
+
+	ret =3D read_extcsd(dev_fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		goto out;
+	}
+
+	/* return status */
+	ret =3D ext_csd[EXT_CSD_FFU_STATUS];
+	if (ret) {
+		fprintf(stderr, "%s: error %d during FFU install:\n", device, ret);
+		goto out;
+	} else {
+		fprintf(stderr, "FFU finished successfully\n");
 	}
=20
 out:
--
2.29.0

