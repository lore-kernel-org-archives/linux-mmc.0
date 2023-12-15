Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E514F93
	for <linux-mmc@vger.kernel.org>; Fri, 15 Dec 2023 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gh3NL0Xm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yw3sLLHY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702629931; x=1734165931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GDqZkw7pKfrwAg5ycXB5kK0UTdLfa8oD6UiygbIQfGk=;
  b=Gh3NL0Xmz1heIxP5bm8iDAkq+K8Em4i9O58NDfZSrLgJ2SWHkU5Wx94b
   BHlavg7dbOprPGGVRnQby6jTwUMqpj7V34e5gotsFwAxm1kTWE/z8SqxZ
   XiYOZ4EfqWXM2sGJuoXtXwuLWo8BofwaHouzk4Wy0cGj0zlyAD5+IyZGP
   FJV0UZGCrBFrf5ecinzWnTRRuCPMo4HRtW85Eexnf0clsfXADTWSs79LP
   G7FbLyBp012yg7WiZphI1WEjeKIH6qbJmSdX3IwISh13dwoRhN1vvca20
   w32dupL5EYRZ8v2Nddjdreubp0hysPBFsAkwJmIZPWitNaeFH0uYT+pzi
   A==;
X-CSE-ConnectionGUID: ProrRPg1Sleqnk6dx2M2LA==
X-CSE-MsgGUID: W8Pt+6J7RGO+uBkyXcaf1Q==
X-IronPort-AV: E=Sophos;i="6.04,278,1695657600"; 
   d="scan'208";a="4896805"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2023 16:45:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOQ5rk82Yx7mBLYv7P//wNN6Sq/3ngTDk4GukhFCntOpaUhOM4C0A4wksDZlLo0nNX2LfpF0VY5TlES8SRpZGByaWtGHfKwopVuWzYzB6J00uGDK2fQoErq6/S96b9i3XcVc+GHEAB6Gd4wD2gi2ySurH5ilHIViVfVlqzO0D4CT50S96j/d885mD0SPP1FrWnyfwHESMdwQP659cmNzP/GNdLzy3Ixon0J+Inki8H/VPQsaMeJ6UFsHUrVPV6s4jfeAZb/EQYiTRJ7ZZSgA2cqAgEd0U7frUZq4LewtbeSfdYurE2Tl4mF+6VOa5bDOh+MtIexoO9qbrCxl/KsBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSQPYpfps2R2Xe8hUhbpUsotAb/gqIcLnJ4xOA1T9eU=;
 b=BgXzVtcsaK+BmMp6hXQPghTbd1BNPUIC+ozbudAu/vTtfmQ8VpAbRUPHhPZO8vnw0wGKKQGhB5H3iu3YZ7UogJ9JlTMobsai6O39+/QQ8MlSPGwp/z2a41UKvbuyD54jeSVNb8+dxi5UwfyXxdHJ9ZictgNP0RwR7HTso4KCsRt8ca+3Ps0PilN9CrygodMZZEiY+Cg5OS7WIc+I+jWwN3vcVqhVxhD7Csa2gBoEoSPQx5BjXERWZcvQrFiIDg7dgXZCUmAxoYPC69o/UZqX/mmZrCP0Q+khJ50TwtxJrP+uWQtjqQyojgWBmFOB6GahS0sbjdze5xe24WRDjn8TOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSQPYpfps2R2Xe8hUhbpUsotAb/gqIcLnJ4xOA1T9eU=;
 b=yw3sLLHYcs9SECd7y0fT3QdSn+iQlNneE/gp4b0JqjK4zFd5helYJB63UN+/yU0rY+6kvKes9IRUThc9u2FoB32i0kYlViHuwT15DrsZkJPd0gFzG+OCNZTmyvQwOZvNlF2MN9wN6Gcb5yHNyVQgjaJcbmGeLoTh0B16itXOCoQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 LV8PR04MB8958.namprd04.prod.outlook.com (2603:10b6:408:180::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 08:45:28 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 08:45:27 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: "jorge@foundries.io" <jorge@foundries.io>, "christian.loehle@arm.com"
	<christian.loehle@arm.com>, "ricardo@foundries.io" <ricardo@foundries.io>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc: mmc_test: Add re-tuning test
Thread-Topic: [PATCH] mmc: mmc_test: Add re-tuning test
Thread-Index: AQHaLm1B+viiDsKh0kqmx52JIeafPbCqCNxg
Date: Fri, 15 Dec 2023 08:45:27 +0000
Message-ID:
 <DM6PR04MB6575F0CE62C510DB2853D404FC93A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231214090902.43628-1-adrian.hunter@intel.com>
In-Reply-To: <20231214090902.43628-1-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|LV8PR04MB8958:EE_
x-ms-office365-filtering-correlation-id: 694b448c-1159-4a19-d597-08dbfd4a300c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7Q+FRNeiiHrJ3+9p82+Wnt5TR4t3J/9zocQ0N1Hao6c5XQdWefpb3ta+rNyqQlWszs7GqtIv1BcN67SHd7KMQNPBTFHRYYW9RFWlNcPTsGx+7DZEc+XydzdEZYKV395cEkIcJlb5kxHfZ1xFPedWvhT5fnwQE7VPgHrkt9mFITMZiiK46jNytFL/adIF7FYIQB9hVcgjw6BjbaPyjx9qC/cF262vnQR39RyYPFYrJRLWQ1BPB5cicZZn4G8yj1FkhclK1YLoIFXS4bBtM1otGZoaoG0IcKlk1ps4uFswzVl/MeKwKWmCCpumYrjRBYbDbBU5v9Xxc5DZzT0DpoV5VUSpI4Zs9ft6sOIwol9CpgEkjPYsWUsxLAR8pmlzx7BH6vff0hgR9QLl9ldliCJ8ux+MD3oVBQH6oUKJL987f44lUr0h+5JrvXyPCmH1q3E9OOF/ZTXoUONMugXpysk8+iTT1EXyStZmJFlhWsO5fh8ZMBk4wrKlsCN+f05f4IjixS25ypj0Reb8Uz+J8RLSXS3RW8lNEGT2JI7tJ1b1FhBrb5XvMZEOTLzKtSWDMp3lvFBiZQKM5lwyhjLsSso3xiC6DUWs+cHp5RQJksnIdDmJOs4aGzl99YxUt2ofnBrS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(9686003)(6506007)(7696005)(71200400001)(83380400001)(55016003)(82960400001)(26005)(478600001)(41300700001)(64756008)(66556008)(66946007)(76116006)(66446008)(66476007)(110136005)(8676002)(8936002)(54906003)(316002)(4326008)(4744005)(38070700009)(86362001)(52536014)(2906002)(122000001)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q9gm4DaGbJ7YSvbA0SFc/Bi/znkyBXSkCYx85X+6tKrWlVdw7ZgehPIl4Ctf?=
 =?us-ascii?Q?7KXbn4MEFQYfcflQbk/VpQlOgTsWbfI4Ba5mtdOgSh1ce1EC3Cwfl+pcYGs7?=
 =?us-ascii?Q?B/G6iO0R2Ig8RpIh8eS4S5Q9mjJbFknVUqBaWUGsPiuB2Rw6t4Vqw6BoXNC9?=
 =?us-ascii?Q?JzCXPD4Ed9lvXs6DaQQz6OoGnHeN3KWjuh0/JM9Ld+iDKr/pIzH+oPnueKax?=
 =?us-ascii?Q?YQoBEGymXvDDjkuZuyVjhOVU2Kulsy3Hg5Shy3wq4fWJC8ycWARbE/89XHdr?=
 =?us-ascii?Q?xvWbw4BPOFS+qnlCjPmHZXgZMuDgJjb9GtGZZbOfhSoO+d9zVKibgAUPe9LM?=
 =?us-ascii?Q?dJdjgkxreaDVqxktOLfg1xVB+Kaj6szYtZLRgz9qOGn5+0viY61J0ot90JLU?=
 =?us-ascii?Q?Mj4jcVxWEo2fqdvkbjPVqVG9oWaOrmmPv7QVE4XD/t1vtolou9sq2BrnV8MA?=
 =?us-ascii?Q?ViNvHqGXYILBRL7Ti4IbcPnJZbiv4fTQVr+XX0EkPcevbYP/RUHkbqzBNOFG?=
 =?us-ascii?Q?RRq4dC/INMrb88Xah30raevrblJ//A+TuHo+ebwxbVtPy++V85XUaZvAPJPk?=
 =?us-ascii?Q?4KwmCANujfAA1XY0LhlwvQKp+aDGQ+DfJMYAX50Wj1XRzJxs2mRC7Fi4lpFW?=
 =?us-ascii?Q?MlPB23pzV3XDgOtGIirPspaU+/cJ2cyT+DcTSrpp+ZsFttBJ1OLDP/Uqj4od?=
 =?us-ascii?Q?cHdrJBvFnBt/wIT3V8dOIWkxXiqnQGYn9ndUYKbhqnXMkWCmmocxEs1udrQX?=
 =?us-ascii?Q?GQWcPV73QeXJ0c/Fmwsj9D/7dFG1YXshR6p/M4RkOhvXm5V6naoimsKG9JHO?=
 =?us-ascii?Q?xw/GX8JCjMP1Psb/Ipak5isaovA+VUrgjk653944+SkT+/clf/suj/HhEhSz?=
 =?us-ascii?Q?weWmjqiBeF/FZpZZ9VXlMtoMAT0R/fBQT2OfKkwfCr27DaF0llVK9G7GL1A1?=
 =?us-ascii?Q?4pScn8irDGqz0gTRnKIyHuv3yqwWFBPelzcoetfRQ4E6sm2JMdTm9EvP0nPL?=
 =?us-ascii?Q?i3NrRbvnW4pH05/gijJYp8MAK94gZqs5k0VVlLpMn/G0xPUGrF5WOanHyfQN?=
 =?us-ascii?Q?eU1RmLztxdJepvMOfk1JgO8IuiinSXZV2pqwy9G1IRlR1yOnYhWJof+KoiAK?=
 =?us-ascii?Q?8BFMUNVEza+Y7F14zHQODQ+ceE16Q1NanIKqmHmutyoERbHZw7oeTLZ9rWTj?=
 =?us-ascii?Q?+yUcQnHalCccDtNf4TlP7FUQsw8luASBB5bX11hAOLK/e0L2nv3ME8W1fA1C?=
 =?us-ascii?Q?KMNEtZZdGAjCcNRStegWTMjeInQpMBBls0kchWEB7wqC6QuHSaYWBfW3mlU9?=
 =?us-ascii?Q?bspcVIBA2bHUwcllfHINI77jNJtNaKCLJN6EqArUuSUih49oQUBJM1NA028W?=
 =?us-ascii?Q?tcVXJXHKeIVgoz2XoS90VP3GvlsSs/4ec8lyE7BaFRjYMsY4g46T92jz46qf?=
 =?us-ascii?Q?tQNDx6uPKVVIDv5DZKmba169KTuybcZnnaee8R6Z1XsvGYKQiiTdzcQNqjiD?=
 =?us-ascii?Q?/Cvot9LA7LbujDc3ubAd9hwbz/4o5b70JPNWTskg6C2xqNPFgnpO8RfzJGSH?=
 =?us-ascii?Q?zusH7OCeFQedrR0SZEgYRs+3AfQ5qC1suyDRS33h?=
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
	/hhVYBoROxNoXldMo05U/UTXK3FijlMrPHtrkAAtLSWXIqROyVBhfXe+Fgs55y+11JXG8kmurM4NFsUOHXfZ9pon9WVS/xfMwWMfF6UGdVIRXHP0HQ80RjoMalugMbWhg58JiL8gHRDmwj6v66heIwCYnZMIwOxZ6tEn5UT+HAOjR7oaXygTNTGdBJAUHOlME5yumQoZyC2xVin5+0BbId8yf+ZeD+C8CfObfm4rH7XB3aXjQuiAVHRXd2jLVD9XArgWnS07Qrbj/nzNG3BTDZC7MTr+c11nggvCkOyav1n8ednxaiwFXjPIPoB0wHTCtdsRhCoIYb7aAQWmUHkS01F4aVtY0OkvUjD1NE4wMkQu2oZiYKRmL9zF41MPn0tPzM3c/xAxMK29PkJHBR1QAUWoW8oN050BqV5h7qYk268lyKkENNeZVZLLVTNIPI+0iBytO3XR1tuoDyQcXssaOZeIPTJVbCBf4a8Wm3BGn0v3booAizKAf8L0RV7huH7LaavJRhnI4cB8KxgtGN3viA2p4kZ4UnjwUKPLCz5ZNihK7nn/2PCEruJigQM02CnDCGyjBqPgmRVFr9lMTJXLfjqF5zo/e/0ePamiQ7zZIMIdyRg50YSeT5/XrN4WPTjy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694b448c-1159-4a19-d597-08dbfd4a300c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 08:45:27.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DimpRQap5vjfxjctX9qw5Fums1PjQdanQtJlG5727bLAO4fvxnGKdRx4NQ6EFIOuPlAI8x8c6if9e0lAfn7Wcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB8958

> +static int mmc_test_retuning(struct mmc_test_card *test) {
> +       if (!mmc_can_retune(test->card->host)) {
> +               pr_info("%s: No retuning - test skipped\n",
> +                       mmc_hostname(test->card->host));
> +               return RESULT_UNSUP_HOST;
> +       }
> +
> +       return mmc_test_rnd_perf(test, 0, 0, 8192, 30, 1);
>  }
I wonder if it would make sense to make a RPMB flavor for the re-tuning tes=
t?

Thanks,
Avri

>=20
>  /*
> @@ -2921,6 +2934,14 @@ static const struct mmc_test_case
> mmc_test_cases[] =3D {
>                 .run =3D mmc_test_cmds_during_write_cmd23_nonblock,
>                 .cleanup =3D mmc_test_area_cleanup,
>         },
> +
> +       {
> +               .name =3D "Re-tuning reliability",
> +               .prepare =3D mmc_test_area_prepare,
> +               .run =3D mmc_test_retuning,
> +               .cleanup =3D mmc_test_area_cleanup,
> +       },
> +
>  };
>=20
>  static DEFINE_MUTEX(mmc_test_lock);
> --
> 2.34.1

