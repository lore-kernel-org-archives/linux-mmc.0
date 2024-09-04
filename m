Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E8192580
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439930; cv=fail; b=H5usGYkssfAfyrNSp2l1NRId5l/A4oj7wbkLVyquD8QFK9xniu9+YBOFPjX+ykIwvH299lnZjXMfj7w3vWvCIGblh214yX0zsjgG5uCWQx1IPruoy0xkULMp0FUypyc1Oxxx5s5DE49fKuZX/Ral9LWeHf/AX0TlafoLA5rYa9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439930; c=relaxed/simple;
	bh=5jQs7mPyFFibB+d9NRzw3DXZkuYxKv070zMO+5mJHuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HzRWX0bx9ff9iUTHUQwBwBcD7UsESKAUQH8wu2xDylLGM3SdWp2033gViloZwznyZX8IGYKJnYTq5DZnTfVrtfa9tVZkZYsRbD8Nflhycd4c9TtWmXSm4xTCClqMGjuxpCSIQMeMdCzMeuvIr4gv3rge7p7sgz63vzsBqAECmVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mRPbYpsB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0JhsryAL; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mRPbYpsB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0JhsryAL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725439928; x=1756975928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5jQs7mPyFFibB+d9NRzw3DXZkuYxKv070zMO+5mJHuM=;
  b=mRPbYpsB1QQahLsVAlxpmVhhijSQ6jOLlRwZ7l7o02dBW6WcmRJUdlZI
   tCZMNn07csqQvE2fxz2EbOKrOAa+ka7gkYXP9QAFG/mR6jG2eV5W/VT3V
   l/pBCihM8P60D6VH383NDm0p7pic/eqTaz+kRAqdoqrLCvc2OWk52Eb4r
   3wxU4bNPLlDOzkD9KycbOKecB23euD+pso0vELltr95nAXgA4ctvyD3Fo
   lB1yejYR12dwgETPgoro+Fs0QlNhXd+qSfvuvO9l0bUqUKsvfJOPji2Hx
   Qhg31KpccuYipfzrZUHAyJXcn46hvfhlkCld4akcC7qQ6yr/OK5nsWqDA
   A==;
X-CSE-ConnectionGUID: mUamXxbUQKeJCJFXcFqufA==
X-CSE-MsgGUID: tMgxo/6gSOuFh3EBm3Alug==
X-IronPort-AV: E=Sophos;i="6.10,201,1719849600"; 
   d="scan'208";a="26908010"
Received: from mail-eastusazlp17010005.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.5])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 16:52:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Szd/si6zrtY4/O9BDwXMls0bEcJUyx2dw7rfieCQ6VAB2OfpkkauzWtUGC1WaehLXZo2BMt66ZzdtwhlUpgVLUCOUsuWYOum2TIh1mQC74t/y2LEVUvaQz9NfJ3FOW/bYzeis2pp1QJWo7AphvgXHRH1vgIQ8Zeqa8YWLbZsk2QLjawGfyRNdU2LGR9GxJSZQxyPlHnjmXxarYqbGyxa41rMJfrJ7uFBb/Goy4cZDCGiQDdojUPM4rBr+WMxMHUzCCKGp0JoaNhQuAj9hh44t+BrZWEsX3KvWMoiI6lL7ZEFX7k7dniraG8EI2dPVvz8t+HzrqN4OyqhqbwD0TPv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jQs7mPyFFibB+d9NRzw3DXZkuYxKv070zMO+5mJHuM=;
 b=uZqZuTYN7pvHjg4dg4QrwwWgyGDMKq+D5H4KQodJIQ6aUcvRhtLNj6Tz9U8Wwx0nHgBdcQkbF18jk/5/Ls4LKu2nKf0C/QvesNiJUUlbHcJGh2Hvs1p0tNFOgPLexYAsjG26v4X1/ALNBXcruxkqoIxmSt+Ef/hb2xJPYJGORodb0wDHZesYXmJrxPKZPndX4MXJh+lVcFeq8xjuqVPYxqIGYSEAiDQ43YF1GeHuBgj6w+qcVw9Dbv4O9v4+mOBcYrzlTaAISOyphl2304Ls+/B6A64FJSbuIcxGNpoywLnR/ADQAW3ke7yV8+8aP9z616EciU84uJWVGtwqF2/o7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jQs7mPyFFibB+d9NRzw3DXZkuYxKv070zMO+5mJHuM=;
 b=0JhsryALKkaUIFQf56k/LnLQGELivWZrdDZ+OauwvCHnZBg+a0OGJ2YDN9vZiXJpvWVOsK9XvwWsfZKpBPvVdCe0vODpFhIpCeZYKGkYtzz9Qyezmgfc1/qJ3mBTuS6yUNyIIn4FSNGiUVuBIqo0qr7ahrbCDyw8i91iSLKUrfw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH3PR04MB8863.namprd04.prod.outlook.com (2603:10b6:610:17c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Wed, 4 Sep
 2024 08:51:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:51:58 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v5 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Topic: [PATCH v5 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Index: AQHa+HxAmR+nx/fkjE+azv7SJpSWG7JFilMAgAAxt5CAAZz2AA==
Date: Wed, 4 Sep 2024 08:51:58 +0000
Message-ID:
 <DM6PR04MB6575D8B74C3FFE15B9AA8F9AFC9C2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240827122342.3314173-1-avri.altman@wdc.com>
 <20240827122342.3314173-4-avri.altman@wdc.com>
 <8c040805-e3cf-43d3-b806-206c3147052c@intel.com>
 <DM6PR04MB657547F546A2FF09FF839176FC932@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB657547F546A2FF09FF839176FC932@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH3PR04MB8863:EE_
x-ms-office365-filtering-correlation-id: 5a777610-9f76-42a3-016b-08dcccbed634
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUcyR0FKWWhDQlBDRzRlRlJHQzZVcjdkZVVlaDVtZjFzSHVyZVQrUnk0ZzhU?=
 =?utf-8?B?KzVIZFZIQytINWJWdmp1M2xxR3BFWjJKdmZPeGhoQUxxZ2Z3SzM5Y3lWTE8y?=
 =?utf-8?B?RHlxRTBxeVg4bUZNcXl1c2NZNS9SVUFscEVMd2tSMGhNUFBlaExoU2Q0R1FO?=
 =?utf-8?B?MWxUVFltWVVHQnR6Rml0dDk3MWN2UFJ6ZU9mSXVsRk15ekpDZVVZd1VWVXIw?=
 =?utf-8?B?Tkdid2R2bnV5anpsbjByUmVBQ09kc0NuVFpoQXhxTmJKQkRqM29Id1lNc1Fv?=
 =?utf-8?B?U20zbzVOVy81Zy8vQlVOUmxEMXNMd0FxTlIzT0Fka3dPa2Q4U0RGemZlQWhT?=
 =?utf-8?B?UHpYR3VNNHNaQ1VnR2hZZkI4OUhEMDBlYWY1OUtrZWFPTldzdks3RWx0UllQ?=
 =?utf-8?B?ZVZYMVBWYlE0dWxMU2xOR1hYYy9QTXVYTEVxOUxrRUNMYnV4Y1R3N2ZOa0w3?=
 =?utf-8?B?M21Vc2FscWhIK21ObzdZVlQ3T3pJTHB6M2xBNk82NEM5eEVUNkR2UURXN3FW?=
 =?utf-8?B?Y2Y0U0k3RTJqditIZTZuVVVsTDlRR2R5Y0xsZzRQaXlBVlFpUUFUYTJlUmlV?=
 =?utf-8?B?dDkvbThHeE53RTAvMWhzWnBmNldDZ29TLzRxa3BPUDhhKzNtYTY3T1NzR2Z2?=
 =?utf-8?B?Qzg5ZmgyeGlMU01VdW9wM3A4QTJOQjh6ZnRwWlRkQ2RnalQ3RGN5NGVvcjFu?=
 =?utf-8?B?dW01akg1THk1aklLU0RrUnZMTTFJK3hPTnAvRnVlTS9mRndyNHozTTBDNm1W?=
 =?utf-8?B?bUhZc0d6V3J6RXRoWkdXNzVXUGpGbEVKNnpPdzRtcUlhWXBTWHkrdGhNSGVx?=
 =?utf-8?B?cDFkeURVZG5FZ3plVTRsUWd2bGh5ZllBcGxkL2hOMCtFOTFzMXVSMnprclV0?=
 =?utf-8?B?UnV3d1krSkxDakxnVGlIQzZManVCdUNPL0F2TVBjM3N2SGpmOXdDbitQSFBC?=
 =?utf-8?B?OFlxcGo4UW9kRmZtNHpHK3hRVENBTlZUczQ1U3BmSnVxR1RhNTVBMkI1dWFX?=
 =?utf-8?B?d3VCS0xIcy92R2xPTTBFV1FTb0g2Zmc4U2xkeDAvMFlyMEhqcThXTnRKUmRO?=
 =?utf-8?B?WDJGVjB3UTV5cW5hZ0NIYTRGU0lNOUlZSmxCTEE4dEhZKy9xUWFzRGtMS1dP?=
 =?utf-8?B?N2Y1a2pvUWlhZmc4cHZGaUhvTC9CMlpoOW9UZDNlZDg4VXRvZTRlTm1rNHZj?=
 =?utf-8?B?SUtHdGpwbmxlQndnd3AyTU4xZUNLYmw3Z1JoWUplUlh3RDlJLzRnWDIzY2px?=
 =?utf-8?B?RkNGZ01CUlVLRHk3ZnRDaW5yYmU2bGs5NjFDMHRuZDh2OFg2SS91UEdPOUJm?=
 =?utf-8?B?UkhST3UxbmJvK3RYMSt3VWNnUE5qQW1jbjUrWExDNkh1TktWMkhTTjY3NW5M?=
 =?utf-8?B?WURRL3lZWnVCVzhIUkpJaVhLNzY0bGpqZ2EwOG5XSHlnY3BEdnhYOUVWNTlC?=
 =?utf-8?B?NXRLMjhJa05nNnBpaUNaN2NWVmdTRU5MUmZiZ29FY0RjTmoyanJQU3JJdUZy?=
 =?utf-8?B?SlBMYUtFdlAvcjhtNW1VN1NNQ1pQbzVOS09wUThucmdOeFV1cmdFUXYyWmpx?=
 =?utf-8?B?QmZabVVOU2lncGxVUndMRDdVdmtnakZ1eG83S3BZSmN5SFBja0dPMHF0d1ZR?=
 =?utf-8?B?L0VRdXVVVFYzMlZuWmtUYmsrOGR5TFVhUWRYSndlRTkxQjhFWDhmREcxY0Mw?=
 =?utf-8?B?d3VOUUpjYmo4V3pJSmVrVlFGYjg1bm5tckZ2YzEvcGJiQVU5b2RqOXM3Vk55?=
 =?utf-8?B?eGI0b1Z1UmZzNU9leEFVK21ETWVIYU81L0tHeWVTcFg3emZTNDY3YUFxQnVH?=
 =?utf-8?B?R3Ara0NWS29BUFhWWVJ5WTBRV0lialc0c2N1UW1qalFadkRQejQvZUJ4MUpK?=
 =?utf-8?B?Y2NKLzZKVFMzQ2FIVEJadnI2bndLVm9EYkl1WTMycjlqNWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SU9sNldNbzgxR3JBR2s0UFBSa3oyRy8xcHV2NW11Q1pub21QS0Q2K1ZIZ2pn?=
 =?utf-8?B?WkRnZjErcDY5THRBdnJkaHFBaG1NR0tjWG55YW5XUzZWaW1RTHlaUVdQQXJ2?=
 =?utf-8?B?VVFQUGNGLzI0SzRSSmgvR1BXM2hUQXlxcUlsM0Y1dFVzRU1xTDlEemZrSE1k?=
 =?utf-8?B?R2RxdklXc3FYZ2JBcjd5WmU1M1VIMEhTR3RFbWFWSkhRVnBwdm5aSFpPMnhR?=
 =?utf-8?B?eFJDVUFjKytqYXF4aXFTaklNM3ZmNThCT0QrNFFwRU5IcERzN04zdldQanVV?=
 =?utf-8?B?NmN5cjI2TzJlTHJma1JXZS9zdE02eGdGZmxTSXYyVXYxbVkyeWhTdVVWcUg1?=
 =?utf-8?B?aFRLOTNiSzJWRFlyeDVhN28vR0szMnViNkFDdXZyUFhBYzlRNUx5djl3bEVq?=
 =?utf-8?B?V1pYWndlbHlFbVRFOGE0bFl4TEpjWGlGRFRsK0F4dlF6dXFDeFdJbDl2bTFE?=
 =?utf-8?B?dkNtaUgvT2M5MVJpTjhjdWZKdGE4WWF0ZEtNTjlqanIxdklZZFhzOHFYeWth?=
 =?utf-8?B?VkFvSmt3MnBlVlNZcU5wWUphV0xjQjd4dUVteVlvSDNIOWhDNEZvdGlabmlG?=
 =?utf-8?B?bEZYOTRkMjN6c1B5TDN2b0JnSjk0dFdoZGdacUwzOUFXTWFGSjRzQmlhUnUz?=
 =?utf-8?B?N21KQnFEbEc0Vk1NQm1NUzhUSmxtWTd0Vzd4QU85VVZ2SXFwZHFrM3hCWVUw?=
 =?utf-8?B?RHlFWE5ZMXZZd3FJNTJCWUkxcmRqS1dGM2NhZWhxa0hnd3BtQmJuRi91R0JL?=
 =?utf-8?B?QnA5N2VkaUJobUxHUHBvY3ZTRXRYaU1wSzg3S29EMzRDVFpCZVFvYStsaTR3?=
 =?utf-8?B?d3o4QVVxZTVqZVBQYUovOFpVOVhTbXN1eTFXYVdoemhSNDdtUFplK2dLTTNv?=
 =?utf-8?B?NEw2TnhEaXY2akVjOW9mNFU2TGl1R2c2M3F2NG9JcUNSUTVWbkszSnQwVDZW?=
 =?utf-8?B?UXUwUXpiWjdSSGlJUkNLaFZBMWp3REx4TWp0ZjZVWFJWUW5GakhOL2R0Vm9D?=
 =?utf-8?B?Z2lRS2haQ3ZXMEtoL0ovS2E3cytZdTdjWXp4NEFkdDZZeTFlNTkwM2tyL1pU?=
 =?utf-8?B?NGVYUGIrRnVmbDNCNEk4NnFWL3U1R1VKanEydjMybU9pRTNZN0EzVVNVYWEz?=
 =?utf-8?B?ODh1K1VpZDJtSHBid2dnK0ZTM2RCWmhJUWhsa1RGM1RTRjhsL2NJRUJ1c1F0?=
 =?utf-8?B?bzRhRHFFWmlnQk5KUFNJNVlScFFEeDVUdmlQZE5BRTRTZTRMRUhJSlp1Szd6?=
 =?utf-8?B?eHpWSnF5aHJqaHFFVjl0Y1A1TTlXdUM4STdOMVkrY1NNSkRxQ2x0NXk4cDVV?=
 =?utf-8?B?ZUgzdG52Ry9QQnlyT2pZdkFjZ1MvMXV5dURQNnM1aDNBenZKQkxCQ0RGcDAy?=
 =?utf-8?B?eEd1M0NvYlFnNDltOFFXamtKQjNGRFpuVDN3dE1lSUhPSVQ2YTF0cWRlY3Az?=
 =?utf-8?B?WEd2Z3FKN2hGb1ZBWmgxY2xZTlltejgzZWVaQ2x4UjZkYVA4bUtPN3pBZnA2?=
 =?utf-8?B?MUxIbWFVckJwN3Q1WmpwejdCcldTelpGUi9uSURLTVRMMnQxQ25UNVQ3bExF?=
 =?utf-8?B?L1p0cWd0SnNWajlRNDlmMjJyQXZUT2QreERHeEM4Zkl0TitKMldwMjdqRTND?=
 =?utf-8?B?eHRhQ3ZWM0FmYXgvblh2VDRYem4wQmNoNDhpSTdkamZrUWY0TDBQRVR0ZmxZ?=
 =?utf-8?B?RFdRb3ZwcFZvdHp4SVJCWGZBT3crQUtSd3poVG5VY0ZCM0xvb3BkQlFMNlhF?=
 =?utf-8?B?N0ZXczNjVDV6MjZIK1FZa1B3OVBVUm1hQXlJbU43WGIwbzF2ei9XYkJ1UEY4?=
 =?utf-8?B?TE9WUWMrV2dnR0VNZ0pyYW12akltcTNUZHQ2dGczKzQyQ0xkR1ZqRkIveWpK?=
 =?utf-8?B?cUE0Y3RBbWd3ZERIK0xaaFVYRmY0MjRETVdMTmpzWFIxdFZSTmtNSlp1YWNV?=
 =?utf-8?B?YjJzVnVCUTB4SEVGcXNPakt6OEtvSkJJVjNrMVhGRmxOQlNuUzQvTVpUOVMw?=
 =?utf-8?B?ZXJra1BaaE1IZDA0dnlQRHczR0NzbUN6cHQ5cDlkM2I2aUZoVDRpc1FCWUNs?=
 =?utf-8?B?ZTh1UGM5T2pHSUp3dTFndFJHTUF5UkdkK0NqZXJqYjJsZm8xUFlEWS9kd0d1?=
 =?utf-8?Q?YJzWSidrbDzuudb5vgzRT35nG?=
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
	gDl/C42i/43SwO//Q4ROFIkv8/BUcgUsllhhWKUxdfeWhuiz1NLBxee0mJ3wSY2gOP8snBwPiEhmlVVs9TdAmb6cl/kfwudN//FGTiy1eVLWglu5huBDHzBeL42mTOSdQRrK2b9VKLV2mUj5tCkGmKjmjsD2X2Jo3oDsDRcMAQnC/uaHoCefZvQHFQieUQksKIhFeWAJsnzrSZhxAJi8PH1KVNHzqDKqfVuuvWgiBfj0w+Aikp7AZh3j5ExiwMYxobvgGOK1z7WFkoCjfjjM6Y6nqAwo4qq3HAtbtYp6Xt/COvvYHD2iT0ecezgmNTs3UT2luh7xmuuHov7M3gJIkyhNGSkgrmppDA3ZD6YlEX9AcGHSNPTSgSL1Ge+d4WlOenWu8KPWdcgJkgc+WlfFy74wYJtQiwqUJSnmyUSLOggJzBV6GKexMrY6GAZJnZzk21/hi2MyPNbYhlCwS3BgOMVIHwlzsDFy4Mn9ElryQ3ICIK+bjlFxHfg/53u67lcCiZe5Men3uqH73dWcqGmgh7O7+X1eVZ9J289K34fK3bTWFwv5JXE0OLeU9ntSRjL3C/ExFSHr3dQCbN8jLF8+xtIo437s/gMyOV0bhINrkRtQ2z5Y+WTTk+TBKun0u/0z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a777610-9f76-42a3-016b-08dcccbed634
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 08:51:58.9153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zs3/aDa8UNzTkXxKagcyLRC54Mz9snXTaVGaIpi0umN90Xz33EtDk7jRayQ776IoCCw1UtUKo0iPKisKlV4FYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8863

PiA+IE9uIDI3LzA4LzI0IDE1OjIzLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiA+IEZvciBvcGVu
LWVuZGVkIHJlYWQvd3JpdGUgLSBqdXN0IHNlbmQgQ01EMjIgYmVmb3JlIGlzc3VpbmcgdGhlIGNv
bW1hbmQuDQo+ID4gPiBXaGlsZSBhdCBpdCwgbWFrZSBzdXJlIHRoYXQgdGhlIHJ3IGNvbW1hbmQg
YXJnIGlzIHByb3Blcmx5IGNhc3RpbmcNCj4gPiA+IHRoZSBsb3dlciAzMiBiaXRzLCBhcyBpdCBj
YW4gYmUgbGFyZ2VyIG5vdy4NCj4gPiA+DQo+ID4gPiBUZXN0ZWQtYnk6IFJpY2t5IFdVIDxyaWNr
eV93dUByZWFsdGVrLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEF2cmkgQWx0bWFuIDxhdnJp
LmFsdG1hbkB3ZGMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9tbWMvY29yZS9ibG9j
ay5jIHwgNiArKysrKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUv
YmxvY2suYyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiA+ID4gaW5kZXgNCj4gPiA+IDJj
OTk2MzI0OGZjYi4uODgxNmIzZjBhMzEyIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9tbWMv
Y29yZS9ibG9jay5jDQo+ID4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4gPiA+
IEBAIC0xODAsNiArMTgwLDcgQEAgc3RhdGljIHZvaWQgbW1jX2Jsa19yd19ycV9wcmVwKHN0cnVj
dA0KPiA+ID4gbW1jX3F1ZXVlX3JlcSAqbXFycSwgIHN0YXRpYyB2b2lkIG1tY19ibGtfaHNxX3Jl
cV9kb25lKHN0cnVjdA0KPiA+ID4gbW1jX3JlcXVlc3QgKm1ycSk7ICBzdGF0aWMgaW50IG1tY19z
cGlfZXJyX2NoZWNrKHN0cnVjdCBtbWNfY2FyZA0KPiA+ID4gKmNhcmQpOyAgc3RhdGljIGludCBt
bWNfYmxrX2J1c3lfY2Iodm9pZCAqY2JfZGF0YSwgYm9vbCAqYnVzeSk7DQo+ID4gPiArc3RhdGlj
IGludCBtbWNfYmxrX3dhaXRfZm9yX2lkbGUoc3RydWN0IG1tY19xdWV1ZSAqbXEsIHN0cnVjdA0K
PiA+ID4gK21tY19ob3N0ICpob3N0KTsNCj4gPiA+DQo+ID4gPiAgc3RhdGljIHN0cnVjdCBtbWNf
YmxrX2RhdGEgKm1tY19ibGtfZ2V0KHN0cnVjdCBnZW5kaXNrICpkaXNrKSAgeyBAQA0KPiA+ID4g
LTE2NjQsNyArMTY2NSw3IEBAIHN0YXRpYyB2b2lkIG1tY19ibGtfcndfcnFfcHJlcChzdHJ1Y3QN
Cj4gPiA+IG1tY19xdWV1ZV9yZXEgKm1xcnEsDQo+ID4gPg0KPiA+ID4gICAgICAgYnJxLT5tcnEu
Y21kID0gJmJycS0+Y21kOw0KPiA+ID4NCj4gPiA+IC0gICAgIGJycS0+Y21kLmFyZyA9IGJsa19y
cV9wb3MocmVxKTsNCj4gPiA+ICsgICAgIGJycS0+Y21kLmFyZyA9IGJsa19ycV9wb3MocmVxKSAm
IDB4RkZGRkZGRkY7DQo+ID4gPiAgICAgICBpZiAoIW1tY19jYXJkX2Jsb2NrYWRkcihjYXJkKSkN
Cj4gPiA+ICAgICAgICAgICAgICAgYnJxLT5jbWQuYXJnIDw8PSA5Ow0KPiA+ID4gICAgICAgYnJx
LT5jbWQuZmxhZ3MgPSBNTUNfUlNQX1NQSV9SMSB8IE1NQ19SU1BfUjEgfCBNTUNfQ01EX0FEVEM7
DQo+ID4gQEANCj4gPiA+IC0xNzEyLDYgKzE3MTMsOSBAQCBzdGF0aWMgdm9pZCBtbWNfYmxrX3J3
X3JxX3ByZXAoc3RydWN0DQo+ID4gPiBtbWNfcXVldWVfcmVxDQo+ID4gKm1xcnEsDQo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgKGRvX2RhdGFfdGFnID8gKDEgPDwgMjkpIDogMCk7DQo+ID4g
PiAgICAgICAgICAgICAgIGJycS0+c2JjLmZsYWdzID0gTU1DX1JTUF9SMSB8IE1NQ19DTURfQUM7
DQo+ID4gPiAgICAgICAgICAgICAgIGJycS0+bXJxLnNiYyA9ICZicnEtPnNiYzsNCj4gPiA+ICsg
ICAgIH0gZWxzZSBpZiAobW1jX2NhcmRfdWx0X2NhcGFjaXR5KGNhcmQpKSB7DQo+ID4gPiArICAg
ICAgICAgICAgIG1tY19ibGtfd2FpdF9mb3JfaWRsZShtcSwgY2FyZC0+aG9zdCk7DQo+ID4gPiAr
ICAgICAgICAgICAgIG1tY19zZW5kX2V4dF9hZGRyKGNhcmQtPmhvc3QsIGJsa19ycV9wb3MocmVx
KSk7DQo+ID4NCj4gPiBEaWQgeW91IGNvbnNpZGVyIGhhdmluZyBtbWNfc3RhcnRfcmVxdWVzdCgp
IHNlbmQgQ01EMjI/DQo+ID4gZS5nLg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1j
L2NvcmUvY29yZS5jIGIvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgaW5kZXgNCj4gPiBkNmM4MTlk
ZDY4ZWQuLjIyNjc3YTAxYzBlMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2Nv
cmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jDQo+ID4gQEAgLTMzNiw2ICsz
MzYsOSBAQCBpbnQgbW1jX3N0YXJ0X3JlcXVlc3Qoc3RydWN0IG1tY19ob3N0ICpob3N0LA0KPiA+
IHN0cnVjdCBtbWNfcmVxdWVzdCAqbXJxKSAgew0KPiA+ICAgICAgICAgaW50IGVycjsNCj4gPg0K
PiA+ICsgICAgICAgaWYgKG1ycS0+Y21kICYmIG1ycS0+Y21kLT5leHRfYWRkcikNCj4gPiArICAg
ICAgICAgICAgICAgbW1jX3NlbmRfZXh0X2FkZHIoY2FyZC0+aG9zdCwgbXJxLT5jbWQtPmV4dF9h
ZGRyKTsNCj4gPiArDQo+IFdpbGwgZ2l2ZSBpdCBhIHRyeS4NCkluIHRoZSBwcm9wb3NlZCBmb3Jt
LCB0aGlzIGRvZXNuJ3Qgd29yay4NCk1haW5seSBiZWNhdXNlIG1tY19zZW5kX2V4dF9hZGRyIGV2
ZW50dWFsbHkgY2FsbHMgbW1jX3N0YXJ0X3JlcXVlc3QgYnkgaXRzZWxmOg0KbW1jX3dhaXRfZm9y
X2NtZCgpIC0+IG1tY193YWl0X2Zvcl9yZXEoKSAtPiBfX21tY19zdGFydF9yZXEoKSAtPiBtbWNf
c3RhcnRfcmVxdWVzdCgpLg0KDQpBbHNvLCBzaW5jZSBuZWVkIHRvIGNhbGwgQ01EMjIgZm9yIGFu
eSBhZGRyZXNzLCBpdCBpcyBvayBtcnEtPmNtZC0+ZXh0X2FkZHIgdG8gYmUgMHgwLA0KVGhlbiBu
ZWVkIGl0IHRvIGJlIGEgbGl0dGxlIGJpdCBidWxraWVyLCAgZS5nLjoNCmJ5IGFkZGluZyBhICJj
aGVja19zZHVjIiBhcmd1bWVudCB0byBtbWNfc3RhcnRfcmVxdWVzdCwNCmlmIChtcnEtPmNtZCAm
JiBjaGVja19zZHVjKSkNCkFuZCBtYWtlIGl0IHRydWUgaW4gbW1jX2Jsa19tcV9pc3N1ZV9yd19y
cSBhbmQgbW1jX2Jsa19yZWFkX3NpbmdsZSwgZmFsc2Ugb3RoZXJ3aXNlLA0KQnV0IHRoaXMgc2Vl
bXMgdG8gYmUgYW4gaW52YWxpZCBvcHRpb24gdG8gbWUuDQoNCkFuZCB0aGVyZSBpcyB0aGF0IHRo
aW5nIG9mIGFkZGluZyBkd29yZCB0byBtbWNfY29tbWFuZC4NCg0KV2hhdCBkbyB5b3UgdGhpbms/
DQoNClRoYW5rcywNCkF2cmkNCj4gDQo+IFRoYW5rcywNCj4gQXZyaQ0KPiANCj4gPiAgICAgICAg
IGluaXRfY29tcGxldGlvbigmbXJxLT5jbWRfY29tcGxldGlvbik7DQo+ID4NCj4gPiAgICAgICAg
IG1tY19yZXR1bmVfaG9sZChob3N0KTsNCj4gPg0KPiA+ID4gICAgICAgfQ0KPiA+ID4gIH0NCj4g
PiA+DQoNCg==
