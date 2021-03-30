Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9100C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 21:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B597961953
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 21:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhC3VhD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:37:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhC3Vgb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2021 17:36:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOe5q011567;
        Tue, 30 Mar 2021 21:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VVmQMCfDGZcQiW8suG6MkAFcPAGlGxOFMJHLB/Rc6mU=;
 b=l621/FfT2J36RA+lqg7dFd3e9VEPYRjKgf0lEXF7ShPkl6Wlcb/M5WUanJQ6OKJRjM+J
 mau4kbcSLb8Mt9RI56agI6fMnp78ihTWRr6uIuZBKQTJ54TJPb3spqTq1mBQzYnqI/Yt
 msaDzNy4hOJa057ognDz9Utl1rkAdXfA6nORHMZwq9n1+x5ID+p9JVn01Yi82Yrq6miG
 f0T7rhgwtoyXkWUHk2eHrY4xQFdSgE69ikAL58d0J+XDqWK06hGxK6/Qt9qwbEWIx/Wa
 9fajqpqd/MpjCxBzaHxdJZTaqqi+/ho9pIrsi5tftJdtnuf9/F0fbrblqK5LX6NUwxex zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37mab3g9hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:36:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPR5p105742;
        Tue, 30 Mar 2021 21:36:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3030.oracle.com with ESMTP id 37mabkbmu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU6IL7tnxL1HZYM7o2XrLXUvEWCW1sRWxj0pCD/Qs/LpoFGBg7O8jNyBWp7h2Gy3ZrVdpTuvWI6OMWt6Bp8xebW24zLa2xBr3fC+YbKUzxv0ngAa6Re4dBj5KQWrYG1LWKGu3YT3e6ZZ3szhzq1byyPoNj3IGYCxyLvcOVFgAzNfLXf9Koeers6R7iPR//KWdigSGo2Y1wDcEryzzc07ge5SiPNWb/MuKiCAHDOBio+W4wwHM0f7DcKu5NiKSo9mUkP6mu5S9jhLSBG6A5xO0y0K9Nqk4e28xiB24JDT3gg+RWqCKiCIdbrbacqZrHfnxqTLAvzc/MYiNuq0CW4weA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVmQMCfDGZcQiW8suG6MkAFcPAGlGxOFMJHLB/Rc6mU=;
 b=oY3ii5t8e0iJvW3CXnCYh6b0t9Uve0FHV9PEKO87bcgx7AcL7mdVpbNlYGbl99eFKfLmjt1r+GprGf5pkUhkFyLlTeC1RUyZVjRyNIk+Azk/L1LGOLZTaSe/FxmdNTk5Df492LKuQdmj3hTgJnj0qquuGvqGIWdzwboTJoKo/9YCY4/1nJJBk+9uGrPnSG6uFK9cph9/srbFDTBhtFwU9i99vT+LXcIFwr8YRcAVlS00/FG9H09Nk0ONoUksgHQVLvrKpTrL3K2l0++TniBqUdl2V70vFr+0cU7gfphRhqsFktlx+VQl1K2DXMk7xB+RFY4EoTgb2QZCmes8UKFSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVmQMCfDGZcQiW8suG6MkAFcPAGlGxOFMJHLB/Rc6mU=;
 b=Iz2Bs6qX8WMKvlEYf1YGNdic3+z46e0FR8RQM/GF0Za+felZXZMl17jdNe0tHztuFwU8oFMsoDLrXwM/AXcc3lEwrXfTla+Fzj2MRmTRRaKebMqZEzeqp3G40U1DyWUo+KhHVal1AMhrlsoNJG81SmJ3YfK9w9XsFZOTw3p43Vs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR1001MB2261.namprd10.prod.outlook.com (2603:10b6:910:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:36:13 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::79ca:ca5b:119d:e873]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::79ca:ca5b:119d:e873%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:36:13 +0000
Subject: Re: [External] : Re: [PATCH v2] mmc-utils: Add eMMC erase command
 support
To:     Ulf Hansson <ulf.hansson@linaro.org>, Bean Huo <huobean@gmail.com>
Cc:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        kenny.gibbons@oracle.com, rkamdar@micron.com,
        Chris Ball <chris@printf.net>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210324164408.14722-1-huobean@gmail.com>
 <CAPDyKFq8oMH-qga_d+EP2T1xbCbq7PHK=ZkrUp0JaWmdcHYvRg@mail.gmail.com>
From:   kimito.sakata@oracle.com
Message-ID: <7a774027-ad2c-21bf-8cb0-eaa92a76bad7@oracle.com>
Date:   Tue, 30 Mar 2021 15:36:11 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <CAPDyKFq8oMH-qga_d+EP2T1xbCbq7PHK=ZkrUp0JaWmdcHYvRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: SA9PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:806:27::28) To CY4PR10MB1815.namprd10.prod.outlook.com
 (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by SA9PR13CA0143.namprd13.prod.outlook.com (2603:10b6:806:27::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Tue, 30 Mar 2021 21:36:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb7724a2-d2a3-4f49-d78e-08d8f3c3d7bb
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB22613943C31C6980366F12609D7D9@CY4PR1001MB2261.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jp89kCsCPJfnuCdzLdk3JIZmqx66l/uUmYW869F8312omKBWzywgiS0Xbbj4AZTD/uj4O1/89yeCE4nCJK6oGiYpgkf4BONfgbsqV4mFqgjvMSGX/eTQ0zHdYxLQJSmSZelwmvhWjY2CWwpSZS30fI/wH8jRM2qmiLvcSswx2Go34ua0FWq7ge0u6GL/p+8LM+2JCcacK4m94ABKu+A4rNRguXtMH263Q2YqV7aFwEqgA6+kCSuEVMGD2VGBcGNhBBdp3Cl8jW+09api97U3SNqbDw9dFSRQdlAg7X/n3d8bj2BEhx0NbtBvOYNhSY7UaVt/83Vp+igqXtQE3CeNA53mue097Ey8pJbZI8HTUOwufmeYG/OR5JKMedDFKqEgMsTZgBuy0j+gM2j/8PDOuhLdmfCFzmj3nE2fj/PlYMAMHMLs1kfnFqT3xg8lGUGj7laVa0QITtd2CIV2ZGpd8H6Yg38vVQgMeZsTI+TpvCjo4q63hGRafQu0simmIdPilPVBPCVnjSc0TjjnYjXIPfOYhyKHDq3Yj5BOBei4MMqKTBWlYeXMVj4wU5tKiWnAEl08NlN+Qo1dFEj5PjUv6k+X5JoPlgmPU8LTNCxeaaTae+/xKF9zw2yoaeOrnMbWEEDgQntCA35EFdRBJoVf8CJARNVz0UOaLtELj9gbA6nvDR1ARTaZyxcexzTltD0N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(396003)(366004)(376002)(66476007)(316002)(2616005)(956004)(8676002)(83380400001)(8936002)(478600001)(66556008)(110136005)(16576012)(9686003)(31686004)(4326008)(66946007)(86362001)(5660300002)(36756003)(2906002)(53546011)(6486002)(26005)(31696002)(54906003)(186003)(16526019)(38100700001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Qjg3TDA0OHlhd1JYTlVNNEFIa2hJbEJ4eUs2RTlEeEQ4R0ZEcEN2WTVnN0xB?=
 =?utf-8?B?RkM4Q1VScXJWdjQzcUdHSllJcFR0WVFKaDZsR0h6SVlJU3R2Yy9FU1hFNld3?=
 =?utf-8?B?bnFQb0JaaFEzTkdmMkhQMGJSOWVjS0pXMXV5aXBqRmRVUGJUQXV0RFVwSUd0?=
 =?utf-8?B?TDNKQnE1N3R2N2N3K0xQRE03MzQ4a3BBUGl3Wk5jc2E0eFdtL0pDM2JaOVF0?=
 =?utf-8?B?cTdheHNSUmR0MTdGbDVLeDU2SnFJM1lSMVhKOUhTamNWZzdTZmVJd21jQjNN?=
 =?utf-8?B?M2FpeHRFejVyRWo4VERPVkV3L0JqRzdGaXM5dEN0MHhlSGhpcjRJZlcvUW9D?=
 =?utf-8?B?M1hTaGhDN2JwYjZob0FHZTJBVWxNWS8wZlZOa1JtZVN6azVEZUhjd0JRWGVQ?=
 =?utf-8?B?c1FJSDdJeTVmcjZVU3FLZWovZS9LaWF4UExHTFZMK3dXcEtTQzBPL1JESldS?=
 =?utf-8?B?QVBORG5lalN0NkY3MC9QU0IxWGVRNDRPeHIrWXRhT0FucWNxaHpyc3g3NklT?=
 =?utf-8?B?UVRYcEd1OFZlMU1BMkFjMGtrUmthSFJ4STV1MUtQVWR3bUNXaEhjUjZWMlVs?=
 =?utf-8?B?VDNtMndYaDR3aGlINFczL2pRQTlXSTZlYnp6cDI2azVDL3F5aldXekVXR3hT?=
 =?utf-8?B?TTUvSU5ITkQ3WTA4ZHFGT0xGb2Uvb0J2dGxRcllYSUgxQXFmRkw0M29BelhS?=
 =?utf-8?B?K3p1WFlmcFREQ0JyYjczc2RFelpqdlUxc1l4NmJ2MVF3aGx3K3hOekpUNU1k?=
 =?utf-8?B?bWJBV0dyNitIdXdxNXR5dHpKVm81dWVxYnJ2SldnWTVhWEQ3OFNzZm5Edmx3?=
 =?utf-8?B?QVNRV1ZzTlZOZElvd1Q5WlFidFBRSEJlMm9sRmlNWHpnQ2ZHNWJwNFlXZFdJ?=
 =?utf-8?B?UUhKVmt2SzEyZ2pQSWtPcnhLdFNqUHdvTnR3ZkRjQTN2Zm5BdUFiaVltdnFx?=
 =?utf-8?B?Zm1WTjA0YWw5aDVNdE44dXAwTkQ1MlZpWXhGZkIvU1FtaE9PcG5UUEZJd3Qz?=
 =?utf-8?B?aU5SaGk0bkg1UHhlS3dCeGV6UmtKOFBhY0UzanVLNHFPbVlPcFpMYlRuTmla?=
 =?utf-8?B?dkVvRnBpLytiOXErWWxiQStQc1FZUmRWMGtEelFtYTdMT1dxK3d4a1hPNWxV?=
 =?utf-8?B?ajR3ZktaQnc5eVJJZnF0c3hVQjdEWWhCa3lQY1o2RDF3L2EyT2R4dkdsd1By?=
 =?utf-8?B?UktQNzNLa1NNTEpEaHdsOEc2dHcrUU5keGVPZzY2S3NRTWRCT3o3ODZUVWsr?=
 =?utf-8?B?YWcvcm1RaHpReXgzVHJ1dnlRN2Q2VGp3RHI0QXlUOGpVV3ZEakVRcDdYNUNi?=
 =?utf-8?B?U3d1ZnM3d3NSZkxMRUNCaFg2MDNLdm5yNDJoaTFwKzJrY2JNbS9oSEMyQzdM?=
 =?utf-8?B?eWpOT092ZFdqZUk5cERDVHIyY1ZnQzY1L1Q4RDlqRTlvU3BSTXRWM25qeXJJ?=
 =?utf-8?B?Qm8vVlQ3QTQzZ1dMeXhob1FPbzkvNEJTQTQ0aThvTlpOblFYNjVrMHRnQ0kr?=
 =?utf-8?B?ZUVjVzNUMGdMdWU0UjREdUlGMFl1WnNBWStGeVUzZXdIaG02NGRNaGZhUE9q?=
 =?utf-8?B?YkpEdFhlbE9YM2w4dEQybHpSVUcxdDdxTnNlNG9SSVdBQlM0MmMzazczcWp0?=
 =?utf-8?B?elF0M1BMSXFvY0xSZGpZSk9jOGRkYVA0UUVVRnVkNWp0SUJ5ME9QdmZRaHcy?=
 =?utf-8?B?ZXp5c2ZlUCtwVHRmUEFqODZSMVdKTS82ekRUOXFZS0FlRkg2VHJWZkVTaEF6?=
 =?utf-8?Q?Tz17iqZAkpc1ppd12DYizL7YCnWwA8Rqf5kl7ca?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7724a2-d2a3-4f49-d78e-08d8f3c3d7bb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:36:13.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: py9PswGdKQVDQSh1PyfebxxHVfk3OoANgAP+Hve9WLQRxR3j/03+9rQKpbUY3RhcYee/uEAGDofrUrQI/qAwfajXrFt8/+XW34z34AJdEJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2261
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: RsTbwtpiyZSYQVlF5t7mgWcTcZQTO5Nn
X-Proofpoint-GUID: RsTbwtpiyZSYQVlF5t7mgWcTcZQTO5Nn
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 3/30/2021 6:39 AM, Ulf Hansson wrote:
> On Wed, 24 Mar 2021 at 17:45, Bean Huo <huobean@gmail.com> wrote:
>> From: Kimito Sakata <kimito.sakata@oracle.com>
>>
>> we have been using this erase feature for a while, but it is
>> still not merged into the upstream mmc-utils. Especially, for
>> the customer, every time when they update the mmc-utils, they
>> should re-install this patch again, let's try to make this
>> erase command upstreamed in the mmc-utils.
>>
>> Co-developed-by: Bean Huo <beanhuo@micron.com>
>> Signed-off-by: Bean Huo <beanhuo@micron.com>
>> Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
>> ---
>>
>> Hi Ulf,
>> Please help us review this mmc-utils patch, and if agree, it is
>> possible to make it merged in the official mmc-utils.
>>
>> Changelog:
>>
>> V1--V2:
>>      1. refactor Kimito's original patch
>>      2. change to use MMC_IOC_MULTI_CMD
>>      3. add checkup if eMMC devie supports secure erase/trim
>>
>> ---
>>   mmc.c      |   8 ++++
>>   mmc.h      |  13 +++++-
>>   mmc_cmds.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   mmc_cmds.h |   1 +
>>   4 files changed, 156 insertions(+), 1 deletion(-)
>>
>> diff --git a/mmc.c b/mmc.c
>> index 50c9c9e..cb29a65 100644
>> --- a/mmc.c
>> +++ b/mmc.c
>> @@ -215,6 +215,14 @@ static struct Command commands[] = {
>>                  "Run Field Firmware Update with <image name> on <device>.\n",
>>            NULL
>>          },
>> +       { do_erase, -4,
>> +       "erase", "<type> " "<start address> " "<end address> " "<device>\n"
>> +               "Send Erase CMD38 with specific argument to the <device>\n\n"
>> +               "NOTE!: This will delete all user data in the specified region of the device\n"
>> +               "<type> must be: legacy | discard | secure-erase | "
>> +               "secure-trim1 | secure-trim2 | trim \n",
>> +       NULL
>> +       },
>>          { 0, 0, 0, 0 }
>>   };
>>
>> diff --git a/mmc.h b/mmc.h
>> index 648fb26..90b7fb5 100644
>> --- a/mmc.h
>> +++ b/mmc.h
>> @@ -34,7 +34,15 @@
>>   #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr   R1b */
>>   #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr   R1b */
>>   #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   R1  */
>> -
>> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr   R1  */
>> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr   R1  */
>> +#define MMC_ERASE              38    /* ac   [31] Secure request
>> +                                             [30:16] set to 0
>> +                                             [15] Force Garbage Collect request
>> +                                             [14:2] set to 0
>> +                                             [1] Discard Enable
>> +                                             [0] Identify Write Blocks for
>> +                                             Erase (or TRIM Enable)  R1b */
>>   /*
>>    * EXT_CSD fields
>>    */
>> @@ -61,6 +69,7 @@
>>   #define EXT_CSD_CACHE_SIZE_2           251
>>   #define EXT_CSD_CACHE_SIZE_1           250
>>   #define EXT_CSD_CACHE_SIZE_0           249
>> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
>>   #define EXT_CSD_BOOT_INFO              228     /* R/W */
>>   #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>>   #define EXT_CSD_HC_WP_GRP_SIZE         221
>> @@ -177,6 +186,8 @@
>>   #define EXT_CSD_REV_V4_2               2
>>   #define EXT_CSD_REV_V4_1               1
>>   #define EXT_CSD_REV_V4_0               0
>> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
>> +#define EXT_CSD_SEC_ER_EN              (1<<0)
>>
>>
>>   /* From kernel linux/mmc/core.h */
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index fb37189..17986e3 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -2435,6 +2435,141 @@ int do_cache_dis(int nargs, char **argv)
>>          return do_cache_ctrl(0, nargs, argv);
>>   }
>>
>> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
>> +{
>> +#ifndef MMC_IOC_MULTI_CMD
> In kernel v4.4 we added the multi cmd support, which is quite some
> time ago. So, I think it's time to drop these ifdef hackary from the
> userland tool. At least, we shouldn't need it for new kinds of
> features that we add.
Ulf
Do you want us to take out the  MMC_IOC_MULTI_CMD ifdef and resubmit?
Kimito

>
>> +       fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
>> +                       " support, needed by erase.\n");
>> +       return -ENOTSUP;
>> +#else
>> +       int ret = 0;
>> +       struct mmc_ioc_multi_cmd *multi_cmd;
>> +
> [...]
>
> Kind regards
> Uffe

