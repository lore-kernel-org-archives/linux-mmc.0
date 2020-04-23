Return-Path: <SRS0=Q/yj=6H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A9EC54FCB
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 11:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4E92071C
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 11:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXlhMy4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgDWLRy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726805AbgDWLRx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Apr 2020 07:17:53 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A239FC035495
        for <linux-mmc@vger.kernel.org>; Thu, 23 Apr 2020 04:17:53 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id s5so5273751uad.4
        for <linux-mmc@vger.kernel.org>; Thu, 23 Apr 2020 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7Ez4s7TFcL08+td0Pw/HtNXY/KZWdaJ4sc1TpkUu4I=;
        b=TXlhMy4AhQ0GH0pixgpOUpMgHBsU3h0tAkK/6Rx8vJFz56Uxwhnoqp8zEbB1TQIEgw
         apmUDenzv/6fnRwX4igtvuMyAnkVyAJ602w5wRbbM98UpxkfLo/ncMfBp+HsaHtHpr9w
         hhXFNofBL01cDkDNed4uptRCpPy/WQfooEJVAvSnV9clpK0CmWOynAxeja2PE6cyqD/F
         Ua4fG1IrFBIkAjAof/I6JwxWwQCqPMrWFL07+ylSyRMhyUsIX23DJLWWKPdxpgkM+lYk
         Np5thEbUlOwBnIEYwqK+OagaKbamesqM/QaJ24DLT+XgSL3Sqt/W3WdhCI5+MsuLUckS
         pPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7Ez4s7TFcL08+td0Pw/HtNXY/KZWdaJ4sc1TpkUu4I=;
        b=gcfiRt/DmDjon+ihnsaDrIWbF29fHTnbttoAAgnyPsmkIuKxz6Sctbg1s48W10JOx1
         SVccumlmyaHBuAWJFZyWJHWoHbNuEVkmjQV54sXHcJ1QjgiYAbFDnz9F6QDdaZdTlRD8
         m9vfeEdrd85fgG9fpfaOmY3DjC9mv/F2A47Z6wlZ2uFvrJqHs3B9agXyXbAO/J9SgCWT
         vWww7ilWxxw4z5epPrf/WWRILFTE/wy6YNxJqwyFTiND0oq0j0eW757n0wetmpcPmauI
         uAOA7fV22kXKFBPERFasn9YGZXD2M1bLSote4z3x31/KTA6Fu5JI8eSy3vDxRPvx5IVh
         9LMg==
X-Gm-Message-State: AGi0Pua2OWyLz6mjRn1/3rJf30PBMYFnb9rElNsAV0NSuxUGcNEGoi2c
        2plBCLOyrF5kcFhY+cxO6EIHZm/v2P6JJzPBE3wQ/A==
X-Google-Smtp-Source: APiQypLA9V3XutvG6mVWw3NQ84jZUoAmzeAqOv7CjGYh0u1E0EmomcjbzAXorUdZ+CSlX+3b6nji5sX1kUGklyCk5xg=
X-Received: by 2002:a67:f24b:: with SMTP id y11mr2479677vsm.165.1587640672754;
 Thu, 23 Apr 2020 04:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <1587633319-19835-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1587633319-19835-1-git-send-email-zou_wei@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Apr 2020 13:17:16 +0200
Message-ID: <CAPDyKFogU2BT1vmcovrGvNEOtS+cxWwM09foMfN3bOPXEhhT3g@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: core: Use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
To:     Zou Wei <zou_wei@huawei.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Apr 2020 at 11:09, Zou Wei <zou_wei@huawei.com> wrote:
>
> Fixes coccicheck warning:
>
> drivers/mmc/core/debugfs.c:222:0-23: WARNING: mmc_clock_fops should be
> defined with DEFINE_DEBUGFS_ATTRIBUTE
>
> Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
> for debugfs files
>
> Fixes: 703aae3d09a4b ("mmc: add a file to debugfs for changing host clock at runtime")
> Fixes: a04c50aaa916f ("mmc: core: no need to check return value of debugfs_create functions")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/mmc/core/debugfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 09e0c76..9ec84c8 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -219,7 +219,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
>         return 0;
>  }
>
> -DEFINE_SIMPLE_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
> +DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>         "%llu\n");
>
>  void mmc_add_host_debugfs(struct mmc_host *host)
> @@ -232,8 +232,8 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>         debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
>         debugfs_create_x32("caps", S_IRUSR, root, &host->caps);
>         debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2);
> -       debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
> -                           &mmc_clock_fops);
> +       debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
> +                                  &mmc_clock_fops);

Apologize for my ignorance, but why convert to the *_unsafe option for
this one, but not for the others?

[...]

Kind regards
Uffe
