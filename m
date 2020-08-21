Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE36AC433E4
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7E8207DE
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcbZN0Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgHUNEw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgHUNES (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 09:04:18 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2397BC061386
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 06:04:17 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id o184so779723vsc.0
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+gRZoMDKAOIDXbYKHsorub5SMcX/+MV1ACNs/3zjm+c=;
        b=dcbZN0MzYhATULNNwg/C5exRnna2Iqk4IyRb2YnEbb0zk2fEvE6NdekAVNLWfH//nP
         1dbTRt37RweqFyHOZ+KIInaHjHtjwoHIr1HUBqZV5LseTcc0ZaDR2zcEr4Zy0KSC56pC
         y/CXZyxa1u9OAQYp7Q9Zoi1LowhxkC13ex3BpeL/gDiaIrd3LyvYX4FxHXbWae0abAyN
         8nVGusIreCxDrab19+fPve5eOJRcbemGlmdUirZCkITAHGUYXc/1SvQt2KXgZF2cd0jT
         Vzh4LcOE0hhhXjsoJzChim0Z3nTufMbtKNcfYmhKXuNZVhdqiRoJ/535F/lu1dLSZCMn
         n4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gRZoMDKAOIDXbYKHsorub5SMcX/+MV1ACNs/3zjm+c=;
        b=jhb0lE+cvPmeYvKrkoz7//F+bM5obPhzaiNcGN/nutIBAlQdfCVopzlOQrivQslcaH
         SBtMMHUooXeKu/Z+wPK9MPgosDa4NXIZFm4ISVnuipuYB93Os4KJ+52528UzRe3sUyMb
         lTVHOLBSw7D9ntVC+/3GOqmdI6asJvbFNkOGgIEWimdc1fLyczeXPb7QNEcQTRrFq050
         VUcA2gd3yMSPm0Go8Ssgerjy1b90h6FWXtC/HaI5OBAvLw/uTiMhNQfZsyQ1RdKBP0xe
         3F5OJItt65l977R0le0EVHbn5n4gfVg8ngP4xBGESswBNS2ixTsyqVluVZRv9PnoqVNJ
         m0yw==
X-Gm-Message-State: AOAM533bj2+dfIootfdcL+uE4lUn53CA77nghecyIaSLz++P3BFsXM0p
        Oj4asiWdRfpdFnG1JFJY7SpsA8QWjTZTH/pZaOdLVA==
X-Google-Smtp-Source: ABdhPJzoHZ6JdYATaZEbKdDSDIioiFDf0mMLFvpIKkkoAR6R1WkrPrj4MoENxOzeVBe8Uka9jGmUbILQXwUPR05Eark=
X-Received: by 2002:a67:6305:: with SMTP id x5mr1596992vsb.35.1598015056157;
 Fri, 21 Aug 2020 06:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200810080247.47024-1-colin.king@canonical.com>
In-Reply-To: <20200810080247.47024-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 15:03:39 +0200
Message-ID: <CAPDyKFrS0798_ftgBti+hJY3F2UpSFmDkTQcPzRNXtFAALfDVA@mail.gmail.com>
Subject: Re: [PATCH] ms_block: fix spelling mistake "doesn'" -> "doesn't"
To:     Colin King <colin.king@canonical.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 10 Aug 2020 at 10:02, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a debug message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index d9ee8e3dc72d..ad1c6f2db089 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1223,7 +1223,7 @@ static int msb_read_boot_blocks(struct msb_data *msb)
>                 }
>
>                 if (be16_to_cpu(page->header.block_id) != MS_BLOCK_BOOT_ID) {
> -                       dbg("the pba at %d doesn' contain boot block ID", pba);
> +                       dbg("the pba at %d doesn't contain boot block ID", pba);
>                         continue;
>                 }
>
> --
> 2.27.0
>
