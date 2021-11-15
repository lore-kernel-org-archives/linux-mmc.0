Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A705C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 15:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E1F61A3A
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 15:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhKOPMf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 10:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbhKOPM2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 10:12:28 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5E3C061766
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 07:09:30 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e9so36225433ljl.5
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 07:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yM+by/2RKCJrf+7EIbv4qG2uO0Xd+W93EE50X4+lOwE=;
        b=wUjcJ/HlNPDDxf8FCdTSai0PtCQQcgM2d5gvkNYvgBY+ZGliLW11ubCXI4Tmq1U3Bs
         21CIiF/oMS6yqybkQhoRUkFTfRajLPkC/za+o8DUWLSdc6vif0qzvEPKWnGTAP7/PQ/N
         Puj8uBqfz72AcV/gza+RDSg7b3kEVyJmifOZpUzDXRmXOJqv3Wsq1sTV4zx+tvgV36YE
         ZmFXePqNjhkUGJghWwkit+Sqtc56EBUthLtiCr7NmtbAI0wjk4SgsgojLsf3pte1aEjK
         mQr63y1mKD/G1oNgoPg9jgVKlShsDfmvr04Tux1Cgdfg3K814jKIff5lz9PdT5ILXpTv
         WLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yM+by/2RKCJrf+7EIbv4qG2uO0Xd+W93EE50X4+lOwE=;
        b=JOEukQjUaAo8qN/p5thjiNcYLs63Uh3YFchbE2nZwofP+uTvZKRWx2QyHhGgrPgoB4
         li+aO8kR7aJTQ3TjtPMZNYP94xmmF78419C1n6cKfqD6oiae2/pnZ1I2q53upypGgrUi
         KwTlMT+bFSMOcQPDb0983r4OzD7GK6Qq4mVudQKRycsjBRwkC8E+GwwRmiRWiDrHGG3b
         Mk1IeNM9uAnLUJvz6Vkwg57/R7EHbNF5M34VlwvwIEVRnJ4KLxqhrf1keDSLSJSQAMee
         aZVKGWiLlkVlkaJvJEXq0yn/z9cdYGmxuZPuvjHliQ6mu4ekjKSK/urUvhBmz5oPTabT
         /CHw==
X-Gm-Message-State: AOAM531ulAyGLb/v3ekhiJ44poVEA4uVQvuJr7Pz3Uhq5AK1BADX16jD
        MNxZcRVr2/QgAolBjAwo7mF4AmKa9FcI0Yeyk/LinQ==
X-Google-Smtp-Source: ABdhPJy5AMZdh0sfm8uOWw/tJKGnTfSf9Xz07dErmf/MoQu7B4Mad9f6IS1CiuXV/oqHuhMo9vS+qRB15ZvPbgTOWEE=
X-Received: by 2002:a05:651c:10b1:: with SMTP id k17mr39203860ljn.463.1636988968915;
 Mon, 15 Nov 2021 07:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20211114204331.39555-1-huobean@gmail.com> <20211114204331.39555-3-huobean@gmail.com>
In-Reply-To: <20211114204331.39555-3-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Nov 2021 16:08:52 +0100
Message-ID: <CAPDyKFo6sbFkbeDSDzukd64O+HFSj2Dzzd8_AJa3v9ZLh3TqjQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc-utils: Add note for CMDQ_MODE_EN runtime value
To:     Bean Huo <huobean@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 14 Nov 2021 at 21:43, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Since the Linux kernel commit 70b52f090805 ("mmc: block: Disable CMDQ on
> the ioctl path"), CMDQ in CMDQ_MODE_EN[15] is disabled before reading EXT_CSD.
> Therefore, it is more accurate to use sysfs node to check CMDQ_MODE_EN value.
> Add a note print to highlight.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for master at git.kernel.org/pub/scm/utils/mmc/mmc-utils.git, thanks!

Kind regards
Uffe

> ---
>  mmc_cmds.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index ecbde3937c81..46c5f5faae02 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1885,6 +1885,8 @@ int do_read_extcsd(int nargs, char **argv)
>                        (ext_csd[EXT_CSD_CMDQ_DEPTH] & 0x1f) + 1);
>                 printf("Command Enabled [CMDQ_MODE_EN]: 0x%02x\n",
>                        ext_csd[EXT_CSD_CMDQ_MODE_EN]);
> +               printf("Note: CMDQ_MODE_EN may not indicate the runtime CMDQ ON or OFF.\n"
> +                      "Please check sysfs node '/sys/devices/.../mmc_host/mmcX/mmcX:XXXX/cmdq_en'\n");
>         }
>  out_free:
>         return ret;
> --
> 2.25.1
>
