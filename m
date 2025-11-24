Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8213043D0
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004270; cv=fail; b=nm+T8GEyHIte7bZ1rV7/iez4WMzDA9bNu2Hsxdswm2Ev9squ7lDzktGBQWZR3BavRRdsxH34c+co3ZLcUawy7ZN299MsC0bFst2mhvgw7SleRCVK+evJmgeMPirqdnBpu3mTqfreXPuHHH+hMz7odAjk+xIpcvjYCq+Kdi0DJlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004270; c=relaxed/simple;
	bh=EFzT66332DLTozpy0DZdRi2sFGT1c2h2sUUFGOOWFds=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fcR1xRDuOW7HZ4WtxrG+vHEzLVIUXim+R6oONQzxlrdiQxxd5KWI2a8c1DDbB56lHi0l5lGyQ5AjXbps+0a9wjhO9/XHBz+oRf28tfaEI72oFsp3geJbsztR6McmWNSSA41YHIe7F4IwuaHPiY7QHHjOyj6Br9oMtO5pHYn8RDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=NVU9MwRl; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="NVU9MwRl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1764004269; x=1795540269;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=EFzT66332DLTozpy0DZdRi2sFGT1c2h2sUUFGOOWFds=;
  b=NVU9MwRljbvE6iytxsxeBNvc4BgBI5aDvA7n7kyhx+bayw+zWFA9P5xD
   jxmClg5WO/Pv+izeQoP+tIhRNXhrmeuddtSGUE2irq3NHdRsEDCTz63cR
   XXTy1H+cQooiElKOr7BT2ALow1okVT8dF/pXb6PMHIIb8Pywj+4j6IoKK
   LMbdYB8a6Ul3FSh1pfFaKIPMekCHR0ivV+AmJktmhCjV7ca8h7ta/cIPn
   oztyP0bf7VwWWS4GS999MSLK+s7r6uVjD8hbxdnb8PnO8B0ltqWjL0f+N
   0j7SZsy3cM+l4NnZ/Dqw7MIwnFi8BpYiR+X8vJkCmVoaMSwS8/rWH/eIx
   w==;
X-CSE-ConnectionGUID: k05wyIoOS+OLL/V5UTw9HA==
X-CSE-MsgGUID: U3m/QnvmThaBykMAk/40nw==
Received: from mail-northcentralusazon11020120.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.120])
  by ob1.hc6817-7.iphmx.com with ESMTP; 24 Nov 2025 09:11:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEVxoxRAEF6v9TDahT7sRFkS815t/LsmNQLaFXqiRibRCUlVq5mo5b3Xzu+9QtGn31BVgWfqeTtt7fOYQvNlOz4isxz5JXXaHlhuxbbSIsFvH3T1vGGtpvy7AhRHaRGUQjlRr0+NFQlt8ij3EW6zmOMRekFu7wx0KjUYBwhYAsX0lhAnLwjhuWB5l63gtCYf9bvJBvboJ+u056iosvyvgIaMElQjPxFDaPWF1zpwIk8RcW/FgZ3YRG9HtvD0SDmyvLRsg2DPaCN4fbOH6QauudpzqO88zjGVrVGug9KmO0gVZY+I7UUPrOqL8yhPmkSZ4iXRZhRi77psrmqsSwd/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFzT66332DLTozpy0DZdRi2sFGT1c2h2sUUFGOOWFds=;
 b=HF6/zRbRJphkATrTURHQccewomA3rZWSVNblblYEEvcSjo5V6NwiR7n1UlrIrQX9Fa+cb6XZ/k43xuyv/a2QMZz4NMTre6NDd5kCXC+8C5Z6szXvyCqz9bt7qAa76ZXv8kO0ICD44KUsFFnZ37wxrt+cbA8D5+PdS0yZi8lq8K2kAaUcLfhZjOtU9Z3X8EFDlUSlGF0EtW3R1ehReK8W+Rm0JunXvP/qtdXJYSVtrXT26AOzMK2WhkpNfAI+8Slpls4bbYJvo2tTwE16iUejzOL+xxoQUcyxbJdQkjGdIYSEoG0I19oG1FGRPJ3l2JPNXR4KZS1i3olEDGZQEWz+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SN7PR16MB5226.namprd16.prod.outlook.com (2603:10b6:806:323::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.17; Mon, 24 Nov 2025 17:10:54 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 17:10:54 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: core: Adjust MDT beyond 2025
Thread-Topic: [PATCH 1/2] mmc: core: Adjust MDT beyond 2025
Thread-Index: AQHcW35SgpMs/8BTY0WYZkolIsn/5LT+iRmAgAOKFyA=
Date: Mon, 24 Nov 2025 17:10:54 +0000
Message-ID:
 <DS1PR16MB6753E92AA334A443DC2A87C1E5D0A@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
 <20251122070442.111690-2-avri.altman@sandisk.com>
 <e9fefbde-3da2-44ad-9003-75b937595d31@rock-chips.com>
In-Reply-To: <e9fefbde-3da2-44ad-9003-75b937595d31@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SN7PR16MB5226:EE_
x-ms-office365-filtering-correlation-id: 838ca4c2-747a-4024-0d08-08de2b7c6d38
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUg0ZEdGajB0bDAvNDhVT0xLbW9FWmI4czE1dW44ZTZJMTZtM3lpQXg0dXZt?=
 =?utf-8?B?SWlSMGdBazZlcXp4Ym55TUZXb1ByVXRHbTBrVDZ5aGtYRjRUc3RGU3ZjRVNl?=
 =?utf-8?B?aG1UUjNRTTZvUENIOEZQajFlVVd0Z3FGdzVLQW9HYm1XbUpKSEIzTURZeS9j?=
 =?utf-8?B?Q2tvSllwUWtRYWdtelRIRmIrZXdMNGcrR0I1MVozZ28rNmwvTEF3LytPNHpG?=
 =?utf-8?B?NStjUHZ1NHNxcHhYRDRBK3Z2Q0NmTkhjTjJHUmo5WXNMZ08wcjFVYWczc056?=
 =?utf-8?B?VUZuZVRWQkhBRktLSm9ZNzNWcnJPMkNwYllZckJtdDlqNlBseDlvdUY4Rysy?=
 =?utf-8?B?b0x1WEpDNDFOU3NLRFl4RUxscjF5WWZaKzMxOWJhdUtXZnBpejE2aGVQRHda?=
 =?utf-8?B?dmVSMFdXc3RoVGl1SnUxRXAvY2o2ZkVUVEs3MlFtOVJZQVAxMVdvV1hjRWpT?=
 =?utf-8?B?eHZTcFdtWXc1V0ZvT2U5WjNYMUVuSWo2UnF0aFlqblBJNDV1TGVGbGNYK21L?=
 =?utf-8?B?RU1xUEYvRkZTbERuNWhxVDdhT2dzckdCTzRENUVRa2tKMWxUQ3BubkYyZldO?=
 =?utf-8?B?M2Z6WXVIMUVxR0RMalZDTEl6U2xSOVBtb3Q5TzVWaEpqMnA0eVk3WndzYmV1?=
 =?utf-8?B?NW9paXJFMytoU0lyY052SkxRcDFra1V5Y3pSS3Z5NnFXUmtRa2k2UGgvQnhI?=
 =?utf-8?B?QWJZaVNmWmZjUTVmdXoxSGphclpKeTVLQU9acUExdUxGQkQ3MkxzSHB0c3Y0?=
 =?utf-8?B?Y3RSc3F3cWkxZjN6KzU2c2VNMkt6SGV2cTdiK05TdmVOdmJ6TkdKa0ZDY1p1?=
 =?utf-8?B?L3phaVg4NEswcTBTcGcySDFqb045VHFCSEtNdklROUozUWNnMitjbndHUnZQ?=
 =?utf-8?B?YWV1U24rdDl3a2hJZ1cyUFUzL0Y0S1l1bEJYZWtxSGYwdGlzeEN6ZzIvaWkx?=
 =?utf-8?B?c2ExbzRpVFpORDUrajNsR0lrdWk1TXRuZER2OE1vWEk4bzhoSmVodXpwWGVi?=
 =?utf-8?B?b0ZNWVFSSGxKWGpnUiszUjd3dmErSU80N1NDUmUzbkVCUEZVbmVJdVZkdmxJ?=
 =?utf-8?B?YWlNMXY1MGd4WktYczJXeEgrVEJsWWVGeXhaVEFJRkkxTjhTdm9RTjlEZmxz?=
 =?utf-8?B?czZDMG1nTGhRZWFRZTlmZ1hWUGNXdmk1Vkc1d3NtY1dQbEVCMFNJYjRGcWNs?=
 =?utf-8?B?dG1Hb1NPUHFyUCtxRnpWNUhSMTNCNGZIK3plNEdUYXJ5Njh4NnFodlNGeDFh?=
 =?utf-8?B?S2xWSmlKV2hSbklDN3ZPL2VwYTRJeUUwL21DbjhKQ3k2c2hIU05FSW1sd0ZW?=
 =?utf-8?B?TUd4eEZ6eFBNejZKRU42bkY1QlA0RzJ1WWtCY0pqSi9CUUJjUDh5RGxkNUZM?=
 =?utf-8?B?V0ZXMjFTZXZtNVZucmlOdFpmdGdtb091Y2Rmck9iWU56eGUrRnZiazhRVlBo?=
 =?utf-8?B?YmtPWldpSGZ5YytUSEJTdmxZN1dld3FsWGhMTUVpRVRoS3FDV1AveTZXbUox?=
 =?utf-8?B?ZlI3OHgvaERWbU5Lb1NXYVVtNzJhb0xIdDducEN6cURLVHBNUXVTdlIxalB0?=
 =?utf-8?B?S3dwVHpkMDFkQWRTaVBodDJFNVZaOXhhVXplUjBFc2w2cjZnczNZOENybWtV?=
 =?utf-8?B?VS85WWRkZWRXNjJZbkFtTjdtbnNDa2lrWkp5UTNnaCsrOE5DZHdnRDZiUWtX?=
 =?utf-8?B?RWROL1pOcmJQeXAwdS84QkpHVndmL3Fma2w2ekRDSVk0eGZCaTZuMEV2STBN?=
 =?utf-8?B?NkFqR1F0b1d3RnRxRUtHSHNaL1hPYkFFNnphYnp6cllZVEJBVlBZcVBKdkFZ?=
 =?utf-8?B?S3dReUdpYnhRdEM5WXA0KzJ1TU9TdTFTNWllR05jMFNVVGxmM2JTZTRnS1Jv?=
 =?utf-8?B?ZzVQcmkxZmRYeWlqWmdrRmJmbDZGVDZMNllvZEFnRVFOa3RuSm1FL2JQayt1?=
 =?utf-8?B?RU9sQm1EWGswaUJqNWVBL1ZlMXlXU1V5VDIwU0FkeklFaGpYdnVJNGtlNHBL?=
 =?utf-8?B?dlVwL0I2N2NOeis5bzFIM1pMQWl6TEpRakNRSU1iZzBNUkdGWEdBKzBTQ1lU?=
 =?utf-8?Q?YSeGX5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXZ6Q2VXMXIySm1JeXA4TjBFbCt3dUkwOW1YRG5pSkVmaTJuRjlQendGVXpH?=
 =?utf-8?B?a2dyODdJRmZZdTNjbnNOWXNxZnpwYUZtaXphNWJmeGlTMSt2bGlRWVB5dGR1?=
 =?utf-8?B?SitPQzBKRDgvK0RTRnY1SVZqRFlOTE56Z2lyTUphb3B1VGVHem12YlB2cEZM?=
 =?utf-8?B?dEREM1N4eE5XN0M5OTZoWTVVeTFKOVhQMmpKN2ZBSW0zRU1YQktqM09yVzZE?=
 =?utf-8?B?OUFONkhwMWJLbDl1bmlOZWlzTkM3Ukljb2d0WjV4WXBnZ0ZpYmh4Y2RxUGM3?=
 =?utf-8?B?SG9saXhOWEwrNmlmZy9uQnhCRVdNOUU1eDZ0UjRmT0NlMzlUa1dsMWVIWEEr?=
 =?utf-8?B?OExKVUpLUEhpYzRMelk4U3RzeXpZVVhsbUNkMjJDaUlNc3ZLLzJnTzQ3aTNw?=
 =?utf-8?B?bk1qUHVnbkpucEpscDRrN01lTGNrY25KRUtjckZrT3pKNHRMcFBFcTdJWWJS?=
 =?utf-8?B?OFYycDU2b2xuYjNCSExqUURaeGt5d2R5eDFBRjFwV1N5Tk1LWDFQUjVrNXNG?=
 =?utf-8?B?ZDNSRVlCQmY4TUNpZTZLb2JSNlp6K3A4Ty91cG45bDE2WEU3N01VZVcrZlVM?=
 =?utf-8?B?d1lMcnpENUJwTkpJR1lkcTdJY2RkMVovZHBMTGUyYVI4VmJNRThld215YUx3?=
 =?utf-8?B?QUVXeFgrOE1LUmdOdWE4ZVJ2OTUwdFM5Qy94UEUwZjJmUDNLSThFeEJJYitM?=
 =?utf-8?B?RWZKNE4yWkJQS1U5L3J1ZGs1M3NhK21uMWdsOTBTZlNxclE4K1VUZVpINm9P?=
 =?utf-8?B?V1BidmJQWkY4MjlyVkJRTU5RZXpFRzdreE1RbkpGL0NKeWszWjNKNER0NDlJ?=
 =?utf-8?B?SlgyendCT1pmOS83ODFSL0NHME1GMnpvYTRHbk5OcTNRRVlhaG5vcGFobWNl?=
 =?utf-8?B?NDR6cERXN1JpLzJCdjZOeTA3UmVMZ2ZBTnRLOG4zNjFvM09GYnR5MnA1eVVt?=
 =?utf-8?B?MTZQYlFvR2Fidjh1MThIcTZmMjJSZDFCTEhhdXg4cnZDSWM1MG1HQnV5YXl4?=
 =?utf-8?B?VWZOVHp3RkpWNjRZN3dSSkhiMEx2SDRYME1adURCdG9WREhhc2RmSDJoK2cv?=
 =?utf-8?B?SzdwOU5ud1hhMkxqWEVtNXN2Myt4RFM3SURDbHJsVnhDZDNHcCtzV0V6dHV1?=
 =?utf-8?B?RzJwVllsaXBMcU5UUW0wazRhNm9UckdFRzFFNExLTmFFakxRMTAybnUwdUF1?=
 =?utf-8?B?QldQZUNja1BMcTJOcjRXR2NIalBIalJVdVMvaUVObnkrRW00WjNKRGU3eDVP?=
 =?utf-8?B?TnZYSEM2UjhmR1djKzJFUGpKRU1hd014WmRTVVRMamQzakd5NlI4bGkvTVNp?=
 =?utf-8?B?QzA4OXNTU05oN052ZE1iTnlRbFkrdHRiOGFpMU1oeUpHd1JDbU5lNVl5K09u?=
 =?utf-8?B?WWNwUUlLQitHQjBFV3A2YVJIUGdnbW9pWEl3TmtVMllDb0VvL2d1NFBmWXph?=
 =?utf-8?B?cU5nY3R5clZSVTB2OGQwMmpBeGJLRUNybGFwOHVRZVUzVTdscjR6aHNoNUly?=
 =?utf-8?B?cTBCNHUzbUM2V2FtT2R0NTd1bndxK0QxUHBLUjRhWDRNaTUyVzFlM3NjNzND?=
 =?utf-8?B?dkhTWTl2OFE2VDNxaHhsMENOZ2M4N1JsWjNBWWs4WGhqbi9IRzcxSnJJZWhT?=
 =?utf-8?B?SXk2Y0w4NmZEQk1yYk9rbDNuKzdFTDNvUlduRHRtYUNENUlLRnQyZVBvWGFC?=
 =?utf-8?B?TkpjQUVCN3RUVi9ZaVlJbXZEejlsNkIvMlh1aGlxc0xuczQvemNsMzNYb1hn?=
 =?utf-8?B?aElPUnFTWXBtWjcrUkQ0d0JuQUxIamJCY1d6L1lWeXV3VUdTbnY5bVhGMTFq?=
 =?utf-8?B?UFh5V1NKVVNvajR3YmVFaXdna3I1dXRpc0FoeUxBbDNta2ZiK2Q0eUNPcVJp?=
 =?utf-8?B?RDcvaTJiZXlaSkNSWS9FZlUyV095NHRIb1JTdDVERVhYZHgxWGoyazdRUHlU?=
 =?utf-8?B?eW1haG55VTNXVVlmNlFLQnE5b1RCaWZDZ09lb25BcHFDdEhJYnJNcTNXa0FL?=
 =?utf-8?B?R0RhN2xKbk4ybEMyeFMrbUExM0w5NG1UYXVRQ2t2bEVCeVFhSTZXMjYxVTFr?=
 =?utf-8?B?Z2QyWXBmMTYvTjBNUzJhOW1qWXk2MndpUW9uMWgyZ1JEcUJoUUEwUStwTHls?=
 =?utf-8?Q?SlSJnxFNzfbY3kjK8n8DVdEBV?=
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
	1dyW5L68sDTlTZarChRTfNpFjY7f0oA7X3g/IuJD6SiuedYlnaogSp6SsrJDKGcnxoSTI/maCePg7AGMr5ZmIfwuFrb4hSRGV5si1DW1NiY7SDx7YpDCPsp2dXYzNL5nlXRl2rQ3sNWUXY2JuH2yjd/dGjMmMF8hMAtO9I4T5sxV3QHV1pcb6KP6UYCHkEVZmeaiKm//xm7E3TeRfGu2T7mV2W85JYtcteXBVme5VnjcJI5V38AwiZ6yVX+VQc8i0sHYmz9wWLzxiLeWX2qikCuLAZVVphpstg005cYyXhjtyl02AoFj8hzvEqkwFktMx3iJ1U4a5mUPrw0zxa+s3+l4oFY+vk2VIUljE0pGRXIfeUGU+KfBq+NpyGHVUKraLrMbRhD0lOJdnrpK5OiyHTBxRg8j4Pao0VIYJ0ILLcgsooW2NTQN86Ax0tM1GOE1zvW0GpIECoOh4mNjEsaiNLSNYjqL3GsLSL7mZgOynr2ODQbcGb31keKIjfAuw2CyW69S379V7IwYmsxCm7XMXUUUiBUPUa6NiSz6biOxj4DQuDkqTx3EqbPRbyFGUePEwnPLYTYC4+XbtMW++n7tOt93RXmNiUBHgRiXSMJtLub299uo1BjX2C2l6+uJBP9nWOqLa0ln5tq8BJ4f1aFUhg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838ca4c2-747a-4024-0d08-08de2b7c6d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 17:10:54.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwpzEUK7zfTOl+IGMFmsZ1uDTFsVjTcayDTZcEd+JPzSV0JR/Ho+SZx74pF0IjB08vBhzBep4aAEFcOO3NlOcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR16MB5226

PiA+ICsgICAgICAgICAgICAgICAgaWYgKGNhcmQtPmV4dF9jc2QucmV2ID49IDkpIHsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgLyogQWRqdXN0IHByb2R1Y3Rpb24gZGF0ZSBhcyBwZXIgSkVE
RUMgSkM2NC4xICovDQo+IA0KPiBHaXZlbiBvdGhlciBjb21tZW50IGluIG1tYyBzdWJzeXN0ZW0g
IHVzZWQgSkVTRDg0LUI0NTEvQjUwL0I1Me+8jHNob3VsZA0KPiB3ZSB1c2UgSkVTRDg0LUI1MUIg
cmVsZWFzZWQgaW4gU2VwdC4gMjAyNSBpbnN0ZWFkPw0KVGhhbmtzLiBXaWxsIGZpeC4NCldvdWxk
IGFwcHJlY2lhdGUgaWYgeW91IGNvdWxkIHRha2UgYSBsb29rIGF0IDIvMiBhcyB3ZWxsLg0KDQpU
aGFua3MsDQpBdnJpDQo=
