Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A6E2C0F63
	for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816144; cv=fail; b=dUmgEZTqTrlmT8r/3+poh1ZRmPAe7iJg2KcBZVUasGTxxPvAiQLifOVM7gAYNITH/AmUCVOoDVOAxK4AqoQbtepWM6tWq1/7rbF/1ZhOLF+sHEgICvle7TWZCMAz+7LJWitHOlob/apEmfpoCr2SoKkfC1pE8aryIyHRXNL5iHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816144; c=relaxed/simple;
	bh=wm0uGzQTHd/1OZDFXTZjXFQXQbnvuQlN6/ReL1z7EAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a+IkqTUpP8WOqFIvdfOvn288Apa+6pQQu8W7oKtttlLRYMpz9lHwSWWtW8o/qhwgunvcsHBG+Kbv1wbGB0OpQJW+3g5fuwovqA1GJqvkRPr9SzuFVn2kIdFzqSoMtM6k2DX3HSezvpqXcuzsBVT7c2MycYNtBrf6c84U6G0wRYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=TFhA9DrY; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="TFhA9DrY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1765816142; x=1797352142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wm0uGzQTHd/1OZDFXTZjXFQXQbnvuQlN6/ReL1z7EAY=;
  b=TFhA9DrYpufo11g6r4ctSAQHVaNNdt449SV7jxDKdtIW2Y+IqfKiRQ7Z
   tPn/N+xrCWgcyQ5IoL34IejlX4La/Jh/hR2oE1EDbpOxXe3m1kgVIzlJJ
   LcmL1ZRf2QCO2CLtrVGkP9cX5ESyfIpvKTR+2BnEyHTmYaHs7m+NW/caz
   ZLkNvApcY2w0MD/Wq/CBC3UKbqqnfTdsJef28p3MrbTmoCYLRjFTaiNZQ
   gOwg0aqTmQQbfIXsfDiTXesoRvysQE+9pxb067e/VrllbpBQzzGjpzfkI
   9uXt2OsFJD6lOIS3T8IvdnbpJcHa+r1L0e7RDlcnHXMQpAZAsP0956w3k
   w==;
X-CSE-ConnectionGUID: 7lBbMJOtTTKegoL0MJX3Ng==
X-CSE-MsgGUID: 0qce19ZrT8i4EUVvlpK9Xw==
Received: from mail-westus2azon11022136.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.136])
  by ob1.hc6817-7.iphmx.com with ESMTP; 15 Dec 2025 08:28:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl574p4WbjufeECPBGvcZ1FXn/CjJsyJcdfsRIr3iPMIvCXTV2LHvGbwqHaE7Go3GWzYdKLtaC6upsm3q2D8CgFBP8gJG3lshX5UFzTXsIYlLSIzTZjMKXZUTMgVUDjziopqm15UD7tcM8EhoFw8DCpWXBumbTusuxPhxrvGZ+C6WqSvn6yvnDaDHFK9CY5/1FoojxTqnfISSFo4zXxgLxhbllcKwXm5p/3ko5mNwFlOk56ZCn3UTIwafCXUNa1uyRZblP4MuGrpVRl5fMWpaRWz9uoFQmM7gIBPVpqhMRz5X+WijiD1hJMtzjXXmXB9seb7M7J7vd1d/I28W9VOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm0uGzQTHd/1OZDFXTZjXFQXQbnvuQlN6/ReL1z7EAY=;
 b=i3vOzOduCrCzznDhOKMaxCrCSRNlzHkX0Gt88nUTMqbK2lNI7NQ9g9zs6pwsZt+kjNz+XxGxvskMmnnJdycw1KkGBUzdvSFy6nSNiTMuFm7cTcasNVPIcp0UoctBikhKXIMSdXR6LvA2M3gQySQlaw+A+kd64e1qptraDV7tRKDBsf5Anr/9QiJi0jwL1U2amDqySuJBz4Y5KPMtjvvjc15yDo/05/GZcfXXQdN9Uy7+9MpmBRHpbhs9MOdGy1oCCPNvDkDiaTPaqA9G0XDZO/uBw44g/H69NJMzFp0tsmoj3dGwDfFmx+T2sb5i+ojW6dWPwVdR0qHMsFbsJsvUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SJ0PR16MB4256.namprd16.prod.outlook.com (2603:10b6:a03:329::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:28:50 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:28:49 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] mmc: core: Extend manufacturing date beyond 2025
Thread-Topic: [PATCH v2 0/2] mmc: core: Extend manufacturing date beyond 2025
Thread-Index: AQHcYCa4HuKdBMa2WEG0w7ax6wml9rUi8tYAgAAMVWA=
Date: Mon, 15 Dec 2025 16:28:49 +0000
Message-ID:
 <DS1PR16MB6753E217F183ADF4F6800879E5ADA@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20251128052011.204735-1-avri.altman@sandisk.com>
 <CAPDyKFpshnLSa+GNOpFdQ6_Kc2ov_jofq56eq7WsqZMRVYs-NQ@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpshnLSa+GNOpFdQ6_Kc2ov_jofq56eq7WsqZMRVYs-NQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SJ0PR16MB4256:EE_
x-ms-office365-filtering-correlation-id: c9a47d36-5d3c-459f-6b86-08de3bf70743
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rnk1dWNYMTEzd2RTS3NaTjl5YVE1emNJb2g5M241U0ZyeHF1SHpGSG9WbHF5?=
 =?utf-8?B?SGV5ME5zZklCaTdrdTdNRm45TlcxYzBFRDhZTVg4SkpNWXdFRGZxMG1xMHEy?=
 =?utf-8?B?ZnQ0MUhnSHNmZjd1WnBsaC91TmxNK1dlTGNxQWlwcTFvV1VITTVJVmJFUCtY?=
 =?utf-8?B?T29lZ2x2V2g1Y3ZTWWtrc2tTUXludlhWbHdzOWhGQ2FPa2d3SzhmV0pxRU1W?=
 =?utf-8?B?Slg3K3RlL0FTQmh6SDVjaG5CU0RtOEZORi9GM0UraWJvM3lxWnNKRVVGU0tV?=
 =?utf-8?B?UVY4bFd4NnF0cmNwT0ROQnBRcUlLWHEvdWo2TWhqYlFyTng5eElHZCtoMU82?=
 =?utf-8?B?MUxUQU9jdC9KeUJXRTMxTEhqeE1MTzllL2xUWVBNcHIzK1F6Q2VmeEhLbElK?=
 =?utf-8?B?T2VoQVlqQjFtQjNGb0VCcFlWNHJVQTFjazNiYzIyN1UyU3pSZVNHbS96Nlg5?=
 =?utf-8?B?d0ZnZktNTlM0UmJ6SG5kSEVxNlVtekxLaWgrR2RQYmdwWndVTVhqTUt3cVdi?=
 =?utf-8?B?cDhZenpMcE5za21qY0tzbGkvMDBJRFFhQ01OcVBHS1dpOWhsQzBLUFVFY0lt?=
 =?utf-8?B?cFArTnBPR2F5K2NKSTJJbCtoRXNNMXRJZFNrM0EyL1cwZmZ4Y3hRdXRQU1Mx?=
 =?utf-8?B?VTJYdEVBS2VGVU5yQ20yd0FobGZQREtUTkJwdG9RMkRBQUJlQ0xDc2ExbFEy?=
 =?utf-8?B?RVhDYmhrWWhUY21SVFFEK0dzTTRQY0tyb0NkQU1IOTh2WGhDNkpFRzM2RHFZ?=
 =?utf-8?B?Zk9BZk9ZUGNBb052bmpSVkZuNzgwL1JFZnAyUkhQVFJ0VjkvRnI1MzdONmZq?=
 =?utf-8?B?THdTQS9tVXZrM3VtaGtUV3IzTVJ4RGUzTFdnS2UzdHdjTXYrcyt2ZitxQ1lJ?=
 =?utf-8?B?Q1gzNUNuTitPaG82V3dpYXBIYjRMY0RrWTFsbDdacE9GMml4MmRwMzhwNmtv?=
 =?utf-8?B?b0pSa1pob2w2c1J6bWlqVmJPeTAwR0xyc01uenB5NEZJVWtVeHd3VWpLbUFM?=
 =?utf-8?B?TmVnTkVNRzVoNmJtbnlCUzVabjFwejRHRVNXcUgxMjYrWThjMk80U2UvTnRs?=
 =?utf-8?B?dE9OenBTYS8rYzFKdC92czhZeWxKcVZlVHN5SzByU3RsN29iU0cxZGc2K0l2?=
 =?utf-8?B?b3NkNUxVcnozSUF4dUdNMys0bkk2b3pRTzQwZW9ld2lmZi9xVGxGZ2hEQ09O?=
 =?utf-8?B?MUFVTFE1Z0I3L0VZZnZnUVJ0UFA4T0VSZXBtenpEMlY1cmRiMmZJZ3V4V0NR?=
 =?utf-8?B?Vm5CcE1TMHJvRElZNE5sMDkwK3AzNUlGLzQrNzM1T2hGUGhYemdZMGZpdjB3?=
 =?utf-8?B?eGtpMzNibXYzNExIQ2pLeHIvWXRiUmhITVJ6NHZtdWM3Yi9PcW9weUs2SURH?=
 =?utf-8?B?YWRlcnl4V08vNWFGdDJNVFlDdFZuMU53TitBM3lSaFVZaWl3bUdiWVZlaXp0?=
 =?utf-8?B?cEF3VEY4T1B3Uk5ubnVncXU2ZkYweFczN2JaSk9rMG1vYW1OZUZZTytKcUFs?=
 =?utf-8?B?VHIxdzY3SWdKYXJuK2VwUzlkNjJPcGZNdGdKdVlDRHU1VGZtUkRuWXVTM1FJ?=
 =?utf-8?B?bnVuWjF5Ylh4QnBJSVRtWFJMNjNvNnJka2g3L21VZmZka2lMc01pTGEyQ0t1?=
 =?utf-8?B?UmpsYzdUQTU0UHVjMWpyNk1ERUVLWmNzWFk0ZlNQTVpybmZlVzA5cUFCZXpW?=
 =?utf-8?B?TityRmpSMHdWM0RNdFJYQ29DZGxUT2VhRzdmbEsvb3pRekpTc3QycWpOdnFF?=
 =?utf-8?B?YkI1bmxJQklSZDdmeG1TSlppN1FIUFlUZlNUZHlVSUtnWU9vNTRYVU50MGl2?=
 =?utf-8?B?OG1UWUg3dzZ6UFRvWnRjN05iQXdRcG52eW1YdEQ1TmU4bHhDUElqSjVwM2c2?=
 =?utf-8?B?SW1MSWFnV2N0VTFnS2IwNzhWbFJjaHdWbzhKZmcrZTk3MDRXSHhXNlozZFBz?=
 =?utf-8?B?TnRmSzg0UkVIQlE0b29uQ2h2Z0RZMnowVncxQU1MYzhjSjFsV2NuNjRydEpJ?=
 =?utf-8?B?ZDc2eTdYeFZZMWNnMmhKQ0UxZXVBZHd4RUlXNldBSHhCRjlrV0JZc0Ftb1hp?=
 =?utf-8?Q?f9SliP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDFTUHZrd2J1cFFGbGROcWRaeThiK0lLVjZGT2x3Z0ZEVFl2TU14V2xhMkFZ?=
 =?utf-8?B?R2k4a3RDQWhNWXpFUit4WFluZS9BZHY2VXM3R3dqVWNNR3dkS0FLRzR3UFFS?=
 =?utf-8?B?RWRjUnkwdGJtdzE2cTZwU2lyaURNZ08rMVJTejdqcmdDSGZYR2pDaWxUWFRw?=
 =?utf-8?B?cC95VEQ1Q0dMOGNXeStOaXlYOHZVdklza1k1c1F3ZjdRcTQrYWpmeWd2NVdF?=
 =?utf-8?B?VnBkQUtUN1RMcXpiMmlUUjdyV2tYWTZxVVZ4YVdidERDYStMM3MxSWc5VUQw?=
 =?utf-8?B?RWxsTzVuY0REeHV0RXBwNUg5clcySDhvYlFoWG9DdHJyTGhUZG5UMkJmUU8y?=
 =?utf-8?B?YnJUU1NudHhROEFaWEJvZTlpMjRMZldZbGlaa2NzcDVCaHFDam92WTNCQU03?=
 =?utf-8?B?c09XMmE2SGYwM01Hb2l6cSs2ZU4zcmhqM1hXM0NKSTZlK2E0NkFPTVZoL0JY?=
 =?utf-8?B?bHFJQmRRU0N1Qkx5enZZYzI1aXVpRjlnbEI0UWg0SS9OZ1VOVE1lVitiNVpF?=
 =?utf-8?B?RmhaNU1BbnhzaVRNZ3lvQ2VRT2xJaThCTzBvc2NPYlJrVDlEMS9VeHMyM2hv?=
 =?utf-8?B?M05UbDhVdXB1QkFpUXZJek1WekdoVklLMGJoWlh0TW9YNzJ1U3dpZGp5cGND?=
 =?utf-8?B?Z3B6S1FCM1M2M0ViN2dTcUVINm82eFNENUF5YlJtT3BZRlN4L1k3MHFlOE1G?=
 =?utf-8?B?S1dQWGdreEUycWJLUS9GL1UvSFpndjh4RWhUR2xHTmptZmVBTEZVK1VxTitX?=
 =?utf-8?B?QWtpblZxVktseTFOckF0Nndmejd2WjlqcW1nQXRFZ1AwbGxHSTd0Z0NVWnkw?=
 =?utf-8?B?bHBtQ25RYlkyUHlxSkVLbGJ6MGxoWjJHajYzQzVLQ2VmT081ZFgvRlF1SHNR?=
 =?utf-8?B?aGcwdGxGcXpLN3N0dk5OSDNyLzgxcFZoY0hRdS9YREJ2TndXV2xvL25QTTdT?=
 =?utf-8?B?RjRWU1NEd3plMjl5eDlwbUlqT1Zoc253aEVmWU1JWnQ2aU1EYVBLRlFab2o3?=
 =?utf-8?B?eGVZZnNyemdpOGtQRDJKTTJqWGtJTXljZGxQSzJGMTEyUERVZ2h6Nm05QXZj?=
 =?utf-8?B?eWsrQXBEU0h3RkpnV280VjNwRWFHMzFpemxqVldBV2hhT1FVOW5zV0pjZXZj?=
 =?utf-8?B?OG9hUm1qYnRKV1gzb3M4YUlNakNPeEY2anlVS0tyTUNSZkEzZmF5cmFkc055?=
 =?utf-8?B?N1RiZGVuVVRieE1UclVMQUhJU0UxZTJCYjV1cnVzcXNLdnlHeS8vRXQ1TWNq?=
 =?utf-8?B?QWtNQU5qaFozckhvOU96SVFyeWowMDM5d1BWTVBaRCtlQTRLZjR6UTNnZHRR?=
 =?utf-8?B?RVU4R0I3YUJ1NitJTUM1VnhYditsRklWL0FJdWlZVHVpRlZBcDh4SHBDL0Ns?=
 =?utf-8?B?cndpZEVOeE1walFUVkpHUy83ZUx3SVh6Tjh2SnpTWUlScU92T0VOSVhMWVRN?=
 =?utf-8?B?KzNQdGpORlFnVEtxR0VSbG0xUVYyNUNlVE1ZQ3ZJK0o3b0NBUlRlMzJsbVB6?=
 =?utf-8?B?RlVkalRwSDl2L1A1TGlGR3cwU3Fjc0FDR05xN3JpVWRVd3prSk44VFpqcXJ2?=
 =?utf-8?B?dUlsWXYxNm1YeFUyRTNrenpFVTdUN3Y5MXJZQ0lNKzFpcTV6WDZOdjN6NnlW?=
 =?utf-8?B?MktqNEhUZFQ4Ykd1ZUcvdVJFaFpnRHBNcktwRjhRU0RnOW1VWGRCWWVFMEh2?=
 =?utf-8?B?MTRyU0lCYTJlWDZEVzkwV056NjJHWmNRNkt6UUh1NGI0WTI2RmhNWUk5NlJk?=
 =?utf-8?B?Zm93N0JWV3Z4NHhxK09LZ1c4aGtlbVpuNWdmalM2YjZmWnNoc3NNNTlDWEFi?=
 =?utf-8?B?cjNQMTZZNG5GZlhESENYS25qNWRsNWh0MDR2UGg0QWx4WjY5MVU2dnVvVm1X?=
 =?utf-8?B?SSs2QkRQS2lia2ZKZWswOUZ5bU94aXVWdXJmZUFsT2xjYlJ0czIrWEEwMUVY?=
 =?utf-8?B?bUk4ZVFCcis4YkJlVEE0SmlXN2M1ajVrSEZDT05ncVZJcHczWUNrYUlJSXZP?=
 =?utf-8?B?RmxPemxGcGZCemR1Z3E0cDNOcS9PUHY2VVhENGgydHB1Y1d1WGNhTENFZndU?=
 =?utf-8?B?NFlOWXRaVVdZT3NrbWwvendmNEVyR3NYbFpVT2tXYzVtMVFJMmpKT2V2d0NO?=
 =?utf-8?Q?TznTw3UsgMthGGFmxvceLSvNr?=
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
	KFZsRMqTxzGUg5XZ3T3AQ4ECmZCHEDkc4mSlMkLg0nh3hqLK3dOOhNu6yEg95wXCBujm7TloupMQfyT4dHIfVrpk/4/D6sbBRC7+GYgqOd9ruwoKvxbFugL2oXCA4EyK6ovtaTLEqXNUt4aonhO32OI6G4VY9TC1nL5hI8Iqw4KcO5AH7tPaiZftcGvxBAaLNcIVlYFIjsSfZd0oIVqxGBPynDuutebjhkx/6IVD9p1bSosJK8NO8DY7CaIBQq21ivtKJMAfCGdSOIzZtJIYIosD7LoDd1CaBlKS70tzGZZRLpLwJo2RPW/6eNWiTw+zAO9C4eoDy2OsWnYlcuX8glXCgZZpRp9StKUiEBJ4KbYBr3K8WGRRUF6cQ8aeNFrbkz2ytG7SdfXd76sxJTjKgPCrl6WEfxWbjo8Ey9t1h6YMXxwioQWmy+/7A0GAuXElzdQjknunnHFuNM5uCUONvMwY8b/pTdqc5TU9aQF+Uj0pKDYXEpBzFddLXEEPpW1ybBL6WDsOsdjSVo/MdqIbE6ayoQnVRr6qpQoUvWQiFpW34Z+VC8h/hL5Q5kAa9+s467PufMca2NnygRXIOpv5Le33qhNzeHp02Vp3ekqHC/GAHrwTXlQsPdJHirKXmc9RoD5MJVn+Z5gr+63LwwHemA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a47d36-5d3c-459f-6b86-08de3bf70743
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 16:28:49.7607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SX7lvxM1rE9OHXYWgBfETcDk5tUDS2ZgYosI/aRBaOCU41XXgvUQTwMvxnJwAeCQ4IswYho0D2P1LrHPP9xEUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR16MB4256

PiBJIGhhdmUgYXBwbGllZCB0aGUgc2VyaWVzIGZvciBuZXh0LCB0aGFua3MhDQo+IA0KPiBIb3dl
dmVyLCBJIG5vdGljZWQgdGhhdCB0aGUgYXV0aG9yIG9mIHRoZSBwYXRjaCBoYXMgeW91ciBnbWFp
bC1hZGRyZXNzIGFuZCB0aGUNCj4gc29iIGhhcyB5b3VyIHNhbmRpc2stYWRkcmVzcy4gSSBndWVz
cyB3ZSBzaG91bGQgY2hhbmdlIHRvIHlvdXIgc2FuZGlzay1hZGRyZXNzDQo+IHRvIGJlIGluIGJv
dGggcGxhY2VzLCBubz8NClllcy4gU29ycnkgZm9yIG1pc3NpbmcgdGhpcy4NCg0KVGhhbmtzLA0K
QXZyaQ0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
