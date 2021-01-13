Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AC9C4332D
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18871233A2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbhAML0w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbhAML0w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:26:52 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CD1C0617A4
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:42 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id x26so920215vsq.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbijAPIh7wUd9rih0Pfd0xER1/kaObwyFAEUGZbA5yM=;
        b=ApmP4kmAyOFCccOnoIKag8QSTMl1PYvCqUFnbJPgqRFs4/mTtoCoIY8IvRwGgqxIl9
         j2TimUVO6mUPr08mFW7fNES7xxZ1oGMN4KITlG5hBGVX64k0eU79NcJ60nlK0UfrHmcH
         RV9chFFh6XSyfIUU8Y9oSFTBRO189YWkwIPIgO5mLnZ+P8REtHQ0Doa/+updnJfzcQMf
         CATzMP5y9jq2fWWq7zFzm17Vlult50m2UTzs+q1/pJYh1JFsleCAQ/naGDZySfa+dlhH
         0kt1/S1Aj4FVdCs6pV4uTIBNuia1SHYNZ7Fdtp6Y/c/jGf1yABH1XMuoGVYyEZR1kv3E
         aQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbijAPIh7wUd9rih0Pfd0xER1/kaObwyFAEUGZbA5yM=;
        b=EjwP7Nku0tjnqYHfRnv/3h67sCxLF85Sjy/yo9DtF37WUwAlU2q0qSHFP4EgCLpFUL
         tMGVksi3NRZ0+ZpoJ/QU+BOcJVrnY6RRkfrrZtBfnW3JSTaFCrAw29uXQPuk0GORUKiw
         M0wl83ObRctsEiRPeTU8NaPWiq4orA87X/NLDfDgOJKYivWWd/MKvF8B7P9pAOPV85WH
         67S5Bb4Z0MOGaNiPyxUTPhZKjqA4t5mjtZdh5xgsmXW+S/ZmyJZ14OotTPY0ncbJJzj6
         y8uzwudJjL+vCGcDrLL/dsFooKc0W7jmL8f+ZpQ117ebwXcsTJJKn3GchIC1SUYNiSIs
         23Qw==
X-Gm-Message-State: AOAM531zTkoGQOjipzuU7pg3LLI9wA7pz8QTlAFdyUcvVNci6/R5O/kW
        q0hZpno19cu8kVXuYf3+pZXX9sJlw4G56DNFG1wC3Boz9RN0XQ==
X-Google-Smtp-Source: ABdhPJwkWIk8f4E6qjFwt0NDTDGUbLNLUXJu0ZcGdugcXBkZ23N6CGZgdhA/olfnRsJWRTL4YRWQ7sx0+5AGBL+OERk=
X-Received: by 2002:a67:70c6:: with SMTP id l189mr1444580vsc.34.1610537141487;
 Wed, 13 Jan 2021 03:25:41 -0800 (PST)
MIME-Version: 1.0
References: <1608708622-29668-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1608708622-29668-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:04 +0100
Message-ID: <CAPDyKFojeah1a-DjCacv5R=hxXUTQOqbKtKd2n51ZaHfQ6P3Mw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: host: tmio/renesas_sdhi: Add data timeout error detection
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Dec 2020 at 08:30, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> This patch series is based on the mmc.git / next branch. The patch 1/2
> is a updated patch from Wolfram-san submitted [1]. And, I talked
> him locally, I can write this Reviewed-by and Tested-by instead of
> SoB. The patch 2/2 is a new patch for retuning a card when
> the host controller detects cmd/data timeout. And, I got Wolfram-san's
> Reviewed-by locally.
>
> Note that I don't include Hayakawa-san's email account which is
> the author of the patch 1/2 in To/CC because he left from Renesas
> now.
>
> [1]
> https://lore.kernel.org/linux-mmc/20201120150647.123237-3-wsa+renesas@sang-engineering.com/
>
> Masaharu Hayakawa (1):
>   mmc: tmio: Add data timeout error detection
>
> Yoshihiro Shimoda (1):
>   mmc: host: renesas_sdhi: Add a condition of cmd/data timeout for
>     retune
>
>  drivers/mmc/host/renesas_sdhi_core.c | 16 +++++++++++++---
>  drivers/mmc/host/tmio_mmc.h          |  2 +-
>  drivers/mmc/host/tmio_mmc_core.c     |  8 +++++---
>  3 files changed, 19 insertions(+), 7 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
