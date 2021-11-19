Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C5EC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 16:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D86611F0
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 16:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhKSQmn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhKSQmn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Nov 2021 11:42:43 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0E6C061574
        for <linux-mmc@vger.kernel.org>; Fri, 19 Nov 2021 08:39:41 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id m9so13597581iop.0
        for <linux-mmc@vger.kernel.org>; Fri, 19 Nov 2021 08:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IMGoSMGc4yeb1poVKk3YdIGT043vy+yP4wpuLEmff38=;
        b=QTxGeUMx82UWWiH/NKxY7SJmDbky4nCBZ5bqzvwhcbOrVILUgQkXy6RFXmPJME1eDs
         jmBkLKwZlzxc+lpGBPVjHDD8eB5AQ9aV1cp1EoYEOx9FzjHmMfvwfY7Vfh3kk01WZQJA
         LZfU3oxzCdVtd0QcggYMaNsMO3t4YjgTSptBqpl2dgz8TBYh8WoBlMAmzeqGigqXiuX3
         iFlveMdZmXgSOyUTLDDvT8g5mBTNqiWQWXZQJowTuteGJeEZTcwtWZpfkYzXDVTQZEdh
         YFnbbSfSYwEbIvsHwjCHcxmAtGaJIfzJdKUHl+PdQZ5NiuD6U5rrApJw7YCSBNNWYX5Z
         VUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IMGoSMGc4yeb1poVKk3YdIGT043vy+yP4wpuLEmff38=;
        b=s12OnH0hfioT6SMVScxoTKhxrWEwKgD0aKvqjHfvXn4bxhnnrS/rwuZj5jXY5I7/SY
         /FA+Jp4CCSPaRaGjnQgQDlV2OgbaAETD2wd47GRP+9kT/uflchKoLFjJ0XgyfZeXwwQS
         9+HLkHSOQul4nNp24kY6BNKjM0ohMcbGBCj3Jz/ybKcCtwddTEU7AV9XDn6BKhWb7Y++
         zPGEqdq+t8nFc8RGLAgP/R64j5Kq+sZedBT9gr20pFZvJAEbDz4AHrjU+uyRrGBnpLBB
         aZ8aA64iaaBY7JDVJsE5jYSc1s7X/wMSX6ZldYbvzjmTDsGD+XXfyptK1hgQmeybW5OO
         yiXQ==
X-Gm-Message-State: AOAM5338MvnXN+t+tXJDkNSuT4231JTK7jP+BNuDNe3PmmX59t24x2vg
        2zObCtcFo0ESDtSx1Jc2j0IlU5QMW3m6+kW8cGRKg7T2kh0J5Ykh
X-Google-Smtp-Source: ABdhPJz6YyefxHoZm2pxUidbhI6QraT56n1Rdctub/Iv0iHaecQ7wN4AZ96CSAexxeu6hvVFItfeM3IYcuCj1/C+j1U=
X-Received: by 2002:a05:6638:190f:: with SMTP id p15mr29090424jal.82.1637339980871;
 Fri, 19 Nov 2021 08:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20211119155337.14341-1-marten.lindahl@axis.com>
In-Reply-To: <20211119155337.14341-1-marten.lindahl@axis.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 19 Nov 2021 08:39:28 -0800
Message-ID: <CAD=FV=Vk2VUsazkBctfxFq5tik0m0RoyXpxz+_2P6fQhUueYNQ@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: dw_mmc: Allow lower TMOUT value than maximum
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@axis.com,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Fri, Nov 19, 2021 at 7:53 AM M=C3=A5rten Lindahl <marten.lindahl@axis.co=
m> wrote:
>
> The TMOUT register is always set with a full value for every transfer,
> which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
> This is normally good enough to complete the request, but setting a full
> value makes it impossible to test shorter timeouts, when for example
> testing data read times on different SD cards.
>
> Add a function to set any value smaller than the maximum of 0xFFFFFF.
>
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> ---
>
> v2:
>  - Calculate new value before checking boundaries
>  - Include CLKDIV register to get proper value
>
> v3:
>  - Use 'if-else' instead of 'goto'
>  - Don't touch response field when maximize data field
>
> v4:
>  - Prevent 32bit divider overflow by splitting the operation
>  - Changed %06x to %#08x as suggested by Doug
>  - Rephrased commit msg as suggested by Doug
>
> v5:
>  - Use u32 type for CPU reg access
>  - Make tmp 64bit to handle INT_MAX parameters
>
> v6:
>  - Use u64 type for tmp
>
>  drivers/mmc/host/dw_mmc.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
