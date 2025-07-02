Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8802620E5
	for <linux-mmc@vger.kernel.org>; Wed,  2 Jul 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454328; cv=fail; b=hoAi7RVwbMHkSrmJAKKTqWPKo881JK6gE8bcS7FmC5FaBUwcaZn0WHtslIqQNtT34yinLsLLZFqiSIotenvymBdwWovyhWphY923OymGQzlnT04zy4Fkm4VVE6vsKL5gDHbOrddu1UC/wc6Dvb7ikgk8Gspz4Jx9K22ApFpuduA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454328; c=relaxed/simple;
	bh=1gdenJuN66C+XUBacSd/b9xZybz8ms7bQWQ49vKRA0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTsYb8V5QbsnU/sS32tDPJ1Eq7AoB9sV9N98UeGJNLCwNXnH8367ySfpbEkKl3STeqv4ZfPhAdiRkrxuT9ohm620hWNjgxSYVjwi4QRwo9F/9ZWUaIIISVnO8j6gibX4VtVLHk7I0KCmJLf9NXdCQEMhjwvCVb0he4prKqeykYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=PWdUb3HA; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="PWdUb3HA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1751454326; x=1782990326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1gdenJuN66C+XUBacSd/b9xZybz8ms7bQWQ49vKRA0c=;
  b=PWdUb3HAeUWKZhbscR1cqfYsH3TY7wPR0oWh7gTYUMh9Q8oIy4NNRSJ/
   k7q4zB/wG1SkaAaSkU1W1svO4toJYbdjlaQQRUR9oooUkDBa32n85bTZE
   /EKgjsrWWjXHDJeF6zloIv+uouMckMCZt+XG0xOCYEbnGlZwKW9MUzO05
   UivAuCSeb3vfJiWRP3gZaG9Utl3qwXE8AzdLZRmJG5ptT9iTgaO2aeUX1
   S1G13/CoAvzyJ+sAG6UYvbB8DawjVXe89+BihVDym1MtBd5/2leQzZtca
   2wnG/oTkQbZAcEmF9o/bHrWtpxYhhBlU9SB7Mk4n62baXeKfYiwe4py2B
   Q==;
X-CSE-ConnectionGUID: Fo0nDc3MSPu3C3XBfc9nCg==
X-CSE-MsgGUID: ufwi6mOWTMKTDbSw1jKfag==
Received: from mail-mw2nam12on2100.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.100])
  by ob1.hc6817-7.iphmx.com with ESMTP; 02 Jul 2025 04:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mu/ta9cknC8LVDgZsLuKRcXZ8aVJy2rAs9koVc7/6+McI1ZOxW3uplhUMJtfBH51cx7pZTjLrWuTSNg7C4rs0ea+qkkel0JJHlippcKMX2ttXFPJXMHhYG9M431OSaiaLCOcgplD9/zZokUUH4fgY9BJk6r71CL4pvvCcPjqCRG+P5t/4jkN38HOHLppzjtvexwpmm7+Kjr+D5mrXDTf9CnMotdnopOIOpepooF15CRgyuQA8muITfGqWuGX0RW3JmmHZEkm1QmrBjPuUSjH4d1l1BaWDOyS1+OYXKFWz+avWV34UdJztxWs57pft+iyCnKoHAvo42J6L1A20H4Z8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gdenJuN66C+XUBacSd/b9xZybz8ms7bQWQ49vKRA0c=;
 b=h3oIEyXriOTfxYWcp0dTiUXSkPegQwl5nOrnhDlHzSKwxt6ei5uS1xmamCH6aLI278hGiaWEH+Aa+e90UaGlx2aOMIeLZyDo3gk24yEaxGwIAjrshmKYa22zHVYaoUOoO7q2+EX/qMZoAdGBpJuf9mqP++qySynMxHHoWuIqi57xS7hGEzUsg5lHDwXnANlt7djoOrTkp7QdaOv0cpdTBEEFYmbWL36abjToubs7btXncDWgxLnd4+4RAg8ULud4s8Xndu/EMRkjGluBUJbx4Z78G1nqZ6tUrAlxP1G5nBwjoc+HiLRMSSSmWFh6gjtXC4NNn/Nmoypag8Qoc1/NDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SA6PR16MB6586.namprd16.prod.outlook.com (2603:10b6:806:410::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 11:05:17 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::5975:403:10ae:a379]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::5975:403:10ae:a379%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 11:05:17 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: mmc-utils: Remove unnecessary null pointer checks
Thread-Topic: mmc-utils: Remove unnecessary null pointer checks
Thread-Index: AQHb6yqjRJW9GOOoXESDea6vxsWjsrQeq+wg
Date: Wed, 2 Jul 2025 11:05:17 +0000
Message-ID:
 <PH7PR16MB6196F505DC6D16DAACB67C31E540A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <c89ce826-7ff4-4d02-9c15-7f61c157003c@web.de>
 <a2c129b6-1d40-4dac-a585-097aba30cc67@web.de>
In-Reply-To: <a2c129b6-1d40-4dac-a585-097aba30cc67@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SA6PR16MB6586:EE_
x-ms-office365-filtering-correlation-id: 4182f3d8-46cd-4d30-24e7-08ddb95853e6
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3ZGaDVER1RLbFI3SWI3eUJNSHVuUGNFVWVFQ0RwZUdXZVliL1ZXUjBxQXdt?=
 =?utf-8?B?K0pUckJpdDVCWHBTQmMrelg2UGtQWiswWFNHbmdqSmhjOFhQODlYWXVncURG?=
 =?utf-8?B?NGRXNitGUVFab2RZTFVNaGRlS3daTyt6T0FMRXEyS1B5N0ZXZWtpZzhLN3lw?=
 =?utf-8?B?WkdJaThnQ0dObDVCUE5qSHorRTRFQUx2d1djTHJoeTFDVlRyU3JDeUJFYnpu?=
 =?utf-8?B?a3JsMmxrNGJMU203Y2NjeEU5d1g5RVpDNXNRQ0JQSGZUZUVoZkMvOSttekNP?=
 =?utf-8?B?WXdnMTZkZXlNY3BidUNjVUNtbHVJb2gvcm1wRUIweVNKSGhSSk93Nkl0YXc5?=
 =?utf-8?B?UGFtbkFVT2s4S2FJek42WTBGajJXQjZWYjVkTDdSMUVmTW5xRm1MeUp2YnVQ?=
 =?utf-8?B?TFpOVW1iUW1vaFg3bW50N0p2UnlkUmp5RXEzQ1BFR2s3MzhIdHNyVC80TXlP?=
 =?utf-8?B?V3FLc0dEVEM1MHlJSlc2Y0xLTkIyajBUZENaWXVvRVFjcDFUTkNMSHVEMmJj?=
 =?utf-8?B?Y1pIbVU5UGtKaWFMR2trTWw3YVFPQ0RWcExYY25EUmNWeVR4bVNzUllDWjlQ?=
 =?utf-8?B?cm5RN1Q1ejVpWjFaZnRRRVN3R3lvVU1GREx4bTVkYnlvTytibW0yVy93MTRq?=
 =?utf-8?B?RTB6K1dOTnhFL3p3M1prczM3UU9WT2dqMHhmb2JxQ3ZhaStJQjNCS3NEelFP?=
 =?utf-8?B?ckVUbmlQRXJMUG95QThwZHEreDFuUEM0N09pbk5saGJFRWpjWHF2TU8zTGRT?=
 =?utf-8?B?L3AyM2k2R1l1SDd2b29zOWV5RnVFN1hKdDRmU1Z1bVQ5Zkc5VEFiSmI5Y1ZN?=
 =?utf-8?B?bTMwK2l4Y09OWEFBaUoxUmRpMkZOblRMSDA4SXFSSFB1ZEpaK1ZpblFVcmdR?=
 =?utf-8?B?bUMzMEN3elZZQWtWdVpQejF4VXhOcEZwQllDVm5DOUJXTE9haEJBN1Y1dC8z?=
 =?utf-8?B?R0lkL0FSUXJpS1Z6T2NmajdkWmoxeXRwNFdwbEFxa1lvaGYvaHF1KzBGOEIx?=
 =?utf-8?B?Y1RUUm4wWkJJL0N3M0tBWEEvSmp1cktTWWluZDQvd3ZTbFNHaENMaGsvcmZ1?=
 =?utf-8?B?T1AycjM5aEQxOEZDcmdMdVptM2Rzc3pndWJNM2JxM0FxTW5mdURTeEZrbzB4?=
 =?utf-8?B?WFBSRVcrbmlCNm5WeVIrYysrc1pEMTh0YkFKWVpqcXZUaXR2VG8yZU5uVFE4?=
 =?utf-8?B?RC9hSWhXeUpBVWw2d1ozdDFRVU12MWFnTUxCbmkxSVlUUTk0RHpGZTlMOVlW?=
 =?utf-8?B?aDJEYzg5WFJqNlhpSVlCcE9FSWpvaFp3WHVnZ2NVRlJLcUh1WFpRNjNvdW5r?=
 =?utf-8?B?cVZoNnEvQS85V0IyWSswSTcvS2VvaTJpY2FQeFQxOXBiRFo3VzNRa3RHL0J5?=
 =?utf-8?B?M2U1YzQ3My9OdHZVbS9RYXJyR0l4ZHFYdDh4UXA0czBGYlBac3ZVODFVSXUz?=
 =?utf-8?B?ek5UNWJveGU5UXJWL25mOWRhM0NnVWw2dUVNeFVjOGhxSHRUUFlkc3EvaWtH?=
 =?utf-8?B?ZUFsV3A3WEFxOFZ2UTlNai81TDlrWUJnQ3ducEhpZmRESmltaDdOTXZSZVhF?=
 =?utf-8?B?dnMxVVNJdFlKRytVN29ZQUJXbGhCbjRjcWNmdTNld3BrdEtITFBBeE5qSmU5?=
 =?utf-8?B?TzhwekNNYWhoRUVlNEdpUkZQdHBBcG5ST3AvUGFFN1V6WW5qMUtySTN0KzZ5?=
 =?utf-8?B?RHQrN3FwZVJTdFBYTVpxSTB0bUFOQ0lZekxRQ2JkRTY0RTJPWTljUGNzK2pG?=
 =?utf-8?B?M2tBL2FVNnBpQjU3SzU4M2J5QmIyVzc2dy94OVl6WnBsSFpKeTByUVZ5SDV4?=
 =?utf-8?B?ZWtqRlBwQWtuMk8wZ2ZXWWhlOTZIRld3U0VybmdKQUJvbkNtTmtpaVNiK2t3?=
 =?utf-8?B?TFA2ZFJNUnZhUjZscWsxUUhTeFNlQnA2ZVppZkVFcklyTE9zUUlzSUhCVFR2?=
 =?utf-8?B?TVphdHlKRzBnaTllSll5dm4zUmFyd0xtN3FDUWlTOWFxZ0VkKy9xaEI0T1pX?=
 =?utf-8?Q?/71mD7TfX3qFtUOy/TvIvgbcJYLlWU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjhsT1J2M3dhR0VqWEtlZGZydy9LakpyUW9yQ1lQVG5jU1VYQ3UwQ1dKeE9r?=
 =?utf-8?B?TlduL2c0d2lUenVLLzBMYjgzSHBoS24wUkRtdm5mMk1tUG5VVkk4QUhRU2NB?=
 =?utf-8?B?cThCRzNodEUyWHdZTVFmMU1US3RhU2JrYXRyaFVmUmtraXhXVSsxaU1mTUxj?=
 =?utf-8?B?Si90SjJSZEljdzJ6MUhXUWFncEwyYk93SjFmbHJTaHkvK2V1aVcxUG5HVnEy?=
 =?utf-8?B?RGFoSzIycC8yZHc2ald3YmkvV0xHQXoxTUhXNXZhTGdHcnZ3R3NnRithMnow?=
 =?utf-8?B?YUdUbnJNdmxmUnVUQXNGSHpvVmozaDh4MEJZK0JVUTRVUUtDTUFXeVRvcVQ4?=
 =?utf-8?B?REZlbDVjZUtwVHI5blJWUkZmUGxJZXZDTVZHNVJDVVNCUDF1UVFoWjNnVk9u?=
 =?utf-8?B?NWt1UWp2blVVbStPU2dqeVNzcFJxRjlpVFJDNSt1QVZ2d3c3YjRXZnFWQVJM?=
 =?utf-8?B?OTVNTmp3VXpGNlE1cnROKzNFdWFwN2tOYlNMUzhFUjdSYVg0OXQ5VG5sRENz?=
 =?utf-8?B?OWl2TElDNGlIcGVJb2haS2h6SjVCa3ZaYkgwRVBlMnRuZjhUUndZc05SSHRr?=
 =?utf-8?B?aFd1SWlMcUdydTg1c0d4UjV0YlpDdU5ibEFGTEc0UGttSXNLcmZaOW1EelRD?=
 =?utf-8?B?eG56VlVLVlRyVWp6N1Y3U2kyVTI1dFNYNEo3ZHpwSm9IamJOaUI4eFpQMkdQ?=
 =?utf-8?B?QkFzMWJrNTU3MGQrOElJQzYyMHZuNDBZVEl1S1JMWUJJa0pFUEF1aW4zRmFK?=
 =?utf-8?B?blZaN1BaR0FhUUFDQUZ1U1pvRzJwRllUSFpJb01RUUsvUDVoUXlmcWVoejRj?=
 =?utf-8?B?Z1E1MktFaUtXS21iSmlIYXhvUnVmZk9MS0o1SHMrd2xIUTdFVy9nK1lIRVNp?=
 =?utf-8?B?WWpyRVc2ak9yci9la2MxbGZ4SzdoUWFBWXhRRWdMSXJUR1V6Yk42TS9tUHpy?=
 =?utf-8?B?WXRGbkxPU1V4UkdUZEk0clVtOThDRkJHZG1XMUdWV0VGODR3UFVHYnpJWTdx?=
 =?utf-8?B?SlZsWGZYckJqTXpkbkwyUGxuejYvYStEM2tuY2tKbStoUjA2MXNZNGNIUWpz?=
 =?utf-8?B?TVdhT0toZ1M4WmlDWTVRSWtPRDhSWTBod01saXJwUmdCR1hWUVcrZnJOMU4x?=
 =?utf-8?B?RGwxN2RBcXhpem9oRE1JK1RUTlc1ZE9zckxQQUZ0STgwbEpQS0JJQXpsMWNo?=
 =?utf-8?B?N0R2anlqQm1RQkowVjhLbGF1UnI1WEdUYnRLSnlSZnM5bnlCNTlHZHpraC9x?=
 =?utf-8?B?U016Vml5eGxVT0VpUE1LQmI0S2RCSUlDbEdCc0VEMnpTZUpzTUo0R1Z0d0hu?=
 =?utf-8?B?MFBrNFhpREJZZGdOTElnS2VmK0YweTdFR3VrbXFpVmxEVjR6VG5HWDVvZHo3?=
 =?utf-8?B?bWxmaHFlcWFZV1l6OVM4OVlDaitabEVjbDZyYlRCRUUxL29PYVMwWHVpRi9v?=
 =?utf-8?B?ajBYWEJBUEN1NmdoQjhwMWdQeldKVlUrWU5NdzJJT0ZOaVV3c2UvNUNnNzg3?=
 =?utf-8?B?UnlESFpFaDBIV1JVcWJwQkEvRDNOUVZXcWZOaFo1VmU2RFhkZ1lNdEFETXFB?=
 =?utf-8?B?Kzg3SXROWTR2bHVURWR1RVVBM3NYTkRlbzg2R0d2Wng5ZjJraVZvdnFYYWVz?=
 =?utf-8?B?TEx3NmNJcXlmdk5ST1VkQXUvTjJGWTl4VGFKWm41OXk4QUVwY20xVldISXlZ?=
 =?utf-8?B?QWhDNFNjYTBsQVJ5aEJiVW1PVHB0MU12anYwbzdHRlQ4cWxENzJxd0pCSW9X?=
 =?utf-8?B?Z0l4S3pEOWQzalJkZVg1TnNKd0dINDRNVS8vNGNkTzRpWEpWdFVib0I0V055?=
 =?utf-8?B?VFlCR0t6dFBzaWorVHVMdlRuZjZxaDVPYTdndkRqaEdjTXFya2N6RXdhU29k?=
 =?utf-8?B?SWRFekFZNDNHNUhuVWQ4Qk91TWdnd3Fta2RISHJNM0p4ZjUzeTF5dThnV1NS?=
 =?utf-8?B?ODREbDNER1JiZHM4WXprblh2cm1mQ3FpNnkwbGxMWHpOdWlkdFlqdzY4ZDZs?=
 =?utf-8?B?elIybkRuNWIrbnNnK1BUYVN6MFF4Sk5rYURKZTdCSHIzYng5aE1YU1V3YkZL?=
 =?utf-8?B?Tld2RnQ4eE8rZmZKSkxRVUFIQ1BPZi9ZV0pod2JsaitpNHFySWtMTjcvVEVn?=
 =?utf-8?Q?4llLmpf3HLLtgUZWsGBQCKmDs?=
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
	sn7z8KDWVbHjDJKI+KhMEcRRWjvtRr/1yfdVpktPSPbWoHtS9srw8YeDy0QZnb9QnKY5kRMIavryP+ZjLQEEESyDOS5U4uHybdBfsHNggJy/l3QajJnBg6hYwTnOQyuTFRj5ZUu6IvDjyQLQTx6eWfTawbQTBtzXj965oDqirL2tldP8ysOmnOt7R5MDGs8jmQUaioQcNj/xcDREmJTrp/89MAJd9WZ6iTOZHjuSX9kclK45dsU4Iua88/FLP0Q5/u+delc5vW9WTg5ioBVBJ7RaRo56tDXKX6w56NGkMZpEzwT0ipTs6xZSy8fSDsNKpdw+JBXuhgX1DSMrI4dlbFH5FLyrKHMylZB09Fm+Wz051DiDTp820zNR+CQ2JwcU5dns26vrBdghpGPKq0EnYmwdRAtr2kSGW3RJ29kfZxZWxohYGXuD4CsBrpFAvr4176776ca5ALcom2IOPkSt7KXOctRTqNQt/z5d5Nv9tK+XW/T7cv7kHvofjGfPsvQbZRN0edbxXHhv80MD7TuaeObqNLNDy1NG6lEkH4Ag6qW4Epl3O5kXk89AN18f3qTPTruyZiDHN8jgZjdvFYcRs1mvftSksxnZaoK5LIF8B0/I6OzIkZa6Y6HhYGr9NDzI9Gid9SWSkQUq0jKo+or+HQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4182f3d8-46cd-4d30-24e7-08ddb95853e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 11:05:17.2130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++wyAmVvO3dA3NUkxispXCqUeLrqupMVjicQnufZOPU/tJ60cvaWTNY5ov3dKh9zvNpK3BwJat+YzIP//b5qcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR16MB6586

PiA+IGh0dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vcXVlc3Rpb25zLzE4Nzc1NjA4L2ZyZWUtYS1u
dWxsLXBvaW50ZXItYW55d2ENCj4gPiB5LW9yLWNoZWNrLWZpcnN0DQo+IA0KPiBJIGFtIGN1cmlv
dXMgaWYgYW5vdGhlciBzb2Z0d2FyZSBkZXZlbG9wZXIgKGJlc2lkZXMgbWUpIGNhbiBnZXQgaW50
byB0aGUgbW9vZA0KPiB0byBhcHBseSBhIGNvcnJlc3BvbmRpbmcgdXBkYXRlIHN1Z2dlc3Rpb24g
d2hpY2ggY291bGQgYmUgZ2VuZXJhdGVkIGJ5IHRoZQ0KPiBzb2Z0d2FyZSDigJxDb2NjaW5lbGxl
4oCdLg0KPiBodHRwczovL2NvY2NpbmVsbGUuZ2l0bGFicGFnZXMuaW5yaWEuZnIvd2Vic2l0ZS8N
Cj4gDQo+IEBSZW1vdmVfdW5uZWNlc3NhcnlfcG9pbnRlcl9jaGVja3NADQo+IGV4cHJlc3Npb24g
eDsNCj4gQEANCj4gLWlmIChcKHggIT0gMCBcfCB4ICE9IE5VTExcKSkNCj4gICAgIGZyZWUoeCk7
DQpTdXJlIC0gSSdsbCBzZW5kIGl0Lg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IA0KPiBSZWdh
cmRzLA0KPiBNYXJrdXMNCg==
