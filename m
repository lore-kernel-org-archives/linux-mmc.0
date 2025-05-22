Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E8F9DA;
	Thu, 22 May 2025 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885969; cv=fail; b=kpqxkoi0kJDpalfV1O95p9fKzGIiL7HKIL0UqlQ7veGzkhhh9ny5RSlpC07VAZk0jim8IqCmEOdVAlzQOLP7dw4HEMp8tpsRX2iC2m0FCpOWd3Etj5nV7AbeCDZkEhCvWUOSFiVAwk+u+vBJ9kPZhqC9O0uYycaPmgrhkqETAsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885969; c=relaxed/simple;
	bh=x92j84KKpfKUPLD3bNl0o2VIUaYCDRLJKNOWnOQvNIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B2Ph87ZmN4vHVzSI4KaYi9d4J2DSi5uyGC9PG8LVhFce33pnMbOawkWv0d0aIFDx4Xa0PJa6HgPARmjCX87Fjk7wa7Sw6ui7p1dJFGltAagj3+8TjVxbGpfPouOA/R5WYIh+yb/B9UOzZGjVn4QXHdR4O1p156FqzJqMEq71Ok0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ahTfbcZc; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ahTfbcZc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZ4LYIvlmRPxQHr/JfatfuZV2cURqc/Rz6R5zhEF+WP4XZpebpCxvwmdxJgbspRNwgAUwPpzH/O+uV8onPaHqwwrWeGI+uLBLT3xl6NFoVF1Z8b1DYMODwBkdsrbK2PeRJCK/VQQ9EnpzKHoz4+zgTPsozDveOILmevLgVqeCP9c90aTaQbffHTQCW2Q0dps1FIxpwxGE/F9cFHCmG9Roj8j2Fj03v/5kRAAOp1YrLf7F9MHJU6rY8LsoRa5cC3D6DXmUdXJOeyyBht+FQVAaSfQ4ngxQqg5eO66WFLf0J1BMpkOohGs4e6ZqmNcwut6nRH53CUDM/aQedFjhsAYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x92j84KKpfKUPLD3bNl0o2VIUaYCDRLJKNOWnOQvNIU=;
 b=wGNX18r/UNeDI1+bc6zt6H4cVdyWiVVebrZSkNxskoENFDs7DsgCSJ/pCoBFoOy+mOi66+SH1gnUPRe43O3csfQ6qt4/3vPvo5QZGsoBLpDpw211ff9einOCUpq1AHGYyIuxo6QPoOjcrV2rFZ3ZkJXoGripdDyG4cRwmTg+s4NbCk0n1B4B9TQ14GkQ1uwV4HTwQRLaQf/BHeqnHOuSExAF4WyXU/Y8hG7gBpyuy3DyoLr3eQ/cDkBjj547HGCDCAff8yzwhfDZVY/BvZFB2bUbwbplCrdm2A06/MfUabePQ3CqM+ymYhDXs7TOV/MbRaY6vLuu9p7GYozYNISKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x92j84KKpfKUPLD3bNl0o2VIUaYCDRLJKNOWnOQvNIU=;
 b=ahTfbcZcAv7FHUHy5/utNc+kRgdvcCbfrk4caMThhEUCs5Uu6rCs0CjHWDywwz9CwvYYmSYVz+Yu8raUtzh3vmKsgfl4P0uYAMSrWtO+PbmGlFsVQKrwR14i8joh8L+cpmiS0esiiSr5rMvNtU0ZjrGHrPZ6FPkEzN/DSK0Zy/UWsnKNU9XpWJyDM0K7G4R7zwqLXrCjit6eB2ko2xGj6xIn76HsjuokNbIEfJH4jGjCZAXdspRm3o+DpOxPLL/9/7JRV3HD87Yd0G12eSWQnx2012usCEqMW3d0IwPK8rZxOlx5+e/+D2CTzpOTV0QYBxp51BwE15/KFiIV0rwp+Q==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 03:52:43 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8722.031; Thu, 22 May 2025
 03:52:43 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Frank Li <frank.li@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: sdhci-esdhc-imx: refactor clock loopback
 selection logic
Thread-Topic: [PATCH 1/2] mmc: sdhci-esdhc-imx: refactor clock loopback
 selection logic
Thread-Index: AQHbyfuQsFFBLvMC+ku2qRP90LQjVbPdQZwAgADA8kA=
Date: Thu, 22 May 2025 03:52:42 +0000
Message-ID:
 <DU0PR04MB9496789260A17A03E711A7399099A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
 <aC360rN4h3smTAj7@lizhi-Precision-Tower-5810>
In-Reply-To: <aC360rN4h3smTAj7@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PA4PR04MB7709:EE_
x-ms-office365-filtering-correlation-id: 5c5834f5-9460-4f1f-5b3f-08dd98e41b13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?RStxd2VwUWJyaXdDNExsK0pkTzREVFlkOEtzcXNPTWgzOUJGZ1BqcUxHUWo5?=
 =?gb2312?B?M250MVkxcmVVUFpWV2tScDlRNnhNT0xXdkNITnk0NEJEYkVwTWcxWlVUaUsz?=
 =?gb2312?B?MEJhZjErR0t3R2tSSFhXYmVkWnJtSVZPYUVoYWhZdFVyRnlIRmgrcFF4UW9k?=
 =?gb2312?B?bEVrdS85TE9kUTlEWkpROFByaXpzY0FFTUhMVUJlb2lJT2NGK1lkUGovNmdQ?=
 =?gb2312?B?RUN6QXBXRGlPZzRRS0VaamZJWFlCZTNLYVc5QWwyZ21oMHBWVzFZM0ZtK01Z?=
 =?gb2312?B?clFEaXZ5b0wyUDZyb1crQWlCOEwxQ3BTenBKZGFwZ3pEUHlPM2lLcGNDZjJC?=
 =?gb2312?B?elovdUdyME5VTGxNeW1uL1NwL09XOUtBOHRta0FQUFRaSWl4dDl0aHlFc0xv?=
 =?gb2312?B?TGNGUzlmejBVYkJCQzBHV0V6MXhHempZTjJHMkJKanlkbG01cVZRRS9sVXg0?=
 =?gb2312?B?WlMyd1htWEN3djZoZ3BXR1drajdZSTFOdjdUUUZzTUxMNGlnTlJKZVcxemdJ?=
 =?gb2312?B?VTFndGg4anpiaVQwbkNxMHBBamlOWkozUzMxMVhKcW9WeDJUSW9obVhEOG1r?=
 =?gb2312?B?UkFVaWlpbDNKU1BRb25IZWxFTG5hMEJETWR4WWVOa1hxM3JoUk9HdmNTS3Fn?=
 =?gb2312?B?SHhVci9lRm9tZy83Wk5SYkZsMzk2TUFOQ1c4VnRYV3BDWHlMWDBNU2xYeWEv?=
 =?gb2312?B?R2tVUVBYVmUwT3NISTlXdkd1dGpBRlR2T3B0d3JTRVlLZ25GVzJzeERkR2FF?=
 =?gb2312?B?VUdZQnJXU1p4YW5MOFFSTFNjbkRyWTlMZHdQdUJ0c0NzS2dkMlNKOHhOcnh5?=
 =?gb2312?B?VjN5TmhYZW8yVmUzRUhuU1Q2MnlLbk52MTdBQjUzMktPU280TEhnUHd6K0NL?=
 =?gb2312?B?cW1MQTRCaU1XWUtvbEVFRjlscWM5WEpKeGtzazlqWks3aVlOODg1ZVk1SGVR?=
 =?gb2312?B?UXU3aGl1d204eUJlZHdYV09pSEN0eTJaeVlOc1pvZVd5d3hycnZmMzY3eTNs?=
 =?gb2312?B?OWFka1BKMml5WjYvSlRjVndQWUN6ajRWK0RhRHRZVGpEME5DSUJNWXdQcE1u?=
 =?gb2312?B?dENTVkNlYUpYQXo0dWFjcFk1V0twREh3SkYxUHNxazhlN2hjWmpmemdpM3Vx?=
 =?gb2312?B?d3JIQjdpbUVtYStXY1o5bmRuVWkzWTNnWFpvYldhWmpqM29VVHBDd2NBVnhX?=
 =?gb2312?B?TndSRnhkV0wrZmhPM1ZnQ2JFQWVTcEVSYmdHWTJFNGNaOG5uMk0wamtZd1Jz?=
 =?gb2312?B?VXlHRUNvdWlQajA4Wktib0owSjA3RUxGbDI3WVk5UU90bjhIUCtJUnU5d0FP?=
 =?gb2312?B?V3h4QlNkbzRRdStha21PY3BWTkdqd0ZxT2d6UGRTelR5OU4xNWF0c1JYVStJ?=
 =?gb2312?B?RW9NVStQVW5WVXZ5YndyQ2tPOGdSRTc5RUhoLzJRUlNvTzdFamtTVWFyZEx2?=
 =?gb2312?B?VUdTakNUTzV3VWdIYzdmUXlYT0MyemovbUtoemdJMzhvS3dRejU5RUE4bzho?=
 =?gb2312?B?U0tYZTdvTmJscGU2K2JqRnNzMTZQN1FLZWZvQUF2Rmt2TVFFeHpCOHo1TnFq?=
 =?gb2312?B?Um1sZmQ4OUVFVWNxeTJqcldpbGtEaW50TDdJMXpHSkk1VHVNTjdTVHFRNmpZ?=
 =?gb2312?B?ZStCajRNb1hRM1ZQeXl4aVJhbjdlenY2ZlVjNFRzZmpBOE0vajRwMk9VSUx4?=
 =?gb2312?B?YU5GRWtPb1g1dE92YzNGWDZmWUI4MFJVeWIwUVBpeHZUaXJGQmc2dGJXQk5N?=
 =?gb2312?B?RnhYN2VHNXVNcDFOV2w0ZEF4UkdoT216a3pDMDhsTFNEb1ZkVEdSYTdqRlNj?=
 =?gb2312?B?QW15MTZ2ck9HNlhieU01K2hNazlzU1JzS0NnSjE5YmdWVElOcmlabkNaQ20r?=
 =?gb2312?B?YzdPTlN1OXR5bnRrSUxWSldqMWkvaEllYy9HNVBLMzNVYmtmalFYbmswSmkz?=
 =?gb2312?B?R2FOejkvVWJ5UGl4QmJFVXliZGtINWtWQVpod0Z5OE1XcU03dTUrVEw4eWlT?=
 =?gb2312?B?aEg5dlNaVXBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Q2l4RXp6bUpJcnJuS05jWVc1b0F1Vmt5WDNMRDRVWG5qS3JFU3UzeUluZUpS?=
 =?gb2312?B?ZmtEZG5WMVFDVjgzNEFOOEt5RWo3NEFpdEdUNzA0QVp3R01Kc2hCUWZaWGVD?=
 =?gb2312?B?QU5pNDVHaFFmLzlJd3YvMTd1dUFMY2Z4SWZCZ2tuQ3J6SU13WGFIQXNveG9H?=
 =?gb2312?B?bkJMU09aUkowRE5JcG1pRHBUUlN2ZlAvdm1RWGswbHRPdzhLNzhob3lHUHc2?=
 =?gb2312?B?K0ttOEVNTStybWc0VlFSdk9RUmwwYXhTemZiQVBvZ1JNM3l5MHh6c2ZzZDFF?=
 =?gb2312?B?U0taaDNJdUREL3NKL1BxbVJOZVhtSUVBbEFnTGtxOFNaL095WFp5dGJyOTBK?=
 =?gb2312?B?R2prZjJDT1lGckUzNTgxYlBpWVhmSUZrUFhhNHFnTWFQNytDdGlxMmJ4M1dT?=
 =?gb2312?B?VDhYWHpVc0FwNXhSL05VMzIwUENGWG9lcUlKTkJnZVVwcENlTHRMdjJqVllU?=
 =?gb2312?B?RnJDR2Qwd2ExSDNTWTQwS0wyRGVhdjBsSUJvWHJBZUdoTVpUbzRWSG9wWHNW?=
 =?gb2312?B?eENKakg2UWpMTk53bzFqSVRQS2IwWTZDNVhkNGlIYlBDWEpoNlJMK0d5UVZy?=
 =?gb2312?B?SFpUNmszTGoyQnJILzhFek5PVFNpN2d1NFFYLzBaMTV0dzlhNjYwNVJNbXFv?=
 =?gb2312?B?WlRYQTgvMkVZV25MRDlKelpKK2lWZ3FDQ2g5SHR3UW5oZFV0QVo5UGEyTEZF?=
 =?gb2312?B?d05JenpVVXU2V3NDSHJ5bW9nZEN6WXVTc250b0c4SFIrUDlqaFdwYjBJK09G?=
 =?gb2312?B?Y0c0QzMrVmUzaUJ6MkFETXpyNWFrZTdPcndTVCtnb2tTMkVZeVczVWQxOGJD?=
 =?gb2312?B?aWUzWkRtNzFac08vOFBIakUzK2hYRUR3d3R0amgvWU1nM3l0WVNOU2Zxc1NP?=
 =?gb2312?B?WDZDOVQxajIyenZLOFE4dHFZRVBGRUJ3NHd0N3ZONDBvS0Fob1Z3clkvaS9M?=
 =?gb2312?B?L0JObTJldHY5RjVJREhjQWQ3YlQvQ2pBY1lIYmoybFRBNzVqeUloMFZ4c0Vx?=
 =?gb2312?B?ZDRPMmRvR3NUUTljalBRSXdreVVvSklMSnVlYWFVRlRBcHFYTVo1VFZ6c2RH?=
 =?gb2312?B?UmVXTWp2VWJRWDRlcis2a2swS1VCOGNGZWVVWDRmbmFkRmNNUTYrbTI0ZzB0?=
 =?gb2312?B?RjFSWnoyNmJnOUtpNDh3SnVjOVdsWXEwY1A1TUlHU2x1VEMxdzhFRUh2SUhL?=
 =?gb2312?B?WmhXbjZzVTR0QVhVVVZVeUFoUXBEd2VSWGw5ckloblAwWHE4bndUZTJ0SkZP?=
 =?gb2312?B?Z25Lc3J1RnpDVzN1amNvbzNFMzFyazB4L0FMa001RGltc0hWMTFDOVdjTjZP?=
 =?gb2312?B?dnlsSXdSWlBHMTl5NVpmTUF5SlJuV3Q5SVc2V0ZjRkFSZWpSclFBODFjcGJ0?=
 =?gb2312?B?OXJTRzVxeEZKRjB3MWlmR0s4V2NvVHNOcGEvQXBsSXZZaHJHc0FtZDRQeXRD?=
 =?gb2312?B?cFM5VTdaak5heHIzNm5KUFJTYWN2RXU0dWtWaEltd25YcXBRbUVsb2cwSTVD?=
 =?gb2312?B?OGE5dmx1YW53VnJBTUFjZjFvcmxiUzlxK1ZuSjZHbFNGQ1NmSXVaMFgvTGVJ?=
 =?gb2312?B?SzFqTGZyNTE3VEJUcGRFR1BTa3Uyeng5VDEwTVdaS3VHTkt2MHlHbUxxMElT?=
 =?gb2312?B?TTl1bCtXNmlGSkJKYzJiaGhreHVMY0ZSYmFPMmt1eWRhb1ErempUS0xlV0FR?=
 =?gb2312?B?dktZL1Jkc1c3VG1ZcGE1SnVaQ1YvelBnRlI0UTExM250SVB2dlhxTWF0K1Jk?=
 =?gb2312?B?bWZFSU9ReU51ejhaSTZOZXNXNUI0NDlKVVFBTVJXYXIvN0pQNjVlSldKRHYr?=
 =?gb2312?B?U01aWFpEanJqc1AvQ0dqRHFwbDQvYlhFeE5RWCtkR2tNWUJSR2ptbzVlN2Js?=
 =?gb2312?B?OEpnTVBKY2UvS1N1bUxkdEp4UTg5YVJCbTZ4dnJ1Uzk4NHYwWmx2OVFjemtT?=
 =?gb2312?B?RHhjamhKK0FHSTVPUWVzWHRweENRSytXSVJvb1VRbWxQS0RMUXdlNmZqaStD?=
 =?gb2312?B?c3lHQnYveWEyVU1rV1p0bkJZNjY3UTJXcmJ3SW1Ya2IzdDhXWU1iQldlQWgx?=
 =?gb2312?B?ZGV5WnBxa0pQTnZNQnhSaEFqTU1uSWhKeEppKys4ejN3OEFhTVV6aTJSUmFC?=
 =?gb2312?Q?iSZw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5834f5-9460-4f1f-5b3f-08dd98e41b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 03:52:43.0141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ezvy0P/INASIWteBXVao55ar+QGMXkkyN0gdYuC6x6eTHpEYFxRDlhywss+wmxtJCOlR39Y9SPy6fpTpp5I8eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7709

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNcTqNdTCMjLI1SAwOjEwDQo+IFRvOiBMdWtlIFdhbmcgPHpp
bml1LndhbmdfMUBueHAuY29tPg0KPiBDYzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29t
PjsgYWRyaWFuLmh1bnRlckBpbnRlbC5jb207DQo+IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IGxp
bnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29t
Ow0KPiBpbXhAbGlzdHMubGludXguZGV2OyBkbC1TMzIgPFMzMkBueHAuY29tPjsNCj4gbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBtbWM6IHNkaGNpLWVzZGhjLWlteDogcmVm
YWN0b3IgY2xvY2sgbG9vcGJhY2sNCj4gc2VsZWN0aW9uIGxvZ2ljDQo+IA0KPiBPbiBXZWQsIE1h
eSAyMSwgMjAyNSBhdCAxMDo1NTowMUFNICswODAwLCB6aW5pdS53YW5nXzFAbnhwLmNvbSB3cm90
ZToNCj4gPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0KPiA+DQo+ID4g
aS5NWCByZWZlcmVuY2UgbWFudWFsIHNwZWNpZmllcyB0aGF0IGludGVybmFsIGNsb2NrIGxvb3Bi
YWNrIHNob3VsZCBiZQ0KPiA+IHVzZWQgZm9yIFNEUjEwNC9IUzIwMC9IUzQwMCBtb2Rlcy4gTW92
ZSBFU0RIQ19NSVhfQ1RSTF9GQkNMS19TRUwNCj4gPiBjb25maWd1cmF0aW9uIGludG8gdGhlIHRp
bWluZyBzZWxlY3Rpb24gZnVuY3Rpb24gdG86DQo+ID4NCj4gPiAxLiBFeHBsaWNpdGx5IHNldCBp
bnRlcm5hbCBsb29wYmFjayBwYXRoIGZvciBTRFIxMDQvSFMyMDAvSFM0MDAgbW9kZXMNCj4gPiAy
LiBBdm9pZCByZWR1bmRhbnQgYml0IG1hbmlwdWxhdGlvbiBhY3Jvc3MgbXVsdGlwbGUgZnVuY3Rp
b25zDQo+ID4NCj4gPiBQcmVzZXJ2ZSBFU0RIQ19NSVhfQ1RSTF9GQkNMS19TRUwgZHVyaW5nIHN5
c3RlbSByZXN1bWUgZm9yIFNESU8NCj4gPiBkZXZpY2VzIHdpdGggTU1DX1BNX0tFRVBfUE9XRVIg
YW5kIE1NQ19QTV9XQUtFX1NESU9fSVJRIGZsYWcsDQo+IGFzIHRoZQ0KPiA+IGNvbnRyb2xsZXIg
bWlnaHQgbG9zZSByZWdpc3RlciBzdGF0ZSBkdXJpbmcgc3VzcGVuZCB3aGlsZSBza2lwcGluZw0K
PiA+IGNhcmQgcmUtaW5pdGlhbGl6YXRpb24uDQo+IA0KPiB3aGF0J3MgbWVhbnM/DQo+IA0KPiBj
b250cm9sbGVyIGxvc3QgcG93ZXIgZHVyaW5nIHN1c3BlbmQsIHNvDQo+IHUzMiBtID0gcmVhZGwo
aG9zdC0+aW9hZGRyICsgRVNESENfTUlYX0NUUkwpIHRvIGdldCByZXNldCB2YWx1ZSBhbmQgbWlz
cw0KPiANCj4gc2V0IH5FU0RIQ19NSVhfQ1RSTF9GQkNMS19TRUw/DQoNCk1pc3Mgc2V0IEVTREhD
X01JWF9DVFJMX0ZCQ0xLX1NFTC4NCg0KUHJldmlvdXMgU0RJTzMuMCBkZXZpY2Ugd2l0aCBNTUNf
UE1fS0VFUF9QT1dFUiB3aWxsIHNldCBFU0RIQ19NSVhfQ1RSTF9GQkNMS19TRUwsDQpBZnRlciBz
eXN0ZW0gcmVzdW1lLCBuZWVkIHRvIHJlLWNvbmZpZyBFU0RIQ19NSVhfQ1RSTF9GQkNMS19TRUwu
IEJ1dCBTRElPMy4wIGRldmljZSB3aXRoDQpNTUNfUE1fS0VFUF9QT1dFUiB3aWxsIG5vdCByZS1p
bml0aWFsaXphdGlvbiwgYnV0IHdpbGwgY2FsbCBzZXRfaW9zLT4gc2V0X3Voc19zaWduYWxpbmco
KS4NCg0KUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gRnJhbmsNCj4gDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgMjcgKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMyBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LWVzZGhjLWlteC5jDQo+ID4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+
ID4gaW5kZXggNzYxMTY4MmYxMGMzLi5jNDQ4YTUzNTMwYTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBAQCAtNzI4LDIzICs3MjgsMTcgQEAgc3RhdGljIHZv
aWQgZXNkaGNfd3JpdGV3X2xlKHN0cnVjdCBzZGhjaV9ob3N0DQo+ICpob3N0LCB1MTYgdmFsLCBp
bnQgcmVnKQ0KPiA+ICAJCXdyaXRlbChuZXdfdmFsLCBob3N0LT5pb2FkZHIgKyBFU0RIQ19WRU5E
T1JfU1BFQyk7DQo+ID4gIAkJaWYgKGlteF9kYXRhLT5zb2NkYXRhLT5mbGFncyAmIEVTREhDX0ZM
QUdfU1REX1RVTklORykgew0KPiA+ICAJCQl1MzIgdiA9IHJlYWRsKGhvc3QtPmlvYWRkciArIFNE
SENJX0FVVE9fQ01EX1NUQVRVUyk7DQo+ID4gLQkJCXUzMiBtID0gcmVhZGwoaG9zdC0+aW9hZGRy
ICsgRVNESENfTUlYX0NUUkwpOw0KPiA+IC0JCQlpZiAodmFsICYgU0RIQ0lfQ1RSTF9UVU5FRF9D
TEspIHsNCj4gPiArCQkJaWYgKHZhbCAmIFNESENJX0NUUkxfVFVORURfQ0xLKQ0KPiA+ICAJCQkJ
diB8PSBFU0RIQ19NSVhfQ1RSTF9TTVBDTEtfU0VMOw0KPiA+IC0JCQl9IGVsc2Ugew0KPiA+ICsJ
CQllbHNlDQo+ID4gIAkJCQl2ICY9IH5FU0RIQ19NSVhfQ1RSTF9TTVBDTEtfU0VMOw0KPiA+IC0J
CQkJbSAmPSB+RVNESENfTUlYX0NUUkxfRkJDTEtfU0VMOw0KPiA+IC0JCQl9DQo+ID4NCj4gPiAt
CQkJaWYgKHZhbCAmIFNESENJX0NUUkxfRVhFQ19UVU5JTkcpIHsNCj4gPiArCQkJaWYgKHZhbCAm
IFNESENJX0NUUkxfRVhFQ19UVU5JTkcpDQo+ID4gIAkJCQl2IHw9IEVTREhDX01JWF9DVFJMX0VY
RV9UVU5FOw0KPiA+IC0JCQkJbSB8PSBFU0RIQ19NSVhfQ1RSTF9GQkNMS19TRUw7DQo+ID4gLQkJ
CX0gZWxzZSB7DQo+ID4gKwkJCWVsc2UNCj4gPiAgCQkJCXYgJj0gfkVTREhDX01JWF9DVFJMX0VY
RV9UVU5FOw0KPiA+IC0JCQl9DQo+ID4NCj4gPiAgCQkJd3JpdGVsKHYsIGhvc3QtPmlvYWRkciAr
IFNESENJX0FVVE9fQ01EX1NUQVRVUyk7DQo+ID4gLQkJCXdyaXRlbChtLCBob3N0LT5pb2FkZHIg
KyBFU0RIQ19NSVhfQ1RSTCk7DQo+ID4gIAkJfQ0KPiA+ICAJCXJldHVybjsNCj4gPiAgCWNhc2Ug
U0RIQ0lfVFJBTlNGRVJfTU9ERToNCj4gPiBAQCAtMTA4Miw3ICsxMDc2LDYgQEAgc3RhdGljIHZv
aWQgZXNkaGNfcmVzZXRfdHVuaW5nKHN0cnVjdCBzZGhjaV9ob3N0DQo+ICpob3N0KQ0KPiA+ICAJ
CWN0cmwgJj0gfkVTREhDX01JWF9DVFJMX0FVVE9fVFVORV9FTjsNCj4gPiAgCQlpZiAoaW14X2Rh
dGEtPnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxBR19NQU5fVFVOSU5HKSB7DQo+ID4gIAkJCWN0
cmwgJj0gfkVTREhDX01JWF9DVFJMX1NNUENMS19TRUw7DQo+ID4gLQkJCWN0cmwgJj0gfkVTREhD
X01JWF9DVFJMX0ZCQ0xLX1NFTDsNCj4gPiAgCQkJd3JpdGVsKGN0cmwsIGhvc3QtPmlvYWRkciAr
IEVTREhDX01JWF9DVFJMKTsNCj4gPiAgCQkJd3JpdGVsKDAsIGhvc3QtPmlvYWRkciArIEVTREhD
X1RVTkVfQ1RSTF9TVEFUVVMpOw0KPiA+ICAJCX0gZWxzZSBpZiAoaW14X2RhdGEtPnNvY2RhdGEt
PmZsYWdzICYgRVNESENfRkxBR19TVERfVFVOSU5HKQ0KPiB7IEBADQo+ID4gLTExNzcsOCArMTE3
MCw3IEBAIHN0YXRpYyB2b2lkIGVzZGhjX3ByZXBhcmVfdHVuaW5nKHN0cnVjdCBzZGhjaV9ob3N0
DQo+ICpob3N0LCB1MzIgdmFsKQ0KPiA+ICAJCSJ3YXJuaW5nISBSRVNFVF9BTEwgbmV2ZXIgY29t
cGxldGUgYmVmb3JlIHNlbmRpbmcgdHVuaW5nDQo+ID4gY29tbWFuZFxuIik7DQo+ID4NCj4gPiAg
CXJlZyA9IHJlYWRsKGhvc3QtPmlvYWRkciArIEVTREhDX01JWF9DVFJMKTsNCj4gPiAtCXJlZyB8
PSBFU0RIQ19NSVhfQ1RSTF9FWEVfVFVORSB8IEVTREhDX01JWF9DVFJMX1NNUENMS19TRUwgfA0K
PiA+IC0JCQlFU0RIQ19NSVhfQ1RSTF9GQkNMS19TRUw7DQo+ID4gKwlyZWcgfD0gRVNESENfTUlY
X0NUUkxfRVhFX1RVTkUgfCBFU0RIQ19NSVhfQ1RSTF9TTVBDTEtfU0VMOw0KPiA+ICAJd3JpdGVs
KHJlZywgaG9zdC0+aW9hZGRyICsgRVNESENfTUlYX0NUUkwpOw0KPiA+DQo+IAl3cml0ZWwoRklF
TERfUFJFUChFU0RIQ19UVU5FX0NUUkxfU1RBVFVTX0RMWV9DRUxMX1NFVF9QUkVfTUFTDQo+IEss
IHZhbCksDQo+ID4gIAkgICAgICAgaG9zdC0+aW9hZGRyICsgRVNESENfVFVORV9DVFJMX1NUQVRV
Uyk7IEBAIC0xNDMyLDYNCj4gKzE0MjQsMTUNCj4gPiBAQCBzdGF0aWMgdm9pZCBlc2RoY19zZXRf
dWhzX3NpZ25hbGluZyhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQNCj4gdGltaW5n
KQ0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJfQ0KPiA+DQo+ID4gKwlpZiAodGltaW5nID09IE1NQ19U
SU1JTkdfVUhTX1NEUjEwNCB8fA0KPiA+ICsJICAgIHRpbWluZyA9PSBNTUNfVElNSU5HX01NQ19I
UzIwMCB8fA0KPiA+ICsJICAgIHRpbWluZyA9PSBNTUNfVElNSU5HX01NQ19IUzQwMCkNCj4gPiAr
CQltIHw9IEVTREhDX01JWF9DVFJMX0ZCQ0xLX1NFTDsNCj4gPiArCWVsc2UNCj4gPiArCQltICY9
IH5FU0RIQ19NSVhfQ1RSTF9GQkNMS19TRUw7DQo+ID4gKw0KPiA+ICsJd3JpdGVsKG0sIGhvc3Qt
PmlvYWRkciArIEVTREhDX01JWF9DVFJMKTsNCj4gPiArDQo+ID4gIAllc2RoY19jaGFuZ2VfcGlu
c3RhdGUoaG9zdCwgdGltaW5nKTsgIH0NCj4gPg0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==
