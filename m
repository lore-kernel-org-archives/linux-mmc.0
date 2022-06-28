Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE69C43334
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jun 2022 14:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346201AbiF1OkP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jun 2022 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiF1OkO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2022 10:40:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70127.outbound.protection.outlook.com [40.107.7.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9439F2A268
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jun 2022 07:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPz4xy0BZpMKFITB1Y7WSz5FD16SRlfPQE6LAjSzY+q8LSCYn7CqU+rZ0WfuiQwVGB174eHN9HEjJMzdqimtVbPZ6KNYMeykXuBL2iFcH5DJeXI+2IkC26GGYyKBOkMhvlOXAD8mhbJ7gtackhT70VBSKEdppelv7m8e9M5QNrUhiWcMUyufbqw9umfWGpyyHPhYyAZMIj2BTgAlAupPLu6Rt/nISdHi811GU93qpbiDU2UkyyCHSO6OKW+wByrKPMzRCeNkXm3O5qIlTP4Qr8cCCLP99tLj022j0nt2LE9r4IlChq1e631swQf4M1cQrnTVPs9qu/YIfLDzSxidBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IBYtgiz9eT+JUHxd9fmr8FLlHLAtr9NH1jBzd/zmII=;
 b=E7SLDYoAOR5yc42G9VizDJ7A4CwmGKo8vuCYAUXMZgLZyjCe4cUarYhgFhVRHnLUN32iG6mWWLNIcAeHJABKlkJ8VOk36VjM6oC4hzj0jKvFgevtZ5cHRTafejl6DoC2BQ8jnBI7vwgdx0A5HnHh2ZVl+txhWT+i55mlZXQM0pQz5WqKJsEgTpCb3lUrN0WqccBH9ZExBPUnyDAqc/Vu5PoPhLv8u8L3VgZ5q7xXRc0I3/RckR3AguK46Ibl21jEd2in1ikOtr2f7FhaYuhCjF/yE5DAisP8yohTGohqAu2fWpIbqeEXl6YskDd/poSgDsOEsktXxjm6F5r3cUINqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IBYtgiz9eT+JUHxd9fmr8FLlHLAtr9NH1jBzd/zmII=;
 b=bU6etLHgPLccV9l2gSOi0Twsx3i9EYcObuJq5eLNtnOm9JqmlCM4/x+4yRoKcHaMd65PkJLWvC9cETL82iZYayiRoRWawK97gMlr6kOak5abQffjpNlo6XjmlW8Jbne+Ia322C8k88y0kFzLTUTYyV1O4OZ49vmCez1bHiX3zFs=
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 (2603:10a6:203:4e::11) by DB6PR0701MB2646.eurprd07.prod.outlook.com
 (2603:10a6:4:22::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 28 Jun
 2022 14:40:10 +0000
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::3593:a351:dfd5:7f98]) by AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::3593:a351:dfd5:7f98%4]) with mapi id 15.20.5395.012; Tue, 28 Jun 2022
 14:40:10 +0000
From:   "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7Q==
Date:   Tue, 28 Jun 2022 14:40:09 +0000
Message-ID: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26832eea-3d55-48e8-9b8e-08da59141a30
x-ms-traffictypediagnostic: DB6PR0701MB2646:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xDvaALbGWZF4M3gefLgRmtwMSNFnX0CpbrGq9sa9UO0WizFFujRIlTgoMZv1j2TsD1omWKqWHMRf6Nrr5eEYYOKa10HtTQP9xthiSxEPpoEgYtFUz300wcBH7XpOAB98Gz3wRJp3pGIqDS5HRE0H9EliExjR/pF5ipjjEM8RxAqgR7N/2FyxN+/n+anFA66AhqVPg2SiNfaN8Xq8S8xBnawhBT33wGgS9VzL5y5MnqI5BwpxI4CJuxT8ZIHtZjnIRfSWSu8DQ0xL1IP5gpvpQuOBgX1TCcz5uf26JBSlyjMpwO+OoMo5cUQ6c8tT5x3tZqCNJKIXEE7YEidP4W+T/MdU4YPkjPL/akO8GVu672YB1zPWpWlidtsY6ytBUTyat9cj7CSDZQIPYXlI+Lt229Qqa7h8hNlAIj6kW0xUTRjixO9908Tz1GkBzPOA27mdT06s9pBwEpuCEZigSKdeJDuhn9wwO/lSxAxy1Swcb8skF7zbdSCgoogVeLvCh+YGJZ8M9FWxZOCwWCItFqsp65TOIlAnMntqGVbDIlcE1RRA3ZIEYMDU/zH43NzzgxUm9OJHm9QpkCrglDPdjsGZ0tcmkVBC4kpoJqOQNlqiGRA6FsPpHInZxkgXIbEg4CQLdujdL9YOPDmzGaGMZxts+4rCXLyzuopOBWe3FfLclIUTC/iqpsk5Ja8Bx3bk0gY4Q47dr+SEQwT073ArtRNkZsfctHnRP6RFz/NTT89Mrnvhunjgtk200bTWvt+CVIG4/k4vxNL1xinwnG1sEXm4nXZyYslFprzdKHRoXLE/qGs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0701MB2964.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(71200400001)(64756008)(8676002)(86362001)(76116006)(66946007)(66446008)(83380400001)(4326008)(55016003)(66476007)(66556008)(33656002)(26005)(9686003)(6506007)(7696005)(82960400001)(52536014)(478600001)(8936002)(122000001)(6916009)(38070700005)(2906002)(5660300002)(316002)(54906003)(38100700002)(186003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PEEShQMGwOwuXhX/CSIFPhh+tmKZiopqoGk92HwtC1KKhcq/gg+Qs0+xx4J/?=
 =?us-ascii?Q?n3KE2aAQ2hyHfnRk8UGq3ACMV0l8ho9WbOrrIT3emtMD6Gas31NtvKh5Sk4I?=
 =?us-ascii?Q?OaOZ8OVAWT3TaN1q/CW5CBaz7np+RrjWq8iWeoVVjPE1kCkNzN/x0A4IrJKG?=
 =?us-ascii?Q?aO+JkAZkQjjUOD9D0L9XVjbX6E8vZJBWrp4g1ajyFE6fI8COZHPjZvyMMxnH?=
 =?us-ascii?Q?w8nalJUUGV5bw0aKd5IRA7pKhGJ7nHXAoHQdU/Dn0T9f/Y0Pc4GhzLHAM3f6?=
 =?us-ascii?Q?DGh129OnMCeoITvUr1IBag4Zstxpbp6eLLIromGqQx5J916cC4A9Kem4cYoL?=
 =?us-ascii?Q?P4tPJyxcuvb/q5a1PmvuePjZbmTcmlBHvrjc1W1s0UobDCmfbYoazbt1aO69?=
 =?us-ascii?Q?TjfIuNO4gwpcZVn3KFmHRJ0SPI9OsR3eB1AwsOaurQHPL0ALu0jzsQPc3jRH?=
 =?us-ascii?Q?ltH1jyu0fzadjqkTVEjOonk0kSXNXra/NFMPIoM8kOOqCi99Ck6JHRECjTqZ?=
 =?us-ascii?Q?671mMyyUGvbjCbSmnSA9UUiHRW/O5DYgrSsFno73uulPUFK/tXx8C2GI4dPg?=
 =?us-ascii?Q?4gMuNvwVFUlqXIuHtw/2yOqakDOEKikDxqyEgBrOaIj/GDc9AL6n3gDKSnpN?=
 =?us-ascii?Q?IZikJcnC+topEUA7UGcGK/K1ePHmRIJHqxtPk0Rwyj0ln7RrHHRrrTSEfn1+?=
 =?us-ascii?Q?Ulg6jEyjs7RDtU+dr6QlnHS47efn/bjQF+yENJ/s8CtDjuXWaI/ERBEG3sNk?=
 =?us-ascii?Q?nMiX5GeByuuZlY29t9EF0IyNDX6gE8+DroKSPsTBvPNvdsN7inp529f+Solg?=
 =?us-ascii?Q?tlCKdaB39TelpL8dFoAe2PfXw4Y2LOiWErnW/+ucgRTkxAQDMOe8Nmcs1z2V?=
 =?us-ascii?Q?/rDVyYqoLNturYvlf9OLxCkQbX+G6Z15wMG3TMbCoCM83h8P4Y1jMMEG8NAG?=
 =?us-ascii?Q?9HAY3ME4nCwt3uKcTiuPfAotgzccFCU7pqMN38uV1yWCxVVpKThmczsexba9?=
 =?us-ascii?Q?2yjsV30XWnzbZ1JF09pbCf7MMyHuFvrbegNnxTaMmb1aRl4M0dx2bm7au+tK?=
 =?us-ascii?Q?nPBQlMq6xT16EraJitQ8Hcw1NPsLRs3MevHCeuuxF7u98Mcd51x2IvJKzcTj?=
 =?us-ascii?Q?k/FiyF4nj4Swtwf9GmE12+hkxQviqGZPCTBVo2v5PI3Yf9kGseEw5bfC1F4W?=
 =?us-ascii?Q?k+9ZOe4LNvutqTYeGrAQW1mpeCMZdsRF4P2OLLHV6++vGRUPAkNTBoNG6ZY3?=
 =?us-ascii?Q?X+SSwYL0m97f1QI25Td/ZqsMoEl6rczWtoq7vwTdDNetVA4LkKI7bW+nW2HQ?=
 =?us-ascii?Q?CG3Vn8yop+j1hpXxeOOv8hySuUOYy3+LcBdKeaIeyuEPnMkvqe3sDMd8RGgo?=
 =?us-ascii?Q?9u1/l+TO4te7/3kJQEl9x60ocKsMfbOMNKxdgx9/LgWE5KWlpvUzndAv0SNF?=
 =?us-ascii?Q?3hiV2yyebjknblMsbDbJBFJX6QxvAhKTetGi5APSKZc1NhFf7fSiUnLaqcW3?=
 =?us-ascii?Q?9AJ5QooXAIMHVStr33cFaZAfOHrhW114M0liPdkgLwjk47x8oZZvuvW9Op72?=
 =?us-ascii?Q?+Y3+FJHQVgsTYYFbG6XU7frNHt7hjq8bESOOYC0G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0701MB2964.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26832eea-3d55-48e8-9b8e-08da59141a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 14:40:09.9332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATaONxZbkz4M3VzWY65qfL+nNZP0YIDFZYRe7PPwAQRpFZBFOrVYDrKsHaGN695Qmm2qjwngCmBgT0CqoBMIyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB2646
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add the check if the whole firmware was loaded.
Cleaned up the leftovers of handling the file in chunks.

Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
---
 mmc_cmds.c | 69 +++++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 70480df..e64c747 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2812,7 +2812,6 @@ int do_ffu(int nargs, char **argv)
 	__u8 *buf =3D NULL;
 	__u32 arg;
 	off_t fw_size;
-	ssize_t chunk_size;
 	char *device;
 	struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
 	__u32 blocks =3D 1;
@@ -2925,45 +2924,45 @@ int do_ffu(int nargs, char **argv)
 	multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	multi_cmd->cmds[3].write_flag =3D 1;
=20
-do_retry:
-	/* read firmware chunk */
+	/* read firmware */
 	lseek(img_fd, 0, SEEK_SET);
-	chunk_size =3D read(img_fd, buf, fw_size);
+	if (read(img_fd, buf, fw_size) !=3D fw_size) {
+		fprintf(stderr, "Could not read the whole firmware file\n");
+		ret =3D -ENOSPC;
+		goto out;
+	}
=20
-	if (chunk_size > 0) {
-		/* send ioctl with multi-cmd */
-		ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+do_retry:
+	/* send ioctl with multi-cmd */
+	ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
=20
-		if (ret) {
-			perror("Multi-cmd ioctl");
-			/* In case multi-cmd ioctl failed before exiting from ffu mode */
-			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
-			goto out;
-		}
+	if (ret) {
+		perror("Multi-cmd ioctl");
+		/* In case multi-cmd ioctl failed before exiting from ffu mode */
+		ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+		goto out;
+	}
=20
-		ret =3D read_extcsd(dev_fd, ext_csd);
-		if (ret) {
-			fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
-			goto out;
-		}
+	ret =3D read_extcsd(dev_fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		goto out;
+	}
=20
-		/* Test if we need to restart the download */
-		sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
-				ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
-				ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
-				ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
-		/* By spec, host should re-start download from the first sector if sect_=
done is 0 */
-		if (sect_done =3D=3D 0) {
-			if (retry > 0) {
-				retry--;
-				fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
-				goto do_retry;
-			}
-			fprintf(stderr, "Programming failed! Aborting...\n");
-			goto out;
-		} else {
-			fprintf(stderr, "Programmed %d/%jd bytes\r", sect_done * sect_size, (in=
tmax_t)fw_size);
+	/* Test if we need to restart the download */
+	sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
+	/* By spec, host should re-start download from the first sector if sect_d=
one is 0 */
+	if (sect_done =3D=3D 0) {
+		if (retry > 0) {
+			retry--;
+			fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
+			goto do_retry;
 		}
+		fprintf(stderr, "Programming failed! Aborting...\n");
+		goto out;
 	}
=20
 	if ((sect_done * sect_size) =3D=3D fw_size) {
