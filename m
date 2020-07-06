Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D5BC433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1472520715
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAf3TrUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgGFOtu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgGFOtt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 10:49:49 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49975C061794
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2020 07:49:49 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id q15so11966631uap.4
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2020 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJansEGmPdeGOGXnqzYZzxjZ76Z/vpZoEqZEVdL7ZJw=;
        b=jAf3TrUasdW4EPNpi+PhMii3nsGn4wqlWpuseKVDJQ+tR69z9Bja0hwcuPuE4GxKok
         HZLd2OpbLRn2p+uWbmIIajaMBEXykLH3KdhV4uGMUgzy6wLDS421i/Cphfn9OhH3PC2+
         64Ep9+YYeFK/g2JgQscYuu/FexYq9D+3nfnv2zn8KTQ33S6TM8guDdOy+AwEYP08wtrS
         aNkq3DYht/YS1K9+dpvUpF/6g0/lSLNw/9BeiFBFiSJX7iM/W/LJi+Ag8OyZUBSJ8lNI
         kkPN+M6tUNY+Gv55A9RKniDz+3bmZ3BWPJlXZoZFQD2kfOy4xgmDcXWkrBERoNv6r82T
         EaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJansEGmPdeGOGXnqzYZzxjZ76Z/vpZoEqZEVdL7ZJw=;
        b=QrNR7QnZWk3bq6E5uVzH02yaYEwoJS3PYsngS8svSp1V3CWhGxib4XHjUI3JthVgRI
         b/cd9K0k0QFpACxZkjkuK7hqL/5UyUgDIcZn+7B4jdme4YSJUG6FA2yhM8GJ3YiOadJW
         yw1Ugn+RwjbzlLxKq70voJov8I3R3MrSdqkz2sZA6CNEHgEumt2mQoV3ywAasZcvJhge
         0OqbJtkOEBM0IU4+M3FfL44UI1n1wCAEIR/hCqMWeSZslMobMelcewzjEe3vEa4RQJzG
         XNvXNQGMB56LTNBoGI4DTjckrgwgY4HlcTrxEFWYOQqadAm+1h+8K5EtdnOZwdK2O2yq
         Y2cw==
X-Gm-Message-State: AOAM530nBHLA6HyD6Dks6AJh7qs09K5zivTqCLEQG4LtkLXlyGpASiWD
        Dy4CT9ZsOHlY/EXtNrGs2/m6jneeapXczT+rN8syaQ==
X-Google-Smtp-Source: ABdhPJy72u3CpM6RLtUQ6iqGATk2GoTxo0fagGN1UKNvQ4nHU/ra/+dEuPRZdsJK6pqbi+duJvZ/U9n4kKqsB9qmIQA=
X-Received: by 2002:ab0:4e98:: with SMTP id l24mr3487632uah.15.1594046988524;
 Mon, 06 Jul 2020 07:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200623133347.4598-1-akshu.agrawal@amd.com>
In-Reply-To: <20200623133347.4598-1-akshu.agrawal@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:49:11 +0200
Message-ID: <CAPDyKFrV9vn1jFEzCWZ-5aDHSyTz9+m9MM_CWLp9iA86YCGTwg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: For amd device set driver type as MMC_SET_DRIVER_TYPE_A
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     rrangel@google.com,
        "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Jun 2020 at 15:34, Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>
> HS400/HS200/eMMC HS doesn't have Preset Value register.
> Hence, sdhci_set_ios function overrides the value set by fmw to
> SDHCI_CTRL_DRV_TYPE_B.
> This patch sets drv_type to MMC_SET_DRIVER_TYPE_A
> so that host_control2 register gets updated with the required
> strength value.
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index d8b76cb8698a..48ecbd0b180d 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -542,6 +542,7 @@ static int amd_select_drive_strength(struct mmc_card *card,
>                                      unsigned int max_dtr, int host_drv,
>                                      int card_drv, int *drv_type)
>  {
> +       *drv_type = MMC_SET_DRIVER_TYPE_A;
>         return MMC_SET_DRIVER_TYPE_A;
>  }
>
> --
> 2.20.1
>
