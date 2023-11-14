Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1A1F176
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SpZnEqQl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yyaLIdYT"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51110187
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 03:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699960873; x=1731496873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PyxpmuC+RXbS8HVioM+y5nlnvYIJYOnX/St1JZRAVi8=;
  b=SpZnEqQljT1278g3o47pIRPFYLAOnk/h36iT9dRwy7TqIvPIn1at9ryt
   660V27wYDF0MnTVn9UOKcU1NizCSCj4zjceNp3FvBld7XQUD3ey772c/r
   Iro2kih1AJpGs7Jye67js3MwfHT1OmXv0EnUwtMW3h1zBDeQBo2EhrhVQ
   lvv+IhDFSqU8LYvppcaA3p7BSAs233qVDbWHDCNqlRb5704P2MX7r38uF
   a5kRc3yniBnVx3PSr0KttswafSV/85503BxYnwSIIbpGR1en8oH4dYxly
   kTzj1R+mA9HIESkHzr5xcLJRfESBROlyS3DETxvlnyVIiDDGhyJIQEXGO
   w==;
X-CSE-ConnectionGUID: aUAA6WziRhyD+cgCWU+3hg==
X-CSE-MsgGUID: QTTmRqINRmqGY71HQdfb7A==
X-IronPort-AV: E=Sophos;i="6.03,301,1694707200"; 
   d="scan'208";a="2235689"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2023 19:21:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP+1hXQPeFWtP0m8U538kbphgK24KEO95SEKa9a5FdpoH7JgQdjmyGaUVYBNKKeQowLU2X9tzl/HW/ArDTxo3Th1GpNIi/HVNe9t+F1botlKLiSGqr8twaS9SCEu7WgD3dvrxWxSqYc0AgUBpnnSiRmlqbYq+rJpLWCT28xkQn5E1ADb1CbxW9m4dDZENH5zM6vGfkoKEAnRjK0u1TZbEtNk/Zk5ZpNGsjqx2CL7fOWo34R5v9gv8A/rPZpLYtA8kn0VRO0oWMVUzs8z0q7TNLPqzH6h6Y1jaO+g50dbGkOEdh3pQHdYwLvhHyz6XV1hrqXWFXnLe/AsyTUcKf94Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyxpmuC+RXbS8HVioM+y5nlnvYIJYOnX/St1JZRAVi8=;
 b=iBwNABsbP7Hn5cXTtOS4K6smtPW+Mv17nOEx5hT0eSd1yeS/LHTgN3L/T2Rnnu+5nNlmtMgRs/bIJKG79Pl1eQc27kQMbMnxGYf0MYx6kOvDa/jYNzBrsbbMyRGwcCtHjN5pydZTUwMCAkj3oqfJJdKRQz3zi9KqI6DQwO6boxOeziBE0E/CB3AD/pjmlk2hVNLHTOLwrH8VP3m/uKulJWP1KRqYK/ITAcUuJKtQpOhK8E5LEjWlZ4ota5WC+9WlI/nX03eR35dh6aZBAqGjsrfKJiTbR8IlnFsRLv5lXj6CWQTfDy7MIxJB60oAmLNFam5tJOSZ0qIFWPS5UoYaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyxpmuC+RXbS8HVioM+y5nlnvYIJYOnX/St1JZRAVi8=;
 b=yyaLIdYTHdDvk+UlnE1Ar8jVysGeq13CekH793sbkGjEkWWLQTCURizSjrsOUs4LybW5KpF7xP3NVqufrzYvMH4GVfdJusqUWHyGnUtbIEfK6/mVXGYNm0rMcO27vKtCBI8N5BwWnscCPJi/821qEAU+mVbSdwBQ8MP7+2Nh0iI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH8PR04MB8711.namprd04.prod.outlook.com (2603:10b6:510:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 11:21:08 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 11:21:08 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Daniil Lunev <dlunev@google.com>, Asutosh Das <quic_asutoshd@quicinc.com>
Subject: RE: [PATCH] mmc: core: Use mrq.sbc in close-ended ffu
Thread-Topic: [PATCH] mmc: core: Use mrq.sbc in close-ended ffu
Thread-Index: AQHaCxDLYKp/eAjaS0W34g/VSus9CrBta9wAgABBWcCADBVGIA==
Date: Tue, 14 Nov 2023 11:21:08 +0000
Message-ID:
 <DM6PR04MB657536595A7EF523A14A7D6BFCB2A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231030090906.1897035-1-avri.altman@wdc.com>
 <557eb489-3e1d-4cbd-b62d-d3046870a4cc@intel.com>
 <BL0PR04MB6564E2DDCA36806907F600BAFCAAA@BL0PR04MB6564.namprd04.prod.outlook.com>
In-Reply-To:
 <BL0PR04MB6564E2DDCA36806907F600BAFCAAA@BL0PR04MB6564.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH8PR04MB8711:EE_
x-ms-office365-filtering-correlation-id: dbd7872a-ebf8-4d6e-b53a-08dbe503ccb2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MpgKiRv8YDGJdbAb4YAPza8lI2MEm09XAKmo5MY6CbcWfDFtraBwBtdwFTaV5A4SWwyREDZHUNbgpbsn2wm2cLTdcnLn9xFSa0yiiIwPtXyVEBOl0yC2sd7bK3xA19oUeTNY8NrWUjw8XKuauJSQEjJjnJnrQPuyIfcxMv7O87Rs0mPaFd/fSZtNP6tM1cOZnB6loQsVUQpL019luta3y739bRfvz1DlVLb66arvzwr1FEd6O2/4XNyIyZ0dwk7lTFsFAkSSc3QwEsfBJte1VLraRSrXdnP8CpFe9w/KxMov6UhLwgN4V4L21R3tNAUOea+3W4nJBfdIWqk5YbyM6OefX3irkGwtP9+9Z6coSnUlsZzec4TiuQbfewEsBV/p+ZmcIv47ziIP0NwOJdlqXo9njFgSp3iZSme9AcD7iqAVsKsKAYBbr2heCOike3S49/oQtbUvumCPwHoc2ujuaMgime6DlYJzv0+KkOvUangyKBOisxKKkV0ajD8xIjx/Dkiwchd5puY0w/3kHGwqcZd1Crd5TFQrBn8sAl/Xy/hYfk8bIFd8C2m3m1TwbgF1aOMUGC00fiZEXGz4oW5exFredVrhsLhakGQvmfKmo/4HQKCqNgq0RMzFjuZkxuGB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(55016003)(38070700009)(4326008)(71200400001)(8936002)(8676002)(9686003)(2906002)(26005)(7696005)(6506007)(83380400001)(38100700002)(41300700001)(478600001)(82960400001)(122000001)(52536014)(5660300002)(33656002)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(76116006)(86362001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGg1Ti95cUp3RWZ6MWlUc24wRWlaUG1MU25FY3Z6VnNhbEtxKzRiUmdudnYz?=
 =?utf-8?B?RXdnNm9aaU8rWis2d0tjNkNsU201eDdKb0UrNTdpUVZabzZMcWZQdU1HVnhq?=
 =?utf-8?B?R0NQandPUFNYR3ZaREMrczVoMDBVeGI1c2l3VWlWdmZhVDBrdCtFUGVPUWk2?=
 =?utf-8?B?Y0VzTDFFUmRvMllqZmYweDhTekJKazZReHU1M2Rrb3gxZ1FSWTRQd1EvQXk4?=
 =?utf-8?B?dFdEL2VpWklPZUtoZFYyYjJoOFpBMkJsZVhQc2RFWlZvbFl2bDRaWUtjNEdj?=
 =?utf-8?B?R25BUkFNRzhYcUpiN2Nzejk1dVFHNmRSR2wyRjlieHpHK2dyaU9KZk11WkJV?=
 =?utf-8?B?c1cyTDhiWWV4eFlnaFJKaVFvWmJ4SHVsOXdFcDR2eDdPNElqZjRlOXBHOFRT?=
 =?utf-8?B?azBHSVQ1NUVmNExqVk9rU3p3WDFNRit4Qkc4WnBBZS85L05QMEVJK0R5YklK?=
 =?utf-8?B?TWlxcnRINFJyZEJMWWRsYitxK0RUekFyNmRRamFFbDF6ZmtEU0l3NHdEQkFo?=
 =?utf-8?B?dmMzSWl0RzAxcFAxdy8xQkxwcmdVNnF2Wm1Nc2N4TTBXSjZxOXVtSkphTkFp?=
 =?utf-8?B?dE5xNWplRWEwSnF2aURhZHhmYUYrSGpVVm0zZEZkL0UwSGRkUUdRNzRrV0Fp?=
 =?utf-8?B?ZUgwOE1KaFZUV05kRWV2ZnhRdmdjYXVIRnZITG4wWnB2TThPMzUzRmkxdVRG?=
 =?utf-8?B?a3Qra0dXRTQ2UkFURHhGSWJYZFBjUHJKWkN1UUIyYmNzZ1hLdFptcjJEb0JZ?=
 =?utf-8?B?Rmw5TkV0Ry9VTTBnQllOSEZhckFEY3g2alAyWTFPcDVjeGVSOTRkR25KVEky?=
 =?utf-8?B?R1k3TDRoM2xiR1hGenJNakVWWWREVDVxMGVLQmozbWtXZ2FsNjZPUG40ZHpZ?=
 =?utf-8?B?b3Rtd2tQYk1GTmZRUHRBbVUrZUNOLzJ4aGNVRUNFUUtHVTM5L0UxZHJ4MnZx?=
 =?utf-8?B?Ly9YVnFRb0tRcmpNTCtrRmVUL29UUEE4NWg2UFlJQnZCaUloWVdPTm16a3Fh?=
 =?utf-8?B?Mjk3ZjB0eHZxaUJZb2dtcXgxTzdMU0NKaUlRd1JXYmFoTXArZjhjQnBSVllx?=
 =?utf-8?B?NHBObGRDSkI0bGI1OXR5MnFMR0xtbThNb0o5Q0RRS0hpVXVELzlPeklKR1lm?=
 =?utf-8?B?UFNBUVRWck43NUI3Y1ptQURINTdBaW9DTE9EQ0tNSTRaV1h0RFN2RmhrVWJW?=
 =?utf-8?B?VW4zTDVBblF2NHo3QTVUSFd0ZTMxQk8zOGtTWUhOOE1JQzE4WXhIUHpVem5I?=
 =?utf-8?B?eFFrN0llR2trMjJ4N3RqV1FER1pFMHNtMUJucEh4M2FlUEdsb1ptT205eFR3?=
 =?utf-8?B?eHR5Ukx2YU4vM0JzTjI2V1Zhd1pYc1A5SGJBTTc2RVNjK2F5bk9Ta0k0bng2?=
 =?utf-8?B?VG9MNGh2WlVTYVdueW9VREhHK0NaQ240L2d2R2RZL1VndUZGRG9uZ1Q5SWZj?=
 =?utf-8?B?Y0E4cm42NHBpT3BDc3BGZnBIbkljTzlnWnJNTkxCZmYzZTNpUFFPaG5kU1ZE?=
 =?utf-8?B?UW5MMXJOV3VoVTNTbHVaeko1T0p3bFdMOFBRMjV0RWJnbHg3UXI4U1FySUZE?=
 =?utf-8?B?Q0s3ekdlSlBqeFpmVERLc0JVRGxSV1JESHNJU1JNZFhBZzVDWm9mVXhDc00v?=
 =?utf-8?B?cllrUlFzNTJmNitkMGcvYUpqTmRNdWVzTy94WUlBdElBZ0tDemZoeGtjdnJW?=
 =?utf-8?B?T09qLytFNENMbmllRnRUM3p6Y3VySG1BOTZEVXptQUJiUE1odnFLTHZDWDd2?=
 =?utf-8?B?bzhFRjNXdkFGNkJQR3p2dHRJWFlITDR5TUIvckVXK2lITTZMMUhlMm1tdHVa?=
 =?utf-8?B?VVByYUppOTU3d1hPMjF2SGlSZVVZSm5OQU45WXoxQlg5dGFkQ2d5OUV0cWNP?=
 =?utf-8?B?NlJhOUwyVEtCY2MweXQwMFh0Zlh4RTVXK1VrNG1xZ0JiR3AvR1BWTjgxQmdL?=
 =?utf-8?B?b2V1aTgzRlpHUkMwV3hjcncrV0wrY0RLTmJzVWJJQ2pqZkovcHAxVWtwMm4x?=
 =?utf-8?B?ZWgrM1luakFBK2sxT2lVMFlOcXlzbURxeVlFUWdqeTl4NnVITmE4c09MSE5P?=
 =?utf-8?B?UmJINW1OcnBCWWVDbHR1SS95OVlpSHp4N0VLeUJjSjl1QXZRNndGcWdpTWpT?=
 =?utf-8?Q?OZMz6u9faZUWW+DCA5DWEE3KW?=
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
	nFAi9tlx0qIOLt5s5UNXy3pu1NcwDUgdDw35wTOUAnoGXM+aXQLnDzo4qgLGUjdbcxmkkPE+nlkI6zosDAa5g0frvf3rd7YVVSzxEl1aR/Q0C93AS3uq7AaAneltmLOhxJZCRJwxpj3n8ke7sC4IHqtloeMbu5woVSkpByz7xgAAKrpaa358WStLOa7juj17JJD/CArCxg9U0GJwKftjh+uBS5F5lb5umGtNENHWUlZGRJlWEEjWXeHIcOivBFbeYEKljBnpCcyualf49tqFmqEbJX/VxN/fON4XvW8KqdTTwWHbsrfpocHa3nQ4qTIv+vYpz6yPnkRkkobWwndXHUW5OwGS3NSiuq9x8MmZ2USr0+BUeGLgvLVniouxB2KpNzVbGjQV77oF54VoN57H1PvBE+UyY+4MJcl8jkdDSdUp2ejYqDoEtKfWQYYQsk2XgFVaT2kdJCU74kRC9DWTWFOYL2e1rzRm5Gq1PAbPRwko9aXZNjfZ0x1vQHycGLnXrYTr0Gzl2oi6v27tv+poh/ocdB5/S1bLeoMmJp646KEr5zBwE5oOau9Bfjt1hCWPtIB0daXnPkDb0vWltUpwKNuEmybWyqXBwJhwUx5Zd5YekoYHAzmGzvjrGG1VTOgZAUs6xTWLCozGuLM9Br9tQQO4STv9t6yaUPbFbtUy84VAOgLaYvFhAjXxQKciy6HaDkjoymarr+qIKxennPfQO+/6yVZL6c4sflJCM4LP9YDLgu6iskxfAw2AaPR9TBLiOxQSZUxW/Lgwk1eLwAZGBSwdIFGlV42i4ARCEosxf/YoTngDEbKMAINjXu6llrc0WEEFKHSnaY1wWCE8k5+6knTO3i/zfA4XfMypCGwtO8qR5qwycXMHyzijZ60V92HBL5oGmETthyZf6JlXy2ngpg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd7872a-ebf8-4d6e-b53a-08dbe503ccb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 11:21:08.4883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2IdaEd1O90GvN5DtVKxHQPwc0qxZgUggsJ3RQONyajiRdVRqPiELSPpeAnBWS8vHjcCfP2S6717DYAugfOQzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8711

PiA+ID4gICAgICAgfQ0KPiA+ID4gQEAgLTEwMzIsNiArMTA0NCwyOCBAQCBzdGF0aWMgaW5saW5l
IHZvaWQNCj4gPiA+IG1tY19ibGtfcmVzZXRfc3VjY2VzcyhzdHJ1Y3QNCj4gPiBtbWNfYmxrX2Rh
dGEgKm1kLCBpbnQgdHlwZSkNCj4gPiA+ICAgICAgIG1kLT5yZXNldF9kb25lICY9IH50eXBlOw0K
PiA+ID4gIH0NCj4gPiA+DQo+ID4gPiArLyogY2xvc2UtZW5kZWQgZmZ1ICovDQo+ID4gPiArc3Rh
dGljIHZvaWQgbW1jX2Jsa19jaGVja19jZV9mZnUoc3RydWN0IG1tY19xdWV1ZV9yZXEgKm1xX3Jx
KSB7DQo+ID4gPiArICAgICBzdHJ1Y3QgbW1jX2Jsa19pb2NfZGF0YSAqKmlkYXRhID0gbXFfcnEt
PmRydl9vcF9kYXRhOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgaWYgKG1xX3JxLT5pb2NfY291bnQg
IT0gNCkNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAg
aWYgKGlkYXRhWzBdLT5pYy5vcGNvZGUgIT0gTU1DX1NXSVRDSCkNCj4gPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgaWYgKE1NQ19FWFRSQUNUX0lOREVYX0ZS
T01fQVJHKGlkYXRhWzBdLT5pYy5hcmcpICE9DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
RVhUX0NTRF9NT0RFX0NPTkZJRykNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ID4g
Kw0KPiA+ID4gKyAgICAgaWYgKGlkYXRhWzFdLT5pYy5vcGNvZGUgPT0gTU1DX1NFVF9CTE9DS19D
T1VOVCAmJg0KPiA+ID4gKyAgICAgICAgIGlkYXRhWzJdLT5pYy5vcGNvZGUgPT0gTU1DX1dSSVRF
X01VTFRJUExFX0JMT0NLKSB7DQo+ID4gPiArICAgICAgICAgICAgIGlkYXRhWzFdLT5mbGFncyB8
PSBNTUNfQkxLX0lPQ19EUk9QOw0KPiA+ID4gKyAgICAgICAgICAgICBpZGF0YVsyXS0+ZmxhZ3Mg
fD0gTU1DX0JMS19JT0NfU0JDOw0KPiA+ID4gKyAgICAgfQ0KPiA+DQo+ID4gQ291bGQgdGhpcyBi
ZSBtb3JlIGdlbmVyaWMgZS5nLiBzaW1wbHkNCj4gPg0KPiA+ICAgICAgICAgZm9yIChpID0gMTsg
aSA8IG1xX3JxLT5pb2NfY291bnQ7IGkrKykNCj4gPiAgICAgICAgICAgICAgICAgaWYgKGlkYXRh
W2kgLSAxXS0+aWMub3Bjb2RlID09IE1NQ19TRVRfQkxPQ0tfQ09VTlQgJiYNCj4gPiAgICAgICAg
ICAgICAgICAgICAgIG1tY19vcF9tdWx0aShpZGF0YVtpICsgMV0tPmljLm9wY29kZSkpIHsNCj4g
SSBndWVzcyB5b3UgbWVhbnQgKGlkYXRhW2ldDQo+IA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGlkYXRhW2kgLSAxXS0+ZmxhZ3MgfD0gTU1DX0JMS19JT0NfRFJPUDsNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBpZGF0YVtpXS0+ZmxhZ3MgfD0gTU1DX0JMS19JT0NfU0JDOw0KPiA+
ICAgICAgICAgICAgICAgICB9DQo+ID4NCj4gPiB3aXRoIG5vIG5lZWQgdG8gY2hlY2sgZm9yIDQg
Y21kcywgTU1DX1NXSVRDSCBvcg0KPiBFWFRfQ1NEX01PREVfQ09ORklHDQo+IERpdHRvDQpPciwg
SSBjYW4gZm9sbG93IHlvdXIgcHJvcG9zYWwuDQpXaWxsIHNlbmQgYSB2My4NCg0KVGhhbmtzLA0K
QXZyaQ0KDQo+IA0KPiBUaGFua3MsDQo+IEF2cmkNCj4gPg0KPiA+ID4gK30NCj4gPiA+ICsNCj4g
PiA+ICAvKg0KPiA+ID4gICAqIFRoZSBub24tYmxvY2sgY29tbWFuZHMgY29tZSBiYWNrIGZyb20g
dGhlIGJsb2NrIGxheWVyIGFmdGVyIGl0DQo+ID4gcXVldWVkIGl0IGFuZA0KPiA+ID4gICAqIHBy
b2Nlc3NlZCBpdCB3aXRoIGFsbCBvdGhlciByZXF1ZXN0cyBhbmQgdGhlbiB0aGV5IGdldCBpc3N1
ZWQgaW4NCj4gPiA+IHRoaXMgQEAgLTEwNTksNiArMTA5Myw5IEBAIHN0YXRpYyB2b2lkIG1tY19i
bGtfaXNzdWVfZHJ2X29wKHN0cnVjdA0KPiA+IG1tY19xdWV1ZSAqbXEsIHN0cnVjdCByZXF1ZXN0
ICpyZXEpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gICAgICAgICAgICAgICB9DQo+
ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgIG1tY19ibGtfY2hlY2tfY2VfZmZ1KG1xX3JxKTsN
Cj4gPiA+ICsNCj4gPiA+ICAgICAgICAgICAgICAgZmFsbHRocm91Z2g7DQo+ID4gPiAgICAgICBj
YXNlIE1NQ19EUlZfT1BfSU9DVExfUlBNQjoNCj4gPiA+ICAgICAgICAgICAgICAgaWRhdGEgPSBt
cV9ycS0+ZHJ2X29wX2RhdGE7IGRpZmYgLS1naXQNCj4gPiA+IGEvaW5jbHVkZS9saW51eC9tbWMv
bW1jLmggYi9pbmNsdWRlL2xpbnV4L21tYy9tbWMuaCBpbmRleA0KPiA+ID4gNmY3OTkzODAzZWU3
Li5kNGQxMGNhYmFhNTcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tYy9tbWMu
aA0KPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tbWMvbW1jLmgNCj4gPiA+IEBAIC0yNTQsNiAr
MjU0LDcgQEAgc3RhdGljIGlubGluZSBib29sIG1tY19yZWFkeV9mb3JfZGF0YSh1MzINCj4gc3Rh
dHVzKQ0KPiA+ID4gICAqLw0KPiA+ID4NCj4gPiA+ICAjZGVmaW5lIEVYVF9DU0RfQ01EUV9NT0RF
X0VOICAgICAgICAgMTUgICAgICAvKiBSL1cgKi8NCj4gPiA+ICsjZGVmaW5lIEVYVF9DU0RfTU9E
RV9DT05GSUcgICAgICAgICAgMzAgICAgICAvKiBSL1cgKi8NCj4gPiA+ICAjZGVmaW5lIEVYVF9D
U0RfRkxVU0hfQ0FDSEUgICAgICAgICAgMzIgICAgICAvKiBXICovDQo+ID4gPiAgI2RlZmluZSBF
WFRfQ1NEX0NBQ0hFX0NUUkwgICAgICAgICAgIDMzICAgICAgLyogUi9XICovDQo+ID4gPiAgI2Rl
ZmluZSBFWFRfQ1NEX1BPV0VSX09GRl9OT1RJRklDQVRJT04gICAgICAgMzQgICAgICAvKiBSL1cg
Ki8NCg0K
