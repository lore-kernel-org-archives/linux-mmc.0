Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36D15CD4A
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756356; cv=fail; b=l4FlFN6WvcrzrWdNOXI9Iwdwk88E6PGH34D2+tpCSdXyWFnLbLcff3B1K3Dgy6hNwN/OX60+RzpOABgnnDePtc2xnBZ59RHP14rWGjfgAGb+mLTf6rY5UyC6rzpQYQtlYRbU5fYtI2FpKsgy6rS/xtQlwIgg0zMi9mmVHlLdQic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756356; c=relaxed/simple;
	bh=WNj8aKaM7Thd1ANtGEGxQAgTe01rx4i/KPLfzTp59Vs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B7qezxQ2cDbL0ska/sOJkLlIfQFR1AFmremimsFypPAooTpCjbVUNFcLzgvoIYRT1hvlOmRIEsYmw5MQ/DJg2t5gt2Pe6gQnAQfQz0wOSyDZurN49wD+xyCkiQIlTomLkZ+tO5kX7awch3K74LXgRGEHy5Ab0mX+r1OBJ+G22V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=C+Yyl1+u; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=b5XCjBrA; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C+Yyl1+u";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b5XCjBrA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724756354; x=1756292354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WNj8aKaM7Thd1ANtGEGxQAgTe01rx4i/KPLfzTp59Vs=;
  b=C+Yyl1+uSAWMiWiN69JFMkguJC2tQiZyRM+1rjYEBWvXVhvgsa6IsOz7
   SiKt1BEzbW9WjGA6divX81uRRHvImaUtoqJ6g48rPCGWMiepD/Hams63N
   WAiSCIHwuEOGp8sFI6G8/Dh6zPDMu8XCJsyP7naDCvn+jIYHywNRoJhPl
   azQ7HzcW1JsHiE1fbSWU30Ye2R2tjSDM5hyP0u4FuNTfeJlfTVc+jHTKX
   xj10SxBaU4vI6fxiF0Y2J88RQQOM7963dVmIAbCvNFUHUKScQvjBP73aY
   qMRT+qCDgwxmhJi495WUPH9qMvDlzXBUP6rH07zzkxumRZOZ+s4gC5+N6
   g==;
X-CSE-ConnectionGUID: /6X3fPYgQ86B+I4pgeaeXw==
X-CSE-MsgGUID: BzZl3rYCQMuuDCQ4cPUPww==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="24655730"
Received: from mail-centralusazlp17010002.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.2])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 18:58:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJEU9RtenRWGGe8OAYV1+RZc+blGDyI2SRdJwd0da5CVK00FYhRVQaJveNyoj8Ci+uvW6+qPnrycBaDrlnk7gSBeMFxOr1cj6AqawFqjQGqFY1uqmoTeH0/48+VFpATK8JHVsUSJn+OxFLMNl6eEeaN0fcC5kY2664Cly2hqSBcgWZscjeoJomiZOm5z1SOHuUp8B250V8vGzZW/OQYd6vbWbdraIevx/5XwLXN7cV3HDuN09DciK8rdCT2mHEgHfgZx1zam6OiZj+cTiac8FWrOIQ8/jE7R/OTWaTDdZNnR2NTCErLCNAMaJ0XmEONp4hAHS+di9OyWNVrEC7jH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNj8aKaM7Thd1ANtGEGxQAgTe01rx4i/KPLfzTp59Vs=;
 b=a7kQc9yhTG2JuR0bGiJ8YVIk2x+xbZlLR4W7YVxxVIIorPciYLo5Dq1gorJ7cKg2htJ6RmUuF6JWWCX8I8F2Ua1XlXjjuYrDa6WjLFkx2YQPEcjaKTFA5bcyRjCjhdKyrCbKLE81lEH926I7r7k4vGLPjGC8lF48zj6VvmMdDdGtJeoHXbt0LEgVz8fqUU8cJi6NdsRKBqZfjjXNadvUlc5Wm5ioYH+BjeaSlH849B2GtOQYkbGHdDlPsJTTctZcPqKe5p5yHsy0Wlj2Q7PW46tPN3ZMaApGA3ZVlejbH1VN/gBkXcuKcpBq/1xOneH+dAfqIOh5PWo4AhRnT4M2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNj8aKaM7Thd1ANtGEGxQAgTe01rx4i/KPLfzTp59Vs=;
 b=b5XCjBrApvj804cEBn6QhfDoTez6b+jnFL2sBY4ck0CwjzRy0bP8XBLMahXs1xZn+3z/1/PeR385MxlFpuy1xUIFqwNDnvb3+/nnc8UsnaL0gjF2BNhbm+b/VyZMB4oRIWGeY3vG+aJsmH18ptT7gqTpZYMFcqe627z1oxN/3S4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA6PR04MB9213.namprd04.prod.outlook.com (2603:10b6:806:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 10:58:03 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 10:58:03 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, Adrian Hunter <adrian.hunter@intel.com>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v4 0/9] Add SDUC Support
Thread-Topic: [PATCH v4 0/9] Add SDUC Support
Thread-Index:
 AQHa9sJ1Fgtj888U6kGa1b/dDuzVu7I5GbsAgAADPMCAAZo3oIAACNUAgAAL2xCAACT3IA==
Date: Tue, 27 Aug 2024 10:58:03 +0000
Message-ID:
 <DM6PR04MB65752FFC3CB355F2FC704C16FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <3d7a9953-afed-4b45-a209-b797634e6bd8@intel.com>
 <DM6PR04MB65756CEE03C15524EF646C3BFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB65751048E9B35CFED478F180FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
 <cb9c225c-b5c2-43ba-a6d5-843dc2790fd4@intel.com>
 <DM6PR04MB657568FC857DA6877F2BA7FFFC942@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB657568FC857DA6877F2BA7FFFC942@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA6PR04MB9213:EE_
x-ms-office365-filtering-correlation-id: 5b970bab-1695-44d4-eea4-08dcc6871fde
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MG1IOGxkUGZhZ0lZb3Q0SkpZdURqTGJ3RGcwQ0dWSVNzUEMxeFAyWGk0N1Er?=
 =?utf-8?B?MWsweHppNUJtUWMxUlp5WjNVMm14WjNoQ25yQS95WlhmYXVlUDJPV0pjZ0hV?=
 =?utf-8?B?VXpVUkkwOGZLUkFVSkU2Y0tScVNXcU5oTGxNUkFMWmt0NHpjdEx2WGhDWnJn?=
 =?utf-8?B?N3MrdDBZQStoUTdCYXZLK2NqaFJGelRQeGlGbk9jZ0FRNFFRNEVod2JiSDgr?=
 =?utf-8?B?TjhkeVZsSmtvcmZkNzh4OVVJVW81aWtZMGtiM0xMNTdIRWJReU01SlJsUkN6?=
 =?utf-8?B?VTZYOURsNm5yaWt5MitmTkZObk16Ly9mdGZFMU5ySFI2ZjBqTTVCUE51VHEy?=
 =?utf-8?B?cnlRMlV6akJmYVZVUnc5NEZKZmdLL3BiY2lBTk1kcWNSNFp4VE5pMnNCTGFn?=
 =?utf-8?B?cTBvZ05CVkxMUXZvVGx2ZUpuVmUrOXoxUGpJMHdsenFML1Z3UnF5Q0JLUzRG?=
 =?utf-8?B?TG9Nd2ljVTg3SmMvTHduNmVMR2g4NkRjYmhUc1RXckJkQkF2VmxoUnRXM2xn?=
 =?utf-8?B?YnBpTGp3YVN0YXExTGFiVlpMdUlzcE1DQTlRZ0ZyOFlUR3NncVoxbWltWG56?=
 =?utf-8?B?MGk1YSt4RkpNUjJndmxQOE53Q1lxT0RYQzIxK25tbmNlRmlUb3V1eWFsT2M4?=
 =?utf-8?B?ekd2RUxLQ1hGeEFOdHhJTGNZTGhYZk01Sll0cUFwSlNMalpoaFYwR1VtYlN5?=
 =?utf-8?B?eCtVeHVhalQ3dDdtc1FiVENGTE45MnVKN0haN0RHSWhRUEYyajBGaFQwamhr?=
 =?utf-8?B?dXpzMTVzSUZoRnMrdEZnZW9SMStwQlhESDdJbVdiUUhiODIzVXExVitYb3VK?=
 =?utf-8?B?ZGpDOXdBV0ZvUndZR3UzV2hNQVJDcHVMZWx0TjlKVDZDTjYvS0NIY2QvTnpm?=
 =?utf-8?B?S1VuZ1d0Wm1wbUxxUlV6YlRia2VGY3NQMWlqWjZOUHJzdDA4cXJvYmVUMFJy?=
 =?utf-8?B?L0xXZzh0Y3laa1VpaXhBMytkT1NuQWJzTzlvaFloRm5Za0hobGs5cUFNSk5a?=
 =?utf-8?B?bWpOdzVDRU91WmJJQWY5UUNjQnZqa2k5UEl0V3M1SHhLTTR5cTlzR1B3UlZD?=
 =?utf-8?B?UWpKZlR1L1lsSnYrMW9UUEJZNHlpSXVZK1FvYWZISEZnMnd1SzNXbWJZN0dY?=
 =?utf-8?B?S1F5cVVaTWJoVWJSdFl6MlBvL2kxUVlLdmhlWjd3WmhBd1RHU1B1eW5RZllU?=
 =?utf-8?B?cXpSQnZleTIzM05kQVZaQU1Kay81UDFKOU1PN24reHdDeEhDV2hoQlF5RFBu?=
 =?utf-8?B?UWhJWFpyTzU1TXJwbTdKaGxscTYyYjJoZCtObzJ5VlBvWlRtZGhxa1lDR3kv?=
 =?utf-8?B?d2lKUTd2Y0haMlNZMDhKQ3dIZnRLNCtkTUFBWURPTEdHSmFvdU5FcmpYRTN3?=
 =?utf-8?B?YmozMmJHTjFramxaL002eDFRZk5PTnBiUXg0OHpRZzB0cTMwRFNPZTJORDQ5?=
 =?utf-8?B?S3ZHeVhwSEs1NkVuTDVBZ3J5L2o3MEczOSsrMmdkK0FYMDhUQWRZL2FiMU1W?=
 =?utf-8?B?cmFQeUhaK2dZNzBkOEVJK1o1RlJCZ2VtL1YvWkFFdTNCdGhJV24yN2JnZWl1?=
 =?utf-8?B?Wm9idHE0aWZweU5sYzBKb2lRZzhDTUZ1M05Ob0tXaGNuVnF4cGVtRmtSYU1S?=
 =?utf-8?B?TnhXRTVFS1JVNnhteGg2cFYySytOdENzWjZQM0Z5TWpYdFAzZjVVZ29YWndL?=
 =?utf-8?B?citPdmVhTFRUSlBCa2hzUm1KanBiNVh5R3FySmFvc0VtUENIWlpocUVvTmIy?=
 =?utf-8?B?enZiZDZqa0diNjdxMXZKdlBTQitSUFlwbTU4MUVHMUwvbzdLbFl5ZG44TWFu?=
 =?utf-8?Q?Ngm4taO8pK2/R4a67QJbO0ryCk146eA7FwhFM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDlWU2N0ZldmeXVsNDNVb0ozaExkNHdCUlFpNEh1ZlNXYTR3NzhHcThBbGNC?=
 =?utf-8?B?TXN5YnhENzloS1NHSU5meVdpaTc4L1RQeFZDSVJ1MEZxdE1XZjdzNlZTelZm?=
 =?utf-8?B?QUVCTmtpa0lGVlVBdFlrUnZxV0Zkd2xueEtVMnowSVRFaFVkUTR3SHpIS0JU?=
 =?utf-8?B?YTZ6MkFEa1hRUDRaTlhkdGx5cHhOaHRhZGlZMGk5c0oxZ01LTThHK0J0RUFr?=
 =?utf-8?B?Y2RQeFhzQ3RvKzhicnhySmoydU5hRmRxN0FremhCNGk5bEwrSkpCZnpsV3dO?=
 =?utf-8?B?aENURU1sTDJjOHhCRDl2OU9qTGZySnRGNUI4TGxWd2dNTHBCTEpISE9RcFpB?=
 =?utf-8?B?Ky9nT3d0SGZEZWI0aFFlVWhnWmhydzV1Nm85LzExQ09mYVhaeDYzYSsxK2Zn?=
 =?utf-8?B?eWcrVUxYMHB3M1lxZzFWT1czMVlBK2xKcmo2ZVFYWEVJV243anEzMUdra0ZD?=
 =?utf-8?B?QW1GS2xZd0VmVUl5aUpwdHM1VjY3bWhMYU9waE5NK2FEUUdISEx3amh0ZEow?=
 =?utf-8?B?b01BTHdsY3lsYkhWQldmelJudGFYTUExMUREblorRWxoK0NoOTlkdXJyd2lz?=
 =?utf-8?B?cEJXWUNYTklrakhTRFA4MDV6N3FsRkJnUnpDVHZiOFlzSUlIYzZxczNERjZa?=
 =?utf-8?B?SzZUTS9rM0VBYU1qUGdFT3NyK0pWMW5XZ1ZZeFdCUzUxOGNGOW81VXN1MlBi?=
 =?utf-8?B?WDRJOWNBT0Erbzc1SE5jRHAzMmZzQ1RWZnJaUGtQZksxRVBqUjVQTVFVTGl2?=
 =?utf-8?B?d2dBdVNrSCszRkhlaUFRaHpwbFN3Lyt2QVVQRFY2U3NXby9EVVNpLzFqZU9L?=
 =?utf-8?B?WlhsUW1KRENOcENtVDJkVzR3dWd3dFg1SkVrYXYrRHRCWEFnZFFuaGJaU2Nw?=
 =?utf-8?B?Qlg2WXhjWjJJdVJoZTJuT2dPOTlyTnlzeDFJV1ovL0hGbHpTN3ZCWTNOQ1J1?=
 =?utf-8?B?TUIxSXhON21TNlNZbFZoeVFTNXRqRnlqUW1JajUwcG9PM2p3U3VqWlFmR0N5?=
 =?utf-8?B?N3RJdkxBM0dGZ2JRR2N4RFpFOHUvbGVMTDdqQVR0L3JmSXpoSE84RFRTeFhs?=
 =?utf-8?B?clZ5eURPRmFBSlNneWltZXBMOGFpQWRjbG9rS2hXckxnN1J3Q2Vmck5TWEhm?=
 =?utf-8?B?QWZPQk00eVVnUkxGN1k1ekFCYkpmSy82amt3Yy84RFlRbkZyMVlicmVUVUJX?=
 =?utf-8?B?aGVVN0MyZUp3YnNaY0hOR1E3NEdzdzY3NEhmbzczVDNJMmNZWGpBVSsvUE1R?=
 =?utf-8?B?eDdsaWovUjNZOHliUWxEd2R6Z3dKaVZuU3MxTG1abXRHdjZqSFZieUlmMWdB?=
 =?utf-8?B?WFdYYi9aQmg1cmg1UXdtOEhFQTZkL0U0NzF4WnFNZlZHS1M4YnlrVmhUcjB6?=
 =?utf-8?B?SmV6NThlRFlaOW9QWFkyQ3NlTi95ZjROSW1TNDZac2dyeUp5OWc3SEVVdTFI?=
 =?utf-8?B?NWhIaWh2emE3dnF3RExCeCtmUDB4ZThQUURGRCtURTUweUZDaU1iLzJKSVV1?=
 =?utf-8?B?MkZVYUxiNG5XQiswNk9rS0MvUjNXR2RqZDZqUmVsR25uMTFkSVVDdTBibDBu?=
 =?utf-8?B?YmF1ZGYwN1J4OHVwOGEzTHd5QnA5VlpDdFN5Y2EyN0F6ZW4zTXNERkk4T3hk?=
 =?utf-8?B?Z2FndVZseDc0YlMvcTNzK1pHd3hIYTM0UmRma21RZW5pOEdJTFA1Z0ZJOHY2?=
 =?utf-8?B?blBteXU5OGVXUWt1TFRHWFBISlFPV3cvQms1QVorT3lneWh3S1pMVkhBUEU5?=
 =?utf-8?B?aEZkNzlFdTFBa2JqcTQ1cnA2cFZlRTFLODhNc3ZnUkZhazFMM3BKbDFsSlpu?=
 =?utf-8?B?dkhvaEhCTTMrcmVWQUg2SUtnRU1kZUtYSVFVdTNxUE03ZDZ6NU1uTXhTZUhH?=
 =?utf-8?B?YTNiMkc0L1YvV3pWc0Jaa1pSbHJMbmM4NGpyU0o5UVptRk13VHRNTEJySnlK?=
 =?utf-8?B?WVgvRGtxbGV0V1BRQy90bTQ2SkdDbWZ2V09kcy9MK1lJT2t1Zk9IZmdtWlpo?=
 =?utf-8?B?MTVXV09PV1dUTkhtMUhiZ3NNaGdZRlNQdnBiVXhLMnB4Rzg0VnVlbGtzYlh2?=
 =?utf-8?B?dnJTWmErNWo4a01lVWtjSDJldDFwb0diV0lmanI0MUExTlZrTDJrdEdkblMv?=
 =?utf-8?Q?T4ddF56WM/CRWEb4WeEWN8GPf?=
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
	OEFgaPHQuxkUYDmznPJiHyWoAcUadGoGAm2TcJqNeo8g6eg5ponYu5W2+iCxpDPlk0WB7Y3nDA/YO2Z/KGczyT++IfTs/6YQVo/YqZJwrpxmHZyWOxMw+60DIaz5R+tO7EJAbH7oRB+dE3HxubEQlypk4iEwJXdnx+amLEChoL77PbLbn5RSrgzfn2GS/CLhpap1ekx7vZtiTaQG4JjvUyw3DsbDd7IcJNFzDoxVfUMCmyZQfgz6zJ6lmcy1GRHucWMhkh9BmQD/Ebwlk0yYS5KIa4ncQNHvQb0XK+6tK96AyfzLE+JFfOJDJgFaIAO5dr6pYPuIZ5jQ0FOlwyUjNlOEmDGrgrBRaBMijC/Wph0hWKFqtpSQy8n09AVcxG6DMtkZ20XckJ37WQyBC9dZHRb2GVE6cgSiS3sZogNabWMHJqzy+AURMOYzlNRENW9zR7Gex3NSMAd44XxMf9lfoJh0ZKLbiAvkGfKlCfKfk0ovXPNpMeZBOCHkwdQf3YXmFKcE5IMkhPfYSIPThiQSQ/unBUC8cx19DbDzpIrofjNaJhNvJ5NaZ+N2x2UhEqy7VtL5xuIb0KGJ7Wz6gGY+x6fGEMbncfn2zIFTTuk7q7PtwoVr4OpRZzfcrbSBW7DG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b970bab-1695-44d4-eea4-08dcc6871fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 10:58:03.7133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEcek6tv1o/HxvDkw7wZYj6xphAkVRb9e4sLF0eskFYw+1iRagiSaT/UEHAP679F02G2ytOiTbu0BAvWQhtqbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9213

PiA+IE9uIDI3LzA4LzI0IDEwOjQ1LCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiA+Pj4gT24gMjUv
MDgvMjQgMTA6NDEsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+ID4+Pj4gVWx0cmEgQ2FwYWNpdHkg
U0QgY2FyZHMgKFNEVUMpIHdhcyBhbHJlYWR5IGludHJvZHVjZWQgaW4gU0Q3LjAuDQo+ID4gPj4+
PiBUaG9zZSBjYXJkcyBzdXBwb3J0IGNhcGFjaXR5IGxhcmdlciB0aGFuIDJUQiBhbmQgdXAgdG8g
aW5jbHVkaW5nIDEyOFRCLg0KPiA+ID4+Pj4gVGh1cywgdGhlIGFkZHJlc3MgcmFuZ2Ugb2YgdGhl
IGNhcmQgZXhwYW5kcyBiZXlvbmQgdGhlIDMyLWJpdA0KPiA+ID4+Pj4gY29tbWFuZCBhcmd1bWVu
dC4gVG8gdGhhdCBlbmQsIGEgbmV3IGNvbW1hbmQgLSBDTUQyMiBpcyBkZWZpbmVkLA0KPiA+ID4+
Pj4gdG8gY2FycnkgdGhlIGV4dHJhIDYtYml0IHVwcGVyIHBhcnQgb2YgdGhlIDM4LWJpdCBibG9j
ayBhZGRyZXNzDQo+ID4gPj4+PiB0aGF0IGVuYWJsZSBhY2Nlc3MgdG8gMTI4VEIgbWVtb3J5IHNw
YWNlLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFNEVUMgY2FwYWNpdHkgaXMgYWdub3N0aWMgdG8gdGhl
IGludGVyZmFjZSBtb2RlOiBVSFMtSSBhbmQgVUhTLUlJDQo+ID4gPj4+PiDigJMgU2FtZSBhcyBT
RFhDLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFRoZSBzcGVjIGRlZmluZXMgc2V2ZXJhbCBleHRlbnNp
b25zL21vZGlmaWNhdGlvbnMgdG8gdGhlIGN1cnJlbnQNCj4gPiA+Pj4+IFNEWEMgY2FyZHMsIHdo
aWNoIHdlIGFkZHJlc3MgaW4gcGF0Y2hlcyAxIC0gMTAuICBPdGhlcndpc2UNCj4gPiA+Pj4+IHJl
cXVpcmVtZW50cyBhcmUgb3V0LW9mLXNjb3BlIG9mIHRoaXMgY2hhbmdlLiAgU3BlY2lmaWNhbGx5
LCBDTURRDQo+ID4gPj4+PiAoQ01ENDQrQ01ENDUpLCBhbmQgRXh0ZW5zaW9uIGZvciBWaWRlbyBT
cGVlZCBDbGFzcyAoQ01EMjApLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IEZpcnN0IHB1YmxpY2F0aW9u
IG9mIFNEVUMgd2FzIGluIFsxXS4gIFRoaXMgc2VyaWVzIHdhcyBkZXZlbG9wZWQNCj4gPiA+Pj4+
IGFuZCB0ZXN0ZWQgc2VwYXJhdGVseSBmcm9tIFsxXSBhbmQgZG9lcyBub3QgYm9ycm93IGZyb20g
aXQuDQo+ID4gPj4+Pg0KPiA+ID4+Pj4gWzFdIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy85ODI1
NjYvDQo+ID4gPj4+DQo+ID4gPj4+IFBlcmhhcHMgYWRkIHN1cHBvcnQgZm9yIG1tY190ZXN0DQo+
ID4gPiBBY3R1YWxseSwgSSBhbSBub3Qgc3VyZSB3aGF0IHNob3VsZCBiZSBhZGRlZCB0byBtbWNf
dGVzdCBhcyBmYXIgYXMNCj4gPiA+IFNEVUMNCj4gPiBpbmRpY2F0aW9uOg0KPiA+ID4gZnJvbSBk
bWVzZyB3ZSBoYXZlOg0KPiA+ID4gWyA0MjUzLjkyMjIyMF0gbW1jMDogbmV3IHVsdHJhIGhpZ2gg
c3BlZWQgU0RSMTA0IFNEVUMgY2FyZCBhdA0KPiA+ID4gYWRkcmVzcw0KPiA+ID4gZDU1NSBbIDQy
NTMuOTIyNDA5XSBtbWNibGswOiBtbWMwOmQ1NTUgU1IwNFQgMy43MiBUaUINCj4gPiA+DQo+ID4g
PiBBZGRpdGlvbmFsbHksIHdlIGhhdmUgdGhlIGNhcmQgc2l6ZSBzeXNmcyBlbnRyeToNCj4gPiA+
ICMgY2F0IC9zeXMvYmxvY2svbW1jYmxrMC9zaXplDQo+ID4gPiA3OTk5MjU4NjI0DQo+ID4gPg0K
PiA+ID4gQXMgd2VsbCBhcyB0aGUgY3NkIHdoaWNoIGltcGxpZXMgaXRzIGNhcGFjaXR5Og0KPiA+
ID4gIyBjZCAvc3lzL2NsYXNzL21tY19ob3N0L21tYzAvbW1jMDoqICYmIGNhdCBjc2QNCj4gPiA+
IDgwMGUwMDMyZGI3OTAwNzczMmJmN2Y4MDBhNDA0MDAxDQo+ID4gPg0KPiA+ID4gV2hhdCB0ZXN0
IGRpZCB5b3UgaGFkIGluIG1pbmQ/DQo+ID4NCj4gPiBEb2Vzbid0IGFsbCB0aGUgSS9PIG5lZWQg
Q01EMjIgZmlyc3Q/DQpTbyBJIHRyaWVkIHRvIGFkZCBpdCwgYW5kIGl0IGxvb2tzIGxpa2UgSSds
bCBiZSBuZWVkaW5nIDIgLSAzIHBhdGNoZXMgdG8gZW5hYmxlIG1tY190ZXN0IGZvciBzZHVjLg0K
SG93IGFib3V0IGRpc2FibGUgaXQgZm9yIG5vdywgcGxhbm5pbmcgdG8gYW1lbGlvcmF0ZSBpdCBp
biB0aGUgdmVyeSBuZWFyIGZ1dHVyZT8NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IE9vcHMgLSBSaWdo
dC4NCj4gDQo+IFRoYW5rcyBhIGxvdCwNCj4gQXZyaQ0KPiANCj4gPg0KPiA+ID4NCj4gPiA+IFRo
YW5rcywNCj4gPiA+IEF2cmkNCj4gPiA+DQo+ID4gPj4+ICwgYW5kIGl0IHdvdWxkIGJlIGJldHRl
ciBpZiBlbmFibGluZyBTRFVDIHdhcyB0aGUgbGFzdCBwYXRjaCwgc28NCj4gPiA+Pj4gYmlzZWN0
aW5nIGRvZXNuJ3QgbGVhdmUgYSBrZXJuZWwgdGhhdCBoYWxmLXN1cHBvcnRzDQo+ID4gPj4gU0RV
Qy4NCj4gPiA+PiBEb25lLg0KPiA+ID4+DQo+ID4gPj4gVGhhbmtzLA0KPiA+ID4+IEF2cmkNCj4g
PiA+Pg0KPiA+ID4+Pg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IC0tLQ0KPiA+ID4+Pj4gQ2hhbmdlcyBp
biB2NDoNCj4gPiA+Pj4+ICAtIFNxdWFzaCBwYXRjaGVzIDEgJiAyIChVbGYpDQo+ID4gPj4+PiAg
LSBBbWVuZCBTRF9PQ1JfMlQgdG8gU0RfT0NSX0NDUyBpbiBtbWNfc2RfZ2V0X2NpZCAoVWxmKQ0K
PiA+ID4+Pj4gIC0gVXNlIGNhcmQgc3RhdGUgaW5zdGVhZCBvZiBjYXBzMiAoUmlja3kgJiBVbGYp
DQo+ID4gPj4+PiAgLSBTd2l0Y2ggcGF0Y2hlcyA1ICYgNiAoVWxmKQ0KPiA+ID4+Pj4NCj4gPiA+
Pj4+IENoYW5nZXMgaW4gdjM6DQo+ID4gPj4+PiAgLSBTb21lIG1vcmUga2VybmVsIHRlc3Qgcm9i
b3QgZml4ZXMNCj4gPiA+Pj4+ICAtIEZpeCBhIHR5cG8gaW4gYSBjb21taXQgbG9nIChSaWNreSBX
VSkNCj4gPiA+Pj4+ICAtIEZpeCBBQ01EMjIgcmV0dXJuZWQgdmFsdWUNCj4gPiA+Pj4+ICAtIEFk
ZCAnVGVzdGVkLWJ5JyB0YWcgZm9yIHRoZSB3aG9sZSBzZXJpZXMgKFJpY2t5IFdVKQ0KPiA+ID4+
Pj4NCj4gPiA+Pj4+IENoYW5nZXMgaW4gdjI6DQo+ID4gPj4+PiAgLSBBdHRlbmQga2VybmVsIHRl
c3Qgcm9ib3Qgd2FybmluZ3MNCj4gPiA+Pj4+DQo+ID4gPj4+PiAtLS0NCj4gPiA+Pj4+DQo+ID4g
Pj4+PiBBdnJpIEFsdG1hbiAoOSk6DQo+ID4gPj4+PiAgIG1tYzogc2Q6IFNEVUMgU3VwcG9ydCBS
ZWNvZ25pdGlvbg0KPiA+ID4+Pj4gICBtbWM6IHNkOiBBZGQgRXh0ZW5zaW9uIG1lbW9yeSBhZGRy
ZXNzaW5nDQo+ID4gPj4+PiAgIG1tYzogY29yZTogQWRkIG9wZW4tZW5kZWQgRXh0IG1lbW9yeSBh
ZGRyZXNzaW5nDQo+ID4gPj4+PiAgIG1tYzogY29yZTogQWRkIGNsb3NlLWVuZGVkIEV4dCBtZW1v
cnkgYWRkcmVzc2luZw0KPiA+ID4+Pj4gICBtbWM6IGhvc3Q6IEFsd2F5cyB1c2UgbWFudWFsLWNt
ZDIzIGluIFNEVUMNCj4gPiA+Pj4+ICAgbW1jOiBob3N0OiBBZGQgY2xvc2UtZW5kZWQgRXh0IG1l
bW9yeSBhZGRyZXNzaW5nDQo+ID4gPj4+PiAgIG1tYzogY29yZTogQWxsb3cgbW1jIGVyYXNlIHRv
IGNhcnJ5IGxhcmdlIGFkZHJlc3Nlcw0KPiA+ID4+Pj4gICBtbWM6IGNvcmU6IEFkZCBFeHQgbWVt
b3J5IGFkZHJlc3NpbmcgZm9yIGVyYXNlDQo+ID4gPj4+PiAgIG1tYzogY29yZTogQWRqdXN0IEFD
TUQyMiB0byBTRFVDDQo+ID4gPj4+Pg0KPiA+ID4+Pj4gIGRyaXZlcnMvbW1jL2NvcmUvYmxvY2su
YyAgfCA1NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gPj4+PiAgZHJp
dmVycy9tbWMvY29yZS9idXMuYyAgICB8ICA0ICsrLQ0KPiA+ID4+Pj4gIGRyaXZlcnMvbW1jL2Nv
cmUvY2FyZC5oICAgfCAgMyArKw0KPiA+ID4+Pj4gIGRyaXZlcnMvbW1jL2NvcmUvY29yZS5jICAg
fCA2MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gLQ0KPiA+ID4+PiAt
LQ0KPiA+ID4+Pj4gIGRyaXZlcnMvbW1jL2NvcmUvY29yZS5oICAgfCAxNCArKysrKysrLS0NCj4g
PiA+Pj4+ICBkcml2ZXJzL21tYy9jb3JlL3F1ZXVlLmggIHwgIDEgKw0KPiA+ID4+Pj4gIGRyaXZl
cnMvbW1jL2NvcmUvc2QuYyAgICAgfCAzNiArKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gPj4+
PiAgZHJpdmVycy9tbWMvY29yZS9zZC5oICAgICB8ICAyICstDQo+ID4gPj4+PiAgZHJpdmVycy9t
bWMvY29yZS9zZF9vcHMuYyB8IDE2ICsrKysrKysrKysNCj4gPiA+Pj4+IGRyaXZlcnMvbW1jL2Nv
cmUvc2Rfb3BzLmgNCj4gPiA+Pj4+IHwgIDEgKw0KPiA+ID4+Pj4gIGRyaXZlcnMvbW1jL2NvcmUv
c2Rpby5jICAgfCAgMiArLQ0KPiA+ID4+Pj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyAgfCA0
MCArKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4gPj4+PiBpbmNsdWRlL2xpbnV4L21tYy9j
YXJkLmggIHwgIDIgKy0gIGluY2x1ZGUvbGludXgvbW1jL2NvcmUuaCAgfCAgMSArDQo+ID4gPj4+
PiAgaW5jbHVkZS9saW51eC9tbWMvc2QuaCAgICB8ICA0ICsrKw0KPiA+ID4+Pj4gIDE1IGZpbGVz
IGNoYW5nZWQsIDE5NSBpbnNlcnRpb25zKCspLCA1MCBkZWxldGlvbnMoLSkNCj4gPiA+Pj4+DQo+
ID4gPg0KDQo=
