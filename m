Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022101.outbound.protection.outlook.com [52.101.126.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E070B279DB4;
	Mon, 16 Mar 2026 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773626400; cv=fail; b=c89odADojYxpxuH3YBs0+9FaZafk/tW9Ba8mU+eZwGZe1xPWv6NG2l93ZGBgnJWUiGSqOTf5j6FxhUpIbEEXKQcdDKIv4VWs7MEVAYHDzsAnsEp6+UAcjYINqUd3floCZMv9TGsy3JhMws+qLoLY6g147zSt6nqOuZq8y6swzQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773626400; c=relaxed/simple;
	bh=uayxAHEOH6G9tcdwZ0jGA2Xvk0GudvbzwJZ0t2WOJoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dGh5AmJunsll8tHRwttgAyM1PGrd7g6N/BhgGCrtlJtHLQLG1hfK3pJfQP4vgcWciZfz+9e7R5i3dlGS+nJdZZ0/teFJpnEDZ8W7hxTR9WWKJu1eHthmHy9FvMmtne/Bez3KoBZE/4b/eXp/upVFp6k1dwtfvpNJV2HJyBs3GYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=VjcxXZD/; arc=fail smtp.client-ip=52.101.126.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="VjcxXZD/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0uy5jGpWaIJH88dzy4nwUGUk/2qTrWd8IaWZocy5JZskhp4RLmjUuxjWLvVnpLkQotzEcsRExit6YdRrRXIesABYWj8kwiv0xlm2PgPZvtLSB8v/x34tWfH+GsFUIKarAIT49prN89XSyodw8uAjdkqVGPvyTNoVLpO/hJuU/B4wptHLUsY0SoxQgyxEIcb4ozYW+7vEeXEQjUcYVT8BYM4ZjFmyVPtSqLm8ZzIkyP6Nm8c7kHYGv9rS1rG/LUG0iANkfGqN/zQv6QcoVdRidaPaqD7Jnjxpbxv2MriKxASoKLBgtlGeRTcdTZv2VrGbfJ1xmmCsyx/1QAD+l9/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uayxAHEOH6G9tcdwZ0jGA2Xvk0GudvbzwJZ0t2WOJoI=;
 b=G8HsmiH5xG95Aw+8djufOEszx4sO2snzaq8mV/CoRACuifdeE3b/GyrJTfwK5UH+09C55Q+Ze+PdAe/rcQWMzus5Tqe5bMz+mYm0BmUu+t29hBWHZhyu7ckPVrIyWUIvV1+bpfM+KJtV4DaeK9J2c1+X/f8it1hZGWKvNNIXUEh1kEsQF9lP60HvUaE1WGYP7dAitMyk18dUSXHw5vK49SmsIkNPmZzPKKg3YfA3M6IivFG8bk67hUNr8qePeguhDWG5vfgnfsUjwfYVjKyMHZ6YNMoZdUbpyFmI2lhZ/E1RHrgLIeg8kgtz1yAMbR3R1Kk3dJZFNsl5XFzOG3H7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uayxAHEOH6G9tcdwZ0jGA2Xvk0GudvbzwJZ0t2WOJoI=;
 b=VjcxXZD/Z7s0pS/bfuCS5IamhxXlU4cvZRd3t9n6+0wBRlqhOgvaOyxcigcQxGmVLMmWHTGoPMwNgW0c3h0vPQXBP0L+A+Oof0xgePV7PN3hOlmhAL/jv+tVCS39Aqoq5CvaBbjm6J/OrTqCRvjcIP7s/mcT5Y0HuZPZ/VF/MQWYRpHsq5Ycb4RROvWUUt648y86rQrX/9/4WcBCGpSWNAi8EmYFV0XG891mF5Uc3o0SM5C4XUUlfz0oXU5vi2cJ16BmlpBL9CHrJ63eGS3qCQ8ka4E/DsuNXFArUrisEz0/en/i7+M+xBfL2ivOQ/mRWSkPODUQ4/0/FXf9R8SqLw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SI4PR06MB8447.apcprd06.prod.outlook.com (2603:1096:4:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 01:59:54 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9700.013; Mon, 16 Mar 2026
 01:59:54 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, Andrew
 Jeffery <andrew@aj.id.au>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: mmc: sdhci-of-aspeed : Add ast2700
 support
Thread-Topic: [PATCH 1/2] dt-bindings: mmc: sdhci-of-aspeed : Add ast2700
 support
Thread-Index: AQHcsqopjK784zsJ3EOO/aaV/1EcKbWt08yAgAKWopA=
Date: Mon, 16 Mar 2026 01:59:54 +0000
Message-ID:
 <TY2PPF5CB9A1BE688A53DE6D5CBEC46CE94F240A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
 <20260313-sdhci-v1-1-91cea19c8a67@aspeedtech.com>
 <20260314-naughty-tody-from-vega-116b3d@quoll>
In-Reply-To: <20260314-naughty-tody-from-vega-116b3d@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SI4PR06MB8447:EE_
x-ms-office365-filtering-correlation-id: 6a2ea1c2-7856-41da-8b99-08de82ffb792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 qviR3DBj0pISHQFtAKXn2BRh85M85Fu8daSlFNmmXMZSB2nQ6rNdKFBxYGsgtJYFSqBec2IGI6gVIEBdvtg12EQFGvsDL5H8yRI3zz0O6hMU0auMBzQ1daJ7r61ZQQyJvEdYRYA0EyRmj9F018MUk0PODfxqAfDnRPLVmGNncdEWVVkcVlcqiaO+2xFOIFnbVKWm6t4Wwfv0gOIhFBAlKhEnYySad+k3i4JEVRtUGkS3hycv4bgZHqHgbFsDlaDzukBNHo62Fo2tlmB37iQGRGEsetr6dtl5dcyOLEbZ/qtmAIswxjbKxGu9KBB2eJrI+5ZlqFq1IMjBZ0myw/l9Bs8G8fxTWg83bLXxVnvh1BJij6wc429wIcSbFWTjAyBXYBB/zXcpxSvJ1JxdBnu7P9Bd7/sJ+6lWQPVFQIjWld3Wz/QX35ALSzXv9KFYgJEd1tjrRy9X+dobWmFAGluhBsJBX4YLmo528c2HlbM4X69RVw8UcbIWvDkVXdD8364+4wYWntKXBKZdt+klUiBQrMF6E8OBHycCgSsp1o75HI1a2VuhvP5Yvc4HMQ1kuO4DeIm3kYTiG0ktxYYySQLckawioCSTy2aJEmEUMtmxwDGoNBQemxo7tsvgNFGE2qg8a9Clvh1JH1p2ilZ0mfIL1+A44XwUauKr2NcTJerdGULfhvu+3nM0zxq8ojN8TvTJGLy1NHs6B+ivEWlssyfAHucO5or8AYnt/8pNHQTkVlpFe5VqDXqRY+vzqQ/53vbziTUWWvHkaA2Qhp5GmKVENRKuOnhmFaUx3iMMGkugADo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djl0R2taMkticUg4ZXQwU1FVMzhMTVRMK0s4ejNnN0c5d0JDaHpyV2lNTXlv?=
 =?utf-8?B?bWRaTXArQ0dBVEFFMzBsaW1ZSXBNUytJL25NRWxMaGsvVzRpSnh3K0IzUndY?=
 =?utf-8?B?Q2NnRFFNczNyM0tPVkdxQTVSUUM3TFRLTlJrWldBM1NNRWNDa0o5STNoNnVQ?=
 =?utf-8?B?clkweWg2Q2NxR1ljOGk4QTBWQWsvREFSSkR6ZVRGOVFCaTZPRHI2bHJzaTR3?=
 =?utf-8?B?VW1BU0FQR1Y4Mmt2L2ZoUUlNdks0WWlaT1I0NFpTNDZiVXZ3cm51RHVTdDRW?=
 =?utf-8?B?OXh3U0hBdWZGck1CaVhaZGdBUGtwOGxPUzhDQ0hIbzgwS1ZUSDRXY05xMzRw?=
 =?utf-8?B?QnZFTXdvOVRmNVZIN3BDUk91WWE4QnZFU1lxQUVqdFlta2E4RzNpTFlIOTZC?=
 =?utf-8?B?a2tjVHR5eE4zeVlUS2Z4clpzUzkyVnk3dkdKMWNSZ2ErbDJQSXFRVjVVaTJD?=
 =?utf-8?B?U2JjWVhQcWRwTUlITklmT29LUHgxRUZscWpLazJYdEZCOGR1VlFHMi9CWXAv?=
 =?utf-8?B?RE9ONHNiRGx1SWhON0JxVUR5NnUrTGFrR3ZEYTJtOTZ6NHBNbXlRd1BnTVMx?=
 =?utf-8?B?OXBaVEoyaEdMdVFKZ3Y0OGxzSDlycWFKb21mZmdqeDkxQU1VSVFPb3lnSDR3?=
 =?utf-8?B?UVVWQytYbFhqSmZLTjM0UDlRMVM3NTZzWDNvc2E5R01xb2JUa2hlYkNLK05h?=
 =?utf-8?B?VUtMb21TNUQ2OXpYcFJQbXhIQUIxSlhCV1YwT3dHR25JUkVhMkxkS3lKeE42?=
 =?utf-8?B?WHo3UVpFVXhCbXplMEZsdElmTU1pRDFSRXhUaVBERGVHR09UVmJtM3Yrc0Vs?=
 =?utf-8?B?OXowUlVqdEwvT1BnN2RNQUxweE8wL2V4a0Mzd09HRmFTeXJEQUh6bHp0cGhG?=
 =?utf-8?B?NUYzeVpOaW9MR2d0bzZxanRPbkoyRC8yY21DRXd0cm9PSE9KQUZiSHRZUGNt?=
 =?utf-8?B?Y3kxbks4Unh3YzhrN3cvOWpGQ09vVk1STWZTSzRwUVA3Y1V2eld1L1ZVUVdU?=
 =?utf-8?B?cGNiWGI3cXhRa3E3dDhBYWdXMkJEQmR4ZVcrNUx2UXNBbkE1eG9WS2RvRUpQ?=
 =?utf-8?B?aXk3Z1F5NGVqaVh6bmt0MmRXUjJuZy96Z2N5STNDZW5nTnh6eVhPc3VIZFhO?=
 =?utf-8?B?eEQ1R21tWHpadHBzeXJ1L2tpa2pudmNtbWlIcC9vRmFnd0ZQTFFPTlE2UXI4?=
 =?utf-8?B?WnJCcWVPWVNaYkZtc2JyYnpCTVBOWDkvMGtvdThRRmMveko3TFdISXVLOEdS?=
 =?utf-8?B?WGlienNWUk84Ny9NV3NxcDlJVkhkSkszSWZ0bDFhMWFtaTlKdFg4UWNrTmQ0?=
 =?utf-8?B?aXVWclZEWHh2TDAvM2FUUzFHanoxT2Y1eTlGU1FKOG0wVmhwUmZVV1UwbHhl?=
 =?utf-8?B?M2RtLytrOWl1QkdyQVBWZGdFVlFHVlRERHdqaTJjd1p3MTNxK05sUzUxRGcz?=
 =?utf-8?B?VnMrRFp0dnVNbStmemdrMmhCbThaUkVFUXltVVFYVnVYODdXU2RTMWpTRytq?=
 =?utf-8?B?czkxbDVrQzYzS3ZCNms3aHBZQUJUT1BDd2x3OEJrLzBkOUJMa0NqMW8rOEVo?=
 =?utf-8?B?NC9EK1hCSEh1aTVqNi9PeUUyWjhIT2RYRURHL1NvczEvRGx0eFU3Nm95U0Nr?=
 =?utf-8?B?RnRrMlVWcXJ3THB1c0w2bWd1bXJNMkVtOE04SmRLU2hwZ1hOYUJkcGoxQ0FL?=
 =?utf-8?B?b1dMU3AzTzJaVVpFR3V2akxmUDNPRUNKTncxL1d4Ym44SVQ2U3NTclNxTmFm?=
 =?utf-8?B?RFhhUGlxQXh4ZUZvNjh0U0F6QlpXLzFyS0lvdmFkTWNnaXI0V0l3cXdXeHVP?=
 =?utf-8?B?S2J3ZnNjSnhUQVhvK1hYNWljUlFXclU3bzZ5NDF1cFZPWVkyN2thSW9HcDc1?=
 =?utf-8?B?S3BSVkdiMjN0MVdGTVNuQzA4RnE5aUduNFUyZ3M2MGdDT0dIa2V6MlA5MGZF?=
 =?utf-8?B?bHZiR29BMnFUYU9ScXk5T09mN05CR1ZzODUrV2szZk9yYkY1YUVQZE5EZHZy?=
 =?utf-8?B?cm9vZmtyVWZnQlNLYi9LaXN0U0xyNVVEU1huZkxvVmFwdVRnaU13Y2FzdkJw?=
 =?utf-8?B?TFROOXpIMkhYaTQ1U1FQN3hyWVU4a1hUMzFpaUdKZVNsSnlTSUZPM3FMcHpq?=
 =?utf-8?B?RUhnaXllTGEwQzJHcXV2RWFWWENOVVpwU3JyeDk3NVd3VVhaeU1Sa2tzMURC?=
 =?utf-8?B?OHNtVTZocHR5dlR5QnJXdytYeDBkWHM1ZEdUNUlLc1AzcjRmTW50ekhlZnpj?=
 =?utf-8?B?UVFSOHZudGYyejk1K0h6TmpTTVlMYzhpZWlxZmlFWGVUVkxuMDA3WjRwVkcv?=
 =?utf-8?B?NStnQ1JaMUM5Y2xHOEJwZ1ViUm9rME9rUldLMnovQ1VENUFPU2JVZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Q7Y2Eclt3X5ucB94f7iYRXCQatwVyn66O2HIW7e1poeJpCPMpvhtIrceu12SVo+bveLDywrO2+bQuIXMKrFvShpkzchJz4BjmICcNMEHTpHxpNK7bl0LgAPubA8u2cRZcsXMKKjfvrigAuGZqMtguQZI2hJU5pvbEvjnQo+SN/s6XUR7NY0R5gELJLEZ5Vq1LNL9AwWBSz4W4282kxdDfKqrYKhQFxAQ2AdgsP7BrTtDihryoBTgEJ7YdIAZTNhMEmK3af50VxWRd+BqqpghqGo6NXu7ag8u9VdbRKRoUq4JlXhPg5iEhXrQYvETIHzHKet3hB/OJA/yAH9/sDlV4g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2ea1c2-7856-41da-8b99-08de82ffb792
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 01:59:54.0860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuGKUNW8/aVT7ASHWt8L6A5zMVJLDixT2p+Y52yFF+TPPnmnhtAbOEEklpvIyq+EuDHEAvDM1jL8oP5kiQJu7rX3qdP4Yc46imPLJ23PzU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8447

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IG1tYzogc2RoY2ktb2YtYXNw
ZWVkIDogQWRkIGFzdDI3MDANCj4gc3VwcG9ydA0KPiANCj4gT24gRnJpLCBNYXIgMTMsIDIwMjYg
YXQgMDE6Mjc6NTZQTSArMDgwMCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+IEFkZCB0aGUgImFzcGVl
ZCxhc3QyNzAwLXNkLWNvbnRyb2xsZXIiIGNvbXBhdGlibGUuIFRoZSBhc3QyNzAwIHNkaGNpDQo+
ID4gY29udHJvbGxlciByZXF1aXJlcyBhbiByZXNldCwgc28gbWFrZSB0aGUgInJlc2V0cyIgcHJv
cGVydHkgbWFuZGF0b3J5DQo+ID4gZm9yIHRoaXMgY29tcGF0aWJsZSB0byByZWZsZWN0IHRoZSBo
YXJkd2FyZSByZXF1aXJlbWVudC4NCj4gDQo+IFN1YmplY3QgLSB0aGVyZSBpcyBuZXZlciBzcGFj
ZSBiZWZvcmUgJzonDQpXaWxsIHVwZGF0ZQ0KZHQtYmluZGluZ3M6IG1tYzogc2RoY2ktb2YtYXNw
ZWVkOiBBZGQgYXN0MjcwMCBzdXBwb3J0DQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUnlh
biBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXNwZWVkLHNkaGNpLnlhbWwgfCAxNg0KPiA+
ICsrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bW1jL2FzcGVlZCxzZGhjaS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbW1jL2FzcGVlZCxzZGhjaS55YW1sDQo+ID4gaW5kZXggZDI0OTUwY2NlYTk1Li5hMmZm
OWE5NGRiMTMgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21tYy9hc3BlZWQsc2RoY2kueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvYXNwZWVkLHNkaGNpLnlhbWwNCj4gPiBAQCAtMjYsNiArMjYsNyBA
QCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAtIGFzcGVlZCxhc3QyNDAwLXNkLWNvbnRyb2xsZXIN
Cj4gPiAgICAgICAgLSBhc3BlZWQsYXN0MjUwMC1zZC1jb250cm9sbGVyDQo+ID4gICAgICAgIC0g
YXNwZWVkLGFzdDI2MDAtc2QtY29udHJvbGxlcg0KPiA+ICsgICAgICAtIGFzcGVlZCxhc3QyNzAw
LXNkLWNvbnRyb2xsZXINCj4gDQo+IE1pc3NpbmcgYmxhbmsgbGluZXMgZXZlcnl3aGVyZSBpbiB5
b3VyIHBhdGNoc2V0Lg0KV2lsbCBhZGQgYmxhbmsgbGluZXMuDQo+IA0KPiA+ICAgIHJlZzoNCj4g
PiAgICAgIG1heEl0ZW1zOiAxDQo+ID4gICAgICBkZXNjcmlwdGlvbjogQ29tbW9uIGNvbmZpZ3Vy
YXRpb24gcmVnaXN0ZXJzIEBAIC0zNyw2ICszOCwyMCBAQA0KPiA+IHByb3BlcnRpZXM6DQo+ID4g
ICAgY2xvY2tzOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPiAgICAgIGRlc2NyaXB0aW9uOiBU
aGUgU0QvU0RJTyBjb250cm9sbGVyIGNsb2NrIGdhdGUNCj4gDQo+IEJsYW5rIGxpbmUNCldpbGwg
YWRkIGJsYW5rIGxpbmVzLg0KPiANCj4gPiArICByZXNldHM6DQo+ID4gKyAgICBtYXhJdGVtczog
MQ0KPiANCj4gQmxhbmsgbGluZSwganVzdCBvcGVuIGFueSBvdGhlciBiaW5kaW5ncy4gSWYgdGhp
cyBpcyBiZWNhdXNlIHlvdSB1c2VkIExMTSwgdGhlbg0KPiBvYnZpb3VzbHkgTkFLLCBiZWNhdXNl
IHdlIHNob3VsZCBub3Qgd2FzdGUgdGltZSB0byByZXZpZXcgdW5zdXBlcnZpc2VkIHBvb3INCj4g
cXVhbGl0eSBMTE0gb3V0cHV0LiBJdCBpcyB5b3VyIHRhc2sgdG8gcmV2aWV3IGl0LCBub3Qgb3Vy
cy4NCldpbGwgYWRkIGJsYW5rIGxpbmVzLg0KDQpXaGVuIEkgc3VibWl0LCBJIGRpZCBjaGVja3Bh
dGNoLnBsIGFuZCBhbHNvIA0KRFRfU0NIRU1BX0ZJTEVTPURvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvYXNwZWVkLHNkaGNpLnlhbWwNCm1ha2UgZHRfYmluZGluZ19jaGVjayBX
PTEgZGlkbuKAmXQgc2VlIGVycm9yLCBJIHdpbGwgcmV2aWV3IGl0IGFnYWluLiANCg0KVGhhbmtz
IHlvdXIgcmV2aWV3Lg0K
