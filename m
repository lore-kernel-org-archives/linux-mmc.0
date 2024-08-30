Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA51B1D64;
	Fri, 30 Aug 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027515; cv=fail; b=ttTN3X3O4xZe/XtsBETNWiGtUoL/jevqD6HMEz4ySKsYErcdGc4XdcKplgp1SmrayM62Nrb/TNSSxg6m7XpDLLU0kAlPdh8Opoi+VpJlxi8xwHbISSrmznr+Uhz98tgAET7H//XuDl9JJ65OqUAf86bDXPp5HPOvcNA0MXk8V1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027515; c=relaxed/simple;
	bh=ua39LoRedcDx9ZiEOLsaseUjAwKNyMZftdHdcwBLNCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SdIzsIQRoZ0CV906SMTyMfAYzRqbZpCN7nBa+JPMAy+iAXlbiTJIE6OMB1hmv76OiQy+jZAamvunysreIUE8YIcivt1AsHHaX3+C1BLCIgxVsVwbSWeTgbr1S9EEVLeuGgFSItYFkyJgFc2M9XIfh0RFzOgsZ9DIGPfi3f+f2ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qyjlGGsy; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qyjlGGsy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOOCaojOY5M7r2YosIcUMlEZ+PUjvr27hC9uEP8/MfOSzgVCO1D7+1n82g9tfsG9RPQKSg1Djc2D7UqrG3o3U854jps11qWYZtI8akmwUmgSVoGEUJtUEa9JUm7ADX2C2jAfQQI6/1W8r2EM/jbhG+3mLwbZ6mgM6xoa2Y4BKCr8HUGVCspPPrb/SU90BRifdgzHh8hoiCswwCo/7GiQt2MP6taypiqeVC+aG04FGoi8Y0Bvvz7VYLYYB3Ou7Gs9Vtca+1/H3mUYK0CouhyXf0e0lEQDVitLhhp6TfuyeOo+NAMZlslbMgeXUP3hCEZ7k9mg/Q5skPqKZt9mBWJEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ua39LoRedcDx9ZiEOLsaseUjAwKNyMZftdHdcwBLNCw=;
 b=dS03DLWwZBaMpRhqdyRbXAXFcIhRK7rM06Cts+yN7OAmQFhlLekWwtRi8thz/PvhGrTh8FXrxQTpSiLBqzplK4mGBXdrCakHNMCwa4BXHBl67ZsjO+m8QPlBjxvfYVi002dmIKLQgW9kkYMao6/hu+BtCPI+m/yHNVf2Gbf4XVmEd0rv8fwdYY2HFifaDS5Mudh7kRUjBys07j1BfY8FmWS54slkvrSJvPUc5AtGHjBovrz3jh2EYD9XFWwpy5g8BaasxWki5YCJogFAGMRYBxpknXJ/L7mC1byp/gDzQCnSIo8ndhP7otcxL9f0tq4KE0uJHIDcnRc3aQYZu9H9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua39LoRedcDx9ZiEOLsaseUjAwKNyMZftdHdcwBLNCw=;
 b=qyjlGGsyBX4g0d989/DWa+l6lAxFD0FRjbwqVVhlUBB58cOpkCyWHZ1nTyZJw8iZRsMm6LBxveMpdjrbIPPYF+jEmOqQ+VKAzKpm9rXjF7I6DsdCvvczlmMYkgqW1IRbqv+AhSNXoTDc3pp+wMwa7raHZYrL8W+1WSWCA2d1nwZxvYEou5A3pFxzHpYa5uuxFK8G9Qak4oVEyosl5v57Mp6JEuk8k+M0EMsi5SoMA2d+GvVH2ZuSLMZxgzW13ngXZO3QxNVys2D49DlywWA4y16jn4ksJ6YYErdMIkVSxCZRHCie5OZh0HK+D5KFgxmCo/aNQQaFsDjpHenvuDzdgg==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by SA1PR11MB6871.namprd11.prod.outlook.com (2603:10b6:806:2b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 14:18:29 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 14:18:29 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>
CC: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Aubin.Constans@microchip.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json
 schema
Thread-Topic: [PATCH v2 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json
 schema
Thread-Index: AQHa+rVxtm/j4HNzUkiWXokLlbvD27I/0SSAgAAG0ACAAAEHAIAAAJEA
Date: Fri, 30 Aug 2024 14:18:29 +0000
Message-ID: <19fc7387-5ac2-480c-8ae6-8501cd65d071@microchip.com>
References: <20240830-atmel-sdhci-v2-0-b7f58973f3fc@microchip.com>
 <20240830-atmel-sdhci-v2-1-b7f58973f3fc@microchip.com>
 <20240830-satisfy-dislike-27ed075138b3@spud>
 <9e9c8274-6bf2-45f9-8b65-ddc73a0802bc@microchip.com>
 <20240830-retry-ranger-fdd01812a120@spud>
In-Reply-To: <20240830-retry-ranger-fdd01812a120@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|SA1PR11MB6871:EE_
x-ms-office365-filtering-correlation-id: fb9cdc81-3936-4ed9-8788-08dcc8fe9edb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amhLTyt1bFBwMnZpMHZOV3YvWTZwTk1tS3l1OW9VZlJXZi9yajBFdWVHQndY?=
 =?utf-8?B?anBlbzV0Y0RPVWZ3bHVPZmRLQnlWc0I1cFJITmliMHJDeG1JSks4U2h3R2wr?=
 =?utf-8?B?YkJ2NDlibmZqYmRTU1FxUHJNMWZoK01GYkt6cEJKaXZENVpJaExubEJONXM3?=
 =?utf-8?B?TnhVQ0ZMSmZYTTJzMXpHZnZkNlU1eElSbElOME84bUhvSkZYQ0ZvOENveWll?=
 =?utf-8?B?OWFtWE9QOFRMcW1TY1F1UkhEYmdHdkV0SXdRSm4wYkoxQm9KWFVWMTJ5NE5H?=
 =?utf-8?B?K1NHdGFMR3hZNDhpS2xtMTIwdkFpcW02Y2s2Qk5nZGpjS3I3WEZEenRoVmo5?=
 =?utf-8?B?VXlaVG5xTmVFcXBLYWdONURGS21ITjBpYVVCelhYa1RkRnVUOVRWM1RrYUpP?=
 =?utf-8?B?bTBPdlkwbDhCL1NXSEJwZ0pGYzJOSnlxaFg4a04vZWZpQjJGemdmZXJoVGVo?=
 =?utf-8?B?dmwvck82OTMwOUVXZytxUUIrWWR2WlE2Y0pXczVZc2V5YTNCT1lzcStrV0oz?=
 =?utf-8?B?ZUg4Vm9KWm5vTW5VVnAvRWpEUkJxZjhoYXZUNk41cUpsL2FQUjRiVmJZVnBo?=
 =?utf-8?B?QytGbC9lY2I3WFRYWk5lQmlvMVk1TzNkNC81c2JXNHA0WEwyWXFCeVQ3L0U1?=
 =?utf-8?B?MGFFVk1YY09CRjFRZXVmR3VIVDg4aW91S0J3S21oclU4QjM2dk42OU9HSVlX?=
 =?utf-8?B?amVoS1ZuczlOeGNPdUxZdkc4eEMreGQ4ZDZ2UXg0YXp0amJLQ2k3WkJEa2lH?=
 =?utf-8?B?MmFzL0lmUEFlZmhxaGdtaUlyY1l0SUtDbExrWkkrdXpyUnR2cWs4L25aR0kr?=
 =?utf-8?B?VUdITmx4OTl2dWVqRHlaNWhUN25xWXBwY3E1SnJHR3JnVTh0Y3RwWVIvbTFH?=
 =?utf-8?B?WmVIWlkyTmc5SmhHWklKaDhQaEM1QjB2ckl5Ry9lajNKTkVGS3RmK1lvaHdv?=
 =?utf-8?B?Ny9KeSthQUc3SlJ1dmhXai93cW82cE9lSFVyMGo4L29CMVhaakZPL3VnSm10?=
 =?utf-8?B?YmFNZUNLTHpWSU1ESVl6bXV1Y0Y4VnhrNnJoclByWGdZcFpEZkVudnQ4dTZ3?=
 =?utf-8?B?THVUNmRsL0p1WkZSVDB0cDI5TmEyMU50Ris5REFjZk1IV0VYYjkzc0ZJcFRO?=
 =?utf-8?B?UGw4RDBjMFA4VCt4VzgySDhKLzBnL05oQzdvcjQxWFkrVm1TWTdFZHJBRXND?=
 =?utf-8?B?TDBmdFFRTm1BM1l6b2hnN2NiMTJlWHdyRTk5NGF1Q0Y2bjdoY2xUeitGbjUx?=
 =?utf-8?B?dTZwRysyQnJBbFhNTWZOUXBEOEo2T2NPbU15SFRoSE5oZzBtQ0hQMHFsRGNC?=
 =?utf-8?B?blFXTlFaM0swOUVmZnpnSW10a3lDaENtQmpnM3pXZUlOc1RLQm9IWEtzQkRP?=
 =?utf-8?B?eVpTTkR5K2FDTmNSN2FRb1FBTmxiMnErakJVNjN6b0RxZlE4UjhwdlU2ZG0r?=
 =?utf-8?B?YjZNTSszdlhQVTdWdk5CeVRpTlpWUmIzNzNwNU5LN1lobXJ1Z29oeTRVcWZ0?=
 =?utf-8?B?Q2F6TlhBazQ0My9XeFVsREFzMVhKeTVOZlNodUlIZUxhYzZJSnJwVjdkUlN6?=
 =?utf-8?B?SFFsNDRLT2ZEY2o1T3lybmNBK3M1ODJVVWs5bXljUlRhd29Xd3psWlpQdGY3?=
 =?utf-8?B?VjBtbHo4Y3c4bVJUMVBISURhSFVkcTRMbm9BbFEwbnFGUEoxMEswSXhPaXZI?=
 =?utf-8?B?bjUwNlprQ2VmSGlqd2VuT1pPdjdBYkdWUHdqSlBQSUZWUnpialA2YUhVQXJ5?=
 =?utf-8?B?L3Z5SUl5SnZlZVNtTDI0Y1BYTFdja285aEVKK1dJTUNvdjgvMmRJQzIwR2cw?=
 =?utf-8?B?YVB5bUZNZ2tJMnVCSnB2TDh5Ulc1bGgxenYxSm9FU1NCRk94aEtwMU0zb2ox?=
 =?utf-8?B?aGI3WFVndURqQStCS3Rsc2JwSU1MaEl5b05JcjZoVVFSV1E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QldybXpYY1V6dXQ4NUtXTjg3VXZIUC83Y0c3VXBJZ0ppakord0dYd3phWk5P?=
 =?utf-8?B?blV5RkU3L2RqQ1lIZTRRWTFyTUJFVUNxak8zSEgyZmJhVUszTk5TSFVXRFBG?=
 =?utf-8?B?TnZTM0RralJpc3hOVDhxeFBPODU4RmhMejlHSEJ6SFRRamdjbjF5NERubEM3?=
 =?utf-8?B?VVU0UmpXUisvS3J0ZFhZSktoQ242RkJsZm1wcm5kYkdjcTNSTERiQUlXaHZM?=
 =?utf-8?B?ZDVmTyt5TENBYnMwTjVCaG5xT1ZkL25PT1VoTjJ6QVMxNCtIVU5ydE15NDhk?=
 =?utf-8?B?T0srNEs0eFBnR2NBRHpEdmJDNjk2Slk4OVV0aHNGdEJjbmNsQXpZQWxWN1RI?=
 =?utf-8?B?ekNQWnFVZWt3SUYyOHpncVpJakVCKzE1Q0dLVy9uekprZStmRGozVFhaeW5J?=
 =?utf-8?B?OW11WmJjMjdiemdVbkkxSDQyaU9MNTZUSmM1aHJBby9hL1ltRXBlWDZNWElG?=
 =?utf-8?B?U20ycFpNeEN3MnMrWkorVXBHT3AreG11REI4VGhGVi9xSGRIY3dpSWRpVnFq?=
 =?utf-8?B?NkhFUU5wRjdkSWI0R090eG0rS3pteGtzMVNDUUdWNm1JbUJqLysyUjluTlVy?=
 =?utf-8?B?bVdIQ0J2dXVsRUtuNXN6R3pkb0xRZlQwMUtFejRWVzVKSXZCaU1DRCtvR0lq?=
 =?utf-8?B?M3dWTmpIcmczeExjYVFpZFU0SWNhU054QlpCYkNZczhRZXJsS2xqb2wyWVdR?=
 =?utf-8?B?d1FGWFNyZXJtdGJNdjZ6Yk56L3hoMWN4TTFzdDluU0hTeCt5UEticjQwQ1RN?=
 =?utf-8?B?YlRjV2hVUFgzMDVmVDN3NzRJV0YrTnp3TTdOei9ycU1EcFNWQWhucWM2NzJW?=
 =?utf-8?B?UFJ5MjVOSlNnc091N1NsM2lvMG10ZWNUYkdjZWMzNHdpU1NCZjNZdDFFMHNF?=
 =?utf-8?B?VTFobGlwaVZmOWJvdzI3WGVyWXo0aEpuWXFDQmh6cFVJYXU3SlVmOHhwWmk2?=
 =?utf-8?B?M01ScWpMUnl0Y0hGNlJKb3BDaTBnZ2t6Y1RHRVNtZGNLUjFScjZpZmswcEE1?=
 =?utf-8?B?bVlwbUhZQ0EzakhoeEViSTB2S1QyZ3lVQlVZNWNmY0Iwa3FSUm9QNlI5bEFy?=
 =?utf-8?B?T0lDRGpNalM5WkdmY0FTRHpNbkR5SkwvUVBuRnNOLzNadGxEanhWRHBLTnY5?=
 =?utf-8?B?Rlp0bTM2RmVmS1IzRmtFUkN2aVlURXNtNEc0dEFLVWhNa0dGM0VqRjlXbUVn?=
 =?utf-8?B?MDJ2OFVUTHczbUVYNy9lUWt3S2IyNkVqay9CRjdhVCt1SFJtUmJ1eEZSSE4r?=
 =?utf-8?B?NFBxZzRHaUl5emNXaG9YMVl1ZkVnMGxJRzU5T2N0K3VXUk1tbzJOQkpBbkpC?=
 =?utf-8?B?MkxBbTdDcUE5cGVQSDVLdEpmMXU5VENOTXJsdjdtWXkyOHkwalpaMVc0V3gr?=
 =?utf-8?B?bG13TE8vN0hhQWNMUXR5UzQ3SEpQcVgxZlV5bERBcUM1dGUrbW9vVG9tWGR5?=
 =?utf-8?B?ZEZjOENka05EN04yckhTaTJ2VmVNNlFnQmxLWDRsOXExMk5BU3kyMHAvVEx1?=
 =?utf-8?B?WFFQV3c2MVZVMWorVW9XVmVVSGVUNjA1M2kyVHBFbnpHS3BESmRmZndubVBz?=
 =?utf-8?B?Q3QyRzhMV2ZnelZuRjNGSnNqRkpsUVJZTXVDWTFFVm5FN1ZTeEY5NmJxb2pt?=
 =?utf-8?B?QVYyYUFGWi9jb0NNazZZUzJXSHYzazBLS2NEZzV2WFkyYXl1ZHdXWllaZzdh?=
 =?utf-8?B?eURGK1JnNWpua2NiK3R1aTIvN1pUK0ZsYWE5R3Z1S1g5VWRqSjA0Z1dDL244?=
 =?utf-8?B?U0sxdG1RUUNsVnZiSUZPRjUwZnc3OHJHUy9qRlpnSDBqL1N2YVRXUWpVd2RF?=
 =?utf-8?B?NWxkemQ2TDNJNk5lQVlMSEV0b3lRNmhXQkVhWEtTeUtSZHNhOTM0M3ZsWWpr?=
 =?utf-8?B?dlJwODVKeUZXSHlOS21zV1I2NUNRcFJJalBHYzU1dXBiRE1wU2kraHdiZDFY?=
 =?utf-8?B?eDlyWG1kTmpzYVJld1ZHRjlYaDZPY0pPa2xUV0NLNzIzdkpMVFI2emM4SDAz?=
 =?utf-8?B?R3p1Yjd2Wml5dUFNSmRmb0dPdjVybXZDb3VEMzJXbmg5S3hFSnR3RDJpVU1s?=
 =?utf-8?B?VXBUb3JHbWJQWnpDbU9zVk80bW5lKzc4OExKN3o1QUZSK1ZWbHdLZDVueGhv?=
 =?utf-8?Q?7lGoak70MmWi6RuvHUdtoK72e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB08158E88FB8C44B4D17526E99EBA28@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9cdc81-3936-4ed9-8788-08dcc8fe9edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 14:18:29.1855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XuVNDdbafFfxsbp2+nEmyyhE1OivUD2rDx6H2m9fBxyKxmEwSaMq6zsAIA0jqoOu8aPXt9yBcVxdAXvWnbiLKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6871

T24gMzAvMDgvMjQgNzo0NiBwbSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4gU3VyZSwgSSB3aWxs
IHVwZGF0ZSBpdCBsaWtlIHRoaXMgYmVsb3cNCj4+DQo+PiBjbG9ja3M6DQo+PiAgICAgaXRlbXM6
DQo+PiAgICAgICAtIGRlc2NyaXB0aW9uOiBoY2xvY2sNCj4+ICAgICAgIC0gZGVzY3JpcHRpb246
IG11bHRjbGsNCj4+ICAgICAgIC0gZGVzY3JpcHRpb246IGJhc2VjbGsNCj4+ICAgICBtaW5JdGVt
czogMg0KPj4gICAgIG1heEl0ZW1zOiAzDQo+IFRoaXMgc2hvdWxkbid0IHBhc3MgZHRfYmluZGlu
Z19jaGVjaywgYmVjYXVzZSB0aGUgbWF4IGluIHRoaXMgc25pcHBldCBpcw0KPiByZWR1bmRhbnQg
ZHVlIHRvIGl0IG1hdGNoaW5nIHRoZSBzaXplIG9mIHRoZSBpdGVtcyBsaXN0Lg0KWWVzLCBoaW50
OiAibWF4SXRlbXMiIGlzIG5vdCBuZWVkZWQgd2l0aCBhbiAiaXRlbXMiIGxpc3QNCkkgd2lsbCBy
ZW1vdmUgaXQgZnJvbSBib3RoIGNsb2NrcyBhbmQgY2xvY2stbmFtZXMgcHJvcGVydGllcy4NClRo
YW5rcy4NCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0K
