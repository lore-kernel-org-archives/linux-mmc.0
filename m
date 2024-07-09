Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394F17B02B
	for <linux-mmc@vger.kernel.org>; Tue,  9 Jul 2024 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555591; cv=fail; b=kw5U68hGdZrCm4M7XbBDeipovr1ovOtYdRwqmLVhcHIYFxsvn6o24lYQa3ObSyyw/odgdyAd5CzEspBdRLM1hiV1yIcVV1Onc/BMzdOjh6LPTYnTAi7BeSNqRQjEkygUqab8LNJpKwV3gG6L5nif184vB3aYXgLeBM4ztzAlF7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555591; c=relaxed/simple;
	bh=vw97lrHKEfV0eU/dsd4DAAAzEfCcQ5Qc2xLEGG06dqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TmD588/tSipntauV0Gx1haAP909JRyxlR5b3cfDfxjw+hIppR3/VoNlw+TEpkpYl9GVJtvcT+G/rLAcx1g8uBnNgL33fODnlrHVeSjlnqSTRe3vTrBc90J0WsUVo7SRO9U8jqKZTbYH72l/lLi7nsbk4e0/APo7GrqF0FI5Vx1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YiEhCSb9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ey6d7BqX; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YiEhCSb9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ey6d7BqX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720555589; x=1752091589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vw97lrHKEfV0eU/dsd4DAAAzEfCcQ5Qc2xLEGG06dqY=;
  b=YiEhCSb9bn9w5Cv50CQgs64z7RYXBbf3R4OgLeFJv7vO6M41xgwY2l/O
   CrDX5rvg9lEHOHxIUS1uwjDP5ETedlIRi2DJ5GlgVaTXsiT8elKzEgoNk
   nTE55rvzFz3bp/3ROwE6xphO7z4xc4yKAEGELg/wxV6woWxmNK/3InYVv
   vXdN0JAWEZmjurWyFEbj7SCI1x1sZDgJXy4MGTfE9Bs94GOynw+kJ6kEg
   zu83xwH6W/oGdcTrhD60Z4FcdItl7GYnByHMQtJoZsjPac5mDxRq1cu2J
   VtK/+CdkP9BSW6khVR1bS/KloCWZfJ+lKW551B31yw0hlTKhL05I6X6wr
   w==;
X-CSE-ConnectionGUID: x/9p+ZCUSpyrudq7LV6a+Q==
X-CSE-MsgGUID: +eLo2aDUTPWGUDK+SjpKnQ==
X-IronPort-AV: E=Sophos;i="6.09,195,1716220800"; 
   d="scan'208";a="21303699"
Received: from mail-eastusazlp17011007.outbound.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.4.7])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2024 04:06:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh65G2ZI4Nm+1X5EfnKhnTbDg4nU9bOJQbUfTjMI2ZsHH0bztrjjfUdsmsKjPr12foC+IPOOSPULo6e3hBuAXC6ZLThRTQa8DCIcrDDM1M3lj7lgRgOmELWPT/5FCYTLwx5jAz406xp6AvTDGSKTLjAxXzYGtUTtpz5EubeJSKMMqHRmytWkR/66x5ldTnwA3a+CbnyRzILiZGPZlKeoC5PakHY1X6FywHXuQqCizdlWZBRZhY7OakIMpsHCffzxCq60mCWSZVAY0yMaQKLSHRU9fnLcgoo/jj31+S3eb5Yg19n4SkmzyoBWiBMCq4JjjEqcyo1tO6Q6NmXtG/6X7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw97lrHKEfV0eU/dsd4DAAAzEfCcQ5Qc2xLEGG06dqY=;
 b=OZXb1uKsvteTFCMNvJkxhyTPhDzByW+Wr/U3zsJCOxfLKq5+YclYNq+GyhNbCUFSAke2E2IfMMfVYXlhVCalFQCIXAOgPbd89AJwhRkrL6sCXWeQLePpYRx/aGn5XCmhYdd2cqKIA/8q6SdSO+p8F+H+jZY/yiVRYcFh/wj3si2cGpO6OrcjtK2In8BJbjGu1ABOFO+f+Y9euVoh/PV7xu+tVRjaE1oVpgKHOCTeZFtSkQQ7XaDr2sWMBEw2jH1OtUofYUlV7adfZG06w6K35rkBI8LzT6r93BRZjGlzIG82xRUsmx2q4GU5779DY6Of/VkCVd+xHJQMXBZg8iO+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw97lrHKEfV0eU/dsd4DAAAzEfCcQ5Qc2xLEGG06dqY=;
 b=Ey6d7BqXfX1ukk8MEcMYBbqb9GexQ5YL+uZf9WI6RO+E5w8Deb8nBxjbxniwDKafCQ8MXmp09UXfJ/aNXciELuyTEum96aEjeL0TH2g9IqekvwALbwHO0YsCka8YHqeptGPWaIP5hrJz9IXH/zy/aBqjTbOx+1l/FKvoFodNAcQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY1PR04MB9587.namprd04.prod.outlook.com (2603:10b6:a03:5b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Tue, 9 Jul
 2024 20:06:21 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 20:06:21 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@danman.eu"
	<linux-mmc@danman.eu>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v4] mmc: core: allow detection of locked cards
Thread-Topic: [PATCH v4] mmc: core: allow detection of locked cards
Thread-Index: AQHauBNeZ2lQZ81CBkKpvc0IuwzTHrHtCVmAgAH7aoA=
Date: Tue, 9 Jul 2024 20:06:21 +0000
Message-ID:
 <DM6PR04MB65756BE6093A5173C58CE9E4FCDB2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
 <CAPDyKFpvPaBwKdadCBC2LHTFGaEEjRN3ZrOC+PXp16aZKgPY=A@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpvPaBwKdadCBC2LHTFGaEEjRN3ZrOC+PXp16aZKgPY=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY1PR04MB9587:EE_
x-ms-office365-filtering-correlation-id: 5240f138-b993-4399-bff8-08dca0529a51
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bm5UQmNoZ05NTUtzV3V0Wnl4Vkw3VjAyVDlnK3BTYllhbllVdVhSUEdEVndr?=
 =?utf-8?B?MEFFUE5hQkh6ZmVwemV2MjNpVkdBQkFNYnRHbTVZK3lyZ2t6V1hBQTd0M2hB?=
 =?utf-8?B?VGQ0djhBL3kwRGpoSUVPdWZiSkJBcXFDcDV0czJjSmUyNjRQZXdWTzZKU3Zk?=
 =?utf-8?B?RlVXWWs4dTZTZkFaOVpkZC9Xdjl4MkdBNmdBM29OZlZJZyt5OElDSklnT2xt?=
 =?utf-8?B?VzAxSW5YcUNxR3lFTFZVUkk4dTFUOXlObDV4bUZyUWIrdm43Vm9XODRyRWgx?=
 =?utf-8?B?Z1Zmbks3WDJhWTEvZUY5RlFoSFV4QlZRZDBaUXdVdEtlOEFNRlZ5YVV6b1pT?=
 =?utf-8?B?QXphdEhSZmR2VnUzSmx0VlUxRHlEZjFYNThZMitRVVJ0THlwc1NCNlpkUW9v?=
 =?utf-8?B?b1dFMk9OSDNRdU1kYzVmV1kyQUduZEpHMk1Hc1pSVWplUTZFWnQ3eTM3SEE1?=
 =?utf-8?B?ajAydXQxaS9kemhraE1mdm4yNTViRlpnajdvUzFjYnhsMmpkRnFaRGp0VFBu?=
 =?utf-8?B?eGxrR3owb3hBc3RRN3dMZGoyekVleHJLL1NtdlEyYVd0a1ZxbEdJdGYwRFlU?=
 =?utf-8?B?ejNHODRDcmVkQUNjditxRGZySXZKdUhnR0ZJMVBIYVNzaHNORHUvRDRPWXVi?=
 =?utf-8?B?K01VN01sRCtWMWQyVEN6QnFDTTkyVHV2cVJVSi9FWm1tWDFLUGxlRXZ6R3pE?=
 =?utf-8?B?OUp1ZTQwb1IxeUNCaHRuL0RMZnRTemZGUHFoeUVIMmtDc211U1pwMjFkdDR3?=
 =?utf-8?B?VW9lOGhwSVFPcExaampsMTd4Y2NodEtzSXNOSk0wd1RzNGhNUk05WEF1czNo?=
 =?utf-8?B?ZnRjYUVMZmNuWW5hbkExb2ovc1R0WmdxRWNDVlNmZ05IeGptTWE3S054ZTNy?=
 =?utf-8?B?QVU1M2k4blZoMVVyUGpyUjZZYUx0V3dCNm13dVBUNkdXd0pvTU4zRzdUV1A1?=
 =?utf-8?B?d1R5WW9PMW5zR1Vad1JxRWs1M0lKYjg0ajBqNUlURld3NGpRVTVQMnplYjI3?=
 =?utf-8?B?bHh2YTd2U3dseWtzUjRWNkFjRmMvelVZYlRkWi9LTGhUVTNsdUV3dWtHN2x3?=
 =?utf-8?B?Nk1BVTVHR3plc1IveXlBTGQzNVV3QnN6MlUvUFhpMkNPOW9ZZ2dlRnFHY0pz?=
 =?utf-8?B?Q3pOS2NaY24wRUJER0hLZ3Q4REI0S0RMa2VkQ29TZXhxUStQQVIvNG9QNkdy?=
 =?utf-8?B?TDF5MUZKS0grazNuWTMxMlJ1WkRKMmlEYW9RdmtESy8vRmVCcU5jZjA1ZVdE?=
 =?utf-8?B?UGR4cC9hRFpVRWs2Y3cwMFVoVmhnaThzTTdRc3JGbXVpYUJqd1ZzUEh5VWJw?=
 =?utf-8?B?RWZCWnFDRjhtay9FV0ZUTjkyejNxazBlSEM3a3h3bE9teUt2UWR1U1pDNStT?=
 =?utf-8?B?VjAzLzg2QUovVU14N0w2RE14cnJNdnZIM2ZwVE5tUXlYL2ZKdTlqekZEc2tJ?=
 =?utf-8?B?OTI4azRkclh1MHA2OUVjc200SWpnSTZia3FiTE93YjlLTkZOL2t1bVRRV0R3?=
 =?utf-8?B?ZnhGSFphS25LYTRpSWFiUUJTbGI0Sko5SXVleUZkMUpCc2gvSjhBbHdtdDdQ?=
 =?utf-8?B?ajVRSXJ2c2x5cGEvcUg3eUp5K01hL1pQV1R1andxZHpwL2hSeHB6dHJEMEM1?=
 =?utf-8?B?WHVPamFkeHBIb3JxSmVSZEVMaDM1aDlMelNTV1hTL1Uvb3JiSGxFRzM0SDlK?=
 =?utf-8?B?SXVEa241dU1xNnJSQXlpdFRSUEJDQTlrdDNMOFdFQ2Mzb1pPM0lsakVqbUFR?=
 =?utf-8?B?VFZRdnEwUThEY2J5NUt2TGsySzNmYWpmZTIzYnRKWml1TXBLUlBpdE9qcGhi?=
 =?utf-8?B?dVhxMVlSanpvR0IwNzkrbXRhd0ZKbGdLVXVyYVFzN0hTclk0V3ExL0Z5MUlE?=
 =?utf-8?B?QXg4Zm9qUnZGUkhKNDU5bXB3ZlBpb0FRWEpzR1h2VmFJenc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cTEzZUZVTFUzWWhENWNMS255OU0yRG12MkFYUHlwMHArRms0SHBzYTE1ME94?=
 =?utf-8?B?eXVXZmhlQmNNSVJ4WVkvZm5IQjBxMmcwNnJjNXJZckRFY2x6aDZKMEF3RHhE?=
 =?utf-8?B?UGFXVmJ0b256LzR2SUpRNUNxdFdvQXNzN3hvWjNVcG1yUEZsVERRejVXVDV3?=
 =?utf-8?B?TmltRzMxQWRqd2doMVc5RHNsVGRRMnVuUzRETlplWkhFU3lGUWl5UWdSWUlM?=
 =?utf-8?B?eFhZcU93NzBpTUw4N2lMbHZGZk9HN3cxSW01dWNDRXoyeENWd1NObXB5c1Yv?=
 =?utf-8?B?T1BESEl6dHhzNkFvWktkVHhsWFYvSzA1TVVLYnZxcFhQaXBadnVIdTZqS3NE?=
 =?utf-8?B?S1JpNUpFanhickFmV1Q2QjZVT2tTbFhBdUxDQWdZN3Q0RVlSUDh4WFBrRXM5?=
 =?utf-8?B?Si9yN0IwTzB3SE1nU3dudnNqb3VGcUNkcEpENnJ4cU1jQ09oNWJYbytlZmov?=
 =?utf-8?B?WitSOGxGRmdUa2dFUzFTM0NnNlJqaUd5Um1hM3RzN05CM0hVSXZRUjVRMk5v?=
 =?utf-8?B?dUtHMTdoN1d6VW96Tmg0enloM0RJc04yQXhmUGt6QWYvcE1raEVRZEw2SVlK?=
 =?utf-8?B?eTl0RGFGU1hJNHRNMWVwZGhJNXo0dXNtRDdtbjg1Y0J0aUVxL2hwcVFKcWhv?=
 =?utf-8?B?SVYrWTFxU2F3aCtDOTVPNHdzRE5qU0N4VE9mZFVWMXVnMnQ5R0xjbFdjVUxj?=
 =?utf-8?B?SldWYU5xbzhtUkVIYWRHaXNhT3ltMTI3cUFJYTBveHEwdmtDOTBYNmZqempp?=
 =?utf-8?B?VGY0MUlmdVVUSEFtKzNyUHRkTzBUZmd2NGNMajRyenEyQ3BDdFlVVjNXWWhr?=
 =?utf-8?B?OEk0UjVUU2x6c25CUEpuekhrTjRqZ2JkTExodmRDcnJSQkVSRVdoNjlOcWNZ?=
 =?utf-8?B?MS84M0ZsWDM5Rk9tazg0dGN6NTFYQWpNdnBmemJZTGdzejRtMG1XblovZ2Zl?=
 =?utf-8?B?d3JGRVgzQ3dLSTJya3lXQ3QxZXJRaE5pRWV4WG5SQUh5bmRtaUgrdVltamph?=
 =?utf-8?B?RDdONmNYcG5NVG9xRE1talArZEVxVzlnYnJsdnRUZGJNWVJ6REdUcFczN3c3?=
 =?utf-8?B?bDhnaE9CV1VBU0ErNjRHZnYzUTVhV28ydkFYZUp1RldtTTl5U3EzQ1k0M2U4?=
 =?utf-8?B?dWVCaXFLOC8veXdrdVh5bmdiZlYzS3UxRmcwRUtBN1pzamovTnBsMGtxSnZL?=
 =?utf-8?B?eVBFR0hrNVdPYmpFZ2pLWHhpaUdwZGFnWnlqN3g3VFp0SWRrSnZZdDUxZmd6?=
 =?utf-8?B?L2JLZGhkRE9BdkhabjZDNWpoK0dET3l3NmJNb0d3TlRDYjZNak43VkNhSmNC?=
 =?utf-8?B?WTRnSHowN3JFSTNNcTY0bVpXdnVndXZQMjlTNFJCZGoyT0dsUUQxaXdDb2Fl?=
 =?utf-8?B?Q0c2U3hDbWRPQ1gvYzRFalJ4UFBTZWdHRDdJc3FwU3NpUW1rdzFpZjlvOU1y?=
 =?utf-8?B?UFNndVZhVTRIZnJyb1V4VHd1QVVzRlY1ejZVdFlUNWtvZkR3MXVzZ2N4Tlh4?=
 =?utf-8?B?T1VjTTBvZ0NGSEdSeG0wdFR4L2pMRUEyTVJIdGFVckNqOWFLYTB3eUt0NHF2?=
 =?utf-8?B?T2E1aDhEczJqYTZlOS84MXlwV25XSUxxM3d2NFM5QXVCa0VVRTdjdFhVRnpG?=
 =?utf-8?B?cng4WS9VVE85aUlIa2NTK1BiRXEzVmFGZzA4WVdCbWh0M2UrZXczMndyMU53?=
 =?utf-8?B?L2VJKzhLUXJKdXBiTWpBdFgwMEtpVXdGUjQvV0dRQkhUczhPMWhpcWJhNk0y?=
 =?utf-8?B?UlEraWJCdmVaRzVkeWFvSUFmK3oxbS9kWkwwQjNaOVdERUhPOTN0ZVRoT1pq?=
 =?utf-8?B?aWtmZ3p4VHlWd0h5S0hJYUxYeTJrR1lhcXlFQ1JHeDlqUmR3NTFzR3JPenl4?=
 =?utf-8?B?Y1dUajRaYXYzWEk5Sy9sMDhzMHFXVWJ4VkJUNUNnZU5QNlh2Z3h0RE9KVmVP?=
 =?utf-8?B?OWIvTG1qRTVyNW1GSTlxZllGL3BCb21SRE5lNGhHb1hsMFhMTFduK1NzNUlr?=
 =?utf-8?B?SEF1b2NHU3JOSU1jQTJReXdoUUtqS2lhN3QySzN2bWIza203RFFtcklBYmFx?=
 =?utf-8?B?eDRYazcrRXhtTmFycENUVUJiSzRqR1RHdUpzZFV1NS9xY0NEeWs5c0RFTzVB?=
 =?utf-8?B?T29hVS9Ld2ZkYmJ2OGJHSFNlbnM1ZFdNQWZ5NzdjTWJYVkc1SjZyNkp6Lys2?=
 =?utf-8?Q?sZkwUk2Bxp0WBqHHVJ2pHR9tgf7vHRbzb9cpHPpv6hZU?=
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
	3o6/MOKziOnwEZX0lIsZSuAnIcdMFDsUqOlm6Xfv0a3P4/7TWUrfkxCuTM6D+MUs+yZKMcrMEyOeOyYDn+kZ8a92y78b/ZfnQ0IDpV8mLYvYQdnffOTlaFHdry8F/OXYbd+bni6Q4UGxb7oeqxBk3pVJ2aBXx47iOCd/C269Vv8N4ZOxtLQmhfodaQXILAmf98Xy1mxTctxvQcRwDV7wCobgnhNtkHPx0i9LTzOSpwft/sVP8UnkimZtv0q3W/c/U7uJC3fmLX+NeAwIlb14ApyK0CAokDKk/j15gW47KlPu5AJx0Zjh/krRpF1lGTVOp0kKAkh9y0dbDxNufNzoxdZmk82nQYor27z8Bia2IoqIgNmcKH2ChAFhmQQTrfelDwvr0EfJVIkAzVS8NGgzna3lL6vTvCu92wYALIq/x2ZoJJcgZV21uUQeeIi0/uQImCkHj5gD1U5+4aHSDP2i/b5EEtCXi+DgrBYvpGO/SuQ+2BtnSaLYmdpYmsRJhXKD2y2zrCC7GsiixaH7+DaNT/OW3wzSotjs3VsLs/xH95ciCDzBSCq7WPit0izdG80uoXgE4PU1YTTJKmn1yXQuWIsmwmLYiNb4trQG4kM99MDqIKz90JwzdfohIEiO0FF0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5240f138-b993-4399-bff8-08dca0529a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 20:06:21.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ms0VDabakU7utKF0kVphx7PrIEdhwyU4neHs0iiya2NNiG2qaUo2QIKe6yd1JrkbXF8GUD94+PI4Aid/GNSe+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9587

PiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCB0aGVyZSBpcyBubyBwb2ludCBpbiBzZW5kaW5n
IHRoZSBDTUQxMyBhYm92ZSwgdW5sZXNzDQo+IHRoaXMgaXMgdGhlIGZpcnN0IGF0dGVtcHQgdG8g
aW5pdGlhbGl6ZSB0aGUgY2FyZC4NCj4gVGhlcmVmb3JlLCBpdCdzIGJldHRlciB0byBtb3ZlIHRo
ZSB3aG9sZSBwYXJ0IGFib3ZlLCBpbnNpZGUgdGhlIGJlbG93IGlmLWNsYXVzZQ0KPiB0b28sIG90
aGVyd2lzZSB3ZSB3b3VsZCBlbmQgdXAgc2VuZGluZyBhIENNRDEzIGluIGNhc2VzIHdoZW4gaXQn
cyBub3QNCj4gbmVlZGVkLg0KUjFfQ0FSRF9JU19MT0NLRUQgaXMgQ01EMTMgcmVzcG9uc2UsIGJ1
dCBhbHJlYWR5IGluIENNRDcgcmVzcG9uc2UgYXMgd2VsbCwNClNvIHRoZW9yZXRpY2FsbHkgeW91
IHdhbnQgdG8gc2tpcCBtbWNfc2Rfc2V0dXBfY2FyZCBhbHRvZ2V0aGVyLg0KQUNNRDYsIENNRDYs
IGFuZCBDTUQxOSBzaG91bGQgd2FpdCBmb3IgQ01ENDIgdG8gdW5sb2NrIHRoZSBjYXJkLg0KDQpU
aGFua3MsDQpBdnJpIA0KDQo+IA0KPiA+ICsNCj4gPiArICAgICAgIGlmICghcmVpbml0ICYmICEo
Y2FyZF9zdGF0dXMgJiBSMV9DQVJEX0lTX0xPQ0tFRCkpIHsNCj4gPiAgICAgICAgICAgICAgICAg
LyoNCj4gPiAgICAgICAgICAgICAgICAgICogRmV0Y2ggU0NSIGZyb20gY2FyZC4NCj4gPiAgICAg
ICAgICAgICAgICAgICovDQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0KPiANCj4gS2luZCByZWdh
cmRzDQo+IFVmZmUNCg0K
