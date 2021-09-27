Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E127BC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 11:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25D660F6C
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 11:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhI0L5b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhI0L5a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 07:57:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E1C061575
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 04:55:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z24so77114834lfu.13
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 04:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/lcZPPstLYfzMiVjK/nw1EyEA3P4zrR6HIgxUCYBXQM=;
        b=AvNkrR9THFWOlO6MnVKJYibfw3a9W9kDG6BUTUplgvXK7Rjs6VZ8YaGVHb7/jhfNUs
         hOC/pcsw3hdWAVeI4zt39Gbb0b6axDus658Z2RAykk/Ze9BKTT+sVJsOABpchJgjA2Jc
         bg+X3YsMyIP87TBnT2clETJp3Dh7V4a4WatAwB3/Kv/pC96eHem+kP5r2EhGSiOGXKvx
         bdTTeNJZ2uT6CdG2bm55OnjaGDYicFnskBdAJyM4Z26zPT1HmJ36DULSK9mzPdyQ4oGQ
         Nizkj55lA1X5JWedWViEoKTcEZqaXSmJ4XzPMvIjwlYtJvsOWLq2nds2UyXS2xy0ejE+
         /dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/lcZPPstLYfzMiVjK/nw1EyEA3P4zrR6HIgxUCYBXQM=;
        b=YTRHgzMF8vETDOZF6d2lLPnMLUmhQmwjLq4TquounvjzTv/5gu07BPkWHA9MoT230W
         PJaUjsPPfQ5G5LWd1oUgP7VocHmWcQETt/6n8xG/FAWyZIyJXX+7Y32AA1t6XPdPlntV
         GSql+SHeeeqLAFQyNVD7Bytx79UJ7/wTMDSxFyLGSleJZwETzGJuTqfQa4wNt7UOMQTI
         oFQR3fPYk4dwHQsdJJShirP+v4NqRFIurfi3gtNApAZb+oiWXbHUb5GxcnLIcJ5hF3Xf
         1F2FtlvfrZ5rA6EDL/OG2T7I7UmIcHeOSZ/yzDvQ8iouRMRhiNHkX4B5qdG0Y+jSmPMJ
         rs7A==
X-Gm-Message-State: AOAM531bcLi6JRQHa0tPtcFdweH0uovJePuPsSCL5zc8sButebOTpWxG
        8HAiXg2XsA/6e6pzqzHK7FHlKhD6KEEa631CIkBxTg==
X-Google-Smtp-Source: ABdhPJxonBYWlx/fjTb88u6HATZ8O3nNSKkpYe7g2IweDebthbedKHdB89ESe5cfcyTRam6q9Ug4MFdvjBsvE7baYHU=
X-Received: by 2002:a05:651c:2006:: with SMTP id s6mr28679170ljo.4.1632743751131;
 Mon, 27 Sep 2021 04:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210826082107.47299-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUXc0oSCXJ-5QmPJz0VkX1Aib+ZAv8K2LN_fT1+5mocqw@mail.gmail.com>
 <YSelsjPyswWCr7Nu@shikoro> <CAPDyKFp2Ut4UJoRXPD4t+k1+ZfmT-CQZ3obNA_iPF6OA-t+T7g@mail.gmail.com>
 <YVF5ZskkvlI40pkg@shikoro>
In-Reply-To: <YVF5ZskkvlI40pkg@shikoro>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Sep 2021 13:55:14 +0200
Message-ID: <CAPDyKFqBWGgsVb8r_n-rR4WSStpEkpExVi_Lizds_S724zGiYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: fix regression with hard reset on old SDHIs
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 Sept 2021 at 09:57, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > I have applied it for fixes (v5.15) and added a stable tag, hope that's okay.
>
> Your 'fixes' branch is still in -next only. Could you send it to Linus,
> please?

Yes, it was busy last week. I will send a pull request later today/evening.

Kind regards
Uffe
