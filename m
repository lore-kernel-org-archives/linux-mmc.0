Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069C20C465
	for <linux-mmc@vger.kernel.org>; Mon,  3 Feb 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738604402; cv=fail; b=vA670rOB3+0SyoCL5rFb6g/0439sI/9teYwhs8zhUU0s4zLj2c650iGwmSkyDurjaoqG4LI0pDPhSB9QH6CWksNx9hBzV6OUY1/sjzsa1ioWTBtJAJ6cFiEOfryyKkLafrO82oewV+fjRi9Fp1SjAc5bzpQ7zPnCMcfCPKM/CE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738604402; c=relaxed/simple;
	bh=BgIKjXwlSw3R63hofXDILrGzFUCTQCJGLYQsZSO1bAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nmTEAWTO4U0t7t6wtq368vZLYUYk0Xaxh06Sp6wVxvoX8njA31e9zq5GqjjLMi2ZGXm3Q39s2twm6lAS54UEY3/N1Nr6/JNtPnU3yaLweTWYX+xlqpE/bfULVFssB3eXuaEFT0eoIS0ybbQvKPTAgYJma9dM6FH7m6anPNFoEOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=St3bZQex; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WGvnxzSa; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="St3bZQex";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WGvnxzSa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738604400; x=1770140400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BgIKjXwlSw3R63hofXDILrGzFUCTQCJGLYQsZSO1bAQ=;
  b=St3bZQex0L7lU6HYfAUZ20eF8uySb/axDUiUuLB+h+FXxm3AQWWS+Usf
   f6u2aQurOB6Lh6bPCTblVLVwXHviGFQWDtH32GBRfVza6kAaU3ZnzmgCF
   onSigE1Ma56yrT/PFnZLZz3xaoK11NC7y129woGDSSiv0JsnknR8NGrIr
   9V062skNOnEYPM1T0ppEBFMmuhkWI//K9j2md6NXlbA6zt3kkRNy97VEc
   qcwmMwf82iv4/QE9qfOu4aZkyvEbDbf8Vt+w5nIE5xE/B/v0ddqvFVF8s
   yoK4VnpQIdSfjNiK16YF+fnmL/r9Az7brg+RtTfOAAwV5fpB2XkyDR7jF
   Q==;
X-CSE-ConnectionGUID: e7gKoPe3TaeHm11oj+XFsQ==
X-CSE-MsgGUID: C/ucfT3SQZ2MUEbFJkQ32g==
X-IronPort-AV: E=Sophos;i="6.13,256,1732550400"; 
   d="scan'208";a="38482750"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.10])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2025 01:39:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPf6Ul7Nv3FSVj8cnXKc8uXWXb7AVtQAMYwHiaiIz9ygx3LvFYxwvea4VlMwR1pL4D3D0xQIAbw586BvFf/GmtVbYAsiCa1qz4jWsRgzhy2M3Fpv+POy8nkXhNC/xT4wVZlb74BcGoldgRanrQDtl5+t4W/1ut492hIbfDPfGCUOKinarr4sciCljKM+XxeyxTRosPm3hNxTi56Nwh7I3jKaGIHhZ7vlvmntgIjqSjBkJMSAZo6J9S+UQvz2Rh6X2D1u/CuC0pEuL01WHZHqxGcT9um0t7WEYHXIFNjDq53p5p0pRBpu+bi90nYa5Xv9Hh/OFqNVGb80fODkg9YzIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csAiHBxRQxjOcH9pgCAeEBvyMwVUhaC1GNS/AUGrNbM=;
 b=d2/0Bb41bRjVDmVSzZRrCT/hYejvDv5DJdUiA2n0RFhjUVT5KUcIPqPxOOs4Z5/vojPnZE9Ylk8uwkO3vJOJ2y4o8BUyq5ahteNsh34/UIwd+sPCqOJabwrjjMVOulKpFEHQMDwVSk2zDU+99DtHic7PWjrQF74oW/HvxPkfIoDbV6+u8HS4jXn2IWzoLGlda8P2ALLVFCEooA5oQBbf9gegZvCg4ATxZCIFLMIxKQSk0hvICBJwqTDNr9ANRax/IeiWYDtP50WNRpbE6kI9pdGog/DRmZbz6PycylJoAHKNq96BRVhatrPRSs0BjJuKRZkpD9xtv0lDI/wb+bSq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csAiHBxRQxjOcH9pgCAeEBvyMwVUhaC1GNS/AUGrNbM=;
 b=WGvnxzSaeOe65UTjrrodjhkPZKKL9fyDTl+iuW1eYJ1M2mhBK1GUBsIfonFMNijtOuqk2oNmi4sh+JQ6s48au31aRrfL0ouDysHj1Kilxi3JRB9w78j+hBsq/Pm7vWD2RqjOnwPaqpaEmr2ju659a3QCCaCJhMo8VGK6g9Bcx3s=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by MN2PR04MB7055.namprd04.prod.outlook.com (2603:10b6:208:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 17:39:56 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::bd7b:c391:6f87:5a9f]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::bd7b:c391:6f87:5a9f%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 17:39:56 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Gwendal Grignou <gwendal@chromium.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] Makefile: fix conditional around sparse
Thread-Topic: [PATCH v2] Makefile: fix conditional around sparse
Thread-Index: AQHbdmEmGDUg5KwgXEylUK5K+oyhPrM12AAA
Date: Mon, 3 Feb 2025 17:39:56 +0000
Message-ID:
 <BL0PR04MB656432C4EEB1A9EC3C6BDC0DFCF52@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <20250203172905.463629-1-gwendal@chromium.org>
In-Reply-To: <20250203172905.463629-1-gwendal@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|MN2PR04MB7055:EE_
x-ms-office365-filtering-correlation-id: 8fb97612-52d5-4cca-b51a-08dd4479c674
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BQsWw1lJBHDBkVhAn2jIK2Sp4gfcBHlePEEQFylAVzzkKmfebTDqKczNN8yG?=
 =?us-ascii?Q?cALLhPjFFOIUNeKB56kBqbzY69l4nzFQJyDjoCReRGNYjBtrxOjbHUVgFbkA?=
 =?us-ascii?Q?9/V0yVBmnoQxUB/coJY9lnJLbBakb0CbLxrkgH+husHnH08R5vBuj0fyqws7?=
 =?us-ascii?Q?xGFYfcAsFE45cbRHvoQOyJihPY7qzUOlkOZOFD8r64S9+XUBNjMko3AZjJ1m?=
 =?us-ascii?Q?pDOWMa15e4XaIkqfWhi5yEmkR55BBSRQwdHGaVZG0L9bqdowhYFO96tbhUMd?=
 =?us-ascii?Q?r+PBOong4qNAQ7+8178UzhNJqlvCjJTgj4iehen6of6kbXuCekYdOW7SE2N9?=
 =?us-ascii?Q?q8+uy8MnBRFtiFj+Y3HiM28knVxF3k45sdqj8BKhALlb1J8ksflR+xKgFjYA?=
 =?us-ascii?Q?ODaWptmww9NDgkxgUlff11+opKD3Ina3v7uGha6SJW3nml1qSxp1BH3kLrpx?=
 =?us-ascii?Q?MnEXFVNeQiBGuKXTqlfOTjjrd+xfeEco4tkDgedZtZ8ZoSWazj/Kw2MxPvNr?=
 =?us-ascii?Q?OBdupd97dtT84Oa3DEtLdviC3BRCYvCd0B/PYNXfAcgP4ijUFdImP6FBCz6V?=
 =?us-ascii?Q?sQulPbIPAaU6bDNo07mfeGWi5W/65CGeszDvlwKtAMzUSyHHXJizx2CBVLkC?=
 =?us-ascii?Q?DWiT+3k3levm7EHt0D+5zab4QtqTE1ws5o1qh6IIAUWKPGfkE8w0lD7k1TFL?=
 =?us-ascii?Q?54MFtYsBiZBmij8Oo2ZZTzYNZV7lNSFwbWoWOYNqxeEdkANFsSVyPMeXEsWk?=
 =?us-ascii?Q?bx2EQglVmCPGG7TXrCYxPqCDeaR3AkvPyPW5FCUpGw/YJM1y+ymD5pZWrp+9?=
 =?us-ascii?Q?KoCjtZYcyqtBygnLTWZbA83kMGC4wu+E255hqsw9ZT5sTCYiUkMQRNC1Qrhf?=
 =?us-ascii?Q?Kaay3F6gl38O4XTz104Xwxy6OFWJViQGry/Cwm5IoRO/WyQMLOTfBMaD3uuB?=
 =?us-ascii?Q?SKLX6kHoz4Mf+k6V76gcY2DhuWtjXL0GgTbUdLsa/5AeQtmHxNWHN59/jur1?=
 =?us-ascii?Q?z95PqHM06b1TtZxkkpIuk9R2WpvPNWHtDjdIuepDf9LOK12I4QkT7Zn6889f?=
 =?us-ascii?Q?6ytDt3Au6mDX0YwibAzHxc9vaNv0JLpCuP2pmVgGiORCVJeGx0A6bYDLP9qL?=
 =?us-ascii?Q?S7NAHWtsp8CYqdLX2VuSFFz/ENvm9qWOayI7EERsPmBqqS0tUdv4N9Y9Jwud?=
 =?us-ascii?Q?ayxVIYHr8qZagHOOtppPBVVo6pXsf6q8sVxNtYGovOCzp/3nrB8Y0Yy9Tcuz?=
 =?us-ascii?Q?20uyfydZRIVHSgCEQHEUCtZQgVUT09ldB6I0BM8H2eC7jR90QHB2G4szgbtS?=
 =?us-ascii?Q?peQfysL+sQTyFC4Lo+xAT73TAznPv9h8Z1P4F2iUw+z+o9jYSXB9k7+E6q0y?=
 =?us-ascii?Q?c8gk5wbtQlza+WVDnrVygkyFnuSwbXC3tebmBxbunEDqqsw6Us+LJKqH6Hjz?=
 =?us-ascii?Q?Ah7mzgOosOqdxhWW2ubua9DsdudAN1kh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IFBuubhqqlR4kOxQ61nOYxZMZWtjqYEjRJRL0RGDXJ/hve0WvlTjUVdisiST?=
 =?us-ascii?Q?Yv3F3qWI3mDxL1kd8rKxKpIRmLH3/4FewPWz23fBbHyZd9WR0qcO2MRyhnU0?=
 =?us-ascii?Q?hi2JVbrhOrDLYI45HHCwkVz6j5OviUEdRCEYCeXKipvw7H4SkOOsUidM395Z?=
 =?us-ascii?Q?EGGxutIZxfh8zB1zyKGIxKFbgFO22A2CiSum+9gSPDBA/TES/dZvh+MA9K5Y?=
 =?us-ascii?Q?jNFhnj/Dp8IQc+ONjJNWGEWlLAD5clDJFbmvdlfhoV0iQPUQWfkNktN9TkHC?=
 =?us-ascii?Q?Vi28mUPOeQQMECvLvJJy+CRWZEegOEjTdejscMaQg+I5gbKjHj67sJQ68Eek?=
 =?us-ascii?Q?1F/upMcRKqS6FzOmtpAqIliMtz+zuk0v+VPw6z+2M8asdnNSn0hF5dx+coHd?=
 =?us-ascii?Q?CdPYXBS2DwUSyGZDRRRbLdI14/Kg5uTKjhfcIMWEj2ZN+EadE7SfbwGY+drM?=
 =?us-ascii?Q?6HCqPxpnVksot3U1lbV0bTNgz0AdkLZFvq/TgOAI3JTfYfxKHW7vVnAMiy/c?=
 =?us-ascii?Q?jqNfC283nIC4Q1QUBN92n5Ek0pVXek1EwfBDdUKgx6cv3EpNzqMfGDsRhHXS?=
 =?us-ascii?Q?yVfROuiPf5HqpoucVgbm25wflFGf0Mdvyz7HlVgqQhDfbF+WrtXj/lxt5+nL?=
 =?us-ascii?Q?tQQHwQ2DogNrZF2n6ouYttYnH4UxhBkGPQHZrvzkz/OTpuUDHrrLxKn+L7Jz?=
 =?us-ascii?Q?X6+8+COtSe+QXxM1+BtPKKCv+XytaaFnHUjvK6omYxSB8/u6nYDCNJkqBrPn?=
 =?us-ascii?Q?oUJKwYhYqXk09rdigX2zZcuEpT+yopqaEo1A8ZK2TENA34t9J3NvK6FbseBG?=
 =?us-ascii?Q?ObGWG4MHIanGCODpfVYNH0DoX0xrmfJ+EAY1zWYc7SdTsf8MGDg40mpba73z?=
 =?us-ascii?Q?45nLt2Clovt56JoJOaMdX1ZcwH7eJwWsKDhuzUefkUtu/LzmbHBdzyyJZS67?=
 =?us-ascii?Q?ZYOp7lD12lCTqWbBtpwRRXhgSwr4OhDaXpQefdAXw1sNODWw5w9+TX4jYurC?=
 =?us-ascii?Q?rvVrlPehpqP3r1zzKL4ZmU4VfrT8q48ZzA08f0rG8U0LWYJPB/uyfucWleuh?=
 =?us-ascii?Q?L2sbuC4ElWXcbHQ8v2hiq3sfdn43uncVCWr3E3nla/NdVVIJQlF3me05oZBe?=
 =?us-ascii?Q?JJgefwTbbk9kMCiA24BDwjjv15/ngKPUfzezEChlDsC6lKjJq2kfy3LXVPrb?=
 =?us-ascii?Q?aKf0m51jLJUZK1L6FpYwlCNUxHnifZqoExxH6J6d0+PqkPnUnip/35RtXo1L?=
 =?us-ascii?Q?8UQQrvyKhYPCcFNLsSI5ZXhOfEM62z3PWV9BUQB1mP+85xl9wq2P8KrrP1f+?=
 =?us-ascii?Q?/33bS09+7vpPbWn4D4LXOBvjJ1Barq10+SKRfC8f/NimWmVoZBdN6OqodFbb?=
 =?us-ascii?Q?ax0FdToeZ22fMgO/WjaOJFFoR/JR8eZxg3R3PciHWkFWtC1WsGCd58+jM48T?=
 =?us-ascii?Q?8bt1OdkMeESThEan/AvG0OFCAUUQvo3MGvjVo0dTLFvpTLll31oxYkhobU+r?=
 =?us-ascii?Q?UsYoqEBSbw1gijGfBVZX4G76kc9bl5fufhZ6GbiwCxpQ1mUXjgegiNvpyKkV?=
 =?us-ascii?Q?jGsS5EXEC/UiLSnAg8mFi4qIls9KxCmhx10skscv?=
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
	+JnkOxMEWsPops8T+kGCWWNEDWer14J+HrDjHwV2FHPwfWs2Tori3KBWt7dUWLKHjQVql+7FuJdnM3xXsNRqlWn2Mq1lBK6YEpCMH/y23FIqjZlzjTp80eeDQLksv1aYDadHawSPbMjItMnsyQhXufwvgjhGAz7W1SffvyQXgNCI/0/yvK3iDZ/R0s/wlUlOqeF74C3BRLCCVMPeaOvUYOYcPWYIyzBcmNKYp6z8MOotJExKDOC9pgSqK0l5a3Qpxj+pXfGvG1ahESU7eMz0UdNiYz11dYrKXY72Z3sqDBXBmRf/HAKGgS3XCF0aPG0thBQTb+fCZovFraMeWethiVdomKKm7KkDlq5krxWh873bblyYIwEfaDejABEdTFq125qCigf1K1Gt/MLMOMne2IhX0Beb0V2elKqyPXT7LJxf0bsk3cFnqp39DW0p1YHajvjYfdWi4sg7Gkyp6O21TqRqfF8xkkE+f2oIvijwFRJIFHkiEhXRPp/D+hPN2asN7qV1n/imsAE4qTfdEREllbGrkpTsrE8NQJEr6sH4/+umvNWXYj850Ypp3qv+WaYUmFHLZ+l2Vr8f3z4hNR10kbxqng+8kSuYlJ7oUQlYARhlV1w8Ai/7fNRKsRBWHenF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb97612-52d5-4cca-b51a-08dd4479c674
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 17:39:56.7200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yrp2L7pLFcJ7cQf68dMIt+HVE7zK0cVYKNTk/YdjhEorUUacGtpEtbfwhgu3cib4Uj5ZLi406S8gLtacNtAl7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7055

> sparse would always be invoked, since `ifdef C` is always true afet `C ?=
=3D xx`.
> Instead, use ifeq to check if C is 0 or 1.
>=20
> Check that `make C=3D0` does not invoke sprase.
>=20
> Fixes f884bfe684f ("mmc-utils: Make functions static for local scope
> enforcement")
Nit sha1 should be 12 characters.

>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
> Changes from v1:
> - added signature
> - add test line to enphasize it is not a revert.
>=20
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 06ae0f7..c0284bb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -27,14 +27,14 @@ progs =3D mmc
>=20
>  # make C=3D1 to enable sparse - default
>  C ?=3D 1
> -ifdef C
> +ifeq "$(C)" "1"
>         check =3D sparse $(CHECKFLAGS) $(AM_CFLAGS)  endif
>=20
>  all: $(progs)
>=20
>  .c.o:
> -ifdef C
> +ifeq "$(C)" "1"
>         $(check) $<
>  endif
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(DEPFLAGS) -c $< -o $@
> --
> 2.48.1.362.g079036d154-goog

