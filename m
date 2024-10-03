Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25601433AD
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972699; cv=fail; b=F3aAE33j4gD+JTwl7hxWLt5vPRnMn29032WERn5xNLh5+HUaXKgEMFKTwcBcwuNFDIPHts8dbprpXCs4F27y0NWyr7CKbw1HLZspNaMdt1JM/XBJG7gJkOL6UwEeA6hP/SyZIrNcIawZmNQ0K/xodzZIdv0f0+cx3lrMn1JJT74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972699; c=relaxed/simple;
	bh=M1IGTznbqyTHAvqTnVd9ZalTAsR0jr3WShi05phtr40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TIk9gvrxuxoq4SJ8xK1QQpjzNXsh4jd/ExMusMEoP27/a3Ya3E1x/Li6PgA3GdwKU2uoG3swy2AhoeuornNyAk3mbt3PrBIw6lsLOqY9lGC2SVpe66kO228VpagjTff1IKVWVoAL8Gz/d91+XMA4s+7wDWVsl28DsDgPHXUfP9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=F8SlZpmU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=i+GH7jtS; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F8SlZpmU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="i+GH7jtS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727972698; x=1759508698;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M1IGTznbqyTHAvqTnVd9ZalTAsR0jr3WShi05phtr40=;
  b=F8SlZpmUF2GWimGlyg8MmELn0pz1dOppn+dm0yg/D5VRJEk/MS3Jjmxr
   yMqrTAnmMJBHMPcgpZnpJHvKqt1Oy0tpZSwWywU/389pJH4sbiuYZlgmy
   h7XFuQc6dTxzq0MtRNs1xhbtPCTI1DPBJ84bZXzm5NN+ezUH6COIiXkic
   PQWNg8nZRX5m3lL3VscVU8cN5uWLt2t8IGejNsGIwXBSvZe/ogPTUxhJt
   wSYYsB8Ql/qhMfH/wIeW4mN5FZsBtESg/en0O/7EpTXcf1TAhBx4UbrDL
   Y/CVPaURvlBzlPeCig+hwZjvkHzp8lp3V1CIsUkCgvHKO6FniR/r+NBZh
   w==;
X-CSE-ConnectionGUID: llIu3ClGTFCitelmkRIbSg==
X-CSE-MsgGUID: 18dw2PdsTnicMThik/enPQ==
X-IronPort-AV: E=Sophos;i="6.11,175,1725292800"; 
   d="scan'208";a="28247382"
Received: from mail-eastusazlp17010005.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.5])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 00:20:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyNZ9XRIuJrsZoEW3rAg+Un1UUnnbJE35Kzp2ST2FMRUE2+M4Nr994c+mTfyxQj8y9kq2KQRJPmBh4RvhwkZkTB4Gfr+lnBayFX1Uvgz0Sq4xtE03pe8DNOl1mraAQqtm3mh2z3U+tMgOztLUgCv/aC2IjqhKWDv6quUouAFkUQT1DxdcHJNnNk6Yfdr/CRg4TVs+70SJWe5UNLCfuFbH7SPsmjp/IL7mmWDHcZ321VhbEXYPF/mqJXmM4u9hF9uihhAIpfU4WNB6F3+EfUgrgWJ31uyR8PKoEQHR0LiLmqL1+z+jeQE7Enfun/8SXM5uc0zRstXJqRh5UQieF5tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1IGTznbqyTHAvqTnVd9ZalTAsR0jr3WShi05phtr40=;
 b=PvLxZ/4iZlNczJdb+QCjCUAYqoD+PZ1tt8lq66wOOKQcII0CoDk/FS8t4md6fbqXzyuJkhYNwMQMu+6GhoDc/BdM1Bkfg4mUBsUyz4bAqmaqU4Le2ldiuZ32eFQh7PcKIxMTjsdcaePejnesVEEBW+4RBcDZPzF4NnfHjYntreNpItQbCYfIo2SYeJD4GTmsnZNTcbmPitrf0BwwP76SzgqxbO//biWjnZAcM2/LD7IBH0gcy4oDHqAYGjS9a2/HWC6WNERfjxAwqFtwKOKgCS8NlEf6T+zCPksvTK0X/BJujexTbfygURN2ZJMsqhRbG/yctY+EAOkq9epm+iSLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1IGTznbqyTHAvqTnVd9ZalTAsR0jr3WShi05phtr40=;
 b=i+GH7jtS2age4ZTbJcADOob5repMfoWzDeks3BgNxUj3JXpYG2Xct8VWwJecorAJi9SoQSEFh5j9XWHZIbXg+BVgjyuuzY+FFUUP3cv8ebwDiYkrveYgtZosTEu3Cl+1MeQpU5Zymyk3WleaElUu1UghEXpJEXYwZGAoh7vPfVM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL3PR04MB7915.namprd04.prod.outlook.com (2603:10b6:208:33a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 16:19:51 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 16:19:51 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Ricky WU <ricky_wu@realtek.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Christian Loehle <christian.loehle@arm.com>,
	Michael Wu <michael@allwinnertech.com>, Wenchao Chen
	<wenchao.chen@unisoc.com>
Subject: RE: [PATCH v7 00/10] Add SDUC Support
Thread-Topic: [PATCH v7 00/10] Add SDUC Support
Thread-Index:
 AQHbAdj4vMM0vFxPGUqJsXBRXsqJYLJPRK+AgAGWXdCAABuVAIAWXc8wgApHrmCAA741gIAAAcGw
Date: Thu, 3 Oct 2024 16:19:51 +0000
Message-ID:
 <DM6PR04MB6575DECDE862F88D6F83C895FC712@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <e157fc58-a571-4e57-b885-e011b7abdf28@intel.com>
 <DM6PR04MB65757BAB092322ACCE642A6DFC9A2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFqJaAob7xceSkNe3aNogT55OoY5WRdPsFs450Sy3GhM2g@mail.gmail.com>
 <DM6PR04MB6575AE090B4E4F14DAE2A209FC682@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB6575428FD40ED3CF919AB302FC772@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFp940xfWk=pVb-UOex6LwOrut7pxBm80yPda11D+u4-Fw@mail.gmail.com>
In-Reply-To:
 <CAPDyKFp940xfWk=pVb-UOex6LwOrut7pxBm80yPda11D+u4-Fw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BL3PR04MB7915:EE_
x-ms-office365-filtering-correlation-id: bee17cb7-1e87-43e9-36c8-08dce3c7359f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WW1EdWtHbXFKZ3phVExZWW5RY2RkQ3Z4ZTVHTXV4RHlZUWF2MndlYW5ZSEFQ?=
 =?utf-8?B?eVFKUlZjcFAwWS9wL25TRjdDSnYxTUgxcGEyODErRUxCU0dBbFhnMWU0Wjd3?=
 =?utf-8?B?SkdJeC96dG1wQWJ0THd3c21DKzFTblJTMlVuQWNUNXoxWFdyeVhSNTFjc3h4?=
 =?utf-8?B?bjUweVNqNzlyeVFrYmFaZDJ4QyttOGRYNXJwVlFOam1HOHE1bjQ0ZUxtTTBl?=
 =?utf-8?B?WWM4dUsrcWlpVjFYeERYOEZseXpJYjlEY3M0dnpZZE50elhxRGtzMHJqWmdl?=
 =?utf-8?B?ZTRVZVdtZVh1bEZhOGFlRzYwV0tzdG9ITkxPNElSbFVDMnZUcjRDTkxueUZ2?=
 =?utf-8?B?TXErOHRnYjFwb3hWMGs1M0QrUEJ3R29vbHJ5ZlByQzFteXNuLzVzbDhiQnhU?=
 =?utf-8?B?cE9aenVoOUpyWVQzNUQ5cDJFeHRBM1ErRkJUMW1wVS9EM1dlOWtPdEQ3Z1k2?=
 =?utf-8?B?T2RleGNsWDhyZ0dZNVlpcXhqVjVrWm9nNGhsOG00d0RCZ0RHelVIOEpXdlpD?=
 =?utf-8?B?OTdjdFFGcnF3WFRjRUJTUGFBVkNaa1BRUWhCL2xGcmxoTWNxQlhwMkdXUFRm?=
 =?utf-8?B?alE2QXY0SllGK0FiODhCMEQ0NmI5QVlMaHFkUHFJT2JzTUREcm1ac3JiOVcv?=
 =?utf-8?B?eEVuVlZ6Y2MwYVUyOXBjQ0VUcVY0RloyWThIa0F4Y0tocVp0ejJIRUlzVkRi?=
 =?utf-8?B?WnNJWFpKMkNlM09mMW8yWmp3L0Uyc3JvK2lQeVVEdzJ4R1kwdk8xNkduK3pj?=
 =?utf-8?B?UDRQOXNnRi9leExPZmt3OGttY0wzVEZRcEdrMWlYUkIrRXlnK2ZENnNRdENL?=
 =?utf-8?B?S09DUXMrMlBIRGlhVk9oekNmTlJpYmx3YW9HYStSRmViQXhwRkNCM05TRkhy?=
 =?utf-8?B?c2tmcEZLamcvNHVVMnh0MmpBa09EWGloNUFKWnBKT1puc0tUaS9mWHY0T1RB?=
 =?utf-8?B?bm5JNXZHWEFlem1XbW9ZUC9wZ3djZlpYZDRSWTgwTWQ5T1NVV0F6ZDBrRHF5?=
 =?utf-8?B?YlpMMlNvR1lKV1podjJoMlU4eGtXYjBiVEozZkcxREttSmJuS2tQUk1XU1lH?=
 =?utf-8?B?R1RkbFZTbXZxcFNmYWQza3ZGaGdVSTF3ekt6UVdDbXYwck9vTkdnNVdMczBH?=
 =?utf-8?B?VyszMmNuTWJQSkVoTDVRSFJLUGVtbUh4b054RzIxY3VFSk51aGtpUnJRTnkr?=
 =?utf-8?B?Ulo2N21HWFFxMTlhbHBadDg1ZkVNM0tQMk04TmxMNlR0d1NDREJYZ2lscHhX?=
 =?utf-8?B?bDBJYmsxYXpES3VEY0hDNDZlbS85ZG1VNGhqZkFHNThGUTVFa01NUVI0ZU9t?=
 =?utf-8?B?aDdKditBeldWRk9KTjFkUUxMcm90d1krbUVlMktOUFRjR01QSXVTVi80dXYz?=
 =?utf-8?B?RDZTR1cycUhWbktpamVCdWxGRy9XNDdUME5PWFdSN04zQUNvOFRzOW4ybjZk?=
 =?utf-8?B?SldMeXVhazhoUjA1bXhoOXdTTmZUL1ZFWG4vMjliMWQvejZqU29rQWRwdmFa?=
 =?utf-8?B?R0NZMjBEU0xXRE1aQTZndVJFNmRXVmlJeWl5aWUvcVNrL1pENEQwNU5Ud21j?=
 =?utf-8?B?cDFURzhoZWU4RFU5T29HR3VEd2poZFlGbGEzWTNIMGdzc3o5OFNDVUFyaG9u?=
 =?utf-8?B?MUN0a3dPVkpOUzE3enE1R0xIZmZWeFJGenhxV09CNmZkcHVqbG5YdHZuUzNy?=
 =?utf-8?B?UDJIY2J2dHVRMmYxam5VNE9XbkQ1Z3ZOUXV0SlhQc1FqNUgwVU5tTERHTmpm?=
 =?utf-8?B?b2s1NkttSGF6SkREc3BwSk9Ob0JFQmRkTi9MWDZTMEl3VXZLU0ZBS0Zpci92?=
 =?utf-8?B?Z1ZDQTEwUG1jVEZ5SWlydz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEtDRllQOVRYdld3NTJ6QkFxUDNTVURIMGcxR0k3anJqT29hUkdHdzdCbi80?=
 =?utf-8?B?bEVkaTFQTUdWLy84d2JPR3I2QjhuRFZ2RTF6MGlaOVF0b08wZkwyWmhlTS9s?=
 =?utf-8?B?Wjk0alcxRnFrenVqcEdvVFNISE9DaG1IbDg2S3gwNzlHSUdXQkl1UnpmWWwx?=
 =?utf-8?B?SHlTWlZaSXhjQ3NRc0w0WWdITDV5ZjlVeG1vdlF5VTZpT2pXYXVvRWNDS01P?=
 =?utf-8?B?SGd6V0lFdjl1eVdZOFRXanc0d09YWFJWU3FVME9UOUpRSVhzTUt3VXg1ekhO?=
 =?utf-8?B?Ni9MVzRTSHFDNGxFdVNlZWZKMWtpQ25vT0tvT0tEeEtLNHM1OUVrbmd5eU9m?=
 =?utf-8?B?azVZTXEwd1Yva2hHVXFxWkc2MDVoelU3bjVZVDJPWVlVOW01bGZSKzcyNUZI?=
 =?utf-8?B?YjRsdll6dEhGZnFhbWlqbmQ0TzY2NmxpSzBGclgxM1g1YW9LdU5LRFQvYUVS?=
 =?utf-8?B?RmZneXg0cElKV2lBL2srck5Rekk1T1M2b3laNHhGWFlXVWQwUWFtWHl5Q0t4?=
 =?utf-8?B?b1pOa0F1UUZ1bFp6OXAyWURsbXd5anZ3ZmVuUHJ1WUtjT0Z2aFo2TkgvdnF5?=
 =?utf-8?B?NVhkRGw0eWdGa0tyd21sUDhXalRveHBjZFZvSnRYUzFsMFZRSjRyT01oV29M?=
 =?utf-8?B?RmdjcUxlLzhyc0Nvenh5NFNOY3VWN0tuelJRTFRaS05SSUFQekg0R29BTDUr?=
 =?utf-8?B?aTFISTBJVnJUTU5lcGZ6WDh2MWo0TEZvcjEwTEcrdjlxVDBSUWZYQ0RrR2tK?=
 =?utf-8?B?T2Z0dWE1ZXdHOFlQVUZHb0NSUWN4RDZOVnpIZE1sdWpKZzBScVRxOE5CTGxx?=
 =?utf-8?B?aWQ1UXpaSmlEdDNLaDMrVStKeFdpSUZETThjS2JrWFd5OWk5TWtkME1hNENZ?=
 =?utf-8?B?VU9BencwOWEzeVBPcVc2RUk1LzkvSVpNV0o3ME9GUS9VVTdGMTFTZVF1UkNY?=
 =?utf-8?B?WjRmamgvZ2wzT2l5QkpEWEpYRisyTDBUa2RrME5XQ2pUbThnQjRQMHJlYXVz?=
 =?utf-8?B?bWg5MVgrZzM4aEFoeGZieEl1bGREREpHUkRVR0kzcFowb3lKcU1NZm5OOThM?=
 =?utf-8?B?NGgvYy9Eb1RDbnZNVmxRYi80U0pEQUh1K2htV2NneHNEMEFmcjBycVl3NkZG?=
 =?utf-8?B?UXpnMEl6blhlRklGN21maC82ODZpa0lTNXk5ekJtakQwK1ZISEhnRFNqNmhB?=
 =?utf-8?B?d2UwZlptV2p5OUhzK1pHejN2M2FqYUR1d3pMRGhvRHRFVDNrOU51QmxPa2Fh?=
 =?utf-8?B?VDRDVjFSanF0Yk1XVWpIT3RJM0VDcnIzRnN5UEM0a0ZhS21UWTAvbEhYMjA2?=
 =?utf-8?B?ZWNOQ3lLZEQrTTRHL2M1ejZPazNoczNiWDJNNzBueDJ3T2poeW8xblliWDVq?=
 =?utf-8?B?VEY2Q1ZQdk9IK0R3bXhMRUordGFYRFBlc0NTR2twR2pWTzZabTV2NklNWEZT?=
 =?utf-8?B?b3NoNVE1Mm9xakFLQS9xWklVQVZDbTJHa3Y3WXkyY0IwNW1zR0dWU2xGWGph?=
 =?utf-8?B?eE16WTNhd2drYlB6TkpFM2ZFT3FsWU1vYS90NGlkUVNEVG1JeGRvOWdJeXFx?=
 =?utf-8?B?SHJ3MUVvbHpLRXFKeDFWV2xIVWtOM09Dc0wrL1dWcXlKRmNVb09yLzhENDJv?=
 =?utf-8?B?RS96MGZzUElWYkVXeEd4KzlCbWh4QmRKbFhzUnpUZHd2SUo1VllHVzhHWFI1?=
 =?utf-8?B?VjlRNTRaeTZKalBwRjZoWExraVRnNjAwWCtEbWl2NFdobitMR1dGQTA0eU5J?=
 =?utf-8?B?b2xVem9OYk9uOXZIcE1KODBKQ2JiWXJtekRXOXcwRUhXSndURVV3UERsbGts?=
 =?utf-8?B?aUVTaXFHSkYyYnFoR0s1bTEwRUxjbnRPeVdUanRKdkFVTG9NdUl1eTVyL3lD?=
 =?utf-8?B?M0dqUnIramYwM3piWHdZdXdVdXo4Z3hlMW5QODVuakd2S3JreHBvdVc2Wk9s?=
 =?utf-8?B?SloxN2RhMVYzSm03UWhML3ZtSitPZVpCeUJNcFQvOStRUFRWTExLMmRpN2d3?=
 =?utf-8?B?U0RTdWI5QzVNOGxiK2MvWHg4NU9tV1FRNXdYaU41SDd6YmFnbEU1NHh3ZnRw?=
 =?utf-8?B?RkFYVVNsNkVlVGhwSXVFNVZadVZKUzA3THhsM3VhOHdjQ3lobzFLcVY1bHBs?=
 =?utf-8?B?NDBJL2RpNjVSekZHZWljUVZhcGJoSjdKY3dqRFlFcjREaUkxQmh0SWNSbkdv?=
 =?utf-8?Q?YmuPZaRLNPqDRMhUdSH/HWBnx4xAX/6HAvZqs6M8NgAa?=
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
	DClalF6zL/wxeEugJT0AcyMK50V3lInrHKJjV+GBdtraLZIqI7vdPDfTiI+X7o2g7Vpaj7YqQ/3J2eyXxEjOz3sZe+CXFuTasq16CL8F7qmtm5aVGEi+Xa31dJs5T6ZJHr7Xhe2P/p+VkHBDCanJ3Chd/eXr/gMhUFO7DjE1nJoaJLfrxU0TjdgbVZcr5eELYTkKsS0AXeTA/Y9SYABxgqH2KRGvn68xMgDWRrnwRWdiIn0Q3Uye4htnzQ5WgJ26amwiWjBdYzvx7+yKoQjobRksVylKLv4uQBH9pAoQTZ2dY/fYUDlJtIddMMMlTXEVymyOJOnFGXtWKFzd0deaCWljaCXlMu7fscIUPoyd0loujGvyWPe+AKtEKw5AvjlEp3rxjeEpC5OZcsoFLQ5utKc3zrpF/YMRn4drWWMhHqtJUyb0bGCL/RpbXkBUkuaW4iwyf3xp/uzKLIQu4iKeO5gGK46pNnK26INWgwZ5BNc3LN7lfS/IR/EMebxJ/FCUZckKWyKs3ZgZMVKa34dKdAIQclFi/192rZiA0e4ERW8EmibK8s7BwIi3pgj7m7dChqhU2bEsymqIFQXq0Dz02Xeu8928f6ntre8aEXHF9jf2DiR5aBUzDK6dJAPFyis5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee17cb7-1e87-43e9-36c8-08dce3c7359f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 16:19:51.7198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1c4Jhaok6sOKtvCwo8QoG+kBgNVaqD+EL1mTWVKpRqFHQ66rWnBv3PQxHl4pGd6IRmssTQ/NP/EIwaJCvWtmZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7915

PiBPbiBUdWUsIDEgT2N0IDIwMjQgYXQgMDk6MDMsIEF2cmkgQWx0bWFuIDxBdnJpLkFsdG1hbkB3
ZGMuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gPiA+IFVsZiwNCj4gPiA+ID4gPiBBbSBJIGV4cGVj
dGVkIHRvIGRvIHNvbWV0aGluZyBtb3JlPw0KPiA+ID4gPg0KPiA+ID4gPiBObywgSSBqdXN0IG5l
ZWQgc29tZSBtb3JlIHRpbWUgdG8gcmV2aWV3IHRoaXMsIHNvcnJ5Lg0KPiA+ID4gPg0KPiA+ID4g
PiBJIGFtIGFsc28gaGVhZGluZyB0byBMUEMgbmV4dCB3ZWVrLCBzbyBob3BlZnVsbHkgSSB3aWxs
IGdldCB0bw0KPiA+ID4gPiByZXZpZXcgdGhlIHNlcmllcyBiZWZvcmUgdGhhdC4uLg0KPiA+ID4g
QSBnZW50bGUgcGluZy4NCj4gPiBBbm90aGVyIG9uZS4NCj4gDQo+IFRoYW5rcyBmb3IgcGluZ2lu
ZyBhbmQgbXkgYXBvbG9naWVzIGZvciB0aGUgbG9uZyBkZWxheSENCj4gDQo+IEkgaGF2ZSBsb29r
ZWQgdGhyb3VnaCB0aGUgc2VyaWVzIGFuZCBwcm92aWRlZCB5b3Ugd2l0aCBhIGZldyBjb21tZW50
cywNCj4gbW9zdGx5IHZlcnkgbWlub3IgdGhpbmdzLiBUaGF0IHNhaWQsIEkgaGF2ZSBubyBmdXJ0
aGVyIGNvbW1lbnRzIGFuZCB3aWxsIGJlDQo+IGF3YWl0aW5nIGEgbmV3IGFuZCBmaW5hbCB2ZXJz
aW9uIGZyb20geW91IHRoYXQgSSBjYW4gYXBwbHkuDQpUaGFua3MuDQpXaWxsIG1ha2UgdGhlIHJl
cXVpcmVkIGNvcnJlY3Rpb25zIGFuZCBzZW5kIGl0IG5leHQgd2Vlay4NCg0KVGhhbmtzLA0KQXZy
aQ0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
