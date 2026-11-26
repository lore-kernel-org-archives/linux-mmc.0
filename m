Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795706271;
	b=BkoaXg4m2jTLl1tz2Q33L936ObaI7djtAKMHsO9XTxFIkF9707PKeOtgEBKCPEmz/j2C
	 0rY4DPnRvYvFKmDC76h9HBtn7JavYbLTgdrqM5Ps+T+ZJLGu5awZUc56BDHLZhdnP6FyQ
	 T8SfxK0uh2Yk21dMwBgMMi27DJRnGBKzkElOc763WpHsWFPs6bHIlZxRAzJF3GX6OT9Tt
	 12wImt0WbEIwAejsibpoqlozFMegVuPyEE6myqweIg8eAVpT/LFwZHVZlDzJ/pxmCCyyR
	 peWFgi+uscy3wt7tO/jDpk6qfDZ+C9I2LLhluPh/Eu3DBOlX/RZDIQUYI3XJkUGurHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706271;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=F2DSgmjMqmkcEJTKuDjux1i71YBQ+ZPzYeTD0BINTys=;
	b=tWgNR+VKSdxXjCwTrx0WQtdISapW8vlD7YTLrBZXTpNBGehNpygQe+1/wUacATKNpIGz
	 OlXJfKjO0LClEB5bO+QUZf5D4FE0R1B7q2CsECrwOVPOvAIiSdVULZIlO19PTRhZTHko0
	 3LCGi3t2i0qPzEe7BD0c0igzu/tS8wzVScLxe7U5jUlEfIRDgkigqCATD7QhlMobbd/C5
	 Y5xdHqBfQzoBqpiV0QZaqKd7xMFHkk0dHdwv/orHlHuk5YS6uzLzTSZSjJuEjfZutvPta
	 aS8ZjrgrB0/YawfZv8dmz5HBCEcEmbs0QyGuAzip41rMCKmDf6rFfRT4Q8cSovQ/nVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="OLt/QrnX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.63
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729E606A31C;
	Thu, 26 Nov 2026 15:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2729E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=OLt/QrnX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTpxOtSinIvUMG+ReStvOKVynW2TxCf8dsiMD4NvT4f4S4jPCvtAJoi8Vzq/Ls6U7t3pnjktB+GgdEbRnWhFJqZYr/q1Z/U8cSBDUfrkxx5IHzF6d/PtNM21DtNQx8VMCpkGJl+e6z6U7ZZkxIEP2TZanjn0/Tnd+6Yq94RhCQalRF4o5EBTbjlER/1ysgxP2BxfD4e5UsEt0ObbrGXmOI/QE4xdafARE+8OeqinIayXXWjwRJ4izgjnzuQnywGVFCLpslllP13fkow2U6OybbXQ8K+ETpwVVeGvRcYrsxEQ1onAVBqZNqbrzwQF0X21+xLdJVz2trhHoJ4sG4+30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2DSgmjMqmkcEJTKuDjux1i71YBQ+ZPzYeTD0BINTys=;
 b=OWov7OPOJDL1Guh9U8SL3PEyztz22clFkwGh9OG1mv7HP34V7NW4g6R3xL6LYOsecu3F2yZ+RJTPKnMZhOO0/KUUXZsbhQFa1KCowNB6UV2Evsxif8XEK/95NhpIyIRE/jD5rBsodgmdEcuifm/yA/UmaEGKumn9NiSrbGzIaFck4191satiNQejlx7CAXZacTpkOYlEabY9ItYdCpkY/lRF8SOu8PXnS9op6i1oA1D3Ymcl3rWK5Ko1E396VO8P/fnKM1o0SFw1omCp9jQsPHswht8NKQIBDZxQ1GtaZf/E46umW96JA7ZZRzX3K5DQDGaQL/tf+ObEeirLk7tUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2DSgmjMqmkcEJTKuDjux1i71YBQ+ZPzYeTD0BINTys=;
 b=OLt/QrnXL5lOk8O/xW4k4YJ4U0uhItUsS56P6ered9g8tUHUzTx25v+AHNoS1lj2PdUfUy8Qzn5KZXSfNShJqcYoDRWCJz6muDU7fv78UfdNSFACZFGONvtCJpRncwM3AR8BnXkBQToI147wVMBhLqYbH+7iU9IFK5ijUP0I1+s5Q2KOHWdjuX/g9MkjmNKCkMn4FAbD7ppcI28Tvy5Aq+pIE8gb7Z6nMkbiil06MRkZrgpUvNqLPAZCjGz9o49s4mLWJQ8BF2nzfMGisTLnQjmKKiflYc6dc2V4SVPurBjO6mE1mnlOS9fe8pAknc5Tm2IeHEER4slcdOjITczdCQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Thu, 26 Nov
 2026 15:17:48 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:17:48 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "Haener, Michael" <michael.haener@siemens.com>, "ulfh@kernel.org"
	<ulfh@kernel.org>
CC: "ziniu.wang_1@nxp.com" <ziniu.wang_1@nxp.com>, "avri.altman@sandisk.com"
	<avri.altman@sandisk.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mmc: core: saturate erase timeout instead of
 overflowing
Thread-Topic: [PATCH 2/2] mmc: core: saturate erase timeout instead of
 overflowing
Thread-Index: AQHdfblLfLlyX2Pb6kO9RmUlutSEAA==
Date: Thu, 26 Nov 2026 15:17:48 +0000
Message-ID: <a939387aedf0ab45a07b370a56ea735999deb115.camel@siemens.com>
References: <20261111120759.100830-1-michael.haener@siemens.com>
	 <20261111120759.100830-3-michael.haener@siemens.com>
In-Reply-To: <20261111120759.100830-3-michael.haener@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-2.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3879:EE_
x-ms-office365-filtering-correlation-id: ac707877-9859-4dcc-7915-08df4bd06e27
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261022113327099003|38070700021|261021121427099003|261021123027099003|10067099003|261026121527099003|11063799006|56012099006|261022075727099003|261102123227099003|261009223027099003|22082099003|18002099003|55112099003|4143699003;
x-microsoft-antispam-message-info:
 JoNOCCzD3iCbh4gv2Kxe4Q5ExyF1EkJk8NQ9p2YkNi8BugaQd8j0Fee3cgWl6u9O4k0x9oh0BrlrRTmQZhNVOZAVFJukI0xCSXuYqzCl735YWcABEGn81vFFKfqLUFk6+fn03hsnaSiRSvZV17PLla0DswLdqtyYtZ6/eYCzKjpyvkeCCH8PMAu7pExxD4qJGim+mtiu3xTz0T56aDjyGzbxuGxWgRH1O3V7dUYEgjtOiXozIv5AyHy6qyECCeu9zu5dwqeuDtaFRdceThqYPsMDwrd5bBulalJFODy8ecjcLkTYxcW4qXQkFsai8zZTe+9VafTuVAGqqVlsR+iP8iQLeL7/zfzBwIt8IVG72or1avpBumyp8OMPnXZ5rkMxF1SrQAE8CaeCSSr9Nj+wLbZCT9xkprN9Qe/sCfpu/OgFJwaToTGT3aJADA7023qmkekCLcVGyfI4oCjTXMltvSXQ6ucfmGHW5V65dg/KKllPTvypvrfraAzdk0KW4+lq+odABG52Dbgz7k5JFRafYeq8yhh/QJdk9x2OD6rfKKSKUNF2Y9rTdVVZMS9/IBbEsigAiM17kei//WJDO0ic4AlKwHkyDdB1aTFsNRGL0PZjZDCi0XQ+Rd/92iFnKft2/yQb2Rd50nY/qoPnN4zA8FxexWTIC4xzw16dR2B5BP0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261022113327099003)(38070700021)(261021121427099003)(261021123027099003)(10067099003)(261026121527099003)(11063799006)(56012099006)(261022075727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(55112099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkRySVI3aHA0YTAwajRDaTJEaUhOWmJuZDJ4N3RtdlFmSGx3VERMZnNFSHN0?=
 =?utf-8?B?ZkNqeGlDVENlM2ptcUZpQXk1SVNqcEtmTlRjRmpQY2kzclE2dlFWYnFEQnJn?=
 =?utf-8?B?d2h6c0dVZlQvLzMreHp6UGVyUU5kc2Q4dm1oUlpxRHZpVmxGbUt0VFJoWEVV?=
 =?utf-8?B?dHoxQllqY01rUXR6bGlEZ0h4eEVWQjBZMDdab2MxZ0NnZFh4aWpncEJJWnJR?=
 =?utf-8?B?OGt3WXl2Q3FtakpIdDMrVVVhNXpLRnBiSm5OaE04MEVuM3FnSTYyb0Z5ajZn?=
 =?utf-8?B?WU41U2lMaDNJTFdtQmljaDV5TUFPdjZjL2xQTTFBMGZiRUxyQk1nY1p0bXFC?=
 =?utf-8?B?eVU0MDM0cFl3MUxIS2x5L2dnKyt5T0FUSDRQdmd2alloSGgwbFA1dUUrVkNt?=
 =?utf-8?B?TncyeFZRS0RTM3FIeFIrQnN6ZlMwWk1yb2YrUWFmYnJnbEU2eDBOTU1FTDBo?=
 =?utf-8?B?K2MwNGFWb2lmRmF0c3RXN1JSY0ErSkZDVXE3SUJLa0VGclp6cFl1UWlHQS9u?=
 =?utf-8?B?OCtwd0Y2enBYTXBYNzJMeEo5NWd4SkovdXNDVG5SeUVwNjRpQWhJM2dwU1dV?=
 =?utf-8?B?cG83Y0gyRXQ4YVBZdkJLcVpWUEd5bTZiR2NyVGdMT1VtTjhSNWV4cEUxR2NL?=
 =?utf-8?B?a1hUc2x3cG9qb0lidWRlNkFEb2lDUFRETm5QZW5ST014RWREZTN4VzZDdVF5?=
 =?utf-8?B?NW1YRmhiYU51WmZ2T29mekZKeHlhaFVVR1hicDlRVCtaNnNWMzQvRFpZQVl6?=
 =?utf-8?B?dnlha09RUXE3MkNZUkhaVlNGTlVzcUFTNHVuSmZyWGQ3Y1NjUjZUM2RIUDZ5?=
 =?utf-8?B?OXNWQXZvNDJyclhiWDJ0ZWEyQklTQUIxQ2hQWmpIdVphYTlBOXh1c2d6d0xX?=
 =?utf-8?B?ajBNWmNqNmJQMXlvRzA2NVIzWkEzY3dmdmU4cXJxYnE4dHd6YmdnZEJTOTZo?=
 =?utf-8?B?NVNtaHFkeTRhSWlaWE5hZTV2NHl6MmY4YjZWUndTSFZxblZQWFBibU1iQnNx?=
 =?utf-8?B?SExMTHgwWmRvWkhtbTR6b3JNd2hQMnFZOHJaTUhaQ015MFRCTzV6WFY0V25C?=
 =?utf-8?B?Z3BYNnY0VktIQ0dHdm9XSlYydG1PSEhHRXJRaXdGMzR2Y0RZT0lJRnUyRmlt?=
 =?utf-8?B?UGx3TGwySGxpMS9nb3Y2ZllnVm0yYmgxaVBCWmI5Z3lyajhxd0dHanBLL2Zs?=
 =?utf-8?B?dkVMajhNNkJLdGh6WkVEYm5ZWEpmWHRYY2dDS3NLcUx0YkprVHR5UDNLRkRQ?=
 =?utf-8?B?L3ZCdHd0aSt2NXFnQWwzOU01QjNpaTJJNlRBV2tncGFGbW1TcXhjS01uaVNo?=
 =?utf-8?B?UzFDSlU4WU9VQmVOR3UzUUtzc0JKRUdhT3B6R0VWUVhmYU9QUHFDWnVrZFlF?=
 =?utf-8?B?UjNvaVh6Z2t4R2NlSHZzY3IrZVFsV0tKMTB1V3RUY2dqeG8rNDQ3T3dlRmJn?=
 =?utf-8?B?UW1nS09EMHJKUXVpSUQyMDBIQ0lHZWY0VGhDQzdDV1JlRUFqVWRhZE5vdGZZ?=
 =?utf-8?B?QThjWUVRZVRNSGxwa3g2MUd4SVVvVGo2QlkwVEI5UUNPK3h1UUpGcHkvMzNW?=
 =?utf-8?B?VkdWQjFMc2tRaVR2YXF5VkRyOGVPYURxb0QvSGFQcmNqbWFuVTZpbTJhNkd2?=
 =?utf-8?B?NWZvek1BSTZDcVVtcU9INnR2ekRlMm1NMy85R3ZJR200bVdld1hmV0RNQ2lW?=
 =?utf-8?B?WU56T0luUzE5amR6L1NtMmxZM1UvUWJLWE9Wd2JiQ0Rsd2MxcytiVG5XOGZr?=
 =?utf-8?B?MW9xMHhxRTRjSWpoZzgwSU1BaHNzQWdtNWMyVzdTbWtodGtQL1dxdUV0RE5G?=
 =?utf-8?B?Yk5ja2gzTmZZTk41Z2wzN09Ya0ErUCtRQkRPcXcyUEtIYjRVQUNoZ0dKdnRW?=
 =?utf-8?B?NmgzQlBzdytwQ1IvakUwWHF3QjlKYWVZSkwyNkZWc0NrdXI4RUhqWHpYWi9x?=
 =?utf-8?B?dkhPbGZvTUcwMmxMMlZuOW9ZVXVrdDZYZGg5NndkdlNMV1UwSkxnWXpVa1Fy?=
 =?utf-8?B?S0MwcCtRaC9ONWRTdUpNdmpkUnczOUtKT0Y2SjRqd3NwMzJTZDdWeWJYdlZC?=
 =?utf-8?B?RXhBYlNFLzYzdHpvTHF4S1h4b1Ztb0N0YXdWbmg3UDUxUG00dngzTFNDak9D?=
 =?utf-8?B?akJDa3JDVndCLzJ2SzNQSytIdWwzOHhvc09MdlhYSDRmajhxWUgwZlkxY2dK?=
 =?utf-8?B?SzFURU05WTR5RHFTdHFsUFA3dS9lSStlRUFTcVFSN3VnNndYdUVtYXpDNFo1?=
 =?utf-8?B?TVk4aHRqNmEwNWlkNitJWms3Q3dhU3ZSQ2ZJRXg2a3BIYUVXSG5YMm1Gd1FS?=
 =?utf-8?B?aG1KWmQwcWRoSlBjSXkxVXVIa0d5QXdKNWRpUG1qVUN5bzE5S1JGbitnMWFR?=
 =?utf-8?Q?B3areqR7nWC5V+WQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFA964E88CCB8F45A8B32C86AB2F3439@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ac707877-9859-4dcc-7915-08df4bd06e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 15:17:48.2811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7KubsYNrIxRzSRIEIndmOCC8gpDUpvlEJ3L1KOjCaY6OQrQKMvCp741mxGDTiJ62pAYeaT7dd6PN6CG8HkxnOMwrA522gw21Tq3XstUBcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3879

SGkhDQoNCk9uIFdlZCwgMjAyNi0xMS0xMSBhdCAxMzowNyArMDEwMCwgTWljaGFlbCBIYWVuZXIg
d3JvdGU6DQo+IFdpdGggTU1DX1FVSVJLX0ZJWEVEX1NFQ1VSRV9FUkFTRV9UUklNX1RJTUUsIHNl
Y3VyZSBlcmFzZS90cmltIHJlcXVlc3RzDQo+IGFyZSBubyBsb25nZXIgbGltaXRlZCBieSBtYXhf
ZGlzY2FyZCwgc28gbW1jX21tY19lcmFzZV90aW1lb3V0KCkgY2FuIGJlDQo+IGNhbGxlZCB3aXRo
IGEgcXR5IG9mIHNldmVyYWwgdGhvdXNhbmQgZXJhc2UgZ3JvdXBzLiBUaGUgdGltZW91dCBpcyB0
aGVuDQo+IGNvbXB1dGVkIGFzIGVyYXNlX3RpbWVvdXQgKiBzZWNfZXJhc2VfbXVsdCAqIHF0eSBp
biAzMi1iaXQgYXJpdGhtZXRpYy4NCj4gDQo+IFdpdGggNTEyS2lCIGVyYXNlIGdyb3VwcyB0aGUg
YmxvY2sgbGF5ZXIgbGltaXRzIGEgcmVxdWVzdCB0byBhYm91dCA0MDk2DQo+IGdyb3Vwcywgc28g
dGhlIHByb2R1Y3Qgb3ZlcmZsb3dzIG9uY2UgRVJBU0VfVElNRU9VVF9NVUxUICogU0VDX0VSQVNF
X01VTFQNCj4gZXhjZWVkcyBhYm91dCAzNDk2LiBUaGUgd3JhcHBlZCB2YWx1ZSBjYW4gYmUgbXVj
aCBzaG9ydGVyIHRoYW4gdGhlIHJlYWwNCj4gZXJhc2UgdGltZSwgbWFraW5nIHRoZSBidXN5IHBv
bGxpbmcgZ2l2ZSB1cCBlYXJseSB3aXRoIC1FVElNRURPVVQuIE5vDQo+IGNhcmQgaW4gdGhlIHF1
aXJrIGxpc3QgaXMga25vd24gdG8gcmVhY2ggdGhhdCBsaW1pdCB0b2RheS4NCj4gDQo+IFVzZSBj
aGVja19tdWxfb3ZlcmZsb3coKSBhbmQgc2F0dXJhdGUgYXQgVUlOVF9NQVguDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNaWNoYWVsIEhhZW5lciA8bWljaGFlbC5oYWVuZXJAc2llbWVucy5jb20+DQoN
ClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVt
ZW5zLmNvbT4NCg0KPiAtLS0NCj4gwqBkcml2ZXJzL21tYy9jb3JlL2NvcmUuYyB8IDE5ICsrKysr
KysrKysrKysrLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYyBi
L2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jDQo+IGluZGV4IDY3N2U0NDVkYzQ4Yy4uOTczMDYzM2Rm
YTgxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYw0KPiArKysgYi9kcml2
ZXJzL21tYy9jb3JlL2NvcmUuYw0KPiBAQCAtMjQsNiArMjQsNyBAQA0KPiDCoCNpbmNsdWRlIDxs
aW51eC9yYW5kb20uaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiDCoCNpbmNsdWRl
IDxsaW51eC9vZi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L292ZXJmbG93Lmg+DQo+IMKgDQo+IMKg
I2luY2x1ZGUgPGxpbnV4L21tYy9jYXJkLmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L21tYy9ob3N0
Lmg+DQo+IEBAIC0xNTY4LDEzICsxNTY5LDIxIEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbW1jX21t
Y19lcmFzZV90aW1lb3V0KHN0cnVjdCBtbWNfY2FyZCAqY2FyZCwNCj4gwqANCj4gwqAJLyogTXVs
dGlwbGllciBmb3Igc2VjdXJlIG9wZXJhdGlvbnMgKi8NCj4gwqAJaWYgKGFyZyAmIE1NQ19TRUNV
UkVfQVJHUykgew0KPiAtCQlpZiAoYXJnID09IE1NQ19TRUNVUkVfRVJBU0VfQVJHKQ0KPiAtCQkJ
ZXJhc2VfdGltZW91dCAqPSBjYXJkLT5leHRfY3NkLnNlY19lcmFzZV9tdWx0Ow0KPiAtCQllbHNl
DQo+IC0JCQllcmFzZV90aW1lb3V0ICo9IGNhcmQtPmV4dF9jc2Quc2VjX3RyaW1fbXVsdDsNCj4g
KwkJdW5zaWduZWQgaW50IG11bHQgPSBhcmcgPT0gTU1DX1NFQ1VSRV9FUkFTRV9BUkcgPw0KPiAr
CQkJCcKgwqDCoCBjYXJkLT5leHRfY3NkLnNlY19lcmFzZV9tdWx0IDoNCj4gKwkJCQnCoMKgwqAg
Y2FyZC0+ZXh0X2NzZC5zZWNfdHJpbV9tdWx0Ow0KPiArDQo+ICsJCWlmIChjaGVja19tdWxfb3Zl
cmZsb3coZXJhc2VfdGltZW91dCwgbXVsdCwgJmVyYXNlX3RpbWVvdXQpKQ0KPiArCQkJZXJhc2Vf
dGltZW91dCA9IFVJTlRfTUFYOw0KPiDCoAl9DQo+IMKgDQo+IC0JZXJhc2VfdGltZW91dCAqPSBx
dHk7DQo+ICsJLyoNCj4gKwkgKiBXaXRoIE1NQ19RVUlSS19GSVhFRF9TRUNVUkVfRVJBU0VfVFJJ
TV9USU1FLCBxdHkgaXMgbm8gbG9uZ2VyIGJvdW5kDQo+ICsJICogYnkgbWF4X2J1c3lfdGltZW91
dCwgc28gdGhlIHByb2R1Y3QgY2FuIGV4Y2VlZCAzMiBiaXRzLiBTYXR1cmF0ZQ0KPiArCSAqIGlu
c3RlYWQgb2Ygd3JhcHBpbmcgdG8gYSB0b28gc2hvcnQgdGltZW91dC4NCj4gKwkgKi8NCj4gKwlp
ZiAoY2hlY2tfbXVsX292ZXJmbG93KGVyYXNlX3RpbWVvdXQsIHF0eSwgJmVyYXNlX3RpbWVvdXQp
KQ0KPiArCQllcmFzZV90aW1lb3V0ID0gVUlOVF9NQVg7DQo+IMKgDQo+IMKgCS8qDQo+IMKgCSAq
IEVuc3VyZSBhdCBsZWFzdCBhIDEgc2Vjb25kIHRpbWVvdXQgZm9yIFNQSSBhcyBwZXINCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
