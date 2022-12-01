Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55416C43217
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Dec 2022 17:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiLARej (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiLARe3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 12:34:29 -0500
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2108.outbound.protection.outlook.com [40.107.116.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C2A95806
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 09:34:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcJLgt0ODcsvnHO0X+OHwJDSxRwdYgBwbgUEVgXExDGFETLi5VV/HR37sIzMCVDeHyz1BWhRuMd27lTrtewlWZZa3tqDyHPeqH2Q7qp57C8rMC8QRLY539gLh6+cm6j5oKIQajzOKkDlxqVhDseLJhfsvso6XHTRGcMR0NgQa4N5tBAmLR6XCHeWgxjdO7Jsr/QqfQl98w8QH2mr4k81VaJNWWdK9EOjOUPurhpldKV+9vsAaYff1sMkZp3ej7RsmFxNSu2B5LSI2AZmxi8IB01Wp+JuyHGpLpozIC1H6r2bbVO+bvulxUXaFbJZU306ZkMo/SjpX/i6c4TBlWIu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wnxhQsWYtvb8gHvp7q/m3tG7ARJ5lQWZvoAlVUpOpg=;
 b=In5d+QV9bAA88uFajpoVLPG9897RChiUF5Ulo/r8XvHfBP67TPaD6PP7S1CkvGFKCSsQOvAHkrj8Df0juQVPghCrqSLL1rON0yQP8MthqOgJGwZ3sv1pg/Pckn8KErfofDNZzWy0TdglGBGpPI4N1nThnhBY8N2OlXM7zELYruO6mhzWMm2meJm99P1l0fCoihN2Q7s77CfhidgpnoaQvvbXIoXjVYzZ1MI2QV68p9rCWOSLtL8rx+xw8xXAhSvToxab3r67+0LWkx5+4EapvAt7xvG1gUVuZSdIGyG+BlhJk8pz8zglf4Cuz5CebLjnaQJiB23eC+1KsvoLnoch4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wnxhQsWYtvb8gHvp7q/m3tG7ARJ5lQWZvoAlVUpOpg=;
 b=e/fXTjigEzLGZ3cmqNmBMstCCZdwJ56X0/JLkx6ysFYA/1HRZ0yuZ6dG+2kR1Sc2QOhnqnt0ffIDacnxyhukbFoRLx971T9VBTB8GbCk7ugpnhUzjdqeu1rSdME33yq6rv+g9gKYPb/kmIP8JwFJHSpV8r9TgCjaeAKKF/7we7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
 by YT1PR01MB9019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 17:34:25 +0000
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94a9:f6fc:9cd8:7bf8]) by YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94a9:f6fc:9cd8:7bf8%7]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 17:34:25 +0000
Message-ID: <4425d932-186c-1d14-e728-0c45d1bd8081@lenbrook.com>
Date:   Thu, 1 Dec 2022 12:34:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc-imx: fix the mask for tuning start
 point
To:     haibo.chen@nxp.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        yangbo.lu@nxp.com
References: <1590488522-9292-1-git-send-email-haibo.chen@nxp.com>
Content-Language: en-US
In-Reply-To: <1590488522-9292-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::25) To YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB9670:EE_|YT1PR01MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c438c13-6934-4c78-3d05-08dad3c24a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2BZhxJBOWm8IoAEFfGCNF8kuSecP7luDEWOLVMphXjhfpLKPxlGCeSjCufJ7Q3vTdpj+TNkY/XHo1ovSpaK3D2G/8+UrTFmSvzsJqpESORhM+KLoYYJAvvq7dSGMjeUdaJcwQ3dXkF+OVAXcG9oAx/oXnKfUYNJ2cakN6i/Twf0McXZsRen0lEz0n4a0DTzQLAClGNP0ZxfcdX6JrwLDNuy1WLh3j+Ar5xh34PV7oRxXXdnC+rVgXHJSAiSwxH3i5m9yZjg/3OF/clku4gkNXrnIaGfKI9vmWeVaZk+SKPrVol0sluEZ6wNvZSJ8l0MoOa6d8sbNPQ2gYUpE7irVwY3OpUImJX+wSESzgKRNIrd1IMDuImSVQd4nm3tVyaSlFP0mxhE+RxXiOPEaYRzeXyfDQqHVOZPJBvs3jDa0wGBZ2vO71Cjmszd0GM7QzMi+X0sgPzxP4UeUohKN9OYJGHv8Sh3hIm6ehPOpIQsOIucQNvEOYa1NIghgwvVbzinYV2IQNeb5NjicYVURmdFwmgtKxTBEhWvWfB7kqLZVFoiLRo4diPWbZWSSgiwbqAtED4eVdECuYwEFXPOQ6pFfrAxeUs1Ra29o/jr1WX/zgwJZ1lRD/yDz5RB4GLLucyZJyJMRm+mS4pU8RDtSQYGiAhgLz1IjUI1ITo7NKV8RmIEqM28nnHY9GNYWNX/9kdOp3ZOjlBaNRHymsQqG/S3m5e6JIR+aGYKoMecJ/lP5w0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(366004)(136003)(39850400004)(451199015)(31686004)(53546011)(6512007)(478600001)(6506007)(6486002)(36756003)(86362001)(31696002)(38100700002)(186003)(2616005)(7416002)(5660300002)(41300700001)(4744005)(26005)(66946007)(8936002)(8676002)(66556008)(66476007)(4326008)(316002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE9mcUFhZCt3Qks5NnJoK2ljc1pTK0VtTlBPODRRdlVFbGN3U21TMjRRekl6?=
 =?utf-8?B?QjV5OXhlY0NtQlBHZ0xJVXlRRis2N1p0bHpzaTJxbTBCT2lLSDlQVXZzZ1I1?=
 =?utf-8?B?cnBJWVhSL3pjR0tOQlNIdW1IRk1ZVUNkQTZEcmtjd2F6VXV2Y3FHM2dKVytT?=
 =?utf-8?B?YVNoY0toNFFBOEhZejdSL3pKSGZuZEtpU0xQSFhxNmxIQWRJN0hxRW1GZ3dN?=
 =?utf-8?B?YUtXYzMwdGwwMDhHem1aSnNIcDNNLzZCeTBWYVQ3OWtpVE00SC9keHVNTU1n?=
 =?utf-8?B?VDVUWkFvaWN5QTF5OUlXdXgyakExQ1h6SDhpNVcyaUpBd0pieTh6bGRIWGZt?=
 =?utf-8?B?LytyQTA4TGxaS01TM0NFVTU2T1Z6MExLZGhDbDRtQ21RWTUvUW01Z3BzR29w?=
 =?utf-8?B?WUJ6NGdyb3FJQjJEL2c0UmRFQWhscUZZZ2laRW5zR0tLYlZ1VjU5T09HSTRQ?=
 =?utf-8?B?dUVWYlNjTjdGaVFKeWhUSVpNYnZtYW04RWtIVVVhQWRTNll1YmRwbHp3aGZt?=
 =?utf-8?B?bFQzYmJHVVU5UFh6bHVHVkdUSTRVcllObk11OWlXYlVsaTJEQk4wSjBUUjhU?=
 =?utf-8?B?OG9LT0p4TUtFOGcvNUFmMkxnRXdEeWlyamhPMFdiZ05RU3hseHBueEY4YTBK?=
 =?utf-8?B?ZDFFMjNoSTdpL3Q1MDVIQmRtY3BzSHFqVmsvczJRWHdVMEZZVDZaVXk3WWpu?=
 =?utf-8?B?Zm9VaVRZMFdCYVFPcVVJZWFNT1AvSkRvQW5JL3d2SnJBa0ZVbjNFakp1NzIr?=
 =?utf-8?B?YzdDeUdwTEk3cmpqSnFIQkdsc3E2WExuTHhZcTE0SW1udTdSbG11Rmx5VW5y?=
 =?utf-8?B?MGhwZVEzZmQ1aFZzdDF1eUVtRHNua1UvdzhEMDBpaXZyOE9qQzBZbWJ5Uk9S?=
 =?utf-8?B?K3ppZlhPTE55RHByUDdrdVZKbm1rMmx2QkxBMFNZNXdBaWJDV2tTTDRQWmxD?=
 =?utf-8?B?SWFLc1JqR2VYMUVIb3Z2RHlLZExmR0lnUGdvSWk1YzBHaXg1M2VqWGFGem9D?=
 =?utf-8?B?TnBybDFvMWpLeVVHNmVsY1hTRXlmbFhCTTJEL3VMcGV2ODlEeXBNdnplMXNK?=
 =?utf-8?B?UDNYSjI2eFVlaXI2Tmc4TE9WZFRYdUU2RkNWZ0wzQzB1L0xQNWJKT0pjMlB1?=
 =?utf-8?B?dTdSWUVsZDA4T2NQTm1PL044YUM3WW5uZGoxKzZaK0d5bnBWL21va0JselFT?=
 =?utf-8?B?RHZQYnptalVmSWtjdHBOVVUvc29VOWIxY01TUnUySmdLSGtDbmYxc21WVlpY?=
 =?utf-8?B?RUJZVVlUY2k2YlNPOU1aOXYzS0ZkRnhPVXhpS3loVGpwejlzUGVaVHFKYnEx?=
 =?utf-8?B?bklTZEx5cDQ4RHgvb0lhYTdwb2pzU2ZPQlcrMHRQK2VRZUp0bnRHNjFDMGhP?=
 =?utf-8?B?UFFBVXRFMFF2SXBqOFlOdGFGRndjUUl5eWM3eWxjVmdmYVpHZmZJanh5M0sy?=
 =?utf-8?B?ZGtrRXh4Y0wzMUlGVnNTMm5qd20yTXlxek13NmM3T2lmaXd3MzhlYkJDTlFk?=
 =?utf-8?B?MTRGS3hobXJyMEhCdXN2OThxV0NVL0lVMGtBYVlQMjBpaElOSWFsQTNQOHBk?=
 =?utf-8?B?VHBuc0ZIdlAzK1MwdUt6dStoMWxCb3hPcE5LRTRDV1VVMk56U2RGNDlUaHA5?=
 =?utf-8?B?NWgxZktpcDcySjFGV2YwM3hnWFFLeWdqbzc2R2FoVFZDQkxxL3VXTGNCY2w5?=
 =?utf-8?B?U3d1MnFNbjYyY29OaGRtSFdBWXU2V0xXb3lZVmg0MEZFc216Tzc4T01GRmJ5?=
 =?utf-8?B?dGNoNHlRY1d1OGRyNlBBakh3M296RTV0S1NGditBQ0hJUXVJSkY2MFlEY3lE?=
 =?utf-8?B?UVMwN0p3VFNlRHJicHNIRURLU1AvbnI2dHZnVVZ0SlM0eUZjVDdZb05HcnVZ?=
 =?utf-8?B?bkw5UkF3TW90UWxGOWprb3dSTEVsSm1vNy9sUndqNjFiWUJZOUdHdWJBRTVw?=
 =?utf-8?B?VzhJOU5SZzBtTEN0VGhiK290WnlaMGlySVhDY0lmS3N2UGpCdDZWSEpEOUVM?=
 =?utf-8?B?b1BUb1VkZWNDdmg0QnowVEdheSthWWwrUktjQ2RsdGR1dGF2emQ4SkwvVzF5?=
 =?utf-8?B?aFNDWCtmZWl2ODBHelJVcWIyZWZNRS93aDcrWmtMbnh5Mi9XMU9pdldiSDhO?=
 =?utf-8?B?MFBVZ2syRUhBK0pzejBFNkhVK1JwSWRIZG11ZEo2MVl3SDdBUjVLQ2I4V1Fh?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c438c13-6934-4c78-3d05-08dad3c24a7d
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 17:34:25.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqIStqwgzlNLcwMTY0X5sbSf5Jrj+TrAVTlti6c03jV2T7VRpy4SzySFwAswl1d2CzTc8OkRe8vb5DGSVfxD/vsp/82vZIfUrUksGPCVfzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9019
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2020-05-26 06:22, haibo.chen@nxp.com wrote:
> According the RM, the bit[6~0] of register ESDHC_TUNING_CTRL is
> TUNING_START_TAP, bit[7] of this register is to disable the command
> CRC check for standard tuning. So fix it here.

Which RM? I just checked imx6sl, imx7s and imx8mm reference manuals and 
they all show bits 7~0 is for TUNING_START_TAP.

I have been experiencing some infrequent hard to reproduce communication 
errors with an SDIO WiFi module on imx8mm and wondered if this could be 
related.

For example:
ath10k_sdio mmc2:0001:1: failed to write to address 0x129ec: -84


Kevin

