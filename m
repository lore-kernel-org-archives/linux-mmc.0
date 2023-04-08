Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D843C77B61
	for <linux-mmc@archiver.kernel.org>; Sat,  8 Apr 2023 20:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjDHUgJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 Apr 2023 16:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDHUgI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2023 16:36:08 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD313A5FA
        for <linux-mmc@vger.kernel.org>; Sat,  8 Apr 2023 13:36:07 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f188so33281838ybb.3
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2023 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680986167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZZscF2fONOwXuFXGvRXOAh5rZYNfj5+qAkcLUluk3c=;
        b=oAlGXoXnKf1mb3thE0+2Avw7QwYKWVsScj36Mtg5OHZ2uBg5ByXpsql2XwSCtK7QJu
         uxJx82qzQ6pdQ7L4V8MFyZVIzDtc/uehKUURjEDSqa1NMb1esjH7bkSaVruTFYnuEjKx
         /tMK4O0ujl8q6O6rLF4Grr/kvBGxPtP7tvy75gU5Wn1PMNpDdEQJ2wVd+G/+jPApt5uX
         iK/CVgmGg7IvJdvJgX+1yMbuGBJiHpU0RCd/6MBNcA61ARNYgJJitm26Ce5ySRKq+YKx
         tr4eo5HusgT5ZIf1ecOt7iIShpGF1VAqRMVkjcMKllsvKwio9Pe59A2rrc0AcxTFtGHw
         7ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680986167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZZscF2fONOwXuFXGvRXOAh5rZYNfj5+qAkcLUluk3c=;
        b=3hjPD3Kz/oJ5GpWJIxOiGaO/ZneA0iv/jbA3SHMBXQVeozgNYlFzYmv0dnell4JFtw
         GlJTP8ahr/T/52Hy0Y4E+8G4o7eVABy/vSPhlRAcKWmWlWuNASBcT8oI+b3cjc2E0y9b
         sUZsFxiRnYvDgZYJG9rDLYOr5Hs/z9TUtJILEtDf4t/0bYVTqOwEH+WoRboYgvsOSMF+
         MBVUktzII7OJh6Qqqrue12YRwI9Axq72fuzLaFJJEVESef1Hx8PAvMJZJiYs2ZtRGsOI
         QMAy1lp3aehGo0lAdBxyqK3cl1LKm9wuMhMK05386XyfaA52KgxHE9K1C7xF/pjl6eCn
         /x6w==
X-Gm-Message-State: AAQBX9eOy1xHPSN/LxlIGHf8ybFFIQv3rKxOLRBwMA7c9vkC5oxnvvTW
        E7wc2yqNtEFlZrDWPVyC1dCZ1PL/IsfOqZMBnz+ujiKmzq7Lx7JE
X-Google-Smtp-Source: AKy350ZCSktfVdSajWHk3Kn/fazYQY7zKRnkVbw1QkBqCtdZTrtjrJZ/VLLHDLKz8vf/X7ENsAiVz4UlF+h4HVCyPtY=
X-Received: by 2002:a25:d215:0:b0:b75:8ac3:d5d2 with SMTP id
 j21-20020a25d215000000b00b758ac3d5d2mr4241008ybg.4.1680986167032; Sat, 08 Apr
 2023 13:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org>
 <20230405-pl180-busydetect-fix-v1-1-28ac19a74e5e@linaro.org> <CAPDyKFp1KDV+q9ApKfq7C4PoiJnMOsACKJvbEiZLhv06GJGB_w@mail.gmail.com>
In-Reply-To: <CAPDyKFp1KDV+q9ApKfq7C4PoiJnMOsACKJvbEiZLhv06GJGB_w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Apr 2023 22:35:55 +0200
Message-ID: <CACRpkdZqosXtxsnTb87-Aw6m2MwC7ScGPNXmN_2=JxqRXA6mig@mail.gmail.com>
Subject: Re: [PATCH 01/13] mmc: mmci: Only call busy_complete if callback defined
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Apr 6, 2023 at 11:31=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> All variants that have the .busy_detect flags set, need to assign the
> ->busy_complete() callback too.
>
> To me it seems a bit silly, to check for a mandatory callback,
> although if you prefer it, then I suggest we do it during ->probe()
> instead.

Nah I drop it.

It's just a bit redundant, what you say is that instead of

if (host->variant->busy_detect) { ... }

it would suffice to everywhere just check if we have
the callback:

if (host->ops->busy_complete) {...}

and we can drop .busy_detect altogether.

But I can deal with that another time.

Yours,
Linus Walleij
