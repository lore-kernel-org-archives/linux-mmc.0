Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B548EBE0
	for <linux-mmc@vger.kernel.org>; Sat,  5 Sep 2026 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607990; cv=fail; b=dKels05S3gIzK1IOFwWyB8flopVrfULHNiMBu28itGzA+TCCAU6OEcV1xmVOfB+bRgZyT1aptZv6g5UzgOYl7BfkY61TEh8vBElori0eaZrYmDBP3sCXehnecVOVi8/O1FxBXCgz0xDs2SAGi8PzthkD2i1wKkrEuCJkb78aGp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607990; c=relaxed/simple;
	bh=aeFTuKjfkIA9gVanlpCZrv+nwvGhGcoHEDU1/B81+rQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gnPT6Ik8jj0SnzMzJe4l9azWKzognOEegsylpPJbfMJ/S8INUpoA5nTr41bTUjZAq79pkAoOSC8zNxofzwN57RxJ4IAjRs5WTAIQW8/li+dilo91DCM86YvIabCeApr1PXx2k5CsRKRBk4MM/Kv5rXxqmvxTqcnIjVwz3LsTMHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=NPN51Dl0; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="NPN51Dl0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1788607989; x=1820143989;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aeFTuKjfkIA9gVanlpCZrv+nwvGhGcoHEDU1/B81+rQ=;
  b=NPN51Dl05XY8Z4Y0biPsA2Gx5Miai7NsgH/4t05tjJbYq1zQWCEki1K6
   Lvk1u8u4FIre1A65HLqISwhqeuQhAH+wa1/E1aGA9nwYann/nMTFB4Gys
   NZ6zYAKTy4HdoSU4zB0UcCBoT6KQwmMZPmelKKwfJAqMBUvCP93e761qs
   F26HhZOs1ieM86aIG6UidNK25wcjfKNDOAWpFybaQIDIspcWZYK8w9Ifg
   F+omZD+FbOB1OAGlFubpl809ZHYheE36N+lTZ87NjC8W50V+MHhR3VKUe
   S0ricTUp1ygEuSrLuLXu9TCrEEItiz/qAW+Wfmtqcziu15diuZf1ikDh1
   w==;
X-CSE-ConnectionGUID: 36cdRGVmRHa6HkfjhXLGdw==
X-CSE-MsgGUID: MatspxL8SUWSG/MCCnHHHg==
X-IronPort-RemoteIP: 40.107.208.124
X-IronPort-MID: 29765559
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westus3azon11021124.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.124])
  by ob1.hc6817-7.iphmx.com with ESMTP; 05 Sep 2026 04:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnThIDoW4897GsCQ5REtaZc7cRUFazJmpmADx1Z4w0AVG24RqafPiIPB2XKMbonYqXFcceTO6eM8uOZzmDktGpiadKjDGTlOyxBaxsvkd4WY1bAj2ssIjf0maB8P099BqFOzv0kNcT/H5iYOoMJ9dgxYhmkIcXI5FgH69Tj09Y0E96Gavl5wdM1AR2nQ323wzZNQNSe0VYEg2d+t520iSikOvh8KpolMjl1Gn5Q+qvsw/9TygvGynzdDZa6ychM1/Izii+tKJcxM7h6GA6qVh0xfNo9jPJfaVhnV0u7FLaPHu87Fj2JHkuEC/dcP+EWY2q2aXfx3MRjJLPLtcuSdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHBryDq/TyFa2h1g/PiNPN2R0U7UUO7LK3cUCTlswF0=;
 b=iCoOqaSZHpwHylQtVTcAKlJTaR24pC7JLrKw4wjHZse17EWdL/7DmmDwdGpgtEfXaYpmuQZZeBwFVGmO40Ax+P6CILredomk7ocTckDn1PaVVrgIDX6UKIASNUtib+TyWNRi5TIpQZ4aRvw6sJ6gNTjKcjUGXmMP4fUs33CRvugPAvek8TddTYAUqTWvow8Kt0NbcLi6Ad3EA6IEogzO/GaMmfXWJblO7mxrTzUPNR4d0eF//3wjCQcMred6eII+1ng7qWa7fqiYX3IxWE5cDlMuetqLEjA2MPMYrg7fXYjDn/UhJjOx89EN5V4hAcc2lZGtrBXE+LeIZaaHnd55SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 LV3PR16MB5600.namprd16.prod.outlook.com (2603:10b6:408:1d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Sat, 5 Sep
 2026 11:33:00 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.21.0382.007; Sat, 5 Sep 2026
 11:33:00 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin
	<shawn.lin@linux.dev>
Subject: RE: [PATCH] mmc-utils: Add health command for eMMC health reporting
Thread-Topic: [PATCH] mmc-utils: Add health command for eMMC health reporting
Thread-Index: AQHdPGmoGtsQkfbfhEqLw78G6hZ6Y7a/0HqA
Date: Sat, 5 Sep 2026 11:32:59 +0000
Message-ID:
 <DS1PR16MB6753DA98DCC26E114D325284E5B42@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <1788525214-40803-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1788525214-40803-1-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|LV3PR16MB5600:EE_
x-ms-office365-filtering-correlation-id: 2bd79f96-5ae6-49db-192f-08df0b41709c
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|38070700021|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003|55112099003;
x-microsoft-antispam-message-info:
 RecrW4ouDiUqkqoIbt644gdByA/4RpmnCFT2jMYB9JtxOFIywx7J1IaOZt3Wi+OEHn+0uwwa7QKqBc+pJi4NWfzEbPqXQZi1gVSg7b1tUxB6dovnOfccHuyinZRI6kyzBW699O03Gxw8C2/RlwrsFfT6u0PONlHvMwBBg9R6CX/4jsyHS3poy3/+82aXb+ikXQxz3n+Z5WA/o84+p8KaDoyIJ7VjTVBq6uWzIxb8AucIdMPdwyo4Q28rJfz2zI2JedQUKrd9KNRrJY5EVr+tgf5qvH01cvKFErupijbinjzyRY/ywQESbfU+YbjMLeAOVR0Vw1Q2xUwDDk63ns2Ou7YKNrLJYsKYa/qWcUl4GBvyoMnmFuxVkDi78PIDzzxgQ0C7m+O/7BtQ++K+hQOD3Awb+iUbXXjdVhcumwREH1+JM0KhEOzxIntWLa7p8nbeZPXJ1TaIO1Z+X8z6Ooru5fIVxqtpuH8l4QFRNek/tf1a9BTvlzioG+xq5Ho9h2HBg4mXTCnsgEz6ZcjPz24M/Vqiy5cHE+3VS9YFmjlu3y2uAoFv4nWPaP1gaJ3DL7t9OIUaB0cIamS53RT9Da09UKlhekIi0clHI26qYaHyMp/58BoJHq/0eafaodfSMulng1g4sl6mrbEbNRz610VC29B2CuBCqEVAsIg2X/HY6W5MTPuiGSfcZudAbl0ednGv8JnR7zgVIh8IvFF+YW6oz4NJOMi0y4UxTD8OIMsECi0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(38070700021)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FSJ557C5/HodrHEzbHvjjMp/XdDp/GIDQy/g/yJopR9KaJrzJ4JcWcP47r8+?=
 =?us-ascii?Q?5csDY8d39LmBc1gqy9YOWzHDJhXo7PWHA3TOs1hQCdNqNlJh4m+UpN4uv0wV?=
 =?us-ascii?Q?L+MPWn+S86Odgo1WqnaeNYRAqHyu6aOPePBsHvvGMCBwvh3i6vQuHadM1ve6?=
 =?us-ascii?Q?0Gad3CKXtPczorBkG37pVWy8ACr4iH8mBIPO2VRwXWis6J3N2dbimhY6gzeL?=
 =?us-ascii?Q?iX1L3UOzi1dKpuSaTf2ziGIztHFbhmMOa74seUU1XHfwia+S0JwHLTbBAJUG?=
 =?us-ascii?Q?vzgX1IqWDyqMSQtGozdr6aUpp1WfFeFUde52dyZjtq9n9koeCRLOZETmyy1B?=
 =?us-ascii?Q?T22VYYrLQzMeNVgsNm9i1yNelYv7TQbsX1v7Velp3yy6ZUfDKNdwzWz6s2BN?=
 =?us-ascii?Q?XWV+XIV5NsoDlM4bj2DCw8R0uv/Rwgj9f1xUiohk7IKF/rhtHUoMWqQKSMaF?=
 =?us-ascii?Q?y5p29gk3t6FVEMNqUCw9srek2KHSqPwS8sPqgE2GVTL/dvBLJSt/DGnxCI9D?=
 =?us-ascii?Q?qpGf9Bsp1X3s9YEZP3pQz0pEk+uktVYTFsXgjbpQWnUOPJ6/N6fYd5LrFiEP?=
 =?us-ascii?Q?HIc5eesqlchCRAPXV5aLv4nhbEcn8j/EAFhr/avO5yWjV3U3YAsuhjxVHq/8?=
 =?us-ascii?Q?MpSKxd5J9O7wNXW+G+X9p+0ghDV2zZcuceCIEC5+LoiA5D7laELZG2OyM30t?=
 =?us-ascii?Q?cWVaLqemmCeZ1DY8cvv6Xl7AJ+aIArSzh/3395iiJkBQfbmnRzYCYgYfXLS1?=
 =?us-ascii?Q?xCJgZt/qVSCZpPQJ/u2vE5YEN2j4e6bQ41pJ+W1zJasgj/RlOoUpEmROdtpM?=
 =?us-ascii?Q?EHkv902s0XQJEUUc98Zlsmgo1AK3RADrrMN3qshgjvdPO9PvJp6KZlVS1YTr?=
 =?us-ascii?Q?vThHhAGaKaO1pJw0/3JiClHVSCNA5+tlOw8JiijdMZKT7zfvahYngbeRfoVf?=
 =?us-ascii?Q?FRzrMTzMd1mkfvTfSMctM11X4tfhScjQZUvtUU/BhaeN0RRaMfjajKTFaMTM?=
 =?us-ascii?Q?wxy5/5KZNb1W3K2v5VtncHcOY9ei4MF08jTHxKwR1wl5aStyB5thr8smIQBx?=
 =?us-ascii?Q?e55AhHOnrR5Gt1gGEh9WMjqJ4JvCq/D2GotVPWLAsbIqV+8S7QKODJqFdczX?=
 =?us-ascii?Q?k5JjNExCbDBsYDJJgVK8+1nS5pj6EL+ibyy/IxijxKzVoN0hUvW/DpT8j5yv?=
 =?us-ascii?Q?/AIRTbC+meHl7RM0kGAhwt9oWdM1qBw/rjJ/ieOteHsr9ihALB+FvcTNPCUt?=
 =?us-ascii?Q?tG1WcWh+dOV6fdjOXqTBNrV/iJcrfziHW1zXQE+nTzwbkBh+vjYfjsX21+Dk?=
 =?us-ascii?Q?+MTqlS3Ni1ei+loMB6T878GTnEXBSB2m16zFm4LldG+JEHQ/hXagYk86EkA8?=
 =?us-ascii?Q?Mxbq7e3YUwobByLPx5I2fISYu5aLhbazpE9uH5KorA63oZa/rQxI+2tyRKzF?=
 =?us-ascii?Q?/pbnHxtA9kzh8p3vgkyJgZbfetDydoWG2ih6qQ3Ym+9aLgTXcXGIljxPhPUF?=
 =?us-ascii?Q?i0PoIuhJYDWTcBJwO3eSbFOV3BRSVJTyF6Juyhelx4t1MxBV5/icqIIRclmQ?=
 =?us-ascii?Q?oIgLD2BphG1wl+BSFUyYdSx3K2gSUlgI6Lgt8zILF8NzsahDLaBXNSGANUv6?=
 =?us-ascii?Q?DyxdWEPSjDhVyPdeTOWztAjelc2hwAJ9N8K/gilpC+noI40gQOZZrHRnnYQx?=
 =?us-ascii?Q?3RhM4lw6gzACgZ2ZOKjgXqoo3S+iiKw0S99HU6CZYwxPaL6+mQQrc+VW5ReM?=
 =?us-ascii?Q?PuiY1nKULZ8TAdq2LRy7V1SJXhCUaeGLObguoBR44LBbvEmR41E1b4R0Xh6V?=
x-ms-exchange-antispam-messagedata-1: y8HmQiMhEDXxuA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Cj1EITu2ntB/oe+zFI4yrh82E0D8JriABNzkkas3PePp5Udvt7FYMZ8Y5SFb/fos0qzRr2rac5X2sD8L7ggOz0sbCbiy4vcpwZ2nPGVvVEQVs5aLjjjAl5lJ/QPV8XfCt6o0zhcY5JKhlWiIsbcMm4OJ7WrtniB6B3/7lUCaMj+nVbMQPWfq+xJ+rtHYZWRYc+3f994yJOzABHdhJOXZN6Hzo1/gw2J4xXX00F13mr2YBuhf1aiuh6H79xbwsMTTXp29sPrW90oKvGAwZWWdyVqF1dXHNhtiPA4Dgv4hV9itN5J76MWYjmvQ9MOlsgemyVdqknWdzcyW5TAAJ0KHCQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MmysrVHcT053Z2mdLjG7X6e00nylbUyN5OKSx5i0Qt1WOLWJTypgp4Ahy2TaBrsaI4urB5BVQcPHm4uFMhvURIFfc1oUi5ppzx3M5bw1BS70Xkn0obM5Te67ISJc+emRmT8RgtHf8lP1RhPxrNwDn8p9scZagJ8DS+7LU/cqBWtzr9hjR3z+s+Ft8qk6ohw5jzVjiiZRYhAdgL/pu07uiuOwYx5F11BlWqwlJHUf/O99UFbR014zTxXm92/Qoqd8tiJlgH34TIORZaLxFsWePak3/p52PcKcPL5ChF7wovFumQ1LXgLBGEB0b8jRE9mP557/LvjVVoA2J+ewBaEXsjiIn98fP7preHAEz4pPFyEx+awT6lRjiE1GwT37qcrmN5d4SYcKjtsrPUx2R/nURwLwKhCmNPYhsEzc2TWeF/AFgo0pPLfAv/A7GvNUw5iaMugPDnZVX1ScTRHCV8mFI4iL7Ff1GWMxfexH89BIuxKZ121pgPilbKYDglml5hN37PN+x/6iBGn1TzVnOB5HctLs3SmHK2ETZUjuJfoN51FvNq2YCKaPZPo5bcKxTrnU3uKLcRrOPM/OwejEDQl+TRCeZ52PNddYnF6D0FnEk4GG1bv7UY1t+j2aVt2t1JT/fN1N6pcMqeKUjkGCu690yg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd79f96-5ae6-49db-192f-08df0b41709c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2026 11:32:59.9790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rIsCgqzZCXlmdDrho328AmA5oIhfQ+ncE8dYEOqq+wOMVPSmHEwepnAVJhYOvkuqGqDTX8Lyp3ywOvKof33/3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR16MB5600

> From: Shawn Lin <shawn.lin@linux.dev>
>=20
> Add a "mmc health <device>" command that prints a health summary of an
> eMMC device: Pre EOL info, device life time estimates (type A and B) and =
BKOPS
> status, each with a human readable decode of the raw field, plus a final =
verdict
> line.
>=20
> The per-field values and their level semantics come from the eMMC 5.0 spe=
c
> (JESD84-B50, EXT_CSD fields 267/268/269/33); the aggregated verdict takes=
 the
> worst of the three wear related fields and maps it onto an exit code, so =
the
> command can be used directly from production test scripts and CI:
>=20
>   0 healthy, 1 warning, 2 urgent, 3 unsupported (eMMC < 5.0),
>   4 not an eMMC device (EXT_CSD read failed).
If you are inventing a device health measure, better make sure to clearly i=
ndicate that this is mmc-utils's own indicator.
Also, worth mentioning VENDOR_PROPRIETARY_HEALTH_REPORT [301-270], and CMD5=
6 in the commit log.

>=20
> The command is eMMC only: SD cards do not have EXT_CSD and do not report
> any standardized health data.
>=20
> Execution effect on an eMMC 5.1 device:
>=20
>   # mmc health /dev/block/mmcblk0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     eMMC Health Report: /dev/block/mmcblk0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   eMMC rev:         1.8 (MMC 5.1)
>   Pre EOL info:     0x01 [Normal]
>   Life time type A: 0x01 [0%-10% of device life time used]
>   Life time type B: 0x01 [0%-10% of device life time used]
>   BKOPS status:     0x01 [Level 1: background operation required (non-urg=
ent)]
>   Result: HEALTHY
>=20
> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
> ---
>  mmc.c      |   8 +++
>  mmc.h      |   1 +
>  mmc_cmds.c | 165
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   1 +
>  4 files changed, 175 insertions(+)
>=20
> diff --git a/mmc.c b/mmc.c
> index b0f1f9b..e0fc0e8 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -106,6 +106,14 @@ static struct Command commands[] =3D {
>           "status get", "<device>\n"
>           "Print the response to STATUS_SEND (CMD13).",
>         },
> +       { do_health, -1,
> +         "health", "<device>\n"
> +         "Print a health summary of the eMMC <device>: Pre EOL info,\n"
> +         "device life time estimates and BKOPS status. eMMC only, SD\n"
> +         "cards do not report health data.\n"
> +         "Exit code: 0 healthy, 1 warning, 2 urgent, 3 unsupported\n"
> +         "(eMMC < 5.0), 4 not an eMMC device.",
> +       },
>         { do_write_boot_en, -3,
>           "bootpart enable", "<boot_partition> " "<send_ack> " "<device>\=
n"
>                 "Enable the boot partition for the <device>.\nDisable the=
 boot partition
> for the <device> if <boot_partition> is set to 0.\nTo receive acknowledgm=
ent of
> boot from the card set <send_ack>\nto 1, else set it to 0.", diff --git a=
/mmc.h
> b/mmc.h index 2bb346b..af0ad87 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -120,6 +120,7 @@
>  #define EXT_CSD_WR_REL_SET             167
>  #define EXT_CSD_WR_REL_PARAM           166
>  #define EXT_CSD_SANITIZE_START         165
> +#define EXT_CSD_BKOPS_STATUS           33      /* RO */
BKOPS_STATUS [246]

>  #define EXT_CSD_BKOPS_EN               163     /* R/W */
>  #define EXT_CSD_RST_N_FUNCTION         162     /* R/W */
>  #define EXT_CSD_PARTITIONING_SUPPORT   160     /* RO */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index a7e4784..43dcdcc 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -981,6 +981,171 @@ out_free:
>         return ret;
>  }
>=20
> +static const char *extcsd_rev_to_string(__u8 rev) {
Already in do_read_extcsd, maybe factor it out (as a preparatory patch) ?

> +       switch (rev) {
> +       case 9:
> +       case 8:
> +               return "5.1";
> +       case 7:
> +               return "5.0";
> +       case 6:
> +               return "4.5";
> +       case 5:
> +               return "4.41";
> +       case 3:
> +               return "4.3";
> +       case 2:
> +               return "4.2";
> +       case 1:
> +               return "4.1";
> +       case 0:
> +               return "4.0";
> +       default:
> +               return "unknown";
> +       }
> +}
> +
> +static const char *pre_eol_info_to_string(__u8 val) {
> +       switch (val) {
> +       case 0x00:
> +               return "Not defined";
> +       case 0x01:
> +               return "Normal";
> +       case 0x02:
> +               return "Warning: reserved blocks are consumed";
Consumed 80% of reserved block

> +       case 0x03:
> +               return "Urgent: reserved blocks are exhausted";
The spec gives no description at all for 0x03 aside of urgent.

> +       default:
> +               return "Reserved";
> +       }
> +}
> +
> +static const char *life_time_est_to_string(__u8 val) {
> +       static const char * const strs[] =3D {
> +               "Not defined",                                     /* 0x0=
0 */
> +               "0%-10% of device life time used",                 /* 0x0=
1 */
> +               "10%-20% of device life time used",                /* 0x0=
2 */
> +               "20%-30% of device life time used",                /* 0x0=
3 */
> +               "30%-40% of device life time used",                /* 0x0=
4 */
> +               "40%-50% of device life time used",                /* 0x0=
5 */
> +               "50%-60% of device life time used",                /* 0x0=
6 */
> +               "60%-70% of device life time used",                /* 0x0=
7 */
> +               "70%-80% of device life time used",                /* 0x0=
8 */
> +               "80%-90% of device life time used",                /* 0x0=
9 */
> +               "90%-100% of device life time used",               /* 0x0=
A */
> +               "Exceeded the maximum estimated device life time", /* 0x0=
B */
> +       };
> +
> +       if (val > 0x0B)
> +               return "Reserved";
> +
> +       return strs[val];
> +}
> +
> +static const char *bkops_status_to_string(__u8 val) {
> +       switch (val) {
> +       case 0x00:
> +               return "No background operation required";
> +       case 0x01:
> +               return "Level 1: background operation required (non-urgen=
t)";
> +       case 0x02:
> +               return "Level 2: background operation required (performan=
ce
> impacted)";
> +       case 0x03:
> +               return "Level 3: background operation required (urgent)";
> +       default:
> +               return "Reserved";
> +       }
> +}
> +
> +/*
> + * Print a health summary of the device. Exit codes:
> + *   0 healthy (or no degradation reported)
> + *   1 warning level
> + *   2 urgent level
> + *   3 health data not supported (eMMC < 5.0)
> + *   4 not an eMMC device (EXT_CSD read failed)
> + * Only meaningful for eMMC; SD cards do not report health data.
> + */
> +int do_health(int nargs, char **argv)
> +{
> +       __u8 ext_csd[512], ext_csd_rev, pre_eol, life_typ_a, life_typ_b, =
bkops;
> +       int fd, ret;
> +       char *device;
> +
> +       if (nargs !=3D 2) {
> +               print_usage(do_health);
> +               exit(1);
> +       }
> +
> +       device =3D argv[1];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       ret =3D read_extcsd(fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s, "
> +                               "not an eMMC device?\n", device);
> +               close(fd);
> +               exit(4);
> +       }
> +
> +       ext_csd_rev =3D ext_csd[EXT_CSD_REV];
> +       pre_eol =3D ext_csd[EXT_CSD_PRE_EOL_INFO];
> +       life_typ_a =3D ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A];
> +       life_typ_b =3D ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B];
> +       bkops =3D ext_csd[EXT_CSD_BKOPS_STATUS];
only bits [1:0] are defined, better mask?  ext_csd[EXT_CSD_BKOPS_STATUS] & =
3

> +
> +       printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D\n");
> +       printf("  eMMC Health Report: %s\n", device);
> +       printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D\n");
> +       printf("eMMC rev:         1.%d (MMC %s)\n", ext_csd_rev,
> +              extcsd_rev_to_string(ext_csd_rev));
eMMC rev:  --> Extended CSD rev=20

> +       printf("Pre EOL info:     0x%02x [%s]\n", pre_eol,
> +              pre_eol_info_to_string(pre_eol));
> +       printf("Life time type A: 0x%02x [%s]\n", life_typ_a,
> +              life_time_est_to_string(life_typ_a));
> +       printf("Life time type B: 0x%02x [%s]\n", life_typ_b,
> +              life_time_est_to_string(life_typ_b));
> +       printf("BKOPS status:     0x%02x [%s]\n", bkops,
> +              bkops_status_to_string(bkops));
> +
> +       if (ext_csd_rev < 7) {
EXT_CSD_REV_V5_0

> +               printf("Result: UNSUPPORTED (health data requires eMMC 5.=
0)\n");
But you already printed the health fields...

> +               ret =3D 3;
> +               goto out;
> +       }
> +
> +       if (pre_eol =3D=3D 0x03 || life_typ_a =3D=3D 0x0B || life_typ_b =
=3D=3D 0x0B) {
> +               printf("Result: URGENT\n");
> +               ret =3D 2;
> +       } else if (pre_eol =3D=3D 0x02 || life_typ_a =3D=3D 0x0A ||
> +                  life_typ_b =3D=3D 0x0A) {
> +               printf("Result: WARNING\n");
> +               ret =3D 1;
Collides with exit(1).
So what it would be: "the device has a wear warning" or "the command failed=
" ?

Thanks,
Avri
> +       } else if (pre_eol =3D=3D 0x00 && life_typ_a =3D=3D 0x00 &&
> +                  life_typ_b =3D=3D 0x00) {
> +               printf("Result: UNKNOWN (device does not report health da=
ta)\n");
> +       } else {
> +               printf("Result: HEALTHY\n");
> +       }
> +
> +       if (bkops =3D=3D 0x03)
> +               printf("Note: urgent background operation is pending, "
> +                      "do not power off the device right now\n");
> +
> +out:
> +       close(fd);
> +       return ret;
> +}
> +
>  static unsigned int get_sector_count(__u8 *ext_csd)  {
>         return (ext_csd[EXT_CSD_SEC_COUNT_3] << 24) | diff --git a/mmc_cm=
ds.h
> b/mmc_cmds.h index 033cc09..88caf85 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -39,6 +39,7 @@ int do_hwreset_en(int nargs, char **argv);  int
> do_hwreset_dis(int nargs, char **argv);  int do_sanitize(int nargs, char =
**argv);
> int do_status_get(int nargs, char **argv);
> +int do_health(int nargs, char **argv);
>  int do_create_gp_partition(int nargs, char **argv);  int do_enh_area_set=
(int
> nargs, char **argv);  int do_write_reliability_set(int nargs, char **argv=
);
> --
> 2.25.1

