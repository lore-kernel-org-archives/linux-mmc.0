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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2590C43461
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 14:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC97D61460
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 14:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbhDWO2b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Apr 2021 10:28:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49868 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242624AbhDWO2a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Apr 2021 10:28:30 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NEQsNI006668;
        Fri, 23 Apr 2021 14:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=b9oRtVragDlRg6DGknmEJP3/Jw2VQJNkJ7ZM88INP1o=;
 b=WTJCWijaKXIrwm+ZC+ey6rbZRbP6Kwx8rNMIKslxUh0aYHHybUjIrixShCVbbYZk9L9a
 Raub3aLuj1oUSNPRZZFFJsP138UBjKMrPcGWXgaEIAbLEoNgV1lhqX1R6blqHvs+XBdp
 NiEVv/Yd40+y1VicI/bcEwAE7LU8JsSwF4xHNIyJNYA6ThZWeVmRgervs1EAPEk0AYCn
 oZ6ONoRCyKfuyBoRRwEhp2oFkvm5FntcNkBpMmuWAJDHhM28mgOSfAUFUOO59jGu1I9Y
 p/qU8kvNrqWo6mCwsQK4w1qNc/9+pPJ6ymUu6aztcvgGI1uQCAGNPvjOSf1tUa7INbC1 yg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 382uth0rpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 14:27:49 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13NERmRl162129;
        Fri, 23 Apr 2021 14:27:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 383ccfkhxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 14:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjOxpmc2HBN6MIA5+/eq9PCXKditDLg0sHh/roPnA7Rreb9kf0FltyR86QDQL9E+qQUheb6NTLHucEjSK34dhtu8nt6aCHVQjNRGk5DVS6E6mMC9HzROPCTeN+qoPMrqLYBGp+twrQW0X2JNPQAbOHfL49B1Tq7K0TWg1l0WnWbs3oQ2WtMWebqswEANFQf1qd78K1kyX2UryrZH5rothOKm0og0VI7kbtxwgt8P5D/oEKbDTtupc/50OrUTGudyNp++XInQmGCwpoiUH8OA5Ha+eudDcD1s8UNHNN4FL28dMN5UhWiwQS5RSxp2/ZqXbZ+pVCvSLqTi/8qjwcoucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9oRtVragDlRg6DGknmEJP3/Jw2VQJNkJ7ZM88INP1o=;
 b=BEWF0DDZItcsL8+3DqC8e2csG0LGQHAj3wjsc/Jhk8eGWRhACfT0E/HavpPFboI6qTDpHI/dD9IfPofV/vGIYY8hccfM0oRLvk6Y5ElhyKkffe7zNdYL5u53eLslMKvY4ga+QCaP8kvW2WMYKyn/dNuXPV08rgpBuhNB6Qip2Ty57TGnew2GM6JurTcZgJolvFRaNpiDNL6Ow1TNqGJ+yRe1FPdq9IsP7snc8Z9RCAOQacx1huHiBZQoXPI3hDsvJMQTWg7n7Img47ZuEqwVFm52SxN5C0ztMiEUNqabXT+2D0mAXycgqQ5Xhrdrlhz4RcGiJBiUILChD3sZMomfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9oRtVragDlRg6DGknmEJP3/Jw2VQJNkJ7ZM88INP1o=;
 b=zi23WG39QF7z6uYGnWfQExY+YjOIOXJEuTqYtEiTR4qCMVOE6lFJpCkdKy9oY7E/10vzDWJh2F1tsr9f8vguKvH4ZcWM3mLActJmPFe8nseJrLdv4YXFaOIshbr2iQ+kpjo+b+A0+Ioj3OJCihCdZ5de2LOKz9AQSV8uM6xntFM=
Authentication-Results: Kimitos-MBP.hsd1.co.comcast.net; dkim=none (message
 not signed) header.d=none;Kimitos-MBP.hsd1.co.comcast.net; dmarc=none
 action=none header.from=oracle.com;
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR10MB1288.namprd10.prod.outlook.com (2603:10b6:903:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Fri, 23 Apr
 2021 14:27:46 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc%6]) with mapi id 15.20.4065.025; Fri, 23 Apr 2021
 14:27:46 +0000
Subject: Re: [External] : RE: [PATCH RESEND v3] mmc-utils: Re-submit of the
 erase command addition plus remval of MMC_IOC_MULTI_CMD ifndef for erase.
 Re-committing the change per request by Avir.
To:     Avri Altman <Avri.Altman@wdc.com>,
        "luserhker@gmail.com" <luserhker@gmail.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        "chris@printf.net" <chris@printf.net>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
References: <20210422161255.4610-1-luserhker@gmail.com>
 <DM6PR04MB657557ACD70FF26950CF0B0AFC459@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB6575ABF56616177093F75D80FC459@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   kimito.sakata@oracle.com
Message-ID: <08442250-bc20-eaea-f383-cb36f4370102@oracle.com>
Date:   Fri, 23 Apr 2021 08:27:41 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <DM6PR04MB6575ABF56616177093F75D80FC459@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: SN4PR0501CA0102.namprd05.prod.outlook.com
 (2603:10b6:803:42::19) To CY4PR10MB1815.namprd10.prod.outlook.com
 (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by SN4PR0501CA0102.namprd05.prod.outlook.com (2603:10b6:803:42::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Fri, 23 Apr 2021 14:27:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0751fdfc-b052-4c15-4a46-08d90663f695
X-MS-TrafficTypeDiagnostic: CY4PR10MB1288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1288321017D2A0111B3866529D459@CY4PR10MB1288.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZyc74FyB3BxT2oplWhMo3BDSOsa8gNewsxd428hEGBKUOTd5Dj1z7qZcT7m2P0WHhvMeLlAv3X31TPrjyoPpnZtiT7c9uM2Rqq2q2v2zi4iR4bUGtLBRFRNBTFldjzoIav3Po9+D8ZYz97AmOaLzbkmJKGXm6GFoeoBNrbMIUbxYEUDNB/aEqLrOEnn3FJRNWsD7fGyuTvQGTP+UD2pZJMA/+vVU+eLnheKG03MYrQqWaZo+zJhTo0M6wyU6SmcQ6YJqZ3Ird50P5sGSmKXTrVxamitd9amjYMTh8aCVQe0VNplxFTYcdE8Hq/V8cOQHhxMPU2bAk3Fa4Zwg4dSNeOY6pliF2JRTcMPQZLkSl0eva4N1T9RrhfiYbbxrhe8/GsUmIlaNOyOXf6h+MVfkEW8wx+2SM4VrgvBx8YL5ykPt/JdWeFyVX8XBWHguzfzegnkWQnwm2Ym2S1WjRrtntKP7F4ES9bnASYfZECrZwUjltQRWbs76/4co4PhKU6ZxfSO2oObSnPBeEILoHAloy4t4xJXMOuouEvAATb37yjcT9x6Tl0QMWFOeu3bIsdrZfN2VdvGaULBHltAsIDoNIjx3JhZ3oYLRZpeqXo6R3h57ssAAgK8guPHlbvzCV1tonf22jxa9NX07WWDGcWO2DUFU9nFZBHv1maRDWsKJ7f28tex76dE1m4rV0vFS2ImqzUonD8xVETtrLMrO+H/sdREgprIU8jPu/o8kS81zbwpw6vQT2fzMeMFpW1U6ZHid+vdumytRjalMOKaJVZT6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(16576012)(2906002)(83380400001)(9686003)(26005)(110136005)(316002)(66476007)(31686004)(8676002)(8936002)(4326008)(16526019)(478600001)(186003)(53546011)(38100700002)(31696002)(5660300002)(86362001)(6666004)(36756003)(2616005)(966005)(66556008)(6486002)(54906003)(66946007)(956004)(46800400005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZHhOSTYzMjliNExMNnI3cmQ3RHNpV1doZnNRMGpvaFFyMkNEdzlWQ0tDeGJp?=
 =?utf-8?B?R0VWNEpmb0VnOVJZQ295NFhma3ZPM2hQcTIyUlBncFhUNnF4MEZXS2Evb2k5?=
 =?utf-8?B?ZFp1MjlPalp1Skt3QW1BdTBrQUlreDVYVHU5bHhablV3Zzl0YjFEcGgyaVhQ?=
 =?utf-8?B?SzljVWJLbTNSaWNVVks0ejhmTm92Uk5SWjNWNFNGK3d0amx2QnhOeEttdDNk?=
 =?utf-8?B?OHZOSUN3b1FpaTNkNitJTEwxWGZ0dyt3blBOaE5sNDAzM3pjZ29oTlRGQjJs?=
 =?utf-8?B?WmxOSUdXWHRvcnhSN1hvN3RxYmZ4N0hFZmk0TDBRa29qbEJBT3AwODFBNy9S?=
 =?utf-8?B?U09RRE9mYnVtVm9xYS9CM2FMZ0NkRkdONmlOWXV0cWpsRVpvOUpITGhVOHhG?=
 =?utf-8?B?VWNHbEd1MTBneE1HbXFTeUcwQVlKUU0vaHE5c0tHOEJOcDI0TVFZOWJpVStS?=
 =?utf-8?B?dC9MeTd3Y2ZaNlBKdVJ0cjJGVGdTNERsN0FVYUxneGEybXVwWGdoZGxpRW5x?=
 =?utf-8?B?Tnc1L0hTclZ2eUZFUGdEUU9Id1cxRVphVE80dFRxRjhFcUFkNWgzZmpiNXA0?=
 =?utf-8?B?MWhoV3FwSTBnRTVuUFBYQWQzRGpTeG4wZmRtdk05NWgyb2pUTTh4WnJtTWpv?=
 =?utf-8?B?VW9mbkIyT1ZGVFlOckkyUlUwN0VPT0lESU5vOUE5bzkzOHpWbDhXd0JRMXNP?=
 =?utf-8?B?THpaL016L1p2dS9UQlF6SGhCRTdERHNvTU9HV3l5ZFBGRHRYdjJSM0hSbWRy?=
 =?utf-8?B?QlFGeTZFbUZpMDVqV3pkOUlZUDlkTFlCT2tCOFRvVDBXNkFHSXFxTHdMRm1a?=
 =?utf-8?B?bHE1YkcrcEN0Tll1OG5CeWdycFlrUGtXM3I2RWFVVDhHYkpLYlMvQWl2YnV1?=
 =?utf-8?B?VlIwRlVKOGswUEU0ZHJHTlRUa0pVVElYUDVSMlB1MHBRTjNYcS9ZbmQyM3BS?=
 =?utf-8?B?NXJua0V3bGxOWUFOTXBrOGhIdzRYVENtU0kzd0VsbXRvMFlFV3hmbEdUZFJH?=
 =?utf-8?B?ZlZIU1FoVEJuK3ExN0gyNndrVHk4Z0lyM0o1TnBOaGllWkhaTzVRTDg3SXdS?=
 =?utf-8?B?YmpFWkxqM3czL0o1a2xVMnVGNkpOQzRvNE5jZU5KL0dFNGRVZmtGZnhHOFo0?=
 =?utf-8?B?WnJ3eU5nVXRaak9QZTJEOTVvb3FjekY3VVVuQzh5Z1RIZ0RYWFBWYWNlVWg3?=
 =?utf-8?B?K0tPRFVNUkNib2lKZVJrQ0FENFpmZUNvMWpBek85RVJZMFpCVjBWODJvTFBS?=
 =?utf-8?B?bXdPL0FPUmQ5MW9tLzNkRUQ0WXpoczFhaXNGejVqRjlSeGxZRFZCSkI3a3Fs?=
 =?utf-8?B?cFVtSmQvSnpJWDVNYVdxVnJwOHdsQ2pGa3lrT2pQdGtyTXJjRkdtei9kemln?=
 =?utf-8?B?WHBWU1VXaTNtK0UrYVFKN0UzUkZqL0dDbXNUcWkvbVVRTlZsQkh1K21HZnVP?=
 =?utf-8?B?dEJaUW5NZWwzcUF1M3VxakhNTGc2L2FQelRITmZtUDZtVmV1cmdaS2VwZW41?=
 =?utf-8?B?N1NUdTQzS2x5bUpIOGJ1WmhTRk1QMmF1QWFHVWkyOHM4NnpHN0xwbG0rQjdT?=
 =?utf-8?B?SEVtZXdROFRGOWFZK1pUYmVqQ0xvdXlsaVJDUDBmS1ZBd3kyNmIwOTRSMlVl?=
 =?utf-8?B?L0ZlU3NjQWRKcE8wOFJFUlcrS0tRSmtzRG13VUlSYjZSdDdKSjZmRHkzSE9p?=
 =?utf-8?B?NG9JMDRoa01BQUZ3dGR4NkFMQXI4ZnVnN3VhTW9MWWFTK3lTWGZtekQzSFBN?=
 =?utf-8?Q?3CUkpoUuPIOawP/fwD7SCdw6LRc9YCnUOZ/VLXS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0751fdfc-b052-4c15-4a46-08d90663f695
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 14:27:46.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mm2OxWZFJ5KYZoqUTp9qoTQzwkzNrbH5dlBduWCh4Ok8xtD/pIoGzxjtVuec1aDAGMoZh3Wad4LYOZsJ/cwZhLjl5DarLauNWdujilvDYkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1288
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9963 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104230094
X-Proofpoint-ORIG-GUID: 9O4sYFp4jkCDXM1yFapF4WUqr0D0hEY_
X-Proofpoint-GUID: 9O4sYFp4jkCDXM1yFapF4WUqr0D0hEY_
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Its basically the same changes. Bean was coaching me on how to send the 
changes.
The only difference between Bean's submit and my last one is Ulf 
requested me to make a change in my changes to remove the 
MMC_IOC_MULTI_CMD #ifndef segments.

Thanks
Kimito

On 4/22/2021 11:31 PM, Avri Altman wrote:
> +Bean
>
>>> From: Kimito Sakata <kimito.sakata@oracle.com>
>>>
>>> Signed-off-by: Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
>> Hi Kimito,
>> Please use a proper subject and commit log body.
>> If you don't understand the difference between those two - please ask.
>> Also for consistency, you might want to use your oracle mail for your Signed-
>> off-by tag.
>> You need to change your git configs for that.
> Also, can you refer to this patch submitted by Bean - https://urldefense.com/v3/__https://www.spinics.net/lists/linux-mmc/msg63582.html__;!!GqivPVa7Brio!PTrg4lGpraGQnZjmxPdNPivVE4IYFevBm1M6vu3_hfHR8REY7LwkcZ3WiZc3MhF21tM$
> Are you co-developing this together?
>
> Thanks,
> Avri
>
>> Thanks,
>> Avri
>>
>>> ---
>>>   mmc.c      |   8 ++++
>>>   mmc.h      |  13 +++++-
>>>   mmc_cmds.c | 135
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   mmc_cmds.h |   1 +
>>>   4 files changed, 156 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mmc.c b/mmc.c
>>> index f3d724b..eb2638b 100644
>>> --- a/mmc.c
>>> +++ b/mmc.c
>>> @@ -229,6 +229,14 @@ static struct Command commands[] = {
>>>                  "Run Field Firmware Update with <image name> on <device>.\n",
>>>            NULL
>>>          },
>>> +       { do_erase, -4,
>>> +       "erase", "<type> " "<start address> " "<end address> " "<device>\n"
>>> +               "Send Erase CMD38 with specific argument to the <device>\n\n"
>>> +               "NOTE!: This will delete all user data in the specified region of the
>>> device\n"
>>> +               "<type> must be: legacy | discard | secure-erase | "
>>> +               "secure-trim1 | secure-trim2 | trim \n",
>>> +       NULL
>>> +       },
>>>          { 0, 0, 0, 0 }
>>>   };
>>>
>>> diff --git a/mmc.h b/mmc.h
>>> index 5754a9d..e9766d7 100644
>>> --- a/mmc.h
>>> +++ b/mmc.h
>>> @@ -35,7 +35,15 @@
>>>   #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr   R1b */
>>>   #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr   R1b */
>>>   #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   R1  */
>>> -
>>> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr   R1  */
>>> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr   R1  */
>>> +#define MMC_ERASE              38    /* ac   [31] Secure request
>>> +                                             [30:16] set to 0
>>> +                                             [15] Force Garbage Collect request
>>> +                                             [14:2] set to 0
>>> +                                             [1] Discard Enable
>>> +                                             [0] Identify Write Blocks for
>>> +                                             Erase (or TRIM Enable)  R1b */
>>>   /*
>>>    * EXT_CSD fields
>>>    */
>>> @@ -62,6 +70,7 @@
>>>   #define EXT_CSD_CACHE_SIZE_2           251
>>>   #define EXT_CSD_CACHE_SIZE_1           250
>>>   #define EXT_CSD_CACHE_SIZE_0           249
>>> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
>>>   #define EXT_CSD_BOOT_INFO              228     /* R/W */
>>>   #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>>>   #define EXT_CSD_HC_WP_GRP_SIZE         221
>>> @@ -190,6 +199,8 @@
>>>   #define EXT_CSD_REV_V4_2               2
>>>   #define EXT_CSD_REV_V4_1               1
>>>   #define EXT_CSD_REV_V4_0               0
>>> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
>>> +#define EXT_CSD_SEC_ER_EN              (1<<0)
>>>
>>>
>>>   /* From kernel linux/mmc/core.h */
>>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>>> index 6c24cea..9340e3f 100644
>>> --- a/mmc_cmds.c
>>> +++ b/mmc_cmds.c
>>> @@ -2514,6 +2514,141 @@ int do_cache_dis(int nargs, char **argv)
>>>          return do_cache_ctrl(0, nargs, argv);
>>>   }
>>>
>>> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
>>> +{
>>> +#ifndef MMC_IOC_MULTI_CMD
>>> +       fprintf(stderr, "mmc-utils has been compiled without
>>> MMC_IOC_MULTI_CMD"
>>> +                       " support, needed by erase.\n");
>>> +       return -ENOTSUP;
>>> +#else
>>> +       int ret = 0;
>>> +       struct mmc_ioc_multi_cmd *multi_cmd;
>>> +
>>> +       multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
>>> +                          3 * sizeof(struct mmc_ioc_cmd));
>>> +       if (!multi_cmd) {
>>> +               perror("Failed to allocate memory");
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       multi_cmd->num_of_cmds = 3;
>>> +       /* Set erase start address */
>>> +       multi_cmd->cmds[0].opcode = MMC_ERASE_GROUP_START;
>>> +       multi_cmd->cmds[0].arg = start;
>>> +       multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
>>> MMC_CMD_AC;
>>> +       multi_cmd->cmds[0].write_flag = 1;
>>> +
>>> +       /* Set erase end address */
>>> +       multi_cmd->cmds[1].opcode = MMC_ERASE_GROUP_END;
>>> +       multi_cmd->cmds[1].arg = end;
>>> +       multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
>>> MMC_CMD_AC;
>>> +       multi_cmd->cmds[1].write_flag = 1;
>>> +
>>> +       /* Send Erase Command */
>>> +       multi_cmd->cmds[2].opcode = MMC_ERASE;
>>> +       multi_cmd->cmds[2].arg = argin;
>>> +       multi_cmd->cmds[2].cmd_timeout_ms = 300*255*255;
>>> +       multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
>>> MMC_CMD_AC;
>>> +       multi_cmd->cmds[2].write_flag = 1;
>>> +
>>> +       /* send erase cmd with multi-cmd */
>>> +       ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>>> +       if (ret)
>>> +               perror("Erase multi-cmd ioctl");
>>> +
>>> +       free(multi_cmd);
>>> +       return ret;
>>> +#endif
>>> +}
>>> +
>>> +int do_erase(int nargs, char **argv)
>>> +{
>>> +       int dev_fd, ret;
>>> +       char *print_str;
>>> +       char **eptr = NULL;
>>> +       __u8 ext_csd[512], checkup_mask = 0;
>>> +       __u32 arg, start, end;
>>> +
>>> +       if (nargs != 5) {
>>> +               fprintf(stderr, "Usage: erase <type> <start addr> <end addr>
>>> </path/to/mmcblkX>\n");
>>> +               exit(1);
>>> +       }
>>> +
>>> +       if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
>>> +               start = strtol(argv[2], eptr, 16);
>>> +       else
>>> +               start = strtol(argv[2], eptr, 10);
>>> +
>>> +       if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
>>> +               end = strtol(argv[3], eptr, 16);
>>> +       else
>>> +               end = strtol(argv[3], eptr, 10);
>>> +
>>> +       if (end < start) {
>>> +               fprintf(stderr, "erase start [0x%08x] > erase end [0x%08x]\n",
>>> +                       start, end);
>>> +               exit(1);
>>> +       }
>>> +
>>> +       if (strcmp(argv[1], "legacy") == 0) {
>>> +               arg = 0x00000000;
>>> +               print_str = "Legacy Erase";
>>> +       } else if (strcmp(argv[1], "discard") == 0) {
>>> +               arg = 0x00000003;
>>> +               print_str = "Discard";
>>> +       } else if (strcmp(argv[1], "secure-erase") == 0) {
>>> +               print_str = "Secure Erase";
>>> +               checkup_mask = EXT_CSD_SEC_ER_EN;
>>> +               arg = 0x80000000;
>>> +       } else if (strcmp(argv[1], "secure-trim1") == 0) {
>>> +               print_str = "Secure Trim Step 1";
>>> +               checkup_mask = EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN;
>>> +               arg = 0x80000001;
>>> +       } else if (strcmp(argv[1], "secure-trim2") == 0) {
>>> +               print_str = "Secure Trim Step 2";
>>> +               checkup_mask = EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN;
>>> +               arg = 0x80008000;
>>> +       } else if (strcmp(argv[1], "trim") == 0) {
>>> +               print_str = "Trim";
>>> +               checkup_mask = EXT_CSD_SEC_GB_CL_EN;
>>> +               arg = 0x00000001;
>>> +       } else {
>>> +               fprintf(stderr, "Unknown erase type: %s\n", argv[1]);
>>> +               exit(1);
>>> +       }
>>> +
>>> +       dev_fd = open(argv[4], O_RDWR);
>>> +       if (dev_fd < 0) {
>>> +               perror(argv[4]);
>>> +               exit(1);
>>> +       }
>>> +
>>> +       if (checkup_mask) {
>>> +               ret = read_extcsd(dev_fd, ext_csd);
>>> +               if (ret) {
>>> +                       fprintf(stderr, "Could not read EXT_CSD from %s\n",
>>> +                               argv[4]);
>>> +                       goto out;
>>> +               }
>>> +               if ((checkup_mask & ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) !=
>>> +                                                               checkup_mask) {
>>> +                       fprintf(stderr, "%s is not supported in %s\n",
>>> +                               print_str, argv[4]);
>>> +                       ret = -ENOTSUP;
>>> +                       goto out;
>>> +               }
>>> +
>>> +       }
>>> +       printf("Executing %s from 0x%08x to 0x%08x\n", print_str, start, end);
>>> +
>>> +       ret = erase(dev_fd, arg, start, end);
>>> +out:
>>> +       printf(" %s %s!\n\n", print_str, ret ? "Failed" : "Succeed");
>>> +       close(dev_fd);
>>> +       return ret;
>>> +}
>>> +
>>> +
>>>   int do_ffu(int nargs, char **argv)
>>>   {
>>>   #ifndef MMC_IOC_MULTI_CMD
>>> diff --git a/mmc_cmds.h b/mmc_cmds.h
>>> index 9d3246c..8331ab2 100644
>>> --- a/mmc_cmds.h
>>> +++ b/mmc_cmds.h
>>> @@ -45,3 +45,4 @@ int do_ffu(int nargs, char **argv);
>>>   int do_read_scr(int argc, char **argv);
>>>   int do_read_cid(int argc, char **argv);
>>>   int do_read_csd(int argc, char **argv);
>>> +int do_erase(int nargs, char **argv);
>>> --
>>> 2.24.1 (Apple Git-126)

