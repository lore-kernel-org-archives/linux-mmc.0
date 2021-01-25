Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10766C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 04:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D6522CA2
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 04:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbhAYEgN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 24 Jan 2021 23:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbhAYEgM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Jan 2021 23:36:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E056C061786
        for <linux-mmc@vger.kernel.org>; Sun, 24 Jan 2021 20:35:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d4so6831261plh.5
        for <linux-mmc@vger.kernel.org>; Sun, 24 Jan 2021 20:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RF+U31mjU+vQtmYKwQP7k4EqO/12hyWNFfFTp846sxc=;
        b=CfOwQ7limljMA7zl/lIAXVsTIKtNDlhwsicqotNl3TtlKhEjyZeIlEEJtHYW4c2U31
         UY4hC8hbmTVMaTURi/h7AUevTqeIqn+Q1FFnUUJ35BV9ke4apIRUY5I8NbeB8KXYicfU
         +trWj06hwAqSeMB9yfxG8wvJYR9/caMYTWeGkZl5KTSBZfynGCBz84SyjX0hbk7AWcGA
         /222IeHt9HOYYROpDQ0wb25k1uTdAAL1nhrslb3U6So17SP9tJY8mfEDx1CUbEE7qC63
         qpRcjNyJveRtr7uQu1UM1fJCkiAbkBaCmTSnXoAaT+i+isB4hYXJxGmrbyMs7d8MUbF7
         BPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RF+U31mjU+vQtmYKwQP7k4EqO/12hyWNFfFTp846sxc=;
        b=JjB8Yh4qvfq9pY9BLkirldtIsD7Jo7J5JOCpuD+Q3p+yKYO6LOm5Ge+SyfnsWRtykY
         jLLD3gjyBt79LApuJeC4SsZUXYatMuqczPVxzl1IbUmZX4d0jXM8ez2Pq/AGaJjxJNhW
         QaQ1RWNNDn5830l2pHygxnT0QIr8nrhQQVnjSzKuQb+Fhek7f7mbfy9J/FDxpY6xDOjs
         2UltP8BJHYR0Cq4bJYh3YUg5X43rrgsi8r34GPTxR4hI7je+Hg0o37BdgbEq+vEoViaW
         oES2H8R3bRz61VBR1w3qaGotKz0OMZVghCpgdOhQSq2if1FDhq6RZ7wJoSNAo/UY6OtX
         I+kg==
X-Gm-Message-State: AOAM532VBfHbOedFwyUnFujgmjENbx0OnHm9JvRGTNTlMDxwUx5AxJ+k
        LgOx0yu1R3UNYTqoTSBE1UaSow==
X-Google-Smtp-Source: ABdhPJwcVIfcZhKpz36wBWgY9pEAr1Osy03vWby4EQev/6n4B5mRbyHylHT/8WSUq/UooHKSU12Q8g==
X-Received: by 2002:a17:90a:1c09:: with SMTP id s9mr6518112pjs.83.1611549310994;
        Sun, 24 Jan 2021 20:35:10 -0800 (PST)
Received: from [10.8.2.15] ([185.125.207.232])
        by smtp.gmail.com with ESMTPSA id x21sm15191515pgi.75.2021.01.24.20.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:35:10 -0800 (PST)
Subject: Re: [PATCH V2 0/2] remove unused argument from blk_execute_rq_nowait
 and blk_execute_rq
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
        hch@infradead.org
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
 <683e16be-1146-e60c-cfea-e4606844f080@kernel.dk>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <73fd70be-90bc-9c6c-dcbe-7981f8fef4f5@cloud.ionos.com>
Date:   Mon, 25 Jan 2021 05:34:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <683e16be-1146-e60c-cfea-e4606844f080@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 1/25/21 02:24, Jens Axboe wrote:
> On 1/22/21 2:28 AM, Guoqing Jiang wrote:
>> V2 changes:
>> 1. update commit header per Christoph's comment.
>>
>> Hi Jens,
>>
>> This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
>> Also update the comment for blk_execute_rq_nowait.
> 
> What's this against? The lightnvm patch doesn't apply.
> 

Sorry for that, will resend against for-5.12/block.

Thanks,
Guoqing
