Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96AD75808;
	Tue, 11 Jun 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121769; cv=fail; b=BmvvgjD/rTY4exeMva1/57eh059bwy+9rBeZ+CRiMf6CGPwZOyTWpLWbODKc52dKwVMIWqRXEyoCmQ2tE4LGoCH4/tJKVSxXZ6+RJR/FOUOBhl90fqbhR6PObYpz9xYZp04GaEHl/mobXuh/haStrSIVTirBtZr3xzN/qSC9yUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121769; c=relaxed/simple;
	bh=7lsAWgCAXVkazk4UjcScS6/EFU4THmbMHhFdxLn+lZE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FGsADyfNXanIcMOOdB2XVuQTzJEMmUjwFgrW2VPh4A0qH/+COj4QuJp8Ly0soa7DnAptX8sBnpIecIC67KgOc4qFOyMsrhDaviJY4lJQ1a1XWKCqlrqMH1ERWhjQJiV1HInlMPYBrYCjWg6oeKtkHuvxbLdfTGvKFHWoZPIQJ9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RR1q79C1; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RR1q79C1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oidg/jYffIgO7UbQd0NHQvKUzTaKDktthmH7TUkfYJ/Pt4kmTHB7sT/u2DC1d7H8wh1hIuVBA8tKqlAPQeas9zr8HBAoysvurpM5PO8UgP9kUpLdpgEhV7zSf6RUNJx589wGEaQIUsNZVvasXxQIzNh8wu4Roa9RhPbUaqADyaen5t2HaLWpMYaFLFq6tf/BgKNiFhX+iXVwtSy2WavTvZP/7/AstadIRL+Z2hIy2/+SxuWKoY0Z2pce9X6sDCjQWkT63hPFjDZxOLowbXOOFMMVg1RAo5JfEBNKIMXQh9vVuIW5eEpo0wK4/0y7/+g5yWUlhEcETmwe3U2Glvff+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXVRxZnEOdAlG3j8+1Jo4wcWDAdpvDux3L4SIIU0ywk=;
 b=Oudtxw3m6cYcgmWXKynUBpiXZ9YN2fidvLjh4m6R5N9/I7nyda+Frj9NYC/JID2BuUCZEeErgsNBBnEQPtNmbI2ciqrR/+Vkjf5xar8MgcQ6AHn4KOm+kHjEJzJdOe4xBDv86NpfltdNg+C3EVQBIq+d9Mx1Ph+0t0be+3/p9loYIFdYWZ1XaO6zNXZj4+GVrgs4sueRgRNsrvm8pphi0Vn5ibs4QwzP747JJOtBU0tfKx+3Smy97MfQYdcH9w2H3YLI0by7FDoRpaEGPR95taZ9KvP3RFyd7EKqbhXSH2xyU/XJsds/FqKJnL52siXy3jR6TWbbLRMNam/raEBIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXVRxZnEOdAlG3j8+1Jo4wcWDAdpvDux3L4SIIU0ywk=;
 b=RR1q79C1WLMFZux10gu6wUig3/py8APisWEzAG7J7XPBDpK6j47GBS33bamf2s4boidtoDqvM23mVntUpD1FOTYHEpOuDp6dIptD1ZbOaZiqtpJhlZ/Lqj2jlCJiGaDLSNLwIR2OcVRjfSGGQJWqPoYiv23yQ6kFzJ9W9zk6N8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8005.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:02:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:02:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Jun 2024 12:01:53 -0400
Subject: [PATCH v4 8/8] arm64: dts: lx2160a: Chang node name from 'esdhc'
 to 'mmc'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-ls_waring_esdhc-v4-8-d0d8a5b3f3cb@nxp.com>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
In-Reply-To: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718121739; l=1822;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7lsAWgCAXVkazk4UjcScS6/EFU4THmbMHhFdxLn+lZE=;
 b=njwtpl8WWsCsh9AbUdPXwtcdZ/RN6B/uZ9nUyg5cGwG4S6Y+hed6a64d6FlVsDLs1UYepFSRu
 xm9yP1CkQ1DAXdgh6I4d6aCNU6W5X68cUKphywzLz5bmZncpVDP0pFD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac59ebd-abb5-4fe8-cfe2-08dc8a2fef31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUd5SVhMc3U1dnFwUjVLREtxTXpnN2xLeTNISkR0NzJreXFjUENsQXV5M3dj?=
 =?utf-8?B?M2ZFVVBONVM0RUtLK3dmQXc0Z2E4Uk9qVjBPRm5Fd3JDT2ZyY1ZDU1Rnc2pJ?=
 =?utf-8?B?VmNDZzVQVnR5WGRWZFNmbksvcys1T1ZVUUFhTWZyY1BNdURuSkd6ZU1MVTJN?=
 =?utf-8?B?bkgrRWRzL1BqL1drNnRPQ3M5TGxJcUhxUU9BY2h6MWJNRktCdTJQMU96Yng2?=
 =?utf-8?B?Z3dRVlBEOGhHSXJCb01sQUpJVS85S0hWOGhwMTlCcHpNdzJwajk3K1BBWk9l?=
 =?utf-8?B?ayswQ1VyR1VMeWMzbC94TTV3bWp2bWJyTThFcmdpZFd4aEk2YmJvOXVDK2ZQ?=
 =?utf-8?B?Z29oa2t1Wk5kWDZkRVUvVldQZGY0WEdmd3FrRmhxbzhJVEErY1RrcHhGV09y?=
 =?utf-8?B?Vmx4dS9DeFU5bTc2LzN3bXIzRWN3bVRoS3hGVjZTUW4zdzFreEc3UjdhMGNQ?=
 =?utf-8?B?U3JaSW15Z0pSRnlxZzRsdGtKSENGME9pUGpLNXRaUnZXdjVhSDlVVkswSGV0?=
 =?utf-8?B?dnZJN1dJcUdXTDc2dXBwVkxPVVpiWVM4cmZybXZYeFRDT21UdmRnRlN5OU5a?=
 =?utf-8?B?a1VzVjZ5Zmc5ZURheGpIa2lTdjBnK1NDZk51WkRtYkMvWnlWSm9qT0lUb2dh?=
 =?utf-8?B?STJjYmVwWGVrdVM3RTRITGlMa2RlWHYvK1FNYUl0OGp5cS9JUE9KS09aZWpQ?=
 =?utf-8?B?ampxRmxQc3B0TngzZXhDeGFNRDFQbHA0U1RLdzRsUnIxSktIeU0zd1RKV3pY?=
 =?utf-8?B?Sk1TQ1c1dG0zVm4wS1ZsTXNuRHlueWRobDAyQW9JSFJ0Y1ZZVGNJdTJObjh0?=
 =?utf-8?B?ME45alVvUGtvbFlmS05ZRUZ4TFJUSm53cmtzSE1EMHNobGdYKy9qYmdPMkJK?=
 =?utf-8?B?YjRCajBHTDVmZzQ3YWsrVDlVOVdHZHhxTkVXRktuM0lkeG43NUpmemttbTFB?=
 =?utf-8?B?T1hBSVovWis1ZURrUVNqMmNFRDdaY0l6VTAvTmFVRFlqSTVWbVpmOUE5OGEy?=
 =?utf-8?B?REpkcVhhdm9SWjAxZkV4RHR2M050ZkE0eWVUUzJPc3hSTUdUK0RwekdHT0VU?=
 =?utf-8?B?RCtuTXhOS2tOZHFZSkI4K0dJM1JxbDl1NEY4NHVWVllmN1A1THlibkdDbFRR?=
 =?utf-8?B?Wk1Ea3lzR1M4SStZU2tVWVpRQXE5OXpNKzdZa3hraDJ0MTJlM2dXbkdmako2?=
 =?utf-8?B?NUVEL0pHa3prdHdGaTZlZ29mdzlrTU5vNzBBSGV1WXJyQXVZVHR6NUQ2UmV5?=
 =?utf-8?B?a2tnVWFyRjJHbWpYVHdJQVduYUhXQVZKTjRudzhpMWFrOHdQcUtTS1JmWFNQ?=
 =?utf-8?B?ZkM0SUJDR3pQY1pOSzRWUEp5ZUtUNW4xMFFCcmtVM05XRkNESTlIVU9VSEVG?=
 =?utf-8?B?RkFNMWRxMWNkOU9oTXR2OVhwM2lwQ1N2LzF1SjYxL0xvWWIyMDdlc0hJNUlu?=
 =?utf-8?B?SzZuWXVOVlk1bGQvYmlHRHJSYTBvRXBVL2M4S2NUK2E2NDlsRm1OSHVrMU5T?=
 =?utf-8?B?K3l5dGc4THJsK0REV0hubmZHL21hMkh2RDVxU3BiSjFtem93NkJ1NGYxZDdD?=
 =?utf-8?B?TFM5M0ZFcGpzTEZXNk1HYS9NMnBxQ2YwOW5PTEx3MGRWOUlWTXJ0UWtFRU5k?=
 =?utf-8?B?ZFVkOU5rM3l0WEZCckZYZXZxZVZTeW85eXZkMmZzOW8xejVXMnlhaUU5Z2tw?=
 =?utf-8?B?VVJTZWg4d3VSdi9TNEkyVEw1OUM2KzY4OS80d21TdFNaYnBjWVhDandFQ2Jt?=
 =?utf-8?Q?hU1xJybPpVTl1VNmK4WAceLQNjbGUbz1x0pZvkh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmN5aHB3b3BpQVA3N1VQRVM3RURzTHFzOFozb2pnUHZmS2ozeDU1SHVMWmto?=
 =?utf-8?B?WnZLM1dsK3h5L0p2bXdZWDFUb0NiYTJHbzJ0NmExNjc4OG0vVXFZQytjdTlt?=
 =?utf-8?B?RzlYWE84ZGphTHhoR1NMWkRTbkh0RHhOZkFIbWRleitKNUIxQ1RabHpEQUpj?=
 =?utf-8?B?SjZ0Q1VuY3ZIT3dwVHpva01yQVJtcmYyTFlDbkRNcmdrT01IQjUzZ1E4VW9K?=
 =?utf-8?B?elZ4UjUvYnhOeDFEZzBQVUNLVkswUzQ0cmJJaUF3dmt5ajljNDhPdGVpc294?=
 =?utf-8?B?VmpYd2VIY2Noajd5QWFWalNwejlRakZrUnkxay81R3J3bGFndHJPSnVwaEk3?=
 =?utf-8?B?cmxmaTIxMFNmQUQyNnVkVFJDNUlnUUp4ZkFCY1p6c015b01JYWxxSTJvMFNi?=
 =?utf-8?B?UW01SnhTNUFEUUpmQ0JJWGVJOUlFMHVBYTRQMlZNUERtaEw5ZFlORmZhVjlq?=
 =?utf-8?B?UWg0UWorK2FKWUp6WndPcGRLTmxFM0YzZlZEdnJYR05YdmtRamY2Znp5WlVv?=
 =?utf-8?B?SUJJdDFzK25wQklQd1dFODF0bXRnWWZRRWNtVGtQRjY5Slc3c0pVSEZ3OEV2?=
 =?utf-8?B?elpGejgyTjhzZ2txSi9lSHdZODRzSUdMLzh2cXJSOTZweGM0N3o2VVBHSW9h?=
 =?utf-8?B?eE44V04vbG5iQkNoazBkakpWS3Baa0I5bDNMWTVxNzYwRVlOclhVWUViVDlp?=
 =?utf-8?B?QnozQ0xlQkUwQS85RlV2anVFeUNMWENzY29WaC9jQWZndGVwTWlmUTFvNFE1?=
 =?utf-8?B?YzR6eHVyeCtKT2w3Tklqc0phV0wwamsvVlhMWlJ6ZEpqbzBoMFR3ZGJFL2Nk?=
 =?utf-8?B?SkpRSWp0SzhkcE9CSkVuVHp3YS94ZXJ0WFRwV1QzTU10c2hDZXFGa0JrYW1K?=
 =?utf-8?B?aGw4YU9aUGVHemk5eTIyOEkvWUllMTR5b3pRcGlaaklFdFZaQ3FEN2RUVkFk?=
 =?utf-8?B?UmUvNjYwOEJnSnQ0L1hveTQybW84WHE5cG1HMFNveUxMNGtGKy9pSytUeTdF?=
 =?utf-8?B?MERzSEl2QWxKUWZtbFRWVERIZ3g3bFZndmtQbWx0T0ZacVl6eEVmK3A2dkIz?=
 =?utf-8?B?dzZqa0ZOVWJ0c09rNFZpd3I3ZDdTbG5NVkhuWlJMUER5RzJKTld0RDZNaEx4?=
 =?utf-8?B?UWRLUlZ2R05OMGk0UDFEMFJPR09qN3FDYVlkME1xYkx3YjhSMnlpbmZFZmJH?=
 =?utf-8?B?K3RyYWVMUnIvTW5BUnZSWWIvZitXblN4eVRIT3hlMDNkOVh1d05WZGpvOG01?=
 =?utf-8?B?ZGI1Sk1mQ3BGOFB5RHBSK1RZb1ZRUnlUemNzTkpNY2poVGQ2ODZzYnFkT0NY?=
 =?utf-8?B?bDZCalN5UkJGQ3V2WkFOdkQ4VndGZmxIOG9UYUNQNWMxaGVEYkZnWkJsdnlW?=
 =?utf-8?B?QmhRT25EM0ZpS1FJclRHNndtUGk0RWVSVkVHZ1ZycWF0U0s5N0hyUUZFaVpk?=
 =?utf-8?B?cFRvQm1XS3BUSlVlUHcrc0k3Y09aWmlPWXFQZis3TlZKYnFJdzlXN2ZGZDBh?=
 =?utf-8?B?UlRNczk2YkExMFlSZzZkMGo1emxiaVJhWGJ4WDgrNm1PdWNtMkxzZHBRSTM4?=
 =?utf-8?B?MDdOTzh2Q1VKR1kvN01VRXZYdFoyZUFTQjdhbk1PWnFpTVdjMldHV05wQkto?=
 =?utf-8?B?d3h4SGZpNHVBT01aaGRiVGpiTTR4SDNSNHZ0UUhOR2pNQXZEaEs5Um9XczZP?=
 =?utf-8?B?bENjdlI0YWxLQmc4bjlUZXdzazJsaEs1a3pSU05sbXFCZ2o5T0lUaUNKdzRy?=
 =?utf-8?B?VFVLZFVIOWhjSDNLY0FkOFFYYnpjNE1KbGNGdnBxODBZblVFQzljbmhDd1VW?=
 =?utf-8?B?ZEhpNmhNSVI5L1czZnBFdDBMT21KQm0zUjk3bi9iQ1JUWmdZd1BTNGxwODlC?=
 =?utf-8?B?akxUSGdERzVRY0dlU0IremN5QTlZZFhTMSt2VmIrNDNaaUJza2tYVnZ3dVlI?=
 =?utf-8?B?UEJTb1FHM2pSbUwwR0hXMHZCb29BQUZHYnRkaktnVVFPdncyWU44NVZHelNO?=
 =?utf-8?B?Mnh0dDZBa2gvRDloMjVGVlpmclVIQ0xEMGFZeDUvay9LcWx2MzVHdGE2OGNN?=
 =?utf-8?B?eXhkR0R0TEhONjVRWGc5NS8vT1ZpNHdxMlh2YWlDcGFJRFhHWmQ3ZEZKMW9U?=
 =?utf-8?Q?+q+NB3rWUaUdDHhnk85BtaZWs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac59ebd-abb5-4fe8-cfe2-08dc8a2fef31
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:02:46.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oujpg2x0gHXmoZig6duSeVpjgH6Tcp7Rxq9AL3WV1i/by8MdEJ8ZF6+HtjdaU92QWh/Bv/vsUsYhkCat1iYRjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8005

Use common node name 'mmc' and to add compatible string 'fsl,ls2080a-esdhc'
to fix DTB_CHECK waring.
arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
        from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 96055593204ab..742de15bbfd87 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -925,8 +925,8 @@ dspi2: spi@2120000 {
 			status = "disabled";
 		};
 
-		esdhc0: esdhc@2140000 {
-			compatible = "fsl,esdhc";
+		esdhc0: mmc@2140000 {
+			compatible = "fsl,ls2080a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
 			interrupts = <0 28 0x4>; /* Level high type */
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -939,8 +939,8 @@ esdhc0: esdhc@2140000 {
 			status = "disabled";
 		};
 
-		esdhc1: esdhc@2150000 {
-			compatible = "fsl,esdhc";
+		esdhc1: mmc@2150000 {
+			compatible = "fsl,ls2080a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2150000 0x0 0x10000>;
 			interrupts = <0 63 0x4>; /* Level high type */
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL

-- 
2.34.1

