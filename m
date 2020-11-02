Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15362C00A89
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 13:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92D322268
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 13:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbmDihyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgKBNm7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 08:42:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKBNm6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 08:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604324577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNgI8i+pWr/ubDT2RgyT0/AFUjy2u7nNe8tclZPonss=;
        b=hbmDihyCFFy9wcwwSyoVXUAw5cURNTWyLZLF0pkNJN+JRaO01c2n+lhAiP5CpRMzJVXakz
        DL5TOM/yFdEAmJ6OLSbZN8Tg2yFdyw4KM+d2iJJrx4XcfhXsTspyPPJXJvdgYSwqZXOR/5
        O4E7Vdszfin13XDPohJ63hr1As33BhU=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-klKf37CoNYyc4aqhim_DMw-1; Mon, 02 Nov 2020 08:42:55 -0500
X-MC-Unique: klKf37CoNYyc4aqhim_DMw-1
Received: by mail-oo1-f71.google.com with SMTP id z19so1823794oop.5
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2020 05:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wNgI8i+pWr/ubDT2RgyT0/AFUjy2u7nNe8tclZPonss=;
        b=E6l3AeD+FCRpRkCHeyyVnRol5FsnssvdmXOjqBsFhmbHvw9haaUwhpaA25ot5JNRDv
         PqTP9UeQZLftr3EKBMUVGshPClH4Z+iSfgSSE0yxoE8fEskaUNC3zQGCAjzqI5lxLBZl
         gMDJMsfs7eSof5boJhqASb3u6CiyLBs6pN+BDYkn0ZsADP8nOSM97Ds1sRwnebS2RmoG
         iuHEWabEMZV16u9ZhT6EDietHOVbLxIhYtuvj1t5zG+kWYplQO0NuFsNDdpizldq4Khc
         I5Nd6dFVr10lZAxcKYZuK3yDcT7KZZ63XmlwvbnszpcwPep0sCWaBhsDKSpwVbANUSvc
         V+/A==
X-Gm-Message-State: AOAM530JNz4NE1XOVNLrkNpqRyqn06p8GF+YEYf9J9t8QOfUiNQqUXo3
        G7jES8ESGNmX2aCG/4pt/n1bXh0B3FAhKBtkllOSvbhF6lZAnEX/0gtBHk+ztO9DmaZ3yNM5klJ
        +QsZxFFtCO7ApR61PeYL7
X-Received: by 2002:a9d:760c:: with SMTP id k12mr12470964otl.52.1604324575014;
        Mon, 02 Nov 2020 05:42:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJ19i/H7DCLBkb1s9ygP+CrVESM+Pc7M9G106KD4uzV9wqtn7INLchqFiyTAEZvONPsYHxkw==
X-Received: by 2002:a9d:760c:: with SMTP id k12mr12470953otl.52.1604324574793;
        Mon, 02 Nov 2020 05:42:54 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k12sm2157256oiw.2.2020.11.02.05.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 05:42:54 -0800 (PST)
Subject: Re: [PATCH] memstick: mspro_block: remove unneeded semicolon
To:     kajoljain <kjain@linux.ibm.com>, maximlevitsky@gmail.com,
        oakad@yahoo.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201031134818.2135446-1-trix@redhat.com>
 <8566b27c-2f71-16f8-1b9a-b1b79015f4d2@linux.ibm.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <df2f3ead-8bf9-144d-8a8a-9d6356f8b389@redhat.com>
Date:   Mon, 2 Nov 2020 05:42:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8566b27c-2f71-16f8-1b9a-b1b79015f4d2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 11/1/20 10:51 PM, kajoljain wrote:
>
> On 10/31/20 7:18 PM, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> A semicolon is not needed after a switch statement.
> Hi Tom,
>    I was checking this patch. Not sure if it will come under as fix patch. Since this is not fixing
> any logical issue do we still need to add fix tag?

My rule of thumb is a fix means the kernel needs to be recompiled.

This isn't a fix.

Tom

>
> Thanks,
> Kajol Jain
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/memstick/core/mspro_block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
>> index cd6b8d4f2335..afb892e7ffc6 100644
>> --- a/drivers/memstick/core/mspro_block.c
>> +++ b/drivers/memstick/core/mspro_block.c
>> @@ -276,7 +276,7 @@ static const char *mspro_block_attr_name(unsigned char tag)
>>  		return "attr_devinfo";
>>  	default:
>>  		return NULL;
>> -	};
>> +	}
>>  }
>>  
>>  typedef ssize_t (*sysfs_show_t)(struct device *dev,
>>

