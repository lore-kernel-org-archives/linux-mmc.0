Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C36FEB64D0
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 14:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242774AbjFMOZw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbjFMOZv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 10:25:51 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D986E1B2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 07:25:47 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bc7ebb912dcso3019683276.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686666347; x=1689258347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X94bKUv1M/Inu/XN1ifqHmKL/+Q4WPqhv8WNjOapxf0=;
        b=OwBzeUYJFPZNoWS/K7NNXfa4wHYGTeLHpzbYzACsXX411U6MsVaA2d+USzjcPRrD+U
         nVeUiqgWgIvGA116XqyHDaVy+rnUnER20hUpmqxg2X3/cMBlogilvT5NQ3OF3qr2IGg0
         m2K9yi0mvoEsQ9ddAhQH6ESEUNYBtYY8ztVKBxmlp7E3tS7qNb39Wl8bauBrrAojY3i9
         6d4J+WtIsYGh+mxxH2/TSSMgexlpZk+f2BrkSXVOX/Febwk10dd1gi1CDRSZGy+59wh6
         kjvsaBYzpGfSP9quYmnmvQ+vxO2lKWiRLh8iM7be5bSZZvsVhIonPRjM3Y4sqihwYG1n
         hbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666347; x=1689258347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X94bKUv1M/Inu/XN1ifqHmKL/+Q4WPqhv8WNjOapxf0=;
        b=axZAfRRZoqXyf9LfBz+uu06fSZm+sf62NUgqa4ku3z8eN8ZJGZ4+rIJgL4lihZnQ2c
         woDNhYr8vaKzDuSYodhOg1IgAOAN6oEVwb1ctYCkpZUj/+fo2KTjmDNg/5bRYRXmJKma
         7v69jnQm/Wf52yzLXS0OpJ8LbA2WXFFCM3JMjJu9CsPhvf3Gjg+QZ9ZItgM+7uuyDycO
         97PIol35IAxowUV5eRio4tOpQB9UHwN4RqjNsbu7vBSCVSwgCsxzTmU+gecZPNnJMiNA
         TVRT6lPdv/6Lme5rFSg4tCKPflTrESkcBusIhlMvrT7gQ8wazmMiz3ZoI4abx7TMBRIB
         7bHA==
X-Gm-Message-State: AC+VfDwGO71E9uU6DNY+JBF5OUh+gG6kvx+fIch50tLdd7DTWAKp+qPr
        prCwjAiEH+dOzaZKDbxTuT7C8YTUPCko9K+tbZmEddvIjzveVzF+
X-Google-Smtp-Source: ACHHUZ4nfn5fXKPLkVPdIFaBTff3OnOuc93W0l6Vm+OqbL1rQradCBXVg8Ejhu4aWla7TnbyV+pim/v5TGSRCEP8xuA=
X-Received: by 2002:a25:8305:0:b0:b99:9335:87f6 with SMTP id
 s5-20020a258305000000b00b99933587f6mr1830093ybk.27.1686666346927; Tue, 13 Jun
 2023 07:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202148.71107-1-dennis@kernel.org>
In-Reply-To: <20230329202148.71107-1-dennis@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 13 Jun 2023 16:25:11 +0200
Message-ID: <CAPDyKFoKmWAC0V_t7WL-5OauxS-iiLxW+KhqC6RzJXD_szjPCA@mail.gmail.com>
Subject: Re: [PATCH] mmc: inline the first mmc_scan() on mmc_start_host()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 29 Mar 2023 at 22:21, Dennis Zhou <dennis@kernel.org> wrote:
>
> When using dm-verity with a data partition on an emmc device, dm-verity
> races with the discovery of attached emmc devices. This is because mmc's
> probing code sets up the host data structure then a work item is
> scheduled to do discovery afterwards. To prevent this race on init,
> let's inline the first call to detection, __mm_scan(), and let
> subsequent detect calls be handled via the workqueue.
>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Along with the patch for the mmci driver, this one applied too, for
next, thanks!

Note also that I took the liberty to clarify the commit message a bit.

Moreover, if we want this to be applied for stable kernels, we need to
manage that separately, as then the mmci patch is needed too. Please
ping if you need some pointers in regards to this.

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 368f10405e13..c0fdc438c882 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
>  }
>  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
>
> -void mmc_rescan(struct work_struct *work)
> +void __mmc_rescan(struct mmc_host *host)
>  {
> -       struct mmc_host *host =
> -               container_of(work, struct mmc_host, detect.work);
>         int i;
>
>         if (host->rescan_disable)
> @@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
>                 mmc_schedule_delayed_work(&host->detect, HZ);
>  }
>
> +void mmc_rescan(struct work_struct *work)
> +{
> +       struct mmc_host *host =
> +               container_of(work, struct mmc_host, detect.work);
> +
> +       __mmc_rescan(host);
> +}
> +
>  void mmc_start_host(struct mmc_host *host)
>  {
>         host->f_init = max(min(freqs[0], host->f_max), host->f_min);
> @@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
>         }
>
>         mmc_gpiod_request_cd_irq(host);
> -       _mmc_detect_change(host, 0, false);
> +       host->detect_change = 1;
> +       __mmc_rescan(host);
>  }
>
>  void __mmc_stop_host(struct mmc_host *host)
> --
> 2.40.0
>
