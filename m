Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F364C433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Apr 2021 18:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371F5613F1
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Apr 2021 18:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhD0SfE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Apr 2021 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbhD0SfE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Apr 2021 14:35:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24648C061574;
        Tue, 27 Apr 2021 11:34:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z5so34657382edr.11;
        Tue, 27 Apr 2021 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5xmzT0WzJDDHOkvVRV5AjYHf40HsChk8Njw4hrRnLE=;
        b=L+krghGInoAmAnhlwYLKrfeFLlhwJ2XNz0eMB+qbGVam0e4IpcRGvwGWsHILy9BoAe
         42hxvV5AIwoqswQWVws33bu3lrb4G/EDzaZeH9Sjpjg86KnllVdZcHwosnY83WwEHMaa
         OQ6k/0rSO7ICThQ1eC1GyQHyozbfpeDFMCgtG3Rz9v2ANWoxAMY3KgGJWhGhh3A+2hy9
         3cb6L2DJepCN+gJBuwOklGTQM8PMxvEpohYPHaKyCs8G2QHeSn+Sy9ZXdTjyntMX4ssQ
         LG+UPm/oCsOhPGbDi7reSDUpXvky+bVr7lMW0vdJpYpY3snEzuxHtMQ3bEWjhm8dIikb
         xoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5xmzT0WzJDDHOkvVRV5AjYHf40HsChk8Njw4hrRnLE=;
        b=APtnIM+K0PGf6otVjolrpQEcgOVQBlJW1AUzKgyvLqvRUsUPFojjkm1NkmJdNRyNl5
         yU/fnWcTs8ABFL35Unw4oiOVUo2x3GviDqQCLvGCG3b0f1LZHOoTcQow1+ceVTqw80oT
         lBxzLowmcCFKgUnlh07wGeMDnwdJXExFur+fMuhakK3ZjQISgHVUnHTlDliyU3awW84E
         PEgkjnTz0jXuVCdN6s04GD/P6vPq8oKBzN6p78VIzhUp1D2VdROzhLPWHvJNrUFqRUkp
         IdquXgrhbbIDVfdQzzY7oIG5uJ8mnIoA2L5QyTj89rH0tO89IKre6gBypxASfRqvfQkr
         yuEw==
X-Gm-Message-State: AOAM533POqc5CWKNxqbPreFuDQ54yasgIQFN1lpRxm1rBxBF1iDU0gDK
        KeXranbT3UaT0BrIQ1UNl1N3B//bntHprJhi92XWAdMxc8Q=
X-Google-Smtp-Source: ABdhPJyXil+DULg+GIVf+69JFlY+AmrhOQ0EVXN1y5/l2hjCszSsOadeNnSfsv8E7rBh4Z1lJGVL0U+Ki8vMOBPRmuc=
X-Received: by 2002:a50:bb27:: with SMTP id y36mr6183368ede.365.1619548458935;
 Tue, 27 Apr 2021 11:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210426175559.3110575-1-narmstrong@baylibre.com>
In-Reply-To: <20210426175559.3110575-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 27 Apr 2021 20:34:08 +0200
Message-ID: <CAFBinCCN88nfSnmPoFq4H_ROWFMbq=Kcpr1W6CpNs58XeHtV2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: meson-gx: make replace WARN_ONCE with
 dev_warn_once about scatterlist offset alignment
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     ulf.hansson@linaro.org, khilman@baylibre.com,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Neil,

On Mon, Apr 26, 2021 at 7:58 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Some drivers like ath10k can sometimg give an sg buffer with an offset whose alignment
sometimg -> sometimes

> is not compatible with the Amlogic DMA descriptor engine requirements.
>
> Simply replace with dev_warn_once() to inform user this should be fixed to avoid
> degraded performance.
>
> This should be ultimately fixed in ath10k, but since it's only a performance issue
> the warning should be removed.
>
> Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
