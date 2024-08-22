Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419061CB13B
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332662; cv=fail; b=qu6pArZasUCSl+U0/Ic7qgXJWNt5BXYi16tnGBs0GYPyvVyG1b/8pZFSuS3MVjKXxO3uHid54K7Q7O/xSMxUm8MQUf1Qp+yjTMgMp1eOXF4oggYRYs0RKBMcmHCVUVD1HPxO88ZS5HPMxFKmrw+TSkN8trI0Dqi089USqp48GrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332662; c=relaxed/simple;
	bh=UwJywrgiWWgHIlcaAyz5nOV9JzciKN8pxDz1jcVBItg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rWAkJTR7XnBiHYyuuk51hQMYtYy4mlBdt9JURZ7OiWQyLrParSUCU9zWIjfVK56q4r43PwrCUniX4Ua7TRw8AG7cHeJE5egHkQ8YcliFWRZRD8yJnUQ3GeDf4k3TKOnZ3QxHKI71Izea4gs4qLeXqR4HAhsl1IJsf9gEm7BlqJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=j04kU3Ql; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=iPgKtDGQ; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j04kU3Ql";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iPgKtDGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724332660; x=1755868660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UwJywrgiWWgHIlcaAyz5nOV9JzciKN8pxDz1jcVBItg=;
  b=j04kU3QlmiPAgwQU53jfS2OYk8aaUbmN7d7tlDVMuuVFRECiiATzDRR6
   774IsH9nNfaANkKEvr+d2qVhwWD8uBLGyscpOle4Rfp9E27fjjVXX+liT
   uUM/Qh6VZrGteqT4IspQ8B8eehrD2TXh/lxyu7UDXoe/EYYqEvGKN0Zia
   tFhhl8N2UcSbnNtr8zeM6v5tzttCIaL6NhNCiMhobcKwiQ5tXuxnABf6X
   aRG43zHGS870YlzZMKYZI4Tz4pZGicm/+WAZMekJgmtYAmWUos/DbSIwa
   AzTwr2yZ66V6Pm3iEQRqWRmE46wdP4j9pz4JUELItIqvNPS0PNCTQVsl/
   w==;
X-CSE-ConnectionGUID: LFp+ulKVSTmmQS8S+fLLpw==
X-CSE-MsgGUID: T7AN3R+ST1uKpmcb440XdQ==
X-IronPort-AV: E=Sophos;i="6.10,167,1719849600"; 
   d="scan'208";a="25894829"
Received: from mail-mw2nam10lp2047.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.47])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2024 21:17:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBrHXdct/FIMbPe66A6KH1YBgj0fpjMjSM6nmhqRAKF0LJKPPwbKNJ0n4pWIQ060kfC+JKc/nXnHONFk8veaSF/To7NqW9RSXXaaNV1t9N5iFThz4+l85OYhLYUvFWZJ1EIFJ/mFwxC/Zj1dsq01Uxa0E2etof0JyTn0AdHVOrFQw5GYW/y9qG7U/KcGvmLPUmrvWSgkSp2/SjWQCxNdsuoLlCw2AyzW1RB7+e7ZdTy4v6QlsT8TtPlIgQhiLPb+UHY/TaRmNeE++A+ISWdWIkwxUwoTSAUVs/O+s78A/QbNzFRO9Kl2GP5WBJrWZ/wKDF91BzZ5nNEkC3fiGSYEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwJywrgiWWgHIlcaAyz5nOV9JzciKN8pxDz1jcVBItg=;
 b=wgQVI9urBpCt+xaX+B39az7tXWv8Ymcjx97eOLCETxAqz0IPp00rVU0LK0I46dFt++f2m+lonF3aYf5swjnyReCHT04+VwFuDfg9PV+9kPl4bEKxnPKlQzj2bRHcP2LEuNK3sAUSQ3vCg1CDqSkcjgLrc9z1C0yG9FBUGxjJpHFh1/nJE6e9zlEdKvpVpZcvoVWEbfzq3pSPDR7LiPCENvbs9mmvwCnMZgFx/SuuCyNzAw+S29GRXasdo+cUO2tfJ+WEqHrdzFO2Y/bDs7TI4CT7BPi5L/8+R27pYLAl2vJa0YoqEEUJ0dSj614xD24g2sU58A7zUGXEem0LKFVU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwJywrgiWWgHIlcaAyz5nOV9JzciKN8pxDz1jcVBItg=;
 b=iPgKtDGQbW30iAF6Nkns625zvnEa2a1xJUd6htkRt+98Ino0qDdBAlyRgXU9T7Q/1FAv9zpQ36vjKjnBESZZNbTnWKHquawD+vBKr3YZ32WoZU7+jNWkI+fp3lQ7y/Rn8prvHWQCeBJ5HeX4zGxOtJy8hGcnQTOYlnjVUaA6VHc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM8PR04MB8183.namprd04.prod.outlook.com (2603:10b6:8:2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Thu, 22 Aug 2024 13:17:30 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:17:30 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ricky WU
	<ricky_wu@realtek.com>
Subject: RE: [PATCH v3 02/10] mmc: sd: Add SD CSD version 3.0
Thread-Topic: [PATCH v3 02/10] mmc: sd: Add SD CSD version 3.0
Thread-Index: AQHa7hv668NQNgRgSEOPRKJrmoRzCrIzNdoAgAAZHZA=
Date: Thu, 22 Aug 2024 13:17:30 +0000
Message-ID:
 <DM6PR04MB657529AB33E060B23575D07BFC8F2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
 <20240814072934.2559911-3-avri.altman@wdc.com>
 <CAPDyKFrtHX_gK_HU4c5DM+KfG=L8C0rqBg1GkrcdEvLG5vMnbg@mail.gmail.com>
In-Reply-To:
 <CAPDyKFrtHX_gK_HU4c5DM+KfG=L8C0rqBg1GkrcdEvLG5vMnbg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM8PR04MB8183:EE_
x-ms-office365-filtering-correlation-id: 5cf93265-8b56-4dd2-9047-08dcc2acc6bb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3ExS3pHNjYwYzZlNm5YekN0LzNmdXNibFJFaHJZUlZiV2Q1ckZ5SktNM2hw?=
 =?utf-8?B?WVZ2UDFJNmk3eXlQc1gzcy9mbSs4T0lIemZvZTQzdng1WTBDTG5mSmlYQjlR?=
 =?utf-8?B?dUNnN3NmOUNYS3pkV0JCMndIQ1NYTlExTUxsdVdrMjdJRUR4a1o2bnJHZWlj?=
 =?utf-8?B?QkY5Q0NaU1gyeTYwZ0NVam1vZ1IxaVY2aFFud0ZKeTl5S211UzBPbEp5RCtG?=
 =?utf-8?B?ZG9zU2ptS1JvTVZPcm1iczQ4VG9NWno5SkIwUnh3SDVvZjViWjVvMzJyNmRZ?=
 =?utf-8?B?dmQrcWt3TkEzVzg1K1p5UzJZSHBSRnVzTmhWL2RHSDBtWFJYTmlGNTlIWFdP?=
 =?utf-8?B?VVpoaVRPRjVITDdVSUJ6SDdXZnp0ZHNQSERIVXE0Q1RDNk9jT3dMUTBDWTAz?=
 =?utf-8?B?UlJxQ3d0Q0psNzViclVGY3ZPdFIrTndwVTdXWHpaYTZoelNTWVZHWHU2TXZX?=
 =?utf-8?B?UjRHeG1ON1NKOUM3QkU0eFZWbnBBZzNVRlNLQXdmeVluTGtuY1loK3RzRUlv?=
 =?utf-8?B?S0d4YXhESmpIZUYvR1prM3lsaitRZ0ZKUTVId3oxT1BXQWZjM1RhSHBwRCtH?=
 =?utf-8?B?TTdURnR6NnRqZStYOEJuVTRWS2lEQVR5UzUwY0tJbHBGcHJNTCtyVHZDK0x2?=
 =?utf-8?B?RW1zc3NPQVk2TUhpTnJwb0NkZnlncDJIbm9ZemZGMVBocUVMOENnTVNVV0g2?=
 =?utf-8?B?dFNObjRRYTVLRDFvbExWekY3RUptYkRQOUY1cUh0OHZjaXFSS3NuS21oVVI2?=
 =?utf-8?B?NlVQb3Z3dlVWTEZXQzZEUVltWVpkblJjZnYxelBzY3hmMFk4MU9TY0lhQjFz?=
 =?utf-8?B?aTd3bFVwMVZVaVlibWUwYk1Fa0M2R1dQN2pPT1ZSUjdaN1VsVGdyS3p4eGJT?=
 =?utf-8?B?MndqUEhsNmUyWmVhRE9ib1hlRGphSUpUTTlJUWZYSng4eGpyZkNMTVlFdzA3?=
 =?utf-8?B?b1htSzZtZmt6OFMxUW1ZdEVoRFVNbkloZWRpOGFXelVBdWphN1cra0w0czlo?=
 =?utf-8?B?anpCUUxmejRXbnBtdU8xbHBzMDJCRzlwdzArb3hHNVhVYnFUcmxGMDN4MlVy?=
 =?utf-8?B?Vjd1TFZFSjVlUmJTUjd3L3ZFb1JRZGxuMWVWTituWkdTYjZ2dmpubExCZDlH?=
 =?utf-8?B?TmlqNDc0Z25lYTNkeTRMM2pLdVo0M0xwRnJKMlpiVHQ3c3Z6TVBUMi8rU0xL?=
 =?utf-8?B?WEREeEp5cEVGV0FNZ1M1NUY4elNKVEVFdHpPTlNuckhOekZBdFNCdkFIUWls?=
 =?utf-8?B?OGY5N1o3NHpaLy9QSEZYSXJaSnY4U0RGc2tiaW5sTCtsa2hvdXVzbXFwUGk0?=
 =?utf-8?B?QnV5RDJ6RWxMM3BwTk5Ld3hyL3p0WXRUV2NSSUIwOHNWeC9DM0lxL3BwTjlD?=
 =?utf-8?B?RmE2OVZlU1dyK2VqNWhaR0dlaDd2L1RueGxJSHJnRFFSaEN6MXJqd05kanJY?=
 =?utf-8?B?YWtyQjZnRXVWRGVUQ083Z0dRS0xMYWJ1WEpEWG02VjR6TWgweW1FMjFvVU1l?=
 =?utf-8?B?NGFwQW90a09xSDlrcEtVM3JwdnZaUVBvVVhnTXQ1TzZkcWcvQ1QrQ3M2Um1v?=
 =?utf-8?B?am1BWHd1TnorMEJDMnZuZXUxWEVGdVlxckdoSWhrVDljWGFJaTBNY2FtR2JW?=
 =?utf-8?B?NGlLWjBScFBuZEZld0FWMnpyc1E2T2tBaFM1OUJWaXVQWkdQT0lBbzVJUnl6?=
 =?utf-8?B?MVB4c3NkN21Wb203WFAzcCs4U3hPUmtBU3ZpMy9kVDZvSGE0c3lnSlpLQWUv?=
 =?utf-8?B?bUxkKzliS3Y5NVpjWnA5ektLR0o0QjBOZkpyMUhwUm45ZXg4dTJmb3UxQWx1?=
 =?utf-8?B?L01Jemt6OTRqKzlTY2dWYW95bCtKd3U0TjlmaHU5TlhnMmd2dFRlQ1NleVFv?=
 =?utf-8?B?bE5SNU1kT0d4bDNxSUw5R2tMR0d3R05oc2Y2UXN3cHdIMEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnM2eXlleEFLN2t0V0FXVE56NU0wanBKNlAxZ0tMYmJ1OXUxN1ZOVVppempX?=
 =?utf-8?B?TGh2V0Z2UlNqamJxM2I3Nzk0Q2xzeElQdi8yb29JRHQ3M2JJcWtQYmdHVGVC?=
 =?utf-8?B?RytNVExnV3EzdTR3RWtmWEdleHVzVHBqN3BhTGtEYUFZYmZYZlRXNnFtRDYx?=
 =?utf-8?B?TTBySVF5ZFZheHJJMlNIOEZhemVuekdma0loU2ZZNWRzaHdVNHhCNHNIaFNn?=
 =?utf-8?B?MERaUDlhVFJlVFBrb3JlSDZvdExkR21vNEgvRU1ZNC81Ly93eVhiamw5R1Qw?=
 =?utf-8?B?ZGlFempzSVphZ1J0Z3F0Y1ArUGVhT1RlbUpJOCtrYVhaN0FUUW10UHpxaTV6?=
 =?utf-8?B?VzZneTJ3RUZpeitHTEZOenNtcmxsVU5Oa042SCtncDRzcStsdzkvNC9oWGV0?=
 =?utf-8?B?Uk1FbW54TUozak1rTTNDYi9OTFVxQ1gvQkRMZENKODJSQmRUbSt1SWlOVmZt?=
 =?utf-8?B?Si8vOTh3RFBuT1BYWHZjeTJWdS9UVVM4dUxGaVlWK1Q0L010ZVNwbWNlYkZh?=
 =?utf-8?B?eGF4ajNkaXZadkV6U0xlRGNBbW5uT1FjTXJxS2pHbHF0Wk41aXVPOVZzalRl?=
 =?utf-8?B?cGZ4Y2pnUUgyVzJrRzB2MzQvQVdvUnJyRXQ3K0dQSUVrMUJ2UnBWMG5JazZF?=
 =?utf-8?B?TTBBNVpLYjdZUlJmeE5LVDlJaVpHZDNTWUgwb1VCMjFiZngvUzRCeGJPNHJ0?=
 =?utf-8?B?TW9JRnJMNVlqRkRKeThjZ2JZNllUNXpnWitaN0VOeFF4RUFhUWNieWVOcXkr?=
 =?utf-8?B?RnMrRFlpL1JUOTdpK2lsVUdzLy96cXNVRzllUmN0Q0ZaM0tiemIzVzZEWWdh?=
 =?utf-8?B?WCtpNGdvN2JhdEpleVYwelFhdTh2YzYrZWZURnRPSHJmNXZLeEdReE5FbnBa?=
 =?utf-8?B?NEdnMElzdXEwclpKdkJSUWIvaFFtdU0rTG9zSC9MNU5CTzZyclhzaVgxVVQr?=
 =?utf-8?B?K3ByS3ZxbW40V0N5SnR1NjB2dXVUUHBEZW8va0VHQjk2V2pJeWc0NWUvQTFr?=
 =?utf-8?B?c3pVRGY1L1FvUmI5ZkRkalpTZkZ3NDNlRWRCMndzZGN6b3dSNURZV3FnWnZj?=
 =?utf-8?B?NmpBNmg3aGZrTzdUcUFlNkdGYjJwMUNPQkVnTnZqdXVqek8yayswZG9DdUxp?=
 =?utf-8?B?YWdmVVNQS1hHaG83WXM1bUpMNEFNdHc2Z2FpTkdaOUpmcnJMcjhXME1XY2I5?=
 =?utf-8?B?RnBpN29zWnVuL2Y0Q3JqVThuSFBrS3B6M01KMlMvcVk3OXh0R2JHK1VBK1kx?=
 =?utf-8?B?bndmMjg3VVNHZmZDaXkxc2g2RXl4R2xDYU0rMmxGeW5EVnZqREI2c3RINHFL?=
 =?utf-8?B?cjlDaWVELys0NGhEV2JJS3oyU21hNWY4cFZNNGJaYmFicE9BQzFIRFU4alVE?=
 =?utf-8?B?Z3hWUzhTL0ozWG9iNDlXSjJINVBZK3ZrRkd3a2o4RXFpWHhPN21tQUVNKzQ0?=
 =?utf-8?B?N212SzRFMFB0REN5VGU3bXVjSTNlazJGYStUNW1wOE00YXFYQ1BrQ2V6LzY1?=
 =?utf-8?B?L3pGbGJwemg5dGtFelVDWWxvR1VPcmdYd3ZUZEw0eHlYS2lEbmI3OS9ZMm9Z?=
 =?utf-8?B?L0x5a0NOei8vWks2L2U3eDdRbGtPYjVBYmFmMVVZTTltZGo0MlZSemhhU3V6?=
 =?utf-8?B?R0ZMRzZXci9CS0QvNTdhdWJ1WUdwR0RFYWJRTVQyaENPSVRmVTVJVjJwdkFy?=
 =?utf-8?B?VDhLdXJzcWlFQmkyMG93d0g1bW9iZytoUWJYUlFpRHFQb01xWnlYSmVaazRY?=
 =?utf-8?B?eFJFckpxSUFOR2lOak8wTFAzN3JSeit0bU9XRjhoMkJLMWcxb2I1Z1pGZFo0?=
 =?utf-8?B?elNoTnBmbmZvTkx5L1poaE5VaW5Zd2tTRjkrY2pqdG85QU5OV3Roa3ZWOWFF?=
 =?utf-8?B?emNTclpaWjdRZW9oUVYycWJLRWxCRFYrNGk4WGRCK0h3Wk1xc2RJKzJYc0t3?=
 =?utf-8?B?QkVaVG5tbHVtS2VXUXdSMlZjaXB4bmpCeE9vUmFDanRZK2FNeTdxbVN3WVdK?=
 =?utf-8?B?aTZzUnRidWxISFZzSGlaL08vNzVLY3RlQ0ZXam1RNCtmSkwxRmppZEZBQjJs?=
 =?utf-8?B?VG03L3FUR1YvQ2dZQ3ptSzZXMS9malJtdGR2ejZTN25FUWFlalZyQTJESHhQ?=
 =?utf-8?B?T3NDV2E2bEZsbStTdWlDem15ZnJQZ0c1VmxkbUtZVVo5VmVxamtOZWYyaUdM?=
 =?utf-8?Q?P5DG1BVBI8rU+DHUr6FdiiMhEqOHxa6lJ6hcLk/LKBMh?=
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
	nkSOwh4mEKGatmqkQlcb/UXZSMKeJkJJFdWGh+T4IZ58zYclf8SOYmiRtys7J19c6Onw8vnO0aLHsk6dRCD0Xpu0/xp0kYwrEMpt35KQeLtoIcxeLOPompt52mQNEAguK3lKmU09vA6mFu8fhxw0P2MBMfdHLAmfHjKjnY0CLNgPeqaj5bmTWr3IpqIaK1421JEypXeoehUjdL5bxG4+r52jV1PyJlzqV5ktUrpdb4ISAdq5icpujm4CnPjEfQcxVIU48HsVaS4VEFBgfhlznRyHhrXm5TcTH9harVMpNDB5Q2aTkUvpHw2wzuCM/aTnsinuxbaCVlOesPsq8/TjCYBt9q2Xa93MhsUYEdUbuMBX1Iq/ZllKplo4Pq2IO6381SCZrB+23bG0FS5JQflH+OWyErgCziCBTLp+2pnKFW+cHIXQerc0E3Wd/0GdXU5S9ND1hEd3FBfi1CppxwzHs6AKi11REh2jTok+mHoVwdjw8Z1erja8HCF31C9rY/HKiR85/qjLtBv/Otg5Sc9gbnkGXZ07pZM8j1aMF9r9Fq5D77KQzJTDJc/eauEF/r7KsMxts+lH8YljzGWgWyYXC3l4jkEKRZ7W8rKT4JMYuOP0dFNGdLCPmjog/HhKoq+U
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf93265-8b56-4dd2-9047-08dcc2acc6bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 13:17:30.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyovUBh9Y2fCfNtNHPNhCRc7wbtp5rsze+2TnvB5LFKpaW+Z9avhC9HPYAkbH9nuz07hDfsubFCbizAFwmOFQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8183

PiBPbiBXZWQsIDE0IEF1ZyAyMDI0IGF0IDA5OjMxLCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBVbHRyYSBDYXBhY2l0eSBTRCBjYXJkcyAoU0RVQykg
d2FzIGFscmVhZHkgaW50cm9kdWNlZCBpbiBTRDcuMC4gIFRob3NlDQo+ID4gY2FyZHMgc3VwcG9y
dCBjYXBhY2l0eSBsYXJnZXIgdGhhbiAyVEIgYW5kIHVwIHRvIGluY2x1ZGluZyAxMjhUQi4NCj4g
PiBQcm9wZXJseSBwYXJzZSB0aGUgY3NkIHJlZ2lzdGVyIGFzIHRoZSBjX3NpemUgZmllbGQgZ290
IGV4cGFuZGVkIHRvIDI4DQo+ID4gYml0cy4NCj4gPg0KPiA+IFRlc3RlZC1ieTogUmlja3kgV1Ug
PHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEF2cmkgQWx0bWFuIDxh
dnJpLmFsdG1hbkB3ZGMuY29tPg0KPiANCj4gVGhpcyBpcyBtb3JlIHdoYXQgSSBleHBlY3RlZCBm
cm9tIHBhdGNoMS4gUGVyaGFwcyB3ZSBzaG91bGQgc2ltcGx5IHNxdWFzaA0KPiBwYXRjaDEgYW5k
IHBhdGNoMj8NCkRvbmUuDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gS2luZCByZWdhcmRzDQo+
IFVmZmUNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvYnVzLmMgICB8ICA0ICsr
Ky0NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9jYXJkLmggIHwgIDMgKysrDQo+ID4gIGRyaXZlcnMv
bW1jL2NvcmUvc2QuYyAgICB8IDE2ICsrKysrKysrKysrLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51
eC9tbWMvY2FyZC5oIHwgIDIgKy0NCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2Nv
cmUvYnVzLmMgYi9kcml2ZXJzL21tYy9jb3JlL2J1cy5jIGluZGV4DQo+ID4gMGRkYWVlMGVhZTU0
Li4zMDc2M2IzNDJiZDMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9idXMuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvYnVzLmMNCj4gPiBAQCAtMzIxLDcgKzMyMSw5IEBA
IGludCBtbWNfYWRkX2NhcmQoc3RydWN0IG1tY19jYXJkICpjYXJkKQ0KPiA+ICAgICAgICAgY2Fz
ZSBNTUNfVFlQRV9TRDoNCj4gPiAgICAgICAgICAgICAgICAgdHlwZSA9ICJTRCI7DQo+ID4gICAg
ICAgICAgICAgICAgIGlmIChtbWNfY2FyZF9ibG9ja2FkZHIoY2FyZCkpIHsNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICBpZiAobW1jX2NhcmRfZXh0X2NhcGFjaXR5KGNhcmQpKQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChtbWNfY2FyZF91bHRfY2FwYWNpdHkoY2FyZCkpDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0eXBlID0gIlNEVUMiOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGVsc2UgaWYgKG1tY19jYXJkX2V4dF9jYXBhY2l0eShjYXJk
KSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR5cGUgPSAiU0RYQyI7DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdHlwZSA9ICJTREhDIjsgZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9tbWMv
Y29yZS9jYXJkLmggYi9kcml2ZXJzL21tYy9jb3JlL2NhcmQuaCBpbmRleA0KPiA+IGI3NzU0YTFi
OGQ5Ny4uNjRkY2I0NjNhNGY0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvY2Fy
ZC5oDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9jYXJkLmgNCj4gPiBAQCAtMjMsNiArMjMs
NyBAQA0KPiA+ICAjZGVmaW5lIE1NQ19DQVJEX1NEWEMgICAgICAgICAgKDE8PDMpICAgICAgICAg
IC8qIGNhcmQgaXMgU0RYQyAqLw0KPiA+ICAjZGVmaW5lIE1NQ19DQVJEX1JFTU9WRUQgICAgICAg
KDE8PDQpICAgICAgICAgIC8qIGNhcmQgaGFzIGJlZW4gcmVtb3ZlZCAqLw0KPiA+ICAjZGVmaW5l
IE1NQ19TVEFURV9TVVNQRU5ERUQgICAgKDE8PDUpICAgICAgICAgIC8qIGNhcmQgaXMgc3VzcGVu
ZGVkICovDQo+ID4gKyNkZWZpbmUgTU1DX0NBUkRfU0RVQyAgICAgICAgICAoMTw8NikgICAgICAg
ICAgLyogY2FyZCBpcyBTRFVDICovDQo+ID4NCj4gPiAgI2RlZmluZSBtbWNfY2FyZF9wcmVzZW50
KGMpICAgICgoYyktPnN0YXRlICYgTU1DX1NUQVRFX1BSRVNFTlQpDQo+ID4gICNkZWZpbmUgbW1j
X2NhcmRfcmVhZG9ubHkoYykgICAoKGMpLT5zdGF0ZSAmIE1NQ19TVEFURV9SRUFET05MWSkNCj4g
PiBAQCAtMzAsMTEgKzMxLDEzIEBADQo+ID4gICNkZWZpbmUgbW1jX2NhcmRfZXh0X2NhcGFjaXR5
KGMpICgoYyktPnN0YXRlICYgTU1DX0NBUkRfU0RYQykNCj4gPiAgI2RlZmluZSBtbWNfY2FyZF9y
ZW1vdmVkKGMpICAgICgoYykgJiYgKChjKS0+c3RhdGUgJg0KPiBNTUNfQ0FSRF9SRU1PVkVEKSkN
Cj4gPiAgI2RlZmluZSBtbWNfY2FyZF9zdXNwZW5kZWQoYykgICgoYyktPnN0YXRlICYgTU1DX1NU
QVRFX1NVU1BFTkRFRCkNCj4gPiArI2RlZmluZSBtbWNfY2FyZF91bHRfY2FwYWNpdHkoYykgKChj
KS0+c3RhdGUgJiBNTUNfQ0FSRF9TRFVDKQ0KPiA+DQo+ID4gICNkZWZpbmUgbW1jX2NhcmRfc2V0
X3ByZXNlbnQoYykgICAgICAgICgoYyktPnN0YXRlIHw9IE1NQ19TVEFURV9QUkVTRU5UKQ0KPiA+
ICAjZGVmaW5lIG1tY19jYXJkX3NldF9yZWFkb25seShjKSAoKGMpLT5zdGF0ZSB8PSBNTUNfU1RB
VEVfUkVBRE9OTFkpDQo+ID4gI2RlZmluZSBtbWNfY2FyZF9zZXRfYmxvY2thZGRyKGMpICgoYykt
PnN0YXRlIHw9DQo+IE1NQ19TVEFURV9CTE9DS0FERFIpDQo+ID4gI2RlZmluZSBtbWNfY2FyZF9z
ZXRfZXh0X2NhcGFjaXR5KGMpICgoYyktPnN0YXRlIHw9IE1NQ19DQVJEX1NEWEMpDQo+ID4gKyNk
ZWZpbmUgbW1jX2NhcmRfc2V0X3VsdF9jYXBhY2l0eShjKSAoKGMpLT5zdGF0ZSB8PSBNTUNfQ0FS
RF9TRFVDKQ0KPiA+ICAjZGVmaW5lIG1tY19jYXJkX3NldF9yZW1vdmVkKGMpICgoYyktPnN0YXRl
IHw9IE1NQ19DQVJEX1JFTU9WRUQpDQo+ID4gI2RlZmluZSBtbWNfY2FyZF9zZXRfc3VzcGVuZGVk
KGMpICgoYyktPnN0YXRlIHw9DQo+IE1NQ19TVEFURV9TVVNQRU5ERUQpDQo+ID4gI2RlZmluZSBt
bWNfY2FyZF9jbHJfc3VzcGVuZGVkKGMpICgoYyktPnN0YXRlICY9DQo+IH5NTUNfU1RBVEVfU1VT
UEVOREVEKQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3NkLmMgYi9kcml2ZXJz
L21tYy9jb3JlL3NkLmMgaW5kZXgNCj4gPiAxYzgxNDhjZGRhNTAuLjI4MTkzYTliMzFjOSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3NkLmMNCj4gPiArKysgYi9kcml2ZXJzL21t
Yy9jb3JlL3NkLmMNCj4gPiBAQCAtMTU3LDYgKzE1Nyw3IEBAIHN0YXRpYyBpbnQgbW1jX2RlY29k
ZV9jc2Qoc3RydWN0IG1tY19jYXJkICpjYXJkKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IG1tY19jYXJkX3NldF9yZWFkb25seShjYXJkKTsNCj4gPiAgICAgICAgICAgICAgICAgYnJlYWs7
DQo+ID4gICAgICAgICBjYXNlIDE6DQo+ID4gKyAgICAgICBjYXNlIDI6DQo+ID4gICAgICAgICAg
ICAgICAgIC8qDQo+ID4gICAgICAgICAgICAgICAgICAqIFRoaXMgaXMgYSBibG9jay1hZGRyZXNz
ZWQgU0RIQyBvciBTRFhDIGNhcmQuIE1vc3QNCj4gPiAgICAgICAgICAgICAgICAgICogaW50ZXJl
c3RpbmcgZmllbGRzIGFyZSB1bnVzZWQgYW5kIGhhdmUgZml4ZWQgQEANCj4gPiAtMTcyLDE0ICsx
NzMsMTkgQEAgc3RhdGljIGludCBtbWNfZGVjb2RlX2NzZChzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQp
DQo+ID4gICAgICAgICAgICAgICAgIGUgPSBVTlNUVUZGX0JJVFMocmVzcCwgOTYsIDMpOw0KPiA+
ICAgICAgICAgICAgICAgICBjc2QtPm1heF9kdHIgICAgICA9IHRyYW5fZXhwW2VdICogdHJhbl9t
YW50W21dOw0KPiA+ICAgICAgICAgICAgICAgICBjc2QtPmNtZGNsYXNzICAgICA9IFVOU1RVRkZf
QklUUyhyZXNwLCA4NCwgMTIpOw0KPiA+IC0gICAgICAgICAgICAgICBjc2QtPmNfc2l6ZSAgICAg
ICA9IFVOU1RVRkZfQklUUyhyZXNwLCA0OCwgMjIpOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAg
IC8qIFNEWEMgY2FyZHMgaGF2ZSBhIG1pbmltdW0gQ19TSVpFIG9mIDB4MDBGRkZGICovDQo+ID4g
LSAgICAgICAgICAgICAgIGlmIChjc2QtPmNfc2l6ZSA+PSAweEZGRkYpDQo+ID4gKyAgICAgICAg
ICAgICAgIGlmIChjc2Rfc3RydWN0ID09IDEpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
bSA9IFVOU1RVRkZfQklUUyhyZXNwLCA0OCwgMjIpOw0KPiA+ICsgICAgICAgICAgICAgICBlbHNl
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbSA9IFVOU1RVRkZfQklUUyhyZXNwLCA0OCwg
MjgpOw0KPiA+ICsgICAgICAgICAgICAgICBjc2QtPmNfc2l6ZSA9IG07DQo+ID4gKw0KPiA+ICsg
ICAgICAgICAgICAgICBpZiAoY3NkLT5jX3NpemUgPj0gMHg0MDAwMDAgJiYgbW1jX2NhcmRfaXNf
c2R1YyhjYXJkLT5ob3N0KSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBtbWNfY2FyZF9z
ZXRfdWx0X2NhcGFjaXR5KGNhcmQpOw0KPiA+ICsgICAgICAgICAgICAgICBlbHNlIGlmIChjc2Qt
PmNfc2l6ZSA+PSAweEZGRkYpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgbW1jX2NhcmRf
c2V0X2V4dF9jYXBhY2l0eShjYXJkKTsNCj4gPg0KPiA+IC0gICAgICAgICAgICAgICBtID0gVU5T
VFVGRl9CSVRTKHJlc3AsIDQ4LCAyMik7DQo+ID4gLSAgICAgICAgICAgICAgIGNzZC0+Y2FwYWNp
dHkgICAgID0gKDEgKyBtKSA8PCAxMDsNCj4gPiArICAgICAgICAgICAgICAgY3NkLT5jYXBhY2l0
eSAgICAgPSAoMSArICh0eXBlb2Yoc2VjdG9yX3QpKW0pIDw8IDEwOw0KPiA+DQo+ID4gICAgICAg
ICAgICAgICAgIGNzZC0+cmVhZF9ibGtiaXRzID0gOTsNCj4gPiAgICAgICAgICAgICAgICAgY3Nk
LT5yZWFkX3BhcnRpYWwgPSAwOyBkaWZmIC0tZ2l0DQo+ID4gYS9pbmNsdWRlL2xpbnV4L21tYy9j
YXJkLmggYi9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggaW5kZXgNCj4gPiBmMzQ0MDdjYzI3ODgu
LmYzOWJjZTMyMjM2NSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmgN
Cj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmgNCj4gPiBAQCAtMzUsNyArMzUsNyBA
QCBzdHJ1Y3QgbW1jX2NzZCB7DQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICB3
cF9ncnBfc2l6ZTsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgIHJlYWRfYmxr
Yml0czsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgIHdyaXRlX2Jsa2JpdHM7
DQo+ID4gLSAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICBjYXBhY2l0eTsNCj4gPiArICAg
ICAgIHNlY3Rvcl90ICAgICAgICAgICAgICAgIGNhcGFjaXR5Ow0KPiA+ICAgICAgICAgdW5zaWdu
ZWQgaW50ICAgICAgICAgICAgcmVhZF9wYXJ0aWFsOjEsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZWFkX21pc2FsaWduOjEsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB3cml0ZV9wYXJ0aWFsOjEsDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
