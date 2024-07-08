Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013071.outbound.protection.outlook.com [52.101.67.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8166A934;
	Mon,  8 Jul 2024 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405639; cv=fail; b=YVFVJoS0QvGLkdcDq/iCewEVS6MnLI4mbd4v7K3UNCs7EThluvY8ayPXrZFrivXRZ5d/wN2/2HQfZmHgCyewsvg0wv0+NbzTYNN3NRli/7VvYecOLf+2xdRab5zOMgOIeQiHxed98iwjYqzvrFHyvyC9YivJzITplHnUiob52EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405639; c=relaxed/simple;
	bh=1juwKrC7tzzwE/lXTOV/w0K4A4PcY667YDZGgQEOhSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WbZTVN0czRolcx4QfCEIO2PTesua9BEiqJYy3LDD6Vi6UvDcCVYqEomIxY+rdCbWYABXpraasWi91du6FGJSBa8NjN9P2VUjeRNiEDi4Ie8nfsj1KNDy+ajy7OK0R4smHodl8rKOGgLYFWY1n9MPbWpUYngm5FXrXM3hYPqQz24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PDzEVmNs; arc=fail smtp.client-ip=52.101.67.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PDzEVmNs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+VPtXtSRU+FYcz5vsSpA20vob6pq/RX118Qd/83+Twuim3nZysysgl2I6/P6XqaqWcOBNds3+/2fZb4C5EjwpA6PqVmXauPEtoLTCH8Wsi1IhZXH6araPx1lhC2tbMRBJkMhVUuiz+U9e6vZdkpKr2hbUnbgjNaoG6qcQSoTaHnQgbZf47LGlf5E99Qjqk89b86KJZ5rt9Q3WLmhx8FHXV0g6x2cz2UdoK8zrmynnCJs9RYOMKkFK2bKjb6EvfcCiVLrjE+AU2B/sWzsOhr2I5wc9NSJ57jSpyb+J01RbSRaClJKGz0gob4rL3pZ7RclI7i4zoozwfajPWKxLEhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1juwKrC7tzzwE/lXTOV/w0K4A4PcY667YDZGgQEOhSA=;
 b=bqJ/rJ59d8HudJubJ0+dnLzUSK7H24eC3c7x7Z1xuXY1qJRsiUt7PxOlyfkcqMArxIj37yw4AOgrsiIowh6fYY3y2rhN283vcy1P2YdCh1wqStweRpaGIZRX/XXWAJ1qweXzPHa8OfZXghMpp+NJAwLmTfIMTrqZPkbtrwzla9ySFxtPshY3HkW6N6Yqkss/yZN67jtxRJMZ3p6UvrFWi19SlJVAUIO1w9hOlcGItqV4uWSlyGQ6kjV3UQzpMJosV1Lxw2nf1lqPJySiISMIbfXgwIKnH+Rs5JvCBz2G2AVdlHeowkcXDL0AczLQrygRORKwgN6OqEemlW8N5jwAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1juwKrC7tzzwE/lXTOV/w0K4A4PcY667YDZGgQEOhSA=;
 b=PDzEVmNsjqRiV8vvXagr+HDHQjfbsbSi2RZiog2LDMVoGQoBJPKl7ctmvfro+8AVFv7v+d034YXG3MJwGz/P2PACd5krFNwT6tOIr9mdnfvWRTDy4XTXLzCqv3gUDSGmwEXpvwOPlmhNvqdENRDCwGoYfgNxl/PHhTI+0EXc2pk=
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM9PR04MB8132.eurprd04.prod.outlook.com (2603:10a6:20b:3eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 02:27:13 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 02:27:13 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Ciprian Marian Costea (OSS)" <ciprianmarian.costea@oss.nxp.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, dl-S32 <S32@nxp.com>
Subject: RE: [PATCH 2/4] mmc: sdhci-esdhc-imx: obtain the 'per' clock rate
 after its enablement
Thread-Topic: [PATCH 2/4] mmc: sdhci-esdhc-imx: obtain the 'per' clock rate
 after its enablement
Thread-Index: AQHazuHdu7ZBNZoMrkav9E4yFfxMILHsHrdQ
Date: Mon, 8 Jul 2024 02:27:13 +0000
Message-ID:
 <DU0PR04MB9496099D1A11444C4475870F90DA2@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
 <20240705134647.3524969-3-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20240705134647.3524969-3-ciprianmarian.costea@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AM9PR04MB8132:EE_
x-ms-office365-filtering-correlation-id: 1a785277-ba0a-4e14-6252-08dc9ef57a71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWxOaFlidHQvRFVFVlRwOFF1SThlNEtTMDJ4cEFtM2VlRVllMjkyd1hqMlpF?=
 =?utf-8?B?N1ErbG5WLzVTSjNCREFta2xIdS90dXIzaW5UWXlDbjVqckZqdUZmcHYraW52?=
 =?utf-8?B?RHozWkRkbUJDajhwWTJlekdiemNiTnI4b3drdWo2Z1lEN0V6enBvNUNaVm9E?=
 =?utf-8?B?QmFYdi9sV281VHZSMjZCQSsvVVRseVNlU3NPb0dDSlFGZnk0WTlNcjY3blVr?=
 =?utf-8?B?QW9pTURkZCtjUWRaVDhkYmIvZ3M5MnJuRVF2RnprMW91bk03V09VMXkzbFdS?=
 =?utf-8?B?aGEzcmxRRlJndjdNSkR0enA1WUNmZmFtMjVaSHg1ZDZhRlRDMytBOGFXTTM0?=
 =?utf-8?B?TnFoWkNVaGptTmhYTXNEbE5MbklYVk5hM1Jub2VHcXo2dVQyc0RsWFlvZzRL?=
 =?utf-8?B?MjVTUi9NeFVwR2lPNDB1TmlIU3pNNmFFcHNWRFBsNy8yZlVBTnh5TU5pVk9v?=
 =?utf-8?B?bjVqYjFhY0t6TTRWZy9EejAxbXpQa0RuemlVU05HeGQ2aEgxUkZCMXFmSWh6?=
 =?utf-8?B?REtpN2V5THVOYUtFSGVCWXNLYmVZZDFaZlZVaHJDdVZwZGlRcmh1c0gwSFpt?=
 =?utf-8?B?Vi9vWlhUdUNGNTBBV0dNMXpGenM2ZC9jNjVpRGlkelJldmZtZUgxUURweDZZ?=
 =?utf-8?B?eG4zZE50Y0lDUGV6VFJUTEtSdDFvZ3hqY0QrNDd3K01nU1NWZFdBdXphU1RD?=
 =?utf-8?B?TktLYUxSTFVHVUlhSmExWThIQU0vakdqYWhQeThTY3hNMkU4TWRkNFBUcW9S?=
 =?utf-8?B?VC83cTZEQ0c4UE9UQzVyN0NWR0Zic0txRHY2L2I4MU1pVWJ2d29yRzR0VytN?=
 =?utf-8?B?eXlqUm1nS1I1bXNoUENPMlU5Z0VoUDlBT0pzaS9NTXN0UU5XdWxkMktaMkhy?=
 =?utf-8?B?cnU0THBjRVU3QjRnaUc0UFkyY1krK21jKzVJbUNINlB5YjhUcE1jb0VkSHo0?=
 =?utf-8?B?eTJtUHRRbFB0RXFqc2gyS2FqMFdtQzJJc1g3UkIvQlgxYWI2TGpZVkp4bDU2?=
 =?utf-8?B?a2pyOGFTckIvNnFrMVlQLzhjd09TdTc3TDZGUTlsZGpncXdrdDIxNEtEYWxj?=
 =?utf-8?B?dUVTcWYvYnFzUWFXSkJRcmcyWFBVOXM0b2ltNlZ1TzRCOWdkTmFSZUJxcmFB?=
 =?utf-8?B?bXdrT1FQeGpvNmJMVlBKZ1pEWlBXb0VzdFNlVHpyL1o0d3R1aXRWNzJPOTVy?=
 =?utf-8?B?VUtOdndWZ3laYmZUSlpjYjJsajlrTWJaaFhiRVRUdVFBVmpldXJmWkZ5cHli?=
 =?utf-8?B?OXFoQW9sL0VOTnNMYU5qbmowSTk4ekxEb0l4STN6UzFLMUttMlovUGdCL3Z2?=
 =?utf-8?B?TFBGVHpwMVRML21LeUNsczdyZFYyR1N4U2ZMdkFHcno2em9CNnlYbHllYjNV?=
 =?utf-8?B?VXpyaUlMSG9RSElXQ0NtcDlWZ2JKcC9hY2FxT1ZKMGIzN3JQb0swemlNMTNm?=
 =?utf-8?B?MVFzbEtPekhMVXZsb3djWFFTYUJjcDZZYTFLQjNpYlcySFNhSHNMRElWQ0lP?=
 =?utf-8?B?ZHJhMGJJLzZ2U1JmQXB3VWhDRVhwSnlwUzRsaXlkMU1maWZJQmxlKytJUkov?=
 =?utf-8?B?MmZBbFhKSDZRcUNueFFVWE1vS0kwODBKRzFvekx1UTdMVldZWldNWG5pWVZ4?=
 =?utf-8?B?THVMV084Z0kvOGpFVFcxb1RsQmdDTWVpSmRMeTZLKzVtUjJ3MXVQR3MxRHAx?=
 =?utf-8?B?bU52Y2gxNUJLa1JYaTFMVmU4a1dTYUdxcnRtZUxsaXp2bVpodEdxSXlKSzF1?=
 =?utf-8?B?K01HWUJ5d3QwWHg1dklaZlNyWVkzcUV1d2pQckU3dWEwR0d2NDlqMHRlWDRx?=
 =?utf-8?B?anV0ZlBVaFBhSzBlc0ZVYWJLSVJ3SXlRN0FiczJ6TzhuTmtYaVd4M0tuL00r?=
 =?utf-8?B?U1B4Wm81VU9uNDZ2OTBtdm93RWQvdHp4QzJaOS9kenZHVUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SERJbmVzM1RqTExKZXZwb1BnYmtEcWd4MUVtQ1dUbWJQQVFhUWo5MmJhWHNG?=
 =?utf-8?B?WU9pVTlFaVE2UGhXWHZSVkw5UnJaK3pYbnVUcUxscGI1MHNzNVZIQ2dpOUZZ?=
 =?utf-8?B?VlBVZ0EwUGpvZ3RkdDBXaStpNllRMnJQYmRvSW9RbVlzRlVRZ0Z3MVRQVzRS?=
 =?utf-8?B?VWRkZVp0N0dTWDR0UEpkeEJFQWZEcE5LS3pjM3JORVRjYTJybFZ5b2VFUXpy?=
 =?utf-8?B?eXV1SEVwRkE0dVZXVUdWMC9nMklLZUVOTEtyczg5ejdRM0RjUGIycXpQRzNu?=
 =?utf-8?B?R1hDbHdERUdWa3FjdTNGN2lYUGg0UFNaNGdiZ2d2bFJFditpTXE0RXpmRnJW?=
 =?utf-8?B?a1NFUTV2TldIRllXTU4zbG0vYyt3bVNTSUFBbUU3b0t3T1BWaWpGUFRMd3Vo?=
 =?utf-8?B?aTFqcldSZTd0cUlnejJxM0ZsZlY4cmpQWlQwbDVoTTE5RVpqUktwdzdHM1JB?=
 =?utf-8?B?L3hQVXJ2Z0NKYWNCQTRFempwVkxzcElnNXVjRzdzSEVzOEJNMERaUlJxRllu?=
 =?utf-8?B?eU16Y1J5RUhzYTZwM2k2QitjaTQvVGI5bWdNMlhmbUM3R2RINVlmeGZCQ3NQ?=
 =?utf-8?B?bTJ0cG5zek42b1FNb2hIeE9DVVdBQ1dFemI2dHlCZkNFWCtyTGRnbk5Rdmha?=
 =?utf-8?B?WTN1aXBXMk1EbzNKTlhYVjRXUGZTbCsrS1drRVFuUk9scFc4U0NtVXJpSkhL?=
 =?utf-8?B?WGJ5NDhxZVRzeW1RSlRucUU0SFlHZzRnZy9jVGxFcW5sYkNoZUwwdUptOVJ1?=
 =?utf-8?B?WkhJRHEzUFNXOHBKWUNmK0NwOXVxUkR6QWp0bGUwUzdxSTg3Q21kVTRyZnZi?=
 =?utf-8?B?S2JMU3lURzd0WmhENDcyYjhmTUJ0MEF4bnVJaVRzWFJDUGlXOEZjazBLbFhy?=
 =?utf-8?B?L2RUUm8vbjVQVnhqUkJUWDAzK0hQK0xwak4xdE1ZWEgvRnRhenZ2UXBFVDVl?=
 =?utf-8?B?UkkzSERQaUNKaStXMjN2Q05pQzkwMjFQbS9JUFRURzdPWStBV05XeUgvRHV4?=
 =?utf-8?B?VEs0MDUwUjJYYTduZEJQbFVkMDNhQWVYbHg4YTJ2bHJJSUxlR2RaWFh6am1M?=
 =?utf-8?B?eUtSeFdkUElqVzAzVVN3VjlReXZoV04vNzVZNlU1R1V5bnhYMk1CMnk0QnhR?=
 =?utf-8?B?NERhYUt2K01rOVErU212OGExckdSd08vcWx6Y1VDTjdsbTZZTGNPT3lWTEIv?=
 =?utf-8?B?NzI5eStVQmRyRFg2WlBzRmhrb1QvMFZFWkZQY3B4d3kxWENjMm9LSTJLRlc5?=
 =?utf-8?B?WG5rMzlhSFhWQS9LOTlGRGVtaVZwRTdZTVJHcXp3YjZvWG1QdU50dVcwZndP?=
 =?utf-8?B?SWhnNHREaE5VRWtpbUtabVlFRXBIQjdaRWRiMWF1TG5ob2laWlFqU3VWT0Nk?=
 =?utf-8?B?NjBUdkRIU2JWSXgwL2x0RDBBU0ZrYU1rbjFoV0NsN1BrS2RsMCtlSVVxQnRP?=
 =?utf-8?B?dmZwUlFUNlV6K2ZSWjFRQmk2RzJ4VmVZa2l0amlHcUlUVkZHVE5KcjlBcDFD?=
 =?utf-8?B?Vlk1dzRybVl6ZUJ5cFVoSkp6MWdOV25JdHlKZDV6UEFrcXo2TWpYOFBBWUpy?=
 =?utf-8?B?M3VCS25mYXVKbDBueW9GRDd0SXNlcFR6RUk2d2kxaXF5WjdENThxVXA3Rzlo?=
 =?utf-8?B?ZDg3b3NrblhCM0Zhd1k0VmtsV2JYQkhON21rS1I1Nklaa2VkaW4wd21vRTNQ?=
 =?utf-8?B?aWZacWJ1N0ROZ1NhRzQvQzdXMmZKclZVblAxNVdqbDlySzFDT0xBdFZGWDNa?=
 =?utf-8?B?MXYxcDNOdUJpTkE4cWtMaE1pWTNlQVBlL0ZKdTNhYmVJM2NmTUI0YTVDRUZO?=
 =?utf-8?B?V3NnV2tnL2lPVzl2T1hic214cVhraXp0Z1Q0S2Y4ak1UQ0JXOVI2c2tQRGJ0?=
 =?utf-8?B?dDVvSXJvTkN2SkMzeWs4Q080UndOYnpOMS9kb3lWbUZPVXlJQ01WNEtIdlZI?=
 =?utf-8?B?U3JSNWZUdVR3M3ZQZ2J5bEk4QkdUcnhtb1lVNTJPNHpzSFJhWmFGUi9tYXAw?=
 =?utf-8?B?OUY4Z252enR0MW1kV29xVXN5YVZKZWRYTjFBWnBZQVZpbmVSK2lSRlFEKzd1?=
 =?utf-8?B?dFF3SjNvRHJFNGxJSDNWUCtPcEI0MG13WCs1UTY1bitIRnVSQVhHOVhscEZQ?=
 =?utf-8?Q?FstM=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a785277-ba0a-4e14-6252-08dc9ef57a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 02:27:13.7745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8lPFNg5LUmUsNH69KUtvi4+EnPMuPNlULELLjxssPn7weLFqCB5CppKlOIsKZFPkN28MHXcAqm5xOP0T9tWeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8132

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaXByaWFuIE1hcmlhbiBDb3N0
ZWEgKE9TUykgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9zcy5ueHAuY29tPg0KPiBTZW50OiAyMDI0
5bm0N+aciDXml6UgMjE6NDcNCj4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47
IEFkcmlhbiBIdW50ZXINCj4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgVWxmIEhhbnNzb24g
PHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRyb25p
eCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8
ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkbC1TMzINCj4gPFMzMkBueHAuY29tPjsg
Q2lwcmlhbiBNYXJpYW4gQ29zdGVhIChPU1MpDQo+IDxjaXByaWFubWFyaWFuLmNvc3RlYUBvc3Mu
bnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDIvNF0gbW1jOiBzZGhjaS1lc2RoYy1pbXg6IG9i
dGFpbiB0aGUgJ3BlcicgY2xvY2sgcmF0ZSBhZnRlciBpdHMNCj4gZW5hYmxlbWVudA0KPiANCj4g
VGhlIEkuTVggU0RIQ0kgZHJpdmVyIGFzc3VtZXMgdGhhdCB0aGUgZnJlcXVlbmN5IG9mIHRoZSAn
cGVyJyBjbG9jayBjYW4gYmUNCj4gb2J0YWluZWQgZXZlbiBvbiBkaXNhYmxlZCBjbG9ja3MsIHdo
aWNoIGlzIG5vdCBhbHdheXMgdGhlIGNhc2UuDQo+IA0KPiBBY2NvcmRpbmcgdG8gJ2Nsa19nZXRf
cmF0ZScgZG9jdW1lbnRhdGlvbiwgaXQgaXMgb25seSB2YWxpZCBvbmNlIHRoZSBjbG9jayBzb3Vy
Y2UNCj4gaGFzIGJlZW4gZW5hYmxlZC4NCg0KUmV2aWV3ZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJv
LmNoZW5AbnhwLmNvbT4NCg0KVGhhbmtzDQpIYWlibyBDaGVuDQoNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IENpcHJpYW4gQ29zdGVhIDxjaXByaWFubWFyaWFuLmNvc3RlYUBvc3MubnhwLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgOCArKysrKysrLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IGluZGV4IDIxZDk4NGE3N2JlOC4uOGYw
YmM2ZGNhMmIwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlt
eC5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gQEAgLTE3
MDksNyArMTcwOSw2IEBAIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfaW14X3Byb2JlKHN0cnVjdA0K
PiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJfQ0KPiANCj4gIAlwbHRmbV9ob3N0LT5jbGsg
PSBpbXhfZGF0YS0+Y2xrX3BlcjsNCj4gLQlwbHRmbV9ob3N0LT5jbG9jayA9IGNsa19nZXRfcmF0
ZShwbHRmbV9ob3N0LT5jbGspOw0KPiAgCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShpbXhfZGF0
YS0+Y2xrX3Blcik7DQo+ICAJaWYgKGVycikNCj4gIAkJZ290byBmcmVlX3NkaGNpOw0KPiBAQCAt
MTcyMCw2ICsxNzE5LDEzIEBAIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfaW14X3Byb2JlKHN0cnVj
dA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKGVycikNCj4gIAkJZ290byBkaXNh
YmxlX2lwZ19jbGs7DQo+IA0KPiArCXBsdGZtX2hvc3QtPmNsb2NrID0gY2xrX2dldF9yYXRlKHBs
dGZtX2hvc3QtPmNsayk7DQo+ICsJaWYgKCFwbHRmbV9ob3N0LT5jbG9jaykgew0KPiArCQlkZXZf
ZXJyKG1tY19kZXYoaG9zdC0+bW1jKSwgImNvdWxkIG5vdCBnZXQgY2xrIHJhdGVcbiIpOw0KPiAr
CQllcnIgPSAtRUlOVkFMOw0KPiArCQlnb3RvIGRpc2FibGVfYWhiX2NsazsNCj4gKwl9DQo+ICsN
Cj4gIAlpbXhfZGF0YS0+cGluY3RybCA9IGRldm1fcGluY3RybF9nZXQoJnBkZXYtPmRldik7DQo+
ICAJaWYgKElTX0VSUihpbXhfZGF0YS0+cGluY3RybCkpDQo+ICAJCWRldl93YXJuKG1tY19kZXYo
aG9zdC0+bW1jKSwgImNvdWxkIG5vdCBnZXQgcGluY3RybFxuIik7DQo+IC0tDQo+IDIuNDUuMg0K
DQo=
