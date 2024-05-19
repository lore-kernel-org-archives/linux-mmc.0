Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA09923C9
	for <linux-mmc@vger.kernel.org>; Sun, 19 May 2024 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716086301; cv=fail; b=Cdn4NHvrcsfz7tI0lDamf6EOdyF81sqt32eLz4SD7tmTIPaS4AZmXoKnv7o/6aQzORpK808kHrEaVdODmM8f5tHuPiwmXpuFNGy8vgMqY6cY1Y2kYBHfuleuldA0Qlx+gDW6FTW98k0+NaTIYR4R0FX+0xbVCsK+SoxT8WySKOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716086301; c=relaxed/simple;
	bh=bhIuvOJYxPUzvuVwEmeMQVp3ZhqOp0WudimOO/mTEo8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n+ZpDpYJN5GL/hwxeZEHC4YtZKyGy/4Gd8cBjUb1ujRpX5U6HmuuUoTLJfcHI8/SYBPHMDNTVGbds0lNwLpAzbv7AtQnUDNPmte8kJpj124WVdIXxKaAviKR3rpBqay/jBXLL9aNw0KzNCyKL7HWVlIH/nEvwNs1XtYM//D3FIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fzLpDcns; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EwSzamEn; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fzLpDcns";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EwSzamEn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716086299; x=1747622299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bhIuvOJYxPUzvuVwEmeMQVp3ZhqOp0WudimOO/mTEo8=;
  b=fzLpDcnssRV/8DzMo27PQA6KoVt4QYzzxtqIvZAbRxPSUX8uPJCDXkHD
   JvGud0rqh0yBd32wx5QqN9yx2rkqlZU69BZzVuO9ul+2Dkw3R5FRWxtAQ
   Snt9VYhUb6KnhnF3QhRKnBNoVNKbFcTtj4XgT1jV6722RqQ/1UK7nSsgL
   MmZ+HfnRj4eAY0qD8zfBFqGujvBb9ZdItinF4gDgtuVGtVk97VYaIFp2l
   qmhzYO55mX9ZW+JCUNidqEATtpxsHMkNLjVsNvy4aEpumDtrGuOHS9VMp
   8mZgDRCowOL3eWjD8PWTqO9kCIaunQ+c70516RnQtq3F2hu/aDb2Co5gR
   w==;
X-CSE-ConnectionGUID: gMBfPZ2RQ4G4RmfuLYXQMg==
X-CSE-MsgGUID: 6GuHeQuTTFyokersHfcmgw==
X-IronPort-AV: E=Sophos;i="6.08,172,1712592000"; 
   d="scan'208";a="16907023"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2024 10:38:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnRiCQcDbaOd5mdL2UeSh37GwlCLp5r146z+Vf7TcXfMu92XdQFOx+mFNAzcYAekFPt5b4g3OesoMpUAb6FWYCPs6BFbm2tWAoPDLwR86WgBV2bglGGkcxosS2++RkMTq+B02+oT9POydJP/aUcS4f7ZV6saFX9YjiYdvwKIucpj3JXuv4dePPWd41nSmuO7Ud+s4nGXJB0HvUoU/DOoiU9/EhvW4wWrhGDihOZPm6zJxl4DJqifJk5WCbpywZct287gi8E8kzWiKp6XETzcjRnt8KxMY4qv9dbH+sjjWgBONoDMOSGyVJrMsMGXi6puJtoF++aNFc27pH7AJLo+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u6c+rOlgdHKw24CljxeZyxF+wlvsYLEa0ND4svzYb8=;
 b=OJQOj/lWr/+eXI4GgP+v6HGurQXyalu3w0+MiTlCyK/NN84LE7Cuus76TxOd5zbSeCZXb0ooqHLeCENKRx9eoo7NdnPX+FeCo7eaXyd0jsICIT+qTCZEyImKIYxamsAfVMQxpcg3uAIMNR8uH85YOQSrYbr8GXdteiuW7nnxgSMvexcfTZQ9FnpV6calPhCG4wnDL2uVqMp4Zfz+/bNIVasTKypWpp23ek48WkBxMwRf55xmryOpEnNP3TUQ4BcyE6xPfoXuH+n0wJm2mKRE5GCZMoeV9xmUDnCFQJfPlLRtFwaD/plYwY2NLO0/0z2EQeXLpfqZRuSTdBwWcb+GaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u6c+rOlgdHKw24CljxeZyxF+wlvsYLEa0ND4svzYb8=;
 b=EwSzamEnctVvnLICFCLG+3uQ4fX1M/5nFCrXW2tD+FKU5kOpk/hD6nj9OKtiBeX7Qsh7ba+slsVu2EzWl5sjWo+mgszY9a7hbLb5dM4GuOvkkmaYSl/dZ6Z7f93r+GgF56LHFxt04ZW9Z3AWvqA3FLaaaChsYQfOy/hZat0irzY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN4PR04MB8351.namprd04.prod.outlook.com (2603:10b6:806:1ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Sun, 19 May
 2024 02:38:11 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::73a8:8d4e:8c05:62a5]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::73a8:8d4e:8c05:62a5%5]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 02:38:10 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: "linux-mmc@danman.eu" <linux-mmc@danman.eu>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>
CC: Daniel Kucera <daniel.kucera@gmail.com>
Subject: RE: [PATCH] implemented CMD42 locking unlocking
Thread-Topic: [PATCH] implemented CMD42 locking unlocking
Thread-Index: AQHaqUA3ExV0DPY/7UmKATaeQHiMqLGd14iQ
Date: Sun, 19 May 2024 02:38:10 +0000
Message-ID:
 <DM6PR04MB6575AC22506EDEBB7C7E9310FCE82@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240518162647.452103-1-linux-mmc@danman.eu>
In-Reply-To: <20240518162647.452103-1-linux-mmc@danman.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SN4PR04MB8351:EE_
x-ms-office365-filtering-correlation-id: f650e2c9-57c8-4d2c-2c00-08dc77acb966
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OXRfeB63lQ3IlA0LaVaE5fiVPx4KxSP5pzVlM1V4107x/auUqosZoaVTf+oc?=
 =?us-ascii?Q?V8CzNGTn+0kMFmB1ga+b7NbXbFu/c4V+vHm6MSJu5SFFJh9DmFdWsra/wkHs?=
 =?us-ascii?Q?DKQm/lQ4SOyLHl6JIT1oX++q5G6J2rT5JRBciTcAf7yShJ38009vh+yuPCbo?=
 =?us-ascii?Q?RC0erw+9FKUwZvyLnKQHhk3FFQnkwfThUeJL29yxlQPjuE/aJZJ6eXM0qo7r?=
 =?us-ascii?Q?OCXZXWRauZkrGtcy/j3EsrFQDTjNPdy185DchKQ9U9s2RuHztxUBcJN98QpG?=
 =?us-ascii?Q?Vz/2vLAkvyiMRXyFeXvXCUls67Pl4K2sNsbrQ8V7LJcgqOsrHJlG6KnFlc1t?=
 =?us-ascii?Q?xyVVSxhpSYXlx+GFOWLB9Lpk65V8P5y3iHz3VKfK/M4GM0GwiisEjrm5YPM8?=
 =?us-ascii?Q?zn79SjRJMUONkYN76RzWXvhFafP0sa+i7ZeCcZLEioi6k0Eo9wd0PLHvHoEH?=
 =?us-ascii?Q?B5KuHpdK9V4uctJhTQ4nRbG4Okemn7R6fNMfz0R9RrARCRAeb3+zwkbFShdh?=
 =?us-ascii?Q?BG49Xeo/dQ70DUMjRrk0iU80SOkn9ALYzjmiUuPRbyOjWF0LElpVDNkJWdee?=
 =?us-ascii?Q?3Hwp9pyONh2Vakga7y6PRGsl419qp/J38u6Viwc/STnKYRQctrBvDw5nulLN?=
 =?us-ascii?Q?WI2T3pOP45Po4TI65Tq4DKz/IZ/+SfDDo4J74iuY+B3ehJhRbQp9MkjRM22R?=
 =?us-ascii?Q?ed9noVlmx623KHxK7IhURIh5mHBoG5ibw3Y6aMSfKvo1mWDnlL8994bYdTIl?=
 =?us-ascii?Q?VzCR/Gf1K+T1lMRIooTdOFHKg01bD7a61XhE1xfHTfTUELukZT/s+aierAe1?=
 =?us-ascii?Q?r0nU5N8q5JcR/IKvyB3SK8nsWRTTZcVW1eQMB13Db4GcELLAQ+0stg5Ln/bj?=
 =?us-ascii?Q?mprppNfoiIfvWHw71bUraVp4vVgSBoDI+KYyleUQZAcpNdwkODED8C+tOzpp?=
 =?us-ascii?Q?mrdpf1bH3Z4JEw/5n9fNyGY1/toXa+tTPltey4yP++p0UY2PFdGG/WyfkLYI?=
 =?us-ascii?Q?EZJw+m65cj1cZRCU6nDcKd8tu3hQkeOfx/EJ+wwl5P4KzBfvC24upragoYco?=
 =?us-ascii?Q?Q+L+fEOayk/UWqNPoEKfxtvxFAVs5ei+T0uwvqBO0FHr0h7DgTk/tH4kblq2?=
 =?us-ascii?Q?sbDkSp06Wuz987vNgs33ZuIppKFcMb69e87jfXWidONCZHLzivslFNVdvuxL?=
 =?us-ascii?Q?PsSZiBnudIX74JF/kZZcXJmvqSLppNyBYdQ7uQm0OsZKJBtErawh0/ZIgAVP?=
 =?us-ascii?Q?udksW/cSe4o8rmvn0h9+8Tb93MkIUPw9wEgUsUGtkab5f/m/n9KE0TjWs7ba?=
 =?us-ascii?Q?tQcpIMSsVNu3WuNE8PklsZK2Sq9Ne90KSatbku20w6D8TQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p2Pstgzoj/+3jqtgDxm//76x/SwklTgrcCidfjNBvdxMMAE5ghTKfn7XewfJ?=
 =?us-ascii?Q?IzdbxDg9LxpVV6tWOegC/aHTc0ddE2YSOgaYOjOkI/4XbD9778vgFOZ2nPw1?=
 =?us-ascii?Q?Kzhtn9+HKTHnWbTQvhwTsUiz5yaWh/M2pQPGtRzLoKeOWRjDhTGZ+9r+NTl7?=
 =?us-ascii?Q?FxqMP+HL5I2GqCFEJ0YGcqYugpf8eftS5ZnmvQF+SBnqAomijfGND3DhJ2P3?=
 =?us-ascii?Q?I7z2DzlLee9ad89QkG1qsD9WOyY+QnGLReC93P/8lktMfzNywpUFEUn4rYfw?=
 =?us-ascii?Q?u6hZxxVJiJlI7dZfPJgxNDfUzc40S1nuydg8zfRPb1PP5fjMQulUuIeEZ6JR?=
 =?us-ascii?Q?AtKorFEsvSAecbPiUMUO7jvXzwmUbQPHcMAcTFfD3iATefjuTrGAvRtFMzJe?=
 =?us-ascii?Q?GZPKrwknrpaT4+YBHLIvXjUWeSo8zY3D0BQTNLOKPVQd8DiHmy/Vmu+VrNMY?=
 =?us-ascii?Q?UU14eJURiaZHszckadvFyGxpAO84xTeqcNTsnrxBwHCDhXnLW35zhGOR2Qlq?=
 =?us-ascii?Q?mHRQ7bAMvb6UNib1X2xsRObv1iINJsY9I/CHhGX07ygaZppXTsUgpotvQw/I?=
 =?us-ascii?Q?QUI/aEsDnH0F7j57CoL2cRlG1v99Mj6GiYAplEdw0mUx6Xb5zSWfObS5BM/J?=
 =?us-ascii?Q?9xxKP4i42qUFs6Mbuc3uDx3oH4bRsnXWppDoqEQ/wt02XDWbzQoSVCh3WPw7?=
 =?us-ascii?Q?Ystp6+8tMb6Jf9HxB2d9y06ZTelUDDNgVBVCISbiIHvc0mvZnaP4OgNbJ0I3?=
 =?us-ascii?Q?+mCHqqNhM0BRGUqd22CFLjfL+liIYjo6U6kPLcXRgMc6zQb0w45D9mC48NDk?=
 =?us-ascii?Q?+ERzMuA9HUfph/FVTp2uVUvGwiE2lbDbuNonGH0TEd2wKJgx9+vXfzhdSveF?=
 =?us-ascii?Q?+6ZHbmxIim03s2sgDsrJIlBBnFqOfCBV8mqbzgAAMXoHSr7yFfhwZk1K7G2Z?=
 =?us-ascii?Q?KSu6WwyFT5jR4q7ULHMPK51bpTD+Zw/YL5QXE7NuIYZsSPKhIFY8wQd7wDlJ?=
 =?us-ascii?Q?5wDpmU89ayliHC/XcrB+RHFyrSBFz4OAeYnOa26ARBHBs7mTa70hso7vMazx?=
 =?us-ascii?Q?82u0McdG6/09/gtHmgW3UjvVS7YDa7Ca4+EGWYzmDjt4ExlcE7dK/hfAFCBc?=
 =?us-ascii?Q?w4U4g46rD+G5ky5CRTMd8ZZGckEnXgV2r9vSFlA6IXrwMePYtFm1eDYqzsj1?=
 =?us-ascii?Q?IHFL5kcbpapJUGErZ3XVijaU7CMMOaPEx0wz4v+JscYM9OUGT3hSJvgBVM2k?=
 =?us-ascii?Q?uKS6labziKGYcC3bs6hDSJnqpgVeFncu17f8LdmuBx/dHQoDsLgUj/Vz+OA+?=
 =?us-ascii?Q?nelVlxkpjrR1D+nPYwv/YuweKGBb1xeCw320CyKwPNT/GL2NpUrUX4PTNyzq?=
 =?us-ascii?Q?+zkCe8sQezQNFxh5NTmnV0+XEr+IrO0GLED3vjrQ/SHm04NhJT+rGrD+OCzA?=
 =?us-ascii?Q?JYpJhWv8zT053t12x2rek2KN2mwoHrOW/5st9KNh+B2iFi8iORpp6Q80Z7Gq?=
 =?us-ascii?Q?zzO6niKSZ0lW93F6qrM4F3SGf5GCIk5eTTg6IA8APb9j9r4MH1zXixS+sk5I?=
 =?us-ascii?Q?q4zNy2IBy3UpbT3tfWo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2G4zTYfwpFZSlmzHrtkZeez7l1a7kOXDxvMSOdZzf0woy8cU0WPAK4+QmDwmTZHeyJZ7h/Vd++/QGxGI/nr6M/sYKJFqFyhiqPb0IMpPrmxjBcnK3OotsNOkrvLvTKgk0spx/Tvy3uaSTIDCdr5yl+uHV+1Gcfh/0Dj18/itAJgwMxkVs0loFqRNaTH5yZXMtsxS7abuPoFw+A7qNTvXkMqNoTRycSWGdUYvIcQAUj4OhpD6SQswcDt1iQU4ddd7KM0BHJb+VGtzE0EFCpumvGq64CsKAN15wnibvKhO6g3JGxzboJp+jUcSsrDpyY9jtv52JKzsjbb0b8y5+Fj1Knzf1KKAGU6XFuklQ0/GLGuKtrBqq1ebI8CZakimLKxpuNPRKfFSIEiKCuy16hTBgBfHxxMt5wD9rcoEVop+faeUj3WRjVKH6dCncG21/XOVWL98civkCXrb0zB+ClPhv1S5MDF/WbhhojmmOfUZyv32afL8QYMFLIBWC1onJXmtJfYgIzkQbL2sQny8a/gT9o8HplHoQDgN0HPSm1WzWHotai9RhTqJMu1W+9ZHRgseJiJaAcPgez37Pn1mvCd8kbqOxtfbslQLM1Umb7xRRXqaf+AaqjQty5Kd0YV57e00
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f650e2c9-57c8-4d2c-2c00-08dc77acb966
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2024 02:38:10.8253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OjN98sJEWcaZQy5zaR1K6/dKY6l+1oMlizIY/X+FdNCrlDqkJy0tFgUmukZh6/Tq0sHUGqSrJxLnR1zdkC+0zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8351

Hi,
Thanks for submitting this.
Please add a proper commit log and run checkpatch so we can start review yo=
ur code.
Also, please let the title start with "mmc-utils: ".

Thanks,
Avri
=20
> From: Daniel Kucera <daniel.kucera@gmail.com>


>=20
> ---
>  mmc.c      |  11 +++++
>  mmc.h      |  11 +++++
>  mmc_cmds.c | 123
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   2 +
>  4 files changed, 147 insertions(+)
>=20
> diff --git a/mmc.c b/mmc.c
> index bc8f74e..3ff7308 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -250,6 +250,17 @@ static struct Command commands[] =3D {
>                 "be 1.",
>         NULL
>         },
> +       { do_lock_unlock, -3,
> +       "cmd42", "<password> " "<parameter> " "<device>\n"
> +               "Usage: mmc cmd42 <password> <s|c|l|u|e> <device>\n"
> +               "s\tset password\n"
> +               "c\tclear password\n"
> +               "l\tlock\n"
> +               "sl\tset password and lock\n"
> +               "u\tunlock\n"
> +               "e\tforce erase\n",
> +       NULL
> +       },
>         { do_softreset, -1,
>           "softreset", "<device>\n"
>           "Issues a CMD0 softreset, e.g. for testing if hardware reset fo=
r UHS works",
> diff --git a/mmc.h b/mmc.h
> index 6f1bf3e..f8bac22 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -30,6 +30,7 @@
>  #define MMC_SEND_STATUS                13      /* ac   [31:16] RCA      =
  R1  */
>  #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
>  #define MMC_SWITCH_MODE_WRITE_BYTE     0x03    /* Set target to value */
> +#define MMC_SET_BLOCKLEN       16  /* ac [31:0] block len R1 */
>  #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
>  #define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
>  #define MMC_WRITE_BLOCK                24      /* adtc [31:0] data addr =
       R1  */
> @@ -46,6 +47,7 @@
>                                               [1] Discard Enable
>                                               [0] Identify Write Blocks f=
or
>                                               Erase (or TRIM Enable)  R1b=
 */
> +#define MMC_LOCK_UNLOCK                42  /* adtc R1b */
>  #define MMC_GEN_CMD            56   /* adtc  [31:1] stuff bits.
>                                               [0]: RD/WR1 R1 */
>=20
> @@ -70,6 +72,15 @@
>  #define R1_EXCEPTION_EVENT      (1 << 6)        /* sr, a */
>  #define R1_APP_CMD              (1 << 5)        /* sr, c */
>=20
> +#define MMC_CMD42_UNLOCK       0x0 /* UNLOCK */
> +#define MMC_CMD42_SET_PWD      0x1 /* SET_PWD */
> +#define MMC_CMD42_CLR_PWD      0x2 /* CLR_PWD */
> +#define MMC_CMD42_LOCK         0x4 /* LOCK */
> +#define MMC_CMD42_SET_LOCK     0x5 /* SET_PWD & LOCK */
> +#define MMC_CMD42_ERASE                0x8 /* ERASE */
> +#define MAX_PWD_LENGTH         32 /* max PWDS_LEN: old+new */
> +#define MMC_BLOCK_SIZE         512 /* data blk size for cmd42 */
> +
>  /*
>   * EXT_CSD fields
>   */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 936e0c5..03fe04f 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -129,6 +129,129 @@ int send_status(int fd, __u32 *response)
>         return ret;
>  }
>=20
> +//lock/unlock feature implementation
> +int do_lock_unlock(int nargs, char **argv)
> +{
> +       int fd, ret =3D 0;
> +       char *device;
> +       __u8 data_block[MMC_BLOCK_SIZE]=3D{0};
> +       __u8 data_block_onebyte[1]=3D{0};
> +       int block_size =3D 0;
> +       struct mmc_ioc_cmd idata;
> +       int cmd42_para;                 //parameter of cmd42
> +       char pwd[MAX_PWD_LENGTH+1];     //password
> +       int pwd_len;                    //password length
> +       __u32 r1_response;              //R1 response token
> +
> +       if (nargs !=3D 4){
> +               fprintf(stderr, "Usage: mmc cmd42 <password> <s|c|l|u|e>
> <device>\n");
> +               exit(1);
> +       }
> +
> +       strcpy(pwd, argv[1]);
> +       pwd_len =3D strlen(pwd);
> +
> +       if (!strcmp("s", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_SET_PWD;
> +               printf("Set password: password=3D%s ...\n", pwd);
> +       }
> +       else if (!strcmp("c", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_CLR_PWD;
> +               printf("Clear password: password=3D%s ...\n", pwd);
> +       }
> +       else if (!strcmp("l", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_LOCK;
> +               printf("Lock the card: password=3D%s ...\n", pwd);
> +       }
> +       else if (!strcmp("sl", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_SET_LOCK;
> +               printf("Set password and lock the card: password - %s ...=
\n", pwd);
> +       }
> +       else if (!strcmp("u", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_UNLOCK;
> +               printf("Unlock the card: password=3D%s ...\n", pwd);
> +       }
> +       else if (!strcmp("e", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_ERASE;
> +               printf("Force erase ... (Warning: all card data will be e=
rased together
> with PWD!)\n");
> +       }
> +       else {
> +               printf("Invalid parameter:\n" "s\tset password\n" "c\tcle=
ar
> password\n" "l\tlock\n"
> +                       "sl\tset password and lock\n" "u\tunlock\n" "e\tf=
orce erase\n");
> +               exit(1);
> +       }
> +
> +       device =3D argv[nargs-1];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       if (cmd42_para=3D=3DMMC_CMD42_ERASE)
> +               block_size =3D 2; //set blk size to 2-byte for Force Eras=
e @DDR50
> compability
> +       else
> +               block_size =3D MMC_BLOCK_SIZE;
> +
> +       ret =3D set_block_len(fd, block_size); //set data block size prio=
r to cmd42
> +       printf("Set to data block length =3D %d byte(s).\n", block_size);
> +
> +       if (cmd42_para=3D=3DMMC_CMD42_ERASE) {
> +               data_block_onebyte[0] =3D cmd42_para;
> +       } else {
> +               data_block[0] =3D cmd42_para;
> +               data_block[1] =3D pwd_len;
> +               memcpy((char *)(data_block+2), pwd, pwd_len);
> +       }
> +
> +       memset(&idata, 0, sizeof(idata));
> +       idata.write_flag =3D 1;
> +       idata.opcode =3D MMC_LOCK_UNLOCK;
> +       idata.arg =3D 0;          //set all 0 for cmd42 arg
> +       idata.flags =3D MMC_RSP_R1 | MMC_CMD_AC | MMC_CMD_ADTC;
> +       idata.blksz =3D block_size;
> +       idata.blocks =3D 1;
> +
> +       if (cmd42_para=3D=3DMMC_CMD42_ERASE)
> +               mmc_ioc_cmd_set_data(idata, data_block_onebyte);
> +       else
> +               mmc_ioc_cmd_set_data(idata, data_block);
> +
> +       ret =3D ioctl(fd, MMC_IOC_CMD, &idata);           //Issue CMD42
> +
> +       r1_response =3D idata.response[0];
> +       printf("cmd42 response: 0x%08x\n", r1_response);
> +       if (r1_response & R1_ERROR) {           //check CMD42 error
> +               printf("cmd42 error! Error code: 0x%08x\n", r1_response &=
 R1_ERROR);
> +               ret=3D-1;
> +       }
> +       if (r1_response & R1_LOCK_UNLOCK_FAILED) {      //check lock/unlo=
ck error
> +               printf("Card lock/unlock fail! Error code: 0x%08x\n",
> +               r1_response & R1_LOCK_UNLOCK_FAILED);
> +               ret=3D-1;
> +       }
> +
> +       close(fd);
> +       return ret;
> +}
> +
> +//change data block length
> +int set_block_len(int fd, int blk_len)
> +{
> +       int ret =3D 0;
> +       struct mmc_ioc_cmd idata;
> +
> +       memset(&idata, 0, sizeof(idata));
> +       idata.opcode =3D MMC_SET_BLOCKLEN;
> +       idata.arg =3D blk_len;
> +       idata.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +
> +       ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
> +
> +       return ret;
> +}
> +
>  static __u32 get_size_in_blks(int fd)
>  {
>         int res;
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 5f2bef1..9ee78a2 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -50,3 +50,5 @@ int do_general_cmd_read(int nargs, char **argv);
>  int do_softreset(int nargs, char **argv);
>  int do_preidle(int nargs, char **argv);
>  int do_alt_boot_op(int nargs, char **argv);
> +int do_lock_unlock(int nargs, char **argv);
> +int set_block_len(int fd, int blk_len);
> --
> 2.34.1

