Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023085.outbound.protection.outlook.com [40.107.44.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06437A4B7;
	Wed, 18 Mar 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821388; cv=fail; b=hn/XgnSKYpdM0C11yTFfwn9Ahatk7iz1Sow9q49F2BGJZM3wyKjzvRG4jg4nrvaV4NuBQpIWDsDwfd0WDqyLOFMODVeRshWlBzDDbgTzHAsKctz0mgxGAuHu4zuq21EbjnoolUIMsaRUZoTF207/kMhDQY4iyiZAXjsin15i9l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821388; c=relaxed/simple;
	bh=KLYa/O9sh2jNk9yIxeNqPGl/azn8NQTv+uUXihZgOyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pRtMTDtMqLm6nhz97lPTLtVH6jYSWI3X6tU09oIz03zf1Zv6/Fn6OtoDBd0txOzRYQmbc58ioe5ifZbV6GtSkSFgpbIkPJ45LY3+bGOdXoDfAFXPGwFBsh95eTSLX1UQPkKUcW5u6TE/r+3lBj3Gqcl6EBZw/TKmpDzzjxxb88w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=jgELXod+; arc=fail smtp.client-ip=40.107.44.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="jgELXod+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyQekr163xwaD7oe6aJb07CSJCvWT5NPTyXAJMvSarX/KwpytOzgrX8tx/VY4w0e8UBMqku+MHmcwK7MrEHeVheGa/vBV+oJJKc/SWyzLQztBAA+VUSHyCKTZheTQlJhOAHANBWanKRki+ZDbKzwTTknAzCpjUTxCCZKSRu+imxeRyy61dLZRKOx5NGrIcQMvHsGlrVivJIEuuwOJ7AtAJE3kpwqoib58XFWFSYqjVN+ZXcSvoywv/OV1tSIWx5dK0QuhQ2Iqs7ztc1sdLPqK9doouwwQHJSyZ8xpYsNRDOfZeojX/h4GubYI0wHtpZjygML0tZzhLrd+9zwS6q2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLYa/O9sh2jNk9yIxeNqPGl/azn8NQTv+uUXihZgOyU=;
 b=PrpOVsCRhTLTPsIOgu+sphT9Qg90YqY9Enfb1cou13W11YAg8o3BMaI+27+v84S1HAIn6MW/worVZ1c1H0JAJM7n6jJd5n3lRTBQ78B62InklPm04OC12tdztYPz+SOihUlikrflIaEENsgA4m4peryZLV5UBqUpJgvKoUb0HtNReLfuLJcnxOZOQhl5p2NuuUx5rPH238shloQtdm7sNm2+QamN6I1T1SImq5nDkXP5SzURAOqSYmT/Uo1eyZUxNvi3IpeUv7ApfIAj19jL9/HiuzwkmHO8KK9beV7NX9hx9GYQ7SyT7nQNSMVLFmuzrkkM+5O9+vvPd6Po+5ZgvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLYa/O9sh2jNk9yIxeNqPGl/azn8NQTv+uUXihZgOyU=;
 b=jgELXod+5FB3fqb7TZPOAlBowo5sD+EMFOZL76M/J+39oS/XH7lodUGM4tQls8T+yv4ZRHbaGjpCGxhkpNWIDq9IMVUrw7qzOeBpePk9G03f/d5HntmIjRwbnCWlzlGoH0AtxB0ZqeSxDYJAg/AuEI3/WS+JwuoSHlSUPFq6eALEbroTInjQwFZYaRduuarNfS5dPdOmOqpMBxLje5JsfHHx9Z3lAPaEQRN8MuqLdnfg/9J9VAzbrsxz7Y+iT11OGSxA4oYdzS1CPwq+DLcPoqClodGdro+tbEKMkXOzKhtvCic1wNoZXyl026GEWb7LgOQNBd5Chos00JBQuPDpvg==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by PUZPR06MB5935.apcprd06.prod.outlook.com (2603:1096:301:106::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:09:43 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9700.013; Wed, 18 Mar 2026
 08:09:43 +0000
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
Subject: RE: [PATCH v2 1/2] mmc: dt-bindings: sdhci-of-aspeed: Add AST2700
 fallback compatibles
Thread-Topic: [PATCH v2 1/2] mmc: dt-bindings: sdhci-of-aspeed: Add AST2700
 fallback compatibles
Thread-Index: AQHctdLYEgta6oUwokG3QEh/PPkOl7Wz7V8AgAAA4JA=
Date: Wed, 18 Mar 2026 08:09:42 +0000
Message-ID:
 <TY2PPF5CB9A1BE666DEF10944BBA2A2256BF24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260317-sdhci-v2-0-39b1f063061b@aspeedtech.com>
 <20260317-sdhci-v2-1-39b1f063061b@aspeedtech.com>
 <20260318-abiding-sloppy-poodle-efd3e5@quoll>
In-Reply-To: <20260318-abiding-sloppy-poodle-efd3e5@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|PUZPR06MB5935:EE_
x-ms-office365-filtering-correlation-id: 665c47b8-3df3-4c76-55d5-08de84c5b600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 iomZ4x3wKUwzzukfYTbZQX607jAvFX9TyVmb7iyfq/M61PrfH0c0nEVXgm0L/3OTG08zbglHC+EyRBuqHHFMuK3ioF3s6RmjAKuwoTLDZHByEgkXYYiLXb3Yu+lVRqHtXntNEX/ZymJJANDsKhDHmwuwcoUUBxAGZC/4Uq/BMIq6HeVPCMzoti9PtN/kn1h2B4is62taA7VmqXyE44K0hMxvaATepCQ5AEHQ66ICdSSd3wOgPwb+xUz/re1LtnsJpXEQcLo03a3RXff9cjFEynHEim+cJyx+4X8ivZz0IJuMNalemKorjYp7cQ/yO0/BI5dRoWDLhC81M6upJdhGG46PXLu0S3WCUicKPihtFCTk6B33oruxVTK6oi9nfUCXROR4p76Ura+u53WF62c6EaDHqxCrKUvefhLKcIeVpEG7lZmG2gw4mTatAbhF7qTd+c/E2o90Biae3LxbB2lmMNZGQubQ7BNom3O21ELBomC+dkaiP7zdTdRQgOWbn/y2e97r9rLWF9ZUTM/CwZdKPScZYotPsgmugZir9TVXVQF9eyBfwOP/B8vZe4ROoXeRryz5Y37j3sM6REyvO2q+GnyjQKxPOVy15X66EIXRv0zHxhFpdC31OI5S3iVF/Wte6KQxKAN+R/3Zxp4UCThYopHukvsu6tFeXoMo+6HVkDZtxI9norlMZJwDywTrLU1WUxeZTf3eowPlpjZsC1OzIRia/PCJh3TeQUjklidXrZGietev/1duWh4FECcdxW5Q
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3EwQjkzb1J4a3d4Q2UrSWVwcHhzN0piNTcwdTB0WFhCU21lU0RrcG9jTUJC?=
 =?utf-8?B?SUNlRDV4RnJ6NDIzWkdiTm1kVDRsZkt4WU16T1R4eTEzdkVFVHEyUXFISEFt?=
 =?utf-8?B?NkxzalExSVMvemVzd2JhWHpMQXlBM0ZZdkVhR1JiOEJKcnAzWXU0MDZOcldT?=
 =?utf-8?B?Sys2T0JvSnczWXNxYmlkaFNPZHA1M1o5L1lubnJQMS94aElvTG9wSWpKeThr?=
 =?utf-8?B?VVhySnN0a3JTR21iSm9mV0haK1ZVVElJNEI4QmNYWEI2T05BNEZESXMzVXEz?=
 =?utf-8?B?bzJOSDdoVDIvQWYzdytwOWRISHdHdHdPR28zMHllazNSV0k4bWthcGJadXl6?=
 =?utf-8?B?QXE1ZnUybkNXbS9xSmpkemFPVnovTHlxWkg1ajZ4eTlZWDYzdDdGbm5LbnhL?=
 =?utf-8?B?TkF2VUg2WlEyNStkeEdjT3NDZFpQWDd0cm5CeXQ3YWgzSEpWbDV1Ym9Tc21I?=
 =?utf-8?B?Vjh4N2pKTWZoSHBvZDZxTlU0Y1JMeW1aME4rTm5mc1U3WnFocjZQeHZDOWds?=
 =?utf-8?B?U3JGTFJyMnJMSVNjd2VsNzJkTkFmODBjWGg2R090cUpNam1TN2t4aDU5Mmdy?=
 =?utf-8?B?K2lxNEYxQmJPU0JhUnkyWllwV083U2NqMTlheXFVWWVjMUJ4aFlqNDJBMU1s?=
 =?utf-8?B?M0U2SDN1K3VQN251U2hpMlJPZVAxWENpNEpxWVRreHJtOUxKRm5VcVZnUVIz?=
 =?utf-8?B?ZGdQMHlSN3MxVDFrYWNVK093MXZmSDFqdDFKYzJrRXo2OVUyUWJROTZuRUNn?=
 =?utf-8?B?dXZpMEs4cEwzamIxaDZOMWkxZTlERy9qYjdTSWh5YTkvcHZjNXJPZDNwUWt6?=
 =?utf-8?B?U09pV2Q5RVZqeDhublRzTjBvNFpIYnlXa1Z0Qmt3Z29MeXBLaWIvTEU3akZM?=
 =?utf-8?B?SUR6blo1WWJ3Y09NZ3J1LzB1THI3S1NyMmlPdkNwRWNhcXIydUhQeHRRd1pk?=
 =?utf-8?B?dHpBbG1WUVFxbWlZV3pYZ1pUMFpmbEV2RlpXQkJicG9OUmZ4Tk1id0JpcHlT?=
 =?utf-8?B?ZUkwVVAxQlR5Y2RsVC94R3gzNXhybE95MHFzNVJaZnFLU1FHbDN0YlVEOFpT?=
 =?utf-8?B?Rkl1OFNKSUd5SllUN2tYVmxRTFdacUwxcGwvck9kNHM3Zm1hL3U1cmdMNm5j?=
 =?utf-8?B?aEtsTERrV1NhaFlnVk91dkpJN0J6dTluV293Z2hDQXc3WTAvWVQ5TVpJZ2ZH?=
 =?utf-8?B?Qkdvb1BlTVgwOUhlenFsdHJrVHBKVFdBZkFZVGlKNC9KbEh4VVpDR0tEbzNW?=
 =?utf-8?B?Z1dTZktUaEhVcTNXNXdJcXVMODlOQkZxL21DOXpiRnJYcVJYY2x1bW1aNFRs?=
 =?utf-8?B?NHNYODFjY1hxRjhWTzgzOGhPY3lmR0pmYkhNRWZYUVZrcm1nOWZXc2U5MGZs?=
 =?utf-8?B?Y1RMYUh1SHRxSkl0c2lQazJzejZXc3RIOGFaaDFTWXhLbDk0K2hFWHYweEJV?=
 =?utf-8?B?VzRJMjNINUZCT0MvSFNyd2M1Tnc0QjNVeHU3TUhoaUE2SnNwVHVQZEdXRXI0?=
 =?utf-8?B?Mmx3RzFXMjA2RWwvYmlLUlRlVi85VGlhbnhkSjZGd0k2VFVQTnpYdnVrOVRl?=
 =?utf-8?B?akd3VENVMFNCbHR6dTNxVExvNEZrOUZzUGhXV3czWm1BK1pqYi9DWStvMEx3?=
 =?utf-8?B?Y0hTdk9KZXNIaUY2UVp5QlZjUWhZaFNsMklhOWRWNTZEZk5nc2NOZmtHVHBJ?=
 =?utf-8?B?NGJjdWJQWC9BRGtTZ3pPbUsyWVRuYitwTS9sZ0V2dEZtaGh0WmxmV2ZzbFNX?=
 =?utf-8?B?V2lGNlAyeFBKTk13UmlkOGRkMWtqUDU5aW5JdlI1eVZ2MXV0S25VMzRTWkl6?=
 =?utf-8?B?TnBWd1JuaStPMzdhV1BzRkpLOWM2Z0x5MW5BNjRFVG02YUlKbDVHVkxYUitI?=
 =?utf-8?B?NzN2Vy84L1FxKy9IYXJOWWhBa3lKMGdZa2h1ZTBmZ1IwSFNYVk4zV2p5aHV4?=
 =?utf-8?B?MDh4dWE1ZmszN2pXQWZ3Vy91YW5KalpJZ21MOWlhVy82MVR5citvUTdXV2hD?=
 =?utf-8?B?VmhEYnZqUFAyTzNkYko0M2NZeWpneUxxL1Q1am5WT1RnNGcyVUxXM0V3aHZx?=
 =?utf-8?B?ODg5YWFERXM0b0c0ZFpGMDZYSDg3aS9yNitKTzVGNStQTEhsSG9BTHNSa01H?=
 =?utf-8?B?U3pkYUdSdmpjc25tWXpXaGdROTYvakszY3NkTGJabFZ0UTZZaklQY3NubVJh?=
 =?utf-8?B?NWZNOVVDc3lyUWtQeHZ6dFd4emJrUUx2Zk5RQ2NNd1htNzFrZDBzWXE5MVdV?=
 =?utf-8?B?N1N1Q0ZVL3c1K3ArQWZReGV5a2lMRFdUdGFaVTlJNWdMTDhkSFBzY2R3bHNi?=
 =?utf-8?B?SHNvU0lWWGd6SFV3N1NQVzNkY25CSDRNcWlRRzBDRzVKM2cxa2hmQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ewjdnQ+TpTMWimt4sqLDsB9rjFUGa9dIc72V/qA7v0Sdqw9YE5BwNhFHLZk7mF+eNvcmel/Ka5EvZMZyK8A1AtkJ4HXL9PZQ1jmAFYY4gBhdWCdAjVQmg6A3ZfMAIDXNwXkLurYUHn1T/e5877DqRjh3fin1vorL+rh+zBDKXwK46yF8vloKoNywC94437wwrizhJ4X5ygGQ9rEm4A1KgnGVCJ1o9I4Oxim6YcvnhPx4257LMqlTVMN8RaErYFc/Dn5jpyQtVEfzCRoPJ8GS/JNdtKGq6Fs+Rv62DZJ2qbP8JH+2BJwJmyjaw7sM9XeBu5rNn+vfo6xo9Xj/t7UQ6Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665c47b8-3df3-4c76-55d5-08de84c5b600
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 08:09:42.9598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIPv2vp569C/ddL6a7BavrNDQSxr41g0bp3OfJWNky6WF5izTlyZhe4lqOs77Vi6rRB3fOt2ltLgsco0iOZdrMoKZ6NmDfeL0B94s+0o5Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5935

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gbW1jOiBkdC1iaW5kaW5nczogc2RoY2ktb2Yt
YXNwZWVkOiBBZGQgQVNUMjcwMA0KPiBmYWxsYmFjayBjb21wYXRpYmxlcw0KPiANCj4gT24gVHVl
LCBNYXIgMTcsIDIwMjYgYXQgMDE6NTY6NDJQTSArMDgwMCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+
IERlc2NyaWJlIEFTVDI3MDAgYXMgY29tcGF0aWJsZSB3aXRoIHRoZSBleGlzdGluZyBBU1QyNjAw
IFNEIGNvbnRyb2xsZXINCj4gPiBhbmQgU0RIQ0kgYmluZGluZ3MgYnkgcmVxdWlyaW5nIGZhbGxi
YWNrIGNvbXBhdGlibGVzIGluIHRoZSBkZXZpY2UgdHJlZS4NCj4gPg0KPiA+IEFsc28gcmVxdWly
ZSBgcmVzZXRzYCBvbiB0aGUgQVNUMjcwMCBTRCBjb250cm9sbGVyIG5vZGUuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAt
LS0NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gYWRkIG1pc3NpbmcgYmxhbmsgbGluZQ0KPiA+
IC0gbW9kaWZ5IGFzdDI3MDAgY29tcGF0aWJsZSBpdGVtcyBjb25zdA0KPiANCj4gV2h5Pw0KPiAN
Cj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2FzcGVlZCxzZGhjaS55
YW1sICAgICAgfCAzOQ0KPiArKysrKysrKysrKysrKysrKy0tLS0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAzMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXNwZWVkLHNkaGNpLnlh
bWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXNwZWVkLHNk
aGNpLnlhbWwNCj4gPiBpbmRleCBkMjQ5NTBjY2VhOTUuLjljOGUwNjg5NjRhMSAxMDA2NDQNCj4g
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2FzcGVlZCxzZGhj
aS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9h
c3BlZWQsc2RoY2kueWFtbA0KPiA+IEBAIC0yMiwxMCArMjIsMTQgQEAgZGVzY3JpcHRpb246IHwr
DQo+ID4NCj4gPiAgcHJvcGVydGllczoNCj4gPiAgICBjb21wYXRpYmxlOg0KPiA+IC0gICAgZW51
bToNCj4gPiAtICAgICAgLSBhc3BlZWQsYXN0MjQwMC1zZC1jb250cm9sbGVyDQo+ID4gLSAgICAg
IC0gYXNwZWVkLGFzdDI1MDAtc2QtY29udHJvbGxlcg0KPiA+IC0gICAgICAtIGFzcGVlZCxhc3Qy
NjAwLXNkLWNvbnRyb2xsZXINCj4gPiArICAgIG9uZU9mOg0KPiA+ICsgICAgICAtIGNvbnN0OiBh
c3BlZWQsYXN0MjQwMC1zZC1jb250cm9sbGVyDQo+ID4gKyAgICAgIC0gY29uc3Q6IGFzcGVlZCxh
c3QyNTAwLXNkLWNvbnRyb2xsZXINCj4gPiArICAgICAgLSBjb25zdDogYXNwZWVkLGFzdDI2MDAt
c2QtY29udHJvbGxlcg0KPiANCj4gTm8sIHByZXZpb3VzIGNvZGUgd2FzIGNvcnJlY3QuDQo+IA0K
PiBJcyB0aGlzIHNvbWUgbWljcm9zbG9wIExMTSBwcm9kdWN0PyBJIHF1ZXN0aW9uZWQgc3R5bGUg
bGFzdCB0aW1lIGFuZCBub3cgd2UNCj4gZ290IHJhbmRvbSBjaGFuZ2VzIHdpdGhvdXQgZXhwbGFu
YXRpb24uDQo+IA0KPiBQbGVhc2UgY29uZmlybSAtIGRpZCB5b3UgdXNlIGFueSBMTE0gbWljcm9z
bG9wIHRvb2xzIHRvIGNyZWF0ZSB0aGlzIHBhdGNoPw0KTm8gSSBjcmVhdGUgaXQgd2l0aCBCNC4g
QW5kIGNvbW1pdCBlYWNoIGJ5IGVhY2gsIEkgZG9uJ3QgdXNlIExMTSB0byBwb3J0aW5nIHRoaXMu
DQoNCj4gUGxlYXNlIGFsc28gY29uZmlybSAtIHdobyBpbnRlcm5hbGx5IHJldmlld2VkIHRoaXMg
cGF0Y2ggYmVmb3JlIHBvc3Rpbmc/DQpJIHBvcnQgdGhpcyBhbmQgZG8gdGVzdCBpbiBteSBzaWRl
IGFuZCBjb25maXJtIGl0Lg0KDQoNCkluIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2
MDMxNC1mbGF0LXRvcGF6LXBlYWNvY2stNDQwYTljQHF1b2xsLyN0IA0KWW91IHJlcXVlc3QgZHJv
cCBkcml2ZXIgY29tcGF0aWJsZTsgDQpCYXNlIG9uIHlvdXIgaW5zdHJ1Y3Rpb24sIFNvIEkgZG8g
bXkgc3R1ZHkgaW4gTGludXguDQpVc2UgZm9sbG93aW5nIHRvIGRvIGNvbXBhdGlibGUuIE5vdCBh
ZGQgZHJpdmVyIGNvbXBhdGlibGUgc3RyaW5nLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
L1RZMlBQRjVDQjlBMUJFNjQyREZERTQ4NjJCNDBCQkFBMURCRjI0MEFAVFkyUFBGNUNCOUExQkU2
LmFwY3ByZDA2LnByb2Qub3V0bG9vay5jb20vDQpUaGF0IGlzIG15IGZvbGxvdyB1cCBwb3J0aW5n
LCBub3QgdXNlIExMTS4NCg0KDQoNCg==
