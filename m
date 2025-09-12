Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA15B30AAD6
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680008; cv=fail; b=ZO7abaJQfz6/lqCcgGObl70sGcikaUcKhkaPkRnQQEhPtfKROPF5jDBwJeDE4Xe4n19c8UZQqDn47l8G5X2VtgEDzSYb42yW0E8ezIJ81MbxQZfTer6LyJa/jy7bmKVNiWYsVrWEJGAgOHxKnhacC4GR6sdC9qCYVrkedDfAYng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680008; c=relaxed/simple;
	bh=xQn/3dC0fMyt+zCCxIxsr5zHX4bEhJQoEL76Q9U7Xik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MuXnqEbG0fk3SpBaIHmf1PWYN0wsTQQwS4uwkskucBxoDI6BgfdjuBc5pjNFD8+r7mnrBwtNYyrNtQfpbfgKjbxDxfTteONuM2JYrVRsxDwInIGEwznca08W3SS6rBP3yC56vN29x65ljguX60uV+2RwTQm6meGY1PcO5WAis2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=wYDiUTIL; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="wYDiUTIL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1757680006; x=1789216006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xQn/3dC0fMyt+zCCxIxsr5zHX4bEhJQoEL76Q9U7Xik=;
  b=wYDiUTILObMKlTCx2pvQvtc0cyZ8W1vJF9QS2/bMbn7PD8r4QL7ykOaW
   NDYAEijhE23Tv3EJA1xIab+hZ2U4fFa5saBtkuiVxEmQmNXOfw9HyrBWP
   ulxU5INj0VBX04N+Ri1eLggv0GYK70oA1MZmvyIui6UKAr7JXoUDaLheM
   ASt7EYwrHC1cs0PnklBU0kd2XbNYgInQgzq+q4222yzVVCT4RW6zBKNl2
   Yx7dP+Uoh7HbrQSwcZKPg455u6OMcVt1q0tnnATuLiep2+eSly/XZ2TCo
   v84jGIZ7cteM7NTjpymXvP+FVMtxJjs19j+hHi2D/mIrVr9JmjDDkeaD+
   Q==;
X-CSE-ConnectionGUID: PFnAcfxIRNmD/NMEjdk+WQ==
X-CSE-MsgGUID: PdPWNXyPTtmxOuR6T+q35Q==
Received: from mail-dm6nam12on2099.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.99])
  by ob1.hc6817-7.iphmx.com with ESMTP; 12 Sep 2025 05:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uw9ika+sXp7yj+aeU2VoX1QwBPC+05gPlY5iSdrpnO15Oxi53/8gDAjvcVlOjctoKeC0Qh7ULKfn4MXOpFP8sjsY9zyQsgZXgCfATxthvly3PUcizpbPHfVFkh/J3kd1HgRRYrVjczzJEYADFM2rA37IvxUNjYoOsNrfhjPF9MkM1Ot9liHYxJietGUSheu4Y/Cl43gaf4Mu8wrhMYFwhwPlagyoI69CuS3f647Y8hd0LFI0BeEMhFoyKXRB1dNBB988wPqcwZQcfc0ZXAck68J/o/DuzYh+iwmvFByRJhUfznun0mtwlefKEEBV/uCtCYMTND4uJpEIdZQdM4LjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQn/3dC0fMyt+zCCxIxsr5zHX4bEhJQoEL76Q9U7Xik=;
 b=GhpWrisy0Bhkz2z4zmzZbZVcZOCc6AnhMeGQoUY7lXcsfSq12JkrkxZ0EXTZSQoYN6qKHqDTPszpqGBdu4KyujevEYgBexUNE2KvLhZcgqrKPqIJkf/3epDDDQa13ZSkD3ZeQqYXFqhfhueu8NIysQ1qkWLcsE/xXjUMGHq9VYgSnTk2bTdAQI8Ac+FckymoNiSSdEfKuZFKrefvf/+Np+TxWuq1RmUPBJOoaBwRzSGICe8LpqZ32CzTToar0u6T30unFVILpqg3FzGHoIzozZmNwJU6m8PqWw/kV/6tgO7d5Y3Ffw/ZajLqVWuMrsnZDMu5FWtNYH5KnqpW/d5ZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by CH3PR16MB6140.namprd16.prod.outlook.com (2603:10b6:610:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 12:26:37 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 12:26:37 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "jens.wiklander@linaro.org"
	<jens.wiklander@linaro.org>
CC: Bean Huo <beanhuo@micron.com>
Subject: RE: [PATCH v3 2/2] mmc: core: Improve RPMB frame handling code
Thread-Topic: [PATCH v3 2/2] mmc: core: Improve RPMB frame handling code
Thread-Index: AQHcI1/xlGbgCqvO2EiNYEaB7JybV7SPegpg
Date: Fri, 12 Sep 2025 12:26:37 +0000
Message-ID:
 <PH7PR16MB6196533EB92F0E57F2062DF5E508A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250911210606.446355-1-beanhuo@iokpp.de>
 <20250911210606.446355-3-beanhuo@iokpp.de>
In-Reply-To: <20250911210606.446355-3-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|CH3PR16MB6140:EE_
x-ms-office365-filtering-correlation-id: 33c6f3bb-344c-4f6e-a7e9-08ddf1f79e3e
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?V8xwkfOW3rDVOdODyrtQVBEe9v+X64rQbwxYds9w2fonruLTsGnJZg9Bip4/?=
 =?us-ascii?Q?AU0jQygnz3uXVvgVj/V+FxkpzsXJFfoPBIKANUIosJHRKp9V0Tx1M808+Iau?=
 =?us-ascii?Q?GAiMJ6BdsJn9cBIA/4wTyqctoxgO8XV908ryIa7UbIL1XSb8+OcGtJb0j/JH?=
 =?us-ascii?Q?RY0KPbkzqek8J6qUQsBxhJt/Ww+8b4ddmLHCEjp9llGv1kmMMr2blttdbyZK?=
 =?us-ascii?Q?959D1xuA7GPAVHNTG2oaxrkJhQAzyiTBpvk5QyQXb8v25+PlkN6qtmVdClGB?=
 =?us-ascii?Q?HWgGmGaduG8ji42fYaztmK7RcPVLYp2iuJsO1/i9jNMOmKYph7icSQ1kFFow?=
 =?us-ascii?Q?gjvU7CWsa2xicSehBJBLAvkM2ck0wwLfAyv3gSAa6DBuvj8vYFcOH8ssrEVD?=
 =?us-ascii?Q?WJa0+bS2UV21Ow/UKrAkeTRGkjZdkj1XECZbpmiGjc1p/5P54i81AH69Y2Qg?=
 =?us-ascii?Q?/Y137U03VzH5d6bJOFGY/AHbe96K+MhgEB8qiOM/3QkuP6C3fc/tDbUf72IW?=
 =?us-ascii?Q?Ku0+5tPbSfJByjyHP51jnYiuipHwNfFiZYKVnQWdeAEtH6x3Eg0grRNPt9Lj?=
 =?us-ascii?Q?fmGaxXtyvIxUc4zKsfHNyJpMppObbZYkZ/uiB4FDSmD6TerAsLq+/IL9UuwV?=
 =?us-ascii?Q?w1UtKqPeYlJ5lCA2ICslCSD8WUdioGBI0zNKcksLK7r0FFJ3f83P5IPH4TCd?=
 =?us-ascii?Q?5NyPUa/DUUOAah8Pg50LIV1NsIEreexSfyG/qX0bqPJkOz52OtLOuVT2UwhT?=
 =?us-ascii?Q?62GJHZnwQHALeTkJNlDFjSmj+W9h+V0iOHWUq0EQ1QI6Lop0bRhPU8nZbQ5d?=
 =?us-ascii?Q?WrM6pgJ6QxYadxdPjqYxuTdj0IBqdcSe2zTzP+nJBYS+kTZwf4DOobTKtMej?=
 =?us-ascii?Q?ztZVFeUymcuLrIz0GkfHDqWYIpHCNh0eWiW8EPgkOObQaHMV2TFBSfIcFpR8?=
 =?us-ascii?Q?1oxuDMN9sZQevr9FwY8YgZGHYBi/K5jY56z1rxtcqt9WSD2Egh4Nkli7PDKN?=
 =?us-ascii?Q?cAvFqnFGfNYIhY0DvXg8/jaPvZo8ACu14IiL4TJTQuH+atfLQmlXP/ZOm5Wj?=
 =?us-ascii?Q?H50jd4NeAVQDdc1KbE0ew8rvX/KQj/3TOy65BsJ6KYkrD0VIRFBnr/4msRXu?=
 =?us-ascii?Q?3AR9FehUgk4AeEPJCNzc6XCxN1DagY/H/Y0BPp5+bWTPwThWfquye6k6rZj8?=
 =?us-ascii?Q?WTELU6qvtamwCgK2N/Z/q5SVsen6AhjUjWi2Q2k0gyorxYU17HkpJX6WUHbn?=
 =?us-ascii?Q?0g/KREftxQE/Rj+19/nMEumeMHfVoLxBMGa2fq8Ogba1suTW2Wi61VpQDxG4?=
 =?us-ascii?Q?zZSJFjKP8N3YbbIsh10ewnP7f1T+qUuWqTG0VoNlSV7mmw+rMkOVfurC1OdD?=
 =?us-ascii?Q?c44mZDK7kfS+L4jw5/SiYT9TyzKzys6VShFJ4bdDWHYysN14qGrl/L/nVHMH?=
 =?us-ascii?Q?qMdAv0JKVsbWrGZl8nPVlhgcB1pO/jNfBYKPslWdBS+p6+8+pUtg9H+0ka2t?=
 =?us-ascii?Q?6BuUQbGb1OBXM7I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YTGn7SYvQARSFQ66AQvB/J6p5TN0JDZeghO1qvTTYa8YPt9JmdmdaIb5MWN/?=
 =?us-ascii?Q?pzlRyEnfnOr3lclYM8VvXH+G69Wf44WebcIysa2QggviMbP0sXqmWobR5sb3?=
 =?us-ascii?Q?y1ae0F+zK06GaGmbnM2bGokqQ6YmCrl5PTW5IGR5S8RgXgleduX6g5fr6Ivb?=
 =?us-ascii?Q?wz2eZXadv7jGziGvnLjpuvWmSLPMmRov9RX3ArnyBNIiqhxFFVP30VpuUG1b?=
 =?us-ascii?Q?dvws08cNOsETDzBj+1VTfNEaB2zTh2iUCY7DHnRnB1qcOYyhJKqKRUiTIyTj?=
 =?us-ascii?Q?ju9+1NqUzd3tLMOFC7qNgY6jSXpvTXF17sMy0zqFTE5mcIU78YqDHjjrMjhG?=
 =?us-ascii?Q?lbEGohtB+oj8bs4hmghFbmB+e9Rz5AVipUbbw+3KODDQNelC+z6bt3naMakO?=
 =?us-ascii?Q?bVhFUjQFsZEHczvibaY4kvu4jtpMoyRVSi/05RGDMfjKK7vdUWx9xi5UZs6V?=
 =?us-ascii?Q?WuSJddBIPxSX6yRKxeYrGzX3D4fRU0q+D82HkWfKlmOsT7B3mOQsLc6olrf/?=
 =?us-ascii?Q?4R6CpkVK0pE4pAlLPY+iVIVd4LzADy4dJ+Y7J4iGIKyEz9eYi5NLn/83ICEW?=
 =?us-ascii?Q?WEDH1oZWMZjjWNduu7FwcPs2DW/02HvXThcjDYT8pZYpWV1M2vjrpdUum4M7?=
 =?us-ascii?Q?zk+6AMlaPdrLe9dOS+qVqg3O649x8MpIe1cI5xNuYiDKmsdKiy/IMavHA/FZ?=
 =?us-ascii?Q?QIo/1dUWe+HS7qhZoASo+LvUGMMJXKf8vvP9cRp8abMWg6JZnLxWttqrADD4?=
 =?us-ascii?Q?FtRnB1IvS86Yf14oWsDHe/vSmd5JyBSE5PSQGxLsWyrEEt3CA2Is1EWGhROM?=
 =?us-ascii?Q?0Ehbu646MEm5MVb+x1nQJdVZwau15PxpkRC+VtgNPR8Sxh/lpxTq936DiqUw?=
 =?us-ascii?Q?HaO5oNKget39s8hOixR4cn58rwltpOiBKdueRF0fNx0KZFS5g+rSBuF8b9pq?=
 =?us-ascii?Q?/17NNU0OQZLcL2vmYewAaTGfyuxGwQ+tMO5XeGR0L87jfF0CdAMq+MLus9oT?=
 =?us-ascii?Q?teUmyn3ZyxbYlfnu1q/ImzwM35e4fRVCsO1ImdFyFfoVUlBHLNZuMmwuAeC0?=
 =?us-ascii?Q?HhCJYT6Go4I/s93+iCfXweKobpz5euSjAZxHDCxyey7kDRkXKlmw4BCwwSWK?=
 =?us-ascii?Q?9IIpuRkCZQtw6VJtAd1F0zO7TNEssK2uEGZbD8uRykks9xuMPq0tq6iB2K6A?=
 =?us-ascii?Q?G+VNYMt8Igza1s1++gkK0JYydYCM5yFLd0w5dVIc2nSPL7kp/noGzkJSpJg/?=
 =?us-ascii?Q?iMoWpmWRNye1oC9x+0XyX+HKAxEbZtj/GOJDrZ6Uwtm8ltmnZEZuMAJ1Kx11?=
 =?us-ascii?Q?FPsBMidr/8L4//xWwVIJAPYvU8Xe5Hpa8/H3dJIq9N11FwYKwBI4b6SS0IOa?=
 =?us-ascii?Q?O60yj6sO34CCUkZF2Tz/1AZTSIaq7lP7WwTQ9cxNXB97mwPn/7iT8W7KIFZG?=
 =?us-ascii?Q?KtHvmXjSmTdnKs3HVIIzitwfSMRRKO+EoFBmgH+5kFtRXImnWHs9K2DSa3Ov?=
 =?us-ascii?Q?Vu6xAQs+2l/qrDQ1tWoWNpRemhCcyQtO2gHgwggPvhqM85u5sn4BVEubgTT9?=
 =?us-ascii?Q?EGJD6o46NnOa76tnimmtW0poKDsqxYKDJKb7qLNn?=
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
	G0zLrz7FfOF/UlLLI5gnlF2qrQG7X5hBMvkXdUV6xwTVN9luD0ZleGDyK782dIEOEodZHPRCqEwTnrMDPa3uGbFMSaUf44rLHuSPRfUtQCussr+MGnNCd3cQ1gEDG+EvkcUR1L+LsIe2mNQIw8bK9vC6xAJDCrU9IOeQOLuzwNiCRSAp/AVWzYDaIH7YWrih1bbKZUBWEjiE6w0EjEyPyqNbqKe97AJe3hqcNcBkEZ377zhGacFG9CJOyZEaxOTsbO7Xn0MKcUq+qzOQgC1ahPizIIwiviRjmCWIVTliwx/ArNWCYYNoOkIZll5P3dUzK3XZ3bG2iRHejf4Aagqq3AB4iGexBl+YHoKj8MwXAyTYFXx+vxsv84KNm8aloRrFJ3PXPNZzYZ0XrOvbbe+MDXs6OnjLLuHH041+TPfk60hdr2kH0sORODtfwqPXJst+xv1Yn3Ebx4UQFnsTMSTFZ9z9qQ9FD9BUyYJ9ysdAuNpzz+hT49uDBkrLWZqlpJz2wfsKH9cIhNIZXFIsIuKckuEF02+qZYO7aQlg7xiWsG4mAvbn4L/L+B0UPIrJxUlFebSpDED5iYS8eyzraDluzsGGqOIsAcy9T8A371hBwcP8HAZoabQR7twzKr8r5kTVNw0nGsoUbzK+zmS3NJeiDA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c6f3bb-344c-4f6e-a7e9-08ddf1f79e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 12:26:37.0499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnax9wnj4D+bo4niZaM9//ySS+SxK8F1PvGQaq8Dfyg6QvRzCzw7azU9y1vvre4QUmGKa2BQQbKxFY9xhVe8xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB6140

> From: Bean Huo <beanhuo@micron.com>
>=20
> Introduce RPMB_FRAME_SIZE, CHECK_SIZE_NEQ(), and
> CHECK_SIZE_ALIGNED()
> macros to replace repetitive sizeof(struct rpmb_frame) checks in
> mmc_route_rpmb_frames().
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
