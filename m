Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E831E828
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778994585; cv=fail; b=UqJm2WIFcz3Day+YNn1mkVawJafi2kd9rFVqwEYp1YWDtSqGcT9JI1TMWzGMlvrNSh9WQzHDtMewiuiugQ1EValx1gDovRrnVFYLIU3C5VdR2UtYHkpL/e1RedV4EgJipug6bMMsoNf+4aaqoAJZTtYqTXBMHMY/wfIgcOW++Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778994585; c=relaxed/simple;
	bh=2Co7l6cv+Ee/0ToMZyAuaV7jyWUf5fjyMubF6HWEd8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EmusCDfQWsQYTE1/Wck2LUQqordNG8cXL7FWIuU2TS8aD5OEiBLkyhFGdV99WbVZt883qgLyGxceMqC+I4Pf4gfjoBY6lh/nU6lnU7khxlrjO1WVlEQ90++EmzU9/0+VeGJYIrhcpZxPym8931W5uvfyom8bCSqqp1SpV6h6zRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=L0huzQO2; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="L0huzQO2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778994584; x=1810530584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Co7l6cv+Ee/0ToMZyAuaV7jyWUf5fjyMubF6HWEd8U=;
  b=L0huzQO2bPgZLLCeAWDIag8l3KAcRxXOspcYL7ofj/Gn6A190nIwn1uw
   juyKrQNMkx+TUgzH+4sZe//NYWeIwUs0optCwnucv0AJrbdob6xX0yGvP
   +uGsVDDPWHSsxdyyEQRcKTFD7tGW2YCrhg8bA+j7r+0DMo+b8H+LhVEsQ
   PpZ2BY0Zv3OZ/TBx97czrjsnH8vOjGbdBV7RBeMeUrTWJQlRuRhVVit96
   iQ9KK9YtGL9So6Waos9UHCuGQz1FrMsR9wei4X/hYGv7Zl1pCp4NDDNcn
   bOcv2gbQzCr/9dUwdOMrQfCLI4/E9ySGJx9Az2c4q/HYjCYJV6u7mxR4Q
   Q==;
X-CSE-ConnectionGUID: sUrSe238ThinV0fSAV5Uag==
X-CSE-MsgGUID: C0z1olSkSkWEB8/SRhYjBQ==
X-IronPort-RemoteIP: 52.101.193.7
X-IronPort-MID: 22726079
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-northcentralusazon11010007.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.7])
  by ob1.hc6817-7.iphmx.com with ESMTP; 16 May 2026 22:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omMBEXyR9Sd4K7DohZx4MJw82rie18wXOeUg+T1n01dcK2MKAedDoNnixT9SNYGT4QJg8YibryJcxA/yLD/EJvK4LGStvt0vzhCYBhz2+l6gknyrH+SjCf3SeWi+2gAGYU5s0OE9EEURn8LMdTKrXfsnpQRY/ku9IBKd40HJUlS+FASOJKNtshO+8kIiPiwRx2gkIPkdYC9bm/skcaPSZI/+Fvqljcp2fLMGK5NGrhHX6+DY8ikIcUetW9poO9+EDpVqj6SUETDCyLdXlvvzW9AGXfAeDhNc3peo14daYPwW/ITy9iQHy6MRe/aJ6UOWbLOJX7b9smR7/fgjwTM4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Co7l6cv+Ee/0ToMZyAuaV7jyWUf5fjyMubF6HWEd8U=;
 b=HCeRP1I7LCrmCNjm6bPYRrbjQSZmQNYHyGKS/EFwue6lta2FwARWufXilPZ0qQZFFqOvY1pbUc3xgdMmcjSpJJLtbw6DdfKKKxWkeTpWj+fJzCFZXfQcyz/hWOBPOKRPUuhRDU0a2mTmbgpNdu3CCzDYEEQqengz0CtT+/RQpmfHKaR4eUBQ33HXAoyc5Z8ijm35y1zSd38U0yAeHxF0e/h6jcYObalYd6nY1RDozbB56d+X6MdOJUKrKPrerrR75GA7y5/VS7UbPXOhg7oHLMbI4g9mkgWJ2KT3WrJFyjGjRbCzn/ngqiiQDv5uc+j74j1PcIsZrzJlQC/nyOO8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 MW5PR16MB5024.namprd16.prod.outlook.com (2603:10b6:303:1c5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.22; Sun, 17 May 2026 05:09:39 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 05:09:39 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH v2 1/5] mmc-utils: lsmmc: Refactor CID parsing into shared
 structs
Thread-Topic: [PATCH v2 1/5] mmc-utils: lsmmc: Refactor CID parsing into
 shared structs
Thread-Index: AQHc5LMmldQUgMVIQ0SgyvnbDMIj77YRrRrw
Date: Sun, 17 May 2026 05:09:38 +0000
Message-ID:
 <DS1PR16MB67539B7C566BBA7A7D56EC2DE5022@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
 <20260515213747.1452692-2-torsteine+linux@gmail.com>
In-Reply-To: <20260515213747.1452692-2-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|MW5PR16MB5024:EE_
x-ms-office365-filtering-correlation-id: d9e70952-3c1c-4be6-75bc-08deb3d27f18
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021|55112099003|11063799003|4143699003;
x-microsoft-antispam-message-info:
 JfU1mVfX9NpY+lXz8bcQoXXkDLLmu1scs3lEX4w3sNswJJ0t56Ps5eJmZVgsimsGzYdegst2ZPj4nek+pIWm6U3c0lLWIbR8jXbcItPyw/wRY5BojPDwKlz7rn4hFF4J5YZ8U8CCV28a/ZWyuxjiM8NSj21/kdVzCZhA8p8iAq8RiuIGR2xWU++/fUWYLO/CvgOoE048N8imQtVkGEf/75KzquCaSWtctEoCT5gnyZo+7AXQzpHJEJIPeScShWHwEBwi0XccoIcc/34jdeRfVXSnEY1bCsjZ5t577eyI8QyPfipkbrVmDOSL72vMT8UA9/GutKqxxCwrAUkJTr1F3iVNHFazvM2BV/NhDUA/ixcc50aB9hYKA5fcip6cahu4FvEDeglEhQ4TknIK4UUF7rCv1asigcU/swOkmJDzNfvhrc+/9DQ9/LkujQcUaZkMV5MKwuya5198luxUEkuO3/RqgwW9AcM3l+n+eRnxGLfBXAbyeKJW5OK3kN/lhY7qF3PsT1q7e1vMb3jTOeFEpu5fsWytYlz8ikDKCyoS2mGMD/n9oqEhMAXxLRpwk7dA7nPkr9IBRM/JWi0P4d540d32q4pjiDRkyShsT2g+umNnje/RTOPn/f5XJBTqMyiPt9dXtyuNaWXIcnQKoMdDXawRYc7X4DsftXEYPiTshCiMhBWiIzAP/7YsUbYLllv5vs5T06ILgOYV052FdLMxFzRrKj30pxbW9yJNPWhl6d7KXiTqtwbVK7ItZKHQn+xl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021)(55112099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/qPZmrsdTfgwelOIn/ajFL/xg8os+rjY9GZyMs9WSgWaaNREYK0vDUfHOVAt?=
 =?us-ascii?Q?C07kPoWYyWQIYZPDut0O2UYpqklt+V/ZA/Kq24KOpreA/npVPuCmej7/IuHK?=
 =?us-ascii?Q?30pacaAHNy3UEuTjXQ5k1Sf3N7A5FawwwnImc9WbWOaD0evbpODz9eVz1psS?=
 =?us-ascii?Q?xpQyhuuW86hda/E99MKVKwHW4KbzimRTMcElfdSeVy0bwzWG8YI1ylNklEU8?=
 =?us-ascii?Q?htrf78GYezKiTwnDxs8bctTiE/RA/A6HjtulbuLC/BFGyTsKnX4qXI0e5e0m?=
 =?us-ascii?Q?hu4/DJMs66knV62eA4eLHtUSF5coa/unjanJ1svhQpVafjaVusuV9HvnSkBE?=
 =?us-ascii?Q?RqJsREUfI085f505fwofb5/ysHqMrsG9gTMJIVPC3oOQ++nEnMsal8gL1Sc/?=
 =?us-ascii?Q?hwg6ax5j2lYwnbBo3K0aXJtPGtx26f++TRGUx5Uj55Iw+M7glrGvZN6gRFfZ?=
 =?us-ascii?Q?S62qpr6NbyvjlcqdgsIyfaE2Q/k/EZHahGJKLOGLPKPwNm5+QRHQLuYW19PZ?=
 =?us-ascii?Q?I2f9jC+FSegB1SVPRBbKipbbwBBYAnGE67nu+46fup036BUuQwJjRBVGC47b?=
 =?us-ascii?Q?oA5jj5H+uXUSMTZfzMQc55v2UXKIaTIWHo3wGIXl/EYV4we374l1RKenVdDR?=
 =?us-ascii?Q?l13lSo7n3sGUZ3UFiWqK+D/SbEadQno754tzHT2DHWdTFo6RAZW4TR1Iv8GN?=
 =?us-ascii?Q?wjmrULrZrtveY5cyo/yIyga9+N/QT3q318uiybdyhsU0sQVxrLlD9N5x8DTs?=
 =?us-ascii?Q?D4ky6IRQDmWgwAHWZ+n+kCdJEop0wXJiovnderGfrmJeGwxRkJuv11PKBBIT?=
 =?us-ascii?Q?PP1GYUT9Jj9Y89rPQAKcGLhfBbb9/9rekNV2gXh9V9fR2ndIujnizT9u3UL7?=
 =?us-ascii?Q?7EHaODGT/R3+205hllt1UHmizsCOSSrNP6xH3VspSlMLUvzf2JwUk+ESg7nL?=
 =?us-ascii?Q?Ic/zctINlFXZPbmKQfimK4lYrW9L22GKCRowCcbw/h/b9FUiwTIDAPtY7xZh?=
 =?us-ascii?Q?B0X6Cr8ox03tFeMDbP4qns7qEl2+1w2AGd5DRFAdcfEnVG642TuXu7HfLROr?=
 =?us-ascii?Q?ZFnm3yGjHCAwmHKQeFUk1n+kUCjM/Nl0nAhp3qFQVuS+B1w0XqXwnPVkCKhW?=
 =?us-ascii?Q?+7kTGKS0d6G3RLM9ePP9BrhA6z4r1ncZmPc68GdhJ1QQsomqWHuSopUuqbya?=
 =?us-ascii?Q?KCSjW/Bvt0Rq0qmDIydUqInSho/gJmPWbnYi+QtyVQ2IuX19HXJsFRgm411a?=
 =?us-ascii?Q?cE8FbKgpqTWNI84d3+gXZP+rRbcwbYnBUQX8hTseSww3BJOadt8KvyHSfxI7?=
 =?us-ascii?Q?TfFiXj0cbHes2+ThGJdQFl6/lNGSfeVxG584IwCDL881N491fgaR6lobr2NS?=
 =?us-ascii?Q?LuYutK/Lxs9oJaIaUq2xO1M3/kWtcd/G+Qs0+j0Vg/s4leAgX29ImSzddQ/m?=
 =?us-ascii?Q?xcpX+tTn/XznjuRkq7xWmByW2Uucev9hGGK3PVPaZh6xifxeKMS+8CwlnC5H?=
 =?us-ascii?Q?7iXqnLStod509fdEmwLPY1bQpFfSv0nFPudI7O049Iu/sJGxHkqgkDzx7kFf?=
 =?us-ascii?Q?TC/fmcFmNddM9U9uR2qlxQndPF4FsIoq905sb4Uk6VaqtCgtyMWLWzPsAmfK?=
 =?us-ascii?Q?WcVnHLOg/LQdTHrlnCxhc0G0e9rKQDweJe4ObmzUxyMgDDmslxT3nBvyYBu/?=
 =?us-ascii?Q?84XIwaDjGPW4H7+VjmzbRKVjFnxyQC246eRUCkk5O+C676/cvH9YZeYmQ10c?=
 =?us-ascii?Q?efPqk1raaw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YXXTzzl0Tl0rxc2Dp43G/fXJAV9TFnzzxx1mMDreDeidKDBRP8553Vwh6Y0UK1G7YZ5noRS59ENR+7Ax1W2shX782+1pr+SKOc7cJm1r6OpWlT/23vu4WjKnUKk7MD7mX0db/v14boMu6Qo1Z1FzJygBmPJ07FSsttWUKR7EnV+7zJmkR2hYhqwH4u4Y4Fp2DyZUyx367uo1+jgULjGpwZZkVpJxXVdpTrrpWoOJuZniS6KzcTXOhpG1CT6psHQ+jZP/5d1xJPG4XIWwfK+Ez/2/ZvTWcbkA6HLTWO6rWKbbouR8c9Fo4+9BH+Ubz7JDEgVs2iAlMy0XnK9+EEy4qQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Q6zdWvHdzO9l4YYmn7TXWzZ5ANCDZqqung8/fOBswDmSRfStrg80WlYrCFkn5Ky54ycktQPvf4vpInt2bbI7GLmpGrBxxfpei9O4fCpVbpwcbE9RCNa6x/PtZrrdnv4DyfSiu3jF+6iejRZF9UkI/3XJhmpvUTpbCHcCLXNsJrsi3Ih4UVA9qq7HXETqPWRLoe3m6PbhmsItTa714wBClTnErBhAXZMdr3v8PLY3SrRK6EH/Z8Sct2Pzd4UqxjGZFhHGvGnkTakJeISJe+SUEvo1VCtjYvqQE8z9+0/L5dkO/jhut2JiJeKxrFHj3OzmMfDu/kGWctLIOWkM3BcXtyLWkTfAKxBvpklvLgG7wmZYCzXRMR4NuxzAWaonNz0k44uh4XfF2DAWmkSjb+58EXv+zUqBbyh5ZYA9UklP4f4qlxxIABud4r2Vn4vbgA6yC+P+HCnfJSkSApJRgYSRbC8XnyQMAwk0D+QdtIa6/hI4UcsbttUmGlNvhuOgUDMY9VBvcUHZRwc6dgMPlZpDNHTwVM7wVcyF4Zzn+1jRCn2NzcTPJ29iplvE1kNvVaJc7F3dGYhG3gjU3y4q5E8t1Ie7aXF51RuXiKj2d1Ew9vNTyDYoAA4NEusYwALYP5ltgYEc2mFnWokemjVkaxdow==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e70952-3c1c-4be6-75bc-08deb3d27f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 05:09:38.9716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3MNUtkG/uVSkptaol7X3MHa3MKDSzqZz6leI91GZ30gPwATcGUE2CHuCV+CEk7BECIpfemct8zjMFZeUJV+L0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR16MB5024

> Add struct sd_cid and struct mmc_cid with parse_sd_cid() and
> parse_mmc_cid() helpers. Use them in print_sd_cid(), print_mmc_cid() and
> print_list_entry() to eliminate duplicated parse_bin() format strings and=
 local
> variable lists.
>=20
> Also fix print_list_entry() using const char * for the strdup'd manufactu=
rer string
> without a matching free().
>=20
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
