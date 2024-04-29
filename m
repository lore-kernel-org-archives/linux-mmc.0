Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89511292CA
	for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2024 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419503; cv=fail; b=leasJ15wNMT0t/6ShCYs3SHAz9SDNdqrhHTKyJlmDe8ANBJNwH6e2kJk5e/oZkqpb1DZqyNpEHCHeiFFdD6HXUhgIvQpLyCX0dvCBqy5e/pI2H7mCflL9Yqnfp6JwBCFxhdxE53LzT/UrBgllDPvgLJ9jl15JDZZGiIkxkRyTU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419503; c=relaxed/simple;
	bh=DdYjtBqcN58Z/P+GgQQP02q5XrW4mDJroixHppqT8zs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SMHrLoMt/GIgvUKrPwnr54YIf/bON2hMW6wRwkSF3X+cfgd5UQJz9ICBRJU8NKG87+JemQidGtiJlEzjqYHSLC4DFXx+jMrpi2GtWRdcNIGbHM/Xn2GLNBA6WBPS9LbK1g4qv208Hr0l+csJSR9cBF5va3kgUloI6rkbHPsX2Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fpG5Tofe; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=B/bqvxP6; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fpG5Tofe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B/bqvxP6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714419502; x=1745955502;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=DdYjtBqcN58Z/P+GgQQP02q5XrW4mDJroixHppqT8zs=;
  b=fpG5TofexhcDvmIrLKy6yHfHr0BgNENOouqX9XF+1G62awsCOvixm4OJ
   EzDmIAVHWtBSS0Cdw3vZN3KHaICXa4N2m2u1w1pj/HEP3gi49aCq3uTL0
   Qns4AQ9Ir+Xzhd+MNyz3YZCZmZMjfAPVwgf4Xic9TXEdboQEzsC7qpwn2
   Ia/5Qy2jxx4g9vvnaETbOdC73AzCW2hO9LN0JTndwde/jsolsEOdwKnB0
   pTT6qSLvpCVBc+yyJ7E1koXUoPFdhf203nFbS0+P+DeKJtF5PwPJtmgVr
   YNzhQtpfzzAVb9rj5ON8hDLuoyydoENF0ySF7YYphRv9z+3/S/UwpGudt
   Q==;
X-CSE-ConnectionGUID: 89YxmgFySSmiVgFRUBHUaw==
X-CSE-MsgGUID: czJtHnDQQna9c0I/fV2I1Q==
X-IronPort-AV: E=Sophos;i="6.07,240,1708358400"; 
   d="scan'208";a="14530823"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2024 03:38:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhK9WMwAaYsER/+jhR8Km6e3hNxTaswgwx2QfYtO1Htz4T27gVeNpMT/Gj4BHe3JY3zS3cAFAw/N7dZp7yJHtGnRJthRNvWWJQzAYukT1ONOhRNv5EBzxzvic/ThxSQQXhveP+dF8mkL0jjCQP02YthIZkQn4Lm/CS+tQf4aG5dhC0cTt8nh2cSMsLAJ6a7vOx3jTWHLjd6hlxCo+/oeVVQwtZhKglPB+ySkW88mfMxmIx3wPZxKs2eX4UqRqGqZboxZzi+Qm3bjNoGJEJqZnADdl0KW6Kq8fqT3cXvOweezYpS1eI3JDlh0DmMk7EBAxFHG8TjJ8xDxyuenR4Jimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdYjtBqcN58Z/P+GgQQP02q5XrW4mDJroixHppqT8zs=;
 b=TVPyuEmofOA823FESkx1GsY9rw5ed2aPgncWzInrc4D/N65lI57niMvc5MZrUFk8dUutK+btTGEGkPiPZMDAQ/w1NSnDVr61le+c6XlHVKEmEJhjhPRnkaApWlYKczwI643EKCaA16BxitW4Zaw1Jp3Amesjt7OkOP4SylsUQr7fejK1yttVvAdiBGfsI0HlFlgT9lm10Xr60OxcpkyDsffvXm0B5DLWjpXpInRX3bqWw4ONwHzqTTne37ckB+/xIvleFUXbA+F8dVhYNakc2UjN+OxvbzPkPLrrVmj4ht17GQD2lYkcLFk1z+GeRJrQA2vQusV4fBUCeicT477edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdYjtBqcN58Z/P+GgQQP02q5XrW4mDJroixHppqT8zs=;
 b=B/bqvxP6/GZjckSLAYktJnxCjQoAua7fuE+WvrBXRn3fQs3rV1TXA9VQhSgKksNunkuhSNgfxelA6rEoy2D5WdNaaSnSZwHwPx/T0HE9Bcq6pJRFu3YHXNE+7fsSEwCHWpYDdPFpXmXNOqn5cr1R5Ja4DlOwzy849DyPp0BZkNY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB6372.namprd04.prod.outlook.com (2603:10b6:408:dd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Mon, 29 Apr 2024 19:38:19 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7519.035; Mon, 29 Apr 2024
 19:38:19 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Felix Qin <xiaokeqinhealth@126.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] mmc: core: increase the timeout period of the
 ACMD41 command.
Thread-Topic: [PATCH v3 1/1] mmc: core: increase the timeout period of the
 ACMD41 command.
Thread-Index: AQHamgXOVIZ34SeCIESXB7n1JqxGDrF/pWJA
Date: Mon, 29 Apr 2024 19:38:18 +0000
Message-ID:
 <DM6PR04MB65756004397E9C84468EE5ADFC1B2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240429071955.163282-1-xiaokeqinhealth@126.com>
In-Reply-To: <20240429071955.163282-1-xiaokeqinhealth@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB6372:EE_
x-ms-office365-filtering-correlation-id: 780232dc-20ac-4315-5739-08dc6883ec0e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nqWycZ6u8fZacitzIMW7/V2NjaRFdFPRrfqWCXVTj4Qdy8DE5mJJEaZNEuKR?=
 =?us-ascii?Q?M0pAZ0mX0jUKD0s3K+TLRiEUiUIELAAqpE4TO8hCQ+5stY5bJHTpV0V1l2wp?=
 =?us-ascii?Q?M7zueo+LPt1nQj1NOWT/BJZQEoh3SIyIGHGUZWfFmd7AtYN7vvoBRhJ68mak?=
 =?us-ascii?Q?9/aDuBXOQZ5xXxCLzpwf5POVhPEg35BP1OyQTss9J7zifQUXxA9D3XX8FdtK?=
 =?us-ascii?Q?b8crOLZ0OH1k9KIif471itP6DppRbJ+pupJ1Q1x7+JayPooy6/a6dEmdIDJr?=
 =?us-ascii?Q?fW4pGXrBzHPfsUTqqberIL4iegk4hiWSy1QXfkCRFlZYjjGhNrElqrO9Oh6x?=
 =?us-ascii?Q?Vo8NwCacSilCE88P7Ws9HCHH+G0uVnnLAULsq8fQJ4K9bvQJity89C/eGvAG?=
 =?us-ascii?Q?6Ou7ITTvWFrvysgZhYeyhP4F0wyxUsH4m5udY2a6JdgN6LgXsSh/fB/1cBKn?=
 =?us-ascii?Q?vi4MC2ZAJ7A/U2RAOU9/242qe3fi1g7MTWMDtnu5SYWs2FrFa2ser9vnNnbY?=
 =?us-ascii?Q?QxYQ1O24Xk8FW84EmtFr/xlu9aonX9/G/yi7tltK+qWxFq93mNWduJNXBMHF?=
 =?us-ascii?Q?TgFY8MX43Dazm81HMw54d2lTFbKdK86IUbAuxhvLb7L+beXcND3jQljGrSzT?=
 =?us-ascii?Q?QvSoaxi+aXE3KD+WKxzWl21C0ZrLpkh4bez7psK3uwkmvu1oAvNxvtmQ3bue?=
 =?us-ascii?Q?bxY4qcJvHcO8LBwXhhZEdFt8ZAOyNcThoixOcSatjh+P0hWNb6m/8SgG5Rma?=
 =?us-ascii?Q?zta4LyqIQRm30QYfPdFZWD0cQl4SCZ/rsqH9+UnC7qphqJJjfAVm8+Ve0y+y?=
 =?us-ascii?Q?aThn18idWiBVvLxu4rw1ml39aBsRJhcuZxa1axfKrGQs6P9SGGN+kzWwzfF0?=
 =?us-ascii?Q?kGAmI5kqoU35+ryZ7lOJ6kJnnS7x8GaZBtsiQfMvOVhCswsY8ys6qRHwj+yF?=
 =?us-ascii?Q?RhNHgeEm0tqkGkz6EIBNBT0UGDSMKsg0V5Y5GFEKDiVB42AOwbAblqE0mwL0?=
 =?us-ascii?Q?nNn1VCv7r3/h8sN86ElI2nuc65HKUfEjeSM/uV2Px38uStxj+54/TIVVgcK+?=
 =?us-ascii?Q?OH7WPWiM/fKfREfUdePPWpTDtx+we6l2L7oc1f8TkaLC1puNvJaPNJ6ZcU4V?=
 =?us-ascii?Q?/KTFYt1rknwTAqs6X9m5gEmhyeA7JvYyDWYdbg8OV46SQG2q2zJWGnqyq/OI?=
 =?us-ascii?Q?IprMovGyNkwkkHXfSypUPBFUI9yRV0WRfswkpWM0duRz4vNjQ4qgQsV7Xu/k?=
 =?us-ascii?Q?tJQTMq80bsg+sOGPvca4N8iA4VsA13sW6xetLYyKG4vpu9IBivG6MirBg5H2?=
 =?us-ascii?Q?letpoykiCkjQok/m52zUQLXweH/ds6DYqIJZD34JjfXNKg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jyOaEGBHmmDcUhYCNYeuRNxN38kVOrH9GEVLhQKHJ2x/6x6nkEUm9x7+IfOo?=
 =?us-ascii?Q?ZR/AJQv+6eHM7UtEcNlhESZJbzyhb5SpM8VXQ9P/KXe59wwTv6+o0pZZ113s?=
 =?us-ascii?Q?GvJjh7w065Wg9YbgXLZJZ6uI3L66+zCNlCJRtl5RjTOao08A9FVu+Ko0JTHg?=
 =?us-ascii?Q?O232HGy1rGl3OEXP4gCcNIaNOC0zZu1rak5srt61zjrgwI2+a8+oWh2g1yeO?=
 =?us-ascii?Q?fOcm47ysVMfuIPU/HFjOnwEuOdfzDlnGk45aMpi5jJl2+rgWsXP0/lKHsYdF?=
 =?us-ascii?Q?+LNF6YMRf0IYmM/CGKZX3yYp6IqX8gHMTm3Kb6XGUcAiJBrwodO+jErypPOp?=
 =?us-ascii?Q?70/zb2zU3oKQd89PnbZ5KDircXeX3AxfU3EBfAWJXwgWBVQGkVb4LzZgsNbW?=
 =?us-ascii?Q?SbKTE10gN/adoJEqeFvlhSyK8gTEnCoDmPjxSSZ0C9CyOpdd6LIOH1I1DycD?=
 =?us-ascii?Q?NVjECbMs6c2tNBJeAJYzKikclE76qRj3lwRYmRb51I7D3z8caSXior6JGVRV?=
 =?us-ascii?Q?dWqp+3kKybOPgzZZUmEq5zRtyspRr2IXnDvTvRZeUp740pNihbkzbPSE6tw/?=
 =?us-ascii?Q?/u98zdkH97tEgQsF4a+AEquK+5pQM7IOSzAbHsS4H7+KeQUj8tDNvvJy1C52?=
 =?us-ascii?Q?sMeokV7ipLym3t9fPHyb1V4c9PaXB5WRkj+rfdSKixtlqzi3c8W3I5jqmy3B?=
 =?us-ascii?Q?eBg7RIYxJzvzhknXzRXXVmYU3AxOgs2xje/4T3iEtDuIj7b06t/i3b8KdLqd?=
 =?us-ascii?Q?1Cnsuab9wplLypfmZuHzwu9hYfKl780INPMX9CMSildWNphim0JPPON3EaDO?=
 =?us-ascii?Q?wWcfd8uNVJDhN3vddFPe8uud2hPyV9Y7vprdOP4dnNi6FCW+ZmuC9ktl3UWh?=
 =?us-ascii?Q?kJ+6H7AoEMvDHzna5zpdZgHXkunVY0Ozlxc2vup/+/D+3nm3uuCJVrxfOVi+?=
 =?us-ascii?Q?2I49Nn+JfenBA3pGM/P+GymJCGP3JKN6DcGuSkH1jw3rrdTUPE8i1uCCtJZX?=
 =?us-ascii?Q?7SwHNgErZH9yByqIyOcl2E4JQePkPw21ng+vwWpOMtnyS7Hwt5BTRBM1KibF?=
 =?us-ascii?Q?LjPV3GHEkmqZa1O+80/cu/iWo30R11W6ksjD/8pqUJhI0ZF9gU0cwvMcZ3so?=
 =?us-ascii?Q?UiCogxdVWYaewKhfZSTmNdDo2ihy9N1qRS8KbYvpyE1y5aTB7wIBqAxmsppF?=
 =?us-ascii?Q?mDGzc2rbQSzXWx5PikpwfLxOQlRdysCFnFzMPhoGLeUmqcJUvNvUUpWnnLeM?=
 =?us-ascii?Q?RJ80qcSOx6WDVh2XKbRh9z8aWcgiIuvfAd+5bU8UjuRmnnY4CpHWri0azqyv?=
 =?us-ascii?Q?OwqdnlJD9EO1LxUwfYrzdJ7WcgVOvHEMXrZVMOc/T5TNIj1MuT8N2qVHmf5e?=
 =?us-ascii?Q?ybH1WYhIqeotOeV8i/VCmaurUx77YFwVnWV7CpDpVFndO+GNKP3jaYnrN7lu?=
 =?us-ascii?Q?SAdA3DnjBOsw1X/0tPY9lrYAgLEsrbc3fjolq1wYb5w/TeByjWKy7yDYU5Gr?=
 =?us-ascii?Q?xMH7A4l9PDHUhC4Kol3y6cuRgm3mVwlE5pwkp6d2LrUO16ICLTb3KoG6WVoJ?=
 =?us-ascii?Q?UV8rVP2BAINrnhxokQ8ompu2Fez4Je05LTxHpe5N?=
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
	axN+CmRfY5W+aBUxOiRd2CzoUs62dMWuQyS8d3EETfvphD71mWVUtVvfqIC1/eeG3WjHqlzt77ZserT7Tu3RnaZPZfKq5XAxedLwqesa/NGA9V/R0hVwCAeHilhfuXmq5PVATX9sn7A7blJv5ZScjOU5/UmWXPIVUcOsfMiH1jS0czpEqu6g7DrXmTrqsVCFjlKr0oO1j0Va6mzCyhr2ZijmzV44EPfwN/5ugYyBGZXNOzY+XqD+xMwBjz6hWLgYhwrbeaBdyT+Hf9UcGrU3j18nnBuhccvpbxLgMs9bkkBhA5KMhSU2+1SJtgQzIkLJKPsAOHf6d8ffZJNvRgF7fOehsx5rUHSg7bhgj+Do3IvuUmxKRt0ymaHLmvbekEqANwpH4ShnQ5nYZubfQYuKL92jj3P+Q8+iBL09LgfcRbTxXgal9vecqqKXzHiuKa7tmIeGnIbLxu0OayBmaICwRWlG5raWZdu/rYlJTL7o47nFO60szplTtu0qHCuol6vosQcxzQS0HbNRDVaKrkkVzbIY96KYp+CNTe9Clpb2KlAQDRb1ZqzkRv1DntM/rs+nr/1PI1CELkVQSB3kLJhrKShda8tjHI7c+9Ei4eNXQQHWFwmuqeBUKcXWhep9QBsO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780232dc-20ac-4315-5739-08dc6883ec0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 19:38:18.9625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQgHRDeyEwtNwmrBdyTYVUj47omQIk3o7SOQDG0umydk3O+afKPuvUITaVQkA6jy1vrdifjKXBHkUAEtwWr6MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6372

> Extensive testing has shown that some specific SD cards require an increa=
sed
> command timeout to be successfully initialized.
>=20
> More info:
> Platform: Rockchip SoC + DW Multimedia host Controller SD card: Xvv micro=
SD
> CMH34A17TMA12 (Made in Korea)
> Note: The SD card is custom-made by the customer in collaboration with th=
e
> wafer foundry.
>=20
> Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>
Acked-by: Avri Altman <avri.altman@wdc.com>

