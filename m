Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C11E53F
	for <linux-mmc@vger.kernel.org>; Sun, 14 Apr 2024 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713091824; cv=fail; b=sKS+L8lRyjDq6b2XyMDNoDrR2sKbPrq0vkgjRH4wWKkhcQCpeMacn5s821bnAi54R+/bTYsLhzBxTFqPIIZQc7AzLGslNrZxPoSEAD3WyG2gwlutWwWGPTiRyN24WIcLJEfce/SqSppgnL8ztkH3n+yKtdzmSRu0lyeN2o0pI40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713091824; c=relaxed/simple;
	bh=9jbuoanleTgqWaFsXt+e1US1CW8tanxU8FnYS/lZLdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tm3wKgSOPRw18JhjyqVmv1Rqflsw0FH1tRLZO92QECIIqrTZwjTXAb+DYOqSZJNruPp5kkai/HPcRrplIVWHJY3e7zp6yXWpnficECUIlFvQ4nyiWWGDasC2MHbTkcR+7g605t43OLNYVdijx31xsLrd1cDsjlpuXkCdPISt9yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JABHtusJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pXF1LB01; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JABHtusJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pXF1LB01"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713091822; x=1744627822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9jbuoanleTgqWaFsXt+e1US1CW8tanxU8FnYS/lZLdw=;
  b=JABHtusJX+cRtmyK4RopGnPIX5wV8BUS2IZsfsPINpvseNkSj04YovNw
   UF9S0GdGi+5M7VA45Mxboy7L4axm/HbaKU5UWSFeHrhbIqMOtI2fNENp4
   12ckFfdS/Ls3jWBlWQ69zTR+eZp1tZqBllv2uG087jhH/+evADd07W6aW
   04Wqn3dvJhmrft7BTfJR7iPURohao8M0fUQJJUFBfUpBUV7lLjtbbNTZf
   kOdJW0x3d0EOlT7kU2zJCm3xtm9otvjTluw9N+mYs1RohwXs5qFg8EVWC
   qw6fQrCjPYzAoWaZm2OIYCeK7emUf2k3/a+khDmbENncfJVHimTCDIRhx
   Q==;
X-CSE-ConnectionGUID: GTGAuNgpRKaOFDBCsM+N1g==
X-CSE-MsgGUID: C0QSAIgsQ5+9AoEQf2P3dw==
X-IronPort-AV: E=Sophos;i="6.07,201,1708358400"; 
   d="scan'208";a="13948447"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2024 18:50:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISOsrRLqo5OoZmkitgkraNS+ku3S0jz8qe/nb/4uE5ZCDuu6FvRvznj1Z1YWMVsa6bfHl2AE7X/QHH3cKuh6zqcQs+Yqsb0dAlUz8LTSP6h0YNoJvkY8M8NI3iezqRKb1pnB2aRr2RXVJkPQRz7zVm9r/3mKkZlx0iVVdZsp+hvn3W/Sn76Fj1nkatgjwXPWtcp2J00RSV1Egd0ECbs5Uab2BcNFIHzBCVnyGdLPp4AGyhXwR2PnBSZszaZvrIHdMTsrsuJraIbDGrr/+WNBRqNr+fAgmjWKDqT87WgjWLyfielO2eG6ZBMDSAnW6bznLY/B0REv6RzQJuazO3znrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jbuoanleTgqWaFsXt+e1US1CW8tanxU8FnYS/lZLdw=;
 b=OrSkcps8K7/MsytAPsRzg0itjMSaGllVUnKTfKGlTIWb6ZYljV4aHsPfdaxZw3tED+O4D0kRcNoc8a7pkKu7vy0fGwTLU6KRTqlJadNgw5VJ8ltBkagRGbAhh1W16XL++MQMF2DMm6GRtrt77YJsFNhKdWd/xgrfhE0BKnSBvLTK8Mulq24NcjSwgN8uSOneYm0MLVUyohxS9wFDPbkcDSaS9uVulhS7ASGzMk/47cSUUwvl3z+hGM8a6BIi4lR7HRoixU3dgdQGq/lyNSAWkmAY0zoq9D3LFL/7X8+LDGg683saTpoStexpQ8TC8w5zuEXsa8v7vVu1giJ9OMDAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jbuoanleTgqWaFsXt+e1US1CW8tanxU8FnYS/lZLdw=;
 b=pXF1LB0164lFCRYKmBmy0tKK3WgmeVR0fg5O5rmSuJ1Tl6ZU52kRTPmtgk1fdj2FILxaQCHGpKLopcPp162up2LboYdu3M3hh9UO4pOaOylzX/SbvXN1v9VPeRnPekr13aXObTc7aKVd+KFpww2eIaC7h4hWR+3NivscBraYlYg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA0PR04MB7434.namprd04.prod.outlook.com (2603:10b6:806:ef::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.49; Sun, 14 Apr 2024 10:50:13 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 10:50:12 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Zhan Liu <zliua@micron.com>, "'linux-mmc@vger.kernel.org'"
	<linux-mmc@vger.kernel.org>
CC: 'Ulf Hansson' <ulf.hansson@linaro.org>
Subject: RE: [PATCH v1] mmc-utils:makefile: cross compile
Thread-Topic: [PATCH v1] mmc-utils:makefile: cross compile
Thread-Index: AQHajOvD0IQ7V2D+zE+SEjm+vesK7bFnmLNw
Date: Sun, 14 Apr 2024 10:50:12 +0000
Message-ID:
 <DM6PR04MB6575C1911A7D969708509A6AFC0A2@DM6PR04MB6575.namprd04.prod.outlook.com>
References:
 <BY5PR08MB6264AE3F237D7E11B9AEFBA4CA052@BY5PR08MB6264.namprd08.prod.outlook.com>
 <BY5PR08MB62644DD78E097A0239ACA8E8CA042@BY5PR08MB6264.namprd08.prod.outlook.com>
In-Reply-To:
 <BY5PR08MB62644DD78E097A0239ACA8E8CA042@BY5PR08MB6264.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=5f2b6dbf-ee1b-474f-87a1-17098f4fcb12;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2024-04-11T18:13:43Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA0PR04MB7434:EE_
x-ms-office365-filtering-correlation-id: 9cba1f3c-fded-4daa-698d-08dc5c70a971
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RmBTh7IBr9rHXT9vq/DAfvjtcTok7CWLLAkKVnKIleDlUqEv8u413RUrvvZYviDCgi/872VZ8+w4KyHJ1r+Zc8f4WafO53+0Ve3a4f3slHlQSTJDr3n+BT+KIV6MSJVUItL2Rf4Xy3uFQPWw8m063WcGkCDOkPjBgaHhhb5bBxjVQgNXhV/wAxcp3DhZafeUNdQZheqH8e2iAnAbU9QAJaluAA6HdghDjCd9qnJXNL2hfELMAnsC5Kh9M/OUbw1xk5uFB7ixtSrK1EdKmM9K11YTiKWxhxjWueJNdQ4cQgDhydO5tJ/ZURqmwZm5fD260feS1iBBBCmj7tWt6HK7vU2Mmu3JaicB6wABDeBqXg/0qbzFnyn6flffOlzdRb0KM475ukgPh3xCXvvTtk1ONaRfAKD3fAu8V2Aer15Ihfmpv4BnTWDwSv7BiugJKfvFvf/DnhA3Md9+ikzf+Xcns7SFVAGJ8704ztKnYXdL9AOoZl9SaOQRKe7x9INzOfJW21DWSszifYQ8PTh1P5OW+vySzgXZWkl7G4VVHzIFD6TiG5hfYVp/PIZwkOytYSjRL0LhgWCSKFuBal4rpAJzE3I619TAbxAt9y47y0/D7iZrfpq0pzIvsYFb5WPwjO4NYM3Uz2BcvuWqDLgu/4z0xmG3pORk13LdMn4OoZX85h18Y59xmQGqgWvCxZd0ybaflOYbieEsSnuMmn7YYIpE/w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OqJkVIonaM4VMRJ/Fwv8HJk0uuDk6+cH5aAc5yiqNGoo0BhHvHFx1Yc22x?=
 =?iso-8859-1?Q?MBwOYnDS0nMJko7tDOqpHs5A8ZktdyR/j0YEq1RA18fFti6LR3BYgapwPK?=
 =?iso-8859-1?Q?SCNNh2pQqI774tsoZPh26bntRHNxNK4Imo3xNfkxNvCtcbxjxWkSMSWwvc?=
 =?iso-8859-1?Q?T7ZyTZvfJR/9K5kguCjbtYSoOSNlrxisJb+8WELCj0/pN3VkGu8Zn0eKVv?=
 =?iso-8859-1?Q?sMGlctf4s+Yx5Bxhd1+mGjDcus5W/jy8XvzJFtb8L98Fgb2tbnBGY3Q5ul?=
 =?iso-8859-1?Q?sZjbkMeJ95ULzV/rWIiZyDAEqImb5YFlwQ5FrgHWbpp+Pdetz8a3ItYujg?=
 =?iso-8859-1?Q?RrDzBNsfI0eoZGdh4qyM/xyXkM6nTOdcwZYBlUCEUafKN6lBUn3z5qO6of?=
 =?iso-8859-1?Q?Hmcd6WrOSoBOScR88ftQz+tF6Ys6LJJ0xNYKmiDg/EDJwTe6rrxRG+p/+9?=
 =?iso-8859-1?Q?+zBENkXDp4uOdZhZxcpI6ndvd2t64GhUgvnb6VrG7qPFmobsERMEatWDbf?=
 =?iso-8859-1?Q?Q1vUYYX2PUhP09z9Vg3+Pl4MHv9mR3+gNUq5SbWmqyM1FnwRo/anQ8TwLq?=
 =?iso-8859-1?Q?JalEMuLdK9DXJHt9pmC1dkEKXp4yr1fK7o85MNg7rQ2tQIYIzMhLyATVbV?=
 =?iso-8859-1?Q?z+7CHMzrllKkgV/aPN1g5b4QfYM4kXiWcxHQKCXS2TE1/qYMCdhbxyNLEO?=
 =?iso-8859-1?Q?T89SmAZUf3ejqC9n6VJAQ2ZYDFIPTjtl40Vc2L3wF8tiqNXNTsLQROXcEz?=
 =?iso-8859-1?Q?vdV0PBbD1NMVw7a0wmCoprwCYcuSyixA6mhPYcbuhom+Q6Vduk5PddG31n?=
 =?iso-8859-1?Q?EHzw7o+tamaHQf0nDxZTolCRlfqvCxWEs1lVpXuzWBMlYIXECjOHxzAmrz?=
 =?iso-8859-1?Q?zuFlBof4BwVwJ9J9NkD3bPRpiKj2uqKWTpjngU7NGEKPIJzpXo0jxshMII?=
 =?iso-8859-1?Q?2MofjMXzHc5l+Dt9sESBsR9B6O0XchyK1ZDtFWb+kqjU2jZWAkUasU04Bt?=
 =?iso-8859-1?Q?fD40AcyGk2T3P61c5qE6nRBZQOCS7l1kpMBvXfHXCgBLa9/cyst2ksky5S?=
 =?iso-8859-1?Q?8LletL0NFF0ofhRDCwQ54k9VkQL9yVWNrqgUwWqeUjwMAGeW8C3l1HUJlj?=
 =?iso-8859-1?Q?YeNSmJ4DSutfnX+sOeZx1tDzkTOiO/SoRn2UwoRwAwVmZHSDJC8eWglSsG?=
 =?iso-8859-1?Q?ApUhanZbAXVT0CQtp/u84cLSQrEoutiodqXBAO+96B/pwpii8rDtlqPHUC?=
 =?iso-8859-1?Q?r2on6tXKv4iZnTS579lXD/mx44Hash3iKiv3piluwwCfKs1KkMSTNnbvcJ?=
 =?iso-8859-1?Q?ftNX6Ecj3/jFTYYqzdNTlSDDdvvU8TziP/SGeJS5SrPVsRfrpL+SqJYg3x?=
 =?iso-8859-1?Q?0qYGxDGZJTqmir6XDa1cnxYF7fz9xZazl/zeCQ/TJHrkmgn+QTQqlmC14k?=
 =?iso-8859-1?Q?ZV4yIvhlBw+MdqfnmHrfyQq0JCy5E6GCemLs6BCrzaJWmS+Q3nG+deVGaB?=
 =?iso-8859-1?Q?Lf31XOh4wVjpgCebFgZ/ScjB6KHbGakimEw75daVnq3EJk1l3DJTvE4JYm?=
 =?iso-8859-1?Q?1ipYL8PNymzRuTVLkDAtZy+fuI+Ztz4SVVW+0lVwjX2RyiW8DgLQdNKIDz?=
 =?iso-8859-1?Q?ttpHIXFsibDwCl+uCuvJeMaepCnDHgAB6B?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w3WrTgsb1Zh943SRsyoi9B3/dYEO/dWXdQ6ZfSSjFE5nVxeDUBcNyco7SRf0fWHpJlW0Bjz6ezoULft/KxS/5sTtBWm02Fg18hnVsSyhljuIB3Uqqt3M7Jkey/SKL66tAcglQcJNisM+UPL9KeONjaMxmYEDS+0n7sGXo74Jzz1LfCik161arybFT0G6ROY5gIyyHAG1nYvZoLqVKjuVpT+8l7x560024F2j2t84WR33i3JuCreUPBxiavpzUlBs5vU6vos05FUmbIwdSR8BRmkDMlXOERuJDStpN3VPtkDaUnxWosedDbLfDIAVs5L7d3DvIopDMzMfI3zIPdXDKPIB2cVkjxp+aeO297H4xHbPDsOWoebiOfHvJfaB8y70fCv2W9deHtUaCQjIt3WCGZNzAmo5JJHFVF8sdtzU6Ckh/InZVBcU/pw+SifN5cM7wCsVPho2K6mDvEnY0JAnR0xLKFfSY3FQvT8kjq6NGVXs1xWjMo5O8rqAamkW94rUKXyO6cSIkRyveSqkRhVDVlfO/nJ2xLYARazqwpNI+OcH4y+/aIqoj0TbKqhme40mASKgcZLKvKW83GkG5n8aaYJDilEIid18Yhhsrxe9vA6S4AzbrK/2gWy6B3apIGxB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cba1f3c-fded-4daa-698d-08dc5c70a971
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2024 10:50:12.8140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfbTlev5PpsKVxGbmsaPfkiB43JxXyP9I7TUT9WEgbB5NQfW8PNnhmDMBVctPd3TJE4+DtF5aBEFX/2ZjFwUTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7434

Please resend as a text-only - patchwork doesn't capture HTML patches.
Also please remove the "Micron Confidential" notations.

Thanks,
Avri

From: Zhan Liu <zliua@micron.com>=20
Sent: Friday, April 12, 2024 6:12 PM
To: 'linux-mmc@vger.kernel.org' <linux-mmc@vger.kernel.org>
Cc: Avri Altman <Avri.Altman@wdc.com>; 'Ulf Hansson' <ulf.hansson@linaro.or=
g>
Subject: [PATCH v1] mmc-utils:makefile: cross compile

CAUTION: This email originated from outside of Western Digital. Do not clic=
k on links or open attachments unless you recognize the sender and know tha=
t the content is safe.

Micron Confidential

[PATCH v1] mmc-utils: makefile: cross compile

From: Zhan Liu mailto:zliua@micron.com

Problem and my changes=20
Current makefile can only compile for local gcc (x86). Add cross compile so=
 we can easily compile for other platform by doing "make ARCH=3Darm CROSS_G=
CC=3D/path/to/your/cross/compiler" .

---
Signed-off-by:=A0 Zhan Liu mailto:zliua@micron.com=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=20
---
diff --git a/Makefile b/Makefile
index a890833..fb7e30e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,19 @@
-CC ?=3D gcc
+ifneq ($(CROSS_GCC), )
+ifneq ($(ARCH), )
+GCC_DIR =3D $(dir $(CROSS_GCC))
+# To remove the trailing 'bin/' part
+GCC_DIR :=3D $(patsubst %bin/,%, $(GCC_DIR))
+endif
+endif
+
+ifeq ($(ARCH), arm)
+CC =3D $(CROSS_GCC)gcc
+else=A0 #By default, we will build for X86 platform
+CC =3D gcc
+endif
+
+
+
=A0GIT_VERSION :=3D "$(shell git describe --abbrev=3D6 --always --tags)"
=A0AM_CFLAGS =3D -D_FILE_OFFSET_BITS=3D64 -D_FORTIFY_SOURCE=3D2 \
=A0=A0=A0 =A0 -DVERSION=3D\"$(GIT_VERSION)\"


Micron Confidential
