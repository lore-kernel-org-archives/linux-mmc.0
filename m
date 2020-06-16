Return-Path: <SRS0=InOK=75=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3B8C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B7F20B1F
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbUTrPHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgFPL0t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPL0t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2020 07:26:49 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED10DC08C5C2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:26:48 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v25so6774842uau.4
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kj8pBuEYbicEiYra/1MxsnxdNYdCIy/Xz738Lg8QI0g=;
        b=ZbUTrPHTGu4GwRh+DYfBRS103wLfZCo7oqvH3ERUV1WbxyzFR/liagSKZA7aO+Iln/
         poyaEIZX/9KHRofWYhS5/iTPpJDMkTYArJLh0qOlLaj3kxF/Ig3VoeQs64cUdVaVPtfh
         apJhsVaDPHBAs71yhuuMbPYLGVlTotvbI8AVAaQJ9Ngzaj/mnnhWzYwF4FCuEy5dS3OB
         8JwCCKvrFCCDYNIQrkQsHeIMZMz62awjR+L9+I9SSwzyuhf9RpPKB3jPhGI4UpaIO5MC
         VqFwFI1DJv4cmFI7JSJCN0+8UrjbrqoL6YXn5kgeLhzuoW7tYTuJIYJNEyfXrwAECPvR
         JuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kj8pBuEYbicEiYra/1MxsnxdNYdCIy/Xz738Lg8QI0g=;
        b=m16CI4XBha3Lx00zGawrpYGDwrSKL0vjMxrBVN/9EcR1WgplIJ9wh4pWH++KC3mIB8
         9llsPvJlciHBvQXsEtzh/NlYOx2SsKDUUsszb4+D54FY6RmjBd78QlZ6XrPxUN2o8G9x
         SQ9cD+gqXKkW7HAcsL5rOxu8VDybTHojAsbyQpHo7oXdPoph8IofvGLLH71dnXpSXmt9
         iCahWcLHhA7/a8Xe9BzZNBTAmAid2r5deDjD1+eL/kfma3DyOBZOarSvglA9bebCeDMZ
         jpnm3JDyFjJA72t9/V/75EskYydPifyLxgKE04NGD30MEjTuyOAVjo4bbBW5aoPi7mMe
         aVXA==
X-Gm-Message-State: AOAM5330BUDSBKUQjg3q2fdjHpqTXhtZVBavoHHihvjuHswxWthhzZWw
        my7CU56BnilTD+OjqLoRBXvOIq7Z6u32rEZj9o+RQg==
X-Google-Smtp-Source: ABdhPJy2Qd7oDX9DDcKEcby0eTov3HheRlbgolbFvrZxbuuTEf20dyHDgn1w9N0lmc2eLKKRZTcijY+l68vloRA9oNY=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr1391633ual.15.1592306806719;
 Tue, 16 Jun 2020 04:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200602172957.13592-1-gaoce123@gmail.com>
In-Reply-To: <20200602172957.13592-1-gaoce123@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:26:10 +0200
Message-ID: <CAPDyKFrUNVryOCn0VqoATOgvJq5H7XPNb79tw+yxTV3wOqsVFQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add error check to avoid kernel panic caused
 by NULL pointer
To:     Corey Gao <gaoce123@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2 Jun 2020 at 19:31, Corey Gao <gaoce123@gmail.com> wrote:
>
> If __mmc_start_req(host, mrq) fails with error, the mrq->cmd->mrq will
> be NULL. This will cause kernel panic in the following
> mmc_wait_for_req_done(host, mrq). Add error check to cancle unnecessary
> mmc_wait_for_req_done(host, mrq) if __mmc_start_req(host, mrq) fails.

The above is a bit hard for me to follow, can you please try to
elaborate on the problem. Moreover, please, provide a stack trace, as
that is easier to follow for me.

Kind regards
Uffe

>
> Signed-off-by: Corey Gao <gaoce123@gmail.com>
> ---
>  drivers/mmc/core/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 2553d903a82b..b13b484e64aa 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -734,9 +734,11 @@ EXPORT_SYMBOL(mmc_start_req);
>   */
>  void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
>  {
> -       __mmc_start_req(host, mrq);
> +       int err;
>
> -       if (!mrq->cap_cmd_during_tfr)
> +       err = __mmc_start_req(host, mrq);
> +
> +       if (!mrq->cap_cmd_during_tfr && !err)
>                 mmc_wait_for_req_done(host, mrq);
>  }
>  EXPORT_SYMBOL(mmc_wait_for_req);
> --
> 2.17.1
>
