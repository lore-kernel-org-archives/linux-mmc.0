Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653D14A092
	for <linux-mmc@vger.kernel.org>; Mon, 14 Oct 2024 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892303; cv=fail; b=VQ7liy7OHSZnXYvqvWJ2xJNUCdUsmWZ43B12ccPMZsuCd9YP6b7Oaa6roOPY4l15QvDG3aeRp2w7yLEaHYK3DikOuiTX+ZxbBmWCXxy3f+gzj8M4Uffzp3VZXuymeJnVNVX+dYeRsaaJDPEEehvHtqR5BQkqOyWIV6s45jQ+Qts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892303; c=relaxed/simple;
	bh=qSar1sstBGxrrkWxk6iC+Mjg+LTLTQYvTr49l/po8F4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uv4f7AxBVrM4La73UqZhkqB7mx2ODDtxMUbpMPVs+pKhjVdyT1TbuDxOYk/csq6v8nFiStiiwDtqITClsX7Nl1UcT4dSATgUmzf61z5fAf76vaGHZUUThJpyYak9HHvN0XDLFXv0+b55CxmVE+U3SGixQgrRCNrMzk4hJclZoX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iPJGYCY7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RfTSav0H; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iPJGYCY7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RfTSav0H"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728892301; x=1760428301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qSar1sstBGxrrkWxk6iC+Mjg+LTLTQYvTr49l/po8F4=;
  b=iPJGYCY7cL6BE2n9/0FazVE6gk+NrmgoA6NSb7C7z3Pl2XP17DrEY/gT
   M6zdkqFZuXUW1reYZj5ZLDo2UEvCX9l0c+TsEsm5ei+YrKn94juCIT/n3
   EsSMASgsrygT6Lt6wkwFJtW2nDcNM8dGyRjcriVS75bm+nLxQ/B9Z45EP
   fGVvpDmz0yllkv4XupSRKFCAzfgbvT8LpjbDi73fWEYldMiRwv67hY+kU
   S5AH6lsUV2gcZBE1E3mNTRIMarg4BCMlGu4sm3dT1tjEUr3PyUAOwjvxD
   bLasKC5Ax1PDoZRit4A6Heo1vIjDC1jv289aDW+eJWjZMwsAXMTUPAqeA
   Q==;
X-CSE-ConnectionGUID: aqZH3LhVSmy1my9XFS/pqA==
X-CSE-MsgGUID: 3KUbaimXRqKQnDgEAzM4Bw==
X-IronPort-AV: E=Sophos;i="6.11,202,1725292800"; 
   d="scan'208";a="29826910"
Received: from mail-centralusazlp17010005.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.5])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2024 15:51:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPYNsSVk/JXVkt5cWhXLkieV4CkxtxdGWVZoS53+ndTk8G4lF0I82Qb5E4q1zAhVsGaErea3be6mcKhYNy0jTRpp9wKhCuQWpY34yaxokWv91RJqvg3Xxd6+vw0rNPzG0us5tD69ufOrEXFi0vNafImqg+4EunsmY9QyLRQfCDdl65PLyBTLXAAJxFox8a5OflGEpds/CBHnXyFkCwFxDqIfhvZqteWdPL53bDlUuFzITVZR5iB650TwAJQmKgJCW3gonGxsAKZDJpUrZ6AjK+9V17hqQbPt9AHyqEgtRBTZlXFB6wQEwHl7/FF/Yz1zQwriGM+aMjG7dbnabiA62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZL1xTYic70A+VdwxLrgQMyz4ODpCSBZuYK3BzvNUv4=;
 b=u20qEYUlPGL8yVFyI5pOx5SOE9OXej7ImJMVU502vVsNlTplHStCx5nCmOzmDZMlvXBollYpifxqhlJxfjoE4pXRG7UgQ10bwTL6UZxMlYrc5nEeDuvAZBuih9EyQYPhW3UpZEnFtTddSRAh9GtlVIbuz1773qIKc6xkPDYFrHtzw5VgjAB2JXOWZUMf8+g7+MeST21FO/0+HBVo0xqgZ2THvRSXK5LhCTWZb5rEW6h/w0Yj0ftie4daDzk5Ad1gLrf08Tie64YNND+tFVyHg4yGzP5btwFvGpAHCfPdNUJ1RojMGJSnXg0Wps6xlYtX7u5MhzCOlkq0okJIpUrhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZL1xTYic70A+VdwxLrgQMyz4ODpCSBZuYK3BzvNUv4=;
 b=RfTSav0Ht59pbteldLUTjjweHPWnE3P86EaRmi4fJiKbmNIB6h1PmikJjDI26ZxBijpv1/CgjszQP0UPNAHSS3fyUg9D5HA/xL79DYXlokb0Cemry3REF1AkWiTAzkXy4bIESwN6gHco4KMxoPYr26AWQCk/lcJmZMCBjB+1CL8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6279.namprd04.prod.outlook.com (2603:10b6:a03:1f2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Mon, 14 Oct 2024 07:51:37 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:51:37 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Bean Huo <beanhuo@micron.com>
Subject: RE: [RESENT PATCH v3 2/5] mmc-utils: Add FFU mode 2
Thread-Topic: [RESENT PATCH v3 2/5] mmc-utils: Add FFU mode 2
Thread-Index: AQHbHbRABQVe0P0iN02JdBh4Xm0Nz7KF270Q
Date: Mon, 14 Oct 2024 07:51:36 +0000
Message-ID:
 <DM6PR04MB6575F0A20CE5C2038610038EFC442@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241013210925.123632-1-beanhuo@iokpp.de>
 <20241013210925.123632-3-beanhuo@iokpp.de>
In-Reply-To: <20241013210925.123632-3-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB6279:EE_
x-ms-office365-filtering-correlation-id: 8b673db7-a17b-476a-8b4e-08dcec2507d5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sX7w9phOtOpKDgfbvryCbCgaB7qJq353smO4ZkomlzUtFBnI/WE4dQPW2UT3?=
 =?us-ascii?Q?b7x8BLGighDCGSfZ5QxUW7NAHr6kkpRA0i1RrBBIhhNxQVw2+rbfR+A2CPFz?=
 =?us-ascii?Q?G8DmWmwE0u67yR5LNLiaZM5hTLGfBy7fdloCE7hqF939ZMrWtx0lIjxT0nky?=
 =?us-ascii?Q?MXk5qNnAgpAoBmnRf24SOBcjJ9XhjuneXnjd+oP0LgS0I+XlV9iYE5L8bRVz?=
 =?us-ascii?Q?60SWT1RVsElLmjGUNoOoo8o75haw2MHt634iZihds39sbRFFC5acUBMilcLc?=
 =?us-ascii?Q?pSyaRfXkSrkZzCnN3JUdau9ObsM+HqUe+kEjULMhYlJ8+C/LFGEB5SvClgvA?=
 =?us-ascii?Q?WCVej6t3aPimFzSY3V8JWX4qByvgMZFs4LfUdFGYXpHA+cKpPtSDTbbVzy/w?=
 =?us-ascii?Q?oVBdcHjCoWz6yImIezo9/gACaGFzs+CymkWsEN2eVvOJUVkGYHR8Eb/ImKG5?=
 =?us-ascii?Q?BtJvugqYvbVlqBxjvNmLLktH3fyv8l/WKmFVm1zUwOCqLqEXt3u3MmsIljdA?=
 =?us-ascii?Q?s7Wc7K9yRAjRNUsc3j3aD3gnDC1EiTOYTO3MzFmCq351PSB24nVlDAvsx/id?=
 =?us-ascii?Q?aD+TYgANi6QtfyjFeLacCGaTsIBxok3r+PEfGZc8JgK3khFr+n4oX3HvtuKJ?=
 =?us-ascii?Q?Ons48OlYreKgY8t9o4foHI3dIgsPazKjYWHvupgdKabkXfCZxoBBT7PdDhZE?=
 =?us-ascii?Q?cimFlaiRsa6stl67VhusMPU/eaGzQAAKFrujGxDqJ6KQ58NptK//BU5TzGC9?=
 =?us-ascii?Q?jNiWq5dqr/UtYgY8dEH7RktrBn6r3NAWR4o3TaDdVV+pvc5IvWrAavb1mybg?=
 =?us-ascii?Q?iCh1TmKvcgG7KQzNce6nwDSqBYoO7n3AbmUdPddfFVIqJhZhzCV24cX+jcsc?=
 =?us-ascii?Q?DA6tjeOy4EqJwQa4AxoZoZnZvZaA9QFNGNKiB/sDOX71ATbFoCvJizJW4DYP?=
 =?us-ascii?Q?IrpXiqcP3UBtSuhCnK18HQKcTwVGg9Q0WtFgcW63AFZMwCtDaGUH7XydYa34?=
 =?us-ascii?Q?CvyCG1mY+R4irdhyYxgpZHLORprqiJobVbys8tuRFWY6oZHlb0pi2ZILkil8?=
 =?us-ascii?Q?51PjKadkogNZf4QoU+UAKrInulnJaZZCYSyguHASepS3DhDuVVypL5ACGXMl?=
 =?us-ascii?Q?DZaNagnrOSqSJ8BXFHgOg+vXggA7GRbb+RWb1IYQCF0MAM7xGZNHTSrP8PgN?=
 =?us-ascii?Q?PxfJk3EjVS0863i4QpNBQM0YGSIktPrdLH727ACaKJWK4UeTvpExfD8ZZS8d?=
 =?us-ascii?Q?naR9IyGynxv+4MGUa2FyQIwIixSbW6GlUdKOdH6sICm0TsYycFoigjDGwx/t?=
 =?us-ascii?Q?46LDvgiYx1uLe+r7jjAjS50ipAjbW6Yk+XFc3Kb0cFXaYA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1ezgKeC9Y+/4N1n/9DMaKTeVyub5jOz43BcqOuGw7VgjOlg9yJjREdDOm2Oe?=
 =?us-ascii?Q?Ncvc/84UQmKkrqPsx3bNSj4xAKOpdUb6INniJu3OTxScyGkRjPYOTGi8jSAX?=
 =?us-ascii?Q?vXH5tvTd80H2txWRGo0J+LZdfIte5SWEHfvmQWjVs68ORg5lVcPEYWGGkxdm?=
 =?us-ascii?Q?TWktaxeiHxyo1NHS+mXytmV2GzkN/W0SnPFpWEahjIrqDW+wOTWs2V8OB+V4?=
 =?us-ascii?Q?MfaE75FX0mtOJP6V5DrynYe+f1I/OB+gVQmPY7QfHPeQl7EaiyJsOZuy7UGW?=
 =?us-ascii?Q?5YVe2l+hkkvhp5lCPpl2QsVHnh5lwCdnaBadC1CEclwSu4fhACCI7lqNn0ye?=
 =?us-ascii?Q?87FYrfeZCaApyYUHOEZ37G6DlVN1J9l1dnWpNAjRn5Oury5TnPLmgoFZjdqe?=
 =?us-ascii?Q?Wq42P3FC8c1Le8bdEcefzUEBO0k+q9qNRWBP1rWAeZBw5ScnUbeCPVp8OWET?=
 =?us-ascii?Q?9jJW5QVP91MVLDqrAgMc1Blima+APMOCSjvl4BfjhhQsnwV68CQEEjNG7pOc?=
 =?us-ascii?Q?BOlckeOyi/6ALIeXH649LikTJ2Nml+NtMs7mT7HQiP8T3V+upVI2BfNGUv7L?=
 =?us-ascii?Q?WYS/2noRAG3Ao+cEoaRI0BEY8tl8M0C4BNJuoYXLTPpfgzGXExTpobopa1Ep?=
 =?us-ascii?Q?x3rp9DuhlJ1CrO1NpWxMmIltlmRO8ZZGHN1itZfQTpZKcyG2sn5w+jzEEKzG?=
 =?us-ascii?Q?lW42K8jhMdoTJdBIC+NAmgm2cOhdc93kzUmqV8QQQc4pGlbwZXwGcc5tjf9M?=
 =?us-ascii?Q?y1Zbrd4bvXx9ltSxVrlDw9dYJcJJMKU3xl6tpMjmame+b2pv4j9+rvD4vv2r?=
 =?us-ascii?Q?7B4XkZg78iMvPl/3YYFvuKZbOZ568U+C20ikUYM2GuzRVtXuLVsOgjRzNLbV?=
 =?us-ascii?Q?kQkkXwV0T2vKKtBP6ZQnNTPyx+6Gast1fpGONUxD9yidw76blTLxDwrW1MiK?=
 =?us-ascii?Q?rjZGBXhEFkntFWzWzmqp+CWubhZEVF8Lo6xwU+gRisnEcSJgKrNbBqve6Xx/?=
 =?us-ascii?Q?F5iLIfXv2FqcWtg+wGNmvQ3VR+q1ljj8w47djOTu6agKgoEHOV3bhNVB2eQn?=
 =?us-ascii?Q?V5JVe9plrfNYwmdmAmtskeThbZHK7WcKl5ADlGk+hcqB6r0KeNx/xLpB4eEw?=
 =?us-ascii?Q?oKZiNZP2bSN3GkEjPvfIAZiXcJKbTZ33Mda42p7UQ3v9cKDDsVtjgAqoApAF?=
 =?us-ascii?Q?DODxL71CacpnS9np3i0+DuHkfTVMxb8dvL7EkQ1xY5ycuvvyxN28z+3JOc2w?=
 =?us-ascii?Q?PIIS0piZHPIJCMHYR0FlaKq/A8Oexy544xfYfKMDo1Kcyj9HvFBhB3K3DyBe?=
 =?us-ascii?Q?SzLhVbLot5P/KJVzbH0lrMMOok0d8eQaSOuzqff99i4Wo5glQBktYiL6y8bt?=
 =?us-ascii?Q?Klh/ep7djlIXhX+9StH6325wKJ/SZJcvUCFxz0xZqjyJyhK/zSKOFWb0eDCC?=
 =?us-ascii?Q?OHu1gUMJgGAlcrdENb3zGYfsFPx8omd2DcIA/7A26zJIgI6GFHyPnKfoa6P/?=
 =?us-ascii?Q?J/MUcbErxblC3tSGyQydXRxYyxHC6Hn+24Bp4UZXdj77d+0CwWmctptaKU29?=
 =?us-ascii?Q?5+0TDhrMR6Ix+U6m2YqnaZtZ61W7tdZk9faiyU29?=
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
	2XEiGseq3r2vSsc+9iq+3/nMNwT3Da7gV4xCEEQTXK44WPD18/PsbO7EH9cCh++2UWuL4lfN6BzfIVBfypQ0szky6ec2UzDx5Agl9p2wleCiR7NDgVeWRJD+XX4McpQakV7XBOQaXfh+TfOgzHBTpRIWfNOw7ppOBdNhN+4Jv2rIbqJdtGIpmevNHYm5CMMCnbwvytp5Y5UcYJVT4CDHuOhbHW6Y/qdVjXHzGYLM3dq3lvpm3p1UfFiYiKXnuHMJeasF3UX+UP+Y9Rw8WjEfQfUH5FdFnOAYzKuDRkyDcj9ebKFmKt4NwuExv9HLxWLsXY8Jvh0R7K4kn3mRX2A6wKVnpviun7fovcXBpLwcOrk0coX+CooYffXPDqz/BKuRA58lR29MLFW2KJWD3+k8qGLhKgpvxVyj63PwZ3BoOIB0gEUj9g6ToxWI8ttMFLJwmroRXbRkRdNHT/qUqkmcMyesYwWQN9mFRuvqfYNdQaXtzHIHcKf4j2xG+DGm7kFZmbuOwLrADCkskhV8dZngpdGGS6+VQVz75HSCQI9d/2qEJ3voKptLozv9Mfz8NkkyTM7aE1HO14/dAcQlofbX303OM7B0rsJw/4sWgEhaFttaenAYGEn49mByeGvhhNi2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b673db7-a17b-476a-8b4e-08dcec2507d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 07:51:36.8939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qa8nzkhubJ0/BAi/ST1qN/PSmYZbtP8TNniTE2z96IC9z9u/nEVjRLcRaf7CbcpJuHWIbWBV/JRexLuBj6PJkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6279

> +static int enter_ffu_mode(int *dev_fd)
> +{
> +       int ret;
> +       struct mmc_ioc_cmd cmd;
> +       memset(&cmd, 0, sizeof(cmd));
>=20
> -       /*
> -        * send image chunk: blksz and blocks essentially do not matter, =
as
> -        * long as the product is fw_size, but some hosts don't handle la=
rger
> -        * blksz well.
> -        */
> -       set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK,
> 1, bytes / 512, arg);
> -       mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
> +       fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
> +       ret =3D ioctl(*dev_fd, MMC_IOC_CMD, &cmd);
> +       if (ret)
> +               perror("enter FFU mode faled\n");
> +
> +       return ret;
> +}
Thinking aloud if we need the enter phase at all, because:
1) The first cmd6 is always part of the sequence, and
2) is it even safe to send it as a single ioctl?

I guess the answer to 2) is yes, and having a start phase actually make sen=
se:
it makes clearer of what the ffu process comprised of:
Start (enter ffu mode), repeat...., finish up.

I would even add a comment in the code (and in the commit log) for all mode=
s other than 1,
emphasizing that from this point onward, the device is blocked in ffu mode.

Thanks,
Avri


