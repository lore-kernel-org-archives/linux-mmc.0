Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2EEC433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B473D613B0
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 08:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhDVI5G (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Apr 2021 04:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235435AbhDVI5F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Apr 2021 04:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619081791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHQB1IPbhElZKGgSLLBWBMmqCT2h+h35Ym1IEByfZ34=;
        b=NDG9DrXfCo4zlV7axS7MDvv+WJBqTA4MrZbJSxpZmA7eO0FkP1N+jVj4TyPHYd3MlBzEW6
        /BdX4LK51NDpMCy3zO3xOK412TBgCR/0u5gKImrUd/kIFlXg0Fgqd/f+zCslZcEphRaJ+F
        KTUnYB+B0fiqRUiNZEBFaP0wG4qs9Zc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-DpJS0-ryPH-SdsbvybYh3A-1; Thu, 22 Apr 2021 04:56:29 -0400
X-MC-Unique: DpJS0-ryPH-SdsbvybYh3A-1
Received: by mail-wm1-f71.google.com with SMTP id a71-20020a1c984a0000b029013841a43c3dso1069612wme.3
        for <linux-mmc@vger.kernel.org>; Thu, 22 Apr 2021 01:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wHQB1IPbhElZKGgSLLBWBMmqCT2h+h35Ym1IEByfZ34=;
        b=kkUMnErBMSjVLlDj+HBTA95L/XSyH4TI57Yu30Fx+oB0IV4ipV7qlsphBRpbfRXagI
         +p/LNOxh/EDMufrNo3YbZKlaa+dvbGaWcA/HHDBMcF/QxKPkjqvqzr+HcAONhZ9qYuH0
         5V9RSTLXTdy65vHpirCTu7mtwoqWdMfsAgOP6XfRZEGy272A7uwJXs2mFPyhXiG/01Cr
         TKYYA4lw2KaCvWknwDtFROGANXukE3FWWztilsgABf4ISka/xRweLj7z9q4V2/lw5E//
         z+RTgs2csVN6yrcruqcW9v5bfK/ez8GBa0bsYUAS3DFLcxA7NcWHl0CmbZW11iDUQyyr
         PpTw==
X-Gm-Message-State: AOAM532psrsWha+B+ZUHsHkHdUvCcmk8pFbDqe36dugpBNC8/IXrzvfz
        JpOQVLJLotVQGeqLop2Jo0nHQbe19kDttgYpALlxfe3Ln7eNFJrwxPlF5ScBFg+sKdj7vYi124x
        9g9wd0f4e43UW69HqWR0P
X-Received: by 2002:a1c:7315:: with SMTP id d21mr2654900wmb.155.1619081788119;
        Thu, 22 Apr 2021 01:56:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsPHfelfld6YqOw0tWP+F88dcipkz+DIt+3hCnhdfScPHT+MwTYgYvwxcA6S6SOCRu/NXMbA==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr2654871wmb.155.1619081787876;
        Thu, 22 Apr 2021 01:56:27 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23eb0.dip0.t-ipconnect.de. [79.242.62.176])
        by smtp.gmail.com with ESMTPSA id o17sm2600591wrg.80.2021.04.22.01.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 01:56:27 -0700 (PDT)
To:     Michal Hocko <mhocko@suse.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, l.stach@pengutronix.de,
        LKML <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Oscar Salvador <OSalvador@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <dbdf7b8c-9165-f87c-92d4-cfb5a4f01221@gmail.com>
 <YIEqpIOAyrs26soC@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: alloc_contig_range() with MIGRATE_MOVABLE performance regression
 since 4.9
Message-ID: <8919b724-ce5b-a80f-bbea-98b99af97357@redhat.com>
Date:   Thu, 22 Apr 2021 10:56:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIEqpIOAyrs26soC@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22.04.21 09:49, Michal Hocko wrote:
> Cc David and Oscar who are familiar with this code as well.
> 
> On Wed 21-04-21 11:36:01, Florian Fainelli wrote:
>> Hi all,
>>
>> I have been trying for the past few days to identify the source of a
>> performance regression that we are seeing with the 5.4 kernel but not
>> with the 4.9 kernel on ARM64. Testing something newer like 5.10 is a bit
>> challenging at the moment but will happen eventually.
>>
>> What we are seeing is a ~3x increase in the time needed for
>> alloc_contig_range() to allocate 1GB in blocks of 2MB pages. The system
>> is idle at the time and there are no other contenders for memory other
>> than the user-space programs already started (DHCP client, shell, etc.).

Hi,

If you can easily reproduce it might be worth to just try bisecting; 
that could be faster than manually poking around in the code.

Also, it would be worth having a look at the state of upstream Linux. 
Upstream Linux developers tend to not care about minor performance 
regressions on oldish kernels.

There has been work on improving exactly the situation you are 
describing -- a "fail fast" / "no retry" mode for alloc_contig_range(). 
Maybe it tackles exactly this issue.

https://lkml.kernel.org/r/20210121175502.274391-3-minchan@kernel.org

Minchan is already on cc.

(next time, please cc linux-mm on core-mm questions; maybe you tried, 
but ended up with linux-mmc :) )

>>
>> I have tried playing with the compact_control structure settings but
>> have not found anything that would bring us back to the performance of
>> 4.9. More often than not, we see test_pages_isolated() returning an
>> non-zero error code which would explain the slow down, since we have
>> some logic that re-tries the allocation if alloc_contig_range() returns
>> -EBUSY. If I remove the retry logic however, we don't get -EBUSY and we
>> get the results below:
>>
>> 4.9 shows this:
>>
>> [  457.537634] allocating: size: 1024MB avg: 59172 (us), max: 137306
>> (us), min: 44859 (us), total: 591723 (us), pages: 512, per-page: 115 (us)
>> [  457.550222] freeing: size: 1024MB avg: 67397 (us), max: 151408 (us),
>> min: 52630 (us), total: 673974 (us), pages: 512, per-page: 131 (us)
>>
>> 5.4 show this:
>>
>> [  222.388758] allocating: size: 1024MB avg: 156739 (us), max: 157254
>> (us), min: 155915 (us), total: 1567394 (us), pages: 512, per-page: 306 (us)
>> [  222.401601] freeing: size: 1024MB avg: 209899 (us), max: 210085 (us),
>> min: 209749 (us), total: 2098999 (us), pages: 512, per-page: 409 (us)
>>
>> This regression is not seen when MIGRATE_CMA is specified instead of
>> MIGRATE_MOVABLE.
>>
>> A few characteristics that you should probably be aware of:
>>
>> - There is 4GB of memory populated with the memory being mapped into the
>> CPU's address starting at space at 0x4000_0000 (1GB), PAGE_SIZE is 4KB
>>
>> - there is a ZONE_DMA32 that starts at 0x4000_0000 and ends at
>> 0xE480_0000, from there on we have a ZONE_MOVABLE which is comprised of
>> 0xE480_0000 - 0xfdc00000 and another range spanning 0x1_0000_0000 -
>> 0x1_4000_0000
>>
>> Attached is the kernel configuration.
>>
>> Thanks!
>> -- 
>> Florian
> 
> 
> 


-- 
Thanks,

David / dhildenb

