Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793945833;
	b=Jf4JH5wy7JNRGG/XFP2YCO3qmEtEJVPA8+JUnY/bYnA2Q9BmGLgI77fWXj2bP1cv1YmV
	 UeJS1XQvySqTY8UL5mjhxJazPK31M0kEstwsDLDPGZTGHebsNXMECXBUGhctk/rGavH2V
	 KQPRuNrowifgGSSkQl/m+ToX08lTAGZgHuLkg87LYjjuUJwl5LZOkzGtLWrJM0CM4Z1ke
	 vqPkzw7xkbwjlTRl4nrTQPo8xw9ZBjcdtKCCw6QP8z2m92eWxZFde25TbGo6QnJwfYoCa
	 17p9ehOJY9sGjCB6ItN8ikc2NhdTZ2TGe7E4fCkbw/nInBDNSK0P45kAl2apz9w+/qA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945833;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=f0X8uT4kDSHertddXJ8btm/b/CTzxHYjG/LWt4e9ksQ=;
	b=V/7e1bHfUY9RLVY71KHF/zF9F0BOQ8q8030CISRJtazURLlwwv5Zdmz5H9HZpwOC2DNL
	 ITUXuOexxtRGV9fRNUPKqSCBejlyuwASFM2tZMUat2vvJ0hvtijDtYZmzM8qFAfCKLhZR
	 eFqZ+eDHgsWVPGrnr7iuAOI9Klvvu1hH3jes8qy+V18//agfXWc1Ri28HBqm/xxC8k1TM
	 V0flGEG8vGDLpeFGEC8M/SBqBum2DpPHxg9apZk0e9VlyMvmBLxIllwS7btsNjw5it1nR
	 UzXN3iTZw4b33SDuHoKsl+rDnIdDwg6HArhU/AUBFR40oYzVmy0hktSVlU807NGLqog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=oXa6wzCi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.61
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B5606A32F;
	Fri,  6 Nov 2026 06:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A39B5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=oXa6wzCi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaOBNaQSoSMmNMx6Xy4t6UIVLTe/w3BiDnzx+YUjF++wBqEpC8au4Fq/nfgXngh1lIxW1r262FAKCaj8bPY2hyE7YqrBVcaL9bGwmywe6yagwJ4qG9BUI46NtAgLLrTn1cqS1867VauXtFZcLvsVFVUgZ3ceTNus7nhYYkxGN5U+fWtuSzjdIwfc8ViaJDCsFUi+gBODtKXSwsE8VBNR+eVy/as36AwNhxA3EzWRFUE2HngWYzy6ySkQbGwkJllgOL8BygHQ4IjnM27Q/CV0OtGJeOeosq/mad47RuYS70iXM4Yq24hzPoytrUT3xg7EUOJxWdkGd6h9BRs0fPt5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0X8uT4kDSHertddXJ8btm/b/CTzxHYjG/LWt4e9ksQ=;
 b=fyFGJRxYqwNhWc1+l4RpHsuTLWOOOX7xZ0e8Yoy52j9/9IrI34Bb0vByybJMTGwMILRx56ebVTIcwwKK1yTYkUZu7RSGeee05ki2925fE6x5qeMI62GZlNt37zYVe0B8rTX30vcC0uLejgAVJS8PQ9gyF65X1PGg/MDAcA2q2OdwWFhGTfCh9XHb8Fl2JIV4TKrbZM/FaDCb5/kI8pKALtMMJfmlzYfIGz55SWXh0IRabmBrN7HfJzCDqOoP/mQ9UiFlur8JjSnFYkHTLWD6OmYAFkiPrqku6NALxr5kjCdT2MnpfZeL6xh/BZKj3TX+j01QZEN26Otnf30eCb57WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0X8uT4kDSHertddXJ8btm/b/CTzxHYjG/LWt4e9ksQ=;
 b=oXa6wzCibN9HFPYWLalpkARydl1LZ1A1fpW9QGwiZ7kp5WYtsNIP+X+3qe221DJ+nInfhZ5Br/Kj7dLlJS5kpAbOsEnLOscc6W5yLhntcR3znDWa6ePQPZzXXTmCTpwsMqo7jqXsAf08qAWpyR2ZriaCRrF0YuPDOx9xLpUUaoj/EFUv8qAhupe5866DkK4OzijIwcNRT0ix5nvLEdDI/EdKok24cagtdfs6MMlJVNLCNBQa2aIhfgwosoNsdcMmz25UPJqDAqYJLK5sqjZTJldd9I/QaXRvYeX8H6vSnUAd6ZPY2FljOTx7VfGnLvbngFw2gHaxdK9f0CAgLFv2LQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by EA8PPF1471CA897.namprd03.prod.outlook.com (2603:10b6:30f:fff5::845) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 06:17:08 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 06:17:08 +0000
From: tze.yee.ng@altera.com
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v3 3/4] dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50 read-path tuning
Date: Fri,  6 Nov 2026 14:16:54 +0800
Message-ID: <20261106-sd_cadence_ddr50_v3-v3-3-cb50afece614@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|EA8PPF1471CA897:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a465612-46ae-45bb-4c24-08df3bcd9626
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261026121527099003|261026140227099003|11063799006|10067099003|261102123227099003|55112099003|22082099003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	uPVvRkCNykR8pNn4jkNFQfh5Xmd6taHXeJijdjPGDRl9ev2Eg0/G/bg+PJZjvH0Y7hzkkOHK7g5ht98L/v4DZEy6wzoHZlU5y1M+p3vfATAHgIxnMZkPSLFbbnxShkIP2fJYxPnPuNu3DaxV4ylXAyQQPJimyh7plHwHs5B3a9yvihV7ad/ZowhehXegCt1Rj92Sc++CYIY9O+U/xPGUxv+OEQHvqXkGxKF1bW/7UJxxIMt9X5jloiRPUOCtCp0P7G78SyyKJGH5nffbHWQtncH60uQZ3uG7lknhweWrXqQAyPnAHgM8asOHpWIqX8ZDFwq5Rccwlqy+yOP/ywwivZ/X/RDjX3HKtsXhrrd0M2/hnnMlfgagyU+H1OSAPL8tG0IQTrZweiRLPKC0KpTyqnqC8ryV32OMhEp9Dq2qoOqJnInrlg6FNFuPftMBnjXoq/viw2hqaL4LdTG6mj50FgapcizTKdfvvA1urz6HjmiROblx8u/VdnhA7dGrn7E9X2tPbsUIUOOF5k8lgY2f7rQexHn0eh369kiqhKqNrt09iOHEPSQG0/PzOHAlwAmWrYjJaFU6HpYiCiT7ssnp5FLqyKi6sn9QwXIfJ3eSn6ONbTAhoU6sWHTUlnuwddpNc0QoPSdAfLDv0zrW9KBkwFgEGWS6oWGHYGuEG9AKhow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003)(11063799006)(10067099003)(261102123227099003)(55112099003)(22082099003)(3023799007)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFNZRFpMUDN0cHN2d2txQ1NuYysrU1ZUeXBra1VBNnRFUFVxVlBpZ1NwaDBG?=
 =?utf-8?B?eWhrU0t6aEUraTlNOHJxSDF5SytpZ29qeStkLys2S0hzeVBDcmdHWGpsNHEw?=
 =?utf-8?B?cmQ2cmpKVG0wcWJ5Y1BzVXJqNHNkYk4rZGFSTkNqSDIwSWVoK1NTczRxczhl?=
 =?utf-8?B?bmo4eGpSRks5Q2orYStRVE9Sb0FIb2F0WWlhTTR2ejhSaXphTW8yemFGUEtZ?=
 =?utf-8?B?TWJDWWdyWHNNNGVTU0YyZVVRUHJ1eU9JVkZPNmtMcXpJZVQ1c0Z6dDV3WW9r?=
 =?utf-8?B?WlFKSFA5R1djVXBBcllKWTlmTWxUcUsvUEVTN3RMbk4vVkxoK28xOW1ndGhB?=
 =?utf-8?B?RlhhallxbDRVMVord0dlWmlsUlVhcEZaNzRkZzV2RCtnM0FHY2JiY1hBR2pC?=
 =?utf-8?B?b3hDTGxML2tSTnNCa1A1SlJCSnV0czFhNURiQmo5M0pka1ZZdUY3eEE3MjVC?=
 =?utf-8?B?cW82TWFlSHF0SzhiTkpnOEJJZ25DUDBST2NRZGd3WGp6UXRMQlRLeXgybjlB?=
 =?utf-8?B?M3R2RUJwQkZEYjdJcmN4Q2cwdHBMb0tXUTdoUzRFN1AybjNmaE5CTG80WGUz?=
 =?utf-8?B?cHdHRU5XTm5KZVptR2ZMVzNZQmpJb1RoZDhiN0VENjUzOU8rS1JVTE96QWYr?=
 =?utf-8?B?MWFXT1BOM3JuRUtqOTlVeDdBZ00zL3lXWnBsZ0xTRlZFNC80UU9jeEwvamR0?=
 =?utf-8?B?SFE3ZDlEMU8rT05QT0NqUmFnY2ZERHh2Ukw4TFAwV3dsUExCYzBmZ09FcXds?=
 =?utf-8?B?QTNNYUFJS01YT0tyTFNKQnhrL1VQOGRiN21uclVlQTRUNWRTb01rRno1QTB4?=
 =?utf-8?B?Mmp6T3BGWGtXR0x2cndJOGRyWGVnTU5HRGp0VTBEU1EyWk80VzcrOWxvb0FE?=
 =?utf-8?B?RmplSFZvcEp6QkhEeHdpVUVJRzFObGZTU1IzWXM5eUIzbUIvdXpCVmdaRDFO?=
 =?utf-8?B?SmpaL1BiUkJXSllMR0JiR0s5YXJsZDJkZ1NhNWNHQm5OVW9vU3FZaGdhbjVH?=
 =?utf-8?B?eWhlbUJzR1ZQU0h0MmFIbjRSSmNPcXRCSXpTTmdWSkFab1hrUmJ3c1NwR3FW?=
 =?utf-8?B?UFVnVCtpNWlpSzNIeHlib2Nkay95TmxRTHU1Wnp6S2tYc0VCN1UvTXBGVS9J?=
 =?utf-8?B?OUJJYVR1QnpyVDYyY3lCaHk1aWx6REo2bEJCcDdYaDF6K2hBS2ZGT2xRWmhr?=
 =?utf-8?B?bWUwS0czZUI3dFFzVmM0bmtvYWpNM2wzcGIvdHhuYVhKcS9HY1daV0IxRWtl?=
 =?utf-8?B?QitPb01zOUEyWm5ubktOUml1a0Era2ZIc3F0QWVJNThlUVRvQ09zRk8xZDdD?=
 =?utf-8?B?MWpzdlQxRkpTNTVteUxRTFRCamNBVzRTNkNReFRxZjVsTXIvcUVTdnNyTHZT?=
 =?utf-8?B?Ymo2anhZdFZVWXg3ZHBVMVBVZHB0K0F1TmZvT3BlamxPYjNaS0xxS2g3c3Zn?=
 =?utf-8?B?c2JtWmNDYmRNdjVueFdBMXBhblVFQjU3VXR4NUhod3ZWUUFBK25YMlM5c0F1?=
 =?utf-8?B?cHZ0ejNtRTlqWUdPM2ZQOHpTS0Rub1VRQVVVbnR2Q2xKbG94SThtUjc0T1lL?=
 =?utf-8?B?MDZVMDRHakdHZExPc1hXNXp5Y0ljVUZyM1laa3JwTXk0MFJCTmxZRW1zRDZz?=
 =?utf-8?B?R09EQ2xtT2kyVitwbGFRQUpsdmxyZ2s4em1NVmNpQ0Y2R2Z6alE1cmxwUGVh?=
 =?utf-8?B?TGNTQVkxMzA3elVTZ3lyU2VWakd2U2hMSTJCeXc3SFN5c0g2K21xRGVxKytM?=
 =?utf-8?B?V3NoSHVRTUZQSVkvZk1CM3l4QytDSERBMllRMEhOSURZZUdsRHNiL3UxRHJG?=
 =?utf-8?B?WXZSYVlWczRROWNBcE5JOGxmZk80MzdpbVNCZGxLVDBBTEVsRldCQ1dYdm1D?=
 =?utf-8?B?aU12YWVGQlJPd2EzSzdMZ3JCeGNXZ1d1YTJBc0h6RUI5WHVRUUViNDVZbkNV?=
 =?utf-8?B?VkcxblVYZ2M3WUIySUV0Ulp3Y1J6VURvcUNqTkRkaHd5VStjVDRLVTdxU3Yw?=
 =?utf-8?B?c21SZVk3emlJQUY2ODZ6cFpOOWV0SVJVdVlybS9BdkJzajI1SXBnOEJpWDNE?=
 =?utf-8?B?NzdoSFFrc3VtbkxvRFphekxLQ0VYbDNuZ1VqYmllYnNIcDRVUk5VTlBLT0VD?=
 =?utf-8?B?TVdub1BZOVhHcUsrY3NOSlh5V09weU1LcE43ZlR5VG1sUm9NbVcxUXowdmFq?=
 =?utf-8?B?MktUUFdyQndlSHRoU3dNM2dmc3Y0VmRQVU9rN2xJa0E1eTZyM1IvVVFGKy9Q?=
 =?utf-8?B?WnJkKy8vMXRRWUovMUNQZVczVnF6ZjFSbHRtWWtSNTlsNlQ3T3ZWYndvN3lM?=
 =?utf-8?B?b2VNcGx3MVdIMytPNEJkREd1Q25nUmhDcmRiUEZEbXBSeFk0QnZWUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a465612-46ae-45bb-4c24-08df3bcd9626
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:17:08.5806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QCLYQtumK/t3DfD0v17r1JZYV4ba0kDzSE/5vXEVPSVskIYPQ/MwORV0LspIQyd5Ek1EqAEKcOVf4xJU6COrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPF1471CA897

From: Tze Yee Ng <tze.yee.ng@altera.com>

DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
static, board/SoC-characterised PHY settings. Add three optional SD6HC
properties for the extended-read DDR modes (SD DDR50 and eMMC DDR52):

  - cdns,ddr-read-dqs-delay:    read-DQS delay as a count of DLL delay
    elements (0-255), each cdns,delay-element-ps wide, that centres the
    read eye (default 0).
  - cdns,ddr-no-lpbk-dqs:       disable the loopback DQS read strobe and
    use the fabricated phony DQS instead. Loopback DQS is the recommended
    default; set this only on boards that need the phony DQS read path.
  - cdns,ddr-phony-dqs-timing:  PHY_CTRL[9:4] phony DQS assertion timing.
    The driver derives this from the RE# pulse width; this property
    overrides the computed value for boards whose flight time shifts the
    DDR data return.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v3:
- Re-expressed cdns,ddr-read-dqs-delay-ps as cdns,ddr-read-dqs-delay: a
  count of DLL delay elements (0-255, each cdns,delay-element-ps wide)
  that maps 1:1 to the 8-bit PHY field, instead of a picosecond value.
  (Krzysztof Kozlowski)
- Added $ref uint32 and maximum: 255; dropped the redundant minimum: 0.
- Used plain description: text for the three new properties.

Changes in v2:
- Retitled to "dt-bindings: mmc: cdns,sd6hc:". (Tanmay Kathpalia)
- Renamed cdns,ddr50-* -> cdns,ddr-*. (Tanmay Kathpalia)
- cdns,ddr-read-dqs-delay-ps is now in picoseconds. (Krzysztof Kozlowski)
- Replaced the read-DQS source selector with a cdns,ddr-no-lpbk-dqs
  boolean. (Krzysztof Kozlowski)
- Reworded the phony-dqs-timing text. (Krzysztof Kozlowski,
  Tanmay Kathpalia)
- Dropped the SD4HC note. (Tanmay Kathpalia)
- Scope the new properties to the extended-read DDR modes (DDR50 and
  DDR52). (Tanmay Kathpalia)
---
 .../devicetree/bindings/mmc/cdns,sd6hc.yaml        | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
index d5ea2717904b..ee6a28ef2e34 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
@@ -74,6 +74,36 @@ properties:
     maximum: 1000
     default: 24
 
+  cdns,ddr-read-dqs-delay:
+    description:
+      Read-DQS delay (DLL_SLAVE[7:0]) that centres the read eye in the
+      extended-read DDR modes (SD DDR50, eMMC DDR52), which have no CMD19
+      tuning. Expressed as a count of DLL delay elements, each element
+      cdns,delay-element-ps wide, written directly to the 8-bit hardware
+      field.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 255
+    default: 0
+
+  cdns,ddr-no-lpbk-dqs:
+    description:
+      Disable the loopback DQS read strobe and use the fabricated (phony)
+      DQS instead in the extended-read DDR modes (SD DDR50, eMMC DDR52).
+      Loopback DQS is the recommended default; set this only on boards that
+      require the phony DQS read path.
+    type: boolean
+
+  cdns,ddr-phony-dqs-timing:
+    description:
+      Phony DQS assertion timing (PHY_CTRL[9:4]) for the extended-read DDR
+      modes (SD DDR50, eMMC DDR52). The driver computes this from the RE#
+      pulse width per the Cadence PHY guide; set it only to override that
+      value on boards whose DDR data returns shifted (e.g. longer flight
+      time on modular/SoM layouts). If absent, the computed value is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0x3f
+
 required:
   - compatible
   - reg

-- 
2.43.7

