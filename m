Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B7C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 08:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06ED06525F
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 08:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCIIpC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 03:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhCIIpA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 03:45:00 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C1C06174A
        for <linux-mmc@vger.kernel.org>; Tue,  9 Mar 2021 00:45:00 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id o20so4261616uaj.9
        for <linux-mmc@vger.kernel.org>; Tue, 09 Mar 2021 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAawWbZ3Tu86roX6B8Jf3LvT9T64GnZgq67Wm/DffKU=;
        b=ZHtzdCdmXK22FRqw7QiWqLy7CmNYb8+9VpkUDOLyFxjYoz4Zq2Y7Pka2za1loAoWSv
         UlppPEEqc5xSsOSGeelILyqLxy+VEeZiAAvkHVQQci/qsS7ioVGXHGYS7HQ0ek7C5bKv
         IbveP+JarnfuWah6vwHp8d9L+7fKSQi3hV/O+ai0UnzWlSrjEZUbq6ruZdNxqCG4uPyF
         LDKXQkM4bLZfANmcSjyA+aYMift3loNrceJ/Xp0aAs6Lzj7wKIcFE6pAFdv+Igv1jdTU
         8BIlI3UErW8ZXoQVwSOOM0KW7yCpIYB7wZBLkwGjG74P3Lo39igEw9eNjL7xqbb+9+dg
         vyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAawWbZ3Tu86roX6B8Jf3LvT9T64GnZgq67Wm/DffKU=;
        b=adI05kYdAUe0wXCP5DARAGQa8X82+IdhhUPwWkSoGdSYWtxXigXJ4jEdSA9qAkbZCf
         MBANlWxkXoV0RLch5KQj87r3fX5jUXUAicLUC4Vcc0CuutRxsn9uKZVWEqzmFr3gO+Tb
         5IaBikwjHTQDTac2AuZrNZW3yPjTeR+5exfC8cY7NYJcbeIGzG5hjF1qKHqU+evrRzId
         33UBLb5POCIDQdGLbrI207+gsTfAxEbVjheF9WGDVDUqbBULDJxbQ7OqGiCRH5yA3WoW
         scRp4fdHsRpFeDAcqxBND2c5MmnjfBztVnh6xXNH0qhiS1DzNxH+l2ygbTH/vYbPifsH
         DnDg==
X-Gm-Message-State: AOAM533r8kM8QkJW4lGRx/lhwNT50MGnAN33qv5CJcwKoWGFuBkV+8Fo
        Y1svIsNenQS0GYoP8YJSoHZNm2h1P6YN9SJzjBTrpA==
X-Google-Smtp-Source: ABdhPJxYOIa/S/oHzV5/qpEuAZ5ERTZoY9knK2DwyKMdbtJZUra9Ng225lZz4DnW1/7HK1tlEy8SipPvCZVIoMqsmNk=
X-Received: by 2002:ab0:c16:: with SMTP id a22mr14774503uak.19.1615279499960;
 Tue, 09 Mar 2021 00:44:59 -0800 (PST)
MIME-Version: 1.0
References: <473ecf21-f0d3-9024-161e-72093004971f@gmail.com>
In-Reply-To: <473ecf21-f0d3-9024-161e-72093004971f@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Mar 2021 09:44:23 +0100
Message-ID: <CAPDyKFp61gV_irmqCuTuERDgA8KqogS_nhtvoOQJpFB0XEmvrQ@mail.gmail.com>
Subject: Re: [BUG] memstick: core: missing error return code in msb_resume()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, trix@redhat.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 5 Mar 2021 at 03:45, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> My static analysis tool reports that no error return code is assigned in
> error handling code of msb_resume().
> However, many other drivers assign error return code in xxx_resume(),
> such as sky2_resume() and e1000_resume().
> I wonder whether this is intentional?

It's for sure intentional, but it really doesn't matter that much as
we are probably in rather dodgy state anyways.

Of course, propagating error codes upwards in the stack is always good
practise, so feel free to add it.

Kind regards
Uffe
