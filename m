Return-Path: <SRS0=G9E5=7V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE47C433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 18:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B09D2078C
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 18:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oIwYbMCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFHSPX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgFHSPW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2020 14:15:22 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D315EC08C5C3
        for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2020 11:15:20 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id d21so10018819vsh.12
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2020 11:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGpe1/DmAZEAKC2EbhqvjHPxfTMYfr/m0SisqKdbZdo=;
        b=oIwYbMCnIsfKNwYT8md93PfuP9r3WakuHjByQqasLAlm2TSsnJdX7xymMGbPH1plWN
         Nos3Z+kA0XluxPtrS6ygw5fiEaBGd2U5+fGB+CSIsEv3CpJXlW7HyDc/8r406Yso9AQ9
         Ka/1KynuFafizTnKPJB0DxSRmZgeoyXY5/tOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGpe1/DmAZEAKC2EbhqvjHPxfTMYfr/m0SisqKdbZdo=;
        b=YmXJuvsQoLClEYnS97oQtHKwuschx4NhbylStu32R2WOeRO+kqX9ztjoUWuxzCKSak
         3rLYCCd+rFWlsDqCyFdP+Mq/wLEkbSafLSxSuuXOJwbNuWwQ8hc8D+ssB61fX1fAvO4t
         dsv/QH+97YMSZBz8yf0HBIZDJiPpLdcKnbjyoMx+kZgbxcrH663Ur0zqttiJCY0pJBGj
         jWLn8ibje8NxCQrGy9010lngmIi7P+w2S3k9buXjCRES25bBzSWgh78zKMQqagIwjNU/
         GaotoCEJ7Dkq5xScjV/0Dm6PAJoXuwQnrNE5b2chSR4khoXWvWiyMYk+ohRlooWYUj9T
         kCZA==
X-Gm-Message-State: AOAM5321KhG0tdgUKM7uPqiyS/DzrNIHFPC364GXYdRB8SPSnb5SJft4
        /yGLPr0sgjUUY7gKxVv5bYN2RgNX7Jk=
X-Google-Smtp-Source: ABdhPJww4bPp1STolByI3xIMtNPI3tlT+YKc9/m8IXw9zdjKus/GPtXvVocfmjUbGg8UyHvpkiE2eg==
X-Received: by 2002:a67:e445:: with SMTP id n5mr72555vsm.73.1591640119517;
        Mon, 08 Jun 2020 11:15:19 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a21sm74414vsq.15.2020.06.08.11.15.18
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 11:15:18 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id u15so4210332vkk.6
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2020 11:15:18 -0700 (PDT)
X-Received: by 2002:ac5:ce86:: with SMTP id 6mr15986500vke.75.1591640117928;
 Mon, 08 Jun 2020 11:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200608162226.3259186-1-hslester96@gmail.com>
In-Reply-To: <20200608162226.3259186-1-hslester96@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 8 Jun 2020 11:15:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U-Cn=Ze=6nY=E3LmxmrJPbnzKKd9h1dvtwx__u3KUQzw@mail.gmail.com>
Message-ID: <CAD=FV=U-Cn=Ze=6nY=E3LmxmrJPbnzKKd9h1dvtwx__u3KUQzw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add missed checks for devm_clk_register()
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 8, 2020 at 9:22 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> These functions do not check the return value of devm_clk_register():
>   - sdhci_arasan_register_sdcardclk()
>   - sdhci_arasan_register_sampleclk()
>
> Therefore, add the missed checks to fix them.
>
> Fixes: c390f2110adf1 ("mmc: sdhci-of-arasan: Add ability to export card clock")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
