Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F10C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Dec 2021 13:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbhLUNDt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbhLUNDt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2021 08:03:49 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C621C061574
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:48 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id i63so21282650lji.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMhiWcyt3C3agW9WNYMlNJT9if+c4LmUGb4U5c05gKk=;
        b=a/sUpSDAdDrvtZCYQ/X3KUo0kWqRnuCF7xI2oBVZApm/IilNdOYWLTqCdBdYEaYVrK
         5JkEwBfLC957fT2ofqY5PE3TgC7gHmN7KWmHb45xufia0WyEJntiI+cj9kHeAqIUvEbB
         /pmhjtFI28lLR3fKr3hw8AGjfCJG5P4PW96BsLbbmHIcB0pOGBbdPtKYo4P+W9eGkfPG
         saYR1ZiVcLQsU7Zx0lSIDus/n3J+U3JbCoVHtRD9k1EQgv5Nk+6kvM7vlSUcqbItqf0f
         bgh3rE3wPQiZ/iVz/cO9FgDIm2tjsFZcBUJYhU4YQwuQx4E7eG0b/cjHiiLxKLZt7WSM
         61wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMhiWcyt3C3agW9WNYMlNJT9if+c4LmUGb4U5c05gKk=;
        b=nwA4PT4L5kQnhgjPQuGilu9VQYzLZWmAigMQS3gDmjCZxYRf3yeWys2thQp/hamkZ/
         Xir3zLL/bEqRwj3v4wekguwudMRqlQPV5Ybz3Thq1haNz7hrqE9MoBr+nKApXv4nHksw
         sobU3qo4DOtOgKbI23JVbI2b58NdVqVO+T6FWDRUsekS6M8tfAIhgccSt2e5LyfpqcGc
         3tXe0q8LJUia1qhBK5GBnqJmv1HZ8109FZovvrOg1VmHGiJ9ZHx83Gvuu2Y/njSSzu6B
         w61MEVFwQDyIzTMsyC3OieJKxOreLuX8e092R9IG2aWvo20FM5luoomYI0Z2Tb8rogCR
         rTww==
X-Gm-Message-State: AOAM5316IdAp0cvVVfk7ztkfWHnZQg06tNaHhf+fVvk+43DBFBV8GdQZ
        MR8cByeF1CdPCzcvmOi3uS7WqUtF+XQ2YByOeCdBtQ==
X-Google-Smtp-Source: ABdhPJxsLMOqAKppSLH9abPC07q7PTD/rFOMgPUTodejUrypm+XH9ou1n1RROg6+ygPROenDgcS6hUgBKCNNCra1f00=
X-Received: by 2002:a2e:80c3:: with SMTP id r3mr2592426ljg.4.1640091826894;
 Tue, 21 Dec 2021 05:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20211217202717.10041-1-s.shtylyov@omp.ru>
In-Reply-To: <20211217202717.10041-1-s.shtylyov@omp.ru>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:03:10 +0100
Message-ID: <CAPDyKFoxVEyVumKLQzXZvFSrkopbd0gR40ZgfvUMd_wME+eMWQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add IRQ check to the Meson MMC/SD drivers
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-mmc@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Dec 2021 at 21:27, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> Here are 2 patches against the 'fixes' branch of Ulf Hansson's 'mmc.git' repo.
> The affected drivers call platform_get_irq() but forget to check for the error
> case and blithely pass the negative error codes to devm_request_threaded_irq()
> (which takes *unsigned* IRQ #). Now stop calling devm_request_threaded_irq()
> with the invalid IRQ #s!
>
> Sergey Shtylyov (2):
>   mmc: meson-mx-sdhc: add IRQ check
>   mmc: meson-mx-sdio: add IRQ check
>
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 5 +++++
>  drivers/mmc/host/meson-mx-sdio.c     | 5 +++++
>  2 files changed, 10 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe
