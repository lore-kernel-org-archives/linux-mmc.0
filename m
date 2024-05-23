Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3713B7A3
	for <linux-mmc@vger.kernel.org>; Thu, 23 May 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469584; cv=fail; b=scGYgBto3Yd1i3mokRWnzxMrZ7JrAR3hwB6lc+0DicZ+DzYA1DI1Jaz6MibxuXliu5KoXvspSlx8/ffg455JJtQOF4MsU65bU6hEz9OUPlmiQxMSUlYYip6wzE4t8EQvRgbM8u7PSIodJSplE+dWNhEVmNv+ZDcj5hbIcd6D3U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469584; c=relaxed/simple;
	bh=0WxxNrGDa8YL5ioTqROCQ9o7QP4Pp+xjWLp5w25+txo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gAf8/VMEwHoVlmis/Wpaw/e62e8ZFUQY0Q4MJ1CjA4EMXku7MHSFS7+fcfbS4c5pnxFzCbA91nWJX5wXQwkrgrv7eSshNtZ7Sb4snFrX3Pv3BDtPoQXOQXYpkl1NwywdyNecqwJ7eKP/W/1R3zaE4V5qTDMU/u832yxTUADp+8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L/G2QOME; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HTHY6M/S; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L/G2QOME";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HTHY6M/S"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716469582; x=1748005582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0WxxNrGDa8YL5ioTqROCQ9o7QP4Pp+xjWLp5w25+txo=;
  b=L/G2QOMEN/qZjFEbZQJfEHuGGuGcFlpziHYxr8i60xs0sWabqH/MCuX8
   tEJsk45goLDhAJwHI6MEpHAzyQNB03pQZpQeVstKMoqdjisqU+S5TcjZA
   s6lq9aZ0jvxKi8eWPr9N2UoiigDaNWpS3r7P21K7TGebcxMdObB+jvFce
   U7mZWIJHWzmt3NZt52IBDHoKOEBRGBXKUQyG6VZRLAM7IHLNOU3WhY2tY
   Y+Qu8ftUFU5YM3leYrtK24PYH7E5x6F4o0LmVbdS3F0dihyb27dGGIPLx
   g1y85n4XgxlYZdSjhimyuC29Teo851d3Hn1OAfztPMXZx+tRmMjaeEqVn
   w==;
X-CSE-ConnectionGUID: +IMmb+SORxWyyrNGBvL3ZA==
X-CSE-MsgGUID: oP3MxQnrT3yZQJHdgAlgtw==
X-IronPort-AV: E=Sophos;i="6.08,182,1712592000"; 
   d="scan'208";a="17327945"
Received: from mail-southcentralusazlp17010000.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.0])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2024 21:06:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUYdd6oRkZ1QyiROeb8r6HuRt4b4YbfWMX+WIe1gYPkK+jZ3H2rvRUA/0xBt9uUvLpUD7xJyVg6PiBgGfUVlQZiR/+Xs30LzUC1FaNgStnYVtEOKK5f3tcuL3X5QhkVJlCqbDRF4K9aeoXuEeMNDteIXZnxC9zj73bikivZ0NLnesrXniN2eNZjHw5IjN+cnRLpkUE8lPhgqhqt5oHbQe742Redypkc+5YX/OWuJN/+COOZy1acbNSU3FG578kRGYSfsUZWYefkeV2Go4FyxbS08fh5G4eD8+krlhjZTwBXn4Q0mtNrOD6NKghfhs84hoDCDptZzrMxOvk6XcMyS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4DwDNiAuoX02A93jatlwx3LExXB2q3ifG9FULb6k7c=;
 b=XPLYX7fzkMdR6t+HQyXEb6+hNhQVcLY+yMbCe/D4vVY9mEqBsLW4RhZ4Sl8eOH74SGIRXY7Vaq4aBHRkZJAvGic0lJNVYKMMkGpXivQR8NcE2aQSM1GtV78r7PDHNjx9Q27C7ka+0BrMpzilpNXg67LNHsEfAzLdPShZe3WUJVoW93Bi6sIsFPR2hCxygH8PrJj00R2q57tTBlApQs/Rp5gmq9Q7k0iO017OlNIUlYNA57dwZaGCvOXicRMp1PCQ8C1AwPw1Hf4E38ymE2Fb1c63IRNaZ5AEnX0jkcEz1r5eHEJH89ZSEZOpqSDwVSPZG9m488gAnGtI0EevkrMkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4DwDNiAuoX02A93jatlwx3LExXB2q3ifG9FULb6k7c=;
 b=HTHY6M/SVdBnxPwH+AE+ZQ36Es2fGSUlrq6bdphHrxetE1RjXyNC0l0wN43eAQD0YvQ7s/MESeXMo3W403kAZht3x+mJtbc++FNr5OGBpiejsJZuuS9fWknhc8snvoujmcrZSRNJXENEErzxkw6PtYUrxOeUg5/2fFU6YabT05I=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6510.namprd04.prod.outlook.com (2603:10b6:5:20b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Thu, 23 May 2024 13:06:02 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 13:06:02 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: "Loureiro, Joao" <Joao.Loureiro@philips.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH] Add functionality to read the bootpart register
Thread-Topic: [PATCH] Add functionality to read the bootpart register
Thread-Index: AQHarRANmhBF4ZCxpE6S3dg1Ljmf3bGkyYOw
Date: Thu, 23 May 2024 13:06:01 +0000
Message-ID:
 <DM6PR04MB6575C234AF126000C63D13A7FCF42@DM6PR04MB6575.namprd04.prod.outlook.com>
References:
 <AM9P122MB0281EA706B05ACFB3E0E2405F2F42@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
In-Reply-To:
 <AM9P122MB0281EA706B05ACFB3E0E2405F2F42@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6510:EE_
x-ms-office365-filtering-correlation-id: c9ab2418-fd6a-4f52-f67e-08dc7b2918cf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5NlTmrsknl36JXxNXcRITy309GruZwk7tkptY+b1Yz1a+scREMlmt+OZpj?=
 =?iso-8859-1?Q?7aJ/i1veVj0pOWRPJRWJgdrEMla73I/L9/BTl9djdC9nz2XrIXFUnNMAwI?=
 =?iso-8859-1?Q?QjtvpeuInLIcD4KJeb90PmeZjtWPMKSrrGOKKpke4nkHCF4KN1iRaCY0Up?=
 =?iso-8859-1?Q?LG4dYmRzAeBRR5tZir897ZJeQNNvXQFE3ujfX7nNnTg/o/C1b5GzvY9KEV?=
 =?iso-8859-1?Q?2snj3oIvpTbJ9m7LWnLTfMnjE19ra4yAKiWDS24eWJ4wfiN8eGamnoY44P?=
 =?iso-8859-1?Q?0j+yN2DqfRNeFw8CvNXphgOxZHqrYuS+axm9w4dV+eMeXyPEhREJGf7fGu?=
 =?iso-8859-1?Q?sEYXepddlysdrhMDr0YRbLyvIn7i9+4b3hRR0jm4aE92XL28u+HpctRNhJ?=
 =?iso-8859-1?Q?HCtUIiTOAVAY8rTxAPL9GJl69ZaMZTPmyRXsQRWNJ+d4vx2SyLR7IsCKjq?=
 =?iso-8859-1?Q?zVwPEjVCP1IrAtFvwMRjOlEOk9GcaycNf+AYvEM1I7uQswvgzLteS4vxH0?=
 =?iso-8859-1?Q?cs6iuxJ0SDH/DCqMuXNh5GZ6KZIXZNTD+wOhDt4a1b+utqCST40nZayYXp?=
 =?iso-8859-1?Q?9uDdB1sOAHd8ne7ixwGsi3kLRdEKRMpS+Za39Lrrngl+idb96mIwcSjSqe?=
 =?iso-8859-1?Q?koBfH9F8SDIDFt85HikmEZ7FitITMwVzLbLPrBBTIlRel7CCpT36GAPagL?=
 =?iso-8859-1?Q?T0E7u+hnmDYO74UoaKrnQFfAboLbDcYdTESPRFOGTbZcuF9DPERMIbzZqr?=
 =?iso-8859-1?Q?GBjHeKzA2u/uitc3FP7Oq/U88p9gjUOahFOVsMogzO/ekx5u6D1ZInnDeu?=
 =?iso-8859-1?Q?3qcnzcPWlC2bALdhTB0Obdc8eyo2rvJiLbInhz4B7/WdS0eE0HFCaDDeYy?=
 =?iso-8859-1?Q?VxjAULLzWTJasNEDUmQ6rqNC4bHsGXukkeh3/LOwtai+1GgF3lswMitQsK?=
 =?iso-8859-1?Q?DrePcBkFxLBK91wCSYqfyys8Fb481VSUSEVx56UIwquzMZ/7PLN6FVkkgA?=
 =?iso-8859-1?Q?UGktb0CDOTUUWBhpmg/wcUI/1A71ZQ9jVS3nfyFlCcMHgF9VgLoYNuXuz6?=
 =?iso-8859-1?Q?uhK/FpRoYIHcV4VM7SGn5fzDLX2se3tq8GlodsvvuDfxa7SWlJzNSaKK7f?=
 =?iso-8859-1?Q?nH9SJWwf01nf0LPoaJr2V+mjfPCu7qVDnmr2BNKFirGb5HjGeVLfUwGZ3l?=
 =?iso-8859-1?Q?6a4X4CTh3npXZhmovxE94OPS2q+Fg6t5Z54AFl/SJWt33EGG6lSVqOLGKk?=
 =?iso-8859-1?Q?UtO7G5FZcP8gxwa864rdMsZhZ6wA5XtPaouuFajFjW3r7bg31+43clkWG0?=
 =?iso-8859-1?Q?7BppU3lQE2OZCyv7WJkqbyKAtFZ2YtuVGV/TqE52tTMz1Q579U0YCRuwH7?=
 =?iso-8859-1?Q?qEBGDr1vAVgb6bXxiGw97WQv80CNj+UA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?izDmouPppm8ij923CmuFPb748FrppHJ412s+X8t/csDbWVUlZAqpKWPfhO?=
 =?iso-8859-1?Q?frax1xHjptRz+gRkeMbXu8NaYDJjstccmJqP+ubhLWDnxGYGYt1eab94va?=
 =?iso-8859-1?Q?ZU4yYaFa2IrxLG6d6+Eo7g3hyGy0U5lKhD3H+HaJDHAr2CjJwld1gg10S/?=
 =?iso-8859-1?Q?6k5TzhVEXw0r1Fx81sy/EJ6ldg3YyiQM/QludUtZLnMkOi/5sKxtHgPthH?=
 =?iso-8859-1?Q?ibzbPVcTxrSyRGcYB/BXnSSu8pxXfxCZIr1Qrm+nkkn7w9UAB3XRrfi/jj?=
 =?iso-8859-1?Q?0jaJVIjv5HJ27cLgMj/FuufmClejUDwXALVf9vKLxuszRCfaMnmxTD54ek?=
 =?iso-8859-1?Q?ovD6blAiNlO7ZZZ8XiuadCA9uwivDcWFqc67Bg1EXX1zLVGWEPKGCv7BM4?=
 =?iso-8859-1?Q?3woWEAIvJuFqAWk7hcP5rC0fq11IHgZ74U3vGAyfFyTucA3DSK7yvF8J2m?=
 =?iso-8859-1?Q?lMcD89WtiWi4BzsbQhrrhU+gMOu9PxB2uRpI3GF+XOexrDgBXytuH1bjtO?=
 =?iso-8859-1?Q?YL62py3+6goE77rlXCyD9I8EkV9KUvUmQMtUPPZbBs+lUVLN7Ikls3XmPW?=
 =?iso-8859-1?Q?bSb6+ML/0RBXx3H1raB7p5gt0kQo0cAOvB+9GZ02PjIytXKY1g9SSk4/CU?=
 =?iso-8859-1?Q?/KUecgNH0dMJQWeWad+NUP5FYEoQlRtAn2UL6pn6KLzZ6xNR0Pwq12Cb4N?=
 =?iso-8859-1?Q?EeqKxDLIiBxDdh0/VNkfQykorxQKiCOWRD4VZeJCEatSqb8QO2rtwCwWaz?=
 =?iso-8859-1?Q?jm6mbdSGEVXXJiVLcYjCSX6KceNGl2hv4+s+cdi+w7c96qxQr9xiogWEnK?=
 =?iso-8859-1?Q?BNsIKq4dZm7fg1A3h5R4cy8nS7Bxs0xceU4P/5OD24XSFvv5SlMpJAplgP?=
 =?iso-8859-1?Q?rljIdhQo/ngdO3peYB+Qikbk0/dVvUilivGAFyJ0ZsBd5tIa+xshAVtvuZ?=
 =?iso-8859-1?Q?0Z27FFBeJXXg04XpM//SSy1l0jeZDYZqPK0G54EvUSL/qkL9Wr0sa+qED3?=
 =?iso-8859-1?Q?DNpo6lPF/VPdf0bzHI7cC7PHapZGeAUlrXBri8mcNy8TOJBqgZJR/4rDEI?=
 =?iso-8859-1?Q?i+uAnBfGxpB2TtomRc7Jd5sKetcLpyFtjLNG24Hf9IzH85l+Ts8dRrW33w?=
 =?iso-8859-1?Q?EZ67qXdaxKDEKQckPIVxzebnvuQSS1aHhYFb7Z2apq7/PH1eMoHAtXkN3F?=
 =?iso-8859-1?Q?WEokfQzpvSPo+LPLljtTmI8oUDnccMmr0M9qhs8HhksQ9kjoxVxo4xDRSE?=
 =?iso-8859-1?Q?yZiehUmDp9Dh8aGy5IXR9IsGP4HxRVm5bV5NXDln1HN4yr6u4yCntEy5DQ?=
 =?iso-8859-1?Q?pAcp3gJ6shvuHg3i26wQP+DNr1O8ZaJIlHRkwY2qAO2JcaAYYkiJnoQrT/?=
 =?iso-8859-1?Q?ISw7ryaSRdiRosrRsbN2oOeGY+1K7xEvcY2cs1z74q9Ho5TmDOBU/QhiMl?=
 =?iso-8859-1?Q?Ax56YaGeep34eAyEa4Pqreo+SKgxxyTGWqrQ5DKiftECUdnYGVlsuWHFSw?=
 =?iso-8859-1?Q?Kd4Kyw7cmO6kyvwFkWzkGz9a7uwZCS0v1bTBG6NR0fheLxy77F0aUPKPC1?=
 =?iso-8859-1?Q?0QLDOqb8pgcMDt1xmXrYUyfyaKE5vjv++lYLcXbec3ugcYyokuwFhiLBXd?=
 =?iso-8859-1?Q?PiZChz7lvQ8Z8oWtdOuCfSwTXbPxYUPTMh?=
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
	+IvYF6/hvlQmLiSgJiqILh5ILCnrnFA1ibKVUpifzZsZ8wtwNyE8dd3zCBmZCJzmItnElAHVXQ+xz8tHntBu/fIwznRultq+N+GQi3ZdTslrV9YR4osh9qBHSg2p7mcRsKg30svVFt3L3f7rVkwhEAO7lhFQ9tZ+d8+nqjSygnM1tX08GSpkolu4s9UDLN5YKgt1qKzhhRrLYyYRNbhqGLakedY5Bxi25GfRiY+Ne7HfGkIgOSej33KNbv+AADLpNcD7xqZaBSD+mNa3UQPJmBuS9OkttygCstBvsBrVj+teVCr16Zh05C/c7EO4KvqY4kNXVZwIzQcbzxlsoST6WazlxtInrpKqat9rtCbi1rKQ+6tXQ113Gyf4CBL5kgiY3UwCM5bxUbPXmcFRd9KScdylV3CyDZ6o6q9UEx5jeRg3oe71dxvnT3D6Pmnrz3tAx5Zg31Q7Vkbl3697iuE3HhP2vZuVVVBpAvjQoP4hoFs+Kjf+96yO1N91T9OJZrQaqGESg+jWGhWHzuY+pGFo8REAFzmzLJ6i8RExIcRaGNkSyA21n7XsXG0VyYOdDiKQOQrDo/BU/0pAsZ9Q4J+wWNK4ojZ9M0I9qWBO6vm+x0CD4hIVbWv5UIkofnpMy19H
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ab2418-fd6a-4f52-f67e-08dc7b2918cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 13:06:01.9852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6j89FPKg5HSEHAmbrXw26ceZ4Ks85tAr4jFcXVGk+ok8a2ZRGU6Z27rUVg9rYuvmKr7TmfkvSM0c6410vfWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6510

=20
> Currently the only way to read the bootpart register is to dump the whole=
 extcsd
> register. This patch adds the possibility to read the bootpart register d=
irectly for
> situations where the whole extcsd is too verbose.
>=20
> Signed-off-by: Jo=E3o Loureiro <joao.loureiro@philips.com>
Please update mmc.1 as well.

Other than that - looks good to me.

Thanks,
Avri

> ---
>  mmc.c      |  5 +++++
>  mmc_cmds.c | 54
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |  1 +
>  3 files changed, 60 insertions(+)
>=20
> diff --git a/mmc.c b/mmc.c
> index bc8f74e..26c4f13 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -126,6 +126,11 @@ static struct Command commands[] =3D {
>                 "Enable the boot partition for the <device>.\nDisable the=
 boot partition
> for the <device> if <boot_partition> is set to 0.\nTo receive acknowledgm=
ent of
> boot from the card set <send_ack>\nto 1, else set it to 0.",
>           NULL
>         },
> +       { do_read_boot_en, -1,
> +         "bootpart read", "<device>\n"
> +               "Read the boot partition information for the <device>.",
> +         NULL
> +       },
>         { do_boot_bus_conditions_set, -4,
>           "bootbus set", "<boot_mode> " "<reset_boot_bus_conditions> "
> "<boot_bus_width> " "<device>\n"
>           "Set Boot Bus Conditions.\n"
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 936e0c5..add9e56 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -233,6 +233,29 @@ static void print_writeprotect_boot_status(__u8
> *ext_csd)
>         }
>  }
>=20
> +static void print_boot_en_status(__u8 *ext_csd) {
> +       __u8 reg;
> +
> +       reg =3D ext_csd[EXT_CSD_BOOT_CFG];
> +       printf("Configuration bytes [PARTITION_CONFIG: 0x%02x]\n " \
> +                  "Boot partition: ", reg);
> +       switch ((reg & EXT_CSD_BOOT_CFG_EN)>>3) {
> +       case 0x0:
> +               printf("disabled\n");
> +               break;
> +       case 0x1:
> +               printf("1\n");
> +               break;
> +       case 0x2:
> +               printf("2\n");
> +               break;
> +       case 0x7:
> +               printf("user area\n");
> +               break;
> +       }
> +}
> +
>  static int get_wp_group_size_in_blks(__u8 *ext_csd, __u32 *size)  {
>         __u8 ext_csd_rev =3D ext_csd[EXT_CSD_REV]; @@ -602,6 +625,37 @@ i=
nt
> do_disable_512B_emulation(int nargs, char **argv)
>         return ret;
>  }
>=20
> +int do_read_boot_en(int nargs, char **argv) {
> +       __u8 ext_csd[512];
> +       int fd, ret;
> +       char *device;
> +
> +       if (nargs !=3D 2) {
> +               fprintf(stderr, "Usage: mmc bootpart read </path/to/mmcbl=
kX>\n");
> +               exit(1);
> +       }
> +
> +       device =3D argv[1];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       ret =3D read_extcsd(fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> +               exit(1);
> +       }
> +
> +       print_boot_en_status(ext_csd);
> +
> +       close(fd);
> +       return ret;
> +}
> +
>  int do_write_boot_en(int nargs, char **argv)  {
>         __u8 ext_csd[512];
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 5f2bef1..12716b5 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -25,6 +25,7 @@ int do_writeprotect_boot_set(int nargs, char **argv);  =
int
> do_writeprotect_user_get(int nargs, char **argv);  int
> do_writeprotect_user_set(int nargs, char **argv);  int
> do_disable_512B_emulation(int nargs, char **argv);
> +int do_read_boot_en(int nargs, char **argv);
>  int do_write_boot_en(int nargs, char **argv);  int
> do_boot_bus_conditions_set(int nargs, char **argv);  int do_write_bkops_e=
n(int
> nargs, char **argv);
> --
> 2.34.1
>=20
>=20
> ________________________________
> The information contained in this message may be confidential and legally
> protected under applicable law. The message is intended solely for the
> addressee(s). If you are not the intended recipient, you are hereby notif=
ied that
> any use, forwarding, dissemination, or reproduction of this message is st=
rictly
> prohibited and may be unlawful. If you are not the intended recipient, pl=
ease
> contact the sender by return e-mail and destroy all copies of the origina=
l
> message.
