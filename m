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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15691C433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 14:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D330E61406
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 14:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbhDWOYh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Apr 2021 10:24:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56680 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhDWOYg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Apr 2021 10:24:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NENkUV025144;
        Fri, 23 Apr 2021 14:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fcWazlAurX1P/9xHvdiTG3A8xthOozH7OtMvNVCHGD8=;
 b=oa8UEG1vSuZCYERp7LExOtUP6Ri7MOf+htl4Ah4IqiRXxiso/K4e0Dte/T84korciRII
 xLLQcFBa+178Tg9amTiXNE5yO96aqT2IkRpZxm4KilcoFYqXnF5ToK5Y1fIPI9gLtRpF
 ECd+oh3UtXj10DchW5+Vj26sn7c4rNG653ZQG09unP/Up1CqsBRzGV1wqeh0PgDkNgfr
 r7O65URaW1iTMgrTig7YArL4PLtWzeTJT4+nv6EmN/jXNPPotZhjvSFZb7734oAJhstu
 q2yT3Uoxb1sFIyVY694ZQlKz+oAQYGVavLiGmch3zpnWuIF92wl9jtRahOmvuUmU2iu2 1Q== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 382yqs8p5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 14:23:53 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13NEKVMQ071776;
        Fri, 23 Apr 2021 14:23:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3030.oracle.com with ESMTP id 383cdswq2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 14:23:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDVFFmw87dmNd3SCzDa3OrORe6gU/Rbgnll11dqP25pdb+rTV5XrUBiS+/E+UDljEIMXPAA1DIA9TJcu/rGWoPfjnsmhSK2yz4q0xJGvNm5MIJqUxyokgGq3Ubj2TeJqX4nuW006uH5DNKZUxKw5OsTX1AIvnSO3ExpkrZa/Ye0gkvnd0ezeJ8NQPLttsWFcgYHeHmwjGPUht7AvI/rW3+xJW7XsU8MaLtRMrY+DPFbAQnmf6mkO6yD1xHZa5GLx1FLDWP7nJ+37aR2oPuNBiAkj698L5mVya6vXynHUeGENESzI9sjany+VK19KOE72ACARCAYCgPkWIqfjmSKNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcWazlAurX1P/9xHvdiTG3A8xthOozH7OtMvNVCHGD8=;
 b=GTn6G+U+oD2nRVReEwfMU2K/owwW2cJXiUBlEylokZ0OC5qUoiPjA6y6UYkM9wKBxW4dNyFRgxWem0S60u9OjblDywolcaYxYQBOllKJ0EcfZna/0uHvw0884ziVawciJ1KsavTWDcDsqyci6ag73wU2+7FAkKekMV/Wy6kjRjQN0pcADCFf9DAuwnIhor+8kfjDn/gUpGbvbuvf8vB3uYv/PO8cGSFVjNoWkgRosTbgTvxnrkzL8f9xETqv58K6paybvupn50JT0frwv5ysq660FrECfEfAJUOZmxrOHWRNvWEatPM0fppV9IHGHlYV7wvL+jzSdcBfFDtAsIaAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcWazlAurX1P/9xHvdiTG3A8xthOozH7OtMvNVCHGD8=;
 b=Vjk1F+PBnO/t6/8DYswQzCjg8cBtpzf9Pc8UCbZ7Ae/HI/4tyJ24G0pQSvVOIm4CtaBFhQlpRD5gIj9HlKejEqUBGVKPDAIzktq1rgI7EO5t+Tsrr0V90VSumiiJ3imSGntPncY6KYIFRkMj+SYpvRqo3gQ1bkDjJfIy5dK7KYE=
Authentication-Results: Kimitos-MBP.hsd1.co.comcast.net; dkim=none (message
 not signed) header.d=none;Kimitos-MBP.hsd1.co.comcast.net; dmarc=none
 action=none header.from=oracle.com;
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR1001MB2199.namprd10.prod.outlook.com (2603:10b6:910:44::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Fri, 23 Apr
 2021 14:23:50 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc%6]) with mapi id 15.20.4065.025; Fri, 23 Apr 2021
 14:23:50 +0000
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
From:   kimito.sakata@oracle.com
Message-ID: <d27806b6-d66c-ada4-5dcb-f861bc342564@oracle.com>
Date:   Fri, 23 Apr 2021 08:23:46 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <DM6PR04MB657557ACD70FF26950CF0B0AFC459@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: SN7PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:806:120::31) To CY4PR10MB1815.namprd10.prod.outlook.com
 (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by SN7PR04CA0056.namprd04.prod.outlook.com (2603:10b6:806:120::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Fri, 23 Apr 2021 14:23:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a87e072e-f3c3-4d93-8a7f-08d906636a2d
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2199:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2199A1E0EF5489C4314A635B9D459@CY4PR1001MB2199.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SK7Ka5xVAJYqMWgmEX5lMom0G6Gjn1aE/egNI8TXmmMV4T4NcB9IWE5xKiJvCEZWGggJ5BzO3ziElBGIB/6AV1c3BZIRJNdjZHN5vwkopjWrCP4ojCUjYqCwIx2e6JukJW7mTdWZDEFRAG40WMTCS94GIR0g0jnbXIexOB1VRA4zM9xwVTNUk+2NsIJPODVeuU4KkVEzyABHfzZ0mGbMalZK9ipffVCnZ2EE4eCoFgYJzkwN0VpTy1DEb4UvyRnWUw3IXu1S9QOYfaLsmdliIb2uzGf4O26Dsc/3Ep75m5d8In2M9ePyJH2P3iQf8sKEmdD6I2WeRstglNDrdFlJxQLDChPVtJ8ZiL/fWufGHeTEl3/cKXxw1aIT4jYCWm/ICf4sgZYdySnmCmXNZcQMpE00XPU7OJZmTLbxGT//s1I3pB2EJkHnZjyLX200rIIuPjLtXiVWmYai8oC2nClCegClQHp4spwikPDWW51X6RoMDOMDpLRxuAyy5k2cWysgJpwrqgzoeRFSB3ydam1+jG69pdT4IvH6WpdQYGioiKL9oK/asFGkmk5Wv/PX3Nans8ta0Wz42wA1Q/SSj+9BwWYCKE0r73czHnkOkIwhnZgDTNEp0vD8pZ5/kPTRrBPckp+kqSqhbBvRk23I/PijZTlWdeAs+1DOj3F8rNFpK8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(66476007)(66556008)(8936002)(66946007)(16526019)(956004)(2616005)(8676002)(86362001)(9686003)(38100700002)(5660300002)(186003)(53546011)(83380400001)(6666004)(2906002)(54906003)(110136005)(31686004)(36756003)(26005)(16576012)(316002)(31696002)(478600001)(6486002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a3hQOVdxL2dkSEtLWTJ5aGdwUWt0SURVa2ZpdlBIWXUwN0lpY1FUNTlnSWoy?=
 =?utf-8?B?eFM5WkFJZUUwVmFkQ0NLczRyQmdXTHZFK1pmZ0gzOTdNcFNYeHhMRkVRbXVF?=
 =?utf-8?B?RDZNWFZvOWlsTUpTVEg1MmN6cDB5VnZ2VGI1SnJCZnl0MDIyVHFPVVBIMXpu?=
 =?utf-8?B?ejZYYXBBeFZJZkVFRFFLN05HWGtReWkyY3pWVHZ3SCtyZlIwWHVIazBoYnJZ?=
 =?utf-8?B?TjFxaTQvS2doNVRHQ3Y5Wit4WE9rRUpKNUNOeG1sVmFzbHlIS2VGVTJOTHpZ?=
 =?utf-8?B?SWlmUGFKR0dEc1JlUDFHNzJ5eWdYTVViVHJKb2RodHI1dHpqclBuUElDVTV3?=
 =?utf-8?B?SXpLYkFiUmJGeTAzMWZpOW9KclVQYi9tWFhJNHpJRHVZbHJwTTV5TEx4MmhD?=
 =?utf-8?B?bmFpY1pxMWphR0NjbUprRUpBYU8wekpSME4zdDEvRk1zYW5rK3BuNW5JS2Jh?=
 =?utf-8?B?VWVha1hZNlpMVUI1WW5hSytIUWRlMDFGdk94ZUJQd29DRy93VmhLSFhGWGlJ?=
 =?utf-8?B?MjNoSGk1bk5uQXZFUUNhN3IraWxZN2t5NEYwZkNZSzhzcmtSK0dEVHJ1a3Mr?=
 =?utf-8?B?TWRjWXdjVEJxZ3RuaHVkYlNRZ1lBREovbGFWREVQWExZYTh3K1B2amNNMlZJ?=
 =?utf-8?B?ZG80L0grc2dKK2twQkN4a1MwVWtUbVVUUTY2NGsrTjdWRkw5bllic1Fkd1B1?=
 =?utf-8?B?SUszSXFobDgveU81c2krMm5mWi9hV203ZmRWVkhCRmo3NDJFOWJWTldaZ2VQ?=
 =?utf-8?B?Z3l5MTJLR1ZabW4yWExVMkVnU1BJMTFudCtBbnJIajJrczJOK0hncWNoa3E1?=
 =?utf-8?B?OXlMYnE0V0tIdmUvOTRTa2RCekhJSVlMMWhxZVFudUlXTndFZUVsbE55Sjdi?=
 =?utf-8?B?NVBBSDJWUjE2VnNPTGNmYlNmTHdMMmtCamdGTmlWSmIySjB5bXVOdXhpNk5F?=
 =?utf-8?B?V05kQ1k2SEpENkp2TFUwdWVRWGhOLzJMeThtZ0FJcE5GaS9LbWhzSXEvMmVt?=
 =?utf-8?B?cHM2UHVTQ0tIbFd5aVVyQklwZ0JweXM0ZklxOGJXdzBvd3VMUUVsbVdCUHVo?=
 =?utf-8?B?dklPV3ZGTDI5RUd2RC8wQVlURG1PMGdSTjhiZ1VoQ0pkT3JORHFiZVNvb29P?=
 =?utf-8?B?WndGMTNnZkZWbXBQekk2Ukc5NkZ0WlE2SUhGcm53ZndVNloybVFyQlU4a2ZN?=
 =?utf-8?B?b2tCdjNUdXNuRm15a0RtcGl5Yk5tUlVTY1hwYnAvSlBYdHlHdVNDVWhLOFh3?=
 =?utf-8?B?M09Ca204bGhkQzFiaW45OTUwYjNKN3R1OHdGeStoQWZqbTJPMFpQYWdMMjRR?=
 =?utf-8?B?dDNKaENCMFpSTE1JMW12bHd5WVd6YXVDbndzcGgrLzZyV0hIbjBKbTFMNEYy?=
 =?utf-8?B?Q21uN09renFMSWlqSEpMWUQ3TkprMTlLdEZ5VlcwNXFFT2RlSThzWmFYUXBF?=
 =?utf-8?B?aUZ2WkVsb2hDYlZWa1cxM3gvZUJjV0loREJ0d3FkaldYbElGQ0NIZm54ZEJR?=
 =?utf-8?B?Vm1YWlBhTmNmeURZZEw4eTVuTmZQd1JKdWlGd1FkL09CdGlkalUrSzF2anFX?=
 =?utf-8?B?OWhJNXA4dmxSNjIxVEUrZnJOZks3R1ROZmZXeTU4MENGWUdIaGRYckZsaW1K?=
 =?utf-8?B?cnFWWG13dDZqK1NFZG1LV2U0Sm1kaFJqa2h4cklrTFJIbTdxTzJjNG1nTWIz?=
 =?utf-8?B?aVJCQS93TEFyUlN0K1ZmejdlUjN2eXZsYWtHYVVoRkN1SGhEby8vUDQwbGZt?=
 =?utf-8?Q?krP18RSHTM3SB8ZzGFDwt0taKqCLXHfKWHUtR0b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87e072e-f3c3-4d93-8a7f-08d906636a2d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 14:23:50.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/BtE4eJrDe1PbvRQPwBkHDJR+eoqbTqWCghyHukJfDayptanBM5M6MK5samH1al97G1gjvoLdMqjIRICezNAX6gD2zqGeSDeqI/asFshf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2199
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9963 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104230094
X-Proofpoint-ORIG-GUID: 6PD-TP85nPqI86nIHfjXS9T8tzsjL2aE
X-Proofpoint-GUID: 6PD-TP85nPqI86nIHfjXS9T8tzsjL2aE
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 4/22/2021 11:19 PM, Avri Altman wrote:
>> From: Kimito Sakata <kimito.sakata@oracle.com>
>>
>> Signed-off-by: Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
> Hi Kimito,
> Please use a proper subject and commit log body.
> If you don't understand the difference between those two - please ask.
I don't. I would appreciate an explanation. New to submitting changes 
via git.

> Also for consistency, you might want to use your oracle mail for your Signed-off-by tag.
> You need to change your git configs for that.
I tried all kinds of firewall settings and no go via my work network.
Is why I ended up using my personal gmail smtp. Is that a problem?

Thanks
Kimito

>
> Thanks,
> Avri
>
>> ---
>>   mmc.c      |   8 ++++
>>   mmc.h      |  13 +++++-
>>   mmc_cmds.c | 135
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   mmc_cmds.h |   1 +
>>   4 files changed, 156 insertions(+), 1 deletion(-)
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
>> index 6c24cea..9340e3f 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -2514,6 +2514,141 @@ int do_cache_dis(int nargs, char **argv)
>>          return do_cache_ctrl(0, nargs, argv);
>>   }
>>
>> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
>> +{
>> +#ifndef MMC_IOC_MULTI_CMD
>> +       fprintf(stderr, "mmc-utils has been compiled without
>> MMC_IOC_MULTI_CMD"
>> +                       " support, needed by erase.\n");
>> +       return -ENOTSUP;
>> +#else
>> +       int ret = 0;
>> +       struct mmc_ioc_multi_cmd *multi_cmd;
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
>> 2.24.1 (Apple Git-126)

