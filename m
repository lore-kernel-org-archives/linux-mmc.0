Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15934C433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Apr 2021 14:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0D8613F0
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Apr 2021 14:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhD2OrV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Apr 2021 10:47:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40066 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhD2OrU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Apr 2021 10:47:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TEckY6170404;
        Thu, 29 Apr 2021 14:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PKyzQUC2Eb2L1KL4Wm9FFw1uzFE04DwZnCn6YbE+QjE=;
 b=ep6N9Br99UD0p5fgzEkEALOfUrEJLeT0z3S3OlMrWtgxoTOtodM7HbZLICghzIXvUWHR
 KzMRpZgAGvjQVW5pqNWFrAxrbljVqYVzgK2Ehh3TjcS2HrW1fnEveEhCvzRWqIvZ+dJ+
 l4jA33Uvu44XxATtkaTaRdMnuNAR40NZmbouDAmw0+GzsNsDzKQtDMHWOCdmZcQfU5iW
 iiLCGS1bSEAVzk0zlJ3OpNSB1wqIz3r9kVYoFvv8d+2oHi6E6CVP1EVRsc5jCY/u52A1
 5FS8ty/0z6w4ZxBR6PqaLFKOeo8LYYPOzPs4b9I6CkWPEkkiCjPixF7HzWBA5DRpqmYn vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 385afq4q1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:46:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TEarOM086417;
        Thu, 29 Apr 2021 14:46:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3874d3mjj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D02BZcY3jVCtCltR/lytAUOac4Ory40XeoI/r5adZzxS+6rEw0m2kcYGNYW58fAF0FhjDYpkGerIZdGQcMzqY1cOavg0VKfIROPhmyZL4X92mhgBqYEgqhu9Jsh0VNfeXG2K2g1fSPhzu71fK7J1nJsYRzTRgKvtBCUdxwjGIn5mtMVMvn+A5z5Ph5ZSmjhyIN8MrwieCXvGKcdsTWgw+G29x+K9G4cr0EmssbeS+ANjBc2oEDm+LKhCwxNB5xuxQ7AwHTnphZCWAmP2W2yATbRWOF0QRwtZTRQeArOg1nw5ejI2KtgUikTMP1nwUsZE50apkcYGpY16cavpQCS9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKyzQUC2Eb2L1KL4Wm9FFw1uzFE04DwZnCn6YbE+QjE=;
 b=J2pPKHXwvw3JmiGdP9KP9lds5tCbKTHdNcCMl/QRhUHIFBWzsVGrVo6A9DV1Y0+cPwxCwKWc7VcRoPdoStCUzf4WCj3zmW2/qq2b/GK3rv1YtdshXBiuqMin3gugt50KKip0NKh/KifMWPvjNFi8/TWo68DGVdbxAQS0TM+NvXA1hwf8IlK0thFkkdxDOhbiOS/dhcmHC8L/uBOEzIwOmxrENWzpCUsgnSqBh/tlTUKiNZKv/5T2P2ahgSn7VRzHZ8M9P4dEKOKd4iC1WV/NeBU5uM5/1lm0q1ZsnW9OZMVGiyFBYVIxN9TVynDLptq3IbKfl/hDqaf3iFQVzREcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKyzQUC2Eb2L1KL4Wm9FFw1uzFE04DwZnCn6YbE+QjE=;
 b=tfWR9ItXZpGFyx0N7qVWSk2qkvEy9ZvaflbZp22UEpiF197TvQ72Jk/LmOsGVh2hnOMSUWtU7Fc68OfKDz97hmtN3y/BUxEpfDC6vz+ImgPtDvIiDFVKYR835lRTYWCmBFShYuBOiAYHseO4cDxNBJOmmbuIHtqX+pEOXP4pSR8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR1001MB2357.namprd10.prod.outlook.com (2603:10b6:910:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.27; Thu, 29 Apr
 2021 14:46:21 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:46:21 +0000
Subject: Re: [External] : Re: [PATCH RESEND v3] mmc-utils: Add eMMC erase
 command support
To:     Bean Huo <huobean@gmail.com>, Avri Altman <Avri.Altman@wdc.com>,
        "luserhker@gmail.com" <luserhker@gmail.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        "chris@printf.net" <chris@printf.net>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210427195157.26568-1-luserhker@gmail.com>
 <DM6PR04MB657542B3CB77F6D894B1EA84FC409@DM6PR04MB6575.namprd04.prod.outlook.com>
 <b14312f5e6c2bcf711397a7c26782710b7a4707b.camel@gmail.com>
From:   kimito.sakata@oracle.com
Message-ID: <6311bb59-45cc-e1dc-b30e-4173edd8a8c5@oracle.com>
Date:   Thu, 29 Apr 2021 08:46:16 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <b14312f5e6c2bcf711397a7c26782710b7a4707b.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: SN6PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:805:f2::43) To CY4PR10MB1815.namprd10.prod.outlook.com
 (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by SN6PR04CA0102.namprd04.prod.outlook.com (2603:10b6:805:f2::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 14:46:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb16cb3a-9aa9-4115-bf63-08d90b1d8dad
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2357308B2DC838AAC7C654EF9D5F9@CY4PR1001MB2357.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szc/YLMPPCbqvfEFQ0/tHRUrOCDbNOZX+/JbbUGPjR/rsTKALAwnDyykQAanEcybISJ77Dhg6j97x1h66h8L8nf3Jy7N3q/ungPeyG3DmcHYNGZPKkl94isujiI4kiCNAmIf7aGPAdMWRBgDxPGO2hHrNhsEmOxEsDsFAelBrybcXlrF6EHPg1n0QRY16K79MpKLPQ5VmhNLvFcieIR6G9Qvlj/W6/lZVvmGkc7U3I1vUbSEVyXzDtWGMhA2O0GOUcFGcBibcDD7AV5Wc/FLqKkAeTCZQB7cfCeY5B0quEjoxRS4JUbOOIkmkHRgUfIe6LakBd5sDycOWJVZi3erBvOqMmRjYRtozZjkgrS0omK8rdkMEDKZObnuBfCaGsmrffR0wGwfnbkH0mE7tsGVUSbTQJSAToQhxSBLQSfHb8L+V4vyVC3yXeLqbZWrTneiQaA3g/5jId/uNoWBUi1JuLSyRpFPKDBKMJzx7g5rIMKUy7Xos9nr85NoGBEEhoW7ZxlYGZY8wKy2kUbTac4HHRFaL2XSECuXbUI9saW/uJSm9gV/hVKRY+8Z1+u0QaGW7XFS6qbIw4RdllYAVixE5On9c3qsce69dytomCPDv5AyIWXe4QhrSadBNDygofGVorHoSWaviR3MKPkJbKgX41SO5Z+53pV0btOvqaYKSPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(376002)(346002)(956004)(5660300002)(2616005)(9686003)(36756003)(53546011)(66476007)(66946007)(4326008)(2906002)(66556008)(16526019)(6486002)(26005)(16576012)(86362001)(4744005)(31696002)(478600001)(110136005)(8936002)(54906003)(316002)(6666004)(31686004)(38100700002)(186003)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a3ZSYjYzV0xHRGczTWNJVWFPQU5WOUFDcVFuQjhKSExoblJDNVBtMUhLc3lq?=
 =?utf-8?B?cHlGRHVFM1VVN1VFU0RDOVR0WnpRaWtiSGxmbHJKdktCSVAwWHgyeXRwcmpO?=
 =?utf-8?B?ZlMzU292ZXNreEx4c3paV1FKTzFHTGlJOExjamRTWUtid3Y1SVVRNXRMcHZ5?=
 =?utf-8?B?em9RREZpTUt1VU1aNlhCMFBZM2tlamc4RjRmWjNwOUduV3VDTklwUzR2cFZr?=
 =?utf-8?B?T21ZQ05FaCtGbkh2ZVZRek1wOHN0bXAwdlo0TGVQN2ZXSUk4a0NHaGJ4SlFl?=
 =?utf-8?B?YVpERENkdWpobjYzeFZzS2pobjF1QldwM2FhRGNIZW5KMVRLL2pZazY5M0dU?=
 =?utf-8?B?dmJrMGVuMERtSS9FemFmdExHYnhEWDlPcmZDY1VudTFRdFdqc3YrTVlteWY5?=
 =?utf-8?B?VkN0TldiZ2djclFtb0dUSEFKeHhqZ3FGM2twYy9YVzBkRGlBY2d6aE5JS2xj?=
 =?utf-8?B?aElZdUdWNCt0Q1o2b0xaWXZEb2ViWktXSWlPMVdKeSsvQ0ZTeitGaFdyL1gw?=
 =?utf-8?B?Uy83aFYzUHdOY0tVenIvdkN6VnoxYXMzcmlmY2pvdTZySmF6RTJKTS9WcUFw?=
 =?utf-8?B?cCtXUFBnOW1YRXpTSFhSdVVXWVBBSG1od2x0RHhPa0tpMVAzWXR4NWxDWGxQ?=
 =?utf-8?B?Z2c2Z1UrRWxkN3BBdzlYTWRoL1hlT0tWbzBFdisvUlhSQUhOWUNZQld5RWU3?=
 =?utf-8?B?VU1wbmtqcW9mSlE0NW5KWmdsaCtyVnFCVEhBQ1NsTk16bGM5T21zN0JmMFJP?=
 =?utf-8?B?TmgrZUJ4aHA2ZW14WUdpN2N5VUpYNUdUNE5Gd1RCY3JrWFpMdGxPVE56UnJH?=
 =?utf-8?B?ZFU1YmZObXdXeXRRUmhEeFZMblpwSi80Zk5LYUdQQXQxYWRYdmIxOVUrYWlh?=
 =?utf-8?B?bm5PYlJSWFNUTGdYSHk0clBSaHI3UER1Tkg3V2FSSmFSSWtyckRSN084TnBL?=
 =?utf-8?B?Wm12bzFvK0h4RnB3WTV3ejhYZTgwLzRUaEg3dkZJdWJuL2RZZ1dDVHhRbG9D?=
 =?utf-8?B?bVQ0bS9SWkFvemYyQ1p6STg2bi9vMFlWbENkQ0hCdStIa2ZhM3Evb1RNWEhT?=
 =?utf-8?B?aDNSR3B6dHM3UXVjYStxVGd6aURyVUVGemtaWmpzNktuVUF1WEgzZllIOWtl?=
 =?utf-8?B?cUE4OGc3NE1IYkxJckRRM21ocHNWZXo3Mm1mVFVudzF2UmkxWHFXV0JpejNM?=
 =?utf-8?B?K2lFZ3NwNHA0eUMvUXJLUkRsSHRJR2ZKVGVqNDBrRzlISzcyL2tHRXowdnpm?=
 =?utf-8?B?SHQrMnBmcmpnbXNidTY3OFZqakZYQUVJMEFWR3VCTDY5SHZxU1J1N2VmY3Ew?=
 =?utf-8?B?d2hJR1JVVUh2S3VJZHF3WUFwUkxwNlRVa1oyVnN2QUZkd2Y1VTZjdjBpdFFQ?=
 =?utf-8?B?N1l2M2tvUGR6aFVkak9VdjZma3huQ2FqRDljS2NEbU0wek8zMzAwaGw2RHFC?=
 =?utf-8?B?Tkg1dnVCTFAyYTBWL3RZWmgrY0N6RW0rYkNNTFdGTTBsT0VrTGhXVVNoend5?=
 =?utf-8?B?Wkt3QVl0N2dtMklPT0REakJXOUlKUzdnZXZ1QUtJS2lpTGZaZHlBSVdOdGJQ?=
 =?utf-8?B?SUt5MzErdzF2cVFPcU1pQnd4TWtYaVk2cXowWG5aVXkrd2t1cTVXeTRyVU12?=
 =?utf-8?B?OXEvRGZCUUJhYmZVT2U3bE1WdlAzYXlzQ2hUbkgyQzIxY0prZmIyV1drVHMx?=
 =?utf-8?B?RjYwTHZLbU45WkJBaC9QRzVKeURHKzF5OWpjcDRwajYwRmFjcGN2S0dxSlNX?=
 =?utf-8?Q?sRMZOlv7LIy80meaf0Uq5r4bXwbCypZyXogXHTz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb16cb3a-9aa9-4115-bf63-08d90b1d8dad
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:46:21.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMtvi2YrdZQ2uW8OZZzQnR4e+d+oY99nAQqiUlzpZUrUo9RxMgdjZ8sKUm9VJouLu1DURqp5BQx61vVfSGA7iz12MMkTOkO5h4r66nX+DPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2357
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=987 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290095
X-Proofpoint-ORIG-GUID: VrqTMeDwdQMrqbVPtQQEylenhBnvb23H
X-Proofpoint-GUID: VrqTMeDwdQMrqbVPtQQEylenhBnvb23H
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290095
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thanks Bean

On 4/29/2021 6:41 AM, Bean Huo wrote:
> On Wed, 2021-04-28 at 05:57 +0000, Avri Altman wrote:
>>> We need to send 3 MMC commands and it is important that they
>>> stay in sequence. Therefore we are using MMC_IOC_MULTI_CMD.
>>
>> You might also want to indicate on which platform it was tested.
>
> I tested on HP laptop PC X86 based and xilinx Zedboard ARM based.
>
> thanks,
> Bean
>

