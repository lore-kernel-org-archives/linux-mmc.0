Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECDFC00140
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Aug 2022 21:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiHRVeY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344516AbiHRVeX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2022 17:34:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E6FB7287
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 14:34:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b38so1138792lfv.4
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VOhy2tOiLbiAu+EtvS1YkBDvfYv2x5oDNzcXv3P0Ar8=;
        b=UWwkFcvlE1WerL0aURek7cXUI+HSgi+5nkDy2IjkofNYn4b01k1tlN03fZD5oQ6THa
         eHFgHmdlK7mKIEOd5Q9gfcvsxzjFckjH7FcXnVtydZKmp7KffumnzGtJMwscF1cyf7Xg
         ZYzEdrZVCVl3za3s10mnq4QDpoOhVmjJIxIjC0Gou0u4DUzoAVL+EVaLDQwpHXXvtRVO
         D+vQs89/DL43FPYTem7oGpVOpbBC99gd4xnfZSznRmzqLAfzVu0VaMKNUhrgHqaCqAia
         3Qkyof9Qrxu7fbaarNbyO15AlGf7dux1IVaHdG00Vr4oG6Sx8Lm5RNI4Gd/FAKaijkAb
         I+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VOhy2tOiLbiAu+EtvS1YkBDvfYv2x5oDNzcXv3P0Ar8=;
        b=gSqlLkhpXKd2fYdyTMhMMertGpwE0V5CmWyifDhJsMLns/6PxCPXx2hy73V9asPc8g
         Eh8HSj48xzryRY0nb3FQRUukew4cTvMiObHS2Qcbz5SKHZGdpbwlCQzCmajzh2fbRvDS
         JfSS1Lyve5XiSuP91a5r7JWDqjepNgoO5GsIFUmFY0iYJJCUdBz3hpnUeX5DYsIvM6Ug
         qKva7ZyFX/jHB5DQNjM/vovvX+gYpZdnBa9wgwnPf7FWSWhaq6yZ1ZqAXC+A1SRmifLx
         sDZ9ehttDnAhU3NliAMIwwN/FEPRN34+zEKDnNiNcAJYVNefVpcA4wKL0O84wpNt0Fab
         Vkyw==
X-Gm-Message-State: ACgBeo1p7SMw42rKu502D+fGtsq8feQ+5KQOML8r3A1B0lXu5Elw58SX
        0DT1BeAIDR0eV3PGlNyRlXzx60MeadfJE8F+gSQvLA==
X-Google-Smtp-Source: AA6agR6D2i9rGE13LFDew1vJN5bGhBelCFBlfE0PV3AXp7SoPLbx2J1Dc4puNCBw9zzjvT5NXX7hAq+hqCtjpiPpht4=
X-Received: by 2002:a05:6512:239f:b0:491:cd95:f67d with SMTP id
 c31-20020a056512239f00b00491cd95f67dmr1445474lfv.184.1660858460085; Thu, 18
 Aug 2022 14:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220815105905.65188-1-adrian.hunter@intel.com>
In-Reply-To: <20220815105905.65188-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Aug 2022 23:33:44 +0200
Message-ID: <CAPDyKFogDVmHfVxOfjkn4_sWijtO1yfx2zOQoeRwUXoUuCq2sA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Update MAINTAINERS Maintained -> Supported
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Aug 2022 at 12:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Currently, status is "Supported" not "Maintained" for SDHCI and CQHCI.
> Amend MAINTAINERS accordingly.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f679152bdbad..4f804357f3a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7414,7 +7414,7 @@ M:        Adrian Hunter <adrian.hunter@intel.com>
>  M:     Ritesh Harjani <riteshh@codeaurora.org>
>  M:     Asutosh Das <asutoshd@codeaurora.org>
>  L:     linux-mmc@vger.kernel.org
> -S:     Maintained
> +S:     Supported
>  F:     drivers/mmc/host/cqhci*
>
>  EMULEX 10Gbps iSCSI - OneConnect DRIVER
> @@ -17995,7 +17995,7 @@ F:      drivers/mmc/host/sdhci-brcmstb*
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
>  M:     Adrian Hunter <adrian.hunter@intel.com>
>  L:     linux-mmc@vger.kernel.org
> -S:     Maintained
> +S:     Supported
>  F:     drivers/mmc/host/sdhci*
>
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
> --
> 2.25.1
>
