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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CDBC43470
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C471961410
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 15:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbhDVPnv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:43:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34918 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhDVPmu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Apr 2021 11:42:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13MFODpU013496;
        Thu, 22 Apr 2021 15:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vNRfFNRc6c/S9AVKSNZc6QH7ZDdDL72KLjvkJppLAiI=;
 b=hszT8N/N6m+QTW1ieh6SAcF7FQvmZSw7i/NSFndB7z74EUa6Gn8Umx901qlMYDDtOWsN
 lNwPizQ5jCyzqOO/yD8pA9Sijl1g0/4oinZkrCDTd28KB1UJ3lPTAbz/K8K7o6xjEEx2
 aRVfR96WoU0n2Net06hqjm5qMKSttohNoZRJCHr9IIA8HqJRH9fxWq8OtMYV8iJc4Fiz
 biktBn5a2mKY666qYOLeTR/+eT1Tm60AFoS5Hx+r81VqgCj9fPcbmakRBHzO3EpO7LNO
 9LF6uSE+GdmztxrUNp36m1efm90V296a1+vlrWisp71Yml4dLQR8Rhl6TbVcWQvewc+w zA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37yn6cdwha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 15:42:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13MFP3fQ135499;
        Thu, 22 Apr 2021 15:42:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 383006p52c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 15:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4qzHrRtFw8yWT5lJYyjGrYbLRCaY8x8weBX1WhB5J6UNWCSazfQeEALGC0GC5U6SVi+wrtqVeaykGWAuGE0UpEEokazxwML+VZe5FfcV/pUXry+0R0KdsiYycJJYYSmmMDpkYMN7bdFZ2iidhCcouYQFPd7nAKBi30n+8qa68xI869WCnbuYHUhYKkKaPwhdbkfiZILL6O4adFLD5vzE39DBvhJFrNEEV3+FsGJDEhILYUzce77r+69vugM76YXGKkxu79KBA4qy51f1Hxij2c9lstL54vSWYLDNHTtklo61Bv3GTPY+HIB3Af9VhQb7QChCUqZYL5ujAgNRhfeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNRfFNRc6c/S9AVKSNZc6QH7ZDdDL72KLjvkJppLAiI=;
 b=DiyCChSCk2gKzQdSmwZIB5ed+HKTYyQlZFD4X1sA7VtCZYfo7YZuVSuvuVPFMKTA/qxXLfkPM7006eeSLZZWQfmplfpcdK5WbhfVabU8hY+vmI3S32BdRHOBVKt/liIFLb2XtG1S4KUWaAFM0njPb59S0l3Y0WTc3k7TsaG2gpfpjMZF0A9xvVtTuHsDtRLSy+SdZCIG6KoUdcO92JUcokki2F4S/JwRSBvduQyoZcWVMOH0le+Ug74cDKckJnBmnPRgqH6YlwSEqf4EZsDoeF29XeD7AOxX4v6Xq/omD+yMDmH3jhrHQg1M6M0EcHTFDdRjTBKOv8BPrAvH2B+T8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNRfFNRc6c/S9AVKSNZc6QH7ZDdDL72KLjvkJppLAiI=;
 b=rDxMapRUiuKCZA1L18B7Z/ldEkP1ZFzndg4sAJg2EXcOdRr7f0UnTE2NLcQCMhAxjlwAngpab5CTZfYVef+tw3OozcVfdsA4GB9d8g5t4XRog0uoRaVpZR8YyENWEzqpIX9IL78hm8uf1izw097Ib9Hyev0BePDy+Y6JDLpaHhs=
Authentication-Results: kimitos-mbp.hsd1.co.comcast.net; dkim=none (message
 not signed) header.d=none;kimitos-mbp.hsd1.co.comcast.net; dmarc=none
 action=none header.from=oracle.com;
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR10MB1365.namprd10.prod.outlook.com (2603:10b6:903:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Thu, 22 Apr
 2021 15:42:09 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc%6]) with mapi id 15.20.4065.021; Thu, 22 Apr 2021
 15:42:09 +0000
Subject: Re: [External] : Re: [PATCH v3] Re-submit of the erase command
 addition plus removal of MMC_IOC_MULTI_CMD ifndef for erase. Author=Kimito
 Sakata <kimito.sakata@oracle.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@kimitos-mbp.hsd1.co.comcast.net>
References: <20210401230221.12532-1-luserhker@gmail.com>
 <CAPDyKFpjTikAzDqkcbyxa1Y918OevojZYhREPsmQgeo_Sd0xgA@mail.gmail.com>
 <7bca3bca-b058-7086-b733-359c21e3d473@oracle.com>
 <7842f17c-7d8b-481a-1f84-c80de715be0d@oracle.com>
 <55316844-d13f-bb84-a269-98f8cb649016@oracle.com>
 <CAPDyKFqwztxA7yWBhUpqgd=oHyBS5L-gu77y-R8TdfJPnisVwA@mail.gmail.com>
 <DM6PR04MB65755D0EAEA05B06888569AEFC469@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   kimito.sakata@oracle.com
Message-ID: <ea1023cb-bd06-87d8-ec1d-c81a100a6af1@oracle.com>
Date:   Thu, 22 Apr 2021 09:42:04 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <DM6PR04MB65755D0EAEA05B06888569AEFC469@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: SN7PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:806:f2::9) To CY4PR10MB1815.namprd10.prod.outlook.com
 (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by SN7PR04CA0004.namprd04.prod.outlook.com (2603:10b6:806:f2::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 15:42:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be06cf6f-f7c9-48b0-8e4d-08d905a5306f
X-MS-TrafficTypeDiagnostic: CY4PR10MB1365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1365038CB6199BE237B1E7F59D469@CY4PR10MB1365.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XnLcDO3WY3cDAglXtO7PqDPM3jLEfMBv/m5d7rAXzOKe5/pVrBwRgvRmwu3gxnAYbP5tDr2YD6R+UqRdDHK7TsvFHicDeBCJxFgl/wtUqhQQWN8KzSjBzLHj0ImDgDJHgT1tBoC+KWZ3kXk3ytngUId2WrBnaGwEQw8YeACuVAFKTpDPTOuan/0ShALQS/74veeZrGx0m8sPbDb5KHLhE09ga6Uyo6ksL9+Cr4vLh0UxOLzUfst4r8o6rCihUUVtk/+FJ8EBvPoCoSXXZJ/syQb/+4K1i2/vyatDO5EE7AUWOwxeO3whH5SPle67J+MOxjLMD4j7hgl4hCYt4zJlxsI6SRX98R0CJXexTfF/UERbfOJ0hLD3LOge3HR2f0Xd4/Yn/wka3h9igvv57gIYMf3oL3Hmsmu55xX8wFIYQ0r8GvgAlcBMzTkzQXBFEzzEUyB5DVoslAg6M//IKHIPHMwp0B2N6pa5f7m3/l7oWz4HJz/Mb88y4oS2/G3Xh8RWgxGiRXSRBhsKgJsaD4EnIDxiZ9PA4msmZTDtUFlwryjbPV/+cFPBoOqbf4UF1Oooo23PpnWexyWfW+lWYlvY3pRhEdsjraN5tdXfk2CaauCBo4+ly3bZYHIBNOXZz+tlAIg+QdwJTlZa6k7wNTQgrxtnER1mpO7ZIQ0xWvSJO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(39860400002)(376002)(53546011)(54906003)(31686004)(186003)(86362001)(6666004)(2616005)(16526019)(26005)(83380400001)(478600001)(4326008)(956004)(8676002)(36756003)(38100700002)(316002)(16576012)(66946007)(31696002)(2906002)(66476007)(8936002)(6486002)(5660300002)(9686003)(66556008)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ajBQRHUrSk0rRk5sZkVMNmYrYXNtZ2JkMnppK1lwYlZiTjRsU3pDR1FnZWxK?=
 =?utf-8?B?ZTd3NlllbWd3UXh1MmZmTFRKdEZqa0kzT3B1RC9VTmcwZC9ZMmlBRzYzRVJL?=
 =?utf-8?B?RlgzV3JnVXN4bFNmbWFEc2xVT01nbXNKZzdyc3p3MHcyNlJHZjcyNXVvVytC?=
 =?utf-8?B?L3JwQzQ4a1VnVEwvRURISW9LM0pXb0VGZnBYUzQvSFAxUG5NaXQ3NS90WlEy?=
 =?utf-8?B?aTg3a3NJUk1pWDRsbE0vS3l3YS9xVnBnNFh2MWNTSmNzb0VaRjVBVkEyV2NY?=
 =?utf-8?B?ejJzaDREa3Rwbk5VZkQ1UXJxSlR0UHBBbllqR2tTaVZOWVBvMnZQaWo0N29h?=
 =?utf-8?B?U2tVd0lkV3FOUys1V2hoR25yQjJJMm4vL3g4Y2l2UWc3MVpaQVA4RFNaRFZG?=
 =?utf-8?B?NW1pOUNhNkJpRytyS2xUUVBFNDBrcnBJdEsrUDZBYzh5WnA1TVFjTS92Ulll?=
 =?utf-8?B?cFp0dlVPdUdtcitCcXNPcFZvY1pFZ2dOcC9GRWViSGVXSWxOZG1ZcXVxNHZZ?=
 =?utf-8?B?VkRGUVhybFhkeHpRTUJSc3NPbjdDRUVyZEU4ZTYxVk1QZ1o1MWtVS1NxaE9T?=
 =?utf-8?B?TEs3Um5lcGh2VUd2ZUtTdFkzbHpkNFdIRUxYNTZkdnh2VWxBM2IvLy9panc4?=
 =?utf-8?B?d09HajdnWmxlYkR4OTdzb2Z1S1JDM0hvMzR6Q1gwcHNOZ3hrck5SVkwxKzgx?=
 =?utf-8?B?TDRsNFVwS05EZnZRTnFwRk9xUkxCNm9hU0tPTzFRck50bDMwbytJeEMwTWxw?=
 =?utf-8?B?S2h4bVJnWE5mLy9ETzBEVHpYL3FTK0NpT29uSUZXUUs0S0lYSUdRczkyRUlw?=
 =?utf-8?B?TkV4RXVia1R6Q3MrZkNNaFRvWng4aklGQ2Y0YkZjbEVSY1dWRWFIZkg2N3k5?=
 =?utf-8?B?ZW5CbVJRcVd6K2t2L2cwZUgxeEJZWWZBbTRvNWVKQ0F1WEtGWkh5QVh2Z3di?=
 =?utf-8?B?SGQ3UFIvWFBoMWIrWUNXVjI3NnE0QzJlazkvR1I1cUo5WThIQ3JuVDEybjZw?=
 =?utf-8?B?a1ZGWkxleWNwUTlPcmtSSlJXZlJob1FTM3VFNU0zMlBESFdTTHJ0MXdSV0Z6?=
 =?utf-8?B?aTZocm94bFk1a2x1UGtkZDhiTnh1ekllUmVtRXBjd0xCQXBmNEJVWS9Md0Jy?=
 =?utf-8?B?dnZqTGpaUzZWOVQvWGlTYmRCeWQvTk50YmJiWUM5U1FJdElOQWsvWmpXRmlo?=
 =?utf-8?B?MWsyRmZTMGY2WGQ2cE1FaFQyZEdIVE9ac2pHUEZ4aEVJN1ZEYVlISm55Vy8v?=
 =?utf-8?B?Si9tVThxdTQxZVI4QW56d0dCWVJkckhsRzRoeFB1RGlPdDRJOHlrM0hudk1n?=
 =?utf-8?B?V0tSTUxJZG1GNExCSDFVTzZnL2dEM1U1ckdNVExYYXBReXIvQXh4dUYyS1By?=
 =?utf-8?B?RVNOR1E4ckMvMVhSU1g5SlVMZmJaSmNTaDJEUmdwSmdveDBBcTJhOU5BMTBT?=
 =?utf-8?B?UG1JOFE5R3V4RGpmdzlJRjdpVnNrODFaV1NTWVJJSzlYZUlSNVVwWUphZEk3?=
 =?utf-8?B?SCtWdCtHc0tOS3pkMVdjVmxseGlQcUtBUko5ZFdCYUZuMzRpOGtoaTVuL2c3?=
 =?utf-8?B?cDEvU3A1c3lpZTZ1UmJXaHNWT3M4c1BLcUREYm5tNGJZdjJaTlRzN0wreTZJ?=
 =?utf-8?B?ZlFOVnVzalFMVVJhS1pTRy9HQkZQclpYanl3bk5ReXdFb1hYdTg1YzdpUTdi?=
 =?utf-8?B?dzhURE5WNzJrMTVDZmRNK283L2oxM1h5UzVRNEdSZ2NYVDhpd2J3ejFLRzlN?=
 =?utf-8?Q?+7BipNnhsXPDKbD6WiyN+6CilrrAvLccJh8suXc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be06cf6f-f7c9-48b0-8e4d-08d905a5306f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:42:09.2114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDmTHXxuTcoAlxX8JNHJU1MFHLpEp74wRWZV0OQBCFAR87f8xbRnpDjUA66cAVEOW6ed9m+L951t3yYokNIG6AH09KKJIJMr9wXgqEZYVk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1365
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220121
X-Proofpoint-GUID: 6o5e1m_yz2t1s2QRoOCSfpkjmRLNcBPC
X-Proofpoint-ORIG-GUID: 6o5e1m_yz2t1s2QRoOCSfpkjmRLNcBPC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220121
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 4/22/2021 2:23 AM, Avri Altman wrote:
>> On Wed, 21 Apr 2021 at 20:39, <kimito.sakata@oracle.com> wrote:
>>> Ulf
>>>
>>> Looks like Avri either has no comments or cannot respond. Could we
>>> please go ahead with the changes?
>> I think we should give him a couple more days, it's not been more than
>> just a week since I looped him in to review the patch.
>>
>> Another option, that might be easier for him, is if you repost the
>> patch and make sure Avri is on the to-list, this time.
>>
>> Kind regards
>> Uffe
> Hi,
> Sorry for not catching this, my mail is looking for "mmc-utils" prefix....
> When resending, can you please make sure that your patch is properly formatted:
> Subject: [PATCH RESEND v3] mmc-utils: <your subject>
>
> <informative commit log>
Avri
Thanks for responding.
So you want me to resubmit with the addition of "mmc-utils" in the 
subject line correct?
Kimito

>
> Thanks,
> Avri
>
>>> Thanks
>>> Kimito
>>>
>>> On 4/20/2021 11:22 AM, kimito.sakata@oracle.com wrote:
>>>> Avri
>>>>
>>>> I'm sure you are very busy, but I would appreciate if you have any
>>>> concerns on these changes that I submitted.
>>>>
>>>> Thanks
>>>> Kimito
>>>>
>>>>
>>>> On 4/15/2021 2:11 PM, kimito.sakata@oracle.com wrote:
>>>>> Avri
>>>>>
>>>>> Please let me know if you have some concerns.
>>>>>
>>>>> Kimito
>>>>>
>>>>> On 4/15/2021 6:32 AM, Ulf Hansson wrote:
>>>>>> + Avri
>>>>>>
>>>>>> On Fri, 2 Apr 2021 at 01:02, <luserhker@gmail.com> wrote:
>>>>>>> From: Kimito Sakata <kimito.sakata@oracle.com>
>>>>>>>
>>>>>>> Signed-off-by: Kimito Sakata <ksakata@Kimitos-
>> MBP.hsd1.co.comcast.net>
>>>>>> This looks okay to me, but I have looped in Avri who might have some
>>>>>> comments.
>>>>>>
>>>>>> Kind regards
>>>>>> Uffe
>>>>>>
>>>>>>> ---
>>>>>>>    mmc.c      |   8 ++++
>>>>>>>    mmc.h      |  13 +++++-
>>>>>>>    mmc_cmds.c | 129
>>>>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>    mmc_cmds.h |   1 +
>>>>>>>    4 files changed, 150 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/mmc.c b/mmc.c
>>>>>>> index f3d724b..eb2638b 100644
>>>>>>> --- a/mmc.c
>>>>>>> +++ b/mmc.c
>>>>>>> @@ -229,6 +229,14 @@ static struct Command commands[] = {
>>>>>>>                   "Run Field Firmware Update with <image name> on
>>>>>>> <device>.\n",
>>>>>>>             NULL
>>>>>>>           },
>>>>>>> +       { do_erase, -4,
>>>>>>> +       "erase", "<type> " "<start address> " "<end address> "
>>>>>>> "<device>\n"
>>>>>>> +               "Send Erase CMD38 with specific argument to the
>>>>>>> <device>\n\n"
>>>>>>> +               "NOTE!: This will delete all user data in the
>>>>>>> specified region of the device\n"
>>>>>>> +               "<type> must be: legacy | discard | secure-erase | "
>>>>>>> +               "secure-trim1 | secure-trim2 | trim \n",
>>>>>>> +       NULL
>>>>>>> +       },
>>>>>>>           { 0, 0, 0, 0 }
>>>>>>>    };
>>>>>>>
>>>>>>> diff --git a/mmc.h b/mmc.h
>>>>>>> index 5754a9d..e9766d7 100644
>>>>>>> --- a/mmc.h
>>>>>>> +++ b/mmc.h
>>>>>>> @@ -35,7 +35,15 @@
>>>>>>>    #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr
>>>>>>> R1b */
>>>>>>>    #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr
>>>>>>> R1b */
>>>>>>>    #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr
>>>>>>> R1  */
>>>>>>> -
>>>>>>> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr
>>>>>>> R1  */
>>>>>>> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr
>>>>>>> R1  */
>>>>>>> +#define MMC_ERASE              38    /* ac   [31] Secure request
>>>>>>> +                                             [30:16] set to 0
>>>>>>> +                                             [15] Force Garbage
>>>>>>> Collect request
>>>>>>> +                                             [14:2] set to 0
>>>>>>> +                                             [1] Discard Enable
>>>>>>> +                                             [0] Identify Write
>>>>>>> Blocks for
>>>>>>> +                                             Erase (or TRIM
>>>>>>> Enable)  R1b */
>>>>>>>    /*
>>>>>>>     * EXT_CSD fields
>>>>>>>     */
>>>>>>> @@ -62,6 +70,7 @@
>>>>>>>    #define EXT_CSD_CACHE_SIZE_2           251
>>>>>>>    #define EXT_CSD_CACHE_SIZE_1           250
>>>>>>>    #define EXT_CSD_CACHE_SIZE_0           249
>>>>>>> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
>>>>>>>    #define EXT_CSD_BOOT_INFO              228     /* R/W */
>>>>>>>    #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>>>>>>>    #define EXT_CSD_HC_WP_GRP_SIZE         221
>>>>>>> @@ -190,6 +199,8 @@
>>>>>>>    #define EXT_CSD_REV_V4_2               2
>>>>>>>    #define EXT_CSD_REV_V4_1               1
>>>>>>>    #define EXT_CSD_REV_V4_0               0
>>>>>>> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
>>>>>>> +#define EXT_CSD_SEC_ER_EN              (1<<0)
>>>>>>>
>>>>>>>
>>>>>>>    /* From kernel linux/mmc/core.h */
>>>>>>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>>>>>>> index 6c24cea..3e36ff2 100644
>>>>>>> --- a/mmc_cmds.c
>>>>>>> +++ b/mmc_cmds.c
>>>>>>> @@ -2514,6 +2514,135 @@ int do_cache_dis(int nargs, char **argv)
>>>>>>>           return do_cache_ctrl(0, nargs, argv);
>>>>>>>    }
>>>>>>>
>>>>>>> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
>>>>>>> +{
>>>>>>> +       int ret = 0;
>>>>>>> +       struct mmc_ioc_multi_cmd *multi_cmd;
>>>>>>> +
>>>>>>> +       multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
>>>>>>> +                          3 * sizeof(struct mmc_ioc_cmd));
>>>>>>> +       if (!multi_cmd) {
>>>>>>> +               perror("Failed to allocate memory");
>>>>>>> +               return -ENOMEM;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       multi_cmd->num_of_cmds = 3;
>>>>>>> +       /* Set erase start address */
>>>>>>> +       multi_cmd->cmds[0].opcode = MMC_ERASE_GROUP_START;
>>>>>>> +       multi_cmd->cmds[0].arg = start;
>>>>>>> +       multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
>>>>>>> MMC_CMD_AC;
>>>>>>> +       multi_cmd->cmds[0].write_flag = 1;
>>>>>>> +
>>>>>>> +       /* Set erase end address */
>>>>>>> +       multi_cmd->cmds[1].opcode = MMC_ERASE_GROUP_END;
>>>>>>> +       multi_cmd->cmds[1].arg = end;
>>>>>>> +       multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
>>>>>>> MMC_CMD_AC;
>>>>>>> +       multi_cmd->cmds[1].write_flag = 1;
>>>>>>> +
>>>>>>> +       /* Send Erase Command */
>>>>>>> +       multi_cmd->cmds[2].opcode = MMC_ERASE;
>>>>>>> +       multi_cmd->cmds[2].arg = argin;
>>>>>>> +       multi_cmd->cmds[2].cmd_timeout_ms = 300*255*255;
>>>>>>> +       multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B
>> |
>>>>>>> MMC_CMD_AC;
>>>>>>> +       multi_cmd->cmds[2].write_flag = 1;
>>>>>>> +
>>>>>>> +       /* send erase cmd with multi-cmd */
>>>>>>> +       ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>>>>>>> +       if (ret)
>>>>>>> +               perror("Erase multi-cmd ioctl");
>>>>>>> +
>>>>>>> +       free(multi_cmd);
>>>>>>> +       return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>> +int do_erase(int nargs, char **argv)
>>>>>>> +{
>>>>>>> +       int dev_fd, ret;
>>>>>>> +       char *print_str;
>>>>>>> +       char **eptr = NULL;
>>>>>>> +       __u8 ext_csd[512], checkup_mask = 0;
>>>>>>> +       __u32 arg, start, end;
>>>>>>> +
>>>>>>> +       if (nargs != 5) {
>>>>>>> +               fprintf(stderr, "Usage: erase <type> <start addr>
>>>>>>> <end addr> </path/to/mmcblkX>\n");
>>>>>>> +               exit(1);
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
>>>>>>> +               start = strtol(argv[2], eptr, 16);
>>>>>>> +       else
>>>>>>> +               start = strtol(argv[2], eptr, 10);
>>>>>>> +
>>>>>>> +       if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
>>>>>>> +               end = strtol(argv[3], eptr, 16);
>>>>>>> +       else
>>>>>>> +               end = strtol(argv[3], eptr, 10);
>>>>>>> +
>>>>>>> +       if (end < start) {
>>>>>>> +               fprintf(stderr, "erase start [0x%08x] > erase end
>>>>>>> [0x%08x]\n",
>>>>>>> +                       start, end);
>>>>>>> +               exit(1);
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       if (strcmp(argv[1], "legacy") == 0) {
>>>>>>> +               arg = 0x00000000;
>>>>>>> +               print_str = "Legacy Erase";
>>>>>>> +       } else if (strcmp(argv[1], "discard") == 0) {
>>>>>>> +               arg = 0x00000003;
>>>>>>> +               print_str = "Discard";
>>>>>>> +       } else if (strcmp(argv[1], "secure-erase") == 0) {
>>>>>>> +               print_str = "Secure Erase";
>>>>>>> +               checkup_mask = EXT_CSD_SEC_ER_EN;
>>>>>>> +               arg = 0x80000000;
>>>>>>> +       } else if (strcmp(argv[1], "secure-trim1") == 0) {
>>>>>>> +               print_str = "Secure Trim Step 1";
>>>>>>> +               checkup_mask = EXT_CSD_SEC_ER_EN |
>>>>>>> EXT_CSD_SEC_GB_CL_EN;
>>>>>>> +               arg = 0x80000001;
>>>>>>> +       } else if (strcmp(argv[1], "secure-trim2") == 0) {
>>>>>>> +               print_str = "Secure Trim Step 2";
>>>>>>> +               checkup_mask = EXT_CSD_SEC_ER_EN |
>>>>>>> EXT_CSD_SEC_GB_CL_EN;
>>>>>>> +               arg = 0x80008000;
>>>>>>> +       } else if (strcmp(argv[1], "trim") == 0) {
>>>>>>> +               print_str = "Trim";
>>>>>>> +               checkup_mask = EXT_CSD_SEC_GB_CL_EN;
>>>>>>> +               arg = 0x00000001;
>>>>>>> +       } else {
>>>>>>> +               fprintf(stderr, "Unknown erase type: %s\n", argv[1]);
>>>>>>> +               exit(1);
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       dev_fd = open(argv[4], O_RDWR);
>>>>>>> +       if (dev_fd < 0) {
>>>>>>> +               perror(argv[4]);
>>>>>>> +               exit(1);
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       if (checkup_mask) {
>>>>>>> +               ret = read_extcsd(dev_fd, ext_csd);
>>>>>>> +               if (ret) {
>>>>>>> +                       fprintf(stderr, "Could not read EXT_CSD
>>>>>>> from %s\n",
>>>>>>> +                               argv[4]);
>>>>>>> +                       goto out;
>>>>>>> +               }
>>>>>>> +               if ((checkup_mask &
>>>>>>> ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) !=
>>>>>>> + checkup_mask) {
>>>>>>> +                       fprintf(stderr, "%s is not supported in %s\n",
>>>>>>> +                               print_str, argv[4]);
>>>>>>> +                       ret = -ENOTSUP;
>>>>>>> +                       goto out;
>>>>>>> +               }
>>>>>>> +
>>>>>>> +       }
>>>>>>> +       printf("Executing %s from 0x%08x to 0x%08x\n", print_str,
>>>>>>> start, end);
>>>>>>> +
>>>>>>> +       ret = erase(dev_fd, arg, start, end);
>>>>>>> +out:
>>>>>>> +       printf(" %s %s!\n\n", print_str, ret ? "Failed" : "Succeed");
>>>>>>> +       close(dev_fd);
>>>>>>> +       return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>> +
>>>>>>>    int do_ffu(int nargs, char **argv)
>>>>>>>    {
>>>>>>>    #ifndef MMC_IOC_MULTI_CMD
>>>>>>> diff --git a/mmc_cmds.h b/mmc_cmds.h
>>>>>>> index 9d3246c..8331ab2 100644
>>>>>>> --- a/mmc_cmds.h
>>>>>>> +++ b/mmc_cmds.h
>>>>>>> @@ -45,3 +45,4 @@ int do_ffu(int nargs, char **argv);
>>>>>>>    int do_read_scr(int argc, char **argv);
>>>>>>>    int do_read_cid(int argc, char **argv);
>>>>>>>    int do_read_csd(int argc, char **argv);
>>>>>>> +int do_erase(int nargs, char **argv);
>>>>>>> --
>>>>>>> 2.24.1 (Apple Git-126)
>>>>>>>

