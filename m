Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99A85654
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658004; cv=fail; b=PQOhT2NlfE+9Tbg/q2y8DrlMYEovNOSOzBmUEDF6z8FKxUWKJ7/mUqmmeBgsW5fGMK34nxf6pblwjrQVl7YXTVF4/PDLZlh8HFjUj7nJ3ckKscsX6G7qMLZI5NFAeKggL1kxRenF7fAVOQ7LntNM49lzxA8DS968yw3MAtICuUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658004; c=relaxed/simple;
	bh=gWe4Rl9jAXBIzXA+UlRburh8EjKwwLhE3s2x/52rg2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hruq/w3krPJpvG52vLiVw33FvMGYeuwFcYuFIxEQAJt+P/XlTaMuBicoalA9A/Fd6+RzckpYLChiwjVpqr+br9APlv/jjDq5S99VLvEM7/mtfHBTWSnQKLzDb4uFC/kARk7mnt6PJNhUUgOlLI1dKK39DRDiagCDRnywnacnigo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nt9i+L/y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vhRVag1l; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nt9i+L/y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vhRVag1l"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724658003; x=1756194003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gWe4Rl9jAXBIzXA+UlRburh8EjKwwLhE3s2x/52rg2s=;
  b=nt9i+L/y31hHhyWZLqotkzwyizv9UBWxPkrBjN+I7b2wTkON9i6ROqg8
   fCdFe8YbD8y9XrwOZ7NBm9kdfHWhB1xWBUJkv7Em86ylbyf/N6ZU/66Ke
   5XfbKtlLX9JNzgwnJHGxxSwL97Eih3Ln0d3oSYuzyl48ucUp8qWMHTci/
   98KGHA6yLZeFr/Y48JcGYoLsxNXdPR/Ca5mBwTha4T22d/Pv/cXeqfWPK
   9AeBxyXwoW6zK2rQV5Gb5glVbTdozRr20fe5mpM1m48cVJMHrhuHITvZ8
   1rdqZ2M3RZnwXKfYzZRi8C1THy9wVd0lpIKGaDuhIHzoEXqAPGb+ZmV3b
   w==;
X-CSE-ConnectionGUID: 1yzPTzsZQnCaGFK3LW6UGQ==
X-CSE-MsgGUID: WFW3HygNTu2Uvx3vzjVFSw==
X-IronPort-AV: E=Sophos;i="6.10,176,1719849600"; 
   d="scan'208";a="25161591"
Received: from mail-eastus2azlp17011025.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.25])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2024 15:40:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9wGnrZ3HY4uxklo+VpXJhHeOnVPEOhSrpOoAdDK6E26/qUAR2LDUNUKWOkHSx++AH9xI07qzUKo76m+1pvBaD/KuAG8ozv1IagJbvILDohf10C2iU95yMYi+aNQrGMkamR+Cs4620dVTlj4Tpz94nFvGniTrvBXUY5b/QxXrlATKdeWogr6JldtiMugdGJk80LcUj6j0wTltE0kDIFWOBuUy3nwX1CYUPU4bSVr60LejwW5PyzGotWf5HEB0dJvwr5EctUsNctt65f8JKrc3Vl52l8vey2nd7Q82BF1KtHPoodHBBif8N1ItuaSDMpvHSnCTRaGwcOck8u5DvHggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWe4Rl9jAXBIzXA+UlRburh8EjKwwLhE3s2x/52rg2s=;
 b=KwxxabsaVyXzwOhZwekG1iQxrT2P4ccA9gGW7MyZgUOfXdXPqQZCgp3xaVWvIbVLvxb/hmchEcqBFJpATTCcRAq8PDYnXLejIbbLGg3eWmt7CJ/VbrOZNTnA7/MesqOnsk1xzhF/tC3kHBegvBUlJuTDCu68cA7MiBqc/ZEaJvPIN1Q8GWjJP6hzuiNd5iJOrcLrY+Z9KWDCN7nvYVrMirJXih9LfH5dIODnIiO/xTUUSPK3fZYNIbRk+khnxMRqea5ox/BRYka9vIIWekKqW7Lu+3MV2WUpM2M4jps9p8IUZe+tVQcsHcShhdMEubiTWH6mzldUgumKCXMk3S/wMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWe4Rl9jAXBIzXA+UlRburh8EjKwwLhE3s2x/52rg2s=;
 b=vhRVag1l2nmq/2UZR6cbH8BFfsg8w9nMABmFb1kE8mByc/Ps98SV7U87T6dUJf6YPjpp+ws2hJq6oLY7GcsEPmcT+RZ8/UMhNWyE3k6YF3J2wlqxdQFuVZ+rw2rj9jIXjYJQxYknpX3JuAyvIeT41oudFPfsHVCCUgrzJBKsN7Y=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH3PR04MB8874.namprd04.prod.outlook.com (2603:10b6:610:17a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Mon, 26 Aug 2024 07:39:55 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:39:55 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v4 9/9] mmc: core: Adjust ACMD22 to SDUC
Thread-Topic: [PATCH v4 9/9] mmc: core: Adjust ACMD22 to SDUC
Thread-Index: AQHa9sKKQsTDeM+JmE6NeIZbweHgSrI5FpSAgAAKakCAAAZjgIAAAHKA
Date: Mon, 26 Aug 2024 07:39:55 +0000
Message-ID:
 <DM6PR04MB65759160C48C45D17F2C79BBFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <20240825074141.3171549-10-avri.altman@wdc.com>
 <9e2bf183-17a6-42a0-ba60-4a2384e53ca8@intel.com>
 <DM6PR04MB6575F070F4F18224617209EAFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <21353874-2384-47f7-9a9a-bdaeec1ba13c@intel.com>
In-Reply-To: <21353874-2384-47f7-9a9a-bdaeec1ba13c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH3PR04MB8874:EE_
x-ms-office365-filtering-correlation-id: ba799f86-6689-441e-6abd-08dcc5a2478e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHAzNFhtKzVoVzZRa0JSNWw2cFFGbzNwZ3BXQkxjRjIwOUFCU2xHWlFRVDhV?=
 =?utf-8?B?bms3MHo2SWZ0QkV2aHU0Si9Yb0I5dUkyVWNmVUl1T3NkQTlLRENkcXpLNXl0?=
 =?utf-8?B?YUNmUGxlWGg3Wkk4c0J3dHBXWnNNQkxwdURsWCtTK2k3VDZ0N0RKMVdjVVJy?=
 =?utf-8?B?ZTQ4VjQzQlVKb2FIa09wSlRDcnA5VU41Y3ZrckN2Q1A3NzFQc0JNQW1hRFZo?=
 =?utf-8?B?TEdBZE1qbVNNZTJPN2hPR042WTJ3ODAybHdmM21FbWVQTXdXcGk2UUt0KzNi?=
 =?utf-8?B?UGlsUENlRDArVXhJVlBlaVFPdnRPaElFZ2RYNjA3cThEK3dneDB5N1FQNGMv?=
 =?utf-8?B?WWEzQzR3SjFOamtWUWRYMVl1RjhVU1MwU215RmZCSUpBazBHblhYN3kyUEdL?=
 =?utf-8?B?cFBobkNIb2JQaDBFb1p3VnMvLzVmOUk5MUtFd0tMNDYrb1FZZmlQeEVmRzlt?=
 =?utf-8?B?MkluTHl5em9nV2dJQjdITVBFMzFFdkpodE5uS2V1VlQzRFZKbFh5dEhGSXlC?=
 =?utf-8?B?dkdpWXE3bkFtV1ZaQTh6WGFoYjBUWlVQWXA1SkZ2eU5GU0xJUERQdHBRQXNN?=
 =?utf-8?B?VUlGWGdMLytyVW9oOVBtbjRtUk9GV1VRQ2Nha2JROGFYRU5rSDg4L09jRDF1?=
 =?utf-8?B?MTlLOEZWTENTVTRrYjZFb1Q0MlJLUDdwb0ZFVzdUaG0zUmpQd0VPNmlFQk1L?=
 =?utf-8?B?Q3I1TG45a0xSeGtqNHA4c1g0Q29UVHJ0eEZoenY5d0lDSUpiN3Q1em5Mdi9s?=
 =?utf-8?B?VWZMdEJmRmZlK2t0MkcrV3FaeklqZiswa2ZTYzd6TVNGZlhXTFpQeHIrS3Ns?=
 =?utf-8?B?OFJwTitWZnA5a3lVRmMyb0JQREltTTQvMEJ0a09RYUs1VFFTQ1lnSXZ6OGJq?=
 =?utf-8?B?VG1ERDdCNVNrU3JtWk4xZlk1OWJLSUZTbUFpVmJPR29VM2RkTVVUbmNRWmN6?=
 =?utf-8?B?NjJVdFFRRWt2VzZweXBhTTdpUUQ4RnZmOS9Vbi9hRVl6OWZGMmVBWHkxbjJT?=
 =?utf-8?B?cG9zSEpVYk5GQmp4MThkODZkRTJGSHhpMXMzSXJOMEtpLzVCWVBXMHNrdjhi?=
 =?utf-8?B?K1luUTBhRHoyTW40UjFoemROd2pVQ3BTM1FkQlg0OVNibXBGWXVUMXdJY1lC?=
 =?utf-8?B?UXUwWG1GVmRxWnlHQ2pFeVp4UCtrazBVcXpuMXJWdkZGNGN3Qko2TkNMWVNX?=
 =?utf-8?B?cHJjV2JYNmdjL05MV1FOd3pBWjNYVzYyMTlldnhyWjJrTGxPZnhSWW45dlFx?=
 =?utf-8?B?VmwvdHp4OVhXOFZtQUJxaGd2UXhaMXlZb21HcmJuK1hJc0FXUGFoTHFhS0ht?=
 =?utf-8?B?dE55RkdNR3ZuVWRpdkxieVpWUUpYZGtwbGVXck55RldsU3RVb2lpcCtudWtC?=
 =?utf-8?B?cERNNm5RL2NsSzFlU2RoZE9aRzNTamRtb1FUL1NNM2RwZmJKSXhyMnpvNHBj?=
 =?utf-8?B?YUg2QlhEZzRnN0R4QXJ6RThDeWJNSUZrMUZ5amFwU3M5VHh4ZjdPdGJIdTZi?=
 =?utf-8?B?Y1RZU1FpYjEveGREWm1rdlBybm03aHZEQmh2bVhSTHJRTDg3OHBFSFRBeVIz?=
 =?utf-8?B?SldTNlJHYnZ3V0JWcWwyREdpZDhhbHVwK3BUOXdHVDNNdERKZzFTRkhEbW1q?=
 =?utf-8?B?N2VFTzJFc2hvY0dIRUR4TVVmMnZ2b0hVWVJhaVZlSUlnMlZ3NVlKVFMxNGEx?=
 =?utf-8?B?M2pPMlBzVTF5Sm10bEF5Z1NWdnUzdUYzZHBIUHV6VFdyQ3RmWjRBa3p5czk3?=
 =?utf-8?B?Zmp6eGJHa2V6Y2tSMGpSVDB4NU1YYlg3eVFkdExtRlRSU1FjTks5dmJQOE9L?=
 =?utf-8?B?dWxkbVc5aVJHSGswdklCZFliQlNsaUw2ZmFoWnBkTlRQV3pxY0t0VGpoM296?=
 =?utf-8?B?TzFCQitZV2pOL3Z2bm1rMWtjZFFUakhoYWp4ZGkzRzh4Wnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVMvQWk2cTEyV1pBOUp5VDBDL21sWWwzOGN0NURueEZPZHhPUHFUSGFublp5?=
 =?utf-8?B?T1ExOUVlYlpUNzNuN1ZydTlLa1F5bXdUckpWenNGNjB2OXRxaVJNcmZyd0Fu?=
 =?utf-8?B?WGlVbWJ3bnhyTjc0OGE3OG5jRTEyaUFIQXlpVVVudTdvenZNK3VEdUh0ZVVM?=
 =?utf-8?B?SXBBaVhGZENMTE1mOFYvNE95MHFIZnZrSFNDcTRHaHdSeitpdWhOd2tQSHR3?=
 =?utf-8?B?L3ZFNDZLb1BKVUp2UFY4VDFqOVFJUjdoVUpNeWZ5YjdqYnVuWEpabXZSc1RL?=
 =?utf-8?B?THJrdkdMUncyK0tIT2R0OFlnOWk2Nmp3dkViek1IYmFvd2JvR1dhNkpmemRo?=
 =?utf-8?B?TDhWZnZMU1FwOXl5Z1RuTG93ditCYmxYc2N2WndXWE96THpDRE5BMVZwcUdi?=
 =?utf-8?B?aWVDWTVJTXdzM28weXJyNXd5WGhOajluVXVyQVp0OXR1djgydVZVRGpIc0lG?=
 =?utf-8?B?OFJ5ZDZCeDh2YjYzT3dKT0JpZEZ1MFptN2VxTmoxNHVhT1EwNGZsdEhnYlFi?=
 =?utf-8?B?NFBWSE92U29vMHdWNnJTTWhtcUlKamlqQ2N5MytMbVdIMFErdnhCR1BzandW?=
 =?utf-8?B?OHlycWdndWFLbGxodkxjOUxLTkRzck1VOUFpTHlYYytaMWVTTXNiSmg2NkFj?=
 =?utf-8?B?OWQ0SVIwN05mKytFVHBCSWh1dlJyT0EyRDBDbjhxQlZId1ZDZnJkQXh0akd5?=
 =?utf-8?B?cWR2YytnRmpqVzVibHU4eWRsSTgvTXRmU3ZMQk0yU3MwVGRsNzRiQ0c3a2VI?=
 =?utf-8?B?d0hUejh3b3pDQUtKbEVkRG9kSmtxblZhQlhsY0RMMDRhWmZtNHI0N1JVeFkz?=
 =?utf-8?B?MTNjUGNRelRmR0sxd2o2bDRyNzJyWjE2YTV1NnRZWUhyWExYUWN4ZTdVeTJv?=
 =?utf-8?B?YysrTGRqM1QzbmUwa21ZazZpV05tUmRmVnVjMkpmdDRCQm5IMFVXMTVDd3lB?=
 =?utf-8?B?M1dsSVpPOElkSGZSMUNwdmFYK3F3WTg4N2V4blczQUdzUlpYUjJGa1RPRnRF?=
 =?utf-8?B?R290SmpxMmZldTgxUFpnWTVybTRtRWJ2UkxMOG9PemFsN2MxakprbnV4WmZO?=
 =?utf-8?B?aDgwbmVkUUVXN05Tb0FDSFUzbElIVUtuVHlKbkVIZWwxbE8xNU9jdGRBcE1m?=
 =?utf-8?B?T3AwYlU3NkJLOUM0YzcwS3Y5L0ZQMlVIWFYrTmxTS0c0Z1RjVGlqQ0JOYmVX?=
 =?utf-8?B?cDJqYU5aRmVwSVFGS3Nndk1pejlOSnJiOEc3bUdPVDZDK2JuNGQyeENYZDA1?=
 =?utf-8?B?SEt1Njg3bGdia1FJOEJNOGZoOTAwcDBrY1V6UG9hRkNSMmZ0bXdxQi81dWJH?=
 =?utf-8?B?UDI3NUJmVHQxR1lYSVB4elZTaExNMTdPNDl2dUNhdVpaREtSeFhibjR1blRK?=
 =?utf-8?B?OU85VWZlL1pYekVuNWFSdGpqN1lxcnJVQm1wVGROQndiSmJhWGhncExLbnkw?=
 =?utf-8?B?d1JvMUJTbFdhNFZjcndvL2hNU2lkNTA5cGhrWndFTmhRWXRkQkptVnZOcGJG?=
 =?utf-8?B?d2FLK2F3M1Awb0E5VkhVOVBWTW0yVkRmZEEzNVhwbk4yUUlpQkJ6RnQ4aDJ0?=
 =?utf-8?B?Vk5UaDdhNXAxYWVlNzNEOTVFQTdRc2tZNWhCQ2JzTUxhalExNzdvOTBpNERv?=
 =?utf-8?B?VXRoT09HaExaMWtOenVIZzhLYmdsMldUTE81aFhYV09VbDBnMjlPVEhMaEta?=
 =?utf-8?B?MkFKTkpqQ0lxYzFnaGQyTjUyQ0M5Z0o5R2ZwQmd4c3VNZHk5d3JzUFJCNkhh?=
 =?utf-8?B?SGV0UGJEQVJLUVVJRGlLdDdGOURUY25Lb3p6QlFBbVVXMmprYW9FWE5XSVFn?=
 =?utf-8?B?emRkMlJkaFpEeUJqNGFkUlVmVjVLbXNqNHA2TU4yMjJHZitxTzJiQytMZXJ4?=
 =?utf-8?B?enRGenJ6eEZKbjh0OXhXSnNFZ0U0RmJaS2YrR2VpUGNUQ3E3UTMwc0pzMGtH?=
 =?utf-8?B?SU11bzZOVEh1dlN2Q0t4MHN1TGgvKzRhSmZJQ2Z5WmMwUS9Nc1UwQ2xwQ0d0?=
 =?utf-8?B?U21TT1RiQ2dzb2psRDQwRFZweU5rYjUzNWRKbmVXOUVMbXFlYlRuQkJCRWVx?=
 =?utf-8?B?RUdobVplQzVXV3k3NEJlYTZHSWFGT0FXbDRBSEVSTGFxUUJvYUdTUlY4dUh2?=
 =?utf-8?Q?a2P8KJkSdFucv46w8os5ueSW8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ja585g7eigenXPD1HOZL/k6MDFPs4Z7XafPrNH0aS7evWMASqSbxYdLYni629gSPocWfx7mc40vPXxfsdQhTnS61EkJE1MGkKs23Gk695dj5UEypzAMtQqw/oE25Jjm36DWRtV4nLbL7PK7dDWR0BuEptMRGll9ysm46KNx7qlKnSwN3tFm4Jde1MbVPYqnkoEyQD68gyJoF61enexFCsZChG0cuiQzZpzzd0+E9MZtYVuoqLUVjC6LuyqU1OXS3lZrQjEjneTSKeUn9eselr//1+BGBg5i1E3P8wmUiZtxc6P7APN6EcIXU3xGvaDnQ95W1rLnW+aD9UQfww7zheS8VY7TOwNAjQUB7RE3S42G8nyaZ0hoLARFLH9L2HBkoklJht0/8JmEXNZBBLvUT1EmTs2Hdn3uXEwlRolpPl7+mgtUl2csAat+rxFpasucvuZ6hdT1B3ZaLiLbs+0wFAW0BuYie0BWfaSDG7mZdJ07uYv5F1ZH9ZXzxl4BCcqFiKlNsPRYw52FL8PeRmCVxkbdiDGhyBUxCxaBryg4J26D3qasj8FcKKFg1WdS8DC1DUWKc4AQNXQw33J3Ifc29BecR9jTco73ylt1qsjnKwQj64zjMgVBT3dTgd6/agtey
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba799f86-6689-441e-6abd-08dcc5a2478e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 07:39:55.5379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfVE+Se2cseA7pwSLIZtWzyxO3ZTd8+JwAu00gJ6b7HovMTBa5qw3Slry+2PNLvqwNpE3E+31uUNLYdvVkUAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8874

PiBPbiAyNi8wOC8yNCAxMDoyNiwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4+PiArICAgICAvKg0K
PiA+Pj4gKyAgICAgICogU0QgY2FyZHMsIHNwZWNpZmljYWxseSBoaWdoIHZvbHVtZSBjYXJkcywg
ZXhwZWN0IHRvIGJlIGFsbG93ZWQgd2l0aA0KPiB0aGUNCj4gPj4+ICsgICAgICAqIGZ1bGwgNTAw
bXNlYyBidXN5IHBlcmlvZCBwb3N0IHdyaXRlLiBPdGhlcndpc2UsIHRoZXkgbWF5IG5vdA0KPiBp
bmRpY2F0ZQ0KPiA+Pj4gKyAgICAgICogY29ycmVjdGx5IHRoZSBudW1iZXIgb2YgYnl0ZXMgd3Jp
dHRlbi4NCj4gPj4+ICsgICAgICAqLw0KPiA+Pj4gKyAgICAgaWYgKG1tY19jYXJkX3VsdF9jYXBh
Y2l0eShjYXJkKSkNCj4gPj4+ICsgICAgICAgICAgICAgbW1jX2RlbGF5KDUwMCk7DQo+ID4+DQo+
ID4+IFRvIGdldCBoZXJlLCBpdCBzaG91bGQgaGF2ZSBoYWQgdG8gZ28gdGhyb3VnaDoNCj4gPj4N
Cj4gPj4gICAgICAgICAvKiBUcnkgdG8gZ2V0IGJhY2sgdG8gInRyYW4iIHN0YXRlICovDQo+ID4+
ICAgICAgICAgaWYgKCFtbWNfaG9zdF9pc19zcGkobXEtPmNhcmQtPmhvc3QpICYmDQo+ID4+ICAg
ICAgICAgICAgIChlcnIgfHwgIW1tY19yZWFkeV9mb3JfZGF0YShzdGF0dXMpKSkNCj4gPj4gICAg
ICAgICAgICAgICAgIGVyciA9IG1tY19ibGtfZml4X3N0YXRlKG1xLT5jYXJkLCByZXEpOw0KPiA+
Pg0KPiA+PiB3aGljaCB3b3VsZCBtZWFuIHRoZSBjYXJkIGlzIG5vdCBpbmRpY2F0aW5nICJidXN5
Ii4NCj4gPj4gRWl0aGVyIHRoYXQgaXMgbm90IHdvcmtpbmcsIG9yIGl0IHNlZW1zIGxpa2UgYW4g
aXNzdWUgd2l0aCB0aGUgY2FyZCwNCj4gPj4gaW4gd2hpY2ggY2FzZSBpdCBjb3VsZCBiZSBhIGNh
cmQgcXVpcmsgcGVyaGFwcy4NCj4gPiBJIHdhcyBnZXR0aW5nIGhlcmUgb24gYSBzZXR1cCB3aXRo
IG1pY3JvLXRvLVNEIGFkYXB0ZXIgLSBJIGd1ZXNzIGJlY2F1c2Ugb2YNCj4gcGh5IGVycm9ycyBv
biBvbmUgb2YgdGhlIGVhcmx5IGNhcmQgdmVyc2lvbnMuDQo+ID4gT24gbXkgb3RoZXIgc2V0dXBz
LCB0aGUgcmVjb3ZlcnkgZmxvdyB3YXNuJ3QgdHJpZ2dlcmVkLg0KPiA+IFdoYXQgd2FzIGhhcHBl
bmluZyBpczoNCj4gPiBtbWNfYmxrX21xX3JlcV9kb25lDQo+ID4gICAgICAgbW1jX2Jsa19tcV9j
b21wbGV0ZV9wcmV2X3JlcQ0KPiA+ICAgICAgICAgICAgICAgbW1jX2Jsa19tcV9wb2xsX2NvbXBs
ZXRpb24NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgQ01EMTM6IDA6IDAwMDgwOTAwIDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwID0NCj4gUkVBRFlfRk9SX0RBVEEgKyBFUlJPUg0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICBtbWNfYmxrX21xX3J3X3JlY292ZXJ5DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbW1jX3NkX251bV93cl9ibG9ja3MgLSBieXRlc194ZmVyZWQg
PSAwDQo+ID4NCj4gPiBDb25zdWx0aW5nIHdpdGggb3VyIFNEIHN5c3RlbSBndXlzLCB0aGUgNTAw
bXNlYyBtdXN0LWhhdmUgd3JpdGUNCj4gPiB0aW1lb3V0IGJyb3VnaHQgdXAsIEFuZCBmaXhlZCB0
aGF0Lg0KPiA+IFNoYXduIHdhcyBpbnRlcmVzdGVkIGluIHRoaXMgYXMgd2VsbCAtIHNlZSB0aGUg
ZGlzY3Vzc2lvbiBpbiBWMy4NCj4gDQo+IFRoZSBzcGVjIHJlYWRzIGxpa2UgdGhlIHRpbWVvdXQg
aXMgZm9yIGNhcmQgYnVzeS4gIElmIHRoZSBjYXJkIGlzIG5vdCBpbmRpY2F0aW5nDQo+IGJ1c3kg
d2hlbiBpdCBpcyBidXN5LCB0aGVuIHRoYXQgaXMgYW4gaXNzdWUgd2l0aCB0aGUgY2FyZC4NCldp
bGwgcmVtb3ZlIGl0Lg0KDQpUaGFua3MsDQpBdnJpDQoNCg==
