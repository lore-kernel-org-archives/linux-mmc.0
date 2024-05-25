Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508E62AF1B
	for <linux-mmc@vger.kernel.org>; Sat, 25 May 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648291; cv=fail; b=gIJPxBTJH8bdnyLt6eyGUXyPGZBQxRtViLmifCnxVY0fFbNS3GzHGf6+Pq9sc7PQ6foK5lIQkuWQ5r7CEq/iJeK37iaGpg8f1o5h410360cjWuJQjIHMTxRbbVLqaCc7xJ3JbQ28gUgZrIF40+SHu7WDCpW/ErjYNrb7Oq1STTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648291; c=relaxed/simple;
	bh=iIUsdhI9jMQqgTWV8DNNH5S4TbN3N2gVKJ4LgWvnw/g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0YgL7knuLIhI9XV+h5+4k9vUKIKGNKHJR6xzOdJQjnmxkRkmzjZg3bXDPl8UY0mHVJw9m5rBE1vdJMx1KWw+yuPF1Lam+MKLsvQDkZEtdkkbww2kF5UfZzucwd4mqzERlgiJYr4sd0+9lr76WjEUipP3hk7j2fhlNUNwkIxnwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Xki50Vfz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dY+A10Em; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xki50Vfz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dY+A10Em"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716648289; x=1748184289;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=iIUsdhI9jMQqgTWV8DNNH5S4TbN3N2gVKJ4LgWvnw/g=;
  b=Xki50VfzVkxwtVAKnJmeP90nnK5aFvL2MROwfToAFugOuFAHJqkI0hPG
   NOMKrku5vWPc/Sqb/OhW+x1pxWEM6va9JTYDR+mjuEArPwyWhIZRuIo6a
   dr0GCpKE1a2j1bmC7XOBdvpAWWyGfKSGTul8KO4BjNljB0hW0y1qN6ycc
   ZiuJSrKPPQ+xAPyFA50giu+KnJNynXgyprK0rm92Iu2L6RKdwXEF4efxD
   u03A+3OjqTAdmqaTm5/+dwX9za4iw5EmgY9AY1T1ZIRztZ5+r2Gcb5JgS
   C4/JyRH97uIc5Thpm0TbUe8UTGDV9FynE7YldP/eXFF9V5yZir+8cOPZX
   Q==;
X-CSE-ConnectionGUID: AUugCpEHQLisp/NY2W1Sog==
X-CSE-MsgGUID: Rj8EOlJKQd+4tkZQ4i4hZw==
X-IronPort-AV: E=Sophos;i="6.08,188,1712592000"; 
   d="scan'208";a="17516738"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2024 22:44:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfQQD1WloBzgy5/uUNkFD/OLJCEk3g8aGwCwWJBCeGQsyq/bRDm4fVDHeeMHSQajYVnQ1kS9JOX9FMOy5OQtyOFMn43Ez6ecKZtojpatn6ruDAbHv2NPIEzvGUnorMGkJ2V10hjuNbnztnmTaGFHadjBEI9nZeVgIW8NhZost3eJdQEKGPBSXh14xqPXJBTzhRimiOdveXs12PwyA7UPDWsoEUCQEy2X8GDXN0YrPJHXqf9db4JE6/Vj3rjQJFEHLFkjPf5LL1r+3pFSKWQrg2GDFnvkS8jy9l+9ecSe000gNFHZkWlXJwjzD1doOHQz3eZvIUFoGGVrXxbgTPNS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+oys6/7zUNOVzZgsI7JPtDUI7QKi2NlsBzr3haZ4io=;
 b=TFOCHsrsftRt9KI49/LCJnVOYfWkexS3IpBSTuDi+RViSYmIwRlShIshw8VUXOmLgyzDlVeDjg80GxSZEMKqeSjrMNg69pTkwQLyfoUISfBPzvuAmX/JIz0B0d6MXLYNjYcyYykJTJXqi7+9i695quSDr/J56/nG5PbnkbuxkSXhvGs1VOFIzvNGMNDMvUrmtCqgqTgOyQPm6wPrXXFfig5Aw2DOk9xXLz9a8xaXQW8HaMYD8VWkC3RR9dgibzfosvcrDS8hmyrx94tj1uJWvDXlEwp7v9GZVS/sjA1WZ20vAtTCE+2QQEXEyckSXNNKcdWyyAE/gaoY7Dd26aEwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+oys6/7zUNOVzZgsI7JPtDUI7QKi2NlsBzr3haZ4io=;
 b=dY+A10EmZH5bzBhdyJCpZ5i16m8QV6/DrA54OvrOTZOtr2p67jsDNx2cRVpIWHTray7tZs8lKXEctCkFdiaAaU9va/v7ZZARpi++24vgh9CrirpaSQOMnm3x8eqjwhvuCi2n7g9y7aBgbM6oZFuBu6xyj0hc7nGhzWJVZcmclQY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH7PR04MB8579.namprd04.prod.outlook.com (2603:10b6:510:2b4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.19; Sat, 25 May 2024 14:44:38 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%5]) with mapi id 15.20.7611.025; Sat, 25 May 2024
 14:44:37 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, "linux-mmc@danman.eu"
	<linux-mmc@danman.eu>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: implemented CMD42 locking/unlocking
Thread-Topic: [PATCH] mmc-utils: implemented CMD42 locking/unlocking
Thread-Index: AQHaqbt6tJbSe7J5F0aYFSUNoe3rsLGemxwAgAlZAKA=
Date: Sat, 25 May 2024 14:44:37 +0000
Message-ID:
 <DM6PR04MB657574B7688DF8C88E2DD3D9FCF62@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240519070843.467268-1-linux-mmc@danman.eu>
 <DM6PR04MB65756D83C351681616139155FCE82@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB65756D83C351681616139155FCE82@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH7PR04MB8579:EE_
x-ms-office365-filtering-correlation-id: 1f9ae0a1-e554-4fbd-27e0-08dc7cc933d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mTg8Q1jwFh5WqEeoe5PTdsQpFP5jY6N9BLsME7h4xO8Y5LOvDrQHbjbh4f6o?=
 =?us-ascii?Q?2JEsbY56/qvj+HwKyh0/CHZY77nOfINOgBgpgUqRbtlJ7nNEh/FkxaAPwSbv?=
 =?us-ascii?Q?CFlNzz2XhnLCZLnbC/+x30EolI/58GTjpFRbhmZXqp7tg4LcAHlFe778UK34?=
 =?us-ascii?Q?4tV/sCvVEOg2SSCDCANYQVBdAhoeaeOF6cMQXet5p5xO9ek8t9reM8bxsZgP?=
 =?us-ascii?Q?QsYZAnYtAt9899ZaOvgEn7hHywNo9p5O36OW5FZqlznvNEQKI6CzmIMwqjB0?=
 =?us-ascii?Q?CCevOnU2oBKP7ZjKrduSwoLb5kSNBiajBUTcK0VEaQdz6fD2TJuoqfyIuYHs?=
 =?us-ascii?Q?zm16l+dCuqhY08s9kSpSe2fa1N0u0IzdM5D/KQGW6+FTdE2J8yUITbI7Vl0O?=
 =?us-ascii?Q?cbqlZu6hdE6kQj1rjkPG6S00tynkpn2mKH57npBBYbqsORgNbtbb7+W9mjm5?=
 =?us-ascii?Q?cLMNDBQJD2At6fniOtx4zE49Buqi+Qh4h/9TH4OKa5AVIOnPQwZykmbw2L0S?=
 =?us-ascii?Q?XQMH26ixW+dx7w9kRk21/oAr1CtyRdq8EtIXlDNcNKci2LmRCG6rqM0dFLk/?=
 =?us-ascii?Q?bTc3b/5LNs6Kryidzw8k4HBjIclBqZ7r/5LD4z+R6q4FZqlt95kojT74Zaym?=
 =?us-ascii?Q?R3cNvZPBbSCZ2CtTRoiBXtNbORtX8BeaaRHxkhzq4g1kn8R04oef4nCpkKvu?=
 =?us-ascii?Q?IiU2avEWdlUMXp1Kl0lGZtB1Q6vm8jHsyo6NBuPsj3+t2WLPDRWkpV2QgCTO?=
 =?us-ascii?Q?aHmfF4rKlCealEDBE5dYnBKEx3LQDpgBNr0T7Kss0kmf/l7hYK3IUyPUlKXh?=
 =?us-ascii?Q?E+0n7p6J6uaXqNj1S56LuuI42dtH0rgujLqzcD67LG3r1X5wUnw6yib01fJM?=
 =?us-ascii?Q?YHqZVjhOe37ajvL+xEX5WqFNGe4M5ys35MWjOMsyZJ0RjDhfKrDLYGOKHmOv?=
 =?us-ascii?Q?4+RMKdSSPcFxS5V14lqJIatb/cQF6PpM5KXXGK9To5mQwJc0exAAKHCSphL4?=
 =?us-ascii?Q?HG+c6bGDvvCEXLgwhJO3mEFMiW5S9hAxlexLIbACfnsgsIWfL32bVPwXImtp?=
 =?us-ascii?Q?ZyWReLvGCshXPyOPVjJNvYhDgf0rri0BbVNZjlMHk5BABC1J73HkkXVPPrmL?=
 =?us-ascii?Q?/osHjbx9jK9+aK8qyynIjOMtkNB16+/rXtQjlldpxuFMVkd7d0lEMeE+2Rd+?=
 =?us-ascii?Q?lVFYTKSobvbqXclaK7QSFY3XXtS3XtOpkNmcEYzVhRG6mP3B0H2rpB8UC5o5?=
 =?us-ascii?Q?yPJC4BOP25VOQjJyUDlIj9ZpgZLoQSl9tXeh51zFEg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?90tdiu7WkegA3cygXshZ5ClwlEdwxqM8SkSOhm6T5ndcr+RRYtzPEYWpnikj?=
 =?us-ascii?Q?4lNcD3oEv7pMFZGOO9Ur5oLWjSLvRnkF5/PeoSbt851EjT+esqbhX5lUYMNE?=
 =?us-ascii?Q?M60OcXIsxetTqdgVwZg+6uUJqSos2UnIMQdsd8YR1Dg/KR5IKXMqgudHegqm?=
 =?us-ascii?Q?oR+SoxhXrAN/Gu2X3O+FjOSD4WTsiHAUN8igmErF0zMEx80iu7/gOOrX5orX?=
 =?us-ascii?Q?fywavAuHOsXjZDwvJJb9J+gA6mmrxwcVtarlPq3ns2bqmmuIzbLoJJiNl9YA?=
 =?us-ascii?Q?t7cKxyVx2e2lGgk+UJm8Itnshhj1bJye38pvY5E/5W4qWPIWSf/EU5KaGkA4?=
 =?us-ascii?Q?aEdBz0xAEPtf2Z3vyt1YY6pV2tL4PSgdndl7VdRJ67I/kCypKn9LhP3dQKgK?=
 =?us-ascii?Q?nLlsDmKMrxKjuzjQ4ucmKrSKddgFQxTy2PQv/YuIWPz/Xi98oTuTag7jUkTK?=
 =?us-ascii?Q?kqV5+evuva7EdEnc7igKXaTF6cwBTnJhSmzFtN8rCTVo63u4FEpvJ0bkMaoF?=
 =?us-ascii?Q?8SYUn+D6Wf3+2GoysUxk9J2XW3JEf7JhMPnT3NdAFiJXFOUKMyiWcqp8v0lx?=
 =?us-ascii?Q?P9TiqvPQWnivCJAz4FGCRBc0kWYfvSHkumhX1chq4F6xA8uvd+C348F9c90u?=
 =?us-ascii?Q?yZXKBSgZRW8BL3nhKOWZolY/43o+fEnbZvYk8+hjGKXMBs6f7RurQmh/wK6A?=
 =?us-ascii?Q?L0x51yZsJBmQMi2pqf4cOPDUPmGBNwEbXIDiSNNo/Gavd8/7gmP8kilNXf34?=
 =?us-ascii?Q?C5vsB75sQaazA2utoN2qTx8pj69XDVaZgY/k1jLxn/8/flYj5wwGhgPVSvsK?=
 =?us-ascii?Q?y/WMgJzrzbP9XG3eMn0SqMuoawyMDWa8vxSTDVv+cnlGX5yFmSoGU8y6io8a?=
 =?us-ascii?Q?UXakNh2abl0rL4b2lb1ahYkIhKsbumHQORolf/a33nMFYPJSwiNrHRZsJkgW?=
 =?us-ascii?Q?o+LncHlItxW0mtLoGcYTvGGJ5TtUsoXWT5x8xBgM+4sOHDn1kEyw/Zhkwey5?=
 =?us-ascii?Q?zJMAtIsAruHlJekoV6PbCz75hjy7me1u48NRR3piUzq9FvcJKhljDr6x2q2U?=
 =?us-ascii?Q?s1Fmd6Z8CwfRv4ovkdOzBuTo6VX7UY/YlFUb3b2OwvehxAasv+AbWN01Fbre?=
 =?us-ascii?Q?vSlZ4n8FIyeXzUlRg74GPc14CbyXr/5vjiRxEvmLZkCohs23K3lCO3+w3KA5?=
 =?us-ascii?Q?ZcVrpEhbhfuRNOEeYFbg7n7lt9SgZ88eYPYFuLr9IrR1AZKXTjq+rc0aUBnj?=
 =?us-ascii?Q?Jn3olwygtJAnglt7CmUzPGPfWdVmexkWiJEC1pldf7bcHdR/Wg5MLDeu4Rwc?=
 =?us-ascii?Q?vBQILjjGmiMQ/ZvZS0Lg1djiA6xodiKB/mM1zgmWLBEnrTBkX+F3CEamC8IS?=
 =?us-ascii?Q?CSe3eoLTcJhO+Cng7+BHubbbXAKw0j+ESLcXqFeZKxqzoIwzcVR9QhwX1gEY?=
 =?us-ascii?Q?ymgAPb6GLi2UQ8gEeP+Zl0rLULdEsLYUl7I566WOFU7FHJYkmKdgij1MrBcH?=
 =?us-ascii?Q?3tzJB53e0yVC24JOESoxuDM7H7wFl6i4M/BBn7bt5IL4GJX2hgjS1tD16XUM?=
 =?us-ascii?Q?vm0upR5kDJasSVlNd8qodBQR/pWrC3G9Yze22QwpjiUc/jaq7pCtCggXJVCR?=
 =?us-ascii?Q?98YgR3VMVyGugejXGPUjW5aBDDnRua7OH/xd+1xmlec7?=
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
	8HrueFIJb542Klyf3DmrxIxl4pYnDDjsuAIjmCPHZsDLbK3aPC66JNC0L/mbRagx87lGxn9a1dfEW+5IeadwVWGb3s6rprwFAodSy7hDJWSRL2ijVezXLRJa53XKkN4TdknJZva2gPll5izXE9weB5WtTAbbY6yZPezfkWcInrSaxmQxGDi73JD04WXBEk9Q8sLO5loq68NhuCvgAqfOfxxU7Khptj57Id6cyNZX8bUZd7lJfjNWO54bcZJOiT87EStDEyWpK90hLN/ihQJgw7TaWTpMdRDUDQKySB+wberVcPPYCV/hJwelewR7QDsHtNT+/NkQny1AGBQxEtNJqXTUHk2QDtsqx1udASb48GaeDKBzSnwEc+hywv2ssiaMMgY+wpod7MmyFJDGDDiEp1q1OFsvaIwIttnZUTy/xOerWlP1exDZ1Fd9DObBRsCsMYa4irR7JGzb5bxGv9RQ8HGLXz/eN2OtV2XjEvgZfxU1XKQaZRuNoG36DyvDetATy9Onrah6+tCZg1hXA5csqsQY8UgiAKGsgOltQlnJ+L2X/TQnIvC8CnYgXTpBRItvrL2FA+Qrzg/BAjk2G/zSBy4Brs6Gr+en21ARH/3/4o+1xM7vmd9RH/d3lGG8NAKO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9ae0a1-e554-4fbd-27e0-08dc7cc933d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2024 14:44:37.9112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIziCXwK/UKrcyLaYuOS02pB+DKzkYFYzvAX6LhbYcyyP+QceeNibq89to1izED8tj4/xHHu+GWc52ZQ4uNkxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8579

>=20
> Hi,
> Please see some comments below.
> Please don't send a v2 yet - allow few days to look into the details of t=
his
> feature.
Some more comments below.

>=20
> > From: Daniel Kucera <linux-mmc@danman.eu>
> >
> > Implemented locking/unlocking using CMD42 according to Micron
> > Technical Note
> >
> > original link https://media-www.micron.com/-
> > /media/client/global/documents/products/technical-note/sd-
> >
> cards/tnsd01_enable_sd_lock_unlock_in_linux.pdf?rev=3D03f03a6bc0f8435faf
> > a93a
> > 8fc8e88988
> > currently available at https://github.com/danielkucera/esp32-
> > sdcard/blob/master/tnsd01_enable_sd_lock_unlock_in_linux.pdf
> The above technical note specifically refers to SD,  Is this designated f=
or SD
> only?
> If yes please make note of that.
> If not - Please relate in your commit log to the differences, if any, bet=
ween
> eMMC & SD.
>=20
> The above technical note contains an implementation for mmc-utils.
> Are you the author of that code?
>=20
> >
> > Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
> > ---
> >  mmc.c      |  11 +++++
> >  mmc.h      |  11 +++++
> >  mmc_cmds.c | 117
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  mmc_cmds.h |   2 +
> >  4 files changed, 141 insertions(+)
> >
> > diff --git a/mmc.c b/mmc.c
> > index bc8f74e..3ff7308 100644
> > --- a/mmc.c
> > +++ b/mmc.c
> > @@ -250,6 +250,17 @@ static struct Command commands[] =3D {
> >                 "be 1.",
> >         NULL
> >         },
> > +       { do_lock_unlock, -3,
> > +       "cmd42", "<password> " "<parameter> " "<device>\n"
> > +               "Usage: mmc cmd42 <password> <s|c|l|u|e> <device>\n"
> > +               "s\tset password\n"
> > +               "c\tclear password\n"
> > +               "l\tlock\n"
> > +               "sl\tset password and lock\n"
> > +               "u\tunlock\n"
> > +               "e\tforce erase\n",
> > +       NULL
> > +       },
> >         { do_softreset, -1,
> >           "softreset", "<device>\n"
> >           "Issues a CMD0 softreset, e.g. for testing if hardware reset
> > for UHS works", diff --git a/mmc.h b/mmc.h index 6f1bf3e..f8bac22
> > 100644
> > --- a/mmc.h
> > +++ b/mmc.h
> > @@ -30,6 +30,7 @@
> >  #define MMC_SEND_STATUS                13      /* ac   [31:16] RCA    =
    R1  */
> >  #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
> >  #define MMC_SWITCH_MODE_WRITE_BYTE     0x03    /* Set target to value
> */
> > +#define MMC_SET_BLOCKLEN       16  /* ac [31:0] block len R1 */
> >  #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  *=
/
> >  #define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  *=
/
> >  #define MMC_WRITE_BLOCK                24      /* adtc [31:0] data add=
r        R1
> */
> > @@ -46,6 +47,7 @@
> >                                               [1] Discard Enable
> >                                               [0] Identify Write Blocks=
 for
> >                                               Erase (or TRIM Enable)
> > R1b */
> > +#define MMC_LOCK_UNLOCK                42  /* adtc R1b */
> >  #define MMC_GEN_CMD            56   /* adtc  [31:1] stuff bits.
> >                                               [0]: RD/WR1 R1 */
> >
> > @@ -70,6 +72,15 @@
> >  #define R1_EXCEPTION_EVENT      (1 << 6)        /* sr, a */
> >  #define R1_APP_CMD              (1 << 5)        /* sr, c */
> >
> > +#define MMC_CMD42_UNLOCK       0x0 /* UNLOCK */
> > +#define MMC_CMD42_SET_PWD      0x1 /* SET_PWD */
> > +#define MMC_CMD42_CLR_PWD      0x2 /* CLR_PWD */
> > +#define MMC_CMD42_LOCK         0x4 /* LOCK */
> > +#define MMC_CMD42_SET_LOCK     0x5 /* SET_PWD & LOCK */
> > +#define MMC_CMD42_ERASE                0x8 /* ERASE */
There are 3 variants of sd cards that support lock/unlock.
There is a warning in the spec - see note 2* to table 4-10 in sd spec 9.0:
"The host should not issue a force erase command if the permanent write pro=
tect is set to 1,
Otherwise, the type 1 cards can no longer be used even if the user remember=
s the password."
For that reason, its destructive nature, and the complications of FEP with =
COP vs. non-COP cards -=20
I think its better to leave FEP out for now.

> > +#define MAX_PWD_LENGTH         32 /* max PWDS_LEN: old+new */
> > +#define MMC_BLOCK_SIZE         512 /* data blk size for cmd42 */
> > +
> >  /*
> >   * EXT_CSD fields
> >   */
> > diff --git a/mmc_cmds.c b/mmc_cmds.c
> > index 936e0c5..07ba18a 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -129,6 +129,123 @@ int send_status(int fd, __u32 *response)
> >         return ret;
> >  }
> >
> > +//lock/unlock feature implementation
> C99 style single line comments (//) should not be used. Prefer the block
> comment style instead.
> See: https://www.kernel.org/doc/html/latest/process/coding-
> style.html#commenting
> Please change throughout.
>=20
> > +int do_lock_unlock(int nargs, char **argv) {
> > +       int fd, ret =3D 0;
> > +       char *device;
> > +       __u8 data_block[MMC_BLOCK_SIZE] =3D {0};
> Just empty braces please.
>=20
> > +       __u8 data_block_onebyte[1] =3D {0};
> > +       int block_size =3D 0;
> > +       struct mmc_ioc_cmd idata;
> > +       int cmd42_para;                 //parameter of cmd42
> > +       char pwd[MAX_PWD_LENGTH+1];     //password
> > +       int pwd_len;                    //password length
> > +       __u32 r1_response;              //R1 response token
> > +
> > +       if (nargs !=3D 4) {
> > +               fprintf(stderr, "Usage: mmc cmd42 <password>
> > + <s|c|l|u|e>
> > <device>\n");
> > +               exit(1);
> > +       }
> > +
> > +       strcpy(pwd, argv[1]);
Maybe strncpy up to MAX_PWD_LENGTH
Also, in case of a password change, it makes more sense to capture the old =
and new as 2 different strings.

> > +       pwd_len =3D strlen(pwd);
Maybe clarify in the usage, that passwords are not allowed to include '\0'

> > +
> > +       if (!strcmp("s", argv[2])) {
> > +               cmd42_para =3D MMC_CMD42_SET_PWD;
> > +               printf("Set password: password=3D%s ...\n", pwd);
> > +       } else if (!strcmp("c", argv[2])) {
> > +               cmd42_para =3D MMC_CMD42_CLR_PWD;
> > +               printf("Clear password: password=3D%s ...\n", pwd);
> > +       } else if (!strcmp("l", argv[2])) {
> > +               cmd42_para =3D MMC_CMD42_LOCK;
> > +               printf("Lock the card: password=3D%s ...\n", pwd);
> > +       } else if (!strcmp("sl", argv[2])) {
> > +               cmd42_para =3D MMC_CMD42_SET_LOCK;
> > +               printf("Set password and lock the card: password - %s .=
..\n", pwd);
> > +       } else if (!strcmp("u", argv[2])) {
> > +               cmd42_para =3D MMC_CMD42_UNLOCK;
> > +               printf("Unlock the card: password=3D%s ...\n", pwd);
> > +       } else if (!strcmp("e", argv[2])) {
> > +               cmd42_para =3D MMC_CMD42_ERASE;
> > +               printf("Force erase (Warning: all card data will be
> > + erased together with
> > PWD!)\n");
> > +       } else {
> > +               printf("Invalid parameter:\n" "s\tset password\n"
> > + "c\tclear
> > password\n" "l\tlock\n"
> > +                       "sl\tset password and lock\n" "u\tunlock\n" "e\=
tforce
> erase\n");
> > +               exit(1);
> > +       }
> > +
> > +       device =3D argv[nargs-1];
> > +
> > +       fd =3D open(device, O_RDWR);
> > +       if (fd < 0) {
> > +               perror("open");
> > +               exit(1);
> > +       }
> > +
> > +       if (cmd42_para =3D=3D MMC_CMD42_ERASE)
> > +               block_size =3D 2; //set blk size to 2-byte for Force
> > + Erase @DDR50
> > compatibility
> > +       else
> > +               block_size =3D MMC_BLOCK_SIZE;
> > +
> > +       ret =3D set_block_len(fd, block_size); //set data block size pr=
ior to cmd42
> > +       printf("Set to data block length =3D %d byte(s).\n",
> > + block_size);
On a failure here you should bail out.
But it makes more sense to me that you would pack cmd16 & cmd42 in a multi-=
ioctl.

> > +
> > +       if (cmd42_para =3D=3D MMC_CMD42_ERASE) {
> > +               data_block_onebyte[0] =3D cmd42_para;
> > +       } else {
> > +               data_block[0] =3D cmd42_para;
> > +               data_block[1] =3D pwd_len;
> > +               memcpy((char *)(data_block+2), pwd, pwd_len);
> > +       }
> > +
> > +       memset(&idata, 0, sizeof(idata));
Can be initialized with {}

Thanks,
Avri

> > +       idata.write_flag =3D 1;
> > +       idata.opcode =3D MMC_LOCK_UNLOCK;
> > +       idata.arg =3D 0;          //set all 0 for cmd42 arg
> > +       idata.flags =3D MMC_RSP_R1 | MMC_CMD_AC | MMC_CMD_ADTC;
> > +       idata.blksz =3D block_size;
> > +       idata.blocks =3D 1;
> > +
> > +       if (cmd42_para =3D=3D MMC_CMD42_ERASE)
> > +               mmc_ioc_cmd_set_data(idata, data_block_onebyte);
> > +       else
> > +               mmc_ioc_cmd_set_data(idata, data_block);
> > +
> > +       ret =3D ioctl(fd, MMC_IOC_CMD, &idata);           //Issue CMD42
> > +
> > +       r1_response =3D idata.response[0];
> > +       printf("cmd42 response: 0x%08x\n", r1_response);
> > +       if (r1_response & R1_ERROR) {           //check CMD42 error
> > +               printf("cmd42 error! Error code: 0x%08x\n", r1_response=
 &
> R1_ERROR);
> > +               ret =3D -1;
> > +       }
> > +       if (r1_response & R1_LOCK_UNLOCK_FAILED) {      //check lock/un=
lock
> error
> > +               printf("Card lock/unlock fail! Error code: 0x%08x\n",
> > +               r1_response & R1_LOCK_UNLOCK_FAILED);
> > +               ret =3D -1;
> > +       }
> > +
> > +       close(fd);
> > +       return ret;
> > +}
> > +
> > +//change data block length
> > +int set_block_len(int fd, int blk_len) {
> > +       int ret =3D 0;
> > +       struct mmc_ioc_cmd idata;
> > +
> > +       memset(&idata, 0, sizeof(idata));
> > +       idata.opcode =3D MMC_SET_BLOCKLEN;
> > +       idata.arg =3D blk_len;
> > +       idata.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> > +
> > +       ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
> > +
> > +       return ret;
> > +}
> > +
> >  static __u32 get_size_in_blks(int fd)  {
> >         int res;
> > diff --git a/mmc_cmds.h b/mmc_cmds.h
> > index 5f2bef1..9ee78a2 100644
> > --- a/mmc_cmds.h
> > +++ b/mmc_cmds.h
> > @@ -50,3 +50,5 @@ int do_general_cmd_read(int nargs, char **argv);
> > int do_softreset(int nargs, char **argv);  int do_preidle(int nargs,
> > char **argv);  int do_alt_boot_op(int nargs, char **argv);
> > +int do_lock_unlock(int nargs, char **argv); int set_block_len(int fd,
> > +int blk_len);
> Please make set_block_len() static - as its only caller is do_lock_unlock=
.
>=20
> Thanks,
> Avri
>=20
> > --
> > 2.34.1
> >
>=20

