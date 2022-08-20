Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0140C32772
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Aug 2022 17:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiHTR0F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Aug 2022 13:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346290AbiHTR0E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2022 13:26:04 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A914DB55;
        Sat, 20 Aug 2022 10:26:03 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-333b049f231so195651867b3.1;
        Sat, 20 Aug 2022 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Vcm63p9Ndo8w0eqrJk86Vp4em1l9XiIXzzzPibiG9xc=;
        b=mpO5iswODoCzpwRmKE8RAg0r6YuSpgtO6RrGKttfrcnl2yfGAn+WnO5htJDrAie0fy
         giQNwDD2rJTPB8wsYBQ8+zSgJ+UIb0wTAGa5GKeUb2wVeH9ugeCbDvfstVUpTDEgq09l
         rjz03HGgjSIXYx1mXweYRTE5m4pD3YOdAohWIjU/9aMBXAUf5CdtoMgvgNnQHIogxVKp
         l+FcpM8nsYHV7xKpf8m8mLhtf5nY7ly5ACKqMNkMEugeCaSFfAv1duxFAIBwgj9Q2/21
         ormwuwjg84FSCn4CJ2jvKht94BfxOBUKvbSNIRv8XKLh7DGo5yeS6sjf/bBHjFbEJDI6
         mCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Vcm63p9Ndo8w0eqrJk86Vp4em1l9XiIXzzzPibiG9xc=;
        b=umc36A7/0VKGqmDFij0G0g2/0iQ7VszXBIU39rfSg9N22iK4XvK46LvKyzSsFmdGoK
         ZK70SI3L8ShhibZqlvYTCGPWmhoC5NHc9Y+Z0YeaMMiik/qR2No4CyyknnLBx0OiNbx2
         ITWvHEqVRyuiUl58LhnNMV6cgVNQqu3n1ONvn4piAPDXyxmXsYGYxn5QD8+fMhRDEkRF
         UluxAxZrlhmqzXJzr5j1arkWKggY4VKiayOFbKsIzhH+wGR/yERiDmN3rBzJFl+c3OL6
         PawjS/rU8E9ZjSqoSwXYa0h9O4u53HAe+B4+Pj0IoyMl/x8xKHPq+fZObQYp6mLaM7Qj
         cRrA==
X-Gm-Message-State: ACgBeo3jpskrHc/hiX5gj8YrrGbdEMlszuaeS+k4SLDNcVHBsx3fmpR/
        1Jevx3NpB8cnDIPl3DBPvoV0NKPIOHFw9+AOGmOBMaa6XE8=
X-Google-Smtp-Source: AA6agR5TRgD/FnBNXaCrUTNJvvi3JQMLm90svy6f13lPPU4q6eUuunzGxFVgcIGvJ4uKIRiM8uS46Cmd3Px6UfZAn1o=
X-Received: by 2002:a81:83c5:0:b0:334:a89b:1e5d with SMTP id
 t188-20020a8183c5000000b00334a89b1e5dmr12036745ywf.178.1661016362743; Sat, 20
 Aug 2022 10:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-18-jinpu.wang@ionos.com>
In-Reply-To: <20220819060801.10443-18-jinpu.wang@ionos.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 20 Aug 2022 19:25:52 +0200
Message-ID: <CAFBinCCbjF_mkV+EaOtC0g_YbtX9TzBEN5fRJ_MiPaie5hxCwQ@mail.gmail.com>
Subject: Re: [PATCH v1 17/19] mmc: meson-mx-sdhc: Fix error check for dma_map_sg
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Jack,

first of all: thank you for this patch!

On Fri, Aug 19, 2022 at 8:08 AM Jack Wang <jinpu.wang@ionos.com> wrote:
[...]
> @@ -388,7 +388,7 @@ static int meson_mx_sdhc_map_dma(struct mmc_host *mmc, struct mmc_request *mrq)
>
>         dma_len = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
Does it also make sense to change the type of the dma_len variable
from (signed) int to "unsigned int" (a few lines above)?


Best regards,
Martin
