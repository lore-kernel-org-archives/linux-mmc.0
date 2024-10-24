Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9E1ABEC5
	for <linux-mmc@vger.kernel.org>; Thu, 24 Oct 2024 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793983; cv=fail; b=tad0Gxbdoa65buiNM3NZE9G3ELXBU6cTbdjJt6wsFyC9jWs1J9i+WawJrkQDO9xxfSnpxVXLlNwTUDRDSRyW31jdhw1ygrGHjMRRJ2XtyjvgB9DJE2p5jLxl3kXed/puTxIDFk2TLVM0lJW3+J9Fc1XPk6MWO0RH1q6u+UFGV2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793983; c=relaxed/simple;
	bh=9F6bX1wS4J4FgyHevcne0vkGDJLCsntXuW0CyfGXz4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CFgOPz9IPY3DNapAkXY4Zdaem908Vcj4bo0f8FvJftBfvRkl65CpkHAhSAwFTCw6lC+aWcqDitt1Ccg/m6I6iQhyGZ40SFcREErgBQ6B5fqWeHttPil5D/qA1RcNq533OU5VLjI4BHW4Lj2gr2eDfXqsXnl3PdYKQluotB8QvwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L8gNDgRg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Pwr+Ipda; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L8gNDgRg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Pwr+Ipda"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729793981; x=1761329981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9F6bX1wS4J4FgyHevcne0vkGDJLCsntXuW0CyfGXz4o=;
  b=L8gNDgRgI7V2AZjfRN81nPAmHcUYswVoeh0qrjzldJFuxr3Mu8f6EYEu
   UgIcqwKDLoC0TPZcJy5yKF1mN1evc+Gwi8zJK0k2ITuTayPn2OdM6xFGv
   SMupE2rRfcnLZj6XaeW2Xz1TdqZziVbi3/FuS8qgyaQQ0GEu3YbUk+R6a
   PzEXWrO+g2fiJDTD4MZ+elSIPo/GqIZqAUofp/AiOBt77ZP864icdm2Nk
   KInrU8l8lfKZuO4bP174dtobqK7aV8BohnMc0s1ikNyzY7Lh0lcpHy3tF
   gJRHMehcPRPpfLWTYTgytuhARzYbwp5/zaatp1oqxZnYzPITg5mvVoc5W
   w==;
X-CSE-ConnectionGUID: VJvMjRi3R1234vxZcf2WPQ==
X-CSE-MsgGUID: fKt/ksoCQC2CHLoBgrilrQ==
X-IronPort-AV: E=Sophos;i="6.11,229,1725292800"; 
   d="scan'208";a="30909336"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2024 02:19:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG0LkHopy+6013XteN2FH5J4M0DaKFuuab8pO9DYuo9lo4ZXcV1g0yZAXiMX4T3aVvePdJnH+5PEWfq1CDOdFBBX6CDmF/XO3QwIViqe9TSBVztUt+YVH1R6zDDnzkiBIZ8JaKIULpNL56nELaaXzMETEtphyKzrEa9v6wG/yWzHH7u074lV3DiWMR2JZuzpxgjI8qUIcEbA6TNytbKCBbeHH9niWyStUEvrxaNQQBJf6TaFKi94ukcknzTHdj4+LDp1IdMkkux7bVEhysg2WORfmZjB+/pRCGhqohWTS28Chv7km55kmBck+XIv8665qxZoKFqc2WxJ3CtA3PYTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F6bX1wS4J4FgyHevcne0vkGDJLCsntXuW0CyfGXz4o=;
 b=EwqdmrLwlXiQ+M5zBnlKMBX1HphwfZJPu3a8UjoxLxz9mRjAt5LRQkiHHxFclTLDrXbDX+0blgAABMtIHzqRnOV8O63GjaWn5VfYPaD9LehAve6DjBBuQZ9OVfT5eLj0hwFYOoKluqG3sVihQiJQ6tBnl+nAPbeNm1OAzJLcMFWNPochhY2OLIL4RDKApYWnKBbVQ2SLDgiVJIDQgtT4bY4XBpBPPpNADSHFYMEnCmqDqgEOa1DI1917D5m9ksQUp1R0H87OKrHpVUWakUMOPnJ9BQte8tRJB8aQAs+1WK0fXgS/FgYaStS9QVObjwtCyJU/OjUwq7g6RNN2ezyn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F6bX1wS4J4FgyHevcne0vkGDJLCsntXuW0CyfGXz4o=;
 b=Pwr+IpdaEX7DAvCtNGHI3upU/YS5gTawitQE1gq6x7cbWiTY6tZYHlvAzitKdbehudLzEZMVUiDap1mT2oUFqUN63gqbQbniRZxkRzm4EmNl7WUbxOVmQ9uF9fQ/5UK4zCJLl1+m6YvyhiWZug2hPGKdEW7UV9iqeCokJKNDwcc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6382.namprd04.prod.outlook.com (2603:10b6:208:1a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Thu, 24 Oct
 2024 18:19:31 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%7]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 18:19:30 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>
CC: Bean Huo <beanhuo@micron.com>
Subject: RE: [PATCH v4 2/5] mmc-utils: Add FFU mode 2
Thread-Topic: [PATCH v4 2/5] mmc-utils: Add FFU mode 2
Thread-Index: AQHbJVlT0y7rmkKGKU6F4HPVZG20oLKVihKwgAASugCAAFfRAIAAQbOA
Date: Thu, 24 Oct 2024 18:19:30 +0000
Message-ID:
 <DM6PR04MB6575BEE89D1BB00936AC702AFC4E2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241023143839.108572-1-beanhuo@iokpp.de>
	 <20241023143839.108572-3-beanhuo@iokpp.de>
	 <BL0PR04MB6564794698F1DF0223380CC0FC4E2@BL0PR04MB6564.namprd04.prod.outlook.com>
	 <eccc31a9689842d711e163a2d4d8b14f97100f83.camel@iokpp.de>
 <11ab9fb918d7ceb15c75560086b0b988db2ad24d.camel@iokpp.de>
In-Reply-To: <11ab9fb918d7ceb15c75560086b0b988db2ad24d.camel@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN2PR04MB6382:EE_
x-ms-office365-filtering-correlation-id: ecd03d81-0bf9-49a7-765c-08dcf4586760
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Sk5aa2VZNHpqK0c4NlNlVUhyWHlYTnhlY0tOa1pPWmVpV3lxNFBUNzgwamkw?=
 =?utf-8?B?dUQxanVXUHIzQjVZMkIwdGJvVzY5VGpXMEo2aWNqKzhrWUR0SUduVVpOUDBq?=
 =?utf-8?B?R3RiYVBhUWgwQXZLc1FxcUo5bCtUT3FvcFpyMngzb0pRRkRjQ1NINDcwQ0NP?=
 =?utf-8?B?K0NIeHd0TWpTRks4dGRtLzVaQzRHUXJsdHhNdk03NjBhTElSRm5aZDhPMUpE?=
 =?utf-8?B?RVcrenFja3VBUll4RG1IaWIxTVpza2JqQ25BQkwyV3JPb251L0lxYklRZUJW?=
 =?utf-8?B?Si9rTmRZbE9UZjZwdVhIZmoyY0FFSFJ3K0UyU3l0WEl0SnNxYWlQTWllcjNt?=
 =?utf-8?B?TDliNEg5UzRxYnJDN3RvZE4rTDBIeWh1eDArQWh6SWFsRUEvVStDdlA5MnBB?=
 =?utf-8?B?V0dmV0dMWldXTlZuYWJyNTA5THcyVzFEU3gvOEtkQ2E2NXN4NVdubEFKY0ZT?=
 =?utf-8?B?VmVSZWhvNDNTeG1CY0hMMXQwcEpCMTgvbXU1Tldwcy84S1RvNUVFbVpCeXBD?=
 =?utf-8?B?TmRQWEFzSzY1Z2JjNTlZKzU2TDJjVlBUcG5HRnRPUVRxWGdMa0hqd2JXeFFF?=
 =?utf-8?B?MStZa3phN2RaZjNzRUNSVGtkYWFJYjdtTWgxVFhEemRRSWRsTWU1R0ozczlr?=
 =?utf-8?B?S09OTlZZNGp5R2tOSmtSREQrTFBSU29IVExoRFhpTXcrRno5Vzc5S0lDSVBX?=
 =?utf-8?B?UUIwSmo2MzZKcG9aOVppUXFyUWFQZUQ1TTlJUU81cS9wWUdxaGJQTGRaVDI5?=
 =?utf-8?B?Tjlzc2dJQ2I3cUNSdnpoZW4wbCs0M09OZHRlQUhET0ZBbElLakI2WEVYSkR3?=
 =?utf-8?B?QUNWK2JVVEYvZmZRbEN5eTRSZWFUeitoR0NuOEg0Q0xLdWovVjkydjZmWDJB?=
 =?utf-8?B?TXN2QXNqNGsxTVlUWUxQVmV4RktJY1Y1ZUJ6a3B2Qm1FNDJzZXdDVnpKL1hN?=
 =?utf-8?B?T3JJZVkwWFlFUnpIT3ByUXU5Vmk4djR4bFI2cjgyNVp0b3NCZFh5Q2RKTVR3?=
 =?utf-8?B?ZU5YbU4rOG9PVksvMUN2ZTNpNVVlYjhnaVBsdUVqT2ZVUmVLdE9YYW1WYTNK?=
 =?utf-8?B?QlYrb1hKYmJUTWNrZG1YNFVSNWhGRFRFVXlURTJoNllUWW1WeWtNK3dwQUox?=
 =?utf-8?B?L29GWXBsak5qUFh2ZW94ckxDSm85LzFiNGtpMDIySjd3VmZFV1lSWGs2ejB0?=
 =?utf-8?B?WHlTQzljZzdDdHZhK2YrNTZPTGE1UGl3NGo0QkR1OVQ4UUlSZnExdExiMk9S?=
 =?utf-8?B?SDFLVEd6SHVqa0NqK0RJdU45anBybkRoa29IazVGZWNNTjBYZ25INVZJcjNk?=
 =?utf-8?B?S1pXT0ZOaGF0Q28wQ1YycjRjTnlDWWJ3UzNxOXpIUHQvdEh5UW1kaThLYVF6?=
 =?utf-8?B?b0RzUkpoVEpjWXlOb3hmaTY1WCtwS3o0b0ZsTHZDR1ZkZ3hHQ2RiMlI2SUM1?=
 =?utf-8?B?L0dGNlluR1lxK0NDWWdFQmZjaFo3enlJZGxyWmlIZzIrRXV4dGFHOEpic2dG?=
 =?utf-8?B?S1h4YTA3QVYzank4eTNNd2tQWkFYVlF3d09GTW5vVzRKckQycW9YSk9PSlFl?=
 =?utf-8?B?SFpobmd4ZzhIZXVtdlFwVk8zNzd5Tks4Snp0T1JaUlo5Q1FoSDdjdmJOWmc3?=
 =?utf-8?B?RnBmS2lLWEh3NFhRNGNOSWRmQ3lSaUY0Z05EYTBObnlYZmltL3ZndUtEZE05?=
 =?utf-8?B?OTV0bGNyZHhqdkpoMW1OaVI4YWZBby90RWdVMEJUU3lqaWRpY3ZLQW1yUlJI?=
 =?utf-8?B?TENZemxmMkJSK2xZT05pMWk0RTJ3VUJFa1JKYmxPRHJmMDdGNXg3QWt5ZXJz?=
 =?utf-8?Q?e6iOd60iB6FrL77nCHPI5kGIkMbbF0bYwd+Ls=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjdWdmxLT3NSRWU0Y3NiK3dBbkFWZjBLVHRYcURidjFVblFBd1FyUG9zWWZ2?=
 =?utf-8?B?ZDFoUkJWNEVyS0pUVkUvVm5kZ3ZVWTlHelRqMzF4QnUzTWpWNUZqdzJVNXFD?=
 =?utf-8?B?UzU1ejVPa05DdGo2MnA1QnZUWUhnR21lUjBLRy9rRDhFUmg5cTlCVURPMno0?=
 =?utf-8?B?VDhNUlpabC9pdmpqaTU0WllITUtFOFdyem5LbE00WXFXWjBndTN2NGxiSnhm?=
 =?utf-8?B?c0F2bzB1d05BN0tna2JEQU9LRnhCeHBKa0xram5yT0NiVTNEa2RDN25DVlBk?=
 =?utf-8?B?MGRqcTN3c0kxVllySjdNdmgvN1VSYVAzWHM2ZVJzLzkwTEM5TDlZbE9MK0N0?=
 =?utf-8?B?d0VTcWlRZHNiYmxmQmFXYUNjWFFvcmZ5ZEwyNmVBRXA0UnlCdFEvNG9tbjZq?=
 =?utf-8?B?NGVJNmlxNG1HQURLWTZNUHV0aU5kbHBlQ3ZZSEhyNTZlcCt6Q0FZVXRkRzY4?=
 =?utf-8?B?Zm1waHU3Z1p5NkNZRDZ0dDEyZG9OZWJXNXJzTFRSMFRKL0JqR1ZkODBxSU1x?=
 =?utf-8?B?Tm5TYXQzR3Z0aGk5aFZTeGNRMjcreVFZbnlXY0JBeWprL0xUcVBDK0p1b1o2?=
 =?utf-8?B?ajM2N0hudVNjZ2RlZkYyMzlDUk1oRnd6NFZqK3hRQVlqbU9LRFNheEc1c1dZ?=
 =?utf-8?B?c0s3K0EzejV1aWFnaHAzcEdFQzRiKzhlOEJSRGRrbzNQdVdpcS8vY1dwYll3?=
 =?utf-8?B?ZVRMQ2pIbGg3eFg3Wm9oMThoV3lPK1lDR3Z2aEhKWFl3dUQrN0NoOGNGRlFk?=
 =?utf-8?B?R1ZwMmZsQ21JZzFuanVod2drTXQ3aDlRVitWZTdDd1lyRTI4MDN1VzF0cWlr?=
 =?utf-8?B?Nk9WM1k2OFpXbk1ZMnAyQ2FkN09hVkQzUmJDb3BubDEvUlRnRmtwWEVzNlRE?=
 =?utf-8?B?M0tWVXdwalVsY1RrTUxPcWZiMmdveXJ3dk40d1gweHVmUkpKMWR1ZURrYTNn?=
 =?utf-8?B?eDd0K2JiQjlFczZLRWxYd0Vib0pRdkhBMmcrNnNhVUwyRTVDWS9vYWJqQS9z?=
 =?utf-8?B?ZWJHcFNsc0d1RWNKeFpXUnQvZzBwaFYzZXVQUWZhbU12LytwOWpadG1sVXNa?=
 =?utf-8?B?aTg2RU56dEtKcko2TktYZkFCQVAwdjRaVmU5OVV1eG82dXI1SnNqZmpWTlJI?=
 =?utf-8?B?R2VTcGs4VlM3a0Y2Y0ZEL3dZcCt6aURWdXk0U1QvY2V1ZE8xUjZ3Z1BiRlly?=
 =?utf-8?B?RzlaaC9JS3psUlowNlhxa3VHQ1haOHhFZXFCcWUvcHZNbGJCRVI4SjdFVEo3?=
 =?utf-8?B?QjQ5eiszQnNhQzlxM1hWb3Eram9FTjZDbGFqaE5NT3JBU2FwcEw0RittYnB0?=
 =?utf-8?B?a0xNcmozL1laNGRyQW5Jb0RvaDJUZzNnMnZySFJodmlIV2Fkb3JnUWNFNjlh?=
 =?utf-8?B?WEdkUnhZRlRKdkxYYWFtZ2Flb2V6d25ZUHhhNFpqM1J1UmVvYi9qMStrRDVi?=
 =?utf-8?B?eTl4cG5Kc01CRXJMdlkzaFQvMUhOcmxSeExnYVF1aTAwMUJCU3Rrby9DQ0V5?=
 =?utf-8?B?OURLdVFWZ3hhWEk0UGh0cy9RdjBwRE1YTnRrcTltcmIxUXV0QjMwdDJNSndn?=
 =?utf-8?B?U1VTdE9iY0ppcDdxdkptVlEya3VSaVl3U0o3L09nbTNHNkU4QUtZY0tCeGVl?=
 =?utf-8?B?NFU0dWJKT2FrOU9sMWlQRHRvUjhJWnlMR2pVSlpTWGVzTlNKWEQ5QVU5cU01?=
 =?utf-8?B?M0ZSenBlbUE1OE1VL09lam1MdnBnVDlzaFhUMXdoZmRxN3d1Z2hRUmlzQ0Ir?=
 =?utf-8?B?MENGMjgrTXhtM1Vvb29kK1h2dnR2L2Y2RmtIMDB1K2pqVHVkTU13dDFqZUFy?=
 =?utf-8?B?M1JWK2JFTkpNU2VuMHVQeGg4Y3poamtNRjBMYUs3eWJOeG5LekM0ZUJKNlVt?=
 =?utf-8?B?dUsvVlVuTkxET2xZcnpYdmpsblAxZjYxcXVFeWJCYTlnWmwzMldMNFR0WDlC?=
 =?utf-8?B?WG9tVThkUjRySFM1VWl2TzNpOUZSdE1BRUZnbTNqMUhLSmFTN2t3TzVySmpp?=
 =?utf-8?B?U2ZpL1NRVzh4RTFMaVNvYzVETjFJMlBXSFZPeFZsMXU0SmNjWEVkOHVBNkdG?=
 =?utf-8?B?MEhsaGJ6c29QV0QySnpNalhFTllyejRIRjNYUnlpMFhtVCtUaW9zL0RFN0Vl?=
 =?utf-8?B?bEc1NDJKNzhUQkQ3SGdGR0dVVy9HVUhRbVAyOUVEVnZ0a2h0bUc1eXdZZjl0?=
 =?utf-8?Q?ywQeAHak0rYuDZzd5juIdiNxsk90JHQKvmeybpuDlgr3?=
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
	lL6oxz5yNEXkDBS1SzvbwwPMci+rqIe1eTPCJBq1CWGBbUyDW0i7Qd94uG6ej3JjLiIr38ItKC9PtKnc0V72pybuf0tXcWJymnst6O3NIUGDbS/Jxw7rI2dcYTGIdtQbqr0SONstYp74IpsT5we+08DFL6CZTD5I16+e3rthiyeIKkmdqJXAvJfX7PXHvAZZhnWNBQ4vqrLAwglXl9LdruDA3qOz90XhdYO+WqEtdRJz2FbJuVQkNRGmm1tcgzkPkqGDJLGB6Kvh5gt1LcaT3/VecO26fgHjgMoVD+oSWc6DRUNH7J5fN1N2fSAUPj9SS2Chgz5CJAc48SyUdu3nKi30ZAhcPdNhF3nu7QX2K652IyN+GqriHzKHf8u56pZ9YfXUBIUIEAgxDIg4VrVvb1AsTI9HNNTVFoH+ysfs8DpRNJS5ysVeRkjHBzemBzCQVzGOYebWfCrIY4NGa0IAFBgXd0OaSPsSJD/1Q+0bKCoeeuKPFwUNjPqErUmLfExg5EQZLSxAXdwMpMjhsheZYB+Qj207OccVvgRktPVfXkPH/qOCNgitGMK5qJ1B4HmtCF+uiP6nYwKO20eqoZyvKpxXcQuKN80tBtP8BCY2KTzJDhTWfKFbhAuMEUW8Fypc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd03d81-0bf9-49a7-765c-08dcf4586760
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 18:19:30.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7PSzvq6b8hdyYzkLUSYigD0+7ywTNCIF4y7AVQtZUZk32RQIYKKh0aKqBH0w/iMaj0n+FNH9wLnQi+KowLKShg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6382

PiBPbiBUaHUsIDIwMjQtMTAtMjQgYXQgMTE6MDQgKzAyMDAsIEJlYW4gSHVvIHdyb3RlOg0KPiA+
IE9uIFRodSwgMjAyNC0xMC0yNCBhdCAwODowMCArMDAwMCwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+
ID4gPiA+IC0gICAgICAgeyBkb19mZnUsIC0yLA0KPiA+ID4gPiAtICAgICAgICAgImZmdSIsICI8
aW1hZ2UgbmFtZT4gPGRldmljZT4gW2NodW5rLWJ5dGVzXVxuIg0KPiA+ID4gPiArICAgICAgIHsg
ZG9fZmZ1MSwgLTIsDQo+ID4gPiA+ICsgICAgICAgICAiZmZ1MSIsICI8aW1hZ2UgbmFtZT4gPGRl
dmljZT4gW2NodW5rLWJ5dGVzXVxuIg0KPiA+ID4gQWgsIGJ1dCBkaWRuJ3Qgd2UgZXN0YWJsaXNo
IHRoYXQgdGhlIGN1cnJlbnQgQVBJIHNob3VsZCBiZSByZXRhaW5lZA0KPiA+ID4gdG8gYWN0IGFz
IHRoZSBkZWZhdWx0IG1vZGU/DQo+ID4gPg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4gQXZyaQ0KPiA+
DQo+ID4gQXZyaSwNCj4gPg0KPiA+IENvcnJldCwgdGhlIHJlYXNvbiBmb3IgdXBkYXRpbmcgdGhl
IGRlZmF1bHQgRkZVIG1vZGUgbmFtZSBmcm9tICdmZnUnDQo+ID4gdG8NCj4gPiAnZmZ1MScgaXMg
dG8gYXZvaWQgdGhlIGVycm9yOiAnRVJST1I6IGluIGNvbW1hbmQgJ2ZmdScsICdmZnUnIGlzDQo+
ID4gYW1iaWd1b3VzJyB3aGVuIHVzaW5nICdtbWMgZmZ1Jy4gV2l0aG91dCB0aGlzIGNoYW5nZSwg
dGhlIHN5c3RlbSB3aWxsDQo+ID4gZW5jb3VudGVyIGFtYmlndWl0eS4NCj4gPg0KPiA+DQo+ID4g
SSBhbSBjb25zaWRlcmluZyBhIG5hbWluZyBzY2hlbWUgbGlrZSBvcHRfZmZ1MSBhbmQgb3B0X2Zm
dTIsIHRoYXQNCj4gPiB3b3JrcyB3ZWxsIGZvciBtYWludGFpbmluZyBjb25zaXN0ZW5jeSBhbmQg
a2VlcGluZyB0aGUgbmFtZXMgY29uY2lzZS4NCj4gPg0KPiA+IGZmdTIgY291bGQgYmVjb21lIG9w
dF9mZnUxIChpbmRpY2F0aW5nIHRoZSBmaXJzdCBvcHRpbWl6ZWQgb3INCj4gPiBhbHRlcm5hdGUg
RkZVIG1vZGUpLg0KPiA+DQo+ID4gZmZ1MyBjb3VsZCBiZWNvbWUgb3B0X2ZmdTIuDQo+ID4gZmZ1
NCBjb3VsZCBiZWNvbWUgb3B0X2ZmdTMuDQo+ID4gZmZ1NSBjb3VsZCBiZWNvbWUgb3B0X2ZmdTQu
DQo+ID4NCj4gPiB0aGVuIGtlZXAgZGVmYXVsdCBmZnUgbmFtZSBhcyBpdCBpcyB1c2VkIHRvIGJl
Lg0KPiA+DQo+ID4gaG93IGRvIHlvdSB0aGluaz8NCj4gPg0KPiA+DQo+ID4NCj4gPiBLaW5kIHJl
Z2FyZHMsDQo+ID4gQmVhbg0KPiANCj4gQXZyaSwNCj4gDQo+IGhvdyBkbyB5b3UgdGhpbmsgYWJv
dXQgYWJvdmUgbXkgcHJvcG9zYWwgb2YgY2hhbmdpbmcgZmZ1eCB0byBvcHRfZmZ1eD8NCkkgZG9u
J3QgcmVhbGx5IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBhYm91dCB0aGF0Lg0KQXMgbG9uZyBhcyB0
aGUgY3VycmVudCBtb2RlIHN0YXkgdGhlIHNhbWUuDQoNClRoYW5rcywNCkF2cmkNCj4gDQo+IEtp
bmQgcmVnYXJkcywNCj4gQmVhbg0K
