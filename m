Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011049.outbound.protection.outlook.com [40.107.74.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B432356773;
	Fri,  4 Sep 2026 02:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788488672; cv=fail; b=cSnshmmBxLRkU9fnhzb5nBHLIK7lHPnZfyyAUY+ToJ4TjXgl6V9zcqXYZR1vRTlzPYicQe2B50CNzP3O7bed8b8kW+12IsMFkhZV2pUGTTlm/BSjYqbYEKbU8U9vpDZXNQ9xCYOQObFHZwe0Jq/v3nCvQCxof1nlKdnHYbDN/5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788488672; c=relaxed/simple;
	bh=OgS/BDOJHdEk2PSC2htXltlByb+2kFZltXvnpWKipgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i1tSmgtygcRUox28P64Oaz+Vy6xIVccK/k9uklf4QQ4IfKOjGgYJynCgUzg1aggRwES0rdtAHwgSZSc5qVeQ6oZTkv53E0hh7d7AUQFtr7TV65GTg4JR5L815CHkJDv4xG+e6HYXztx7vTjm1IR/58la8e9S8VfKsEtMYdfwNmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Z4xrnyW1; arc=fail smtp.client-ip=40.107.74.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Z4xrnyW1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vb4civalJPhLP50+0i8z4L0Fcz+i9Sa4kYAqxFDFhNKIp0H4Y68kPJHFN/xaR0DzhoWf6ozKXZsoyPbFtPFqEj/jpfb7WG1Ko1db9EH02RFpkifE8FXNatMW7JEgHyI+HOzQ8dV3Vavqco/3e37PX4bV+mJocU90Tv0MNqpg9oznfMhyPKhJfc0MZJn9wl/hgzPFHRe86B0ZM25+vWpRh3Cf+R1nqdDEmsL7CXNwsDtZoqfWBheR28i5sC0lrIY0vvBNYeHHOKR/DFqSiOIJ4FeCb0SZyMYqSEXNQ7yAMTiW4rRCLSIbEHz6nJE5X4/yYf1T4u6bgA7SQ2Pss1tfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgS/BDOJHdEk2PSC2htXltlByb+2kFZltXvnpWKipgo=;
 b=sq7EpNNI90pfcseYvU2ny3cgE6bQBDyJfG3S6x7BQdFU8fTOXwkRxkLVeeE5/vPAanMf7OCEsYX/erSDcMswSOFWVOTxpBEISffApfzzyhn+xOiarpBPn279CgGzOy8aGNa4HrLM05C3FARravBuDrWxMXAX9hkrdpPRcLFmNXbz1TH+H3hr36LPzHfkwSa9LJCxvaFHik9CEGzNEWUK2plt6Hsty2yJALTCXLyzFfis6Qd3Z7KLnmfu6UBCzxvDso9nMXLMbpP5URq9vhdBa3d1hrSA6yGzxKNq13ivectJsSLKbuQJ1E5gm5ITJbRvapSwiDQtHpAbkua5zXGnsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgS/BDOJHdEk2PSC2htXltlByb+2kFZltXvnpWKipgo=;
 b=Z4xrnyW1lFeC4d4iqk+it97TZNdj+e8irusmF64rimjcS7slbu4dsVjOpkNzQqrG+Z5RysJhsqAbFZ3FBXxcUS+nKIEv+Jppr91edZJRJz+Yskg7uchp8RBM1Z2ckpgUM4h4Qx72M4yfB8+sipGqY6Ik4JsyBPx66KeIfJoAX/w=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12727.jpnprd01.prod.outlook.com (2603:1096:405:1b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 02:24:23 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 02:24:23 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Philipp Zabel
	<p.zabel@pengutronix.de>, "magnus.damm" <magnus.damm@gmail.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 00/15] Add Renesas RZ/G3L SD/eMMC support
Thread-Topic: [PATCH v24 00/15] Add Renesas RZ/G3L SD/eMMC support
Thread-Index: AQHdMMe6FCa5O15soU2kHswixJD0Q7a9X1CAgABno7A=
Date: Fri, 4 Sep 2026 02:24:23 +0000
Message-ID:
 <TY3PR01MB11346A6003FC02140800246DF86B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <apnUfCIcTG4bmYZF@ninjato>
In-Reply-To: <apnUfCIcTG4bmYZF@ninjato>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12727:EE_
x-ms-office365-filtering-correlation-id: 9645ae47-0ae2-43ba-37ca-08df0a2ba28b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Jn+uJR0gacgHYxZ1qcJFMJLa+wbURa3pNhi21cTI5XgEIIttt21ZbRuf9ffihJUZ+abSwcKBsrAYnhel7iliXJZRqzwL4+mNsfrleiQ0B9bg/avNpMhncAJQeFwU9vNPJaJHUxpJrGyQMb71/5nCYahC/2j9UvoBdVpt3yO5WpDoqq+mR33dc554JOzZR/GANMK5boGFYKZR48mAhWxz1o2BDlEklg63oxV7DQ7PzRRnvW6IFbO44ObBf91ntPR1B7QB331iHYf4W29DF945KZceCmwCQahiTCSR3RLlwabT38q42odeRvgXZOh6GrYGMX7R/SnFviVnBWtzc9ofMs7PwoFK+VVVtx/7hjTdjtnmxa6nwY8cGvZycIgONzDiwlLaDyAYXttTUqLN1tHCpXY//9bKjtsv0bGdPyw80Ni/QxcCpRShGMbSgMDPjC1cCri5qhpGz4mXiOmvkyGb77wrlJHXwAcwfgLoISMeiw0+HKxAK3hl0K7T4OeaxbcWhcUZlR8H8JIz26xYNZuVR2Sct2Hw+gORShGzYkLCR/02dyKYpfKbBGpRGZ4LuvNSTiFnHs65RjcDkeAK7ASGfeelIA83XKUg84jF3WVBt/hYPMPDON3UUkdWEqW9Tgqvqx4ULYlXumQk6HCZxnOs4yrmnnnWj5bvtTGIgsAfJ804r8t/l3P6AP/wL5TiW5u6Ip5By2eeJumDnY0ddFKq20t9JPT9N9ittqXENnUrigg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HI4EzitcbuS9H2vkzaYPpJkDjS6KJPIeUb4BHiZ3uBvfCspq0v8KWuJV9f8Y?=
 =?us-ascii?Q?wPPiySiPO6/nmiopuNOiVShsTV/+0T5WaHrSgY7yXGjU2ClL85Hb60K4DwjE?=
 =?us-ascii?Q?1l29zwy5zBtzmQoWr8D7evXejGP+PMmoAtTpqu5IIfiwFxKDhL6Or2kk9G8O?=
 =?us-ascii?Q?jnCa16qGKTQ8sLJIbDzS1HvR20mRUoEPqkZACYlITK5zBNo9mBmVhlM4lwu4?=
 =?us-ascii?Q?5pM52k5UCNNp3MSqTzmduQEspNY7Skdx/ixNYFArwoqCxcr+NUl7qSHInkVm?=
 =?us-ascii?Q?uGMAMWvlUVHBJLGjJpolSIwFUNC72qC6ZeWtRkhTKMWQJPVFMgZFEGaGjyso?=
 =?us-ascii?Q?Y+JsGl6IAXs/nQzDKNgiMD+6RFyasSIZ03CehWrxcxfHJaa1LST36ERzU+18?=
 =?us-ascii?Q?KUugDie0o89vAoqIEL+F2XcYijSc2rN8Li06RAteNZhZxGCE8yqjbYhiZd3b?=
 =?us-ascii?Q?23/tJmZbUZhxhPQvL6elfxsnHc7Gus2jlBTOCP716DlAOUW8oKZzRhrPSOdE?=
 =?us-ascii?Q?FUfi3nuumm7y6TWMAfEDB+m2KUJJcACxdP1hh8SYoI4fBe2DF1Hck9w1zAoJ?=
 =?us-ascii?Q?FSUEXCkbJPMv/H9HLZ/AvvV/+RYDhVcLJt3MQCYKj4m23quM8fWu1V2pGfXZ?=
 =?us-ascii?Q?kybCVKUipq4IkJlzBh7S7/QGEDF8JQ+PhV6jRRf1ZJpdkArPPcaehnFZ8ZES?=
 =?us-ascii?Q?rp7EYGP7rihVkgiXaAo34VmT9vaWsouQQW61q53LDHyRIpPahU5SKlGCAGYb?=
 =?us-ascii?Q?XezVJ2RG4zu/5fsWeFNro/DRVfdMMjGr7MPKsWJt0kKWcWc+e6TTJrOpTHKF?=
 =?us-ascii?Q?3hTtDO+IQ0bl5yVaAd7OuTNMKeOTmysApZeCpuR2fSrQItT2+KM2fVGEmTvh?=
 =?us-ascii?Q?6PnX1V2Q13SQgTKjHAkWn4rPQIQHi3j9v74ubbUYC+6KVH0j794zBYJzX+SB?=
 =?us-ascii?Q?j3SK9k+A7bq3OLFP3U5+/HxQ7h8oho4LmSwgkta5W5l4FgbhpNH/elCcqegQ?=
 =?us-ascii?Q?prQSgiMhTA13xZXFDF0nFgsmC8/oIPl+KSDFtMu0BmRZESDMgwDaxVn9rZbB?=
 =?us-ascii?Q?NdtRTzRs5vrAxlPRLi3i9Z1uEbbS6anvXpjengzUoNblcmTIkVES5VqX89m3?=
 =?us-ascii?Q?+9hR70VXkfcHCe1cjAbWpCFktWMysH4QwgLTUibIKRhoKnrQ1DFbNbctNKQY?=
 =?us-ascii?Q?lusq48CWHvMYYAHnDyYb73aR1++u7iOHHPxIYyhRPwC99kMJiDtxR5U6Qeco?=
 =?us-ascii?Q?ixLCy+1j1cIUtUMwQEWXKt3/+wlFnz7E6B+A0uzX5WBwJ2ccuinQxWsg7Xxv?=
 =?us-ascii?Q?D/4O1qJwXR3Xdj+PFZp3/h+P+XFLIKBtKiySYEpIr5rRQdQFIBBLMz+MkL3/?=
 =?us-ascii?Q?okHLWbxQhL4xt6Dj0ERXEe4uibctZpWF41dEpfCCYwPa3IiYGz1UtNhlUsqG?=
 =?us-ascii?Q?+/JF+k8DzjUeyD80mOR/hSO8+W+xDQl6MqK9ZA8VfugHtnSO9MBI89/MdhgQ?=
 =?us-ascii?Q?qBl6dP4neBIT7SKtI5UW99Bpi5WZ5zUYqa0fGKBW2SWspuDfOLOGtClOf6hy?=
 =?us-ascii?Q?VAvWqrfmJeEt49HOSZCmE2q3F/vHKB5fZ6hpFIJcRMIz2xEhRLDv5JWIWQZv?=
 =?us-ascii?Q?BGLhV2ws3NZprB24siA7N4zkbsA/Mf8ccS/WE1T6LaDvtkIMW8zEtNyChZis?=
 =?us-ascii?Q?pTWPVyWoo8qrVabPZ730D4BBqRsXESXodiNFvDR1q11otXXTl837GvuWlEZR?=
 =?us-ascii?Q?5veVh25BxQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9645ae47-0ae2-43ba-37ca-08df0a2ba28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 02:24:23.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLV/AxSfTDPCba/GgtNXFVWae7ZLzvVxUcaF7EJUJl6DU1g9xZPazYov9ptnrqhFzznsXq+2P/1T5pMx3HImuezxyjcQpQ7SM6Rnl1CAhgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12727

Hi Wolfram Sang,

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 03 September 2026 21:12
> Subject: Re: [PATCH v24 00/15] Add Renesas RZ/G3L SD/eMMC support
>=20
>=20
> Although there are still issues to be handled, I tested this series on a =
R-Car S4 (Spider) with HS400
> eMMC and on a R-Car V4H (SparrowHawk) with a UHS SD card. No regressions.

Thanks for testing. I will start addressing the review comments today.

Cheers,
Biju

