Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2105.outbound.protection.outlook.com [40.107.249.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED141FE479;
	Mon, 27 Jan 2025 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984274; cv=fail; b=m+LrSahAQiXm+5o6ladI1Sebq1+jb6VJkNBJU0vmX9Up/+2yfz40Uc+1n9hXKxmm7AuA1mKqwpxOYpnXWJAtg0jsK6R/9gljku4zzHoHZuKnPzheKTk9gbJx8z2OI/rKUH2csAI1O84wfR5X0UQHmENLHy+pyH2pKCRETjhI6/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984274; c=relaxed/simple;
	bh=fPd5ykYHBAcGR736DBnU8iRzIdgCvPSG12Kw/WvDIx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOnITo3rUBkxtQUMGWEs68ztfGrHYDL3euRSFd2pOozluC7MuDGgp0qvPFPVwSMcF6m7NQqk0LpEphp9ilF0EOdXwUjg18LpZTLI4fIY6/+RrN+VHGdc2DIVu+EAeJz+PwlbRtt+7zTid0EbLj+ea0okdGcUY6/gbGr3/meG5Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=gksxGbrB; arc=fail smtp.client-ip=40.107.249.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="gksxGbrB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8rNGgB/j2+4+Hv1O+xTEyYefN4LPctbdoRev45H400+EY3UlK2I0JDUertOss4hdTUh78YUEG4PDhsCnRakuxw7NaFkQEelmSJoVRN2AvFemkSEWecg6phUY1R2hFpv2b4CXGq6Gmg+zNmaxAW1NL6TdWj/3Zj9OyZ4x8tF6qy/2Znt5q4TpqNYAQ8MEF9f+ku9KDiZgyKlFKb1TYVvIqAfsqGE8YNUpY6HPkCZLuWvt9dNDTg4yg86sGZuOo9As4kFujNYbRHijkXzTuTqgsXqxezIknsIkQjjFGAP6RSuFOk/EIe2/ce8GL4CCWS/l3ZI+n3GihZJOr9m9G7kgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPd5ykYHBAcGR736DBnU8iRzIdgCvPSG12Kw/WvDIx0=;
 b=X9i3mqvxkrFT2vGAz9J++3F0bMPwU+iCUQDew6NxOyQulUIL8StFh0ns2JX/qpKGS/YffPHAMAilJFt2c+Ls0uqWa4F7o8KEXj6iPuCzZwAE7M39Rv12PGXbKiLeO9KBEtHpun3/fm2u0twxC+PTPN5/SMrPpU6br1jood+ObFrnGsOchFzlGc9hIcunb4MsMbhXmG1xO62Y2rPcb2NEcaGL93l04rDHYmY2Hvvv5tpRBpkuIK3Oaoxb/rrnxG6HRe+QhvwFSDEqke7gkjihWe7oFZl/o91raZUEmXq7muwnk0R5rNz3L8efARGeAdm6cgJMk8WI7lxgZNbnuOS8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPd5ykYHBAcGR736DBnU8iRzIdgCvPSG12Kw/WvDIx0=;
 b=gksxGbrBTszmy2L2jK3Y9UdRI9s6Hrz25bOTOYfujOZrmouWu0pjqhys4F7p6xkoZdwGy1rI+NSXbEhZA4pfCWK7pmf/pm4LtQMC9v+0fRNzvLaa26eCvEPV4Gd7Q7FymC6+Afjz4fYdZwwCUElNs2qUKcynX3871l8eGqTbru8=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Mon, 27 Jan
 2025 13:24:28 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 13:24:28 +0000
From: Josua Mayer <josua@solid-run.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch
Thread-Topic: [PATCH v2] mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch
Thread-Index: AQHbaq7Z0Q+CvTyGKEO2ALjdrALpTrMqqDWA
Date: Mon, 27 Jan 2025 13:24:28 +0000
Message-ID: <a326d377-0833-4ab1-87af-1e9619a8c86b@solid-run.com>
References: <20240913185403.1339115-1-jm@ti.com>
 <a70fc9fc-186f-4165-a652-3de50733763a@solid-run.com>
In-Reply-To: <a70fc9fc-186f-4165-a652-3de50733763a@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PA4PR04MB9365:EE_
x-ms-office365-filtering-correlation-id: 8e6dd574-f574-435e-359b-08dd3ed5ed2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S24wNDg3T3JxbjRra2ZEK3VVZmZtd3Y0ZzdNL0p0WDBCOVN4Qm9RYUl1c3Vk?=
 =?utf-8?B?NjM5NUFrNXlnY0R0QWluYmlzWUs0REpXRzlxdUxEL1NtWTU2MVR3d2Z2elBp?=
 =?utf-8?B?REpmUDduYzNFaHVqRWw4WlhyUkFEdHhpSnBsUGtJUmxEemwrQU5UN2E0RFc5?=
 =?utf-8?B?YnBDemJZMXZKbXpnNThpZ3dSMlFldjlWMjlLY2xwbmxMN2tyZ2hpeFJLbHp4?=
 =?utf-8?B?L09Yb1lWMDFoeUtkL1l1OFVLcWRuZHg4VTJIb2k5QzFYT3R4d0FoUTZsd1pG?=
 =?utf-8?B?UGVYbGVHNUw2eHNVejJvaVR3OXVBc1JvR3gxZ3lwVFdITkRDUzMvUUJqZmMw?=
 =?utf-8?B?Q0ZhTGFTK1gxQnQ5SGhnMjBPVVUwRm5xVktqMlVncGJCeFJIeXlWNlVJL01G?=
 =?utf-8?B?eTlMS3hLVmpYaDZzY2FxOVA0aWFjWW9jSldaK3BEcmRncGN3NmNseXhhbENv?=
 =?utf-8?B?ZGd3alVHd1dNeVZTclZSU25NZVBlYXBvNzJqeHp4aVhlMWpHUFJyenFremov?=
 =?utf-8?B?a0lJYmtGOVpHOVFHbGg2bVpNZXFqMkYzY2FWWFpNa2tKV01VWGJ3ajJZZGVW?=
 =?utf-8?B?MmR4dmllNmhyWlhjYXBOdDRCQ0d4T2JPY0RJZ3ZkQmZMRUpQTGVxc3VPT3hq?=
 =?utf-8?B?SzQxb3o5K0Yxc1ZmNDNKRmUrZzMwVU1wQVZ0WDI5R0JuNkNHNnJWVFZqMTIw?=
 =?utf-8?B?VGI5RWVZYm9pQmgwdDQvODNEczV1V2JmM1pnR1V2eDJFVFdZMmNGczNTZ3Jx?=
 =?utf-8?B?RWFadzJSd0x0UzliUDF0VDNWZGVyZm5xKzQwMFdrdUdJWGNEM3I4OWtLWTFS?=
 =?utf-8?B?YXdDQkFzWEYxaXRmamJRRHE0VXJyclY2MnRXeno5b0UzQTQ3R2g0NEZGUHpu?=
 =?utf-8?B?ekN2TnVISDd5ZlcvS3NWTmQ1QWwvZUxTY2lMYjVIN0NmTkNEVXVpb2ZvMFh2?=
 =?utf-8?B?T2l0M1NnZ3BOL0FRTEYrNGhCYXlodFpPckdsOVdMTnBsbTRiQkp1bzMwU1hK?=
 =?utf-8?B?M2ZiZDlKOUpHNWVLekY3TzYwZEM0YXlGWUsyUFN6T0t2K3dncW1uK0dkZVYv?=
 =?utf-8?B?VXJzWlZQNkhnVDdwYzE1ZEJpNnhWQlU3cEVvNVBWZUR2SHdwZlphY0dUTkFX?=
 =?utf-8?B?TTBoU0lxU0VPTnNSRkRYZGdBaDJoTkx3TnNVZCtsRXcwWGZ2MmVnenhMeTlO?=
 =?utf-8?B?N29yVGNIdE1aZzljTWIrbTlIQ3FzUDREc2pyL0VzWDdWaTV4TEJPSFl4Mit2?=
 =?utf-8?B?QktKQ1VkQU4rWHB4azFxMUhqa2FsT0pzMDdnTmIreXFEd3BEYjZ1Snd0QnJW?=
 =?utf-8?B?MmVFOHhpRWhZNWtMajRIM2FEQk9XYnkvaW0wS3o3MllLeHkyUzhiZE5lUWdW?=
 =?utf-8?B?RjF3aEVXQTBqRkRZMEdienFMVFlEdmJLU0l3TnZuY3dpTHU2OEg3ZGJTallj?=
 =?utf-8?B?RDFxaHhMQmhvKytvVWNxd3Vheno2dlhpVFVxMFlTS2QyMmdOVEF3RVdRa0xJ?=
 =?utf-8?B?MjNnUjVrQnY1VlRvSkFQN0x1TjN4ZXdHSVllMG5aVjNPOFN4K2szMGY1KzYv?=
 =?utf-8?B?YTgzV1Bwc3hZc0VNMHlzeGxzbjAxTDB0SVMyV1VEQTJMRUVvRFYyNTBqb1RW?=
 =?utf-8?B?cm8waldZUWpJVEhhQWpORFdqd1Z2VFdVeXRpenJUZStWYVc5S08zTUs4RnJI?=
 =?utf-8?B?VDRSOWFtTm40WWwwSnRlZW83RFNOQ3NzUCtyTkppY3l1eVFLZmZZS2plSWE2?=
 =?utf-8?B?emwxdU1La3ZoaWJYWUhLOWZIb0NEMFlWUHlYVUIya3JiVFl1UTRPTE1EUGgx?=
 =?utf-8?B?ZUNnRWw2ZmdtVkxLNlVmdThJM2dBa1EvbFE1TWZTRCtHcGlBL1VTMDdoWHps?=
 =?utf-8?B?UWtXM1BlSmtmUTdlb25LUWVMcCtRdStyNzNlUll2ditKNDBHbFAwVWVsaFZY?=
 =?utf-8?Q?62JI2PjX8gQliAoj2W3rm6Q6RZTe3ztA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azJTWVpHcXErdnBSSysvMmZ1Y1cyVUFVZUdmMzlyWUhRbk9FdzhRSlpGVVJ5?=
 =?utf-8?B?bk1mTTFiR1BVT3RncTJ3dG5rQmlER0JaOVVaVGphaEZlRktrcVVobllWTWM1?=
 =?utf-8?B?VVJjQmNCS2xKWUVNc0lsNHdOKytJbEpldklWN2l0a1c5cXAvRFdTUUUrY3RU?=
 =?utf-8?B?ZU9RS0FRK0pZeGxvK2JIaUlsTXBJalZYUlVOUEVrKzVmcVRpdGRaU1pjZXZ0?=
 =?utf-8?B?L0tMUks4VUxZeVR1UHJobjA2ODNyMmI2ZG1EUDBHOXlmMDEvSDZ1WFVTRVhn?=
 =?utf-8?B?dmNPSnc4bGN3MnBCSGxkWGlFcGUrVnZMNmo0S3BabUhiL0g2TUd5Z2prODZE?=
 =?utf-8?B?MUhEajF2dnR2NXBueUo1TWJnbVA0eExJTzZCL0lsejlzNGFQZHhaZ0Z1eUdw?=
 =?utf-8?B?VUpZWWZ1TFQ1VGZVM0dpQUQ2bDhDNUZtUHkveEw1bHBSWCt4ZFdxVnJKWitp?=
 =?utf-8?B?ekdZUG5VNnFzR3ZTdzdZMXZteUNWcVZvNFU5ZTRFSkNXWTgrL0IycHYrcWo2?=
 =?utf-8?B?bldCV0gyMkRUSFQrcXpNb1IxbkRac3Z3bEFIcWNYcHdKbWtTWUMyRlMzdlNQ?=
 =?utf-8?B?T2k3ZFdtbncrd0NUS3NIMnpqdC92MHZMa2xoZ2pNdnJSNGV0Q0g1TG5mVDl2?=
 =?utf-8?B?TVRnTndlS3A5MWhSSDRUYWpTaFZ5eHlqc2RhZG4wNktGNFBqY1NUOFVjaWla?=
 =?utf-8?B?SEo2eUMwMWNiTjhQUnBXODgrLzJFUk9wUm5vTzFCQkxJemdidnV2WUQvcDVl?=
 =?utf-8?B?YkFVLzIwUStwSlZiSWc0aXdZT3RRem5RL2phSlZPMHZGdDNZOTdMSjJEeXZQ?=
 =?utf-8?B?Yld1UmFNWWM4a0dpMDhzUDRUY0tCeEwwRE9VRzBHR011cFV3a040ZDdoNWlr?=
 =?utf-8?B?a3dscWd5djYyR0xNbEY1YTRxU1VQdHZWSmVGK2pwLzBnaEhXMWQvRllNZHJE?=
 =?utf-8?B?MHc4UlRqTDJTSE1EWmkwYlFnWFRkVFlFZEk5ZEdQRjZ4Yy9sT3JrdWdiVW1H?=
 =?utf-8?B?MDZnbkN1UWt3TWRXdUJRWkM3VmFZMG5MTUt3UGhRalZ5U05tK0RCMnNMUVgr?=
 =?utf-8?B?MjdKd1hCZmg1ZFpjTTdhdXVDL0NqaDhUd2pTM25vaC9CMGRUa2NiUytmME1W?=
 =?utf-8?B?Nmdib1BRL1JDcFFlQVRtclFnVTJlVjNxbG1sWXg3aG1oTGhVemJrOU9yWDUz?=
 =?utf-8?B?RHcyaEMrRGppQmpzRDRqclNVOVRieW4wWkMvbHdXQUE1T2U4K1I5Qk4xR0Qz?=
 =?utf-8?B?M2pQdXF3QXJXdS9BQ1lrdlRPQzRHTlgwYzR4SVFPaGs4M2M3bWNkaDZVMmxS?=
 =?utf-8?B?dmF0WW9ORTJxdHFsSVJhZlNWQVdZbHVzK08rUERxU0t2UW56VHpNZDIzRjdm?=
 =?utf-8?B?OFhVN3F3dllCTUpyYldEY2JUMzlmOTFlTk1QOFpDZnVEbU5UMVNkM01mNkZK?=
 =?utf-8?B?d2tZbjlCTnkxb3YwNEZCVHhrV3N4aEJkQ0tLK0tqMEpLRkoxN0t1MWsxb1Bx?=
 =?utf-8?B?eFVmTVYvVWRaaVlUbjJlbDQ0dWR3dVRzSVgvZS8xdEFxSlNtMTZ5NjUxS0ts?=
 =?utf-8?B?YmJtcjdmODRSMWZOZWs5WW1Qci81V0FEMmJ1ZUwwZUZtYmgxRmhHZ3RYY0pV?=
 =?utf-8?B?N3dvd1NJd0hMSVVFSHBVQnhONFB2eVFhNDRhSU9CWnJ0YWc4U01OTXF1S0dE?=
 =?utf-8?B?WWJTeHVWSE5Ld282QkRFb256djdHNkFROGdHeENIb3ZEczQzVjR6SytDRXl6?=
 =?utf-8?B?Znk1ZyttbXRqS015VUF3OTZqN2N5Q2sxU2lwUDI4eFhuR0MvQXJUM04xTHhN?=
 =?utf-8?B?MUVQWmdOMkZOTmdZRW9QUUV3Wis4MUFGeU9LeXRKQUV2K25aVlV3RlJrdnFo?=
 =?utf-8?B?Z05yOUFYdEtBZ1pXUUlWMUR3WTgrbTdydUV4aWtVQXE5cmtZM2R1ZTRra2Fx?=
 =?utf-8?B?aGJ0WEFySFhhcGgzZW5ydFBUTlR0VGVzL0xFeVRNU1NIZGhpRFVsMFc3eFBG?=
 =?utf-8?B?cnU3YUtqYWxHWGxjQkN2VTBoUXFyQ2JBZngybnJicWdHcitLVzQwL3U0UHlV?=
 =?utf-8?B?ZlVBL3NWOXFOTEE1M2ZGZFdXRHlreUk1dGdYOThJNDMzam9UMll0bEFuY2FU?=
 =?utf-8?Q?PrG3l+6llI9250labIb7ryf7a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D90939EBDE00E4BBA42BFEF024FA971@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6dd574-f574-435e-359b-08dd3ed5ed2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 13:24:28.4265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHQmorQUq9ziFtwKBOGrU328U2mBmbEDmkg1Diay8kIqTSH0/6sXWc+5He+/q1PVGijaHF3MZb2zsfjzJC5jZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

QW0gMTkuMDEuMjUgdW0gMjE6MTUgc2NocmllYiBKb3N1YSBNYXllcjoNCj4gSGkgSnVkaXRoLA0K
Pg0KPiBBbSAxMy4wOS4yNCB1bSAyMDo1NCBzY2hyaWViIEp1ZGl0aCBNZW5kZXo6DQo+PiBUaGUg
c2RoY2lfc3RhcnRfc2lnbmFsX3ZvbHRhZ2Vfc3dpdGNoIGZ1bmN0aW9uIHNldHMNCj4+IFYxUDhf
U0lHTkFMX0VOQSBieSBkZWZhdWx0IGFmdGVyIHN3aXRjaGluZyB0byAxdjggc2lnbmFsaW5nLg0K
Pj4gVjFQOF9TSUdOQUxfRU5BIGRldGVybWluZXMgd2hldGhlciB0byBsYXVuY2ggY21kL2RhdGEg
b24gbmVnDQo+PiBlZGdlIG9yIHBvcyBlZGdlIG9mIGNsb2NrLg0KPj4NCj4+IER1ZSB0byBzb21l
IGVNTUMgYW5kIFNEIGZhaWx1cmVzIHNlZW4gYWNyb3NzIGFtNjJ4IHBsYXRmb3JtLA0KPj4gZG8g
bm90IHNldCBWMVA4X1NJR05BTF9FTkEgYnkgZGVmYXVsdCwgb25seSBlbmFibGUgdGhlIGJpdA0K
Pj4gZm9yIGRldmljZXMgdGhhdCByZXF1aXJlIHRoaXMgYml0IGluIG9yZGVyIHRvIHN3aXRjaCB0
byAxdjgNCj4+IHZvbHRhZ2UgZm9yIHVocyBtb2Rlcy4NCj4gSSBoYXZlIGp1c3QgdGVzdGVkIHRo
aXMgcGF0Y2ggb24gZG93bnN0cmVhbSBUSSBMaW51eCBmb3JrIHRhZ2dlZCAxMC4wMS4xMA0KPiAo
djYuNi41OCkgYW5kIGl0IGJyZWFrcyBzZC1jYXJkIGRldGVjdGlvbiBvbiBTb2xpZFJ1biBBTTY0
MiBIdW1taW5nQm9hcmQtVA0KPiBzdXBwb3J0ZWQgaW4tdHJlZTogYXJjaC9hcm02NC9ib290L2R0
cy90aS9rMy1hbTY0Mi1odW1taW5nYm9hcmQtdC5kdHMgc2luY2UgdjYuMTEuDQo+DQo+IFRoZSBi
b2FyZCBmYWlscyBkdXJpbmcgYm9vdCBmcm9tIHNkY2FyZDoNCj4gbW1jMTogZXJyb3IgLTExMCB3
aGlsc3QgaW5pdGlhbGlzaW5nIFNEIGNhcmQNCj4NCj4gSGVuY2UgSSBzdXNwZWN0IHNvbWV0aGlu
ZyBpcyBub3Qgb2theSB3aXRoIHRoZSBoZXVyaXN0aWNzIGVuYWJsaW5nIHRoaXMgcXVpcmsuDQo+
IEtpbmRseSBub3RlIEkgaGF2ZSBub3QgdGVzdGVkIGl0IHdpdGggcHVyZSA2LjEzLXJjMSB5ZXQu
DQo+DQo+IE15IGRvd25zdHJlYW0gd29ya2Fyb3VuZCBpbiBkdHMgaXMgdG8gbGluayBhIGZpeGVk
IHJlZ3VsYXRvciB2bW1jLXN1cHBseSwNCj4gYnV0IHRoZSB1cHN0cmVhbSBkdHMgc3BlY2lmaWVz
IG5laXRoZXIgdm1tYy0gbm9yIHZxbW1jIHN1cHBsaWVzLg0KDQpJIGp1c3QgdGVzdGVkIHY2LjEz
LjAgcmVsZWFzZSBhbmQgaXQgaGFzIGEgcmVncmVzc2lvbiBmYWlsaW5nIG1pY3JvU0Q6DQoNClvC
oMKgwqAgMS45NjAyMTZdIG1tYzE6IENRSENJIHZlcnNpb24gNS4xMA0KW8KgwqDCoCAyLjAwODUy
MF0gbW1jMTogU0RIQ0kgY29udHJvbGxlciBvbiBmYTAwMDAwLm1tYyBbZmEwMDAwMC5tbWNdIHVz
aW5nIEFETUEgNjQtYml0DQpbwqDCoMKgIDIuMTE1MzQ4XSBtbWMxOiBlcnJvciAtMTEwIHdoaWxz
dCBpbml0aWFsaXNpbmcgU0QgY2FyZA0KDQpBZnRlciByZXZlcnRpbmcgdGhpcyBwYXRjaCBvcmln
aW5hbCBmdW5jdGlvbmFsaXR5IGlzIHJlc3RvcmVkOg0KDQpbwqDCoMKgIDEuOTUyMjQxXSBtbWMx
OiBDUUhDSSB2ZXJzaW9uIDUuMTANClvCoMKgwqAgMi4wMDMyODNdIG1tYzE6IFNESENJIGNvbnRy
b2xsZXIgb24gZmEwMDAwMC5tbWMgW2ZhMDAwMDAubW1jXSB1c2luZyBBRE1BIDY0LWJpdA0KW8Kg
wqDCoCAyLjEwMDIxMF0gbW1jMTogbmV3IFVIUy1JIHNwZWVkIFNEUjEwNCBTREhDIGNhcmQgYXQg
YWRkcmVzcyBhYWFhDQpbwqDCoMKgIDIuMTA3Mzg3XSBtbWNibGsxOiBtbWMxOmFhYWEgU0MxNkcg
MTQuOCBHaUINClvCoMKgwqAgMi4xMjY2NjhdwqAgbW1jYmxrMTogcDEgcDINCg0KPg0KPj4gU2ln
bmVkLW9mZi1ieTogSnVkaXRoIE1lbmRleiA8am1AdGkuY29tPg0KPj4gLS0tDQo+PiBDaGFuZ2Vz
IHNpbmNlIHYxOg0KPj4gLSBJbnZlcnQgcXVpcmsgbG9naWMNCj4+IC0gU2ltcGxpZnkgc2RoY2lf
YW02NTRfc3RhcnRfc2lnbmFsX3ZvbHRhZ2Vfc3dpdGNoKCkgYW5kIGNhbGwNCj4+ICAgc2RoY2lf
c3RhcnRfc2lnbmFsX3ZvbHRhZ2Vfc3dpdGNoKCkgd2hlbiB0aGUgcXVpcmsgZG9lcyBub3QgYXBw
bHkNCj4+IC0gU2ltcGx5IGxvZ2ljIHdoZW4gZGV0ZWN0aW5nIHdoZW4gcXVpcmsgc2hvdWxkIGJl
IGFwcGxpZWQNCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2lfYW02NTQuYyB8IDMw
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzMCBp
bnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2lf
YW02NTQuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2lfYW02NTQuYw0KPj4gaW5kZXggMGFhM2M0
MGVhNmVkOC4uOWZmMDdhYWRiMmQ5MSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2lfYW02NTQuYw0KPj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaV9hbTY1NC5jDQo+
IGN1dA0KPj4gQEAgLTg0NCw2ICs4NjgsMTEgQEAgc3RhdGljIGludCBzZGhjaV9hbTY1NF9nZXRf
b2ZfcHJvcGVydHkoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4+ICAJaWYgKGRldmlj
ZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LCAidGksZmFpbHMtd2l0aG91dC10ZXN0LWNkIikpDQo+
PiAgCQlzZGhjaV9hbTY1NC0+cXVpcmtzIHw9IFNESENJX0FNNjU0X1FVSVJLX0ZPUkNFX0NEVEVT
VDsNCj4+ICANCj4+ICsJLyogU3VwcHJlc3MgdjFwOCBlbmEgZm9yIGVNTUMgYW5kIFNEIHdpdGgg
dnFtbWMgc3VwcGx5ICovDQo+PiArCWlmICghIW9mX3BhcnNlX3BoYW5kbGUoZGV2LT5vZl9ub2Rl
LCAidm1tYy1zdXBwbHkiLCAwKSA9PQ0KPj4gKwkgICAgISFvZl9wYXJzZV9waGFuZGxlKGRldi0+
b2Zfbm9kZSwgInZxbW1jLXN1cHBseSIsIDApKQ0KPj4gKwkJc2RoY2lfYW02NTQtPnF1aXJrcyB8
PSBTREhDSV9BTTY1NF9RVUlSS19TVVBQUkVTU19WMVA4X0VOQTsNCj4+ICsNCj4gV2FzIGl0IGlu
dGVudGlvbmFsIHRvIGFwcGx5IHRoZSBxdWlyayBib3RoIHdoZW4gbmVpdGhlciwNCj4gYW5kIHdo
ZW4gYm90aCBzdXBwbGllcyBhcmUgc3BlY2lmaWVkPw0KPj4gIAlzZGhjaV9nZXRfb2ZfcHJvcGVy
dHkocGRldik7DQo+PiAgDQo+PiAgCXJldHVybiAwOw0KPj4gQEAgLTk0MCw2ICs5NjksNyBAQCBz
dGF0aWMgaW50IHNkaGNpX2FtNjU0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+PiAgCQlnb3RvIGVycl9wbHRmbV9mcmVlOw0KPj4gIAl9DQo+PiAgDQo+PiArCWhvc3QtPm1t
Y19ob3N0X29wcy5zdGFydF9zaWduYWxfdm9sdGFnZV9zd2l0Y2ggPSBzZGhjaV9hbTY1NF9zdGFy
dF9zaWduYWxfdm9sdGFnZV9zd2l0Y2g7DQo+PiAgCWhvc3QtPm1tY19ob3N0X29wcy5leGVjdXRl
X3R1bmluZyA9IHNkaGNpX2FtNjU0X2V4ZWN1dGVfdHVuaW5nOw0KPj4gIA0KPj4gIAlwbV9ydW50
aW1lX2dldF9ub3Jlc3VtZShkZXYpOw0KPj4NCj4+IGJhc2UtY29tbWl0OiBjZjY0NDRiYTUyOGYw
NDMzOThiMTEyYWMzNmUwNDFhNGQ4Njg1Y2IxDQo=
