Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9B1C433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 14:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BCB611F1
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 14:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhEKOeq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 10:34:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62960 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231760AbhEKOep (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 10:34:45 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BEFk1G005177;
        Tue, 11 May 2021 14:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3p/q/qHrzOOK6gTsvHCtXjimLltMeSrIJKZyHBnEWjo=;
 b=CLkRBIaXl/2P3HvQYIJ3xzMdk0QtLz5lrWwMOEdl5ltjE1hfrkSU6x5EWmYakqAqO5R0
 qHo6olPlLnVWQ2RYPtcCMgltxTNmNfcbXVTDvBqHQz5MXa0I0Jw/gCQFuXV0/7eIfn/q
 id81z/v0s+aOebutTM5il9euAa0tDznYi+gwNMPt5Gw6veK88DGhqOUB+y3WwjgcYcDp
 CP5eVfyQ0JSlRkO539ivD0jgc4uqhUHm7sZagsumSXA2yjk+FUnTH5S1C82/lKo3+rmq
 QrPeB+DryF5HvblL9SqpC7SpHWiD7Q7OomIQzqBpwxFAHv0oW9lnvyPO7Z6VesPTjxzR OA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38f5ag8a43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 14:33:35 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14BEXYXC004455;
        Tue, 11 May 2021 14:33:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3030.oracle.com with ESMTP id 38dfrxbwy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 14:33:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHPwVZcYSYh082Q5XraRdNcPi5kQaRQuO2E+ztx5u3/IW0fRKovaV3e1ANMJulbvXcgorV3GAnUAM4eSNTrX+HCfmHB49Oi9ERsL4XtG2ifRkOIxm+M3ta4z4Otqfa5Dy9dnPQ6q4448NwsMcFiETDhq89IfsmjOnBCy9DcQobF2xoRege5w3e+ZiCt8z0QD80CxIHpY/ceVHyqWV4kdwaoI6gxlh5eS5zLuDPGrimKCB+gV3xh6+gwb8T0f6dxIVYgmO/DAXUxcQ1qz0UIs+yGl+Vxg6CB0vlATWWr9p020cnP8QfQFw//ASR6SuJ7DvSt1EutrG2pixPTfmrRMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p/q/qHrzOOK6gTsvHCtXjimLltMeSrIJKZyHBnEWjo=;
 b=HMJ4u87SN4GZczThIEBNKYLjV6SkrPztOJDFiVBQnwk3ezD4fRz/bvL8g/oFfRAlL2VSKO8KpM0QNewkevKJGfTgwWpDw9BU7oHGeXYCx0co5cuCf2CXCczMMXWq5UxmF9Wmpx8m/G0F0Dv9gmqBZBN8dXDmEw8h3MCXuPtfzzjgWXKsECyjjYoeqRIiRHeX3PiWwAGrjlVS/sFKBAhHZ6nsXqCtHlxLvIlQlK1dhk/jLPUNLFsUbXiFYr8h5SjKVVkfi02///p0PJGLZxhDRk11mo3BhybAkl/++yncR1O2fuLalHQfKj3zTngg7+CSW1i1/anM39HZJZvQJ9ux6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p/q/qHrzOOK6gTsvHCtXjimLltMeSrIJKZyHBnEWjo=;
 b=sY5akQjTUumnS0LiC8+HNy5F4Qt6TGi2tujqfpLbWZmfj0bliC+LRDjQjLTLLbBRTpX9QQQ00gSapgPhXycKGDWUc4fXA7K+Ya7RlhstGIB+DvMhEcSe4VyQQdsk4M6rFguykrh//m6qyYsQZEacRerrPjG9wN8izmi6lO9Io4I=
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR10MB1446.namprd10.prod.outlook.com (2603:10b6:903:28::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 14:33:31 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc%6]) with mapi id 15.20.4129.025; Tue, 11 May 2021
 14:33:31 +0000
Subject: Re: [External] : Re: [PATCH v4] mmc-utils: Add eMMC erase command
 support
To:     Ulf Hansson <ulf.hansson@linaro.org>, oracleks043021@gmail.com
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>,
        Kenneth Gibbons <kenny.gibbons@oracle.com>,
        Avri Altman <avri.altman@wdc.com>
References: <20210506191041.1178-1-oracleks043021@gmail.com>
 <CAPDyKFrj6LAEZq6+8vcXTU1TH=yq7+k9FoWX6TDEVB+NSa=KEQ@mail.gmail.com>
From:   Kimito Sakata <kimito.sakata@oracle.com>
Organization: Oracle Corporation
Message-ID: <4a46ec8d-8fd9-14c1-d84d-b1adc56d8f23@oracle.com>
Date:   Tue, 11 May 2021 08:33:27 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <CAPDyKFrj6LAEZq6+8vcXTU1TH=yq7+k9FoWX6TDEVB+NSa=KEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: BYAPR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::38) To CY4PR10MB1815.namprd10.prod.outlook.com
 (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by BYAPR11CA0097.namprd11.prod.outlook.com (2603:10b6:a03:f4::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 14:33:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5ed11f4-2f86-4f50-56c7-08d91489bfe4
X-MS-TrafficTypeDiagnostic: CY4PR10MB1446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1446A1BB3BB672F9B35960C39D539@CY4PR10MB1446.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDLqIJHlFU4umV1QS7Yf+A9l6rCSv+ok7QgOByEgxAHQ0jvhpik6uoJ/NzckeNZie7y5a2bX+Q6KnJtvfCP2yp7LW4z4huc8RcAUPtedCf4VgAVGwUTwz/d97DT+FlZn3y7tROHuwS38CkrmT1Ioj6TYcIRLYZfEtDR6gg5T3hyvbixc5B8+tdynjScZNWzttLebdg127BBXMC2EywkuPRr9j5NCdAt0F8xheffPHekja02QJiAi3PO6L5vhZCGjPEmXprOmM/WMVSpz43IPz7MH4Rf9n8gGEl8Tb06ttK1XRZWzkNow2JJz9ofO7qEIT7YzHbnxKefqDDw9g5jTOpC6M+xtcWksei+Xy8pCEACy+UT4hPLbm8WahwPtDkx6jz7iTU4P1qK6chOUEie7n5iX+CMfX3CRjNC79fJStcClgb61NwG+gGFjPet4zNKIqtkxlenf8Rd20wd/VD+kR5lJ3rNyaAxg7UpL2BEyWqzb0bh9e80gCfGlgT7p5TzmR/kifgsef7Z5CC998FiNirk2NpU6Qt7amJXl2unvNPoTCYjwrlEF9t7xM6qu6Ps3XhVtJaD7+F0P8zTqknB+mTGmPcKZm0O73jdxv/QDilgvCzYapZvIPPzuKKGRn/9dZLg6M8mvpFYPXxlyYqZXfrCZc3zhS+Mlb6+srsQwbQyRuPmfSw+vlA37PgtMtsEG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(956004)(44832011)(2616005)(31686004)(6486002)(16526019)(5660300002)(36756003)(45080400002)(8936002)(54906003)(478600001)(186003)(316002)(83380400001)(16576012)(2906002)(38100700002)(26005)(66476007)(6666004)(53546011)(36916002)(8676002)(4326008)(86362001)(66556008)(31696002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Mk1BeHFITm5ocGYzWTZhWGxiQ3NCNCtxSXkybEgxVE9WRFBiOEJTamUzNjll?=
 =?utf-8?B?bnorRUtnU1p1em9MK2NJQXlPNVVCU2krK05UTHlXQWZiMnFGNnIrME9tUUJX?=
 =?utf-8?B?a01nTEhrTVVoc2pjWEk4QzJHaUg5N1lIaU01dG5ZME5NZDFmeUpZZE5TWGdS?=
 =?utf-8?B?THI0cFdHcktTM21ta1B0MmhvSjA0TzNKK2JRVGxqZjVzam9QZ1d4ZUgvLzZT?=
 =?utf-8?B?bVhPZVQ4T1l3TXlHN0lSUE5VRDNDSVZ5K3BTL1cxaEV1d2xEOFZhUUJiTVVj?=
 =?utf-8?B?bUlGTDBuTlBtdVlYbDNOcXRaYlBteG5KUTk0U0p3cjhwVGpVUFA0Z0dDOEZr?=
 =?utf-8?B?MlN2YUdYeHhzOHZoeHdIUGlvdXR3UnFZa2lkR1BZdlR2aEwxZ2NuY2x3anNE?=
 =?utf-8?B?azlTd05BZ2VSbzdyZmJ6aDhDN3ErTFFKMUR5M0JZUkRtaUlqMHI0MmFFSUVj?=
 =?utf-8?B?eW9UNmpkNW84N0k3YWZNZmN6V2JCeGdvQjViWDliN0VGeWNSdE5aYlF6Qnp5?=
 =?utf-8?B?WU0vcExlYnp0Y3NrdG90cUgvYy82U3RETmJOZllOQWVGbmxIem04OEdIaExR?=
 =?utf-8?B?R1NqdS80eXRhb3UxemtYMFRkUmlsb3FZd2RRQ0k1SWVScWoxOGttVDBtaHI3?=
 =?utf-8?B?dU1NMVViSW1tUlUvbU9FUS9laHlZSmljcGx6VmlCN2pRYVV0N2VVUWtTQlpT?=
 =?utf-8?B?ZWRWdG04T0YvMTJFdEIrSnRBQnY5eGxNT1g5ZDhOMXJyazZkVmdkQitHZG1T?=
 =?utf-8?B?dEdVcmFtQlNvWXltL3pvWXNPWnFCSlhrVkt4MTJIdnpKWk5MNy9wcEhwaHlo?=
 =?utf-8?B?MytvU0JzbXJQWGRJOGVIdUcxbTVZaHh4VXhnSTNEREU5WUtyLytPK2NqbldX?=
 =?utf-8?B?c2gyYVJxQVZQdU05b25CUGNEOHF0RUJEWGtxMDlwU2syZmxEY2YvRlVLMTZa?=
 =?utf-8?B?SWFoRmx0UVNNS3dHeWN2UVNCQzZURDR6VWt5Z2QvMlYxbVl4QStYcFJwUlEr?=
 =?utf-8?B?WHAxNjNnMkhvTWFiS1dQSjRqOVF1dGNGcWVLSTd1eDhSTVg3ektjUjZ5OE41?=
 =?utf-8?B?UzJqRVhPTFZtUllpeWNST0xtOFVyWHRBbktGaUgvSm01aWdTMVJHa1Fjd21n?=
 =?utf-8?B?aDc3N0ZSUkFqcjlCZkJGVFVzeDRaV0xCeWFkMHgzUEloSmUxT2pzNlJacUFC?=
 =?utf-8?B?cmMyZHhqQmo2Vmo2cjZmOTFQQXVvZFh2NEp2amJlV3VNUGpmQnRITlk1VFZr?=
 =?utf-8?B?Tit2Mk5QVHpsL0lwSXBGTVJSYm1jbVl2RnFYalE5NGdEc1cyYzhpaVNqSVk0?=
 =?utf-8?B?cWZZUGRCMFNoYU5WZGpQZ00reXk4d2xQTmZnMk5pVkhCeVhjcVBwTWdPYWtM?=
 =?utf-8?B?dFJRNkhTdEhrdndORkY1dG9Tdnc5QUdWd3BMS2RXM1IwNWNpOS9FQUpyUDlr?=
 =?utf-8?B?aWI5eExieXpHNmQ4T1pjOGdST0FVL3pHNjhxaGcwb0dsKzRvblk1LzZPZXcr?=
 =?utf-8?B?UmNxcXg0WVFETURJbnd4SW9idDNvcktFN01JckRLSnBTd05PTjd2RnR3TzRC?=
 =?utf-8?B?ZjB5R2g3bEpzeWpVUXFpL1VRZTZqTDhwN0lYZzR6TG9TR2lXV2s3Nk8yNExj?=
 =?utf-8?B?eHNsbGoydFdSUTIvRi9xbm9YclhSbGcrN1JUdFZzWGF6VFBLTXJYbnU1cGN5?=
 =?utf-8?B?WVdkS3VDWW1VWk5JZ2VSeVIrQ29BU0JCNTQxcVh1c20zbmZrMGVRUStHanBQ?=
 =?utf-8?Q?wcxXrx9Yoi3f/ZShF0evLfBng6u1/lo2GTTBURO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ed11f4-2f86-4f50-56c7-08d91489bfe4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 14:33:31.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jUbQExly8fiXscQk0qVY8yIgi0lF+hGBpW4dzjbtebqfEJedy59M25Py/uJi0UobSllxb1vqZC7nW9w089DBFgZbdwGUt35f72jijiabGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1446
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9981 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110109
X-Proofpoint-GUID: diMp9GIS3NAwgNYDLzc3jyTalPX01TT0
X-Proofpoint-ORIG-GUID: diMp9GIS3NAwgNYDLzc3jyTalPX01TT0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thank you!

On 5/11/2021 4:57 AM, Ulf Hansson wrote:
> On Thu, 6 May 2021 at 21:10, <oracleks043021@gmail.com> wrote:
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
>> Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
>> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!
>
> Kind regards
> Uffe
>
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
>>   mmc_cmds.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++
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
>> +               "NOTE!: This will delete all user data in the specified region of the device\n"
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
>> +       multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
>> +       multi_cmd->cmds[0].write_flag = 1;
>> +
>> +       /* Set erase end address */
>> +       multi_cmd->cmds[1].opcode = MMC_ERASE_GROUP_END;
>> +       multi_cmd->cmds[1].arg = end;
>> +       multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
>> +       multi_cmd->cmds[1].write_flag = 1;
>> +
>> +       /* Send Erase Command */
>> +       multi_cmd->cmds[2].opcode = MMC_ERASE;
>> +       multi_cmd->cmds[2].arg = argin;
>> +       multi_cmd->cmds[2].cmd_timeout_ms = 300*255*255;
>> +       multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
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
>> +               fprintf(stderr, "Usage: erase <type> <start addr> <end addr> </path/to/mmcblkX>\n");
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
>>

