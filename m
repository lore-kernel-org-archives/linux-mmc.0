Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74D178CD6
	for <linux-mmc@vger.kernel.org>; Fri,  9 Aug 2024 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723189125; cv=fail; b=BnXByGRz7wWqtp4NmLBrlZefavIvPkwNBcM0mTT/G/kU3eAx3nJ2IklEHX/Qe9G7tKXI8XRr/KswrQ1yEyIxWZamLRdiEP4Lk7yzGGGboBQ2jEF+6D9Gz4N45smu2aP5fi1zdhLAT4XHNlqkjNJFHiYuS8E85G/Ht8gtQV9FKQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723189125; c=relaxed/simple;
	bh=FLCpt1TkC1QZBZn+ki8hUGk/GE6CkuGjXxV05etZwAA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eKzS0FcrcpMinY1d9nzKiY+oKmyvcfXnodSA0E4zc+2o3qtGb1O3Y8jcyy+8psqtcv9c1FK/DSzdQIB2wz8wOoydoqOyDmP8LzB9tDNLMziuy+sZn6TAO91TG2aMMnl2kj6/i5G1Syus/vcuepXCbN2Ze1i0S6zRJsruyudEWKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QWwS9qnc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XViRl005; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QWwS9qnc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XViRl005"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723189124; x=1754725124;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=FLCpt1TkC1QZBZn+ki8hUGk/GE6CkuGjXxV05etZwAA=;
  b=QWwS9qncucqNuwQcpR+e56Zu/40A8fKStGD5w3Q2imk1WInH89zjOtAv
   RMUdp7cFJbHT90OXPpQGg85aiRijJG7hFoUvET9KoIHX9Lpw76tGPvvlT
   iiilc+eVOqbqErlUD+oAQ3lQ/aPjKnEVmxVeQn293nLt9HdyTOIdUxL11
   SBSjQfLEZkjHUWH2H8LyynDu7qUp4+KZoL3WIbAbfLfnTfvWdQmsZe7cO
   ZrljvNhvMsaCWUoWdDvz7g551NAScKGUleGnjypLsYvvWsiUJInbDDQ0U
   nAAM9OwQB0Nju3rZsQ6grnQig/B4MofCusg0BJmPXqYAd1+ykmya1CbbL
   g==;
X-CSE-ConnectionGUID: 2C+8GBj3RBOfJf9HGEbajw==
X-CSE-MsgGUID: 3eDhj6YVT3yl/RMNA3wBxA==
X-IronPort-AV: E=Sophos;i="6.09,275,1716220800"; 
   d="scan'208";a="24881464"
Received: from mail-bn7nam10lp2042.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.42])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2024 15:37:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFyAsAfjgpNgrve/Zif8jhVHCGx58xB1cWrb3Ou8tj4NYKOQnzZVURphe1yP6qeZCuf3bYH688C1JmhgMS0zlAhvhrGO4lm1Nc3etl1Dr+z3AhwPhYuJQGIyzriF+N2zkcjts/YWZyB/akBxkhi1jrQkj9HveLc2RVkUOak+jOhIiGF4WOLrWuTpCbQ0oTOYHO31dDzAjxos40+JWU2sofzHAdkOWPwGIPSAc7ONzvHI4s4hiztelOSEtJb8m21s0GYBmp2pg1I9iAh1qHcvD2j+V1bkhBktd0TcW82+a0LspNHljn4Y2Atl8BDK/mIIKLTviHuYIM4YMqRld44PAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLCpt1TkC1QZBZn+ki8hUGk/GE6CkuGjXxV05etZwAA=;
 b=Wq+9/gTqwvP4K5bUR5AXA0KLU1IOj5dwKHeFNc/7Vut3s6TUAwwnaayT2XP4AY72WPC2yEwpYMwOVAs3uiIHsRR66QvIdAtT2/JpUQ4V1uLvnI62uJoSewOO+dHV+ZLhdN/+G5v7FU2BMNyTT9hSQj77tS+POEk6u0r7gbKknSzaEXGg1UhUymd6yN6dHMJdecnpVEwG5pIQl/JOw3mY3slFn8htmrohc/OuMywsziZIr89S10TfWzPxeE8LhvahMtvqkYxk/lbrJfhl8cl2mouOMVDPb+yRn2Ze1pkysbzEdQAsS2ppguS+fQ0ArTMWNLMdXLJb2jxZcKMvfvKqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLCpt1TkC1QZBZn+ki8hUGk/GE6CkuGjXxV05etZwAA=;
 b=XViRl005ivKqNNawahhic6rTtT9o2dK9gFwvfgcEH3d9Z+OHUlPwp29b3g7SIHxcODhPDToaX7Bwff/WWP02BXbLhjgyCETU0joTzwaUDeKvB3bI1NgQHrzt3AqxKCzL6wULLPJU6tLHRGiunpv2aXsOIUlyWYpBYAt7c/yI5wQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB8576.namprd04.prod.outlook.com (2603:10b6:510:290::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.25; Fri, 9 Aug 2024 07:37:33 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 07:37:33 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ricky WU <ricky_wu@realtek.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2 00/10] Add SDUC Support
Thread-Topic: [PATCH v2 00/10] Add SDUC Support
Thread-Index: AQHa6I+0roiZZqojKUiljkeDybdGm7IegLYAgAALpuA=
Date: Fri, 9 Aug 2024 07:37:33 +0000
Message-ID:
 <DM6PR04MB657581C90670A2A95191BE4BFCBA2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
 <1e25e47ddfe84bbb82a2b9c1b6eafe84@realtek.com>
In-Reply-To: <1e25e47ddfe84bbb82a2b9c1b6eafe84@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB8576:EE_
x-ms-office365-filtering-correlation-id: 475aa4ba-1748-498c-1f08-08dcb84621f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEdwMWNMM3dvRTRLSnpRVWhnUExJMDZyYjBScWZaUUZlQW5xOG9hT2VCWHVi?=
 =?utf-8?B?SU5SVS9FY0hYOVZOUWhXQnRSUm0xMWdtMy80bUhPd3FPQi9DY2JJV05JSW9Z?=
 =?utf-8?B?SWhUdndEa3dlMVlFa2lyM0FPTXdoMW4xeHhndW9ZWHEyU1BneTh1VEkyaUdT?=
 =?utf-8?B?ZnJNOU5yUkZqQVRNYXhUZGc2c1d3aXh4cXdjNkZyd3gza0NJRlZxQlU1SHE0?=
 =?utf-8?B?Z0NRNXNuYm5tSmNLelNWQmdCN1ZSR0Y0WTQwQnN4MWtmOWxMc0FrZFBGWGIy?=
 =?utf-8?B?MFg2QkJTbEQ4NTdmbTg4SHNrcUNxUXdUMTlaOTJTdVJ5M2dmUzZ0amVrSFJr?=
 =?utf-8?B?ZUIrYmgxOTlDS2MrRFJEVzhWMGZuRzFyYTRsdllQYm5PemhOdnNZQ2hHVndV?=
 =?utf-8?B?VjZyN1pDTnBLV0tsVjVkZ3FxVXJUTGt4d1pFaG9mbHBJejViZGU1dDBCUXM2?=
 =?utf-8?B?VU5LQmQ1aUZQcTdYOEJBeWlaQ1hRV0M3ZFY5ZGoyZVVnZTFiYm84cEs1WmRu?=
 =?utf-8?B?V1JBQk83azFxdGErZmgvNUVJdzd2T3VOblpCclpDaWFlM04rcUJVUE5ZK2kr?=
 =?utf-8?B?UjZqbXdLWWZQelNuYm9yb0p3eXpsWjAxUkd0Y2xNSnlpMHd0MEhYQjFDR0lT?=
 =?utf-8?B?dmdoNTN2U1pMOHFsKzBiWUNkamhwVFQrVDZkK3docUJLZXVqa3VQQW92VWlH?=
 =?utf-8?B?a3YzbGJTeUgzbGNLdGMyeHQyTHYzbGRjODM0RXZyM1NsWGtOTE1xNWVVVXNp?=
 =?utf-8?B?M1lWVnN6N1JLN1FmZHh1M2huM0pueThMMkMyZVIzNWVCZmNQZ3BnZHNZWmNa?=
 =?utf-8?B?Q0pZNGI3SkIwcG51Z1BNQnFxUVhQdm5jUXFleXFpY1JPZmJLQjN5YmVmUFJ4?=
 =?utf-8?B?a2MzUDk2clFSZDdKY1B5UkhNd2pueFZDWVRydTdTeTVra1Jqa0NYK21BcG1N?=
 =?utf-8?B?bkJNUGc5RUNlbnhNSW5IV0R0QWhsaktLaHhGN2RIc29PZFZvU3JiejZuQ2Zn?=
 =?utf-8?B?SGFDWS9TQjR0VTFXRDBTZXBBNXNTdVZiaGI5OEd5aENWWG5yVTdZNFBNaG1W?=
 =?utf-8?B?QWdJQ3kramVhVzd0ekZncDdOaUpjWkd1U2dHWCtZWTlHMEdoeXF3NlphdEJS?=
 =?utf-8?B?VmVJalFlQWdDQkxTTzV1STZrTUo2R0M3MlR1Q29GcTNVUWxWeVRNWldnYjF4?=
 =?utf-8?B?TTdpQ2NqSGx1SGsvT3AxTmFuZUsrUW00M09ZSmFQdlU1ZG4zOHc4YjQ3NVhY?=
 =?utf-8?B?WW1rR3BTOC9xZHBFYWZmSG1xajFqSjBFbDhHdW9nR2JuMGRYeXJGaU1xcW90?=
 =?utf-8?B?TVlrbk5SK3VyNDF1R2NZWk1FcWFkL3ZEUmo3UUtVbXErV0VDWjZUMlB4aWcv?=
 =?utf-8?B?djJZY1NIRXdjUTQ2YStHZkZRTFBSa3dPeU1nUWxSUHM0QjJZMFE5UjE1OXhV?=
 =?utf-8?B?NE81KytVTS9VYVN5YWpiWk56UDdkaldHWUErZ0JZMjZEamdPd0YrTThoeFNp?=
 =?utf-8?B?NGY5Q3h3UEpON2FTMDFZcTd2SXoxcWllNE9sdXE0ekZ2RDY5SEFzSXJZa1NL?=
 =?utf-8?B?YkpLS3pNMGh4Q0t4TEhqVjBrdG5jbUZ4TmZ3N2xjT1NQK3kvdnJvR255d3dD?=
 =?utf-8?B?NVk5S2FaVjZ0WlducFZvOGZqemUxZFhhajBpZEZLZUh6VlI3bGVPb09LbTIy?=
 =?utf-8?B?R2xYZ1V4b0RqZTFNWDRmdC9mbFFhdUdIa01Qd0RGNVQ5a2hGVUdlc01mSkZT?=
 =?utf-8?B?MUZvTHNJZDkxQXRidndZRUxTaXNaWFRqZ3owZnZybDdJTXFLdXdva205L0pU?=
 =?utf-8?B?Y0FXMzhlWFJYQlNFTVU2R1l4b2k5R1Vnelp2RnMrQTBTS0hpMlBjQnRkU3Zi?=
 =?utf-8?B?OGJjSnRCVnplQzVkczY3TjNtcFBteVFRNWFqcnYxTjRKaWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnA0UGsrclJuNDBjRnZYYkV4S1B4OUhRWkhWOTR4RDhZMzFIVWRoampPQVEy?=
 =?utf-8?B?Ujl0MFlBamxsS1NHb1duSDRPU3hBOEl5VmNjbWl5ZHhaY0lMSmdZbTliNVB3?=
 =?utf-8?B?VnJIVlRNNktORnJBK1dVOTYrbEwveFQrclZZQ1kvSnAzalM0Rk1vZ09RSS9Q?=
 =?utf-8?B?VDc3SlVISmYrZDdsL2VyN0JSZERwNFE1K2Nrck9UMitNMUhBbU1GREZ6ak1l?=
 =?utf-8?B?MEZpb3Q5azg1T09zWGRrUW1WWWcrY2k4MWFVRWY0V2x0WXRZZ2UraGp2dWVw?=
 =?utf-8?B?dVBGZExpMDhVZG5HZ2E0UndCUkxHREZJVE1ZR29mckMyVWFPQlFiNEFNd1Bl?=
 =?utf-8?B?T3FtaENENzZIUUQwa2w5dUZFaUVMczZCRjNMWEhCYzNxc2JkL3JhRGRSM2FZ?=
 =?utf-8?B?TyticERrZlFXUmtzWEdxQUJOd3pmMkNGdkdkT3RsRXcxRGVGc3p0SWNLK3Jt?=
 =?utf-8?B?YkhIb2U1c3ZBK0p5RjY3OHErQUdLOWRuVGxGa0JaR2hBM2hWWXhyYlN3WXRE?=
 =?utf-8?B?d0ZxWHhGVzBjMUpPUEhFeEw5N0dNQ1NjeUpqcGdIUTRTYXBCaUFWYVd2Q3B1?=
 =?utf-8?B?K1VLNWxFUmh5K3pQZ3lVWmhMeXpVeEx2N1B1WWFRSzNYYmlWU2NhcGFOZ21k?=
 =?utf-8?B?NGxPc1FsTFpkTjZoMFA2bk9rdGYxSk16bWc0Q29IWDlSb2NETmdCWmZyeGdk?=
 =?utf-8?B?emQ2QXJQR2VWQWk2ZEc2bTFQak9ZdFIxNnJraGRrdHpYdmpGK0lqK2pJN3NT?=
 =?utf-8?B?YStGb250czJRWmUxL1owQndHaXI5YkNKWk1LYVJqTmpRSzQ0UVM1MzhPelB2?=
 =?utf-8?B?NVBueEVzcnQ5NmFQNGNzTFdBQ1BmQjJrUkllLzRYaGJYb1ZYR2hpTDcwSENr?=
 =?utf-8?B?MlJJZTJKOU1oL2FwZWJrWFpWZ05oUFFLcnpRUEJ2UnN3ekRoZVhqenc3eWlN?=
 =?utf-8?B?VzMrZVdtR2RzcGFybkYvK0hCSVc3TGg2OTdXNFpBNE1nYlhNUVZaUWpXeUxU?=
 =?utf-8?B?YjBuVWYyM3IvczAvVWpkdFpEczZiUmF5OTJpQ1RENGx5RXlXTE9IT0E1Qks5?=
 =?utf-8?B?Y2piYTRTbUl5RzVCbXFFbmVtVVZYZzdVb2p3OW9pY0E5WXhwSldLbjJLRkdM?=
 =?utf-8?B?NEsrTTQxUWQwR2llOUJZT1ZRNTlDaDkzWUpwYXIyaERxMHRLdkJCaVZUMThl?=
 =?utf-8?B?SU5LL3dkc3pGczRCRWViQkpEYWpvVU1XRE5tYTBlT2JvcThzQWpITXFhL3c4?=
 =?utf-8?B?UGN4ejI4U2lvNTd4RGRMQklqbzBMRWFlSDUwalFHTWVURXA1UDJqNVl2aDl4?=
 =?utf-8?B?OUFhNjVqeFpPUVVNd3g0SXZqNngzbTZyM3NQUk42NjV4blNUalh1U1NzRFFk?=
 =?utf-8?B?TVJLb0hXbklKOGUra1JtZytiUTllNWgvRGI3ZkphVGJ6aWV1a3VPT1E2akl0?=
 =?utf-8?B?YUVFMDQ0SG5qUUs0RllRVURUeXQ5UTI1VE51MU5RS2haSXBiVUlOME9Oa1Ru?=
 =?utf-8?B?SEZKbSs0WnNYR2w0cVpkZWNwUlY5UXdleUJ3cjM1Z3NGRk5ySUdySlhNNm9M?=
 =?utf-8?B?bW9lVW84R3pWVERMclE3cloydGNOZGFuT1NPeGZkeStubHR3OWsrck9SYW81?=
 =?utf-8?B?QkV1RXUrTmM2NmprYUFMN2tIaXJhNFVNUzVueXNMb1ZxcXFSS0NBNG9iRHNz?=
 =?utf-8?B?cG0rN2ZsVkV1ZnFrSjdER3lVVW5lUVVsNVViV0hKZnVWZm5tUjlBakV4TjA3?=
 =?utf-8?B?SzlXK0lodG0vZHpmRGs4ZWZxQUFCZHVQWUNkVnJJYkRCNE1jbzFRL25saHVl?=
 =?utf-8?B?UTFXQ0FEU21mcDhmRXBKaTVmQkNGYjdBTFNHeDFuQ1c0cUxuTnJ0M0lYN05i?=
 =?utf-8?B?ZWFXRHFXemc5TFVpNERSZVdjTzc4S0VMNjFhRUtHUy9GdDNjaCs4aFN3KzJy?=
 =?utf-8?B?NjEyQzUrKzUyWlQ0SDZyd2F6Ky9pY01ERS9FTEFWT05YVmpRUDk4dnBYYTdt?=
 =?utf-8?B?dXlKbUtSUCtURDlNbUwxZkMrWXZMeHpUR2VPZFI3d2wxK0UyZGJneUl4em5O?=
 =?utf-8?B?Z2svLzNqWDZhdUVrT3c2TlduUWlGZit4N0tkejJoTzlxckgrVnpKQUJWOHVP?=
 =?utf-8?Q?FmLhi7yAAs0wxnmlwsFcaO1qS?=
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
	bA/+ja2SpZnomMO9EAlyTM1WtHfN13jLkdmVtzpEKGKh392P9xtrmVj/TrcQLuvMXqkHLg7ozoIHMYCbY32iS3iUG1OjtwIV+dfFLMSGlL1TKmmLHrJ6a8Q/kk3CpgdzbdPmllmqX9m6UL6C2kXMycN5CD9XoerjsiUxIv5xb0ftFrJLQPr24QhyLw5Rj4WTtQFLaf+xdixpELPymBn/IanR6FhJkTT/XFZ9947/RYfyWwShtUK0h88xba5LDl+QJQhKHohbE+ocd7r3F742vhV6tqdms2CId2dAQMFzt3NTrX/EQq+rWG0SyQtwurmQDxlRYUUJEV3gyNKv8trYKE+D8uZcN0mS+uR2Cm7gXJJNIGwUpo7ulabF1J4RcCUtufX+gTgsDtowBmtI+rUah47Kd+NxDbe5Dp8sK+mjaj69ZNILER/zQJW0eZNRuJP+Q68dY8afrAddD+R4tCOI+W/6b1lcJHfY/ntWzV3bKA151jSR9UcE9DXXFum1hjmBpVlgrfjYha8QF7/lP6Ur6SKN5ixJ4YgQcDX/Ck4t4rm7EysnQYBybu0ZBiKioD/SKNtayoNstDPC5xVEgjjxt9QIaRYePadE1uN96RuEbLhI0mAk70BPZ0637sDtKqlg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475aa4ba-1748-498c-1f08-08dcb84621f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 07:37:33.6233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1afvPCbXts/V3tlJWAirkPzF2g81wwtckWKo3PjCfKB5abGkK3+AZ32wvWX8yHECREbDkQ48zXm0uTHkHCeOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8576

PiANCj4gSGkgQXZyaSwNCj4gDQo+IEkgdGVzdGVkIHRoaXMgU0RVQyBwYXRjaCBmb3IgUmVhbHRl
ayBjYXJkIHJlYWRlcnMgYW5kIGl0IHdvcmtzDQpSaWNreSB0aGFua3MuICBXaWxsIGFkZCB5b3Vy
ICJUZXN0ZWQtYnkiIHRhZyB0byBteSBuZXh0IHNwaW4uDQoNCldvdWxkIGFwcHJlY2lhdGUgYW55
IGZ1cnRoZXIgY29uc3RydWN0aXZlIHJldmlld3MgLSBoZWxwaW5nIHRvIG1vdmUgdGhpcyBzZXJp
ZXMgZm9yd2FyZC4NClRoYW5rcyBhIGxvdCwNCkF2cmkNCg==
