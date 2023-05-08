Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79230C77B75
	for <linux-mmc@archiver.kernel.org>; Mon,  8 May 2023 20:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjEHUNP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 May 2023 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHUNO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 May 2023 16:13:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026F55FC9
        for <linux-mmc@vger.kernel.org>; Mon,  8 May 2023 13:13:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9660af2499dso572846566b.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 May 2023 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683576784; x=1686168784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIYXjKK0hBvjiVVVHhHByeXrttVmKY8Bp2JHp345uLU=;
        b=S1ElEGS2VwyXZP+Juni4sOaWpcgHo+79kRLzdkK1qJ3jNbtqBMFlEOtKJ1Xe5grET8
         TRW64Blcbc3sS7H6Um20nYWZyMIOenbnrZKniZhQG/vn7WZK+9FZxhrRZyLaGhsaKu3a
         DGVVSRlp0yD8fqUykPLCsiiYJP+TAjm9vQ2pbzTQl6eCfssFBw203aDTEIYbIqZVIp0B
         ByFXtYXzty0lUuKgVEqrIejqCrcc3wdqlEGhtl+hwgOpg/pBgyWnDT+7gzmM1CX1yKKH
         vYhx1RxfgonHza9eXgDBU2i56l70ca0d49W+lqqqUUDdVsf+vYBbGMikQWehmDGzht4m
         cyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683576784; x=1686168784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIYXjKK0hBvjiVVVHhHByeXrttVmKY8Bp2JHp345uLU=;
        b=Z6/hf/EeOqIuRTR1wnSsmvNfl7bfeVOrSK49jUDqXftsueSHjF1YFjGLV+FngXzY0G
         aCyhpH1ZkKl0IE66EeLDKPhTJzNqJf3MBh9jsajVLfeoi4vYPwsfM7B8bWgs+jCQ392j
         8gOebRwDa83ADUwSkYAcLusboYYd3AZkjXgiSv9w3ezmOAoq09iZWovsMBc2IHHvJ6GI
         SKAm/fl5G828PaCrENy5jxhzgRnVvePLjGhcjuXzzRhHMBU0r9kP/atgAApalKh16vv4
         DGKa4IucbOvT8mW/m7LLl8gStmEai/uV0KLF0uWThtq9IWreQ8oWzbZ14fJgLD8jPlmO
         XW8g==
X-Gm-Message-State: AC+VfDzFGnMBu3OIJi2Ue8Mt5oiW3l5PUzb+5A4PYWqR4ZcklktNpMI5
        uE8VThlMWmczoQom5BpN1ADt6yhLd7/2qMvH1Ks60Tab
X-Google-Smtp-Source: ACHHUZ5v/7PMSKbP1WiZXfJkZSHAvJN9ticXlWIqYmUybc03sGb+Ueam1JXs3ObBQ+XxXEzvYoASiUj8KRE7GlVp31g=
X-Received: by 2002:a17:907:3207:b0:94f:5b91:7952 with SMTP id
 xg7-20020a170907320700b0094f5b917952mr9479149ejb.21.1683576784341; Mon, 08
 May 2023 13:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
In-Reply-To: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 8 May 2023 22:12:53 +0200
Message-ID: <CAFBinCBf9A9M15uBCtCafB2NOWd+y0xYwfsa9QxBUTCRJCpxOQ@mail.gmail.com>
Subject: Re: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf, Hi Brian,

On Tue, Apr 11, 2023 at 1:13=E2=80=AFAM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hello Ulf,
>
> today I found that upstream commit 4bc31edebde5 ("mmc: core: Set HS
> clock speed before sending HS CMD13") breaks eMMC support on my
> Odroid-C1.
> (yes, I know that I am very late to the party...)
I think it was holiday time in Europe when I sent my original mail.
Could you please take a look at this once you are back? Or in other
words: gentle ping


Best regards,
Martin
