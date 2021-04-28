Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF513C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Apr 2021 15:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815E3613BF
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Apr 2021 15:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbhD1QAX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Apr 2021 12:00:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41534 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhD1QAX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Apr 2021 12:00:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SFjjnI135029;
        Wed, 28 Apr 2021 15:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=U8y2bQicoSfYhjtOjW0Is2c1f+sO5khzCErlhsh9tP4=;
 b=t+2poWkq/Sq09ADOhcX3gGkuBojvkrTRZVqSGya7Cq+rKfaKcQDgQviW95kBjA3G0JZe
 TiRqVxFEjszuBwJp36EIRqT5IoT+96kcTA9+ZagniFdSBlupurEdXD/G4QKEo/iVy/QB
 BfftZDCCg+fHqJWG+r3MCB3l3r4Jmx/3rOeepfAs2nEoIG6GIZWc+CjCORgDYzzJGgVk
 8FXWnkHF7JRAtn+WeT6p1L+be4enbre09oT5Tpgkw6GomBqnSn0KZ2ZPc0hiIjTf0xU2
 pnw8e28Nzz1qK+x/pm5ylxUX7sn54zsFUmhIs1IZQwK9drw4LaWhiVHbVjx6T9Sr54dU jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 385aeq1buu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:59:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SFlCh9077372;
        Wed, 28 Apr 2021 15:59:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3030.oracle.com with ESMTP id 3874d2838v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:59:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJHc026cyWYp9HXOQZo9b9lolInleNpUtm2mZsw5JJ7pgGgTXV24y3NH/xuXhkCpvhIq96VlCgk+9hr5Ff2qrgoTcwXjmw9EwYdSLTLdiKZl/+aZ7iRRX3vgXx1gukS14YBhZ0afL+VADfcE3ZQ2FxGaXicJKDoqmmeKM3XNeHQnHnkN2ku7B/pBQrzTuusgg4k81YOm7T8w8NDqGZ+Dvuezktistv8Vp3UKvwCvf0BqWjgBblxIyzLxJ/IFH1YqWGREYSwIhCeCkGSscgPMC1Wd/hfp0O14bcaG+QaG7cl2/rGl4pamN6gGWhCxfd6zDdyLoHLjmU3kVijON+AETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8y2bQicoSfYhjtOjW0Is2c1f+sO5khzCErlhsh9tP4=;
 b=akWI5QB5rI9NG723iWkf3TjxWhPjtLmQ7oc2InIz6YwjeiVaJdeaJZB2a9801AoPmXcYox8lfrr1hIJnwQrKGtHl3MV5+1Iu5xPd+IEORWy0qENxrTr01FpXP92zp5jj+yDCnJUVfKNSfIUUTvDShkfsDCbgKXTl8qXHV9SkKYFAqD1zPvEfMX421X4D/gpi3nSgp1qNaoUpiJYcIjHXuYzvC4i0plinbAbH0i81RhGqx48S7RwFnk4QZ/37IuXRcFJg2t0Rs2F5XqJQHf6zvodooFIrO6quKALm61Da1GklNi1LCBIrr7eDJUHznEfMQZujzHfP3v9TVN6RlgfYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8y2bQicoSfYhjtOjW0Is2c1f+sO5khzCErlhsh9tP4=;
 b=VLfLa+32xForg2hg8eVpw1jjntZudDDENY3jbtRB1PyhAFTVKCXHkjqpBrPNI9+/RFNx4gLZyLVWRVw34hKZZPI81bxo6ajN+/qbj9h2fQz9rQKwOr0DcjykcUf4cnU4o9hnPfa429xeZ9ASXXvkIxuwuxFwizKDvM7QFzolae4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR10MB1366.namprd10.prod.outlook.com (2603:10b6:903:27::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Wed, 28 Apr
 2021 15:59:16 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc%6]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:59:16 +0000
Subject: Re: [External] : RE: [PATCH RESEND v3] mmc-utils: Add eMMC erase
 command support
To:     Avri Altman <Avri.Altman@wdc.com>,
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
From:   kimito.sakata@oracle.com
Message-ID: <535e8934-5c7b-4315-6a13-4b53c241d933@oracle.com>
Date:   Wed, 28 Apr 2021 09:59:13 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <DM6PR04MB657542B3CB77F6D894B1EA84FC409@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: SN6PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:805:66::18) To CY4PR10MB1815.namprd10.prod.outlook.com
 (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by SN6PR08CA0005.namprd08.prod.outlook.com (2603:10b6:805:66::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Wed, 28 Apr 2021 15:59:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c158533c-0e36-4b33-ca0c-08d90a5e936c
X-MS-TrafficTypeDiagnostic: CY4PR10MB1366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB136649EF39E584CD383CA1D89D409@CY4PR10MB1366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6svecI5I2PY4k1sIOPwV9DtmOaZp4w9Kvkl2bdzPS5eEXsx4nqPxmwOz3k2sHl5AVYjOV+juYQx2fab6Jm9/q2AxwPe4KfdiJCiH0qgdc7LIThHOYd8qcUxm3RGvaYtc3d/s8KbdTRKpA7iD8JQld5Abm3MOPXxqGgXaQNj4ES0lJyD8XW0qFGM/AkSPi3L/XQdBTrrj8Q2qzBZI1O120VjYuQECAKR0VLMDjzrG9oE4YHnBzFzDn7ctwAcBSAjG8suXVvOq1WzFEYwxgfgIRWaPZAZNZCKCwgXP4MQ3zRwAsMdXc0FyWEdrmwinCZ9owiVRYrepMrIFPdsoJVrcbaNStcW/uuCcaR8J8MHHYTW5t+BO2ZO/jDg242VXg4ULYNRp8nreHqaLdoQFZ3WHOlsMsVJpsLsE/0JRjq1vQzpdPY5DoFaMntHV5uflN5WSZiUb2P/PRqg2aei6+7MpP8ln+H+3DwpvkSY8Dp+SThpEpNuTxPwd944mJNP1+HIEaDrOVsqc76elgJi1uzw+GBk6lGB1Ozsrl1BoVIzgBNrerE8vM+hSNWCvXmIWi2EdZ9GvMmYiyd7NYsUdiUijSMMDO4vI5m/TfHasPY6+Rb+ze+iVyNLDzUqUKQ2kYvMWNiA/gXNl/G4nhUGgTCkifaYL1jcLK61rFL4DmirPS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(366004)(396003)(346002)(8936002)(36756003)(2616005)(110136005)(5660300002)(66476007)(478600001)(956004)(86362001)(16526019)(66946007)(31696002)(9686003)(26005)(66556008)(186003)(2906002)(38100700002)(8676002)(31686004)(6486002)(53546011)(16576012)(316002)(83380400001)(54906003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T2xRYkViQlMxVitsVHVBOUdXd0dxeU1vOTI1OGZWV3RkMDhyYjYxeVZncDFO?=
 =?utf-8?B?K2VvNnA2b3A3NjBqM1BPODBiQW1ZSklacmUrSVkrekhueGoyV3oxOUhRTDVk?=
 =?utf-8?B?RlJtNWppK2pZT0RhRFJhVzFEUHRuUFUrMTFnZWhwVkxoK0U1L2lLbXFqdk0r?=
 =?utf-8?B?UWNMazBxTFpUVXZYTG9FT3M2YUVXTmMyREZKZUdDRk5BT3ZkbTYzbE5sQ3Mr?=
 =?utf-8?B?U2krY2hXMTJXTjQwbUIrbTkzQ3hPTHNwSmJ2N0lkOU9aUDJ3S3QrUnJ0WVJ2?=
 =?utf-8?B?R0lPMUFtbXZ6QyswaDl2aGFIRk1TeGpCYzd0RDlUNGRCejMzRmNmNGdBNitO?=
 =?utf-8?B?ZXh2WlF1djhuaGRZbks4ZlFiTCt0M253SEVjK1ZpY2hFUmVPdTZZL1R4ZEhn?=
 =?utf-8?B?SUErVG5qd242V05iTFF5bVdYL0RvaHo4b2tDajZ4eFdDcmJ1U05rMVV4RkFB?=
 =?utf-8?B?TUVjQ215ZzNlS2liZ290czloVEdIdzVJNGVKUUw2RjJCNE9SNW5waDFGeDdq?=
 =?utf-8?B?Mm5vMHJsZnlMU0duWmFwVmtqNUkvMGdONVJQblVnQTMxa2FKQ0ZrSVNkbEd5?=
 =?utf-8?B?ajUzOGtuQXBzWmhwZHRYMkVHNGhOZTRjdEZ3UTl1bUJxQStyVlZHcmtUQnd4?=
 =?utf-8?B?NENkY0dobURnOEVRZ0JibEIxa2didVVJMnRFdGY4RUUyTmR5OHlGbTM2NndV?=
 =?utf-8?B?V0JENndSUnlCajRldTJiQzhlM3FsWkFJVW12ajZqVW1KdVY5WTN3Z1FZT3FL?=
 =?utf-8?B?OFg2eTJDSEZMdUtZc3Z4SkNZOXVsbHdvYXo2R2RiWlkxbEY0L3FLdHpnK3o4?=
 =?utf-8?B?SmRYelN4aWo5WjBjcE9nc1V2SUpTbzMrNUNGZG5neEJhbldncWIvQzY5a00x?=
 =?utf-8?B?cGJhTnpPbDhRR0JRY3lIRUdhQzhJRTNiZzRQK0pzMzc2YVFLY2orNDhFK01K?=
 =?utf-8?B?WDlWYWdlaUs0RU5Xb05MLzREWEV2SkFJV3hPUWVqOHk4NzQvWkRlUDRMam91?=
 =?utf-8?B?Y0puZkoyQktVajM2dkNLaVd2dFBzUFMySVlmZjdNa3FTVU1rSlBSVTRhTVFm?=
 =?utf-8?B?QnhMdGxSRmRNdnNON1haYVhYZUd6dHJiM29sTHU1clBLLzIyUnBDUnF2YkZV?=
 =?utf-8?B?aVFmUDJHNDF2d0VLbDIzQlFjZTNwWDZQNHFVTDJxQ05vMUNxZlQ4YTUxb05o?=
 =?utf-8?B?enp5WnlhZTUwVGJuUFdnYWJzWDNTWUhoMzVuTzU0OWZOWStMemJ2bXorTkxX?=
 =?utf-8?B?QVV3U3lJTjBPY282TU9XL29YSUZNc1NLSG45ZWp2cWVLZTVHa2ZCaHhVR0Ev?=
 =?utf-8?B?eVpSMDFyd29xUGlKTmtlZENzM25NajNYREpnVkF0QmR6YjFFVE0zSTVPVlBP?=
 =?utf-8?B?Nm00ZzErWTYydEtETVJHdDdQdnFHY0xybXF5cE5Sci9sQ05qRFpubmJNTUpG?=
 =?utf-8?B?SEhOQ2MwcGNBblNlVTVUYXBzQUlLcERUS3h4aU55Y09aWHVaSDMra1U3cnVJ?=
 =?utf-8?B?SDJJY05qNXJnNmdSM1h1VlprZklHWjFMek5Hem42SGZzb0lhZnk2bHpLY1BD?=
 =?utf-8?B?WWZBWXNIaGJMNlpPVVdXTlpsTmM4d1pyYk4rNXFxazZCcU9udFZySFdmTVRH?=
 =?utf-8?B?bms0TkV0WmZJQzFVek9iQnhlaGlWUk9DRjVFbXZFWmVuak1JMnV2MmdySFh6?=
 =?utf-8?B?UWQrNW5seGQ3ekZXM0pvMGZhNmpFaGNob1RzWVB3bFVHb3FtN3BJSngveVh4?=
 =?utf-8?Q?fOHu0UiZtSKx1a2JxQG5OubrZu305qEWUXMkhUX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c158533c-0e36-4b33-ca0c-08d90a5e936c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 15:59:16.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JX3/nx/LR8ZwQgPM9ENNld/j+xM3YB5EAFUTfp6xC17p0iAGpQFtBV908x7Vb9cXDgHB9hIzHDRZflZC1dFVnmW6zoYayedNP/eM55jUOMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1366
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280102
X-Proofpoint-ORIG-GUID: VkrvhtJqjSSyDhPFKdPNa2ht2aCi5vjQ
X-Proofpoint-GUID: VkrvhtJqjSSyDhPFKdPNa2ht2aCi5vjQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280102
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Avri

Thanks. I will respond to you when I get the chance to go through all of it.

Kimito

On 4/27/2021 11:57 PM, Avri Altman wrote:
> Hi Kimito & Bean,
>
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
> You might also want to indicate on which platform it was tested.
>
>> Co-developed-by: Bean Huo <beanhuo@micron.com>
>> Signed-off-by: Bean Huo <beanhuo@micron.com>
>> Signed-off-by: Kimito Sakata <kimito.sakata@oracle.com>
>> Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
>>
>> Changelog:
>> v2--v3:
>>      1. Remove redundant ifndef
>>
>> V1--V2:
>>      1. refactor Kimito's original patch
>>      2. change to use MMC_IOC_MULTI_CMD
>>      3. add checkup if eMMC devie supports secure erase/trim
>> ---
>>   mmc.c      |   8 ++++
>>   mmc.h      |  13 +++++-
>>   mmc_cmds.c | 130
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   mmc_cmds.h |   1 +
>>   4 files changed, 151 insertions(+), 1 deletion(-)
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
>> index 6c24cea..24f80db 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -2514,6 +2514,136 @@ int do_cache_dis(int nargs, char **argv)
>>          return do_cache_ctrl(0, nargs, argv);
>>   }
>>
>> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
>> +{
>> +       int ret = 0;
>> +       struct mmc_ioc_multi_cmd *multi_cmd;
>> +
>> +       multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
>> +                          3 * sizeof(struct mmc_ioc_cmd));
>> +       if (!multi_cmd) {
>> +               perror("Failed to allocate memory");
>> +               return -ENOMEM;
>> +       }
> I am missing reference to ERASE_GROUP_DEF.
> It affects the timeout, size of erase group etc.
> Don't you need to query for before starting to build the command?
>
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
>> +#endif
>> +}
>> +
>> +int do_erase(int nargs, char **argv)
>> +{
>> +       int dev_fd, ret;
>> +       char *print_str;
>> +       char **eptr = NULL;
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
>> +               start = strtol(argv[2], eptr, 16);
>> +       else
>> +               start = strtol(argv[2], eptr, 10);
>> +
>> +       if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
>> +               end = strtol(argv[3], eptr, 16);
>> +       else
>> +               end = strtol(argv[3], eptr, 10);
> You are not really using eptr - maybe just call strtol with NULL?
>
>> +
>> +       if (end < start) {
>> +               fprintf(stderr, "erase start [0x%08x] > erase end [0x%08x]\n",
>> +                       start, end);
>> +               exit(1);
>> +       }
> Start & End are in bytes for media < 2GB, and in sectors for media >=2GB.
> Should also check for legal erase group restrictions.
>
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
> Maybe use an enum for the erase type to avoid the strcmp?
> Then need to update the usage message.
>
>> +
>> +       dev_fd = open(argv[4], O_RDWR);
>> +       if (dev_fd < 0) {
>> +               perror(argv[4]);
>> +               exit(1);
>> +       }
> How do you differentiate between mmc and SD devices?
> And for SD you should send different commands(35/36 vs. 32/33).
> Do you intend to support SD devices as well? In another patch?
>
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
> EXT_CSD_SEC_FEATURE_SUPPORT might also contains the sanitize bit,
> as well as reserved bits that you shouldn't assume they are 0, so I am not sure that this condition is correct.
> The checkup only refers to bit 0 and bit 4 - maybe add a helper that accept &args and returns 0 if allowed...
>
>
> Thanks,
> Avri
>
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
>> 2.24.1 (Apple Git-126)

