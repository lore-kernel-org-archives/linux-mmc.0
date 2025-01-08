Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2EA2594B9;
	Wed,  8 Jan 2025 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305912; cv=fail; b=SU8j9B60diKuHUrIylqaV8B8WNHtf1ljK+en7/uokn0QM7DXTJU3FTOTOCkSngLQFMkB40GR8S0AyC9bnm7PQglnBt1Zsy0vs32ykPCWfioaXzTToMRBALl/fWz+5WjvNcGiuTYymJ2wyexcNEjzVfz2etTmQL8Jta6e2Gw71C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305912; c=relaxed/simple;
	bh=kOJ258WedIjHgcaZoolQj5Ylu0tuTxWoVqR9fVMEEyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hlY/A3wNt7+5niNI5NyBqVsvd+lx58jv+bzqG0pcyVywuvSCaCfSKS8LZCgOVIyGDM4nwbl36a15XL07oW9ESUyeIPr5wWeutCoXMmj7OMTH5+IDe5S59SwwlWDsMDVKW9HK86UfMMwHDv7iD5yf0/4K0irYiQ6YhNHBK1bZxkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IDZxSRCo; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IDZxSRCo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIXzdc/UmAAaLIslHky52vLrZORdiRKuNOxM+oZZ40wsUDWORswsl9gdJXUw1bTCCgK5E/9TZropiqcJAqCrT4A4A7V7eUbiV0Goncq3R24upTvstG5VE6R3y3jKvZtAM6Q2cOM7IDkDEjhs56gFmZLTphlMTTDgY5aWlizonukFNCojuqGTcos3qF2k70tDZcgnzdDHWzjBsKGs8Satrl9bUFUD1zcuKvRpNKr6M0rwmExNE7mgSRVWUTszHJijd9TYTJzwWipbtB0N6bCgJwmndfARk9L5ukyhlHzGcOEroNp+IWxpAi8nsuDb8vWZ7Qz3+ffupVl0WhZitshGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOJ258WedIjHgcaZoolQj5Ylu0tuTxWoVqR9fVMEEyI=;
 b=qsU4oF8fHx/jARzEVmVE+cplhgwZjet7ODzk6qdUtteSQp3AyDJl8N6Pn+oFpr/ZYQ2kW4f89vz0KyjUuWEFoNK6rVyjukil6JW6cJSRiu0rPUNy0VQ77RLKzNd+3hXkCXmDJnuq3iRLyO/cAf/3ONYjz6Wt4TwEwg3y6cKxVtdk0fxw4kVS3b1Gf1SQYo2f6l2nieshCkaM6DB7mWR7a/v3I7DUSiTv4rnvrvlcqMUaYe/f382Vbc8NVWi5IGcrdmqJLqXqk2CXvczrb7l+hzuEqZIvMTeJDsvkWOdRjr7IyGAmw7VSwBFDnua87yGFvKu6rzzxCvMDhRf0F1qoNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOJ258WedIjHgcaZoolQj5Ylu0tuTxWoVqR9fVMEEyI=;
 b=IDZxSRComaq1mbLGANbyFtCpus6x0mssw7H2144eIRagYaDlKA8vHIpdZ6ty7ulB90RG0KdRKLQ/HrK7XbK5Zgm+T+PcTxGQbdXkvbPNk/QQuISUQvOEmotbMngm2pGcjuTMzamRNoFTTIRv1to9CigKgMVAJemQr3P5sDApRwgi3Od4jvyY3gV40Jys3Z0knmKMu8yEf3XXMni5BxDCXMDkk6ksNWE5dslNPQ3Cv2Jo7pG1+iG8oQnc7H8IabmLV2cD005M3ngkML7mu7mreUgwgo5nXo1u8LlJP2pfCuCAdF5ya8u7Tk5k9IDPb9irDuOfEnjDDRwAUn99ueoXHg==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DM6PR11MB4548.namprd11.prod.outlook.com (2603:10b6:5:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 03:11:47 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 03:11:47 +0000
From: <Dharma.B@microchip.com>
To: <martin.blumenstingl@googlemail.com>
CC: <conor@kernel.org>, <ulf.hansson@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
Thread-Topic: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
Thread-Index: AQHbUcwFXFHAxHVg1UOmapSBwIyZUrLuAKyAgBzF3oCAAR0SAIAAbuaA
Date: Wed, 8 Jan 2025 03:11:47 +0000
Message-ID: <39be0bea-c207-4bcd-b464-ca93e91cec93@microchip.com>
References: <20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com>
 <20241219-scenic-revision-17da9231d61a@spud>
 <91dfdd42-6ddb-490f-acda-41ce55782959@microchip.com>
 <CAFBinCCxZjuXL0duy3ePPDtL1oJS_GZiX3=djXpHR+-6gLkN_w@mail.gmail.com>
In-Reply-To:
 <CAFBinCCxZjuXL0duy3ePPDtL1oJS_GZiX3=djXpHR+-6gLkN_w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DM6PR11MB4548:EE_
x-ms-office365-filtering-correlation-id: cad0bb7c-940f-403c-65c2-08dd2f922ffc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QnMrTm9udWhLWDIzaGhiSEkyc25XNUVIcFhNdDVDakJOdDlLUjlJMzU4YW42?=
 =?utf-8?B?L1hVdTBPdENHM3BBbFZQS09mNDI2WEl2UnBJY2xlKzhGSy8yYzU0dXJ0Smw5?=
 =?utf-8?B?MnRaTGwxWUZYRzNVWk53MndGSlFJdTVFc1d3bXMrUFE5bmc3SzNRT0xLTngz?=
 =?utf-8?B?T2xxZk5tdjVvMElQR0ozTkgxeG5QcEk5bFovWFJGdUI2OWtBSnR5R1MvcWky?=
 =?utf-8?B?N0dkY1NZb3RwNzN4RWxLQmc4US92VkppUTQ1Z0JtS1BvdGNnZ1FPU2FpSmlV?=
 =?utf-8?B?TkJOWDNpY0V2OE84SWZkU0dvN0JqUC9nYVVKdC93cHNDZFc0QjFVNFBSbWtZ?=
 =?utf-8?B?U1ZxMXdUdldvdmlpc3lqOGd4REdXK1pSWkdYRVFPVzRPMStZdW9IZmdsOHQr?=
 =?utf-8?B?aDBuWjczVytrLzg4b2dUODVVTmRGRHJNUG8yc3JCVmc3NnJwcHc4Sk5DU2FW?=
 =?utf-8?B?Y0RWT3RCT1I4cElFL2N5b1p0U0FRVTRwSVk2cTU4L1ZiQnA4bzZRVC9ERTdi?=
 =?utf-8?B?aFVqMU91VVNZeG1VOTM0T2xtODdHa2dhZDFkK3BXTTAvVTRxWDROZFVXVTJM?=
 =?utf-8?B?LzZPa0NGdWdRTWxxckJ1MkxkMTN4NmxocHBsUkdDQy9Xbi9pOFZlcG5MNG93?=
 =?utf-8?B?OXA1NlFPUW1lZElTTGpVWXhISStjVGRLZXU4MXlxQ2Q3dE5rTFlXNC96RWo1?=
 =?utf-8?B?cnEvNGNmMW5TN0VScmlTUFU0SWNqN1Y3NldhSjRhbE1MTHpPSVRiRVJLSHN1?=
 =?utf-8?B?MEJVYllxc0IvVUNKUlVvNzNoRHRpL3ZLQWpOcGhPL3MwYVZBUmFtQlVDTWdp?=
 =?utf-8?B?TUNYV0dpRllzNnFpTUZESVRHRnlrZGN4ekJnOGFlaUxVQlZxVEJVQ3VmbUxq?=
 =?utf-8?B?M09oNnhoVmN4RFpEYXRIQ3d5UnFPNkN2OTM4b09WTUY0SllaVmR3Mnl4OTRB?=
 =?utf-8?B?SS84YjE0S2hVKzVTV2syU3cxYnZvdWdyOVBOMzYzbkdFbkoxTVpxUkFMN3Nj?=
 =?utf-8?B?ZUsyc0Z4Q2VHV1NGaFp1WENuQUx4Umt6WmFHNUhDTmxucU5sMHJYRUlZVFBX?=
 =?utf-8?B?QnZqOXIvSmk4R1h1WGR5Ty9XdHRmVENhREFpYTF5N3M1MGh2SkdxQnFSeW5Z?=
 =?utf-8?B?T211R2lrcHBkZGt6SzEzbkhNSDM4dWRBaDFlaFNTL0ZtZEVVSUJWTk8wTURS?=
 =?utf-8?B?eEN6OUQwK2VDZXNsWWQwS3I5aitGUFdzUG1QTHNqTklvRXVQS0pKTzl6MHZv?=
 =?utf-8?B?MGpld08yNTRISzN5YU1UV0ExMVhYc2p5aGhWTDR0RUpsZytPcEo0RGN2eUkw?=
 =?utf-8?B?Q3pEWmtmc0pMeGVodzZRb2xMUW5aK2Q3VUNHQW9PZ0V1Q1doYlArZThvdzls?=
 =?utf-8?B?czE0ZlE1V1orYTNvQUZ1MHp3SUNjbEc3Y2VTbkJ1SENncTVxNElwN2VxREd4?=
 =?utf-8?B?SDE0L1VYU1lKMWFxWWRqWVc3S1F1UVpBWDlvT1Fwc1dTUElCZnlqQzRYS2Vq?=
 =?utf-8?B?cDlZQUJFVEFzNm1HTlU3S0c0S2c3QVl5ZUduNTQyMzlpam9iM1pRK2FGTmJP?=
 =?utf-8?B?dUJWNjNlMVZ4aEZGUWVrblNEdG01Tm5ZT3lpWjA1NUVLTFZXMlczcG11QXov?=
 =?utf-8?B?cDh5U2lrWlhYTTVwc3hOUE02OGh4UjF5UWN3bUU0ZTV3aS92OWVWVlBoSlND?=
 =?utf-8?B?UTMyb3VsY0NaTTJLdXdycjY4SWQzZGJKeTJnNzErek83aThSSHJJYUt3NzhC?=
 =?utf-8?B?dWV1eTZYR3FGN1FZb2hueEdUYkh1Q3ZjcjFvM3M5ZVFjdFdpWE91Zk1udnVN?=
 =?utf-8?B?V1NHVXNPT096VlVjYm5QMFgwRG9FMG9kWWp5VzVvSSsrOXRBSWpIOTRaTDN2?=
 =?utf-8?B?MEdGWFphdHJxL2QyZVM2U28va2FuL1hiRU1pT0pzOEowRmgxSG1YbkdqMVV3?=
 =?utf-8?Q?A9krqsU6jX5I1pk8yVSFw5eTGB/R99kY?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHN5eXRkcGN6NVQrQmNxRG8rNGhrK1N1Q0R5cGFZNVQ4Q2w2eExBcE1QbzVO?=
 =?utf-8?B?QUxYRDlFYjNQek8xZGJ3VTRpWElOczgrMkUrR2h1dWlsSElZdFZnaFUrSGF5?=
 =?utf-8?B?QTJYK1QrR3pGMG1nWlhEU3gxdy95dTBqdFc1b2JlVDhiMUJLZStUK1FaVFVB?=
 =?utf-8?B?NU1kcWlXb2F3Tm9aMUl0UHFPZlhoWGFoVi9FbnlDSjgvaXVld3VXRWJwMXRt?=
 =?utf-8?B?b25welJkWXkwQmJRVUlPWm53cWNVd25wRnBtbnloRUo3MXp2RTFLbjc1dG1N?=
 =?utf-8?B?QjdiVFMwQWZTQ3QvWUpZM3BPSUhhVkt2bEkrSXl2K0RSTDZDOW9GSlRkQlBn?=
 =?utf-8?B?NHR6NjF1THFUbmgzU1ptTXQybkJlWit3Zk85d05odjJiZ0Q5bzlzd2RldVh0?=
 =?utf-8?B?L2Z1cHZ0bTZ3WG5SeXgvUC90aHNKWmJSY2FEWFNQRmFXdEF1d1BPQXpNOXJj?=
 =?utf-8?B?T1J3aTFpTHNOeXlHWnRQNTdrVFVOWEhCdE8xNDBmMGN6Ry9XVnh2VFJMRWFB?=
 =?utf-8?B?bERLY1RzaFZMRXJMUWJ5T2xQdlRyem9MUitMa2l2bmROcHE5RVEreUROUkI4?=
 =?utf-8?B?YmdQTXJQbVYveTh3UVczSk9PWGU3bkhpQkl5T3dwVjg3SC9vOTJrNVNsZ2p6?=
 =?utf-8?B?L2IwclZBbURWVjhndEd4YTdDYVd4Mk1vL0ZSalJ2OXo0V1ZidnI5bGVQTkx4?=
 =?utf-8?B?L2UvemlxWXQxdWgwV3FlYXNpZFVFV3Axc3BuWFVwKzMrQnRvWHZrelRzamlI?=
 =?utf-8?B?dXhuSXlvN2xVN1JlT1J5Qk5IaFEwVWduR2Q4dlg2YmI4MkNPMU9XOFU4K2g0?=
 =?utf-8?B?NmxxT0VDcStpYVI1dWQzcEJlc3VTSzk2UzJ5R29XOWEvWWY0WGFkbm5CZDRz?=
 =?utf-8?B?cW92S1ZHY3VET2RtbUliVnNDYmIrTTJ6UCtPcEdFeU9nWVNEbUpwNW1zMk4w?=
 =?utf-8?B?WWR0UVFWVUdqanR0NHVkRjlvY1JYajluRnRTVUFJUjdEeU96dWZrMU5HOElT?=
 =?utf-8?B?OW4rVnlkUkpiZVFMaW1pM1EySmpzMUh3b1BsRHVYZ21QWFBxS1R3S3NYallQ?=
 =?utf-8?B?K1FLU2VlL0Vjc25RaUNab0tMNHBBd0JtOWhaQ1pTTmhWQ0pPYkNpWHhwK2Zo?=
 =?utf-8?B?eUhDK1RCZXV0Q05VZlZmUEczL3YzSkdyQjBMekwzbFNZaFZFRVdrZGFTYmQw?=
 =?utf-8?B?Um9pZGUyUzF3bHFGdnJsZGFPcG92d2IzQVJHajNPeUFHTEN1ZGtwRzlFRytC?=
 =?utf-8?B?MlNOalRUOXlTVEZRVHlYUHZQeUY1QlMwZnkvOUoxbGNVVUc0YkxvMDBlc2Jt?=
 =?utf-8?B?U0cwcHdaWUxNZ0VjMmRNV3pSUW04UXFZT3M5TUgrYjhpdXJTZkMwK3ZMakpX?=
 =?utf-8?B?TVJQbDJ3ZTB4RGNQNTF0ZkljczRtSU9LN1pUVnV3K2pLRGs3UVdhMzY4YnZu?=
 =?utf-8?B?eVZuT3RlUXFnUklOYXpOYVBGU2lObDQ2SFBsellnSHNNVHFWMjloanNjTVo2?=
 =?utf-8?B?dUx2QUI5MFVlRGliVCt6RFhoZjNkQTZiZlp6cWlkS1VXNU43dkM1Z2VyTHJG?=
 =?utf-8?B?S2UzZ01vaE5uYkxZa3lmRjZWZGhVRkJOdWRKckZ0ZzVqK09Sak0ra0gxOHpq?=
 =?utf-8?B?bElaYy9nQjArUGhVQ2lmcWhjUzExUE9PM1JJMzhUTW45K0hWY3RBdFMvZ09l?=
 =?utf-8?B?TCsxNGREdHNFWnZxL25qa2pBRXFUVXAxMjgrT1dtZE5MT09IQVZxVm9EeThk?=
 =?utf-8?B?MTJBOTJ3Ui9wVk5uTG4vREsvY01rTE56TjlsQ3RYb3pOdnMvSHNEeGhMZUdr?=
 =?utf-8?B?eHk0eU43aUdVZ2NhZElVejFqSWxGRGlWRHhjVlZIOEJOSVVFMnZvaGY0ZDc5?=
 =?utf-8?B?V25aOHRZK3llbGtNODQ1ODVLbjVHa2lyamVaYW0yUjdGdE5RaFZmQ1ZXdmpQ?=
 =?utf-8?B?ZWFoVG0zNUZXZlZRYVFWY0F5VEs2RVlVcCtTWGhxcm5zckF1ZXJlZkFoSHdE?=
 =?utf-8?B?eUMyMGpNVUxrajhqTVlXdWV3czhKbDdzZkNPTFpXc1NlcUdkMW0zbjdKSTd4?=
 =?utf-8?B?Y1I2QTZtcmZUT2RBN2hWMmUxTGVVeHFONVZnNjZaVmRPZnQrVmh5cDVrbmdI?=
 =?utf-8?Q?t8LVC1dJBzoYSagMLmi8vklWp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <588741BF59DFF246B9DB2575FA4D19A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad0bb7c-940f-403c-65c2-08dd2f922ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 03:11:47.2809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZBeEwXM3I6hBJgGZ5VOIJQydaGmpgGoHs+vtBBJEIZuvttFnEQVkklcstTMWY6YtJ1I09tA2oRVUqDLX0miXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4548

SGkgTWFydGluLA0KDQpPbiAwOC8wMS8yNSAyOjA0IGFtLCBNYXJ0aW4gQmx1bWVuc3RpbmdsIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIERoYXJt
YSwNCj4gDQo+IE9uIFR1ZSwgSmFuIDcsIDIwMjUgYXQgNDozNOKAr0FNIDxEaGFybWEuQkBtaWNy
b2NoaXAuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAyMC8xMi8yNCAxOjQxIGFtLCBDb25vciBEb29s
ZXkgd3JvdGU6DQo+Pj4gT24gVGh1LCBEZWMgMTksIDIwMjQgYXQgMDk6NDA6NDFBTSArMDUzMCwg
RGhhcm1hIEJhbGFzdWJpcmFtYW5pIHdyb3RlOg0KPj4+PiBNb3ZlIHRoZSBgY29tcGF0aWJsZWAg
cHJvcGVydHkgaW50byBpdHMgc3BlY2lmaWMgYmluZGluZyB0byBtYWtlIHRoZSBNTUMNCj4+Pj4g
c2xvdCBtb3JlIGdlbmVyaWMgYW5kIG1vZHVsYXIuDQo+Pj4gVGhpcyBtYWtlcyBubyBzZW5zZSwg
YXMgcHJlc2VudGVkLiBXaGF0J3MgdGhlIHJlYWwgcmVhc29uIGZvciB0aGlzDQo+Pj4gY2hhbmdl
PyBZb3Ugd2FudCB0byByZWYgbW1jLXNsb3QueWFtbCBidXQgdGhlIGNvbXBhdGlibGUgaXMgY2F1
c2luZyBhDQo+Pj4gZHJpdmVyIHRvIHByb2JlPw0KPj4NCj4+IFdlIGRvbuKAmXQgaGF2ZSB0aGUg
Y29uZmlndXJhdGlvbiBmb3IgdGhhdCBkcml2ZXIgZW5hYmxlZC4gV291bGRu4oCZdA0KPj4gaW5j
bHVkaW5nIHRoZSBjb21wYXRpYmxlIGluIHRoZSBEVFMgZmlsZXMgd2l0aG91dCB0aGUgYWN0dWFs
IGRyaXZlciBiZQ0KPj4gcmVkdW5kYW50Pw0KPj4NCj4+IElzIGl0IHRoZSBjb3JyZWN0IGFwcHJv
YWNoIHRvIGFkZCB0aGUgY29tcGF0aWJsZSBqdXN0IHRvIGZpeCB0aGUgZHQNCj4+IGJpbmRpbmcg
ZXJyb3JzPw0KPiBMZXQgbWUgdHJ5IHRvIHN1bW1hcml6ZSB3aGF0IEkgdW5kZXJzdGFuZCBzbyBm
YXI6DQo+IC0geW91ciBhcmUgdHJ5aW5nIHRvIGNvbnZlcnQgdGhlIGR0LWJpbmRpbmcgb2YgYXRt
ZWwtaHNtY2kgZnJvbSAudHh0IHRvIC55YW1sDQo+IC0gd2hpbGUgZG9pbmcgc28gUm9iIGFza2Vk
IHRvIHJlZmVyZW5jZSB0aGUgbW1jLXNsb3Qgc2NoZW1hDQo+IC0gYWZ0ZXIgcmVmZXJlbmNpbmcg
dGhlIG1tYy1zbG90IHNjaGVtYSB5b3Ugbm93IGdldCB3YXJuaW5ncyBpbiB3aGVuDQo+IHZhbGlk
YXRpbmcgdGhlIC5kdHMgYmVjYXVzZSB5b3VyIC5kdHMgZG9lc24ndCBzcGVjaWZ5IGNvbXBhdGli
bGUgPQ0KPiAibW1jLXNsb3QiDQo+IA0KPiBJcyB0aGF0IGNvcnJlY3Q/DQoNClllcy4NCj4gDQo+
IFRoZXJlIGFyZW4ndCBtYW55IE1NQyBjb250cm9sbGVycyB3aXRoIG11bHRpcGxlIHNsb3Qgc3Vw
cG9ydCBvdXQgdGhlcmUuDQo+IFdoZW4gSSB3cm90ZSB0aGUgZHQtYmluZGluZ3MgZm9yIGFtbG9n
aWMsbWVzb24tbXgtc2RpbyBJICp0aGluayogKGl0J3MNCj4gYmVlbiBzb21lIHllYXJzKSBVbGYg
cG9pbnRlZCBvdXQgYW5vdGhlciBkdC1iaW5kaW5nDQo+IChEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbW1jL2Nhdml1bS1tbWMudHh0KSBhbmQgZHJpdmVyDQo+IChkcml2ZXJzL21t
Yy9ob3N0L2Nhdml1bS10aHVuZGVyeC5jKSB0aGF0IGFscmVhZHkgdXNlZCB0aGUgbW1jLXNsb3QN
Cj4gY29tcGF0aWJsZSBzdHJpbmcuDQo+IA0KPj4gcmVsYXRlZCBkaXNjdXNzaW9uOg0KPj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC82MzQ3MzQ3NS1mMjllLTRhNjUtYTBhYS0xZjFlNDEx
MmI1N2RAbWljcm9jaGlwLmNvbS8NCj4gUm9iIGhhcyBzdWdnZXN0ZWQgdHdvIGFwcHJvYWNoZXMg
aW4gdGhhdCB0aHJlYWQ6DQo+IC0gZG9uJ3QgbWFyayB0aGUgImNvbXBhdGlibGUiIHByb3BlcnR5
IGFzIHJlcXVpcmVkIChpbg0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1j
L21tYy1zbG90LnlhbWwpDQo+IC0gYWRkIHRoZSBjb21wYXRpYmxlIHN0cmluZyB3aGVyZSBuZWVk
ZWQgKEkgYXR0YWNoZWQgYSBkaWZmIHdpdGggYW4NCj4gZXhhbXBsZSB3aGVyZSBJIHBpY2tlZCBv
bmUgcmFuZG9tIEF0bWVsIGJvYXJkIGFuZCBhZGRlZCB0aGUgY29tcGF0aWJsZQ0KPiBzdHJpbmcp
DQo+IA0KPiBZb3VyIHBhdGNoIGlzIGRpZmZlcmVudCBmcm9tIHRoZXNlIHN1Z2dlc3Rpb25zIGFz
IGl0IGZvcmJpZHMgdGhlDQo+IGNvbXBhdGlibGUgcHJvcGVydHkgaW4gdGhlIGdlbmVyaWMgbW1j
LXNsb3QgYmluZGluZy4NCj4gV2hhdCdzIHRoZSBwcm9ibGVtIHdpdGggUm9iJ3Mgc3VnZ2VzdGlv
bnM/IElmIHRoZXkgY2Fubm90IGJlDQo+IGltcGxlbWVudGVkIHRoZW4gcGxlYXNlIGRvY3VtZW50
IHdoeSB0aGF0IGlzLg0KDQpUaGFua3MgZm9yIHRoZSBjb21wcmVoZW5zaXZlIGV4cGxhbmF0aW9u
Lg0KDQpJIG1pc2ludGVycHJldGVkIHRoZSBSb2IncyBzdWdnZXN0aW9uIFsxXS4NCg0KIk9uZSBp
c3N1ZSBpcyAnY29tcGF0aWJsZScgaXMgcmVxdWlyZWQuIEVpdGhlciB0aGF0IHdvdWxkIGhhdmUg
dG8gYmUgDQpkcm9wcGVkIGFzIHJlcXVpcmVkLiINCg0KSW5zdGVhZCBvZiBqdXN0IGRyb3BwaW5n
IGl0IGZyb20gInJlcXVpcmVkOiIsIEkgcmVtb3ZlZCB0aGUgcHJvcGVydHkgDQppdHNlbGYgYW5k
IG1vdmVkIGl0IHRvIGFub3RoZXIgYmluZGluZy4NCg0KSSB3aWxsIHNlbmQgYSB2MiBieSByZW1v
dmluZyBpdCBmcm9tIHRoZSByZXF1aXJlZCwgd2lsbCBpdCBiZSBmaW5lPw0KDQo+IA0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBNYXJ0aW4NCg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhh
cm1hIEIuDQo=
