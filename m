Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337D36AF2
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656305; cv=fail; b=mlobwmw3R68aPFsQwqA7MmGiOObZEgAumpSMxx+2LjUIDgUciElCniJhSGvKsk8kLJdc52WKIThQTSLPdLMwndLKgFIjBCV0SGiTPuyR30QTJ1nxZ+ACYH901q8nbaS0XOX2MGppnIf/LrpHdb6rLitwxPNuHIPPolmTG3GBgDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656305; c=relaxed/simple;
	bh=upYcPc2EFMthFH4JrYef0jCmHHnVx1vz33v/mMEC3e8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KgOqPEjjriOKgJUQ3V4V8pIc3U9hWNG+PrKbeoesr7Ec27twFsxTbHMyMwXykAlJ2o97gIpuXefZw3cpgNDvrtOwoEKi2qTpp7rzH1JkB4nC+3+wrb6Urw6A5AJM6RhVGl++IssSR5Q/MY/vawE+5tDCz1+eBnHkUbhuQjnJIAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BdgpjiVJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=k5bAcW8i; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BdgpjiVJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k5bAcW8i"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724656303; x=1756192303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=upYcPc2EFMthFH4JrYef0jCmHHnVx1vz33v/mMEC3e8=;
  b=BdgpjiVJsy8sXu7t8geb4c5Q6eJVwWUGOg6u00+C1DNYjTPBAlAJac06
   1WaIM+gfpLyLUQrCuluQYi41JwYC+VQV5+D4dzLj5XEH11fRjR/GQaZI2
   qQvw2rEZTvlQooJMK52VaCKr+RMAS64nJnxqa0tPmqvPGUtDqhIQU+WmP
   bMaZDtiW0UKd7z2AwKPoHML4EwIN4/h8QWHqQGJB1oo1ZR0UqeBcy14yY
   BfPpxJkBuHzGnV4YFvpk8FenihpgYbYdFCsd0BhaJaKaM6r4Q3Vhd9Z5I
   plCDwUXJufWOhbPzgxZOT68U7DJmqrtVlaz7uGOlqQcYYuCxqUirgNzSv
   w==;
X-CSE-ConnectionGUID: qhZiZsURTz+7uOxGyARfIw==
X-CSE-MsgGUID: YvVzW1TbSmK8xFvqeK1zAw==
X-IronPort-AV: E=Sophos;i="6.10,176,1719849600"; 
   d="scan'208";a="25159405"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2024 15:11:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3V8bu93zadmD/gkZZKI1+qfD0KvH3kPH/FcpJj83q8/2aOw4SYBqaug+7bUM0nTqXqhN02Glgt3cFf/BRVQGcpxWDPSjJ3fsOmBBvNDC+K63/RmmhB2UIkz7EDqT9qtartcFyrygFdfYYXMLKIE0FRfxEinFXwEWUS6sw1a6rvG+jjXa0SKfHDqt2Cn+rV6uIcJkugHgE3xfBaaT6VouDa0IftKqdjI8ZLI8yswdZLPMM81a5HJ8gKt9UEZSYibiyz09igVgDgKTs/VmgOKYvR7A7rQEQL8huLlaagQa4JVW32p7xnhECLnvsNudLmVekeymGlj2Rm5CuNTA+0YVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upYcPc2EFMthFH4JrYef0jCmHHnVx1vz33v/mMEC3e8=;
 b=pm9esUOGpDW72tw8dvdEgcTC9hX8PfdbqQ2S8MIffDTHTZcv7mY2CzudRJif8SHcx/B4Py9PGwjD6XsngrdTfbInTSPWi0kILdAC1y+eAnN9kydi5cTNWtNTGojEn/VYosNCTqDwIMiDX7zD62pP+W+qySbGAehuWEQzCw4voyw/ZRZVaNRPmWsk4MHP1dxsg+I4oVpocUuj1wCkgQDH+pV5BUaSTIBFLUaN1ZC9IOAm6ZrRtHc5q3jrvqZ9dUlrFlYZnx99NbsDuIO/mDX3vnKwUMrPWQxNUKJGewi21wuhemESajHROjCGxKCjUTYppVHVHxvaGda6Yax8mLq+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upYcPc2EFMthFH4JrYef0jCmHHnVx1vz33v/mMEC3e8=;
 b=k5bAcW8iiEv/ppqtLLgsEccXII4B8Kyf8QAwnorTvxHRSNyoL4OIwMJSKI2YGs764Hj8XQ+FXVjHanReWfKQ0eyvepo/5sIZH99S3/o0A5tykfgrZukbcnOFagp2v0vhA1NDgagXIxP8d2nFYEab1wg5/UA6RZk2UabGvHfXG6A=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6864.namprd04.prod.outlook.com (2603:10b6:208:1e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 07:11:39 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:11:39 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>
Subject: RE: [PATCH v4 4/9] mmc: core: Add close-ended Ext memory addressing
Thread-Topic: [PATCH v4 4/9] mmc: core: Add close-ended Ext memory addressing
Thread-Index: AQHa9sJ/k6XU2v+xOEigK6atzB+wl7I5ANsAgAAab4CAAAPiQA==
Date: Mon, 26 Aug 2024 07:11:39 +0000
Message-ID:
 <DM6PR04MB6575D36CB333225D99FAE437FC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <20240825074141.3171549-5-avri.altman@wdc.com>
 <DM6PR04MB657566FAC186AE1A9698AF5DFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <636d4b90-d195-498d-b2ca-886c86517ee5@intel.com>
In-Reply-To: <636d4b90-d195-498d-b2ca-886c86517ee5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN2PR04MB6864:EE_
x-ms-office365-filtering-correlation-id: 93559b05-ef80-44d2-f517-08dcc59e54b0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnFqRFVTNzJWZi9ndmxST2M0QVlRNDh6Kzd2eVhzMGtvU1lpQXVvMnR4NUZL?=
 =?utf-8?B?cGNTTVVMRkpxQ2pDVWpBcGQ4YmxlZS9SOXRpekY5eHp6d1l3M2xxUmc2WStw?=
 =?utf-8?B?eGcvektqZkdPdVRoQ29sQ1NwZmlLck5seS9tVVBkc2U4TUhscmhFQmVNWXox?=
 =?utf-8?B?bjBlS1d2UUxBUjJMSTJMZ3V2OHY5cGRjaXZNSnBWRmFoSUtVU01tdXlkZjhI?=
 =?utf-8?B?b1NnVDFrbkF3Mk5nY3VXYVJwV0MxWmN3YXZGU3RrRmNLUDVTZFZiK1N4WVQ1?=
 =?utf-8?B?NGlFWFAzYjU3eXBlUlg0TWtocW1aQXRuMUxITTAyQ3BTSTY2NVlkWWpjR2Iz?=
 =?utf-8?B?MUFLN2ZQQmZNYmxGZEJOSTNzRWxwRVFSRVZSNkJaZGRnblZkYTJ1dTk1NitU?=
 =?utf-8?B?Q1k5WVlnTEl1dFROQVhlc0w3cVpOMXRkWkxYSVJmSXNMS2p4QUNOR01pUldx?=
 =?utf-8?B?MzUxaVcxMHlkUDd6eWhKMHYvR0xqdUYwc1dJQllwaTZuUStlb1hnaG8zVE1u?=
 =?utf-8?B?aVpQOVdkZFd6M2ppcE9IeDd3WTUwT0N6NlpwVjd2UW9UdlNTc2tKeCt0anJS?=
 =?utf-8?B?R2xYN2s5U2s4Q21ucjlZa2Rsd2NjTXJwVjFJeDViNmdpZGFsQ3dTQ1B4TTRK?=
 =?utf-8?B?YWxEVzJVQm5ZNUJPNlpsbmZaTllpMjhQeXNVZzAyZzN1Q0JJMFJNbElBYWJH?=
 =?utf-8?B?SDUwVjl6R0pNUmJZQ1lLbzRjZGpSQmtqN2FabWU0eFg4SFlkang0WURZV0JE?=
 =?utf-8?B?UzZKQXdTeTdtNlc2aXNYZktoTWlZMVRidzJEK0pPOXk3UGpkK0ZhUmNWQjhj?=
 =?utf-8?B?SzRaUVpHNkh3bUY2SFpqQUVTOTdkNGdjTnc5RnQ2bTIwbG9TdE8vSkcxZHJv?=
 =?utf-8?B?aXhKa0RFWE85bG9IaGJ2ekVTK2F1TW5OeDNMQURSeVd3S2NGNjdXZFVQK2da?=
 =?utf-8?B?YUNFZTFkZGxOUkFISVJuUFBnQlphaDMwSGFGSHM3azFOa2Y4c3Q1dGNkRmsw?=
 =?utf-8?B?MzZ0emRwK1hhNzRQRlBkcDRrUExCTitUaHZOMTNCeENsTWI3M1luVCt6dHNw?=
 =?utf-8?B?K3VRdzUyWjdEY0h4NHpLNzB5bmZHZDR1RGI3Sm1hdEJFR0VhRWFBcTdEMmRE?=
 =?utf-8?B?NndLR3BRUEJwWUhBak1FYm5lc05LVFBuR2VtQ2g1SXpkbExBTzVlTUFsRE9v?=
 =?utf-8?B?djB0cTI0QnFDZWh6U3Q1WkF2eURJSFNIYXoyMWFlOGMrQjlidjNMNnljbDhT?=
 =?utf-8?B?MDhvT3hzTjl3VWdOVzEzNUJyVC9YeSt0R3pIaXYrcnhGSFJxTmxqeUsrTUFh?=
 =?utf-8?B?VDJicDVxbmhXczE1NkhHUTFFSDgrVW8yTWoxZTRWMWZkUnBDRlNGajdhaWE4?=
 =?utf-8?B?NjlBUTNvT3luZU5yWStGZFBPNTY0cldXbXJqd0hLU0VxbXBGTHlKei9PMGpU?=
 =?utf-8?B?V3FLbVlYT2o3TTVCNFJHRkc2UlBMTmZUTlVneDVXYUU1aGp4SDJXdHpUbGZD?=
 =?utf-8?B?aFBsWG5ldXU5MTRwK3pPSElOdmdyYVp2RXd2QWcwbjlJMlJPL1ZxdXM0eGVv?=
 =?utf-8?B?Mk1PSEs5c0pScWdsQUZIM3o3MUFEMG1zb3VJN2w5eWVVM3hJbmR4cHZIOXA1?=
 =?utf-8?B?c21vUWtlL3M2REp5Z3NGcWYwNjkrQUpVSDVzdGF3bFlLcTBUT2pqOUh3aXRi?=
 =?utf-8?B?RzV5T1NpaVZ5STlwaE1DOXJXUHI5a3pmTEpvdWR4MERlTmRXSWlYSDhCdmJK?=
 =?utf-8?B?aVhtM3JodWRrSmVaalRBWm9hOTNNQUpaZXdmTDlzK3NHTUFkUHBzbG54Q1A3?=
 =?utf-8?B?UUVBb2FDTDd6czh4dlFmM2cwMW5xdk56amVMSW02d3pObTV3QTZ2MEpvRzFV?=
 =?utf-8?B?dFBTR3dUVS92eU1VTkduWWE0dXJOd0FwWEYrUnJkTUEwR2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUJ4RzVGemZzWlQ1WUw3SXpycWgxMThFN0NZeitJQjh3MkorV3A1T2dZN3ZR?=
 =?utf-8?B?RzYxS04xZC90cURqRlZiK1ZxY29yS05IeDE2ZERUN2NSMDk0UFR2czJua0xO?=
 =?utf-8?B?ZHpOYUd5cXJodnJiVTBSMjg2cTY0ZXZ4MFhhdzZYbld4UnlDSHUzaU0vbytu?=
 =?utf-8?B?UkRXcmgxYzl4M1BRVmppeW1GQSsxSmZ4MVVJclVFVGhPYm8wY3YvQU9JQXAz?=
 =?utf-8?B?ZUlyYlMzeGZ2QVIybEhvNU93VTE3Z012WS9mSXZVcFhTbGlkWVlVVjA0SXJ6?=
 =?utf-8?B?K1hlM1hqbHlOVVhwSHVkMm8vV1h6cVA2RmhlZVVUYVlrV0xUZFVoNEFScVVq?=
 =?utf-8?B?c0lwejNrcFFVYmhCbXNjS2NKclZLaktqMjQyUnI1eDJxSDVZNjFGTVlpc1hz?=
 =?utf-8?B?YnFYbmc5V3pHbTFGQzJMNGFBUEZHMHBETUhkWkxOYkRnbHBOTEg3cHZYVHZH?=
 =?utf-8?B?MWpsd0VjNU9qQkt1TlBhaDFUQ2NLdTJPSFNRUjdMRk5SMExyRkpReVlpTWFw?=
 =?utf-8?B?UmVOUHVYaThZNDhXSXhWVFQwKyt0MWh1bFV0Wmh3MTcxRXhzVnBMb1lEVFM1?=
 =?utf-8?B?aEE0cEVYQVpnNFp3Z2V4YUpsKzRmczRQc0tqUFlUVGY1c2NINnpRa0VNOFlm?=
 =?utf-8?B?SlpNU3BTcHNnaTVGelI2b2J4SFpmdGxIbXdmVHRuL01qTWNRVFBXcTIxbU5T?=
 =?utf-8?B?T0tscHduTm1hUXo1QlBiK0hKUHR5aWFYOWFkL1RSK21TWnZjK29mTDIvWC9y?=
 =?utf-8?B?UGZVeTRJWlVBWFlXUHJxZjBKS3ZaOE9Ob3I4WWVvRUhVTWRNblJaTVphbzV3?=
 =?utf-8?B?d3ZvSjlsZE1aR2wvci9sazdOc2x6b2FhQnpBdHhFVnVXajlJNmtkYjRpNkV2?=
 =?utf-8?B?M2tUNnpDZzVyNSthREVoNGFYUDFlV3lOaW1JY2M1aEpiSmNEN3kxL1BkT1Ex?=
 =?utf-8?B?b2FpbDhaS0IvRmY3R244eTVtYzNnZkUzQ3dOcFhCdnFSU1RkbllJaWZpMVQ4?=
 =?utf-8?B?djdQUDBIRm1oNll6RHBLTjZqT2RqdFBtZnl4K0NRTkJLWmwxYVZSU05HRWpv?=
 =?utf-8?B?RFpvODdsald3WFV4NUJPeG5EZTlaMDg1NFNLUy9JVW44dkZHTnkrZWt1Vmxz?=
 =?utf-8?B?T2MwQ0ZLNmhjaklxRUtEcjBMNFhZV0pvS1RKcFdxQnNBUWRiWlpQUC9hR2N0?=
 =?utf-8?B?enNZWGtqQUFsa3NMN0F6U3JXZWNlQXVkYnZCQVREWUtXVkE5SXplZSs3N0Rp?=
 =?utf-8?B?N0F6azhKTVNVYjdyYVQ1cUpETElMZjBFSVIxaTVyRFFVcEFRVi9pY1h3NnRm?=
 =?utf-8?B?L1ppK1FybWtaMzJOaHlSWThTaWRHT2tKSTRCTWFIUFYydFFodXl1MzRDdGN3?=
 =?utf-8?B?dm9XRGZ6YVp0V0dxanVHeU9yR21KMVIxWk5jN1VweHVLMjJxZXJWd1VzVFlo?=
 =?utf-8?B?RDdzVHVoZU5yd2haa3hBRU5aSk01cDRQa1A5cmY5T3FrSUhtRUg0djhuR2p3?=
 =?utf-8?B?dmN1NDVzNlNlc1VvOUVMRHNUN3c5RElmV2dZa09oTk1UQ21oQ2NyRUVQOFJr?=
 =?utf-8?B?TTNJd09mRVZUTFUyV2R4L2RkMWppYXRGN3Mybmtua042M3YyeHBWWmduS0Mw?=
 =?utf-8?B?MWpQd2RkQytWNE41WGVLc0NlZ1ZEOVA0eWYxQ3pxdHZXdjZQQ1IyVng3TFln?=
 =?utf-8?B?aWRzbjN3QlJiL3dSZGhsUDRYazJSVzdOT3ZhWVFuRFNnVFlMWU9obmw2TE5S?=
 =?utf-8?B?TzJZM3Y0Y2xLeE1XVFlpMUt5ZkQySFlucDUyUlc0WDliazVZejRvMzBXWG9N?=
 =?utf-8?B?U0Y3SzZKYTR4MkZNcWFhTXMvdVpsWkVlRmNBa3ZWN0dWTnVCaXg5S05Lakhu?=
 =?utf-8?B?a0w3MHU4UjBTRS9QaDhCNjhoVlpTbjBWYloweEd6V2llYnJaM0NxUk9YdXB6?=
 =?utf-8?B?NU9rN0d2ZlRDQU5xa0VDNXE0MUwwY0hTc2hLVmVhNTNNcnBxQUZYZmd3MWRI?=
 =?utf-8?B?bGFPMmI0MzFLMUNJNDRBTWxta3hLclRSSi9aZ05KT0Rab0pwVzNwVVM5VTAy?=
 =?utf-8?B?ZFg0QTJ4TGk0bHVkK0V3NWlrQ0pIQ2lIRm1oN1BVclNIdVBDcXMydHhscXJJ?=
 =?utf-8?Q?QSxm3Xy453Sv7QXhc7abBMr4b?=
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
	BHXdZg95w9dIZLSPZJq6tWdU+9ZVF/YThCo7IJOD6M80T0r3my+Cce5TsOt3rW9inv4HWW+tZrZa21cfB3ys52S3/5sNlEpdiMTbK5o16xsrEmX8GAjnWiE8ZUFanPI4HzIOSSfzeAjTUtSP3WcStfGVl+7j2Tf8/zmb/OcOCASTpc3x0H0w13cv+GmAry7PmajIjI+1oYHx/xmqYwmRqGjrOgGLy0SLCTvqwI1usKUJuYEcEV4NK5wDQDtUmHYm+NI24kEBBPgFoYxm0bw1hrw358TO1GIMbXibPRPQ3QYILtd8xfAw5AazK2x3lxhL+THcs68aL6hOIJkf6DwPXR0fEPXR2trN8jUtlavjX4wXXfyro6Dasnlec/Ei8JqDx3iFyy4z8o6uNvLNbo05er94s0S/B/QNWAVQOVdjgLmU8HMiwwfjKt/sAIBUy6/TXhSK69eLqulo+J/rItOVbaNMlpOQEV57rQWCVmtb0G2I25MoLNCwnO+7TSCL6f9F3vzq5wQN2GlckrqWiGHw/Uy7UFzJvxCiPWQN7UGtLgsqOWdp3081+ekWud3CZaLJugkyHJjQ0jJUgrWfHOBPtX3jehAq82+njNW0RIqsQFIQevUzWErPhPa+SXSCRBC3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93559b05-ef80-44d2-f517-08dcc59e54b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 07:11:39.6025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKK4/YEn41k8APrpeEl/qRmkVsq5aF+TFtTq3TP4qhea3CUc/N0GlUjpvP7epLBNEBkd4W7s+So2nNqS3tJ3Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6864

PiBPbiAyNi8wOC8yNCAwODozMiwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4+IEluIGEgbXVsdGkt
YmxvY2sgZGF0YSB0cmFuc2ZlciwgQ01EMjMgc2hhbGwgcHJlY2VkZSBDTUQyMi4gUHJlcGFyZQ0K
PiA+PiBDTUQyMiBpbiBhZHZhbmNlIGFzIGFuIGFkZGl0aW9uYWwgZXh0ZW5zaW9uIG9mIHRoZSBt
cnEsIHRvIGJlIGhhbmRsZQ0KPiA+PiBieSB0aGUgaG9zdCBvbmNlIENNRDIzIGlzIGRvbmUuDQo+
ID4gSSBhbSBmbG91bmRlcmluZyBhYm91dCB0aGUgY2xvc2UtZW5kZWQgcGFydCBvZiB0aGlzIHNl
cmllcy4NCj4gPiBNeSBtYWluIGNvbmNlcm4gaXMgYW4gYW1pZCBzdHJlYW0gb2YgZml4ZXMgJiBx
dWlya3Mgb2YgYm9ndXMgaHcsIHRoYXQNCj4gPiB0ZW5kcyB0byBhcHBseSBleHRyYSBsb2dpYyBz
cGVjaWZpY2FsbHkgYXJvdW5kIGFjbWQxMiAmIGFjbWQyMy4NCj4gPg0KPiA+IFVubGVzcyBzb21l
b25lIHRoaW5rIGl0J3MgYWJzb2x1dGVseSBuZWNlc3NhcnkgdG8gYmUgaW5jbHVkZWQsIEkgd291
bGQNCj4gPiBsaWtlIHRvIGRyb3AgcGF0Y2hlcyA0LCA1LCBhbmQgNi4NCj4gPiBXaGF0IGRvIHlv
dSB0aGluaz8NCj4gDQo+IFdoYXQgYXJlIHRoZSBkb3duc2lkZXMgdG8gc3VwcG9ydGluZyBvcGVu
LWVuZGVkIG9ubHk/DQpJIGd1ZXNzIGFsbCB0aGUgcmVhc29ucyBmb3IgaW52ZW50aW5nIGNsb3Nl
LWVuZGVkIGluIHRoZSBmaXJzdCBwbGFjZS4uLg0KU3RpbGwsIGl0IGNvdWxkIGJlIGFkZGVkIGxh
dGVyLCBzaG91bGQgdGhvc2UgY2FyZHMgYmVjb21lIHViaXF1aXRvdXMsIGlmIGFueS4NCg0KVGhh
bmtzLA0KQXZyaQ0KPiANCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBBdnJpDQo+ID4NCj4gPj4NCj4g
Pj4gVGVzdGVkLWJ5OiBSaWNreSBXVSA8cmlja3lfd3VAcmVhbHRlay5jb20+DQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KPiA+PiAtLS0NCj4g
Pj4gIGRyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyB8ICA3ICsrKysrKysgIGRyaXZlcnMvbW1jL2Nv
cmUvY29yZS5jICB8IDE4DQo+ID4+ICsrKysrKysrKysrKysrKysrKyBkcml2ZXJzL21tYy9jb3Jl
L3F1ZXVlLmggfCAgMSArDQo+ID4+IGluY2x1ZGUvbGludXgvbW1jL2NvcmUuaCB8ICAxICsNCj4g
Pj4gIDQgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5j
DQo+ID4+IGluZGV4DQo+ID4+IDg4MTZiM2YwYTMxMi4uNzAyMGE1NjhmYjc5IDEwMDY0NA0KPiA+
PiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4gPj4gKysrIGIvZHJpdmVycy9tbWMv
Y29yZS9ibG9jay5jDQo+ID4+IEBAIC0xNzEzLDYgKzE3MTMsMTMgQEAgc3RhdGljIHZvaWQgbW1j
X2Jsa19yd19ycV9wcmVwKHN0cnVjdA0KPiA+PiBtbWNfcXVldWVfcmVxICptcXJxLA0KPiA+PiAg
ICAgICAgICAgICAgICAgICAgICAoZG9fZGF0YV90YWcgPyAoMSA8PCAyOSkgOiAwKTsNCj4gPj4g
ICAgICAgICAgICAgIGJycS0+c2JjLmZsYWdzID0gTU1DX1JTUF9SMSB8IE1NQ19DTURfQUM7DQo+
ID4+ICAgICAgICAgICAgICBicnEtPm1ycS5zYmMgPSAmYnJxLT5zYmM7DQo+ID4+ICsNCj4gPj4g
KyAgICAgICAgICAgIGlmIChtbWNfY2FyZF91bHRfY2FwYWNpdHkoY2FyZCkpIHsNCj4gPj4gKyAg
ICAgICAgICAgICAgICAgICAgYnJxLT5leHQub3Bjb2RlID0gU0RfQUREUl9FWFQ7DQo+ID4+ICsg
ICAgICAgICAgICAgICAgICAgIGJycS0+ZXh0LmFyZyA9ICh1MzIpKChibGtfcnFfcG9zKHJlcSkg
Pj4gMzIpICYgMHgzRik7DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgIGJycS0+ZXh0LmZsYWdz
ID0gTU1DX1JTUF9SMSB8IE1NQ19DTURfQUM7DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgIGJy
cS0+bXJxLmV4dCA9ICZicnEtPmV4dDsNCj4gPj4gKyAgICAgICAgICAgIH0NCj4gPj4gICAgICB9
IGVsc2UgaWYgKG1tY19jYXJkX3VsdF9jYXBhY2l0eShjYXJkKSkgew0KPiA+PiAgICAgICAgICAg
ICAgbW1jX2Jsa193YWl0X2Zvcl9pZGxlKG1xLCBjYXJkLT5ob3N0KTsNCj4gPj4gICAgICAgICAg
ICAgIG1tY19zZW5kX2V4dF9hZGRyKGNhcmQtPmhvc3QsIGJsa19ycV9wb3MocmVxKSk7IGRpZmYN
Cj4gPj4gLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYyBiL2RyaXZlcnMvbW1jL2NvcmUv
Y29yZS5jIGluZGV4DQo+ID4+IGQ2YzgxOWRkNjhlZC4uNDgwOGU0MmQ3ODU1IDEwMDY0NA0KPiA+
PiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL21tYy9j
b3JlL2NvcmUuYw0KPiA+PiBAQCAtMTg0LDYgKzE4NCwxNCBAQCB2b2lkIG1tY19yZXF1ZXN0X2Rv
bmUoc3RydWN0IG1tY19ob3N0DQo+ICpob3N0LA0KPiA+PiBzdHJ1Y3QgbW1jX3JlcXVlc3QgKm1y
cSkNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtcnEtPnNiYy0+cmVzcFsyXSwg
bXJxLT5zYmMtPnJlc3BbM10pOw0KPiA+PiAgICAgICAgICAgICAgfQ0KPiA+Pg0KPiA+PiArICAg
ICAgICAgICAgaWYgKG1ycS0+ZXh0KSB7DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgIHByX2Rl
YnVnKCIlczogcmVxIGRvbmUgPENNRCV1PjogJWQ6ICUwOHggJTA4eA0KPiA+PiAlMDh4ICUwOHhc
biIsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1tY19ob3N0bmFtZShob3N0
KSwgbXJxLT5leHQtPm9wY29kZSwNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bXJxLT5leHQtPmVycm9yLA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtcnEt
PmV4dC0+cmVzcFswXSwgbXJxLT5leHQtPnJlc3BbMV0sDQo+ID4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG1ycS0+ZXh0LT5yZXNwWzJdLCBtcnEtPmV4dC0+cmVzcFszXSk7DQo+ID4+
ICsgICAgICAgICAgICB9DQo+ID4+ICsNCj4gPj4gICAgICAgICAgICAgIHByX2RlYnVnKCIlczog
cmVxIGRvbmUgKENNRCV1KTogJWQ6ICUwOHggJTA4eCAlMDh4DQo+ID4+ICUwOHhcbiIsDQo+ID4+
ICAgICAgICAgICAgICAgICAgICAgIG1tY19ob3N0bmFtZShob3N0KSwgY21kLT5vcGNvZGUsIGVy
ciwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgY21kLT5yZXNwWzBdLCBjbWQtPnJlc3BbMV0s
IEBAIC0yNzAsNiArMjc4LDEyIEBADQo+ID4+IHN0YXRpYyB2b2lkIG1tY19tcnFfcHJfZGVidWco
c3RydWN0IG1tY19ob3N0ICpob3N0LCBzdHJ1Y3QNCj4gPj4gbW1jX3JlcXVlc3QgKm1ycSwNCj4g
Pj4gICAgICAgICAgICAgICAgICAgICAgIG1ycS0+c2JjLT5hcmcsIG1ycS0+c2JjLT5mbGFncyk7
DQo+ID4+ICAgICAgfQ0KPiA+Pg0KPiA+PiArICAgIGlmIChtcnEtPmV4dCkgew0KPiA+PiArICAg
ICAgICAgICAgcHJfZGVidWcoIjwlczogc3RhcnRpbmcgQ01EJXUgYXJnICUwOHggZmxhZ3MgJTA4
eD5cbiIsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICBtbWNfaG9zdG5hbWUoaG9zdCksIG1y
cS0+ZXh0LT5vcGNvZGUsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICBtcnEtPmV4dC0+YXJn
LCBtcnEtPmV4dC0+ZmxhZ3MpOw0KPiA+PiArICAgIH0NCj4gPj4gKw0KPiA+PiAgICAgIGlmICht
cnEtPmNtZCkgew0KPiA+PiAgICAgICAgICAgICAgcHJfZGVidWcoIiVzOiBzdGFydGluZyAlc0NN
RCV1IGFyZyAlMDh4IGZsYWdzICUwOHhcbiIsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICBt
bWNfaG9zdG5hbWUoaG9zdCksIGNxZSA/ICJDUUUgZGlyZWN0ICIgOiAiIiwNCj4gPj4gQEAgLQ0K
PiA+PiAzMDksNiArMzIzLDEwIEBAIHN0YXRpYyBpbnQgbW1jX21ycV9wcmVwKHN0cnVjdCBtbWNf
aG9zdCAqaG9zdCwNCj4gPj4gc3RydWN0IG1tY19yZXF1ZXN0ICptcnEpDQo+ID4+ICAgICAgICAg
ICAgICBtcnEtPnNiYy0+ZXJyb3IgPSAwOw0KPiA+PiAgICAgICAgICAgICAgbXJxLT5zYmMtPm1y
cSA9IG1ycTsNCj4gPj4gICAgICB9DQo+ID4+ICsgICAgaWYgKG1ycS0+ZXh0KSB7DQo+ID4+ICsg
ICAgICAgICAgICBtcnEtPmV4dC0+ZXJyb3IgPSAwOw0KPiA+PiArICAgICAgICAgICAgbXJxLT5l
eHQtPm1ycSA9IG1ycTsNCj4gPj4gKyAgICB9DQo+ID4+ICAgICAgaWYgKG1ycS0+ZGF0YSkgew0K
PiA+PiAgICAgICAgICAgICAgaWYgKG1ycS0+ZGF0YS0+Ymxrc3ogPiBob3N0LT5tYXhfYmxrX3Np
emUgfHwNCj4gPj4gICAgICAgICAgICAgICAgICBtcnEtPmRhdGEtPmJsb2NrcyA+IGhvc3QtPm1h
eF9ibGtfY291bnQgfHwgZGlmZg0KPiA+PiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvcXVldWUu
aCBiL2RyaXZlcnMvbW1jL2NvcmUvcXVldWUuaCBpbmRleA0KPiA+PiAxNDk4ODQwYTRlYTAuLjdl
MTkxZDdmMDQ2MSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9xdWV1ZS5oDQo+
ID4+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvcXVldWUuaA0KPiA+PiBAQCAtNDAsNiArNDAsNyBA
QCBzdHJ1Y3QgbW1jX2Jsa19pb2NfZGF0YTsgIHN0cnVjdCBtbWNfYmxrX3JlcXVlc3Qgew0KPiA+
PiAgICAgIHN0cnVjdCBtbWNfcmVxdWVzdCAgICAgIG1ycTsNCj4gPj4gICAgICBzdHJ1Y3QgbW1j
X2NvbW1hbmQgICAgICBzYmM7DQo+ID4+ICsgICAgc3RydWN0IG1tY19jb21tYW5kICAgICAgZXh0
Ow0KPiA+PiAgICAgIHN0cnVjdCBtbWNfY29tbWFuZCAgICAgIGNtZDsNCj4gPj4gICAgICBzdHJ1
Y3QgbW1jX2NvbW1hbmQgICAgICBzdG9wOw0KPiA+PiAgICAgIHN0cnVjdCBtbWNfZGF0YSAgICAg
ICAgIGRhdGE7DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tYy9jb3JlLmggYi9p
bmNsdWRlL2xpbnV4L21tYy9jb3JlLmgNCj4gPj4gaW5kZXgNCj4gPj4gMmM3OTI4YTUwOTA3Li41
NTYwZTcwY2I4ZDQgMTAwNjQ0DQo+ID4+IC0tLSBhL2luY2x1ZGUvbGludXgvbW1jL2NvcmUuaA0K
PiA+PiArKysgYi9pbmNsdWRlL2xpbnV4L21tYy9jb3JlLmgNCj4gPj4gQEAgLTE0Miw2ICsxNDIs
NyBAQCBzdHJ1Y3QgbW1jX2RhdGEgeyAgc3RydWN0IG1tY19ob3N0OyAgc3RydWN0DQo+ID4+IG1t
Y19yZXF1ZXN0IHsNCj4gPj4gICAgICBzdHJ1Y3QgbW1jX2NvbW1hbmQgICAgICAqc2JjOyAgICAg
ICAgICAgLyogU0VUX0JMT0NLX0NPVU5UIGZvcg0KPiA+PiBtdWx0aWJsb2NrICovDQo+ID4+ICsg
ICAgc3RydWN0IG1tY19jb21tYW5kICAgICAgKmV4dDsgICAgICAgICAgIC8qIFNEX0FERFJfRVhU
IGZvciBTRFVDICovDQo+ID4+ICAgICAgc3RydWN0IG1tY19jb21tYW5kICAgICAgKmNtZDsNCj4g
Pj4gICAgICBzdHJ1Y3QgbW1jX2RhdGEgICAgICAgICAqZGF0YTsNCj4gPj4gICAgICBzdHJ1Y3Qg
bW1jX2NvbW1hbmQgICAgICAqc3RvcDsNCj4gPj4gLS0NCj4gPj4gMi4yNS4xDQo+ID4NCg0K
