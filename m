Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1445113AA26
	for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119676; cv=fail; b=Y6UOI/iGT+wF0mpSC4aOaieCx+7ki3cdIueJoyqONTRAycRASdNe2vGTUPnP0xXwyrNInYQrF+Mq1rrvNdbSS9rjYJJpl9mZTlSEuappgr7BiZKQhdZ8j0dwKZ0+JVY5LlV0Y+WEhVbrjzWIvRCIs6Ajm6AgiYt4U+zbxpMWtxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119676; c=relaxed/simple;
	bh=TQaq5IjtkrnUnuKjhVwOQE5Uy3X9C+mNOURnHkff9hg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jgtjIi1laIoLkeu52RAfXb2GH+FbFk+rrZsBDeb2Iz0uYr+kAiTVcjdOJee30VagvuczVZgjm4XXhP239TxOrOyCWE6N0C9TYJal+hAjOl2W0RR645j89tGjYMH/ifOmVj90839hXgDnAiJWoSAneN5wgx/BLD7QH9lo9OCBjI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=kyULaC8t; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="kyULaC8t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHIV243m5FplRf5w70KgcyFFx6yj3PAXGlFrZVBlh/FjxtEKs/rFI9wKle6nG2pW+mXe41oe1EZ4+3/F8TTDr17Yrsgqh+OHVXZePFU+rbKwsV7oDuPSDzO2lLtT4VR6synznx7eQStV+epUHk49S11avSAVj3VDs2ulZ14LInSnCI3Gq9vDex7GCpGupwz3JcdwvxB5tHlnHzyteF0bM/WwUvZuN0/M/9nwtbRRd19wW1QB7aP4utgBzwfAh/FOXJyybrYr6Faz6qPZz1qtvCogoR1sPOQz64M2Ei911FTCcgViokapqq8oShffzYWEz15MF2JVRx/lCJ7GapTLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je72NoH2MYrj1CULq+RyRevXWapoNrVvs7QTmuKmWyo=;
 b=cnXuakhRe2lk0uvbqHudRU4W4XrHFL0j1TRiKlT2YpEIFnj8XeFTHLplFlBLfufH4km61uEuwmkO/SmMHyUiCWY5tfBBWGMGHquw56jCjfPxeMvBRcLCYGFXzs5EGSAxMoOt2B+3AEQLUY9LXEvlcAdiHqMgWbPbcdTBVpAg1vxH3v8TFfFce+vXvdn7asidTc5bWecMWfBI+4KJAQSsvgri/H+np0IX8MM+dZuvwIeA2iL7oyqnAVVNeN89hxK1+k5IM4hNMIL1CjtCyBawdoRkUofYI4+x8VZZ4OfIv62xQ3aB4Z0nGaLA6culvRYCSTpjosy975mvQXbSJgYV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je72NoH2MYrj1CULq+RyRevXWapoNrVvs7QTmuKmWyo=;
 b=kyULaC8tFilBnSn2CHhMyMZyJEGtEtkq4sU6mjP70UchrZszYf2hkEIbcF3lSRbwXb/iLV4KPmyRVXCDvNuKs+ETMeRijZcN/tAV/H5C5BlViQwv8yEbEchDBtEtjegc4gYUvMDBhxp0nrza/POExFA+q62DevGEh6VntZRhhS3YHXStjxcN1vq+RRPWhpYHtrmbs9bDW0xqC47O/0CS18Z+QeLjegGc4kAf12+3zW9xARE19am8lNcAoWzwAJqwNaCwOZuFdqLf3cRgghL7K2RVUZydD/eDsTwbKiT8C5ieos3CvxSSByHvGTGDonGcvHmDtLHd+BbosCBinNDqmQ==
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by SA2PR08MB6460.namprd08.prod.outlook.com (2603:10b6:806:119::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 16:21:10 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36%3]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 16:21:10 +0000
From: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: MMC card detection may trip watchdog if card powered off
Thread-Topic: MMC card detection may trip watchdog if card powered off
Thread-Index: Ads7Zw4syJtxBkzjQFCdin/8++ZdRQ==
Date: Wed, 20 Nov 2024 16:21:10 +0000
Message-ID:
 <BN0PR08MB695133000AF116F04C3A9FFE83212@BN0PR08MB6951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR08MB6951:EE_|SA2PR08MB6460:EE_
x-ms-office365-filtering-correlation-id: 5c9400ce-6c04-488f-c054-08dd097f5831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kPmU4DaNucJVogQoWzZyfxGdmjmMReKLqYVJZZFvYvSubLqb/YM8BbAfwpUw?=
 =?us-ascii?Q?Vw3sq/11Ki+HdFdqramDRfNTy3Qglc7/KQBTbK0mZw3SsPiYXapqQZT3SEmq?=
 =?us-ascii?Q?gSX+il10fXmAm6Wao0CnUYRB5t8PdCgshAhDnxZQ6ieUUqbG5R9POR20ZtFL?=
 =?us-ascii?Q?Y+zEeeKHJ13tiVjAvyXGDEuARpJX6/2ySkvJad2HSThLF4wcmrG5J7lOp9hA?=
 =?us-ascii?Q?0mU3HwSkQ4MPTrYajhe1/ktAmIZWNGY58xDBjZeCXCPfwLwI5D/nWo3ru9fg?=
 =?us-ascii?Q?dy0rbGpRcW+6K4pd5YVOM0M50V/upBvMkS4rC39Hd/6NgZegf+SMJwlf9P6C?=
 =?us-ascii?Q?CcDjbYLyYvzprjYMBBotrrDEinBxUdZr5r/HLfKV93a6KHomysuopfwGxrR4?=
 =?us-ascii?Q?pBn77EyO6GqDzasaTbufc1qRur0aUQeipfUPxhoYexuXUl/B6XgtlFXyYcgV?=
 =?us-ascii?Q?EudqMh2G8xLQZyzFPqR7hKqIoYN5A4J53bdLUzSNHkeqAb1msU+RMbhfaF5G?=
 =?us-ascii?Q?Wt5vD51gtdFlhv1xg26AgPiVzVydCeiydGIvIIvbYEHYnUOWb6yTy2YvGXgt?=
 =?us-ascii?Q?38Ij1Vcy6l6oR35B6hZ2wJQ+Vg0AfcUfwSBfKGuT09EzNHhZOdDUWREBXTLd?=
 =?us-ascii?Q?++RciN0F+gvRbr8gbbX5L8nWjAFWvkosCKELSpvJfmR6vA/SUy8Mb3G2qzwq?=
 =?us-ascii?Q?MPXSymMwRcUOoUtxVIhZRaKCnje8gDwDMgQb4CQTO//FUS2OAPXUBBaTgypp?=
 =?us-ascii?Q?XQs+VWx5BF8TrOZBknr/ugwFjVKIs/0Xu4BOVz2lNPGNiHfMJk0qlsab5i+V?=
 =?us-ascii?Q?udcOv2sHuCDASDlUnWiuWNJdFdgzJ52tpdK8XvVHES6AtGafnv3qerUQlIYN?=
 =?us-ascii?Q?BeahV80vhj+4fTUwGiMDYCF8eSv5gFCRoczjs+HHiSYAMDa7Us5MxEF0N5yN?=
 =?us-ascii?Q?733ykQetm1qA//Wg3yeRywIQp3JpNjHpG3ddmSVLD1gesM1X6UJNYJ9WK3sp?=
 =?us-ascii?Q?g6PCqu8QpllHoaR8jCrYEcheMCdJrPx4E5W6VXAnzK59uOXS4xqHJw2Fn6Fz?=
 =?us-ascii?Q?odU6GoRcaxRJwPPWkZ0tsnl4xCcxT3kyHcRWNEW8HVx/9vzBKH48GRnxgQd6?=
 =?us-ascii?Q?BmmWEOQQNOrOE34Xb1CbzzZUGpnsdYQDCS2SeIJYgdMALm3qIycAxZUTrPfP?=
 =?us-ascii?Q?IlHWD0JoLnORuOCZRtdsNDosk5s3RV1ubdhwhRqGB+v3OYxyT6ccI20oZiGM?=
 =?us-ascii?Q?NEl9TPTZi1byeOmLY+TKSFubqq1ohQCN51FfYac892rnrcbkDDbkSJE9MtB9?=
 =?us-ascii?Q?RG27ioah/nvJen2ktyHJmVzzm8L/XVkXN+DsMC+ro7Bd4B/GvX0YkZBpP3wC?=
 =?us-ascii?Q?WEaV7g0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0eUq36g0sUBnC98mTdA0pea3Dmo+opE6ciOcfNoD4Ltn0woL1hWfJhcreSWj?=
 =?us-ascii?Q?VmW8PbByyZKSK6WA+JKovTQ+XAJu7j4JCpMtDfOZ36kAxooJ23xtII6a2c1c?=
 =?us-ascii?Q?BAWpp9WmR90N5vJx/BJl7cONn9kpiAmvSxM00nyZENSCXdJVMV1mUQHvc8Hk?=
 =?us-ascii?Q?ihuJmbyhP5X8JC028HeqcOcHyzrYlMCexgmubrZI0BmMslrQChN7w6IL6Uu1?=
 =?us-ascii?Q?y1tv3IXv4CrZU+RQkfi1R0htZnpxRA5D8KxM2lVBZcqfcKr5wxAPd6DKa0aW?=
 =?us-ascii?Q?vrxYrOJPxrSpHrWOEtvvxtLAtA54WPNx3f8Ox3tbjnsFohKqo7uLLU8i7zHU?=
 =?us-ascii?Q?GvmDfL2E+EwrisUcmmI6whlDjn7EZRSqnLDObryPitaU1OYHm5NORIK8iP1+?=
 =?us-ascii?Q?RaEEOe8kr/p5q8MDmLg9tBQNfvFr5jMFfU3YSPBNE7dZKp83DqOZ9ybPcu5l?=
 =?us-ascii?Q?lxkmJ/bwP5NOaJa8T+D8QTHLpFZESkQCI9r1Ddjb6tpgqbWfpd5SMxwXIrbg?=
 =?us-ascii?Q?BjKXoYlTC9VauqoOuRmsxqlO1wdnXDt1o1Z4LxBXDQ08GmJx6KCoQlMQIqsn?=
 =?us-ascii?Q?adEJMcCQbSXVp9hBJX8ndv8oZpM6yJAKyEyacxx1gfOvKqnmbYNLgUEZrB9C?=
 =?us-ascii?Q?8nRQhifO922rsrGG15mXvmuA2K9O9yr437naCgWrdji60q6mRwph9o2KZCqL?=
 =?us-ascii?Q?yzmx2asK0BEqDNsD3RUsKVn1MWoNbxWZ8qxT42I724hqHbVq1uT+lRMfZRid?=
 =?us-ascii?Q?TGEK3zFaK7NK3d0VQ0gy97jksNxV1KKNpYhaUIqT9u/2ujGTq0cJy1KMORZn?=
 =?us-ascii?Q?0RaIZX/rqmyUXJcjenexoHfZwfRrApYEnPReKtX/LSPiYdDGesmw+oiHDUxQ?=
 =?us-ascii?Q?4fnR2HCQ2K/YVlxkS0apqTMVFbuiKw92cfWuKxe+rJ82zYps2YY2VFoYgLPD?=
 =?us-ascii?Q?zGf2xjM3yEA1DGLWqGZ9qS6VwMO5r7aJjI8Q9SBUnlHr9UCPKfbPHtVkfYz8?=
 =?us-ascii?Q?Sq9kmFt7jn/PonaVqFZ66uUGLhqMPbxtAVyLavD7gn6to84001wS1pHHdj36?=
 =?us-ascii?Q?MwMNbtt00IcIg8bhZMBl+a4f52ZmXYBnh+Y/FvJBOEeOEtcdkj6WSXfmSbrJ?=
 =?us-ascii?Q?dVp9sCOfNKi5dB+9p68+B1LpF8tBiiWDcz8wBiqWJSMcPn9rA1sGJwwpEiRp?=
 =?us-ascii?Q?zBS+w72VrpY6bRm++LZyo1VgGrXodUCNBMcO/J3qIHUpwsL+HrWVpy/bcz8a?=
 =?us-ascii?Q?ghC0GQGC3vxinG6f0YUUXutn4JRUq+J2XLnUmb2cZPNO/XzOYlnN6PKJQaWF?=
 =?us-ascii?Q?NL06ihzPv5vQFxqyqWictt3750V04GqiWGzZDMkVrMkslf2dyIsf3hOVWkp7?=
 =?us-ascii?Q?ZxluxcTrLH3K2Av6W2ta+Pr2Zvlo+L4Cms1CQJQ/EMvRtEST11YsLKtUvdSS?=
 =?us-ascii?Q?NS1ChGLAMjuZYumR33uRg7fj5iFS23fuj1fwShdgQUa0+dhpquPND3uVP7Jg?=
 =?us-ascii?Q?Q4filVvzE7p28NWH27Oh1UBAOgAYQOaOdMUkklgs2ZvJSG9XVfyhfWpwvnbH?=
 =?us-ascii?Q?MgC6v0Fy4xNwwyIvffBUvNsyV1zVQpDQioBvVz6S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9400ce-6c04-488f-c054-08dd097f5831
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 16:21:10.1436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBzZ5e/7z5Ss06P+/JjbJwrRXP13AEhqLplbZ278LpORSLTtlCzJ24jUaK1u9mbpj1BMUyKyRWtkDIqo1D+HaaD6Ec/va2tGymc3KqhEHfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6460

If card detection is done via polling, due to broken-cd (Freescale LX2160, =
etc.), or for other reasons, then the card will be polled asynchronously an=
d periodically.

If that polling happens after the card has been put in powered off state (i=
.e. during system shutdown/reboot), then the polling times out. That timeou=
t is of a long duration (10s). And it is repeated multiple times (x3). And =
that is all done after the watchdogd has been disabled, meaning that system=
 watchdogs are not being kicked.

If the MMC polling exceeds the watchdog trip time, then the system will be =
ungraciously reset. Or in the case of a pretimeout capable watchdog, the pr=
etimeout will trip unnecessarily.

    [   46.872767] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg 03220301 f=
lags 0000049d
    [   46.880258] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00000001
    [   46.886082] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00000002
    [   46.891906] mmc_request_done:187: mmc1: req done (CMD6): 0: 00000800=
 00000000 00000000 00000000
    [   46.900606] mmc_set_ios:892: mmc1: clock 0Hz busmode 2 powermode 0 c=
s 0 Vdd 0 width 1 timing 0
    [   46.914934] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg 00010000 =
flags 00000195
    [   57.433351] mmc1: Timeout waiting for hardware cmd interrupt.
    ...
    [   71.031911] [Redacted] 2030000.i2c:[Redacted]@41:watchdog: Watchdog =
interrupt received!
    [   71.039737] Kernel panic - not syncing: watchdog pretimeout event
    [   71.045820] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O    =
   6.6.59 #1
    [   71.053207] Hardware name: [Redacted]
    [   71.059897] Call trace:
    [   71.062332]  dump_backtrace+0x9c/0x128
    ...

CMD6 is SWITCH_FUNC and arg 03220301 is POWER_OFF_NOTIFICATION (bits 16:23 =
=3D 0x22 =3D 34).
CMD13 is SEND_STATUS, and when it occurs after the POWER_OFF_NOTIFICATION (=
as above) bad things happen.

I have made the following change to attempt to work around the issue, and i=
t seems to hold up, but is also quite brute force:

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2046,6 +2046,11 @@ static void mmc_remove(struct mmc_host *host)
  */
 static int mmc_alive(struct mmc_host *host)
 {
+	if (host->card && mmc_card_suspended(host->card)) {
+		pr_err("%s: Skip card detection: Card suspended\n",
+		       mmc_hostname(host));
+		return -ENOMEDIUM;
+	}
 	return mmc_send_status(host->card, NULL);
 }

Anthony

