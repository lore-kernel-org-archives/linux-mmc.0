Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5CEC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 19:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17EB7611CE
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 19:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhJUT5Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 15:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhJUT5X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 15:57:23 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE1CC061764
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2021 12:55:07 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d125so2500336iof.5
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2021 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dryz5aYNafXwhX7noxR+lLfCrdXvOrDveVshzNV5ctw=;
        b=DCtuYy186INLLr2bu5gedG+rZQF6mZlLSgei2smbBdDL9jWmqVr3U6kEBFRY0Hu9Sq
         7HPGJMd6H31TuNadcdLSTMOHfYyfSybGzwf562rpfd7vXnD3e/ZSphvdUPGDzkJoCajt
         20vwWepZBLszVDPDaf2AdNpP/WSv3cto/5zsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dryz5aYNafXwhX7noxR+lLfCrdXvOrDveVshzNV5ctw=;
        b=TpQjdconsh0ASOj+xcXAc3ikFVg6klTOsd6+xCtumPhIzvXBP5BrhIHg1hARMwQo1W
         2tvGxD5UbG6wQz5Qu5EBTJqlti/NVdJIicQKXPbRKpsUwrNNlm1/aBoHIm8F4Frdal1s
         0Z4VtRfPsgpdo5ruU5z+LEJHc+nLWs/f5lfMGM39xcLAffCrBHqQcEU3fO+bTkk9B/Ig
         GWzXs149ZrSKqZ2kRJbW1wst4cvnAUDwNwHSLblNI4muRPDE8d1hmIjel+bPVBo2oN6Y
         bW98IJA7wzH6YOkFdGB/Tbn989RRclw2F8Hb1ZoFfFaXLjmMjhUyCMEUb04w73oqQ10A
         5NFQ==
X-Gm-Message-State: AOAM530j2itayEWjB9oZjckxmJMOdHsv+2n/hyqou0cIDPTotWdonwew
        EmTg0Ilk5epon2BcHHQzKk7DXMWBLFgtkA==
X-Google-Smtp-Source: ABdhPJwIDDGXKm72hjiotVGKOLNUHu108XRY1l00vWlkAXJhIyP85vDAx6ufImkFjlXi3WjA2lq17A==
X-Received: by 2002:a05:6602:2c88:: with SMTP id i8mr5333309iow.126.1634846106835;
        Thu, 21 Oct 2021 12:55:06 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id i2sm3416799ilv.63.2021.10.21.12.55.06
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 12:55:06 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id h196so2521452iof.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2021 12:55:06 -0700 (PDT)
X-Received: by 2002:a5d:9d56:: with SMTP id k22mr5250332iok.177.1634846106049;
 Thu, 21 Oct 2021 12:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211020102907.70195-1-ulf.hansson@linaro.org>
 <CAD=FV=Wooy9c+S2QpQRn2Y0qKf16Q4cS6RtJ311NjkRSwrpeiw@mail.gmail.com> <CAPDyKFpzw2E7i3ZtkobBQcjWd9LnyH8MbPcxvt6ro3t6enMU7g@mail.gmail.com>
In-Reply-To: <CAPDyKFpzw2E7i3ZtkobBQcjWd9LnyH8MbPcxvt6ro3t6enMU7g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Oct 2021 12:54:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WvHxas2q7kMu=4UCqWLE2JqGkE4cV_36bvScAVJAhOzA@mail.gmail.com>
Message-ID: <CAD=FV=WvHxas2q7kMu=4UCqWLE2JqGkE4cV_36bvScAVJAhOzA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Drop use of ->init_card() callback
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Oct 21, 2021 at 12:52 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > I also wouldn't mind if you added some of the research above to the
> > commit message
>
> The commit message states:
>
> "This works fine, because dw_mmc uses sdio_signal_irq() to signal the
> irqs, thus the ->enable_sdio_irq() is never executed from within
> atomic context."
>
> But I can throw in some more background and refer to the commits you
> pointed out above.

Ah, you are correct. I must have skimmed that over too fast. I think
it's fine. Thanks! :-)

-Doug
