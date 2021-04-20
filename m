Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CD1C433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 17:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6410613AF
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 17:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhDTRXR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Apr 2021 13:23:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41386 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDTRXQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Apr 2021 13:23:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13KHMT6w083877;
        Tue, 20 Apr 2021 17:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KwdicN2+ntoL57BrBvykOSF0xYWsWpBAd7Rrgv9yXsc=;
 b=dSrFzZu03zJ/VtTsuDXlM4XjQfrzCnFVagaGbxzfWrfmnV40ywLRdzobyNR2487dmNJ+
 3ActoYXrHXOrdpSmrksgFxFud3eRhUrE+lWSWQvIdOGGUb5w5o0zUTz3hH1mzXR2cMiH
 7pdV3FhKd3aplGi0MslKzRYGI91TCx4TMIiJXQWJt3zMG8bj+Xhgekrsl8Y+yIOJa3JU
 ZwNqa8dlfRYQZNmzNHCmdKEYE7qXxtcLPRbYB2J8fcqnS7wuyUYiNPlWjb1ikXAT6w4+
 fISVHa1DESP7enX4qaYt9DqprOcYXJosgqMYrQt7hIFQBVu+0x+JjnDF4MyRe3bOEleQ Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37yveafmcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 17:22:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13KHEodt120627;
        Tue, 20 Apr 2021 17:22:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3809kyc8vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 17:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zyll61HicMMVnKIuV9nMKu7bWkeVzUSM79Ypog5rIREkca/TOXln6lLlSc+wisJr9+3AehzarrUoYhRCnODbaUnTwFC6gnJgiCPBa9BunlqvdBXIpif3w2yZhBol+z4KUlF9MalXcHBQ7XhMWRsVuLPWrbWWMuYF/pKRqJqH7vopNhNJ0pSv4cqWPohUjkDHXuYvxCveyWfXJCkP7ZSOd/BEgQ123eT45RkAtnF8oVyxJ0goJzFs6mrxEDctK3AcJSl4WBBekvp+5pF4pjgLN0j7snfqhYkHlROs0CJGA7eIcNhv93VuZY/kaWvKjgaNHeJv6orNwDtqWTAtas37Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwdicN2+ntoL57BrBvykOSF0xYWsWpBAd7Rrgv9yXsc=;
 b=Gpw8aW51dbBjeUJh1Qm2qpjo/FJdmh5SsfygqpZrDgyC8O5Dd4zbQPjC80wG42dhwGHzwKJDkcIJGlyV1Qzt7G6vPkH8npvXp6MwYWnRVZxxhTJGqARryV6ggBY3SBKbbrWVmdIiVtzjDjF2BskzZrfXCxMEgS9+nalRpf4pRYhRvVOyBS8t2lfrnrEr83pmH76uZMRhp14nSwswdE+RgyEZ6c2h4B+0IOvu5IdLpd6f1cBxOFbOnsuwvauDOIko8FhIQTl7MiHECYd91PI5/BrAI7zY5+9b9Tuirc5yi7d8aaLAOeZDN0l2NDDriN+MsI0xfUSeWLYDpJBDXQd5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwdicN2+ntoL57BrBvykOSF0xYWsWpBAd7Rrgv9yXsc=;
 b=l6rusz9Kbf+Edv7LutTlTtkctR1S84pjfiwIU6ZZ1AERSubDEwFIcxs/Dtm2WKz8Ac/hmvo5av0bN0Sl6VqeZHi7AZmjXPUdzyNKPfyOzSYl3DoysJ1Nil4O3uBsK8+bSGPv+Aw3VAT/AteRsIT2PPx1iUbe4zbeNDXCvMHaTxc=
Authentication-Results: kimitos-mbp.hsd1.co.comcast.net; dkim=none (message
 not signed) header.d=none;kimitos-mbp.hsd1.co.comcast.net; dmarc=none
 action=none header.from=oracle.com;
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR10MB1237.namprd10.prod.outlook.com (2603:10b6:910:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 17:22:38 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc%6]) with mapi id 15.20.4042.025; Tue, 20 Apr 2021
 17:22:38 +0000
Subject: Re: [External] : Re: [PATCH v3] Re-submit of the erase command
 addition plus removal of MMC_IOC_MULTI_CMD ifndef for erase. Author=Kimito
 Sakata <kimito.sakata@oracle.com>
From:   kimito.sakata@oracle.com
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>
Cc:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        kenny.gibbons@oracle.com, rkamdar@micron.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@kimitos-mbp.hsd1.co.comcast.net>
References: <20210401230221.12532-1-luserhker@gmail.com>
 <CAPDyKFpjTikAzDqkcbyxa1Y918OevojZYhREPsmQgeo_Sd0xgA@mail.gmail.com>
 <7bca3bca-b058-7086-b733-359c21e3d473@oracle.com>
Message-ID: <7842f17c-7d8b-481a-1f84-c80de715be0d@oracle.com>
Date:   Tue, 20 Apr 2021 11:22:34 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <7bca3bca-b058-7086-b733-359c21e3d473@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: SA0PR11CA0207.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::32) To CY4PR10MB1815.namprd10.prod.outlook.com
 (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by SA0PR11CA0207.namprd11.prod.outlook.com (2603:10b6:806:1bc::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 17:22:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a2043a1-991b-4fc3-0dd2-08d90420e583
X-MS-TrafficTypeDiagnostic: CY4PR10MB1237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB12375AAFAE0704FE062492609D489@CY4PR10MB1237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g70DercZHVQRrCsA0OEFMmbg5ic1Z2N782xaHoAGgTFOg9g54a5N5BcCVAOTw6eZmOk+QrSS82y6OViTT8w7XVyP0uJVcWIOiQ7RPpygF8/2wMnwq9HenOxN1t8XL85MgkjCr+kZnqM8R91XT40E+7REmZb9Q3IGFSvjMKMu9LGdOLPqh28lfkUPMXJPRShFPuJ1Aeumx9W7PxMuys4SqrH8MrA6dgtrfpTWGajr0i7y7Ym04NqLYg3TOkcX6wLS+VbnXrjVWvoNKDIcxeuGTZM+c0Iq5MoyMojuV7RKiSTf9O/jxFM0OO72l1rX526/FbroIjvcGOPtpqwh9nc7dpQwEBpVeX/nSkRaPzfz12uVfi6TP2yFp3sSC0Kp4kRo9lEZZCatnuEtCQGh48y8QSqRENPzOQekNvBwOFGt5gnfCyOADnZU24lB9+eqOQXlXm6NeWZcG6dqy+F3ONm9mrsO47AVM3bzC7fc4tkd88hJjKhdy+p8i0DTseaDwVEUhmogEKWGgwVmOFD0BTW/abIstWsNYhD7CwTOqEjm5SXeHNBwM3pVR7OMjNgEx8TtCMLHhBCJn9MG6BGM1HhT/1X3CyIKZomo6KrYJIYLK8uFHmTELbtjSIHWdpMo1esTPKiLNpWRlu4CQkrFcLnEBxohaEiL8TmX1BUkWQNtTWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(346002)(39860400002)(136003)(110136005)(16526019)(26005)(54906003)(5660300002)(8676002)(956004)(66556008)(2906002)(186003)(4326008)(16576012)(86362001)(316002)(31696002)(8936002)(9686003)(31686004)(2616005)(66476007)(53546011)(478600001)(6666004)(6486002)(83380400001)(38100700002)(36756003)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dEdRcUJLQ0NZVWdOd1FXS29pQmFLZ3BUNGQ0VzJjTm8zdWM1Rjh3Y2NRWlF6?=
 =?utf-8?B?ZFFjUDRpSGFzTGFHSEkvSXZvb2xONWN3dks1M2NTSGl4MzJsU0tZcGY1Z29F?=
 =?utf-8?B?NldkRkxFZjJGdzBlNlN3ZHkzNVdybWpVMnl1TmNhRTk4UURRajV5SkFSUTBi?=
 =?utf-8?B?VTBaQ25NRk9lSjl2MGQ3VTA2eHExcHVTcDU2dW9aTk12RjVPRWlmVmlrdG1S?=
 =?utf-8?B?Wkt4YUo2YnpPd2ZoVlYvNUZGOHB4cUplcW5NTlVqa3lmUm56N2ZFT0FzdWFN?=
 =?utf-8?B?aU55VXdLelNYcDcrSG9UN25pclZCeU9PMEpEMUowMUFKb1ZYeE0wdkxIREdy?=
 =?utf-8?B?Q3dVM3BUaHFNOCswSTBuT0JTRkRMRURGTldJeUhuZHRMdkxqRmZSVUV3NWd3?=
 =?utf-8?B?blU0bmV3a1BETktjVkp5NGZrSENRL0pVa2NPbEZhd2lCN0lHcWVZWThLa01v?=
 =?utf-8?B?OUdaN0Mzby9adWlVVGJQaDBTWmJvM1o5UzRFdEhpZ2dPNVVhTnFTZ0x4TzI3?=
 =?utf-8?B?RXdXYlhtQ0poc09ZTWZHOGVwYUNJSXBWblRPS1lKRGIxS21lQVU1WnNIQXJB?=
 =?utf-8?B?SW80MGY0blhqR2NEZHFCUmYvSTFQb3N6YVJMR2NFL1hTc0dZQ1pFN3R1L253?=
 =?utf-8?B?ZThDNDlwbjNLSmErZUR1VUJlWk5vVDFPd0d2QmNyOFZGTFNRODRuUmFYQVFT?=
 =?utf-8?B?a01lblo2bjljbGZFcVova1I5a0h6cm5oVTUvWEFpeTJ5TVVhMHJlQkRlTlJu?=
 =?utf-8?B?elJtSmdvYXFjaUQyQWxEZ1A3UHJmNDNKVGl4VUROQVRPd2VPUUhBZTBlQ0g0?=
 =?utf-8?B?UjRwV1l1Tk15ditzSjVEc2FlN2ZGUUt0MFBveFBwWDFJL0t3QUF1d1ZEbWFy?=
 =?utf-8?B?UUg0K2dvL2F6NFJYdlpwanhMWjN1elpwanZPSVFsbVpobHovdUpTOVZKRGlk?=
 =?utf-8?B?dytmM3I0cGZvaGl3VkxJV0pwNHdLQitNMWQyOGY0UU5lWDdRY0hKTUFzNmxH?=
 =?utf-8?B?Vi9Db0VQdU9GaVVWcVhXK25MNXVDa0xCNkYrQ2h0cVR6ejRtWXZjWFczMjF4?=
 =?utf-8?B?UmFwWlVpbDZRSWQxbUJxYU55YzQ1Kys5RTR6eDNiRlRFZ1VIckcrNXlCV0NW?=
 =?utf-8?B?c0NPZk51VnB3M2xSL2RmTlE1NkNFcE9yMmlyMWc1THZ3NUVWWDdhWGZJN3Qw?=
 =?utf-8?B?RHFJK1ptSldnNi8wUEZJbDU5MUNFdWhrUXh5QVR6QnB4RnBTOTFsOE5IQzh2?=
 =?utf-8?B?UVZiaEtBaEFJeDhQc1NFem5YaUhEaC85T09YMi8yaStlVzVjSW9sWmNPVmdx?=
 =?utf-8?B?L1daSkh6WkJ1MnZ0TmZnS3ZWOHdSUmRCQndRamg2YW1jOWNhVTUwaUtmRXNZ?=
 =?utf-8?B?VXEvUXZqZC82dUl6Wjd5RVRiZ0pCSFhQYUhZMEV2cXZXWXVDZjNvUTZSVGVQ?=
 =?utf-8?B?ZU8rZEFIYklRZ3RiZHA0U1lJVFpOUFJJR0pwcXdXMnRXNEhwOWx5T0REdUdE?=
 =?utf-8?B?bFlrbVd2Z0JIUWh1c0E4a3NHME83bmgzeDFEc05RUmtRQWdOWDVZc0Y2WEZs?=
 =?utf-8?B?VXhDTkZoL2tvc1BLeFN6c05TSEJMNnVzYXNoUnl0aGw5UjlOMTlVUjdFRHFn?=
 =?utf-8?B?cVRIUXBpQWFJaDUycjVaTkJIeXBiUWdvT1RCT1lJcDVtYUNqQktmMzI4ZlZF?=
 =?utf-8?B?Q044dWFtc294S2lyQno5WkxZbGUzZW05UkRYVXdCWUlkbnFQYVQ3MHp2Q3BH?=
 =?utf-8?Q?SGQWfhEidGIVy796eRvxzgkZtajlnNp1/vv4E4T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2043a1-991b-4fc3-0dd2-08d90420e583
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 17:22:38.7130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScrTQnnIxrgfydGklgcliziebxJU38nmAsyoyyXxdCcdBcyJrlq/aCbh5YQbgQ8fl8TK8M6XXMK2RLT8fx5h4uVfjoU2TjTZs9JwJolZHUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1237
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200119
X-Proofpoint-GUID: i6F3kBUkDWIifCjNNMjshSiyFZwPT6eZ
X-Proofpoint-ORIG-GUID: i6F3kBUkDWIifCjNNMjshSiyFZwPT6eZ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200120
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Avri

I'm sure you are very busy, but I would appreciate if you have any 
concerns on these changes that I submitted.

Thanks
Kimito


On 4/15/2021 2:11 PM, kimito.sakata@oracle.com wrote:
> Avri
>
> Please let me know if you have some concerns.
>
> Kimito
>
> On 4/15/2021 6:32 AM, Ulf Hansson wrote:
>> + Avri
>>
>> On Fri, 2 Apr 2021 at 01:02, <luserhker@gmail.com> wrote:
>>> From: Kimito Sakata <kimito.sakata@oracle.com>
>>>
>>> Signed-off-by: Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
>> This looks okay to me, but I have looped in Avri who might have some 
>> comments.
>>
>> Kind regards
>> Uffe
>>
>>> ---
>>>   mmc.c      |   8 ++++
>>>   mmc.h      |  13 +++++-
>>>   mmc_cmds.c | 129 
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   mmc_cmds.h |   1 +
>>>   4 files changed, 150 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mmc.c b/mmc.c
>>> index f3d724b..eb2638b 100644
>>> --- a/mmc.c
>>> +++ b/mmc.c
>>> @@ -229,6 +229,14 @@ static struct Command commands[] = {
>>>                  "Run Field Firmware Update with <image name> on 
>>> <device>.\n",
>>>            NULL
>>>          },
>>> +       { do_erase, -4,
>>> +       "erase", "<type> " "<start address> " "<end address> " 
>>> "<device>\n"
>>> +               "Send Erase CMD38 with specific argument to the 
>>> <device>\n\n"
>>> +               "NOTE!: This will delete all user data in the 
>>> specified region of the device\n"
>>> +               "<type> must be: legacy | discard | secure-erase | "
>>> +               "secure-trim1 | secure-trim2 | trim \n",
>>> +       NULL
>>> +       },
>>>          { 0, 0, 0, 0 }
>>>   };
>>>
>>> diff --git a/mmc.h b/mmc.h
>>> index 5754a9d..e9766d7 100644
>>> --- a/mmc.h
>>> +++ b/mmc.h
>>> @@ -35,7 +35,15 @@
>>>   #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr   
>>> R1b */
>>>   #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr   
>>> R1b */
>>>   #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   
>>> R1  */
>>> -
>>> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr   R1  */
>>> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr   R1  */
>>> +#define MMC_ERASE              38    /* ac   [31] Secure request
>>> +                                             [30:16] set to 0
>>> +                                             [15] Force Garbage 
>>> Collect request
>>> +                                             [14:2] set to 0
>>> +                                             [1] Discard Enable
>>> +                                             [0] Identify Write 
>>> Blocks for
>>> +                                             Erase (or TRIM 
>>> Enable)  R1b */
>>>   /*
>>>    * EXT_CSD fields
>>>    */
>>> @@ -62,6 +70,7 @@
>>>   #define EXT_CSD_CACHE_SIZE_2           251
>>>   #define EXT_CSD_CACHE_SIZE_1           250
>>>   #define EXT_CSD_CACHE_SIZE_0           249
>>> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
>>>   #define EXT_CSD_BOOT_INFO              228     /* R/W */
>>>   #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>>>   #define EXT_CSD_HC_WP_GRP_SIZE         221
>>> @@ -190,6 +199,8 @@
>>>   #define EXT_CSD_REV_V4_2               2
>>>   #define EXT_CSD_REV_V4_1               1
>>>   #define EXT_CSD_REV_V4_0               0
>>> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
>>> +#define EXT_CSD_SEC_ER_EN              (1<<0)
>>>
>>>
>>>   /* From kernel linux/mmc/core.h */
>>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>>> index 6c24cea..3e36ff2 100644
>>> --- a/mmc_cmds.c
>>> +++ b/mmc_cmds.c
>>> @@ -2514,6 +2514,135 @@ int do_cache_dis(int nargs, char **argv)
>>>          return do_cache_ctrl(0, nargs, argv);
>>>   }
>>>
>>> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
>>> +{
>>> +       int ret = 0;
>>> +       struct mmc_ioc_multi_cmd *multi_cmd;
>>> +
>>> +       multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
>>> +                          3 * sizeof(struct mmc_ioc_cmd));
>>> +       if (!multi_cmd) {
>>> +               perror("Failed to allocate memory");
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       multi_cmd->num_of_cmds = 3;
>>> +       /* Set erase start address */
>>> +       multi_cmd->cmds[0].opcode = MMC_ERASE_GROUP_START;
>>> +       multi_cmd->cmds[0].arg = start;
>>> +       multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | 
>>> MMC_CMD_AC;
>>> +       multi_cmd->cmds[0].write_flag = 1;
>>> +
>>> +       /* Set erase end address */
>>> +       multi_cmd->cmds[1].opcode = MMC_ERASE_GROUP_END;
>>> +       multi_cmd->cmds[1].arg = end;
>>> +       multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | 
>>> MMC_CMD_AC;
>>> +       multi_cmd->cmds[1].write_flag = 1;
>>> +
>>> +       /* Send Erase Command */
>>> +       multi_cmd->cmds[2].opcode = MMC_ERASE;
>>> +       multi_cmd->cmds[2].arg = argin;
>>> +       multi_cmd->cmds[2].cmd_timeout_ms = 300*255*255;
>>> +       multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | 
>>> MMC_CMD_AC;
>>> +       multi_cmd->cmds[2].write_flag = 1;
>>> +
>>> +       /* send erase cmd with multi-cmd */
>>> +       ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>>> +       if (ret)
>>> +               perror("Erase multi-cmd ioctl");
>>> +
>>> +       free(multi_cmd);
>>> +       return ret;
>>> +}
>>> +
>>> +int do_erase(int nargs, char **argv)
>>> +{
>>> +       int dev_fd, ret;
>>> +       char *print_str;
>>> +       char **eptr = NULL;
>>> +       __u8 ext_csd[512], checkup_mask = 0;
>>> +       __u32 arg, start, end;
>>> +
>>> +       if (nargs != 5) {
>>> +               fprintf(stderr, "Usage: erase <type> <start addr> 
>>> <end addr> </path/to/mmcblkX>\n");
>>> +               exit(1);
>>> +       }
>>> +
>>> +       if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
>>> +               start = strtol(argv[2], eptr, 16);
>>> +       else
>>> +               start = strtol(argv[2], eptr, 10);
>>> +
>>> +       if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
>>> +               end = strtol(argv[3], eptr, 16);
>>> +       else
>>> +               end = strtol(argv[3], eptr, 10);
>>> +
>>> +       if (end < start) {
>>> +               fprintf(stderr, "erase start [0x%08x] > erase end 
>>> [0x%08x]\n",
>>> +                       start, end);
>>> +               exit(1);
>>> +       }
>>> +
>>> +       if (strcmp(argv[1], "legacy") == 0) {
>>> +               arg = 0x00000000;
>>> +               print_str = "Legacy Erase";
>>> +       } else if (strcmp(argv[1], "discard") == 0) {
>>> +               arg = 0x00000003;
>>> +               print_str = "Discard";
>>> +       } else if (strcmp(argv[1], "secure-erase") == 0) {
>>> +               print_str = "Secure Erase";
>>> +               checkup_mask = EXT_CSD_SEC_ER_EN;
>>> +               arg = 0x80000000;
>>> +       } else if (strcmp(argv[1], "secure-trim1") == 0) {
>>> +               print_str = "Secure Trim Step 1";
>>> +               checkup_mask = EXT_CSD_SEC_ER_EN | 
>>> EXT_CSD_SEC_GB_CL_EN;
>>> +               arg = 0x80000001;
>>> +       } else if (strcmp(argv[1], "secure-trim2") == 0) {
>>> +               print_str = "Secure Trim Step 2";
>>> +               checkup_mask = EXT_CSD_SEC_ER_EN | 
>>> EXT_CSD_SEC_GB_CL_EN;
>>> +               arg = 0x80008000;
>>> +       } else if (strcmp(argv[1], "trim") == 0) {
>>> +               print_str = "Trim";
>>> +               checkup_mask = EXT_CSD_SEC_GB_CL_EN;
>>> +               arg = 0x00000001;
>>> +       } else {
>>> +               fprintf(stderr, "Unknown erase type: %s\n", argv[1]);
>>> +               exit(1);
>>> +       }
>>> +
>>> +       dev_fd = open(argv[4], O_RDWR);
>>> +       if (dev_fd < 0) {
>>> +               perror(argv[4]);
>>> +               exit(1);
>>> +       }
>>> +
>>> +       if (checkup_mask) {
>>> +               ret = read_extcsd(dev_fd, ext_csd);
>>> +               if (ret) {
>>> +                       fprintf(stderr, "Could not read EXT_CSD from 
>>> %s\n",
>>> +                               argv[4]);
>>> +                       goto out;
>>> +               }
>>> +               if ((checkup_mask & 
>>> ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) !=
>>> + checkup_mask) {
>>> +                       fprintf(stderr, "%s is not supported in %s\n",
>>> +                               print_str, argv[4]);
>>> +                       ret = -ENOTSUP;
>>> +                       goto out;
>>> +               }
>>> +
>>> +       }
>>> +       printf("Executing %s from 0x%08x to 0x%08x\n", print_str, 
>>> start, end);
>>> +
>>> +       ret = erase(dev_fd, arg, start, end);
>>> +out:
>>> +       printf(" %s %s!\n\n", print_str, ret ? "Failed" : "Succeed");
>>> +       close(dev_fd);
>>> +       return ret;
>>> +}
>>> +
>>> +
>>>   int do_ffu(int nargs, char **argv)
>>>   {
>>>   #ifndef MMC_IOC_MULTI_CMD
>>> diff --git a/mmc_cmds.h b/mmc_cmds.h
>>> index 9d3246c..8331ab2 100644
>>> --- a/mmc_cmds.h
>>> +++ b/mmc_cmds.h
>>> @@ -45,3 +45,4 @@ int do_ffu(int nargs, char **argv);
>>>   int do_read_scr(int argc, char **argv);
>>>   int do_read_cid(int argc, char **argv);
>>>   int do_read_csd(int argc, char **argv);
>>> +int do_erase(int nargs, char **argv);
>>> -- 
>>> 2.24.1 (Apple Git-126)
>>>
>

