Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66EEAF6;
	Mon, 23 Sep 2024 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074761; cv=fail; b=A54NOlaVy+PXHxcbpj5HIi/GhIJlIvwdJ2A/LgWYJs7fFVOE9aa91l3CItd8JrFhxayalUOsKy4ESOUt2GmHwezS1K6yQRoiWH2hylunor4LXrDKYJpkguNG+Zf82exqK+pvnhbO6sZow0701XnDcst+ZcGloWIFW7XcJDUvPDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074761; c=relaxed/simple;
	bh=lcLolcYpveHUlI1qswg+vNOw4RTm3fGKU6uGmgO9d6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iI6r0KDAKptsWEN+UB6z+HkYBSomi9oy8fwLUXG4Z05bYTyL09EFL5hyjwfCFdX9hvhdJKDVsvOpwY+AaAgOJejr5EkmSPX2tQ/Nx2TC1EPKh/0tk0KHquwFxtFH2xz9Tr1r/AWeHlJfSLFsLGto9NSvnEh9v/KdJv2gDPUCFpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BmRZH9QB; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BmRZH9QB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdjdoLhcBWWyKhhNV+eISbtTj6Vyh4HdBfEpHyCDV4TXi5kDYR4l0AptovMyyFHAA5tYbW6EhbIlohafF9dY4EReqJrJ/SI2oMnGgqRY7Pi/pS7Seg1UP7QqQ7ZITgi3lNBuOqBeVJ312M3Zih25a9RgSJNdvBCH/ow6/oZ7UZFpNO8b8ahwT523Z5abu18OG2GPBYbwtmvnBoNud+KwBoWFTHEDf7Qt8Tmm/Nj5cVSUQiWPsG/I9U78gN0HW+RojTj7Y4abM07ibUaA7mxh/Tc8R/UCZpfFOmbBOFyvCDbBUeWmFMLk1xFw/kXpzv/puV8bwf7Va1JA7nT5u6BmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcLolcYpveHUlI1qswg+vNOw4RTm3fGKU6uGmgO9d6s=;
 b=lpOJIfkOj+WsypuiCv81S2dYpzQ7qJH3iGL4bZZU8WI/YQa2zi1K19M9tCZF+vEkfFDJFXxpacILdnobCDEM+KQrJ5Fxa9kPSPveQYT/DHKEmqjdIQ6ilBT7jSyGfIJTKzr0EILGQ5k1Alv1YIiAwsVngbI7trjaorY3eqe64GHb3dFLyfFQpJErx6IQtpce+vGfB0Grqpexe1SMLPW5KJhwvcXguv8I5JpOJH4xt8c1JdmcBmlc5xmDcsvgLIxTtUgTv+orqh1h1V/060MZ4+ryxeSSIR6Yeu1JXd/zG2ZoX3vtZamUsJ88gE538jM8pCNsXab/I5eg7glv7O+ypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcLolcYpveHUlI1qswg+vNOw4RTm3fGKU6uGmgO9d6s=;
 b=BmRZH9QB5vz042uVcRoWFEzmS1T5zJyRx7u8DvQVCZCyI1iz8FOUPIqtxaQowUhwgjBfsjyLy5aiMUi+nb6EEiisgEc0eBex0qhJ9yHmjrhyijRm4rzXYvpnz3h47aXmSKUBK+Nhkg2tJtCIh+bhwP/PPTCJWrGsnU5mwXoaWg0H1jVROz8lJQBcM3PX3bd/HCNwWqXFUup12qjj9TyL7S65l7pWPLCMHFMTi8EjmbVLPBPngRGnrI13B+AN32gD4IJuujcxb6RsLvor8B1e1IBNSPsFI5nWYw+zaLx/SVEuZ/DKp+fYvvdz8wMxyEzj31+M9BU5QZoHVeW46WM//g==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DBAPR04MB7221.eurprd04.prod.outlook.com (2603:10a6:10:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 23 Sep
 2024 06:59:13 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 06:59:13 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: enable quirks SDHCI_QUIRK_NO_LED
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: enable quirks SDHCI_QUIRK_NO_LED
Thread-Index: AQHbDX977DDtWW9YwEWJFzKCTXaX87Jk73yw
Date: Mon, 23 Sep 2024 06:59:13 +0000
Message-ID:
 <DU0PR04MB9496E0E11D5A6BB81BF122DA906F2@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240923062016.1165868-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240923062016.1165868-1-peng.fan@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DBAPR04MB7221:EE_
x-ms-office365-filtering-correlation-id: e3b71030-b40b-482f-a224-08dcdb9d3b72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?UnhPeHUwRWNwZFZoWThSSzRSNW9LekV2TS8yVS9DQnlmcTl5Z2NBWExUREhj?=
 =?gb2312?B?NXkyamU3Nk1mTnNjM3hKVVFVMUFGaktLdGw0K3BtclQ5bVBlWFZJVWlRZWI1?=
 =?gb2312?B?elZNRDJrbVFmZkdJbUhleTN6M3RMSCtBQ05UMUdYOTJ1UTNyTE9VYm1QeW9z?=
 =?gb2312?B?eWpMVThvalcwVHZBRDBRUEhLK3hHSGV1ZDRPMEVQUm1VNkNBT0dMQXdpTG5T?=
 =?gb2312?B?R2QveUovU2xtaG14dmowckZXeTFKbGxsTnhnYU12cGVMa215R3FtZ3hlN3Jh?=
 =?gb2312?B?c0EyeXFqeTZKL0dJYjRqQ3BHWSs3eFUzZjh3YytKMWxjR0UxdnFiM2FVZ2RM?=
 =?gb2312?B?NHhWUVBZdFVOTTJuMHdwbzdjRGNBd1pVUG5BZ2xDQTlZOUNscVN4NjhabkE5?=
 =?gb2312?B?YjIvR3M1V3JpVytIb2ZCZlR0c2Iza0c2amg0ZlczU1hFRTBNemNwdzE2S29r?=
 =?gb2312?B?M1RIY0Q2SXZvMUtHM1hKRkZOT0lEam5McjN1YkNYUzllSjJlbHpMS3RZd3lz?=
 =?gb2312?B?TkttbTJzZUxIR2thdkdLOEg0RTNWTW52R2hJYXZIaURwbHlxYXdOVmhnYVoz?=
 =?gb2312?B?RWdUZ2QyRzRVeW54SG5MMjh5MmdoNXpnbVI0SjZjTng2VEdkbGsxMk56dURS?=
 =?gb2312?B?NlNRcmladTVyQ1owbzZwTVNMSDU1cmJTeitYL2ZHbW9VZzQwdkVOSTNTUnlx?=
 =?gb2312?B?eitqYzU2dzF3dFJsNGYybFJzUThhZFFMTHljK1lUZUw4UEp5RWZxYmdodTRJ?=
 =?gb2312?B?aXpReEE2RzZ5MEZ1aWlwY01CeXVvOEQ4aUpQYnpKanNkYnFHazZTRkJzaUxH?=
 =?gb2312?B?UlcrVENYbmNUZ3ZMa0NNa2xQdWpyVlh5clljMEFXSlJlVHNzdk5ZdDRkN1cv?=
 =?gb2312?B?QlhvSElEbUR5UTVNRU1MOWtaOHhTbXlUMWhhVmo3Nk9qcGFnWWd6aE9uQnpL?=
 =?gb2312?B?MmhQYWp0bExacTNkWjFJcHl6bUNrdE1ZVG8wUFBuL2VrcUdhTVI2WDZTMWRG?=
 =?gb2312?B?aVlTZXJSNDhGcDIrd1p3dUNqNXYrMmtqWUhpQUk3c1pXYWJYeElZNUVLOHBJ?=
 =?gb2312?B?eVI2dGxxOFdHbVBsMk1FVW94SmR4dS9CdzNBRzZBb0FNcHJnV0ZqbUNHUjNp?=
 =?gb2312?B?b1hmRTVDOG1QNGFqdGRrNmtZenN1TWVBa1VmOGk3S3RRNDhaSVBESUE1K2NH?=
 =?gb2312?B?Y3BPenpvVkgxemF0dTMzRnJhQUpqTlMrNWRzT3dMZFM2Wk1Ubk1KeDQxYWlm?=
 =?gb2312?B?SEVRYWJsL0lUcEpVaHZtTzdDbUoyQng3QnZYVE0weUgxNm5pY3lpMnozeU81?=
 =?gb2312?B?K21RMkE3N2pMcSs3eUc2TnQvM0w1WUhRcnFIL2U3WkxEd0MwL2I1aFUyajRH?=
 =?gb2312?B?dGRyckR0cGsxTzFSQ09wVW9ua1RKcW1Eb2ltbk95S3Y0RFJQeVplcmN2N1Ix?=
 =?gb2312?B?WGxnWFRUWm9IMWtMNThmL09EYXJ2V01keEVqSnp3RWtRTlpOenAxblZJZ2RH?=
 =?gb2312?B?WG1vaC9RTTErU3BXa2d0S2hOV0d0VWpRV0pvMVlKNS9oL01icUNEVW9YMkRT?=
 =?gb2312?B?cStLMHBlSWpBTEx6WEwzT01zTGxGMDFUOWRRbVFvaTZMdzVmRlJOOHJoZ1lo?=
 =?gb2312?B?d2xZNkZJUDVkQVJveW5MTnIvYzc3anU5ME9XYkVZV2tCbGo0UStMMlhQOVlq?=
 =?gb2312?B?SlQ4cUZrM0V2bDVzTFNGNXlHRzZTeGxqYkZvQTFxWE5UTkp6MVRKbUpJNDFR?=
 =?gb2312?B?cngraEkyeTlHWHJ6QjBkMU0zRmVHK01XVm5wcEFrVjJyU2IxUzVXMnBHV25y?=
 =?gb2312?B?enczTjBseVZyd2N3N2tMUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?M3BGNHUvWCt1dnF1eEkvMEsvYkl2a250V2RxWU96dlUwU3lLVVFHU2JOYUVk?=
 =?gb2312?B?Z3FDVmhBbWIrNUJrMm1pRTgzZHU3U0pKSU9kdkEycUNXVS9GRXVHNWV6d3JU?=
 =?gb2312?B?aDJXaVltUWpZUFFHd1RQUytZUFdtZzhubmQrUUNKdkphcGd3bG44TU9FelVJ?=
 =?gb2312?B?MzIzeWpNZ0NSWEw2VmI1WkRFK3MxaTNPWkpqaHkwZVlrcTVIb1lZWEpablBi?=
 =?gb2312?B?cHRWTkh1Q0FEcHA0cDZHU2NpWFRLWjdTVmF3QzJ5dzNKTXJMWXJURHNERmo1?=
 =?gb2312?B?UEEzdUEvS21UK2NXcjJuM0JMUHl6RW5XUWZvaDNvV2J1L0k1V09NVzFobDhp?=
 =?gb2312?B?a2cxVVp2VndTMDhmeXlvOHBrTUI0MUlkb05qVkQydjdXNjdJbmhwYVM3elpu?=
 =?gb2312?B?UTd1YnRNWllLT210Q3FpTWZlcWUydmE1TldlREluSnZNZXk4L1J0RVVibVl0?=
 =?gb2312?B?czRDZVU3YndWUkxZaDE0a0ZDSEREU0xmRXhoOWo1eDZoV0Y5a3MycHJDK2JR?=
 =?gb2312?B?NWVPeldBL21MendOR29TZ05xOEZidkhYbld2c1ZWZDE5b1lKd0d3a1B2Wk5m?=
 =?gb2312?B?Nit1d0hpWTVFem1UMm5tU1BaeVFhZmhGUnpzZFBybVM4REtDRzB6dFN6dlV3?=
 =?gb2312?B?bUx1Nmt1YzN0czhKMERIeFRwcEJCZlg1bVoxdkpmejNDY1NpTDI0UDNhdDNw?=
 =?gb2312?B?UFpNT2dXeXV3RjAzc2hzR3BpV0hYSXZsSU9DZCtleXQrZThvYzVHdmRjQnYx?=
 =?gb2312?B?Uy9UZ3U4cVVlMm9LUDNldUxXZ3RHdHVtR2lOUTVjTGJpTVlnUW5KdlpvcEsx?=
 =?gb2312?B?WkFjd3ZGV21tcURiMm53akRoYjZEZ2N2dC9wM0U5UG9SQlRuZnFPM0J2cVBP?=
 =?gb2312?B?eWR5SEpFNHVOTjAwUDd6dlpmVEczQmd6VXl2ZDBKMDNYRU5yOExUcG00cWJz?=
 =?gb2312?B?Y0ZOMW02L045eDZGZU5DU3ZVMVUzRXNYWFJwZW56dzdobHVzWFBTSHAxRGs0?=
 =?gb2312?B?ekhyWnZURXJTQmxnMlFFV0ZkZ3pVQ3d6cXhJSTJTby9rL1BBbWk5MnJZTjBO?=
 =?gb2312?B?OHMzWHhGc3FaRFUrTmloWG9odnE3WE5vMld4eTRZcDdxbHZIZmVZQWFsV3p4?=
 =?gb2312?B?MnRTeTNtVy82NXZ1UTZ4ZUEzbml1LzQ3bUE5WmFvU1BZbWJCTG82SVJwcmp0?=
 =?gb2312?B?QmFzZFp1TXMrWU5yRStIbmZjYUNUbmdFdnZEWVZkc2hUZkV1N2YzNGx4ck8z?=
 =?gb2312?B?MlRWVTdHVkx2WjFEc2ZrbThrRTFQWFB1ejBmclJIaGRrelFRYkdDTDd1aFgz?=
 =?gb2312?B?MStTdnJTdGdNZGVCN254K2Z1SEdWdXdnR1IwNFpkYjJQS292RnhQQ25SZHdr?=
 =?gb2312?B?OWJHR1RoSU1BL09LazNMR1VWandRTkFDYzQ5bFg4ekVJM2VoUkJseWNVYVp4?=
 =?gb2312?B?eWgxdWRLNXNyWkdLWFZGY2IzWE9SQkZJMjFVaENzU3c0SmJ3aVVnY1hwbTU3?=
 =?gb2312?B?WE5lS3hXK294UE1SbUNHYkhaUG9MTTFzNVRqUkhMb0Q4NDAvUlNLTVQzWGdZ?=
 =?gb2312?B?NUMxVTNYVFp5U3M1ZUhPdzFWU0RsVUp5VE95V3dvcFZIeEYwcThuTG56V1JH?=
 =?gb2312?B?Wm90T1QxbWJEZm9Xa0tqZStaZHNjQVpyM3ZlVzZFb3BQYko4YVRCelk1RmJM?=
 =?gb2312?B?c3BUVlI2ZkMrZDgxOVpiSndpQlZsa3JIMkxUcmdYMW5MY0ZFSEdBTVVRMGMz?=
 =?gb2312?B?MGpkNnJUOW5mZzArYnRReXVMMWxVWGZGeWl1akdyVVFSTGJoY3pucS9vK09T?=
 =?gb2312?B?cklBSjdLN1B3bmZ4czNSWFJiQVFHelp4SkVUb3Q1aHVnaWtBRFVjTkVPRmFw?=
 =?gb2312?B?VHgxemNNUFozVEJDM2JaYjI3QUN4bVNIaThLWkk4ODk2ZW1CMlhiMEJCVFl3?=
 =?gb2312?B?QjhMbG5RM0FKRzVjQzVSWjVGSXcyTHljRkxTOHB3dzVOTVk1V0ZVSWpiMG9W?=
 =?gb2312?B?ZVA0UTg2eENQdWp5TjQ0blkzS0pzMk9id3IvZ0sxQjhtZEplOVRTYS80RFB6?=
 =?gb2312?B?YkZFaGh6dURMQkdqN3g5WkVVMWtEcWxSV2FMYnhiUzAyTHFESDBvRWNmYWlz?=
 =?gb2312?Q?YvDU=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b71030-b40b-482f-a224-08dcdb9d3b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 06:59:13.3245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jO6KFCcy1TV8z7BwPtnj+YtpRoGHhHEZq/47Ev5LrAeaJZ3EnD/25j34tUCmgXYH1GTOeLna/slfqedU0V1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7221

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiAoT1NTKSA8cGVu
Zy5mYW5Ab3NzLm54cC5jb20+DQo+IFNlbnQ6IDIwMjTE6jnUwjIzyNUgMTQ6MjANCj4gVG86IEJv
dWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOw0K
PiB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnDQo+IENjOiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhh
dWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdt
YWlsLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsg
ZGwtUzMyDQo+IDxTMzJAbnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gbW1jOiBzZGhjaS1lc2RoYy1pbXg6IGVuYWJs
ZSBxdWlya3MgU0RIQ0lfUVVJUktfTk9fTEVEDQo+IA0KPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gDQo+IEVuYWJsZSBTREhDSV9RVUlSS19OT19MRUQgZm9yIGkuTVg3VUxQ
LCBpLk1YOE1NLCBpLk1YOFFYUCBhbmQNCj4gaS5NWFJUMTA1MC4gRXZlbiB0aGVyZSBpcyBMQ1RM
IHJlZ2lzdGVyIGJpdCwgdGhlcmUgaXMgbm8gSU9NVVggUEFEIGZvciBpdC4gU28NCj4gdGhlcmUg
aXMgbm8gc2Vuc2UgdG8gZW5hYmxlIExFRCBmb3IgU0RIQ0kgZm9yIHRoZXNlIFNvQ3MuDQo+IA0K
UmVhc29uYWJsZS4NCg0KUmV2aWV3ZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNv
bT4NCg0KUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVu
Zy5mYW5AbnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlt
eC5jIHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IGIvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBpbmRleCA4ZjBiYzZkY2EyYjAuLmVm
M2E0NGYyZGZmMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1p
bXguYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IEBAIC0y
MzgsNiArMjM4LDcgQEAgc3RydWN0IGVzZGhjX3BsYXRmb3JtX2RhdGEgew0KPiANCj4gIHN0cnVj
dCBlc2RoY19zb2NfZGF0YSB7DQo+ICAJdTMyIGZsYWdzOw0KPiArCXUzMiBxdWlya3M7DQo+ICB9
Ow0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgZXNkaGNfaW14MjVf
ZGF0YSA9IHsgQEAgLTMwOSwxMCArMzEwLDEyDQo+IEBAIHN0YXRpYyBzdHJ1Y3QgZXNkaGNfc29j
X2RhdGEgdXNkaGNfaW14N3VscF9kYXRhID0gew0KPiAgCQkJfCBFU0RIQ19GTEFHX0hBVkVfQ0FQ
MSB8IEVTREhDX0ZMQUdfSFMyMDANCj4gIAkJCXwgRVNESENfRkxBR19QTVFPUyB8IEVTREhDX0ZM
QUdfSFM0MDANCj4gIAkJCXwgRVNESENfRkxBR19TVEFURV9MT1NUX0lOX0xQTU9ERSwNCj4gKwku
cXVpcmtzID0gU0RIQ0lfUVVJUktfTk9fTEVELA0KPiAgfTsNCj4gIHN0YXRpYyBzdHJ1Y3QgZXNk
aGNfc29jX2RhdGEgdXNkaGNfaW14cnQxMDUwX2RhdGEgPSB7DQo+ICAJLmZsYWdzID0gRVNESENf
RkxBR19VU0RIQyB8IEVTREhDX0ZMQUdfU1REX1RVTklORw0KPiAgCQkJfCBFU0RIQ19GTEFHX0hB
VkVfQ0FQMSB8IEVTREhDX0ZMQUdfSFMyMDAsDQo+ICsJLnF1aXJrcyA9IFNESENJX1FVSVJLX05P
X0xFRCwNCj4gIH07DQo+IA0KPiAgc3RhdGljIHN0cnVjdCBlc2RoY19zb2NfZGF0YSB1c2RoY19p
bXg4cXhwX2RhdGEgPSB7IEBAIC0zMjEsNiArMzI0LDcgQEANCj4gc3RhdGljIHN0cnVjdCBlc2Ro
Y19zb2NfZGF0YSB1c2RoY19pbXg4cXhwX2RhdGEgPSB7DQo+ICAJCQl8IEVTREhDX0ZMQUdfSFM0
MDAgfCBFU0RIQ19GTEFHX0hTNDAwX0VTDQo+ICAJCQl8IEVTREhDX0ZMQUdfU1RBVEVfTE9TVF9J
Tl9MUE1PREUNCj4gIAkJCXwgRVNESENfRkxBR19DTEtfUkFURV9MT1NUX0lOX1BNX1JVTlRJTUUs
DQo+ICsJLnF1aXJrcyA9IFNESENJX1FVSVJLX05PX0xFRCwNCj4gIH07DQo+IA0KPiAgc3RhdGlj
IHN0cnVjdCBlc2RoY19zb2NfZGF0YSB1c2RoY19pbXg4bW1fZGF0YSA9IHsgQEAgLTMyOCw2ICsz
MzIsNyBAQA0KPiBzdGF0aWMgc3RydWN0IGVzZGhjX3NvY19kYXRhIHVzZGhjX2lteDhtbV9kYXRh
ID0gew0KPiAgCQkJfCBFU0RIQ19GTEFHX0hBVkVfQ0FQMSB8IEVTREhDX0ZMQUdfSFMyMDANCj4g
IAkJCXwgRVNESENfRkxBR19IUzQwMCB8IEVTREhDX0ZMQUdfSFM0MDBfRVMNCj4gIAkJCXwgRVNE
SENfRkxBR19TVEFURV9MT1NUX0lOX0xQTU9ERSwNCj4gKwkucXVpcmtzID0gU0RIQ0lfUVVJUktf
Tk9fTEVELA0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3QgcGx0Zm1faW14X2RhdGEgew0KPiBAQCAtMTY4
Nyw2ICsxNjkyLDcgQEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19pbXhfcHJvYmUoc3RydWN0DQo+
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICAJaW14X2RhdGEtPnNvY2RhdGEgPSBkZXZp
Y2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+IA0KPiArCWhvc3QtPnF1aXJrcyB8PSBp
bXhfZGF0YS0+c29jZGF0YS0+cXVpcmtzOw0KPiAgCWlmIChpbXhfZGF0YS0+c29jZGF0YS0+Zmxh
Z3MgJiBFU0RIQ19GTEFHX1BNUU9TKQ0KPiAgCQljcHVfbGF0ZW5jeV9xb3NfYWRkX3JlcXVlc3Qo
JmlteF9kYXRhLT5wbV9xb3NfcmVxLCAwKTsNCj4gDQo+IC0tDQo+IDIuMzcuMQ0KDQo=
