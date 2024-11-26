Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED313BAE3;
	Tue, 26 Nov 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607428; cv=fail; b=Ho36soTEVPdNwYncXUTnAXBumDU262PoaTtv447l5tb5xlWbBgIYMjYNHRk+ToxljfiCsgSKyC3pwIIwLVaHDT5gQzqQkHm0zUHOMJ1TI/580FVUlJLiJrA8Q4jt4UyAI//2yVZaA9YWRy0uQDZjoST0u5/Lksx5nMev7EpTaiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607428; c=relaxed/simple;
	bh=QO5FsovdmCwjVVGDK/0LFHS+Ykm3qFlbvDTKOV/hRBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tyLuj9Phb4N1+4E6zmLzgwzOHPIdYs+PGz9c223g8kHtFMWLzRFVhoKPakB9lFyEzoaXzTJQ7BaRsQ38W+uOpg9mlIAUPitlaQAn38OW3lMUzheuwdhsRm+7GQjdG6lRS7BaCOetvLxZUXn60YTrECmt6cUs650Wwtr0hv3zgik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m58VjSFU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JIe+9MzO; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m58VjSFU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JIe+9MzO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732607426; x=1764143426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QO5FsovdmCwjVVGDK/0LFHS+Ykm3qFlbvDTKOV/hRBU=;
  b=m58VjSFUOVtUkMTRiFfsBygpkXCkyED+5LfDL1hwyHj6np9vTG+Ba/Gu
   DCy+Gqlmwa77RDBJm3/3YMGFuEXwXbbp81Htzf4XfvG072Rb3MYtzK6us
   xMxfuZqDzGoIaCOEQAi0v7qDfrbcOp6nzrIcK02EHD8k40jLeIWz931nd
   fl5mnCCpAtmLWfBpWfDOHjTQBvL7J1pw9wpcIybf5VSJEkV5lAgwbBnaR
   HZsiaewd/qUyOpn8+tSkQJsngR5oyLAbj2a67vt9pRHDKWEglbpbEtgTv
   0uQcWQkIvZDR8smKZ5n2KavM6+vAjGRDMNyM4E49hTIPoWvuet/fnoZOP
   Q==;
X-CSE-ConnectionGUID: HKAS2QYwSUG2a73oojxR2A==
X-CSE-MsgGUID: yUlVCwLjTXKmi8OB/ztEXg==
X-IronPort-AV: E=Sophos;i="6.12,185,1728921600"; 
   d="scan'208";a="33438775"
Received: from mail-centralusazlp17010006.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.6])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2024 15:50:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5RgEW69o+OcxtrJMSss/5yv3BtgVxz5Vug9KKGbaVBKIN7el0V9q5vRGF4v1Rh0nxZSNojED0SEGeht0aHN2guMGch5GagKGpR3jxTT/Oimy1+N3ta0LDlUxcH/EOFBMn1+1OM4gEp8t04UDGJpLVXhTWH5ZH1/tG1kIjhUNCeW7iMU6EIZQQ1DB1PXCCiLlJw9PFiiOA//G3yo0pOaoI3ZQDy7WdLVC2TMMU5OcaI01atDxKhoEAkVEM7ZhuCncY058v6/OeREGgImPQAYDWPn9YJuStVu5r/JuwbGv3RRqm/wJwPFgRUPsZ5H96hjpGdhQ1VbRA/ZBcKPlLQ53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gor6t42sUCWfStfdOIiwkVOpB+LPq3vYnJP1iIsyhKY=;
 b=DYzL1vh5B/45c9ExjHKStiB6aM1se8ABP5a07IoZA4XHHvcaR8UquqtDkOqsKkw6Aj6JIBbnGFDGyT+o8jD9YhM6PMNm7zgPCd+YOIj4gyePgvBUf2DABy94T3CGSCPm0Spkx/s1tjH5Gs3Tc5R6ELy2i7hkIi4THQEcHsZsbabRV2fOmaXo34PPqHarYSYxkNWi/vLoP+1ruQ6C6Oxaj0WiVu57QjXEgle84mpp3LuAaNLHXcSClqb1iK+YCH6zTxo+okKx+8YJgSmqDxItp9egwcQEsNpinsfPxTO00ZzEfW0aSvblDcBM6llCHk+IOM2fBz6WTUvKVcZiG/IGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gor6t42sUCWfStfdOIiwkVOpB+LPq3vYnJP1iIsyhKY=;
 b=JIe+9MzO9j09T34MwCmboOsHMF5WB90YtuGuVCRKmnR/1XYfwvgL6pWHTUNWw5/IPAdrf6oYUmGxfeAf8+cNs+fAZsRhZvthGL1vb87ttbua2rLGgJZraDQcPWytkWiI+mj2z5vnPG2weOypgoldg6lQSRf15ndypyE37onbEk0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA1PR04MB8784.namprd04.prod.outlook.com (2603:10b6:806:376::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 07:50:17 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:50:17 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, Andy-ld Lu
	<andy-ld.lu@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Drop the MMC_RSP_R1_NO_CRC response
Thread-Topic: [PATCH] mmc: core: Drop the MMC_RSP_R1_NO_CRC response
Thread-Index: AQHbPz1jG8RrC2uOC06c22jS3Ky7+LLJMQTQ
Date: Tue, 26 Nov 2024 07:50:17 +0000
Message-ID:
 <DM6PR04MB65758A3A4CE4B86DDCAB2973FC2F2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241125132311.23939-1-ulf.hansson@linaro.org>
In-Reply-To: <20241125132311.23939-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA1PR04MB8784:EE_
x-ms-office365-filtering-correlation-id: fc5e352c-832f-4e7c-64a5-08dd0deef822
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6R6Lcm+ktQJtyx02mD70BNYRB0wJSEzhk8z93Y1Dd/qIP3QvP+fRw05/K6AJ?=
 =?us-ascii?Q?CgyLJN0X436vRq7gkHKWh6nfMdhqKKGucX3wB9O58U23FBDNcBhmoT48E4SR?=
 =?us-ascii?Q?4+ALlTw/+lLeZ6SRbZwM8ipKEmgzQPltdW4yhP2FlF/XLRfY7A3xBkE+2oi1?=
 =?us-ascii?Q?suim3yC1LYu28i4CIkMEpKSFMrv6w0ZfwQmKPX+OqfSRByZZEwR8wUfPpUZU?=
 =?us-ascii?Q?Y7+xqNcvBhXcZTNvSQH2Wr8hdiy77OlfBZA3aYXW5nngB/QgpqKaHsvyC+kq?=
 =?us-ascii?Q?GFPDpMk9VlDNdwijfR8DRM1C6y2BUxGCnT1tyDM7aw5gz5fGf73KI2mkPKKX?=
 =?us-ascii?Q?p/9TH/kGlP6lm8UWaFR/duKeBXK0xFFERBNi6cx8z7S5d6NhT/t8kmhmMqvw?=
 =?us-ascii?Q?ODshGm17O8A1S0YwIspa5sfJlCh2IF4NhQzJeWxWmuxaRgziQ5WjZ8moB9hu?=
 =?us-ascii?Q?ZpWtNEQ2mMw3Jb9WBghyqiZ3tCtz2r1qNrihRvkhoBqquyL29+nx59EmgfWR?=
 =?us-ascii?Q?ToqA0V7irP8Zity5c3KrRrh1dZhjclgD7vw6EaVsYCV1Oez6Q7CN3KYcG4VW?=
 =?us-ascii?Q?qWMOzaQbFTo1a87amC9Fk0G+6eZVKLGkx3Cp79wxXRtyoKdc2CgS2LrpBfq/?=
 =?us-ascii?Q?ih4rilDckAS0EITxvqu/64A3kRf7uICC825Udeba2AvUxhw3BM4FlZl8InvF?=
 =?us-ascii?Q?baqUIuZKVipZj1uKEA6iNQwKtMwNpTP8cywMGHhwbh53jM4k7S+zs3zIun5J?=
 =?us-ascii?Q?kGfQZMLd6bNuv15e/xtK6JqUKxrbYyX7U9ezddx31PfLcCCvH1spZXzeUICk?=
 =?us-ascii?Q?mo7UQm6TPAvjnmIV8I7Zt3+Mv8hWVb/ljn/HbiDsWsJsgIQ547sH6vpJs1CS?=
 =?us-ascii?Q?dz/dWL2Udt8fbXzLqNjg04i+ShFUDH/89h3Y4YObiwUQWJpXd9/ZzYZMGCk3?=
 =?us-ascii?Q?n+aJEztQVhYkdUh3N1YRqsWa+rPsqmgJSZDSe27GMi9nlOwIQUUhdqPjwlkf?=
 =?us-ascii?Q?JeK9BWKii8VbHsmd6PyGSRvHAc3aWPYKr75PI60CFjgAl9jmUjbnJmU6DYuu?=
 =?us-ascii?Q?8qSs0K+dN5u/TxN+Gp+tuoZ6QghZMOEmM8QNJz0VCD3XkjDVu/lMiem5fUZb?=
 =?us-ascii?Q?ESDHZCj40lmnaddtUlMyKSzwHhDATt39BWQhCSerJ+q/glmBYoxh7Si1AmDS?=
 =?us-ascii?Q?466omx20WKEg7TrA20/kmg9jG4ivOTEzLh6HeC7wYp0AbGFL6P8KqoinwbI6?=
 =?us-ascii?Q?p77gjr+HYP6a61fzW4FG0T7pgnid14GUbvPrWkQIT8aYhzIgYVgXYxnrJAYm?=
 =?us-ascii?Q?qhAcFchRa3y5waNS+GWQcqlcx5ICJKkfrSL117x5MNHcjnm8/yg7wn8RQgYZ?=
 =?us-ascii?Q?DLd+nGF9mQEhv+qAq7AZbVrnzp+m0wbUIMQ8pcTiv8VAkFJb5A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w8jT4i+vEiFxKNdCiNYFj8681Vt7BCvDuIxNjoJXSfQk5D5tC7SabjcTKnb4?=
 =?us-ascii?Q?oauFDg/aLkxVQh9zqdQXmTIkgQ6eCefphImih3uByQM6vrtI9JjxxRDOx/H/?=
 =?us-ascii?Q?2QQsGv6sX35gHwLgaK/omz1HiutTVDYsOfc7ITV17PDJe2mmcxHCUkGjAoOX?=
 =?us-ascii?Q?3w8duOpugBNfenjp+MRjp8EmFmMcYRYYZPs9MVw9+2Ml6tnqAWE885O9A9Ju?=
 =?us-ascii?Q?AcJevF744T6XFTKor/+MdZaChmwlvPjAaqiSpaHwP5eIGCdOkDTfyzTKpCJO?=
 =?us-ascii?Q?qO82LzIqD9++M/R2ZrL5ZEGZA12UWqJUBdDOaRmGtacy960EP/26pnypjomh?=
 =?us-ascii?Q?A9E0/P4jdWe9Fo/04mHmWZSUY151Yucn9qRGs6rsIRLBCARJ3i+GvtRSN1UW?=
 =?us-ascii?Q?6dc8JrvHoIp6lGhpoA93OWaE3zx8TXRYzCe5YnzbjSEah3D9eL5wFegQGrEB?=
 =?us-ascii?Q?1a+J5BVk0OAfnKkVQDfSko946AduIQ6rsSYckVVydV3vEzBrCQeVXlLpHakk?=
 =?us-ascii?Q?wDfazi21xWQYVKughXqGYz1gPwQTyxNSYw5t5VOLF9K228QJd13NmWekcDCV?=
 =?us-ascii?Q?PS+KsgXRm7ETPtUZfRlnNh/cfPM9/8D/HVdV96fusc1TmNSyM41eerhBG1I1?=
 =?us-ascii?Q?oXh52VPzQJQQwrKIomwDI52+GD0ath81b5SUzW1fmH3CtTVcGN0s1Mq5pk+x?=
 =?us-ascii?Q?ZEu8FDz/exbFFaKexSFmdz2oKsjOObcQebPfJqxJIPJ5tcDKPyZ2W5L7fhuY?=
 =?us-ascii?Q?bs0/o0AmGHHLhbdzXFBejQ0eK1XrCL7qT08ErtXtPoy+VUURAZi+Rza0N7HV?=
 =?us-ascii?Q?sHZqm0XRniC5kbXBkUKAmXKW+g7aE4t2bD4/EQO2eVAZqzJspIR/9y6XTJZU?=
 =?us-ascii?Q?zcj4AICvNFbC+9jvh55pbPcPFAmpqVAIVibVNPW+cGJlcnCec+qf0HT6ULYu?=
 =?us-ascii?Q?wATUv8BB6R8p50G0+AGBwENXzSMzOyTKB0KQMgpB43XDG7qLUfqBruWdVpYl?=
 =?us-ascii?Q?Es3Aip27tLN/3GuA5r5jMpWvT0ooJ3CaVdj2DRWrRiQFnx3IoL/Q30T7X7pC?=
 =?us-ascii?Q?+k3Ib3sfmy4I6dxSRSg65ux2nn3lKktn/gLwIoXQKQRhLWecn8opOm1DWBm6?=
 =?us-ascii?Q?PrgVxSL6mD03AR0o1ljUctp21IQAqWqKWUxlWlPrmODlRURW+LmpTGFg+elu?=
 =?us-ascii?Q?9Vybyc8/OWjO2jlMmpij5OOXhTFwC3VIKWVbGuJ/2+07Xsygr63Nl81KJ3N/?=
 =?us-ascii?Q?obmOW6CHRDEBbCllWKEF0pJFE4SGSn61yKH2GIYWnydx/MhPEm/0bPou6tjC?=
 =?us-ascii?Q?eqlerNsgwosz/4Y9yIEKDZ7bqLt+RiuSp4s2/aUYvls22+Oe+ghooF+IUeoi?=
 =?us-ascii?Q?gvIaNwguzI5cdWBILrgvcY4WpqPy/jj0YPyPoNHePhHs1j0SHqTinycS1nxh?=
 =?us-ascii?Q?4QgcM55reXdRDDvk02obF9jRKBmjKqonl5USb+zJ9veTJdZnhVtEZi+bdMhc?=
 =?us-ascii?Q?LTn/PAxBOUGy5Ku74V8eUDgDZfzkn29I+O9XJqh81YQ4nLpbg25rgwGoHehn?=
 =?us-ascii?Q?z2YEoaFgP46+VnPo7ukqg65ZGKuI0dLoHIaKfYGG2xIA4AWQFbVbqTjXTZFo?=
 =?us-ascii?Q?SJAHIGGGTsXUyOkB0CSvOEF6Yi7VoVGxfU9dBzwie8sS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RCa6B4mmMGaHoICGCJWLUSQsIOVo5qPfqBRJuN70ncxDRq33qt1tG1fsGs/EDIDaSRzrXfpoTtk1aS15PvmJIilqWwxXc+VG8ovQLd7iCqLA+837A8cXVf4VckopRcfa1BC2pGEl0lSEDbiJ/WB8q2UO9ViVv0e+Z6vBoxvynedPD+8FqPQg1ZwxSWyWgfaOc2Y0hIsaahbjtrr8NrJp03bzVO1XlwZjMgC04PoIEoc1r5WXvI90vfjF6RA8TrPPsLPXKDoIV6q4OgSg/29aT9bQVhpOsZTnLWblW/5btnk2Xm3YrAg/yjug2du2uoLRmFBAMPUcdzz3MX9gxLGSi/q1K1vOJm1JiThGd6IkGzzIojqrpGNMVhW3bGuiS9JthAbXLmrbcO3I50CmFle1K+Y3P2RE2x8r9NeaJTUf5V+foZRzpBgapsegYRKa9WMgaT3D6V5rZrWskaM3HKz4LeylTs6r6mJw07OfzQTMrS2Ut2sgNi119+LUBi5ieKqOBo21IHJBihn/T/gxzcYig6HotSny/ezZI7oB4PqB7F/DM4h7G1IybBlJWZUybF74aXpLg3TDg7xP7be+cJwO9xaFiOPsD9te1zU52fYefdfY1jopFLnN9erygSFXoNcM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5e352c-832f-4e7c-64a5-08dd0deef822
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 07:50:17.2420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQYvWFF54k9zvV4CppDDVWmhV3mQocdbzTQFwIX3QcACzGDo4Y7xu0lmTeT9hXvzlaexfYGrO/nmR4DLu+l5XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8784

> The MMC_RSP_R1_NO_CRC type of response is not being used by the mmc
> core for any commands. Let's therefore drop it, together with the
> corresponding code in the host drivers.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 2 --
> drivers/mmc/host/rtsx_usb_sdmmc.c | 3 ---
> drivers/mmc/host/tmio_mmc_core.c  | 1 -
>  include/linux/mmc/core.h          | 3 ---
>  4 files changed, 9 deletions(-)
>=20
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 48d3b0aae5a0..0c6eb60a95fd 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -115,8 +115,6 @@ static int sd_response_type(struct mmc_command
> *cmd)
>                 return SD_RSP_TYPE_R0;
>         case MMC_RSP_R1:
>                 return SD_RSP_TYPE_R1;
> -       case MMC_RSP_R1_NO_CRC:
> -               return SD_RSP_TYPE_R1 | SD_NO_CHECK_CRC7;
>         case MMC_RSP_R1B:
>                 return SD_RSP_TYPE_R1b;
>         case MMC_RSP_R2:
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
> b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 107c78df53cf..d229c2b83ea9 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -313,9 +313,6 @@ static void sd_send_cmd_get_rsp(struct
> rtsx_usb_sdmmc *host,
>         case MMC_RSP_R1:
>                 rsp_type =3D SD_RSP_TYPE_R1;
>                 break;
> -       case MMC_RSP_R1_NO_CRC:
> -               rsp_type =3D SD_RSP_TYPE_R1 | SD_NO_CHECK_CRC7;
> -               break;
>         case MMC_RSP_R1B:
>                 rsp_type =3D SD_RSP_TYPE_R1b;
>                 break;
> diff --git a/drivers/mmc/host/tmio_mmc_core.c
> b/drivers/mmc/host/tmio_mmc_core.c
> index 45a474ccab1c..04c1c54df791 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -297,7 +297,6 @@ static int tmio_mmc_start_command(struct
> tmio_mmc_host *host,
>         switch (mmc_resp_type(cmd)) {
>         case MMC_RSP_NONE: c |=3D RESP_NONE; break;
>         case MMC_RSP_R1:
> -       case MMC_RSP_R1_NO_CRC:
>                            c |=3D RESP_R1;   break;
>         case MMC_RSP_R1B:  c |=3D RESP_R1B;  break;
>         case MMC_RSP_R2:   c |=3D RESP_R2;   break;
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h index
> 56972bd78462..e13856ab6ad0 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -64,9 +64,6 @@ struct mmc_command {
>  #define MMC_RSP_R6
> (MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
>  #define MMC_RSP_R7
> (MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
>=20
> -/* Can be used by core to poll after switch to MMC HS mode */
> -#define MMC_RSP_R1_NO_CRC
> (MMC_RSP_PRESENT|MMC_RSP_OPCODE)
> -
>  #define mmc_resp_type(cmd)     ((cmd)->flags &
> (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC
> _RSP_OPCODE))
>=20
>  /*
> --
> 2.43.0
>=20

