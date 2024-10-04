Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CB211C
	for <linux-mmc@vger.kernel.org>; Fri,  4 Oct 2024 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728030586; cv=fail; b=S+1LDl1rjqq0Dqf8KAuLB3F/h2ceGF6rpQ1tLe1+VXFa0QTfWC27LWjhw8VhYPrvYJZSixRgp+vO/ovHtLnIsRukY86x6KYlYzK3yZn/leinctEGNtJD1x/dUiE1n42rwHkmFmsp85QVb4PbSmT5my9x+WgAS7f4IrKC0glnHrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728030586; c=relaxed/simple;
	bh=vV3e5mVoHqaPG7lODw2OMTnqEpfHVAZR4xd80Ht63TA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fl34y62gBg2djy80RIDGZKFXSsj+tNG64QTqkJaHMrSUoaep5QCcp4f0rjWkGKmrMIqxR16terUhUOrmqqI4QhigyQu1beGSnpQcrJfhfLTOzLe2sjDLx3b5WwHiGOU+lEeQNJcJ34TEj9w3dXDGwm5cXTTLDbLbf971MUrzNEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eCX2NsiZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=p/GDwr6l; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eCX2NsiZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p/GDwr6l"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728030584; x=1759566584;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=vV3e5mVoHqaPG7lODw2OMTnqEpfHVAZR4xd80Ht63TA=;
  b=eCX2NsiZ/YS5MbCXg0KekmTkPGrZP0s3lGtJO0kANzQTOZHAozuSge7E
   iP3b5+S3m+8ePbZGP+a4xJOgmlTMKjN2gMBQI+VRlr86J3FetVqyOyQ+I
   pnXKu/srQGL5JM/fHMy5uHfc6Bvnpf1XgcZGj+aBayMicSMfAx4JQWQpx
   seQ8QHH+56CjLLprByEbztRvK1BVrmfhhVkmb3Y4VxnGEgKdxm6RJedRi
   iEkko04/Zs84JLBH1MrCfFXaD09mBqbI2mx/ZY2oOWECtnNj7WUgq82c8
   hqg6wNcTirFP9nRpconAO8ieRtxf1DISqa8dcqcJsSdfAfON7XyNyPYRF
   Q==;
X-CSE-ConnectionGUID: /sOdAxHpS62vjBxy92yuyQ==
X-CSE-MsgGUID: U+/xElLhSqWfu3SgnfnC/w==
X-IronPort-AV: E=Sophos;i="6.11,177,1725292800"; 
   d="scan'208";a="28650338"
Received: from mail-northcentralusazlp17010004.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.4])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 16:29:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlROdLPUnW0Mya7bgH9hU40ZNk44N86R9H47ZnH1wDqDwv0cq4mE2xrBp+MH0c0WCQYxAyS9fAbuNzmldHB2zlxptUizVA6iUfFd7pV6wYw+WLsSV2hzR4Up/VkFsqx/8XR41N9XcsZ1FanqQ3Gjyd4mopqn6RStInCW12joy6rwtAhEzwuUAWfCJQVxcOq/X+b3kkKaxtIXj797FAgLkNlZ1gLcJg3a9tuJNCykgWTspRrNa6Z+pQe/lRtRM1djVMEC0IOMmiW67XYY+GenGFLsPUFo1Zx4xhpwjIj3DuG9zXdiSW9ZCOnFK3aObTCKIeOZ4d1Sq7ElqRVp/rhivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vV3e5mVoHqaPG7lODw2OMTnqEpfHVAZR4xd80Ht63TA=;
 b=XA3YnjYS6tfy7+B3bR+dayww3dfhkGn8Xx5NzBVH8YT6IM6GuZxpLx9EpOFcVOmrHFpNV9NJzLTZqKIrUgqgdhzJcC7aaH7QKNDUFwx0t3hxtBZLkyMbvZ6K4oS4xPbHAASZIWh9mW6Bpuj0zs2Qkzwibx+MkhQBv4jFv+4Br2FUtGBtQY4wb5+n4PV9+Q5uopk/rCndGh0AdOiSHLDzkik8t4VR+MtujyLQjZAAzJC2GGql1UAyFUqa147ByelLPSbrOFBChdUdh50nvsu4obBPrtXNSPEidaimngmnCMTxo0AEfGfvMSrj65QPYHcgcNySBMDD6XbBbJWber8gkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vV3e5mVoHqaPG7lODw2OMTnqEpfHVAZR4xd80Ht63TA=;
 b=p/GDwr6lD4u97qGNY8+EOVxIijhz9Z5SLuFOBqErTYGImARuO5jdY0qLMrac/X/R3mGkCGaPWqoUZvQOtoKNMlkC7oHvV9bxeEWHNzyAtBrd74AKU6BrS7Meu1dBa6aS035Bayh/GSFEJcq9YNpIPeLmRAYFhBIbAaVw/NKU+DE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DS0PR04MB9486.namprd04.prod.outlook.com (2603:10b6:8:1f9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Fri, 4 Oct 2024 08:29:41 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 08:29:35 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>
Subject: RE: [PATCH v2 0/5] Add multiple FFU modes based on eMMC specification
 6.6.18 for flexible firmware updates
Thread-Topic: [PATCH v2 0/5] Add multiple FFU modes based on eMMC
 specification 6.6.18 for flexible firmware updates
Thread-Index: AQHbFcOq+D8Vppc/00mKkAwlmqeOnbJ2Qlkw
Date: Fri, 4 Oct 2024 08:29:35 +0000
Message-ID:
 <DM6PR04MB6575B11917ACEC21FF21B5F6FC722@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241003183848.58626-1-beanhuo@iokpp.de>
In-Reply-To: <20241003183848.58626-1-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DS0PR04MB9486:EE_
x-ms-office365-filtering-correlation-id: f980f652-76c5-4390-6028-08dce44eae0f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0m+lKU0bA6V8tJ1v5DyHsyeH5TVadRoLvUcrWUAkLzyOA9p+adDJ8vaF3WEq?=
 =?us-ascii?Q?CpGAOdqMj3hvPpLVZet15go/gdZ9Gg8l5t+5hGGLOGCTn+zMvlOePZoQSJLj?=
 =?us-ascii?Q?U1rpz29o/j16QPlMbvpBqb1Um8Xs0VLzGLKyuJ3nsj5EagaqoJurhI9QbGaw?=
 =?us-ascii?Q?lpUUlnx8PvtIcYtxZQ/D0nelriO8o6LdzYv6aYwJ0IXsT2TMDKdNjspLnY4/?=
 =?us-ascii?Q?NQu9tvNiK4Tf66PKhA2gFtflw3KYnYC8u94gIQAbo9PA7DvM2yU3hYzVUVdu?=
 =?us-ascii?Q?3MTOtQRulEBGjK+Q/fh1xJDEwAQmj/Vb0Cfh4IM93BhQL3NgEkqwcOfI1UOP?=
 =?us-ascii?Q?KkLaynlD3s9ROyLVac8As2FAOYpzFg8O1MgrriQUvm8zL8IY84xRNAejmRH+?=
 =?us-ascii?Q?Pbb2kH7vTMxKUxSKVlhXUEk/ohvxAPQQ+Z3ohQqTGbmX/HYXUqSeK0194i+h?=
 =?us-ascii?Q?GqA/7muSsUa6FRS8f7Pejo6KxxaIxO69UXOQFtHagDTXXCzJPzFyvDJMa29c?=
 =?us-ascii?Q?xYcLyJo7TyeGsi7NybzOv+xd448Dnwr6tY+0zZULUEfHvofUHZg34pKBcxGW?=
 =?us-ascii?Q?1s7Sr5im871Ygof9lygzFiiwSrvkqnOatZ0jbfz0HEjY2Y4LgZ5juqK3Nx96?=
 =?us-ascii?Q?wfK6uMFBYJ0z/DfXYCATx1xcEoIUUOyozCPlpfDq6DDO4vWyaZ8UKiK3jhL+?=
 =?us-ascii?Q?JIesAieBvljyUxqCvnpkQ+j8saRilPK1IT7t+htmVlW+VzDNfkYOf+QcaP9X?=
 =?us-ascii?Q?D8FbjaWWs875nA7cutv4G230cTZAm88g+miOC0gQw8Ty/uvpkhHv4leMphn3?=
 =?us-ascii?Q?ZK9JyjIag/srE7ejWW2g5eHAIDmUCYTW5OUTMU9EmGJQz2DNDYC+CjPuV+dH?=
 =?us-ascii?Q?uzAkSzk0N0FAgeWN1yBnoimC99kj4lP9WVjzLJCwvuzBTNxS5KahQPIVr4a4?=
 =?us-ascii?Q?iAvXMN82CkRvjtxHB8ct07z4H7ouTcrZS10cuHCtcJ1XK+gTO0hSri9wCeG9?=
 =?us-ascii?Q?XvLAdQhDzfPMOvY+50AFY8Q4Rz9kKYHGqKCrJvIM7CobKq+MipnO3wNKzw0V?=
 =?us-ascii?Q?HgDgPjcTLXM93OYt5SI1kEfxj/OAqAYsmRUY6ItMsi0BU0WBH6l+ufbQSirv?=
 =?us-ascii?Q?wrBb/SALxnoNlTKvrdeu0+W6Ji6XJv6xiUBGXYJ2h0Duy/9ZIyS6c8U9JUYZ?=
 =?us-ascii?Q?qVa5NwWOSKACQK2yskVsK0ZUL1dw/TWBbOdEf/ezQHDbgGF3UBM7M+YcHbvf?=
 =?us-ascii?Q?FUQyrKKFVFFQbiKP52zq0q3crSvtN6xe8qWqE44N/JKhTqK5CMElcrCV4ve2?=
 =?us-ascii?Q?Jn0hboqhwGTOoc/IsaU41uwSddepCVoH+MXNXxOPQesMVA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Zf2agiM1v+9rAi5t3IEG3ww+hSD2DwKhkpRmeM3eo546rljd4uiJKEiWMkrd?=
 =?us-ascii?Q?sEchEtlb2l4YEpbAX50X9OS+JcRMUr/rkdIKlbA/HiOzpemZuE94b6ndCClr?=
 =?us-ascii?Q?CskwIUGq+Y5VkluYakC5AkPp06jBMhNJqUzfkcmi3q4z0O1o8wZuuy7orFq+?=
 =?us-ascii?Q?BzTHRzVwc0UeahaFOaG/RP6YpV54gvos1szaIhv1/WE+LXtqjknZXh4Cra0Q?=
 =?us-ascii?Q?1GJsaqeg8DXQCULIlCsWtqSBtopFF4St7/Hizv5d+Iou2ccTZH2hnUdiJU4m?=
 =?us-ascii?Q?VzUTwtIuyQFOiK/FzvrCiL7M7yPrCS3l2qjcCEUlde63C0FRjkPr8OGgkw/M?=
 =?us-ascii?Q?62c9QmH4dtE29wpTpHADnlJTEAk14WlCmT208UuCm23PjUORlEVOq4Yj2EZP?=
 =?us-ascii?Q?5+pT8wAbeqW6S6YqXA16gCZ6LbKAA7WyaiZjjnMAKLxV/vUGwP739ANEUGrU?=
 =?us-ascii?Q?m/tKRdLHJj4SyKrwHdQmnqj82YUSzcexueOo4JxueBlWkQll7SjtA84USIls?=
 =?us-ascii?Q?CX9x2iNTzOgtLr3J7CI0KJyvh9Al1s8rPTr9hoBWm0L1eDCi1jn9zFo2N1E8?=
 =?us-ascii?Q?hmp7S/jk2C6JNshj2C1eeSEZWYXxkLQN4LpJUST0Kodhm90mnMiC5l5eWlAF?=
 =?us-ascii?Q?tuk/mcaZtnS+aU3sry8Z3fCZqB/XNsTYjRvuZ2a+jgWNADr2Yrf7CkgIgnGz?=
 =?us-ascii?Q?QhaqD4Luc0C0HvI8Z2qdlt97eHAiaoDETUZMJDqdb/FLYxfnkWu9T7iwLkqh?=
 =?us-ascii?Q?COcmvZy9lV7HDpbMtfB7bwICjaJAB+SNsOxv2OVOy/ZEptzUeWFXhCHDHQLk?=
 =?us-ascii?Q?5vUy43gQ8D475suOpUbkWjefiJxuCkCaGoA34v2UzbDLDTyhDfqFEeU0Teop?=
 =?us-ascii?Q?jCNMnrkgHJLgU7jS8v+mv8t3YIgo8C+cTKKtJvC852BEDUxKzPZrZ87pVfjR?=
 =?us-ascii?Q?NdkUW8ja0H1U7KpQgHrm3XXjOjdqMDNU1G7gxjEP/c9Tij89mQHfsSL6Sd9+?=
 =?us-ascii?Q?NXr+1fX56V2AF8yUlKRGpBKPluQtN6XRRIU+xihJdtXzAuFfY5ktWFiD0/A6?=
 =?us-ascii?Q?h3ZPFLdKrazwsE9ddgi+hXCs78pntyAisVRKgS39Do40JEn/XJsqKst1pvFW?=
 =?us-ascii?Q?91xwUfKaRDWLN1RTRf2/gFl7xlaW8bJ1k5E/+R8HSUU2iu8AsKXaToFp4+vD?=
 =?us-ascii?Q?zzuAhO8vixVM0u89CcrC8yiDAKQ6yTy8F96i+6+UDrZrbloNDFZzSywmM4MH?=
 =?us-ascii?Q?h8Urqzv7PzBd+mZyCMe/I4ucEQFAIzFzgvxSQOhRMD3RiCSD9dTGlwbeFxxo?=
 =?us-ascii?Q?0OYVuZvB5GMWiYQEoR1CACArmGcw/sUZ/wmIxJAPiyk5uT86EyokCPlSbTa6?=
 =?us-ascii?Q?WiNvNW7V+q4krTyqjZGjJL5mhlomSZbK8xaqNbPQXw4SgIC7oOvgasHm5ERj?=
 =?us-ascii?Q?4ti52fq/zLOoyttIOBK3meTwdQIiojsNn83bVfmflm8wg2gUemCVMkSBFAW/?=
 =?us-ascii?Q?Q2FI45n3EsXljyjpuKh6f2cPRzC53JyERYYNiE1Rm71Hmd9l2wOcOxHKE/7r?=
 =?us-ascii?Q?E8Jl8lzmMnn866fY1Vd7e1k8aCJ/XDO9HO9Yx56cquRtfy3fBjCxCNzB+yko?=
 =?us-ascii?Q?QAZlXb3PQyQNYgeJgsoug/kFK1gOPPBByuxhl5hSlX9T?=
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
	xoCLJ3swyQqKwvzoheU1OjpCdsU/ZYvlU1EtLSMUYhlRDEEYgbUeypQfiVtFYITbi6GO/Hai1gFBNcqHZNVs3rHGzwYfi8RTnH65XbdR/HdnV93tTfmS/EFvc4XD/Lx6+Tah+pBAxe37wo9CsLuK+8tfXDFoRPDUD7+gtBuL8uhSCrlG0Kia5uHUz2voxlczRMEB3BUP5QhhUybH7ZcpZtqokZ0WJSh0+kiyf93s8QiIW20x6b7o5nawwqnAB4Eb41IleC7TfJm4jYqz+rRpl2D4iSpUUOjM4vKcUD7HFo5nUvNoukDrq/Tad8nHyWETVdcTHvvsVDOoE9KInel5SHrCMPsbsjbQ7aO3qbhHCpRG5CMROomREr+LaFarRJf31b9Z9njQ8TrMq5x2gnoo79J3NzeMadHJxnADyPvQ/h0efnRA4KptO+zaks6ddUs12UueI0YMZ1l0kwmeLq5ygxDxISqFmajbyFcjk4s6Yp4+WzEzU7nHni8+nZkgxIh2d9lBZvFqlwr7vkpo+mn76pFLehHsVOCk3bxPdSD+6ncoENB8EWUkwN1ijRYIzcbOz6Cj8YWv58ulFYHbU+mUk93+IBZw3DayhH8pDgsMH4JvB50F2yN2SXYPMWm94zJq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f980f652-76c5-4390-6028-08dce44eae0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 08:29:35.7967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I5UTrNflJRB2w4Ez1luubzgDk7PU3V5G5D2ShNt8n4phLtPcZSX0CV5p/t5fAzoUdAzvgDpzCGTSqywXPnQ1PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9486

Hi,
Thank you for this series.

> Hi Avri, Ulf
>=20
> Following the discussions with Avri at the 2024 ALPSS, I am submitting th=
ese
> patches to introduce multiple FFU modes, as defined in the eMMC
> specification 6.6.18.
>=20
> The new FFU implementation can support diverse vendor requirements and
> operational conditions.
Ack on that.
I concur that various devices may respond better to different mode.
Thus, allowing different modes to choose from, improves the overall operati=
onal stability.

Will try to review it early next week.

Thanks,
Avri
