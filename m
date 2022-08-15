Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706E7C3F6B0
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 16:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiHOQ3K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiHOQ3J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 12:29:09 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BAE1CE
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 09:29:08 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id cr9so5817964qtb.13
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NVdbXDDqt8OLuQLqClAaHnuBSzQXULtNPdEas2SrLJY=;
        b=gggYPfYCcZrz3KKyz6DVR+Swe51KgJItmUNgu0M9NHQfWWqXLRLoqWgNrflb24LvVq
         xcw1w86Vmq6OoZWjBE1JUPlLygkB8ijz53I/N7/8hK09levGgssM7nf3sHzC6b3NBVhW
         iA4kg5/OCyLeQxLxNUhl1MQIVyL0u9qRfrOO9qvkYhzcNWG0hc2z6LR7AQKJEL3qBiXM
         U4Ezv+avFSC7RtJhoomfXqFYpbhErgcW06VjKn2e61Xz9ceTMXsoui1OaeFTngV+5pRk
         TvMci2XKG2o6nBhkI2vewzFgGyW54cAwtZYjtYahkYFkQ4mDVLdFfsAT0ObXo/pl7Dip
         qbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NVdbXDDqt8OLuQLqClAaHnuBSzQXULtNPdEas2SrLJY=;
        b=llAlYDUOc8YAi+qPyZ+Re42nbM/TH5kKPZeij1XuxKKXaxgs7GBoFilGpiuGhRTYNb
         45snY6BZTJ7PUEniy/hVa1HYGNCglgZvXAfktfMojg4huwHUTU5f29GXg3OnZpHS0RvM
         99tPnRGGOmMvnNRmfsBy9+AZ8Knt8tJ5w0l6N+DuqbZoqRytfLyfx5sEx+OnxqqDyuzY
         1guTvvwoz/fYH4A3IOG14TJVnnkxL7fBl8rjRGVUtDFQvDuXCpLjbKrLXVG/pqGPkhPy
         9fHypGXrAyJeAvu3bo3CnW/U+nrhVh5vyCs0EcfvgQ/69m0yInHML3IBEn7vKD/d15+w
         do7w==
X-Gm-Message-State: ACgBeo0PR5Fp4LyKo9x8/efKUiT2jCaHPNlFsgiNEhoZrfZQJYZZDjdD
        WNA1rh+Pcsrkm3DUT9uxYQ95iIAPoxhztBQgcStMFvnTzKc9btiA
X-Google-Smtp-Source: AA6agR6illJXJezPnUlYRSvrzzoS5CAYf4IUEm95n/U6inIK5fOcXEH6F1mNmBMwtsRq0xclG5MWykhUOUCpEetI2Pg=
X-Received: by 2002:a05:622a:1013:b0:344:5b66:fe15 with SMTP id
 d19-20020a05622a101300b003445b66fe15mr5314154qte.66.1660580947982; Mon, 15
 Aug 2022 09:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <CABMhjYp3xUyQ9q6nXHvEA2zuzhYi0ETn6UETeH1apWf2n2eP7A@mail.gmail.com>
 <7ba0c325-bc1f-f6e4-dd8a-b5d13a04ef93@microchip.com> <CABMhjYrDyOoDusE4-y4VzM87Vg=NhPbow_dQ+1C4EcX50LrMHw@mail.gmail.com>
 <fb861221-2e9d-7d4a-dd52-b16b3b581fd6@microchip.com> <dd128dec-6092-7aeb-6e66-eb45cea3b0cd@microchip.com>
In-Reply-To: <dd128dec-6092-7aeb-6e66-eb45cea3b0cd@microchip.com>
From:   Atul Khare <atulkhare@rivosinc.com>
Date:   Mon, 15 Aug 2022 09:28:57 -0700
Message-ID: <CABMhjYrB+Qn9ZuJ3Lqpu0KVFGeg6avxkYqD=SQWyLjdQ3wSpjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: sifive: fix dt-schema errors
To:     Conor.Dooley@microchip.com
Cc:     palmer@rivosinc.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Conor,

Thanks -- really appreciate the help. Dell had to come out twice to
fix my laptop, and it's finally done (hopefully), but moving back and
forth between  the different distros has been really disruptive.


On Tue, Jul 26, 2022 at 9:42 AM <Conor.Dooley@microchip.com> wrote:
>
> On 01/07/2022 21:00, Conor Dooley wrote:
> > On 01/07/2022 20:49, Atul Khare wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> Conor,
> >>
> >> Apologies for the delay, but my laptop died a couple of weeks ago, and
> >> I have been scrambling to get things up and running on the
> >> replacement. I will try and get back to it ASAP.
> >
> > Nothing you can do about your laptop dying :)
> >
> >
>
> Hey Atul,
> Been another couple weeks so I am going to send a v3 of these
> patches (although without any changes to the v2) and we can
> resume discussion about the cache binding change there.
> Thanks,
> Conor.
