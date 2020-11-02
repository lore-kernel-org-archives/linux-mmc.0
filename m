Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E5BC00A89
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 06:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9C5223B0
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 06:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l6B3rnff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgKBGwF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 01:52:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726684AbgKBGwF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 01:52:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A26WRnZ147625;
        Mon, 2 Nov 2020 01:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Flpl5d3gqadvBKGdLHMOuDptqjM/SCj4H/OoSwa82YY=;
 b=l6B3rnff1k0uB027NXroScQxxO/03q9J9mPfvybeTCwjcNnp4JMRzl4QjBNeysvik33e
 BLmAzaRP83OiwTrATSVw1agNh+NFCgweSp0QeDuIWapxn1E0i/hHfNRHB2DYsEPr+S+y
 Yo0Dpu+6rcMhUC+q3HRugYumWjf3gCKUjgQjIh0sOTb4gBYFOOhDJo9Au5fOYsQmpHUZ
 Hv9Za4/VqyAgVnvcuoDDfemYu+U8i1C0UluOE07ZiHQDTFmvs+uvlNhhFmYrNbdJlwlS
 IUgAGC1KAuTmArD/lsMUYW7FO4Gkt2QNuf4haJQwsSCjS4I8xg2qoDbunDidwfUFSJkK 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34hnfu434k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 01:52:03 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A26q3SN027141;
        Mon, 2 Nov 2020 01:52:03 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34hnfu434b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 01:52:03 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A26ivK5000991;
        Mon, 2 Nov 2020 06:52:02 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 34h0evjm0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 06:52:02 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A26prXu9634514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Nov 2020 06:51:53 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46EFD6E054;
        Mon,  2 Nov 2020 06:52:01 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B0AA6E050;
        Mon,  2 Nov 2020 06:51:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.87.246])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 Nov 2020 06:51:58 +0000 (GMT)
Subject: Re: [PATCH] memstick: mspro_block: remove unneeded semicolon
To:     trix@redhat.com, maximlevitsky@gmail.com, oakad@yahoo.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201031134818.2135446-1-trix@redhat.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <8566b27c-2f71-16f8-1b9a-b1b79015f4d2@linux.ibm.com>
Date:   Mon, 2 Nov 2020 12:21:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201031134818.2135446-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_01:2020-10-30,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020050
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 10/31/20 7:18 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.

Hi Tom,
   I was checking this patch. Not sure if it will come under as fix patch. Since this is not fixing
any logical issue do we still need to add fix tag?

Thanks,
Kajol Jain
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/memstick/core/mspro_block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index cd6b8d4f2335..afb892e7ffc6 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -276,7 +276,7 @@ static const char *mspro_block_attr_name(unsigned char tag)
>  		return "attr_devinfo";
>  	default:
>  		return NULL;
> -	};
> +	}
>  }
>  
>  typedef ssize_t (*sysfs_show_t)(struct device *dev,
> 
