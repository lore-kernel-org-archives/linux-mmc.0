Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAD5C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC5E61108
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbhIWSv7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbhIWSv7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 14:51:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298DC061756
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:50:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z24so30472842lfu.13
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CBqcEeaNCIzEJmTkQKL3nnjymx6WgZloiotm1WXO5Q=;
        b=FZGhrTospEri7qgpD9SosYC6mllXRRt1rSBWvIvR7N6iRArrjJ4He4QebBVd+cajfD
         75fqVz58YQWNarvpFpkkshoUQ62pc/Xe8n6xbmSQJF9zUVNOeKhStA+uKX2UcVm7EVDX
         Oy2VDS9I5ojFOcoejlAFsjwE2gYhurBMeUudMpVhx8DYuubujSTOjpaah5SevSeFR9fd
         bJJulkeZTBrwxYSgMoUp91EPJgOSmZmRGChxEzA3RrYPVyj2xVvHy4uAlTZ+3HyF/FLQ
         DewTEnSJEiN4q72dr569yuFVpZzyGZvKSBiRcBIGcho9zS2k+bcHL8F0ipPMf7u9VYmx
         kEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CBqcEeaNCIzEJmTkQKL3nnjymx6WgZloiotm1WXO5Q=;
        b=xd626Y2urrFhYFnAU0PlVudVeFp4BrDAtyCJycUfnWb2lM8OJ5Ql8JkTAUA9Wz5JaA
         qI3NQ2gzc++Ze7qP0IZ2IN3ZYXe8mD0OpIYswwU6velAVPethjy4BWYqWsKYsSLf0hZr
         xOeOIfy4t+qKb+L675bPgSfxvvn8VYqwFwVxzq+tJHiKmUKmeGAstCGcp8DakLclGfNh
         HTZfg4Ty07O1aBBUT2GOR1j79szn4eIHieDnwHDyMKKb2XlHXZ0bTA96f8G+r6X2WNfm
         2GD/OYc/tCntaBFZlkEQJPIA0bXTpo+xnaMaXURgaF2xFAZBDVfr70fMkZb/fz4aY4rn
         qC3g==
X-Gm-Message-State: AOAM533BBQ7kNpyaA6U8/wIf9hUg5kwNaYSVKSDjI+mKqxdIXTOQf4+R
        3OcFfmJCY48yhdxs8jMb44iYf3PO9ftwhIaSMw5Glg==
X-Google-Smtp-Source: ABdhPJy/jBdtZppzF1VrwwZlD+f66NRxMptTHpqaUXWgpxUCUuKpfe5ziBVMZ1OUWRIIDczx8iHpuWgdHYKaXL61ooA=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr5554685lfb.71.1632423025387;
 Thu, 23 Sep 2021 11:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210917124803.22871-1-wenbin.mei@mediatek.com>
In-Reply-To: <20210917124803.22871-1-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 20:49:49 +0200
Message-ID: <CAPDyKFrtrY4qDU7nxynXuvyw32zkHcwMkmJJjftj7EzMcsD9Lg@mail.gmail.com>
Subject: Re: [RESEND v4 0/3] mmc: mediatek: Add HS400 online tuning support
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yue Hu <huyue2@yulong.com>, Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Sept 2021 at 14:48, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> Change in v4:
> - split driver patch into a core patch and a mtk-sd patch
> - use mmc_get_ext_csd function
> - move mmc_get_ext_csd() to include/linux/mmc/host.h
> - modify some commit message.
>
> Change in v3:
> - add detail descripthion for hs400 dly3
>
> Change in v2:
> - remove the check "mmc_can_ext_csd"
> - change the hs400 tuning condition for "msdc_cmd_done" function and
> "msdc_cmd_next" function
> - use "-EIO" instead of "-ERANGE"
>
> Wenbin Mei (3):
>   dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
>   mmc: core: add tuning support for HS400 mode
>   mmc: mediatek: Add HS400 online tuning support
>
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 12 +++
>  drivers/mmc/core/mmc.c                        |  8 ++
>  drivers/mmc/core/mmc_ops.h                    |  1 -
>  drivers/mmc/host/mtk-sd.c                     | 79 ++++++++++++++++++-
>  include/linux/mmc/host.h                      |  4 +
>  5 files changed, 101 insertions(+), 3 deletions(-)
>
> --
> 2.25.1
>

Applied for next, thanks!

Kind regards
Uffe
