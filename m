Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C380BC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Dec 2022 14:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiLTO4Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Dec 2022 09:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiLTO4W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2022 09:56:22 -0500
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2101.outbound.protection.outlook.com [40.107.116.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BF862CB
        for <linux-mmc@vger.kernel.org>; Tue, 20 Dec 2022 06:56:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4ZHfRspg9t2S29beRryhyO70+Wt0e4FkYid0bxyv2t1/eOLWyeqoWGDCjhgbmV8cdIhzhmnYXh3I2cdUg5BYYZqROZ+NTRM8N7nGv8BE2VE/88PTm4nlm8ls/iipTYWR4Cc5pf4brV1HzzWRh45D1EC6D7SZ409cRCorU9rSMXOdQONRRfJyN4oPxzh8MvE4/YygQ0m04xwk9pxTzGMA+1d7PbF4jaAJfwx/SMlS+PR1TeP/2esrmzslgheu8zoJhhE+h1fyo3Fa0wYs2ww8zYvQZG3u0eDQ+sXmKrgdDr20thwnNok5AraksL94U95XbuVauAI1dfAaLaXfZjx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh8Bt/MebQZNp4jSi65685vD70o0id953C4b1xpLHJo=;
 b=jWazgOkzd7H+cd18/EwFdHzsllGGB0ZXtl5Y2zxnbGeoU8MMTw0+sWV+X0vkuaxYeyVaLlVlqWdtYDyGUyKwoUYN2bPYDK7KPygyG8wsLBJDJvvRcintPl89E/AManAasnoY2m9w+KfUxgmUeOvyYCKQrmVycs6gvok4gN/5IcNLp8Zfstd/nHTcXrH5D6Y8DZIv+hla+GJ1jtUYMg4+zBycTkst4XQFOKzVqY6kcOO2wxZmz2p7n7l3vtxlP/6DAM7jRNX8wpi/usRaTyQXGQmTlUrI2A/ouOvKEu2PbVVEj/TelfdccdBk7pi0tQr7382KfbtpIrwlNH8I0OVzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh8Bt/MebQZNp4jSi65685vD70o0id953C4b1xpLHJo=;
 b=kqHAz9kpt6T/CyX3IqSEFm2rww+LTmyDtClNFFXJwVdtLrJ6HDjiDp1cSWXOMMpIVUtRxztVWpcZ5WxFs9oub3MA6Cd05LuVA3aAG/xu4ZU/RbLseOE/1qIwEvkByWQO4eb5lSai4qATIlkiGCsoU+aNUhFOBDFRHCt3GqDqRrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
 by YT4PR01MB10597.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 14:56:17 +0000
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94a9:f6fc:9cd8:7bf8]) by YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94a9:f6fc:9cd8:7bf8%5]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 14:56:17 +0000
Message-ID: <e3fbc37a-c5be-6ce4-bc68-4406b4378c6c@lenbrook.com>
Date:   Tue, 20 Dec 2022 09:55:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: correct the tuning start tap and
 step setting
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>, haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
References: <20221207112315.1812222-1-haibo.chen@nxp.com>
 <CAOMZO5A8uC3hz6=5uG=xKSdqqStypqvJq+nNcR3BORv9JvyaWg@mail.gmail.com>
From:   Kevin Groeneveld <kgroeneveld@lenbrook.com>
In-Reply-To: <CAOMZO5A8uC3hz6=5uG=xKSdqqStypqvJq+nNcR3BORv9JvyaWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB9670:EE_|YT4PR01MB10597:EE_
X-MS-Office365-Filtering-Correlation-Id: 84dfe8a2-7a58-488e-cab9-08dae29a5928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyNYxkXfZ+SRq2umVvjx3GtRr7bNnXH4lkgtOsxi7UXUX1abZqxMuSSd6yo9JEkq9Mgc9gmuwfpBanuYUhaCBRPN6faAjPnnmfwHxPPcR3n/6gxMwzZ/myuPkwr9yEjipW0OdSlTEJofe4KezU3WBpvpQ0CDpH5wjvBKHpA7MtSHYImClIj7zF3goUSLRUSinMY28Tbi3isZev8hMKeiCxHwOvln/8KGNcMP04pjJ4KLj3GQ9n6bSDG+xUnAVLzJ2BLI32wGTM7/DUJxsWlFjYoStv1cTn/KU3RWxW2g/pDFvwusIS3fOEe9tO2WQV1chkVa8jxDIU9eFdElFbmutRzXwoToNLlPtkXmyyFl05MdR3M4+Lk+DIxaxyPfotgr8FqbjIx0QBXXD79Jv/MCjsi663ZF6+DDZcbohWU/rtgdtZ3TcRZV7AF5dZJK40pBVJlL3WcMtTZqOLp53s9bBlLypHb1T6vj9CHhXitgmHvWM4+7FqJBqcCFY+waQHa/T/1kZ8Cum7mA61rUbJKHA8QKIxlF/xJSVC3tmF1s2dtVXsv46Iw3IbUtEE1GxUrV1LJrH6JV7Sa7sCVlj9x+rwUygD8di4c8a3XEevi8BBYkVrI5ZRkAeiw+ScdNDn1t+4rr5Rro2CsUhy9FFCFn70Ay5nPRltGYwXQzKKkwMvoYEL4N9d9uX4EiMhQ11M7R9eyPUmGrJD2dgRlpmn7mQEFH6kNQOtJlRbLfe3fAptw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(376002)(39850400004)(451199015)(478600001)(6486002)(31686004)(8676002)(6506007)(53546011)(316002)(6666004)(66476007)(66556008)(2616005)(186003)(66946007)(26005)(6512007)(4326008)(8936002)(41300700001)(5660300002)(83380400001)(4744005)(2906002)(38100700002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEFCeGQ2T1lMYml4cnFKRnQ0S3ZTNFdZUHo4MTRzZWJjNHVaUVRObWw5OUNj?=
 =?utf-8?B?cGFIK0k0elBFdStTOVdXSXltZ254VXBiSmU4U0R6M1BkMXVlZ21nbE1MTk9j?=
 =?utf-8?B?Y3pEYVcraW4wcGhXRGwvaTJ0bWRyTTQ1aFYvRDY3WEU5eGlULzNFbDF1QTVn?=
 =?utf-8?B?Um14S055YVEzb0dZSTVORzhZRnR6S0hkaUUrL2F2WlFMM3NSN3BnV1Vuamg2?=
 =?utf-8?B?TzNtNDhXWTVMU2dQeVhsV2pKTTJkVTRJdi82REFrYjNVcGhxc2V2aXFYU2Q4?=
 =?utf-8?B?dzhHRVZuQXE2S2l4VytERWFFUXdHZkpvc0dvZS9ZeGpQbitqY0VtRzdsOHRO?=
 =?utf-8?B?bWdwc0RTUENvNkEwWHNEb1BuL3oxZ2dTVlFWcCtMVFRWZGZVa2N5a2t5bjlI?=
 =?utf-8?B?T0dnUkF4ckhGaFl5ZXNIalB3SXpkNGg2Q00rQzFRTDVUU0RHcXM4cUdXOTQw?=
 =?utf-8?B?OCs4c0ljcm9sL1QrTVlvN3ZqQ04zTjlKU09WZGkwUHlRb0hybjFFcEV6UVdN?=
 =?utf-8?B?Zjl6aExwVzNqa0dXT29veE5PZmVPbzFRTnZqVzYzUmdjeS9IZzFVQXNKQkpN?=
 =?utf-8?B?aHBjNi82eFhSVEtxYXdGR1E1M1d1L3gzSnNqNnN6MElRVTFuT3dzOUo1SnMw?=
 =?utf-8?B?LzhyTXpJSVk3QlcxZGorM3RRbmFvM0I0Mi9KdkFrUlllcmwvTWhQYzF5eThX?=
 =?utf-8?B?L0xDTys1OFJ5VGkxNGppNVgxWHp4aFdEVC82VS9wb0pob3NKQ3VnTWRZSW1L?=
 =?utf-8?B?QW9COGlVaW5QTlBSZC9Hb0ZqM1NsRDBIRk5oQzdhcjVybm1udnlRd09ZRUdt?=
 =?utf-8?B?Rll3T1BYeE1HR2g4ZGN2eG9WYllVTHM5RnMzN0tkVWlvNkE4ZkZPalZiK2RH?=
 =?utf-8?B?UE5uNzZtQXVpdzRLZVB3aEcrVXJSSk5ZdEFoQStVYjR4SHBpaDlVUk11ZFI4?=
 =?utf-8?B?YXN4cW1ZWTBGQS8wWkxURXpLWjFDT2paK2xRaDZaZUhUZTUrMk95N1llclB5?=
 =?utf-8?B?WitWeENJV3VrM05EVWxwL21OYTN1RUlHUzJpWkFNdTFzaGJsV0xUUHc3clJ1?=
 =?utf-8?B?WE9TZ3F4QlFHbUhBZEdLV3E4eFJ3YkhydlNSRWV4WTlpTUVIWkgxaFB3eHBB?=
 =?utf-8?B?b0ZJa291S0o1NDVTVmhNSkZlZ2VQbVRyV0pZUWc1eGNvcHQxelBhU0dVaDRE?=
 =?utf-8?B?SUNveFVrSUwrYWlRd3RndXl4KzFPN1M3WXN3ZVByVFpFRGJ6dll0OWhTYnhJ?=
 =?utf-8?B?M0xwcjZUVHRHWlJqS1lNMTJaU1FxVGRHc0M2MDJsOWVsSjQyTmczL3R2N0pX?=
 =?utf-8?B?cXJ3WFBnOE5CajREbW8wR1ZDSlNFT2JLOVFXUklTbU5jTWtzc3NRNFdQRFVS?=
 =?utf-8?B?c3BLSllROEJoNWordWpTZGZsRXM5c2Q3YkkwZ3B0UGJvc3NkeFpHb2VpS05q?=
 =?utf-8?B?NG5nTzlYWGhCQitBRUV5WkdWVDZXVXl1M09pOXdyeFQ4NDVIZGIrK2haaGFP?=
 =?utf-8?B?WGZnZGl6SERTT0x3eU9Db0h4bFQrYVpscWttTG9EdTBRclZ4WjNBUFZMZ3RJ?=
 =?utf-8?B?RGZHVlk2M3l1N1VjcE80eXV6YVlwOXloT2pJUEh1Mis4TzhpYWtJUTlJTkh2?=
 =?utf-8?B?UWVhb2xCKzBrV3F6L3d2MDJ4VG5xdWRRMlM3VVNzQWFGMk1wNnNpSkJmcDdC?=
 =?utf-8?B?T0ZWemV6dFJZWXFGVGRLQVRPRHhRRnJFOXNvaUEyZ3dRaHlzRGc5cmJQZG1l?=
 =?utf-8?B?WVBtRXF3ZnhCN2h6dkFsYnpWeWpQeEdmUUE2NS9ZTUlEc2JIeEVRQUxEalJp?=
 =?utf-8?B?RDVuOVNWQWt2YS9xelZERDZ2VmhoY0FRUm1ya0t6aTJkdEdKSEgrdzZxcVBJ?=
 =?utf-8?B?eDRMeWNSL09HL281aUFJSG5tK0NLYklFTjV3dzZwT3lkY0hpaytqeGk5ZStD?=
 =?utf-8?B?UGZjeVFzYWozU1Jsam9zVmJEL0pjaTNLOWl0elZZbDlTNFlqeUF4ZmNURlNu?=
 =?utf-8?B?T3VTeUlOR2JvdHprbkIyOGNrY0Y5Z1lrTUtLOS9yaDVybUNCYXJmRDVJeG12?=
 =?utf-8?B?MWlRNlEzcithVzYzakM0Y1g2MVorbEdkaUlwMW5tR21WdGcvWExrQkpQWnpx?=
 =?utf-8?B?S3B0UlBpdnJpMHhPU1lLTW9GNTVrOFFUOVpHaEJKT3F2QWZ1aXlqZ3ZFR1pG?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dfe8a2-7a58-488e-cab9-08dae29a5928
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 14:56:17.6126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZULxzEuQdfKABz6x4hUoIX+PXkihl3ohC3wbcarx2la+P1lbTFxpZdYkbPJTTIhvZOQE8lfp2FzXoGc0QZ94kw9gv9O1M6fH1azB0ayNnzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10597
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2022-12-07 06:49, Fabio Estevam wrote:
> [Adding Kevin]
> 
> Not sure if this solve the -84 write error when using ath10k that
> Kevin reported.

Thanks for the suggestion and adding me. I have not had much time to 
work on this lately but I did dig into this patch a bit today.

This patch has no impact in my situation for a couple reasons:

1. I verified my boot loader is not changing the defaults (at least on 
the interface used for WiFi, it is changing them for eMMC interface).

2. The mainline imx8mm.dtsi file defines fsl,tuning-start-tap and 
fsl,tuning-step in which case I do not think this patch makes any 
difference as the code was already masking the bits in question in that 
case.


Kevin
