Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E49258EFB
	for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2025 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764222620; cv=fail; b=j/y/yqajJcPaHkEEAKdJEIwin2eDoEQmvPDR9XN4yhGQ+/G09Wmav9OOc/sg6fveCzoRCCOOW8ukHXAPNphGNFrioDdwhcB8vADhjcKkkJ7Dws5JGUkSVaOAGa7FXmWVnwE4cNNTMsVeEtkxC0C4ao51VTXLzctCm359hiEtJtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764222620; c=relaxed/simple;
	bh=IANVGrycgwOpCBe3t5gEZYvpZhBqdjBmssAEviknv3U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ORFEPiZV6LMLD/F5S/pzNXIMBV/6bn2YRhymhYFvCgjbJ9RNytFNDPNtlr7T2rNxMVczwSr1dLGpktZzs/BOZxxWNJLVuBP/cRr8SKicU9YiUzAXtREhU4KB3PeECbq7AFigSia6tsh9B+qbSK/JngOHKOryMg5yUeQ4KxDBFTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=sA6Ne9sX; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="sA6Ne9sX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1764222618; x=1795758618;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=IANVGrycgwOpCBe3t5gEZYvpZhBqdjBmssAEviknv3U=;
  b=sA6Ne9sXNDI2szdF3H7MKA/dCCYyhzlWCs2/gVBWfK+GoDMYWxfaQegT
   yjtCYmrIl6oTWeHS6SxsXS1ma/uP45T1jnQBh/COcVzvDzI2kQDoqzrDP
   xPG2x+w2WMGJjGqzrT7ab1/rbw9n32DNBHEEybdrB7222afUoCledGGT7
   NP/0qbCG8Az+JiFB+yn1bO/7eCqCsBtHyETlamk9a7d9JL2J/MGSk+gnl
   6XPGHwMr8x9Q4qgUG9ywafoabifwzORadO6tb+t5NdHJel/swSQse7cBd
   DK/Ice5EOTbYUdBNtpeGyMiYC1guyeDaPuFjMXwA5OHFc4i/WsVGGoFM+
   w==;
X-CSE-ConnectionGUID: 8d/FeZs6Roy3fzIEtW034w==
X-CSE-MsgGUID: OwWvqV/VRQ67vtoL4DgByA==
Received: from mail-eastusazon11022099.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.99])
  by ob1.hc6817-7.iphmx.com with ESMTP; 26 Nov 2025 21:50:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQJRF1bsOkcslCKupjlkydUxr96VZgBks5V7DR0btDEgLibDTFA7sUQtAr36SoEvcHOWHnC+aHN+NZ4o5lbS6JWEWycBKuxtrA3rdwMHFT+pyC1i44BVf7P202MCTOp4hZL7+uQZACTDj+uxDS3CE9lOxM6ZARTsg/QRQCAZxrvm2hRJAEMlBIUOLlgmXFX4jz03Mh92xEBpFMmBdQR4RAps2JE0GrfeN+Av1xeZf+XjrY1i8jbx1TXYT2ASNZwy0hoGhKyDzmoRgPy3kDQrxVsA+EJ1altWomU5S5DsexP9ETUHyXIgjmGBVRaeRiBEqboye9kH/sfwz66CtQqIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IANVGrycgwOpCBe3t5gEZYvpZhBqdjBmssAEviknv3U=;
 b=Q3f+tapfXsb6F/C9TvKEJgsOG6uxOu/tBMGVX5WVtFOwcDliYtFjwjUfrnSqQlZloXDJPiq7H06VJ1ampeIQHwtk6vy+VcGhP1MN1Rv64WzWFcRtC3v0JFEn2vgNJZq4d6k6GdrzAWgiIznX0dpRuPyuUqj2hygA5oczH5AwKdMn4ParNQeZ9f3QB62+6dFDubnPA55hKdrNJ7Ywgk6SL8VPVTULJuH14uxmJQVXdraB71s5aPwrEumQQ9ir3xG4lWMwaNeF3547yw+10Kx0GC1Gm6huSXpzArnRkrRA3GNXBJVryS8GhbidsVX1CToOPLi1ndJuXROQoopw2W9Urg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 CO6PR16MB4033.namprd16.prod.outlook.com (2603:10b6:303:af::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.11; Thu, 27 Nov 2025 05:50:09 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 05:50:09 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Bean Huo <huobean@gmail.com>, Avri Altman <avri.altman@gmail.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
Thread-Topic: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
Thread-Index: AQHcW35Y+KUsWivi60iGUFRu2uMWZbUDatwAgAAJ0WCAAg92gIAAh8eQ
Date: Thu, 27 Nov 2025 05:50:09 +0000
Message-ID:
 <DS1PR16MB6753F7367E14F8EDD5602DE8E5DFA@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
	 <20251122070442.111690-3-avri.altman@sandisk.com>
	 <4a9236e8a4172437874291da221ef8b82d4a1126.camel@gmail.com>
	 <DS1PR16MB6753397C1F5EF5804509D39EE5D1A@DS1PR16MB6753.namprd16.prod.outlook.com>
 <a05f579671751c47cfafa7ada6ba631261b7c598.camel@gmail.com>
In-Reply-To: <a05f579671751c47cfafa7ada6ba631261b7c598.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|CO6PR16MB4033:EE_
x-ms-office365-filtering-correlation-id: c88ac275-0020-4bb7-5c65-08de2d78d319
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGJvbEFCZ3VkazlDUkwvVGZKeWR2WWxjcVltcjVqWGdDbHVZdkJDYnF2R1pt?=
 =?utf-8?B?MzYxbHpRQWowdlRKSVRtWWJNeEdIY0ludTU1SGlXQ08xOHNqdG91OEwvVDVQ?=
 =?utf-8?B?bUJKMEZKVThPVEpLNkVqUGltUTJhOCt2cFFNZ01uWWRzODFqTFlZUnVkcjVG?=
 =?utf-8?B?NkJ6ZTNZRmxrNHZ3SDVuMVlMYU1kLzBwT2FkQ2JBYzQrR3YyY1dMTjRJZ0xT?=
 =?utf-8?B?MUN6TXgvbHVqOTFSdjRvR0VzWW9meUM4UXVWNkM3Qmg5cFVVNTBVVnlCZTEw?=
 =?utf-8?B?S01tM0tua3ZnR3pwRnE3alNnZDBKcnFqNlY2ZzFTWUpBN21OS29qUEpDWnBo?=
 =?utf-8?B?RWlPc1hVYmJ5ZllYcTZUOHNpNU92amNuRmpiOFlpbmQ0aFl1amVKYk9ySm55?=
 =?utf-8?B?UkMzNXNYUnVaUzBVSFhwZTJPdkQwM3p6eWVLeEdhODM5NTR6UzE2Y2dpNEVH?=
 =?utf-8?B?WXpxdXRwWktHSW9LRzZwZ3RWR1dYNThLUnl0ZFJuODA0UkJtL2twUWxBdlRz?=
 =?utf-8?B?L3lST1JSWmpvbjFjMWVRSml3VklKZ1FabU03VzNVWG9GYWRDN0VNZGtDblU5?=
 =?utf-8?B?THBCMytpRGdKNWZ5SjRoOWhSdE10U2JnNWJHbnNDZGxXeVJJRDYxRTdrblpH?=
 =?utf-8?B?SnZSZ3FlR2VDRUVrbTIyRmRFVmx1WjZGVXcxR0VlMzBHbitOc2JzWTlGdHdH?=
 =?utf-8?B?M21TeDJCSkpqV2ZCbHRUYTROSXVtZkNDeDdBMDE3TThVK3lvRE1KUWMxdEFI?=
 =?utf-8?B?MjZTUlBvK1VycDJYZ3YvWGltbFU1Y0NrbFRxejFKNXQ2N2ZTNTVSOXBlOGVE?=
 =?utf-8?B?S0JsdzZ2cjMzRWlvdklpcFVWOVUycjdVUDFibFVHWlZRSUxHR0RqMzNsQVhH?=
 =?utf-8?B?bGRlZjF1aWN3LzV6NE8rK084NmRsOG1CUitsd01yM2dWLzlLQmJqc1dFV09v?=
 =?utf-8?B?TmdWZWx2NzA5Q3EwNk1oQzJRM0RlOFRYZER4R0EwNTZjdEVmcG5rcEg3TWVu?=
 =?utf-8?B?c29hYy8wVndXSk52QkNWVElQRW16SHo3UlJzVnQ5dGNTVHpoeUlCdFI1OG1X?=
 =?utf-8?B?dk1kZUVPSTVEVUJjbThSV2w5czdMdG1RSjAyS0NpL042MTNqRC9keEpnWXE4?=
 =?utf-8?B?Q3ZpejhDM0Y3aE9EOS9jYkhNbGQ2R1V1NmZ0UlVyL2lmMDlUOGZnMWF0SlFy?=
 =?utf-8?B?WUN1UGZqOTVYK1lrbVFMTzR1QVVpTFprazRYbHlEbDlMMXNUMUhYazlOWUoy?=
 =?utf-8?B?QVBUaENmWUhkbWpqZFdRVThSK1FtMkY3SDl0dG5iT2c5SzBhMVQ5Mk0zTTFG?=
 =?utf-8?B?RlJROUdQaEwxb2FUTkRJa0RFVDhDWGFqOVZnUEo5eW5HbHRUYkN0Ym1VTW8z?=
 =?utf-8?B?aEJTUUdtYy9YVEQ3ZmpjOGdMR2thYlBJK2hYNXdtRWJUN3Q2cyt2bzkxdXZ0?=
 =?utf-8?B?Q3BDSkpJT2lIYzRCcWd6TnVKZVlNMWxNaEtqUFR4NXZGM0F3SU51SGh5YlhW?=
 =?utf-8?B?NlRDK1NMMHVjWk9RT0lMZ29wN3h6N1ZFOTQyK28ybXpETDJOVTFRcDhJdzd5?=
 =?utf-8?B?MTFLZWRXeGVpeEdVUCs4WGJ1S1BsWFpvWFQ3YVZIaC9aYmpGVE9HOE9BT2xq?=
 =?utf-8?B?c1ZOYWNTK2RWc0VUVEYvK24yUGlmVmJ1SmZ6WWlTWGZXamZPbmJnbjB3dVBM?=
 =?utf-8?B?dTJvSWo5aDk5Umt3UFhTQWIwVG5PQndQSjhoMmhhMzNmRXByZG1lajBPVlVE?=
 =?utf-8?B?c2hUQzB3VzY0Q0VVZEEvOHl0eDVqUVIrODBQaWNwQkxEK0MzWWNITml3MHJC?=
 =?utf-8?B?cStyRjdtV3p5SGtjQWk0enJkZk1yYWNyYUxRZ09LOThrVFA2ZUdKcSsySXZ1?=
 =?utf-8?B?dDVjQmtreTRTR2VFbTVMdUpYRDNoRlk4SlQyK2xxaXNETUtsZEkyb3NoL0pa?=
 =?utf-8?B?ZjZQS3c3WjdXUlNKRkhQcEhIL3RSOU1ydWYrNDlFNTlsdXAzdytUcHpqV05F?=
 =?utf-8?B?UGdzb2NueVk2UlNOaG45SEczckc0a3YrRkFVdUZTcTh2d3hOa2xPdEtGbisy?=
 =?utf-8?Q?vMZm0K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEZCcTdoRzlQSDdvR0wxeGtEREE5KzRsS0UxQ0F2emlSbTBPYmpoY0ozUU40?=
 =?utf-8?B?a0UzM095SU9rVG5TNi8vanVKWlRKNnZXM3dKcHg4OFFNY3FoSVdERm1WUFlp?=
 =?utf-8?B?Vi9pZHN3dWI2a2RrWmt6anlzdCtlK1FaZ253NFlvUXpRU0NHc0J4SEJzbHAv?=
 =?utf-8?B?enQ0b3haZzlGaDUzVzFXU1d3RTBTNlJiakpHV1ZRcllSZHFwckNlVzBxdmp2?=
 =?utf-8?B?LzhObFRQR1NnaitSZzk2Q2hjaHdYZThHaHBFMWlpejVMMW14bDI1Y2xwd2Z3?=
 =?utf-8?B?YmhoYjVqT1Z5bzRWd1lydW5UeWtONkVhR3RaK2xpL1QxT3ZXcmlHZ0xaa3VV?=
 =?utf-8?B?UXlhRFZCeFVYWHpQWkVISEhwU1lCNXZVdnRPRUFpRUxUN0tBaHR6NVRtMEk1?=
 =?utf-8?B?aW1oQlJMM0wwQ2xmZGtVWnF3V01HdmUzTEJ3U056OVpLT1NqV0xsVm14d0Fz?=
 =?utf-8?B?UEM4ejRxRFpndGh3a2ZzL0drMW9kcWRwS0RYMVY2b3J0OUlzb0ZkdXlpSmJx?=
 =?utf-8?B?THBiTmZsSWw3VjZkdHZYSGYrNTIrajFKZ1pseGNwTGtzTGliV0Vmemx5N3V6?=
 =?utf-8?B?K00zTnF5SjZHbkRUWHd3NmY2cWFqRXBwejBHYVEyTE9XVU9ZU0pKRjBmL0Z4?=
 =?utf-8?B?ckxPTzZQNVdmQzBxaS8rS3AycDJGQXRCb2x3UVNidFBsRGh4cnVCNDQzcXBY?=
 =?utf-8?B?ekNPVDNUbmoxS0xSdVlUU2hTUXJJcExCVGtCN005UjBZMzMwby9aY2sveXVr?=
 =?utf-8?B?NEJIVTVFdFU3bjJleUVkWFI1L3dKM1ZzSjlHdkFmc3BWMWJIMG50S3pkdUZl?=
 =?utf-8?B?Nkp5VEg1U3BPT3M2T0hrNmEycUpDMjFsMndPczN5bzFycVNRQ2hlb1EwR0tG?=
 =?utf-8?B?K3pFaStSc0k1ellpS1FVbDhVeDhQRWxzN1hnSWg5MGV3bk93U3Y2MVltbzgy?=
 =?utf-8?B?YllRai9ObVRITWZCQUFWWDJSNG9nVHhtQWtyUkZsSnBQSDlya0dieTA4dWVW?=
 =?utf-8?B?ZVp3UkI2cUQvQXdwUU5rRGdHTVNmTjhRcmQ0RG9OWWpuSGsrKzFIY0JuU2Nu?=
 =?utf-8?B?U1U1bW9XOGw5R2xxc3MzRVovaVlBOFFyOVVkK0ZpWEw1dGtvcnRyZVliTjFQ?=
 =?utf-8?B?d3dQbzhBMjRhSW5vWncwTElJelloOFFFMWhFTzVFTURLTEo2YUFKakcwd2xj?=
 =?utf-8?B?eFp2dHdwR0d5U3VOeWpVOXNZaHIwaHR5bHFUTTRyd3QyZE5udjluK2plRmph?=
 =?utf-8?B?UFdoLzd2eWI4UjJXNnBraUJLWTJtOFBTU2NLSWtrbE43aFhtV0RxdGN4MHV5?=
 =?utf-8?B?aWQ5ZUNKNHNDRTdUM3RLeG02TzNZUmZJQk9iZkpXM3p1N0JPTWJtWnpKUlND?=
 =?utf-8?B?ZTdGNTJjdndKZ3Blb3B4dnlIb3J3NE56RXBGM2JaUmdkUllhMnB3VitYMEdS?=
 =?utf-8?B?Q0dzT256VFVrT0JRWVdKclZPZHVFSDE0TjhaaXBvQU9BWU16TWMraVA3ZW1C?=
 =?utf-8?B?b05US0VXNDdobWYvNVhTdEVndzlyNC8xU3FHdEVvb1hqN0V2OHNHNmFFV0VQ?=
 =?utf-8?B?b0lialg3QkZsRGQzWUZia3cyYU1YbmwvRFJiKzM5WDY1ZEltWE5VQ0FJdlg0?=
 =?utf-8?B?MFlTdmhkV0RFeUUyNUQxcndhaVpQYlcwWWlyY1dCeXhyK0t6SDRTc1Q5Z2xv?=
 =?utf-8?B?bE52OUMyVGp2RUdpeVdMYXVzOGhMcFBVVUl1MXJEVCtEdjZmUmY2aWJVa0dO?=
 =?utf-8?B?UnRpZllYVEZPOUhHcFhxUGR4THpIU2xEamJQaEZxaXhHcHJMRkpFM0xJdnpx?=
 =?utf-8?B?Z0hDMGYrSmQwZ3J6YWM2UXVWNGdwZkV5ak8wL2crbGQ4bDYvOTNBWm9KVUZz?=
 =?utf-8?B?TmlKZDNTVmJCMktDN0hmUnJ2WktXL2IzMlc5dFp1anB0UjRkcnU0SGZIMmF2?=
 =?utf-8?B?aTJuZlhGT29laXltZHhlRGkzVmZLVDZFMVpTVTF4Rk1XdEFJU2QyamgyVWxx?=
 =?utf-8?B?RDlBT1RzUDdMSXJaSkx4U0h6RkZkSDd6R1BNUGVHbStsNkdBZ2xwb0hWZ3k3?=
 =?utf-8?B?ZUJ0RGFTdXVGWjNBUS9td3BHTG54WDUzUTJobnpBUTJaVUxBSnRGSUZRSHlv?=
 =?utf-8?Q?Vn7OX+fiazf6gWjSwiBceMT10?=
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
	Ir+RmFJSgEekmHNwfcf1+inzQeLCnFoNsH18O3YdId8QMr/H9JS42C/XoCcbeCdZT51wqX8i+HMroKHp+Zkv8kOOcgf/i3VQ2Sx8Goj65Fuwu9ThbKaQEQbbWglrrGPYIJiZNA4erFISAT83bc2W6A7tFW9/kKwdlHqCXUTB6ArJaoW8Ab+7w7KrV+ceUKjYFeRpayhaNNfzTiELSloP7wyoWC1HWLu7rzcBOJ2mqFUJ9UsDN5RMUkzY/uLaYEqwNg2dYamL/I9g44V81QYJ2vDiXE44NtcNyYuVVJ13i7M2pktuYpdjP3NGU5eFuy9XYPunkDnTMIrkfN4lVK/00GqhTxUp/F+1xEs5QG4Nxq4/Cn/dj9zt5SOCwk0EGdK/WN5yzhVaNnSH3avKNAJpbUChcSl5DcCsoI5oBVgWNlNPwgxfOqJamtKRh8HWkYiGBR0CuIljVIvmQfl8oWmi7EqrWgdXY8xun07zGv5pHt7YZX20bk+m+1jHxXlh/s8qYB0/A6/Zt/h9E+V/hCiD9bW5ft5mudlr0FKXULx3IGhzhljAAN2H2pTLAIz4AmselME4GSX803/Mop10Wu3SYw+zb+MZklcQIBI6db0cBa9SMmlrJxYOgSmRzHmOgQvrL/ewHlAKa8loYfMDaOWkrQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88ac275-0020-4bb7-5c65-08de2d78d319
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 05:50:09.3758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2eRW9T28xJd4gPIwFpvJZsVA80FuV71Owy6BnLKTCpKeRY3p2v8D6WWbmpBdSBCz6RMbyOwYPDj3h8+lgrCkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR16MB4033

PiBPbiBUdWUsIDIwMjUtMTEtMjUgYXQgMTQ6MjIgKzAwMDAsIEF2cmkgQWx0bWFuIHdyb3RlOg0K
PiA+ID4gQXZyaSwNCj4gPiA+DQo+ID4gPiBXZeKAmXJlIGF3YXJlIG9mIHRoaXMgaXNzdWUgYW5k
IGFwcHJlY2lhdGUgeW91ciBhdHRlbnRpb24gdG8gaXQuIEhlcmUNCj4gPiA+IGFyZSB0d28gY29t
bWVudHMgcmVnYXJkaW5nIHRoZSBjaGFuZ2U6DQo+ID4gVGhhbmtzLg0KPiA+IENhbiB5b3UgcGxl
YXNlIGNvbW1lbnQgb24gU2hhd24ncyBwcm9wb3NhbCB0byBlbGFib3JhdGUgdGhpcyBxdWlyayB0
bw0KPiA+IGVuYWJsZSBmbGF2b3IgcGVyIHZlbmRvcj8NCj4gDQo+IFRoaXMgcXVpcmsgb25seSBj
b3ZlcnMgMyB5ZWFycyBieSBtYXBwaW5nIDIwMTAtMjAxMiB0byAyMDI2LTIwMjguIEFmdGVyIDIw
MjgsIGlmDQo+IHZlbmRvcnMgc3RpbGwgcmVmdXNlIHRvIHVwZGF0ZSB0byBFWFRfQ1NEIHJldmlz
aW9uIDksIHRoZXknbGwgbmVlZCBhbm90aGVyIHF1aXJrDQo+IHByb2JhYmx5LiBNYXliZSBqdXN0
IGFkZCBub3RlIGZvciB0aGUgcXVpcmssIHRoaXMgcXVyaWsgb25seSBjb3ZlciAyMDI2IH4gMjAy
OCwgZm9yDQo+IHllYXIgPj0gMjAyOSwgZWl0aGVyIGNoYW5naW5nIHZlcnNpb24gdG8gOSwgb3Ig
YW5vdGhlciBxdWlyay4gSSBkaWRuJ3QgZmluZCBvdXQgYQ0KV2lsbCBkby4gIFRoYW5rcy4NCg0K
PiBwcm9wZXIgd2F5IHRvIGxldCBvbmUgcXVpcmsgY292ZXIgdHdvIHllYXIgcmFuZ2VzIHdpdGgg
dGhlIEVYVF9DU0QgdmVyc2lvbiA4Lg0KPiANCj4gVGhlIHJvb3QgY2F1c2UgZm9yIHRoaXMgaXMg
dGhhdCB0aGUgZU1NQyBzcGVjIHBvb3JseSBkZXNpZ25lZCB0aGUgeWVhciBlbmNvZGluZy4NCj4g
SXQgc3BsaXRzIHRoZSAxNiBwb3NzaWJsZSB2YWx1ZXMgKDAtMTUpIGludG8gdHdvIG5vbi1zZXF1
ZW50aWFsIHJhbmdlcyBpbnN0ZWFkIG9mDQo+IHVzaW5nIHRoZW0gc2VxdWVudGlhbGx5LiBGb3Ig
cmV2IDgsIGNvZGVzIDAtMTIgbWFwIHRvIDIwMTMtMjAyNSwgbGVhdmluZyBjb2Rlcw0KPiAxMy0x
NSB1bnVzZWQuIHRoZW4gIGJlaW5nIHVzZWQgZm9yIHZlcnNpb24gOS4NCkkgYW0gZm9yIGFsc28g
Zm9yIG5vdCBvdmVyLWNvbXBsaWNhdGUgdGhpbmdzLg0KDQpUaGFua3MsDQpBdnJpDQo+IA0KPiAN
Cj4gS2luZCByZWdhcmRzLA0KPiBCZWFuDQoNCg==
