Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22074322A
	for <linux-mmc@vger.kernel.org>; Mon, 19 Aug 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724046417; cv=fail; b=PIzBXh2qvGcUj8wEKq2pyyVGuF9a7nKBAu0HHbLD5Njxk55WcnnITccd634K7kAeJVvZD8WNTPEZEujXmyAoZ+Jb56gA8J5+BODI1p3UYzIM3ve6proN5JXmXvEPYZzOzPsWRFjEpziM11AW0aB50UGtOi6WNXr+YylQEwpFz4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724046417; c=relaxed/simple;
	bh=AOnfyqMAhepxg9XPDdyOU38O1SRr418jErhl8SFuwuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ERtWGpCii0jqVzW5uWcMucQ2EYDT+jGXe4ioIkmoSCIBz6VunaFoZ4MmkDGTME9aeC7amptvSxpoiCPNPrZ28eOVOzLlf9L02Zhdl9G73QgeJwHkGGWrO0gEp/jmkpQqNUltTBVsw0hhzjkOnIvR/CXf+G0ELP8U9POqpCWVzbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T8oGn4Cb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=siN5LU5I; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T8oGn4Cb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="siN5LU5I"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724046415; x=1755582415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AOnfyqMAhepxg9XPDdyOU38O1SRr418jErhl8SFuwuI=;
  b=T8oGn4Cb5oWMUPPQilKCkUBcm9bJXGzY1pnOYsRASDgtH24wSgQ73aAQ
   xi5n6Q33yIcPv3j77S6s0cMpEcJytlvXram2YOhoXIOg2M8ZYRRrGAdMO
   sntB7z3xPrVWBRBcLoJHrfDvwzKosTXFFNvRbu9QdeJo0qH4BQ3fgxO4c
   XJU3bujG9pIYCIqKdQgr74OCxurTKZ9MAW+04NH6kjfw4rs3x+aCOfLnl
   gJv+p33zJC2sOyHWsbpI0DoI9OHW0WMQ3MZaVZhzpSm3VO1oLlhDLDlyx
   hMLU/m9BK+74Y2sQVboJKZUi/jf/irPopHwy9+Uoms1DAbJGKC7ixOFK3
   A==;
X-CSE-ConnectionGUID: IpndIIypR5OqVA1ahaJVJQ==
X-CSE-MsgGUID: Xv8Ch11VSoGhpG/E+5bWZw==
X-IronPort-AV: E=Sophos;i="6.10,158,1719849600"; 
   d="scan'208";a="24621398"
Received: from mail-eastus2azlp17011030.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.30])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2024 13:46:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtyMumUNcquk/Xbo3C+hsPZQ8wqY2hwc4gXj1O7+NuTeGOEG/Fvwogqi6Id4TC74qAJ7XJInnGI6lznZv7hLnHmoCvsb9EfOUAU3rXL5qSizqATUDeQudKsmLSWOBThT5hZ53SO7PfxHQ9Iy1jojdF++3cNT8n48E9S4gHb5IPfXwzd0cEKsYrtm6DjTAV192uDXUAuCzNKVcyHGQte405sL0xTmu5Wx1XEeFjNubcYAxa0GZwEjnGyHthNymNRqGh4t/CZMIB3Ax7cV1sclUuH8YfdQW0ejgAhJaN2eiUW5Ep1nPBlKnEZ7/bpAlzYw0bpoTrvtFHb8J3BZiNPqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOnfyqMAhepxg9XPDdyOU38O1SRr418jErhl8SFuwuI=;
 b=NFLzGyG1uxEC3RnyEfoKS4nU/3obXC5lTOvjBZQ/y6pawhrxY8clv+MGdVOrCzz+WaAYj7u14p8oAQbLtsadyysq+ipLUGXb3zKZwygcRKlrSV2hCXqpUDX1g82Xf1ml7jaqLc9/kCNAnGCb7NamdDa6oVdQCkEGM2Zgxln7Tp2/205BkkU+KG5uI//Q4k/wUpnSn6iefrrvZBsF9yO/DVkYWZ/J+MwdkZ81mqIVFOlW1ug892v4Ew5TRFQ8BayVQ9zLyVXPXvn9VMSYhoHfRZ92wKvmpCKeQtnufM+7QUwD+8sQJQQmeCR9aaqhRffYVI3+gMphlNskU9K5/BJldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOnfyqMAhepxg9XPDdyOU38O1SRr418jErhl8SFuwuI=;
 b=siN5LU5Ia9i6f97S7RLmCiWFSTma27PrlcG63DTmEsUb3wBhbSa2nIi2VBw1csA3HuHvKzQH1LokKwLqZaRTRPgCzDlzBQbqxjPbKK6IgcjVfUPXNuf1LlAajdYcnB+GSrIBRSEUZJTIHMlAnn3P8gY24nHteY+FYZMsKMFJli4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW4PR04MB7460.namprd04.prod.outlook.com (2603:10b6:303:71::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 05:46:44 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 05:46:44 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>
Subject: RE: [PATCH v3 00/10] Add SDUC Support
Thread-Topic: [PATCH v3 00/10] Add SDUC Support
Thread-Index: AQHa7hvyewG+Um17tUSMut5xtKNlzrIuGZ+A
Date: Mon, 19 Aug 2024 05:46:44 +0000
Message-ID:
 <DM6PR04MB65758FAE9750D94B73B17587FC8C2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
In-Reply-To: <20240814072934.2559911-1-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW4PR04MB7460:EE_
x-ms-office365-filtering-correlation-id: 72a37d6a-d7f9-40e9-dd2d-08dcc0124ea7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjJub0RkaTJkME5FMmY5MEU3ZlNDZmg3N0I5eFJEdWptSjZrUHJ4dCtHUkk2?=
 =?utf-8?B?Z3I0Smxqekd1QlhoM2N2aDY4aXo5WVI1dzZ0TUM1L2owZHNNUll4WVpQVnB3?=
 =?utf-8?B?RUdFQm1KSFVxY1dhTHU4MFZVcHJUUFB1SFpEQnphUFRmOUJoaTZxb09kT2xi?=
 =?utf-8?B?TEZzaUZpSnFLRWI3bXdzUzEzWmR1dGZFaUQ4NG95QUF2Y1p2NGdaOEdVbnVy?=
 =?utf-8?B?MkdrVEZHNVhoeWNQL2RPbzhwc2FkYmM0bUtJMmFEOXpjTUdET2xjMmlsTWN3?=
 =?utf-8?B?WFp4bXFyYWFsTzU5Tk8wa2NiNkY4bFpQbTdINHNERzJXY3crcm4rN3VuUWdQ?=
 =?utf-8?B?NVZKMlFRWWRCRkF4SDAwdTVheXNVK2NGZ2lsVDZJWjBrRkM0a0gwYVk0RWxD?=
 =?utf-8?B?dXRXNlBsb2poMUcvV0FlYmV5WVdlNjVMczM3ZFowOUlLaVJjRU9ERnNtU1BR?=
 =?utf-8?B?WWxOTm5NMWtVSjV5L3VBM2dtUGZZeU5vZDM0TzNkZ0xDdlhNVWVIM3F1RWtV?=
 =?utf-8?B?TWl0UUpYdWF1RkVPN0hqY3JIZlZ4MmZrQ2x6TjZsWXVOeDdmWE5Za0kyM3lN?=
 =?utf-8?B?TnB5MDZJdDdTVmxVT3Zldnk3QzBPR0pBV1Bna1FiVGZSMFpXamZGS1NiYWNK?=
 =?utf-8?B?dmIwejZqUlMrdTI4NGM0KzJUTnVFOWtTQmlFRlFDNFhTUU5jU0F0RXozckZq?=
 =?utf-8?B?M1U5RFZmS1pEM0J0Uk5taEE2bnVPa0Qyc3ppVXRud0V5NEFQdWFiR1NQOFVt?=
 =?utf-8?B?VHZMbjYyQ3F6cWZGWUU4N05sYlZJaXlPeHhxWUhaUDJOaWNjN0RBdUVha2Q5?=
 =?utf-8?B?Q3NRWU8vWmloMTNuSUpqZU9VUUJVT1A5RFI2eW5QK2NoeVlYSHBkMENnL3lK?=
 =?utf-8?B?NUN6cjFUUXh5cFVteXBNZTJHalN6VU5nWnNhSHBSVkVxZ2YrTjlhclI2RVRp?=
 =?utf-8?B?MXVNS2xCdmRoQThrVWlVSkdXdUMyTHpQZXJPRjRJTFJmbWQvYjFnWVZYY09Z?=
 =?utf-8?B?QnhreEprV3RzT0xTT2V0cU1WZS9YU0FYRnBydUUyMWpJeFJqVkdHMXFONlRZ?=
 =?utf-8?B?MzZlM2p3NEtMa2Rpa1dFelRRbE43d05HVjcwd3NJVVB3empTeG1VdUtOYnhv?=
 =?utf-8?B?cEx0Z21RZjZmdmsxRDVZSk0xdklBeVFId1hOZ2prNVIySCs5RVRBdHdCUEFD?=
 =?utf-8?B?QTd4cWppWGFPS1dHd0xWeTllcFZHYlV2Y1JyNHcwclZCcU44T2RWVUlhMkE5?=
 =?utf-8?B?eEpFeEhoK2tBcVgwUzZzOEFiWlRLb1VKWlVOdFR3UWJ4ODUrVy8ydUI2R0tB?=
 =?utf-8?B?THpWcDVYQXZzU01VS0pSNnZLVnVjczZkSVZtRER6WWR4Y2EvVUptaFQ3Q1RL?=
 =?utf-8?B?SjBHZXF5SzBVYSthaEk3b0EyeGw0QWVZd2sxc1ZCWnNsVkxYanZYRW9ST3Q4?=
 =?utf-8?B?NFkwME1SYTh6NWJRQTQyMEk4RzI4N0Qxd1EzZXhpOElBc3N4S09XbEQvTWxs?=
 =?utf-8?B?WUxBM0hTVVI2STBMb3FwZExKUjUzc04wdUR4TGhYWXhtQ3dsL0tUZDRNdUJz?=
 =?utf-8?B?akpFN0gzbkVvaTNPQjU2ME9sRVFaOFdxZFBObnZqWTVPdDFlWTYzRVV6U0Uz?=
 =?utf-8?B?azBGS0ozSTQ0RGVvekZlWUV4Z29xODRLMVNEYTRWQ3daU3ZzWlg4aDhiOE90?=
 =?utf-8?B?eFFHNzdtb2ZoRGNDcUQ5UVAyL0k3SUZBQlQ1Q2t0N2dBdHpEcFYxNWgxdngv?=
 =?utf-8?B?bmNVOEhGVXJVV3pKQ1VTUVpVS1J3YWIrcklsTGVuZURlMVBkQWFSa3lGRlpY?=
 =?utf-8?Q?oX+hBfDF9pidqy/SSmThuVVc+ObFxxIVRKmxY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGFmMDlTNit4ZU1jbUZreVpPMFlvU1dqcm1ScmtnZ0EyYVhQVVdWR01aWWNn?=
 =?utf-8?B?UnZyMUJUVEs4ZHE0UFh6bVQwdjludE03djkyMk1FRVQyTUtscmlibjVUUmFO?=
 =?utf-8?B?ZEgrZ0tyYmJJMWZZeEZodDJYeFlKc041UFRGZlpaZ1VHU0QwSndYSUMrMVhw?=
 =?utf-8?B?RXRZcmhRSitndTlqeWVzeFhmWlVodzVwYkNFK3Fkd0hUTjF6cDQ0YkloWlFQ?=
 =?utf-8?B?Y3U2d0hMWlNMOE9SSnFLRlR5d1l6aFdoWDJnWVRrU09QTENyS2Nic2o3MUgy?=
 =?utf-8?B?VTE1NjZlT2ZicEZVeGNmMG9pV0NmcnBhdEM3TXc5WHpZbXdJOUhqbS8vUDVs?=
 =?utf-8?B?MHFIZ0lBMXNqZTh0N1p1cmhObWhIMDAxNW40eVprVlBFaDU1dUYrdlN4Q1c0?=
 =?utf-8?B?UHpVNTlTZUhSSUxKSTFGTVo2SEpBNXY5cUgrV2YvbWpUYVpMaDlsT3FoeU1O?=
 =?utf-8?B?UlBISkV6UVE5L3VhM254VnFXcEI3aTVubVhLOGVvY2FHbmZvaVV2SFVKUS9v?=
 =?utf-8?B?L1daSExVU0UvMi9HMXVpOThvaGZpWjZqdkZ1YVZhdld6MkVwM2Zqays2czFE?=
 =?utf-8?B?Y2lwVTg1dUFHSThDM3VmdytIcEtrbGJnQUJzbWt4VUV0TVRLZU9rejBDcG95?=
 =?utf-8?B?a3JaZHRsMGM5TmYrbFRTdFJOVFFYOUVLVUhlUndKdzhCTjcrWlJhN280S1px?=
 =?utf-8?B?YmdWYlhXMmo1YjZ1ckhLRWNjS0MycjhUZy9lVENGOTBaSE50c3FXTVdDVWRE?=
 =?utf-8?B?UWhUNVdMTGp2RVl6NUNSbzNVcUV2eTBHZUVQVmZGYjBFNFlRemZOUEZYeUFm?=
 =?utf-8?B?eUk1NG84aEw2WVg0cUp0ZjVOT1d2RFJ4ek5IYmRjNGhsOWtydFllTmJaNkxG?=
 =?utf-8?B?NWNuSEE5Mmhjem1KNDJtTy8xdGhLUTVFTTFwZHVXOVVybVNNWDNFYTE0bU5C?=
 =?utf-8?B?Z1NKOXFWMG83Ti9wYmlCYjlXZktKdXlUa3lQRHVSdVd1eE5LdFZjS3lhMWRY?=
 =?utf-8?B?N3ZZMmg0akdKN2c0K3hGK1RXZmVvelVWaUlEdWRmOFJ4emdrQXdXSEUxUmF6?=
 =?utf-8?B?NmhpN0NFYk43ZVQ3RzlBWUlPMThVblFzVnBKWUU5dFVEUVRSVURBWTRIL2pi?=
 =?utf-8?B?Q0daS2pDbXRJQ2RmcEE4YitkaXlXRzFCRHlTSyt5ZFZTL0luQjlCcVVkYTB0?=
 =?utf-8?B?OUZUSkdjdldoaUxOWk5GMUluWXJLWGJiT2w4Uk14Mnh6K0UxQ0Y3eGpYY3Bn?=
 =?utf-8?B?TXRyOUFkL2lYOE9waEQ4cytFNjE1VzR3eGRFOVI0bm5wem92U09PT0VVczNu?=
 =?utf-8?B?L0pkc2hxTHM4MC91WVlzQmIyU05Rdk9RUHlJN3FHSmxhdGxlOVhESXJ6VTh0?=
 =?utf-8?B?ZHZYQmpuYjl2VVFzVUhIcmxlWFA4eEprUmxGRkRQdUNoMmpPNmNaYTBjcm5v?=
 =?utf-8?B?eE5YTWIxc1dhYVljMFpXR0JkeWNsREo3Zms1OVo0VGtUcDdzajBkeEd6RTJV?=
 =?utf-8?B?RWNPN0Vxd2lsQllsRUt6WU9IN2V1cVdCakJGU2oxcWFLRkF0V2RrRm50UFgv?=
 =?utf-8?B?RHM4dTlFYVoyTXY0OGQvd3pTbWZHWjdOZ1lCdGNyM2pqRW9ONyt3OTloYmtN?=
 =?utf-8?B?TnpHRFNhUm9JbTY3WG12Z3B1VTBodFlGTjVHOUcrbnpKVGFHdE9VQ2NoOFYx?=
 =?utf-8?B?bW5EMGFYWnJBakJhdjNKTThyR2RVZ3FjRWltTzNUY2FRdEd5cUs2bHAxZXlU?=
 =?utf-8?B?c0RDMkRQbVQwd2xLY2hzTkw5MkZOOHIwYjFjK0FPcEV4eFZZTW1aL3hnSjB1?=
 =?utf-8?B?Yll1bEtIUFBLaFk3NkUvdzlKME9meHkwdWF3aEJJRERHWnR6QXByTVZVQ21Y?=
 =?utf-8?B?NkpkUy9DV05zRktlWVVqVnBvQ21SSHJtenUrYTRodmpudGphcm1Pa1Z4bkN3?=
 =?utf-8?B?WWJSb2h4V29kSXQvMlVQb0Z5ZzZFdzBxZU9QaGlwYmVFaERoMkJRbFJuU2Js?=
 =?utf-8?B?OFNJNHhJbVZPMkx2QnNoMncvN3NBVkZqeHM1Mi95UForamgzRmYzZUZBNGoy?=
 =?utf-8?B?QTkxUGNvS1BXcnMrQkdPeFl6WmxhQzdseTBOZm4vb1B1aU5ER1VIb2lyN3oy?=
 =?utf-8?Q?rO1VTASToehYyHWfaYdiFRMXn?=
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
	JVHLHayAAp2lJFSecc8aSijv/cDIO5rFwCtn2Q/L7G8aVFNjgrsVWtVFsfnFfcBoJH180DbNk2Y0Li9C7wRLyZY4ExZ79dykqNMP/9eli1mmuT4u0rFqVJZ8A2atM+gv9EHhGx12Rl+JgG3NRKdeJ5N29nR0EBhP/inImAOF/JjHwWwvlmEN7TYmep6gy4s70WSo+zQknMMhMXbeZZo8sgFZZRuEkRJnmhR+ndlS4OYLtNCNWu+cFw1xzZbpPzhlH/5zPqb3EsilldIbdPTmvATmKfNB7/uSKzVwz4jkHqa0rQeRE7T1IDDdvt87VyKaltwCyrxU+I/ZqtmXG1xV+1ejnVDNoDTBHWRTN/SteZV1KzNdNJsvTi3t8bIUUvZHZGxQXxrpNwR8qsH5CAfcBWRKFZcrxM0kA1W+ivQKXj4K3u1xk02MXbzZn+CH5tY9ui4wFqMG+jWKzemkdlBoBkaCNVmtQY+4ny1Zvum/4EXw6L1WDNxx/WNEvOuxjVjPpMRp/ywpYdMXCqXjkvk4urk+YlYYzRq0B1bNByZNB/s9LNW2CkF8TU2d2iTdKTzowqz3BLLoHCVM1cgI24zvYpJEZj8CRELUj9AqpW4TYrFe1Q4hWXIaVPAhZsHGnMQs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a37d6a-d7f9-40e9-dd2d-08dcc0124ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 05:46:44.1174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzUmYQuxo7AWXR25xNBQD+SLX2IJg/GOD7QdYdDUVKiakHNcPmNfuFvThi9PQjwI3JQu/FCI9wvvcqlC9jKZ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7460

VWxmLCBjb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29rIGF0IHRoaXM/DQpOb3Qgc3VyZSBpdCB3
aWxsIG1ha2UgaXQgdG8gNi4xMiBtZXJnZSB3aW5kb3csIGJ1dCBJIHdhcyBob3BpbmcgdG8gc3Rh
cnQgbWFraW5nIHByb2dyZXNzLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDE0LCAyMDI0IDEwOjI5IEFNDQo+IFRvOiBVbGYgSGFu
c3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IFJpY2t5IFdVIDxyaWNreV93dUByZWFsdGVrLmNvbT47IEF2cmkgQWx0bWFuIDxBdnJp
LkFsdG1hbkB3ZGMuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjMgMDAvMTBdIEFkZCBTRFVDIFN1
cHBvcnQNCj4gDQo+IFVsdHJhIENhcGFjaXR5IFNEIGNhcmRzIChTRFVDKSB3YXMgYWxyZWFkeSBp
bnRyb2R1Y2VkIGluIFNENy4wLiAgVGhvc2UgY2FyZHMNCj4gc3VwcG9ydCBjYXBhY2l0eSBsYXJn
ZXIgdGhhbiAyVEIgYW5kIHVwIHRvIGluY2x1ZGluZyAxMjhUQi4gVGh1cywgdGhlIGFkZHJlc3MN
Cj4gcmFuZ2Ugb2YgdGhlIGNhcmQgZXhwYW5kcyBiZXlvbmQgdGhlIDMyLWJpdCBjb21tYW5kIGFy
Z3VtZW50LiBUbyB0aGF0IGVuZCwgYQ0KPiBuZXcgY29tbWFuZCAtIENNRDIyIGlzIGRlZmluZWQs
IHRvIGNhcnJ5IHRoZSBleHRyYSA2LWJpdCB1cHBlciBwYXJ0IG9mIHRoZSAzOC0NCj4gYml0IGJs
b2NrIGFkZHJlc3MgdGhhdCBlbmFibGUgYWNjZXNzIHRvIDEyOFRCIG1lbW9yeSBzcGFjZS4NCj4g
DQo+IFNEVUMgY2FwYWNpdHkgaXMgYWdub3N0aWMgdG8gdGhlIGludGVyZmFjZSBtb2RlOiBVSFMt
SSBhbmQgVUhTLUlJIOKAkyBTYW1lIGFzDQo+IFNEWEMuDQo+IA0KPiBUaGUgc3BlYyBkZWZpbmVz
IHNldmVyYWwgZXh0ZW5zaW9ucy9tb2RpZmljYXRpb25zIHRvIHRoZSBjdXJyZW50IFNEWEMgY2Fy
ZHMsDQo+IHdoaWNoIHdlIGFkZHJlc3MgaW4gcGF0Y2hlcyAxIC0gMTAuICBPdGhlcndpc2UgcmVx
dWlyZW1lbnRzIGFyZSBvdXQtb2Ytc2NvcGUgb2YNCj4gdGhpcyBjaGFuZ2UuICBTcGVjaWZpY2Fs
bHksIENNRFEgKENNRDQ0K0NNRDQ1KSwgYW5kIEV4dGVuc2lvbiBmb3IgVmlkZW8gU3BlZWQNCj4g
Q2xhc3MgKENNRDIwKS4NCj4gDQo+IEZpcnN0IHB1YmxpY2F0aW9uIG9mIFNEVUMgd2FzIGluIFsx
XS4gIFRoaXMgc2VyaWVzIHdhcyBkZXZlbG9wZWQgYW5kIHRlc3RlZA0KPiBzZXBhcmF0ZWx5IGZy
b20gWzFdIGFuZCBkb2VzIG5vdCBib3Jyb3cgZnJvbSBpdC4NCj4gDQo+IFsxXSBodHRwczovL2x3
bi5uZXQvQXJ0aWNsZXMvOTgyNTY2Lw0KPiANCj4gLS0tDQo+IENoYW5nZXMgaW4gdjM6DQo+ICAt
IFNvbWUgbW9yZSBrZXJuZWwgdGVzdCByb2JvdCBmaXhlcw0KPiAgLSBGaXggYSB0eXBvIGluIGEg
Y29tbWl0IGxvZyAoUmlja3kgV1UpDQo+ICAtIEZpeCBBQ01EMjIgcmV0dXJuZWQgdmFsdWUNCj4g
IC0gQWRkICdUZXN0ZWQtYnknIHRhZyBmb3IgdGhlIHdob2xlIHNlcmllcyAoUmlja3kgV1UpDQo+
IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAgLSBBdHRlbmQga2VybmVsIHRlc3Qgcm9ib3Qgd2Fybmlu
Z3MNCj4gDQo+IC0tLQ0KPiANCj4gQXZyaSBBbHRtYW4gKDEwKToNCj4gICBtbWM6IHNkOiBTRFVD
IFN1cHBvcnQgUmVjb2duaXRpb24NCj4gICBtbWM6IHNkOiBBZGQgU0QgQ1NEIHZlcnNpb24gMy4w
DQo+ICAgbW1jOiBzZDogQWRkIEV4dGVuc2lvbiBtZW1vcnkgYWRkcmVzc2luZw0KPiAgIG1tYzog
Y29yZTogQWRkIG9wZW4tZW5kZWQgRXh0IG1lbW9yeSBhZGRyZXNzaW5nDQo+ICAgbW1jOiBob3N0
OiBBbHdheXMgdXNlIG1hbnVhbC1jbWQyMyBpbiBTRFVDDQo+ICAgbW1jOiBjb3JlOiBBZGQgY2xv
c2UtZW5kZWQgRXh0IG1lbW9yeSBhZGRyZXNzaW5nDQo+ICAgbW1jOiBob3N0OiBBZGQgY2xvc2Ut
ZW5kZWQgRXh0IG1lbW9yeSBhZGRyZXNzaW5nDQo+ICAgbW1jOiBjb3JlOiBBbGxvdyBtbWMgZXJh
c2UgdG8gY2FycnkgbGFyZ2UgYWRkcmVzc2VzDQo+ICAgbW1jOiBjb3JlOiBBZGQgRXh0IG1lbW9y
eSBhZGRyZXNzaW5nIGZvciBlcmFzZQ0KPiAgIG1tYzogY29yZTogQWRqdXN0IEFDTUQyMiB0byBT
RFVDDQo+IA0KPiAgZHJpdmVycy9tbWMvY29yZS9ibG9jay5jICB8IDYyICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICBkcml2ZXJzL21tYy9jb3JlL2J1cy5jICAgIHwg
IDQgKystDQo+ICBkcml2ZXJzL21tYy9jb3JlL2NhcmQuaCAgIHwgIDMgKysNCj4gIGRyaXZlcnMv
bW1jL2NvcmUvY29yZS5jICAgfCA2MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0NCj4gIGRyaXZlcnMvbW1jL2NvcmUvY29yZS5oICAgfCAxNCArKysrKysrLS0NCj4gIGRy
aXZlcnMvbW1jL2NvcmUvcXVldWUuaCAgfCAgMSArDQo+ICBkcml2ZXJzL21tYy9jb3JlL3NkLmMg
ICAgIHwgMTYgKysrKysrLS0tLQ0KPiAgZHJpdmVycy9tbWMvY29yZS9zZF9vcHMuYyB8IDM0ICsr
KysrKysrKysrKysrKysrKy0tLQ0KPiBkcml2ZXJzL21tYy9jb3JlL3NkX29wcy5oIHwgIDEgKyAg
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jICB8IDM4DQo+ICsrKysrKysrKysrKysrKysrKystLS0t
ICBpbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggIHwgIDIgKy0NCj4gaW5jbHVkZS9saW51eC9tbWMv
Y29yZS5oICB8ICAxICsgIGluY2x1ZGUvbGludXgvbW1jL2hvc3QuaCAgfCAgNiArKysrDQo+ICBp
bmNsdWRlL2xpbnV4L21tYy9zZC5oICAgIHwgIDQgKysrDQo+ICAxNCBmaWxlcyBjaGFuZ2VkLCAy
MDQgaW5zZXJ0aW9ucygrKSwgNDUgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjI1LjENCg0K
