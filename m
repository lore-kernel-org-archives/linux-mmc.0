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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4C5C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D552F61403
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 20:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbhDUUZl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Apr 2021 16:25:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40092 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhDUUZk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2021 16:25:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LKBpb3175758;
        Wed, 21 Apr 2021 20:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=emg87yyoSV5bdIbH+hYZKK2waUj0AZQq4gleg3wGbUU=;
 b=yAf8reXyXLHl8uQj3tBmKiI51Y4S+qDj5zwkvxEYO0FWazbADjMUX2vrG9ck07fXqbbL
 y1V3HPLy5wcKi++yFYzC/ikqgJ5oIjUsFb6SoMy0xYDSVGbgVHhfwOtetgY9jithqQHz
 HNDMTrGIwgPlMgfLH5xoJ1LBirmf/foOEK3wk30G7qzOx8omRaVCOY3x6SR0MBwzqaXd
 CqWr6qXz9PzXaCJ+37/Hj0QRK7aI8UQbgXyPyM+A8n9r6vTHUlg2ARhDOjuLk/uIRltH
 I2655tn6zCyifOFEh5D8hiZB9nTpjnznsGTL2agyeV/Q4zdFVtu+J+wlAtZcyv8HK+vX wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37yqmnkft6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 20:25:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LKEx0M079231;
        Wed, 21 Apr 2021 20:25:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3030.oracle.com with ESMTP id 38098s7mba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 20:25:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I92f9euzW2jD+9iLCu9PiBxryLjynDXFxPU/LzeevvxuNqZ78NQaOYF/kOW1KYA1CuSCNp+HOyFxqncjFHJOGo3mBx0GDBXfTEOCBd54gWO3zXhCtyyeouDrwTx8dIkEWdPq8m28+5btm9St/pd3QI3oAsPrvkphsFvuFgfJXsF04OZuePWy9iVW+8zJK8OEtPMO/tRDJ7jRIbsQGvAiCu7CMZ3WAQKyo6AJPLAvzyzIxXvgqtBLkVZQ/DlfjY/wxpMXztbaghVQBh+mclwcb6ZM6Mcc/ISQoNt7wsdIZKHfujykA4LPIuFF6CDlKxJavOV12uSnbm+J0IvDWs1Ghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emg87yyoSV5bdIbH+hYZKK2waUj0AZQq4gleg3wGbUU=;
 b=jqnsuNk0wfVi0qJ0y5y/CMDpXm8SPJR5ehySLwn6EH/S5JSDMvv8RLKVL1wcY84hQraB74v5UfwReVIgLv8ivHz3LhYKTGwsWYeZngtO+WCsy2gMDgmnErBfn1CnOOzs2j+tESSVY/i1R8tpxujt2pxGgFNzCczqBpAPiRmmyzCkb6FthTxPFV6ldOHiKZTTqukOMZMShQW66CR8JB1bHyYICbpF33bLWsQpCxlicPW38WT7yowJAH0ubyZYJTdm03Vmul262+QCG2OwCd6c3ujrKCI+ggjtkm6BEz6M0+qmUsswMfUzJHhqbF1xyvcS+prNlvDFbqKTm2H9t4ijmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emg87yyoSV5bdIbH+hYZKK2waUj0AZQq4gleg3wGbUU=;
 b=R0rXs5KcUrnbhbaDUgHhZV2TBjRFxRQiLrv6vdObnXE8+ulmIWu7YIBNnQaPlV9z52Qc46ri+tJ7zAwpDzGRKoCwn8D5Pix378mdchcvWu53BOlHqVVINKoWXhcj1l2yE/2oZgRSv20R61OAUWssc4o2EtH8+Wq6QDMutigpFfQ=
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR10MB1367.namprd10.prod.outlook.com (2603:10b6:903:2d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Wed, 21 Apr
 2021 20:24:59 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc%6]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 20:24:59 +0000
From:   kimito.sakata@oracle.com
Subject: Re: [External] : Re: [PATCH v3] Re-submit of the erase command
 addition plus removal of MMC_IOC_MULTI_CMD ifndef for erase. Author=Kimito
 Sakata <kimito.sakata@oracle.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        kenny.gibbons@oracle.com, rkamdar@micron.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
References: <20210401230221.12532-1-luserhker@gmail.com>
 <CAPDyKFpjTikAzDqkcbyxa1Y918OevojZYhREPsmQgeo_Sd0xgA@mail.gmail.com>
 <7bca3bca-b058-7086-b733-359c21e3d473@oracle.com>
 <7842f17c-7d8b-481a-1f84-c80de715be0d@oracle.com>
Message-ID: <8a76ead0-91c5-7d1c-08c4-618b737bd207@oracle.com>
Date:   Wed, 21 Apr 2021 14:24:55 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <7842f17c-7d8b-481a-1f84-c80de715be0d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: SA9PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:21::23) To CY4PR10MB1815.namprd10.prod.outlook.com
 (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by SA9PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:21::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Wed, 21 Apr 2021 20:24:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae49db5-b892-47d7-0371-08d9050388bd
X-MS-TrafficTypeDiagnostic: CY4PR10MB1367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB136734700E120945D74B0DAB9D479@CY4PR10MB1367.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+iQEa1Tn4wwSCgDKTP0nK1hfCA1a99uceUFW753EMzRnG9uy7ZxcbRONU7NU2sa+k1hdYjUbpRYkkwP/Q97vOfR38S/GKWCRcy9K5bn4o2lAj9q9bZjXt0XmSp1Of8xZ4GWHYngV9ikKfysRZgvf+NEg6b0Io/ZYke9Doeolojth3m4YfnRhRQGeCvbB2Q7fNMFZ7vBhEWlHww0wG07QW4MIdLMAUyZ5lbljmdy2zCCVcK4EnsONvIyRGeLB/N2WYTmlQO7V/yLCeTCQGYvv69z9ttWgmrLQzwVuqKamWvN8GH/YCywqbt3QETRO2KHbbdMUFpn/c2h1Anew74qx+b3iZj+eyr+DbQn4EEqnNjXamQDRuiPISUL8cLr3KZzTaWZbw/Iiw/PYWpBLlO+pI5lB9vGgI5SMPZmazK1SYKpLAIFcIritCKduj7aerLu1q//wc1Wk+4z2NcEgILYHxBEVoONuRukgrXwH5IsW7pxSmw/MxpogeTT0RWukUO48YqhiXYyteVFDZ9kbesoBn+DkHM1gkrX2aJzzUFGOUjUV4QE5chwZq7lWy4PJV1zqsNIb5w/TGNNebVjArcZEZwQQ+OFHnlIyNJniuBj7sF9TOYvPjpazXWzuo+Jy5b67msr95ZWxQor5k1WeGWvp2aeN57btFriEJh91H6JYpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(136003)(39860400002)(16576012)(4326008)(186003)(16526019)(31696002)(86362001)(6916009)(31686004)(8676002)(5660300002)(38100700002)(54906003)(2906002)(9686003)(316002)(26005)(66476007)(6486002)(66556008)(956004)(6666004)(36756003)(2616005)(478600001)(8936002)(66946007)(53546011)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q0xCbS9sTXppTlUwVGRzU3FIODVSaDRHcnBVU1hXYWdOVnUvby9zL0sySVo0?=
 =?utf-8?B?eXBHYWE0MkFZZVlmUzRucmtua1Q1UG84M0Vva0wwOGF5QlZtdGM2VjYxYW5r?=
 =?utf-8?B?ZWlLdXR3TzdPTUJ6VlJ2N04vUXFqUEpQZmd4YmhEbUduSlA2K1dQT3dsRStz?=
 =?utf-8?B?cEJWSW1kMHNNUFAzRDFQVEhQNVZ4SG50NHZVVU9vUWFnWXYwTHRSU3FhOE4w?=
 =?utf-8?B?OHpFalpyaktqeXdZa1p1QzZHMWp5T0R1NzNZaXdyNmE0V1pWbzR0T09CREdB?=
 =?utf-8?B?YjVsOFN4dUExVkFBd1pBUVpPSFVNand6dmU4Yk43R2tPaEVtcTV4eUFGdzMr?=
 =?utf-8?B?R3BWanhZN1lCWXZKY3pFem5YQkRHVDVuTUI1bnIwWnNiNUl1clYvcUpJV2RE?=
 =?utf-8?B?WnQyVC9KdHFKb0FlaGYvRU5pOTUvampGVE84UWdBczdGeFh4K0RabjRNVWlT?=
 =?utf-8?B?RVIzczZTelh5N1U2RW5vMFJDeEZhaCtFRGEvVE44ajNkemh5WW9ha0cvZFNj?=
 =?utf-8?B?c09SQ1p3UENRVG50OXZ2U2pHeWZ2UU9NbTBoNU5hMXJlTUd5NkJHaC8yaG9p?=
 =?utf-8?B?TnFicTFQVTdVZ0xjMnU5Lzl3ZGFCaEVVYk04elBpSnV4KzJOYVF0eWFzZFlp?=
 =?utf-8?B?dHRpT0ZqQlVEMWU2ZUFSNk5yRi9yaXB5UVUxTEZaYXU5QU5QVlZrMGdlUng3?=
 =?utf-8?B?T1BuSUxKY0wvb1ZkbzEvSTN1amUrNERNalJGNWR1eUEzVkpFaStvU3BJSyt4?=
 =?utf-8?B?anRVdnFHelhlRGYzUG9sZXlSR0s4Q1kvOXpFRTBVQ292cktBUGUzamtwRTlX?=
 =?utf-8?B?RGRqUG42MDc4VjN3cklNd1NVNE1QaE9OdDZKcXlXWE5PUFlLblhqZjJ1RXlx?=
 =?utf-8?B?aTByUjhFWUhlYUllOTg0SXhqdWJnYnpNQlZ6c3pINFpQMHY1OFJCWThjQlU0?=
 =?utf-8?B?clVLMDhyRTVBcmFVT2dUc0UyeFZYeGlXWnlPb29uOXpWQ3E1dFUvSzZHUUxU?=
 =?utf-8?B?bWh6VG5ibkt2K3Y4OVpCdUp2Z1RlcE5QeWJNZXNSMzFseFpxRXJwZWg2V1lr?=
 =?utf-8?B?Vit5aVdVaFBmY0dKelIyYzlEZ211T2V1NFBaT3kxb3hRODRoMzBVTldTaHNV?=
 =?utf-8?B?ckYzODc1bzJCN1ozZnVybFZUUFcwSStPa2JTNFBLQ3dmNFpMVWtsc1FxbVIw?=
 =?utf-8?B?QVI1dS9sVWthaEJwckxRb2dRMmJIWjB1NEloOUFTVHd4T2Z4bmFUeHBJdDRr?=
 =?utf-8?B?ZjVaM0wxZVZCV2VSRTJDaDV2TkFIcUF3WWdxYUMzREk2T0ZxMm5WSmdwU3V3?=
 =?utf-8?B?YzZSczV0MGYwUk4xSnBxRXVURkU0OElFZjFlVStjL3lDT0lsTTd6QnZHeE1q?=
 =?utf-8?B?bDRaZ0FLUFdJUGFzeGdtU3hhQzFRcXJVZldHVmxxWkhFQ0x2OGxJN25pVk41?=
 =?utf-8?B?dXA1N2t1a29XZ0lMc1ZMOGU4bzA3bnF6L0ZRNDdmbERIQkZpTzlPODJkOUdZ?=
 =?utf-8?B?YmFJRmErSGp5NWVGbXppQXdRUk1DcW0wUDk4N0pVY3FaU3cyaFBlQzNQZ3hE?=
 =?utf-8?B?ZXg5UWJENkVmbCtBeCtSOXkwMitObTBvRDM1VjhoZ1FvK1JWbmg3ZmRNc3Fx?=
 =?utf-8?B?QktTYnNxR1hLT2Y0Yzd6NXBHVXBDSjJKRW9HZkg2ZDJJVXB6Z3Z6cUJtVitS?=
 =?utf-8?B?MUlHdmpLRCtySWxOendFNHk0TFczSmtpMkxWNFlWR1k1c0ovclBYMC9TUFNp?=
 =?utf-8?Q?zcD23flmvojCTvwzQS/vNxJjyYLHZ1hVPkBx1r7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae49db5-b892-47d7-0371-08d9050388bd
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 20:24:58.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YO8b6jPhiiG7IaHuiz0BuiOAp/BuDgr8Uavv1/0agqJR4QkIHNg0XxrTiU/sBTAXoXcUEhULhWn4GAsv36jiYpMxyBlI+WlOpIlsAwUFEk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1367
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210137
X-Proofpoint-ORIG-GUID: IyOn7x2KjZDwKnCyAwN4yC_TeW0Uys4z
X-Proofpoint-GUID: IyOn7x2KjZDwKnCyAwN4yC_TeW0Uys4z
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210137
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Not sure if this was received so re-sending since I got a send error.

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
>>>> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr   R1  */
>>>> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr   R1  */
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
>>>> -- 2.24.1 (Apple Git-126)
>>>>
>>
>


