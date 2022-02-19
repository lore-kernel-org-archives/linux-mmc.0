Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE62EC433EF
	for <linux-mmc@archiver.kernel.org>; Sat, 19 Feb 2022 00:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiBSAec (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Feb 2022 19:34:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240332AbiBSAeb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2022 19:34:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A436177E76
        for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2022 16:34:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y16so1778541pjt.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2022 16:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=N2mb/fnXiK+55Vayu1WQaDGcQm6fHIlg0WJV5p4N/HY=;
        b=vhpvpYAs72r/uoSL/BUaAusH6XKA4rAULu6qjHWYo27jOy1C6kM9j5tc1Az/Esg0n+
         FIOoL1tgzkQ9bIQz2F3q90+Bps0EPIorHHEdHbZIVqHLPyPSB73rdhlXru65MTfByH59
         Newd+wujsKTxWviQyz6zZe1F9pjl4rRdCaGC92BJL9pgI6PbUqQjZx/sgR1F83Px1HYs
         UUdtOicItV1IdSw8I9tgzri27OuyH8j/3J+hd8TKLNaRGWCfo+74ClOd90Qrmng3KlOd
         b2PRktm+Sm6qOC1/T9BNb9qvzmS8jeA4BSScIvYwNokGxI37wp3LhcFPjWjivHq3pn4V
         Sudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=N2mb/fnXiK+55Vayu1WQaDGcQm6fHIlg0WJV5p4N/HY=;
        b=S63RvHr+JCXXClge+Py2J7UAb/4eWQGPItsavsszBvPJQuLIo+zArsTugzGORSmeph
         MUSbPwS2TPfJR+8yrgnhhr8spWNP3fzR4corbn6AUt83kdHWgfZcdiJcKeq/NIMSMZ5E
         nb8fXxULOoA71c4SsfNrDjmwMDPV/eNN9su62nvBwsfXiCmb/YEKCF2a+Uv4fKaobyPK
         lwz+R7RQ4c6DdmIny4dYeNeC4ubbLaqpNxq+ZsS3mR/X54cq2+4UbymophK8HUUjo237
         S9rmXUu1O1bWZwpOjwSJ/E78UItnjVVWyeWP0nsp6g6r/K87GdBMdKUYKLn382Fd9x/q
         +40w==
X-Gm-Message-State: AOAM530utyS8GpCsdVgy0ZkybH+qvPLTEDew4aq7IcYc2StORVBPgAP7
        f+PwjIRObV+2qPZHowLUo1AkjA==
X-Google-Smtp-Source: ABdhPJwVYQwlCngXM8fnMUumYkNGCOKPefj15RGXF11ZsFIDjKByrvfXXFy68PJeKQKdfkbdD+ttrA==
X-Received: by 2002:a17:902:d683:b0:14c:c0a9:34f3 with SMTP id v3-20020a170902d68300b0014cc0a934f3mr9482203ply.109.1645230853581;
        Fri, 18 Feb 2022 16:34:13 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id h16sm4149298pfh.40.2022.02.18.16.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:34:13 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rong Chen <rong.chen@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        1131046452@qq.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     45581586@qq.com, Rong Chen <rong.chen@amlogic.com>
Subject: Re: [PATCH v2] mmc: meson: Fix usage of meson_mmc_post_req()
In-Reply-To: <20220216124239.4007667-1-rong.chen@amlogic.com>
References: <20220216124239.4007667-1-rong.chen@amlogic.com>
Date:   Fri, 18 Feb 2022 16:34:12 -0800
Message-ID: <7hiltbitiz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Rong Chen <rong.chen@amlogic.com> writes:

> Currently meson_mmc_post_req() is called in meson_mmc_request() right
> after meson_mmc_start_cmd(). This could lead to DMA unmapping before the request
> is actually finished.
>
> To fix, don't call meson_mmc_post_req() until meson_mmc_request_done().
>
> Signed-off-by: Rong Chen <rong.chen@amlogic.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
