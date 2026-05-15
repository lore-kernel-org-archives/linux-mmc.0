Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862443002A9
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857544; cv=fail; b=LLaZUKgUHw86X0poYgePQLdaLXRoaP9Lv1jls/LsBTUXYuD7dPxFp70f2tHY6nZrfvV9QX+ywANMdIgG8XdQTsm6dF161bopTIqcgRvhE1jiMBUzZ9QMTVR9LhBwrWCV3Btgh/cPlBO2J25+K5Wj+h4GGxEojxhp6Vhnok2BtWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857544; c=relaxed/simple;
	bh=gVCWsnDNawlwI0INYq48Y1gS1NRu0R31Sx9etG6l94c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F4YfCUSj9ak3Tjgay64l6b9zpg+pOmyWhsH9NKt5KwEwYXUyu978XX/JWGyIneR654GgM1F9eTGPIUPjXnnjrHt8eXpKnez3irWJV2gcjUtSuTF4J0dRePtgvbs+MlTumqZHfXlNPFMMbWBTdLQuAlDEEGrLopDQv2fFygNmxqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=wonf2ARI; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="wonf2ARI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778857542; x=1810393542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gVCWsnDNawlwI0INYq48Y1gS1NRu0R31Sx9etG6l94c=;
  b=wonf2ARII3xteYfAnGpZmffS1+XJAXXRwImhNyGRY3LLHIqV3YuWkt5B
   HKbfa5Jhlnt50/Z6EAmuqLoBQBLhGckQKIKqHbvgcGh1OMI8+MgA6fju6
   fDhzke+aI7xoVwHBBIZyQAzwcUWZdJI6KEOCgc7MhQcfSd7cOLtcVqMbM
   vrbnW+ONt1wPDlvF1yUOKe27R28jWJ/BjF16LE5cBer9IFh9fBX8Q4p/H
   zpvTnz9QQjpiU+b10s/VpBEngjkfJC9C9th/z0jZt9bEI1hdzz+9/iQWE
   Pl9CZ6RQGA1/dfr2k8gGAkZbHcft0SClN+q8CDQBlhC/TddotTYfoQ+MK
   w==;
X-CSE-ConnectionGUID: 6NPfEJ5NRaqSdRC8L5Latw==
X-CSE-MsgGUID: VT6Wo0aFShmpDvs2xXyS3A==
X-IronPort-RemoteIP: 52.101.201.18
X-IronPort-MID: 22591839
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westus3azon11010018.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.18])
  by ob1.hc6817-7.iphmx.com with ESMTP; 15 May 2026 08:05:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtYw3+qbId1KKY71vLqekkNs9MrDIuLNzaWNzEX3d0v0IB0EoHS6c9us8FoyzcaGcdHQcftt8tfdOjbB225Op5QNOXLMdygCyFo0gYxxjknH0vYowXn/I+FEbF/zyoNOgsV1HNr+mjLJySUQYd0d6IWm8jqiEfUyPB2EUVS4k8aA6VfdywObZXqjnERiMTdyuH/2pHSkYVO0rwPLewvJk0dXdU9xwYz3lHlTxksJC8OlaDXG3mfFaPzk1LpYlFadAfBxSIhyQIzBwDR8nZwmiAqBjftMlnbDS14xjond6gFScN3STC6DlLvgtcuhzO0ojU32AbSUP4RDWfLeFFJB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLHI/FrWxTda9GcY7WeyyaukzUc9+HpOF+FfTQek7Mo=;
 b=EIxG9CbbyFXwYioQloYruB/j1G9QV1RKh6UXihXvlPMXgSkDQM7EFUwswSQYQ3P3K7DOm8CL5UZ3lhUwBq1ODG8kL0y9Ln5YZlRkkWll+g9YeMEMk7Z864GsalhoSv06LPAVLT/n7cVP0SN833d/q1Bl2n5cKGRQK7/47iBYuZf/88A/9FQfLdNtcDLizwzLsCHHlisWZE/y5IeAfg8TgK3ndk36fekRtywYjPpAKglvK+/p2xcH+5I54SQmi1fkxCCXxdga4ND400+5NWRyPPjibdfs8iqc5O8zaxGnq+GqMu5e4yn3QNlT15ogHPejr6pDGroAGfSkEUkqncb0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 CYYPR16MB5489.namprd16.prod.outlook.com (2603:10b6:930:bb::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.19; Fri, 15 May 2026 15:05:38 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 15:05:36 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH 1/4] mmc-utils: lsmmc: Use external .ids files for
 manufacturer lookup
Thread-Topic: [PATCH 1/4] mmc-utils: lsmmc: Use external .ids files for
 manufacturer lookup
Thread-Index: AQHc5EYx9n44ArWoB0qoWqDN2GLj27YPJg3g
Date: Fri, 15 May 2026 15:05:36 +0000
Message-ID:
 <DS1PR16MB675328EBEAC3FDCB8DCA599EE5042@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
 <20260515083457.3690804-2-torsteine+linux@gmail.com>
In-Reply-To: <20260515083457.3690804-2-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|CYYPR16MB5489:EE_
x-ms-office365-filtering-correlation-id: 4d46af04-45e8-4854-dcd7-08deb2936b77
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|38070700021|13003099007|4143699003|3023799003|11063799003|22082099003|17002099007|56012099003|18002099003|3613699012;
x-microsoft-antispam-message-info:
 kh8YppA7yMOD6PrcA4xlZcMwGf2cBImWaVV+Wgj+2yBkq8YJaUhLYZkwgx1y1E3SslRDiNs++p6maNeYpoKmVr7+9vk1Z5oJUbt2IOCyExINkQOVqBoniEopuV3obHbtu6GTVgdmrcYCDz9o26K13j9phijH4hXG60P9OqKU0gLX7L0uZbqNPminr45z/QTAtDCav7lnVJ0qhO5TKqHwBxGCmEb5cjs4bSkp8GX+NUMR4GHKgPdKTsIq/RIGpaJ4uP1QGqQtrSAoQ9H6z/I4tPtkKQ/tguUr5qJ0aingk4K+T7+vjBHyN8htHB7Qok/6Z6ws8Dl5rqYiVcDHy7fZMvexOVxaFinLSMxsi8RQNatYX7UytA7dgb/QSOMpeV5E0WDI9edl8fA2itCWiKNCQ0GVHULU/Ay1hAzOy5IdyrM4lV97HkcPU3EO1Q577Zehmv3762lmmeQGo0Z+wZLe9FqJWmCNL12JlwTVTkiO8gQigE6hDTgowENyFJUPPT/ZFB5C+UMdTiohCsBMh9jvoRVasKEGmZ1RRX4n5OMBSF8uOchhWYTOBDzzolhi9/zLEE8f1Npi2nUx4l3SEI76OPLb7mg3GcZEh5rvLIJj872tyeFNfqQpgOjycSKqRh6KlnSoSSVFqVvw+sr2m2pW443tbDtfrd8657mL2saO+dUQ7lPmGlQCaIw8YlhaynvhjO6UreV3+SqYaOt/6K9N4ACrjlzToWEtIAWfbqU56jMM5Bs5pzSzFIhRUXRjHF3fcEQ7uUR88yRzuSWvD8GeherhtZBmTBpqnR4jO1lP+gc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(38070700021)(13003099007)(4143699003)(3023799003)(11063799003)(22082099003)(17002099007)(56012099003)(18002099003)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1IOi7AAuJAuhgVyuFxHeQrdKYIl9E4C5pmTrrA7cYjfbvGRiL8XF+6j6/gKh?=
 =?us-ascii?Q?sjIMYu+cKvbmeY1NuplUx3VesdS4b579/LC/rtlLxgYqeJEls3e1yEsaIpfC?=
 =?us-ascii?Q?cLmYrCPoJnawCrhisJRJX79yXHVkCh/jRib0CQve4ppU7J/QkYoEB/0Yoa4Z?=
 =?us-ascii?Q?R9hYn5rhigQ6dbvHZlW9igGYySvHd5iRm3q7GCgLrzVP248VZuko3lc1TiWD?=
 =?us-ascii?Q?CWhyqkW5gWG4/FwPMXeQzb7u2wM3I30qjKDp4LEh2xIEcv5XG3c+fmlmRJyw?=
 =?us-ascii?Q?fHN2nFwbGASKM7f33rmsXm2CW1ldtn1NKQBEQVB94xqHKQmDidVbTnQIB6MO?=
 =?us-ascii?Q?Q0JAGzqMs4VyVqtlxatcLx9y2kJHIKRZX+egna4qro+V7RdrxsPOwDcjnj0J?=
 =?us-ascii?Q?x1Q8a2JFbzTkEbh2vsIS6toNIeogDMKyiMaoLYYlUg0NkC4aLJNDUtMcN23E?=
 =?us-ascii?Q?jd3OHmZjg7ZxaUUHuxYv4xnyDJaXbISNfy8MLbDmf2y6aue6Ij1UtewgidzS?=
 =?us-ascii?Q?EhB1tn75h71VFQSlLeFGN/YEbpJblo2yu0eyEpQ2HsM4kdy5Y4B0yNuBkEHn?=
 =?us-ascii?Q?7kLjDfR/+xE8wYEmhdF+pGK+S9wsYsn4wSZC2s9sU/J3ndeO+NVJUkGHt9sV?=
 =?us-ascii?Q?pQIJwF+O3dCwAQUkTlfogFHaQRLRh3rXTU5lfkHt/UI1hZ+jYORNp7yx8ttM?=
 =?us-ascii?Q?+bZ+osCLX//ksXu+ZOQaLJgHNsrQQyhuPY3M9d9xZGoO9NPE324Ae/rYDytY?=
 =?us-ascii?Q?K0RYc05GOYHKRpZomc5QfUHmia8DQJhmg3ioYhpFtdqCStxpFCJYn21iOZKM?=
 =?us-ascii?Q?J8lh15M41QL8yT7xNZzDLpCO5Muq9MwijCytbU6SM9b8VzOGVCIDdFeyrnOQ?=
 =?us-ascii?Q?o99ckxfNUg3nLFuf2RiBYNqEVE/FphG4/o8KrgvIHSFZLGSvSugTSiFWdAtu?=
 =?us-ascii?Q?70uaxqgyNMm71PTCTroN6C6A/8ZvJuXfiZL1TNLA3LwA97yhjxYAmjVwKkq7?=
 =?us-ascii?Q?S0Nk3QVz9lVCvmviykS+Udtn4efS8Byi60XZZAbob+jOHj0h8d9kIBEz60fr?=
 =?us-ascii?Q?7bIwVgMLfYkhp9DXYU2cP3FkNv/6TLE/J1A3o18nsje7hl781zkHNu+bU6Sv?=
 =?us-ascii?Q?hwn/CfO7No9te7Dt3/vtTBZvqjbqm5a9ISTuWWA/6nEUKrKEv29F9oeZpmMn?=
 =?us-ascii?Q?p/NWCmDAJlrp2D1fDkDcrEuMKyFwdxwcQj8WuVhRkLqA1EqBE8fnpggIKX8P?=
 =?us-ascii?Q?rcD/W33FCoQlWCfvGbjEI9gw9S8ap5s50lLKb190aKVnGIZp4VjFF7S4c9Sh?=
 =?us-ascii?Q?BatuGKN/T65oJ+fdhO51UkEP2OvaGYT2awwxPV9f+Fw+oKRRF5cyfjBQ9+bo?=
 =?us-ascii?Q?0vF8v4uIRrmYEMtpy6F42jvf0WuoS8N9C4FxyjO1Xaz8JvBK+SlNVhL+fL1s?=
 =?us-ascii?Q?ErdD+iDczHmvGKfslM9B6bNQ27zP9OsRYEqtdPvYR9SdqA52kouHvfuwvhQV?=
 =?us-ascii?Q?mNwiRTATMiDejRwtRLLGpoL6qh20QyjHXPTrNXakRoYxmv+0hHvGCmg8nSy7?=
 =?us-ascii?Q?xdNs2Qa5WKqUIZyumxBxHRrQri1kA3OwuEJcwevpw2uolCBSRFyrq1mp64lK?=
 =?us-ascii?Q?bNtNhU8z4r0PbIbRA2Yw796Cp4hQBeexP5XXOI71BSdMHc+VZYR17hfUgZck?=
 =?us-ascii?Q?uPoPcsXFiICG+RWXJ4bON3zdsN3lUd9qoAFTcHt2PaT3+CoYzANPDS4saHLf?=
 =?us-ascii?Q?5MFZyTuogg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	AOAFC40u6LGFIyjWGiEo5BoTTjaLyaGBNIZ2UlAJsoCWQPQy42dzpMXpuJlEZYXmZDDqHL6IvmxRWJyYHjp1yiQFA5WgdchuVmvS2MgtFjc6x7ORC93n+M7CXQegkXNdceaOVBJROs3kxY1vX4s7xhLx0q9P142mlhmSwpbkFJeQDh+8wzTAB3G+FPaBM5XmA7W8zIlScZaSjOWLclS5ZcO2K8sdeuOEOEz1bkvMEFX9r88e/2aLpzFX+65//XoLAXftZF4jddUcXG+GHvAg106zLNkmrB4c3wZy7W6xo5y3mraFVxbvbwyr6xqtSsbXyMYBtUqBarGcCGLY3Z24cA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fajy1hYdkB2lK9neO6Lgs1w/ITZ1aksBDGmd4ciGrUpxgP4ykOZcjjMUlDlAQEKwBNy9xGn8JRDCw9pmnZPexWEzjmKxZzpAMxMlcaUHjvdQICcbLWwmU6689ACfoY/TncES6ziDKbkamaY1TEF4hJX4NJ5tkC9wWYkXScbvAA24UE2805nyXWIVffma8GPkoVTzYpCfsUuvslG53TtEP0Hh+ZG7kh7kfrDgJvI8HdvaUHJ9DCHjtRj9akr5HvCRAvgLcTFB/XIUdI9AL/MQLe7HdJvw29Dz4sT+9rjEA9PcjSvyV0Vv+/asjllggned1IvaD9kwbtLsbUBQDtJJxHLXQ0zX9WMDgpafAV4tFmMnWwnB20N1dMBCUQbFOMU+6DScaSIl5XZbQwYuYmUpo8jjspzBW/+zasm4dOxJ4FukkrwwJSFWmSQ0GdLnTik8SL4fcx1MusmhhJS07QpxWOtD8wVfOSpoAOEr5q8Cmx6fZX+w3ub4HlkfdnN4aH5AI5Z+6S77arjlI5nFvsd3avun33Wc6O/2+d8ijbO20t2AR/dYvc7cjEul8ME5cMItghiZVnaOuhEqr29gZ8Dd9W9PW/Sca7Ql2on7SiLoARsNyBBg7FAG+P6iNFc0Thu2QRmfhItMbj9CTjayqDvmmw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d46af04-45e8-4854-dcd7-08deb2936b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 15:05:36.5526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbRlWX4nO2LBzlAhAIyZbQiR1kPIwCL1qEARsTdZKZAIcYYeSp2IACO48RNfyztVVdp8fdR6PP2h1iCjIGqtYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR16MB5489

> Similar to pci.ids and usb.ids, move the statically defined manufacturer =
ID arrays
> out of the source and into external sdcard.ids and multimediacard.ids fil=
es. This
> allows other programs to use the same database without an API, ABI, or cm=
d
> interface.
>=20
> Make the program able to read from the base directory to test without ins=
talling.
>=20
> Make it possible from the Makefile to change the install directory of the
> database.
>=20
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> ---
>  Makefile           |   8 +-
>  lsmmc.c            | 225 ++++++++++++---------------------------------
>  multimediacard.ids |  16 ++++
>  sdcard.ids         |  23 +++++
>  4 files changed, 104 insertions(+), 168 deletions(-)  create mode 100644
> multimediacard.ids  create mode 100644 sdcard.ids
>=20
> diff --git a/Makefile b/Makefile
> index c0284bb..11685b9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,9 @@
>  CC ?=3D gcc
>  GIT_VERSION :=3D "$(shell git describe --abbrev=3D6 --always --tags)"
>  AM_CFLAGS =3D -D_FILE_OFFSET_BITS=3D64 -D_FORTIFY_SOURCE=3D2 \
> -           -DVERSION=3D\"$(GIT_VERSION)\"
> +           -DVERSION=3D\"$(GIT_VERSION)\" \
> +           -DSD_IDS_PATH=3D\"$(idsdir)/sdcard.ids\" \
> +           -DMMC_IDS_PATH=3D\"$(idsdir)/multimediacard.ids\"
>  CFLAGS ?=3D -g -O2
>  objects =3D \
>         mmc.o \
> @@ -19,6 +21,7 @@ override CFLAGS :=3D $(CHECKFLAGS) $(AM_CFLAGS)
> $(CFLAGS)  INSTALL =3D install  prefix ?=3D /usr/local  bindir =3D $(pref=
ix)/bin
> +idsdir ?=3D /usr/share/misc
>  LIBS=3D
>  RESTORE_LIBS=3D
>  mandir =3D /usr/share/man
> @@ -55,6 +58,9 @@ install: $(progs)
>         $(INSTALL) $(progs) $(DESTDIR)$(bindir)
>         $(INSTALL) -m755 -d $(DESTDIR)$(mandir)/man1
>         $(INSTALL) -m 644 mmc.1 $(DESTDIR)$(mandir)/man1
> +       $(INSTALL) -m755 -d $(DESTDIR)$(idsdir)
> +       $(INSTALL) -m 644 sdcard.ids $(DESTDIR)$(idsdir)
> +       $(INSTALL) -m 644 multimediacard.ids $(DESTDIR)$(idsdir)
>=20
>  -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
>=20
> diff --git a/lsmmc.c b/lsmmc.c
> index 799e1ea..113f371 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -56,6 +56,13 @@
>  #define IDS_MAX                        256
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>=20
> +#ifndef SD_IDS_PATH
> +#define SD_IDS_PATH "/usr/share/misc/sdcard.ids"
> +#endif
> +#ifndef MMC_IDS_PATH
> +#define MMC_IDS_PATH "/usr/share/misc/multimediacard.ids"
> +#endif
> +
>  enum bus_type {
>         MMC =3D 1,
>         SD,
> @@ -63,6 +70,7 @@ enum bus_type {
>=20
>  struct config {
>         char *dir;
> +       char *ids_dir;
>         bool verbose;
>=20
>         enum bus_type bus;
> @@ -75,157 +83,6 @@ enum REG_TYPE {
>         SCR,
>  };
>=20
> -struct ids_database {
> -       int id;
> -       char *manufacturer;
> -};
> -
> -static struct ids_database sd_database[] =3D {
> -       {
> -               .id =3D 0x01,
> -               .manufacturer =3D "Panasonic",
> -       },
> -       {
> -               .id =3D 0x02,
> -               .manufacturer =3D "Toshiba/Kingston/Viking",
> -       },
> -       {
> -               .id =3D 0x03,
> -               .manufacturer =3D "SanDisk",
> -       },
> -       {
> -               .id =3D 0x08,
> -               .manufacturer =3D "Silicon Power",
> -       },
> -       {
> -               .id =3D 0x18,
> -               .manufacturer =3D "Infineon",
> -       },
> -       {
> -               .id =3D 0x1b,
> -               .manufacturer =3D "Transcend/Samsung",
> -       },
> -       {
> -               .id =3D 0x1c,
> -               .manufacturer =3D "Transcend",
> -       },
> -       {
> -               .id =3D 0x1d,
> -               .manufacturer =3D "Corsair/AData",
> -       },
> -       {
> -               .id =3D 0x1e,
> -               .manufacturer =3D "Transcend",
> -       },
> -       {
> -               .id =3D 0x1f,
> -               .manufacturer =3D "Kingston",
> -       },
> -       {
> -               .id =3D 0x27,
> -               .manufacturer =3D "Delkin/Phison",
> -       },
> -       {
> -               .id =3D 0x28,
> -               .manufacturer =3D "Lexar",
> -       },
> -       {
> -               .id =3D 0x30,
> -               .manufacturer =3D "SanDisk",
> -       },
> -       {
> -               .id =3D 0x31,
> -               .manufacturer =3D "Silicon Power",
> -       },
> -       {
> -               .id =3D 0x33,
> -               .manufacturer =3D "STMicroelectronics",
> -       },
> -       {
> -               .id =3D 0x41,
> -               .manufacturer =3D "Kingston",
> -       },
> -       {
> -               .id =3D 0x6f,
> -               .manufacturer =3D "STMicroelectronics",
> -       },
> -       {
> -               .id =3D 0x74,
> -               .manufacturer =3D "Transcend",
> -       },
> -       {
> -               .id =3D 0x76,
> -               .manufacturer =3D "Patriot",
> -       },
> -       {
> -               .id =3D 0x82,
> -               .manufacturer =3D "Gobe/Sony",
> -       },
> -       {
> -               .id =3D 0x89,
> -               .manufacturer =3D "Unknown",
> -       },
> -};
> -
> -static struct ids_database mmc_database[] =3D {
> -       {
> -               .id =3D 0x00,
> -               .manufacturer =3D "SanDisk",
> -       },
> -       {
> -               .id =3D 0x02,
> -               .manufacturer =3D "Kingston/SanDisk",
> -       },
> -       {
> -               .id =3D 0x03,
> -               .manufacturer =3D "Toshiba",
> -       },
> -       {
> -               .id =3D 0x05,
> -               .manufacturer =3D "Unknown",
> -       },
> -       {
> -               .id =3D 0x06,
> -               .manufacturer =3D "Unknown",
> -       },
> -       {
> -               .id =3D 0x11,
> -               .manufacturer =3D "Toshiba",
> -       },
> -       {
> -               .id =3D 0x13,
> -               .manufacturer =3D "Micron",
> -       },
> -       {
> -               .id =3D 0x15,
> -               .manufacturer =3D "Samsung/SanDisk/LG",
> -       },
> -       {
> -               .id =3D 0x37,
> -               .manufacturer =3D "KingMax",
> -       },
> -       {
> -               .id =3D 0x44,
> -               .manufacturer =3D "ATP",
> -       },
> -       {
> -               .id =3D 0x45,
> -               .manufacturer =3D "SanDisk Corporation",
> -       },
> -       {
> -               .id =3D 0x2c,
> -               .manufacturer =3D "Kingston",
> -       },
> -       {
> -               .id =3D 0x70,
> -               .manufacturer =3D "Kingston",
> -       },
> -       {
> -               .id =3D 0xfe,
> -               .manufacturer =3D "Micron",
> -       },
> -};
> -
>  /* Command line parsing functions */
>  static void usage(char *progname)
>  {
> @@ -319,25 +176,53 @@ static int parse_opts(int argc, char **argv, struct=
 config
> *config)
>         return 0;
>  }
>=20
> -static char *get_manufacturer(struct config *config, unsigned int manid)
> +static const char *get_manufacturer(struct config *config, unsigned int
> +manid)
>  {
> -       struct ids_database *db;
> -       unsigned int ids_cnt;
> +       const char *paths[] =3D {NULL, NULL};
> +       char local_path[PATH_MAX];
>         int i;
> +       FILE *f;
> +       static char name[256];
I guess you are preparing here to iterate over several devices.
The static buffer will work here only if the result is printed before the n=
ext call.
Maybe use strdup() instead?

> +       char line[256];
> +       const char *local_name;
> +
> +       local_name =3D (config->bus =3D=3D MMC) ? "multimediacard.ids" : =
"sdcard.ids";
> +       /* check local directory first, then fall back to system path */
> +       if (config->ids_dir)
> +               snprintf(local_path, sizeof(local_path), "%s/%s", config-=
>ids_dir,
> local_name);
> +       else
> +               snprintf(local_path, sizeof(local_path), "%s", local_name=
);
> +       paths[0] =3D local_path;
> +       paths[1] =3D (config->bus =3D=3D MMC) ? MMC_IDS_PATH : SD_IDS_PAT=
H;
>=20
> -       if (config->bus =3D=3D MMC) {
> -               db =3D mmc_database;
> -               ids_cnt =3D ARRAY_SIZE(mmc_database);
> -       } else {
> -               db =3D sd_database;
> -               ids_cnt =3D ARRAY_SIZE(sd_database);
> +       for (i =3D 0; i < 2; i++) {
> +               f =3D fopen(paths[i], "r");
Maybe just:
f =3D fopen(local_path, "r");=20
if (!f)=20
     f =3D fopen(system_path, "r");

> +               if (f)
> +                       break;
>         }
> +       if (!f)
> +               return NULL;
A warning that the ids files are missing?

>=20
> -       for (i =3D 0; i < ids_cnt; i++) {
> -               if (db[i].id =3D=3D manid)
> -                       return db[i].manufacturer;
> +       while (fgets(line, sizeof(line), f)) {
> +               unsigned int id;
> +               char *nl;
> +
> +               nl =3D strchr(line, '\n');
> +               if (nl)
> +                       *nl =3D '\0';
> +
> +               if (line[0] =3D=3D '#' || line[0] =3D=3D '\0')
> +                       continue;
> +
> +               if (sscanf(line, "0x%x %255[^\n]", &id, name) =3D=3D 2) {
> +                       if (id =3D=3D manid) {
> +                               fclose(f);
> +                               return name;
> +                       }
> +               }
>         }
>=20
> +       fclose(f);
>         return NULL;
>  }
>=20
> @@ -526,7 +411,7 @@ static void print_sd_cid(struct config *config, char =
*cid)
>         unsigned int mdt_month;
>         unsigned int mdt_year;
>         unsigned int crc;
> -       char *manufacturer =3D NULL;
> +       const char *manufacturer =3D NULL;
>=20
>         parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
>                 &mid, &oid[0], &pnm[0], &prv_major, &prv_minor, &psn, @@ =
-585,7
> +470,7 @@ static void print_mmc_cid(struct config *config, char *cid)
>         unsigned int mdt_month;
>         unsigned int mdt_year;
>         unsigned int crc;
> -       char *manufacturer =3D NULL;
> +       const char *manufacturer =3D NULL;
>=20
>         parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
>                 &mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn, =
@@ -
> 2220,11 +2105,14 @@ static int process_dir(struct config *config, enum
> REG_TYPE reg)
>         char *type =3D NULL;
>         int ret =3D 0;
>=20
> +       config->ids_dir =3D getcwd(NULL, 0);
I think it's an opportunity to replace the `chdir()`/`getcwd()` pattern wit=
h reading via full paths (e.g., a `read_file_at(dir, name)` helper)?
That would eliminate the need for `ids_dir` entirely - `get_manufacturer()`=
 could just open the `.ids` files directly since the working directory woul=
dn't change.
Your code is fine, if you decided to do that, it should be a cleanup first =
patch.

Thanks,
Avri

> +
>         if (chdir(config->dir) < 0) {
>                 fprintf(stderr,
>                         "MMC/SD information directory '%s' does not exist=
.\n",
>                         config->dir);
> -               return -1;
> +               ret =3D -1;
> +               goto err;
>         }
>=20
>         type =3D read_file("type");
> @@ -2232,7 +2120,8 @@ static int process_dir(struct config *config, enum
> REG_TYPE reg)
>                 fprintf(stderr,
>                         "Could not read card interface type in directory =
'%s'.\n",
>                         config->dir);
> -               return -1;
> +               ret =3D -1;
> +               goto err;
>         }
>=20
>         if (strcmp(type, "MMC") && strcmp(type, "SD")) { @@ -2247,6 +2136=
,8 @@
> static int process_dir(struct config *config, enum REG_TYPE reg)
>=20
>  err:
>         free(type);
> +       free(config->ids_dir);
> +       config->ids_dir =3D NULL;
>=20
>         return ret;
>  }
> diff --git a/multimediacard.ids b/multimediacard.ids new file mode 100644=
 index
> 0000000..0c91118
> --- /dev/null
> +++ b/multimediacard.ids
> @@ -0,0 +1,16 @@
> +# MMC manufacturer IDs
> +# This file is maintained at:
> +https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
> +0x00 SanDisk
> +0x02 Kingston/SanDisk
> +0x03 Toshiba
> +0x05 Unknown
> +0x06 Unknown
> +0x11 Toshiba
> +0x13 Micron
> +0x15 Samsung/SanDisk/LG
> +0x37 KingMax
> +0x44 ATP
> +0x45 SanDisk Corporation
> +0x2c Kingston
> +0x70 Kingston
> +0xfe Micron
> diff --git a/sdcard.ids b/sdcard.ids
> new file mode 100644
> index 0000000..cbddcae
> --- /dev/null
> +++ b/sdcard.ids
> @@ -0,0 +1,23 @@
> +# SD card (secure digital) manufacturer IDs # This file is maintained
> +at: https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
> +0x01 Panasonic
> +0x02 Toshiba/Kingston/Viking
> +0x03 SanDisk
> +0x08 Silicon Power
> +0x18 Infineon
> +0x1b Transcend/Samsung
> +0x1c Transcend
> +0x1d Corsair/AData
> +0x1e Transcend
> +0x1f Kingston
> +0x27 Delkin/Phison
> +0x28 Lexar
> +0x30 SanDisk
> +0x31 Silicon Power
> +0x33 STMicroelectronics
> +0x41 Kingston
> +0x6f STMicroelectronics
> +0x74 Transcend
> +0x76 Patriot
> +0x82 Gobe/Sony
> +0x89 Unknown
> --
> 2.53.0
>=20

