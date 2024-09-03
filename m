Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3225200137
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350434; cv=fail; b=JQyQSVEkuddhZgv3Cl1fmvOEobHmx6h5vofVF8m+Nr8vLInRYY9CnuB3Lsd70ge9QOxt8UxcjNwyx5WwTfeV+wTPq7wswWVgOb3+qtzVay3+6DSRX223mySyPo3/+pwwVxm+Vjdqz3uu0nwIDetES27dnnMWkAHn89oq32WSzGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350434; c=relaxed/simple;
	bh=GqM1HqMWUI8TzYNGKDOFmQxE34PrQvpBI8jSbAocTSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RTqrt3bV4FdUdcr42iBFTlQSBVfmyE2NkkGmpQXPJrjbDGUy2YR0MYcn3YSg80aTP80j0G88oYPGgKaMN3UjPKDC94qoMlwQkvz7E77dfg14pZmF3wzDbh/nrq0JNMRSIehwjZvoTr3t3Jjkiq1Wk5P0oZXYbFVsTtazGS2vwoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UBLP23QR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sHgqW/Bc; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UBLP23QR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sHgqW/Bc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725350432; x=1756886432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GqM1HqMWUI8TzYNGKDOFmQxE34PrQvpBI8jSbAocTSc=;
  b=UBLP23QRbhsxTUxYk/KTOXAHJLbmSONpM4kGM/ifMFM5CVXPYatxlYAX
   uGuHfL+LMdEkIe3yGt8mtP0YILxuWawACoVamFEbafrvmPvevYI/sk2O8
   8hrh+JskLlby1Zl8SCztH1cK1GuzWk4cPlTvyp1KUAw1zzIahg+n8b+0Y
   +x+oIWSk2Us6aoqt63fIauy22jTNZ2sbTrJktFvpXwOfMo7PbQA8XtBpJ
   Wh7fKwR+pIkl8Va2LWK58TXCEKzBK4GFM1pgYaBMaMvb+t4DHxAzeiBoY
   O+aBvmsGbtlRHTiAbuPJfnw1F294iW8sEDjs4g/fIPU0PGjHn/NyQudLg
   Q==;
X-CSE-ConnectionGUID: UugM9KLWR2K/VAui1hpCYQ==
X-CSE-MsgGUID: HGRZM5ZtRQS/2jrrBvKV3Q==
X-IronPort-AV: E=Sophos;i="6.10,198,1719849600"; 
   d="scan'208";a="26591723"
Received: from mail-eastus2azlp17011028.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.28])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2024 16:00:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGfkyritLHqOq5bwjht69m+eDj1IG/Neww/SK/hDTbHBQNuRRF8+mBv/7xYX6R6OD7T4CioJFlGgz8EdLXbJHAKP2wvwf8STDaA0Jd+z9+z0u0pv98DwBoET6TNrM56ax+xevFJyOwe6YAR+mkDCBk1zwftUVp3yr8p7tMgVNEv28YUoWzfezXBpsSKvB4D9wiQ3498I2GyMXSIjaXQNhiMZeWp1EThhVylP73N7HT+mFRK8BSZe1vuIrWJueTTACJGZ9BQQGzfX2yz/GAujhYFEoZTn2wV/l8Ek9x/CuYEmQzCyKKafygBErXHtHJbcE3f9crNPtiSHE7PHzO+Apg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqM1HqMWUI8TzYNGKDOFmQxE34PrQvpBI8jSbAocTSc=;
 b=aayXCEuvLwQ6OhZtlm7iiTx8qqZi2nR0NLwBtD0Ieq/IVzhnecqx328BDveQ62Gtgq1+LUynQd6Xe8MW8PotqZjRcZkkQVsv5v1ybHBpWC25CErh966zQPq2RzzrOYz9L0TwU99GnrlsCnhWo40TMSVEwvwFexlFRpTX20ic+eC74Wwv0sR/4OQo/h7GB+chs8ZLqV85p/h+MoPteuYGPWOG3iKaRdU/PMIlSBhBKznvhU1P+lKUj3huPVIh3W4oGCOinaIW4vYwgk0GMmd64GZv/LiGcUpbJO2JW2q+EzvUgCDXdhix08DQzI6IhCmWIo2JJnnzijcXCpfkc1R0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqM1HqMWUI8TzYNGKDOFmQxE34PrQvpBI8jSbAocTSc=;
 b=sHgqW/BcoApJLGkf5rA4FLydVP/3FEHoybTf3I0yiPZVZW72mGkKwRGtc2p1SIkAVnRon3/Ru4WgOLBEgMm7jDCMKzUo2d+55A8UikeR/cfURVLS4HQHv1n5fg0LmtDSqBpvrVh65sWAdDV0Z6qA27XuZzRpfmlYObbj8OzysSU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7191.namprd04.prod.outlook.com (2603:10b6:510:1c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Tue, 3 Sep 2024 08:00:22 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:00:21 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v5 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Topic: [PATCH v5 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Index: AQHa+HxAmR+nx/fkjE+azv7SJpSWG7JFilMAgAAxt5A=
Date: Tue, 3 Sep 2024 08:00:21 +0000
Message-ID:
 <DM6PR04MB657547F546A2FF09FF839176FC932@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240827122342.3314173-1-avri.altman@wdc.com>
 <20240827122342.3314173-4-avri.altman@wdc.com>
 <8c040805-e3cf-43d3-b806-206c3147052c@intel.com>
In-Reply-To: <8c040805-e3cf-43d3-b806-206c3147052c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7191:EE_
x-ms-office365-filtering-correlation-id: f681ad5f-8b8a-48b9-5379-08dccbee75b9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDFkbXB2RlVmMWdWWU5IU1k1eVczTzJsU3d2T3pnK3Z1UkpWNTFaZFo4azhp?=
 =?utf-8?B?Q0IrSkJoZWJ1M3RVbDVJRlJjdk5DYjdVUkl0eGJTMS9vV3IyMHRCVHg4YUkw?=
 =?utf-8?B?a0t4Smt1bjZjSmprWEtYUVRwUUVsSkc4Sy9Pa3FRMWNLb0NNQzZZeWxwc0Z6?=
 =?utf-8?B?MDNvSTlYVUF6amw2V2ZFditiMTVJcWdoOGJTaXA2cmd6UWFKUXFLeDk3YUR1?=
 =?utf-8?B?Y0x1cXZORnVIcnMxL3ZFdm1MQ3lQWmV6YlhCblZ0SU5qczhCbjhkUGdFVnJR?=
 =?utf-8?B?ZXpWRDBFd2N4SG5McGZpU1ZYV3FDak9pTHk0QU1aWCtpL0NNc2liRk9NelFp?=
 =?utf-8?B?OEpaWUZIamZxNXA3YW5GV0ZQdXduVU9DcFJia1FuOFhib3pWRUo2ZkhXY0sr?=
 =?utf-8?B?Q09ZSDhkcVFnWEVHaU91RGgwdFhUZnorbHpoU29jdnYzNkozc0JjQUpyUXlo?=
 =?utf-8?B?RTVFNnFZejViMm5XV2hnNHp6MDhKN3kxYm1SNjluZlhsSFMxQWdKM2RJUi8y?=
 =?utf-8?B?N3lLRUtmdCtiTVRWd3dVckJEeHF5YXFuaEhGVVA4YkNkRlVYY1lLYWFyRjd3?=
 =?utf-8?B?TlVySEhJc29UT1pub2Z0bEEyS3FabjhyRW9VUHhGUmhDODMzWGh3eWM5NnM5?=
 =?utf-8?B?TUFsVkpsZVpNbmNLNE1RaUxpV2RYREtMZTBQOHZ0bEk1Zlp1T3hPcGp5bEw1?=
 =?utf-8?B?S3c1ckkybHI0VzBhS3RiSjNDWWN6Qm9ralF5ZkpNTUxTRHduVzZBUEliN2JJ?=
 =?utf-8?B?Y3RQS2RHbkpyVUp5SGdwZGxzMjZGNmxpRCs1bjJJSk5ya0FROVVsMG1kSC9P?=
 =?utf-8?B?bmMyQ2xoQzZEcW1KczVTVnlWb05TYk1xeDlsWUZUTGo2bllQbG9ya01ZTUR0?=
 =?utf-8?B?SXFZMWM3WngvazhFdGk4WVhZY0N4VXFYL2F3d2pqQS9RRHRBU1plR2ZFOE4v?=
 =?utf-8?B?TnoxblRpcmRxN0FqY3BlSjhCMlVkQTYzR3dNSldJWVh3MmtoQXNzZU1ZSWpE?=
 =?utf-8?B?eXEzUnhucjNYMnYraGRWbWdCRndXM2pRSE5TYXRYQ1JzcWNzM2UzTXNKYTlO?=
 =?utf-8?B?eWJ4K21YWW5QOVNIMklqWkZoalM3bnlFWUFnaVZ2Qnc0TFlJWC95ZDExTkww?=
 =?utf-8?B?TTB5ZHd0TWVOeVZMVFYxdmxTMlpCdzlRTG50OE4wZjlQdlViRUh0NXR2akRu?=
 =?utf-8?B?bWZqR0xoa2piQXozYlhWdlJ4bTE3bnVvVnVUVUhIZWlGbllWazJVWWc0VWN1?=
 =?utf-8?B?UzkvL0c5aFhmSkxnZU1GdkJhdTlWcTFLdld6amZRZjRPY1ZueXFDUzdBSitK?=
 =?utf-8?B?MlM3R1VyUHVLb2tWVGVPZnVLUHJka0lSRXBKellwMTZ3NUlUc3ljSHg5MEhJ?=
 =?utf-8?B?UTBQQmx1MTNwMVBrVWVOVHpxRWsxQ0NrSVp4dzlNTDNWdC9IcklFVVIvS1ll?=
 =?utf-8?B?TERmbGF0Q1VDcXNSWGt6b0VoR0Y1T2pETzZJVCtKSHQ5US92K0N4UWN4TEFP?=
 =?utf-8?B?Y1dyOWxtamZDVVZrQjlNVU5zUTJkZk1rVXRPOXhFTDRDZjBGNGZNUTlKKzVi?=
 =?utf-8?B?RldnWlkxYzgzNnVJSURkZDBnOXE3dS92VGZYWnRnOFErTnRpR0E0UVFFbEY3?=
 =?utf-8?B?bFNNYTFzeGNNdXc4QjZ1VDQ1dUVVeXZQNk5IVUJHS2g3ZTdXRjNTTzNLSDJH?=
 =?utf-8?B?ZGlueTNKUnFzNkVmWldJOU9RVm1XUFAybGVGd0ZIaDYrNFJoMEtFMVk3Yk82?=
 =?utf-8?B?Z3F4SFBoS0hUbXRBZU5wRDkwV2JCR0d4L2RCQ0x5SzQ4azhmUU9VWmF1Sjli?=
 =?utf-8?B?a3NkSlFjRzF0bDBad3UzaVNpck1zM0xWVWswWitTWmdHeDdKanZld1EybVBP?=
 =?utf-8?B?N2JIRDVyWVgrOHpPUi9BS2YzaG9RVmdnc1VjNUN5UElqVHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHZWZkhLdW9mOGxhRnZHc2hLQlpQdXF2NUYvOW5hckc2N1p3eDhDU1JCTFZE?=
 =?utf-8?B?cm9SRExCR3pTaldnaWRFWG85VFVQMXMrdTRIRGtLeE1ldHhWeExXTTVtUGxC?=
 =?utf-8?B?V2NIS0ZSQzh2M0ZmL0V4dlQrTDZ6WmNHbmRUMVFTNTNCcUtWQmhYM09ZZ09C?=
 =?utf-8?B?cDJOWTkvWjk1aHNXbE92VUxZcDNpOXBtMzh5d2pvUEpGdGY5eEl4WWhaRHpt?=
 =?utf-8?B?WGwvYzlIRzkzbUFiUDhHS0NLR1crNnJvbXpibGtrSUo5SjBBT2hwZVZRQW5E?=
 =?utf-8?B?V2NTRUxaSVVaWE56VkR5OStIREZKSG9qUnd0TjR0S2Zyb2lsUkg3ZS9FZmsz?=
 =?utf-8?B?QU0vMlB1Z0hKbXNsZ3ZVNldrR3phTVUwMk1vTmY1R24zNWU4T2RwWXR1dUxS?=
 =?utf-8?B?VncxdnRReU5LbUg5eS9DUTJRQVlEenN3K0paYTdkNzZTYVhvTnRMejg2THRp?=
 =?utf-8?B?Tm5DcVpmV08wN093cE9pWFFvSXdZYjN3bDhoNVUrbzRlU1VPZStlNEpoUEg3?=
 =?utf-8?B?b3BBaGRXZDZKZ3VzNXlvRWlNSS9KdDVEdkwwL1RTR0pxQjlVcXpkY29vN3Ft?=
 =?utf-8?B?MnpDSUJUTWFybEVlWXhXZWVzZStPbmw4aHNQcm1qcmdNK3VocGJuZkJ3VTFO?=
 =?utf-8?B?dENKR2RYbEpwbjZwQ3A5Y3l1WHlaQVMxaWlFS3N6SVBWQzFJMTkrdUJuaHd0?=
 =?utf-8?B?dzNMK3pRNmhGblM0djBRQjFianA5L2d3V1hoVi9kY2QwbFcrSGRPdUZBMzNq?=
 =?utf-8?B?U1V3WmxKTnpDWFREdGJTdjNMdnVsTGVBUUh2N3pLVGQ5Zkcvb2dLS1o4bzV5?=
 =?utf-8?B?am4weWh0WGVwRkJmWlZXeTdHVUVJSVRNQndTYzFnMGJSOEQ5emxlTWZicXZ3?=
 =?utf-8?B?VE9Na2N4SGRFZ09BZ2I5SldxRGtjWTcwQ0NBdVFWdlBNQlpIbzZXMUU3cndi?=
 =?utf-8?B?Z1p2Y2RrWkV6UGViTkFiU2ladXlPVEV2WFVFNEtYU2I3dFFkYjVUaGRXMzdk?=
 =?utf-8?B?YUpRZWU5NlV1aGV0ZWZ4MTNPeEIzeVc2cC84QkludngweUNKZHZZUlFETUty?=
 =?utf-8?B?THVoNHAraGN4Vm1zQTRpdk9EMWhjRGJlRTJJMDJkSmM2RHVmdDZJVHREcFNK?=
 =?utf-8?B?Ymc1M2F0WEdvVGk3VVdMSDJWRHBRdlBrZzFOSmFpUEdEOXZEdVhzaDExaU9q?=
 =?utf-8?B?R3JxNUt4NC9VR2EwNmxpN1RDWm5raTVPK2lqeWoyWWFlOUNETTcwYXhJNFZB?=
 =?utf-8?B?UHlzOFdkYmtpOWVDaVR4WnNnWE1IN1RkajBDVDBLS3QyUysxcE5sWURjRVJY?=
 =?utf-8?B?UjJoV1h0Z0Fza1Z1K3lDUldENlgxZjBxZmpOVG1pVDlGU05DUVJDRVc0bHFa?=
 =?utf-8?B?b1ZDaTJmQU52KzdURFhqYytVOVVPUVBhTG42Szc3aEZjVmtrTUtaOWJsV1lE?=
 =?utf-8?B?c0U3RWprWVAvTkxCWCtuYVliOFg5bWtSMWx3dDVKN04xTTU5K3JVMkl4OXh1?=
 =?utf-8?B?K3hzSkpIWlBzMmIzSEpxVVEzSnlYczJHVkt0dHdWWUJ3SVd0eTdDRk1HTkZU?=
 =?utf-8?B?Z3dlSUZhODdTZTd5VnBZa05yNWxMMVViUWwwc01IUmpRUXFrSWtSSXR5VlhB?=
 =?utf-8?B?bExVMDlxZmdFaGlZRW4rZGIrUTI0S3ErT2RMR2NpamFOdkRYTXdkYTFONkNU?=
 =?utf-8?B?TjFrV3g2L1E4OWhCVWxYZGY1ZHZXUHpJbFhWR1pkbm5BdXA5VzRTOTFsRGJQ?=
 =?utf-8?B?MXdWQitVa25VWmY3SXE5ai9lakhiQ3BxOG5SajRtUGl0QUhWUUN4MGYxYm0w?=
 =?utf-8?B?bFEvbk5qMWZ3MGMyeUlhT3VEWGhzWG54ZURVdFcvampqb2xZNDF1UEVhTUtG?=
 =?utf-8?B?bnpqbzh0R056RHlDNStTQ0Ezdks3Z24xNlFsaG9ZNVk5dG9PcEUvWjFDSzAz?=
 =?utf-8?B?ekN3QVN5NDBRTnFFbmRKWW80amsvU0o0NytTcWhKalRCYzhiaG81SW5HdHRW?=
 =?utf-8?B?WUxKUElUZitnc2I5SlZnV2E5bWxGbUpMWXRldC9jdDJCOG1IY2pjTHNNaCtk?=
 =?utf-8?B?WGhuQ2xBbzlLZ2ZydnlkblNmQ1ByaDlJYUw2MDdFVHI2eVBScktjRG9UQnlR?=
 =?utf-8?Q?T2+jkRxGKZw0rWxdZxFfWyejU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aAVrBox62bG6h4j69FreN1CMETp9fAunhR/TeDIeYiXU9ronFu6rA2ypTNPpCEWzW1mrpYzzpnLeqVZHck+qfsAUmcb7gwuDIy/EHAeDEaAyZ2vbPBpC9oCXNPJfhnRRQjjfvu3CZBrSaOu5Qs0kYVlT5ZlWdVSZscdQEq6tirryQ0ZMCzifHR2aZzsW37cD/g82pIox3qbtEAY2bxal5bpQy55FIbwCr4VGPCy9dVq11U4vYCfejusSRAh2WL24rkMK57UeFJF7rwvfJrEytpDF6BZvwhKDf7vWxKV6e2MOFAf+Fpk4NlYhdqxuwLMlAOeLCUCQy0LvJAhOvJ3SFjaOseV2O5V64ngTb7lIDdW2GDC75xunHmSGcUfuCMuYk52viTn0CeJpFkiNwmQPhhV5NIlu/Hd7GRpz2mmIvpjkmxp4l5bm+mFFakwgd+SxzxsXW6Wtg52Z5qTtT+EskVNWrDp+/VKF/mfc10mMxt3fvjp6Ahc65Lr0Gf0CW5r0aHIPIvI1qnYPUn74mkVfBAyfP+ggw45y2GI1GIEkZjEZipii7x+G6FD0Cw1xTm88fO5SQY0LhhSQOUaG3DtwiFvdBC/Z+JH/Q1binR/+HGBAqT9gAxU9XRIPDMeQc2df
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f681ad5f-8b8a-48b9-5379-08dccbee75b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 08:00:21.6881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQ0pSlCCi42tSsNs45pCQ2B/pRx9P/5o99w15ByFMiWnTxLqu997YorEJAK99oI1kd1YWNX+uav9IUmzmzR70g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7191

PiBPbiAyNy8wOC8yNCAxNToyMywgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4gRm9yIG9wZW4tZW5k
ZWQgcmVhZC93cml0ZSAtIGp1c3Qgc2VuZCBDTUQyMiBiZWZvcmUgaXNzdWluZyB0aGUgY29tbWFu
ZC4NCj4gPiBXaGlsZSBhdCBpdCwgbWFrZSBzdXJlIHRoYXQgdGhlIHJ3IGNvbW1hbmQgYXJnIGlz
IHByb3Blcmx5IGNhc3RpbmcgdGhlDQo+ID4gbG93ZXIgMzIgYml0cywgYXMgaXQgY2FuIGJlIGxh
cmdlciBub3cuDQo+ID4NCj4gPiBUZXN0ZWQtYnk6IFJpY2t5IFdVIDxyaWNreV93dUByZWFsdGVr
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIHwgNiArKysrKy0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyBiL2RyaXZlcnMvbW1jL2Nv
cmUvYmxvY2suYyBpbmRleA0KPiA+IDJjOTk2MzI0OGZjYi4uODgxNmIzZjBhMzEyIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1j
L2NvcmUvYmxvY2suYw0KPiA+IEBAIC0xODAsNiArMTgwLDcgQEAgc3RhdGljIHZvaWQgbW1jX2Js
a19yd19ycV9wcmVwKHN0cnVjdA0KPiA+IG1tY19xdWV1ZV9yZXEgKm1xcnEsICBzdGF0aWMgdm9p
ZCBtbWNfYmxrX2hzcV9yZXFfZG9uZShzdHJ1Y3QNCj4gPiBtbWNfcmVxdWVzdCAqbXJxKTsgIHN0
YXRpYyBpbnQgbW1jX3NwaV9lcnJfY2hlY2soc3RydWN0IG1tY19jYXJkDQo+ID4gKmNhcmQpOyAg
c3RhdGljIGludCBtbWNfYmxrX2J1c3lfY2Iodm9pZCAqY2JfZGF0YSwgYm9vbCAqYnVzeSk7DQo+
ID4gK3N0YXRpYyBpbnQgbW1jX2Jsa193YWl0X2Zvcl9pZGxlKHN0cnVjdCBtbWNfcXVldWUgKm1x
LCBzdHJ1Y3QNCj4gPiArbW1jX2hvc3QgKmhvc3QpOw0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3Qg
bW1jX2Jsa19kYXRhICptbWNfYmxrX2dldChzdHJ1Y3QgZ2VuZGlzayAqZGlzaykgIHsgQEANCj4g
PiAtMTY2NCw3ICsxNjY1LDcgQEAgc3RhdGljIHZvaWQgbW1jX2Jsa19yd19ycV9wcmVwKHN0cnVj
dCBtbWNfcXVldWVfcmVxDQo+ID4gKm1xcnEsDQo+ID4NCj4gPiAgICAgICBicnEtPm1ycS5jbWQg
PSAmYnJxLT5jbWQ7DQo+ID4NCj4gPiAtICAgICBicnEtPmNtZC5hcmcgPSBibGtfcnFfcG9zKHJl
cSk7DQo+ID4gKyAgICAgYnJxLT5jbWQuYXJnID0gYmxrX3JxX3BvcyhyZXEpICYgMHhGRkZGRkZG
RjsNCj4gPiAgICAgICBpZiAoIW1tY19jYXJkX2Jsb2NrYWRkcihjYXJkKSkNCj4gPiAgICAgICAg
ICAgICAgIGJycS0+Y21kLmFyZyA8PD0gOTsNCj4gPiAgICAgICBicnEtPmNtZC5mbGFncyA9IE1N
Q19SU1BfU1BJX1IxIHwgTU1DX1JTUF9SMSB8IE1NQ19DTURfQURUQzsNCj4gQEANCj4gPiAtMTcx
Miw2ICsxNzEzLDkgQEAgc3RhdGljIHZvaWQgbW1jX2Jsa19yd19ycV9wcmVwKHN0cnVjdCBtbWNf
cXVldWVfcmVxDQo+ICptcXJxLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAoZG9fZGF0YV90
YWcgPyAoMSA8PCAyOSkgOiAwKTsNCj4gPiAgICAgICAgICAgICAgIGJycS0+c2JjLmZsYWdzID0g
TU1DX1JTUF9SMSB8IE1NQ19DTURfQUM7DQo+ID4gICAgICAgICAgICAgICBicnEtPm1ycS5zYmMg
PSAmYnJxLT5zYmM7DQo+ID4gKyAgICAgfSBlbHNlIGlmIChtbWNfY2FyZF91bHRfY2FwYWNpdHko
Y2FyZCkpIHsNCj4gPiArICAgICAgICAgICAgIG1tY19ibGtfd2FpdF9mb3JfaWRsZShtcSwgY2Fy
ZC0+aG9zdCk7DQo+ID4gKyAgICAgICAgICAgICBtbWNfc2VuZF9leHRfYWRkcihjYXJkLT5ob3N0
LCBibGtfcnFfcG9zKHJlcSkpOw0KPiANCj4gRGlkIHlvdSBjb25zaWRlciBoYXZpbmcgbW1jX3N0
YXJ0X3JlcXVlc3QoKSBzZW5kIENNRDIyPw0KPiBlLmcuDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tbWMvY29yZS9jb3JlLmMgYi9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYyBpbmRleA0KPiBk
NmM4MTlkZDY4ZWQuLjIyNjc3YTAxYzBlMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvY29y
ZS9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMNCj4gQEAgLTMzNiw2ICsz
MzYsOSBAQCBpbnQgbW1jX3N0YXJ0X3JlcXVlc3Qoc3RydWN0IG1tY19ob3N0ICpob3N0LCBzdHJ1
Y3QNCj4gbW1jX3JlcXVlc3QgKm1ycSkgIHsNCj4gICAgICAgICBpbnQgZXJyOw0KPiANCj4gKyAg
ICAgICBpZiAobXJxLT5jbWQgJiYgbXJxLT5jbWQtPmV4dF9hZGRyKQ0KPiArICAgICAgICAgICAg
ICAgbW1jX3NlbmRfZXh0X2FkZHIoY2FyZC0+aG9zdCwgbXJxLT5jbWQtPmV4dF9hZGRyKTsNCj4g
Kw0KV2lsbCBnaXZlIGl0IGEgdHJ5Lg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gICAgICAgICBpbml0
X2NvbXBsZXRpb24oJm1ycS0+Y21kX2NvbXBsZXRpb24pOw0KPiANCj4gICAgICAgICBtbWNfcmV0
dW5lX2hvbGQoaG9zdCk7DQo+IA0KPiA+ICAgICAgIH0NCj4gPiAgfQ0KPiA+DQoNCg==
