Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A29C28C012;
	Tue, 10 Jun 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555705; cv=fail; b=iUJQv0dwfTM9EuJJNuHNzAV3EK/IhTO+K57qOaop4coDIeDWDaeF8igfgb0AGbxAO2njzakTGx8lj2seOTi6T5ZML0gXgFTsRu1ilvABePiQnlR+NcfEbawRZ4fRCB/jrLN4ZNz5ovTs7MHpKfM9FywRY+ShbdU8LfTZeGEJ+qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555705; c=relaxed/simple;
	bh=GYEt56VzB+0l8Ijmv0L6IjRKoDO3/yC4DRGq6xZz4ts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cy2HxiD2Ci5uqgpVaKj1bH+L0HIjftG5pNbZ5+IDl71b/rrBLh5oaY3JsUOvj/rh0SHAC3StY5ihlff9rboPTbDyhNFppFOYz0rbgpRbat8MIMINpE3k4/OHRr06cA9NcXUQb1S99u6YHMVV/V1Zqdpm96dWodHRb5+C0mZSMJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=DhfwtS4z; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="DhfwtS4z"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1749555703; x=1781091703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GYEt56VzB+0l8Ijmv0L6IjRKoDO3/yC4DRGq6xZz4ts=;
  b=DhfwtS4zj2rTxR+qbr6WJMu/Xw/MBIpBMnSo0UkwxikC5pGEAlA00Veo
   e3LNnVeesD0zSfzRaM4Lq/1gNXu7a55YmyMKuZHxiDf3O/yssmFKpLvvj
   /rJzThB54hBKy130ZdaH06xkcHl1v/o6Nl1xDXXm5RBe29e6NwOWbO+5N
   Pot/muARdvbwU/rIkcZALvyCCbpSdp6lu+NdhJrT6CQnoy0OXvtQjoXJq
   UmaFDk1zTp08cjX1AjZbd89gTGaIFkF1yHA7RF0lia8AMr6wm341nnynv
   nVheGz3Mqb96i46iZKr1e9qWlSigJ3wPVuaZCewgM/v0dfRrJojR4190q
   g==;
X-CSE-ConnectionGUID: G2VKuT3fSeOsCIJUrQxSSg==
X-CSE-MsgGUID: 6vTcACzSQkWghT3wg2+21Q==
Received: from mail-mw2nam10on2119.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.119])
  by ob1.hc6817-7.iphmx.com with ESMTP; 10 Jun 2025 04:40:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzWZ4ah6hCT3RzM9TbmhZs5PQeCf2rzKxi2Kv/dKB8uhXxYZuGtccj5RJtxhObJfwBAZV9oj88rTrg67aePWTnRw2A2IR6RXNrMMnlUImZPTyD9M3kmFeYtd/obh25TI1c95beeH84gxW8/uLSGAxRNOOpSWKkg2e+SNOdIZr5iJaI5boPyufgp8M1z9pZ3B4FmfadYnyggA54PCv11RvwJ4yvHt40WvUTRgr80OYBVYumj4TI1FU5DRg8q8AogSnHfbidERbbyNRVJJJGQVdp5PVltJjgAMrGvvLXbmHybkyIMFwn8nM0N/pUzE+BErkc4E4f46Wf6nom+9TjOxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmp8ZbVe3A4PE9uYYitSNZ+Q29wR/R7k4nca6Sri+aE=;
 b=psVslwOVerhCYpjb8li3n5R74HMtRI8jDZ2bTBy7GQDJZpgjq/XPClDgXyqc/nQS6SJTh5J0lndYs3hdSAAv5LdpW4XfSTnZsSNGKBIIg5VrsXS7swuowtzML1QUa3whA9dfCWUd899P3QnR7r242sYiQzMEwlPFoBnKvXKk+UxRtma48wm96mOf4DbOs04LONwsIkbIF6RxRQ6v9fnxkWCXiMKWTrr0ak2WseWhSMatVXQGh5V+Zk5DEQw83bIBwUi5qN9hVc/Y2AumXnRWPBXAmjF6J3R+elygnxHuQ6cTvdyGIZ7iMQahPm6vlzk0LoKmWwbFAL26o3JWEXfbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from LV3PR16MB6190.namprd16.prod.outlook.com (2603:10b6:408:1e0::17)
 by PH7PR16MB6000.namprd16.prod.outlook.com (2603:10b6:510:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Tue, 10 Jun
 2025 11:40:31 +0000
Received: from LV3PR16MB6190.namprd16.prod.outlook.com
 ([fe80::dda7:471c:a1d:dfe4]) by LV3PR16MB6190.namprd16.prod.outlook.com
 ([fe80::dda7:471c:a1d:dfe4%7]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 11:40:31 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky Wu <ricky_wu@realtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] mmc: rtsx_usb_sdmmc: Improve sd_set_power_mode()
Thread-Topic: [PATCH 0/4] mmc: rtsx_usb_sdmmc: Improve sd_set_power_mode()
Thread-Index: AQHb2fkyusJ3StIpA0yQSbdMspv917P8RKEw
Date: Tue, 10 Jun 2025 11:40:31 +0000
Message-ID:
 <LV3PR16MB61908E77DE690142D3A05140E56AA@LV3PR16MB6190.namprd16.prod.outlook.com>
References: <20250610111633.504366-1-ulf.hansson@linaro.org>
In-Reply-To: <20250610111633.504366-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR16MB6190:EE_|PH7PR16MB6000:EE_
x-ms-office365-filtering-correlation-id: 6ac7fce9-5ea8-46fc-2d9a-08dda8139b09
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vLG3p2YGumfZwkmGgSlLy84KHQDBKXutvrBanFaKzxqbbiBtQAUn9xeJoPdh?=
 =?us-ascii?Q?+fyp7E8N7rj784m/oU8+oyifwVw2DBn9Inf/rVIDdgCIY8u5GklD035K09BP?=
 =?us-ascii?Q?kGhKIkQtYSD8p7BdSG3BN06FDD8KO+jUCat9N5EvK5t7bPIsD1sntNbJA/1L?=
 =?us-ascii?Q?2b5uT4HScH6iC4ki6lBi44MnBpXvpGIUilrzt18JQ130R39SM5dQu4hSkGVX?=
 =?us-ascii?Q?1dAYSs8fSs7541VNj8Kby8QWiVVY/1+iYZ5iSglG+UlFbXpCCcN1rAp/9EG3?=
 =?us-ascii?Q?Bj2WZl2qzk+3jhGj3XKaSLdlgzI+HatarWYuMZgzCEAmtfZNNNYjhebpHwyg?=
 =?us-ascii?Q?29fBXE3sC9efL03OzYapbfzLUmdSFGTcJDox0rFBjYv+/AU6SglIG6CG/iHH?=
 =?us-ascii?Q?ng+B716wfv2DECkVkcWp6ziWVvDKpykyBhO9AYfGjCLrjv8N96cD/FYSZruj?=
 =?us-ascii?Q?kjsH0XsOObtelbBGclzSLQoIR+WG9zO2Ecq+p6B4Grx3ZWPmVyfo+98W9aAc?=
 =?us-ascii?Q?AuR5CJLXYnvdioAQsAhmCSIp9LvAmM1iZ9ZKrnUQgd4Td7R3E56X4ROMaKHo?=
 =?us-ascii?Q?L7QmZbhD1UTsrHmU3DUNEwXe8b/d+qkXeYSJsnrQ0PpQfUAWzlVajL2Veoj5?=
 =?us-ascii?Q?NJoIW8LXqMvVw/P4CyJEOCcmxG9a9vDGAeK72TXCW2FuGgDd7z/IQkuJDoHk?=
 =?us-ascii?Q?jiB5plynQ4FB+NLzDEeIRl6cKrLJe3ULgO384sachm5anv6g7psFF+FUU3+f?=
 =?us-ascii?Q?Zb9k45FqEbaYit2U2OKdCrt6Nmr46jwRbiCEBnRYnuD3S7fjszNWlpRsW6+v?=
 =?us-ascii?Q?dWm2udmPIGWFtrNtWynVAeeflh4CH/EvohsjEHDjgv0Gmx99NXFAa+noPDg9?=
 =?us-ascii?Q?OOdesm+CE2BQuaFf2h2HiqpXGoBHWE5EvpNHQVedByPMLgbJN/MggLL4C9xg?=
 =?us-ascii?Q?TLIKDtMlFQw7mExl+EHmty3atsvKYVQ+1YVIGE+PIweDY2MnGdFg5WGBGQ1x?=
 =?us-ascii?Q?qZi/2fV84LkPAxnbG9NwV0+JZDHqkG10hxOLlD4NqZfGKrC/SgD/5GxT23yb?=
 =?us-ascii?Q?LgLecSC3xrAqtVd2PHqspQATa/osttVN5ksTrPVIFQcngniG0hoBic6YxaEP?=
 =?us-ascii?Q?8WEAlwHi8Fx//Xr6isCfewbkYx+dw879foAefAv5jX7STIRi/UvgdQlYWTij?=
 =?us-ascii?Q?Bz22BJM9R4CZoRScPZvCLRSiVnmm06qeepqGvzs1/NS+ayfsLtfPdJQyJD/d?=
 =?us-ascii?Q?1hhJxVlz3zd3dM7ZZnqZeltj17rDCLt1322I0iQ3C9HgK4xV6QEt7N+sekyL?=
 =?us-ascii?Q?caUy2sK2IfiIav7L7G53C/Vi9udh2wjTqf7yXiCCv8Xo7wONJdK+5/9IVpmA?=
 =?us-ascii?Q?sPCnU4+LIFQypmQv7vPRHHpvRwTjXm+yGXUwYBVYcfL4uTYgp6X4eX7b3jV5?=
 =?us-ascii?Q?Kq7klCA2xtAukR1bEqH7rf4t/2h1XisrxVgSJBfzK+qOTPESzmCQqVNktPyE?=
 =?us-ascii?Q?49hM+Gt+AXt5xOA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR16MB6190.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bga4nVKjDk6PoN+n8KoX9LD3GrcOTpm39TbHELdwrQ0WmujQzVDRTQzacdhl?=
 =?us-ascii?Q?Ifgy8JCKJDEIOYGwxkaP7FazW/KU1KqrqVout7XK7QIfAdtrqNCvf+VdKbZh?=
 =?us-ascii?Q?NKQzIrF+78ZdZo7HX+oaOnbTJxswcBLYflVpIBI54M2o0dnyOYU3SLPUyQZg?=
 =?us-ascii?Q?EKQ3SRQqle1C46Q+GNlu5iOkiwXq929PVL38s3P3Lezp38+CtP587PEFznSv?=
 =?us-ascii?Q?gW8LxQrAXBu/SSLFXt839+fUhmOI6pPXOVXH0Dm7shqHVc1eS5VAYIqyKxUa?=
 =?us-ascii?Q?sQW/frzZXZc7gHCyx8S0Gudx0rYWiX2xupC6FQy6JV0B7JhROlVjYX8GLMzD?=
 =?us-ascii?Q?tvChnfpV3Sa2+JyhSJr66Ekt2ZmdW3BPU1jfbLqaSZ/Y2FSV2a0dKL7TUxE/?=
 =?us-ascii?Q?ANGjJWapRGGr4PpgDzeAfUIDPB6SQXIW7FfajuZhgXpoHXAuzJxGrnI15j2/?=
 =?us-ascii?Q?Ttcqj0bHuaCKHHYjJHkcx9x70eTfN+QHbdT6aeLrHor4IB0xNBc2tHgK/lW6?=
 =?us-ascii?Q?iwc5XOe+k0LCSxdFAJlJWdJtsSKSRjsN0qKSR9nHO4saGFSGERh+6vWtNrxi?=
 =?us-ascii?Q?xpoW4OMDsm3BB54qgNzAHEVCRI5fDG68FbXG9S/ZDcbchTwxPeEj33n0WmMp?=
 =?us-ascii?Q?UXccOUb6UCdcE6IEoyslSDNs362PmSNEq/mqro4bFquB5iySpiP+SzXUZfac?=
 =?us-ascii?Q?OF+wX9rgYN90w1QFEzqjEIKcYD8PK8SWlFXG2wxzZIg3B49bLqFuj6G0Hes3?=
 =?us-ascii?Q?+9Us7c5uF9L/4gGCv1wmIxZHcsHxrhkWQVg8oK1gUQiZdzprGlI+45GrDWYR?=
 =?us-ascii?Q?lQVPZcpSB51klhpVRsoBqs9earb1VKV4X7ln0Mlk4n39w06h7mkHGkh+HG87?=
 =?us-ascii?Q?vxI8Vu/OqY9vC03yIrWfa+WnMEILnERTdSsgRUwMTamDnA8N0w8tIa4X23x+?=
 =?us-ascii?Q?N3xTrjgvuO/GX0dLdatjJjYW5vxyJSjBN5j26Xwia9ByP8lad1FyXWN6Z6rp?=
 =?us-ascii?Q?PsBWtYqrD1v4JmvCc5iVH3ll/sjd45t9Bk38UiX/+kXbk7QL/lvX1/Xicz08?=
 =?us-ascii?Q?r4ZniWirSfZgktL0/7YGtziKKsasQDyewcUGJM6nuRx6kERxAiWSS2lYUy9G?=
 =?us-ascii?Q?YwTAnzoPBgqAIhrXrmsjCdo6Rc11elAZ21jBmhhOs2NO3vZ8+B74FvAFgyy8?=
 =?us-ascii?Q?vdQhAkNPNDR0+X1tY7YwonuxjGt6FGS5zz4wl1wiDt2C6XxFL9Hz+zKTHUnU?=
 =?us-ascii?Q?Au2GedW0W1FXwTLfkAKPqNpH0Ww1ua2cOOgSw8B2FBKfnylkpAdkPK7r+qTM?=
 =?us-ascii?Q?mUyHCUSLcHRF0xYeYYxMP8KaK8joYZFu2nndwJ+3tK+1tZ2M578a2pn2oSYP?=
 =?us-ascii?Q?rB1QOQo40In2MTLN1YRWgDmh8g+/pFgY13VpNLpybNhLMZ5ue118AUO5Zauf?=
 =?us-ascii?Q?H75BBCQqmq6XsXYceEZNfYd5HY5CuOt6G0qwKeOxQVWUe5y6DhaJx539n2gZ?=
 =?us-ascii?Q?HbdW1F+1tK0jmZKMDx9MN3rsLQx12QNxcrqp37m3MYVhuBhg9IXhcc7OqhGu?=
 =?us-ascii?Q?I09yEEGwVm088zW2K7v/I95oBCAMmeqiotSpa9fS?=
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
	NrHE+Tcphs/iwZWSBrhE5C43hFoYrw0d21JeBukl2kM7kghnFOwhebddiWq6iZEGnDea+UoEvaXGoV15P3Rdf0ouuGXWNbdKHVS0f2cZernDw0xUlrCWBAz0vQAnU7eJQm2VfaqX+eAtbqGXJJZkYAzNsSMxcY5MbWfqKdfnegt95b6PvuaUeMIIwV11Ha6zrrWNiSaRy/L1KBGtclOzeentfNAJIrbhb4LTETv+b5dwarUtIlwlU7eevX1iUr4TEXKJawvnvr3eAC/zbPepUXy6JFtjWC7LO5Dhmy8/l3KlcGGkmrYIXn2a47WWER6rFB+qFl/xpzC+nZgRgzzu05957Rx1aVYh+sOY7crusOWSWQeEi9Jl6M72HscIPdvLfdZ8HvMy1/PfqoC09VA0GJ+9hCa8zAgo7bv3X3nn64shJvgrYfGDxW0mJdEC7p4U6FKvbLosFOkQRsn9A0GxQokWg1btkmprZzWcfhGK5y4DeVSHcC3Krn/ghKV/TAOtkcUxE/Gyr3tsgYrRWeGdf3qSVQF4FwAnNk8sFXQ+/eSP+20fHnrEo+n35SGdYd+a6GbcNwHf0IubQRJOjGnb8XAaigdqZ6k2ZKfJec3i08WTTxiySZQ3mvlFla1KgxRRA/l/NbNpTl+BN9dultiuCQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR16MB6190.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac7fce9-5ea8-46fc-2d9a-08dda8139b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 11:40:31.5151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6zxODIEKY2A7MBgjhIkQmcX5GhGBSfixxzOTVS/+JIeUb1O+EYcBIDLHyYA6m8feSXAgOsQ2Rsnb87aRocBgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB6000

> The code in sd_set_power_mode() is a bit obfuscated and also has some
> minor issue in its error-path. This small series addresses these problems=
.
>=20
> Ulf Hansson (4):
>   mmc: rtsx_usb_sdmmc: Fix error-path in sd_set_power_mode()
>   mmc: rtsx_usb_sdmmc: Print debug-messages at power-on/off errors
>   mmc: rtsx_usb_sdmmc: Convert sd_set_power_mode() into void
>   mmc: rtsx_usb_sdmmc: Re-work the code in sd_set_power_mode()
>=20
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 31 ++++++++++++++++++++---------
For the whole series:
Reviewed-by: Avri Altman <avri.altman@sandisk.com>

> --
>  1 file changed, 20 insertions(+), 11 deletions(-)
>=20
> --
> 2.43.0
>=20

