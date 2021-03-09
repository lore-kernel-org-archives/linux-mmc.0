Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0161DC433DB
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 13:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49DA65101
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 13:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCINkP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 08:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhCINkG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 08:40:06 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D705C06174A;
        Tue,  9 Mar 2021 05:40:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id i14so907287pjz.4;
        Tue, 09 Mar 2021 05:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EfRNWzuGNBnhyAcRR8YiG4gPJSCXyRxbY59iKyGieEM=;
        b=bSFj4cVXRH4Uyt5PbRaBkRomb40p5oImg8LwuuirDjxXJmQHkTAyE+D4Zv+smEGHdz
         PssQ7BOd9f4hUiIcznzaMuwGkSWzFSx3KD4Yk2G33yYpEzm3G9G+5sXWzRV+oO4HwrZW
         NsPWKnV7RCXSNwc2xXO4DSSzOg8EfFlYtpIUi13ZgvSGPB4eqtSap6bLju3Y0luYCUUZ
         Ia0EnfFir8/NdfyPsqjB8IOwMTZ/edObR5YpDrH21myII8nF6uUKmIPbp9R708wUTXsO
         2iWoWBdE2jhbSPTK/wi6pR2TiT5EYNoNzel9zAnruWghJTRIjKG3xdy46dQqCmrSAsW6
         bVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EfRNWzuGNBnhyAcRR8YiG4gPJSCXyRxbY59iKyGieEM=;
        b=FiAt3thewtbav/bGA5QLdUhF8HtMREy2hEWBDP9BZll6FSqlmXEGp9e0JmpBE/8sLM
         Dz0w79AIibXlZ3CpDLd9ihqKztjXFtuERYJCMgtfvGoqH7O0wGeZuBV3w/v5nq3z76dN
         UWx26pR7Lf9IIu6m96YE4VtcjqscUyQvNxrm2utUg+Z8T8TTc+mOHL8opIGrEYExxr8X
         yqpibrIlwJ4jue3sg2hF/RKshCWmOcuysq4PkfJcLgH9fm14K+o/D0UaxX4Q+Xc7f/NE
         TW2ILVsBqD4VR0CVZ9NSVgefqJNWfjBhUa7Q9ulLdx58uYEot1fuA97Md1wLulser8/w
         geFw==
X-Gm-Message-State: AOAM530SLRc4bHIGruZAV2cTh9VUK/b2LILiEKpoaAjbt1F8ti7LhBsZ
        AU+MTSsiKxzTC+YWRonceKAq70CAcdD6CYo9
X-Google-Smtp-Source: ABdhPJzF2Ju5j0GoVlbGzuoBxEXHnAx21+9hbPmDpXfy80CvN8i+0OlsDH7E74ICSInCNjA80Wte6g==
X-Received: by 2002:a17:902:b70d:b029:e3:6c97:d180 with SMTP id d13-20020a170902b70db02900e36c97d180mr25954776pls.40.1615297205578;
        Tue, 09 Mar 2021 05:40:05 -0800 (PST)
Received: from [10.160.0.34] ([45.135.186.124])
        by smtp.gmail.com with ESMTPSA id y1sm2567169pjr.3.2021.03.09.05.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 05:40:05 -0800 (PST)
Subject: Re: [BUG] memstick: core: missing error return code in msb_resume()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, trix@redhat.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <473ecf21-f0d3-9024-161e-72093004971f@gmail.com>
 <CAPDyKFp61gV_irmqCuTuERDgA8KqogS_nhtvoOQJpFB0XEmvrQ@mail.gmail.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <7c55dc0f-b6a5-d35e-79de-6f3b5d8d66c2@gmail.com>
Date:   Tue, 9 Mar 2021 21:40:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp61gV_irmqCuTuERDgA8KqogS_nhtvoOQJpFB0XEmvrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 2021/3/9 16:44, Ulf Hansson wrote:
> On Fri, 5 Mar 2021 at 03:45, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>> My static analysis tool reports that no error return code is assigned in
>> error handling code of msb_resume().
>> However, many other drivers assign error return code in xxx_resume(),
>> such as sky2_resume() and e1000_resume().
>> I wonder whether this is intentional?
> It's for sure intentional, but it really doesn't matter that much as
> we are probably in rather dodgy state anyways.
>
> Of course, propagating error codes upwards in the stack is always good
> practise, so feel free to add it.
>

Thanks for the reply!
I will find time to add error return code in this function :)


Best wishes,
Jia-Ju Bai
