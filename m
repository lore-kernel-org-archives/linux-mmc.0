Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E35173355;
	Fri, 26 Jul 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974436; cv=fail; b=hLL0979VnSfdYlZn/z6QKPucSTAhL1ZDsmt4fhEoPP4qRtpzcjyWZ7wvOZGR7458atrWYsRUxWb/E0e4b0p4VsAKpcicyJORrnJ2EJAhNnCHRVD30+znjQtPZTNpqMquf69ZyTnijnp9TfpGEbItGQZXW2atR8El5GN4MlgjbTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974436; c=relaxed/simple;
	bh=RWhBgiDXZ8ofAcsI0sa4rtCttibE+W72sn+kJFf3xlA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iDLCFF7TGfev77WZotOoknxFceS4BTqp/e454AV98t/Sza7GFIV4QCJRO+ftnX0NKoXOfaRQ40CwbHBmKO2YrjEkGuvc2k9tT474n4tENUe8mk7gj88JOBSGgng1L73j/oYzqo5yt61iWaic48RWFtwr8a1ut9PE1Wg5PWVyE8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Hnc7CdLU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=x1rJokHL; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hnc7CdLU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="x1rJokHL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721974435; x=1753510435;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=RWhBgiDXZ8ofAcsI0sa4rtCttibE+W72sn+kJFf3xlA=;
  b=Hnc7CdLUNgisJILc8uaqTaVNOXk1hTzBzhq8kQHuncLSaWOJqa+EaFBf
   nx2UfXJ9x0pzWHxOMd3rMkpuSKCB9Xt1oJc1zrROu2HAyV1ij3t43va+s
   JGMzPCJGaw5hDNwQLU8qyDjiLk0Sms7TC7X7c35W96iP67uxdv6vOfYPj
   zda+W0WgfpoX5tHcvMfDqUqJWOnWaW4FhHR4v6fLm8x0bA6vW22kN+DL5
   CaFxt8OrB3XstnUtOdywbY6Eb4onhYJCYNRGh+Zzr6KKIkYCMzmL5Q/P1
   u7YBoiEWjGz4qpRP7hw2OwkoQ/1wIDf8O6PHh8+jVK1Ertca7ekl1AfdB
   Q==;
X-CSE-ConnectionGUID: 653Z5dYNQBm1dqfj+jOOPA==
X-CSE-MsgGUID: pSnk62AsSy6vP2Ri2EYuaA==
X-IronPort-AV: E=Sophos;i="6.09,238,1716220800"; 
   d="scan'208";a="22126178"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2024 14:13:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3Ms2Onv7ZrtCoGLgqBfEZKKVQN8pUd/3HUfCVxFpwxucV6C1AHq5YTPTIDJTBZ33vyQtBKQT7iw+t8rxGbpigf1ZACgvEBndk3KN0697twxtYggPcWXEvjUmlDH+vEbk+pE/lp3icW7ewyeNBHq8jOvLUU8CXsLblHMAGd2v1YdNHL2w688LS1RMFMbqq5flcGXX9OjDkuxAHqlEXWTzB0samgfNl9Bw70QYFM69WggoNeT3WYQ2ZtXExw/83R9EazdplQek2B2ANPllDlCv+CYf6BPFSReKupOw5+USyx5KVH8rYZ0881X9o8sACKAdEPobXQ29zM+JEfiaBjQ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VxxT/j8Ft0hq9dZUbUsu+uk+Qecd1NebhIxzbGf4Dg=;
 b=X3EUzacVp0YPU7adHJsuVOkkaWTBUnluKlRSABtwm+55aSpkrgPBz022ngQQQTpQ28JGs4wc37rI4MWf87Ojl7xKxAWQR6tN79lTRvF3M7OEf9HhXrtDbOdi5dMjKW6aMB9w2imdV4T9qjiBy89y5qJp6eqxt2Vxxl2qp1xG8GLH9M5B6x4H8OIqklabB07Tr/IR0+0SHQa2QodXmjhhKDNu+KNf7uiHqooV+b2fggr+J9XZSAQoCkyH2W+l5kKkUAI2xYBil9nbzFPs3wXLJWmw3zK+i/WFmxyHEvOxg+kN3crGFxC/EB0y9rUcH5FLg1FYsacIR4KTXHHPDckdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VxxT/j8Ft0hq9dZUbUsu+uk+Qecd1NebhIxzbGf4Dg=;
 b=x1rJokHLwOgbvwsqjTz2HcLBNa6CL+Q5c+rXqWD6nwywNa3TGVLj6KB4KnZAxUevYDVX70GaBBmTtXKLpgRCV7cVe4qni8ETx7/bPrHpR8q9eoymA+3QNGVXHmUikikoaf+NbqNlxUaIazpzUGG8Oe8Ft6jM35dxVZXJhLV4/0s=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 LV3PR04MB9152.namprd04.prod.outlook.com (2603:10b6:408:27a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 06:13:45 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 06:13:45 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ricky Wu <ricky_wu@realtek.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ricardo@marliere.net"
	<ricardo@marliere.net>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH 0/4] Add support SDUC for Realtek card readers
Thread-Topic: [PATCH 0/4] Add support SDUC for Realtek card readers
Thread-Index: AQHa2Z1D1FenrAdgBUOW2bwTYfV+nLIIiVzw
Date: Fri, 26 Jul 2024 06:13:44 +0000
Message-ID:
 <DM6PR04MB657501EF884BAAC24446E8A1FCB42@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240719053314.1636649-1-ricky_wu@realtek.com>
In-Reply-To: <20240719053314.1636649-1-ricky_wu@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|LV3PR04MB9152:EE_
x-ms-office365-filtering-correlation-id: 764023ef-81a0-40d2-5dc4-08dcad3a1adb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gmLAFf1gCONvZ+NQZACwtZo/lMwAW7cSktj3sx7O665pBgGWqJGmtfGEi/jD?=
 =?us-ascii?Q?4/0KnAeaF9wirA8baH2/8CCjyEqgvMOV4nZuqg5QvMMcQ5Ey+GsVnkmvL8nX?=
 =?us-ascii?Q?21RibuMmtGeGVowAxGbWmK85wxoGtDUJ9/4HBPoJM9Q3GoU1H5OVIUj9soil?=
 =?us-ascii?Q?RMuoVV+MMggK+wVioZi0a4R6qmFp0nIM+jJjzZSlr9WHQSSYCmTJ3t3Y0+yD?=
 =?us-ascii?Q?Ofm4M3fFDhWH3psAtGwN+SeICgXJaQKZ8MCUnap3wN994sv74LJqBBGWZr+2?=
 =?us-ascii?Q?IDhfCRMpUTur89boAtjznYBW34gf372igsCb+A8eLKZzC8czmAaTeRTd+INE?=
 =?us-ascii?Q?qbUqCdUwNmkWaL4heWLz90MbOBM/3ZFiK7iF1a58F30qU5NZeLW91YXH1HWV?=
 =?us-ascii?Q?q5NPGyVfbVuEiTdmfZvvVN2usefdM6b4n87N10HbCjHQZRSktW1/S6ZxUbGa?=
 =?us-ascii?Q?14Okh6rmhofx+9f38NpFRfXGUZf8j6Q7NonZOBsG94UEetNvgz+ZSU4R9ZwA?=
 =?us-ascii?Q?flSAgio5hUfs6gUzlEYlvmILZPlBpu4FKR+3Xl3ZHBe4XLIHy4iW1jmJOHX1?=
 =?us-ascii?Q?mkY8zhii7stKf0xwXH/9UflP0cuM1/IJSAmFCIZ0CfDykF+9Uj2CfOP6ajLp?=
 =?us-ascii?Q?XQbgiqg4o7gDQYUHAxh2/mvJXFbn6H53h+BrmV+8HSI1eM2nHhjR/1cZd37t?=
 =?us-ascii?Q?LJsqOZKBjO23PROk/TYemr4VZ3ETlc6mwfXDyMUpwmrl/2egn1Kr3TAsyU7g?=
 =?us-ascii?Q?bhAtCg+dgNt4YClgbNWvDRLx4GJIfeIp5Tt5GDw2q+z523ZrGuMK5XhvNwgN?=
 =?us-ascii?Q?K4OVFtcugjKN71T6cMhhhm7h6mTmT5NKKVe8l5me1n3UmQHuXFZULsEZfhGI?=
 =?us-ascii?Q?DkVRFQkPYEdBCpcx8QVVNg1RKFsqRA1WCfq7GkWEt44F/GQd8vKL1w+wjC0i?=
 =?us-ascii?Q?yvlICUQO1F87wBOePwn0FMn/Zi0oL9wown+RNagfaHjc41QHBn9jW1+1QcJy?=
 =?us-ascii?Q?LiQGaxTtFntRI8RIGlrUXD72uNIRbN/bdFy8MJPR1jSapV67oLFerjhYhfiE?=
 =?us-ascii?Q?SoSORVgeb6uTleyC6Eex6fl6CBmMTEpldxClmt2kfuLiVpfxW2Vv/LbBHYVc?=
 =?us-ascii?Q?oyisOcOznfhMuBHWyitshhKSWMPXNZAvxgeywuvJHmeZluWSTrBMzXqdx1O4?=
 =?us-ascii?Q?Ugu7Fza6GWXtst2fktvDJStavykfNF+FBDnBCMMFLW+rEcJyypkMoiyzvLXa?=
 =?us-ascii?Q?M5pzTRGVU0HD2xI/hnRDsTNnxdYH16G+WHr6P5+2teukVwWcBWmtEibCz7WD?=
 =?us-ascii?Q?IsmGDnNMcPZFSy9ke6KDX47TcKgMKgsl4zqRng7U8CqKMeGicYvgTmpOpFVF?=
 =?us-ascii?Q?PvzBfR5UO1NvGMpd2b7N9dSjc4xui4oj4DzjFCblXYJN/gNyOw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LjarbGosA7z3uDxoDed+cAYW+ZeMAj+v+UR9VsUk8MjvAeuyHSMc8mbvos+w?=
 =?us-ascii?Q?UqqVq7mublhwlJwIO3KLcR9jLEp5H7NFRijkpa2Q/z9KZDQLARiiQbS8A4bJ?=
 =?us-ascii?Q?73WCUjrdelBFDWxq7bG8Vhq2i1jkWcW37Cjay5pX6/hYQSUkafMIWW+vXiAS?=
 =?us-ascii?Q?2VpKxGvCApk1rabcTRUEijqdBCKLxxmgHzjcs4k+pIuzX5hm4uad00eRs70k?=
 =?us-ascii?Q?3YO1kwOAaORmzhGjniktgSwx3y0Ki3zAdHwQ9WE9sh3Vnj9DX3yvdc+0eCLg?=
 =?us-ascii?Q?4SW48/KhlMP1gyhzDdq/urgX7+0TEw8t85aVwo1hw7QYv5wKNEKgfjtZFkQV?=
 =?us-ascii?Q?aCz/zlM7PRx73eLN72fUSDuAGcLW1x5Wju8IFBSWgGdh0Kb754f6TqiHLbN0?=
 =?us-ascii?Q?p3ReVfossWDhsZwqPR348x0gvqr+WSu9w4c3/0Y6TdJsLv7ihegnUj8K22c6?=
 =?us-ascii?Q?vs6GlKjwamH8TMrq804TSEdp7eN6I8jVX69DI7mcSw5G1yMEQhvKULUrQInA?=
 =?us-ascii?Q?Hf2MoJ6p2u1h7MgO7knYNt5KWXD+ZF8LrN5AiZQKrrYBr2dtQI5JxVCrQ4BE?=
 =?us-ascii?Q?GpD82sX7Uihcrpo+nR/B1YReksHLpReB651S1w7fVzUoMitY+5IrN1rKVHLS?=
 =?us-ascii?Q?uZqzq3BxesQIb9B7Ar3vZyXsY8b4PseWTpiTg0y4059Yoez130COYqm4lZ6C?=
 =?us-ascii?Q?O3vR8lYgoC9+o7neFiuUafDiD2LCazYxNImiKSoDf/RZhN5CdQXg+WuRklOQ?=
 =?us-ascii?Q?gy6MW1GWjfjIFiQeAy4ugPe4wD//RqSPfVlF0jWgzxj1rHSjurYz7j3hfEea?=
 =?us-ascii?Q?nj+p+VUuGCdvolgkaVn+ZE5+bXavDS3y6s1rHXcIzzJwmKAYc7jGzndSHt7K?=
 =?us-ascii?Q?SVgFlapM9veaT/TCIZQpZc9RDS2f+UzqxSvOb70lclE3hqRjbBttw/1MTQQD?=
 =?us-ascii?Q?+BbvNRayGMbppMXF7N7tNMqNEiabS8CvW3IY1qK3TP0syv0na6A2+1pFojLE?=
 =?us-ascii?Q?5Q0Iu7x1bXYvCyG7AWimAzWecCHFRagHK5RlNw16YhZzMLRq0ub3xFL1/iCi?=
 =?us-ascii?Q?wcjkd9DBp7nHc3ScnY+NQLYKneIB0lD46ed6kkYoq/hA1xX5m+0VGsLb6vl3?=
 =?us-ascii?Q?LkF0x8qbrb93gPXI50K0EHduBNkYgGwwMHT9d03PkgbxHLScr2zLgnWacrR3?=
 =?us-ascii?Q?oWfEpvU+rneB62nkqWiGP+iWH2PjCpOea1IeVcROuQLdH4HWzJUR2L6rvl1o?=
 =?us-ascii?Q?OfdD+yRsF+ceSa7q4AXjz4+/e9CctWTA2Ob1bOsD7dqCOMC/CwqLJUgZKigH?=
 =?us-ascii?Q?MsGEe3oEUMwHYb/0K453CVSDTyhB+R3udlaIiItk20O+oOQoMg+T4C6YWzFp?=
 =?us-ascii?Q?Pi6w0/tw3JMLnSuhuBBpwWp4JRS5WVMtu9QRBK2G+nBQlPvnYtwNVGSa3yMK?=
 =?us-ascii?Q?21AFT4nVIEaPy1SVLeCBTDRYaBDudIXyxExW6k6RJo2T9XILaJGEroPo4HzE?=
 =?us-ascii?Q?Y5T5hJyCNbYfFylvuv3QHAScG8EyUGG7Nmsi5us3/xCu7m/An9F4JuB9uzft?=
 =?us-ascii?Q?Dc0Ke5Jxh5s6thdE3sQkZfawHEExApDsU3WYCvN+pbnL/nq1F+pTjLa9xMTk?=
 =?us-ascii?Q?crQPrUYTxhYmpl4hhul7Ita5ZP1UaHTSgsXnCUdxWArt?=
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
	Xlj6AD4osQjDRujjSKAbdf9EgrfHRlkLF1uDQQA/VNIcCT8rcVeTYUpij7O+0z6HZEc6Ff9Wf4C9jbh94TN3PgZQfjKD5L0mIoxOYAZyTb2A+VLH7vW6fgwAqicmuiw/jqzO9JrhLpsdeJgI6XS/hRZRFbIwgV90qUri2FnsnmMSvaSkWDf9VkgjoYkadTRTdyjjRgrYCY8MMHYR7/dZ5P2atdH+yupYrQeljcD7sizLYrMAynqkvsSvDyXLe9QDeVSLGGXT58e7O3s5DQ71FpwalXCJnOHyLISAAjJwd3DaqKvFoq2wLzKyFFvvxj01LSF1ZH3QwLvqAp20S4yjTJDdG92n9oGDZQWoiuDOnylnYkkVtrHXkrmnfbxsd5Vz+l5incFLvLo9gEdlMmijglHIXWL+0Y7AzmWDwJiTYjPIdjOVzhPlYqZgehHbRg71x8DQbiDmGb9LO4zQdhlLFDonpXu6XlOaZ0TG/g6giN8CJ4n4N3hDEwUyySkPlkh/EUQKNSs6ZlUIWtXrP0Gy4lAmb7v9/7FnVY7W7ooQwEmnFuJHVJP6AdQjOwIMySUJvO7NpTSCUblstLjcGzqiFFa5wGi2oDHOfMmDBy2QoFBN2UGDZqLQk+pdNL4IixDQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764023ef-81a0-40d2-5dc4-08dcad3a1adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 06:13:44.9709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJ7jdAicB4ZS6JeBzMUU+jvN8xHan/2Ub7XNBpiBJWqSPPyLfTRLNHFgbxn9kTL4zko/bmW+UQ/g4siS3PqmSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9152

Hi,
> Summary:
> this patch is for mmc to support SDUC(Secure Digital Ultra Capacity)
> and add Realtek Cardreaders to support it
>=20
> About SDUC:
> SDUC is defined in SD7.0 spec, it support the max capacity is 128TB[1]
>=20
> Roughly implemented functions by this patch:
> 1.Mutual identification of SDUC in ACMD41 initialization (5.2.1[2])
> 2.SDUC card user area capacity calculation (5.2.2[2])
> 3.Memory read/write commands sequence (5.2.3[2])
> 4.Erase Commands Sequence (5.2.4[2])
>=20
> patches:
> patch#1: Defined functions and modified some type of parameter
> patch#2: For mmc to support SDUC
> patch#3: Add Realtek sdmmc host to support SDUC
> patch#4: Add Realtek card readers to support SDUC
I think that the way you organized your code makes it very hard to review.
I would like to propose rearranging your code in a more readable form.
E.g. something like:

1) mmc: sd: SDUC Support Recognition:=20
Explain how ACMD21 was extended to support the host-card handshake during i=
nitialization.
Also, make it clear, e.g. in your commit log that if a SDUC card is inserte=
d to a
non-supporting host, it will never respond to this ACMD21 until eventually,
the host will timed out and give up.

2) mmc: sd: Add SD CSD version 3.0
Add here the require changes in core/bus.c, core/card.h, and csd ver 3 in m=
mc_decode_csd().

3) mmc: sd: Add Extension memory addressing
Add in core/sd_ops.c mmc_send_ext_addr() so you'll be able to call it in op=
en-ended rw, erase, etc.
Here it's a good place to explain the general idea of the new CMD22.

4) mmc: core: Add open-ended Ext memory addressing
Call mmc_send_ext_addr() for open-ended rw

5) mmc: host: Always use manual-cmd23 in SDUC
6) mmc: core: Add close-ended Ext memory addressing
7) mmc: host: Add close-ended Ext memory addressing
Those 3 patches will facilitate close-ended rw.
It should be IMO or any SDHCI and not just for RealTk's.
Once the driver is in place, SDUC support doesn't require specific hw chara=
cteristics from the host controller.

8) mmc: core: Add Ext memory addressing for erase
9) mmc: core: Allow mmc erase to carry large addresses
Make the require changes to support erase

10) mmc: core: Adjust ACMD22 to SDUC
Make the adjustments in ACMD22.

I also think that there are some specific issues with your implementation,
But it would be easier to discuss those once the patches are in a more read=
able form.

Thanks,
Avri


>=20
> Reference:
> [1] SD Specifications Part 1 Physical Layer Specification Version 7.00
> [2] SD Specifications SDUC Host Implementation Guideline Version 1.00
>=20
> Ricky Wu(4):
>  mmc: core: some definitions and type modifications for SDUC
>  mmc: core: add SDUC init rw erase flow to mmc
>  mmc: rtsx: make Realtek sdmmc to support SDUC
>  misc: rtsx: add Realtek card readers to support SDUC
>=20
>  drivers/misc/cardreader/rts5227.c |  1 +
>  drivers/misc/cardreader/rts5228.c |  1 +
>  drivers/misc/cardreader/rts5249.c |  1 +
>  drivers/misc/cardreader/rts5260.c |  1 +
>  drivers/misc/cardreader/rts5261.c |  1 +
>  drivers/misc/cardreader/rts5264.c |  2 +-
>  drivers/mmc/core/block.c          | 13 +++++++--
>  drivers/mmc/core/bus.c            |  4 ++-
>  drivers/mmc/core/card.h           |  3 ++
>  drivers/mmc/core/core.c           | 38 +++++++++++++++++--------
>  drivers/mmc/core/core.h           |  6 ++--
>  drivers/mmc/core/host.h           |  5 ++++
>  drivers/mmc/core/queue.h          |  1 +
>  drivers/mmc/core/sd.c             | 47 +++++++++++++++++++++++++++++++
>  drivers/mmc/host/rtsx_pci_sdmmc.c |  6 ++++
>  include/linux/mmc/card.h          |  2 +-
>  include/linux/mmc/core.h          |  1 +
>  include/linux/mmc/host.h          |  1 +
>  include/linux/mmc/sd.h            |  5 ++++
>  include/linux/rtsx_pci.h          |  1 +
>  20 files changed, 121 insertions(+), 19 deletions(-)
>=20
>=20
> --
> 2.25.1

