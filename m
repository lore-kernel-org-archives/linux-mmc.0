Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89392C07E96
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jul 2021 12:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6413061452
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jul 2021 12:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhGHMwy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jul 2021 08:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhGHMwy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jul 2021 08:52:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F74C061574;
        Thu,  8 Jul 2021 05:50:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p9so3460347pjl.3;
        Thu, 08 Jul 2021 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcHQFi+8e8Mq6rFTSFUkcqHki4CDxOmVuk4mSIaVOt0=;
        b=G9heB6AtU4IBxFLX15YdIRn8NIArvA1BL5bPy5MA0OEEqBBN/ha2edgEjlCRuHz79d
         dL+kQmAeob0Wqr9XMjY4ctbPU+x3oYcQ8MNBSkVZvqkC94/g1UcSTozS1WjaYw1dbq0I
         /NdqT1C82oGcHI5uefrB9ce/51vHgacWkQ0F2C7UKwhjqOp1Cc2NopWqP58C8bRoZWQr
         IiTPjB8bEl2A0CrDdXRW6lxEWpQQZ6rebrHO0iA1b5wTmfAjG9cOkPmhzT+ypfacHiwr
         sv957RNV8n8z3/DCShgxHR7zMIKwVvrzuPw00jVVdrw2lw376dfnqcLJXA08EBDOMEi9
         LK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcHQFi+8e8Mq6rFTSFUkcqHki4CDxOmVuk4mSIaVOt0=;
        b=hTOZ7aVogQKmyFHvtpJdhnmzPKXjY+gE+K/Ttz2kshkFqf98OhGlhBwsmk0uxHLoil
         QF5UTvU+Yeh02yPMRYlET6QwnObXsI+DG3w1nS/D7PeSVgxe9EEPubeddacCbNmWUJdo
         +hIrpQUNJHOB70dBSpo+3AmsNiXpyDXhg+AFZyrtU7fIkWUVut1Rx0YleinhYQSWXn+g
         w5qFkw3BS9jk4YkBXsEbXb1vPz7i+asrTjahhzSzRnnyVBgMLJ0oHQm3GoO5hIh/I/ew
         OEWenKS+wG4by80ozbFFqJsxyaIGZduxhKxpuCP6Bj7AG+cpoizuUy6Z7UV3iQS+W96g
         X83A==
X-Gm-Message-State: AOAM531w1xPt659ewRnC4ig5Y/m6SB5k7uLE2MoaGHL13Wd2zpr5ANrB
        9nzFw7IAPo7HIGuThmsHQrU0KUDWfTWD7JQ1iwhYAH6+o9U=
X-Google-Smtp-Source: ABdhPJwXpIza/Rm0HTKf2QInQQ+egmaPF+Jp7aqI40ZSaTOv0R3uakOriHs76GSbk1t+9bnBVvGqVvkXJJjEhMUlfes=
X-Received: by 2002:a17:902:b198:b029:11b:2246:e374 with SMTP id
 s24-20020a170902b198b029011b2246e374mr25928208plr.17.1625748611098; Thu, 08
 Jul 2021 05:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210623101731.87885-1-andriy.shevchenko@linux.intel.com> <CAPDyKFoM-gkFPoFePbHS62r-HUpk6ipA5J-qPbQ8NWL9Mm_N2Q@mail.gmail.com>
In-Reply-To: <CAPDyKFoM-gkFPoFePbHS62r-HUpk6ipA5J-qPbQ8NWL9Mm_N2Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Jul 2021 15:49:32 +0300
Message-ID: <CAHp75VfdDXwboZWZgRdFNXLpONy8UgDryeZWd6UD2RaCXo=uOw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: mmc_spi: Simplify busy loop in mmc_spi_skip()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jul 8, 2021 at 3:33 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 23 Jun 2021 at 12:17, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> This certainly is an improvement.
>
> Although, what do you think of moving to readx_poll_timeout(), that
> should allow even a better cleanup, don't you think?

I believe you meant rather read_poll_timeout(). Either way I don't see
the benefit of using that macro when you have to customize its body a
lot. Besides that the macro doesn't use cond_sched() or even
schedule() and I'm not sure it will be an equivalent change.

That said, I prefer going this patch as is for the time being. We may
adjust it later on.

-- 
With Best Regards,
Andy Shevchenko
