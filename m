Return-Path: <SRS0=wp20=6U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB588C28CBC
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99082208E4
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 16:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syehwF6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgEFQbm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 May 2020 12:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730353AbgEFQb1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2020 12:31:27 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211A1C061A10
        for <linux-mmc@vger.kernel.org>; Wed,  6 May 2020 09:31:26 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id w188so831738vkf.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2020 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FiB9pQXmMO6J13wRygH5wpmcQuT6bpeBnplQ+yoWqy4=;
        b=syehwF6nfAGze51brJjFnUAcXmSHB8FPB4pfxWc8SG6Aqa4Tem6+CFPiSLPrQSdHte
         r+SFPnZlwqFeixuSetvwES7+awv3/hy73Y68iyZHVbZ51ei1puiteuVzWEiPLX8fKGmf
         im1pZ55RH9HrzEdYUusQ70GrGcKai+do7bKUbwnb2psU5O4xmrplAU/4voLvbLyTWoD0
         PdrQVb+Aei2sTJqsnoSFjLQWN9YHPKlz6OViM7ZFNJkFS0nx0/miXdO15nD/a8yjWMPu
         y1jnV2dp1wd5NFFkkeBVE0xyAPjoyHBLHqqTR9ezZvUlIA5OYJT+dC2ObbEv49QEeEGB
         6lXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FiB9pQXmMO6J13wRygH5wpmcQuT6bpeBnplQ+yoWqy4=;
        b=OMVquJIRKNrkoIgif1vW2dsuq9XyFWlkVC8V1shNE+4xApoIHzUkmfRDm206DxDfr+
         ewC6SMQSnEseB5ffaKyqpVzbQtPtMQvwhwJdAj5lZevFo2IEJIh9RbLT3L+PD3HIOzmk
         HSMMcm+evXMIiy7pkoc7bttS1Xn/3c2NbWXpWuJGCHpqagrl4NBh5/PIrey+WMr/UG7x
         2XcpXKRcLHlVRiC7QsPDPSZDEBaU7GM3ILJ+VpiUZabgnl2aDlud2494UgWwyIXjf/5H
         LrtCXOZQ8VTgv7eJpOkIGqbVveOIhc3SydHhra3A6ecBjfgHFcwDetDQecSIb4SWSpV8
         XcFg==
X-Gm-Message-State: AGi0PuZJsACRviuolocTPTeaT050a9tvvhA1xyarvDcxBRJOlB3hVC3M
        VQizhWr03l7+BACjlJ9SDfpP+OG88LP/n+askneKnw==
X-Google-Smtp-Source: APiQypKpUnyKEH6JytKdnsuKIPTizThoHvdxVZCbosHBLsSAAvQY9gGYjrD60PyyFN0U1l8pWmf9tlPrnU9IVFfxork=
X-Received: by 2002:a1f:31cf:: with SMTP id x198mr7906893vkx.101.1588782685228;
 Wed, 06 May 2020 09:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <1588348794-4511-1-git-send-email-yanxiaoyong5@gmail.com>
 <CAHQZ30Btybck2ts8FGru_GDP63e6-ZdxN_mF5Wbp4L1XeTPAtQ@mail.gmail.com> <2020050201173899657320@gmail.com>
In-Reply-To: <2020050201173899657320@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 May 2020 18:30:48 +0200
Message-ID: <CAPDyKFrZebubtoQ-uNwdHc6qpUXz16-3w4U+DkqvnAMbe0-S-g@mail.gmail.com>
Subject: Re: Re: [PATCH] mmc/core:fix mmc_sd_hw_reset oops mmc_sd_hw_reset
 function may be oops if the ejection of sd and the reset of sd simultaneously occur
To:     "yanxiaoyong5@gmail.com" <yanxiaoyong5@gmail.com>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        kstewart <kstewart@linuxfoundation.org>,
        tglx <tglx@linutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 1 May 2020 at 19:18, yanxiaoyong5@gmail.com
<yanxiaoyong5@gmail.com> wrote:
>
>  it is a race condition,the situation as follows:
>         a                                                                           b
>  mmc_rescan
>      mmc_sd_detect
>           mmc_get_card
>               __mmc_reclaim_host
>           card is not present                                       __mmc_reclaim_host
>           mmc_put_card                                                 wait a __mmc_release_host
>               __mmc_release_host
>                     set b TASK_RUNNING
>           mmc_sd_remove

mmc_sd_remove() calls mmc_remove_card(), which calls device_del() on
the corresponding card->dev.

That leads to ->remove() callback gets invoked for card->dev (see
mmc_blk_remove()), which ideally should clean up everything mmc block
device related. In other words, beyond this point there should be no
thread/user that can call mmc_hw_reset() (which invokes
mmc_sd_hw_reset().

>                host->card =NULL
>                                                                                (b starts to run)
>                                                                                mmc_sd_hw_reset
>                                                                                    finds host->cards is NULL,then oops

So, from the above reasoning I need to ask, have you really seen the
NULL pointer exception happening? (then we need to look more closely
at mmc_blk_remove()) Or do you think there is a problem from a
code-inspection point of view?

Kind regards
Uffe
