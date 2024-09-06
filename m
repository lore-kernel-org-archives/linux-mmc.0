Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE913CFB6
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617518; cv=fail; b=hN0JIi+qhg0+uGTKA30YPuwTuRo0RA/f+hye5TeuVmjPEkv+iQNOpN68y7Fum8dXOd4BJhjAQQsqqadcejOsWZ5/TaotOwrJfGOG+XFpHlSiw8GJAkYFtxuDaIcOh1rBaBSIaUudamRYlK2AAWcr6veoTWD/w9mVBz+1ayLw0QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617518; c=relaxed/simple;
	bh=2XeJpPGSBp8voRmUCyWEpR14HemHaLEhGfx4M4HON0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TNXRXwFEWFq2tyVUYmxWidsIlveM+atzYgywHgADIgccL78WohJw7PgSDwEbjC8s3IatlTe0QCoAMLwC6C9P503Yu6n3sYAUzP/17FoR8Pebezl07ZZGZbHIGTENNukdkfjXMqFoOeYd1YHb6MF7eHnZySMPXxoyWqwr8BKuccY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oTl8oLJe; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EK2PnDnB; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oTl8oLJe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EK2PnDnB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725617517; x=1757153517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2XeJpPGSBp8voRmUCyWEpR14HemHaLEhGfx4M4HON0Q=;
  b=oTl8oLJertGXIRHI6hiGWBlxWc3jFPbm3ZbNK3x/qtJbkxR60nl9cUkF
   KuDjQlx2zGtkHC3hUrSsOimDgO4mEtyHZTqXYrQD/C5aRwWtjPTRgTrk8
   izFwPP6jqsQPOAdwhYfkSaZhbehaR5WRRTBbjViCasgqI0XyYlmENfbl0
   oUQ0TI9fxKpo5Pv/UoeGSPlFytYdctmSgL1J3RZlO97UyT93nhcD+SFXM
   rEcj6ukuBJ70gHJY8ElmweBEAZxEd1QuJXXMvZFcag5Gesnxn9IG+RoQP
   C2npb88NqmWlnZeXcITNdE8fJX3Ih8EBGUdmn92jAwiA3557zKXeUaqkp
   w==;
X-CSE-ConnectionGUID: fBk6Tm5wThyBmxeVWckc9Q==
X-CSE-MsgGUID: I+TsisgKQAeiZSKJPr3Zmw==
X-IronPort-AV: E=Sophos;i="6.10,207,1719849600"; 
   d="scan'208";a="26080778"
Received: from mail-westusazlp17012033.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.33])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2024 18:11:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8trH11NApV1h8hO2UIW2HHp7nXyrmjySTSikxNbd5/mjlITAGZbGQLHDwA8W03ciF6PiX8/Bik5O+tY9mzY+FzrfcK0MGdm6YXYu+l7OguBN6TuiSS0PvN3VIctJhN9KQsBIWcNPoyZA7u2EtI7VgEaQWt7uDJtZ8bwcTr7rkdtH5bFn2VgN+NtYdAHAapORExjA4m1gw4rdXSMA/XEArDAYkJbXoKlyD/bKL53OWWO6EJzUVpzOGq5CYYhyBQsYbZKuBTHZtyEwXK7cM6aPqc6kQebppjj7Alqz3NgrfJGazBtOilEem31uZAxL9ukmjr23KCJoYu+/XR8r7B/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XeJpPGSBp8voRmUCyWEpR14HemHaLEhGfx4M4HON0Q=;
 b=e9PUg8sx8roQK+lg2C2Gj6Z4HCMC7tq0T5PuaMPosoB1Uoq608EeClAjKHa+T86dgSpn00ayAmZtNJ4l/ZCtDJW9wLQUFk4qLBe6pjP1tBmphFy6vzG1NXsOHn/thEd3BRfByZ0E4aJETETMhJMTbXGXb5vaFy3rj9YHEQxrDXMHB0VYkbrr6TnnfD9doJ0ksuCEqQPnLQFeM3/UK0RE+shv8FHeBmJ64OT514gLmRUDm7HyfpYEt5ADTbVXLBg6DA3qx49qNhP5aClxfFxIlfqn1B6vOIh/5vxkR0eL+rymeKJHoWq88ZM/lTZVezCtW7cS1GNHx4sHga96mbi/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XeJpPGSBp8voRmUCyWEpR14HemHaLEhGfx4M4HON0Q=;
 b=EK2PnDnB702NibXxqNP9iC5ukGsivz7qYSsoGvUhqNrC5ezb/UOsA2k7G8uz20BbHdR3nFjr9GVm5XdLVqRMlt2zJA2GjcHJ+YRP5GYmj0w4FyWC20ryWag/QWuTEPt1bTXgosHtjp8rWdt1cRacA5OKkNCr8+0Weh53FoxH550=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7495.namprd04.prod.outlook.com (2603:10b6:510:57::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Fri, 6 Sep 2024 10:11:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 10:11:52 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Topic: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Index: AQHa/tpuqzDYrSc/4UWqwA3ouia0pLJKaKAAgAAC7QCAAAWLAIAAGvzQ
Date: Fri, 6 Sep 2024 10:11:52 +0000
Message-ID:
 <DM6PR04MB6575B661DB570B1D2D05A6D2FC9E2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-4-avri.altman@wdc.com>
 <fc704a6e-962e-4294-9d97-ca43144adbc6@intel.com>
 <DM6PR04MB6575CF2F7CBDEB87949965D7FC9E2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <4a4dc281-34b7-473b-892b-7227530f6d56@intel.com>
In-Reply-To: <4a4dc281-34b7-473b-892b-7227530f6d56@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7495:EE_
x-ms-office365-filtering-correlation-id: 206b14bc-d094-4c32-ab54-08dcce5c53fe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGpYcU1PRlByQkdrMFFtMk51b2N0UFZJU0s0VWtCZnJPaXNmNjQ3aHhvOXQ5?=
 =?utf-8?B?M3cxSjlqRFJDSTV2Z0FvU214SWwreVRnNlZxS1pET3VYOU9uZWRKZlBacFRD?=
 =?utf-8?B?V2E1RmNyUWhBZmVZSkdFSGt0dHpJVGlTK0dDQjBqREtSQm5CQngxQTFnK1l3?=
 =?utf-8?B?OE1nZTBwYmxUbGVBcWY3dEdFeVovY3BzUlBWMmJsc3JVVEpIY0hBdUtWVlN3?=
 =?utf-8?B?QjNScmxnSDU1UlhFUjNUQ2l6aGQ0cXZ5SXlOaXkralE5d2NkL011TFJrUWJx?=
 =?utf-8?B?dG9Hb2R2eDhWa2l5QlM3bWpQNXNHU2tHbTlsK2xOOW9NNDlmcTBwR09GTk5V?=
 =?utf-8?B?N3pUYWN1Q3I1Y1RmNk9hcHR4dGZjVHFPemQ0UXpNaWo2eUk1Q1FWNFRLUFZz?=
 =?utf-8?B?aVEyKzdXMXVCN2xoRUd3TGRoTVBhelpOdEs2aGVtb3Z4bk5CZTljbDBkVm5r?=
 =?utf-8?B?ekRlYVY2SVhsOFpaclFiNTR1Y040WDBzUHFTWVJGTXNMVHlsZjh2emdNYStp?=
 =?utf-8?B?aGZma05odSsxODkyOXhnbGthZTJsMnN6b1cxQ1JEZnFsc2NVeldOdlJHR2tP?=
 =?utf-8?B?YXcyRUZxVEpaTmVDdnhqT3BEMTBTSFNYd05BeVNNRFRPNndlT09TRldnaU1R?=
 =?utf-8?B?ZnNTUmtUeHUrWTFoWnEwV2J0c1NmV0tIM3BZWm5hMEt3M1NrTW1hZ0RvYmFm?=
 =?utf-8?B?ZEtVejJ0OXA3V1NBV3dHVnN6QjFQUkJ1S1l6VVR3NmdKMHE5U1pHU1EwakNL?=
 =?utf-8?B?MUdRemZqTmYyb0I3dFIyc1A4RTJ1Y0FySjNEZnphRW5hUitZaHF4MW9xVXV0?=
 =?utf-8?B?MUpFZ3BjRkZqdUkyczNRdHd0WlhET1A5cy9QZlpXL3I3em4zUHgzV2pKa2pR?=
 =?utf-8?B?eVFiTTJnNGN6OEJnTkdETnczSHRjd0FuSXNKdlJPQVlVcDYzSlFWUVBSeWVI?=
 =?utf-8?B?MEswVTlaRnJjTGw1OC9kYVpFanlhNUMvM3FrYXNNVlBWSTI5Mm1CQlNEUi90?=
 =?utf-8?B?dUFYcUd5cFNESkRWZzBQa2dvRkhSOGlEV2luSnM0NytCWjJET09LSi9rNy9K?=
 =?utf-8?B?UTBIdUxTNlVrT2Q2b3plMVdLMHR0MkZ5N1ZadEZBK2lIWVZFSWNlQTJWTmdF?=
 =?utf-8?B?enBQQ1Z6c0pCSitBOHVRKzJObmdSV1JoZ0lvR3dGRDRaRVJ4OC9MSEJMbHN4?=
 =?utf-8?B?ZmlTMmFrdC9Zb0dRaDRRK2dQV2pSMGpqeEo4R2k3Tm9iWmx3WmRYU3JIMHpQ?=
 =?utf-8?B?d3Zrb2pZZTBKcWRwUnIwVHdUNHBUazNNZ3BYSEI5ZDExaHdKSUxWOWUyNWhO?=
 =?utf-8?B?N1JVbDRUWDlCOG8vaW84bTRKNTRtQnJ3K21ub29XYkJ2QlhDQ1RLMTRJMGJH?=
 =?utf-8?B?ZnlrQk9ONVJtYWpsNjhxa0NENGRuY2pUUktRbzlDMmJvL3NndmIxMnNHUFpE?=
 =?utf-8?B?QWtsYU16UllnMWgyeXBJV1BmWHF0cGEwNGlhbGJ0eGhOWnVxZStVSzVTd1lZ?=
 =?utf-8?B?RWNUa1V2V1A3ckk2TCtrWXNQamd4M0J5ZzlPSHZ5SzF3RFNyOFlJRkNFSDl2?=
 =?utf-8?B?aHpRMml0MzBpMnNMWFhTSEp2UHVyeThDZUY4SWlKTTFXWFV6Wk5mQXBndmhj?=
 =?utf-8?B?TFppMzJMeFRWdC9Rb3F3NVNrdHYyTVFPZ2J3MGdTS1NIc1VvNVpDNnl4ME9m?=
 =?utf-8?B?Y1ZwTURQYmdRSkhWb3dyenFycTFDUUNUWWZWRWpLTDZKVmQzWk1DaUlPNkRw?=
 =?utf-8?B?OG5OZ3dkN1ZVT2Ntd1JRVmtyTTh5Y0Noc1owdDFhV1UyWTlqQkg4aFEwUmJh?=
 =?utf-8?B?YS9RQ3VBUDU5M0phZkZjUXp5VUJBMVA0RFJmakkvODY4dGJwNnJJM0h3QUpl?=
 =?utf-8?B?U0xJdDBOSTAzUC93UDdWdW1GUXVwYnlXWGc3WFNvNXVYMlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmZPTEVIK1JkWXRRWFo0WU5ZUEg5aHV5a0ZEUHg3cG5UbFc1d09mUGhXdXBT?=
 =?utf-8?B?Qjd1S05UQ2pncDlvalhxTldDMXNEdzR1Ujk2UTZTV0hUVVJIUnh0YkE2Rkl3?=
 =?utf-8?B?VjJTVGdsTFovTFB1dFlzcXNkclAzZDlSQThZSW1zbTU1UVB0QzhiazdpU2pS?=
 =?utf-8?B?TTA3THJDejJVODFUZVJEdDdUaTFOYXhWamNxak1RNldIOWIvTWl0TWRiMXJK?=
 =?utf-8?B?My96Mm1pcWRiZmNWeHpZcGtPUXJ4OUZ4WCtIbElERjdueklUSFRsQ3dKVGh6?=
 =?utf-8?B?RE9YYmRUME9uOGFjbG1rcWJ0TTBQMVd3bkNJZHA3SnRBekc4SWJyaTdicjg1?=
 =?utf-8?B?dE1MNDdCbCtkQzY1ZlBqQ2lvUDhkNWFNY1FJVVd4amd0ZUZoQU1iUndsNTRO?=
 =?utf-8?B?cTFlUEJyV0xSL0ZwNUdva2t5VHVzWXRQS3FDSHcrMjk4NXpUOC94MGFNSmQ2?=
 =?utf-8?B?YkI1a0xlUkR5cEtZeXNQbmVBQjRGZWFkSHdTNDdtVldxbFMvWkc1NzhDM0k0?=
 =?utf-8?B?TUZVajZreTF3R0o3UWI0YjZENnFPV0gweUN6SDRpcHF0azNhY0twclNhS1JG?=
 =?utf-8?B?K2EwOHhrV3FqMm5PN3cyWlVXck50WDBXT080K0lvUGtuSGtNNng2Y0Y1WDVO?=
 =?utf-8?B?WTVQY1QzNkRWUW5SR3h3MnVxSEJLVFo1NGVad2ZoSXFlU1Bady8yZ0syaFBP?=
 =?utf-8?B?Vm83OGNEL2ZPL1Y2TzBWVGRIUURMaUZPOW9CZ213djBUcktXK1V4K3pFUk9L?=
 =?utf-8?B?KzlBNHQ0VEtFd29NMXRoUVlxMmlGbG91bkQ0OXFnMjhNa2hkSkxDVDU1WnJs?=
 =?utf-8?B?MWg1WlE3Vjl4dCtUN21lUXZic2liY0t1ZHVqT25FVWMwTFhhM05QVE9MWWk0?=
 =?utf-8?B?M045WFRqOTNCcDJVSDlHbG4vQllkWXFLSGlmNXVNZVdhd0tNUkw1SFRValV2?=
 =?utf-8?B?WGxIOHFLNDZlRE9ZVVFjTDhpOXgwQ01WYVNmMUNVWlB5MjZQUWo2aERrbm1H?=
 =?utf-8?B?SlhxL01NbU1pZGVsY0FOYm5Id3Q2dzJYNkVoRnZvRHA0Q1NSeG1kRC9Vbk1w?=
 =?utf-8?B?NldHWkpmaTN6ZmhkQ0d2UllYZXFUNzRnRzAyVkp4OWgyOG44cS9oRDZyeU8v?=
 =?utf-8?B?MDlaOFB1WXIrMDVXVEVCbVlscWV0c25rRGxpNUgyM1kvN2J6K0N3ZDRmb1Jo?=
 =?utf-8?B?VThVSktQYzlrU1RYd0VVTXFJamVDUkNpdXljU1pqOCtERnJTYUJsZFJaM2Qy?=
 =?utf-8?B?TVAxb29PV3czUzhTMW51UHNUUDFRYXpIUXJBQlJIekphNnlJTVhHUGVLOXZs?=
 =?utf-8?B?aGREa1VObWVzQXBnUlZLUWlxQUhUSTc0WWpxaUpob0FnRmlVSHBhek5EK2d3?=
 =?utf-8?B?MGgzenAyTk1MQTFUa1hXYjM2QVdtbk5xVWZhYVVMOWxPeVBLT3dhaFp5eCtv?=
 =?utf-8?B?OVVyT2ZoeTFxQzZTUzJDbXZsT2FiTEtUMm9UUmY4WmZRdzdHZTkyeFJObUh2?=
 =?utf-8?B?cG1VUUdiVkg2UDNrNm11RWdsZUVSa1BLdU5sWDQ2THd0cm1CNDZXY3Y0ZUYy?=
 =?utf-8?B?dGhmMHNlK1dqVHo2dDZCSmlJcHJHaVRRYlllZXgvWmNzdkZqdnJOcDBoL01Z?=
 =?utf-8?B?Y05pVWZ6NjhIdHI4OU9Yd2hvQnpKZThLTUVSYW12ODU0YnVZTzltbk5mY01l?=
 =?utf-8?B?THVHK3dqb1N6UDFHaFNrWlBjSG9VenlFZG9XK0h2YzF5eGlFc25RTnZpcmtu?=
 =?utf-8?B?SW9MZExrOWdobWdjenJWbm5VZjY4NUd1aFRwMnB5K2xJNFZXenJSUmwwWEhM?=
 =?utf-8?B?amdmbzc2Z3dNcDllV2F0Y1BPVFZyaVAxaGlwbTJqcjZ3aUpCeFJXVE9JZHVI?=
 =?utf-8?B?SmNXMGNtbVc5MUV4bXkwOWUvMFFOUWU5MzVxcElxUGtZR280SUlSYjdDUHlz?=
 =?utf-8?B?NWdtL0k5dlhOWmY5VVhNTWFsVnZwbG0vSFhXMnR1WjZSaVlzd0JkcUd0SmNJ?=
 =?utf-8?B?eUpMNnUrVkZlYjRXRGFMUk53cWR0K1g2QmpYd25aWEJudUtkS01YQ2IvdXNY?=
 =?utf-8?B?QTRleW9ubDZ5NEJNcjV5V05uVXJQQlMzQXRIZElyWWM5WEcwZVBLbGZTclFV?=
 =?utf-8?Q?OYctwgn9ZYPjTGQ9OzlsD/ztK?=
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
	+N/o1fSUIWE0+OKQv1qI1AkOxtp2cE5CNim9tRO8bcFBgEdGQF3aLCaxeObcAu+fZdOU387R43Rpy6sAkb+hf1/ZHZiIsgszULyw8qfYqZloVKJ9AYFkFZKinu15YUnKt1sZEHgTjaKQJSxmtA70lOZhrk0gDVdWvIFgSAa3Ia4H9+DRjjRtvrE1zrf2H5dl1D4yScMCCg7ikShdwj5G/akq+e6D6JQDjSWpX9Ph5969/hsQ/UZHpPzhvDkDvMA9YetPtVVxLvUphMcpdR2kJdd73naYeT+ypkazLgUju7/315NVxPXX571P01dKRv3HGkpSCTi6LmvTRDIf7CcfPMFlaQPACm3qKnbUtwLceg3vBQB4HZ+hpm+3toHe8tHPh5HAYHT2Y7zKmvYIcemSXWMOelaXllJu0CNiE2aPxfvD/afciZA3nkGlI8Y9eN/L32qLRcUw96sqd53pmC2AnWDOU5g3bJ0mi5eKfH8YQANJKXQ+SFeesxbUqGPitoLY7IYPH5/Vmz7mmrdqb4x5d3e42hc8Ohgnz1hn1/NyoR1/7qgAx4vefSD6t6KW40lVjd3+0pnVDnAHjuZRAgVK3RrEK/9p7huWuOPZ8djcwAi3rmqLCa9lPhHv21whQsmb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206b14bc-d094-4c32-ab54-08dcce5c53fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 10:11:52.1052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrWRf/nsOiR7ga8p0Z84TYYcz1gnzcnqCWHfHDY4oY0lV5Z8UEDzkojPfXh3Fd6SB7j0a+zNejMo41sXCSzcZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7495

PiANCj4gRGlzYWxsb3dpbmcgU0RVQyB3aXRoIGNsb3NlLWVuZGVkIHNlZW1zIGxpa2UgYSBzZXBh
cmF0ZSBpc3N1ZS4gIFRoZSAnZWxzZScgaXMgbm90DQo+IGFjdHVhbGx5IHJlcXVpcmVkLCBpcyBp
dD8NCkFoaGEgLSBvay4NCkkgbmVlZCB0aGVuIHRvIHN3aXRjaCBwYXRjaGVzIDMgJiA0Lg0KDQpU
aGFua3MsDQpBdnJpDQo=
