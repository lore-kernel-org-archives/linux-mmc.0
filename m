Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010065.outbound.protection.outlook.com [52.101.228.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75491EEA8;
	Mon, 24 Feb 2025 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740373666; cv=fail; b=qQvIdsc9JSakm6bYXAS83gzCBqMsSYX9cz8DfnPoXkasWsRjQVEFsZno54WSNSEeNLd6A0+XnFdckCpg58tv+z6EPSiVHjWt8Wn/E3aiUXoprwszp6N63tMiD1Zd9jI+kpd5qo/5KnEQUPDChZNvkZksn68m8zpfz5eYbIHrP0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740373666; c=relaxed/simple;
	bh=l8AzIneFu0cOU36jfFZj23YyKBedwHAMIAB94VNeYKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EBiBHKkm8aJ5xkp3Q+aADwViD3DGftqNDMkePl9XO+fGW5cBQFCbcDr7QlaqT9C9hLnlzYniEPj+bq6TnqrfI5qFdW8ftNw6k91TuNhlT0JH1tT+02EE8gj3Be6oHNAx0fB44gK8+3gvCP5WKBXdYcsSwyuZQE3pt+sbcB5G8dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=cZ2mZUFk; arc=fail smtp.client-ip=52.101.228.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="cZ2mZUFk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/TMVLOnyCFhi2NDA/IDMYQ7Z+LdBD8lsbKUwGD5XNsPpOS6UuTT4/cZRxZMoBhZJNGB5yxno/nUfvnSOQiG/Yq0ACuu/wy4xEpzI90tsvlXGCKHhIha9rkuqAPCRkp5ludeTtwRN0Zfros4FK2WCRnV8NXc3v336lnhZWmMSzkUI55ZTxinfNRR8XhQqM9l2xSffXE/EoYVnwIAsVZQjWIybwtDPf+88zNZnKzJ8z0mcMtDp7SFhK6N5x14lsySwUQVuaHHJvZdIwdW3o8Pu9v91o9uT3hSvShOB43UjlM44wHl51i9UaWBNKLc/70gP4Ruextz8mxJRtQ6aVe75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2Du/2c4TQYGWxfWU5QFKK/mluObJVC7n2K0rL/3WvU=;
 b=DHjfbLcGrohHEI5wp5Q1+lTPEesfit+cCxrhTEzZ+Jbj/lu5xnceM40o1QKRbiHpxcdnFuaKlvbwyvjysd/4Ybm2JIRRh+P6xm8I9ZARPLkxj50w1mivjE/zJCs1UiF6YK432l/omC4/Z6p1QwfshJB80n4JcV2230JTL4ZcRUIYn92sbu13ZqBUbyYP00U0x1ptF4XenhlHVNgUlMD6cVe0HfszIQq6fKBJRRzQ8TJhpZX/DbNAVIhm/xBH2iGwezyahmE66ORfxpNBtoTx9ni8S11x/+YHizJV+MS7gyee/9UACM4pTCicbA/5Tn5CKvOZipjHReiztEPm2kwx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2Du/2c4TQYGWxfWU5QFKK/mluObJVC7n2K0rL/3WvU=;
 b=cZ2mZUFkzk/qefhe6sjItE5dtjMsdFXGRKLlrw3FQJmXi7XaQXu7+NGgCcevtNcmyJpAsBDgH9Bfl/VgiEBHT3OWrB7bLpXDi3Th8fdfJbPNfGa2EmCj+XZDrif0wMPqy8OlSoqy6ioikZ4aLpHeEVWhkH1eq7wsq+I6wt+hesc=
Received: from OS3PR01MB9577.jpnprd01.prod.outlook.com (2603:1096:604:1ca::14)
 by TY4PR01MB14512.jpnprd01.prod.outlook.com (2603:1096:405:236::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 05:07:38 +0000
Received: from OS3PR01MB9577.jpnprd01.prod.outlook.com
 ([fe80::4855:7449:84e7:9dba]) by OS3PR01MB9577.jpnprd01.prod.outlook.com
 ([fe80::4855:7449:84e7:9dba%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 05:07:34 +0000
From: Guan Wang <guan.wang.jy@renesas.com>
To: Guan Wang <guan.wang.jy@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Avri Altman <avri.altman@wdc.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Jens
 Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: block: add reset workaround for partition switch
 failures
Thread-Topic: [PATCH] mmc: block: add reset workaround for partition switch
 failures
Thread-Index: AQHbhnj+ymQtGXVrfECCNmxi9v9UvbNV5MUAgAAB5dA=
Date: Mon, 24 Feb 2025 05:07:34 +0000
Message-ID:
 <OS3PR01MB9577E9CAA7A75AECA4234CF5D9C02@OS3PR01MB9577.jpnprd01.prod.outlook.com>
References: <20250224045918.3321394-1-guan.wang.jy@renesas.com>
 <20250224045918.3321394-2-guan.wang.jy@renesas.com>
In-Reply-To: <20250224045918.3321394-2-guan.wang.jy@renesas.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9577:EE_|TY4PR01MB14512:EE_
x-ms-office365-filtering-correlation-id: 7e8ac7fa-cbf1-4277-99b0-08dd549125fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TWbNSJPr3FWkHlSHmFDmfm9D1OCOw++ksx2wMCQhWx64ZgNwBgTmRMud0t3Z?=
 =?us-ascii?Q?BLVk8jRb7ccAbDlAnt5Qh84HpWkW0OizUuuKP9htGUs4bteRa3JmjmBIibp9?=
 =?us-ascii?Q?nyvt3eiRaiJvfcsDAPFMf5fNO6Y5FOf2Nn75lxcFi9zvoK7TTad0yhLCe3ps?=
 =?us-ascii?Q?Ma215pR1ryhLDUJPi3jH1RmHuuVPLbCS68ORUSGjEVU3eIyfXQ1ATVycr/mG?=
 =?us-ascii?Q?IGNBSOXJj+f5KFpsTOZei0X6LRlrBsxDggscxQ0QcFxYi1+P/jBJltUYOnSm?=
 =?us-ascii?Q?lKUk97WAkrlCYiJLIkb0zaaUtToX2wsCeYn76R6WSTpgYcAvRaxTg7mjbMK+?=
 =?us-ascii?Q?lUlDFxj79KOoRPj6awWPw1w5RKJN/NuBtYhQeAeSv6Cg7nfbExzlst5LGOXD?=
 =?us-ascii?Q?UPpYCrotux42GBaXPxYjsELe6qh9u3CLvyDfA3du+41SCUrOFX52SsTasTwJ?=
 =?us-ascii?Q?o66WPnMxM9p+wtMjgTMq/NZiy0C/6/JF6A9KOKB2DyM6n6GbZTU5GznNY2o6?=
 =?us-ascii?Q?qy1Tv2fV+b8Ql9jqzY3BCJRE9TWvm8EV9uHXkpdDHeYYi1DBC9nAgpv35Wy5?=
 =?us-ascii?Q?D4MWAYblO+XyP9vArciOhA19ssqQnsggHGHiAKjnR/gFaErRA0prAn3KI86X?=
 =?us-ascii?Q?IjNLj6/P7O/E3KKgbFNbojwP+WUjhgIkg0tJxMpLXAGyzE/dbNkjRLzdx3Bm?=
 =?us-ascii?Q?cBND9ke0hEOB0hhxcoUHQ1rkt46bVT7tzc+9q+f/aAjPUdLfujSV2efIhb8v?=
 =?us-ascii?Q?0ssYps/FRn35TzgC8N1Ld0pqG4lRipwM7GjGGKx6xJlSQzOxH6NrcXs1UPPj?=
 =?us-ascii?Q?ZjE0xsCS8U9I+JOhommBZzBj76ArSJ7jMGVKke3hh/R9L6bkVkw6+SsWmY6W?=
 =?us-ascii?Q?C3K+bfUMn+kDMMik/MtzU2W2FFIo+PdFJrR+uG+3KSY3uagU9ZU+CbWBsNRC?=
 =?us-ascii?Q?1Kw2btqhoxWEpdi+727Uyux0DXPtwKH3MpOefGNqJ3oaKc9+61a6mtE3jDJF?=
 =?us-ascii?Q?ODCkQo9ryTgvg+0XQLBiVDnMah43IYTa0JRCb6tAUI9ea85j7Rbnyp0Yj5NG?=
 =?us-ascii?Q?g9FSAkLi2sc1HpLk7SzEPL0uFQqnu8LbIfaCBk/9at3wOp6FtQoJBS3qaPXA?=
 =?us-ascii?Q?6RgkaeB3qwgAKOUJRCsTXlSS1sGP+WQDmFtXymx87uwfiDBiA/2xNomum5LR?=
 =?us-ascii?Q?Ld6lotlM+W5TlnnLvPz874AtX13FAngL1tojBzNBzCynVKUAF/oxE08bRzCt?=
 =?us-ascii?Q?AQ73mGXvc+VJKXdMdVBPnRvUbbFTzrOfcTqGI4Vi+4ySawF/Obr+y6tFdDiV?=
 =?us-ascii?Q?K38ot/7LYSo6rHJnPuLJ9uSgMoNfTDhj9F+cd2NrpTT7jJlit+UDiA1Pk6CI?=
 =?us-ascii?Q?uK8ATgVT3QBZZ+5NOrxCTbgLrT6v9sr8fp+MYN16KxL+18Q6KZSrKXH3YgXh?=
 =?us-ascii?Q?IvebXAk1T3Za2RfNLFO8TKTjzgjhIJma?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9577.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cZ3xCJyM8Pu8HnyycgngJQ5E+lRgRZgW/xn9A5WpLLt6kL6SuFDCahn3bqje?=
 =?us-ascii?Q?QMldccyz/MMqnU5n8JAt6l2pV4FacTjOdC7wn9pc2d5pbBY39FzOFLcW49qg?=
 =?us-ascii?Q?wFi3dDVD8439KpAB8HYrgQKRnxhUsQ/orv5H2a4icVQ2qikD97mSKA9Ablo5?=
 =?us-ascii?Q?EWaKGK6l0oN6173us4/8Rix+IJRRkcMkQl6mJYpJD1S2F0maLfTQxm4g5fFe?=
 =?us-ascii?Q?6nBXmoMUYsdZu8kM5Qp45LcvuDhdiJbgAYpVl8TE/pQ+UScqkPtxNajxJAbt?=
 =?us-ascii?Q?OfveMoNKzAlZFS5vRNn1JBkyttAKi0Len7ZOdPPFW3b6eRSMbQDeKa+aHXC9?=
 =?us-ascii?Q?OHUA6NWPpQZoFUBrx93C9HlIFHPy+C3aXfypaJ1eiYMICxmtpLZDAaPQU6kF?=
 =?us-ascii?Q?fLuBw3vkEST/abz/54EFbXF2N7E/K+atwVkWZ+4m2/mFN7ORxsmJhi6K/nez?=
 =?us-ascii?Q?h7Ld3FFYKCLRyNLwIcrGKyu+lOftSCzI3NS5m+xGREtEE210C4In1TJnJjT0?=
 =?us-ascii?Q?MXCOPwvX9hqNlrIcJ929bcvYSMvEAfyApPomswwas71dnoQlf+NfHEPWJKpB?=
 =?us-ascii?Q?Il09xmxk5+dTSGfABLcQvmM78D+El45xDMdYBtbeX1DKt3E5M9FJDriWptP0?=
 =?us-ascii?Q?vocKH/k/5svyMjKhd5sKMiradcuB7ZDGTAzJ8fzfRIzgiUfiHLJqeDYWWiYL?=
 =?us-ascii?Q?pVPx1el/hDSeR2ZsdXki+9dyS0XLtlMUkO7ET20IE3QVUCoU5cF7NBbreeGj?=
 =?us-ascii?Q?3iYkszpqlPuewUxwYfzTlijct1eUUqIJ1GkuJ44fjM9S9HZkHzVP9cE7D4yN?=
 =?us-ascii?Q?5Ivx7/DMPpN4FoZmsBIt89mtOIoIYV5674OwBOUgpGiE6F5cH2Cr9UaVD7jO?=
 =?us-ascii?Q?UCldhVDmVJJs1zY/zOQ4S1kpaBWvrhswUto0wi5My9HOtmxv9ekp5SKi6bSO?=
 =?us-ascii?Q?J3h0zCukXJmT46QTSwBiubnhRRT1t+A29OcMzzwWX7ESRzR1lqs1rrtTBzqv?=
 =?us-ascii?Q?zS6PYf2F42AV1mCZwtO0Rq4zjL3ZVZDAypyuf4FjKi+STVJZGMN5WVinzefw?=
 =?us-ascii?Q?t7bA6zPzw+FBXZvlzBl2To5IOEQq6C2KMFbT+az6r86c2gKQDsoGlLAWITsh?=
 =?us-ascii?Q?89Ydr9MWvd/LeFLCBwVS9YYNn56a7D/kP7s3997NqL2/OTXJma4r3H3kYGss?=
 =?us-ascii?Q?43UAoFwVsj1wJ3TTje+TRgLD/Vb06bSEX3fX0MpFmo4BA6TKNFawrjnYskxJ?=
 =?us-ascii?Q?a6TbAX0IicjkuG2F/8cVRkKfvZHrqYDHi934CNO8/h+4PNziftl/5q+hkux4?=
 =?us-ascii?Q?VvyiB0XLWPBVsxqtfWdP8EWoHeAugwI1RV9kTbO98JbdjEXSFvlNYnywneWH?=
 =?us-ascii?Q?gHj2IyH9FOWTtLinH2NgfvMHD95K2x9kiffQSz+lfCwUyomVsXhZHtXBZbOA?=
 =?us-ascii?Q?HcEvXhOwlk2mby+LVnfFayLdZxf2+Mjm4J+0ZmBdawWnXBt/TVgG3eSzH0Np?=
 =?us-ascii?Q?LUC5dw0VCKBCs0ktRmy3nL1/Of00ioq0Xgs1ahx7u8yNPckjZQwQsqYIranC?=
 =?us-ascii?Q?gyWbibKcDhwMluMZyLefi2CgVwyW+50+AHR9Zs8F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9577.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8ac7fa-cbf1-4277-99b0-08dd549125fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 05:07:34.0458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIrTPeg5dGuf5CpaoOl3lt1PL5MoFLolXzeeeHSanokV2ZRzHrfPN7bVCREMaQk7is2wQM+dw4+NSnHRjGf2+tIUiWL18xxKeX1nVCI+2V0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14512

Dear all,
I apologize for the duplicate email sent earlier.
Please disregard the second email

Best Regards,
Guan Wang

-----Original Message-----
From: Guan Wang <guan.wang.jy@gmail.com>=20
Sent: Monday, February 24, 2025 12:59 PM
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Avri Altman <avri.altman@wdc.com>; Adrian Hunter <adrian.hunter@intel.c=
om>; Linus Walleij <linus.walleij@linaro.org>; Jens Axboe <axboe@kernel.dk>=
; Guan Wang <guan.wang.jy@renesas.com>; linux-mmc@vger.kernel.org; linux-ke=
rnel@vger.kernel.org
Subject: [PATCH] mmc: block: add reset workaround for partition switch fail=
ures

Some eMMC devices (e.g., BGSD4R and AIM20F) may enter an unresponsive state
after encountering CRC errors during RPMB writes (CMD25). This prevents the
device from switching back to the main partition via CMD6, blocking further
I/O operations.

The root cause is suspected to be a firmware/hardware issue in specific
eMMC models. A workaround is to perform a hardware reset via mmc_hw_reset()
when the partition switch fails, followed by a retry.

Add a workaround that:
1. If initial partition switch fails after rpmb access
2. Performs mmc card reset using mmc_hw_reset()
3. Retries switching to main partition
This helps resolve cases where the device becomes unresponsive after
RPMB operations.

Signed-off-by: Guan Wang <guan.wang.jy@renesas.com>
---
 drivers/mmc/core/block.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4830628510e6..29388786624c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1174,8 +1174,24 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *m=
q, struct request *req)
 				break;
 		}
 		/* Always switch back to main area after RPMB access */
-		if (rpmb_ioctl)
-			mmc_blk_part_switch(card, 0);
+		if (rpmb_ioctl) {
+			if (mmc_blk_part_switch(card, 0)) {
+				pr_warn("%s: failed to switch back to main area, will reset and switch=
 again\n",
+						md->disk->disk_name);
+
+				/*
+				 * Reset eMMC device if partition switch fails.
+				 * Some eMMC devices may get stuck by write CRC error in RPMB,
+				 * preventing switch back to main partition. This workaround
+				 * helps recover from this error state.
+				 */
+				mmc_hw_reset(card);
+
+				if (mmc_blk_part_switch(card, 0))
+					pr_err("%s: failed to switch back to main area even after reset\n",
+						   md->disk->disk_name);
+			}
+		}
 		else if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			mmc_cmdq_enable(card);
 		break;
--=20
2.25.1

