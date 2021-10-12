Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB5FC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Oct 2021 17:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16013610C9
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Oct 2021 17:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhJLRkV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhJLRkV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2021 13:40:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB317C061570;
        Tue, 12 Oct 2021 10:38:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y12so2520168eda.4;
        Tue, 12 Oct 2021 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65fKHD+M+Er9uhTpiihlsDl5Duc5t5mBhlZrIZ+70nA=;
        b=mN5vlKdY6YDJyc0zZRmv57rBSX9TIH/y0NImzGlHpfeNIzchoiBRFGCwlopaw2hMmG
         zZ5dMQ3ZXbvUFC/Oy1EryRSkJvMjXDzOtBY1RyvRfJESJbQtQxajEjLU2aMr9LoTh1EC
         djoZIRgbsW3JQw3QnqQwBEocyAxLUnLJM5e//bsqHOIecXyQHSEADaXi2N6Ol6N08u0C
         HPiGCC4PYRYsD/KNimIyjqFRhsLknRBdth56xcxMpYvEAqnNTSwQBDOLHLiBzqllQcu2
         fs/VibPU3Wz0lXNzxqD5MrdfBRPjJ2Llr9ZNcAfX3hZA16kPGNtFmL+w8hxFnJdHa+Td
         fGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65fKHD+M+Er9uhTpiihlsDl5Duc5t5mBhlZrIZ+70nA=;
        b=DuzNAzf2NAdE+a+cKpYoqYZ9MXII+iBAwBiiALWaeJ3EQrT+1ock+vLbKsCCRcaP7i
         VqCXnZ7rYPQT/V6BaWC+NF8Z94sy19sSi0LPw3pTIDFnDYz+gUv8XTWvsfvz7HehrOVr
         tlR/KOJ41xwxM4ypQyojgoBAKwYbMJ3MkF59fZ7JvRsEk2ItwekqXFgE6RgP7Mrn+dKI
         tDbtsYHEKLZhURcNkBv1sXlz6pUjxA3U+JrPs8Zh6dIT+Cj2RnZKwvOf3aZSw8B2NJ+W
         eAIrcAsdLR4pJIcTfmJV2ZoRdazjfmJvzOSeHAS6hovzaNZs3mXWk+7yFyBTKDZKHfdP
         icIQ==
X-Gm-Message-State: AOAM5330V6YdMm23jN3BkIK6VZyStQ78bjeaUUE4Bzrgabk04pmUeBrI
        HkCCss1JlPW3BuOWb4n16qdo7/x+j5Arl1na/jE=
X-Google-Smtp-Source: ABdhPJxQJjl7ARsqRIHmUeD3KgJ517Bp5Voq/I2Xz+g7p2aC2VY3cryaO8s/aiOTYbwy/qmkPf7Fr+Tra2Ndald3Xfk=
X-Received: by 2002:a05:6402:10da:: with SMTP id p26mr1496074edu.283.1634060297308;
 Tue, 12 Oct 2021 10:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
 <YV8jfavX/W9T25YX@smile.fi.intel.com> <cc9d92a9-0896-5222-2080-1380afd480ba@intel.com>
In-Reply-To: <cc9d92a9-0896-5222-2080-1380afd480ba@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Oct 2021 23:37:30 +0300
Message-ID: <CAHp75VdAGkG-xK1sMna6dG7dAd7ZbnGicimorftTOjZ-8cvC1A@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mmc: sdhci-pci: Add some CD GPIO related quirks
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Oct 7, 2021 at 10:45 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 07/10/2021 19:42, Andy Shevchenko wrote:
> > On Tue, Oct 05, 2021 at 01:24:24PM +0300, Andy Shevchenko wrote:

...

> > Adrian, Ulf, any comments on this? At least first two fix the regression and
> > would be nice to have them in sooner than later (I can split them separately
> > if required).
>
> I am not sure we need new quirks, given that we can just hook the callback
> and do anything that way.  However I really haven't had time to look closely
> yet, sorry.

Adrian, thanks for review, I'll address your comments in v2.

-- 
With Best Regards,
Andy Shevchenko
