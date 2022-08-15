Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CC9C00140
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 13:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiHONLo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 09:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHONLn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 09:11:43 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70093.outbound.protection.outlook.com [40.107.7.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C2212D3E
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 06:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFQ62CZL0+pBSdNcTzLcin/VVEAeVGIjhyofPjZfWw9VXU+D+qUUwWlvzTT5gBMKAEHdPIEqoe0VjKYRj0YnPZWwgNYQWys/kAFzn8xHri77g/J9wa8ZYr2r2r0YvRNhihrOSuYqN3o44G7qIg5kBMx47f7V+lZ1zhQegKAACPNpg3bEamAW8RXS7Gtnz5ZlNtSA/6jJ7Wt4acMzqd2yGxVJLDMZNnNoDOJnSQ2fjEc0ZKHEH6dYYBdjzREhfQF4UzCdG6DW2Obptihmt/97vUu/Q3bc1RENldoxQ+CSrwgXnfsU4NX0qWauuGgcoOQdRC3Cw5rsqChUOockYz0kAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5TsGA/ZpdOpzVvQSaFuXXzSMf4mA2sp86aMEu2NZ8g=;
 b=CdFqKs4IWnFxRYMI2hTjzQdQ2S15YSGClWCtQA9DGBr4jv33xFe9fE/RaqXO69ZbbO2FtDmm6bRFVE8ezbuOXvaf3+V6yWD/IfAywmz11Wf8M+X79q+x6u7t1qVqGIJSgri2Y4+InCwOFMfp1QNZm4L9sTKTbEPD21poS6eMTTzF/XF8HiVhHrT3QPgPOllKEPZq9BrZY6zM2oiK01Ky41crO1smcLUslOv/mUAjkNtU1bNyNlpjPSumNQbHcaVEc2MSjheZBrHZP76vP+MVAO/YmQI+4BUkI2X2xgA712oOALG18NXW5/rgGXHnL8Vj4Esolu32FDGfjo/3mIOzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5TsGA/ZpdOpzVvQSaFuXXzSMf4mA2sp86aMEu2NZ8g=;
 b=yDuPBHkCZ+0Kq+QQ/yzywqJMu9NRrLtPIWkeXeSV8ckmdxhjPOpIGn3R51ocCBouU4IzkRkhd+IVJkt3iLG8Ri29fyyGeWMW3r4/t/xiU8887nGispszOAhNnGJaUIOJ//Nf0OrFBTWB0/X047Q9jn+389k2K3Ki7x4TxHdKKaM=
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 (2603:10a6:203:4e::11) by AM6PR07MB5413.eurprd07.prod.outlook.com
 (2603:10a6:20b:82::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.14; Mon, 15 Aug
 2022 13:11:33 +0000
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::542a:5d98:f0f4:3640]) by AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::542a:5d98:f0f4:3640%7]) with mapi id 15.20.5546.014; Mon, 15 Aug 2022
 13:11:33 +0000
From:   "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7QAPwi0AABQpUuABmc8nMAACAULgAlKINPAAMpvpoAUetmXQAAXdPWAAAhdXwA==
Date:   Mon, 15 Aug 2022 13:11:33 +0000
Message-ID: <AM5PR0701MB2964D0B47A64F62402ECC43BEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <AM5PR0701MB2964D76967437E61EF42731DEF839@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65750D9A332093DBA5B30BDAFC839@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB29641DB9207CDDD1DB273075EF8F9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65759D709D6C45AFD03EB4B1FC8E9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB296429322BA0EEB2CE0B23FBEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65756EA45A10629F2EA8A870FC689@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65756EA45A10629F2EA8A870FC689@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e9ec43f-7700-4dfe-aa81-08da7ebfad47
x-ms-traffictypediagnostic: AM6PR07MB5413:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CnQW4fTB4EfrB8ksEkQO92Lpgy8EcM7dQ48cYATsBr0fhse/gvgMFJmb0rdLy4GRJFROsRInwXbvrWUvLsHYhqhju3khUPoUbzU0cipDTXlOMppPtH6QIusYCMTB0cEvH6mU1l6912PcYJ5v+fstOom552vckVLNJ7TKveNxfFhd+xb5iXHV+d5xoXtEWQZ1VkD9k8vnTZMD702EgChiS3oSnLg+RC1la2nABffkwPcyNajcqDkUINOUfD+298LbyNQBK6BFstBSBT0rNd3LNolXx6MbMLKbZ3fvQchv+8lsm2mCaGKrdTaghX3UediIOmqFIftLKFpZzXHMhBRu7xUMxDlhmEUkkCk81OyR9WfCK6TbBZ6/cvCY9Fd7Zlbb0QyOT1ogMtrCsPH0wjTV/gBcUlehQJMg66bqgZw7gNqn7VSYrsHH+YIFW6jJDi+zbqehEYF1HLPvjdlB4KHzIrR404TD9YqIvSYaX//MLG3fkasDGZF9ZCCW13ImC9eGSoZB9xenPtRHuOYfaMMyVTcac44aCsVU/4F2F3dqeB0Jywc5Y1dBlOjusMs1HrLCyXuDJyaOeyHp6VJ3tUhi7TzPSG1Odz003vTrruqaBMKHrCFfV9RQCi3Yvau1gyYtuyxUwpjKcGxZVAzt2Kk1oFWASNEBh68NwT8OVV08+bCWnnIf5J471O8NskETauw7bwzk35DJCrxpqsFYfUt8y5BYI+E7iJgFaNGNhyQUjJGVdOKK3OMwzfKh8PTJTO/uYMN6pBK7g36HDPNsqoKkhkeij5KV4gi2qx5AFgY6szv68SakJzkHvKFlWbEEKD2O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0701MB2964.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(6506007)(9686003)(26005)(478600001)(186003)(7696005)(41300700001)(316002)(54906003)(110136005)(8676002)(8936002)(76116006)(66446008)(4326008)(66556008)(64756008)(83380400001)(66476007)(66946007)(2906002)(55016003)(107886003)(38070700005)(52536014)(5660300002)(71200400001)(38100700002)(33656002)(86362001)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UxH+8vWT8OWmlJKzMIGm6uO27WE8LJFrOL+doZ2dFX+1t/ja8r3onvuc3a?=
 =?iso-8859-1?Q?/My0sFB5Nl0s7+RrQwx5hqTdlJOGEYWgd/KTj5VO8APPNDrRboBguIlPOC?=
 =?iso-8859-1?Q?2fb7tLUdJyq6LKmuwPt6s86ioEtvyk5he9EqYd9mLypIH2uUsE/gmdJ4wC?=
 =?iso-8859-1?Q?YKWjvRjZlKVYpDWyrWLn0DILsn1TrlX69oblqdqcKx6YTGxVAs2ejpH0RU?=
 =?iso-8859-1?Q?94d0yxbb0LXbBRnEyDdUmiD0O31Xtt8ZD/C78D8t0xwjH42kLRW6GfV5cW?=
 =?iso-8859-1?Q?cMnsMy5uODYj/7qCGppAMUCz185Scay0d9ruQb8ihCb78iSn1Fqu6fHsmR?=
 =?iso-8859-1?Q?AnoPxMKrT0bIhHw7hY9bZ66cYetIDPFiOkk/KijTec2k3+xsjexYBO5xZK?=
 =?iso-8859-1?Q?YtkzpwwucrEOT4JzmtNWb6WjTmwK3Ah0pgs9H5t1YUKLbuSsmpUvmb4WnZ?=
 =?iso-8859-1?Q?TxU96AXv4qHFigPMNj2Gur6G5iHDSyYZWeX7fYH5AB7iz+nsY8Ih7Hga0N?=
 =?iso-8859-1?Q?+bsvqzEHmiMXDOLeU6RQeFKzgPN+AouWG8aQgTiDzeKcnSKySHskrO1LEl?=
 =?iso-8859-1?Q?aZA/pnbyGWk32pygGwQCipWA9my6X1Fy3Fo72NCNmoiDhAPqJ8EppWAfVh?=
 =?iso-8859-1?Q?jj3y9Yxw0YLG1HYaaIJi7dKwK5CHTyYPi0rhhxkDUWlWIufNIHi6EuZh2D?=
 =?iso-8859-1?Q?r/ojhpWIgUXEHLU4x+m2AkLlhXycZI5vciivlYjaQ18q6AwCL4TJOekjAU?=
 =?iso-8859-1?Q?ipggNo2Uvnie0auAPD/BPRvpyCTQUyvKdjCjVfrunM6ZL2r58VKRp/6UUq?=
 =?iso-8859-1?Q?bIeDIr/8h+BjBJYdJKO87bjEG1hsYMWnJLPpdj4YHSYHDTTT1eKtUHwAgH?=
 =?iso-8859-1?Q?GcvagMlh462EzctZ7ug3mnmuQ+Agvd8cQthVwC7g5hPyCvGLSIFniCo7Hf?=
 =?iso-8859-1?Q?cWRY9tCU69PIiwqGZfCpz2vRcHpG+/OVDhn7/4LPtR653kbH5bOUYvLkHa?=
 =?iso-8859-1?Q?RAjp4z/KnJAPbTRlQvZ8sNyYp3LWF4CWtOZIp/++4dYOF8Qxq06yk640WB?=
 =?iso-8859-1?Q?f1zrx1PYzae49ffHLv9L+VLF4RjSyrfTYQOaGiQYLIeJQheyFMnmpQA9fa?=
 =?iso-8859-1?Q?ULTiVAKahGxQtrQXD3JEAPwMRn69WAK443f4Vv2+qtCionjWnm0t3pdBrz?=
 =?iso-8859-1?Q?K838Ie5z9Zmpc3kl5zI4XpdAiK2Etdd/a5aRDKxFmIJpJB6mbZ1nGIUCZk?=
 =?iso-8859-1?Q?I8giv+vSDSnh4/9q3g4vjnmULkVIraaXwI1muueg9qH7NMDwUfs17S5HAO?=
 =?iso-8859-1?Q?y3yUSdJoajwmy2XPF2zOLlcAb9Ie0Ol1/lkO4vn3JW0HJnhXNk2wv0SGU5?=
 =?iso-8859-1?Q?Hw49u3gI5JfN/DGguH6olllZG4dsm5tLcHyNtkqrWioAadnSp8KWJtM+if?=
 =?iso-8859-1?Q?dnIsmpMfcf+blkjEdt58g205ghjJ/yw/mysv/4rXNxHYXH9JqXJW0mJQsC?=
 =?iso-8859-1?Q?aahuWryxsPYUrGMEltxHyqgUkMBsvBbbze7e6M3JQzAjWVHd9R492R7pnm?=
 =?iso-8859-1?Q?l5g4pcM6wdBuW7/zEQqR/ba6+YKCVEUEf9h7GgXsQLkkv0E+z06mxB17AP?=
 =?iso-8859-1?Q?Lq37dlZkuNVM9MKSGQ2HMEQP1g0amAc9b4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0701MB2964.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9ec43f-7700-4dfe-aa81-08da7ebfad47
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 13:11:33.7043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyq06gNNA5K4Lo5mUAqW4g1MYbtlJQTmhddLxQOPadcHNA58ahRmoCCZEOSCbFK0o0yl2b8UhXAmQaZ8Tv9bcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB5413
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi everyone,
As said, here is the reworked patch.


Add the check if the whole firmware was loaded.
Cleaned up the leftovers of handling the file in chunks.

Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
---
 mmc_cmds.c | 66 ++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 70480df..7d37e93 100644
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
@@ -2925,45 +2924,44 @@ int do_ffu(int nargs, char **argv)
 	multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	multi_cmd->cmds[3].write_flag =3D 1;
=20
-do_retry:
-	/* read firmware chunk */
+	/* read firmware */
 	lseek(img_fd, 0, SEEK_SET);
-	chunk_size =3D read(img_fd, buf, fw_size);
+	if (read(img_fd, buf, fw_size) !=3D fw_size) {
+		perror("Could not read the firmware file: ");
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
+		if (retry--) {
+			fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
+			goto do_retry;
 		}
+		fprintf(stderr, "Programming failed! Aborting...\n");
+		goto out;
 	}
=20
 	if ((sect_done * sect_size) =3D=3D fw_size) {
--=20
2.29.0

