Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49124C00A89
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103B32231B
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 16:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fs18gg/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgKBQGV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 11:06:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbgKBQGU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 11:06:20 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2FX1XQ114751;
        Mon, 2 Nov 2020 11:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yWeJd9b3uXAxEvXhZoVHeLC6L15Mg+AxKO0jZvm997A=;
 b=fs18gg/DJMVLYrtMcdQUrSQ3gEXnboihP0TaCaZboxLCgxHwVRGxjXgXz9Pm1iaZRRt/
 zmngIDJ90cpYzq2VU4CzT2uFXU8lq3gwKnlazqTDUZ18q+F/5lo52L9V71oX3qEmSmKH
 Q653Thum6sobtq9PrUtqBS4WQUymyx9p04WxcapOxTfOpBxJjKsCbR7G0uNTOsFRd9iY
 YaD1O4ahDrJ7Y5mwyQ00FehqiCjkuXR8NKhTe7Iu774e2BosLLFc3bPv+jb7zynCUL1j
 juh3P+naG/8ci7oGuy+b5KHieJKYR3j/38Cw+S0jkK1LZg5Ql5NUgJjo2CCrAhFrOAaO ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jfg7bxy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 11:06:19 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A2FX5EC115166;
        Mon, 2 Nov 2020 11:06:18 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jfg7bxwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 11:06:18 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A2FqWMo006282;
        Mon, 2 Nov 2020 16:06:16 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 34h09mp56d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 16:06:16 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A2G67bk12714722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Nov 2020 16:06:07 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC5EE13604F;
        Mon,  2 Nov 2020 16:06:15 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96BCE136055;
        Mon,  2 Nov 2020 16:06:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.87.246])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 Nov 2020 16:06:13 +0000 (GMT)
Subject: Re: [PATCH] memstick: mspro_block: remove unneeded semicolon
To:     Tom Rix <trix@redhat.com>, maximlevitsky@gmail.com,
        oakad@yahoo.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201031134818.2135446-1-trix@redhat.com>
 <8566b27c-2f71-16f8-1b9a-b1b79015f4d2@linux.ibm.com>
 <df2f3ead-8bf9-144d-8a8a-9d6356f8b389@redhat.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <4ff202e1-1171-6ad1-5a5a-f384e987f77b@linux.ibm.com>
Date:   Mon, 2 Nov 2020 21:36:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <df2f3ead-8bf9-144d-8a8a-9d6356f8b389@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_09:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020123
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 11/2/20 7:12 PM, Tom Rix wrote:
> 
> On 11/1/20 10:51 PM, kajoljain wrote:
>>
>> On 10/31/20 7:18 PM, trix@redhat.com wrote:
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> A semicolon is not needed after a switch statement.
>> Hi Tom,
>>    I was checking this patch. Not sure if it will come under as fix patch. Since this is not fixing
>> any logical issue do we still need to add fix tag?
> 
> My rule of thumb is a fix means the kernel needs to be recompiled.

Yes make sense. Thanks for confirming.

Thanks,
Kajol Jain

> 
> This isn't a fix.
> 
> Tom
> 
>>
>> Thanks,
>> Kajol Jain
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> ---
>>>  drivers/memstick/core/mspro_block.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
>>> index cd6b8d4f2335..afb892e7ffc6 100644
>>> --- a/drivers/memstick/core/mspro_block.c
>>> +++ b/drivers/memstick/core/mspro_block.c
>>> @@ -276,7 +276,7 @@ static const char *mspro_block_attr_name(unsigned char tag)
>>>  		return "attr_devinfo";
>>>  	default:
>>>  		return NULL;
>>> -	};
>>> +	}
>>>  }
>>>  
>>>  typedef ssize_t (*sysfs_show_t)(struct device *dev,
>>>
> 
