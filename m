Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD775253F38;
	Tue, 25 Mar 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892016; cv=fail; b=k2fOMf0X6/5K7QkYRu5HUVX7KI055iA7zEDGIML7IXyICV8MNniApPd9rNue8vETI8g54VCMeRT3qgIA6Wo7DH0PXW7+fbJY9NOZHHsGexj2TMclgokCvzCwf3ekh7gPZfRcjSAnkRdYbcBEEHuUikI+PBJgvkjzl/Q6eL+BvqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892016; c=relaxed/simple;
	bh=lYrskw9dDnSOdwmEQes5I0VyU/+zrzK3+9JjwCzWIb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QsWnjLY0Qm9g3xLEDnWP/djPirS7W4vNyIMB3XEcP/jFAK7hZ1nKDWggltwPNYUTIXzU0C+US+u3kmHM8RrBuOKDb1wUH1+cr3k7hQzFGN2jj91nbcrPJqyfzAVAOHeDsEHAEMH7vhAFr3pSlOPteOnseP6RffzvnFzP8NJ4IAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FOaJdR8h; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FOaJdR8h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGmJ7KG3b8kt4p9FVEm9LZJ49TM8VMd/8+XzSR30/3J69Fg0oXEdHAvs63v5cH+pLASVUtJcreqZFY2FZA9o183QUjx3NHjwcHs2nXXdCbaMFowyx/0kUprbzyKYw8nGiVjUow6OfMQpwJCzdORkY6CIWfKjokfiT/rNnYgm03YMBnxUYdyfXTNQqTkbkOye8vbMggiAjE66pIXbsJd2Xnf7oRuXyJH7sPBDvyy+l/zcKeQevsJTr1qQK6cNBG3YFcxTylgBM8NSkBsPhjbltVYm3Bo96jsdwZy6FLxQ+antcAvg2plRB2sjt+7JYglZFbVAxkTJaeKIOZZBD+FjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYrskw9dDnSOdwmEQes5I0VyU/+zrzK3+9JjwCzWIb0=;
 b=l12bMqLAK4JmZrkwlwvd6ZZ14FSXr/m4Uh+lutJvPECgkscrh/HaTSScHgqmjym8IPAGmlLiyXNhYSS763WSS+dPLsQAYiyPte/Sg01skjdMvRTpoHf4VL2/AtNfVXjO8IF11IjQ3pbRAxhhI3n+RE5I+lNXyYTcYTo9c8Xu2Me+dQIYjaClz20W2n3c47bRelJtfb23VMwMc8yBW4CgR69SJve5zsoFr8OyWSXjO9W1byc1cyurPhEpHv8NDq9gbQZWPknZIhtzNxiT68PCry6iIsZp0mgfYPT3wURmJHysuIDYc0K0Uer6SeQ8WubNhSZlzE9Hlrtif4YdEHYOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYrskw9dDnSOdwmEQes5I0VyU/+zrzK3+9JjwCzWIb0=;
 b=FOaJdR8h9iYDJDi6XakxHgXxaS1LHvfq7QWjKToE6HBcJ5JraVim1M/qQuaEGnr1hmDY5OeAI7zCzr4ilVLZV3hIr2GYlg+2MkXYuMur/WBZklER/37VxxZQ1kGWGCYfw2QOd7XzhSSKo1HWyl+ArW49FP01r5iiTL5ykJVNKCW4a5ZIR4R2GUT7Z8joeh2xcLTi2KiG7CyzxoreUODmiudKGDeoNZE5NLpENrh0Gg9vbSgX5i5p4SUYkp6Q2QnVaivWlief6lZSf2hFlaswf0bA31gUEguSgQXg+ubpd4k7wWodmp2mm1sG8YGiWgijhH2eXW56kMFWHKfs8uUGUQ==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI1PR04MB9809.eurprd04.prod.outlook.com (2603:10a6:800:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:40:10 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 08:40:10 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Luke Wang <ziniu.wang_1@nxp.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc: sdhci-esdhc-imx: calclute data timeout value
 based on clock
Thread-Topic: [PATCH 2/2] mmc: sdhci-esdhc-imx: calclute data timeout value
 based on clock
Thread-Index: AQHbnJ5BZQlqynsxpUKZ0LXVCGtrkrODg7ow
Date: Tue, 25 Mar 2025 08:40:10 +0000
Message-ID:
 <DU0PR04MB949673D7E71316D001C3872A90A72@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250324092336.2231385-1-ziniu.wang_1@nxp.com>
In-Reply-To: <20250324092336.2231385-1-ziniu.wang_1@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|VI1PR04MB9809:EE_
x-ms-office365-filtering-correlation-id: 25c0363f-4bc0-44cb-16b2-08dd6b78a754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?UDFpaWdra25uVnhJdU9jWWpoejZET24xcTU3N2hQL0RwNnFJbmorMW9TRk4v?=
 =?gb2312?B?Q1JwM2RqTU1zQjBpbnB4bUhMQVJiVTB0SCtXM1VZSHF6M1dWNlIxeWJpL0ZJ?=
 =?gb2312?B?SzVzZ1Q5Mm1seWpBWHJzNm1zNG1qMVFHaGJldHAwVGlEeS93aVJma0hiWnJX?=
 =?gb2312?B?cVpqT1lwVVJJcFVyOFphOEdRM0p2NkpIemsxZEJPNWVHVElQcXhtdHBRS2Ju?=
 =?gb2312?B?YjR5K3U3VGlQNEVzdW93SE5jUzA5NTQzRkVua3JHT0czVDZmNFY3NncrdFF1?=
 =?gb2312?B?K2ZrUWRhejM5czRpVUVHS1ZuZTBPb1ZKeFVvWjV5MElxS0hyQ0h4enIzNVVJ?=
 =?gb2312?B?YjFFcUtycVFXU2p0cGVrd3VwUy93WC9ldVYwMTVnMmdPbE5xUnZWZFlCV1d4?=
 =?gb2312?B?UDhYNThiM2o0NFdRUkFzRmhvSU5YdEEvSU83eit2bmdneFBmWFNReE9CemlW?=
 =?gb2312?B?dHVUdU14NXNGZkpYSE1MNm9tekJXVFJGUU15RXh4c2FEc3EyOXpzYWNxL1c0?=
 =?gb2312?B?OFdHYzBqR2ZoZVl4a2N1bFk3SFdLVTZKRGU3amVFaW9tWTA4dnppMG5EZDBF?=
 =?gb2312?B?TmN4Z285MTFsZ2JaUFpqUWhHdWo0azFtQmtSVVdFWVpVVmlPZHk3WmZLSVlx?=
 =?gb2312?B?Y291bCtCWFJ3WXNtT3pLSzRSQkppenNiOE0ySjNlZ2gxQUNkaXdmTTFWUDFM?=
 =?gb2312?B?SFR4a21zcTVhSGJudnNKZUt0VnJoL1ViMTNDSWtMQ2gySUxrN3VZRUxYaVZo?=
 =?gb2312?B?WTVlYm9YMFZwWmgyTzRSdkxRaVBuZTJtTUlVQ0dqYTBFZHpHeHFGemJMNnBv?=
 =?gb2312?B?eHYzdWNXcHFuOUlhcWgyMzBkN0xoMktlOVF4MjUvc0xaT29mMG1QbVU0MmN5?=
 =?gb2312?B?VGtabDVoTjI2ank1STJ0WmJJQTVsaGYyZVdHZWxpWVlaa21kd2VwS1Jmckc0?=
 =?gb2312?B?RFZsaU1aVzE3TE9pOXRBZHZIUGptVk1ya3BsbDVMTUZIdzFSSXVXZ0V3MDFH?=
 =?gb2312?B?ekNEdWNkSG81cytVaWV4M09WVDBJRHpERkJXNUdDSTNHakFxNWZuQTZOUDly?=
 =?gb2312?B?TzlGSlVJNXB3UkRiK0dtUThmN2dCZXcxUTZxRzhBZWhPb0xMWC9RNUlEL3Mx?=
 =?gb2312?B?bXNuc3VxOTBrcWtXV1JKK21yVi8xSytTazdSOEIyYmllZlhYejVlemN1VFVV?=
 =?gb2312?B?Vm5KQ1FxQ3psSWs1Z0psM3FDaDdaMEUwaDV2RzMvcktOTWFURHl0UGlCM2hG?=
 =?gb2312?B?cENCOXVia01WUTZvc2Z6M1ROejFBNDNnazN6blZVRnYzcHh6d3EvS3NWaHhy?=
 =?gb2312?B?SEdOM2Zwa1Y5Y2pKclo4U3drcXY4UVMrWHAxamZ5SGM5OTltZ3lRazlXN0NN?=
 =?gb2312?B?aDFYWGwyMDZ4Ymh0dWVhWmhheDFnUVVoTzNhT1NRMHMveDVwbFkzNUtEN3pO?=
 =?gb2312?B?SndBQVlVbWRSMklyMUpSZHgvZExpOWZBaVgwbHZMNDBvNHJkbnJtMkFVS3ZG?=
 =?gb2312?B?ZkQzeXVZV3NYQ1J4Myt5OUk5WnAwdHk5UFhVZHFCeExNaGt2ZThuY0thdFF1?=
 =?gb2312?B?VmxGcWJzYnYxRUVjb2Q3YWVXYlo1SDUvbk44eG1BdmVYd0xzUGxsSWUyTUR5?=
 =?gb2312?B?ZkdBOERsaEtmZ3NZOWdMekphWEFJWHN2WDR6cHNBdElRTjh3cHZGSDloekdH?=
 =?gb2312?B?R3hJRFVscTk0TWJsUHArdjFOMmZOQndQYUt3OEE3OG56azM2Nk1rVkZabWZr?=
 =?gb2312?B?T2E5Y3pzNWlIVXZpanZTbGVLUkZPUlZrWjE1c0MraXBlNUUvTjlGcUhYb3hm?=
 =?gb2312?B?YlJISGpTUGI0SkhIYVhqamI2bCtKbURsRkQzb3A0dGFJU0hjcUJ3amxkUjFp?=
 =?gb2312?B?TTU4RDF4NmlCUjRVaE1HMU41NzhuN25YWGhMNDRYZXJQZVhkM08rME9xOWds?=
 =?gb2312?Q?zpXdq41R719lOO6Sv9dKU8e6wL0mAp2f?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SXYzSWh2QjlOcktUaUN1S2Y1dkY1Z0R6bDFjMHhyd2xCN0ZyVnZyQmNwOUdo?=
 =?gb2312?B?VjdPSmtEVCtwZmdTRzZUVTMzNEE5andvOFp2STBPb2kwNDVXUGdueEZjOFVp?=
 =?gb2312?B?NWRPb3hRRDFRY0hvdEREckNJUWZySWxNYTlPQ1JrdkNxQnBQZlFkL2M0by95?=
 =?gb2312?B?TUEzbm93U3JwQlZpcllRbUtmV0lZWmo4OVNUVk5XTnhnakREREs0R1pFYTRU?=
 =?gb2312?B?cXM1RmxvVDQ1M3FLQTdQWEpqMCtNbGVaOE1hS0NFSHpQNEFEU1Rrb3p3Slgz?=
 =?gb2312?B?eWV0N05RakJHdDlRdUVOMVd4dEtFWFFjZTBGcHVPdFFTdFN5bFYvL0tKL2tz?=
 =?gb2312?B?U2Znb28zL0JmeFdMZlQ2d2UwWFduMjZDWW4zeUJ2M1hnclNOdWZqMjA1V2ZN?=
 =?gb2312?B?SjFKb2VnL2FXdzhhTTRqOU9FMXdzOU9NajltZ2FzZDVSdFJPcld1RXVZRkYy?=
 =?gb2312?B?NFVERUtNdXZCSitsWS90aTBOYWFwSzFEOFJXRmdBRkhVNE92TTlnMnMzOUZs?=
 =?gb2312?B?MHVSdTJkTk9GZFV3TGlZMlVBYlZodTRpaHQwNU5sd3REQzJzQTZhUkV2bVcw?=
 =?gb2312?B?K1k0MVl1OFhSd1lLZ2UwSGIxT1gwcmZvdXhzQm1YTnJNKy8wT1RaSUtmcEZ3?=
 =?gb2312?B?b1piVzZURVlnRnR0bStCUnIwdCtJNVRNSGZvRTdLQ1NLN1R2dGNiWThLOCtH?=
 =?gb2312?B?N0c2RkZIVWxiY1o0VDZoUnoxQ1E5eDhnTWpGVzR2c2g3Z1lIZnBPM2dkbDQ4?=
 =?gb2312?B?dUMvanhvL2d0Z3EvRHRlbVJSbkJwc2tsTlE1NEhTaVVNdEszN1ZTU3J0Skxr?=
 =?gb2312?B?Y2ozYTZZYVlHY2RYZFVOMmdUaUtPVTh1UXY4dHk3NGQvMXMyMGYyWWV2NEl3?=
 =?gb2312?B?RXVyRWlEWEI3M240VExudk9qOWIwdHkrU3pxeDdkTEIxUmtRMzdIVzc2UlQz?=
 =?gb2312?B?S1FPU25rR0JmMVA2UmdDSUJxbHJyci90QVBPOVl5ZVN6eXpzVnc4dVJ4dXdN?=
 =?gb2312?B?MVhkUHlmc0FHVTZTK3UwdnA1STVhUDFBTlNJTU9XY05tNFRoaFl6UHlWcGcy?=
 =?gb2312?B?MUY2Y3loM1NnOE9xeEdtTmlISjRqR1doaFdLUmxURGx3eEQvc3VlWnVmVEhv?=
 =?gb2312?B?Y2s1Ulc3ODg5d2ZUM29DUWdXMjloRjVHRm9zd0g4cFR5ZHhjWlM0alhtS3pm?=
 =?gb2312?B?ejNLcVNHYzNncW5YSmZ2NG9wYWROMEx3MWo3bHdoaG90UXhWS2swS1dmVng4?=
 =?gb2312?B?TzBRd2ZIclEveXAyVzQ1aEVCOTNBS0JuVmdUcXJsOGhmMis3M1E4ajU2YzIy?=
 =?gb2312?B?bTczaFdxVHNaTE13aDhIR281eTM4b01yRk1iaSt4UlA4MlQ3K0hOaVlYRXdN?=
 =?gb2312?B?V0JWNkZuRzJlcHFsMFJHVXVRcWthQkdVQmsxZmhpZ0NMVE5qNzNoZ1ZSakM4?=
 =?gb2312?B?MUZhN0JpNkowOVNMUk45eFgzMWFHWURNSDlLajlBVE04SlgrTmNTazMzTmpT?=
 =?gb2312?B?ZkJOeWdESGgrZ3dNKzFIYysvTjdJRkZKcTNHclR0ejI0ZkxqT08wWVlxZVVB?=
 =?gb2312?B?Zm96YWxqWnc0RXhOM25zdFdKOEo5b3VFYlhXLzJpcTJVVk5PQTlJdmYyY1RB?=
 =?gb2312?B?UVhFQlQ0eHpqayswaE8xc1RZVU5naE5DMXhOa29oVERNVVc0c3plenZreDhX?=
 =?gb2312?B?N3NlaGJhaWtOZ3h1REdsK3p4NzNleklsOVJwQTB5cU02c2s3Y1B4TFIzOXE4?=
 =?gb2312?B?R1A1WVZ5a1RPa1hBT3RkL2Q5ZDByWXV0MDA1M0FRYkwxS3dta2FnT0F4MGRv?=
 =?gb2312?B?MlZVY2pYK1lLT0gxbkJFdEg3OWlUeloxbmlQMkhwenFUei9nY1ZPWUNTTUxX?=
 =?gb2312?B?aGo2dGxSNmhlSDV1VHpaSStYZ0pJenFQYTNzc21WcWpPNTlsYm4vSUtLb2ow?=
 =?gb2312?B?bEpBN0t3bm15YitXcnRiSkNtTktINEx3eVF0aUNVOGYyVlc2czFtenFBMThB?=
 =?gb2312?B?WVpvOWVFTGhEdmZHOUI1VTlVT1VhRGZlaUpKbTF1WGN6ZnlXazExUUkvQnJ3?=
 =?gb2312?B?bE1aendlNlpRaFI3NmxBVVY3SExZQWptdDJYTDREdlpXNlVLN0o2cXMzbzhY?=
 =?gb2312?Q?TjkY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c0363f-4bc0-44cb-16b2-08dd6b78a754
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 08:40:10.3657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKl6fF0Cc8mw5+PiT3uIqv17Qa541kxbP0aROBP3oQzd5o2YisGeFnccIfTCPmgZMfN8wKan6dH1oyyxn+WkIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9809

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1Lndh
bmdfMUBueHAuY29tPg0KPiBTZW50OiAyMDI1xOoz1MIyNMjVIDE3OjI0DQo+IFRvOiBhZHJpYW4u
aHVudGVyQGludGVsLmNvbTsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgQm91Z2ggQ2hlbg0KPiA8
aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5j
b207IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGRsLVMz
Mg0KPiA8UzMyQG54cC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDIvMl0g
bW1jOiBzZGhjaS1lc2RoYy1pbXg6IGNhbGNsdXRlIGRhdGEgdGltZW91dCB2YWx1ZSBiYXNlZA0K
PiBvbiBjbG9jaw0KPiANCj4gRnJvbTogTHVrZSBXYW5nIDx6aW5pdS53YW5nXzFAbnhwLmNvbT4N
Cj4gDQo+IENhbGNsdXRlIGRhdGEgdGltZW91dCB2YWx1ZSBiYXNlZCBvbiBjbG9jayBpbnN0ZWFk
IG9mIHVzaW5nIG1heCB2YWx1ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1a2UgV2FuZyA8emlu
aXUud2FuZ18xQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2Ro
Yy1pbXguYyB8IDE1ICsrKysrKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMt
aW14LmMNCj4gaW5kZXggZmY3OGE3YzZhMDRjLi5lNzMxNmVjZmY2NGUgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysrIGIvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMzEsNiArMzEsNyBAQA0KPiAgI2luY2x1ZGUg
ImNxaGNpLmgiDQo+IA0KPiAgI2RlZmluZSBFU0RIQ19TWVNfQ1RSTF9EVE9DVl9NQVNLCUdFTk1B
U0soMTksIDE2KQ0KPiArI2RlZmluZSBFU0RIQ19TWVNfQ1RSTF9EVE9DVl9TSElGVAkxNg0KPiAg
I2RlZmluZSBFU0RIQ19TWVNfQ1RSTF9JUFBfUlNUX04JQklUKDIzKQ0KPiAgI2RlZmluZQlFU0RI
Q19DVFJMX0QzQ0QJCQkweDA4DQo+ICAjZGVmaW5lIEVTREhDX0JVUlNUX0xFTl9FTl9JTkNSCQko
MSA8PCAyNykNCj4gQEAgLTEzODcsMTIgKzEzODgsMTYgQEAgc3RhdGljIHVuc2lnbmVkIGludA0K
PiBlc2RoY19nZXRfbWF4X3RpbWVvdXRfY291bnQoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpDQo+
IA0KPiAgc3RhdGljIHZvaWQgZXNkaGNfc2V0X3RpbWVvdXQoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QsIHN0cnVjdCBtbWNfY29tbWFuZA0KPiAqY21kKSAgew0KPiAtCXN0cnVjdCBzZGhjaV9wbHRm
bV9ob3N0ICpwbHRmbV9ob3N0ID0gc2RoY2lfcHJpdihob3N0KTsNCj4gLQlzdHJ1Y3QgcGx0Zm1f
aW14X2RhdGEgKmlteF9kYXRhID0gc2RoY2lfcGx0Zm1fcHJpdihwbHRmbV9ob3N0KTsNCj4gKwli
b29sIHRvb19iaWcgPSBmYWxzZTsNCj4gKwl1OCBjb3VudCA9IHNkaGNpX2NhbGNfdGltZW91dCho
b3N0LCBjbWQsICZ0b29fYmlnKTsNCj4gDQo+IC0JLyogdXNlIG1heGltdW0gdGltZW91dCBjb3Vu
dGVyICovDQo+ICsJLyoNCj4gKwkgKiBFU0RIQ19TWVNURU1fQ09OVFJPTCBiaXRbMjNdIHVzZWQg
dG8gY29udHJvbCBoYXJkd2FyZSByZXNldA0KPiArCSAqIHBpbiBvZiB0aGUgY2FyZC4gV3JpdGUg
MCB0byBiaXRbMjNdIHdpbGwgcmVzZXQgdGhlIGNhcmQuDQo+ICsJICogT25seSB3cml0ZSBEVE9D
ViBmaWxlZCBoZXJlLg0KPiArCSAqLw0KTm8gbmVlZCB0byBtZW50aW9uIHRoZSBiaXRbMjNdIGhl
cmUsIHRoaXMgaXMgYSBiaXQgY29uZnVzZSBoZXJlLg0KSnVzdCBkcm9wIHRoZSBjb21tZW50IGhl
cmUuDQoNClRoZW4gZm9yIHRoaXMgcGF0Y2g6DQpSZXZpZXdlZC1ieTogSGFpYm8gQ2hlbiA8aGFp
Ym8uY2hlbkBueHAuY29tPg0KDQpSZWdhcmRzDQpIYWlibyBDaGVuDQo+ICAJZXNkaGNfY2xyc2V0
X2xlKGhvc3QsIEVTREhDX1NZU19DVFJMX0RUT0NWX01BU0ssDQo+IC0JCQllc2RoY19pc191c2Ro
YyhpbXhfZGF0YSkgPyAweEYwMDAwIDogMHhFMDAwMCwNCj4gKwkJCWNvdW50IDw8IEVTREhDX1NZ
U19DVFJMX0RUT0NWX1NISUZULA0KPiAgCQkJRVNESENfU1lTVEVNX0NPTlRST0wpOw0KPiAgfQ0K
PiANCj4gQEAgLTE3NzcsNiArMTc4Miw4IEBAIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfaW14X3By
b2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCSAqIHRvIGRpc3Rpbmd1
aXNoIHRoZSBjYXJkIHR5cGUuDQo+ICAJCSAqLw0KPiAgCQlob3N0LT5tbWNfaG9zdF9vcHMuaW5p
dF9jYXJkID0gdXNkaGNfaW5pdF9jYXJkOw0KPiArDQo+ICsJCWhvc3QtPm1heF90aW1lb3V0X2Nv
dW50ID0gMHhGOw0KPiAgCX0NCj4gDQo+ICAJaWYgKGlteF9kYXRhLT5zb2NkYXRhLT5mbGFncyAm
IEVTREhDX0ZMQUdfTUFOX1RVTklORykNCj4gLS0NCj4gMi4zNC4xDQoNCg==
