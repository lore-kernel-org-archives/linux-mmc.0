Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F5166F1A
	for <linux-mmc@vger.kernel.org>; Tue, 28 Jan 2025 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052207; cv=fail; b=snjQlOS+nk+xlwqcPNXo1kCxJ0QEnwR/K2T99JatEoTQwXIfIvXdmahBtPEEbyemgHK5/7pugNEcB/JLee4lJhQkir9MNHNQmNJTI9BP+dNVMuw7yjDCJLwXFa/kBNmtdKIlkchFw3vsTwMX5m5RAVetZHsE1ycpyfy1yivokeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052207; c=relaxed/simple;
	bh=7B+RzImE3xPnCEcqggRGYb1on9LpO+qFrSTffA3wM4w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n10sS9bTXBqZufOdzIAyd9jT2JgXiAUNDez0L66HlnN53PhAdXq6N39G82gUy0E2q4JYJcGacc7eVQy4rL6ADpVd2wcfyqPtjo3uyIKdh+rw5V/IHP6j2l1lJeBBG2Ei1NYtwRniMQdbhf4TdiuPrC4yaP7QFSyt3j2Hw2Tw0WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d9B/zbFf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XlJLVUT8; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d9B/zbFf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XlJLVUT8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738052205; x=1769588205;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=7B+RzImE3xPnCEcqggRGYb1on9LpO+qFrSTffA3wM4w=;
  b=d9B/zbFf5qzvn0W3YOJBltOYDc3bc1h0Y9PHV3AJX5cGc4ehOqxBr7Zl
   19Ii61f+pFc3s9WXvT3nuoV00TxyjtC0qRsznFcTaCA+QiGIx5LUOb/Ea
   r87poQaVpj9O+fvvcGUSlu8Z2k9zbzoPy7Wy+xH85PO4ltKnpNql0oazW
   N6FKqJhUoyINKsFH561JRqf+eHCb/m51gi+NMppmYZLFz7RltWK/wMl31
   fbi7u3E8rlVKHvoOLGf6PzM/mUPaY+Sjw1fMRJHiO1HT2/RhW8K+fc2UU
   8tTBlFupHjMfxk+N2m/Ek/kYcmZV/bdeboPoRkPKPcsq1JpylLNVogPvI
   w==;
X-CSE-ConnectionGUID: bF96BOP2TxSmrW7gPmGnTg==
X-CSE-MsgGUID: nqg1OzJGRI6jdKsqkPYJiA==
X-IronPort-AV: E=Sophos;i="6.13,240,1732550400"; 
   d="scan'208";a="37991670"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.10])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2025 16:16:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+SgkAy2X6V89AZvPcwkECMYx4tXSJCXp/i//tyUmIkRQLcMKJhS+wDNL6g5a5pzf+3TQnByWr4464lKTUXsR4y62VoSrMUCx/3iImHwR9xxNVFl+9Zm69UzL9jbOqtsiYVcve+zHMHjcuovNpwsrF6mWup61QmNKZ6/pbEV8VC+u13eJHtwo9wyI/2R9m4UdeFm7h+Rp+CwUh37tSh6Z+6xuI1epj8j62VpQVo1pwAHEa13l7uzheOp8YKCIRfwDHLikbrEqxLBgZt/UtBcG5JQTQenzddNAPPg6dBIT+Z3Z9KMuvw9DKIDJIxhrKzyCkF7evSdqgiq/wTE507iZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZJmEOkPue4h58RfQPvVLlzfnQcnAVXZ2cHkaz7daew=;
 b=g0RAJLAE+ovRI01T/nqr0IvVfr3HQbGrfDA85edr5+/YSYPiBpPyLuWjRNyKrTw43O3VtU6VZ8GNqmv9ygPAFND/B2PgIODdxO3RI5tcZoANoAkV8Fsefib76Lq89AceEnFaeGOq82+jQ0SV1juiJGdXU7sy3y6b9EOWMyKZA7aI+u0eZnCZgFGhmbdKjEvU2S/raZarSrelJlUdaieKyF2+Jcce3u9PYoCa7ZupajeRMuaT25uy1XkBGdFZOSK0rIts5rut0ytmLfG8pW2zFkU66raYM0o3WAs8hT6KY1puI3pljXw8o58hlk4CS+BPS+eAC5iLXY2flvUNztFXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZJmEOkPue4h58RfQPvVLlzfnQcnAVXZ2cHkaz7daew=;
 b=XlJLVUT8l8T0a6YEKD2xES/yB4xDP1Hi3cL4HV1eOgWAy4febh3txlwpgwd0p94Td4qD5uFlsx4PCKu4pRJHtNlRfseE/xUC/mDILlS3H+TqwhbCPO/JcLH3SCl3Rzq2CzAEW1vauExBnNAQlWCpBuT8MiWmpig6ODJYwrU0nJ0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA6PR04MB9237.namprd04.prod.outlook.com (2603:10b6:806:417::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Tue, 28 Jan
 2025 08:16:41 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 08:16:41 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: sooraj <sooraj20636@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc: sd: Fix incorrect capacity calculation for
 SDHC/SDXC/SDUC cards
Thread-Topic: [PATCH] mmc: sd: Fix incorrect capacity calculation for
 SDHC/SDXC/SDUC cards
Thread-Index: AQHbcQiXrONIV/QAiUmrLTLQet6HrLMr1kHg
Date: Tue, 28 Jan 2025 08:16:41 +0000
Message-ID:
 <DM6PR04MB65754682169CF936F637183DFCEF2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20250128084226.15873-1-sooraj20636@gmail.com>
In-Reply-To: <20250128084226.15873-1-sooraj20636@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA6PR04MB9237:EE_
x-ms-office365-filtering-correlation-id: 2d6eda9c-9b48-4999-9c6f-08dd3f74188c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R6cZNsGOhnbWr/7EssnL/Ff2Va65pMI3El6g26ZEc4iixPPn+NbzzwWmGQs7?=
 =?us-ascii?Q?KB0aFbD7BkH3BxqNegbXq17HPLvzhn/OI1hbRl2sxUd9Dcd8yvybcHGxognP?=
 =?us-ascii?Q?8+ycrKoCuVyS70yabGVF8+OldofRO8gAfNM/BJmNNUVurwOR30QIkb46pyTm?=
 =?us-ascii?Q?l64TjBRBOIgHhIpDQ4fkL8mZ6cDqgY25YHCOFQ71bvZCO00vDnzWsrZ2BS1C?=
 =?us-ascii?Q?y4GgjksiUBGqBLW8KxS5azE5jPrRfKQfVo9fTqQJiygNHGc+ugCl30BPiHXn?=
 =?us-ascii?Q?519+3SokYNBj+kQbWm+HqWN0Mv2BK6rVQJrC8+h/Kc2oAhAIGC7sVVGuH49i?=
 =?us-ascii?Q?mikmIM7VP0P+5FPIocsHua9M4f7JCCnsz6+zcDwWxanXX9Yj4QNrVMvpc2Es?=
 =?us-ascii?Q?uIliymMHqz70zijsUWRQOx6hZ5e55v7a7MnxcL1brk9bmcOrNAUzD8vRh+Vf?=
 =?us-ascii?Q?c0Go63qY/x1X7RBvLf3/mPW1960KQIYfiIqq2T/giTqEabsue3TETxMd0R1u?=
 =?us-ascii?Q?tbmBzrmfb6xgLxmUEuLWWPys3AAarMRM37kypBJEDQUtpboBGM3imSXruqTh?=
 =?us-ascii?Q?TG/9E3XLMipTyNzrA6+maBT8BllMKuGd3m34JJl240/lw6/V/pzfA1Ge8xZZ?=
 =?us-ascii?Q?HJCzmsRTmiS64f+fRNeN/qkndZv6gj9OuZGEEV8/WHd5Chve/WF3JIGSXBcl?=
 =?us-ascii?Q?IYy+xsgHUokFjQiEhDkMJocp6RsKrVSuXoe7Khk1tBnnIu5mf1wuRVZ6s9xP?=
 =?us-ascii?Q?fiUoM5PJfshNf/gtDvr1+n52mhCcLsxDh5aaKGvyZPpTkA5azLojoHAd3oyI?=
 =?us-ascii?Q?+LgA0b6bNHWSG5rPplkuK0DF0jSMq4DjRVTF7gR2IPORIrfDFCDNu5vz7LEg?=
 =?us-ascii?Q?akdaEGJJYYoQoJ4lWE0EGzv75KNearGqMdT0kNC+hE39QTesnL8JaN7J2yc/?=
 =?us-ascii?Q?Xie0B8DRbfdoW856wMCk7dOK0cH0HJ+ch8npmXKzgj30Op2mfwIeYwRlCnrR?=
 =?us-ascii?Q?aw0M/3UPZ767fxRJhhLxUGyC2aOo/kpTHBPhcL/UY5KLt4EzA/77nY6P1LCB?=
 =?us-ascii?Q?jQF+h6dL7jEnrPGasPguVk73XY8Feu17lR8ZUKAX74EG3QOyHbwxTjIyYCm0?=
 =?us-ascii?Q?HiPeRKC1VaVvSoZLLg0HOY5A0mN3EeaqjLGg39aYEejg+v/gwe5ymAU7K/f/?=
 =?us-ascii?Q?yM4cMdxRoeIjIQ6RuSxTKTiMt8p2hncwiRk24cBjBDf36bxt2Gf9ZeTvU2qr?=
 =?us-ascii?Q?1pLgtLevSPOZIC0a2l3FN2akNTKHfRP6FTfkBo7EQJbbTU6U365s/DFUQqI6?=
 =?us-ascii?Q?jDrQCdXTrnqn1aEwYrb+DhERwArrpTXj+pxqnWobpvaVI6Ct+OSVZngmWq3H?=
 =?us-ascii?Q?1p6CAM0LE5rwlXLsbJF3Rzw41g2v3c6ANKrMnd4/CQvYOGVczkRbHWkgzeT7?=
 =?us-ascii?Q?A8FNkEEPiWGFwgz1b8k+4WnnT3yyf1hB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eqg+eDkghNGoQeBQHAM1LR5ZLrBbxW9wAEhG1+LFY6Ix569TayiLMm1z9Qwk?=
 =?us-ascii?Q?ErCS2Bwzp7imWCgKgVTnBr7tEQLa5xlgtZGSZsZrs6Zd9+ce5Hy2q2ddW6j5?=
 =?us-ascii?Q?BWuTXPkhF1hsPUw9/io3p1VW4eC75ellqLfN63VQw2uE3DqMNuwK25FS3er3?=
 =?us-ascii?Q?hS+c52TyUGHgpBKQ9PnC0erTBN8wMgOR4bHBqnWVXzu17HQkqZupr3pg9XVH?=
 =?us-ascii?Q?Rl0cBLPluYh4jvzqa+JyB+PjOEUrOXYaR4S2mp+qeU8Xj+9KqTlZ7KZaBT3O?=
 =?us-ascii?Q?uyH2Ya6IDSTU1/xkWadSE4bDwdHDmHnFHXJUnC7dubEc6PMx6fPSS+207Q0S?=
 =?us-ascii?Q?+5UqverMZ0fSNtBpRQUF0YQJJlUsFWSYOlKtR8gN/5aNFgDblPWoan+rRIUU?=
 =?us-ascii?Q?q+ycygKgjJSZ4Uq5X/t7z/qaPG5MXKYeo3AbCdDTJBNy4HvU8LjYQxJcfpEf?=
 =?us-ascii?Q?RM8CKzdqwW7I7tyxUc3+/pTaUFDpuhlGiBdKjpi3o9o55pu68UMBvT/834ql?=
 =?us-ascii?Q?pOwMiKSuGUeUEACVf/naFJOsBeVHdZjXytx9gLYlpc3gTZXv8eddG2lGmag2?=
 =?us-ascii?Q?Do3czXWx1Lz3swvfaP0VPsVWVoiclUCPAkq1azwhMSJwEIhcBigXXO5HNuzY?=
 =?us-ascii?Q?Z5HxbYheHI4bfmRQZy+Ke62I75GM/PTqca7tGI7cJCcCwptO7atgt5MlK6AD?=
 =?us-ascii?Q?k4L+XCS/PFrQGjWDkcrcHOsJsWlxq2vONyJz8o3ZnLJiH6KknBSkt6HXVAc7?=
 =?us-ascii?Q?qOY+pVM7mbM8LTngPPl9w3HR9mq27RL3QsIRilmgbPLvovX/bGUw1FQvXBo1?=
 =?us-ascii?Q?2eowdZ2yKBwqb+dbKomtoVwM1Fjbt8BRs6OiiJNhhhqZXxh1rfPhSrCGO1bF?=
 =?us-ascii?Q?51WDjYoumoI5MaZeQduN9nzwdqUgiNpOVDJKaU5lAo6uHj/BshJcIgeNZSXh?=
 =?us-ascii?Q?rsgqIijvRVWodH7fKnmx0U+qME4yE5/dhOtYzbbMmZdRXLj8qk8XFOt5dI+J?=
 =?us-ascii?Q?HYtHjxtqFS0MTD5uiFCkZZR3up/fKFxt66nYVXBih6IVKLlFXA45G7AVFAfJ?=
 =?us-ascii?Q?nPvR50bhHo70uxpctyPZTlZ2Eq6G/kRPzqYldYF7xKLQrhE4nReHpaVubjBj?=
 =?us-ascii?Q?hicvJ6F7Lfca/f9y5IEGLv6iYl7qMBq4zEkB7+fidsHwTXu2JX//gXjf2N8b?=
 =?us-ascii?Q?jBi/ARZF0ZuzDJBnJJnf30fOsPygqD1pBxwGpxzXmpw6XGiqqcXIlXMN9fCX?=
 =?us-ascii?Q?6aEfe2lAXsbUtIG0PlmPmVV+eDQhPJi3Yka1N3493XAgzHFPTqDerEREclxH?=
 =?us-ascii?Q?fawiK9Gv8bBM9y/omvfQjcntGg/iUebQ8ZifvJ/B+WspzDKWEWxp+PBJEJrs?=
 =?us-ascii?Q?Uxnn35KHj/SR2/SUwfliOSWAnGi/yHgVWSxJnqw+lRy3IpfVspH07CDyhZs8?=
 =?us-ascii?Q?Q+eBuoyIacjxzjLEUhdUhYrvk3S79JlX0RRg1sBlNV+ctv+EICpC9NETVrFo?=
 =?us-ascii?Q?gm/eAwd9m01Dt4jwTv7cHjQBwqgkXXwhRkeAq/oeO6+gSj77U2tl6Vw6tIku?=
 =?us-ascii?Q?66KAKEKlocpA/S0LXMsdbYNKdmooFtLD2ugUKpEf?=
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
	SIadc9MnT7gfPv091ZPI4a0GFj667jXOk2GzaNvpcSidOJ3tW/q6vHSwKS/c2CfLllvsGJkN1edu2SU8Kv72rDa0QXa4ltJyvFT+p8O4AtugSzUnNtRvzoXylwm8UXvyl6CAbqGvDoNtB7FkARlmMFpdt/pHo/h51By8l9lYSREX1QieHnrNVvU8gvPzrZbB75jnWocj+Z4I6MLj4qLJmbXMe74hwsD3naCZW6mjQ+YesQJptAgOX8BYCJ+EPV32IdYyBIqgVDZ8OzdBa+HW6A4uly5yd1KOn4lUjsE8oQGmNQIhCCGA6oidJx12eDbBlzn4oyjdxgggxUvy/zpx72OAzigmBvvRW2foI6eF6HwmF7ZM8yB+NptjjDAAGVQ0eDDZziuFmV0jGv9WXY+xNYw736bLwH65HmCxHWXXjFGPL3kjXAXXx1PrdB+BcTVu9/f7JYMMX7injn6El2NyrGJZvm3X3xfKytOpCzz99d1ELl/WVlwokQJUNDJ2/lu9Gx+dtY9Qo6GGaXVy+J8cIO30I1ts+EuKvpQEBFM+ha6Fxw8fK6aWK8ZRUYnMoXvwmNQ1zqt7ahMJ68B9ZGZicxkmRDjBWFV+RZwr1j85J7Rry5wNCqhuWAEIVNgG3SxU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6eda9c-9b48-4999-9c6f-08dd3f74188c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 08:16:41.6932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jVvtXu243tgzJFCjEMhulfhqSTFHtM0Dq4IRuaxfNnASYcXbEfy3WjphXPSIAT2T2KpHGOSuiD+wp+ZHxqC1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9237

> The capacity calculation for high-capacity SD cards (SDHC/SDXC/SDUC) used
> an incorrect bit shift (10 bits instead of 19 or 22), leading to severely
> underestimated storage capacities.
>=20
> - For SDHC/SDXC (CSD structure version 1), the capacity is defined as:
>   `(C_SIZE + 1) * 512 KiB` (SD Physical Layer Spec v3.01, section 5.3.3).
>   This requires a left shift by 19 bits (2^19 =3D 512 KiB).
>=20
> - For SDUC (CSD structure version 2), the capacity is:
>   `(C_SIZE + 1) * 4096 KiB` (SD Physical Layer Spec v7.10, section 5.3.3)=
,
>   requiring a left shift by 22 bits (2^22 =3D 4096 KiB).
>=20
> Update the shifts to 19 and 22 bits for versions 1 and 2 respectively, en=
suring
> accurate capacity reporting. This resolves issues where cards (e.g., 64GB=
)
> were incorrectly identified as 1-4GB.
>=20
> Signed-off-by: sooraj <sooraj20636@gmail.com>
Please share the kernel info of your sd insert flow, e.g. something in the =
form of:
[ 5791.041876] mmc0: new ultra high speed SDR104 SDUC card at address d555
[ 5791.041916] mmcblk mmc0:d555: calling add_quirk_sd
[ 5791.042108] mmc0: calculated max. discard sectors 1957888 for timeout 60=
000 ms
[ 5791.042127] mmcblk0: mmc0:d555 SR04T 3.72 TiB

Also what your /sys/block/mmcblk<x>/size say?  where is <x> is your sd card=
 block device.

Thanks,
Avri

> ---
>  drivers/mmc/core/sd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> cc757b850e79..b60de859e978 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -172,7 +172,11 @@ static int mmc_decode_csd(struct mmc_card *card,
> bool is_sduc)
>                 else if (csd->c_size >=3D 0xFFFF)
>                         mmc_card_set_ext_capacity(card);
>=20
> -               csd->capacity     =3D (1 + (typeof(sector_t))m) << 10;
> +               /* Correct the capacity calculation based on CSD structur=
e version
> */
> +               if (csd_struct =3D=3D 1)
> +                       csd->capacity =3D (1 + (typeof(sector_t))m) << 19=
; /* SDHC/SDXC:
> (C_SIZE + 1) * 512KB */
> +               else
> +                       csd->capacity =3D (1 + (typeof(sector_t))m) << 22=
;
> + /* SDUC: (C_SIZE + 1) * 4096KB */
>=20
>                 csd->read_blkbits =3D 9;
>                 csd->read_partial =3D 0;
> --
> 2.45.2
>=20

