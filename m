Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD1C43334
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jun 2022 22:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378996AbiFPW54 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379248AbiFPW5z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2022 18:57:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B4113CEE
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2022 15:57:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h36so4329365lfv.9
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2022 15:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foFbBVpMYm/Gc4GSlJ3hBTUJlqtStZvyEhHzzHadiP4=;
        b=zl8pfMtKWBhptJeoc08baEemGuv9aKv1Jn0h1c4BlepEKJUYTPtlqTnWWZ9oroZKJr
         kzD2Xz2Q092wzBLtcUH8juGrkyk6LO1ggZeWkeNS+e2FvsobHPJ3BG06FB3g/ujVVWpW
         iPt1ttRgKp1gENNhs42FH9HhOe0fwZVQyd79jJP70KFtuulmTiiRheCMakE0VqCN3s0n
         pOBkj2Lsnj1vs4x+m+kCVa36omwFUmx2w/OeGy11439k3Ud2jzx2/eHwC025gW1l55xz
         ao5UkThzIh3OMNQpipjn287sB2CUaFAgOIWf8hE1C6EpPLnRguIGRNWqCA2jXSTELg5o
         03BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foFbBVpMYm/Gc4GSlJ3hBTUJlqtStZvyEhHzzHadiP4=;
        b=yEIjucGuzHtJtKYhrFGynOJ6Fa4V35pGX3LGje1Vq4BKVKXObsPPxuTqRLg7ZndWzv
         5TBGhqkseqbNL9vF9TuJJhTvQ33XhOuHfR0QnIpfvkVYDYsITv3sjGEyG6Yh3o3gnm75
         QiwvjPTIyID3MNh9p6WHGNX5a1WMcQGi8x7lv5XCKvtiuCMrvxH7eoP2PBKP5XxvgLXF
         I7znadfkLRKq+1PYBtDf/Gi+1K784jDAGSXXoSkhneHO+FknNlAa6Bsb/8lJuCRVMHLQ
         Yw9NBZra3PCebQlDgguwhyKGuRtyRAkjB/xhpPc9hGTSwHU93pQBT8EyjrAPCPUO9x4W
         KhpA==
X-Gm-Message-State: AJIora+S2BbsDYt1IJVPNnq8D34Z1SzCItDJFEEJQFVns/3tHl8xrWzy
        uYwaeYo3w4hV6myMwraFn8fW6MDk8n7qv1ng/w1EYQ==
X-Google-Smtp-Source: AGRyM1vfn8Wbf5jZ1bsro7EQrh/0VnN6uTKGpjRNEhxRCmlaYNOLxKAv0gnmzZvxDdL7HlzmHVzuXHgXyvAT734MCz8=
X-Received: by 2002:ac2:4bcc:0:b0:479:16a9:897 with SMTP id
 o12-20020ac24bcc000000b0047916a90897mr3879288lfq.71.1655420272466; Thu, 16
 Jun 2022 15:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com> <CAG0XXUF_YrNHNHPPNRjLSiycYyaAZuwaeCG3XpP_HVJrqYsy-w@mail.gmail.com>
In-Reply-To: <CAG0XXUF_YrNHNHPPNRjLSiycYyaAZuwaeCG3XpP_HVJrqYsy-w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jun 2022 15:57:16 -0700
Message-ID: <CAPDyKFrTVOq67krAe8Vc_Y75M+6CbrTdS2Uh8pb=CxL=OiDm+g@mail.gmail.com>
Subject: Re: [PATCH V4 0/6] Preparations to support SD UHS-II cards
To:     Lai Jason <jasonlai.genesyslogic@gmail.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        SeanHY.chen@genesyslogic.com.tw,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        victor.shih@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 6 Jun 2022 at 00:25, Lai Jason <jasonlai.genesyslogic@gmail.com> wrote:
>
> Hi Ulf,
>
> Do you have any comments for this patch set?
> If you think this patch set is ok, we will proceed to integrate UHS2 host part
> of code with this patch set.
>
> kind regards,
> Jason Lai

Hi Jason,

My apologies for the delays. Unfortunately I need some additional time
to review this, it has been a busy time for me lately.

Note that, as I said during the earlier review, it looks like it's
time to rebase the host series and thus include that as a part of a
complete series. The reason is simply that I would like to get a
better understanding of how the host driver deployment would look like
too.

I plan to complete the review of the $subject series next week,
although please don't wait for my review if you already have a
complete series ready to be posted, as I would rather review that
instead.

[...]

Kind regards
Uffe
