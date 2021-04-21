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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF150C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 19:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B61B46142B
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 19:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243223AbhDUTkF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:40:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60450 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhDUTkE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2021 15:40:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LIQH2H051337;
        Wed, 21 Apr 2021 18:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=l1nFtAbazc47yPXDBNZ8l4OfkMMnapO3NNeeyJt9n0o=;
 b=kZY9zzGRM/MwzhF6PUjRrKAKeTFgPQQIei1hmqhcMxSDcuPGT4xCrvV6CDOLqhMHV2Qu
 iWHPFCcPoTaxYb8R+4wCgdJ6yJJt3m4DvF2csPaGMyQEV13Z/PUDPXQAxvzUl4TO3hiX
 TuCYFxxgQ7zGhCBh4lykrGny9PhfTabutzW6egPKAOhn1VkdYZHjH/H6Tw7V1EUHCqey
 hRawLAfR6EWbbBlEU8etdQLvS2mB8aKBXc2NE9abXm3fOgSD18TQzhapFcPji67dB8Ze
 pHq8U9YL5LliQvZ/WT3fMnmQGVTUaeMOLHA/p2vuJSYk1mxr9oc73kni+/dfoVc22CgU Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38022y2kxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 18:39:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LIYp8X060649;
        Wed, 21 Apr 2021 18:39:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3809m10s9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 18:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ9mjA1AV1k1Rz8wdA8ien+wNwUXVWo1XdzDlYmeESaNz6xMDuLj4zFd6uZ9jCheyS5Xx6AyWY3nLo4717bz7ovBt8j8M1bqdTjYiv1wdw3IheAGud70uRrbw9DsXLqCwQVkoh77CEPkEeHw1q4HphBUP4HNQ64uV90GS+oJBbQ8Z7LsFq6A/sGR0gwmm5mD+pPXSr0VsFZcTCS2CaJox+2U3mON5CNLexbgS5nOWlXkGsDE5mgPXOPSIqdOBislanfwYtDDSD/KmZjUSk7J6rwfgwtMENfGn+BJTnCOYvfx2Mb8MnKJ1XGudUN0ly801gHhjcKxxBeOg08/FJizKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1nFtAbazc47yPXDBNZ8l4OfkMMnapO3NNeeyJt9n0o=;
 b=SbR+z1dqv0FwbEJkGj1XxVPvHv7ihtSi6kDPWxLM4RSN9VhboQw5QOudI0o7FrtGam6y/quJWZzCw2gwyyAdytTfNhM1QyyHIle3OqqFmw4y0e+wRMNYFognnR/VJ1UbEkt3/m5HMYyDa3lBS9ro98hBAHBV7mv1vJ8HNOlQ7RkQzCa7EcIA2MjgJo5mXeHgLaz9IPX8y8VmIZmpqY/k2Ak4GmaWOLFq3YRNGn3hOoSVNsqxWEuFg5eiaWw8+T5CWB/rkMYzHxePEIg3r79frxKC0RhPr0LUxHcyBmqVG/2zSxAwup+5UPYbjTDv//+7YnplYXMEGtHXe5mp6NQz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1nFtAbazc47yPXDBNZ8l4OfkMMnapO3NNeeyJt9n0o=;
 b=QFB4OwFnqEEkuoTH9ixKuFOf0PqZTl9i5HUTMwH2zLjC+1EEvgIhYwoGGoS4j3y/YCrnSF6GWXdWPnyyBLvKZuUaeF0tJ0rsNKhxb5XY+MiP8PosGSkOCll8+wPIYe10+egM9c8Mls15YrKyDv/ERBVTkInbzzmxAvWzFRU9bQ4=
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR10MB1448.namprd10.prod.outlook.com (2603:10b6:903:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Wed, 21 Apr
 2021 18:39:22 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc%6]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 18:39:22 +0000
Subject: Re: [External] : Re: [PATCH v3] Re-submit of the erase command
 addition plus removal of MMC_IOC_MULTI_CMD ifndef for erase. Author=Kimito
 Sakata <kimito.sakata@oracle.com>
From:   kimito.sakata@oracle.com
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        kenny.gibbons@oracle.com, rkamdar@micron.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@kimitos-mbp.hsd1.co.comcast.net>,
        Avri Altman <avri.altman@wdc.com>
References: <20210401230221.12532-1-luserhker@gmail.com>
 <CAPDyKFpjTikAzDqkcbyxa1Y918OevojZYhREPsmQgeo_Sd0xgA@mail.gmail.com>
 <7bca3bca-b058-7086-b733-359c21e3d473@oracle.com>
 <7842f17c-7d8b-481a-1f84-c80de715be0d@oracle.com>
Message-ID: <55316844-d13f-bb84-a269-98f8cb649016@oracle.com>
Date:   Wed, 21 Apr 2021 12:39:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <7842f17c-7d8b-481a-1f84-c80de715be0d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: BYAPR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::15) To CY4PR10MB1815.namprd10.prod.outlook.com
 (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by BYAPR06CA0038.namprd06.prod.outlook.com (2603:10b6:a03:14b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 18:39:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b95bdb45-1978-4e01-549a-08d904f4c806
X-MS-TrafficTypeDiagnostic: CY4PR10MB1448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1448AE9518461BB373C1BEB89D479@CY4PR10MB1448.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hW5OoaSBOhhb6qdbkhDXNBTmtWRAIskQzD6WoDcyv1igysgsXicAV4hteivaym7H5KdNcxatMMvlelIVywBwqryMJq9abXcsixliBcAGqWD25Q6eYrl4p6LvpfianNbhK4DYeBqrQwD9JawOFoO60rS+dvXFao/DDYrl+lU+mIeTA4q2rNT0A21P209xRwVTaABRg4Ogyz0VKkuGBrsD4oE7/T0keY++JttIhxJt6Lr9Wu69FvMp3O2dM8PkY002GT/kp2IccAt6UHBlZd0u6c1Gi2er9sft1OXdRM8yPdeYkkZocncxUmyWunisxru5kkfGGVHyAOu7+jYWkvOwNSYzFeS9KXIS/PIFjB0FhX6OlwzqwFRxVrh7HOX/1BWHyODzS0xtIn9f1/5wfRyBPF8jFt4dmH/e6PWLvKSAEFECLONCYXpw7LA4EP63dzHUMKWJi8ZC6nSYQNEebl1h7LFb1Tc8dC7UKnkg6ebm1RSYrJIdeHSvL1LPx9Uba8TWhMVRGbYrjCGhWnAW2EnD74e8Guow/4pDL314hvwHag0nCm3lSOmkF3hhuOD6Y77MF7WEoFwdNNuBaeGQAThHWO7s34s19JxMYInEuA2ujQHuTQ1hIpajUd5bE6m+Er79op2wlJe/7XUx2jc5cC9w5iPGdpYUrUWHnzRKTU7Wx1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(366004)(346002)(16576012)(83380400001)(31686004)(66556008)(8936002)(53546011)(31696002)(5660300002)(6916009)(4326008)(8676002)(16526019)(2616005)(26005)(186003)(956004)(316002)(6486002)(66476007)(9686003)(36756003)(54906003)(478600001)(6666004)(86362001)(66946007)(2906002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QWhCWms0dkNwRCsrcXRyeXBURmpnUzJRTEswbzdqNGFycE5tTmIwY0p3QVBQ?=
 =?utf-8?B?TmFNUW9HQ2JtSTVpajZRWGw5UmxNeU40YW9pcHhpSHlmcEdnU01oelpQNDNr?=
 =?utf-8?B?Z2YyOHJsdE1PcFZOKzU2RG9XQ2tqVlNUelQzd1ZZQk9WRjhxMjJidzlkYWpZ?=
 =?utf-8?B?UmJBNnd4dm1rbHZWMU91WHAwVWpBRDV0anlRQ2Y0YWt4NkFoUTdKY1FoRnkw?=
 =?utf-8?B?VUVtSGhkOS95ZnVEYkE1Vk9CbGRIMy9NTDJxWXpXN01FOEloaGlHbjlrQTlK?=
 =?utf-8?B?WDRlcW1wTmZXNUp5eWkzcVg1bllZM2o5dWxzOTFGZDgrTDJoblE3cmU5QjYy?=
 =?utf-8?B?Z0x4ZXd0TlFPdU1Ua2JBSDROdjU1emVWUnZKWXRNek1McmdHUFNBZlhXMU5y?=
 =?utf-8?B?MmJFSTVUdUtrVS9EMEpvbnlVcVN5UGZGb3ZpWTVNMm45dVhIek9vTHR6cmZW?=
 =?utf-8?B?Y1I3MGxJS2VROWUyRDlkRGlYUUoxQmIyUUNJd1VaelBsaU9yaDJWbzFDN0gv?=
 =?utf-8?B?ZlY1MFZCazU1TXFiRDRGK3Z1blZmY01oS2JMTFF2dGdEVi9nR2pDSVMvbTYz?=
 =?utf-8?B?M1liWUhFZGxpOXh6Q0lnSDJFY1JnalcyUDlOUmlqYVRkQms2TVZIUStTMlFL?=
 =?utf-8?B?enlYK21mQjN3Tnl4OFkzQlBxVmJlRXMrYTRwMERjS1V2WmZwcXR3enhvdFpi?=
 =?utf-8?B?TS84RkVkRjdOQUhlaXFWbjBCdTRTdDgxMGlXblVLbm9lamxnM2N1Z1NTL3I4?=
 =?utf-8?B?S1RreHo5d3hTYzNZa0F3NlVxTjR3Yk5idFRYT0xOREtJdUF0VUNjRnRZSXk0?=
 =?utf-8?B?TzhwM0FJUld2THdNT3hkTnAwUUcxWGZXYWQvQ0lHRXVoYUN0S2JlOVdYV3la?=
 =?utf-8?B?dzIwRjU5Z3RCaTdIY241cFRFR3kyaHZJODJzejhrNHFxQlhpZmNUNUJWWjhm?=
 =?utf-8?B?S2pmQU5VZlZLQlgySmVvK3NMV1JpeDNjeXc2OHh0ZllrTFp6R1RrVVd6ZDBV?=
 =?utf-8?B?Mmw0SWZodTE4S0JuWTlOZjlFb21nU3h3YXRuU2JZS21DZ01DOGpBbEswNzJp?=
 =?utf-8?B?dnVBWlBZRllHOHFINjZhVXpoc3A4WHo3dkwreC9FZkwzZ2ZhbS9Qc3R5NjlL?=
 =?utf-8?B?QU5aMU45M2dON0JIekxFUjdROGhVMmg1clhXSERzRTRHbXpjaXV4S29qR1ZP?=
 =?utf-8?B?UGZoc0cvb2NPbzQxS3VuYmxoaUg5WFAzUUpkeTVUL0tlRDMydk55Yjd0R1lR?=
 =?utf-8?B?WHB2d0ovWFRpdGQxVHdYRnNOWHRZSkxrVG9LQnA3ZUN0cUNiZTBZUk84NW9l?=
 =?utf-8?B?elkyejU5UXNVQWZueUUrcFBEZnh3Wkl0ak5qNy9wN083eStCT2RaRjdRZHVh?=
 =?utf-8?B?ZkhBa1R3YWdDOHRKUHBXZGRYSCtCWVR2aHRNTXBEU20vQllNNjE1dVU5QlE2?=
 =?utf-8?B?eW95cEFnOFpYSEYwZ3YxWmhINXY0MTk1VURLVFluSi9FNi9SY3lUb3Rma3JF?=
 =?utf-8?B?aFp2RUpORHJ5L0dxSzJCSlFlSUlwek1YbWd3TzhVTXpXdFZRYkx6K3dsbUIy?=
 =?utf-8?B?b2dEd29lcXcxdCthNEdiUnFic0NCQkdhWXZvYzdyam9oYjVUNTNCOUNNTGdU?=
 =?utf-8?B?ZC80T1RaZmpKNWVldDkyVGlFMmJBTTRnTndGa0xIeFUvaTR1ZXVsdS9CSkxC?=
 =?utf-8?B?bkhsRnVRUjlaUU9UbnVTZ2JoaHV1QnFkTTBxM0RtdklSWjlFTXZNUlNaYXpE?=
 =?utf-8?Q?n/A2DTbCPe+rzYiLvtM0KXEG+DXbr8p1Wk06utq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95bdb45-1978-4e01-549a-08d904f4c806
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 18:39:22.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Yv9muSNbudyykwnJNnqoiLLweeeqBO1UIiUKeuvt11SSmK/rGk/EjayDJnAmBpaNkJiUwCKeLicpq+YUi585Us4OtS5nOU3GGTm9dTJMG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1448
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210128
X-Proofpoint-ORIG-GUID: _dJm24u_0OO0eQQJckPtLEsSt7VrXVUE
X-Proofpoint-GUID: _dJm24u_0OO0eQQJckPtLEsSt7VrXVUE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210127
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ulf

Looks like Avri either has no comments or cannot respond. Could we 
please go ahead with the changes?

Thanks
Kimito

On 4/20/2021 11:22 AM, kimito.sakata@oracle.com wrote:
> Avri
>
> I'm sure you are very busy, but I would appreciate if you have any 
> concerns on these changes that I submitted.
>
> Thanks
> Kimito
>
>
> On 4/15/2021 2:11 PM, kimito.sakata@oracle.com wrote:
>> Avri
>>
>> Please let me know if you have some concerns.
>>
>> Kimito
>>
>> On 4/15/2021 6:32 AM, Ulf Hansson wrote:
>>> + Avri
>>>
>>> On Fri, 2 Apr 2021 at 01:02, <luserhker@gmail.com> wrote:
>>>> From: Kimito Sakata <kimito.sakata@oracle.com>
>>>>
>>>> Signed-off-by: Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
>>> This looks okay to me, but I have looped in Avri who might have some 
>>> comments.
>>>
>>> Kind regards
>>> Uffe
>>>
>>>> ---
>>>>   mmc.c      |   8 ++++
>>>>   mmc.h      |  13 +++++-
>>>>   mmc_cmds.c | 129 
>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   mmc_cmds.h |   1 +
>>>>   4 files changed, 150 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mmc.c b/mmc.c
>>>> index f3d724b..eb2638b 100644
>>>> --- a/mmc.c
>>>> +++ b/mmc.c
>>>> @@ -229,6 +229,14 @@ static struct Command commands[] = {
>>>>                  "Run Field Firmware Update with <image name> on 
>>>> <device>.\n",
>>>>            NULL
>>>>          },
>>>> +       { do_erase, -4,
>>>> +       "erase", "<type> " "<start address> " "<end address> " 
>>>> "<device>\n"
>>>> +               "Send Erase CMD38 with specific argument to the 
>>>> <device>\n\n"
>>>> +               "NOTE!: This will delete all user data in the 
>>>> specified region of the device\n"
>>>> +               "<type> must be: legacy | discard | secure-erase | "
>>>> +               "secure-trim1 | secure-trim2 | trim \n",
>>>> +       NULL
>>>> +       },
>>>>          { 0, 0, 0, 0 }
>>>>   };
>>>>
>>>> diff --git a/mmc.h b/mmc.h
>>>> index 5754a9d..e9766d7 100644
>>>> --- a/mmc.h
>>>> +++ b/mmc.h
>>>> @@ -35,7 +35,15 @@
>>>>   #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr   
>>>> R1b */
>>>>   #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr   
>>>> R1b */
>>>>   #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   
>>>> R1  */
>>>> -
>>>> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr   
>>>> R1  */
>>>> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr   
>>>> R1  */
>>>> +#define MMC_ERASE              38    /* ac   [31] Secure request
>>>> +                                             [30:16] set to 0
>>>> +                                             [15] Force Garbage 
>>>> Collect request
>>>> +                                             [14:2] set to 0
>>>> +                                             [1] Discard Enable
>>>> +                                             [0] Identify Write 
>>>> Blocks for
>>>> +                                             Erase (or TRIM 
>>>> Enable)  R1b */
>>>>   /*
>>>>    * EXT_CSD fields
>>>>    */
>>>> @@ -62,6 +70,7 @@
>>>>   #define EXT_CSD_CACHE_SIZE_2           251
>>>>   #define EXT_CSD_CACHE_SIZE_1           250
>>>>   #define EXT_CSD_CACHE_SIZE_0           249
>>>> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
>>>>   #define EXT_CSD_BOOT_INFO              228     /* R/W */
>>>>   #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>>>>   #define EXT_CSD_HC_WP_GRP_SIZE         221
>>>> @@ -190,6 +199,8 @@
>>>>   #define EXT_CSD_REV_V4_2               2
>>>>   #define EXT_CSD_REV_V4_1               1
>>>>   #define EXT_CSD_REV_V4_0               0
>>>> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
>>>> +#define EXT_CSD_SEC_ER_EN              (1<<0)
>>>>
>>>>
>>>>   /* From kernel linux/mmc/core.h */
>>>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>>>> index 6c24cea..3e36ff2 100644
>>>> --- a/mmc_cmds.c
>>>> +++ b/mmc_cmds.c
>>>> @@ -2514,6 +2514,135 @@ int do_cache_dis(int nargs, char **argv)
>>>>          return do_cache_ctrl(0, nargs, argv);
>>>>   }
>>>>
>>>> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
>>>> +{
>>>> +       int ret = 0;
>>>> +       struct mmc_ioc_multi_cmd *multi_cmd;
>>>> +
>>>> +       multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
>>>> +                          3 * sizeof(struct mmc_ioc_cmd));
>>>> +       if (!multi_cmd) {
>>>> +               perror("Failed to allocate memory");
>>>> +               return -ENOMEM;
>>>> +       }
>>>> +
>>>> +       multi_cmd->num_of_cmds = 3;
>>>> +       /* Set erase start address */
>>>> +       multi_cmd->cmds[0].opcode = MMC_ERASE_GROUP_START;
>>>> +       multi_cmd->cmds[0].arg = start;
>>>> +       multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | 
>>>> MMC_CMD_AC;
>>>> +       multi_cmd->cmds[0].write_flag = 1;
>>>> +
>>>> +       /* Set erase end address */
>>>> +       multi_cmd->cmds[1].opcode = MMC_ERASE_GROUP_END;
>>>> +       multi_cmd->cmds[1].arg = end;
>>>> +       multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | 
>>>> MMC_CMD_AC;
>>>> +       multi_cmd->cmds[1].write_flag = 1;
>>>> +
>>>> +       /* Send Erase Command */
>>>> +       multi_cmd->cmds[2].opcode = MMC_ERASE;
>>>> +       multi_cmd->cmds[2].arg = argin;
>>>> +       multi_cmd->cmds[2].cmd_timeout_ms = 300*255*255;
>>>> +       multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | 
>>>> MMC_CMD_AC;
>>>> +       multi_cmd->cmds[2].write_flag = 1;
>>>> +
>>>> +       /* send erase cmd with multi-cmd */
>>>> +       ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>>>> +       if (ret)
>>>> +               perror("Erase multi-cmd ioctl");
>>>> +
>>>> +       free(multi_cmd);
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +int do_erase(int nargs, char **argv)
>>>> +{
>>>> +       int dev_fd, ret;
>>>> +       char *print_str;
>>>> +       char **eptr = NULL;
>>>> +       __u8 ext_csd[512], checkup_mask = 0;
>>>> +       __u32 arg, start, end;
>>>> +
>>>> +       if (nargs != 5) {
>>>> +               fprintf(stderr, "Usage: erase <type> <start addr> 
>>>> <end addr> </path/to/mmcblkX>\n");
>>>> +               exit(1);
>>>> +       }
>>>> +
>>>> +       if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
>>>> +               start = strtol(argv[2], eptr, 16);
>>>> +       else
>>>> +               start = strtol(argv[2], eptr, 10);
>>>> +
>>>> +       if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
>>>> +               end = strtol(argv[3], eptr, 16);
>>>> +       else
>>>> +               end = strtol(argv[3], eptr, 10);
>>>> +
>>>> +       if (end < start) {
>>>> +               fprintf(stderr, "erase start [0x%08x] > erase end 
>>>> [0x%08x]\n",
>>>> +                       start, end);
>>>> +               exit(1);
>>>> +       }
>>>> +
>>>> +       if (strcmp(argv[1], "legacy") == 0) {
>>>> +               arg = 0x00000000;
>>>> +               print_str = "Legacy Erase";
>>>> +       } else if (strcmp(argv[1], "discard") == 0) {
>>>> +               arg = 0x00000003;
>>>> +               print_str = "Discard";
>>>> +       } else if (strcmp(argv[1], "secure-erase") == 0) {
>>>> +               print_str = "Secure Erase";
>>>> +               checkup_mask = EXT_CSD_SEC_ER_EN;
>>>> +               arg = 0x80000000;
>>>> +       } else if (strcmp(argv[1], "secure-trim1") == 0) {
>>>> +               print_str = "Secure Trim Step 1";
>>>> +               checkup_mask = EXT_CSD_SEC_ER_EN | 
>>>> EXT_CSD_SEC_GB_CL_EN;
>>>> +               arg = 0x80000001;
>>>> +       } else if (strcmp(argv[1], "secure-trim2") == 0) {
>>>> +               print_str = "Secure Trim Step 2";
>>>> +               checkup_mask = EXT_CSD_SEC_ER_EN | 
>>>> EXT_CSD_SEC_GB_CL_EN;
>>>> +               arg = 0x80008000;
>>>> +       } else if (strcmp(argv[1], "trim") == 0) {
>>>> +               print_str = "Trim";
>>>> +               checkup_mask = EXT_CSD_SEC_GB_CL_EN;
>>>> +               arg = 0x00000001;
>>>> +       } else {
>>>> +               fprintf(stderr, "Unknown erase type: %s\n", argv[1]);
>>>> +               exit(1);
>>>> +       }
>>>> +
>>>> +       dev_fd = open(argv[4], O_RDWR);
>>>> +       if (dev_fd < 0) {
>>>> +               perror(argv[4]);
>>>> +               exit(1);
>>>> +       }
>>>> +
>>>> +       if (checkup_mask) {
>>>> +               ret = read_extcsd(dev_fd, ext_csd);
>>>> +               if (ret) {
>>>> +                       fprintf(stderr, "Could not read EXT_CSD 
>>>> from %s\n",
>>>> +                               argv[4]);
>>>> +                       goto out;
>>>> +               }
>>>> +               if ((checkup_mask & 
>>>> ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) !=
>>>> + checkup_mask) {
>>>> +                       fprintf(stderr, "%s is not supported in %s\n",
>>>> +                               print_str, argv[4]);
>>>> +                       ret = -ENOTSUP;
>>>> +                       goto out;
>>>> +               }
>>>> +
>>>> +       }
>>>> +       printf("Executing %s from 0x%08x to 0x%08x\n", print_str, 
>>>> start, end);
>>>> +
>>>> +       ret = erase(dev_fd, arg, start, end);
>>>> +out:
>>>> +       printf(" %s %s!\n\n", print_str, ret ? "Failed" : "Succeed");
>>>> +       close(dev_fd);
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +
>>>>   int do_ffu(int nargs, char **argv)
>>>>   {
>>>>   #ifndef MMC_IOC_MULTI_CMD
>>>> diff --git a/mmc_cmds.h b/mmc_cmds.h
>>>> index 9d3246c..8331ab2 100644
>>>> --- a/mmc_cmds.h
>>>> +++ b/mmc_cmds.h
>>>> @@ -45,3 +45,4 @@ int do_ffu(int nargs, char **argv);
>>>>   int do_read_scr(int argc, char **argv);
>>>>   int do_read_cid(int argc, char **argv);
>>>>   int do_read_csd(int argc, char **argv);
>>>> +int do_erase(int nargs, char **argv);
>>>> -- 
>>>> 2.24.1 (Apple Git-126)
>>>>
>>
>

