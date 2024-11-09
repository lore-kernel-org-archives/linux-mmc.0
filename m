Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5624A1E
	for <linux-mmc@vger.kernel.org>; Sat,  9 Nov 2024 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731131101; cv=fail; b=gk37VXiLOynIRphGAjN1CoG1bDpRbWT5o9KxvsvKeCylmQyDGbwnz2s5no2p+RiDSPQQrRaRytx9Mz7m6601f0OVIYA6gLAQzWw/FZDNmbn8L3Jm85UdlImuSmqYDutLlt+YX0YcA5hDIUVDAhvEiLj5/X20XtjZx808MHnig58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731131101; c=relaxed/simple;
	bh=gdP9WfW2M9c0JROEGmk+zA6GQaacTY4wsNezZRdHZ2U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cp//qwRsmZtZClSdkQGHtnnoudVMDD1A/5nQp6r1gCPsdwau2dZUFvfy+iO0b8AwW9imoR3RAtjNNgbZAoR8jcfHtM8cPcy5oykxIWZVVLf4E7gsWs7pgNUTSdXFX4eQIdD9bYWi8cs0zUiY+rJfLLTy1ti+j1hhH7aMbYm10MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PoiHQk7/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UYhyxIMY; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PoiHQk7/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UYhyxIMY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731131100; x=1762667100;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=gdP9WfW2M9c0JROEGmk+zA6GQaacTY4wsNezZRdHZ2U=;
  b=PoiHQk7/YLtSZgyzF5PMlmfXoz4ZCM7l2oUjZPx333S1ikO3VEYCUU8F
   RyVFSLFLw81tBJqQeydYcSgASbrNZjuPZCtT9Ckr/tnIsIlWB+Z0ENNSu
   C7+RXp4/7o3lCYHLV9N/VSglqlzue3BzJZ4idxrmX2KPRWpnI1jEn3jVL
   S2fYBKNFXnMwoZUO4AhOnSisArr9cOqBYMS64WCEgbRYj99qdtFkTSX7b
   4YnLUyhdpXvFEm6l+o7M7zy07+SINL0Hzgc8DW1X64xK+dLuNuoq1zPc3
   l4CUxmdfZHQb5b0DYeQ0meqMeQt4kNJXXMzxKFcT0KUw/sCQ2dFTWA2y4
   g==;
X-CSE-ConnectionGUID: 7+ASy/BcT3CmA6Gdoj+yGw==
X-CSE-MsgGUID: L8uV7sFcQ6elkICnq70Faw==
X-IronPort-AV: E=Sophos;i="6.12,140,1728921600"; 
   d="scan'208";a="31148517"
Received: from mail-westusazlp17013077.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.77])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2024 13:44:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgU6z3Npfd6RejWbwlr0l+gE0xQq7GX2MI0if1foYF7zqcX5Ce4Yc1xRI2A7usb98R7x8gk5IedB2g8JS8Li92rOl831hCM41xDRxg5mQ3SIsMEeLA2syciaHfu3qGbimVGcs4No+JBkP4nw5kj63FLTKuvMNOTbraq6Vdf82Ad7ieMZgQzc5AWXKlraxZAfWtSuzprysZLSHhJ5YZRe7GB3p3ZW24aIbEH5QD48MtwPsMGGHvbhcPz+6wBhpmw+3cgIr1x99bmthcSm+1kaUMeABXyJ+hdOSijR/U7lBSrX6T/ceKw5Eqza61Qa7fY6wAM+D89YhvoPegvm4mzyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdP9WfW2M9c0JROEGmk+zA6GQaacTY4wsNezZRdHZ2U=;
 b=Wf2qQR6y10LUPNVw2f3nYLmJXQ58u0qletFYY7tnVuo3U/QU/SIBwKpspZts65rsllxyYR36u9TtbJMSjFVMcSZ+xXfzxvGD4QPux9srCDpizsNHYnvg4ad+2bBF/M6AH5aK1evQoZuuVPyAkRAlTEFgHfk7Q69JmBtAtWLlZmZyqLxK/eh1lYTOzYXwGcHlbuXsYbm5Q0RGTRKEkYtADzB5MGlImvO6Ssyf3zRhJJ38wJw7Eu4ICjN0Rlr/tivmBcZqzPqtuFxsrPUYFEriGXbB7JCwiAzzfsy1RFOhGduu7tVYdhlym242EpXKIROrkxlpAopGf3E45huctF+WoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdP9WfW2M9c0JROEGmk+zA6GQaacTY4wsNezZRdHZ2U=;
 b=UYhyxIMYhKfcpCM6H0Kxf4uibmJFj1sFtkpqyyAz/R+W51/3l3/R0OeuOfME/Ne8IemOu/x8bEcXQ5ijjOkwQlzmKtNrpQkd0CLrBLcs9icwLdZTgFOf1eUEVRg+NHQwhZUgZLXVFbaCr9FdeJ2irOChUOZRXpom12WHon3YrfM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB8565.namprd04.prod.outlook.com (2603:10b6:a03:4e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Sat, 9 Nov
 2024 05:44:55 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%7]) with mapi id 15.20.8137.021; Sat, 9 Nov 2024
 05:44:55 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: clang-format fixes - part 1
Thread-Topic: [PATCH] mmc: core: clang-format fixes - part 1
Thread-Index: AQHbMEZWP7S5xGGM10mvFlfsGDkrdbKtfq6AgAD1luA=
Date: Sat, 9 Nov 2024 05:44:54 +0000
Message-ID:
 <DM6PR04MB65753BAAF6E08C23FA2DE3C7FC5E2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241106121830.739041-1-avri.altman@wdc.com>
 <e34b886b-aac6-4d0a-92b2-0b342dd45240@intel.com>
In-Reply-To: <e34b886b-aac6-4d0a-92b2-0b342dd45240@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB8565:EE_
x-ms-office365-filtering-correlation-id: 0748fcd7-4755-42c1-fbe9-08dd0081a385
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SzNMMUJCSHljMW9SRXU4aGtYT3UzakF4ai9ubmhsMGtGY3VRY1hKajEwajJp?=
 =?utf-8?B?TVdXTWgrTENvcWVmdjRwN2dRNzBWdnk5Nkc1bmJBc2pmVVFKelkvZWZQT0ZL?=
 =?utf-8?B?OFd3MGZ4ejh3OXc0NHBPallhTW1XVitpTWZPUUFnRzdDSWRhaW5TY3VpcW5j?=
 =?utf-8?B?ZURrOXRvTnllSXlva3Y1U29jWjhoREpxbjk2R1RzNTI1TzMwaHUvWVZvcG5N?=
 =?utf-8?B?K0xuSlNzaENYNEluNDAwaFpDZjdWY1ZkbWQ5QUltUlltMDJLamptVlp1U1Zz?=
 =?utf-8?B?T0tONGJQekVDcDdrVkw4ekJjVGxyS0V3a21BM0JqWXEzakJCTVJvSHd5UURl?=
 =?utf-8?B?ajhuUWxmQnkwMDBDZkxvTjhoZldGQTYrMWR2SHFhR1lNTXdycXJMWHFCME81?=
 =?utf-8?B?Y3lpU2lNSEdxRmFRL1Nwb0N0bktPR3hVd2MvQ0xRVmpGb2dtblBMbjNGUlRD?=
 =?utf-8?B?c3BFMFR3d3pOd3hZU3pXNVdVQko1b0VHNkVHa0UvT0NxSFZ1RTkrOGx3SDFl?=
 =?utf-8?B?dFArbkJkQ2lYNnpyRjdQUE5zS1g3c29mVWROWEh4SHh6c0RmK2NjK1BDWHNX?=
 =?utf-8?B?YWtaSmkwcEkyaHVGMmRuS2VRZVRPa2tvaUpYam5WOGZ6YytGaXh2MWVFbHZO?=
 =?utf-8?B?MUt5aFp0eDVwV3F3ZklxOVNHTm5KOHJ3V1NDenMycHRRVFl4cGs4UVQzamV2?=
 =?utf-8?B?TWQ3cnFwTHdGRkdDZ3paczJRNFJncE0wdHdYL2ZTanp0M2NUVC9mSFhCc0ZU?=
 =?utf-8?B?Q2xtL3FKWXBSRi95cXRCakh2NUJ4cXZSaVEvbzZxUzJIa1VXWXZGMS9NdWZS?=
 =?utf-8?B?ajAwUGdDT2JVNG5pYm93RXlIeHFsRmZyMHdTUHRwbms1V1hjdzBpS1JEZ2Zw?=
 =?utf-8?B?NFJOTGNCV2sreDdYVTNBN0ZVa1ViR2JPRW1VNExsQkpjOVp1dERiMmtrZ3hj?=
 =?utf-8?B?T25qTldIaE0xRWpidnRrTnYwWXBKVldNNEkrNUFyU1pqRWZUVnpqUG1lRXM3?=
 =?utf-8?B?U1N4cllLdFFpcDRUTVllRDRjVG1BMkFnbXRwTldrb2s0Q3dHU29MUkprb3oy?=
 =?utf-8?B?UjNMNk5FT1JQa0lncGRvZ29xV0ZqL0JLSStDL2dhS1RIRk5TVENVVnIxaXlt?=
 =?utf-8?B?WG81UUN2VmNZQkZsVVprSFdodFd3dkpGamN4OTY4azY1ak9LeUU5dzIwV1lX?=
 =?utf-8?B?T1VpZ29BMW1UelpqYmNhTkkySFlTQ2g0Vk9YSFhjUFJuNk52ak5jcnd6TCtK?=
 =?utf-8?B?ZUtpSTNkbm1qT2dvMHBQTDJrdjE1TmdieGYrajM1MS9BSlYvZ2Q5STFCdCtu?=
 =?utf-8?B?M0MveXJVRG9tZTdBUGFUd1VoSVpKMkFzV2RCTmJ5Y0xYT29sOHRxQXBXbXIy?=
 =?utf-8?B?blRCazIyMFFZUGZXWXdRVTBDeGExWStVRGNUQTNmNjNLZ1pkN2wzV1Q4bjBS?=
 =?utf-8?B?QjllVCtVMzVIUlRHck5lNjVGaTBRdUZNeXcxUkhEcmtxc1k5SHpGSnhvV2pa?=
 =?utf-8?B?NllzYTRZMGRJVFp6L3VIenVjUjRIY2dBTHN2WEtkZkw2cUlkbUFKU2dmM0dx?=
 =?utf-8?B?bnRRMW9hOGhiaWRmeFlDL25RdjFwWnZQWEkybmlUZ3J5cFNENkVJQWpHdHhI?=
 =?utf-8?B?dWF0ZVREOGVibnRTN1NhVHJpSUtTQ1dxM2kvbUU3SHlMeDhkQmZDMHNjSEdz?=
 =?utf-8?B?K2N4S3Jna1BuN0JUSFJLbnJUWHk2MzN2WWhjcHQrQ1VXdlNyaG12M0lSZ245?=
 =?utf-8?B?RHkvNFFkRDR6UDlXUXVrR3hNcktjQWhRSFNIMGdIcGpaL1AwbkcxVjhUT2Za?=
 =?utf-8?Q?76+BWfPd+m0jiuoeJujQjyVkM1DbNsukNqp+k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEErbXU1N3E0V3pENGt3Q2lCK2tXbUZGd0t2ZkdicnRtSU1mcTI3cjZ4c1Zk?=
 =?utf-8?B?VUFQK2RpK0VrNEVUR2s5TEh2L3dYVHBYbzBGZUd0UTAvNnB2dHdsK1B5REtp?=
 =?utf-8?B?ZUdhbElvL0d3TFRSTE5tb3dycmw0UkdLM2pSMi8yUkhJNm1oSjlvWUJWaUdC?=
 =?utf-8?B?cUtDcTNiVjRJV0I4TTNuYkRCN2xuaXM3TllBMVAzUUlVTkEwVU4xSmRUR254?=
 =?utf-8?B?Ym5TTCtPSVB0SWRTQkFwdUNiTzMzWjY3Q29XMnBVN2RkNW51ZEVOZWd5SnJy?=
 =?utf-8?B?YzErd0RSTi9wS2Z3YUhHWlhNZmlVK1VVUGVGL2xQMlZidW5YZUFYNkZLMlVs?=
 =?utf-8?B?MkN0MWhkVzZtRU5yYmc0M0ppOVJoeGY0U014RWVxek9rQTFoclkrc3FkOFF3?=
 =?utf-8?B?R1p3MWY2Qk5Jbzg4RG0xRVdqUFhJMy90am5MS0Ryb2hUQnNCU2NRZVdVaHIx?=
 =?utf-8?B?U09wVnk4S2l0ZzRjMy96V211L00xYk1jWFFxclcyT3pNQ3oxUmgwZE1DcHl1?=
 =?utf-8?B?RWxMUTI5U0laZ0hVNDI2bGEwZEZPaFpQSEM4NmRkaWZWb2lwL1ArQmZqVUhK?=
 =?utf-8?B?ZjNoa1V5UjBPekV3U0ZucVlmQ0R4Ym1qdW56elc4a01RUnVvNEsxV0VPcFh2?=
 =?utf-8?B?czZOZlg5dWhyQ0hNOU9OZkhSeXo2aFRPb3EwbXp1c3Y4MkY0b1I0eUdYWmZZ?=
 =?utf-8?B?OWRoNVQ2WFhSZWUyNmo5UHVJT1gyc096ZDg2K1B0bS9tOVFsK3lTb0VCSXJS?=
 =?utf-8?B?eTNzM2FCbjA0V3p0K1hQOWtCWGVnL3RJbU13NVVFMzBDRkkrR3ZWdlhudGNN?=
 =?utf-8?B?c2lLNnZQVDFLVGYyd1hxd3poUGRuaGdLaEUrMEZEMG9tcS9rSTJTcXlGR0o4?=
 =?utf-8?B?bDNQVG9NQS85VkcrY0xPRUhWeUY5VStBL0hWNnpsR0hXaWt4aEhHRXR5R1hi?=
 =?utf-8?B?aFMyRzMwMmRwei9TcmJZQUlhdVU2T1V0RFFyM1doMkltMWJnQnRWdWRRd2Nr?=
 =?utf-8?B?VEYzbjF2VkxCa2ZkTXhHQjJLTDRPZDEwNnQ2aHhNRUpUVkNHVVFYUlpURWRL?=
 =?utf-8?B?b1B3Zmd4S25IT3V1ZVFSTHdWeW5vYVROTE1RcS9BMk5KNk90VWVyUDRpdkRD?=
 =?utf-8?B?MWVOMnpvUFR2MWtFWmEvSEJRLzdCUkNDL2FUaDRIaVZJQWZSSTlVTkNGL2NC?=
 =?utf-8?B?eW1Wbm92bXFLZk41NmhlY3hpUXRNUXdORnE3RUppMFpIZCtMK0duZ2pzRTFK?=
 =?utf-8?B?bGF1ZGJJcEpUb0tld0dFRmY1cGsrRkFCUVJTTWdxN21yL28vUkVPWVRuQXJU?=
 =?utf-8?B?Q2NBWnZFT0d1Rm1qTmRUWGxWSDhOT1JSZUt3WENLNWk2M1hZWERoOVhSWjVz?=
 =?utf-8?B?WkhUUWZVODVhMTdUeDZMeHFoREk3OWNmYW9hMGxYRW9xOGtQd3dNek15NHVW?=
 =?utf-8?B?QkNNZjNkc3ZwWkN3eS9RcEdEMkZPTy80MlFxVlFYZWdRSmx2TEY0blpjZGlP?=
 =?utf-8?B?enhyRkVxZ1lpTU16ZXFvcUxEdWZwOUJ3R2RZR0xwZlhFd0NQNXZydms2UDZX?=
 =?utf-8?B?Y2RKaVVMNzJGUTNaeFgvcUkzWTZldFVWbVpqdzRRSDhlQXA1bWlSbTQ3MmFw?=
 =?utf-8?B?cUJxVmhEMldjQnhqVHV6NjNjNUVzQlNkYnF2UHh4UFhEdUxCNUxYQWxwZnk1?=
 =?utf-8?B?VS8wNkp0SG9vYXVBOGlsSFpDS21DYVBXeGIvenBsaXpxTmVybTJtc0V4NWtU?=
 =?utf-8?B?YURlVnVKQlBwUDl3d3dQNmhDbGo2S1RMSHlhT256WnplSFVuazhKcmNjY3U1?=
 =?utf-8?B?SncyQWFUNWIvbVFNekdZOHJma21CL1JoTXJQbmtGQ3dic3hoVzNZa3BXRjdH?=
 =?utf-8?B?dkU5N09KaUQxK2Y0NnZaSWlZU1VwWHRRVHora2VBSUpQdDExaTY0Zit2OTZK?=
 =?utf-8?B?QkRMN0VPbE45cW8xWVNUTUpMcldUMXFwRThIR0xqWG4zOW9qOTBaNG1UYzRG?=
 =?utf-8?B?SkJBMHF1R1VUTVNnUGE0WE5vSml6TGJhWUdkYk84eEU5YjdIWHFFbnhCNkx3?=
 =?utf-8?B?OHRLYWZkbUFxM3Q4eUFadU42RjVNWmJkNzN0TDdvajBUcFo0dXcyMHRrNHU1?=
 =?utf-8?B?N211M2M2VDhRRjRFVmVUYWIwOHZQNHJLVzEyMWd3cWFJRmx4R05EU1hGQUd5?=
 =?utf-8?Q?9PVuXU9S8PMnkp2nupA45jqyPX+XY9aqxdkKmAnsNDe3?=
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
	TGC/47A+CE4pisgb91l/hUc3wXN9oi5t8SVvxjf4YcYnA2B2jdkb/2a/7ZCk9YZYJnDd0FAcbeI3IRQC29cCdfXCsh6O/ZhdZ8DpKSgI9D3ryVFQ5ZhbQ6eWur9rlxQBz6yjSeBdMdqa4LQqzRj1lTee6v6fb9r6eVn3khdo8bRR02jciyqu1448GfNszwapy5DsIzKsezq7vh6JhTCNJxMcgoQ6wPsyNiZtgyVeBKLrYV9FPu2fYjdVcebeX8ayCZ2tMEyEfVs5SQy/IBEI4XeXen+1MYogc2CXiw4jkIN4OZgCHAmcqyC/MsqowSqbd/kSJ3ImlthxaeFvPpjuFouPTps6kdX19NRV8rTJIVJ76b8NiBl/1D5m5bvV7tNwgxyT7rHPCEaXynSqBYV5yaDe7MgpZ6HIx7Fl3IZNDEsy+XfJZu8xP0sfBz1gVhNr2vSpmSF9iPnnDbIANOQnHZhQhGwYZn+Bix4I7DOD46ttLULsBnbCuZQsfDxhuR/5t1BBbLUKedzu5vKiy3zxoJ4fnP4Uu6yOzrF+huNNh0ri9uBynSo8XKKjrQtz7XP4mwhU15EXstLjknUrLB0LLQRiB5G1O9VwSl9CYpXzrE6XoXtdcC5+FELIH4yAS9z8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0748fcd7-4755-42c1-fbe9-08dd0081a385
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2024 05:44:55.0140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beuvzTYZU1W0CBTHHrftfRjiFxOGpYlRqLcmKAzHCLQb9OI0fRwDCzk9KTneMefutdtoqZ0BxmOgsvBI7R839Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8565

PiBPbiA2LzExLzI0IDE0OjE4LCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBXaGlsZSBzdHJpY3Qg
Y2hlY2twYXRjaCBpcyB1c2VmdWwgZm9yIGlkZW50aWZ5aW5nIGNvbW1vbiBzdHlsZSBpc3N1ZXMN
Cj4gPiBhbmQgZW5mb3JjaW5nIGNlcnRhaW4gY29kaW5nIHN0YW5kYXJkcywgY2xhbmctZm9ybWF0
IHByb3ZpZGVzIHNldmVyYWwNCj4gPiBhZHZhbnRhZ2VzLCBlLmcuIGF1dG9tYXRlZCBmb3JtYXR0
aW5nLCBjdXN0b21pemFibGUgc3R5bGUsIGNvbnNpc3RlbmN5DQo+ID4gYWNyb3NzIHRvb2xzLCBh
bmQgbW9yZS4NCj4gPg0KPiA+IEJ5IGFkb3B0aW5nIGNsYW5nLWZvcm1hdCwgd2UgYWltIHRvIGlt
cHJvdmUgY29kZSByZWFkYWJpbGl0eSwNCj4gPiBtYWludGFpbmFiaWxpdHksIGFuZCBvdmVyYWxs
IGNvZGUgcXVhbGl0eSBpbiB0aGUgdWZzIGNvcmUgZHJpdmVyLg0KPiA+DQo+ID4gQXBwbHkgdGhp
cyBpbiBwaGFzZXMgLSBzdGFydGluZyB3aXRoIG1tYy10ZXN0Lg0KPiA+IE5vIGZ1bmN0aW9uYWwg
Y2hhbmdlLg0KPiANCj4gSSBhbSBub3QgYSBmYW4gb2YgY2h1cm5pbmcgY29kZSBpbiB0aGlzIHdh
eSBiZWNhdXNlIGl0IGdldHMgaW4gdGhlIHdheSBvZiBoYXZpbmcNCj4gZml4ZXMgYXBwbHkgYXV0
b21hdGljYWxseSB0byBzdGFibGUgdHJlZXMuDQpPSy4gTGV0J3MganVzdCBkcm9wIGl0IHRoZW4u
DQoNClRoYW5rcywNCkF2cmkNCg==
