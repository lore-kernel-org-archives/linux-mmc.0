Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFAA22257D
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900095; cv=fail; b=U5CalhA4VAnbbYLlSrjTklbnMqBcqENkphd4y14qZmBn8CHQrEMsJTkbYzGCmRsKGlbTtggKOEu6NJjuc3crIib/mFZ4aAc1zwKf39FSWH1QmcF2Jo9nVH9IBvvzu7fr1KDGx1wjf70kaClzaNXp6opfjcWJW38fYPYMpW29oVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900095; c=relaxed/simple;
	bh=oyyw0l3a9Yx3VgNW5Pj0ig7xvEgcFn3WvsZ3liVaCMQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhKLFws13ed22ETHPBtqK+NUmiqERWnh8GODBWCIKCm6BeJF47Or9UAtaZB7lDJ0QXwCL2XT7dQVh5Z9MYzgm7w7OmtAYvLp4WraWSozEOYqP14+g6evVVoIrcZBfD/rT3eg76le8eiwa0bgPTNwWrztCOceqyXe18UBWgXlJCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=QeZXWL7c; arc=fail smtp.client-ip=40.107.103.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="QeZXWL7c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNE01HWlvHg3tJb1OKNUTexoXXPhynW6TvrjUsj4LArbK5N+kK8ccm8psuT+5FVzGEa19+3Mf3KcIrEs78GLZjIM6pQyfOjRJgdpriUGFHOpMV8kvteknGwcqJIYjmUoZC7H1y7YYUacVf8tZoM8xCFa2buv3F8/Vuekc7mRv6NAIgDImFLq1/JJQVnPLl/vr14lcgALwK7VlAPFEeoE2qcEtpzsYwpPMV4aOsYCjvrpP/EI3InbwZoBvSMExHcMKK2SJqbnaaXFijRJizHPKfE5LWH+B7MYOD1s5xpIBg1ajO4UZDYCjio8YshfrA3yc4R237uQqjcgml8s2b9VlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEdt2iIRMFzAXVzg9VmJ4AxVautV83mqNTwppHWMZk8=;
 b=GV8fVXA4RoEvkQRf+/GeiLWssa8ww0VO38FKfWKcq7rg7hXSoxWko96TuQtth4lUZXBm60tMUsaOjCIyGdVD159+HCI4t+qMOHVu3wRq4+RLPNM98YAsZMEajqfQpP6FnDhuokDVaqCS1oCGJKLav6R3s016cH8KY0CvU+tOYEVFpSlRLqKQXf+H6BjTwf4ReRQr67PAtLfawRxBMZ0fEMksNP0npDtf9Qs/NaMgJFJ0O1H95BcZcljwOuM49Q+xifHeHCxhV7wsol7cNckIszE1coXboXQXuRart4gaNob5ydKWqSLaGpe4Q+p93MeeMw6Hen95v7/aoC3rGm24ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEdt2iIRMFzAXVzg9VmJ4AxVautV83mqNTwppHWMZk8=;
 b=QeZXWL7cBVlEIy+onu7z22oozjQZxWY40dgIrBeTzi1OiM95jN2DRkOJ94CSP/OUcjA6jIv7MfiJm49BcW/KnER7CMkWPSeBOFT9+PBwguURBeVHT3QNVfOM5zfAXPOr9t1Dzp9i4fL+p6B5FpHYxCb0IQQ8oUV6+14miHkCTd8=
Received: from AS9PR06CA0414.eurprd06.prod.outlook.com (2603:10a6:20b:461::26)
 by GV2PR02MB9423.eurprd02.prod.outlook.com (2603:10a6:150:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Thu, 22 May
 2025 07:48:09 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:20b:461:cafe::2c) by AS9PR06CA0414.outlook.office365.com
 (2603:10a6:20b:461::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Thu,
 22 May 2025 07:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 07:48:06 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 22 May
 2025 09:48:06 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 22 May
 2025 09:48:06 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 22 May 2025 09:48:06 +0200
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 693CC2E74;
	Thu, 22 May 2025 09:48:06 +0200 (CEST)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
	id 64AD462A06; Thu, 22 May 2025 09:48:06 +0200 (CEST)
Date: Thu, 22 May 2025 09:48:06 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
CC: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen
	<chenhuacai@loongson.cn>, Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen
	<chenhuacai@kernel.org>, <linux-mmc@vger.kernel.org>, Jesper Nilsson
	<jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>
Subject: Re: [PATCH 27/36] mmc: usdhi6ro10: Use devm_mmc_alloc_host() helper
Message-ID: <aC7Wthl9TXa3ScI0@axis.com>
References: <cover.1747739323.git.zhoubinbin@loongson.cn>
 <0d16c9af84f9b8e31568f409a4eefd5e5ad6d1c8.1747739323.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0d16c9af84f9b8e31568f409a4eefd5e5ad6d1c8.1747739323.git.zhoubinbin@loongson.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5F:EE_|GV2PR02MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6ffcc2-75f0-48bb-f2d3-08dd9904fd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hK8DNbTnwREMy3sSXrXvbdLLDw9nBLQmT+QSrMCzShgp92oMCLKjkal8JhfZ?=
 =?us-ascii?Q?MEaJe7VSdK33B8lwfuW3CyxsQ1KzTR1qLF5v5xToiGfZGU0mWtiE/FP9ZV6g?=
 =?us-ascii?Q?OH9G7653PiMmLIDKKVD7NFB4soOmF+pLHkfHyhmUoTYLgD0DBAiRE3Eoccim?=
 =?us-ascii?Q?B9nGfWvvDzL1vVDBIybBjKB+otr4/6X55VXu9oRiJZr+VjHVJtzXc1j5sjzc?=
 =?us-ascii?Q?tiegIWSAzUTmTabmOQ35d68ZQZ2NOJUlRHHGLwcC7omRcmbkj8R6fmCEvAVJ?=
 =?us-ascii?Q?0Mmx82dRMQ9jM3/qGI57bPeeYhoyn+cH70XpVml+cxPsGMhu3K0ftcYyXgey?=
 =?us-ascii?Q?xHh1vEQj6/CTfETM88suowx/DsRXGHU0QXJvn+3iIrng8Xtr5x5g/8G7pUKJ?=
 =?us-ascii?Q?P2N53gyVCv3tgjwtRtqDv+a0XeK8WFgSfWI+1yRom2Eb8iNlHthB/p76WX9a?=
 =?us-ascii?Q?sHYE9ew3ZRVIenV0AYp+sccARTYHwvJFkpxo2wjsfVCl9i2B6hSMKYcPKIN5?=
 =?us-ascii?Q?SvxRbeODY6CEi2EBZ3igMB8+gCxC4UGcguiuX0OVFoUBGPszcftxqXeRxNKq?=
 =?us-ascii?Q?aNeVG9dq6INk4wARw15RJ7pZQHu75Sbf1MchsY2esGhJO0ETNtW2Tg3j6Y8+?=
 =?us-ascii?Q?+8OtGMCZLYfSEnW+CaTroTQMhabZ4c0h3Af4x6GpNBX9elvkjsAH7KuXcIYx?=
 =?us-ascii?Q?3Pkr1EgKHANuweVxajWZ3pNxOv6+wKdRtk+sOZ8879wBsRbEghUXnaemZpsx?=
 =?us-ascii?Q?W5pMaEFc2BwxrQmFHre4/PzBA5qNMbkL5HK4Q38m2huxYNWkTABSuX9zfuMD?=
 =?us-ascii?Q?/DqWaLWaSMD4SwDFCjWY+OS8pZitFPEi5XToGLJbCGZHCv0jf49arLJimKl0?=
 =?us-ascii?Q?VgN6qA8qwUnCrCwyCVLKXnuDmy7210Zh/EmgoAGsxefsxGL1XTuOEImeaqer?=
 =?us-ascii?Q?2AQsBtRxET7SvdmerqQ9UprilzxSIrDc+/QwMk/IptWLnT6l/GNeZTQvzth2?=
 =?us-ascii?Q?b3EywPFseYCIld7Tf5rv21ymCp3sXwhqz6iSnTAxY/PP+4Vq3AjMAbkoyuUE?=
 =?us-ascii?Q?l4WeZicnH1BpylzG//yFOFZ2YZ6z6U0H09HTOS1zV0dovtXh43Knm/E9DpQu?=
 =?us-ascii?Q?h5xXbqPsJNLW59e+i6QOGUC6bTxcBH6hmGO0d4aO+uIZJZgvs6jpioQVnGBU?=
 =?us-ascii?Q?kxn+UD4CCjgQPst2vwmgbO8dk7reBVnY0YdSCS40AwKzNqdjMRfJB1f+JHJ4?=
 =?us-ascii?Q?W65k9XNtph2w0UGgrdii0uttonxjAFeSfBBKjok6ThGKfkZLgCKVuFr8KIJb?=
 =?us-ascii?Q?Hxux/d+e7uiEbbvWt628jjYeGa+vIhHc5dYpvXgmgf7ozZdbacO2xoLgN/oK?=
 =?us-ascii?Q?aXXqpE+HwalFxl73lsuRfNYYbR69NIbRDaKIuui28T22wzgKbqjuS6EpwF5s?=
 =?us-ascii?Q?8D5Z7Y1lS/cv0gkSXDKnQh/rAKdlGDXwyrcymIx0QpQLb+LYBPujfrvVuPmr?=
 =?us-ascii?Q?5VtmGyraLi2ACgSu3bKnzaWorH3hLyQ+Y3oe?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:48:06.9663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6ffcc2-75f0-48bb-f2d3-08dd9904fd99
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9423

On Tue, May 20, 2025 at 07:46:34PM +0800, Binbin Zhou wrote
> [Some people who received this message don't often get email from zhoubinbin@loongson.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Use new function devm_mmc_alloc_host() to simplify the code.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
