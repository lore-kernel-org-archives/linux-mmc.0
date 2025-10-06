Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA4226CF7;
	Mon,  6 Oct 2025 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746138; cv=fail; b=d7DXGFCBla3trrNKISK/AGhxGLVv7Lks77lMi8PdoID5HGYUIw+/RZt51CAEo8EHacXhZ4z+EifwrQ96lEAADrVo4g3Hoin8ZlQTWqU28VR0vnRyFBDm1GYEp6jtrbZ9E5bpPRO93t+uQ3nO1Zv3h84dQp7UuWGtVC3BYf1e8GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746138; c=relaxed/simple;
	bh=9j+/OIdyNCdXrtrS/Uq0Ylx2ksw0XyoxhCmwYM2vcNM=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SH/ant/2H2QJENClQa0Dna6UVKiSWo/Q1ZvaAS52mGUzX2fi779JjzXXpS0U/lmoyirLjFGm+/A0Vh5FbfzAh72K3mZkE33ZrFU+Qp6C4gDfQsBTTdwtnoOVoCYaFjVj89zlrmLnyyZ53YVbXVu2qG5/bnS9sb04bVPsekgc2QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gytgzt1Z; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gytgzt1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759746137; x=1791282137;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9j+/OIdyNCdXrtrS/Uq0Ylx2ksw0XyoxhCmwYM2vcNM=;
  b=gytgzt1Z8QwFhL9J4PDEkvIcZdghxzTRi0ai0vVyDSnYVtsiolc3h7Mc
   to2N6ugcuZMGVblCe4tfLD9eU/frUioY8F5Naa6WVlKQKb+H/uaBMPd4e
   tqz8u1KaEAoPgM77LIEo5tfUuMP3U8aE4EH0qItMfDDqTX113VFqZsq3Z
   vGBkPi2RUyE8VbA2oC8EzQ1e6PonSzqwkyC4w87AN2MTqnPpq27zXc8MU
   WQ6EmpgleuibceLbGTwmY34zKb5ED1/jz3r9x9NpFl4CQ2f/2Rp4mNw6k
   3M7ubzrftmg43qknZvQBpmUK1HOifwi8e3Isig6a38E3wK9SH0iSvIjSF
   w==;
X-CSE-ConnectionGUID: qRXx+vzKRViAit2jkQyINA==
X-CSE-MsgGUID: 24FhnVENQxGmvcszHyad6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65747975"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65747975"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 03:22:16 -0700
X-CSE-ConnectionGUID: B0WCnlcFSuuzpCmJPbmaAQ==
X-CSE-MsgGUID: LPwHHz7kR2m7jlEQADcOFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="179784548"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 03:22:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 03:22:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 03:22:15 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 03:22:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hU3NDwom1pH9UqzKUFKtEcUUZwm8WvAXCJhTZUFNh0Y2+3VB9sGYSs4gIcA3G/+Dvkj2W+EiqYiYGmZnHFuPtzeFiRJsnB9wXE4at0yuXkbEqhys3jC/xd/Swqc1H0RRJ4IrbR3PKUUAiNa9rC3u2eBcqOCUiWNwa3JNPY6G2sHnswk5NcasvyUT+i0D0UgnbE/ExKJZ5cOIzi/qvN5MdyHIqS6WY4lmwGGCNMGohVA57II+4NBq68HDE7GZZf9J60r+FgfWH0xNIVQ8i2BLcRaWPTpzdn61Fn8IkMpXY6mQBzpm1NI5rIgoqZFsDc3TnP4Uy/LyCEbqLQhJo3X6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuTEYHHA0dGDtHFSQE829sS4g8dP4a9BQgLq4sfKIPU=;
 b=uAiwovgwx1YJvpewOti1ObXEp2TGqeDHz/s6gWBuUJhxil5/I9hZ5KN9xk1iAz8diGuBMWdneXrsJ/QwRfqRHu7G9as8AnONssRiAoCP58RhpJufROD9WHCppQfyw2tcTpbPwk/SL+IeOs/wNSx1ZuYhbpyIEgsBZ/ET/050PmKCRnuim6ipUarF4ibAo7yVHijm4vChBcMRcOY3OGiDdeetM4sYWoqMXB+Coa9cttJHPUIHg/qp9v1vuUMuNRImOzsPq5rsEX+GSbLY11I+8awxR90nU0iM+gLOTpRTLHXP0T2mbN4bRBFwE2nz2Cp5DEw9HjzyejpUpq9A8C6z7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:22:07 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:22:07 +0000
Message-ID: <957d5c73-528f-4182-b655-116fb6b94f3f@intel.com>
Date: Mon, 6 Oct 2025 13:22:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mmc: brcmstb: save and restore registers during PM
From: Adrian Hunter <adrian.hunter@intel.com>
To: Kamal Dasu <kamal.dasu@broadcom.com>, <andersson@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<florian.fainelli@broadcom.com>, <ulf.hansson@linaro.org>
CC: <bcm-kernel-feedback-list@broadcom.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
 <20251002210426.2490368-4-kamal.dasu@broadcom.com>
 <24a58a70-b4db-4925-8454-78dea4fb22b2@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <24a58a70-b4db-4925-8454-78dea4fb22b2@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DM6PR11MB4721:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fe6145-bdb9-48ac-f3b7-08de04c233a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjllQUV0TVhsZ3FyZHpoUFdaTEtwV1ZGMkpkMCs2UFd2bnc5b0JxSkNCNHdl?=
 =?utf-8?B?ekhjdmZFckxDQmlMQ1J6TEZZTHpjblVHN3dxcHFBTTIvMDBjY1dVNHluRWJh?=
 =?utf-8?B?RENaSUY2eWRoQ1VqZzNLZENRYTB0eWhVU1RwdC9ZbXM2TDB1QmdaeXY3bkZz?=
 =?utf-8?B?elhBeU9DWkFwM05maFZGaitQTlVZRXZwNXF0cEVoVUNFRXljT0NHMER2NTJD?=
 =?utf-8?B?dk5sNEhIOFowblZMSDJDeUlkVTFqZncwRXUvRzVJaDM2SUtRZGd1Rm5yRU5E?=
 =?utf-8?B?dy9hSE11b051OURhZ3huRjR4aitoa1RQeFhyK0Rzb1pZL0gxOGlNbFlFbWcy?=
 =?utf-8?B?K1FTTEkyMDBhampJc2NycVNJQ3hzeGg5RzFSSUs1ejlRR05RMWxtM0F6dnpZ?=
 =?utf-8?B?Qk1hWWE1cTh3QmExZDEwVGV5R1RldnNyc0lRR3BjdGN5SWl6ZDd2RGc5Vkpu?=
 =?utf-8?B?d2tDdDNhWVllVS9qM253dW5DbjNGbnhDUUMzSE9NZEhKZkg1SnI0VW05RDl0?=
 =?utf-8?B?LzVVSExOc1RNTGVlY1M3ZXlUUGdSallybDdKaWFaTndPSjZCbGVJUTZvQjJ0?=
 =?utf-8?B?eHZCLzYzalNHbDFUK2lESVlheVNvRmg4WVhGM2IyOUthb25hTGdBWG9YcjJa?=
 =?utf-8?B?cHFpTFZaSm1YK0p0dlZMN0IzY0VIdmZCblJhOHBic2M4K0VpNmZNWU5qcmlH?=
 =?utf-8?B?UkxoVTMxK2tpL25iamVyS3JnblBEeVBTQW1BMHl0VFNaWC9ZRlZDNjNSR2RZ?=
 =?utf-8?B?WW5UUWFQSTdTaFV0RnJ1MEVYOHZrSUh2RVVVKzRZaldBSjlXb25uYXh2RkV3?=
 =?utf-8?B?U2VCSG91K0wwKzBwSzVsK2hURDJ6aFdvckw4VTdJdkYvSzI5c1BYR0FTdDBD?=
 =?utf-8?B?aVZRbjdNVHBCQUQ5K0owQjAyMDl4RDhTTnp2eUxocndLdHF6ZDViaEs1M0Q3?=
 =?utf-8?B?T0tsU0dkbVA1RnEzb25nVnBvd1h2amdxNnJ0Ykp4NFBTWlVIeE52a0t5SEFX?=
 =?utf-8?B?UEJkbXdOdHVtWjk3RWl5Mno2a013N05SWjB4TGllRXRBOUltRDRHVnA0UDlE?=
 =?utf-8?B?L1hoSlhoSlBCKytnanJLa0JvYmJkZ2IyTFNJQWc2WDBxd2xNOWJpNlVCWTBL?=
 =?utf-8?B?Qm9nOEUrRnU4WnlJTmFYOXRZMys2SGM0WUJ6WDJlU2IyeDN4ZGxETjQxcWNZ?=
 =?utf-8?B?M0h5UFVsekhMVGdwZS9QSGs4VFNCWHEvdDFDS2JmenljM0VuaFlxcE1rdnRQ?=
 =?utf-8?B?bXN2amV3NHRPS1k5SXgwTFVHNWh4OGYxVW5nZ2xxbGc2MTE2YUNURHlZRjQr?=
 =?utf-8?B?bWRaWktaWElVSW5pZ05aNFhKWVErbWp3cWhaV2FmMlpyUDBMWjN0RDdQV0tI?=
 =?utf-8?B?TXRlTisxcnYrb0JGZGlmbWtmWHlWYVZINm5ZdGp6SUZMeHh2S2NXc0JOSkRW?=
 =?utf-8?B?QjduRmJnd2NxS1QxaTlqcE0ySStNSU9kWXRzdzFVaTEvSURYSG14bmw5N2ZC?=
 =?utf-8?B?K2h6aDZtWU4wWXU1dmdoQ1JlcmxuRVZ4OHFFbUNITXI0bGcyVlVTczNYVjhC?=
 =?utf-8?B?WTdmcXVWYlltRGdoZjhoZTJlWE44OXVUNlRGdkczUmh6Y3FRY2ErM3RPNXo3?=
 =?utf-8?B?ZngzYU53WEZrTE1LU0pUaWZiWUpVZnNueUZHYjlwbVB0WWpsUTBGZ3JqcTlQ?=
 =?utf-8?B?TUd6elc4NzRPM3YzOFZ2c1dBdDNnZ0ZXUS9iRU9ZdVRhZldKQXNJdzhQL1ph?=
 =?utf-8?B?MTQrR2YyaGltZjNsRnE5bENISVJFaSs0bHBsQnR2MGhYVWYyUWRoeXJzL00x?=
 =?utf-8?B?WG1xakRQWFlPTWRGUi9BWDZZaEZTN1lhS2FZMUJQWXJGZ3NpZ1B1SFo2SERD?=
 =?utf-8?B?OFdFWEJ1US9vREZ4OXA3WGlnVGxiZ2ZMM0VwSVU3ZEJ0dHB6ek5RV25sMTBU?=
 =?utf-8?Q?RFEnDB1EIxq/FL0Gf0JABstIaOiDvpzS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjFPOWN2TVduMDVCcUttN2dsYkJldE96aCs0ckM0eVlJL2I4aEUxWDlGMGpK?=
 =?utf-8?B?QSttakxRcTdWRmF5RDczL1dxODI4aXlqdnB4amliVHFlWk9nenJGUnM5V0FQ?=
 =?utf-8?B?bFp4TDEvc2lpWHpaSjhWS1dYN1ROdEZST2tCbnEzd0o4Y2RIaE1mcVJIUmY1?=
 =?utf-8?B?WTIxMFdxMDIvWDY1c1VzaE5BWXdFTGhsY2l5b1VyYTVLaEZyUG1TZFRPRDNZ?=
 =?utf-8?B?RVRUaEFqOVRQYUZzaENDelBkOGZMT3dIc3RJMlZMakVFOXFZYXpTbms3SDJW?=
 =?utf-8?B?VGpwUDVWWVpVWldRLzI5QWwvdEdEZTJZdDBBaWFJMzNDWVRudi9RZll6eCt4?=
 =?utf-8?B?S3VaeGpBdHJKWVlHblppdWJQTW5Db3pxRWxFbG45akZlSUtYMHFqVVpFQVd0?=
 =?utf-8?B?TlkxMzJHSnhXSFgwU1Q0Q1I3ZGx5dUM0T1o3ZWlOVU5DYUpvNkI4b1Rwcll2?=
 =?utf-8?B?b1hRVDVQdlF1aEFNQ1FzY1NaaWFJMWdXMkYwNXNaOXdYbzZ6SXNxT1BJekJw?=
 =?utf-8?B?d0ZjTytBd2Q5ME11K2NETWh1NDZheFpTS25mTDFTM093UjRZOFFxUXdncnkv?=
 =?utf-8?B?alF0VGkxaWYyQTIra1V1Wmp5VFBEMWV1b0NGdkFlRjhpRElsTkNGNEh2bDZ3?=
 =?utf-8?B?WmN3Yy9xTzVuY1ZUNTd0OUlsbkpvT0NUWjN6TkN4RmxjSElhcDhDN3MrSHVm?=
 =?utf-8?B?cTVxTXBEcVIxbE83NWJjVDI3OHh0dWczOHpWS1JrMWM3REEwRFhBZVVHZDE0?=
 =?utf-8?B?dWxGR3UxU0FvWkpHSnR0Ny85T3hmRllsYlRMY3M0R1NkMG0yd3BRREZEV2NB?=
 =?utf-8?B?S2VZajY2cGkrRjR6VHRlRG5YaDloMVJoUjRJVml3U0ZJVGo5MU4xY0dESmYz?=
 =?utf-8?B?dkZVYmtkaEtDbWFoWjZtOWNqTXo5am1TOG9JUmdsSXBzY3AyQXdkVEhyNjNv?=
 =?utf-8?B?YmUvY3ZReEJ0V1RSUkNwNHpFME9VVVBuUW5RbjkyRDNsbnpxdktNSFNmQXdT?=
 =?utf-8?B?Y2o2VTZOdXNtdWJCKzl0aVBJN0xmV2Q5TGdxdCtYV3JaUE5WMWJBYndkRHJ4?=
 =?utf-8?B?QTdaZTRIa0lRZmNsdHdHclhkYmN1SHFHNmxyYldldlNmdE5vMmYwZjlIVG5m?=
 =?utf-8?B?Q1lZT1c0WEhkN3hEdkxobURMblhiQnZZZVIyL0ltbThlWkZoaTFoNjZOcGcx?=
 =?utf-8?B?UjZ0SE9LRlJuVkRjWUthQkszeG52QitvY3pITk5BTm9WZ3dRZ1RkYWhOb1V6?=
 =?utf-8?B?ajh5U2RJTE9sRlIweHl3SCtzK2F5Vnl4RklDaHB2dGpTNEhSWi95T2Q4UklG?=
 =?utf-8?B?Y1RiT05vMVV5YVBGdU1ldFVYZkVJdnBEUFVPOENVY1VvYUxCamhJKzhKRFNT?=
 =?utf-8?B?eXBZL3VTajNwelRScWdlUGlKMDhVRUs2WGN4TE9OZXE4WU5YMFhsMUhYb2Ix?=
 =?utf-8?B?cUErRzRwUFAxUWRWZzdZbFRWa0ZnQURjalBVVXlaN0JiTGxzS1hOMHdUdXEr?=
 =?utf-8?B?UWFMWjgyWHRleUtxWGlHQmsrU3FHSEk3aGNmUFVYTmxtUjhUbmZqZFMvVWVK?=
 =?utf-8?B?NnM3c1FQMDhKWUdPOVhDRktWVVFSbXJsMmZFSUh6ZTZtODBsdnk4Q2c5R1Uy?=
 =?utf-8?B?V3NMQ1NST3VWcERHdHRpQzJ5MHluSUVEVHRZQm9JZHlRb2ZUY1dFZTd6VEgx?=
 =?utf-8?B?bUsxVHJvMVl0bDJrOG9TQlpwR09qUFRvUUt0dXUrT1dkOG5yU2wwbzVDZDJp?=
 =?utf-8?B?YmZaZFNJd2N0UUVhNUZTdit1VjV3SXFEOE9DZHpMWENMaTdxdHBlNVoxUzh2?=
 =?utf-8?B?WlR5SFFRQlVpcVFEY2lVRzlMUytTSEppS1ZJNlJ0c29KeXZaelk2aHI1QlNj?=
 =?utf-8?B?RWxLQVFWZlFRdUNjL2FGVzFWVXRtdmF0ZVRZZmtkTDdvTUgxcWQzcWtXbGh5?=
 =?utf-8?B?TTNPcXRYeUVZbStXTEM3QXVOVjYrK0NPQnlrbytSaS94cUtSYlR6L2JSUUFr?=
 =?utf-8?B?cnlKZU5IY21KN1Z6emxURjBwdXRnUk1uTlBpQVl2OCtEdjdDaGd3blZOdW14?=
 =?utf-8?B?TW9RUS9TalNvSlNiR1crZEI5YS82RmJoTHFod0N2eERwbm1TZlFUaTFURWxr?=
 =?utf-8?B?bEN1V1p2SFc3ajJHNE9tS2hZYVJzWHY3NVl1MGVLR2NXSWVjNENLa1RNUlVT?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fe6145-bdb9-48ac-f3b7-08de04c233a1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:22:07.1671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOE0V37BhRymD4z65tWL8bFF7c0b8uaqFq1tuwWCgDWB/irj9K9NhDYd/jRTm4+M2Fdng+HRywdoxJjJ4hCLSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4721
X-OriginatorOrg: intel.com

On 06/10/2025 13:08, Adrian Hunter wrote:
> On 03/10/2025 00:04, Kamal Dasu wrote:
>> Added support to save and restore registers that are critical
>> during PM.
>>
>> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
>> ---
>>  drivers/mmc/host/sdhci-brcmstb.c | 124 +++++++++++++++++++++++++++++--
>>  1 file changed, 119 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
>> index 0905b316a24b..ffa602a99ab7 100644
>> --- a/drivers/mmc/host/sdhci-brcmstb.c
>> +++ b/drivers/mmc/host/sdhci-brcmstb.c
>> @@ -24,7 +24,9 @@
>>  #define BRCMSTB_MATCH_FLAGS_NO_64BIT		BIT(0)
>>  #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT	BIT(1)
>>  #define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE	BIT(2)
>> -#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY	BIT(4)
>> +#define BRCMSTB_MATCH_FLAGS_HAS_CFG_V1		BIT(3)
>> +#define BRCMSTB_MATCH_FLAGS_HAS_CFG_V2		BIT(4)
>> +#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY	BIT(5)
>>  
>>  #define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
>>  #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK		BIT(1)
>> @@ -38,19 +40,39 @@
>>  #define SDIO_CFG_OP_DLY_DEFAULT			0x80000003
>>  #define SDIO_CFG_CQ_CAPABILITY			0x4c
>>  #define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
>> +#define SDIO_CFG_SD_PIN_SEL			0x44
>> +#define SDIO_CFG_V1_SD_PIN_SEL			0x54
>> +#define SDIO_CFG_PHY_SW_MODE_0_RX_CTRL		0x7C
>>  #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
>>  #define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
>>  #define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
>>  
>> +#define SDIO_BOOT_MAIN_CTL			0x0
>> +
>>  #define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
>>  /* Select all SD UHS type I SDR speed above 50MB/s */
>>  #define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
>>  
>> +enum cfg_core_ver {
>> +	SDIO_CFG_CORE_V1 = 1,
>> +	SDIO_CFG_CORE_V2,
>> +};
>> +
>> +struct sdhci_brcmstb_saved_regs {
>> +	u32 sd_pin_sel;
>> +	u32 phy_sw_mode0_rxctrl;
>> +	u32 max_50mhz_mode;
>> +	u32 boot_main_ctl;
>> +};
>> +
>>  struct sdhci_brcmstb_priv {
>>  	void __iomem *cfg_regs;
>> +	void __iomem *boot_regs;
>> +	struct sdhci_brcmstb_saved_regs saved_regs;
>>  	unsigned int flags;
>>  	struct clk *base_clk;
>>  	u32 base_freq_hz;
>> +	void (*save_restore_regs)(struct mmc_host *mmc, int save);
>>  };
>>  
>>  struct brcmstb_match_priv {
>> @@ -60,6 +82,69 @@ struct brcmstb_match_priv {
>>  	const unsigned int flags;
>>  };
>>  
>> +static void sdhci_brcmstb_save_regs(struct mmc_host *mmc, enum cfg_core_ver ver)
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
>> +	void __iomem *cr = priv->cfg_regs;
>> +	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
>> +
>> +	/* save  */

Comment is not really needed.

>> +	if (is_emmc && priv->boot_regs)
>> +		sr->boot_main_ctl = readl(priv->boot_regs + SDIO_BOOT_MAIN_CTL);
>> +
>> +	if (ver == SDIO_CFG_CORE_V1) {
>> +		sr->sd_pin_sel = readl(cr + SDIO_CFG_V1_SD_PIN_SEL);
>> +		return;
>> +	}
>> +
>> +	sr->sd_pin_sel = readl(cr + SDIO_CFG_SD_PIN_SEL);
>> +	sr->phy_sw_mode0_rxctrl = readl(cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
>> +	sr->max_50mhz_mode = readl(cr + SDIO_CFG_MAX_50MHZ_MODE);
>> +}
>> +
>> +static void sdhci_brcmstb_restore_regs(struct mmc_host *mmc,
>> +						enum cfg_core_ver ver)

Prefer to line up function parameters.  Using up to 100 columns is also ok.

>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
>> +	void __iomem *cr = priv->cfg_regs;
>> +	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
>> +
>> +	/* restore */

Comment is not really needed.

>> +	if (is_emmc && priv->boot_regs)
>> +		writel(sr->boot_main_ctl, priv->boot_regs + SDIO_BOOT_MAIN_CTL);
>> +
>> +	if (ver == SDIO_CFG_CORE_V1) {
>> +		writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
>> +		return;
>> +	}
>> +
>> +	writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
>> +	writel(sr->phy_sw_mode0_rxctrl, cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
>> +	writel(sr->max_50mhz_mode, cr + SDIO_CFG_MAX_50MHZ_MODE);
>> +}
>> +
>> +static void sdhci_brcmstb_save_restore_regs_v1(struct mmc_host *mmc, int save)
>> +{
>> +	if (save)
>> +		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V1);
>> +	else
>> +		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V1);
>> +}
>> +
>> +static void sdhci_brcmstb_save_restore_regs_v2(struct mmc_host *mmc, int save)
>> +{
>> +	if (save)
>> +		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V2);
>> +	else
>> +		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V2);
>> +}
>> +
>>  static inline void enable_clock_gating(struct sdhci_host *host)
>>  {
>>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> @@ -300,24 +385,33 @@ static struct brcmstb_match_priv match_priv_7425 = {
>>  	.ops = &sdhci_brcmstb_ops,
>>  };
>>  
>> -static struct brcmstb_match_priv match_priv_7445 = {
>> +static struct brcmstb_match_priv match_priv_74371 = {
>>  	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
>>  	.ops = &sdhci_brcmstb_ops,
>>  };
>>  
>> +static struct brcmstb_match_priv match_priv_7445 = {
>> +	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT |
>> +			BRCMSTB_MATCH_FLAGS_HAS_CFG_V1,
>> +	.ops = &sdhci_brcmstb_ops,
>> +};
>> +
>>  static struct brcmstb_match_priv match_priv_72116 = {
>> -	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
>> +	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT |
>> +			BRCMSTB_MATCH_FLAGS_HAS_CFG_V1,
>>  	.ops = &sdhci_brcmstb_ops_72116,
>>  };
>>  
>>  static const struct brcmstb_match_priv match_priv_7216 = {
>> -	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
>> +	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE |
>> +			BRCMSTB_MATCH_FLAGS_HAS_CFG_V2,
>>  	.hs400es = sdhci_brcmstb_hs400es,
>>  	.ops = &sdhci_brcmstb_ops_7216,
>>  };
>>  
>>  static struct brcmstb_match_priv match_priv_74165b0 = {
>> -	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
>> +	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE |
>> +			BRCMSTB_MATCH_FLAGS_HAS_CFG_V2,
>>  	.hs400es = sdhci_brcmstb_hs400es,
>>  	.ops = &sdhci_brcmstb_ops_74165b0,
>>  };
>> @@ -325,6 +419,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
>>  static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
>>  	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
>>  	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
>> +	{ .compatible = "brcm,bcm74371-sdhci", .data = &match_priv_74371 },
> 
> Shouldn't adding brcm,bcm74371-sdhci be a separate patch?
> 
>>  	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
>>  	{ .compatible = "brcm,bcm72116-sdhci", .data = &match_priv_72116 },
>>  	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
>> @@ -441,6 +536,19 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>>  	if (res)
>>  		goto err;
>>  
>> +	/* map non-standard BOOT registers if present */
>> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
>> +		priv->boot_regs = devm_platform_get_and_ioremap_resource(pdev, 2, NULL);
>> +		if (IS_ERR(priv->boot_regs))
>> +			priv->boot_regs = NULL;
>> +	}
>> +
>> +	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CFG_V1)
>> +		priv->save_restore_regs = sdhci_brcmstb_save_restore_regs_v1;
>> +
>> +	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CFG_V2)
>> +		priv->save_restore_regs = sdhci_brcmstb_save_restore_regs_v2;
> 
> It is not ideal to use a flag to set a callback.  Perhaps sdhci_brcmstb_priv
> should have a pointer to brcmstb_match_priv, then ->save_restore_regs() could
> just be put there, and BRCMSTB_MATCH_FLAGS_HAS_CFG_V* are not needed.
> 
>> +
>>  	/*
>>  	 * Automatic clock gating does not work for SD cards that may
>>  	 * voltage switch so only enable it for non-removable devices.
>> @@ -533,6 +641,9 @@ static int sdhci_brcmstb_suspend(struct device *dev)
>>  	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>  	int ret;
>>  
>> +	if (priv->save_restore_regs)
>> +		priv->save_restore_regs(host->mmc, 1);
>> +
>>  	clk_disable_unprepare(priv->base_clk);
>>  	if (host->mmc->caps2 & MMC_CAP2_CQE) {
>>  		ret = cqhci_suspend(host->mmc);
>> @@ -564,6 +675,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
>>  			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
>>  	}
>>  
>> +	if (priv->save_restore_regs)
>> +		priv->save_restore_regs(host->mmc, 0);
>> +
>>  	if (host->mmc->caps2 & MMC_CAP2_CQE)
>>  		ret = cqhci_resume(host->mmc);
>>  
> 

