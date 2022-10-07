Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F03C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Oct 2022 19:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJGTkh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Oct 2022 15:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJGTkX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2022 15:40:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3FD6249
        for <linux-mmc@vger.kernel.org>; Fri,  7 Oct 2022 12:40:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lx7so5282617pjb.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 Oct 2022 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxYOj2DA6xvjYpi+XjW859HEQbWAzDqivFYp1R8d9jI=;
        b=JSokHwDczc1aciacWSkMTqECkqX12cgHLtkdL/XH+82v+aKZu5/QzJZ0ecFwGkIDRf
         Z02cviv/Imk+Sr+WfKeaA1j46Qwitv8//H6u+2lhrJ+wTSk/Q9SG0uCTQKn/WieUA1bl
         5aHFKXM21gFCcUJfrFtMuiGVnEX2ReCe1zZcVgAJh5odzpNfeoHARxNS828KG8RkAq6L
         qBnyw1Po+eQCCrrudcC22x5oBN7sTXN7VxF0qvJsS7Hf4AflJE+rEO5MLC1sXWJ/XAC3
         Yt7Dc6nVwAIh1KAhf9azIkRQJmNvjSXuldj7n2i7RWPeJIBvUCs2PEBG4zbN8VTvj5a2
         0J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxYOj2DA6xvjYpi+XjW859HEQbWAzDqivFYp1R8d9jI=;
        b=FbjgV+C2udn10TOCeAg7YhGiqzphy6t1SUbrjHVbAwJk6c8kvkpECLGaSpUk+fSLgV
         ydTrP75yk2yYvS6NwyEjyWYKCTsvf6tZHxIt+6Pl4779HIgO/Mz4ETLn+xbkWy8lxsdA
         2wqjenwbTDX0+CrzAQYlc0ezPyMSl2/qzLyyM3RuidgixV1/8zlhex6NLm+yKkmy9LYZ
         U24l3jS1Yrc5pBhr17tZ34PMSywf1y9EcQ2as+zpxGrHYtcK35xEjb3l8CM7GNke3g5w
         nPmaJ2Hq5CJX7QOCm5SggXNQ9quBzOQLsKRKfT4ZmW/gqvZfGTOxIjN5EhsulqnViF14
         v2cw==
X-Gm-Message-State: ACrzQf31e8QdRfvBiy9MH0prKstl92aQvCeYuOnSmXnYePzcTVF2MKET
        kE6Ems+GuDCS5eJpPYsHVis5Ug==
X-Google-Smtp-Source: AMsMyM4MuAQY/zX9CazcfpxFTzbqh5ZWzm+gsv6RigMXmdLqaTceG4IiqZbKufitBzYcJnpVRQQE2w==
X-Received: by 2002:a17:90b:2705:b0:20a:b4fa:f624 with SMTP id px5-20020a17090b270500b0020ab4faf624mr6996007pjb.124.1665171620206;
        Fri, 07 Oct 2022 12:40:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b00176e6f553efsm169643plh.84.2022.10.07.12.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 12:40:19 -0700 (PDT)
Message-ID: <2a79929c-ece3-3d5d-db6c-414ec22b381e@kernel.dk>
Date:   Fri, 7 Oct 2022 13:40:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20221005032257.80681-1-kch@nvidia.com>
 <20221005032257.80681-2-kch@nvidia.com>
 <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
 <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
 <e0ea0b0a-5077-de37-046f-62902aca93b6@acm.org>
 <a7e4fe12-64f2-3164-d675-26310ac07c9e@nvidia.com>
 <7e9ce6b2-70c8-cf85-95ab-de09090db64d@nvidia.com>
 <51f62009-777f-8958-8d28-b29e64bbff09@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <51f62009-777f-8958-8d28-b29e64bbff09@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/6/22 12:40 PM, Bart Van Assche wrote:
> On 10/6/22 11:13, Chaitanya Kulkarni wrote:
>> I will trim down the argument list with the most common arguments
>> and keep it to max 4-5 mandatory arguments identical to what we
>> have done this for blk_next_bio() and bio_alloc_bioset() [1]
>> where mandatory arguments are part of the initialization API
>> than repeating the code all the in the tree, that creates
>> maintenance work of treewide patches.
>>
>> Also, instead of doing tree wide change in series I'll start small
>> and gradually add more patches over time.
>>
>> This definitely adds a more value to the code where code is not
>> repeated for mandatory arguments, which are way less than 9.
> 
> Hmm ... I'm not convinced that the approach outlined above will result
> in a valuable patch series. I think my objections also apply to the
> approach outlined above.

I would have to agree, I don't think this series buys us anything
really, and in several ways it actually makes it worse or creates more
of a maintenance problem going forward.

-- 
Jens Axboe


