Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794500200;
	b=2s2xdrSbtmDwQ6AH53CtEYxBKRIDId1OcIMqPsF1wrLgybU5+bNLJLYaGBGxMetEeyUl
	 J/ih4xVos0LdZI3Hysi9UuO/ubxEujoFK3OCzd1My8eAk7Z4HYhxfc1i9K34O2sB71O6P
	 ozXKUM/n/uAAZHvObqdLGNi/4AfpveIFZMEA+/yywu0E00jehTRBsRqfBO86NaKNb3r8O
	 cIFMISNP8tDgQN6cUKFK8CYdm4LfEDPV9Fxdaci/VfR/TyvTWm4EOQyCziqq28TUsGVqH
	 m0f6WYffaDIwO+EU2RBWCdcLQhwYNdEOoK6VPXnt2v3Xik70h+6PIWE675qIEzlpXiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500200;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
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
	bh=ZHk+RV4NNbJ/6UE4Ebhv047EdpZZ7gJD5hsclmQi694=;
	b=kCJokco8h++Qg/YqYR8gKBFb2//3XhsynuOlsmF3PQ24bse1U644PMxaJdVJSHbc46C4
	 9xlZLpP2RUlCe2znxE2vcELFnoau5Uh1x8OwDZXog8pM8lBlHG8EFFi37rSa1XQw3iSIk
	 /jXZSzpnNwRW5MHXdEytFvF3mfWJcAPluB7TuJcq6apc5UqDEdIAhuMF/NTKo4UFwJvxo
	 6w+ZEpfMZ9iIadpkkK+HGHPFDzS1Hhy7FUMfo5TrBzZjlSFI1wxnAvRojeN5bwC8IA+r0
	 shcukMnWKQQ25wsWpjayOTw/rALXVzV3zTdEpK9wtJuzXOvnPlWgY6wTay3PNLpdERQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lenze.com;
	spf=pass smtp.mailfrom=lenze.com;
	dkim=pass header.d=lenze.com header.i=@lenze.com header.a=rsa-sha256 header.s=selector1 header.b=TIvip6y1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.75
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021075.outbound.protection.outlook.com [52.101.65.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AB606A88E;
	Thu, 12 Nov 2026 16:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B93AB606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenze.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenze.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lenze.com header.i=@lenze.com header.a=rsa-sha256 header.s=selector1 header.b=TIvip6y1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPpazgt9YIa/eU42N6L3LR5wA0xtGoksanoZezqyXvAdH7Losl0/HD5b44N2DYAF5oYutTjNUA6uSXe6IfBArW+JCKjjPAFAWI4z/mxTB4qoHWwqt+rbb9tPe817kKmFf6CwgxWWE+1tw3SRBjR9I8T5jd+j3n6dJncXOxXO8pUpJAux+7wwsgZaWLceGppkkbA/00V+Qv9vmoXnD66R2XOYBFld467WV0wSR5X7h6smBdrjNwMl7a/zQIjCN861h/MwgGRpwxQsVkohkQ4MkFBxwQQsrrLrkMDyuDqt/LjvNaZgZcXBOWP6+XjFZiX7gTSZeObLIPKBwd1U0Qkcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHk+RV4NNbJ/6UE4Ebhv047EdpZZ7gJD5hsclmQi694=;
 b=zKJZsEx8RQn/ce56A4vJRsxx8vLeSfQcFTBvBKZokZ4oG34laT+r+d1+i1ExfazVYSZgAG1mp0PgsFQtAYYv/nnFlaP1X3dbzSfiGNQ9mgmJ+6CEbUQkWBsSquNpRCHlea6bS8sLbt9CjvVnPHm6AWH8wbRiS7Tlh7Wfon1kaxChTBsvQrn7EBPxBZ6gyX3KrE1fUevmX7C/8y+xZFydjy1n9xFEkt8cyTcufPwY93pckPHN8bjbcaDdm0Y3YscM+hYfsSN6EydtO41caE0x2Tx2I8Ciy0GapZ9Yu3XsxfxRn8MBfe0IjwMt26CGEy4cBI/cvr2H8SW2f4BPGeDy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenze.com; dmarc=pass action=none header.from=lenze.com;
 dkim=pass header.d=lenze.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenze.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHk+RV4NNbJ/6UE4Ebhv047EdpZZ7gJD5hsclmQi694=;
 b=TIvip6y1V76hK0030g6rzzKqLZSVlUSzwHxCTPforOgflyEjOs0v3ll6+EqtJ3HhFGLRwZdbB1jNgD/60flDSFVubdLtDS85Hk+aA/vWOrFVgn7X8BQS033zT5q8QsMK1uxbtW5DdruEyrhjbIBA4BgOyUKIcX/Y+GKfa7PAmqC44yxQMAgwfIS/JcqjO230A52KdnrL+k+0qJYiOOBImb4Nb5oaTyn+TxYMUOGj8bqDlw71XBjyA/ctxnb7yri9I2JUbqm5i3ss87UZEIIceLwQklqph99d9eE286qYxTL5TlIhxS9uxBnaoUhhfYRAbSgaGxEG087V3ICoy8+ulA==
Received: from ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM (2603:10a6:910:da::23)
 by AS2P194MB2171.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:640::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 16:16:35 +0000
Received: from ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
 ([fe80::9250:9858:e034:cd34]) by ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
 ([fe80::9250:9858:e034:cd34%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 16:16:35 +0000
From: "Brandt, Oliver - Lenze" <Oliver.Brandt@lenze.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: "ulfh@kernel.org" <ulfh@kernel.org>, "jh80.chung@samsung.com"
	<jh80.chung@samsung.com>, "shawn.lin@rock-chips.com"
	<shawn.lin@rock-chips.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: dw_mmc: Read clk-phase DT settings earlier
Thread-Topic: [PATCH] mmc: dw_mmc: Read clk-phase DT settings earlier
Thread-Index: AQHdcsEwqVwDFMPCbkurWCfb3enpSg==
Date: Thu, 12 Nov 2026 16:16:35 +0000
Message-ID: <2c5f6a551f5375a5f92728b1aee036d05eebad7f.camel@lenze.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenze.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR6P194MB918907:EE_|AS2P194MB2171:EE_
x-ms-office365-filtering-correlation-id: 283e53c4-1c10-4415-6bc8-08df40d852b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|11063799006|56012099006|261021123027099003|261022075727099003|261026121527099003|261021121427099003|261102123227099003|261009223027099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 +G1a4pHkqb6leU4ITw0GiCy1Rn260/N7iYANj0644BCrsfgmJFDYHPgIsggILVTKM9SaHzdN7u1JWL/RYw6QJhjziHIl4eb5KkEOEJg1/VCnziYBQSElrcIWlyaSOuzcQvojCLqChLi3vg6N2elYYSL0jTr7es1mYqEaUxdZctIKKPh9pF06YorSqOGQ87VlqDlG3t4kcEarKhb+1GkPFTC+ApfhBkITeJKrgjv32IBHOsDxwfoTjJ1cIcZpRFnomVXIdepNBTalOQDyH1MYtQ84RnsemXDqLpUgxd4cIze/UbTvhHCp4e0OyjFWRtqilyxARtKQoOlBTRGOMBwbzKB06C3N+WfNtRPDY+E/OSrgFfmcHVrzOW6S+MDHu+DRVYVLZFqDx5RRnbXFMec8mRsGY6d6wE63TRLk44hODdG75qPObcj1Cw9L2t44k+h63y3rUAhUwV7lDmbAY58t2Rh/n0dXh68D4DIEFC3V5Uc31hZXfB6x9GEeJRKz4kuu3D3RCkqMr/ExTzLRVJxucTiVeEcThOKoAtdun2kQBZpkovZByooYVZHZAt6CWlbPDf2nDWZXGz+LKVal976eIFvJidaf1n2iZr2KBC+Knca0cRvykn+wgiIlMC6rFcX6JTFQrmdxnkz0yTfPBhYuIcE8Q/5KJ5Olw0hiWCQCm/I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261026121527099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OE0yNGZqelBrM0hJeE84T3RGVnZXa2YzZXROZ3RTQW11SGhpOXJnZlFUNGVr?=
 =?utf-8?B?QnFLd204WFRyNXM2R1c0dlgzQW1IRm16a2UvY2d4UUhQZk0vWTg3NHhoVUpo?=
 =?utf-8?B?Wjk1N0M5R1JnanBvRVZORjdHNWdPa0h6TldMOGdwMUVDU2xocVlHVytncXN5?=
 =?utf-8?B?d3BFVlduVVFtQ2MwKzV1OGpyTDFNdXllODVhUzlhQ0xXK1hhZ2xRVnJhdlJh?=
 =?utf-8?B?UkhEOW1zYm5nM2ZaWXFXdHRKemd0MHQzYU54cWp0VUplWGxuKzRkdkpsOTVR?=
 =?utf-8?B?a29CVnRWSW5vRE1aU0xoaXRsNEo0QWdXSC9va0Y3ZnUxNU9vZFFUVS9oNFRQ?=
 =?utf-8?B?c0kyb3gzNWhDK0Ixd0NDY2FkOCtWZ3Bja0pzTUowNkNXcVdQSkNqMGhIYnVi?=
 =?utf-8?B?RHViSTdheFYwNDV4RGVXbHdJK2NVd09sU2xyR3ovalBCdHVvT3gvbU5NQm1n?=
 =?utf-8?B?aVgxTC96REVBK2JoT0laY21GeW4rMGFWQ2pEWk94R2xtRGEvelVuL05HNHdF?=
 =?utf-8?B?RmNwZlZ1dVVJUkVKR3NWUVZuTXVSbnp4Zmc2dzhsYjkwR1ZvNjFjUjg1QXZW?=
 =?utf-8?B?d2FvNjExVGt2cU8zZ0JSZnVmeHlDSG40akdvTmhmQ2x6ZklnVDhYMnBtS3ln?=
 =?utf-8?B?ajlwcWYrSWFUY1R0RTRYZzZsMVB3a2RJMWRVWXBIS1pvcDN0c2hHbzJFdG44?=
 =?utf-8?B?Q2dqQW4rZWtjK251d3E0OUJmQXRlN0pJYmVndWlMUEl6clB5SHV4dEJoRWRl?=
 =?utf-8?B?OHRpVzIwQjVTdEx6MVhLbzN1cEtiMWNxNG9ERHIrS1FNUytTa3RINGNRQi9l?=
 =?utf-8?B?b3pGUExyL2NmUHpxZHc3djhKMzhRbDFMZEwxK3hPdkNEMzBjd1c3dG51bkJk?=
 =?utf-8?B?MTA4OUhUU3ZIR09mSnpQNzkvZVFxQnVULzJUdWdEdXVIcEdraDVXYThub2gw?=
 =?utf-8?B?MEVyNVBWNGxQaVltcHVEYVlKZ0JQYXN6RFhCSDBJWHZheGxUMEU0WUVBZkxJ?=
 =?utf-8?B?aXVQWUl1cG02TTZ2S1pjTUZKbzNFZUZqU1FZaW44ODZEUnNqL2l2YzVCSjRE?=
 =?utf-8?B?a0x1RXd5eHJoZ3Zxc2hqZXpvcUZQMW1yWFJ2ajlaT1hoc1VZTnlsWGFjUXRk?=
 =?utf-8?B?b0pUb20vNmk1b09lZzl6Ny84TGgrYWpxdnJHd2wyc2xqVVhENXRUMW82aWJo?=
 =?utf-8?B?bzZ0TlcvR1dnd092RXlXL2IxRmVQNzdnaTlVSjhQekI5OTIrY2JPd3R6NUtK?=
 =?utf-8?B?TDZrOXdtVnZxR2lINkN3M2YrbHFscnFHck9ZNnBBV2JheXQ5QmE5TU9DQWZH?=
 =?utf-8?B?bHp4V3lKVHpDWC96dS9WaEF1b0QyMnNvMWNzRnlDVVVYdVVyaXRGMkZzMU5Q?=
 =?utf-8?B?VUx5bUF5dUJiQjEva014NWt5Z1gzY0FSZCtpMk1VZDBBOGpoWGVxZU5BODVL?=
 =?utf-8?B?Y0JuMlFGaVR2eUY5MlU4R05FVHdzbmNua20wdTR4dEg0TWd4VHpYbU1BOFhS?=
 =?utf-8?B?UHpoMUdMNDFDTjd3WldSVUNLNXVGODZCa3FsTGE0SERnMktvTTMvNnR3WElq?=
 =?utf-8?B?ZjcrRGsvSk0yYjZGeG9JbnZ0cldNbzZXTTlsa0MydzhmVC9kRlZLbXFKU2k4?=
 =?utf-8?B?Y2t6c3ZQeUdGcy9yN2JDbVorY0JUNW5JdFpGa3orZTh6dzVkQ0hSd2haYWtP?=
 =?utf-8?B?ZnFRNUQ3QXBDMWVxTVJEaVFIWWJ0WEVmUDVDcXFhQkJpbTNzZUdsNk9NQkJh?=
 =?utf-8?B?cnQ0YmRFYW56ZnpvR1lWcVQ2Sy9leVBzQW9JaXB1aTdTMWZKeGxvTzh6ZFNq?=
 =?utf-8?B?OGU2Z2pUSURqVWVrbTFUbE5PZ2xnbXhoTEg0c0RFd2hrbTA2ampYeGtkWUpn?=
 =?utf-8?B?MEIvNytlQWJuTFpzQkxZZ2s5K2Nqekt4RUl4QlhiOTNWUzhDWmlaZFU0bDdY?=
 =?utf-8?B?aTVSK1VIVzQxWmZpOXZVUmltelJmaGtmelBBTWM0eG9hTHBJcFZqQWMralFX?=
 =?utf-8?B?K20xbWx2TDBxbU8zYktQeVJzakFnc0pXeFJVdWxycU5SUTFOcDJSK0pCMlBk?=
 =?utf-8?B?cTIwbnhIUHNjSTRBek52Z3NnbzlnY09ZeFVVTDVPZEQxenhiazU2eTY3Z3Ja?=
 =?utf-8?B?WXo0UXhSNnJtek11NlpWMndtUzl3R0J0eXZkT0h1UURmbFZNYVVseS96SkUr?=
 =?utf-8?B?eUtFVjkvRjBDcWdsNjhJclRrcmlYYnBYV1VSVzFrbXN3bFNXTXNPWjVNYk9S?=
 =?utf-8?B?TUJWazl0N3RYcTFNZkRNS0J0TGVsWU10bmdyT1l2UlpzQVBFUTVnQlFCTElW?=
 =?utf-8?Q?aUSRexYNFe87Yrk4Rv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <257517EAE0AB86409983214016FD5F23@EURP194.PROD.OUTLOOK.COM>
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
X-OriginatorOrg: lenze.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 283e53c4-1c10-4415-6bc8-08df40d852b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 16:16:35.3681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37cf0ce8-ac09-4e7d-9ff2-f1da44914b3e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxQaYjb5Va/+5xgG1hbwLSn6sSmpl5AjVxTQbqMZrebWvDNuDb3nV7sGnYNQ0e7jlf3m6fCWnBeoytn4TlHAYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P194MB2171

V2l0aCBhIGtlcm5lbCA3LjMuMyB3ZSBzYXcgdGhlIGZvbGxvd2luZyBvbiBhIFNvQ0ZQR0EgKEN5
Y2xvbmUgNSkgYmFzZWQKYm9hcmQgZHVyaW5nIGluaXRpYWxpemF0aW9uIHdoZW4gdXNpbmcgYSBo
aWdoLXNwZWVkIFNELWNhcmQ6CgogIGR3X21tYyBmZjcwNDAwMC5tbWM6IERXIE1NQyBjb250cm9s
bGVyIGF0IGlycSA1MywzMiBiaXQgaG9zdCBkYXRhIHdpZHRoLDEwMjQgZGVlcCBmaWZvCiAgZHdf
bW1jIGZmNzA0MDAwLm1tYzogR290IENEIEdQSU8KICBkd19tbWMgZmY3MDQwMDAubW1jOiBHb3Qg
V1AgR1BJTwogIG1tY19ob3N0IG1tYzA6IEJ1cyBzcGVlZCA9IDUwMDAwMDAwSHogKHJlcSA0MDAw
MDBIeiwgYWN0dWFsIDM5NjgyNUhaIGRpdiA9IDYzKQogIG1tY19ob3N0IG1tYzA6IEJ1cyBzcGVl
ZCA9IDUwMDAwMDAwSHogKHJlcSA1MDAwMDAwMEh6LCBhY3R1YWwgNTAwMDAwMDBIWiBkaXYgPSAw
KQogIG1tYzA6IGVycm9yIC0xMTAgd2hpbHN0IGluaXRpYWxpc2luZyBTRCBjYXJkCiAgbW1jX2hv
c3QgbW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDMwMDAwMEh6LCBhY3R1YWwgMjk3
NjE5SFogZGl2ID0gODQpCiAgbW1jX2hvc3QgbW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAo
cmVxIDUwMDAwMDAwSHosIGFjdHVhbCA1MDAwMDAwMEhaIGRpdiA9IDApCiAgbW1jMDogZXJyb3Ig
LTExMCB3aGlsc3QgaW5pdGlhbGlzaW5nIFNEIGNhcmQKICBtbWNfaG9zdCBtbWMwOiBCdXMgc3Bl
ZWQgPSA1MDAwMDAwMEh6IChyZXEgMjAwMDAwSHosIGFjdHVhbCAyMDAwMDBIWiBkaXYgPSAxMjUp
CiAgbW1jX2hvc3QgbW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDUwMDAwMDAwSHos
IGFjdHVhbCA1MDAwMDAwMEhaIGRpdiA9IDApCiAgbW1jMDogZXJyb3IgLTExMCB3aGlsc3QgaW5p
dGlhbGlzaW5nIFNEIGNhcmQKICBtbWNfaG9zdCBtbWMwOiBCdXMgc3BlZWQgPSA1MDAwMDAwMEh6
IChyZXEgMTAwMDAwSHosIGFjdHVhbCAxMDAwMDBIWiBkaXYgPSAyNTApCiAgbW1jX2hvc3QgbW1j
MDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDUwMDAwMDAwSHosIGFjdHVhbCA1MDAwMDAw
MEhaIGRpdiA9IDApCiAgbW1jMDogZXJyb3IgLTExMCB3aGlsc3QgaW5pdGlhbGlzaW5nIFNEIGNh
cmQKClRoZSBTRC1jYXJkIHdhcyBub3QgdXNhYmxlIGluIHRoZSBmb2xsb3dpbmcuCgpSZWFzb246
IFNpbmNlIGNvbW1pdCAzZjE2MjhiYWE1MWUgKCJtbWM6IGR3X21tYy1wbHRmbTogVXNlIHBoYXNl
X21hcCBmb3IKU29DRlBHQSBjbG9jayBwaGFzZSBjb25maWd1cmF0aW9uIikgaG9zdC0+cGhhc2Vf
bWFwIGlzIHVzZWQgaW4gb3JkZXIgdG8KZ2V0IHRoZSBwaGFzZSBzZXR0aW5ncyBmb3IgTU1DX1RJ
TUlOR19TRF9IUy4gVGhpcyBpcyBkb25lIGluIGRydl9kYXRhLT5pbml0Cihkd19tY2lfc29jZnBn
YV9wcml2X2luaXQoKSkgd2hpY2ggaXMgY2FsbGVkIGJlZm9yZSBkd19tY2lfaW5pdF9ob3N0KCku
IEFzCmhvc3QtPnBoYXNlX21hcCB3aWxsIGJlIGluaXRpYWxpemVkIG9ubHkgZHVyaW5nIGR3X21j
aV9pbml0X2hvc3QoKSwgd2UnbGwKY2FsbCBkd19tY2lfc29jZnBnYV9wcml2X2luaXQoKSB3aXRo
b3V0IHRoZSBuZWVkZWQgZGF0YS4KCkNhbGxpbmcgbW1jX29mX3BhcnNlX2Nsa19waGFzZSgpIGZy
b20gZHdfbWNpX3BhcnNlX2R0KCkgaW5zdGVhZCBvZgpkd19tY2lfaW5pdF9ob3N0KCkgZW5zdXJl
cyB0aGF0IHdlIGhhdmUgdmFsaWQgZGF0YSB3aGVuIGNhbGxpbmcKZHdfbWNpX3NvY2ZwZ2FfcHJp
dl9pbml0KCkKCkZpeGVzOiAzZjE2MjhiYWE1MWUgKCJtbWM6IGR3X21tYy1wbHRmbTogVXNlIHBo
YXNlX21hcCBmb3IgU29DRlBHQSBjbG9jayBwaGFzZSBjb25maWd1cmF0aW9uIikKRml4ZXM6IDBk
OTQ0NTc2Yzk5ZSAoIm1tYzogZHdfbW1jOiBBZGQgcGFyc2luZyBtbWNfY2xrX3BoYXNlX21hcCBz
dXBwb3J0IikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogT2xpdmVy
IEJyYW5kdCA8b2xpdmVyLmJyYW5kdEBsZW56ZS5jb20+Ci0tLQotIFJlcGxhY2VtZW50IGZvciBv
YnNvbGV0ZSBwYXRjaDsgU2FzaGlrbyBoYXMgZm91bmQgYSBtdWNoIHNpbXBsZXIgYW5kCiAgY2xl
YW5lciBzb2x1dGlvbi4KLSBMaW5rIHRvIG9ic29sZXRlIHBhdGNoOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1tbWMvMTQwMzE3ZGZmMGZlYjlkNjJiNTgwYjFlMzE3MGNjYjEwYjhhZjE4
MS5jYW1lbEBsZW56ZS5jb20vCgogZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuYyB8IDQgKystLQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL21tYy9ob3N0L2R3X21tYy5jIGIvZHJpdmVycy9tbWMvaG9zdC9kd19tbWMu
YwppbmRleCBjZjVjZWNjNTQ5MWQ1Li5jZDQ0ODk4ZDQ0ZjNjIDEwMDY0NAotLS0gYS9kcml2ZXJz
L21tYy9ob3N0L2R3X21tYy5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLmMKQEAgLTI4
NTAsOCArMjg1MCw2IEBAIHN0YXRpYyBpbnQgZHdfbWNpX2luaXRfaG9zdChzdHJ1Y3QgZHdfbWNp
ICpob3N0KQogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKLQltbWNfb2ZfcGFyc2VfY2xrX3Bo
YXNlKGhvc3QtPmRldiwgJmhvc3QtPnBoYXNlX21hcCk7Ci0KIAlyZXQgPSBkd19tY2lfaW5pdF9o
b3N0X2NhcHMoaG9zdCk7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKQEAgLTMxNDMsNiArMzE0
MSw4IEBAIHN0YXRpYyBpbnQgZHdfbWNpX3BhcnNlX2R0KHN0cnVjdCBkd19tY2kgKmhvc3QpCiAJ
aWYgKCFob3N0LT5idXNfaHogJiYgIWRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJjbG9j
ay1mcmVxdWVuY3kiLCAmY2xvY2tfZnJlcXVlbmN5KSkKIAkJaG9zdC0+YnVzX2h6ID0gY2xvY2tf
ZnJlcXVlbmN5OwogCisJbW1jX29mX3BhcnNlX2Nsa19waGFzZShob3N0LT5kZXYsICZob3N0LT5w
aGFzZV9tYXApOworCiAJaWYgKGRydl9kYXRhICYmIGRydl9kYXRhLT5wYXJzZV9kdCkgewogCQly
ZXQgPSBkcnZfZGF0YS0+cGFyc2VfZHQoaG9zdCk7CiAJCWlmIChyZXQpCi0tIAoyLjQ3LjMKCg==
