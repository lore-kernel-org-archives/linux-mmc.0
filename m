Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFBDC4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1871163210
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 14:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhKOO6X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 09:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhKOO6P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 09:58:15 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F122C061570
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 06:55:19 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k23so8014758lje.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDBjuHaI/M6XAQNvDVXSkstOeNPvwT6mcUxnKoTVfL4=;
        b=AwzVbJFUDU3EZfTuWnksSgb+dXT8XY4jgxXBx35XeMkJERwsqCKC1pNuAxDC0AYmlg
         TlXQCMck2GmkkffaXe+AD8Adf4hlaDIMmmSmoEpAm6gRDZTkKjvMAgosfUBjjJsmlXr1
         sJ2krPt4VNHON36Ns3WIG3ewtwe4YH5zON+YrwBFNRwrn+caqZX3F57qAe9iK+yA+uHC
         3GvSSNMU1rYdL4EQE/ZW4WgbCdpKer1XRiXvYFNh0i/cfrUgehclzeyuURCGzzIQm3W+
         RnmpvL34j9z1ulOg/ZTtOUdICBJUxa4ZqKkm5odyQ/VX0PCocwAjEvQe2Vo1SaSMLOqS
         Ukhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDBjuHaI/M6XAQNvDVXSkstOeNPvwT6mcUxnKoTVfL4=;
        b=Et44iOjG/njkG5CFT/xGHeJpmSMEKltkVmuDWfRrRnW8Oh4rqeW5n9VubB7nqrQ8XN
         e6BQ4MhfJxcKq11+QXdSnV5XQYxpwtLUJjpk1GArVW0Z4WuG/V3TKd/m3nkKLH4FW9CE
         18AzXAQC6IbRnHiuMrIjGqoJL/iAjCCor+wD+zCgH3q0zl/svV5EthAt29FLfDZHtZHJ
         ujnqwQU7nC1yWSlQK6aUKaNCPuj/z/QOLm3Lculg3aqOB0ipe1sVvbQG/HHfriytRg1p
         eslLODbkiUsq5Ub8ILOXFvmaOwyAiNItK+8zuO0KQPMnXjyzTY9afmpdEZ0gG+tCwA7Q
         CTMQ==
X-Gm-Message-State: AOAM5328Qd+ebTBW0pwjj+q45asDkc+CY/9izNzoq+MNn+ms75o8qY3R
        bq2zdHrYd5YgUMoxFc6h8mTig3v7GcU2pDG1DyuyTQ==
X-Google-Smtp-Source: ABdhPJxKgxsttYhTHkC2LoDZBAYtxZkRitvIhOVrLSIs2jWkLu8dlqJhJnAZdSCa5RkrfEp1Y8gHX84Eua4HH8QjIWw=
X-Received: by 2002:a05:651c:907:: with SMTP id e7mr41936174ljq.300.1636988117478;
 Mon, 15 Nov 2021 06:55:17 -0800 (PST)
MIME-Version: 1.0
References: <CGME20211104063243epcas1p4526b49feac019f3eadb33a23dc132976@epcas1p4.samsung.com>
 <20211104063231.2115-1-huijin.park@samsung.com>
In-Reply-To: <20211104063231.2115-1-huijin.park@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Nov 2021 15:54:41 +0100
Message-ID: <CAPDyKFrxbMvLNxFrsgD9KoG0eo_OSL3F91AU+tVJcf=mAj2c8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: core: adjust polling interval for CMD1
To:     Huijin Park <huijin.park@samsung.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huijin Park <bbanghj.park@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 4 Nov 2021 at 07:32, Huijin Park <huijin.park@samsung.com> wrote:
>
> This series is for adjusting polling interval for CMD1 using
> __mmc_poll_for_busy() common function which provides a stricter
> timeout checking and a throttling mechanism.
>
> v1...v2:
>  - Change __mmc_poll_for_busy() first parameter type to 'mmc_host*'.
>  - Use __mmc_poll_for_busy() common function.
>
> Huijin Park (2):
>   mmc: core: change __mmc_poll_for_busy() parameter type
>   mmc: core: adjust polling interval for CMD1
>
>  drivers/mmc/core/block.c   |  4 +-
>  drivers/mmc/core/mmc.c     |  2 +-
>  drivers/mmc/core/mmc_ops.c | 89 ++++++++++++++++++++++++--------------
>  drivers/mmc/core/mmc_ops.h |  2 +-
>  drivers/mmc/core/sd.c      |  2 +-
>  5 files changed, 62 insertions(+), 37 deletions(-)
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
