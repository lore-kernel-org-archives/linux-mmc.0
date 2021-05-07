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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE69C433ED
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 15:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2870B6145A
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 15:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbhEGPT2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 11:19:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36064 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhEGPT2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 11:19:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 147ExfjD012259;
        Fri, 7 May 2021 15:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xM4pVlREVAZZtKV6/2TVMq22Zn+5/pJeDeVFLpJOeFU=;
 b=GTK3Oxe0+N2RJFtkFR/edSXMXg9UwyP5znZ7ytBQEve7XPGyXqY5J0o6yi6e1QrW56oi
 6JMkVCxcYKUPvo514v4PIId6pKLqqkTdaOks7bFYrP7W8BpF/ajXEJWgpjCSUdfuOeYR
 zDNMu5LRgJeeYApmUCyEwtGYJhwBqIr5qPVpaeljrv9QV4yrS4HvI4VKxrc1DcpZ2hIA
 zMVJTFLrp5fbdokXeMAOiZ8HirSi77pyNr8zh9CwzMJgNnIvncUOW0DhSESTA/PC4vD+
 TZOjS++xd+nSx0+kxZALb4YK1PdEnam6ArMhc6TDFOMz0OYZf3JNriIPMlljnYl8c6QC kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38csrd9yvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 15:18:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 147FFkG7014180;
        Fri, 7 May 2021 15:18:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3020.oracle.com with ESMTP id 38csrhb6k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 15:18:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH7VSoLFTVKfp1gmyNHsOIJDSscLjkjsnBDFg93eSpih4vDTKozQTw9h5LkF/MuLY61JEpl1DcE3/vPD+dLlBomCf/9fUXJnfGlE5xceO7TXJRXPaSDKXtAiSe5xPbyyRNpm4BfFWg/jfvMUa1wCRtGT3+fBSxgScS59Sd0fJrzGz56e+XFnmapG7e5TqVVb1/Uav1B5uN4AgI/f3EHiNYWY2BNbmTI7rZbYAYNxicTjuCVPFaXScA2uDZaGH4aihqkcc77ZOGS/wClf3LnmYqI21wWwdK5bPqF7NV+49ZYPiyRycLz8VqFAV+39tI3BKIO5YUpujP/eEigTIhZP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM4pVlREVAZZtKV6/2TVMq22Zn+5/pJeDeVFLpJOeFU=;
 b=MaijuktUvbaEH3x8lZMapRTpiSIlLP6zfCfIbeLTQGEaZ8BRCKIlHnApnHmQj2Rd81AVMo0czQbE4qR60ZEbBWeYWG0mu4KGYV602vrAgn9oMMzOL1dhbYTFOV1Y5J5Jnh6GOxhpuLx1zbkO7EuRpfXLQ26z4IMPsRmFRrWDTDiUYJQAIDyFsbpoUe5DNMA93P7R+l8redzy4qhSjpuBBkf9RUL37jwJscTePgYxZu3/hG8HrDEXwsx+k9Oi7BtJoj8ay/+wx2oDaJOoaGpMVjlgoKra2I3d7T86gW4tznxTGnf3AHDLUTUjfVwwW2xya0O4So66Ux6PkXGCCJeABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM4pVlREVAZZtKV6/2TVMq22Zn+5/pJeDeVFLpJOeFU=;
 b=hIPgiRKXI+Lf7llfVi/GJGDh2Zu2LLiyvY3ij8nOJbvs4X1PLC2xufco1+1ZuVC4+Boa/NEO1F90jSVG0Dm2YlEG+9BqhYsPydZlgtyvvfVQjs7QjSnfEbXS7PVVWgQVvJKKDe4UN9Xs5Z41iOsb2TTxOXekW6toA+59lI/2cfM=
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR1001MB2055.namprd10.prod.outlook.com (2603:10b6:910:43::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Fri, 7 May
 2021 15:18:19 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 15:18:19 +0000
Subject: Re: [External] : RE: [PATCH v4] mmc-utils: Add eMMC erase command
 support
To:     Avri Altman <Avri.Altman@wdc.com>,
        "oracleks043021@gmail.com" <oracleks043021@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>,
        Kenneth Gibbons <kenny.gibbons@oracle.com>
References: <20210506191041.1178-1-oracleks043021@gmail.com>
 <DM6PR04MB6575AB417EACE5AF3E006723FC579@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   kimito.sakata@oracle.com
Message-ID: <81b71c24-6ae8-2b09-5310-9d1d55ee2d1c@oracle.com>
Date:   Fri, 7 May 2021 09:18:15 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <DM6PR04MB6575AB417EACE5AF3E006723FC579@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: BYAPR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:a03:117::26) To CY4PR10MB1815.namprd10.prod.outlook.com
 (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by BYAPR08CA0049.namprd08.prod.outlook.com (2603:10b6:a03:117::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Fri, 7 May 2021 15:18:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15fcb63e-2da2-4bf2-6fc3-08d9116b5884
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2055E3E2F273F9FC7B6931D79D579@CY4PR1001MB2055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvK1iADMJuY/FMlxRXN1PU3f6I/RgY4OEJc8yIw/GLhIm9jPoW5KjFpCN8PnXCUWKL2zz5TWZ7HUdfCR466giEYwPeJyKBArQzHM0EikmNjRCezYhV+lIcAIYDRD3pWz01tZs/nqdfMvH3g6VAIJ3CQPfS+qa3dC/fmFYvybJ+N5P7x4g7AsiTqWWVxoKDhOFoHz/Qkj2hg1tQ7/TSIrPwrMFw8oU3Q1ioK/gB9mCaCIhRkDvYHi04yHnOEBlw3jUeN/lAGgy/eWTyI0dGkuYAaTCxV9CN5KX7U794KGzpGfKV4MIUM7mDPm2exsu8yNuHyORsg+i5xvyoKZB+Cp06s8yWYVJCAcqEpEOBV0DjdDFxfcn/qEDZ+YwxpG+iS8GTnPs1sBcNFicUsfCtRi//9QruMZiRTBzZiWmxO5v7s7FMqxLHKBt8jrGDWyrgsD0LPhNa/jdWOA9tL1KqE2cMY5MU8OvbXBEWtbgfxPEk748eLO9b+FhJT3Ddd106S5lGsjJnDZMYgV2Hx4P7c0yblPe+XkS5jo/EJBYsJhdkfc2DIfmhi9c9neoLXhl6ihOKMDh2Zi5/54QZ6br2fmMfrWm9Ab+DP4WAbKCKytDMxXH+WkWWAyB6L/T0oyErzbL1YQsRhuh2YzfvxQfNU/NDePsf0aFCW6nU7e4kvesNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39860400002)(478600001)(4326008)(66476007)(66946007)(66556008)(31686004)(110136005)(107886003)(316002)(16576012)(8676002)(2906002)(8936002)(54906003)(16526019)(45080400002)(186003)(6486002)(86362001)(956004)(31696002)(2616005)(53546011)(6666004)(9686003)(26005)(5660300002)(38100700002)(83380400001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WEdydEdpdThYVkxadDY5TklSVUdvUEdleDVzZ2xPekdiWWowdHUyaWl4VXJ1?=
 =?utf-8?B?cytYQVdrSUhHeThEREFjNGZKUXE3bW1OWC9uaFNhenF4b3FseXhKd01VckFK?=
 =?utf-8?B?cFZ1dVNLazNTcjZGaUpxMElRRTVTRkpoZ0tYYi9SaW1Lc1VuOFd3aG1yWlpv?=
 =?utf-8?B?cmhLakdTRndFTTJLeWlKNXNadS9XODduK281Mlpnb0d6elVHTjZxZHdxRUIz?=
 =?utf-8?B?cjlYbndlZ0dHZ0IycUlIMGpnUXBxd2pVc2ttWmN6aVJVVG55dWlnWFlIYmZY?=
 =?utf-8?B?K3RoV29oc3dKZjhLclRpYzBFVG16ZzltcEIvMXRTUXNkSUdzUDUzcmIyL2d0?=
 =?utf-8?B?WjBSUDZsODZYRnhsQy9vQ1dLS2JIL2lYc3IwaXgrQ2JpUEdrejBaOG1GS2oy?=
 =?utf-8?B?TFJCblh5ejZYWnc2b2JueG9IK1hURnlwZEd1K1FPeDBJN3dRcFhMWGdjMkV5?=
 =?utf-8?B?K2xhSXBtNnRkZDI3NzlobkpCZ0Q4NVMvQnI4WUllSTI0N3BkZkE2aEFVUWgz?=
 =?utf-8?B?cGIzR1F6WkRZcHNSd29ORHQrRzdwNGpFUEVsOWRleTJORXRBRk5sRGZ5N0to?=
 =?utf-8?B?Y3JOM2NERlhDY0JyTXNxb29rcUtSN1c1ZmQxaGQrQUdVNlVEQksrcHFtZUxp?=
 =?utf-8?B?MUlHYVlNUFFwOC8rblJMdkhicWRQOGxGbTRNL3RtT1ZhbHN0YkxXektOLzlz?=
 =?utf-8?B?R2g1UVBFOVFIRXhmamllNFpmNmplMG9hcFQvU1o1OFJVMXFvZU5IeWlncSsz?=
 =?utf-8?B?S1oyWXdpS2tIbjFJdTdzKzJlWGE2RzkxTFVvRXZYbmdEVSt4c2JWZkcwdjU1?=
 =?utf-8?B?VUUyOFF3MFNicHpWRjluVkNraUMvem1raXAvSElXUWR0RUVSVXB4dUlmMEk3?=
 =?utf-8?B?VW13TFVxbXJCQjZZMWVPdE84a2YyV1F0T1pLR0c0bjRYWS9kUFl2Mkh2SWwy?=
 =?utf-8?B?bW1iMFlFYXU3enpYYXc0cm0wb2s3UnFab29ETzdCeXN4L0d1M0Z1TmwrQ2c1?=
 =?utf-8?B?K05CVlh2RzJYdkdiSlhya3pKVjcvd0pURS91R29RU3dWbFpvMko2UHhsRGpT?=
 =?utf-8?B?WTlTRHdtS3Y4QVpET3MrMVlWN1dxMWx5V0crMmtvOXZWTlV1RUJhYXUzaGNs?=
 =?utf-8?B?dyttQkFidm1nTXVaMU1vOTJLNWV1VWJyK2c0Sy9YMHl6MVVoN3k4TnV5QVd6?=
 =?utf-8?B?RGxnNmdkMEtRMG5aODZXWDFZUk1EL1FleFc4Vnk0L1NEdy90MzU1b3hWZWEr?=
 =?utf-8?B?U2piakJaUXhMVlpkckhwRlh5UmlwbDBXaTZpekRrOEVSZWlFZ3ZqQVRqTS9U?=
 =?utf-8?B?WG5QZVc4Qkd0UTFxdGNVMVE1VGhZNnMyc1lVK0NZOGhOZ1graWNrMllPbXJS?=
 =?utf-8?B?MEEwNGl2MTRrc1QxbUhpSHF3R2FNRmNsTStUNjY0MTJ3UWtzaGRTemFtVTl0?=
 =?utf-8?B?WG82a25VMk1UUjdLSFpyRTdFSXdvb3Q0TFB0cHBmb1lQWTZpZkxHM0ZrSXBp?=
 =?utf-8?B?Mm43YTdUMkVHOFRDdUt3SEwzVTFsWlVBMExyTlJFejNxQXUvUk1KWUtNeUYz?=
 =?utf-8?B?emxSdE5pdlBabXlPc1dLWGlRbVZHclN4RnUwZTVSWW9uZ2x3YWc1UzVoSFhk?=
 =?utf-8?B?cVhEYmMwbFhUS2ZyaUxVTngvaVA2Z0FPeUFQY3lCNmt6YWp2d2ZSdDhJU3Qv?=
 =?utf-8?B?aWpBYm9Rc3FoMm1KREdOMm5GUFJtdFVYNkM1VzZxdFVWOVl5QUR0dlozWkRi?=
 =?utf-8?Q?2IAg3X6C3QSIK0M7hlFiSrgyqrNsXtM1hoPSSqw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fcb63e-2da2-4bf2-6fc3-08d9116b5884
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 15:18:19.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOfI04+HsJK17mgh1FpB21A0nhIHRF/7NphE5vgj7XzWLfOXwtyDsjKy7CAjFoodIDP3YrokgcSj4Hyrbks/kJLX7Vu+DidpiQvzqud4j9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2055
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9977 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105070106
X-Proofpoint-ORIG-GUID: JzSciXTB7vWHPED1JXU8_IRdoS5OM-J9
X-Proofpoint-GUID: JzSciXTB7vWHPED1JXU8_IRdoS5OM-J9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9977 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105070105
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 5/7/2021 12:36 AM, Avri Altman wrote:
>> From: Kimito Sakata <kimito.sakata@oracle.com>
>>
>> we have been using this erase feature for a while, but it is
>> still not merged into the upstream mmc-utils. Especially, for
>> the customer, every time when they update the mmc-utils, they
>> should re-install this patch again, let's try to make this
>> erase command upstreamed in the mmc-utils.
>>
>> We need to send 3 MMC commands and it is important that they
>> stay in sequence. Therefore we are using MMC_IOC_MULTI_CMD.
>>
>> Co-developed-by: Bean Huo <beanhuo@micron.com>
>> Signed-off-by: Bean Huo <beanhuo@micron.com>
>> Signed-off-by: Kimito Sakata <kimito.sakata@oracle.com>
Thank you!
Kimito
>> Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
>> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> This looks good to me.
>
> Thanks,
> Avri
>
>> Changelog:
>> v3--v4:
>>      1. Replace unused pointer var with NULL.
>>      2. Added msg if ERASE_GROUP_DEF enabled for HC.
>> v2--v3:
>>      1. Remove redundant ifndef
>>
>> V1--V2:
>>      1. refactor Kimito's original patch
>>      2. change to use MMC_IOC_MULTI_CMD
>>      3. add checkup if eMMC devie supports secure erase/trim
>> ---
>>   mmc.c      |   8 +++
>>   mmc.h      |  13 ++++-
>>   mmc_cmds.c | 144
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   mmc_cmds.h |   1 +
>>   4 files changed, 165 insertions(+), 1 deletion(-)
>>
>> diff --git a/mmc.c b/mmc.c
>> index f3d724b..eb2638b 100644
>> --- a/mmc.c
>> +++ b/mmc.c
>> @@ -229,6 +229,14 @@ static struct Command commands[] = {
>>                  "Run Field Firmware Update with <image name> on <device>.\n",
>>            NULL
>>          },
>> +       { do_erase, -4,
>> +       "erase", "<type> " "<start address> " "<end address> " "<device>\n"
>> +               "Send Erase CMD38 with specific argument to the <device>\n\n"
>> +               "NOTE!: This will delete all user data in the specified region of the
>> device\n"
>> +               "<type> must be: legacy | discard | secure-erase | "
>> +               "secure-trim1 | secure-trim2 | trim \n",
>> +       NULL
>> +       },
>>          { 0, 0, 0, 0 }
>>   };
>>
>> diff --git a/mmc.h b/mmc.h
>> index 5754a9d..e9766d7 100644
>> --- a/mmc.h
>> +++ b/mmc.h
>> @@ -35,7 +35,15 @@
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
>> @@ -62,6 +70,7 @@
>>   #define EXT_CSD_CACHE_SIZE_2           251
>>   #define EXT_CSD_CACHE_SIZE_1           250
>>   #define EXT_CSD_CACHE_SIZE_0           249
>> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
>>   #define EXT_CSD_BOOT_INFO              228     /* R/W */
>>   #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>>   #define EXT_CSD_HC_WP_GRP_SIZE         221
>> @@ -190,6 +199,8 @@
>>   #define EXT_CSD_REV_V4_2               2
>>   #define EXT_CSD_REV_V4_1               1
>>   #define EXT_CSD_REV_V4_0               0
>> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
>> +#define EXT_CSD_SEC_ER_EN              (1<<0)
>>
>>
>>   /* From kernel linux/mmc/core.h */
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index 6c24cea..afa85b7 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -2514,6 +2514,150 @@ int do_cache_dis(int nargs, char **argv)
>>          return do_cache_ctrl(0, nargs, argv);
>>   }
>>
>> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
>> +{
>> +       int ret = 0;
>> +       struct mmc_ioc_multi_cmd *multi_cmd;
>> +       __u8 ext_csd[512];
>> +
>> +
>> +       ret = read_extcsd(dev_fd, ext_csd);
>> +       if (ret) {
>> +               fprintf(stderr, "Could not read EXT_CSD\n");
>> +               exit(1);
>> +       }
>> +       if (ext_csd[EXT_CSD_ERASE_GROUP_DEF] & 0x01) {
>> +         fprintf(stderr, "High Capacity Erase Unit Size=%d bytes\n" \
>> +                          "High Capacity Erase Timeout=%d ms\n" \
>> +                          "High Capacity Write Protect Group Size=%d bytes\n",
>> +                          ext_csd[224]*0x80000,
>> +                          ext_csd[223]*300,
>> +                           ext_csd[221]*ext_csd[224]*0x80000);
>> +       }
>> +
>> +       multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
>> +                          3 * sizeof(struct mmc_ioc_cmd));
>> +       if (!multi_cmd) {
>> +               perror("Failed to allocate memory");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       multi_cmd->num_of_cmds = 3;
>> +       /* Set erase start address */
>> +       multi_cmd->cmds[0].opcode = MMC_ERASE_GROUP_START;
>> +       multi_cmd->cmds[0].arg = start;
>> +       multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
>> MMC_CMD_AC;
>> +       multi_cmd->cmds[0].write_flag = 1;
>> +
>> +       /* Set erase end address */
>> +       multi_cmd->cmds[1].opcode = MMC_ERASE_GROUP_END;
>> +       multi_cmd->cmds[1].arg = end;
>> +       multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
>> MMC_CMD_AC;
>> +       multi_cmd->cmds[1].write_flag = 1;
>> +
>> +       /* Send Erase Command */
>> +       multi_cmd->cmds[2].opcode = MMC_ERASE;
>> +       multi_cmd->cmds[2].arg = argin;
>> +       multi_cmd->cmds[2].cmd_timeout_ms = 300*255*255;
>> +       multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
>> MMC_CMD_AC;
>> +       multi_cmd->cmds[2].write_flag = 1;
>> +
>> +       /* send erase cmd with multi-cmd */
>> +       ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>> +       if (ret)
>> +               perror("Erase multi-cmd ioctl");
>> +
>> +       free(multi_cmd);
>> +       return ret;
>> +}
>> +
>> +int do_erase(int nargs, char **argv)
>> +{
>> +       int dev_fd, ret;
>> +       char *print_str;
>> +       __u8 ext_csd[512], checkup_mask = 0;
>> +       __u32 arg, start, end;
>> +
>> +       if (nargs != 5) {
>> +               fprintf(stderr, "Usage: erase <type> <start addr> <end addr>
>> </path/to/mmcblkX>\n");
>> +               exit(1);
>> +       }
>> +
>> +       if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
>> +               start = strtol(argv[2], NULL, 16);
>> +       else
>> +               start = strtol(argv[2], NULL, 10);
>> +
>> +       if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
>> +               end = strtol(argv[3], NULL, 16);
>> +       else
>> +               end = strtol(argv[3], NULL, 10);
>> +
>> +       if (end < start) {
>> +               fprintf(stderr, "erase start [0x%08x] > erase end [0x%08x]\n",
>> +                       start, end);
>> +               exit(1);
>> +       }
>> +
>> +       if (strcmp(argv[1], "legacy") == 0) {
>> +               arg = 0x00000000;
>> +               print_str = "Legacy Erase";
>> +       } else if (strcmp(argv[1], "discard") == 0) {
>> +               arg = 0x00000003;
>> +               print_str = "Discard";
>> +       } else if (strcmp(argv[1], "secure-erase") == 0) {
>> +               print_str = "Secure Erase";
>> +               checkup_mask = EXT_CSD_SEC_ER_EN;
>> +               arg = 0x80000000;
>> +       } else if (strcmp(argv[1], "secure-trim1") == 0) {
>> +               print_str = "Secure Trim Step 1";
>> +               checkup_mask = EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN;
>> +               arg = 0x80000001;
>> +       } else if (strcmp(argv[1], "secure-trim2") == 0) {
>> +               print_str = "Secure Trim Step 2";
>> +               checkup_mask = EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN;
>> +               arg = 0x80008000;
>> +       } else if (strcmp(argv[1], "trim") == 0) {
>> +               print_str = "Trim";
>> +               checkup_mask = EXT_CSD_SEC_GB_CL_EN;
>> +               arg = 0x00000001;
>> +       } else {
>> +               fprintf(stderr, "Unknown erase type: %s\n", argv[1]);
>> +               exit(1);
>> +       }
>> +
>> +       dev_fd = open(argv[4], O_RDWR);
>> +       if (dev_fd < 0) {
>> +               perror(argv[4]);
>> +               exit(1);
>> +       }
>> +
>> +       if (checkup_mask) {
>> +               ret = read_extcsd(dev_fd, ext_csd);
>> +               if (ret) {
>> +                       fprintf(stderr, "Could not read EXT_CSD from %s\n",
>> +                               argv[4]);
>> +                       goto out;
>> +               }
>> +               if ((checkup_mask & ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) !=
>> +                                                               checkup_mask) {
>> +                       fprintf(stderr, "%s is not supported in %s\n",
>> +                               print_str, argv[4]);
>> +                       ret = -ENOTSUP;
>> +                       goto out;
>> +               }
>> +
>> +       }
>> +       printf("Executing %s from 0x%08x to 0x%08x\n", print_str, start, end);
>> +
>> +       ret = erase(dev_fd, arg, start, end);
>> +out:
>> +       printf(" %s %s!\n\n", print_str, ret ? "Failed" : "Succeed");
>> +       close(dev_fd);
>> +       return ret;
>> +}
>> +
>> +
>>   int do_ffu(int nargs, char **argv)
>>   {
>>   #ifndef MMC_IOC_MULTI_CMD
>> diff --git a/mmc_cmds.h b/mmc_cmds.h
>> index 9d3246c..8331ab2 100644
>> --- a/mmc_cmds.h
>> +++ b/mmc_cmds.h
>> @@ -45,3 +45,4 @@ int do_ffu(int nargs, char **argv);
>>   int do_read_scr(int argc, char **argv);
>>   int do_read_cid(int argc, char **argv);
>>   int do_read_csd(int argc, char **argv);
>> +int do_erase(int nargs, char **argv);
>> --
>> 2.31.1

