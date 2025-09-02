Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D74C8FE
	for <linux-mmc@vger.kernel.org>; Tue,  2 Sep 2025 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792970; cv=fail; b=erKfGeMtJ9DBz2ixzQYx95/KmTqfZvVsY1Yq39ZJJtwf9k2NR9b94JsXzSeix46rGOsRvDzlpcx/Z1PbnSMmhJoYU7a1uwgzO2JZFzoUsIWHFdDyBvksZD0+OEzZ6uJVCIF9ne33VlJmtGHKCw4XHpJijN0NEnwEOKqy3dZFk0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792970; c=relaxed/simple;
	bh=1oF5NNXwgfhmz7ONfqWjnAyKXhCzfAJXGMO0a2A/0OM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LV/mVtAl10LAHjGAM7Tf2fMHx6wW/ZFxlCbZSiIwzRWdg4jibBaxepAvN32Mksb56s/y9NcSQ1LQkHjJvkBRbcLIfJQ3DTnQ415QjpoBOmwdQ1HWEh/QfMDPD4reZau0kS44g9uIkm0IrPEYNb5ewLrp2v1CQJ+5uW54llizc5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=N0sBW+PQ; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="N0sBW+PQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1756792969; x=1788328969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1oF5NNXwgfhmz7ONfqWjnAyKXhCzfAJXGMO0a2A/0OM=;
  b=N0sBW+PQlk8/08rB55bihAGJROQngunkUji3G941PvSFcH9ZlwvCL4Ye
   GXjKwRJ3ojL1wZ4dHk+zTfoQ4C9EeKoQCBBs18pLF8vluCenqUrjwSPx7
   7rFgIcLEb4lKXHm5wwv2T2kCA0fPTcCIVp107oyqMSbbl3JVdcGzNe5OY
   x5F/fYIim5/QLbcgx2ckGIF91qw+eieVwFM8KEPvjbw7aeLmcJkCDAlTc
   e7MNeiVYmDPZjkGC30V2bdJKwf1PgV9hKjJpGsyRIak+1Thx/GkmKcm9E
   CqKJWL9tYt7zVp4o4E63W1RfHthSZmvifnHhPzkyv8Vs39Z2ltucqtVqX
   A==;
X-CSE-ConnectionGUID: m4mQkeoMTVyEteo5JRtAtw==
X-CSE-MsgGUID: S24Lg8HmQzyEvsWSHJKXnQ==
Received: from mail-dm3nam02on2113.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.113])
  by ob1.hc6817-7.iphmx.com with ESMTP; 01 Sep 2025 23:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHblsKNYtYdBqLFqZzhRLkDEFLKepz4UqzHSQhv4hXedj4XtM7l4fY5t0xN/EDfdODMmPyBg5D+2HrftTguo1hoIPpgpDuvFNL/t2t6ZpsgjVOcet65fQEiUq+G5QLXIs9JOILHyMhdUx+UQna60gD9MiJBHc1TR1/7oNSJgVcG2KNfOWR7ATCcaAi/hhN+8/P8diT+m2xWdzisOtS4o4u5rHk+SIafDWBMAJdWE4UMOhjsNd8kwQ7RxQM0AdK8JF05T8pS8ppeDR63joSrAFPoYDJj5P7hbgBSrpjGnrwNihDgPDwIaJPJpg/EI8ES10h+na78eDRpjPcjnPUCfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oF5NNXwgfhmz7ONfqWjnAyKXhCzfAJXGMO0a2A/0OM=;
 b=jGXVo9AU/MVucjdoQWPaBfo/Zg7Ou5xykTyKvN8wlM89mHyHQ1MEhYrwJ/EZc8Kwn/E3RW+QIdXzzUDdTujzt2VHzQ9Y+lUyZDpGvwG8yqAAj2dXElXJcF1Fuh65ZBQPRTb4Dp4pjor6V2icWGSm+NvTz22FeWH0o4L9SUwvbKITsUiQ0ty0bvyGtq7KWTyE3eO9f/iByclG4c6AU7OToBdDkDq37YWumsF7YfT+VLbq6bM7FGh66JALCeU5gt3mH5/rAKBDox+f4TmQ3eoudjqk0AAVvISxDNlZVSHlGRNkIZn5lmHPeunHraUnK6oO3+QqjyEyjvciT+4dkIdqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SA1PR16MB5485.namprd16.prod.outlook.com (2603:10b6:806:379::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:02:45 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 06:02:45 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH v2] mmc-utils: Correctly handle write counter overflow
 status
Thread-Topic: [PATCH v2] mmc-utils: Correctly handle write counter overflow
 status
Thread-Index: AQHcGyJ4+2gT7fMgeEaZfQh0Pvb0NLR+m1EwgADIDoCAAAQC0A==
Date: Tue, 2 Sep 2025 06:02:45 +0000
Message-ID:
 <PH7PR16MB6196528FF366384AB1F7B46BE506A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com>
 <PH7PR16MB61961D92DC4EAF96C8378802E507A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <2ec0d3e7-3637-46be-94d9-0d7af9137e12@siemens.com>
In-Reply-To: <2ec0d3e7-3637-46be-94d9-0d7af9137e12@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SA1PR16MB5485:EE_
x-ms-office365-filtering-correlation-id: 1721886f-44dc-437d-8576-08dde9e65621
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?blZGNEZiRVlRMGl3TVh5dGhhY1J5T3NYU1AyOUhQd3lGTGlNYWJsOHc4Z1kz?=
 =?utf-8?B?Sm54eXJlc3krd2xQUlhnSWhGaXE4QTFBUDc4TFkwZFo2RFFYN2ZpTDc1QXk0?=
 =?utf-8?B?UTJJcnRPK0RMc2k4dk4ybHkxZXBvRUNVanB1TnNzZ0E0Ujg4eml2Z0xkME01?=
 =?utf-8?B?aVF1M2p0SmtIdzc5ODJKbXlPUUhIQktUMGsrSU9ZS3BISXFON0FlZkYxQUMw?=
 =?utf-8?B?dHBrSm1YVk9kdmF3ZkFRREswcnplM3RpUkNsVG5wcnk5cmNIRG5ROG4xeUw4?=
 =?utf-8?B?K3ZKQmJSRWxWZU9qVS80WTF2cnVHVGpyaGxmMVJTREJKeUlpUjZNWUFJTktU?=
 =?utf-8?B?MWRsMEQzYkVkYkZWUCtaQitZdzR1cVFVTmQxeStTS0pBM2ZKL3A3T0wxNFlP?=
 =?utf-8?B?bnh2WGlGZlpQT3I0bHFUV0NDbG9qNmpGMDZZcUpEV0prMXd0THB4Y0x0a0xL?=
 =?utf-8?B?ajdhVEd3NHhOMndXNkNLVktIcXNjczZ3UHpTK29uNGdGT3ZLbTR2ZGVidE8y?=
 =?utf-8?B?TUtvdEp3T01nTmNySFVZV3h1U01MMFNmUnI4Q2RLd1lCRlZMdStwNU1RWkxq?=
 =?utf-8?B?bHk0VldjRG1ybUZZL3cvdjkxbjIrOHN6K0NOTFZTMnJTdmFmVml0ZFRaVG5m?=
 =?utf-8?B?Rnc2UGZoaHdNbGVzeklEZDF5OU1neEsrRElTQUtzYnhNb29ZYnZhT0YyTjdt?=
 =?utf-8?B?MnN5L3k2Vm9nQnl3WU11ZkxoelRvWmUvaWU3d2lZbTVIV3N4YUhoNDF3Vjl2?=
 =?utf-8?B?SW9nb0xBMXFjV2xYdGY2cWxzZTRiRFEwOVVLNWxkUWcwcndseDVocWgraGdL?=
 =?utf-8?B?RVV1V2xyNm9Sa1kzNUU1TGt5Mm1WZEs2MnpXZForNVFtWjBlaC85bzYweWNm?=
 =?utf-8?B?VWhVemVkV25hZGZzTU9TdWl5ZlhYeWdtbHFlZ0JsUGxJOUhsU1NkaVI4dWlL?=
 =?utf-8?B?eXhpQ3I0NWFWdkREUFhnSXJ4MzVQa0NaZUFYYUZvZGtmK2hjN0o1UUhjUnI5?=
 =?utf-8?B?bXo1NTBMSFpybmM1TE9aaTlNOGwwalZRSSt0SllFMCtoTWpsYUpUU05rYnh6?=
 =?utf-8?B?NnBiQlZyUGJNelJSWUdBY1hBM0x6MkYwTVlQMlR5WFJWVkNON1dBKzF5S0Fo?=
 =?utf-8?B?TDZMdVgwWmhva1Bxcit2ZTZGNDFUV3lncWZaL001VWNSVytXNzZmeE9pbGMx?=
 =?utf-8?B?dWQyNWNBSHhwWkV1NmdJM2lwRlAvNjFET1ZmZkJ2enByTWs4SHZ2ZkpmNTVQ?=
 =?utf-8?B?c3grVmpsTDFXR0pCN1lNRlR4MElEb01QOEM2bTZjU0QzNUg4dWVEaEpxc25m?=
 =?utf-8?B?Q2dlb3ZEWHhkYWljTk1BZmVEc2c3ZUwzMGV5M1lKMlc4eEc4MXBnWjJ4MFNv?=
 =?utf-8?B?SjBmMjliaUlKWjVFRERxMzNYNGRnSldRVFByRHZNWWtSS3FWNEswVkIycm4z?=
 =?utf-8?B?amZiZ3NGUW9qai9XVU5Db0ZobkNPUlRFai81aVBncHNQdkpmSUFlOU9DaFV5?=
 =?utf-8?B?cUFObEwrY1hSWHhRV29Dd2RJZVQwQXdDaTh6Z3ZLZEp3TER4WExjc2tCc3pN?=
 =?utf-8?B?NHc1Mzd0SGJkY1lya0hxbWlCVkJGVTRuVTNiOG1NZWJKSEJzSVF3UTA0dUdW?=
 =?utf-8?B?Y3B0cnF3dG1yUTVveVA5Z1lVVmpZbmJzajdRdjhMSFZjNXRJZDNSWVYzWnJa?=
 =?utf-8?B?MCtocTRqYURPU1RzVTNMYVhRdGkwMmRCU1gyS3hMdEdBZWVVRlJjd0JrNWxl?=
 =?utf-8?B?UkpiMzVYbUhFWVNwOVozZE5iWVBjQWdkQk9lY0c4UlZaZGlvbEkxVEs1d2hn?=
 =?utf-8?B?WkVRS0N3T01DaUVhRTMwcXVoYmZPTW1GRXg2ejQreDI2endOQmJFZktRTTR3?=
 =?utf-8?B?S1NVd0d0OE9oWTBlc3ZnV2NCemdGem4wNmpoUHhHanpqdUVxRUFSTmNzSHlz?=
 =?utf-8?B?Y3NVSGtFYzhNM2FLN2txWE1EZWxjaGM5SFFDcDNrZGRNTzE5OXpNS2JLRTlT?=
 =?utf-8?B?YXJNMUNVaHp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWdqeGVUbTZrTnRlWndBeldsRC9zWEFVR1pyd0tJUUxnY3dZS081NWl5a3Jh?=
 =?utf-8?B?ZjE2eXdEVUFYTHdxVGlZd0tOSW1MS25qaEdDa0U3c1RLYXJKZHlOUG5uTEow?=
 =?utf-8?B?SGxsVjF6cnByQ1UrNDBPNzNvT0Q1eVRFMTBQUFg5emhOUnZXV3NleG9wN1Nt?=
 =?utf-8?B?ak1BSmpiTUNvdE4vQitYUWtjRHFlM1pzRmpXb3lXZEtKSlhHTEhsZ29TWERZ?=
 =?utf-8?B?VlRaaDl0VG9sVkU1TEp3eXBzSVNsbGk2M1ZuanVEbzg1K3JhYUd4TCtqaFIx?=
 =?utf-8?B?NmxWZnN4a2FvajVlU2lZdDJIbUJxZ3NGM3ZhNWhmNEc2bVo1cTdrYnkzdVlh?=
 =?utf-8?B?cnFOZ3BrUXJHcjBQUzVrcm8xNGprK3dveDdjU3Vmc1BzM1pRZWpRS3dMMHRu?=
 =?utf-8?B?NTBUWW1jME1jcDd0aUg5NUtNdUlYWW1xRXl1dE9hRER4VzhNM1NSUUVwSWJz?=
 =?utf-8?B?UmZGZUpyQWYvT0NFR3hyNy92aUlKaTVyTGhQbG9ncHRuY0xjWG1mRjRVcXZG?=
 =?utf-8?B?VlVFRE5MRVZhUjV3UUZIM0hqWjBxbjkvSld6dEs2VXBZOWNsVjVJek1PZW0r?=
 =?utf-8?B?SVI5bFFuRmhoWExOMElEWmtHL0tHd3h1T1hWVEdaNGRyV0RQM0NHR1VxUHV4?=
 =?utf-8?B?amVoRXBhLzVXdXdMa0l4MXRGcC9BZEZ1bm9BR1NoUHN1aFdwcVQycUYvZGVQ?=
 =?utf-8?B?emI2azFublJraERyT085SC9UZGdBVnFQODhEVGFUaFdScXZBV3lMM3NaSDd6?=
 =?utf-8?B?MTgrR2pwRDhMYVc2bHdaMWRzUnNXdnJyREYvb2lDQXc4RXFiOHEzeEZvRUcy?=
 =?utf-8?B?YnJrdGpmdEJoV3BOd1pVR05TTG5GaGsySzdISUJ4T3pYZEZIaVpsTVI1cWFN?=
 =?utf-8?B?NDdrSGw1bkM4cXd2RXRJRmlOM3J0c2ZyL3BqdG92OStzYUw2U1dEVUlzWk9Z?=
 =?utf-8?B?alErOUJUSk81aVUrcGFjeWRWSUljaDZWeEJWTTBjSVlpSzJBTFhKQlQ0UzJo?=
 =?utf-8?B?RXZqMy9ZcU1jSkdYZVluMXFNSnJ6TWlhdnhQcFFwU29VVnl2RFkzRE5XaUw4?=
 =?utf-8?B?UVJlcVVQMnNpdjNLenZGcklsMXFoTGVFanorT0h4TThnR1B2U2xHUlRwYm1X?=
 =?utf-8?B?RGpmc0s0YzByL2wwQ0Y2b01rQm1EUnR4aXkxTlBWRm8zeEE2cHdoUG5kS2RX?=
 =?utf-8?B?KzVJbGROcUthNkgyWjBPQjZZUFVXQVBjTFB5TXFZeWJrR201MXFyVEl3UTZn?=
 =?utf-8?B?SndOQ1BNZTd3RHZOVThndkoySDBaVXMyVUR6N28rTTNIVjY5T3RzRnQvWEFT?=
 =?utf-8?B?WHB6VzFPYTZWK0VBZkVPa1VpRzlLOWlxZ3poK21Tb0VtTDFDcGo2K3FiSUtv?=
 =?utf-8?B?YzN1QkE5ejBTTVB4VGRqRGg1S2Yza01UdHlyeEtscjh2R1RaREtJQWdBOXNC?=
 =?utf-8?B?cnFlYUhCWkdWc0hodDFMbVhjdEdxQktCcHk0ZjhNd3YySkg3UzJkajMzaW9j?=
 =?utf-8?B?dVpvNTg3d3lsOEtSdGV5Z1BwMlcwejBIMDR2Nnl2dVEyZ0M1Z1U1bGNjNGR5?=
 =?utf-8?B?Y2MwVEJRVkNCVExrMGZxMC9rdUVZMnM4UDkzc2hnOGhnT0RjYVM1dCt1YmRB?=
 =?utf-8?B?clRZdkNjNHpSSitvbVZNb0llTVhzYnAvYzZWRVh2SlBDQ2pXc2xEWXZOdnRi?=
 =?utf-8?B?ZmVsRGJiQXgraU9XV2EyZlZNV0FpOHRHNDd1WWdQczJ1aE5Ra3lQREcwV3c2?=
 =?utf-8?B?aVR2MXhpandUSnV6ek93NVRWWnpkM0pRdlVHVmlYbG90RmFrS2dmUitPUm8v?=
 =?utf-8?B?dTcwSTFQak9USVJ2OUZhS1RFZFYva2xVVVYzWWJDdUg0ZndGYzRXYVdqR3ZY?=
 =?utf-8?B?cWdGKzB0Y0xOMGJMd1VaVVdTOXU3UlZUdlQ1Z1gxZTNoSk1WVmRTUzVUa1Jt?=
 =?utf-8?B?QW9pdWx2THd1bDliZTQ0NUdZUkhKOFVGS2RLR1MwTGdpR1VvYndrRG9nZ3pH?=
 =?utf-8?B?OGp1MlM4L3dSaE9WMUdXSVVxcUJ1ekRvTHI5bDVzTDIvMjZ3MW9zdVF6ZFZT?=
 =?utf-8?B?Z25ZNkpQUUI3R2RrTHB1VVRpVk81WVN4WEJZNGdkenJ5RTVUSkFDZDEwWm54?=
 =?utf-8?Q?zOxmqbseDoz5Ikz3grIX5h/2T?=
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
	bkjfYRjFO+1uhCp+CL+mm4gXftjpO+jQVjeRwnTxsN7gbQRwP3+sigtWNsRlhDoEG+5OlEfDbNHxnplECY7l8OaCMJTvVY+SFb7rtUN+F+5MzvRbwU7GHZwRchf9UVOI8I0RuWUVsMZkcfDaxveabk6cr/rnrdPYhALyhMwFc9ordU93unmGRz72t5dfYfqIFSlC7VIixkZCEqWuEY5fHEzWFugFyIIuk1B2zbr1AyeOlTCZ4Sedj/C9L5HRqkXrGjtynEsDLGaJivoqR+QpQqIRGPBeIofETX4I1Frl3+pTzn7eTH88aJrxwsvVrgTogl7Op5QrY1B95NI5Jm2QLrushpXbk2qoHtPSsagldcOLnGPMxrkhAFkWpzex/FNj9JMkXGHiAYMeFtegdgRQ0gsJRoC34G7RcVENXFgw96r19bhmhBaTHRjofDFGemF3ZsYjOj1CjZVu1nMh/Ry2DUiegRNtGDB2KBRMUNxPisHtTPz842tktUXIBVNSRYMKmN2MgM26BUzLqh4qwrkHkoB7+gDFuu/iZGgdg0VGTYJPYai22F5imsujyPlU4et1kz4ld2NoXpkz0PRPXNHIbcEUnf64EPff1/5cy9NinzvkTO79c3CBBxnE/5WAeu8rVQZEnlwny28zGx2MBHxveA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1721886f-44dc-437d-8576-08dde9e65621
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 06:02:45.3020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ra9GBw1YsA8qLkMKx3jbs3mDaB+K6FlZM79uXYq6/xWsn5IfZ0398PfuCBd4tH0i/qymhKiXfqrfy8ZaKXab5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB5485

PiA+PiAgICAgICAgIC8qIENoZWNrIFJQTUIgcmVzcG9uc2UgKi8NCj4gPj4gLSAgICAgICBpZiAo
ZnJhbWVfb3V0LnJlc3VsdCAhPSAwKSB7DQo+ID4+ICsgICAgICAgaWYgKChmcmFtZV9vdXQucmVz
dWx0ICYgaHRvYmUxNihSUE1CX09QX1JFU1VMVF9NQVNLKSkgIT0gMCkgew0KPiA+IEdpdmVuIHRo
YXQgdGhlIEJ5dGUgb3JkZXIgb2YgdGhlIFJQTUIgZGF0YSBmcmFtZSBpcyBNU0IgZmlyc3QsIEkg
YW0gbm90DQo+IGNvbnZpbmNlZCB0aGF0Og0KPiA+IChiZTE2dG9oKGZyYW1lX291dC5yZXN1bHQp
ICYgNykgYW5kIChmcmFtZV9vdXQucmVzdWx0ICYgaHRvYmUxNigweDdmKSkNCj4gPiB5aWVsZHMg
dGhlIHNhbWUgb3V0cHV0IG9uIGEgTGl0dGxlLWVuZGlhbiBtYWNoaW5lPw0KPiANCj4gQmVjYXVz
ZSBvZiB0aGUgZGlmZmVyZW50IG1hc2tzPyBSUE1CX09QX1JFU1VMVF9NQVNLIGlzIHJlZmxlY3Rp
bmcgdGhlDQo+IGVNTUMgc3RhbmRhcmQgKEJpdFs2OjBdID0gT3BlcmF0aW9uIFJlc3VsdCkuDQpC
dXQgd2UgYXJlIG9ubHkgaW50ZXJlc3RlZCBpbiBiaXRzIFsyOjBdIC0gdG8gY292ZXIgYWxsIHBv
c3NpYmxlIHJlc3BvbnNlcy4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBPciBpcyB0aGUgb3B0
aW1pemF0aW9uIHRvbyBjb25mdXNpbmc/IEknbSBzaGlmdGluZyB0aGUgYnl0ZSBvcmRlciBjb252
ZXJzaW9uIHRvDQo+IHRoZSBtYXNrLCB0aGF0J3MgYWxsLiBUaGUgcHJlLWV4aXN0aW5nIGNvZGUg
d2FzIGFscmVhZHkgY29tcGFyaW5nIGJpZy1lbmRpYW4NCj4gYWdhaW5zdCB6ZXJvLCB3aGljaCBp
cyBmaW5lLg0KPiANCj4gSmFuDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwg
VGVjaG5vbG9naWVzDQo+IExpbnV4IEV4cGVydCBDZW50ZXINCg==
