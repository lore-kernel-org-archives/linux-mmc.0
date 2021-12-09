Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511FEC433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Dec 2021 12:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhLINAi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Dec 2021 08:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhLINAi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Dec 2021 08:00:38 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC88C0617A1
        for <linux-mmc@vger.kernel.org>; Thu,  9 Dec 2021 04:57:04 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id k23so8905267lje.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Dec 2021 04:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0BtcPSuCBZNOYhnI2qnvhboGSIsrlgHM+V1nqjUds8=;
        b=Z1w9f9FMAhEW6XRAId0RysIH65MLTGwdQfBavHvTgTg5bWdH1lTDU7oX/vHAqhyDEu
         PgWrjBkNG3pIXb8JXze022m1Gk0Y/rQ0QNoEPjC7ENFsAqi71tG2IEudmW1taqa+t4Tz
         wiWRaoQvXHM1de8xqer00XgTu/TIuw8fpSerBQyJZftJTGnrdi6iy81BcZYhrg/NbPgj
         v4MsxL5rafq/lmCQodhOfTBYZwKHRhhw2/ftXaWGlCuTm3dOAcF+vJLdKm/CAsyhOakO
         iBDfo8ysC/Y93/62ouBsydPSgu04uTIEfHYO7JM5Vpnyr1Jd+5xlKhP6vkwqIv01dd3W
         an6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0BtcPSuCBZNOYhnI2qnvhboGSIsrlgHM+V1nqjUds8=;
        b=Di7CF2eyPq2D6Iwr9OpXTjlTNKnvXyLx4qci1CbjThrlonZUwcIN0trTzVxz8rueYb
         VrRcxDiSWnTfneeJsna9el5p1hyENAuFY0O8WxrpTxV9iKYif6Vxa1nIPlgzkTd05Mv3
         f7+Ky31MGNZWs+vElMuLSsLubhifdb157M1O28ukCtk7pgDU6UoRULEYepNXjtcFtKPJ
         vTY5HgdQ9GDzVIER+gTQS2V+UyiRDgrQhW/cGb6uC53ndNPXOJq2c3uDwKojs3UALttz
         3lNhzRPBc9xt5tByoqMevMamnymRe1i51NIt4coKHer5yxpwFLRLrLpECyrVaYH0yYjm
         rs9w==
X-Gm-Message-State: AOAM531xAZBKEjKH3GcsCViUWZng8ZNevK6fVs675ziv9t/eapF7p/RV
        ifV9wZVpUaYJ6CJveOwslqMlcKzhQ04siNqfcuVamQ==
X-Google-Smtp-Source: ABdhPJxFeplZpEbkpi36puU+ZoePzLXj3VK/XGWK4+73QwTS9X8sRxsML8YFI4+OA1EGwOAE6kv11IKAxaf8gFR8H5Y=
X-Received: by 2002:a2e:a22a:: with SMTP id i10mr6246609ljm.16.1639054622591;
 Thu, 09 Dec 2021 04:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20211209120157.9552-1-sensor1010@163.com>
In-Reply-To: <20211209120157.9552-1-sensor1010@163.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Dec 2021 13:56:26 +0100
Message-ID: <CAPDyKFqRsKAo7YtxQxmieMcWRQpxs1vMkFZ9VXWocpH9xneXPw@mail.gmail.com>
Subject: Re: [PATCH] drivers/mmc/core/bus: Remove redundant driver match function
To:     lizhe <sensor1010@163.com>
Cc:     u.kleine-koenig@pengutronix.de,
        srinivas.pandruvada@linux.intel.com, pali@kernel.org,
        TheSven73@gmail.com, lznuaa@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 9 Dec 2021 at 13:02, lizhe <sensor1010@163.com> wrote:
>
> If there is no driver match function, the driver core assumes
> that each candidate pair (driver, device) matches. See function
> driver_match_device().
>
> Drop the mmc bus's match function that always returned 1 and
> so implements the same behaviour as when there is no match
> function.
>
> Signed-off-by: lizhe <sensor1010@163.com>

I have already applied your previous version. Or is there a change in
this version?

Future wise, please bump the version number between each submission
and highlight what you have changed. See
Documentation/SubmittingPatches.

Kind regards
Uffe


> ---
>  drivers/mmc/core/bus.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index f6b7a9c5bbff..096ae624be9a 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -53,16 +53,6 @@ static struct attribute *mmc_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(mmc_dev);
>
> -/*
> - * This currently matches any MMC driver to any MMC card - drivers
> - * themselves make the decision whether to drive this card in their
> - * probe method.
> - */
> -static int mmc_bus_match(struct device *dev, struct device_driver *drv)
> -{
> -       return 1;
> -}
> -
>  static int
>  mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> @@ -226,7 +216,6 @@ static const struct dev_pm_ops mmc_bus_pm_ops = {
>  static struct bus_type mmc_bus_type = {
>         .name           = "mmc",
>         .dev_groups     = mmc_dev_groups,
> -       .match          = mmc_bus_match,
>         .uevent         = mmc_bus_uevent,
>         .probe          = mmc_bus_probe,
>         .remove         = mmc_bus_remove,
> --
> 2.25.1
>
>
