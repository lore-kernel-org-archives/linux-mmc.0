Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C34C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 14:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345F260FF4
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 14:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhCaObQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 10:31:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbhCaObE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 10:31:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VENlqX038393;
        Wed, 31 Mar 2021 14:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HkM7wW78M/0oZ+Ly6POnz5n9nf52fBst49FWLTxNqf0=;
 b=EMlAGLZ4v9yBJ6l96dejIs4rmqjykZLy9ui//T1Ch8H2QsleToyWaJTIBhjGFQp1djRr
 8JcG9/iL3D+BNj+7MzRAnFco8QAzCLWSnXiJ3b6e5ClrAbg6bSY4Q7+VC8BqEwcQshaV
 CKlfTtMV/GFs/G6cnnsxT0AIK7joiOw/8aM24gb218fi/PaHA5vEV37eOPel1O1xl1ZV
 sKrhC8f1rzcPTz4X5k2PUic96N3rZ4dkPUJOetMI+bVpAprHkTmHXXlcJzACTchSKiq4
 kpZ6N+epKfWA3Jf8BbRZaNzQec1zFVeL8YWIUf2Ba6dp3yw7cYLXROFK7pZ4gu0rNFUw BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37mabqtevs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 14:30:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VEKeeo187333;
        Wed, 31 Mar 2021 14:30:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 37mac5jb4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 14:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecF/bCR8qNOFM7TQqkNF5hG7dYNGRF4Y0i/HwAwzS14XcuUi2PiD39QLE8W+5wp+fd3lJLY9s5s9TwXZNAbPkaXtTmtt3FaXa8cmSC/L8ipQTB/B1M+hg9h5ESpeIjlaC71P7E0VWwsqt5OxsWNvJ9o1XFY26GQoytAe39zGIZqxyuLinFFKp0ArV9hbp2MGi6QBRpYeE5EXXSRBF06gYiPrn70bmKJ3ozPJQm+s0buVtVCrFqIOfd6CfWgpmSzM1FIa+PeNJhyWKXMdnyKu1GmpXxLNduUrzL823lvEQws4wUAQkHWphSGtx63TE+Lgmv1av1el7m53A+sE7fZykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkM7wW78M/0oZ+Ly6POnz5n9nf52fBst49FWLTxNqf0=;
 b=Mf42VDee6W9QVvW9D/WFPyWcrxzzf3W9ZxU9m5twbdF7LeWjUZH3vr21txqKmMnq399IS/rO5Le4umyuu+ZWl1tou6cmeKihAhnJuEmMCTGL0iOMc0lA11RK8jAFWKMbIY+o8b6U0L2fImDGcw9yVqazvW7DxMAfPi36Dy7Iz91SFUqNa6sMGbbXPhreKbWUcp8EHaGZXyc+gvub1YX2gvHMvUEQW82QBLZe3lJwhEKC1GDFkYYmCJY4URwuJOyVIyV+tv3Q33a+BLejMox96QdOp4w3oGi+ygm5eB/m/6FJ8hpvvIIqvQu4ztuFwyGPc/+xQKaK/M+NMRanAMY0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkM7wW78M/0oZ+Ly6POnz5n9nf52fBst49FWLTxNqf0=;
 b=MeW63ZHrLf36359zimL3wnmRiLkdwDJcL+2K06M8SArVMXvXgFCMvgL1c5RIP6BJnQ0pQOa5zIvqxWdaJeU5I36dKNCLFveWONpozeJW+PCJrLsQ67fe71TWuFuTpeL2lAHIsvp9hACDNjIJdNK/AyO+s+hWLA92SpZeAFIqnuA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1810.namprd10.prod.outlook.com (2603:10b6:404:108::20)
 by BN0PR10MB4902.namprd10.prod.outlook.com (2603:10b6:408:12a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 14:30:48 +0000
Received: from BN6PR10MB1810.namprd10.prod.outlook.com
 ([fe80::d041:ee69:6e33:5ef2]) by BN6PR10MB1810.namprd10.prod.outlook.com
 ([fe80::d041:ee69:6e33:5ef2%11]) with mapi id 15.20.3977.033; Wed, 31 Mar
 2021 14:30:48 +0000
Subject: Re: [External] : Re: [PATCH v2] mmc-utils: Add eMMC erase command
 support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <huobean@gmail.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        kenny.gibbons@oracle.com, rkamdar@micron.com,
        Chris Ball <chris@printf.net>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210324164408.14722-1-huobean@gmail.com>
 <CAPDyKFq8oMH-qga_d+EP2T1xbCbq7PHK=ZkrUp0JaWmdcHYvRg@mail.gmail.com>
 <7a774027-ad2c-21bf-8cb0-eaa92a76bad7@oracle.com>
 <CAPDyKFqva-50WytCMRfaFALf_Cy9xoce8pHBBTX7XXirqRKkqQ@mail.gmail.com>
From:   kimito.sakata@oracle.com
Message-ID: <f6c053ed-dff1-73f8-4f69-dad0c6278e71@oracle.com>
Date:   Wed, 31 Mar 2021 08:30:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <CAPDyKFqva-50WytCMRfaFALf_Cy9xoce8pHBBTX7XXirqRKkqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: BYAPR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::48) To BN6PR10MB1810.namprd10.prod.outlook.com
 (2603:10b6:404:108::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by BYAPR02CA0035.namprd02.prod.outlook.com (2603:10b6:a02:ee::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Wed, 31 Mar 2021 14:30:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1df7af80-01b7-4fc8-7a2f-08d8f45193f7
X-MS-TrafficTypeDiagnostic: BN0PR10MB4902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR10MB490212035A47C6CBCCCA19DE9D7C9@BN0PR10MB4902.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wcp2gfPh7twQuhOlqGbVsV2P+1pMfhjBr4u9rjhKQN802E661BlUyQ89Y41Pz1lkHkhFjjFgaUOgfVFOzktZRZrR+VE+9PMkv0acq51zgxZugV2VwRxnXAc7epzswPr7cVSHCjbTF9WL++fWQHsHQIrm/IRX9jD5psLHxHcv3pXOIj8HalLclzn6Z9PWnFB7AfnaldqxmRBZmWnUoTUlgpD7gFutjvpnRqRu4jgFZkoKwYCaYRUPtgqMex4r8JZQjuwB/k+G3QLyjekCntJspo087l58B1j3FlhLPeDmlnzItfS+Ebj2p5LaI3zv6cvMKii/DD4z7LNiaSun2lUK7iOoW2i0ofKMvrp5lDTjYiKMKMYJBiKGq4GqKxRlTUWNZ5dW+Oh5TbNYmdf8I2VxlxdsezhxX2/Vdrbcz8+Qledvyoil4VDh/ruki9qQOk7fo0xSjntmRm5LrDvEUZbWH6LpWD88VaVysoGpO1yvGwQ//4/CLAvxBj1MpldA1OrjbheKO4Mk0Ujis+U9e2QruZdws6FDEljSL5hKulnx2fFejFDeDbqKONGQQnaWtY89bF0A7RgUpjYF2CFMFtlT/4453PFvNLr/pApzWMcT391FVtGgNrcWUbiyoTOigJkRkMxiJIuKvX5qFn90Q2q5xUR3LEsR1E51F4XoFChsZzO2NtJ+4MFBtc0/6XD/qxGt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(376002)(346002)(4326008)(5660300002)(478600001)(83380400001)(316002)(38100700001)(6666004)(86362001)(31696002)(16526019)(956004)(2616005)(26005)(66556008)(36756003)(53546011)(2906002)(8676002)(6486002)(54906003)(8936002)(16576012)(186003)(9686003)(66946007)(66476007)(31686004)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZVhiOUw2MldOOVJ1UWkrQTF2UGpiVEV0NEtvV01TQmdPSjg3YkZOdHo5dUhv?=
 =?utf-8?B?dXUwYVFxbjYybUVsUWxuOVZjMkxXQ1JFVHdjVjVYTmt5SzA5YnZHZFBrb2hz?=
 =?utf-8?B?MGJJS203bHZGclZhWTFNcldjZXlNMnB6cDl2RTRUYkFGYlFlenJJN1hhY1Fw?=
 =?utf-8?B?NGpEOUJPNXdCTklscDlzNCszYnY4Ym5YR1M2RkRrVXVzQ3hOd3YwZFNyWHZV?=
 =?utf-8?B?d2JXNFZrU2xYRUFiR3d2d3dqc09WNHBMRmpSWkdENTk1WlZobHpvQURZY1Bh?=
 =?utf-8?B?N0RkZzdmMTkyOG9NSjV6SmRXbCsxNG1LUnJYNGdYNTJRQzA3U3BmT2I2Nllm?=
 =?utf-8?B?WEk5RHJTakJqUkpDaUpxTHBNOWxvVnYxMG8wSjBkTWF2TGRDVTI5MnZIbkpk?=
 =?utf-8?B?K0Z3NGIxcG1qcmVzZUNucWk4VjU3U2dCcWkvNFZid3ZiVFppZHlRWFptT2Mx?=
 =?utf-8?B?am1oSEVSWFJGMElPT1p2YXFoNWlydjNzNmYzUFF5OG9PbEROSmJuVVdkb0FP?=
 =?utf-8?B?RDFHV0wrUjNzbGFQU2RXVWZtTGpCWE9xZ25haCtROFdZdEF6V3FGVjlVc0V1?=
 =?utf-8?B?NFpFOG1qWlZZVkRsN3lTOWFCRnowcXUzUFJmRDIxRWV0YXFuTGF5NHU4aGZy?=
 =?utf-8?B?WThJbGxYbHBGblF5bGY1cGJBeUJ6czE3K1pYZjdsbVQ1SlRVZXBFbC9ZaTNU?=
 =?utf-8?B?L2lLQTh1eHNDa3VwNnZTOGdnY3dYNGNpT25VaDVESm5BbGFkMTROSDRXaloz?=
 =?utf-8?B?M1RnSmFDNlJWZ2RpKzNTbi9TRU92N1hVODVvNnhpV1BsbURNVkppSGdJSy80?=
 =?utf-8?B?Y28zNENieTlIZm52NnNHUGwvT1JpeTAyZ2p1VytHZjJyMmFWNm9kR1J4d09N?=
 =?utf-8?B?dGhESHVFdzJiSTlWalVycHc0UnViTTVnay9NUkxyQWZ3dzdqcVNPeFdlODBT?=
 =?utf-8?B?YU95VG1nd0l2L3ByWTNqeloxMzVTOG5ZRktQN0RJM1dYdDlpd2FqWC96N0hB?=
 =?utf-8?B?VERHSmIzM0tZMld5ampUa1BZR0tzc3ZSTmZ3VnFLKzhGbEdTMnFwelh4VFAx?=
 =?utf-8?B?R2JCdExyM0dCREFwRmNjcW9YTGtXY3JPVEI4V0JBWThBWm10T2lFMkZ2N05l?=
 =?utf-8?B?LzBxNzVZTDU5dEd3YkphdjBBWGxOekp3TVdHUjJLWnY3RUZqL0xKMFhFcDBE?=
 =?utf-8?B?ZDRsUDJvK0prZTBTS0tlSnZhSis1MUZrTGRTTG1IL0t0L0lvZEtKWEJRMFFV?=
 =?utf-8?B?M2k1M0Y3OVdiRU1WWGpJN2ltaTNwc0tBNE9PcW5pQWxEUWpLZGk4Y3BhNzd5?=
 =?utf-8?B?TTJiamEzZUlPK0gyUEMvQjNiMmt3TTRFR3g1cVVaWCticDRDc0o5dG9NbU1m?=
 =?utf-8?B?QnhZeGFLMzJpU3Z1QkpHUTZ5REJaU1BWWTMwVEh5VXJ0NzZLUXhWcnhKTnU2?=
 =?utf-8?B?bVpkd3BlRWI2MldFSyt0a3M0MG90bFhMbkRKZFNTcmtyWjAremxxUlFJMXdJ?=
 =?utf-8?B?ZXFodEtEd1l4U1RZNzkrUW5EZkNCYUZUQWxRTWFjM3VBMzk5cjlUNFhyK1lw?=
 =?utf-8?B?Qk5xaTc0VXUyV1NsQmJ6cDNwUjVJNG1xZm1ram01OG41a2hoeWZNWTAwTXNI?=
 =?utf-8?B?QSt6SVgxbFZhQks1b2ZsaThtTjRxNHZOMkFaMmJJUytYVGtzRzJqMndFUWhr?=
 =?utf-8?B?TVpjUWhXcUl5aHMxNnU5NHZOUEFkbklBbEZNTzlIcVJCbXlHVXZyUU1IazQz?=
 =?utf-8?Q?cGRnuE4HFjR43HaD7HUmSeG6qbPdz4L7Y4Xo4k0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df7af80-01b7-4fc8-7a2f-08d8f45193f7
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 14:30:48.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFoo8HQISeCBotXrN6kLOGO960F2aruhe+wPlSyntgGBWq4tO0yAcgtqmJ335E3TglmwZtOfT3Kn5GBMC2yQRBtZFxXzs7Ps9tA6mbmsqA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4902
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310105
X-Proofpoint-ORIG-GUID: KqGVvGuXcg2QwPt4Iuo0Bt9bEDXKBSYz
X-Proofpoint-GUID: KqGVvGuXcg2QwPt4Iuo0Bt9bEDXKBSYz
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310105
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

OK Ulf. I'll make the changes and resubmit.
Thanks
Kimito

On 3/31/2021 3:30 AM, Ulf Hansson wrote:
> On Tue, 30 Mar 2021 at 23:36, <kimito.sakata@oracle.com> wrote:
>>
>>
>> On 3/30/2021 6:39 AM, Ulf Hansson wrote:
>>> On Wed, 24 Mar 2021 at 17:45, Bean Huo <huobean@gmail.com> wrote:
>>>> From: Kimito Sakata <kimito.sakata@oracle.com>
>>>>
>>>> we have been using this erase feature for a while, but it is
>>>> still not merged into the upstream mmc-utils. Especially, for
>>>> the customer, every time when they update the mmc-utils, they
>>>> should re-install this patch again, let's try to make this
>>>> erase command upstreamed in the mmc-utils.
>>>>
>>>> Co-developed-by: Bean Huo <beanhuo@micron.com>
>>>> Signed-off-by: Bean Huo <beanhuo@micron.com>
>>>> Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
>>>> ---
>>>>
>>>> Hi Ulf,
>>>> Please help us review this mmc-utils patch, and if agree, it is
>>>> possible to make it merged in the official mmc-utils.
>>>>
>>>> Changelog:
>>>>
>>>> V1--V2:
>>>>       1. refactor Kimito's original patch
>>>>       2. change to use MMC_IOC_MULTI_CMD
>>>>       3. add checkup if eMMC devie supports secure erase/trim
>>>>
>>>> ---
>>>>    mmc.c      |   8 ++++
>>>>    mmc.h      |  13 +++++-
>>>>    mmc_cmds.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    mmc_cmds.h |   1 +
>>>>    4 files changed, 156 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mmc.c b/mmc.c
>>>> index 50c9c9e..cb29a65 100644
>>>> --- a/mmc.c
>>>> +++ b/mmc.c
>>>> @@ -215,6 +215,14 @@ static struct Command commands[] = {
>>>>                   "Run Field Firmware Update with <image name> on <device>.\n",
>>>>             NULL
>>>>           },
>>>> +       { do_erase, -4,
>>>> +       "erase", "<type> " "<start address> " "<end address> " "<device>\n"
>>>> +               "Send Erase CMD38 with specific argument to the <device>\n\n"
>>>> +               "NOTE!: This will delete all user data in the specified region of the device\n"
>>>> +               "<type> must be: legacy | discard | secure-erase | "
>>>> +               "secure-trim1 | secure-trim2 | trim \n",
>>>> +       NULL
>>>> +       },
>>>>           { 0, 0, 0, 0 }
>>>>    };
>>>>
>>>> diff --git a/mmc.h b/mmc.h
>>>> index 648fb26..90b7fb5 100644
>>>> --- a/mmc.h
>>>> +++ b/mmc.h
>>>> @@ -34,7 +34,15 @@
>>>>    #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr   R1b */
>>>>    #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr   R1b */
>>>>    #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   R1  */
>>>> -
>>>> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr   R1  */
>>>> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr   R1  */
>>>> +#define MMC_ERASE              38    /* ac   [31] Secure request
>>>> +                                             [30:16] set to 0
>>>> +                                             [15] Force Garbage Collect request
>>>> +                                             [14:2] set to 0
>>>> +                                             [1] Discard Enable
>>>> +                                             [0] Identify Write Blocks for
>>>> +                                             Erase (or TRIM Enable)  R1b */
>>>>    /*
>>>>     * EXT_CSD fields
>>>>     */
>>>> @@ -61,6 +69,7 @@
>>>>    #define EXT_CSD_CACHE_SIZE_2           251
>>>>    #define EXT_CSD_CACHE_SIZE_1           250
>>>>    #define EXT_CSD_CACHE_SIZE_0           249
>>>> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
>>>>    #define EXT_CSD_BOOT_INFO              228     /* R/W */
>>>>    #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>>>>    #define EXT_CSD_HC_WP_GRP_SIZE         221
>>>> @@ -177,6 +186,8 @@
>>>>    #define EXT_CSD_REV_V4_2               2
>>>>    #define EXT_CSD_REV_V4_1               1
>>>>    #define EXT_CSD_REV_V4_0               0
>>>> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
>>>> +#define EXT_CSD_SEC_ER_EN              (1<<0)
>>>>
>>>>
>>>>    /* From kernel linux/mmc/core.h */
>>>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>>>> index fb37189..17986e3 100644
>>>> --- a/mmc_cmds.c
>>>> +++ b/mmc_cmds.c
>>>> @@ -2435,6 +2435,141 @@ int do_cache_dis(int nargs, char **argv)
>>>>           return do_cache_ctrl(0, nargs, argv);
>>>>    }
>>>>
>>>> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
>>>> +{
>>>> +#ifndef MMC_IOC_MULTI_CMD
>>> In kernel v4.4 we added the multi cmd support, which is quite some
>>> time ago. So, I think it's time to drop these ifdef hackary from the
>>> userland tool. At least, we shouldn't need it for new kinds of
>>> features that we add.
>> Ulf
>> Do you want us to take out the  MMC_IOC_MULTI_CMD ifdef and resubmit?
> Yes, please.
>
> Moreover, we should probably also remove all the other #ifndef
> MMC_IOC_MULTI_CMD hacks that we currently have in the code. But that's
> a separate patch.
>
>> Kimito
>>
>>>> +       fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
>>>> +                       " support, needed by erase.\n");
>>>> +       return -ENOTSUP;
>>>> +#else
>>>> +       int ret = 0;
>>>> +       struct mmc_ioc_multi_cmd *multi_cmd;
>>>> +
>>> [...]
> Kind regards
> Uffe

