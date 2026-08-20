Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010029.outbound.protection.outlook.com [52.101.228.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277793F39EB;
	Thu, 20 Aug 2026 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226280; cv=fail; b=AzLEbABzTLoM7zwFWqeKG6UmGr+4IImPC6BkWwHO5MuOb8vyDwJDSQIlxU5H057SHTWL/+Ys4XyiSk6KTQnAmuRgvj5B4txnYvVmcxgTdxMrbEvPlPw9qe9i/Rw3c4frGhGOa7zdrKa7BSWodcV+NY7VsnLDz+Ovp7yqB5s/ri0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226280; c=relaxed/simple;
	bh=ArUjaQJI44uKXW0HkOqbzEU/5kgjY7a70yD/QmN0D2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TAgT69wlMkTgyJJCewlavlLoizNhZOvLM+1DxnGeuZo89wZHaJW3Pbfd+58PAEgh7laOSD5D2zYLlsMIBy7M9xSs27MQHouBhmLASD5fUKtu3Kg/8dqJA1v89MIcMGe+CeKgvRIvJ9o9bl8hCLCL0Vo6LS0Afar6BTbE6Kj2GLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=D5sSrQ8V; arc=fail smtp.client-ip=52.101.228.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="D5sSrQ8V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9Perbz1yUyR45clucWuWSlLzJM7R9gmh10o2AJcnGnT2Tdx0/I1ijjacQbl4CSGLoCEXBqxXU0yEkGtHq7CzBFXrHPmRgVfTI4qO6Jr97T1wQS1TzRH/93r0ws3tFljoIBux6iiH22Al7gJ6v5N/zLXFVQiErspOMAUJiyV4c56aLCcAG0cETDxIZXtXc8Nrnh5oQOUhrM3q+DEsnHTzewZumN1HsvXpIU5Ka2KZuZnV5+PMQ9PztH4R3FKZw7+vXOffxwW1ZY3D/57+v2I0izWVTxLLiAtp5KpXsuihkopwL906REd04MBKRLgvtJhvJUvEzWeT95Z3PDu7MVmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArUjaQJI44uKXW0HkOqbzEU/5kgjY7a70yD/QmN0D2E=;
 b=gipvHNYzPXwoudz6EhtORM5H/5FUDVRjMvB9fBKhpFkGiW+Lh5paitfzhJBkkG2XRrSKZoNM2EfSwhUXRPo9WxgmPTmGcGHa/dtLwOhZI/EyCmKW2t6fr9yxU58KH72vsJ3HQ9dOzz2l1kvSTE6m4hK99A8eNvBoIodFrMR6Aqc5VsfwgFQw80wGMuDlnIlHjh//PPNIb/+yaYFs8wEwqTzgJycsUC9Rnqt4xvL9fLDwT7GgltGWxR42++7q+mxfv/Vf3GLwvuyct5cL1SpXngd/5heB0mEvnwlQNBdmF3XzWSpCzklVH9HCmjb9V+f+byDtT0k3s0NKjeCeQ29bjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArUjaQJI44uKXW0HkOqbzEU/5kgjY7a70yD/QmN0D2E=;
 b=D5sSrQ8VUOl+i9M+wTM9VHXf4giNFolQIDQI+RPPMnCalCTCBoOyl9TkAR5rjQFLLFyptEwXa/yWllZOZoLbUhTrN39arZdUW+xAqY7JRdIZRK51YDSubqbDDIISM3yZAPIwqKgRoaq6gdwJf0zGOZoSds74WKzvx8L08OM92ho=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB18500.jpnprd01.prod.outlook.com (2603:1096:604:4a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 11:44:19 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 11:44:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, wsa+renesas
	<wsa+renesas@sang-engineering.com>
CC: wsa+renesas <wsa+renesas@sang-engineering.com>, Ulf Hansson
	<ulfh@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v23 05/14] mmc: renesas_sdhi: Make clock divider mask
 configurable
Thread-Topic: [PATCH v23 05/14] mmc: renesas_sdhi: Make clock divider mask
 configurable
Thread-Index: AQHdIBcSWjc4ixp24EuhO9P3hcto0LaSnboAgAGp1MCAEqj/8A==
Date: Thu, 20 Aug 2026 11:44:07 +0000
Message-ID:
 <TY3PR01MB11346EFA580B3F7BBFE3D508786A42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
 <20260730113200.36456-6-biju.das.jz@bp.renesas.com>
 <CAMuHMdXAFX1bji7Q+OAmDRYmQ8Gezxhf2RsrBOV34AXLOBgLPw@mail.gmail.com>
 <TY3PR01MB113463AB187EBEEF2CD2C2A2986D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB113463AB187EBEEF2CD2C2A2986D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB18500:EE_
x-ms-office365-filtering-correlation-id: 9ccb5614-cccd-42b8-e842-08defeb05832
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 x3qp2eCZkuKERtXL+M6S11fqUIrMB9radw5mX/297xkfTYWFCjuO4wItAOlkvAoGyYd+vXF2W6seAvsAyWKiH1llxeCDdHRMWUJAjyycy88NB9NmqHLgNry/6+o8Qp/Wbn0lGpljGZnF9j6/X/uSIJ+/MWPSlrT1A4SQWXneiHNkQ79m43gT8gXgGKfeLq1qPjVJajwJqvXwuwo6l6y4VumBQ2CfU06QHRQE2o62tsxLB1eJgGC8nBY6//bro7CU9CBlWlvZ0jwcKbkrd9hloS6017NknwFNmKjB/sRY2lRFtBr9wQdWIgrQW1lY75uKWTnVanfHwl2c/gHod/nK/ed07Jgnin23zs6r/VBfUClvN8EUB7GprmxtkElULeMo/LWe/Tq+W6sDOs22q03vj6B0fd3QvqylCzX1RwsSpThbPjpXEilMGH842LfgJ26OaWGFUVjJun3PDeHwWBZc23/bqngUTC5tzbhRUAZSwp86OOg0FfxZZhER8K6uI/7Hmibr1iUAfGCO4dhijSucGj8Eh82lnIAvgibvCy7JwdWlz4PjOmhTKkgUS+QtFLqx2KOq9WxCIwT9z5LkCWa4eZsOLr+qbkEIomfOutHv2U1GdkIyiJFs7oUuY0Vj83xhM3zj+SHiULpytVoqA+93rrK14GEI3nKmncaWEl9ldkKTurSe3s/9c4NsQU7XtThqRnrJhRWC2ZkvByl/Mn5fR+w0gA1U6xTzIHPCXIA6Fa4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a09pUENqQm16TlA0R2ZodW1ZTWlPREpwdFRoMHB1NTVJK003STFZNW15V2Nr?=
 =?utf-8?B?QVhkclh0NXhSRTBYSkhnL294Yi8xampnZEFkM3l4YTdIWDB2RkpyZStHWkMr?=
 =?utf-8?B?UG0zOVVhRVp6cW1qY0o3YzBld2g4ZlI3VUFKUkIyYmVFSmRtSzA1Zk1DZC9C?=
 =?utf-8?B?OFVnMVI4TTBGMVczdXgzRmJUcHVmZ3lQQzFIcUZzbW5BT2NTWDVsdlE0WVpB?=
 =?utf-8?B?bWdBajFCVWMwSVg0NTMyd0NQUEZlYy90bkFINzA3aFdhNkMyOFIzSm1FcXN2?=
 =?utf-8?B?YTZabWI5WG5RYS9wMENJSWlEOHVRVThTbHFIS3dPMHNUbHBkS3pCT1ZTMXE0?=
 =?utf-8?B?STNlTG9TTTBZaldwa2hEdVRiYjk0OS9xUllVazVRakI4a0RuSEtNUDkwWE5I?=
 =?utf-8?B?Rk84c3JwZWRxbGFJRzRENk5Zc3FKcXRNSXg5emtHcjltTWxFTlUvd2N0ejJQ?=
 =?utf-8?B?N1g4ZkFvL2pncmcvKy8yTGlMU2o1cEtZY1Q3N1d3UVRQRGV4UDQxUkVVanRt?=
 =?utf-8?B?MTdYVWI2OXZObDh0WUptdzA4cVBLSHl3V09WSTBWK2hJSlg1SFd5WGpwN2lE?=
 =?utf-8?B?SUw0b3RiV1Y0MTlWMTZhN25GSjcrN0taQ0dGRjJrbTJxcmhVdlpWUkd6a3V1?=
 =?utf-8?B?eVNlZ3VrNUFXbnErWjJaTVVueFF6MmdrZDlJQUtoVXA2Z1pES2lxUWZSeTY3?=
 =?utf-8?B?ejQ2Nlp1VXB1eTNpMUhwRmxBSHdmeGgzSm5wemtRZWo5MzdvdW5KbmZFbFlj?=
 =?utf-8?B?Zmlac0tOMmRKb1NWQmp1TEVmT09Odm5ISEgyV09nTkFUQWVnc2pJdUpKMnUy?=
 =?utf-8?B?NC9oUVk1RW5mKzJQOE9TcGFKbVIyZkdUOHFqeUIwWmZQTkcvdzcvTDZrNksz?=
 =?utf-8?B?WVVDVlpHbWc0cE9YS3ZpVzFwL2RJd0VNV25JR0pBSkpETmJOWExLN3VPVzVr?=
 =?utf-8?B?RVBFOFhXSlVud250UFlNSURObVNZRU1DbkdJWHBmVUJMSWFBbEJWb1RzNk03?=
 =?utf-8?B?cFovb1ZvZGpMbUtLN3F4em94SXArMlJZdy85eEpaWTRRMWhiaXpRV3h4cG8r?=
 =?utf-8?B?QmIzc0FWSjZBclVNYmszcWdCUzJSOGIxVlpKWmlPejZqOWRidTlJSER2REFV?=
 =?utf-8?B?MVh2YlllNEJhRWgxcFFCaS9NMStSWHpWYlNFWU9XaThHTWo5WENpbVZRU1BU?=
 =?utf-8?B?ZWxIdktBWm44bld2U0FNa1IrazdaK2laVENXTWdWbTJkS05oTHdNSE5ibFpk?=
 =?utf-8?B?TDUvNFNKS08rWjM1UXByNnU3K0JFZjczdUNRbDIrM0NiUWh5RHg1R09sUzBD?=
 =?utf-8?B?UWk1Wld1eXo4Q0l6TEh3WGJkOXlEZTRZS1FqQ3pxTE5paVdpUGxEaWJ0UzRY?=
 =?utf-8?B?NWQwdTd6WUU2bkRvcWtOZFlrNStwQ1pubHkvT0VnOExPYXA2YjIrYlUveUJV?=
 =?utf-8?B?Q3B5d0lQYmVzUHZ1TWZOeFJrWExYYWdJd2xDSUNTUVo4M1lmRjQxYWpDODNW?=
 =?utf-8?B?VFc0anJVOXo2T0tpa01COW9LTEg2V3dPS29BYkIrTlEvczBScFhKSy9CQkll?=
 =?utf-8?B?QzdSMTJUTDZMSnU5VkNJNis4Vmx0SzE5RjFvejlDT2IrU0greXA1Wk5mYXlz?=
 =?utf-8?B?bVZKelVYR1d2bWprc3F4M09RT281b3BBQTNJRHJnMGJWMi91SElTVDZHaVBT?=
 =?utf-8?B?WGdxYWZGWFZlK0hFUEFWVHJpRXFUOHBDempjQjBWL2xYQXlrMHpvbCt4eEIv?=
 =?utf-8?B?NjBDUTdtRWF4b0U4ckJyeUkxT0lBTktZZFV1am1KRkEwUGdIcUkxbC92SkhJ?=
 =?utf-8?B?TVQ4ZkRHVUtHWGJNdytUSFM5R0txdi9vTDR6dWd2TnlXWDBzQmxVM2oramVM?=
 =?utf-8?B?UjJlMzNHSHY4RG14RGV2YXY2VVRLdmcwVzFMVU5FN0dpanBOeVFmZmQ5R0Nh?=
 =?utf-8?B?Ykt6dmFtMStNU2ZSYzh4QVFzRVFSVWJjSFFZalNKajVwQ0IybEtDa3N1TnJh?=
 =?utf-8?B?WjdqZnVRaDhqWkMyQWhGVm9uYy81cXU2QVU4S0FnT3lpV3MzdGsxTVpkellJ?=
 =?utf-8?B?ZnpIT2dyVTFKa1d6dWV6MHhpSjh1S0ZvYUExRHRMYTFKdjd2T3NTS2trQ1lD?=
 =?utf-8?B?RzRGQVowbWVObXdZR1h3eU85cXlaM3FIVkhIOW5BNGg5Q1ZiNTFreEVNOHJE?=
 =?utf-8?B?WkpMQ0kvR2IxSGlHVDdLR3hWdzR6ODJjcGFOKzZwTk5uVWlGSWZCalZRT2Nn?=
 =?utf-8?B?WjlrN3M0cWluSmFHQkp2VlQ0NVYrSHBGTEF2N2dYZXpoV2hFQUNMMERPSFhw?=
 =?utf-8?B?NzYwWmFrM3BkRVZJZmhMbU5OemFPd0ZmU2dmL3FsN0d2ejUzUmJMUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccb5614-cccd-42b8-e842-08defeb05832
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 11:44:07.9776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cy3u9+/Bp2+tf/FhWdPvXB4HDr03hPrbMFWL7C6hBx4/cvgYx7Cfbu9gpNm2Y6Z+F1FMbCtV93zYxfudv/CCurhCLyHZQY8e1arOfXH3nc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB18500

SGkgR2VlcnQvV29sZnJhbSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IFNlbnQ6IDA4IEF1Z3Vz
dCAyMDI2IDE2OjIxDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIzIDA1LzE0XSBtbWM6IHJlbmVz
YXNfc2RoaTogTWFrZSBjbG9jayBkaXZpZGVyIG1hc2sgY29uZmlndXJhYmxlDQo+IA0KPiBIaSBH
ZWVydCwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KPiANCj4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGlu
dXgtbTY4ay5vcmc+DQo+ID4gU2VudDogMDcgQXVndXN0IDIwMjYgMTQ6MTYNCj4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyMyAwNS8xNF0gbW1jOiByZW5lc2FzX3NkaGk6IE1ha2UgY2xvY2sgZGl2
aWRlcg0KPiA+IG1hc2sgY29uZmlndXJhYmxlDQo+ID4NCj4gPiBIaSBCaWp1LA0KPiA+DQo+ID4g
T24gVGh1LCAzMCBKdWwgMjAyNiBhdCAxMzozMiwgQmlqdSA8YmlqdS5kYXMuYXVAZ21haWwuY29t
PiB3cm90ZToNCj4gPiA+IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNv
bT4NCj4gPiA+DQo+ID4gPiBBZGQgYSBjbGtfZGl2X21hc2sgZmllbGQgdG8gcmVuZXNhc19zZGhp
X29mX2RhdGEgYW5kIHRtaW9fbW1jX2RhdGENCj4gPiA+IHNvIGVhY2ggU29DIGNhbiBzcGVjaWZ5
IGl0cyBvd24gZGl2aWRlciBtYXNrIGluc3RlYWQgb2YgdGhlDQo+ID4gPiBoYXJkY29kZWQgQ0xL
X0NUTF9ESVZfTUFTSyB1c2VkIGluIHJlbmVzYXNfc2RoaV9zZXRfY2xvY2soKS4NCj4gPiA+DQo+
ID4gPiBEZWZhdWx0IHRvIEdFTk1BU0soNywgMCkgYXQgcHJvYmUgdGltZSB3aGVuIHVuc2V0LCBh
bmQgcG9wdWxhdGUgYWxsDQo+ID4gPiBleGlzdGluZyBpbnRlcm5hbC9zeXMgRE1BQyBvZl9kYXRh
IHRhYmxlcyB3aXRoIHRoaXMgdmFsdWUgdG8ga2VlcA0KPiA+ID4gY3VycmVudCBTb0NzIHVuYWZm
ZWN0ZWQuIFRoaXMgbGV0cyBSWi9HM0wsIHdoaWNoIGhhcyBhIHdpZGVyIGRpdmlkZXINCj4gPiA+
IGZpZWxkLCByZXVzZSB0aGUgc2FtZSBjbG9jay1zZXR0aW5nIGNvZGUuDQo+ID4gPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+
ID4gLS0tDQo+ID4gPiAgKiBBc3NpZ25lZCBvZl9kYXRhLT5jbGtfZGl2X21hc2sgaW4gcmVuZXNh
c19zZGhpX3Byb2JlKCkuDQo+ID4gPiB2MjEtPnYyMjoNCj4gPiA+ICAqIFVwZGF0ZWQgY29tbWl0
IGRlc2NyaXB0aW9uLg0KPiA+ID4gICogQWRkZWQgY2xrX2Rpdl9tYXNrIHRvIG9mX2RlZmF1bHRf
Y2ZnIGFuZCBvZl9yY2FyX2dlbjJfY29tcGF0aWJsZS4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhl
IHVwZGF0ZSENCj4gPg0KPiA+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9yZW5lc2FzX3NkaGku
aA0KPiA+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9yZW5lc2FzX3NkaGkuaA0KPiA+ID4gQEAg
LTQxLDYgKzQxLDcgQEAgc3RydWN0IHJlbmVzYXNfc2RoaV9vZl9kYXRhIHsNCj4gPiA+ICAgICAg
ICAgdW5zaWduZWQgbG9uZyBzZGhpX2ZsYWdzOw0KPiA+ID4gICAgICAgICB1NjQgY2xrX21hc2s7
DQo+ID4gPiAgICAgICAgIGludCBtYXhfZGl2aWRlcjsNCj4gPiA+ICsgICAgICAgdTE2IGNsa19k
aXZfbWFzazsNCj4gPiA+ICB9Ow0KPiA+ID4NCj4gPiA+ICAjZGVmaW5lIFNESElfQ0FMSUJfVEFC
TEVfTUFYIDMyDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9yZW5lc2FzX3Nk
aGlfY29yZS5jDQo+ID4gPiBiL2RyaXZlcnMvbW1jL2hvc3QvcmVuZXNhc19zZGhpX2NvcmUuYw0K
PiA+ID4gaW5kZXggZDg5M2EyNjNlNzcwLi41ZGNiYjQzMWUxZTEgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9kcml2ZXJzL21tYy9ob3N0L3JlbmVzYXNfc2RoaV9jb3JlLmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvbW1jL2hvc3QvcmVuZXNhc19zZGhpX2NvcmUuYw0KPiA+ID4gQEAgLTIyNCw3ICsyMjQsNyBA
QCBzdGF0aWMgdm9pZCByZW5lc2FzX3NkaGlfc2V0X2Nsb2NrKHN0cnVjdCB0bWlvX21tY19ob3N0
ICpob3N0LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY2xrICY9IH4weGZmOw0KPiA+
ID4gICAgICAgICB9DQo+ID4gPg0KPiA+ID4gLSAgICAgICBjbG9jayA9IGNsayAmIENMS19DVExf
RElWX01BU0s7DQo+ID4gPiArICAgICAgIGNsb2NrID0gY2xrICYgaG9zdC0+cGRhdGEtPmNsa19k
aXZfbWFzazsNCj4gPiA+ICAgICAgICAgaWYgKGNsb2NrICE9IENMS19DVExfRElWX01BU0spDQo+
ID4NCj4gPiBUaGlzIHN0cmlrZXMgbWUgYXMgYSBiaXQgb2RkOyBzaG91bGQgQ0xLX0NUTF9ESVZf
TUFTSyBiZSBjaGFuZ2VkIHRvDQo+ID4gaG9zdC0+cGRhdGEtPmNsa19kaXZfbWFzayBpbiB0aGUg
Y2hlY2ssIHRvbz8NCj4gDQo+IE5vLCB0aGlzIGlzIHRoZSB2YWx1ZSBmb3IgMToxIG9wdGlvbi4N
Cj4gDQo+ICAgICBbICAgIDIuNjQ4MDUwXSAjIyMjIyMjIyMjI2Nsay9jbG9jayA0MDAwZmYvZmYN
Cj4gDQo+IGlmIHdlIGRvLCAoY2xvY2sgIT0gaG9zdC0+cGRhdGEtPmNsa19kaXZfbWFzaykgdGhl
biB0aGUgY2hlY2sgd2lsbCBhbHdheXMgdHJ1ZSBmb3IgUlovRzNMKEdFTk1BU0soOSwwKSkNCj4g
YW5kIGl0IG5ldmVyIHNldCAxOjEgZGl2aWRlciB2YWx1ZS4NCj4gDQo+IFRoZSAxOjEgZGl2aWRl
ciB2YWx1ZXM6DQo+IA0KPiBOb24tUlovRzNMLCBpdCBpcyAxMTExIDExMTFiDQo+IEZvciBSWi9H
M0wsIGl0IGlzIDAwIDExMTEgMTExMWINCg0KSSB3aWxsIGludHJvZHVjZSBhIG1hY3JvIGZvciB0
aGUgMToxIGRpdmlkZXIgY2FzZSANClJFTkVTQVNfU0RfQ0xLX0NUTF9ESVYxICAoMHhmZiksIHNv
IHRoYXQsIGl0IGlzIHNlcGFyYXRlZCBmcm9tDQpDTEtfQ1RMX0RJVl9NQVNLKE5vbiBSWi9HM0wp
IGFuZCBSWkczTF8gQ0xLX0NUTF9ESVZfTUFTSyhSWi9HM0wpDQoNCkNoZWVycywNCkJpanUNCg0K
PiANCj4gPg0KPiA+ID4gICAgICAgICAgICAgICAgIGhvc3QtPm1tYy0+YWN0dWFsX2Nsb2NrIC89
ICgxIDw8IChmZnMoY2xvY2spICsgMSkpOw0KPiA+ID4NCj4gPiA+IEBAIC0xMTM4LDYgKzExMzgs
NyBAQCBpbnQgcmVuZXNhc19zZGhpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYs
DQo+ID4gPiAgICAgICAgICAgICAgICAgbW1jX2RhdGEtPm1heF9zZWdzID0gb2ZfZGF0YS0+bWF4
X3NlZ3M7DQo+ID4gPiAgICAgICAgICAgICAgICAgbW1jX2RhdGEtPmNsa19tYXNrID0gb2ZfZGF0
YS0+Y2xrX21hc2s7DQo+ID4gPiAgICAgICAgICAgICAgICAgbW1jX2RhdGEtPm1heF9kaXZpZGVy
ID0gb2ZfZGF0YS0+bWF4X2RpdmlkZXI7DQo+ID4gPiArICAgICAgICAgICAgICAgbW1jX2RhdGEt
PmNsa19kaXZfbWFzayA9IG9mX2RhdGEtPmNsa19kaXZfbWFzazsNCj4gPiA+ICAgICAgICAgICAg
ICAgICBkbWFfcHJpdi0+ZG1hX2J1c3dpZHRoID0gb2ZfZGF0YS0+ZG1hX2J1c3dpZHRoOw0KPiA+
ID4gICAgICAgICAgICAgICAgIGhvc3QtPmJ1c19zaGlmdCA9IG9mX2RhdGEtPmJ1c19zaGlmdDsN
Cj4gPiA+ICAgICAgICAgICAgICAgICAvKiBGYWxsYmFjayBmb3Igb2xkIERUcyAqLyBAQCAtMTE4
Niw2ICsxMTg3LDkgQEAgaW50DQo+ID4gPiByZW5lc2FzX3NkaGlfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldiwNCj4gPiA+ICAgICAgICAgaWYgKCFtbWNfZGF0YS0+bWF4X2Rpdmlk
ZXIpDQo+ID4gPiAgICAgICAgICAgICAgICAgbW1jX2RhdGEtPm1heF9kaXZpZGVyID0gU0RISV9N
QVhfRElWSURFUl9ERUZBVUxUOw0KPiA+ID4NCj4gPiA+ICsgICAgICAgaWYgKCFtbWNfZGF0YS0+
Y2xrX2Rpdl9tYXNrKQ0KPiA+ID4gKyAgICAgICAgICAgICAgIG1tY19kYXRhLT5jbGtfZGl2X21h
c2sgPSBHRU5NQVNLKDcsIDApOw0KPiA+DQo+ID4gQ0xLX0NUTF9ESVZfTUFTSywgcGVyaGFwcz8N
Cj4gDQo+IEFncmVlZC4NCj4gDQo+IENoZWVycywNCj4gQmlqdQ0KDQo=
