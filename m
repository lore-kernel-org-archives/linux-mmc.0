Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B77C7EE20
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 14:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDQOzg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 10:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjDQOzT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 10:55:19 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C5B758
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:55:10 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fe82d8bf5so106532157b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743310; x=1684335310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gxiUW6ouT9eU7cEEuvLNBJj6uCVyb9oxwSNWWSEtoZY=;
        b=N1jBHyHqYo2w92EqHmVUYcqBX4h2RId2T4ePUICUx/e+tLVf1KI9NpbNnJj+s1/cU4
         jIl8qnM1JZFPP5l4afG5sTu77Z5BL0hFslayWrJv4Huimz6RFjxlTwvHTMUDSehblB2z
         DWrmIcK3yreuICY1Bs+TV59BQiSZKQzzUiH0me6+fst2jMe4hOcG5qPVFS6JqSuaNRo2
         6yET/AXWVeD0lJWU+sXkuG8wYmd2U0f8WZVVeejNnRkOfoG4A/6zNeH8fEHwAUM1ALU2
         dHVNOXlwjDJd6L6q8hHWBswsbyW7Qv4JpBEDkOvjLRu41W/uoEoY4wZH0IycfKTyV6LD
         TWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743310; x=1684335310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxiUW6ouT9eU7cEEuvLNBJj6uCVyb9oxwSNWWSEtoZY=;
        b=HhgbL+XSgOVDZ2xy1H1O/4ye37gxAtMDvvNV8IoNgq4dkKJ7yjA/IVk1b6q/WzyVGP
         Rt0VTCZgEvMjHGx7XQ2WrN9rzLslBkkNePRgQ6D6KOblL4B3QStYMLjBka2iAcnQXraO
         mYJIbdLrzFGjePYppbjfgocdR/EiixXdhxONjVFVMlYpIeyuxm5VCQLQ5U+amBlr1ywi
         9JBOrFSzXMlQTYsSHxV1vl6xumM7k6Eo50PFNzHVwDH+9whwZKDGjw+gd9o8LWASX3gC
         Oqn71v9F+ST5iHJZ/cvuSCZl4cG4GYNmEcy+KU+FDennoq3FNDHzgSLde1a09o9iI6Sf
         Ukcw==
X-Gm-Message-State: AAQBX9eQSQ8+WHMkd8utkY9H+9/OifgRDnllFzwGeQ6G/FmP1g7o0XXX
        JOPvNSVWYXOiFzvKSH3T8MneOZjxiBm1k0Usq3/WcwzSgdajBBmkc0A=
X-Google-Smtp-Source: AKy350bXe9bPbnmpUz40cF1jrt++48kzgjsPqD/6o8jjRKYJSOIMahy2BKO61REoJq4aAZfevpMsengqgQ8um5wpTJI=
X-Received: by 2002:a81:b64b:0:b0:54f:9718:1d33 with SMTP id
 h11-20020a81b64b000000b0054f97181d33mr9282038ywk.0.1681743309911; Mon, 17 Apr
 2023 07:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230412084758.2673-1-liubo03@inspur.com>
In-Reply-To: <20230412084758.2673-1-liubo03@inspur.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:54:34 +0200
Message-ID: <CAPDyKFqcpBqCnzxE7wpM7q1oDfHjaFV=ggnXJTE=hNkPK3=60g@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: remove unreachable code
To:     Bo Liu <liubo03@inspur.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 12 Apr 2023 at 10:48, Bo Liu <liubo03@inspur.com> wrote:
>
> The function sched_partition_show cannot execute return, delete the
> invalid code.
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/vub300.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 72f65f32abbc..e4c4bfac3763 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -1341,8 +1341,6 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>                 return;
>         }
>
> -       return;
> -
>  copy_error_message:
>         strncpy(vub300->vub_name, "SDIO pseudocode download failed",
>                 sizeof(vub300->vub_name));
> --
> 2.27.0
>
