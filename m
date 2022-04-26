Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1254DC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 18:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353080AbiDZSGR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353593AbiDZSGQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 14:06:16 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D327CFA
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 11:03:08 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e93bbb54f9so7506248fac.12
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtLzLFLewrXQHTJbVImCCDYJrynuyEbueRUS2ATV0U0=;
        b=AjrbAV8MeBG1TftKOze/fLl/wHpmQ8Rhq7SRWYnnk6QRX7wdha+JlYrp5O7tTdMzUy
         WqrpM6F+WjaAZwYZpZ2mDTaX4XSFH+e3nzwvRyoi/VCGEQvOsNrYC0eoZTvSLoRw7PaA
         6QSCdsZtqCQElCl5khit+DPERPtXiRGy1ElHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtLzLFLewrXQHTJbVImCCDYJrynuyEbueRUS2ATV0U0=;
        b=6O5Jchp0Lbcy4U/yMMoExVaw1Qk6oUD/Ygrb0SPIA3LzZYLDgEzAU7jhcZAjFMJVg2
         afU6VsVDPkUPgK+UO8posyJXpDWhUJCyP+5jy5VPIRopnpeWM8JpseMID+lzLGoO4fXk
         a1b7UhxRbVV9oqfTcuKF2TwSLe5cS/8uVKHw7zFYoJUsYoiPAQqwv1RAwY7xVSubYFbu
         Nh2U3RbZ6glQlH7iguQWoLHRnL7thJk+N6A3gv3crxOsftnx5sh5yxeWQakmKsbgM5fn
         e2iS4M8PIOCkqV9i5Y3jMRwVpQddxxIU+1LfAhLUVkg6MNaE35v3EMYmFzG1qts3nxBQ
         9mXQ==
X-Gm-Message-State: AOAM532bXPMXcLwHejd523I2eLvl73XqJL3x6vp1cRC1zW9t4/7hQmRb
        ZE6wT+JRCmVtnfy8zibkze8lCpvzV8etgg==
X-Google-Smtp-Source: ABdhPJyW9crLrM+PqfkpPGRZxNWYy4fK3gYo13mjZrdiBIAtDMKEcGTyUePKFLyFXlx7wnlRso1eAg==
X-Received: by 2002:a05:6870:c692:b0:e9:5368:10df with SMTP id cv18-20020a056870c69200b000e9536810dfmr3506033oab.182.1650996187061;
        Tue, 26 Apr 2022 11:03:07 -0700 (PDT)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id l8-20020a056808020800b0032575bca0e5sm68734oie.46.2022.04.26.11.03.04
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 11:03:04 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id e7-20020a4aaac7000000b00330e3ddfd4bso3522725oon.8
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 11:03:04 -0700 (PDT)
X-Received: by 2002:a4a:141:0:b0:353:d3c1:8aa with SMTP id 62-20020a4a0141000000b00353d3c108aamr8682441oor.64.1650996184119;
 Tue, 26 Apr 2022 11:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <1650964532-9379-1-git-send-email-quic_spathi@quicinc.com>
In-Reply-To: <1650964532-9379-1-git-send-email-quic_spathi@quicinc.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Apr 2022 11:02:52 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMkzrqkDdb=y4DpK5Ot=XFtj6aAv7-mSBoGP5rDJZanpA@mail.gmail.com>
Message-ID: <CA+ASDXMkzrqkDdb=y4DpK5Ot=XFtj6aAv7-mSBoGP5rDJZanpA@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: core: Select HS mode in device first and then in
 the host
To:     Srinivasarao Pathipati <quic_spathi@quicinc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, avri.altman@wdc.com,
        Linus Walleij <linus.walleij@linaro.org>,
        vbadigan@codeaurora.org, Shawn Lin <shawn.lin@rock-chips.com>,
        s.shtylyov@omp.ru, merez@codeaurora.org,
        wsa+renesas@sang-engineering.com, sayalil@codeaurora.org,
        linux-mmc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kishor Krishna Bhat <quic_kishkris@quicinc.com>,
        kamasali <quic_kamasali@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Apr 26, 2022 at 2:16 AM Srinivasarao Pathipati
<quic_spathi@quicinc.com> wrote:
>
> From: Sayali Lokhande <sayalil@codeaurora.org>
>
> While switching from hs400 to hs200 mode, high speed mode
> timing should be selected in the device before changing the
> clock frequency in the host. But current implementation,
> (mmc_hs400_to_hs200) first updates the frequency in the host
> and then updates mode in the device. This is a spec violation.
> Hence update the sequence to comply with the spec.

I'm a bit new to interpreting eMMC specs, but are you sure this is a
violation? In JESD84-B51, I see:

"The bus frequency can be changed at any time (under the restrictions
of maximum data transfer frequency, defined by the Device, and the
identification frequency defined by the standard document)."

I think that suggests we can lower the host clock first, and then
lower the device timing. And (according to my limited knowledge) that
makes sense too: the device timing is a "maximum" (to some extent) and
we're free to run the host bus somewhat slower.

And on the flip side: it sounds like you may be _introducing_ a spec
violation (that we'll be running the host faster than the device
timing, briefly)?

Apologies if I'm off base. But you did CC me ;)

Regards,
Brian
