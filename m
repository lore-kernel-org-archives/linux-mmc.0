Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259DBC3815B
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 08:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F31DA22244
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 08:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPbM6YGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDTICQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTICP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2020 04:02:15 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB13CC061A0F
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 01:02:14 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id t8so3272344uap.3
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGNbQJnwncFtmSfnnq7BG7mTK5kM8GPjPL8s7er/Oug=;
        b=FPbM6YGm0+2v+a7dfLD2r1xsPIdoZzsB3WLcQQpt+iiMZ0ZPr6E+Xmah4VeCnoBVwM
         1XI9tGVqd+amR+wTuvVcSje66GPeBZyjeGx2riOIZ5WnA0cCWkSXlmOFJdYy3+7LumtF
         LXINRU0UpApdf0FihchJuJxe9kxYFW70+mWB6Od3Fk7CyKmTnue8LmsJWXLJ87jKt7pH
         zhpqlZ7rQaVen8QMRXBN5XO7XD2vZOggFT3VHz80jzrnbGum40+ZXcX+aR8JsRCbvWl/
         NTVTFHylhWw+j9qoGVrOVHACsQIgRAs2mxa48rsE1VTGzlzxfi5LNYP/TNrD0oFSu+Mr
         Qqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGNbQJnwncFtmSfnnq7BG7mTK5kM8GPjPL8s7er/Oug=;
        b=tkFPYXLkLLSmf63YX2BPmAEyU/OFSrPsY5+EnXIz1NAQWRbjBGo4BamnqWQKFDZi7W
         l9Xb08jB+9emPv9UEAMpFyy45iC5KMEEjALOwgoXLX6CPqDb9/wSb0q0T3iwm1hCtli0
         dTmV9Ih/GB6zkqo7O8VVSuXo+OCwsR6F8t71zmjBzcIK3Y/3FYU14Hd2pOlF0MOhCyr2
         n1ksWKtmn8Xrj0VTYHUu+mvthH+F89fw7wgIlqfhAL0L1Z/HR0XgF+QiKJF2qp8vvTvA
         EsilREs7MwUnRdBMeJpi1vqivg++rQDG/v2JV2IySBJMkZ8PP8LPZIA9+PuTUrD+pdHl
         WDjQ==
X-Gm-Message-State: AGi0PubouyIw9VblXE92kaYiRmV7PnGnKp7Uys76DQBlWoC6wvZJt42T
        Ruf5nI+jQStKsck9eSk8QiZTbOcBJKjAcYCl5CwZcA==
X-Google-Smtp-Source: APiQypLaYCzytAomXpGw0KpBtvlb+IMYlHUaXnefkBr/mv0cHGOaEE/8DDORc8fTsMLcsoUj78yspHZlXLsrfKD9OfU=
X-Received: by 2002:ab0:6588:: with SMTP id v8mr6202526uam.100.1587369734116;
 Mon, 20 Apr 2020 01:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <1587363626-20413-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1587363626-20413-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Apr 2020 10:01:38 +0200
Message-ID: <CAPDyKFoOq3djNJzEppPwSUUfKYh2vrkcr3LmDEbfwPRa=Asphg@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] Minor fixes to sdhci-msm
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Apr 2020 at 08:20, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Enable a couple of CAPS that qcom sd host controller supports.
> Set a quirk for enabling support for auto cmd12.
> And enable adma length mismatch error interrupt.
>
> --
> V1: https://lore.kernel.org/linux-arm-msm/1586706808-27337-1-git-send-email-vbadigan@codeaurora.org
> Changes since V1:
>         Squashed two caps related patches and appiled stable tag.
>
> Veerabhadrarao Badiganti (3):
>   mmc: sdhci-msm: Enable host capabilities pertains to R1b response
>   mmc: sdhci-msm: Set SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk
>   mmc: sdhci-msm: Enable ADMA length mismatch error interrupt
>
>  drivers/mmc/host/sdhci-msm.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>

First patch applied for fixes, the other two for next, thanks!
Kind regards
Uffe
