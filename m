Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD32146589
	for <linux-mmc@vger.kernel.org>; Fri,  4 Oct 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045884; cv=fail; b=aRpqBHzJWUyIX+rJNIHy0D8ocYThhKOjTwXUPR/EFr3fC7/J4oHB6PN/6CzcCFT0XZRM8EUUWH6sgFIdwlqMoF+DxvANjFyMQg9z1lD3Ij9iLINVrb5jxP74dlB/fFSg4zeJGCr8bTRBdwmwJwgEE3NQdQICi5/atxlFsMb2wRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045884; c=relaxed/simple;
	bh=vltVpKsKLAnb8yYoNJjN9/W1vhNXIMo2iKJGTL3+fHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I9Qh05nfacwlOLpbnI4zAtt9p29BWWAsev9RiMnPLW/b2i28nyHENVQ5yM/OhElDRKq8Ngepko/a/PCTEHZt8xi6ycDzswNOYJqNFq7sJmPcKYDPHwA5tBVxbmrABOmi37OpQSfBch/W7Vc+i+TpiA9VBIWPOqfpz31H10WnIZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T3Md8Oby; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ur2Z72cD; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T3Md8Oby";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ur2Z72cD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728045882; x=1759581882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vltVpKsKLAnb8yYoNJjN9/W1vhNXIMo2iKJGTL3+fHA=;
  b=T3Md8Obykctr1LMXXfFdMu9JtBA3dl4N76dduJgsjY/p3e1EjV4pO0cE
   D+L/KCm/bBECRWsxJYvgibkJEkS7ehnRj0d0wNlgM7a38R4NMC4hkiMsJ
   Ru/PhSz98bC5CN6JASmZDRAUG2/EdaegRImJI2TYJpNGrKJ71AennY4hJ
   3qtJGQOxdnhwT1WsXNEQKgEufa+W0T9CMtgqXRvdzlwciFaBklYYplguc
   XW7R+EffwyaF5hKqycBoVmsOqAxJvVWFOUHM9MMk0IntR6pQ/HVSJ0wmt
   D5NNRH4lLpyEc5YXA/UsH+Ai6oBV/dLa93pYywKT2Bh9NS3vI9IDZuJn6
   g==;
X-CSE-ConnectionGUID: Rsc2GGV/SD2j2qKCwwgJlg==
X-CSE-MsgGUID: mWZG2EXHTL2dpSxGnHip8g==
X-IronPort-AV: E=Sophos;i="6.11,177,1725292800"; 
   d="scan'208";a="29325616"
Received: from mail-westcentralusazlp17010000.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.0])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 20:44:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usIS9PSo7ksNNd5RaEYmsvS+aiz8+mdG72cMczQxoMowd364D9unSXHm+Gudk0q+jiG6Ktty1sVkLwTJ0be7/vDhuRAIHXzD6d4X8Y+D+2fwUPsMnBLL+dbppyVpBDzZBAVn2O/cfIQlr9glaPrOTpNW+eB8s43UOV+Sf6fvi7RVtGW+pt5wcN/SW3ZMsWi9SuG1MI7W5TQoeduka4dcD+ikvBgR7lj/LKAax7phQaMYgPizxA1qU8rqDxgfVbMa+RsbUbb29H9VVkGZpwY1KwqBo+nDnRfnn9B/v+1+DfKG+o6QvZkEIaqBsKasMclc7AaSImmIapPPa2XIw4gnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vltVpKsKLAnb8yYoNJjN9/W1vhNXIMo2iKJGTL3+fHA=;
 b=JWLrIl8fJOwoWsizgz1WU04I9UR5OcDxZwPC4ZyrivN5+skz49K2Vuc2f4wXQGXB4Hn+a0heaIJ2Gq9YnaN0OeIOdmHH09Kwg+dvRdyAsmUg0+VBzWw/CIR5LoiB2w+w7IDh+kWwuGv0572vdwhpCIVgtfkw+gSRq5AQqu/wvaDcOIQOtHr2K2eGxQ1hx9pV93d1tQjuFhS0uhSQ17IVGEhafgx785Oo6sZI9jo1ZSpWegiR6T8dU/1azaSuoL+5jx3ul2vWh3fHmM+AEDxeFH3ZAnm1//HFRPx0+ESWesyZJOyVBTXatarQlIIqdh/pMpykfWXtqwlmildxg1Bm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vltVpKsKLAnb8yYoNJjN9/W1vhNXIMo2iKJGTL3+fHA=;
 b=ur2Z72cDzzJXv4f0RzqCMZRLsRD/83rvuYIXbNgEid+iSS9AvzLnjyKsHf5m11395wvDtJBo7vuI58tsR6Xg2hxcZbSDDSJ5Rx1kWVryYkFzcmJ60xZvxOakEOJ3qfIdDIyWMXT0cEIFCTW0tVBFJHm+Vb0COA69myCYcI7Xj0k=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH7PR04MB8662.namprd04.prod.outlook.com (2603:10b6:510:249::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 12:44:39 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:44:39 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Christian Loehle <christian.loehle@arm.com>
Subject: RE: [PATCH v7 04/10] mmc: core: Add open-ended Ext memory addressing
Thread-Topic: [PATCH v7 04/10] mmc: core: Add open-ended Ext memory addressing
Thread-Index: AQHbAdkB8EapvzC+fEmeN3z7QvpkNrJ1U10AgAAP6pCAARtpgIAAM8qg
Date: Fri, 4 Oct 2024 12:44:39 +0000
Message-ID:
 <DM6PR04MB6575A3A74C9D95F05CF15490FC722@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <20240908102018.3711527-5-avri.altman@wdc.com>
 <CAPDyKFqE2SZ1NcsYGpuL4wYW1r6s5Di_4Vrjbkk8uPP82xpoCw@mail.gmail.com>
 <DM6PR04MB6575049927531335ACA5D611FC712@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFo64szpExHeK8Aa=1=XZF2RR90ovVEa-U3SUMJf929v7w@mail.gmail.com>
In-Reply-To:
 <CAPDyKFo64szpExHeK8Aa=1=XZF2RR90ovVEa-U3SUMJf929v7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH7PR04MB8662:EE_
x-ms-office365-filtering-correlation-id: 42517882-3ad2-4b0c-e458-08dce4724fa4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFBPc1QrYVV2RVl5SFo4VktERDVBcXgvQ3VKWXlCSVNNOTlKK2szaTgyRmN4?=
 =?utf-8?B?YkQ1UUVWaE50Q2JyUnhUMnl4WTZ1bmh5Vm4vYXQwNTdod2V4U2NhZTJ0UVFu?=
 =?utf-8?B?RW9vY3drdHdFdFVFYkFFTE94UTFwU1kzdEhYVUF2SW9XdU5VMWZOdFVrZ1ph?=
 =?utf-8?B?RiswK0Qvb3VSK0NxeVZlc3dSSjB5VGhHNDNTWmxpWUJLd3U1VjZKbDVOWi9k?=
 =?utf-8?B?Nk03SlhPTzNtUFdlUFhuelBSb2dTT1RLTFpwaDJOZ0hrVnBIK3pBK1hIRE45?=
 =?utf-8?B?RllOS1FnZFpMcWtGUzF3aDNCOWxLWTNMVUdtN0gvdkVObFFlbW1WTE5QY2sw?=
 =?utf-8?B?THJ5M1lyTCsrT0JQYmEyQXJ6QjNNcGhBU082Yzk2SFFEVEUvQ1FkbFZ6RXV5?=
 =?utf-8?B?TC95bHloU3FQRVJpN0JzcEJ1UWFrSmlma2xrbXl2WE1NaFRuN2RTRzJZb2pn?=
 =?utf-8?B?VnVsLzhRYlJFTmZuRHFQL1NiZHJOd2FkMEcyS2wrSXNUZlpIRk5NZ0ZIbTEx?=
 =?utf-8?B?V3FRRFp0M2pRN2wwem9kSTExaVNKWlRTWDZUdCtwRUZVck1iai9JSWF3WVZs?=
 =?utf-8?B?UmIrcEdQMDZnaVpRSCs4ZWdDTkh4MVNOOUdZQ3BEWFp5RHdiQWdCdm9vbGZq?=
 =?utf-8?B?YmloNHVNN0tkNHluTWhveXNHeVdhWkJuZE4xT2g4b041UmRHTWVnczRjczhK?=
 =?utf-8?B?UERZK09ZUWpZcGpjL1JFV3N5MldzbkdrRjJKanF2QTRkNFA3Yk9PaDZjd1lu?=
 =?utf-8?B?NkVYSkkvMHRiRW9SSktRQ2hVQ0xLeUNiMk1qMExETEY0MTFXa1VzekI4Qm1G?=
 =?utf-8?B?d25CNjM3NWJ0QU0xaloydjM0WHQ4akl3TFpqaTRlZk9CTzBTOG1xK2NjMSsw?=
 =?utf-8?B?Zm43aFNIajg1eERYeGs3UDYxMWVxSVVsZ0k4Q3U4MkwxTzFjRkhzSlJycm0w?=
 =?utf-8?B?OFNNRTlQOVlBWEU5NERETWwwL3J3NVJTd0tJWDRxWXdKM3g4TkNvTHlEVmYw?=
 =?utf-8?B?NHA0S0o1TmswMGJQU3JDVlRxK3VFNmdNOTdSZFRuZ2ovZkphaUJ2aVR1c0tT?=
 =?utf-8?B?cFBDSS9qWWJ3NWZBZ2FSVHJHS0JYcG03Q0I3WEg3YVVrTWhHWFdKTWd5c1k0?=
 =?utf-8?B?UTYydHVHMjBVSVZsNDlXYXZ0cFVPRk1TWlVIL1paa01FMlZIL0hqbWpxdnIr?=
 =?utf-8?B?TTBKU2pTVGlWeDJDM1NnbUFtZVp6aGxCejhQdVZkMGpuSWYvb3R1ZHRvcVdw?=
 =?utf-8?B?M2xjNmJBb2J0N1F0elE2VE95d0QzdEVJbEFRcFJja1hWS3dPZGRWeHB2RlRK?=
 =?utf-8?B?TkozU3BSVzdMeVI3TWlHU2ZxQ0tuR0ZIOEFkM2xWSHhkU2wreTUxTkMyRER5?=
 =?utf-8?B?Y1ozcURjZFF4MXc5SnFFaUpINDIyaThlN2YvdmE3RDJZUndiempvMnBURzdX?=
 =?utf-8?B?aDF3MzhNVDZzZmtqYlQwS2pzdlJobUdSWTN4MmtQTFByY1hNeUhhZmJiU0NT?=
 =?utf-8?B?R0hFL1pyME96RzR0RjZWUHJzKzRlNVRMMDFnaWRjaVk2Si82TVNtcTc5eXNu?=
 =?utf-8?B?VG1McHNMbmVGbHlDamRlNVNKcGFLWWV3b3pPWmVyV2pEZDhIVEhVQnBuWnhl?=
 =?utf-8?B?QjROS1o0ODVPOXhUbVFjamJ2eDAxM205Nk8xUy9WTFA2QUdIeUdOcVY2dVM0?=
 =?utf-8?B?YXJoRGQ1YjUvdEZVOFZ5a09HcmkrazdiQU1rZWF1Vjcxd3NFYU02ZVE5c0xt?=
 =?utf-8?B?b0FPOGUvaTI3M25mOElWLzNhNXYzMGRmczgyMjVrS3NaT2xVTkx6cFFuWVgx?=
 =?utf-8?B?Z0Urc0JMUWJyTzFXVVE1UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGcwR2Fyb04yV3lJdlRITzJ6VVJrNU9yenJzU1ZXLzlvek8wMFh6b2NiUnRx?=
 =?utf-8?B?Y2tES0JPdnpXOEoxSkhhQTdwQlRsOUpJK0gvNllEZG51djNUUjYwN2E5aWZy?=
 =?utf-8?B?U3JPWVQ2R3JDS0lwcWRBS0lYRTBUVnZPdGo0YjJaMWZrYm16ZjFJRzlreC9H?=
 =?utf-8?B?NG9kOVpIS2tBMVc0ZktKQ0Y0UFdxTWNwQTc5aFlmYjBHMU5JRDF3Y3NpZlRI?=
 =?utf-8?B?T3Fvc3ZWMHhjbXNTbzRySWlTRHFoKzlGb1g0UjJvRUdWQUhFaEFNYy9pNnkw?=
 =?utf-8?B?ZlloRnNyRnhBZWRMQVFyNlJSSUxMMzZPVTNhcm1XeEMxUndFcEQ1eFQ2Z3Zz?=
 =?utf-8?B?bXBnRHRGYjFEOENpa2kzK0kyYXc5VTkwNzhzMGZKV1FrTndIZlJuaTljU3k5?=
 =?utf-8?B?bDBuSyttSklSRFpCUjY2VkFobFIza1ZpdzJNS3RaWHBaR1dleUhMVzIwdERl?=
 =?utf-8?B?ZlFncmxBSFM3MDd6STZnOEw5MG54NUd4SEVRY0xzU1QzbDlHcm5XSFl1ZTh6?=
 =?utf-8?B?b3VtT05VUWZpSDhyTTlMamNWS3RTbUxXTTF5Qzg2SEtOQ1JuZ1huai9CMW1S?=
 =?utf-8?B?TXZCdXFCRUdROTJ2SHROUGRheit0MDVxQmIyMXBObmFOU3AvYTgxOE9oQ2xH?=
 =?utf-8?B?KzEwN21nSTJJUGM2RWxyalZQWG9leWpldUU4TU44UjIxSjRrSkJCd0tGMkhH?=
 =?utf-8?B?SXFpS3BQeW5vcnZNaDBvTTlqbWZmUVRIZm9qRHJCOEFOWVpuUG5yMmdEaWhH?=
 =?utf-8?B?ZFdvYnpEVmRkeGljYW94VURtUGhvb2hobzZuYVgrY0pPN2ZxdHZUR3pUVWpO?=
 =?utf-8?B?MElYYkJiQnZSR1RaOXVoR3VpeXVWbzQ4UmxJaFNDbmFWUUFXVWJhR0w3M2RG?=
 =?utf-8?B?aC9uV2RoUHdoVklWeTFucmdIUTkyaGI5WTI0UzBYYmVLQVdZNjVPdFJFWXo2?=
 =?utf-8?B?K1VDVUVxZW1FNEFWSFJxSlZOTytEMlo2NG9GaHg3aW9CQW9XMEw0NXkwdjRC?=
 =?utf-8?B?RWxnYXgveXBEM0U1U3VxSGI5bXNIZk5lajVNQXp6cVVLdEl0am5qYldjcEpn?=
 =?utf-8?B?QUR2Y2oyYVpTQTRScDdxMmlBWW4xWVVTSEVBY1RmWmZ1LzkwR0VvQmdaZkNC?=
 =?utf-8?B?U2FIWTRMR1duSmNlZGlQQ1JKdU1WRHF2VFNoWURVbkZTYXk2V29Ocm5ORTFL?=
 =?utf-8?B?Z1E0aVNFQ0ZsZ3JsVXJ3M1hsbm9kcVNOQWZEZUNkSHcrVVJSSHRSb0k4K2Zl?=
 =?utf-8?B?L1Z2Tm53QmJWNW14Y1NGeUZURmU5RUJkYXIrdmdXbDlFQktVY2VhWktEd2pW?=
 =?utf-8?B?enB2cTlCYm54ejMyQU5mYy9lVmw3UlhUc0gwbXlydXAxTjVLSUc5RTYrZHBL?=
 =?utf-8?B?aEkxUFMxQ2V1R2Z6MTZPeE5IQ3hjZ3JXbjFyc3JTZHZqVHREenZjeGkwdFdl?=
 =?utf-8?B?bXA2WVlCSnBHdldpUTBYaHQvN013c3dKdCs0SlJvQ0NSY3J0aVdUT0EyRGIx?=
 =?utf-8?B?bDk3WG4rbzdJb1RoRU9sUVRpemgwcFhMOHhsSUc1VnNsaFlXc2kxU3UranVP?=
 =?utf-8?B?WXBjdFdPaU1aK0Zad2pDVDR4TWJ0QkppZmdHbGZnNmdIeGVta1BkS2p5Z1JE?=
 =?utf-8?B?YmEybUp1d0huK0FJUFpRMndoNVdVcXgvREdJdEZWVWVEcG1PY0NIRGVyNk94?=
 =?utf-8?B?VGlCNVNlbkdCbXZ1Z3pjOUs1bWVVMGsxbXh3em9qQlVETERrangzYy9DZExz?=
 =?utf-8?B?QmZQN3hXRzdIZEdmQURqOGs0QjVzQlprWUxJT2JRM1dCZ3k4ZkhsK3pJWXRm?=
 =?utf-8?B?QTkvR3VTWnFYODR0SW5QemEvd0NMUHJZRHlzNDZDUjdMS1pMMDZMb3V6ZVdp?=
 =?utf-8?B?RGR2WFpIeHMyMmQxb3ZFbWFQaGVubTVYcVhMT2tkMUdBTDAwZDZDY09VRStB?=
 =?utf-8?B?NEJmUHp4WXptd2F1dGZmTFNuVWVpSXJvUExueWYzRW1YQVgwQ2JOMlhvTGly?=
 =?utf-8?B?cnZPTE5iUVBiSGZjUkZvWE1GSzZ3ellCb0RBZk0za3pwc1JJWGUzTzRJNmlH?=
 =?utf-8?B?VEM2c1hlaVpKb3NMNERKekkxTjRnU0M2Y2dIZ1FHNlBjQitDMzdoL3R5NUtO?=
 =?utf-8?B?VDFYbldsL2dBSmlMWVptSXl3YjNRMDg3eStTVkVla1F6VkVIdG92M1dkNFFO?=
 =?utf-8?Q?sVeO1X0dqwcP+GUNZsDcqmnESrLxTzWdLqs7eQWeInxU?=
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
	RgwPevWU0hKCxKCnxIoPoSaKMFTkqcgnaL48nc76c2aBVaxKXOGYjLU0Q66teLsulZfw6xkBKzuFzDO+77rlYyTBtUzpkwopmI16UHySYtVXUSDMukGZr6uCcf63AyeiYWU3m2yrWyyRzusY8IB3vOtRv0B9SSFpJDnR/dYIdgqWFZAP2LHtkc+Xmgx19JstPt2j/8SYxJCEcazS8Kw8FIUjxJ4J7vvNFHPJhwO90FbCc7wjs2vdoROpKJ+EfR0H9SECiF0B2YUuOZAO3RTw7iMh1U1a+LNf3lCWaJeaJNnDTJaisDbo4zNXFS03aP+Ks1AoMLpzNrFu/uFn/tfsQpdlWJXjuITmEUigCrpvjy1nHh8WRUyjvEDPIpgL7FOEyVrymAxaqPUI0xGL8arRF7KuGcVwj6xrQjEX5KIh8xXQDNi4Yanx6Ie56zcek5nHhTTBZ7D3pR+G0SR/5ty/sguK62EjyNibv07fGMjYv/QWYsPMdMDHNh8fWxTKfKsNWy4JMk6bT+XE5LceuUQUdlge03y3pt5UXqKF+FznY4OvznQmhYrtHW0AZ4qMjzLRlda4tz//OP2vhiBBtt/f4A27w73K1oJcwCzpVo0Zmv0GyaZMlNzIvqRtf2Of9QZt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42517882-3ad2-4b0c-e458-08dce4724fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 12:44:39.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJuCbWzAVsiT2kdcNRx2GLS8Mv5AL82035cLF7zcLJ5Qu2EhfCwoQZTNc7H0XNLcwB14IGwfdfrvMI5PLDiKXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8662

PiA+ID4gPiArICAgICAgIC8qIGZvciBTRFVDICovDQo+ID4gPiA+ICsgICAgICAgYm9vbCBoYXNf
ZXh0X2FkZHI7DQo+ID4gPiA+ICsgICAgICAgdTggZXh0X2FkZHI7DQo+ID4gPiA+ICsgICAgICAg
dTE2IHJlc2VydmVkOw0KPiA+ID4NCj4gPiA+IEkgZG9uJ3Qgc2VlIHRoaXMgYmVpbmcgdXNlZCwg
YXQgbGVhc3QgaW4gdGhpcyBwYXRjaC4gUGVyaGFwcyBtb3ZlIGl0DQo+ID4gPiB0byB0aGUgcGF0
Y2ggdGhhdCBzdGFydHMgdXNpbmcgaXQ/DQo+ID4gSW4gbW1jX2Jsa19yd19ycV9wcmVwKCkuDQo+
IA0KPiBJIHdhcyBvbmx5IHBvaW50aW5nIGF0IHRoZSAidTE2IHJlc2VydmVkIiwgdGhlIG90aGVy
IG5ldyB2YXJpYWJsZXMgYXJlIGZpbmUuDQo+IA0KPiBMb29raW5nIGF0IHRoZSBjb21wbGV0ZSBz
ZXJpZXMsIGl0IHNlZW1zIGxpa2UgdGhlICJ1MTYgcmVzZXJ2ZWQiIGlzIHVudXNlZA0KPiBhbmQg
Y2FuIGJlIHJlbW92ZWQuDQpPSy4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBbLi4uXQ0KPiAN
Cj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
