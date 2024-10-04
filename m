Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB221D6DB0
	for <linux-mmc@vger.kernel.org>; Fri,  4 Oct 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045948; cv=fail; b=BSj97MG2FrecX+WXEw1pTfCUHjkh7yV02OD9P17xIf7cmzdNk4SpQmzQeiOXSsF3FdXXct8cWi4w2KBbA69TJfaWbu5sjrU/aWWqeAKnu3L7hZ2oMtM+MHx5tbRUK7WWDcko8X/3di0CpAFCxd02x1WCo8oqV/sn/Zv7HTV0K9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045948; c=relaxed/simple;
	bh=Jetb0+9siCbcKVp53VswxKYgYdl/6NwEsrJbNScK9Fc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rtLxDc8OXPbABVMp2TVeGZsIOrQLNwY3ma7rcxdoqBL88ibeJ/fnccsAhQPsXbQXW0b2OL0obFh+NyUJrxbeKK7niTrEWBSz3J98zHHbm/on24ARfARWobdTCA02Jg1zvMhV1maPEHBPr7vZ4MwTuPULKvzzytDQaw2ElvFwVj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NY/s4CRE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UmtlefJ4; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NY/s4CRE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UmtlefJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728045947; x=1759581947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jetb0+9siCbcKVp53VswxKYgYdl/6NwEsrJbNScK9Fc=;
  b=NY/s4CRE5zmMzoeRw7/UpFHlS08zHNBwVrlszV8V7dfc8kY9ejDX3bus
   iPAEwFVgjbxrd02L9Z9ZRmqZsBiAFq0NWdbr27T3lOeORROgI7Qvwa7hB
   /9yqw/mnoKmHW9F90Bt3hxCXAqlcGXj+WI0AM0tDcVZ3pbk7HRPrcRFZG
   IVAlIL1xgV4Ux7Hf4j741HF5PA+M8XnVet0IwcqOD7y8ARsMux3MWov4b
   OKEYmDinbi3LIkV8bHyldPXkCKXJmdA/nykVGyy6usJb2DccKRWB6CNm3
   rCO/Ph14lCoIcKyOPcIvjbIhmrs3quDUdPAh9H/+pQzii1wZUAXS9C7wH
   Q==;
X-CSE-ConnectionGUID: SprL92m1TBiiJQpxiuqB+w==
X-CSE-MsgGUID: e2fgazCrQZyOJYwvcVUnCg==
X-IronPort-AV: E=Sophos;i="6.11,177,1725292800"; 
   d="scan'208";a="27628280"
Received: from mail-southcentralusazlp17012053.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.53])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 20:45:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jo0/Yngw5YpgtTN3k93lgbVF9ByRASGTwqgkPERWK91qtHDPFLGpHC/1kGpzgnYphTHlgHR1Qh24H3VFDFLO+bINTiE1cQs7mwG1w6h5jDarfaOjemND/KjRSE1uaEntys9fXVoPg4jY96a606th9fGCneDQgAIVh9iP7Gnjr79Um1D9s7dhm7CpbeR4elmi1yO8WoNAaJjkghn2nKo5U9as5C/6DKmVf1FFnrgK+vOXDZIALoY+AVX0NXOZD8SmdT3Q2XUhe9rPHhahLozLxBoao0nTMlK3xvllEafd3LachZ3B4oITbejtXJdUwqPBdbc0RYms98ONJB9ZAO5jtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jetb0+9siCbcKVp53VswxKYgYdl/6NwEsrJbNScK9Fc=;
 b=ywlegAwHkSSNm5DDMKOlL5eYeEeqGBleTiZVPH2HensHfCY9hgZGY+M4nnSjUst/8kzslIW/lJyy/txj2fw1Nn506yf6BwV2TDMgV9u50R+jBnWobnHzvx2GhpI0F2Nn1nc3msaWZVK3DP+6NR30MVm1KI5HFlRCnF4j8pipdfrxQVh8vA5vrezJoEKiCV0Bib525BO/PjzbkHa86HfPTRQEKPNEuQpKBlOxd6PXhtmH5aq0GdiWjktI7HlXcId9O0YvyDIDGVjYmef4NJ3/LmgwXXDiAXpR0ln+JmmpFan7/NgMRPvZSbyWqQFYlRM22vXAqIVIwzu0RabMGgmzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jetb0+9siCbcKVp53VswxKYgYdl/6NwEsrJbNScK9Fc=;
 b=UmtlefJ4Xwim9B700MHk/EDUgKpq/yj6i5R5jpQ9ieK8lviaJr7i55FZEdFoXAvOv5mXk2fjDFLHGNHwwsnauCKxQgE1t9VC3efTLISZvKeD/Kcxo95MY9sVfPDZZyx6Xfj8CCfI12bUjwVzsqxdAlZ8wFH64g26nm0ekp//Tnk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH7PR04MB8662.namprd04.prod.outlook.com (2603:10b6:510:249::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 12:45:43 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:45:42 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Christian Loehle <christian.loehle@arm.com>
Subject: RE: [PATCH v7 02/10] mmc: sd: Add Extension memory addressing
Thread-Topic: [PATCH v7 02/10] mmc: sd: Add Extension memory addressing
Thread-Index: AQHbAdj9YxKhLNvUhUW+Q6Jiz9Q4crJ1V2CAgAAH53CAAR3igIAANbMA
Date: Fri, 4 Oct 2024 12:45:42 +0000
Message-ID:
 <DM6PR04MB65757A0237F63211E07F8106FC722@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <20240908102018.3711527-3-avri.altman@wdc.com>
 <CAPDyKFpZJQ7kGngaUmLfgyKNwhVjjGEuDw96kFBY3s6hXaEJTw@mail.gmail.com>
 <DM6PR04MB65755F48D1F6A263584F802BFC712@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFpebDAFKDsNYmLDbKDEvmi1oLXRb7LD1b1D1taHnRA7SQ@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpebDAFKDsNYmLDbKDEvmi1oLXRb7LD1b1D1taHnRA7SQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH7PR04MB8662:EE_
x-ms-office365-filtering-correlation-id: 30c42082-4912-4abd-11b7-08dce4727586
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3dYTGR2bCs3NG5VRHVTb0dvTHQ5MWVuVG82TERPNmx6OUdWZjhUZ1p2dldh?=
 =?utf-8?B?QWRaVkVmeGhXdzVGVlpteVFoYjBGSTJmdXZuV25mUmlwZFRoOVh4R25QT0l0?=
 =?utf-8?B?UGd5a1ErRVU5eUl5VURTNmg4dHdBMXMweWZkQW9XbTdWam80NzRjVHVMY0V1?=
 =?utf-8?B?ajVWaUtiWExTMTBGRXZacFBBUDMrQmh3UkNMekhiVWoxU0RRcmRrWEkwQ09R?=
 =?utf-8?B?VGJDS2tZTmNVeUtrbWh2Q0dQV2g1akliT09Cd3pwNy9NMHp3QjdzUGphZy9h?=
 =?utf-8?B?Wm9qSGdQNnVLZlZqQWkvSXl6M2pHSWhRekM0ZjUvRXpVMFpQK3RKWUJKU0dh?=
 =?utf-8?B?d3gxb0ZKSVRMenVjYUU0WlRJR3d6WDdGNktRWkF5NGdjMVhoV1lrUjFaMTlp?=
 =?utf-8?B?QnJ1T1JZN083eHc4eVNWRzZISFAzb1BkWitSYXoxRGFITXY1aWpwa2dLemxG?=
 =?utf-8?B?cEVpZHVxN2EveUpMdVc5c216YTVYNEdhT3d4VE94SEVSZnpEdjBPMDlvNjVI?=
 =?utf-8?B?MDdUYlRCdU5KNTJ3bWM2Z28yRTRESlBhTFEzY2NiSkc2d2NXM1BQelNVSTAv?=
 =?utf-8?B?cXNVdjVjMkExSDdHdm9KNTBSYjcydzBMT0JwRVhnU3k2YldoV2JsWmJNTFp0?=
 =?utf-8?B?ZmFGVXhVdWd3WUhiWDEvc0Zxb1NpVDZGWjgyLzByWG9LV1hQdU5jNGJtWk9a?=
 =?utf-8?B?bmo5SkxXLzBIeUk2NE03Y1RXaWEwU2JMNERHRG9zb0UwTDM3Mk1MODBIT3Z6?=
 =?utf-8?B?M2NOeVZJa1ZSVHFZc1NUVHAySmkvUDI4YWVSU1ZOL2JSRzA2dDNFVFdpWTRR?=
 =?utf-8?B?NlpEdmx5MzVFS3ZqOCtGbEp0LzJETllQT1FuZmpTWnBWeGtOTnJnV3hjaDRj?=
 =?utf-8?B?Y1YyakN5TXBsRThRWVoyVmJIZFI1NFVVRG5EWjYyTTNpRkV2SWFLUFVPSWF5?=
 =?utf-8?B?YVhqeStmRi9KbGxndzEwSFJyNUJBOG5pYWZ0QktjYUN3VURMMmlEdW9nV3Ba?=
 =?utf-8?B?N1RIZ2pReU50amJVWkdubmllckp3b2tMS2NRUXd0NkJNWitlWUFkUHhoZWFE?=
 =?utf-8?B?YlplQWRZSnlHRVlFcFBWVlI1SkxOcTBzc2RtazBLekZ3K2ZiMEVDQ1QySzN6?=
 =?utf-8?B?RVEzRm5nOXN3c0FWNS9QZWZGNmk2RmxhU09UbEE3aUQ3N2pXSVVPWXE3ZmpJ?=
 =?utf-8?B?V0xoalZoK2thNTh4Rlg5QmJKTnIxZFlLdjk1K2dMb1pmY0c4cTk4eVY3alNZ?=
 =?utf-8?B?cmZhTVRmWHVna3NwUDExMjU2UXNJcXgzeEhYaVZNaTIvckVPc2tVWEVTa3pz?=
 =?utf-8?B?bGExcUZRZmpZZG1HQVh1QlBGdHo0Rk41b0xTREhwZ2duZDZ2MGQ5V0FDNXpG?=
 =?utf-8?B?YnBSTEoyaFNId1FCem43UkhKQWtRTE1LMHdwL3c2cVBsV21NREh6WDV6c3Q3?=
 =?utf-8?B?SEFKN1JnZm1rbXhYLytWZ2tJaTZmMGEvU3FxSmZNK1YvUXBrbkVZZnpGd1ZB?=
 =?utf-8?B?OGlyUnlaRW44WEZaMW5WNVlncy9rT1N5SVpscUQ1SG1kT0o2M0tmbUVidDYy?=
 =?utf-8?B?SkxsaFJPWVY3ZkVLeTJWSFgxVnJUYVZ1NnFpSlRHb2JrRlB6aXJNT3VKMnFr?=
 =?utf-8?B?MlJ2ZHdvV3lKNU04aDFyNzhGYllQVE9wcEdJQkw3OXhxTVBOd1NBRDd1T20z?=
 =?utf-8?B?OEpuUWs2REdXajY5ODI5eFdpL3A3aXM3QnlOS2hUYkE1cEJVVEt6NFpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUoxOWhhRTNvWVlpUk1zelMvaE9WYW5mVFFid3k2cXVBRjJBNXRsaWpHbWVz?=
 =?utf-8?B?ZmFlSWFxd1V1RWZUcC9KMlp0dGVYRGRBdk1RNlpqL0laYmlmRG85QXExRER3?=
 =?utf-8?B?YnQ3eURyaE9lT0YvTDVJN1R6ZzNaM1JFTi9qSjIvUER1SVVKRTlpeE9WMnFx?=
 =?utf-8?B?NkRrS2RvQnZ5WERENzFEVzNoWDVWQ2pmNkVzcnQxVThhc1FHdE56RzY2ajdu?=
 =?utf-8?B?bVRTOVVVUWxJa1hLR3VzNjlqS2grMy9oK0xzQ1RoamFSOTlDTzhYK2FnYUxQ?=
 =?utf-8?B?amVLMDlXVDI0bUxkU0F4UTFuTTBQRVNlcDRWNnpWYklleGc4MUlBa21teG1v?=
 =?utf-8?B?UHlDY3Q2SFRENWdDc0lrRGh2SUV1WUpkb0tNVGh4ZmNsVkEzVzZIeDJkekFO?=
 =?utf-8?B?TCt6WnpQUXNYbVpxNjNaT1lveVluSGd1VFJxK2ZBdW1WSFVRdTJ2K3IzYlNH?=
 =?utf-8?B?MHIyMytNT1BYcjhHN2s2RGcrQVdpV2QzTGwzNm92MkdzZ01GR3M1TG44VWZq?=
 =?utf-8?B?ZFlsRHpydkVsWG5NeTJCUmVPa3p6czNvNkhoTENjWWJiQkdHNkw0YnNyWldm?=
 =?utf-8?B?MnVLbE16WktiamovM28zK2JBWWJ4ZTdMWVRubEV5TU5UR1N6SWZlNlFaTm9n?=
 =?utf-8?B?azBKaVJGVEJtdzJlV0U5R1kxTG16UmNJYWYzd0xQaDdOTjVqdlQ3M29INVpn?=
 =?utf-8?B?VWcvWnJIclZSN1J0cWluNk5XSDFIaGVTcVhLcXpjRHBHaFFzQWdSZ3Zya3Zy?=
 =?utf-8?B?QnlKSzFZanRvTTZidjFrWXQ4SkhZd25UcVRxM01DbDFrcmhDSFVsbXNIVVpS?=
 =?utf-8?B?M0xYVXdnTGY3bWhwR3YrRjkxcEZvQnhYVUhoOWI4enluUFY3M1lqcGZkdmsz?=
 =?utf-8?B?RGVhNzMxMVB4cXF3MmFxVHNTelE0eGtobDAvK3FZc2MxZ2RGSFoweHE2ZElY?=
 =?utf-8?B?YncvakNIUGRiS3RieHBMWE1YNndldTNocTFtTGpqU0ZNYURDNVYxYTRUaHZB?=
 =?utf-8?B?bHJmV1lQL2FYQ3VON0tpTzM5YldIZ2N2RU8vek0xNVUvYy9qMU5vdE9CUGRU?=
 =?utf-8?B?Y2tSdmdENFlnQ0doNkI5WUJGeHdLd0JxSnQ3SFM4ZDNNUG5iSVdyRU5KbXFj?=
 =?utf-8?B?YU1aZ2FwSDRNRUFlVy9FbS82YUhkM00xbTdMVFdpbG83NXVwODJNUGhMSnhz?=
 =?utf-8?B?OGJVNTNWaVE4VHNtZVpTUEEyRnFxcVQycmxoV3MxbXJFQTROT1VmUTU3S05v?=
 =?utf-8?B?dWw3cDREc25qYUhxeHpWYWoxMXhhcnc5UUptNzdPdXFDTHE2VlkvVmZWYk1o?=
 =?utf-8?B?TllYYjFQOVVsZ01DT2xHTHhNZm00TllWL3AvSlNxNTlPMmExaDMxN2xqZ1Rx?=
 =?utf-8?B?RENTUlE3enZUWWdneTJiL3pwcTNqSDkva3ZwTHBEcjg3Ny9zQXA0REJxc0RS?=
 =?utf-8?B?YUhQYTM0a3YvSjRXWG90SjRqRWFvY2NBbGo3RTc3a1ozWGRmbS9EeTBiZjZQ?=
 =?utf-8?B?TEkvdjBOWG5hZEFFRzF0SEYwS2tqdFVWWFBmQ0sxcmI2cXJtdHIxdnRRU3dM?=
 =?utf-8?B?K1NoMDRxb1lFaWR2QXBZYlduQkpEbkZ2eGJxYnFpdGQyRUpRYlpXVjNnbnFz?=
 =?utf-8?B?blVtemZRTWhyQk1QbXVYbnF2bnJuK3B1RlFMbkMvdXB2bHFndkIzb3dlR1k0?=
 =?utf-8?B?NDRDekhISjl0Yy96N0ZCYnppQVpQZzk3M1o0dzA2RnI0T2lSRTlsT2FYeW83?=
 =?utf-8?B?ZVZKYWNLa0FaU1AxdmJBY1RnMzVlamhNZUoxNkhYTVNjUFN2RjE0eThuWHAy?=
 =?utf-8?B?MXZjVDVHSW5vUVVCdjNhZEM4dzBFVGZNNHdGWWZnU2UwdUxsVld3OUpRUXl3?=
 =?utf-8?B?bHl4VGt5bjJBeDBlRDdOYjJtSUdIT213K3NZYXBYSTd4TkFwQkhNNk50YUo3?=
 =?utf-8?B?RXdmOHF5bUMrS3VQVjAzNWVVKzZVK21PVEhqck1GN0NtZkxBcTh5SmdsMHE4?=
 =?utf-8?B?VmZvZTl5WDAzcVB2NUZoSkdqL0MvdWtmTlI1KzRhU2lWOWcwM0w0N21oUHYw?=
 =?utf-8?B?TldLVmJpWUFQTnJjQUU1cEZESlU0N2ozeFRSUEVaaWsxbDd0MXYvMlhvZVZS?=
 =?utf-8?B?UXduZEFrbVBYWWpIYzhVT2VacExYT25ZS2JHeUdWamdkSTZ0S1FBaXRUMEdO?=
 =?utf-8?Q?d9A8zXjGXjsAQae7ZTapGQrUvOAb1LQO/+SofIG2vqCx?=
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
	tDw7w8mVNxKsSvzDkrJThxfkvdVhx0DN/x94Z8QJJ153xfqdkL6r5NOA0Fa+177kiheFvUhUsUfdRgzoTd5UKnG2VFXa9for8qPyzY/RmVy0bIN9N/QVcZD85tkqI7IjIJtcGf2PWMGTkzOMOcGEDOBf65d/aAVt4+iyQcxDhGOF3g1vF3sbe3JCKOfAnRJojwsvBJkf3/5X7VORgfvnqzBXjzlYb5uNtpdYgLdAWf1oXkyapu3ExKnhCVftTb9l+IzcWNXr2Cbg2plqSpBFtaVvuhkdJprS8PeLOYGPDOxQnkX4YttJi9ya0jkjXrl5k/ZmUaoPM516ju5AxwaDyqtHqIpbF8ngAuTaompOSSs2J3AdgzU6yM3kkKWpvxy0+cbNYVRqJqiln0ZHH+fPsB5qXlIYLau0uZfnxpjrYlmp54qo0KIdJQEp6rUPlHlxmznAH24Mt/pTZx+lVE1NdEbIEjbCNWUelxLBOxhXYRrXA/0Q6285EoA2Stv+JJvLSN7wbNu2xpnr+joj5Kaciwl6AVjWFYWD8yPCArDLULNcvFRX3Bg2qSax8fMIR5nxVpS4ZLNpwEBHTXS1ozZfjoJ9kd9snx60ZI+bhzULVzHpJbAehuF9SFV9nfFb1kDK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c42082-4912-4abd-11b7-08dce4727586
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 12:45:42.8758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRxZOYT87R4iAfpaapa6pd/rshE2jocrLitL0QLyap/nX7Nzk1ppc7jdQt55S9YYQGhuktGN/ka2jHclGFi/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8662

PiBPbiBUaHUsIDMgT2N0IDIwMjQgYXQgMTg6MzEsIEF2cmkgQWx0bWFuIDxBdnJpLkFsdG1hbkB3
ZGMuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gPiAraW50IG1tY19zZW5kX2V4dF9hZGRyKHN0cnVj
dCBtbWNfaG9zdCAqaG9zdCwgdTMyIGFkZHIpIHsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgbW1j
X2NvbW1hbmQgY21kID0gew0KPiA+ID4gPiArICAgICAgICAgICAgICAgLm9wY29kZSA9IFNEX0FE
RFJfRVhULA0KPiA+ID4gPiArICAgICAgICAgICAgICAgLmFyZyA9IGFkZHIsDQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICAuZmxhZ3MgPSBNTUNfUlNQX1IxIHwgTU1DX0NNRF9BQywNCj4gPiA+ID4g
KyAgICAgICB9Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgaWYgKCFtbWNfY2FyZF91bHRf
Y2FwYWNpdHkoaG9zdC0+Y2FyZCkpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHJldHVybiBtbWNfd2FpdF9mb3JfY21kKGhvc3Qs
ICZjbWQsIDApOyB9DQo+ID4gPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChtbWNfc2VuZF9leHRfYWRk
cik7DQo+ID4gPg0KPiA+ID4gVGhpcyBkb2Vzbid0IG5lZWQgdG8gYmUgZXhwb3J0ZWQgYXMgaXQn
cyBvbmx5IHVzZWQgYnkgdGhlIGNvcmUgbW9kdWxlLg0KPiA+IEkndmUgZ290IGEga2VybmVsIHRl
c3Qgcm9ib3Qgd2FybmluZyBvbiB0aGlzIGluIHYxOg0KPiA+IGh0dHBzOi8vd3d3LnNwaW5pY3Mu
bmV0L2xpc3RzL2xpbnV4LW1tYy9tc2c4MTUzMC5odG1sDQo+IA0KPiBJIGRvbid0IHJlY2FsbCBo
b3cgdGhlIGNvZGUgbG9va2VkIGluIHYxLiBQcm9iYWJseSB0aGVyZSB3YXMgYSBjYWxsIHRvDQo+
IG1tY19zZW5kX2V4dF9hZGRyKCkgZnJvbSB0aGUgbW1jIGJsb2NrIGRldmljZSBkcml2ZXIgdGhh
dCBpc24ndCB0aGVyZQ0KPiBhbnltb3JlLCB3aGljaCBzZWVtcyB2ZXJ5IG11Y2ggY29ycmVjdCB0
byBtZS4NCj4gDQo+IFlvdSBjYW4gZm9yIHN1cmUgZHJvcCB0aGUgRVhQT1JUX1NZTUJPTF9HUEwg
ZnJvbSBoZXJlLCBpdCBpc24ndCBuZWVkZWQuDQpPSy4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0K
PiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
