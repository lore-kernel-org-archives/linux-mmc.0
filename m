Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85562C433C1
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 13:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B9461938
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 13:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhC2NpA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhC2Nov (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Mar 2021 09:44:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A3C061574
        for <linux-mmc@vger.kernel.org>; Mon, 29 Mar 2021 06:44:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q29so18456678lfb.4
        for <linux-mmc@vger.kernel.org>; Mon, 29 Mar 2021 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xbwOyUoByuGnZGoWKpGwyaF8Ra1/D45zi9BaPI7asA=;
        b=iLaLQP3gfwQoeqqnF5bgUGM7HmMcRJd2XQHUEp2ZXgZlKyrHNnyDBgzyenG7VRZAkF
         TkzvXw0PdghuCeoFyIHVAyjML18L6DnL1Hm2qHPdqlUDIqO+7D5DIFdTbqWTL6RsoslN
         frLA/pVwrLgTFkwzc8E+HCJfWM2a1mHPJxa5YgZ+221DPxMO5Dy422whkdUC9MhzSUh9
         2rOQox2y9WTkTSEc/xw4jjloCHigCq6GFtgQYrqbSvXYEZAy3M4vdnPZgY+i1bRuZ7CU
         Z8VriZNADTlteSOp000kLFSykkZfOujZP2h5exuCf3xSPgm0yGnV9sxj3dfzMnrR4+bG
         c37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xbwOyUoByuGnZGoWKpGwyaF8Ra1/D45zi9BaPI7asA=;
        b=EyR7KEA5EmQGWOG/eNMXl17wtLJEX3qIQpaNDUrtfesohP3cv2lRlho+sPa54l3UDf
         /jfSBRtmIe0+kmhp1p+KIDXoGBrjDfBwbYIuJg0IjlxZSBXDv+btnR+652u4AEHl+dYp
         +/XmjDhL+WrqAX/urvfuzqSz5JH/gCPHnGOrwpFj9gv2b0CxurXeg5TxMaiJ4rUWX9Es
         kldornMkjom2c/JKXL1zvJPBwXP3sMM+L7DZIbO3+220TnSbMEOs9Ys3DSMVZiIe/0YT
         J9kK0px9IdTnW12g3sPWIsAGIBsKZ/BhJHRmkgYaZvf/8ohvWD48KgM1cnhyUbAnGCfW
         h2rA==
X-Gm-Message-State: AOAM532cqKQNknbiq+CeH60zouB5Gc/iVvVDHzSNaIdrLH6hMK/29VsC
        yFdFZ9nmfm1n61f6vwl+oFaOcmQ+bAKTJQMJx/p4wA==
X-Google-Smtp-Source: ABdhPJx46cwsZAPTk7xADrpjLswh2jZ2RWz0/XBNMefSDCHrAKWZDNbXjH4pAv01Lms1i1d6DR1r6h75l/y09/ITdeY=
X-Received: by 2002:a05:6512:243:: with SMTP id b3mr16860525lfo.529.1617025489839;
 Mon, 29 Mar 2021 06:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-14-brad@pensando.io>
In-Reply-To: <20210329015938.20316-14-brad@pensando.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Mar 2021 15:44:38 +0200
Message-ID: <CACRpkda78p=aU5xfT+HtC9OCkZdkVEiN64F1jck2FDJB02C+Rg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] gpio: Use linux/gpio/driver.h
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Mar 29, 2021 at 4:00 AM Brad Larson <brad@pensando.io> wrote:

> New drivers should include <linux/gpio/driver.h> instead
> of legacy <linux/gpio.h>.
>
> Signed-off-by: Brad Larson <brad@pensando.io>

Fold into patch 1 as indicated by Greg.

Yours,
Linus Walleij
