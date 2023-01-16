Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C12EC46467
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 01:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjAPBtB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 15 Jan 2023 20:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjAPBsz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2023 20:48:55 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234E04498
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2023 17:48:50 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id i188so27674260vsi.8
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2023 17:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDMQAc+InVAe90as5YSmu9YwvDXhMQZbvO4pT+l78qI=;
        b=bgq9QR02Dyf/F5ogkvDHTqCEkFBjQyuun1RhW7zWXH/YWW15PFSZnv8ZlkA6KaMe2N
         +L2LXSBfnOZhKQ7I0doWjhhxo+nq0XoPMtnYUBAeggtva1C5kqQugPR4oFoCU8WKrkXt
         yjZXtjpcOqpVazcrRCAeI5pV0WKPjs3wdY3ni+cs6fkwjCi4+3oQ16NCejSfTOfwBA++
         yUSt2ihBFUv6k1uviub6/pbqTqzmkqr0Hnrksr7GFms7hjqXtEmYgL8OHcXW91rLR/73
         vC/WjLZr7EJoATmIc6xg7f51TpZV/jp+cb8VmfXrWHwrkm/EfgCOLZFTS1SJGQLN9eCN
         8gTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDMQAc+InVAe90as5YSmu9YwvDXhMQZbvO4pT+l78qI=;
        b=1CzXOKudlGibXaHyAzYuM00U6/sALOClaoB8IqVRHQqUPqYxHLAkdZTId6fNiMeJwW
         NCNDrBnKaLF4IVG+n5UpTsfEjmFZehspCzCgpS0R4hi1/GJfdAyLtAemiOJyCmimB2Le
         hAm/YYC+0nNUVZQA/SIggbWDPCauowsxNg8YXb3Ekx8OZBLqyhLBbehDawYHfB5dHbSY
         6sw/vfgbLu5JQJ3hkU4Chg3aPrDoENcoB9usiI811TtMoNhw++t8kn9/nvkjV/jHE7JB
         8HOQPQdWrdXk7KZTl04QtLa2wvx8xa/ddwM9/3QlTCjcR2tBHFD6M7BV7pV0OEe2VjTo
         dmQg==
X-Gm-Message-State: AFqh2kpGvg6LFmtsdqiVSsxkmSxJeFCADlnmm0HETClyLjG/g/pWsmsb
        wuEpKAflfwD4ODg82ZztEDeYhm4gktfvSUt8zIU=
X-Google-Smtp-Source: AMrXdXvdqyHYMyITXs/PgCYIKVfj0i+mphMwbMY/tlbQBy0SucIvXmi5dQngdHfRBgAY9yzL8oG1BUyZF/mj22VosvY=
X-Received: by 2002:a67:ae06:0:b0:3d1:d6e2:41c9 with SMTP id
 x6-20020a67ae06000000b003d1d6e241c9mr1313261vse.71.1673833729236; Sun, 15 Jan
 2023 17:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20230113110011.129835-1-adrian.hunter@intel.com> <20230113110011.129835-4-adrian.hunter@intel.com>
In-Reply-To: <20230113110011.129835-4-adrian.hunter@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 16 Jan 2023 09:48:13 +0800
Message-ID: <CAAfSe-urYx9s9Mmbg_3DtyYyTGQG0fT87dzeYCZ-_HjyGs2x1g@mail.gmail.com>
Subject: Re: [PATCH 3/6] mmc: sdhci-sprd: Replace SDHCI_QUIRK_MISSING_CAPS
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 13 Jan 2023 at 19:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> SDHCI_QUIRK_MISSING_CAPS is not needed because sdhci_read_caps() can be
> called instead.
>
> In preparation to get rid of SDHCI_QUIRK_MISSING_CAPS, replace
> SDHCI_QUIRK_MISSING_CAPS with sdhci_read_caps().
>
> __sdhci_read_caps() is also called from sdhci_setup_host() via
> sdhci_read_caps(), however only the first call to __sdhci_read_caps() does
> anything because after that host->read_caps has been set to true.
>
> Note, __sdhci_read_caps() does more than just set host->caps, such as do a
> reset, so calling __sdhci_read_caps() earlier could have unforeseen
> side-effects. However the code flow has been reviewed with that in mind.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan


> ---
>  drivers/mmc/host/sdhci-sprd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 525f979e2a97..7f4ee2e12735 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -553,8 +553,7 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
>
>  static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
>         .quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> -                 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> -                 SDHCI_QUIRK_MISSING_CAPS,
> +                 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
>         .quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
>                    SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
>                    SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> @@ -671,8 +670,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>          * will allow these modes to be specified only by device
>          * tree properties through mmc_of_parse().
>          */
> -       host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> -       host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> +       sdhci_read_caps(host);
>         host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
>                          SDHCI_SUPPORT_DDR50);
>
> --
> 2.34.1
>
