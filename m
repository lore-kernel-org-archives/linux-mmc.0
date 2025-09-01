Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7482212556
	for <linux-mmc@vger.kernel.org>; Mon,  1 Sep 2025 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707277; cv=fail; b=ICxirlbnWcSWl/2QvesZqtGxFgYR4CsQlrnV51G4xWgxTxYRtc5eDs6vI/Vihy0PyNuOusmlXINXT9JbryDBW7+T5Vj5WApkhPGBG5V7McBcPr46fN9iy7yI1Iuz4iz6zF+X/FIVvBtTAd8f1tyTqMpkF7q1fi2qeam6dlHqAY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707277; c=relaxed/simple;
	bh=xoZWd5j7OKHpG6CKZ7tOLp9bykW0HBTQcOUntCrWIeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6moetXqAr1gOw37cCYAZ32qfix9IuyOjoMvfD+zGNjWtAatdsM1nL4O0VVYxBRozXlPlhd4f55OntldSDHk7LCbD4TlbT+VlH3EO/4d7BljhNC5obY8rmagtXLDn4olW2i78fMgvuK8BvFpdRDtO6tAjYUUEj0Q7ScdLpy77QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=W5jxeT+M; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="W5jxeT+M"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1756707275; x=1788243275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xoZWd5j7OKHpG6CKZ7tOLp9bykW0HBTQcOUntCrWIeg=;
  b=W5jxeT+MDn0lCQqLNQNkk/bzmczOEBcrG9yGVKoTIqTCZZhKjkmqzlMm
   wmpeN7O0J1WgQgwcQ7O+sm0trXSSGKkPDQta97T/kIb5vBQrZfzDNWvg4
   Zf+0KKFSqqPRI2h3IoBWdg92gltJl8VnORGhGJMNvZqfCiGxeV/uCKipC
   bWXfgipdIXqrUnt+RHFThWIoTjpOZKWwgTTDYqwh2VyOxOa2Y8FpQdExp
   tqqJdkpg7E6hsmYk/hDhYPVUhqliNzXv/HA++AID709Fx5uB7yj0G8199
   xbH0rBShMZy8BJCWLERSqcbPNqmxAfjJ3KIA+cpiBWIwkEhdcjEVs4Xob
   w==;
X-CSE-ConnectionGUID: 5nVXnuArSC2UtulVr9p4rw==
X-CSE-MsgGUID: 0qRqYeZ7RdaQDnJfLT2SeA==
Received: from mail-dm6nam12on2110.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.110])
  by ob1.hc6817-7.iphmx.com with ESMTP; 31 Aug 2025 23:14:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5WY+L0icC9vOnJ4IYNBJlvmBvVd0OkH+SvFRK9CcfbWC/6iRi2SSK+VmWgdkAnNY0nGEqVYqtrOXhJ1RowU2HbrRANo8h70rEoUbszbrWZQXyBY7+HauC5mrDv1EydAdjfQ1flRCZGTQGDqqMMZYA0dFGzQ2e3JcrQvKZZ8nltcu69O5lraBXjdwwJXwxg58mKKqVqvEshXsVRtlX/MrTKv8Mbc85He9+z1OJ7vNkOkMFAFx91hNbVOzDOWrKWeeEhdu6ktHwB+GuvTHdIdpl1haOpoxV7a10ymWG/czBNhRyl3WsgNZEm3ov5Xqxm+ktLzL1BZKkylwIfmUVZPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoZWd5j7OKHpG6CKZ7tOLp9bykW0HBTQcOUntCrWIeg=;
 b=vZp3oqyPw4Vr/AzLRasvUhlrCnrB0cHTu/6flRHdFqg3glq7dfxF5d2Vfi68yO/9lkSkdRKs1oMtkoWmC2UlAlw7ULhKbFp0oELSmTEzrmDllClerf99iDrvmp2Zk/A8N7V/MpRlyH0v2tAeR8J6W1A3+QcmVTmMcX0AKbuz7MKkHke/5jogVaWWpQmcOrAYmk9S74kYS6jRDvaC0eRx1vrEdsO/hI1lvLlrztjFQ6X1yaZj/VhT8TBjgF5lw6H5Z2iFXUM/F1CwTdajcN5Vi442K4/aUj9/r03EmPFmk94IKBnwR7vG20bE7hbMJb0CVVVCmSbNPj1wvCyJ8LE4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by PH0PR16MB5162.namprd16.prod.outlook.com (2603:10b6:510:298::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 06:14:26 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 06:14:25 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: Correctly handle write counter overflow status
Thread-Topic: [PATCH] mmc-utils: Correctly handle write counter overflow
 status
Thread-Index: AQHcGrbML19M83kUxUy0kjLhGrR097R90Pjg
Date: Mon, 1 Sep 2025 06:14:25 +0000
Message-ID:
 <PH7PR16MB619601040C92D28ECC72F7AFE507A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <31174fae-a3bf-4415-a8a5-76d252a6fbd4@siemens.com>
In-Reply-To: <31174fae-a3bf-4415-a8a5-76d252a6fbd4@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|PH0PR16MB5162:EE_
x-ms-office365-filtering-correlation-id: 6f024218-c600-4154-d5ab-08dde91ecd3a
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnJxQjZROGIxM2RPcDVoN0wwVnhPTytUSXNxM01pbTUyQlVGM25tMzdiLzR2?=
 =?utf-8?B?THI5WlpRM2p4TCtpMEJrYkJGM01NUEszWjc4VVV0ellTTmVKaHBIY0sveS9I?=
 =?utf-8?B?bVZpcHJUYkZXME9OakQ5Tm1sYm95RTd3TXNiQlArd0pUQmFBeUZVTXRsL0Jy?=
 =?utf-8?B?bitSN0J6UVd6bXMveERGcHJMckFqWUtTbzJOS1ZHa3lmNjFFTkVEZXp5Rk5q?=
 =?utf-8?B?emtmUE9ZRCt1ZW02SWdvZ0tFY1lxZnR2WGc2QVdpaFFFS1RORXdDL3MxczRp?=
 =?utf-8?B?V21wK0EzNDVrZ3dZYjBLZGltYXAyQVMwMzA1WXBSMG55VlpNaTlLSjl5MGxF?=
 =?utf-8?B?bzVsdk9RTS9ZYXdTRDMxbXRKMFpReDFxeGNzcTdHNU5HWS9GcVlRRm9qckJk?=
 =?utf-8?B?dXhteXY3dWRIMlA4LzJOaGZjTGNMM1B2VEx1RnoxVnRLVmEraVFFZXRKUmts?=
 =?utf-8?B?OVFsd0xzTEIwbWk0TyswdCtNWDBTZS9vYkJDVU5xa25NeWY2V2Z3cm5FU1Qv?=
 =?utf-8?B?VURlL0YvazZTM01lMjJidkcwMm96UElkQUJxZUZkM2FyQXF0ZmdJWVZZWXVP?=
 =?utf-8?B?ZXNFZUF5c24zWW9jTEZiTHRuS2lIV1RlbDFzOGFLMTd1TTJLNUxTVkpoZ2tM?=
 =?utf-8?B?VEJGeWhZc0lWeUFsbGFXaDdWY3Y1ZHdJNnBlUDNQSU9TOGdjcVBxYVV3WTFI?=
 =?utf-8?B?U0xYaThWU05JQXNPeXh2THM3L0YwNUxialowRWRGL2p3Rm5sc0h5TDBScGxJ?=
 =?utf-8?B?dWx5NkVRa3ZtKzkvb0JNdXF3aGR1YVZxTHhsb3E1Y3o3T0NCNmtXZVQ2elh5?=
 =?utf-8?B?a3R0cGZGN0pDVHNINGRwTmEreVErVkM2eklDVHMvcHIvK2c5S2F0U2QzUnpz?=
 =?utf-8?B?cXN4SEJOUGxneHZjMHZpckNyNzBVMjV1dENuUEE5MU4xcFlNK0U1QWM1V1hv?=
 =?utf-8?B?VkV6UjZtRUpKNTRMR2ErYjR0Wld5MU4vT2U0VldVMC93MXlBeGdrWFJ0Mkdn?=
 =?utf-8?B?dnZXWldsNFNpTmJkbXVEbjRoVlE3dy9hbFIwSU5rWFd1aGdlTk1RMDVJUHd1?=
 =?utf-8?B?dStNV0l0R05LOWx3dWhudWEyOStVQUhGTy9lVitJRGtwNVRMY3kyazFnSVZw?=
 =?utf-8?B?NzZsWjJaemM2a1p0aU9rT0QwMTBydDlzTU9BQkNYT2JKOW9YT2FyYmFoNSsy?=
 =?utf-8?B?ZzI0OHduWW9oaDBVclBFckpJR0JvY0RtLzRvTHhiRVJVbUtiWEJWVGFtVGJp?=
 =?utf-8?B?UmY1WWI2U1RyK2ZCNEU1bzRxOGJEbW1hNEpxaVJIV29jeTcrbDRGZWxPZnFJ?=
 =?utf-8?B?T1FkV2g3OTBEZzBJd0k2WmR4S1h2Tk93ZUowYlROaVVtVlNSU1pXWnFUVStr?=
 =?utf-8?B?YUltVitHcGFHNXJNK3JoMUFTclBiRkZKWjBJaFdsOE9lRGsvRWZ0a3BDVTRX?=
 =?utf-8?B?WTcwZHpoRHZUQUJJOUNNcWwxNVRVY2VUb2FBMFNNOTluZjhLdEQ2a1dxRjNr?=
 =?utf-8?B?L2VRQTFYdUttOTZ5RFZrdzBmTmFxNmVDSGt4K2puMGR2bFNxVlJPRzQ1cmY3?=
 =?utf-8?B?R09PYjQ0ZEVpWnFHcHpmUmltZFhBMFlBSUxJbVY0bFI0ellGd3BxM0hiZkZ3?=
 =?utf-8?B?UTJPT2RkeGdEM1o5VlArTHI5ZnIyT0ozcStWeGc2TlRsVHEvcWNKZXErYmxR?=
 =?utf-8?B?aE9NazV5c1VQaTVHZ3pYUVJJOHYyb3p3YnF2VzQzeXRHNjJKTFc3ZG01Uy92?=
 =?utf-8?B?aVk1RXFHLzFKSzZoTmlRS01odGJmOXFTZVNPNE01VWJYelNydk1YcG1YNTFl?=
 =?utf-8?B?cVFDcGk4elhFc293S1N4UCsybGRZQXlUM2NqaDF1bEcxcWdyNG5aVmNIbWlU?=
 =?utf-8?B?dDlod0JVYzNLUE1TeDJxY3BWZTI2aDlLUFBCaGpsQStCYzk3b0NHMUJ5L293?=
 =?utf-8?B?UU11U3F3TXdJVmhRdjlaR1NFZGgvQmhSYmhuWmJ6QUhUOU5RUlBFNml2Vy9M?=
 =?utf-8?B?VUs5S3BiYVBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEsvTjJsRUpnTXdScUNHVCtGaVhkbzF2SUR2MFlPMjZOZHZUdWVleTU2Z2Jt?=
 =?utf-8?B?S0JXa2p2Vy96ZVZZMGpHU2FMWGxtT2hlbmdKT2xJV0t3cEJFL1Q4QlVRZTNs?=
 =?utf-8?B?WkdGSzRoTFRzaW1KaFhNeitBcUR5ZVFVc0RBWk1ud3ZSVGpLWjBnUjF5R0ZY?=
 =?utf-8?B?RktJcHRjd0tNY3gwbnlSNHVmczUyNWF1YVg5S1RUVFVZQ2I2ZTIzWXlPQ08v?=
 =?utf-8?B?MFhYSU5TbXE1Ti9EaVVsUVZSNS9Rd0pYbVVhTWQwWnNYVVlmR1FtZHB6eHBi?=
 =?utf-8?B?N2VHRUNSOGJlYXYrWGRyTHd1dEx6bFpqckpnL2pLaHF3ZG5vNEo0WjZBOW0y?=
 =?utf-8?B?K0EvQnEzanliV0c4UEFweGIrVVF4c2tBMzI1QzVOVnU0clE2SWRMYy91YXRB?=
 =?utf-8?B?alpzU2xzdlNCVHpKd3paR25SNXc1OTNHUTM3ZGtTY21saXdOaUJKYVRBc2dK?=
 =?utf-8?B?SGtHS25yVWtuQmF0bjNMcVUybWpJRG0vSUl3Nk90cEVXUWpxbkpQYVJFUEc2?=
 =?utf-8?B?Mm1wSG5hZ2VveUlhemF5cWE1ejFmdkJzaFJpS1RvU3dvSkhudDBCMEt4Umt6?=
 =?utf-8?B?bTdZNGdxRmVDMWtuRkJvTm1LN3ZCejZUNEp3UWNDbzVERlBMVFBSOWtwdzhZ?=
 =?utf-8?B?SGk5VE9qdHJRWEdyVU9rZTBXN0l6M0JUTFQwTERsa29KKzRFbmhUQm1ZUlh1?=
 =?utf-8?B?c3VicVpMbEw0bVplZ25sQ0l1WUFpd1RMQU5ONGg3SU4xdldrdml1enczcTVh?=
 =?utf-8?B?aDFtMjFtS25DMkhHcmZycU1uTlFsWEpudjVocUY3T2VleTM4Mm9CRzY3SkdD?=
 =?utf-8?B?cFkyeEppdXIrNkc5dWRiTk5BSVJKYzltS1FaeVY4WGVieDZ5RmY2bXRMa29i?=
 =?utf-8?B?eVFPV2RPNzhrU1BORXp2ZmRKK2xSRDRBTDBvc1RZWTVvdFRRRUtYQ1NzSmN6?=
 =?utf-8?B?YW1EcDFPOXp1bE91SkM2YXNCM3RzZDlnRHFXTU0xR0dsTUphYzNqc3kzMzJ0?=
 =?utf-8?B?REhIYlBORTI2V1ovMm90MHJlNjdOMVZ6dEp3dXY0SzFLbkdpcU81QWJpeHFa?=
 =?utf-8?B?MEl4Y1phWHVwRDBPTEdZM0lZZXY1V3lFb09zY244OEw5ZTUyK2dpcVROazlW?=
 =?utf-8?B?czBpRXFiOERXenVPQ3NxY0ZZcnVsSEIzbmtFSFV1TFZVeHJqSUl0QnA5QjY2?=
 =?utf-8?B?NmVNTlM2RUtwUk41RkVqU2hTVzUyNUpWbW1BamFDRHVYdXJZT2VMTnlSNHVF?=
 =?utf-8?B?NnpXeDY3SkNlaTZsd0x2MG1oOUx5aFRJSHlHU1BnN0MxeW5LeU5vYTJQUnNP?=
 =?utf-8?B?UWl1cGgzTi8yN3pOQVVmRXQxNml5Y2tyZmVLTE1qMkVGcmVaVlQ5ZUR3V2Yv?=
 =?utf-8?B?Y1ZlNk9Iam9mdnhvcWRaS01RcTU0SVhLSnNZK0tUdHB4K3BxRm04RitnQVN5?=
 =?utf-8?B?SWhKZWhlMEpIZ2VoaU5sVjIxUGdLRDVOaGlGTHRmMmtYaFo3Vi9wQUFwdDNn?=
 =?utf-8?B?SkhJVGloVzlvUjEyQlFvb0ZVemtIelE1aTBVQi9QKzJvSTdRZnhIVFJoV3JM?=
 =?utf-8?B?K0YyaTFic1ZuSTYwTUZOQitrVlZKSDRVd2V2ekYvRk96Vy9tM0pudUhZOERV?=
 =?utf-8?B?ZnAyR2pySkFIRDdDRHdQLzNkWWFGbXNob1JxMDZGbU8ySktaU2ZLVHBhZnZX?=
 =?utf-8?B?NHhFd3I1cnN3dEQ5dHNmZ3RhNzc4Z2ZEMG1mUU9BSzc2M0llL3hYUTZDQmM3?=
 =?utf-8?B?aXNWaitoRFJGcXBvM041R1lEblduU2hsQk9IWlcrOUFEdDFyRWtSS1lhdFNM?=
 =?utf-8?B?TmhDbmE3MkE0UnlqNlhJdTMrZU9JYnRRQkZqWEEybDRKUE1HaGdNUDRqeW9E?=
 =?utf-8?B?Z3FUcE9uVjIyNHZpcTVvbzBxMWRaOVFHVHdJUkFSYzY2Y2pOaUZwN2JacDl5?=
 =?utf-8?B?dkk2NjN6T1d4WmM5djYrWDhQMk83NDNSUFM1TzU4amZiVmV4dTY1d0NPQjB5?=
 =?utf-8?B?LzM4WDBOdmFVN1A3b21OWS9PcTkrY2Y3OWplZ1I2QWRnY0ZleklncWp0RHUv?=
 =?utf-8?B?Q1V5YkNLV1JDMHA4NkdDc1F1TGpmZWVBdGNUb1IwMjVia29FNEZFWFN5UWxR?=
 =?utf-8?Q?HFvtg7kOY5sToGWDpYbtRLlVZ?=
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
	/RtsdnyI7MkiG9Gk2PTkaZp54KZN/uIywKGNuq1fAdSkKb2upJWkvkz467RcHDSMBByu05aRvk5wSIh/xquB/Z5ztaw52ObfUgAgATrjeMN8fwtkRFV5Foz7aXYXfuyCkInJhmWuWDrYesI/GfxdMI/HQXx9cJOk/Z+ZwmlYTDnO18RptbaB607dt543hT8nRvOhimDU431WrZSg+hd3mYlnULfCMokWU2MXgtcLuB68IqQFyAQzOLKooh4LsjzVWbAdcQBS9QVOmlFjEJc8pQht7S0pAjci2PQVnCRguwQ8wRgnfulkvg2xJKGmBmgDwQhYfLiQMCgyKGkRTJ0c1v9afd9T8k5g+zpONFX4M8o5x+u5o3HADGd6dK+FEnI3OGz/Wb28P32nuZdMbYvB2oign3eUeMrHG26ZW9Pgh6E+VKttOfBQYhGGCtsj5scaKpqMmVwjyvebH6b8bbHr5w44E+UgHrQTO5BqTZrOQgT1pOYznOv+gDtklgZWoygrfJZ2Eidp/xJi8st8Qiv7UI6VCtQ7+5KvfApa/BXIWotISdR2H1hGrTnGGMMvHKIGVTPSwBTZPN8tEyf3ZFJNSJydWEIdecEgTgLb0mC+bA33BLGnCct0fybvTVu70lQcwMEwC4regiI7Owf5imzpGw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f024218-c600-4154-d5ab-08dde91ecd3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 06:14:25.7700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7ExLxcgDtJSjXXZHCQ+Z3FdyHKDixSkMhtpCHopqqNbvqANqLWRQGx89KZo3SjuwSq3C1q7RSpjJTcUHteb0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR16MB5162

PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gVGhlIHJl
c3VsdCBmaWVsZCBvZiBhbiBSUE1CIGZyYW1lIHdpbGwgaGF2ZSBiaXQgNyBzZXQgYXMgc29vbiBh
cyB0aGUNCnNldCAtPiBwZXJtYW5lbnRseSBzZXQNCg0KPiB3cml0ZSBjb3VudGVyIHJlYWNoZWQg
aXRzIGxpbWl0ICgweGZmZmZmZmZmKSAtIGV2ZW4gaWYgdGhlIG9wZXJhdGlvbiB3YXMNCj4gc3Vj
Y2Vzc2Z1bC4gSGFuZGxlIHRoYXQgY29ycmVjdGx5IHRvIGF2b2lkIGZhbHNlIGVycm9yIHJlcG9y
dHMuDQpDb3JyZWN0Lg0KDQo+IA0KPiBPbmx5IHRoZSByZXN1bHQgcmV0dXJuZWQgZnJvbSBrZXkg
cHJvZ3JhbW1pbmcgZG9lcyBub3QgbmVlZCBzcGVjaWFsDQo+IGhhbmRsaW5nIGFzIHRoZSB3cml0
ZSBjb3VudGVyIGlzIHN0aWxsIDAgYWZ0ZXIgdGhhdCBzdGVwLg0KPiANCg0KDQpGaXhlcyB0YWcN
Cj4gU2lnbmVkLW9mZi1ieTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4g
LS0tDQo+IA0KPiBUZXN0ZWQgYWdhaW5zdCBhIFFFTVUgUlBNQiBtb2RlbCB0aGF0IHdhcyB0dW5l
ZCB0byByZWFjaCBhIGNvdW50ZXINCj4gZXhwaXJ5IHF1aWNrbHkuDQpNb3ZlIHRoaXMgYWJvdmUg
eW91ciBzaWduYXR1cmUNCkFuZCB5ZWFoIC0gSW4gdGhpcyByYXJlIGNhc2UgdGhlIGRldmljZSBp
cyBtb3N0IGxpa2VseSB3b3JuIG9mZiBzbyBtYXliZSBhZGQgYW4gaW5kaWNhdGlvbiBvZiB0aGF0
Pw0KDQo+IA0KPiAgbW1jX2NtZHMuYyB8IDEzICsrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
bW1jX2NtZHMuYyBiL21tY19jbWRzLmMNCj4gaW5kZXggMTZjNmIyZS4uZTkxODEzYSAxMDA2NDQN
Cj4gLS0tIGEvbW1jX2NtZHMuYw0KPiArKysgYi9tbWNfY21kcy5jDQo+IEBAIC0yMTAzLDYgKzIx
MDMsOCBAQCBlbnVtIHJwbWJfb3BfdHlwZSB7DQo+ICAgICAgICAgTU1DX1JQTUJfUkVBRF9SRVNQ
ID0gMHgwNQ0KPiAgfTsNCj4gDQo+ICsjZGVmaW5lIFJQTUJfV1JJVEVfQ09VTlRFUl9FWFBJUkVE
ICAgICAweDgwDQo+ICsNCj4gIHN0cnVjdCBycG1iX2ZyYW1lIHsNCj4gICAgICAgICB1X2ludDhf
dCAgc3R1ZmZbMTk2XTsgICAgICAgICAgIC8qIEJ5dGVzIDUxMSAtIDMxNiAqLw0KPiAgICAgICAg
IHVfaW50OF90ICBrZXlfbWFjWzMyXTsgICAgICAgICAgLyogQnl0ZXMgMzE1IC0gMjg0ICovDQo+
IEBAIC0yMzIxLDcgKzIzMjMsNyBAQCBzdGF0aWMgaW50IHJwbWJfcmVhZF9jb3VudGVyKGludCBk
ZXZfZmQsIHVuc2lnbmVkDQo+IGludCAqY250KQ0KPiAgICAgICAgIH0NCj4gDQo+ICAgICAgICAg
LyogQ2hlY2sgUlBNQiByZXNwb25zZSAqLw0KPiAtICAgICAgIGlmIChmcmFtZV9vdXQucmVzdWx0
ICE9IDApIHsNCj4gKyAgICAgICBpZiAoKGJlMTZ0b2goZnJhbWVfb3V0LnJlc3VsdCkgJiB+UlBN
Ql9XUklURV9DT1VOVEVSX0VYUElSRUQpICE9DQo+IDApIHsNCkFjdHVhbGx5LCB3ZSBjb3VsZCBp
Z25vcmUgYml0IDcgc2luY2UgdGhlcmUgY2FuIG9ubHkgYmUgNyBwb3NzaWJsZSByZXNwb25zZXM6
DQplLmcuIGlmIChiZTE2dG9oKGZyYW1lX291dC5yZXN1bHQpICYgNykgPw0KDQpUaGFua3MsDQpB
dnJpDQoNCj4gICAgICAgICAgICAgICAgICpjbnQgPSAwOw0KPiAgICAgICAgICAgICAgICAgcmV0
dXJuIGJlMTZ0b2goZnJhbWVfb3V0LnJlc3VsdCk7DQo+ICAgICAgICAgfQ0KPiBAQCAtMjQ0Miw3
ICsyNDQ0LDggQEAgaW50IGRvX3JwbWJfcmVhZF9ibG9jayhpbnQgbmFyZ3MsIGNoYXIgKiphcmd2
KQ0KPiAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgLyogQ2hlY2sgUlBNQiByZXNwb25zZSAqLw0K
PiAtICAgICAgIGlmIChmcmFtZV9vdXRfcFtibG9ja3NfY250IC0gMV0ucmVzdWx0ICE9IDApIHsN
Cj4gKyAgICAgICBpZiAoKGJlMTZ0b2goZnJhbWVfb3V0X3BbYmxvY2tzX2NudCAtIDFdLnJlc3Vs
dCkgJg0KPiArICAgICAgICAgICAgflJQTUJfV1JJVEVfQ09VTlRFUl9FWFBJUkVEKSAhPSAwKSB7
DQo+ICAgICAgICAgICAgICAgICBwcmludGYoIlJQTUIgb3BlcmF0aW9uIGZhaWxlZCwgcmV0Y29k
ZSAweCUwNHhcbiIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJlMTZ0b2goZnJhbWVf
b3V0X3BbYmxvY2tzX2NudCAtIDFdLnJlc3VsdCkpOw0KPiAgICAgICAgICAgICAgICAgZXhpdCgx
KTsNCj4gQEAgLTI1NzMsNyArMjU3Niw3IEBAIHN0YXRpYyBpbnQgcnBtYl9hdXRoX3dyaXRlKGlu
dCBuYXJncywgY2hhciAqKmFyZ3YsDQo+IHVpbnQxNl90IGFkZHIsDQo+ICAgICAgICAgfQ0KPiAN
Cj4gICAgICAgICAvKiBDaGVjayBSUE1CIHJlc3BvbnNlICovDQo+IC0gICAgICAgaWYgKGZyYW1l
X291dC5yZXN1bHQgIT0gMCkgew0KPiArICAgICAgIGlmICgoYmUxNnRvaChmcmFtZV9vdXQucmVz
dWx0KSAmIH5SUE1CX1dSSVRFX0NPVU5URVJfRVhQSVJFRCkgIT0NCj4gMCkgew0KPiAgICAgICAg
ICAgICAgICAgcHJpbnRmKCJSUE1CIG9wZXJhdGlvbiBmYWlsZWQsIHJldGNvZGUgMHglMDR4XG4i
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgIGJlMTZ0b2goZnJhbWVfb3V0LnJlc3VsdCkpOw0K
PiAgICAgICAgIH0NCj4gQEAgLTI2MjEsNyArMjYyNCw3IEBAIHN0YXRpYyBpbnQgcnBtYl9hdXRo
X3JlYWQoaW50IG5hcmdzLCBjaGFyICoqYXJndikNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAg
IC8qIENoZWNrIFJQTUIgcmVzcG9uc2UgKi8NCj4gLSAgICAgICBpZiAoZnJhbWVfb3V0LnJlc3Vs
dCAhPSAwKSB7DQo+ICsgICAgICAgaWYgKChiZTE2dG9oKGZyYW1lX291dC5yZXN1bHQpICYgflJQ
TUJfV1JJVEVfQ09VTlRFUl9FWFBJUkVEKSAhPQ0KPiAwKSB7DQo+ICAgICAgICAgICAgICAgICBw
cmludGYoIlJQTUIgb3BlcmF0aW9uIGZhaWxlZCwgcmV0Y29kZSAweCUwNHhcbiIsDQo+IGJlMTZ0
b2goZnJhbWVfb3V0LnJlc3VsdCkpOw0KPiAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ICAg
ICAgICAgfQ0KPiBAQCAtMjc4Myw3ICsyNzg2LDcgQEAgaW50IGRvX3JwbWJfd3JpdGVfYmxvY2so
aW50IG5hcmdzLCBjaGFyICoqYXJndikNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIC8qIENo
ZWNrIFJQTUIgcmVzcG9uc2UgKi8NCj4gLSAgICAgICBpZiAoZnJhbWVfb3V0LnJlc3VsdCAhPSAw
KSB7DQo+ICsgICAgICAgaWYgKChiZTE2dG9oKGZyYW1lX291dC5yZXN1bHQpICYgflJQTUJfV1JJ
VEVfQ09VTlRFUl9FWFBJUkVEKSAhPQ0KPiAwKSB7DQo+ICAgICAgICAgICAgICAgICBwcmludGYo
IlJQTUIgb3BlcmF0aW9uIGZhaWxlZCwgcmV0Y29kZSAweCUwNHhcbiIsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJlMTZ0b2goZnJhbWVfb3V0LnJlc3VsdCkpOw0KPiAgICAgICAgICAg
ICAgICAgZXhpdCgxKTsNCj4gLS0NCj4gMi40My4wDQo=
