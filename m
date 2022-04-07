Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36EDC433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Apr 2022 11:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiDGLIT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Apr 2022 07:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiDGLHf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2022 07:07:35 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA2F1ADB1
        for <linux-mmc@vger.kernel.org>; Thu,  7 Apr 2022 04:05:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id w134so8859604ybe.10
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2022 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Wnce8ncyatyb4gXkJdV081qkC28xHzM2e5a5lY4yi8=;
        b=ytIEiIg3QiP013POiEG2apVS1RqXz3qs+vCRF3uUMKhCGQxRAslFraHUvrNhC94XLs
         1087O6VSv22VakIPvOQE4OpNoz9RyAbLohuvdrC8G/OLNMpELKzlkG8eGkpHWL9oBZY4
         Y+cTGKKfJKumQxF6hQxSHwNZ7Ve9lFYQPOEce1u+HeQ1DIsGjUDUAkasl4isUKoUmJvb
         UmkY67z7j2UCR9uQ7PxlWiEHMZpnBWRDympcyoAuikNMox+Lk8l3rduFFYODex2JOXFJ
         NFSGpJiqzyhkyHaKC8o/zADs8YAJehAdOyXux1FxgOjsf9O+VeinGEM1TGWOhCgn6ADU
         faDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Wnce8ncyatyb4gXkJdV081qkC28xHzM2e5a5lY4yi8=;
        b=DCcj3KMlJqQxEiCzzmthDyuugI2MyhQsXs5h3xIOKh6MkDisEuu+K3AqerenYvB4f/
         rjdVf87mA+znN5mteJzNlWu4GWYX/vO7zvpkBAsFpr1vL0pXIvluRTVUUbv7lHWOLJSn
         vC4WpgMvFpG2CdWQV2YhIzONjKNHK9p/WlZlldOFItoHJv5B36Urz+RTVs+D5B9en0gZ
         Qh5UmMDwC4KyNN1PZconLZyQbbePICrhYfU0pA+84pRFhr02DUrCrSSzcltkCWeasr2V
         B7k3gqUR3eN6M+auK/YnEyctGxxbdNPO3AwOtrka8+/aWH0whgj+lqfPoGM3cirRdQBk
         XvWg==
X-Gm-Message-State: AOAM532XhMhrT7zHvTxBt48Z42IYxA6Uzn4bbKRGJ69cekoqtlIGt/ik
        Bh+ckKewQXHpOy9GSFeUv56eCUd0rDIhdhPu81qyfA==
X-Google-Smtp-Source: ABdhPJzzGKIMIRVH84s2AytE2sGYA9B4IzNEPjC3vRlzS+EcJoWlDXej5CaUimsSTSINkFmBjimra7tAENYAvcQZ7vI=
X-Received: by 2002:a25:344e:0:b0:63d:b9af:4dce with SMTP id
 b75-20020a25344e000000b0063db9af4dcemr10320468yba.123.1649329532622; Thu, 07
 Apr 2022 04:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220404174159.571-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220404174159.571-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Apr 2022 13:04:56 +0200
Message-ID: <CAPDyKFp9KdBRes7Ks2m=qpmrmX0J6ZFVqt1+CuCDM-wGXxOPVg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add linux-renesas-soc@vger.kernel.org list
 for Renesas TMIO/SDHI driver
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 4 Apr 2022 at 23:39, Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Add linux-renesas-soc@vger.kernel.org list entry for Renesas TMIO/SDHI
> driver.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e98278418d1..64529590a659 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19858,6 +19858,7 @@ F:      drivers/media/usb/tm6000/
>  TMIO/SDHI MMC DRIVER
>  M:     Wolfram Sang <wsa+renesas@sang-engineering.com>
>  L:     linux-mmc@vger.kernel.org
> +L:     linux-renesas-soc@vger.kernel.org
>  S:     Supported
>  F:     drivers/mmc/host/renesas_sdhi*
>  F:     drivers/mmc/host/tmio_mmc*
> --
> 2.17.1
>
