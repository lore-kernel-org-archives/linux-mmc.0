Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54BC129A74
	for <linux-mmc@vger.kernel.org>; Fri, 21 Jun 2024 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954204; cv=fail; b=L1LpCb7Nnrsf/oqsf8T25Dwe2Xu7VRrb4JmrMXfx7c3fnRd3e0TwGhONM+T8ZZKI4SQmhf7kWq92HX/IKcynuH3BHXmVJmvpCgpG4u9FXH+ooU0o86gqG6ymjPpEbNmmSzajP12UFO9ed4SXV2vJsqBBhiLoe4xnnpOfyd35Tvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954204; c=relaxed/simple;
	bh=92sjHAdif0qYVFhnEpOAbidxn3yIc+mngyUKjpk0Kmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D3+/yWQmCGFGng8i5Y32xWfhiIvsTS7IdxK2j6zwRLf+ZuJoAAHGB/EjBbYsVWQ9DlJzv0X/A8ryuETnnKFglzOK7MRNC+H4247e/nwlNB8xSv+0UOPiPq6/wDOSqhwGIvChwsATRyb2qWspo9vluBzPaFhQVXeF3opofVN/nvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LxXXqnCb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PC3i6Itp; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LxXXqnCb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PC3i6Itp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718954202; x=1750490202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=92sjHAdif0qYVFhnEpOAbidxn3yIc+mngyUKjpk0Kmg=;
  b=LxXXqnCbrP9AGTnP8i2TxbqtlaLbJaq2BXAERJTkGXgXgKkwfcdYFhQ3
   C0OchC4lnwGcxBCp5fyBaN8B8JzPOzVlKRh9kHY7WlJKpsNT9QX6HynYE
   dY4+YKeQLtjn9rQU1826h6HkeGXCB+FvX3MfO5apvYg7s9WLgzKwHMLie
   i7f7SyQ3lbY8JINLoRX2UR69qL5yYmmMKVuYkTsRtxGaMniGxauSZ/jNF
   cK0pYCyKrHCgHRVr1aR1O5kLDbKEn1f4vv5ZOtpTAQFHdyVWR7RiL14pa
   NCH1dIp+H+0xm2pnJgUN/3Gii9Ibrxa03OyBJThSVhvqTT0WdUm8b8GBX
   w==;
X-CSE-ConnectionGUID: eOQv5d5DR8mGqx2C7Mn+ow==
X-CSE-MsgGUID: sF+fLp7YTRyTDw0v+3X0Bw==
X-IronPort-AV: E=Sophos;i="6.08,254,1712592000"; 
   d="scan'208";a="19384932"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2024 15:16:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc0yuGsDhLZ9pK0UVa6tfd5hjCXetFoUc3rJMqLrIcGfQevtQ4WjE/1XpGFLYyOJMvUjOQNV7woXFuq4iK4gbHvmt/NUAPEs6vZRhysgAurpQVsu2wUSxXMe65CRa0jer9pwEKdhbTc0aq3cazpQA7oI0JENlqjORzl2j+Kjf7/YVTOD6+O1SydkA9GmzceQMnAFOFnsf9lNXlt9QcOkakVjpqfTFkbPfwpv2pMWG4vd0AqLUNsOQH319q175CBg73dMpO22urQgREIG4UqWzqeDHyFa5MTLD13Lp/kT1/NAAS5ffyQIHNUXYg1imZ85ExHf5715R5n0awv/f9LoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgLnJuyruprYswDYvmB9Jfm7x2UFoaZys+bvGeGcVYs=;
 b=IXQz61VKurj2G4w/mtHlTGwVSyeq7fQe0t7VEYRPqmo2tcHeDiQqp779aSSMO8FgVHRcrRQY8MvEaCHrSleq5CelZomcNRwLddUBirl1kI4f+eiUDH24ZVs5Wj20ruF6hmyfOlC8e/ceUt1bjS+GDYaD+c1rzjrKVuZF1EelyIi5rb6wyAdMSO42tC5wEN9e1wCmWxAQeHqZeYWPkn7FEW8cTdt9F5WpZGcTdpLrt9rmy9r7sFxdBrpWWi1iv8CYX7yRrUUJz/hi0G2+5wsewDs4g5BQCI9yPwnIwtXtmpWGBhKJBZ2g96iQBUPW98gnaFCRWoyXYkexgEAxZUVs1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgLnJuyruprYswDYvmB9Jfm7x2UFoaZys+bvGeGcVYs=;
 b=PC3i6ItpmXpRgaqVnvyAYDvNy37N3OvaX80k0sz+3Vw0GkYIJs7Tu6B4ZE4RXRhdIGdRtJlKPusbyb9VvmCio2P8LrwkYu1sEmJIQT0jM9djOt3DDku9kT3poZnSl/87dKtnE/xZNufZTQkKO94+ZEeRQNLdUwmAU/0cnK9ILDI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA3PR04MB8594.namprd04.prod.outlook.com (2603:10b6:806:2f7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Fri, 21 Jun 2024 07:16:33 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 07:16:32 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Daniel Kucera <linux-mmc@danman.eu>, Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"alcooperx@gmail.com" <alcooperx@gmail.com>
Subject: RE: [PATCH v4] mmc: core: allow detection of locked cards
Thread-Topic: [PATCH v4] mmc: core: allow detection of locked cards
Thread-Index: AQHauBNeZ2lQZ81CBkKpvc0IuwzTHrHQrV4AgAAFyYCAABomAIAAPkiAgADTplA=
Date: Fri, 21 Jun 2024 07:16:32 +0000
Message-ID:
 <DM6PR04MB6575D856FD5D5E61D40576FAFCC92@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
 <CAPDyKFpuJexp_1hgKhJ3b8VCx+PwwhAQscbJT5-44Re0xmbxrg@mail.gmail.com>
 <c89d8a0c170fa3bc8593bfde25b07e4d@danman.eu>
 <CAPDyKFpLkmU-vjAaM=QDkc+3F3tMNjViOdnYSFNqyDduyfBm1g@mail.gmail.com>
 <6845f5386ccb71908eedba833e8ace29@danman.eu>
In-Reply-To: <6845f5386ccb71908eedba833e8ace29@danman.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA3PR04MB8594:EE_
x-ms-office365-filtering-correlation-id: f958cbdc-3ac9-4abd-2b95-08dc91c213d7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DjJv72TXXWsRou7N6y0IVCffM2TSvng4mZwerTGqdIUOTsuqc1niyryg/gXG?=
 =?us-ascii?Q?jKRyU4Yh7FNICUhjmKe0MwoPWF0v8Jdd+47Tye+MGO1p+eSwZzdHthv51Uwu?=
 =?us-ascii?Q?0vr8HwJ1UeWzXxthPNY5wiejpVzOsmmDF6SLuKwOGQGDsi5hKWsYUX6MVV7Z?=
 =?us-ascii?Q?Q9KZ3ists9tywIPQht9GN7VL0wUuG6y8O3srkcM0sEihfWqOisbSAUije8lY?=
 =?us-ascii?Q?+lr1AlEpDlsyLg86+VE18FcSuBGowHt7AoS2Q7/a0ROBjgKaa8JzX3AeTCMS?=
 =?us-ascii?Q?SjwRdeS1m13WYTLb6AGWatSF770dwt8gvBdK8MNPD9MBmYyki9W0FqpbL4Wx?=
 =?us-ascii?Q?2rc5m0QnlaCbmHjofhrRwSMSBjZ/Ax8GFnGMEXd8bLgWNY4iN4Lxvt5jPO6H?=
 =?us-ascii?Q?IeP3CQcWCmwg0Owbwzb04wp3jTWvu5hUv0tFweCAHjVV2z9595dG94VUTnK7?=
 =?us-ascii?Q?iRRm93iKJ21rjrMTnNvC47s17x6rATkKwbS+3bnMpu+nUVKont3HKYV/dVIh?=
 =?us-ascii?Q?OU8skmmCinYTYAW6vh5q+eJhlNWv5CK1uVrD8GImdzhOVXvnldgQyxIE8JTC?=
 =?us-ascii?Q?44R149W5NIygSWx8QG1n0Fls8PlqBX+fIWnMDb6QLiJYopX5laqgqd2lXOfE?=
 =?us-ascii?Q?IS/ZvjE9ZJwUNFhroaKKk6KoRmgDwL45urmtBg8eTWaExyBzNxsOf603TRN4?=
 =?us-ascii?Q?W2IJAbNHrUthjZdgpzZUkO8nHjHwIUXyE02dTD5T8np2qc+G8VZ3O2Y/vYKl?=
 =?us-ascii?Q?78SBNZI9dgZno+ffWfKqwMGa1RDdWBwAVGiPM3aZqqDBR6e4pDsBZgQyv6Cy?=
 =?us-ascii?Q?fYaNcZrOBrJ5rP0oHOrWe81Mp5B+jcsjurFtkWQFORk4cMw6tPhDF+e0QuMf?=
 =?us-ascii?Q?Pnr5dqRi4TK6siMWxigNeyfUeU8NyK2D4Pjgwx3jT9+8hrtQ7KP+fQbKfGEd?=
 =?us-ascii?Q?Bvcbfxy9LRuneoenq5OAmocKtq49GDpZGm6CD3bqs050esCPnCUdWC00bJw3?=
 =?us-ascii?Q?Bi+G1VAMoQF+8Zaa+4r2RmDj5ON9Mue2MWIid1SB8WVTM4ZFooTrPos7ex6K?=
 =?us-ascii?Q?Xwdeqe6CJ4WkNwqolqiX+8wAs5b5477KN7o8+woQoWmSxXvYMOLc/XiuUq/h?=
 =?us-ascii?Q?zF8yDB410Zlw1bDufZ3Q7b5BNx3FOwd7S4bznPtFzm1bQaEMuzYbnt7d4cl2?=
 =?us-ascii?Q?ya3qrglsNr7Z6qbph3B2mqj5QWh3EhZ7i88/9WJD6thsTyVAdnMR7xczgkO6?=
 =?us-ascii?Q?LbI6zgeeMzKC9z7cyjt3eLTBrmq3IZUckCg34BUclF7fpSCZOZGt1MnzB2Ub?=
 =?us-ascii?Q?JZA3mfAthLdMXMCvnymRuhvVcC4oGz7kViCEgH7L2lPuz0vJGP9buQcwZ1mL?=
 =?us-ascii?Q?ocM2qj8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qqKA0kh46SmlkiHno2hz0ZbW1dlGnwyBLz5tLGjTdmux7P6IT6SH2bf0K7yw?=
 =?us-ascii?Q?6wmsIuPPviLngH+gCDgq8GN1rVZsji2kevQA97gdcii8Giopl+PScdnDpH47?=
 =?us-ascii?Q?Mkle2YzSjOPN9WQG6trr9wwGWMDrH6ahxX+fVfJG4krfSVBQ77Db76maZh44?=
 =?us-ascii?Q?25oNiMqT0P7Vq5DlhDsluuqdoGDF/sPCa/GxOwsNWpjKIj7dVimYT/+k91kd?=
 =?us-ascii?Q?/w0qAsmEqQP1mL726MJU1TwN46qVoYaZkqpiRq8hBisod67AWmSkn+j0mvkU?=
 =?us-ascii?Q?ZSv6t6PFRpYwHJOg8hoYxbckFu7Khl4HhMs2MW+l5VSHwL9Pcr7cnXUmYjeI?=
 =?us-ascii?Q?EeHsPqjU6GrFXFa5UA6rwr7BaGiu6EfmtPUcKdo2wEFSKtMJzGVIn3sJOZos?=
 =?us-ascii?Q?c+TL9ywpNel1x02awfihboYoBC7uaTpwjONjLgY7YbtzDc43ajkPEXUwovzg?=
 =?us-ascii?Q?aqo7Y/1RicOLIG3M7/7SRg36zrBuZivXeZMG6cnaWCuZhnnAwXF4WepcdbN8?=
 =?us-ascii?Q?K5OeFgb1zxr4skiRzpsHShTd8ZBcU9zVy4biM85/xmrW39e0LvbTjPfV7kpD?=
 =?us-ascii?Q?+IbVLMZsgR5b8lDiLTSescK4cldS1tXOnK0dsxRZjYbEOKszG/j8rMvBUYGr?=
 =?us-ascii?Q?BPZW+EYBqTeMOO9oUOI/rMelb5ssiew287mtBvARqV/C6TrlwUXE+2ho/wox?=
 =?us-ascii?Q?fh1tMeu1D2sZv4ZORof5hpO0mZhEYG9gONnlafmngoglUbHltP3ReB912QsM?=
 =?us-ascii?Q?/OviG++zq20VtH70yRk92LOvS9tOJ3oXxG3vXRTyUIiMiaRoYYsBzDqQ3Wdp?=
 =?us-ascii?Q?M8NExat+vP4Zki6jlE5Fh2DGXcjlvodQLKbIC32Jv717porRHczWl+FoTobk?=
 =?us-ascii?Q?wM9PBuRQASRK1TlOqzr410/Qwzcb+zIo+4iFSMNJ4QxErt/07AkRseHGUU+S?=
 =?us-ascii?Q?JXbadLLfd3tVw2A5qFKJPHgnNHhq+UrUudsn/WtvPljY7L2fjok0UpCnP0Af?=
 =?us-ascii?Q?sPnvPdcQmSikTu5FdwhCQVf3qyZdrsrjMVF1HOc7DWk2z5WmFXC7oC54aipN?=
 =?us-ascii?Q?T9k7aRvESDs+0w13ItJO7e5Sz2VYeqbxXtiaHorArH7+d2EMwC/mqyrIYnMz?=
 =?us-ascii?Q?9xAac0gix/URE2ezduplaYzFw9ATSgvlwelVK9VlQupQXEWP9F/Lg2djDRLT?=
 =?us-ascii?Q?YURvdOJyU4H9fjXTgQNkMCGbuIp1Q3OvNPo+5Mw7FvKhAApfETF88oXMwq0N?=
 =?us-ascii?Q?hkx2ky6MCjoDfmiwTa0ngHcK80mRCe3Oq3cTfOIvUn26fz1K7xG4No+sLkNV?=
 =?us-ascii?Q?U12cVkXvG4NuxzpUQ8kMXHiPGvHAn3s9tIkQwMcf8Y5px3IxbS4K+nHyM/bg?=
 =?us-ascii?Q?+yLNN8vNS/n9bNA5XhyXosOMkAs6sPkhzemJdeReuYOxnFqQd+LjbleCCtEo?=
 =?us-ascii?Q?39/vY7JjxfwauWtjIHhmkPdGwuWWZmQkeWCsVjqJFsIrrANPxS+DbWYPIPu7?=
 =?us-ascii?Q?VqIVURmuy/pbrvfAiHmC8ip5FIzIda2nOtS9zWyuMCZOvMvEKr9Wd4M+3l8z?=
 =?us-ascii?Q?AI/RQvnbOqLUUDP0r9448/hojzSjsGD8YbtNTMg1mKVCLOXC/e5ufqCMZcQu?=
 =?us-ascii?Q?pcixL5EGuJG416THjM1N6G12tvdAH9nS8Y2ZPnplSYGp?=
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
	qIp6kLQqclzFophJUmkxBF9wbMrVHCRgY0zXGr6ygoUr1TngZpTNwgnW/8TUfhAJsSy90LzTHglnCx6tIZGkdB1lFYC5YN1299QRXHwirSxPIMOvqv+DaRegFV1+ny+EsLS+CAtcjL6olD8KAVLI++7anJmdSrSEgBMqghJlKDzfD2TYeD/gH7FkeZmc5NrFDd++DITA5VbjbCt0syxJVZ0DBjftIMC7P0+brzq2N4oDmEQfPqbb9+w/q5JLMAAqksbjRfEc++NHtCyrniLiH+HPMBGqu/6sJnKF99tqoWyWRqGCNmSawMIE3rRN30hmOzYU/Bp89HHEMxPhb1kxTrX/0zUP6V1/K59BAjcn/p0FWCL4l7UcJRZ5hW1cOw6h52XcmvvnF0752imhRcTF64HL5HNOdjDAceF2DplVH0N+WOILz1dfOPmWoHKOnXqkElM4b86yWHcxrCF8Ilyz19QLEz3GBJKyFngQwDMRYYZ7Iq+eiRhrhs0E1sGY1wNnnXCEy5ws9BW+Hp2ubsSGC0VMnJE8YpxCnIAKRy4450x81LFvvJBOn8lG1kx3nr5w14pYiwr0OUXRZa6EfI6fRZYbB6RoRS6HWsVmC6JVJCQiO80skIUHoyTAPEDMKkgn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f958cbdc-3ac9-4abd-2b95-08dc91c213d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 07:16:32.1960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZ/gymDGHZqYBzxefwMgIf+FFFClVEnEkWAA0+nD0taL9uP/8eyzbTf2E4kCdvm448eqR0kiDE2UVBSksg6TxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8594

> On 2024-06-20 16:32, Ulf Hansson wrote:
> > On Thu, 20 Jun 2024 at 14:59, Daniel Kucera <linux-mmc@danman.eu>
> > wrote:
> >>
> >> On 2024-06-20 14:38, Ulf Hansson wrote:
> >> > On Thu, 6 Jun 2024 at 15:12, <linux-mmc@danman.eu> wrote:
> >> >>
> >> >> From: Daniel Kucera <linux-mmc@danman.eu>
> >> >>
> >> >> Locked SD card will not reply to SEND_SCR or SD_STATUS commands so
> >> >> it was failing to initialize previously. When skipped, the card
> >> >> will get initialized and CMD42 can be sent using ioctl to unlock
> >> >> the card or remove password protection.
> >> >> For eMMC, this is not necessary because all initialization
> >> >> commands are allowed in locked state.
> >> >> Until unlocked, all read/write calls will timeout.
> >> >
> >> > Skipping the commands above, only means the card gets partially
> >> > initialized.
> >>
> >> Correct, but it's an improvement in comparison to current state.
> >
> > Not sure I agree with that, sorry.
>=20
> Are you saying that that being able to work with locked card is not an
> improvement in comparison to not being able to? Or did I misunderstand
> that?
>=20
> >
> >>
> >> > Leaving a card in that state seems fragile.
> >>
> >> Fragile in what sense? Nothing can happen to the card as it is locked.
> >
> > We may end up having a card half-way initialized that we can't really
> > communicate with in a stable manner. From a system point of view, I
> > would be worried.
Actually, it's what the spec expects - the CARD_IS_LOCKED is carried in CMD=
7 response.
Then the card responds to class 0, class 7, and ACMD41.

>=20
> It's not half-way initialized, it's initialized correctly, it's just not =
using the full
> potential of the card (higher speeds, etc.).
>=20
> The situation would be the same as it is currently with emmc. Locked emmc
> gets initialized correctly but reads/writes time-out. What is wrong in ha=
ving
> the same result for both sd and emmc?
>=20
> >
> > I would rather just power off the card if initialization fails and
> > remove its corresponding device from the system.
> >
> >>
> >> > What will
> >> > happen to upper block layers and filesystems when trying to access i=
t?
> >>
> >> Everything will simply time-out.
> >
> > Yes, but it's uncertain what that could lead to?
> >
> > What will happen with power consumption and power management
> support,
> > for example.
>=20
> Okay, this is a valid concern. Would it be acceptable if we just enabled =
this
> "feature" with a module parameter, something like "sd_initialize_locked=
=3D1"
> with default 0?
>=20
> >
> >>
> >> >
> >> > Several years ago Al Cooper made an attempt [1] to manage the
> >> > unlocking of the card during initialization, by finding the
> >> > password through the "keys" subsystem. The series didn't really
> >> > make it to the upstream kernel, but overall the approach seemed to m=
ake
> sense to me.
> >> > It should allow us to complete the initialization of the card
> >> > inside the kernel and prevent unnecessary complexity for userspace t=
o
> manage.
> >>
> >> Yes, he did a great work but obviously no-one got too excited to
> >> review/merge his work. His solution was complex.
> >
> > It's quite some amount of code. On the other hand, it seemed quite
> > straight forward, not that complex to me.
>=20
> It doesn't solve the situation when you don't know the password and you j=
ust
> want to erase the card and continue using in. The (un)locking doesn't bel=
ong
> to kernel IMO, if it can be implemented in user-space, it should and it i=
s more
> flexible that way.
I also see little value in handling the unlocking process in the kernel.
I find the proposed approach, e.g.  co-exists with its sibling mmc-utils pa=
tch, straight forward and simpler.

Thanks,
Avri
>=20
> >
> >>
> >> Mine targets the smallest change possible to make it work at least.
> >> I wanted to avoid a solution that would be hard to test, review and
> >> maintain.
> >> Especially when there is only a small interest in the feature.
> >>
> >> > Perhaps you can have a closer look at that series and see if it's
> >> > possible to update it?
> >>
> >> I don't think I have the skills to revive his work.
> >
> > I see, maybe we should ping Al and other interested folkz to see if
> > there still is some interest to move this forward?
>=20
> Okay, Al, are you interested?
>=20
> >
> > [...]
> >
> > Kind regards
> > Uffe
>=20
> BR
> Daniel
>=20

