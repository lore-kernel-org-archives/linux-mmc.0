Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B987168497;
	Sat, 31 Aug 2024 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725090464; cv=fail; b=lAymRGe2KAwA/a2iRN3MyLh+kvDvCwZRdOrDe/kxBVjQkjVKo2hpimBF+Iw4dnaCNPwfvm48ISKBlq8ZFiHJn4ogAB8L4gTU05ekZbdCTy3XaxdWDvcSWcjIWFYXbRtkwCri8Ce2RFzBeoA4VSue33nD8Pcst9nThlTXbnsbwC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725090464; c=relaxed/simple;
	bh=9XV1G0//k/JmvcM0XLsOTQG7haQj42sNBnztg9wszQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSaBTWpH4fiu5faMWQPzJCx4r+eDhOeUwfe8ADM7j1ySaUxVZhdX29c5/8QKhPoJPa+NqP40kR/1bRuqODTFw+8D6OSoeoU061dFtAJDHZbIgLkW/a0EV6/WMLE2psVy6/v52XICXyROexRqxcKbR9DYKkHvd196QD63a+aqUgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=3mD9oZX+; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="3mD9oZX+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qy/muj9R97cDw+E+tKsW1V9h9/MPbZDSgLDUWKMMiulWEAqx3ge/3XFanGG5UCZxj3p1lTmg4Um6chC/+mi1To9zUgA/YR3LyVUScRbJNZs8t58eUn7VZp37719m6sOImTTzognG9M64ld8K0aXHeDlXYyzkItNck5N+zJjQJkwaTE2lOM5CxhV2EfWcuPgK997gJbGQY3hsENhQm0JJROEuNC3/5wMB69koLOpv+KYEMTkefc2gclNzDM8xQfvdIUFB7VMhHr7WmrML2a3Gvuw8BtLFLy61QAPoin8QnF4S1RlOfjZsZsvxvRDmNILyGarxpP28hP2SerxFUDdqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XV1G0//k/JmvcM0XLsOTQG7haQj42sNBnztg9wszQU=;
 b=nY3bhh1t+KammZAHU17CCEgebUxZ7igwZ2VpO8aPRj2rLBQTBkVXh127Srn087P1GNsffEHHmJRdzwgphbOVY3BIlr1bXadZjXn1mzuxzQAoR8rrMTIPR/CXUxPuSQwnx0JZM0I4Jzy7ubI/bqWZVd6FI4lZiTwKScJEMY71Cv8mogpULXuXic1po1hMpN+yK5qRA5rc3TAm8nYw1g4hj5EJQaD2DLDIw/IWeCJ6lmo9rg/qk5G2IZv2OSxFKGrIGlESDMOhz7VYVbUxHEG0VGzju0sKslEUMUWgNtQfMOyvU+MNKX3fwMY1sfUWBXXjvqX0RRex2zx0kgnWHTwzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XV1G0//k/JmvcM0XLsOTQG7haQj42sNBnztg9wszQU=;
 b=3mD9oZX+mbmu5xO9ao2154jwjKcEhk9HsOZxvKtbNbeoq31A638GwrSlLZUfdpzsLRE5CkioEu2HaVg8j8ISi1xB5SpQXGEvkfZLWTvBxlJgsrdSJPFV46LEadyel5BABaHNuIR+73xCV6FR8hmYoI3nOoC9g1V8rS6ctN08/mEcXu4QjcEigierKKnVZ+5HKo9uWIil3E//UTtOLEFaTgCJGNsLQ3fvJneCeJVM6kpIT7QaM+l5SW7M82IAzHODEPhTuxTqHlyukUOH1ezzOR6Ru6Q+NWhr/rO6oQR7Ey4l7WDfVGu6AWNLgK+EeB5vuQy+2AhmpujBfE5qZEDm9w==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Sat, 31 Aug
 2024 07:47:35 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.7918.019; Sat, 31 Aug 2024
 07:47:34 +0000
From: <Dharma.B@microchip.com>
To: <krzk@kernel.org>
CC: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Aubin.Constans@microchip.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json
 schema
Thread-Topic: [PATCH v3 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json
 schema
Thread-Index: AQHa+uwtJ7/r8VHBykWcdm8SWG3Hw7JA5aoAgAAYkYA=
Date: Sat, 31 Aug 2024 07:47:34 +0000
Message-ID: <31493b09-06c2-445c-99c3-93fe9b69338d@microchip.com>
References: <20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com>
 <20240830-atmel-sdhci-v3-1-7c97a0872af4@microchip.com>
 <7cprvqjnmtkpehkok7lfv34t2i5vywt5fhp6q4qyfvmlivvcp5@xdsif4htcqxl>
In-Reply-To: <7cprvqjnmtkpehkok7lfv34t2i5vywt5fhp6q4qyfvmlivvcp5@xdsif4htcqxl>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|PH8PR11MB6999:EE_
x-ms-office365-filtering-correlation-id: d081106e-a63b-480d-306a-08dcc9912d5f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVBKc2FmL2gzQkZON3gwWkdRV2dkWmM1UFgxUXdJZ2VGNUFsNW52RUpEYmI1?=
 =?utf-8?B?cHFmMHdqOFhkRUdPRWxLTjgrMndjbDgxWkJmZXdCL3VoMTQ1bXBUb2RkMEFh?=
 =?utf-8?B?UVBXWEJEcVJIN3k4Rlo0YjJNUUNnQXVVQUh5RlVhUzN2UDhMcVMxSEtkS3JJ?=
 =?utf-8?B?Q0JGQkZ3ZEFyUkVxdCtQSkxPekgyTjBxTnA3OXFBSFpDUFB4VVdldG9HM3J5?=
 =?utf-8?B?WEE4R2gvNWNEWHRLS25JNzI1ajd5SlNkQjk0a3lRWVhYbUc1eW5hV0I5OTZk?=
 =?utf-8?B?MkdaL0N3N0FuTXBtQzErd2F2OTRXUGRiRmlCNFlUMnlTejFHZHcwY2JMYWpN?=
 =?utf-8?B?VkZsMEg3Z0RGcVZCU1YyVFVCRmRaRU1qcy9qM29kdkxOTmQ1Y0hsK1VxeW9h?=
 =?utf-8?B?VEtjOEdTMlVISkRYVEsyczNjeE41RlF6U2pBWDlpa1IrUlZrWlFWUzFTZ1Rt?=
 =?utf-8?B?WThlaE1lRDVFakMzU2JBK1RXb3V0TFNtU05tN1c0WTlvaEFXd1NGS0FnbzBW?=
 =?utf-8?B?YjFyMXI0L08rVU1PNVNaZ2pRQkZOeE5tcGw1MStJeE1CNHhaYmE2U0ZkTFJI?=
 =?utf-8?B?TjlXZTcvdDBCcUhsUEpoeHBLWEJjejdjMFJFN2dlYWNUNWJFQUZxSDEwUVdv?=
 =?utf-8?B?MlhLdlp3SkN5QlNOcEgvc0RZbzZ4NGR4MGl1WSs2dUgwL2lvb3hqWkluSTFU?=
 =?utf-8?B?SkF2eVNoVW5Kb0xtWTdXSmVWeVp0ODY4dzJPUWs2b2UzNWhOcEhJYzRZZ0dy?=
 =?utf-8?B?VzJ4Z2FUR1MvWk5aTkRWTDM1TU9RSUZKMDEzS0cwd0ZUeVNYVVpIYjFNYUhm?=
 =?utf-8?B?VndSS2J0amJIaS9zRENDV0lsMG1UcWxIZjY1MDVBb3hUVk01a01XOCtVSDAy?=
 =?utf-8?B?OHRtdlNwQnFhY2FLRzg1SVo0QW5WcE1vR05mT01WaFd1dThjKy9rQ1pUUTBS?=
 =?utf-8?B?Q3cyTy80Z2J0bkpwZXlxNWJTZi95aUY2VlczRDZBdUh6RzZpVVJYYVRJaEd6?=
 =?utf-8?B?NEZhYmxkVUZSd0I5YUNkK01ndUEyT0ZaYmNkZXQ3dG81U25MeVFNemN1REgz?=
 =?utf-8?B?RFdQYXRvTjFWTjBkczhwMWt4eTNMcElESzI3OEl1SEdpMDV5aWR4RE5kK2VL?=
 =?utf-8?B?eUU0cG5OWFdUZmttUi8yemRSejRwZmM0Q000ZnVjZjl0RDZUaVJ0eXlUTDc0?=
 =?utf-8?B?R1B6Y1Vqd29QOUE0QnIxOFNrNEljNjlkbnlLZXBZblJhL09DSWNHUm9Ec2Ny?=
 =?utf-8?B?bnNQbFRLZ3NZQ21TOWN0RXZaSTlPbmhVaktGM2UwTHFYdFNNeC9XZjhXN2ph?=
 =?utf-8?B?YncrL1g5dWwrTTNpN0ZEK3ZyYlNLQ01yaDQ1RFRGbUE5b2tlck0wdnl4NVly?=
 =?utf-8?B?UjFuSmd2ZjdVL25yQk9XWklqdFBYaEkyd09qa1hJbU9pL3dsSjRJakpEOWZX?=
 =?utf-8?B?aFBUc2pBejdRZG5KWmMrMko1YTM5Y2prZ1BaNjI1L0lwY3hENjh5b0FieEND?=
 =?utf-8?B?WStraUpjWS9BdmVuOTEyZ1FJSnJZN0lrbXMzM05WckU1Znc1OXFlWGZWK3Jy?=
 =?utf-8?B?ZEkrM0ZpUlA0dFBTSVFXaUFjQ29UNlI1OXZPMzRyQS80djBXU1pISzN0UzFt?=
 =?utf-8?B?cjFFcGNWQ3BtSEc1amNKOTNSTlprOWc3WFJDVHA3MUI5NmRjT2ZFWmZIN3Jv?=
 =?utf-8?B?dEpMYmEybGxhazBRSW1lM3AzQm5URVpHQ25wYmpvNyszUHhwaWphWHhyaWp2?=
 =?utf-8?B?Z3pXZHFDU3pvMVJjZGJyejAyOFFHUVhBTnQ3QmU4dWp2WjUrbEVRNHR5cTQ4?=
 =?utf-8?Q?FdkGnpriuixV/6YqyyxTExWllQ2XslCMqg4/M=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NStzMVRDdWRQV1Z4MHBvYjZnb2R3ZEk3Q0pxODY1bzVGaTlvOVg5V0JUQlM3?=
 =?utf-8?B?bG9oUk1jcHRMQmxKSTNRQWpZMWw1QjVEUk9zQnYvN2d6aHQzNnVZNDJCWVR1?=
 =?utf-8?B?YWUvSUVUK0M0TVlyUnk4bE1ENktMclJQcFlGNE5sRE40U3lvV2V4OFByOUh1?=
 =?utf-8?B?VWJSNldKRklwVSs3Sm5aelYrT0ZGU0JPMHR6RzM3RW9XMTN6MlRNTm9NdHFj?=
 =?utf-8?B?NUs3QmdSR3g1VEEyYkdRYlhPcnprV3oxOENMSThhL05PcDd0QTVoaTRVYVl4?=
 =?utf-8?B?Tm9SZkNxZGFobU5sZS9kU25nTjViQ2FOYXNvU1JNSXFIbVA4eGQxVEJxNU12?=
 =?utf-8?B?N1pWV2RLb0hzNmJrNXorTjJVNWhxTGxhMVAzeFZKVStockh6V0dDR2ZGMTJS?=
 =?utf-8?B?Vnk2dnhrOTYyOU5UWGxnVERwbG5lWE52UnE4WjJ2TzdoOTh0Q0ZvVE5hWUE0?=
 =?utf-8?B?N3Z5TmtUR1hoMUVhaWpGb1czeExPSCtIcUFmdWpFNEhqMHdnTzFpRWZuMVUr?=
 =?utf-8?B?YlMyTmFWWndRdWFhbFVRV2M0NjZDUzhzNWJ3SEN5VFlIZDk0NkwybmtseTFP?=
 =?utf-8?B?aDBzY0VPenhLcDBrbHJYYUZKNlI0ZlVEbWh3VVh6WmlKM2JFRGYycG9aNTla?=
 =?utf-8?B?c3Z0d1UwZXVnTFk0NUUyejhWMk94cHBFQUxHOHlqMWdxTHdacldVREhrdnBw?=
 =?utf-8?B?VUxrclhOUzdLcjlvZlFkdGkzeS9hOWFVR1plS255K25SZkxKanE5aExodXZ0?=
 =?utf-8?B?VG50QS9GbjZUTTJkM1BYY1ZOUUZNWnVGQnFFdm5WRy84eTlrUmxzQnZ2STNa?=
 =?utf-8?B?NDVTNHpRZ0VEamNLSFBTMk9yV3l0eDdFT0pJQnIrT1hXeVFBYncyK2diRlpi?=
 =?utf-8?B?WWlHY2RaU1VvZGhIWnJzMUNtNkJoZERlNVFvY0Y2Vi8rMU5kZ25id1dGdnda?=
 =?utf-8?B?K3NicnhzSHJyZnpRVk9Yc0h3QzhoU3VnWTErSTEvbXRPYVlidFR3dm51U2JX?=
 =?utf-8?B?S2FpZ2V5ZTFGbVo2YVAwak9IL25YZHZhSXBFMXN0R1lPSXJQWGFzWFFwdC83?=
 =?utf-8?B?SUR4eXJWOG5Wb1ZsU2JiWlpSdUthK2hrbjFBT2VFV1Iza1JhZWZRbDNhYytF?=
 =?utf-8?B?UHJMMitWT0t6Z3R2M2t5TUx6V3FDdHJlRXRpYWZsVjVBamgwNXBSWTkzMVJh?=
 =?utf-8?B?S3pCMTRwOU5ENEpiMGVDWHhwWjNPYXZUQitidnI4ZjI0VEVwVDNMWFNCRng0?=
 =?utf-8?B?M2NaYVVIL2U5NFBNU3hROU84aGFpZ0RUWU9GQjNXZkNYaEJvR3hHYWRrb0tp?=
 =?utf-8?B?eFhBbEM1c2NGeTVFQlNreFdab3V6WHhwbTU0WnN6Z0FSRlNmZFB1cFlOZEZO?=
 =?utf-8?B?RHIyRlJ5RDk5RzhSSkY1dDQ2S3d2d2IrQlorOGg0NjF6TUorejFncFBrTmg5?=
 =?utf-8?B?VkwwU2ZjcmFxblZVVFIrZXF4blM0WkFMbzB4T2k4aEJncXdqTjU5WmQ2R1Vn?=
 =?utf-8?B?Z2xVSkpic2t2aHBzejczQUNYOE15MmZZNi80UDgrOGpOZ1drbHlJQ210NXly?=
 =?utf-8?B?dENwaWFYNTNaNDAxSVd3RnBtNUhKbmN6N0tab2FKbHFmNmxFcU94N1VvVmI2?=
 =?utf-8?B?ZXRscm5aRFZKWFJ1bWxtMVJ2a25hdEhxM3Vqd0VpVjdHU3F6OFdBeHFCaUtl?=
 =?utf-8?B?Z0Z2MjN3MDhZUmtMY3M3ZjdvUU9URTRRUXpyWXV5c2dSRTNvNzFjekpyQ2t4?=
 =?utf-8?B?U21GYk5uL3dVZ2VmajZuZXg1MWl0NHlyWDYwdldkWC9QZHRpbm9XTTVlWVZH?=
 =?utf-8?B?cE1XR3kwcVA3T3dlYkxXcFJyK1JTc3Q3R2ZEejFsWmNoK0h2cTZweTJCTEN2?=
 =?utf-8?B?eDJSOTArOHl2YzFldGp5aUl6bFhYanFwbUxxbUV5V2hpVTZhaFVRcTdLU281?=
 =?utf-8?B?ekt0TExIenFKMXQyNlhmeCs1SXU3aE9TYTVOdGpvdVphbnB0eVVyWGg3YnFD?=
 =?utf-8?B?MTVNazZvSGgxK1hBbUluSkpJWGIzajZBOTlucXNwOUhJWFllbzM3V3RmQmtK?=
 =?utf-8?B?emRvR0ZDVnB1UzlHSjhCckFlaktHdnlheE9SMHM3bXVaSCtPUEZsOXIwRTJ1?=
 =?utf-8?Q?kwoX6vbLc/sG0sQluuqX1iOC0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A79297DF913E8649ABB9CD465E95C0A9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d081106e-a63b-480d-306a-08dcc9912d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2024 07:47:34.7903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QApNicmry69f6pQvZEUTKXC6mt9NlGna/AvR/QAR2+UAuIvtCw5mQW7pfdyDBC29m/lePppqZnK8J9CZfqziyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999

SGkgS3J6eXN6dG9mLA0KDQpPbiAzMS8wOC8yNCAxMTo0OSBhbSwgS3J6eXN6dG9mIEtvemxvd3Nr
aSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBG
cmksIEF1ZyAzMCwgMjAyNCBhdCAwODoyMToyMFBNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1h
bmkgd3JvdGU6DQo+PiBDb252ZXJ0IHNkaGNpLWF0bWVsIGRvY3VtZW50YXRpb24gdG8geWFtbCBm
b3JtYXQuIFRoZSBuZXcgZmlsZSB3aWxsIGluaGVyaXQNCj4+IGZyb20gc2RoY2ktY29tbW9uLnlh
bWwuDQo+Pg0KPj4gTm90ZTogQWRkIG1pY3JvY2hpcCxzYW1hN2c1LXNkaGNpIHRvIGNvbXBhdGli
bGUgbGlzdCBhcyB3ZSBhbHJlYWR5IHVzZSBpdA0KPj4gaW4gdGhlIERULg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IERoYXJtYSBCYWxhc3ViaXJhbWFuaSA8ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4N
Cj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3MvbW1jL2F0bWVsLHNhbWE1ZDItc2RoY2kueWFtbCAg
ICAgICAgICB8IDkwICsrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgLi4uL2RldmljZXRyZWUv
YmluZGluZ3MvbW1jL3NkaGNpLWF0bWVsLnR4dCAgICAgICAgfCAzNSAtLS0tLS0tLS0NCj4+ICAg
MiBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hdG1l
bCxzYW1hNWQyLXNkaGNpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bW1jL2F0bWVsLHNhbWE1ZDItc2RoY2kueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+
IGluZGV4IDAwMDAwMDAwMDAwMC4uYmE0Nzg2MzI4ODMzDQo+PiAtLS0gL2Rldi9udWxsDQo+PiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2F0bWVsLHNhbWE1ZDIt
c2RoY2kueWFtbA0KPj4gQEAgLTAsMCArMSw5MCBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyVZQU1MIDEuMg0KPj4g
Ky0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbW1jL2F0bWVsLHNh
bWE1ZDItc2RoY2kueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogQXRtZWwgU0RIQ0kgY29udHJv
bGxlcg0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBBdWJpbiBDb25zdGFucyA8YXVi
aW4uY29uc3RhbnNAbWljcm9jaGlwLmNvbT4NCj4+ICsgIC0gTmljb2xhcyBGZXJyZSA8bmljb2xh
cy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOg0KPj4gKyAgQmlu
ZGluZ3MgZm9yIHRoZSBTREhDSSBjb250cm9sbGVyIGZvdW5kIGluIEF0bWVsL01pY3JvY2hpcCBT
b0NzLg0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBv
bmVPZjoNCj4+ICsgICAgICAtIGVudW06DQo+PiArICAgICAgICAgIC0gYXRtZWwsc2FtYTVkMi1z
ZGhjaQ0KPj4gKyAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDMtc2RoY2kNCj4gDQo+IFRoaXMgd2Fz
bid0IGluIHRoZSBvbGQgYmluZGluZy4NCj4gDQo+PiArICAgICAgICAgIC0gYXRtZWwsc2FtYTVk
NC1zZGhjaQ0KPiANCj4gTmVpdGhlciB0aGlzLg0KDQpNeSBiYWQsIEkgYWNjaWRlbnRhbGx5IGFk
ZGVkIHRob3NlIGNvbXBhdGlibGVzIHRoYXQgYXJlIG5vdCBwcmVzZW50IGluIA0KdGhlIG9sZCBi
aW5kaW5nIG9yIHRoZSBEVFMgZmlsZXMuDQoNCj4gDQo+PiArICAgICAgICAgIC0gbWljcm9jaGlw
LHNhbTl4NjAtc2RoY2kNCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGVudW06
DQo+PiArICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW1hN2c1LXNkaGNpDQo+PiArICAgICAg
ICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxzYW05eDYwLXNkaGNpDQo+IA0KPiBXaGF0IGhhcHBlbmVk
IHdpdGggbWljcm9jaGlwLHNhbTl4Ny1zZGhjaSBjb21wYXRpYmxlIGZyb20gdGhlIG9sZCBiaW5k
aW5nPw0KPiANCj4gQW5kIG5vbmUgb2YgYWJvdmUgY2hhbmdlcyBhcmUgZXhwbGFpbmVkIGluIGNv
bW1pdCBtc2cuDQoNClNpbmNlIHRoZXJlIGFyZSBubyB1c2VycyBvZiBtaWNyb2NoaXAsc2FtOXg3
LXNkaGNpIGNvbXBhdGlibGUgZnJvbSB0aGUgDQpvbGQgYmluZGluZyBJIG1pc3NlZCBhZGRpbmcg
aXQgZHVyaW5nIHRoZSBjb252ZXJzaW9uLg0KDQpJJ2xsIGNvcnJlY3QgdGhlc2UgaXNzdWVzIGFu
ZCBtYWtlIHRoZSBuZWNlc3NhcnkgYWRqdXN0bWVudHMgKHJlbW92ZSB0aGUgDQoiYXRtZWwsc2Ft
YTVkMy1zZGhjaSIgYW5kICJhdG1lbCxzYW1hNWQ0LXNkaGNpIiBjb21wYXRpYmxlcyBhbmQgYWRk
IGJhY2sgDQp0aGUgIm1pY3JvY2hpcCxzYW05eDctc2RoY2kiIGNvbXBhdGlibGUpIGluIHRoZSBu
ZXh0IHJldmlzaW9uIG9mIHRoaXMgDQpwYXRjaCBzZXJpZXMuDQoNClRoYW5rcy4NCg0KPiANCj4g
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCj4gDQoNCg0KLS0gDQpXaXRo
IEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0K
