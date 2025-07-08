Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE78238D54;
	Tue,  8 Jul 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004230; cv=fail; b=jNvL3Wse6rx5UbBdWFa7d9EGFcPh8mnzs/hCwHownVFQbkgox02KKqVfp+z/fWZSe0nAHL1jYlOcnAiBt1cw4w7+/PsjeOBkxK45xAPt3OJpKilS1CWKIh99HqP+2zhWzo0FwKqE5RbxQkGQh6SadwiOGSUjKHV7UTkFGRrxWCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004230; c=relaxed/simple;
	bh=NTlHHZV5O8k2Ay+ceVD7XJKPPTrjPq9k/l9KpaeRBUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L2mm54Igb4krjn981PMiXuX5KkTSjKYTI/ReN9Yg8CpOvcDq3TbVxez6YuS6yTm39b0VWnTNB63WpjboxUCOMK1KJVHoGRVHQtijCW+W9aSDc6071wBI9xzANd1UycOW6Yfp4K0heDB5MEQCfCVFySH2sQoFpgi2H6BE7no1nMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ppGHEVVY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yIpf/8x3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ppGHEVVY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yIpf/8x3"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568JVqWX009115;
	Tue, 8 Jul 2025 19:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WdyeHAuliq1x9mVZR6
	WrkS2tm4S+BXNvh61dMpIsIc0=; b=ppGHEVVYsbGpu6ETHE1gpenGDdnLotBQIo
	nNKDpbR1LHlwUfvB49Nb1O4X6axJS/em9PKNmqeWNV8lZ1N3C/I5SAZJQEovT/B8
	Z5ZyZMK+yPr5uShsGpRmQ0Vo19PSYzK4lh7kBV96nkhc7uyGN/R3amGjZkADehic
	Po4EEYPwJEWsG16mGOC36oMBtGLHN/QR/pmH0XmAPbjZ0NR+CGa5qtM5VAw4SspO
	4EBxk979tGTBgNsAH4FE7ZlEYqGxUt0YJqaoY9YDbl5CTGZ5LnVskuFpvIDx8adv
	RtxCWKD+QgMGgHbScm3o829jybLcPC9oKUqRapShr42GOjiJUfJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s9jhg16x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 19:50:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568IVsT1027344;
	Tue, 8 Jul 2025 19:50:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptga2615-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 19:50:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/lFAcRKCxHHeDU6NO61Zd7yGBUip8Bd0642av1RdFpRMEY8B3GjKzitigke752QrgVn/0UAfBeJASM/MgGoleA7dnHkVsHTTj/kUNdwsQ9S0j/xEscKRjx+Gni9jDtG6o3RpOksQ6Vooyavkk7WnEkDZxsFO8Mffxcb5mDbvggdkByY2T8e9/536TdcrCZgLFJQEpHvXkX8X5aWkZ49GO7zd6W0HCkuDSqAiS+dDiGpiv8SsPvsqH6YAaxGMCnncucRInxXvX0cB+YiEy03C1x7gikrrqLNGFzRdEPUzKP1bFA0oRKqLzScEszDIN1vvGIj9kPcr9J7mehJpOy8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdyeHAuliq1x9mVZR6WrkS2tm4S+BXNvh61dMpIsIc0=;
 b=sX9dsTX8ufD2Ln0LZAlX2NJUgItcp5htWInnd9BN2F7/PqJqCEkBSheM9XPwvgGdzTv73t50aDU8hnyoz35UfREOKA0Fc9iNzCg1XZ3G7xCvK9fTBXOP6wQwkC91rA6EjvgaHIS3FNXn5V7IXtlTWvDF9OC7asak+xIXoprL7bocdfOarAM5HlcStqWSPSlidxYzIqDFxo/JvEguc0stDGPRJZhGnD9nxziO4X/hIAkHrLQkCqC8dhT0mWhHc3jLREO8vlRLL92zF54SCK2ArRB9hPQXK+82RmR1YURIYDAe4wWjC9m7gPgKrfn2DrGMZfGh3tpET9waxIZo8Py6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdyeHAuliq1x9mVZR6WrkS2tm4S+BXNvh61dMpIsIc0=;
 b=yIpf/8x3ssnbl4Nc1jTGdbe5mv9NYo/uGJketFaSOJGPMAny1ldjqTklQ0XJcedwlVUQwfK/oS1tdIJikEsCg9p8UvELxB42pahWbJYqrX8xe1JgIVq142V+4rAGxW6TCrabwbXhePCpdPHXwMw9sen25KzUc0Q1MexIEut/yUQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA2PR10MB4459.namprd10.prod.outlook.com (2603:10b6:806:11f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 19:50:18 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Tue, 8 Jul 2025
 19:50:18 +0000
Date: Tue, 8 Jul 2025 15:50:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add mm folks as reviewers to rust alloc
Message-ID: <mslmf6fmbaxmurrwwwjt27mt5gc6a6czxyn5pvbprarugbzdk2@et7htmnyf7pa>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Danilo Krummrich <dakr@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0487.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::14) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA2PR10MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 488ad607-f5dd-4789-9a5f-08ddbe58aa93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ybrGzCO6XLvnmJrHfJSlZaA5FMiUMMtZt9+zD47Z4kknAeBD5dcBs9MAj6Mn?=
 =?us-ascii?Q?h7IjSX6LLcLocWbtJX3B1HdnxfYdCnVLCf0j6qS7bPPXTrCWlwz4luRn3mLy?=
 =?us-ascii?Q?JGVsV1qE8jq2MWu4JKQW3i6IJtxmuLY2Ya7qGhpyMD75mGQ8nt2AE2jxYiMv?=
 =?us-ascii?Q?6lsrrTzuWAbBs+qVV0z6LgWwaSq8rJflE3VvnJAPl5MBCFuoW0+p7DLr9Q0E?=
 =?us-ascii?Q?G736gu0ngFFGbA7DrHT7bJOsVN62sRP+RZt6c17VdHFOmkM2jTB5t3bvFz2/?=
 =?us-ascii?Q?N6ZZZSsSnAI+OyMpPQAYgbfZFBma1BHGJhhA6wECRxbvuD/ZFQ/9uTuT1I/S?=
 =?us-ascii?Q?lRsHYpzcFsqhdfLnFx2Ws9iLeTpM67odbWAlmw13sJQV1p88gOzJprclJs3d?=
 =?us-ascii?Q?/QCjNCqC5a3AtLLaQ/0w/HeSuNr2wLzabxVISxaW/Ho+20UC4h8Pbf8iXoFL?=
 =?us-ascii?Q?IXYl20r1L9cyBxmaxlvx52NLEKuyscfFCY7IRFq0aQ7PM9HHhLVk7lAO62bb?=
 =?us-ascii?Q?UHGwLMwY2K9cZ1gPKlxl/J965DW4iflRwzJvheSjjeP6dlr04p6wAaUOLvXA?=
 =?us-ascii?Q?J7/P63O9sRc/TOd5PkB+RDxsC5jKRnYdqBu3L65ncaLPZw32vaTjxLDevqGg?=
 =?us-ascii?Q?H6zPxdUFKaYwmEUSa/58v9imIKUh6SgZhonIFFS1xBb4qp184tAzdd5OXKg3?=
 =?us-ascii?Q?ooC174wZhyfclS7QO7ixenFTrb8DqvlP9EpcC8f8S0bVvotTPEMr0NVTQa3f?=
 =?us-ascii?Q?jjYV2HztvBhKUcI9dgoARcUz+chhkCGN2iCwhZfupY0IpDnBjg6JRAIBk8EA?=
 =?us-ascii?Q?3q1YaPpcZlyV+bdN6IiFv5a9ogAQVDBjTUq2KHqJxflB+Qq3CVml/LsJMFZ8?=
 =?us-ascii?Q?iJg09/BuUlIB7RbvXGJexzqPxCvKuxkkawwLoS/QpXPAtIF2aMb49jDIDXF3?=
 =?us-ascii?Q?zboRh9DTT22oK76x3Ts/0AIOs/S5D4TfddzkTEGqDNTDOzEq6z7xLvDFGCRF?=
 =?us-ascii?Q?9ndTK68qzXyiZ/Twy52UpU9gqDycWuQGuvrSdAZC6LVZwLGrgViEfFu1mIZZ?=
 =?us-ascii?Q?FgdSF4VX8RRvX300Ot2xnrmBbF73aiLtzo1MSYdTY2+O55Y/JrzSO1WGdYS9?=
 =?us-ascii?Q?WxXN2sYaY+tfS9Dmh8dN2nLkhzSvTUXz5coKwoxLhluz3CuSUNF7CZUomb0u?=
 =?us-ascii?Q?yt+VUrsL5sHNG/IrOaIfD6YikOuarxKtzHuLaJq8QGzD3BNjmXPI2RC6ujcK?=
 =?us-ascii?Q?59YND9ykDVXxj5Uj/Ol0SNTEOQbVX4GHt8R08WFRyofErOkb8q6QNv2sqQoK?=
 =?us-ascii?Q?lS4tFsT54VWQGdf54fC/HtXIOeUwlhtyuS8Y1XX5ktcFFvXdF9b6gPUxe1wU?=
 =?us-ascii?Q?aK85z+U7VXX2zUxQTE8bjG0r7M1SYzspuN1kSY+u6pijkZtHVpsUyZYSe6+Y?=
 =?us-ascii?Q?YgB07QXddf0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LOLzB7KEnJvJUj0MtfXo5QZe93nltOHmLbNZOfA/enWKz4WEBJsSNzrw6aLM?=
 =?us-ascii?Q?/Uuv7frW+9gaRohMDjbVMguUIaaSYBTRmAd6s9TsdoiK2zC+HTwAh4M/WpDh?=
 =?us-ascii?Q?ifvFEiCLek5E/+1Nc7SP9JXv2nS/4yxmXgdfsmlzN5WCwFTWpUSQ6M6j1Jv/?=
 =?us-ascii?Q?uhhsKj+AgSfMLx5mZO0CjBeDGFvpZxczyXUkkIIfympLTp54xLC+CvJzbJoE?=
 =?us-ascii?Q?uBAoHfBAf28Igk3OG51U7ufeEvfQYFegxqSEvGTfe13g2q31mIJUr6KvS8Ia?=
 =?us-ascii?Q?fo5APa6tw8vHZuOgupe7p9Oet6K0bYRwch9NXbZN9Tz4/PQxzvY5Q+QhyHYM?=
 =?us-ascii?Q?CeSaEqMq2hFByPfBZmnjUVgfzY8qVd+UouS44maPJWyeJ9p7YVN3zf6BfrH1?=
 =?us-ascii?Q?cgcpczmGzeXVyDCu3vgUmvnrZdGRGlG377oDCewTJxQu2twp5sRYv6urS+qE?=
 =?us-ascii?Q?Mp1NVHyAS8jy5Y5bm/i58ppcIqIOWEJ7ox6PnW6uxz7YH6INwg8gafCbbUE+?=
 =?us-ascii?Q?s66y1TFzRNc6rfs8SmqsefQXInznqbGu9GhTShViInIF48epYaKTRL4eeNt9?=
 =?us-ascii?Q?uHa/mrpwmVuKBXpEKEgv1qls/ViWfVBxGxQ3+2G7l7qTItTVfcuViCbV81i5?=
 =?us-ascii?Q?nN5a4J4+0RRxqaNNgoawBFMK+0jFTzNBOCPymfvyI7TXIK6Oeu8QTu2B5XwU?=
 =?us-ascii?Q?QWsanIdx6Zz+5uCOoV6nmwlsR4BzAMlCpHwn441EFUPlDlp5ahrK/KWRrPnx?=
 =?us-ascii?Q?oWvzWM3mnObyfFhnr7VPWF+OwIhMnyAdfT3bTHWgB19KDZVedSmo1a99RyPF?=
 =?us-ascii?Q?YXFaswGLjHDSa3dRcBObP7L+yieBVe4dZhkgPJReJZOsAOcOGMF3AfxcSDLi?=
 =?us-ascii?Q?1tjZ5WhmDqig1RYd+ElN1aPxP5mMkcZR4wvYQEHfshDKXiL67920kF3VSpgo?=
 =?us-ascii?Q?+XkJxVUCPkoaKq6/uhga/UJsWNBDGDc57lEkEHqYuDOF3Nya0c5xg/mmKqtX?=
 =?us-ascii?Q?vwIPUp13r6ZpiFRuw1pmTfRxwfMMRKIe4jH3IUI+KGj911Q8z7B03ytet3UX?=
 =?us-ascii?Q?MuIEvD+JeBGemsVyIDZBfUarfBLdERUAfNnWtwVfOT1sJfxcY3+yl3xSSN5o?=
 =?us-ascii?Q?iDamDtzGmK+UbggSHm3ICRx8CmZPGTgAAsUOr/fNax/2PAFKU40UckoH8xsE?=
 =?us-ascii?Q?nWVpUSyuHwdvX8RAlA9LOTFaqQmZsKXA8z/rSqLQMUZKVgNwLqEa0KQnUm2N?=
 =?us-ascii?Q?nwxZmlWvpXdj0BXhk8ClXCxqnvwwWTuIbs1E1sn+PKO9b6n4vFL89N/1dtrb?=
 =?us-ascii?Q?/yXQOkXZB2n2BGRcDdu0gMj4FA+fhH4b5mBm75RNouaqCWw5i0GRKyegUzVD?=
 =?us-ascii?Q?cIoHEa58gnBWaZAu6wCvjf8j3hOf+is1oeVkgFcmYf717BOe6xhbAysIiX3T?=
 =?us-ascii?Q?3K0t2fZ5PPInfw3iMvoft1/2TfIejGb6ocwX7dsf8jdIDmlu7TvEBRuRWvFt?=
 =?us-ascii?Q?S4AEx9nAahFi0Z9ZlJ73JC6qmHG1hmAigCJ7nKIOwKq1DtEp86LPymSG3haD?=
 =?us-ascii?Q?nYH9h+I781xqma0oIK7yCxO2YSs5NKQBoWglp/1Y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I0qb2RxsVDo/wnt31L8FmlIe04ZjCA9HLvr9YKWxtEwxGhSyGO5FcHwOU0oUEGPryUAUU8+nTxZHk4MmJb566h3bOorT38bRmG4g0SfkTvC2SGhWTnJy842RVeyxk8V+SfCqPWQJwmZzT5xlH3zqLKYPfVv9dsVcDLx7ZA3q6y//bXCE76qkJkw22w+NPgUYm+UrOaKgJzIsLmdn6fc6VxYHg4q+0Z294NWVZyg91Y9O94o4tth+HW9CTFnDZo49GN24vzG0y6GwmW6lrL3V97uLiEWzEAB6meZ27aJz6JEHEGaE6cH6IArKP37qDb9irmYQxdaPlwmaOio7qhsNelEof61XgclKLb1Fs+9lUzL2CLbB7ys4WX40m8JsjskReqciNiQKAgPNIhd+A3LmLsaug0t9nS1wY8XW3HW/9W217J/Y3ehXMlodmtGaq43Fks3U1CS6r9fNgZSaw6/Vx55xxDfJsrysxdPH/6JHlUZ3/v25YCctZAhroL8e7ZfMhw/GF5kgJ8oTb93Qz/Zknn1NdivUYxjss22g5U06TJGeA7A6iNXs3Nqr3UUXJIEPOafZ69NFO/P2ogrjxOOPt8/b/N1vsIiCsaI1nATlVrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488ad607-f5dd-4789-9a5f-08ddbe58aa93
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 19:50:18.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7rL38zMOkvbdiUO+SruuBHFeGb7pIGTBgjM3nm89lNkh/MJPkgOSjwEH3RbVD1Z6pGuqOeLxVl2jDut26wOqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE2NyBTYWx0ZWRfX8rybQeWF3xcu EmijpTv2ePBedCBiqIQggpNBLSuXF9fwEnvL4nDhEayr29t7cwIFOoEZwgvvGaSHGyd+Dd9nhBQ O5CVq0kn4ujsbPcpjAV2bJS4Id2WOVwVmO6WpCCaxvOntRzr5mk8mM9IfvVFJ1aQPVbLLR9DBp/
 WR1IGSirrm55CsmSGHKcNPb0iYmJXU5yQMiFQ1WF3lqUsn2BWTS+9CM+HyKrR9Qiq5byzx1ZSWB G7lWa3a1pUVBKLPauRT/APbMe49CnTmOVYJxSxhytsVz80kIY16PCGxcT9zjPfXXtdBHQy4Sstl 4KTlkwWOEte76aXrdRKWgUyBFSbKkVR1ExJTR85KZI6UhM+pgBzvwymmAxbHlaS1/NG2GzQ03py
 BPU/9c4AimyKP4YwkUGM+4AOStJGbZ8tU3wgXlkCBMfD1zqcfib+LRtXloDROAqhUMJ6OQ9k
X-Proofpoint-ORIG-GUID: 7GU0A7fLrzoJmBQsQDeof8qgIu2d23tH
X-Proofpoint-GUID: 7GU0A7fLrzoJmBQsQDeof8qgIu2d23tH
X-Authority-Analysis: v=2.4 cv=QKpoRhLL c=1 sm=1 tr=0 ts=686d767e b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=O6DfbOwrsqiBtfZzAKkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12057

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250708 14:37]:
> The alloc implementation is a thin wrapper over slab/vmalloc, so to help
> out on the mm side of things and to be cc'd on changes, add some mm people
> as reviewers.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by:  Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 71599ab6bd56..54dd937160ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21751,6 +21751,10 @@ K:	\b(?i:rust)\b
>  
>  RUST [ALLOC]
>  M:	Danilo Krummrich <dakr@kernel.org>
> +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Uladzislau Rezki <urezki@gmail.com>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Maintained
>  T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
> -- 
> 2.50.0
> 
