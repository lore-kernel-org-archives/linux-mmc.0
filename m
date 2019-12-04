Return-Path: <SRS0=1974=Z2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D18C43603
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 08:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B807820675
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 08:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Urf/A79c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfLDIMR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:12:17 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37688 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLDIMR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2019 03:12:17 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so7015798ioc.4
        for <linux-mmc@vger.kernel.org>; Wed, 04 Dec 2019 00:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I13QOM/XyZe4jexaUu6Tg14FjNQVNu2OzdTG+eKEvxs=;
        b=Urf/A79crlroamjdZ/4jO0Ea3JsVS/HR0RS6j4Scbe/uESPEuIqzn1CISgZZ4M2O5Q
         2IJ/bbCONVPXPx0UHdwldQBbY+glrYv9E+RAOFyiQlZhteyXjKfPhHoaC0lmBx818SVx
         zrOFUawhELjFTUzvBv6ySv1v7pSJqYo2WdgONHIEbMLzMRuo7ZshWOT2URSNCCVm0tFs
         dME9t6qUHmmDkcJ78hRUgtnH7QGqkW7K6X4NttTr2wqeRCOPQMcv/FfDYNUVmkpEpxui
         EHybpT0WbT4GlKWVIlTpGBZ+k3S90J77Jjt72aKwVx2gqSklHM8p5i9ZFJGkKUFnam/Z
         +fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I13QOM/XyZe4jexaUu6Tg14FjNQVNu2OzdTG+eKEvxs=;
        b=EuGL64l9kDWuMJ4hMoxvzonwWJI9CcPMZQBZB217ekIEzKsz9kzZyU1MlgZqBSLdi9
         TqflSgXgYdXJpx/zgGk97XTzxvcYBonW1sml7zAeiGgQfloj6XzWvd59A5cyIqCE3ZIB
         SxFRZlSzWWc7yLpayJnB3rJBvkREcuHZaK2bohAD37LsQezCBGCxg2zYopxuAeBBXrO3
         GvzKR9jAGymgmFeLQOyY35ZbeidEVhofl5BdpOHs1rVUOGMrFMfC/bwm7aMid59BuMPK
         AOGiP1q36n31f1lF2rdjJJ9oIXaPXSpyKyh88i7FDwXIGxEYnKPW/X/UK+iypb3LThsc
         3nCw==
X-Gm-Message-State: APjAAAXEhalP6Qj/piTgBNaYSR7ydTA8PmMqploUYcpmOjacc42RxZsn
        7TWV35n6LWBlQkzAfFpPFa0Sagrm9fTNrfkmSpkj7w==
X-Google-Smtp-Source: APXvYqwt6fIkH5aRFph0l1Lb7nTwjasXYcWkPzvXCdXqxUsHWhUIa0fRQNvSZ2zcwf47+j1kV/aNS9rzQoInjIAmU2g=
X-Received: by 2002:a6b:c7c7:: with SMTP id x190mr1124939iof.123.1575447135988;
 Wed, 04 Dec 2019 00:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20191204071958.18553-1-chaotian.jing@mediatek.com>
In-Reply-To: <20191204071958.18553-1-chaotian.jing@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@google.com>
Date:   Wed, 4 Dec 2019 16:11:50 +0800
Message-ID: <CACb=7PWeW+aYx3Dah0CFj3cyG+Wr=gOe7pfo9a_jmfjvjJeFDg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: fix CMD_TA to 2 for MT8173 HS200/HS400 mode
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Dec 4, 2019 at 3:20 PM Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> there is a chance that always get response CRC error after HS200 tuning,
> the reason is that need set CMD_TA to 2. this modification is only for
> MT8173.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
