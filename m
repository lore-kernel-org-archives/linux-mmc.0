Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310F7C433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 20:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEF36113B
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 20:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhDOUMa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:12:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45774 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbhDOUM2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 16:12:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FK5Hm6044354;
        Thu, 15 Apr 2021 20:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fPpJlr/Z4vH4/iYhwcsBsqlP9cCiG53ZAXff5Coi+M0=;
 b=XSBGPrAW2atJI0UqlRolMMdYqLaL6sVA8B/YmU5XmI+uuHej8x44hOzgW9ckzFW/HxC0
 J5kcRPm5w1+Ngvhuyf+j/9V/cZWgM19Rj8+b5sCpLHUcOE1r59BMvdFq0pGeuHLlsmBD
 Hrl87adblrtGLD2ryab8IUzOWe1Jt3XsvTG2ZR528ESWRTscgtWk2fjmmqAT0FoEYe9g
 vmb4/tiQvjeiadIg49nliVU/VbJlb+uykB5G9Its0ibkheyb9oaKNzDQbviNLZftZnbL
 2LY3wHgJnSkIVa4F6NDo1eSvBiB2awHIuMNN7yYBDHerQNkbBQiVGSypfkLFS4e0oSBC AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37u4nnq3p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 20:12:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FK5d3H158181;
        Thu, 15 Apr 2021 20:12:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 37unsw4k61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 20:12:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC8x53c6rYXdi6PlBGYH4zTbmVpsrgdsAhLmaUnjvvH4XqJpL5FoDQwjhxv0UiU8Or35vtuLgX7cEaZWxO5X1SLr3qwn00KLG28yfCMnqpGcblFe6o/7nnOD5DsWsEJR8a/wTlHxfKHk39ckDGaSwHk/EbFHsqL40MFFBDFlzXsHr6cBPEr4qATtv7NEJANHLRQExvrigviygcXslUP6QqbYKDBGVr3wF31BJJHeAqzhUW4jfaXS9hmTBD5zPHpmkCBO8wJBC61aZDN3S9ZtZNdrvN82JFl0o0dObU9MW8kzF5cz1GIhtCrTliCxnyqpeZVyDPPmavztn3P1Xd8tVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPpJlr/Z4vH4/iYhwcsBsqlP9cCiG53ZAXff5Coi+M0=;
 b=V26zfhqSvlguTp2VA/B2BpLMF+WTMhrAVsoInRRqTWfLC76xMd8G5vyrHbwz4eiRithpM4lW1HnjGqkoxyUZLj6/ftrvli/0k6z2qYFPmJ4aK0WIxnGdscBRbH32bnIy1x4UK5oorqTKZ5hkS9P6fHC+9UfTu19ge8mG92nIrWvBLGD3inWGaIJdBLh1JEUuolGB54/EV1yXPMrEaOGP7lVUd9q99OT33NwQ0z5CcASuRsDaVKGNna6ytmqGPwdI+d+WW6Hyj8VeDh3r0v6BqIRc/0N490G6RV1N0jg2RwUdXFh007MSRlC6+f10Bef/61uFg4I89TldHIlPxwoRKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPpJlr/Z4vH4/iYhwcsBsqlP9cCiG53ZAXff5Coi+M0=;
 b=XriFKOVy1hTnkVdAT6e/hnbjhuzapRNMEMnz/KJHC4xuTSV4xGI2fJiyuRn7rVmqKQNExxCUoZJFelBkyTBrCH2DqpsvXIrp9xGiL9c58ZkzP3Ysiac1OduIf1TPHZoSjDCBMugl3v6G+nyFqhoIIVXB1DY87TIhdhaSq5PK9iA=
Authentication-Results: kimitos-mbp.hsd1.co.comcast.net; dkim=none (message
 not signed) header.d=none;kimitos-mbp.hsd1.co.comcast.net; dmarc=none
 action=none header.from=oracle.com;
Received: from CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
 by CY4PR10MB1285.namprd10.prod.outlook.com (2603:10b6:903:2a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 20:11:58 +0000
Received: from CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc]) by CY4PR10MB1815.namprd10.prod.outlook.com
 ([fe80::1405:2af1:a195:63cc%6]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 20:11:58 +0000
Subject: Re: [External] : Re: [PATCH v3] Re-submit of the erase command
 addition plus removal of MMC_IOC_MULTI_CMD ifndef for erase. Author=Kimito
 Sakata <kimito.sakata@oracle.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>
Cc:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        kenny.gibbons@oracle.com, rkamdar@micron.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@kimitos-mbp.hsd1.co.comcast.net>
References: <20210401230221.12532-1-luserhker@gmail.com>
 <CAPDyKFpjTikAzDqkcbyxa1Y918OevojZYhREPsmQgeo_Sd0xgA@mail.gmail.com>
From:   kimito.sakata@oracle.com
Message-ID: <7bca3bca-b058-7086-b733-359c21e3d473@oracle.com>
Date:   Thu, 15 Apr 2021 14:11:54 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <CAPDyKFpjTikAzDqkcbyxa1Y918OevojZYhREPsmQgeo_Sd0xgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.243.79.162]
X-ClientProxiedBy: SN2PR01CA0011.prod.exchangelabs.com (2603:10b6:804:2::21)
 To CY4PR10MB1815.namprd10.prod.outlook.com (2603:10b6:903:125::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.208] (73.243.79.162) by SN2PR01CA0011.prod.exchangelabs.com (2603:10b6:804:2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 20:11:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 538042c9-9769-410a-fdf4-08d9004ab908
X-MS-TrafficTypeDiagnostic: CY4PR10MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB128580778D257BA2C55391E89D4D9@CY4PR10MB1285.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0uByjuiqpmoMdYgzs4Rx0lakRN3zwF09ehABIsylaCYGJk6GB0M4Ii4mdn9tc3lFFwyVslzsbV/kFJVl5fClMLOipJWc1R1zITCGhjufS/3fZFtO/9Pq6p2UkgUiTVsc9hQ2z5AFfUiwO80y27V3QgZiYtZojYRIriXRLmQ+FgjxwJ+lUuNxeKOthGNhAQik1GDvkohNl6XzMNiKSyJYdSTy7zx6yYyAnkmE57UD7CbfsXpccETt7iXNlLJ93eqdc0jXMfPLMpmYwcBcLNKlA4FIPMI/EaFoxfDwq0ebWOb0nNDPpMHYyqh3/9322LINOrfBgkO5cnHXczYRGTA1o82HjSN73MSlfLca4euRqkn/g3e0Q9i2MHaoS1csKEyaoSU4kht2Zf7PH0Tv9GNSTBU7o5bn8VAh0kUWZq3eXI62PG5/Z8JskOc3CluchGOgmbCusoPk9XdPrQECvEt+vWeCnsDzKD8ICgvhxG1YSDoKVLD+sB9JeW0/0iLTbsqI8uwIvJd5/2+sp+UXZCvs+9grLm/l3FrmN4F4D5h9gS1cwaYYVVjM3KjHlhySPkHygS5tYITi3HNp3vegXxnEXsNuzvsiTl9gEkswSlFiyMsWhSSMBQO8bcFg6Bj+sYONPecr+UilQST9/2daGbTQ3TwqzM0wym3fLcp+faOW0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1815.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(396003)(366004)(8676002)(83380400001)(31696002)(316002)(8936002)(54906003)(38100700002)(508600001)(6666004)(9686003)(956004)(16576012)(53546011)(2616005)(16526019)(26005)(5660300002)(186003)(31686004)(66556008)(86362001)(66476007)(4326008)(66946007)(110136005)(6486002)(2906002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bHl2ZlJOamdPTGtaaHliRWpuWmN3eEdLd3BwUjVHNDhGOWFOR01hcnhVK0J4?=
 =?utf-8?B?U3l5am9tUGhpMS9mZ1dIai85eGJWQUYxSXN3TzFhbGM2Tk5Ia1hoTkZBWFZ3?=
 =?utf-8?B?R2k1VWZ4dm9pK3BQWHAzSDF0ZE1JTFRPc255d1JJalhGdGsyUWlUWGJsVXk5?=
 =?utf-8?B?dmhRNVNhQjJlMzMyQlJxemhPdzJEeERXNWRneXREQzIxV0ZsbnlFYnZkRC9F?=
 =?utf-8?B?Q1BYSWJzVzVjK0hNcGhUckZuN1drdHdzYzFYV21WWC9sM0VqYStZTmpHWERS?=
 =?utf-8?B?cjlKUjM4MWV3YWVyOFBXdk1Yek93eVJBSzFRQmtNVXA4czBYTjloZDFtc2k2?=
 =?utf-8?B?R3JuUnlVd3BSaGFiTThOYUtlNUVCOTBMRFZ0SVIyUHdQdE5scVZQNGhzdkRl?=
 =?utf-8?B?d3VNWVUxRlhBQUFIQldlQVptcW8zUVprMVhhYzdnbWtlQklWWXFZa2Jma3Qz?=
 =?utf-8?B?RW5CbSs3QTg3Q1pxMzhnKzlsb0ZKQU42Z3c1V0wxSWx1SGFDdWRaWFFJOTdS?=
 =?utf-8?B?TzY5Tm84dkJQa01KM2k3N0d5UmF0ZmJBRlVQZVgrUUI4WGdnam1tRkF2WHd3?=
 =?utf-8?B?ejd2Vm14SFhWV2RFV1NRWlN6ZkVVNUNnME5RMEQrS3ZWTkRUNWh5Qk52RjFX?=
 =?utf-8?B?aVZrR29iZWV4UkpibUg0NURveHY4SU1kSk5HNlRpQ1UvZmlmMG1Vckl2aTZT?=
 =?utf-8?B?aTd4V042NUIzTjMxS0lUazZnRVpIU0JTdWR3ci8zOGVKQWsycDY5dHNRdkNv?=
 =?utf-8?B?aGE3c1g0bU56WkorUUJOWWdWTE1iZGYzU0RMQXJpQTVqdDdwUjRCL1dCYzdv?=
 =?utf-8?B?bENWQkx1Q0VaVC9VMHVTY0pSY21qT2MyelJXd2dxeENqbE5RUnRaOEJTK05C?=
 =?utf-8?B?WXNIbHhleTNhWDRwUGhPSU41Uk05aWNiSGZKbWFSYnJQM3hjTG9OK0RTNnZ1?=
 =?utf-8?B?VHlDRlBSMTFrZStTUU9BRDd0YVdQV3RHY3JBRXMzZU9Od1BiV25XRmxNMlY2?=
 =?utf-8?B?aE1VbDdJbkZidWVsZ3E5QXdaS0dJWHY5MHJaaDZWM3hOWXBFUTFvWGxMMFJC?=
 =?utf-8?B?U2ppd21meTFrbVRJNGRrTG4xSGczbk01dzl4ekFWd2xieUNLV3Y1VytrMmFr?=
 =?utf-8?B?amRMRnlCRG9Cc0dsTm4wVVdXaytDYnFSUUZqRExoSlZ4Tm9kaW9CMkhsM1VT?=
 =?utf-8?B?QnZCblZWdzVkV0tzQldvWWg0eHlEajNTT1VKL0JwL1lwbXY1V3pXY1VNZFlF?=
 =?utf-8?B?TCtVWTMxTllyNnh4VDdjRnpxdFlYOWVGNWxXeGpqL2xIN29PSXIwaWZLdUQ5?=
 =?utf-8?B?dVNDKzRHc1o3ZUN2cnpmdDU3Z0h6VmtZN21INlhNaUU1ZHdIa3JXT1VwUEwx?=
 =?utf-8?B?RldyY1VJcmlQRHRyU21URnJ3NE51Rm9kMG9XeURqK09HWTNOdGU1S3FmdGxK?=
 =?utf-8?B?cmNVTjA1U1F4UWNBOUFFWnRqRHYzaFNkaWdzbGYwSWdDc2FiekNMbWFxc052?=
 =?utf-8?B?UTVmL1BWZ3FMTndUKy9zL3BvYVg1M0RBanFsUEJtanJkSFNPWjJoOThzYXo0?=
 =?utf-8?B?WExwNnliSmNDOHZFclNZSERobDVqUEVjWG5xaTdycHVycmNMT1VGcFkvWjVi?=
 =?utf-8?B?dXo3NVZkbzYxTXMzblpPK05PQ3VZeVB3Z042K2NPdnRteHdpUXYrdnl4bzBP?=
 =?utf-8?B?VmhOOEFkN0tuMWJ2Rm9kcjFzcUhScm5vL1h2TmRFMVpDay9oS0xPdFcrY1Rv?=
 =?utf-8?Q?kwetunjo3f7bE5b0bY8N+X+xdJ8+xB+0FRYRLiE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538042c9-9769-410a-fdf4-08d9004ab908
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 20:11:58.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Edi1jJbyVpK3MNzOxJ0zjtiEmle3dHk2v7ZbuzX7DDu/fjt5xL4NLE6YGWoBnQ6zUUs5uhHa7joEvB6NcY5IzjxJ8/XemMTycUmvpw9tzo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1285
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150124
X-Proofpoint-ORIG-GUID: msLlaKNs3OqhkxyijThx0ZExGZx7x5Tw
X-Proofpoint-GUID: msLlaKNs3OqhkxyijThx0ZExGZx7x5Tw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150124
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Avri

Please let me know if you have some concerns.

Kimito

On 4/15/2021 6:32 AM, Ulf Hansson wrote:
> + Avri
>
> On Fri, 2 Apr 2021 at 01:02, <luserhker@gmail.com> wrote:
>> From: Kimito Sakata <kimito.sakata@oracle.com>
>>
>> Signed-off-by: Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
> This looks okay to me, but I have looped in Avri who might have some comments.
>
> Kind regards
> Uffe
>
>> ---
>>   mmc.c      |   8 ++++
>>   mmc.h      |  13 +++++-
>>   mmc_cmds.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   mmc_cmds.h |   1 +
>>   4 files changed, 150 insertions(+), 1 deletion(-)
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
>> index 6c24cea..3e36ff2 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -2514,6 +2514,135 @@ int do_cache_dis(int nargs, char **argv)
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
>> +       char **eptr = NULL;
>> +       __u8 ext_csd[512], checkup_mask = 0;
>> +       __u32 arg, start, end;
>> +
>> +       if (nargs != 5) {
>> +               fprintf(stderr, "Usage: erase <type> <start addr> <end addr> </path/to/mmcblkX>\n");
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
>>

