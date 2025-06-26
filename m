Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7491411EB
	for <linux-mmc@vger.kernel.org>; Thu, 26 Jun 2025 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750921432; cv=fail; b=XmHIAA4We4dw5HwKbqcwHFe7MNdxqHFx+o7W5KiiSS4Mx5BIN1RB23JZPOsiTShXl5tHw3oxKqZK7MCiZgTT9nog6ALCjh95TBNpd0RCC0YnrGigZJobzY8cLS6/ByJHheWOlH0vpyf78TlcglQxp5Xx3bcLvRLJ2+ocds8BiM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750921432; c=relaxed/simple;
	bh=/fEVT3foRj7lT+NUfXA8rEm/7pxoxtUjdGQP2A5dzk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aNeS6EBiakPvGjAHmSZHZ1CUarKj73nPA/WLpqanog1JblcPMh3eH4Q9350ZEHC64q0RPJainjjnuVRtAeeMt6RqFoVBWLLMrHJG5RrlmqB5ssfdlMFXRcfS4IjCnFZoe3QXGumRjyeubY6gAGW13jEj/1RscivRwQcGVFjE5o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=SOnBmxi2; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="SOnBmxi2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1750921430; x=1782457430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/fEVT3foRj7lT+NUfXA8rEm/7pxoxtUjdGQP2A5dzk8=;
  b=SOnBmxi2Oq6QJ7KRR6ltm047gqeU2i+eppMldR7dyam20iKhqUWrv9KF
   Dg5mbK155DooD9VNLUmJfQvkqjqtSkBu3ws9xRwojZg7FaOc9exrrvOe1
   9au5/x95KQHIdTrLDOKaS2f/Vi6nEGn63ousqc9IH+qzSE/kf74Idybz4
   KLa7SgGpzt8rWvluoC8rdliaFvsb23hEM9xutNOEkAkRP6GZLYpaeeHxk
   1PvDBcR8703pxdelON/CY8gewndjiEuR+/gPYZ3uPX3vzqber+23kcxOE
   d37XmXicW/etVEP+1fzW6A2IiIDnRzT3ryHBZWfjtqfT5KzES3aArP/ph
   A==;
X-CSE-ConnectionGUID: VirUm5AESX+PHxPvmRdLsQ==
X-CSE-MsgGUID: AbKfphvEQh2TABAu4hbnJg==
Received: from mail-bn8nam12on2135.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.135])
  by ob1.hc6817-7.iphmx.com with ESMTP; 26 Jun 2025 00:03:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLbnkOD37oMC6s331LiW1Uh/1KbheyyCH8uYYJ5UiBIzNbZHtS1udpAPfiVDMcz6S0gaLTvcB+5Fz3Re7Q76ASjsxt3jKcDI6qJ41w/K4qwuWHxuQ5Qxe9xyXStxo9d/RqBkMvQnMVfF8EPvFLcZF8OgiN7KQlf16ZGFhLP9H6lKAWxydSk9bnuRewNrCVgBZrcx80txQwB9eeH/s+f6uP36GzLFfalSW7kpDgA8r+VBx9J0bH7Nw4WM9DHAOvLx1SHKqL5kaieCozXQkqQqYdd5icPrjNRWhFa7uBlQ7sfcliXd3ceov8pruGnXLZlhD1uaO1sZiQc5PWOmUo9l4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fEVT3foRj7lT+NUfXA8rEm/7pxoxtUjdGQP2A5dzk8=;
 b=Xut4rWrHf3ssgwM+w1E+qz215dqYEAaj5baB54l8kuhUI7+IHo0pRnjirra2Aw7J10aX85b10FtsoPcF8DAtNawiEVeRsOsBi1ycoY3jywrp2zITmDRxrpH6cG9CuiVPrNF2QoEm0ZByfyXZSPperL+PdwdTEta3AD9LPhldd7umc7rL0H5JTQP/C4+zKmeaOY6+pK+Kbmxfh7tnXGJ8HZrcSk0rnmByF2NJwGrp/90lst3uJrog6RkbytWIShoGe4kT5MURpcTSYozQQ8N93GPTGJ71x4bikm9xsNMxVakcHAPQ7fxaZ0XcVJbK/jbg6EP7zPjGekGq9eWWFfoEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by PH0PR16MB4023.namprd16.prod.outlook.com (2603:10b6:510:52::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 07:03:41 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839%5]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 07:03:41 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: mmc-utils: Completion of error handling
Thread-Topic: mmc-utils: Completion of error handling
Thread-Index: AQHb5d16Ob4/h/B3wka9sCwBsSkLe7QVA0ag
Date: Thu, 26 Jun 2025 07:03:41 +0000
Message-ID:
 <PH7PR16MB619651DAF605B93FE8E839A7E57AA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <f1bcf11f-817d-4a57-8084-fd1e1e5c5140@web.de>
In-Reply-To: <f1bcf11f-817d-4a57-8084-fd1e1e5c5140@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|PH0PR16MB4023:EE_
x-ms-office365-filtering-correlation-id: 2ca50318-899e-4537-4ca5-08ddb47f956b
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjV4WUF4Q0pDbXJIbnR3Z0FNU0xLaXRVSjMxSnh1MS8zd2w1eDd1NVdRdkR6?=
 =?utf-8?B?Y0Z1TzBNK3pPaTY5Y2I3UHhPRDI5Q0Q4YlZqQys3djJoK1ZVT05ZakZRYlR2?=
 =?utf-8?B?Vyt0UWo0S296NExMZU5tbjdlQkZXYzNQMjR0RHgrQlZHRnFCNk8wd012SE1z?=
 =?utf-8?B?azhpZzdQZWtNNENJUktzaVloRXF3V2NvZnIyVVMwUDNBM2F0MTA4N1QzQTVy?=
 =?utf-8?B?b0FPbFI2bzYxc2VvZDkrWG5lUVlhMytQMEtKenUyeWxQQlBXLzVSTzJHZlND?=
 =?utf-8?B?Z2RzNlQyN1FHWDk2SmxveFl4cU1rSnI3UElQdzZDM05WZWpQNk5GK21MVEtX?=
 =?utf-8?B?QVNOVEM0NERLaEpLNE9ibVFKNUF2M1hMMmNTNVdTbTlxUVVKVW5DRVpsNzZr?=
 =?utf-8?B?TVJhbXYvWGNkWjVkRVF1TGtQVTk1T1pJVEQxcUJSQzBsdjNqWThGbXpRZmxH?=
 =?utf-8?B?a2VYZEp1OWxpUUN3OTlOWnAwUzRROWY1MC8wRDhVb290SE9mSjBQQXpFaUZI?=
 =?utf-8?B?UTRlT2ovUFBKYkc5UVA1YlFjSnl4MDNvNkY4ODZVSE5LL05CaFdwTnhqRmFj?=
 =?utf-8?B?WDNUNDlSWG43MlRDeUt0V0x5blV5SUNhRGVZb3FNbUxLWnk0N2JreXdpMEcz?=
 =?utf-8?B?d3B1SHdkdHBZMVRRd09qZ2FLMityUWdEVlN5cnMzL1owWVhaRmtxVnpCWmlZ?=
 =?utf-8?B?ZGN4enBQeHhRN2RDbTJFQ0treG1BR2hzRUQvaHB0MHVsRllpZG52aFc4cXRM?=
 =?utf-8?B?VEpIU3ZuTHphVktGTkhxSWRVMmlSTmRhR1hreEtDMTRIZDVlU2FlSUtKZWcv?=
 =?utf-8?B?NGJxUW5EMnlXcnd6dFhERWxuTFkyckZzMXgwelZzZ1VtcU5kKzFoeU1RZGZX?=
 =?utf-8?B?RHZLUlZFQzVmR3pYdXJ1eXg5dUg3djNIM2NHTHVLNm5XeSswZUw0ZFdmL2Fz?=
 =?utf-8?B?d3hNZFgwSmUrcFZGY1dnSjM0QjJ3czNnMWxpdDhLSHdoK3REY2JjUktiQVdR?=
 =?utf-8?B?cmFyUkR5dUNhMm9PNE5UUTBuY0ZsSGVscFY4NUI1UnQ4Nk5PbTd5VnBrYnpN?=
 =?utf-8?B?MUJUZ1F2ZmwyZkZmT3NTeVVrbmcxVG1CQ3ZwVDdJTkJIb2g3Z01mN3hYQ1k4?=
 =?utf-8?B?ZGlpU3hRbjN2OFpKVFpMUytpWHZjRVlEYkt3RlVXRDRaR2pwckFUT1h3VGgr?=
 =?utf-8?B?dVJlaWcrdmtKZGtDQzlpdktlNEpWYy9PRWhkVThoZGV4NDhlUTkzQTkwZ1RD?=
 =?utf-8?B?cjNYSHdOWkpqU2trRW1VT0ZJejNBQmp1L2E5TG9VazZwZmgxRmRZVVMwdHE0?=
 =?utf-8?B?LzFJdkh0Ump5cnovbXNDZm9MRCsyeHlyZHNnOVBwNDJLN29HeitkbTdrM3RX?=
 =?utf-8?B?OE0vSFJmMFNsV1g0RUFSaXZPSXdxUmEvRXpTQUh6cUovdjRWVHZsS1Z2V0lL?=
 =?utf-8?B?L2lsUkN0L2xMNFhBcnVNNnJVQk9iWVFadEFvWGNzNnFTdlU0aENlMitFSlhu?=
 =?utf-8?B?dFhDdzVjRmZqbXVNZEU3KzRuTjRYeVdpcXo5KzJmd2JDM0ZFc1R0MW1LSWtu?=
 =?utf-8?B?ZkZQbzYvdjVreWtibThvNmh4SkZRSCsya1NEQThkalRDZGpGSjRwbVIxUWxJ?=
 =?utf-8?B?VUd3dTVzcC80cHUrd1g2a0FBNExFNTlCMzNMVkh1K0lOelVNeVpubkFpNmJm?=
 =?utf-8?B?OVhEMHRuazdXVlBKemF2dFhrcEJkZFA5V2hMLzhvMi9NZnhXNnhvbUxrVm5L?=
 =?utf-8?B?UVlVVlRtK0d3WUVkTmFSRnhlU1kwT05hUXNsUGhaK3I0cFMreHFhaWhtdXlP?=
 =?utf-8?B?amIrblFmRWlJNHFFSDhpNXljMk83QkJpRzdpeGdrdkYyWENSVTlVSUk2NnVt?=
 =?utf-8?B?MWF1Y3FvajJtcUovVnNaNWRnR2tJTUNFak1qdTVkeXppUkgza0l5OW5PLzFT?=
 =?utf-8?Q?vw4NShBH+hM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1NUK1RVcmo4bWU2YU1Qb29wZ3Z0Mk9aUjIyeXZ5WTAvdzFrdE8yL0hPS3gx?=
 =?utf-8?B?aW5mOTNhWVg2dmJnREVOUW9HdHFpb2UwbkN0bVdFbU9yWGx2Z1dySUNLRlA0?=
 =?utf-8?B?S2UybFVPaS9MQXdKSlhDSGRsV2JMMHU2Z0xoSC9na1J6ZFhndWlBcnVnWUxQ?=
 =?utf-8?B?N3NIbSt1dU1CNEp6MGs1dy9UdkhiN2J4V2c5cmJxMjdGMldudlRCTXBSL3lJ?=
 =?utf-8?B?NDgxRW1kMTZXU3FCY2cvUDlJQ2tUMzFzbnhKdFdjMEl1YUl4L1Znb25icXBl?=
 =?utf-8?B?OVF6MzJCRlVraTBOUXlkWHR6cWc2Wm11eDNHNnpidHBkSG9TSlV0SHRwTlZR?=
 =?utf-8?B?Y0lhUU44cjhmRnFIaWRyY090Tjc0L0p2ay9rbWpuNGhQc1F3dkk4ZmlpbkNy?=
 =?utf-8?B?WjE2QjRUdWN4ekx6b3ozM3J5S0YvdjBVb1M0MVZRMFJkdVdBeTdnVE5mNVNP?=
 =?utf-8?B?VDVHV05OSFJLVnJDM0VYeGtCd1hkY1ZLMkYrQVhCYjVFMDBhdmI4L2xka1BZ?=
 =?utf-8?B?SmRZTS85UzRKNHJVS1B3UldRSWJnRldmMjBvUHI3ZEFYQlh2Vi8vb0R5bWY1?=
 =?utf-8?B?d0VFaENTVXA4Q20rQWRRL0NuWEI5d0JIVmowcmpvOWxOVXEzWmE4NDduWUtT?=
 =?utf-8?B?TEZCV3UzSWIxbWlmcS9nelZhc1BVVTFGOEZqb0JwdGNVYWpSc21Eb29SY0pH?=
 =?utf-8?B?NzlWbUoyaWJROXpBZlpNQm8wS2NzVGZlMml2Q2ZSU2RBKzBLYWhHQjJUVVVj?=
 =?utf-8?B?NzN5NVJKN050dHhLMFQxSlJIU01nTjZJZmpBeExtUmxHVjR0TWQxQTE2UmlP?=
 =?utf-8?B?MHBxdXN5SXpHRHhNRUQ0cnkwa3QyU01JZG5VNlR2Q1Z4SWp6aS84UStrd3da?=
 =?utf-8?B?YU43dVlHdWd5cnkxaXNqdHY4T3hsQkJzRURUeWZ6a0thZklwd3hyMTJhRUo1?=
 =?utf-8?B?NjNwM0RTZFNvSUdCVy9Bd2F5WE9OaXVQWGpWVy9KcWp0Vm5rSk03cTl6MkRj?=
 =?utf-8?B?Zkc0V1Avd0VmbEtPeENtRWl4SmxDMWJ4NmYreC9DMStPR0JZSWlnck8yZE5I?=
 =?utf-8?B?Zyt2bitvV0IybkwxM1QrdnZQYTJLZnBsMVI2WS9KTjgyUG5BU25yRFZyOVln?=
 =?utf-8?B?UlhWRzV2U2J0YjAwamtlTG45cDlzYy9LT0ljZFhURzk1Z29sQno4NkdKVWtT?=
 =?utf-8?B?MzNQRDBxOFRWYjFueks5aFVWV0FCVUZkZnZLUHNCcUMrNFlmWkpVNVhia1ZR?=
 =?utf-8?B?d0pzcTVEa1NUeXZBSEFodCt5RDBPLzlTejYySW9uVmNTTUU3M2hXY0FCVEZD?=
 =?utf-8?B?ZEhDUkZZZmtoWjlMTU81MWxRY3BvNXZZVmxEa0RzT1NJM2V3UFNxYlBUYXFE?=
 =?utf-8?B?V0g1SFo5YWZLUW5DbHVOOUtXYVpxSWdoVklUeWpBOXZtcEh0N3hpaUJPV2tp?=
 =?utf-8?B?VUlteE5mRG5yMUEvc01NR1kvbU9yRFI1N0Q2U1VUVTU1WDVkV3hvb3hWNmRp?=
 =?utf-8?B?UURyZ0MvUWtncjNXaE82d3d6UkI1QkxDUnl4Z2RlUStoOVFsZ1NTaHE2V3NS?=
 =?utf-8?B?dmJSSU1SbnFGRWRORFJqTEdyWFJ6WFJxZ3pscUZCOXNSOEh0djJobCtYeTND?=
 =?utf-8?B?dk53WEZKb1ZnV1FmbmZ0dVdxYVRYb2h1dURRZmwvSmw4aG9tOEtsWU03OVZ2?=
 =?utf-8?B?WjZvRHFxZGJUUVN5M2dpWkZmVjIvL3V3T3YxOFE5UHpsUkU2amtGTG1aYllS?=
 =?utf-8?B?V1BaRzhNMEdONUJ0aGVFV2VQa0NuSG04cFhuK2dBNi9mSFdkSFVyeUxlY1Ry?=
 =?utf-8?B?TkpkV0ZtSm94aGg3TlVqb3EyZzF0aXRFelVUZWF5dStldzBTaDkwQlRoaTh4?=
 =?utf-8?B?TGQ2WHh4TjdDeVZHajdIR2o3U1hKdTdzc1BLUkxTRU50YjFpQ2thcFhMNzRk?=
 =?utf-8?B?WVBBMlM3SmJYWFZSeE9ZUlNuZlRPTUhVd0xTbHE0TjFVR3lLYU5JcmlXcEFl?=
 =?utf-8?B?WUJUS0dPaC9SUzZkVTNwc05yQWVsUkFiSXJEa2R4RzhOL3pyV0V6RllUTUd6?=
 =?utf-8?B?TVJwVlVDNTBYVHpTaG13OXpIRktaTG1TZTdCUThoSm5QMVRPamtDQkZKL3pW?=
 =?utf-8?Q?QMMf8bg9N3sX+BrYinu+fBHvL?=
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
	8YnjjV5dMKhnWgi2Bk1bLZO7S04/9+dGcOmxp5AUIvXARwx+M/qdnkkFbFOT0atquUsQBLXs3Bj6GIGU06DAeWwfxXcAAUTAlCCZTaBbhzL0ucw5SCJw+A2u5AAfCPQZGgynpJT8c77iir4zFKPzmB5orpHbnbvjmTKz6zKwkAUV2egT0ylzSQX21ijH6BBPw38Z/II0IPUCja9F+FQqhjyD9Mym+3Ixt2jr1sCoSY8+g5RJGblEuuMxXz7+B3DjeezkOac3xw+SWNPc8GOCopfP3tUNF9wcsAEtw0LTWVKQa+DDV2khBuceT83riEZN81Msmc/rxjsUPmd23vZjrt+yB8vqJ7/CnmY2eAL8AJtDsJ2ei2AmdlyCb4CpdFr6X3Oyn8R/t2Pyl4W0QKP4fItces7zPOEVnLMJIDzHWIFBj/r+yQF5xkn+5q1uJpUJNlKh2qCE5fMnbtFWxHP9l3IA+98Qqu+QcBS8S28g+l+Mve2WR4hXiX4e4ukNDG0QFyXL5V5DfEZn3RI0+gJU6EvbQpQg0HRQH2A/S/rY/W50A38T+qf/mhtjD+hbicz8XvWC3INoweGpLd5qHI3i8x//NVuo+r0iCMOY8DJV5FC5N/Fz1ASnOgzoh/Cr+D9b3sqxQSCbzfeJ7DxLHzaa+w==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca50318-899e-4537-4ca5-08ddb47f956b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 07:03:41.6659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5280auuBf4JK81khzGBE5K2WwDPkN8blU5uFjovdgB+Tmn8l0OIPhvjjce/SKozVWfcVCaUioIVWTC8IGwnOwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR16MB4023

TWFya3VzIGhpLA0KDQo+IEhlbGxvLA0KPiANCj4gSSBoYXZlIHRha2VuIGFsc28gYW5vdGhlciBs
b29rIGF0IGltcGxlbWVudGF0aW9uIGRldGFpbHMuDQpBbHNvPyBJIGFtIGxhY2tpbmcgc29tZSBj
b250ZXh0IGhlcmUuDQoNCj4gVGh1cyBJIGhhdmUgbm90aWNlZCB0aGF0IHRoZSBlcnJvciBkZXRl
Y3Rpb24gaXMgaW5jb21wbGV0ZSBzbyBmYXIuDQo+IA0KPiBIb3cgZG8geW91IHRoaW5rIGFib3V0
IHRvIGFkZCBtb3JlIGVycm9yIGhhbmRsaW5nIGZvciByZXR1cm4gdmFsdWVzIGZyb20NCj4gZnVu
Y3Rpb25zIGxpa2UgcHJpbnRmKCkgKGZvciBleGFtcGxlKT8NCj4gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL3V0aWxzL21tYy9tbWMtDQo+IHV0aWxzLmdpdC90cmVlL21tYy5jP2g9djEu
MCNuNTE1DQpZb3UgYXJlIG1vc3Qgd2VsY29tZSB0byBzZW5kIHlvdXIgcGF0Y2hlcyBvdmVyLiAg
V2UgY2FuIGRpc2N1c3MgeW91ciBpZGVhcyBvdmVyIHRoZSBjb2RlLg0KDQpUaGFua3MsDQpBdnJp
DQoNCg0KPiANCj4gUmVnYXJkcywNCj4gTWFya3VzDQo=
