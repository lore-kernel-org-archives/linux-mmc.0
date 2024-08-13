Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8753CF7E
	for <linux-mmc@vger.kernel.org>; Tue, 13 Aug 2024 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527733; cv=fail; b=u+HyozwHE1GQIUqtXgRbOxMiyKrrS2MAvT6xZhddYgZXaymz/CZ9oOTHFFykWXjO9HP03K3qqfUeRwxfdM2XKscFSKqSZ2FNfmQnSC2PMGVJFR5kmJJGtYxdGcnlaRtZq4fbbSx86yy1Ecp1ouIVzMmX58NXtbMRh2jxN1Jk8ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527733; c=relaxed/simple;
	bh=XIfogQq2l+oHc4lbManl6+68eVzLVidqf0Bj3tJpNVg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cIXdJKHo0RpMPlcFh7ZN6OQQF7y/VpJYyfIZTOR5W7ZKQWkijNahUqJWh6kw5Xn3soMLeilW3M3GXTcqBCZ4jdvYgEsaVNIvftasAggtGPhHwYAJ3Yt1RBmSjmPHvVIZ/TWb8bKAxV6ARcMuZdYcHJ/aPF1+5AAisp80Aj/NXAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=H0tbj9ik; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cTiyHq1h; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H0tbj9ik";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cTiyHq1h"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723527731; x=1755063731;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=XIfogQq2l+oHc4lbManl6+68eVzLVidqf0Bj3tJpNVg=;
  b=H0tbj9ikObaszwnO1S99wWvDGdR/Wgq+b8/qQY4efxnsqHeZyiBxrgNT
   Uf68LXGzeCWTt+RlWvShEwNzQlMFZ1/IQUV+D/nBaNFVlDEV2ogHklSaQ
   94SzcfFdfGNSAYiunF+uFjzcU/9l6n6Qp7bOoh9bO/IMNUUqf9Hq4zjNa
   arHi1L2niO93UFFreEWP7HSqHJ0KZjGYczrVN9ZeB1wCFtz1gRe7VJkd+
   u2wrp4/J6U6MmulNrJOsWgAEMJj/wYW9fWle0eHWuDGe2mMzTDUtSEO10
   qQZJvfIB2JGJHtxarFQ4lkXvZaoVTlJRJpverw33qfS04XaX0zoGkKLDS
   w==;
X-CSE-ConnectionGUID: EZCSinukTFOY9SrBRsuFcQ==
X-CSE-MsgGUID: BigjT8XmSnSEtEb2h9rXeA==
X-IronPort-AV: E=Sophos;i="6.09,285,1716220800"; 
   d="scan'208";a="24854333"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2024 13:42:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sefLn0KYCLeMbHp5Fde4sF0qMhxKyWIVlInrXvU2DQgF+SVJowNihhLoPaiFOw9zsDKo+8z3LErxGUEE9KlfGeOw5Wh/OeJyOwSErmdH32St2B6fayHHHvJRrYbeH3qLLN+SEkCLkwBW+RNGe18gkqe1UE0PnH3+hIHbPv0GWvPRG+q6Rs2Y14+9cABaii4tdWpDeCK2g1HgQ/Rm+0ajDPZk1kT7+a5tGwX4WZW8kS6vp2LjDnKY06rT9lzPlcI2jcksFL4yDO0W3XvugDdUGjuIEdKRwI2JlGXTZKrwAUjlo/abjDyGA3x4yQBrDz0abzQONMPAMNNOqyuGCvycpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOPBDQNY/eBgFS0Ua9GXsPjFNK2Q3ER98LZxqK2+N3o=;
 b=vHTaG3LSq9fS+BqO7/fsstA/SCE8v1jVRX5eGxq5MnxvY8sgbjbP3wyql+qVsSE1RSZLVJL2QsktL/Q3unnPerW8Qt8ENhYuklSSjQeyCmg6WVAZ1e66jhgPz58LzPFCCVUxl91ujLofzfo5ntE1+wmRxI4FybtK211XF/T06290TwuE2607H96jIo7YWyedV2mfKD4Ym5K80qAV14EEAI+KX8lO5x2QWDDlrlxlLFDS++UBe1T7UYm4ZE0X+5m3cibWz4MhuEqBrHUgOMjtL87khQFXbCqkCtW46K+EDnWk/n4dkE1V1TeATXikGYdHIG1p1rv6aBf6+SVrTed8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOPBDQNY/eBgFS0Ua9GXsPjFNK2Q3ER98LZxqK2+N3o=;
 b=cTiyHq1hbYW4yYxTWqW4OTq9YgSYND8eJqe1h8jHDmio9QxWdSM5MQIpRZcgfTqMs5QNMEaLkpj7NG8UwvREHM7FzGMmku+vhHbvzHATasGQ3sYc/J6MAI4M3gqvtCPjguWxOWxet/NzMBj2Dna2kM3c26iMnbWTymtUBa5USd4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7461.namprd04.prod.outlook.com (2603:10b6:510:1f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Tue, 13 Aug 2024 05:42:06 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 05:42:05 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ricky WU <ricky_wu@realtek.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2 01/10] mmc: sd: SDUC Support Recognition
Thread-Topic: [PATCH v2 01/10] mmc: sd: SDUC Support Recognition
Thread-Index: AQHa6I+3UXs43GPn70qM59vpv7m6PLIesvqAgAFwMXCABJHUMA==
Date: Tue, 13 Aug 2024 05:42:05 +0000
Message-ID:
 <DM6PR04MB65751B8D55D4C4495A603871FC862@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
 <20240807060309.2403023-2-avri.altman@wdc.com>
 <9353f3aec3e846dd9075ada858d44fd4@realtek.com>
 <DM6PR04MB65754CF8B3A986A88FB0A517FCBB2@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB65754CF8B3A986A88FB0A517FCBB2@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7461:EE_
x-ms-office365-filtering-correlation-id: 3bb60de0-1a8d-41a3-8286-08dcbb5aaa57
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hM55D2u+2v8qujfX46bBJbaBhvoMVStzBnYp+5Uwv/wAx67s1jb6E3K3DIdL?=
 =?us-ascii?Q?3hljnXNQJr9AzqLwrgHu1+pZI8k6ER9ehBXdbd9M4iDQOifYNfJ9hRNoAn/B?=
 =?us-ascii?Q?pOPN4Q67f32QwmmI+ivdG7oLE3m1HwsxTG2trVbXh6y7jncTHw4AxLe1Usp5?=
 =?us-ascii?Q?o1AaGs+ZzlJ6hfu9yT2TGKbawWhuV7vmYnjnikMZDDxDzDCXIbrpGxudk4/a?=
 =?us-ascii?Q?jxIUEJrMcBmKQsxNFatGmoqWMa5XppKK0z0lXi9Axri9iLMUM6CnakBc0Txd?=
 =?us-ascii?Q?Bt2RC+4oG2hsRSyyV+o7kerEV+AhT02Q6/YUz5ArQs0iSfWQIWUUIuBaYDKb?=
 =?us-ascii?Q?yRDfdwnuHD8btALYsbMtY1X15LwGMhFYAUkYp3FXLKlq0O51V+GM5zxMqnQ8?=
 =?us-ascii?Q?6nbfqzo9+z4EsP/ocUqChPxAfxnoONraLKr+0jp8hlITsVmeA8j+VDXh+ZOO?=
 =?us-ascii?Q?oeCCw6Hu7sgOkmCXXsyW8ntWlyWHdt4nANsG/McaaFHdMA4vuFCcRybpwFr7?=
 =?us-ascii?Q?sK0ijQcXln6hRmFgxgZPy3Zp+Ee/TBJheTf5QoYu0WinaTxyE3twcTFpKzyQ?=
 =?us-ascii?Q?dfE5BO8v++W0TEssOTuPyv1ILLuxO3A1ePS0QYgNa5qQdIzYxFgda59AUt5+?=
 =?us-ascii?Q?yMsJEzZkZKIZ6nUJlKdg51nx7JnitCy0ZiOWzO96z+iu9OWo30grh5tJ+72C?=
 =?us-ascii?Q?QS5uSw2uTcu7GaIWH1Zt6iEGAbDN4uAHuYU94fm+QosnywLEArJulpYoP0BY?=
 =?us-ascii?Q?pprg6JqaGoNwM+vDq07GV2T3U9/5eCuV0ykM5FkMWFVGDu7tqHMzRcsnjwl+?=
 =?us-ascii?Q?HbuyszABUpbe+3kLz1gnKVnzomX1Y68YVpsyHFilEljmRFeyceE6Wwd0f0jh?=
 =?us-ascii?Q?In1P1YsrB9SL+Zpu+uQsXU0QXhiRAsMflUd0RiUbSIml6P51T2mugh6S6N58?=
 =?us-ascii?Q?7YQ2gswxfXCCRyTqmLJemMu7FWd7/J1yYWm9f4rtf4+0DFSThd43jdAOy4HM?=
 =?us-ascii?Q?RUR4JEOY0ubxJTYu2/mGPgQCzJiE+kWJp9sToATAly9nbhjBEvQP+vzfYs7D?=
 =?us-ascii?Q?EU8ufJpLVa7MuJyKmHAjXrIucfWPUNv2+bLDtAst1yuWTIiqLwpjuTC2ALHf?=
 =?us-ascii?Q?2FcHR0Ottvc38KdnxTJsdWMZMupvlnoYUFSIHUjOEfXv+NqiXTItK4QGOith?=
 =?us-ascii?Q?XClvb8MZajjmIEhGJTBV6EFXSs0nf4EO7a4ZIQBWUjGE9d4oJo4X1wKK8KQc?=
 =?us-ascii?Q?8hdpbEv8RcwfPL/qhVk09lXSkWEnXQDezU1m1y/dsRyVesyr1yby0/p9ZSpo?=
 =?us-ascii?Q?0gMiszr9spnySqfui49sgGhje+Qy+PvAgEQ3ZGYUwZLJ4HiUG2wnW82G4xCx?=
 =?us-ascii?Q?gkAe5XU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?58VwAGMzeuSECgqa57comnMwDBpVUk9nwX4GqJi76uEhmy+M+2NndKh4GYj0?=
 =?us-ascii?Q?5iMUcROoukjTFE3M0l+Qq96h8fysMmXxd2YxyLTjtdzvQ5JTBJGCG53vgxf5?=
 =?us-ascii?Q?4NhKushDAz/IwKwNzcw9jFFKEAKkADprY5/sriqjEpwRGjTTA49Kq7ZxPQLK?=
 =?us-ascii?Q?7YKyBWNmpr1w++7aUve9yg4qxQAbi3pNqj5K+MKOicWt6FfYMtxNYcQUjfBz?=
 =?us-ascii?Q?55Lsuxhq0JbHe0gES+2BeADurevF7QezXZ6KIUvRLD7VVKnzYlGf2r9+foPM?=
 =?us-ascii?Q?cjXSVuCvxGhC93Iy/1dnXcQtlE5To+bsPwtPJZyHq0DHPPX8vcdYUGKA4Xqj?=
 =?us-ascii?Q?MQeIWCfQIk1slKJAlSycmatf9e3Y5uaZZ5HFcslKem1YmvcqgoFS8kHBvZiI?=
 =?us-ascii?Q?WAjttF+UXjiYNM6iX1d/bSmbQcHn085kpaME4cpG3yygCJJb9YLGCjQe6pD1?=
 =?us-ascii?Q?CLe+vrtJWkQ2EjPQXmxZ+sTSvwAeetTxzjSExUcGrho0JR1I0kDYoNaojcDG?=
 =?us-ascii?Q?rlJN+qdDGuh7rZ1sh4rtq/Jm01bQMhyYKHUMTaFXxduoVuCfKvDOkVGxVb18?=
 =?us-ascii?Q?IIQ/EBhOJoH3R4W3EUXvBcMa+149daVjWoSJmbC/JqVmH77hk5yoaKHWZrZ3?=
 =?us-ascii?Q?a3Q37VgG6nsl43framS13CAJNPG3muwKS7Gd2ndCEMzcYS82ib6gdh2Al3NV?=
 =?us-ascii?Q?i9s4JbHP+fUYt4kcxZ9qpRB74RyVecnzrGyBOPldkUSh173t9o+0SHakPE3y?=
 =?us-ascii?Q?U6Ghvt2gXjAgrpJxo5MnkxRTIMH0JgAsfIbA7RYQlJ5T5mWTDlsQBc20Oq47?=
 =?us-ascii?Q?5T3my1OBj/Dr1zjeI1vWwfEOmoKdTWANA9+eJVmk24StXrmXKQ4wx4VYj+Km?=
 =?us-ascii?Q?2jAqBg9zdLPL5SmDug8jzu36BhGypHIblqXsZPdCfXV4zS3BoRBrYN3wY3bD?=
 =?us-ascii?Q?ripaHWX96IcRKTRp1OCstEn5vgkZRaS3KFGHB7YAMCT5pmyOAKTsvjox3swp?=
 =?us-ascii?Q?NTeDOakgpX7z7gb3VgqHmeJQPBRXdHjXPdrqw+S8JgP004GWCnv9yO3jqDBQ?=
 =?us-ascii?Q?uM8HqaLfeEpzcfP8XD3XPujop/ZTpfHoMC5F5j/eEHU+yZXxXq4zu7rWe9d3?=
 =?us-ascii?Q?wXjA53LPReWlAYwvljz4ylaBQr2Yrc1TtKejPFlHdQVjJTXFwHvbuPQWgkPY?=
 =?us-ascii?Q?kc0c72+12FpxGHwVndroot0CxCG1lLhlMmR0XodiabH2BwF6kp4u64l4d0/R?=
 =?us-ascii?Q?qSBCM/+Syd6eVXJYiUSSWVrdwf0E0puZ4Rt8ZCmZhwSmN6ane+bPA29Zfp+W?=
 =?us-ascii?Q?yLBkmsom26Z3+oQWdF4Uuwwl+E3M65udVt/KgZ/dVMzsoq1lmPTWoEnOGvSV?=
 =?us-ascii?Q?FkhTNes66C81SHthKyFDL9Y+IelfB19FEHhXhCi48D7ZfcV0u5MrmHBtvTmG?=
 =?us-ascii?Q?mb2qjXqJLqLoHrxr7iTC/5o3+ALDxS4NQ9+GeNr6tejZyRH/+NjTX1i7Xx0W?=
 =?us-ascii?Q?xpLz+W5LMFem7IxhrniVokHQM6XwYBd9DGD+IuTsfjKQXbvDiKXGJu8dne5M?=
 =?us-ascii?Q?oQ8AtLkaTV1Ac5Iv/YT9OsFA5G+RNLHfsKk1ym49?=
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
	GW0zudrFjH2lr4Em2wLKMIUrUUhT1H6z6sENkyLGsW7QjodYO0rx54h5p0F6J0ORevLZW8PAmSVBdg2F27CzYvxbC4CcsW69zPv11CBLFGri3J17DKHdzoc2WRRu6FOJ9cS/dEkD6uBtsMEb3WUaczx0TNzD6EZU2+6FOvmv2+CgYayy6P7Nm/TMjO/OMTwrUXnZRKMxPIkFX4tsUrsKVflQWlQ3l9b6UBsUFUNuti7QcqhSmti+I4nt3UfGUrDLZSjqWaVII30vxCfWpV9fjdUyCpNZkmtHN3LaWfNIozhwS2WfNrv4U+VSWTQ96vCfH8kgykO7+sD+FLJOtG3Q0oBGGTjYWzYP/MhRT56sFJdxD7x1r4MHQ+jkBS7DSWL+4XTUiTao8YNTx8kU74a545sK/Z3NKpyVwLMXkSMkAc36YbN+xdXE5FNRloIiaBU9pTmCsKiDoWZ7msQX4m4cDNJYat0WQ9kWODTXxF9QPxBf0bKVs4YpYkDbUhgCf6vvEHlgqdhtJShhhJYlbGeK932XTjvd36Rq92yjjopKmieyUk4SXMrX09HBkdStOcsrvsWsoDyPlTd7EZuz9+EcJdA9x2vIWc4mfM6UYIL+OIBDvWo/jlTt03TacPsX7Ek8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb60de0-1a8d-41a3-8286-08dcbb5aaa57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 05:42:05.8810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Es5rKYFFNQ3xjjEnSyBz/SYH584KPDVmIRLotb5DQ4pjARoYqC5bUqJB5nuJ51htVfT3ldN7NuFkgZt3Cpt5Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7461

> > > -182,8 +186,15 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> > > u32 ocr, u32 *rocr)
> > >         if (err)
> > >                 return err;
> > >
> > > -       if (rocr && !mmc_host_is_spi(host))
> > > -               *rocr =3D cmd.resp[0];
> > > +       if (!mmc_host_is_spi(host)) {
> > > +               if (rocr)
> > > +                       *rocr =3D cmd.resp[0];
> > > +
> > > +               if ((cmd.resp[0] & sduc_arg) =3D=3D sduc_arg)
> > > +                       host->caps2 |=3D MMC_CAP2_SD_SDUC;
> > > +               else
> > > +                       host->caps2 &=3D ~MMC_CAP2_SD_SDUC;
> >
> > I think host->caps2 is for host to claim caps, here can just call
> > mmc_card_set_ult_capacity?
> > Don't need to wait csd, because SDXC and SDHC need to identify by
> > capacity, but SDUC can be identified here And all your
> > mmc_card_is_sduc() I think change to
> > mmc_card_ult_capacity() to know the card type
> This is an interesting idea - and yes, we can do that.
> Also the line of reasoning that you provide makes a lot of sense.
> However, SDUC is not a card state, so I am not sure I should use it.
> I added it to comply with SDXC, but using the card state to imply of a ca=
rd type
> doesn't seems right.
How about extending the use of card->type for that?
e.g., adding the various SD sub-types etc.
But this needs to be done in a separate patch, probably after this series g=
et accepted.

Thanks,
Avri

>=20
> Thanks,
> Avri
>=20
> >
> > > +       }
> > >
> > >         return 0;
> > >  }
> > > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > > index
> > > 88c6a76042ee..a9c36a3e1a10 100644
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -427,6 +427,7 @@ struct mmc_host {
> > >  #define MMC_CAP2_CRYPTO                0
> > >  #endif
> > >  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC
> > > that has GPT entry at a non-standard location */
> > > +#define MMC_CAP2_SD_SDUC       (1 << 29)       /* SD over 2TB */
> > >
> > >         int                     fixed_drv_type; /* fixed driver type =
for
> > > non-removable media */
> > >
> > > @@ -638,6 +639,11 @@ static inline int mmc_card_uhs(struct mmc_card
> > > *card)
> > >                 card->host->ios.timing <=3D MMC_TIMING_UHS_DDR50;  }
> > >
> > > +static inline int mmc_card_is_sduc(struct mmc_host *host) {
> > > +       return host->caps2 & MMC_CAP2_SD_SDUC; }
> > > +
> > >  void mmc_retune_timer_stop(struct mmc_host *host);
> > >
> > >  static inline void mmc_retune_needed(struct mmc_host *host) diff
> > > --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h index
> > > 6727576a8755..865cc0ca8543 100644
> > > --- a/include/linux/mmc/sd.h
> > > +++ b/include/linux/mmc/sd.h
> > > @@ -36,6 +36,7 @@
> > >  /* OCR bit definitions */
> > >  #define SD_OCR_S18R            (1 << 24)    /* 1.8V switching reques=
t
> > > */
> > >  #define SD_ROCR_S18A           SD_OCR_S18R  /* 1.8V switching
> > > accepted by card */
> > > +#define SD_OCR_2T              (1 << 27)    /* HO2T/CO2T - SDUC
> > > support */
> > >  #define SD_OCR_XPC             (1 << 28)    /* SDXC power control */
> > >  #define SD_OCR_CCS             (1 << 30)    /* Card Capacity Status =
*/
> > >
> > > --
> > > 2.25.1

