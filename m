Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5FFC43334
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jul 2022 08:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiGSIDZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jul 2022 04:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGSIDZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2022 04:03:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60098.outbound.protection.outlook.com [40.107.6.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C18286C6
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2022 01:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEvdL7QQEbAPmdKD8waztOQ9Wx2BguksNqobh7oVQgm16z9OSFuFbPWfjP5ah9b38znFcnFl21yAf0UxhePg8swY67/WIWBcb0d0S2rS0PxevfR2jHRKOSof8Qr7isuXKEKf2aU0LJvhQwskWpfzK/LTD63Nax2+suMOJGiTtn/Rohwuf4Am9d+8WctOKCY9HPsAn+g4F5tw6OEJDizPIGqC0FaJvPNUrePv7dc4k04H1t7/cZakTROwSX3RE9yL3O9X5WodErJ1qtOpauy+YMbbLuxHVoGiui7I9Wi+CRH2NcnansqEOd6HXPDSyD0MgVYlfotlDr4/xw9C5yGa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbXmU/Yp9AQ8w5tzgPFt5mQOzkvKDZ/vsaGS4WTindg=;
 b=oLPOgQRKWU6gD713xoJZ7C29k0A/Qv00R9TQJWhjN66YDFx7mUbKFPuQeo1cW5ehyg2CTrLtEA4alSDYD7MrjAZl+/f4QaJkggDTQ1XsgcULqqZrbxU/Eq8W3K1V8Jo4N4DXz3bbkLNyeg0Yt9IwATxb7llVgG9tQkD/HwKixHef24nzOFoAAawQv3yDEaKRpVwJi1HYX4DHMUx3Du2Gvx75OxK1BmLS0LLzWlrEy0rHSFeRiYq3J4jO91jMffZStBucwkvBoj3koO44Iq57DDW6mQq1CBqwxGQR8WFBCz+SDQ+BfHzG1xSAya1kosOPiez0pr/+BpNjaGbOK25+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbXmU/Yp9AQ8w5tzgPFt5mQOzkvKDZ/vsaGS4WTindg=;
 b=u302caB25yfYHI6hrfsTtixkv/rBTJiYW1MNQ8pZRW8/CD1IpDpFKvWdcXIoEXjQ+drFXaaio9+c7rzWLLI0ZK7cvBCDUNZvtHix4RwMmu18B5Od3iHrPWLREUWxU8MNKZmk44PYiyBJR6q6CTut+0kHL2+N5sq/3JYvjVX2lkE=
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 (2603:10a6:203:4e::11) by DU0PR07MB8643.eurprd07.prod.outlook.com
 (2603:10a6:10:31f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.15; Tue, 19 Jul
 2022 08:03:21 +0000
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::d03e:b328:3e29:7230]) by AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::d03e:b328:3e29:7230%7]) with mapi id 15.20.5458.016; Tue, 19 Jul 2022
 08:03:20 +0000
From:   "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7QAPwi0AABQpUuABmc8nMAACAULgAlKINPA=
Date:   Tue, 19 Jul 2022 08:03:20 +0000
Message-ID: <AM5PR0701MB29641DB9207CDDD1DB273075EF8F9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <AM5PR0701MB2964D76967437E61EF42731DEF839@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65750D9A332093DBA5B30BDAFC839@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65750D9A332093DBA5B30BDAFC839@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee4bafc8-f8b4-4ad0-26cd-08da695d2590
x-ms-traffictypediagnostic: DU0PR07MB8643:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /nECMSOZVIbGYCajF+Tm/xhPx8ue+mXQcFrWwn2rkbAV3E+LuHVGAZD52cecrk9GplXL8lYFVb/AsTiIHd0/NT9OzaBiY5MqHKmaqOrvb967I3vLmJuNWXmBCXFaA5qwgIaSs8e9VqxgoTX81Ee7RMohRHOi25If2xWxYy8Lmow4itxRYy3PtS1c0vUhvR/b9bHKIpko08KqhYEmn6iP5Wz2RvgbxJrYfjOQMivAyBX4VD+QRpWljOUapqpLQUK5IdW4aYnas89kuSDGUuLhAOt+6NaKhb0pFJiX9O4sSUoqzPx9h5QXEP6rZ30thh62T1DPR2LHHvMGxRjONe+mhyCR7+wzzoa5LPykVAs1zSwoW4e4dCwOK7pApe+/qV6U/aCyJKkglXOfvYEBSJ0CYc/ZMHHWceRxkGudNIOt6IPWMyVFD3apiFPvJRTXXtqLvh/mALy7jc0R/jjvuN+ovvD7a00FAdTplkTVIDH9VVAD8quqFJv6PqVWSh9v2oAyPtZY5y+ejJThFdosXBDCaEKEMQzdL+Dyn4Ha95ZvihdB6KGQA7IHMPqHUrsnVEvTfljt0+vVwjractvRelz7oojqgMm76N9hCRKqNpnbrs6FWJi51Er3Hfxs5wQm2zXllmzubIGGKGSJDjULXeq653NNL+5t9V3bBJj0VeCHA/6Uj6h8cOtqdB1C0decExYGZRvG2bg4uIMU3Rr7pYgge2VbEzWmStEFRBr+raD5T5rJr2k+Tf7kjXinNqLcDmQquMUfK4GzWWkRnBmOE/I8fVv/XNjcxFYjDmxpkJP2QM7HerFhMSonJ4sr7x2LXPfdYYTZLKzboRgC/XShwD5u4rR6+NacjLFQ9J2GR14NkmvZeVHg+OpeeXdJj8Ho8cv0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0701MB2964.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(52536014)(8936002)(5660300002)(64756008)(55016003)(2906002)(66446008)(33656002)(66556008)(54906003)(86362001)(110136005)(8676002)(76116006)(316002)(122000001)(82960400001)(6506007)(26005)(53546011)(107886003)(966005)(71200400001)(478600001)(186003)(41300700001)(66574015)(38070700005)(4326008)(66946007)(83380400001)(66476007)(38100700002)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?D0/xsQowf3ZbnDq1u3jh0WNwc49Kx9RVllR6kWq9Bz9/96bOsERCb2Ag2j?=
 =?iso-8859-2?Q?i/+zvlEq8MDEiZB2IKx2DUdXpqv6BlWHZdMutrul6A3qjWtrxKo9IRobX+?=
 =?iso-8859-2?Q?JVfG9LVJqkY7w8NiuR6iBjHtU/VTVqyi9SA47Ar4qwFvrZ4z/cMfH4mea8?=
 =?iso-8859-2?Q?iN16S1M6k27chJ+bKqqLlSmK//oPcJF5YJQPP18m4L+pyQUAi06ZGvExD3?=
 =?iso-8859-2?Q?JcK4dEMfBn0Y0yGhWTFfyD3Esi+yexbcwxXa9VUxw7bLDMa0kDWAlh8Zgk?=
 =?iso-8859-2?Q?k5DOMPdXImUhjRFqL+QDnBRlJ+mPwo6kRJd/Kk2PDNQjTwpLv1Rqw5JPEB?=
 =?iso-8859-2?Q?K/y1bsfKE80gTrGuUukrWhYd62fyvNhUbtaLnD7zuVPkIYj10uV8L391Cc?=
 =?iso-8859-2?Q?1LN1P4GObphkq9dmXVmIHOfGh3yWHXreO5bW5MN0ve6RbAQ+2tXcNAkgwa?=
 =?iso-8859-2?Q?chUYOKGrANJVkiNEx/83KEd58DX/X9uZz+WgH+m/yBh/lFF8VQXAzehv40?=
 =?iso-8859-2?Q?nnwm3MukoUWdf51ksFRPhvRoWPOZXnxLOosH/uOQjsWUpfKb8goC7PjLQ5?=
 =?iso-8859-2?Q?yQTe3PqLTWrWisrTC9ot78FKQUbtoCe28DwJC6Ttfjovhb2U1XMJ9ZR/Vq?=
 =?iso-8859-2?Q?hvK8VBihpQl+Og0MoxKarBEL0i/jxYfUtg0AEDisFuxl46+MqdUUibVvXq?=
 =?iso-8859-2?Q?XFlhlMSWZVzjshoteRbXBedrpjrHmm04HFXayBqIxaxtn12+da3+1pw5L+?=
 =?iso-8859-2?Q?VLKZz5XiwUtPxBq7FhYcMgi7vU0rfL83F5VZmEXY/YuWtfGD1S6dlgBBfl?=
 =?iso-8859-2?Q?lY0euLdBGIChiHTXo347SvaqIPJX/MPa8GJ/jloHIEZpmfncWFpwYYDmQP?=
 =?iso-8859-2?Q?RhUiYE1P1yWew5CdBtslcohB2TyFMvPJFvSTpbPc4ncKaNYSzNwOtGrsH+?=
 =?iso-8859-2?Q?/E8gX4kmq6RiIKd8RRPyjp8dhBoBJOxYrm6N/s86/DejiHhbgetkRNZfaP?=
 =?iso-8859-2?Q?aaVjh8da6PMpzAZo0+kNleYrRqf7BK53812GpnJB54Q197VJaGn+oK/lRg?=
 =?iso-8859-2?Q?9HshHDJ6x85Lgl8HuDxqJO6a0AsXkK3nVSuMJvwh/0z9VL+QRI228Loeuk?=
 =?iso-8859-2?Q?dmvatlAXIQ9Xy7rc/DfApI6Q2ba1IFJPkqrlRuPVsaXJmD3gdcIEb+qyZ4?=
 =?iso-8859-2?Q?sQF2a0GBJrrd8NjQbYKdYhnXq5xaK5W62j7xMjM+l9tYFmTws1GRJjNb/B?=
 =?iso-8859-2?Q?I2H3McXD+8iu18suLPOwufOiqC3LpI/n5Pt5YweQC1rAxwu654HuPZiwgl?=
 =?iso-8859-2?Q?l2EuyWKQZDUewZI4sAtZ5JzMEHXBFZw+Q3A1Bwp3VCPdegkCmA0ag8q8mO?=
 =?iso-8859-2?Q?sOQI7OWz32dlH8RwBmykUWK/AUL3qGLHcSQ1ad8CH52pqCoZPFIbRMv079?=
 =?iso-8859-2?Q?JAcPGURmSk2amiCbneOYhRWB3S8ABQqiH5KQDpIyHdkTyc4xKWWFT64OuH?=
 =?iso-8859-2?Q?sMU9T2hsOvGsjASNw+tN7kohZomG+i36onBmDtApkThw5/Rlngjtapm7Z0?=
 =?iso-8859-2?Q?TVU3STk1lge2eNhvd3gW3pGTjo5A+RQabN3NnkT8Cr+CN7RBPUA4ZuOcib?=
 =?iso-8859-2?Q?Ta6s9suKpbAeVNAaT320kU3z0+ghe7J2jx?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0701MB2964.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4bafc8-f8b4-4ad0-26cd-08da695d2590
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 08:03:20.8800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7t1emw8zB+Sb/wtvqc4fIfzv1MKGtwzw8GRelrrSA+hM7eeBxorZadr4H4PEJ+qdrH5HmometkxFpCc0+EbFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8643
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi everyone,

Here is the rebased patch.

Add the check if the whole firmware was loaded.
Cleaned up the leftovers of handling the file in chunks.

Signed-off-by: Bruno Matic <bruno.matic@nokia.com>

---
 mmc_cmds.c | 67 +++++++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 8d7910e..d017b64 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2812,7 +2812,6 @@ int do_ffu(int nargs, char **argv)
 	__u8 *buf =3D NULL;
 	__u32 arg;
 	off_t fw_size;
-	ssize_t chunk_size;
 	char *device;
 	struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
=20
@@ -2926,45 +2925,45 @@ int do_ffu(int nargs, char **argv)
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

Best regards,
Bruno Mati=E6

-----Original Message-----
From: Avri Altman <Avri.Altman@wdc.com>=20
Sent: Thursday, July 7, 2022 2:00 PM
To: Matic, Bruno (Nokia - DE/Ulm) <bruno.matic@nokia.com>; linux-mmc@vger.k=
ernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>; Christian L=F6hle <CLoehle@hypers=
tone.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling

> Hi everyone,
>=20
> If I may ask if there is any update on the state of the merge since I=20
> can't see anything in the git log.
I am following this - Ulf didn't pick it up yet.
Will ping you once he will.

Thanks,
Avri

>=20
> Best regards,
> Bruno Mati=E6
>=20
> -----Original Message-----
> From: Matic, Bruno (Nokia - DE/Ulm)
> Sent: Wednesday, June 29, 2022 9:33 AM
> To: Avri Altman <Avri.Altman@wdc.com>; linux-mmc@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Christian L=F6hle=20
> <CLoehle@hyperstone.com>
> Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
>=20
> Hi Avri,
>=20
> That is ok, I will wait.
>=20
> Best regards,
> Bruno Mati=E6
>=20
> -----Original Message-----
> From: Avri Altman <Avri.Altman@wdc.com>
> Sent: Tuesday, June 28, 2022 11:56 PM
> To: Matic, Bruno (Nokia - DE/Ulm) <bruno.matic@nokia.com>; linux-=20
> mmc@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Christian L=F6hle=20
> <CLoehle@hyperstone.com>
> Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
>=20
> Hi Bruno,
> Thank you for your patch.
>=20
> > Add the check if the whole firmware was loaded.
> > Cleaned up the leftovers of handling the file in chunks.
> >
> > Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
> Christian proposed a fix to do_ffu about a week ago, see e.g.
> https://www.spinics.net/lists/linux-mmc/msg70961.html.
>=20
> Would you mind waiting for few more days to allow it to finalize, And=20
> then rebase your change and resend?
>=20
> Thanks,
> Avri
>=20
> > ---
> >  mmc_cmds.c | 69
> > +++++++++++++++++++++++++++---------------------------
> >  1 file changed, 34 insertions(+), 35 deletions(-)
> >
> > diff --git a/mmc_cmds.c b/mmc_cmds.c index 70480df..e64c747 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -2812,7 +2812,6 @@ int do_ffu(int nargs, char **argv)
> >         __u8 *buf =3D NULL;
> >         __u32 arg;
> >         off_t fw_size;
> > -       ssize_t chunk_size;
> >         char *device;
> >         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
> >         __u32 blocks =3D 1;
> > @@ -2925,45 +2924,45 @@ int do_ffu(int nargs, char **argv)
> >         multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |=20
> > MMC_CMD_AC;
> >         multi_cmd->cmds[3].write_flag =3D 1;
> >
> > -do_retry:
> > -       /* read firmware chunk */
> > +       /* read firmware */
> >         lseek(img_fd, 0, SEEK_SET);
> > -       chunk_size =3D read(img_fd, buf, fw_size);
> > +       if (read(img_fd, buf, fw_size) !=3D fw_size) {
> > +               fprintf(stderr, "Could not read the whole firmware file=
\n");
> > +               ret =3D -ENOSPC;
> > +               goto out;
> > +       }
> >
> > -       if (chunk_size > 0) {
> > -               /* send ioctl with multi-cmd */
> > -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> > +do_retry:
> > +       /* send ioctl with multi-cmd */
> > +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> >
> > -               if (ret) {
> > -                       perror("Multi-cmd ioctl");
> > -                       /* In case multi-cmd ioctl failed before exitin=
g from ffu mode
> */
> > -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3])=
;
> > -                       goto out;
> > -               }
> > +       if (ret) {
> > +               perror("Multi-cmd ioctl");
> > +               /* In case multi-cmd ioctl failed before exiting from f=
fu mode */
> > +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> > +               goto out;
> > +       }
> >
> > -               ret =3D read_extcsd(dev_fd, ext_csd);
> > -               if (ret) {
> > -                       fprintf(stderr, "Could not read EXT_CSD from %s=
\n", device);
> > -                       goto out;
> > -               }
> > +       ret =3D read_extcsd(dev_fd, ext_csd);
> > +       if (ret) {
> > +               fprintf(stderr, "Could not read EXT_CSD from %s\n", dev=
ice);
> > +               goto out;
> > +       }
> >
> > -               /* Test if we need to restart the download */
> > -               sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> > -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] <=
< 8 |
> > -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] <=
< 16 |
> > -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] <=
< 24;
> > -               /* By spec, host should re-start download from the firs=
t sector if
> > sect_done is 0 */
> > -               if (sect_done =3D=3D 0) {
> > -                       if (retry > 0) {
> > -                               retry--;
> > -                               fprintf(stderr, "Programming failed. Re=
trying... (%d)\n",
> > retry);
> > -                               goto do_retry;
> > -                       }
> > -                       fprintf(stderr, "Programming failed! Aborting..=
.\n");
> > -                       goto out;
> > -               } else {
> > -                       fprintf(stderr, "Programmed %d/%jd bytes\r", se=
ct_done *
> > sect_size, (intmax_t)fw_size);
> > +       /* Test if we need to restart the download */
> > +       sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> > +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
> > +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
> > +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
> > +       /* By spec, host should re-start download from the first=20
> > + sector if
> > sect_done is 0 */
> > +       if (sect_done =3D=3D 0) {
> > +               if (retry > 0) {
> > +                       retry--;
> > +                       fprintf(stderr, "Programming failed. Retrying..=
. (%d)\n", retry);
> > +                       goto do_retry;
> >                 }
> > +               fprintf(stderr, "Programming failed! Aborting...\n");
> > +               goto out;
> >         }
> >
> >         if ((sect_done * sect_size) =3D=3D fw_size) {
