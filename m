Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BEFC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 11:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEAD6108F
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 11:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhKOLk5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 06:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhKOLkz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 06:40:55 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109E3C061746;
        Mon, 15 Nov 2021 03:37:58 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id n66so34075928oia.9;
        Mon, 15 Nov 2021 03:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0MaBm2tCNOzB7pxkxpAcyTPKCZcMQtr/VIW7MJsUgQ=;
        b=qTz/EZkX979C2y62JUPQuqDRKsfB3tWivmXImqgc5AxOejpWrusp6Tf/0BhalJZ83j
         bHSSje7oWXVZMP8qK5xYvRxJdpXZ28FPevlfqgm59grjJVZsrmBkKfQrKov/7o6VGd9+
         Vb3f+6den9moXBzjoerkc20XUDz1VDJuLGY178NXxrQi1M2h78+j945ZLHPrP2jGBzUU
         tPtx0wXoOIClo2xAkaX/JhyO/SCbcUkkKmpUzWS+ue6ikTQ7MaomiijiN6nh3Y2yJ3+W
         1TvXaH4jaZ669TF8D2xyK4WF+McS2j6zGLILvnVwT/wYjbeU0DXVIv+tz8xKvNQgM1MY
         E50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0MaBm2tCNOzB7pxkxpAcyTPKCZcMQtr/VIW7MJsUgQ=;
        b=J0BRSoq6IpOQ6+WCHfazsEXZBAPQ98t3CyGqyIeI5PIg8IO08T4DcYN67ZHfWm65wc
         SCYtDDYW2tUec0YFno3C9k4pQE+Q4r2lbLzA2s7Qw5D+/rVPaDjJm1Ne+kCjmyGbeO7O
         Npch3710tGq2uCVoGgAdjcyYMcAsVG/pzDeXhyM0PYgSb6zEBEkZ/HuTlnD0LN7m0dJx
         GcsYj23/mZMUO5aVxdMVyfapSkoFHDbqgStgBZx06/A4YD5csLdySlyajpiDCc54Iy3w
         HBiauZvyj8SOf2VVB9KtehgQYqSa6vaUPLY1p1d0N9+d0NVrPEsrczPsmyrt/2VfZx2o
         TK0g==
X-Gm-Message-State: AOAM530Y84hkNeaQF3yJyQq4ibj7Ou1PvLm38p3XPR+sdalv7SHoy4+N
        kfB2xgiXR+yGIuqvdG/yZCgI4Ed4D/KS7SVLVAh1OX77hoXp7Q==
X-Google-Smtp-Source: ABdhPJxCkoOTLSfk6A9QBUZwpfU4iWuHy9PNDHr4sst+/yML5Gwy6pBqNPujWetD8QFsLI5kYqMAgyIsZlc0negOeW4=
X-Received: by 2002:a05:6808:d54:: with SMTP id w20mr31698921oik.91.1636976277388;
 Mon, 15 Nov 2021 03:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20211114204331.39555-1-huobean@gmail.com> <20211114204331.39555-2-huobean@gmail.com>
 <CAHP4M8VAhcTysoBRfNQSiN3fTY6GK9fTz5+hzvzoEuNfC+9CHQ@mail.gmail.com> <937514c9cbb3dd86a659d3fff11fb0f6fa3de8e9.camel@gmail.com>
In-Reply-To: <937514c9cbb3dd86a659d3fff11fb0f6fa3de8e9.camel@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 15 Nov 2021 17:07:45 +0530
Message-ID: <CAHP4M8W=EE+v7LeORkLSPBChQQjmALNR-Nm+GY6TkUjE4qiiDw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc-utils: Use memcpy instead of strncpy
To:     Bean Huo <huobean@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> I don't understand how above memcpy() overflow/underflow/out-of-bounds?
> would you please provide more specific reason?
>
> memcpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
>
> here lbuf is a char array lbuf[10], and ext_csd is a __u8 array, __u8
> ext_csd[512].

Ok, in the given information parameters, it might work fine at runtime.

But still, using 8 as the magic number makes the code illegible for a
third-party. Plus the code is also unoptimised, eg :

i)
If ext = "abc", then we need to copy (3 + 1) bytes.
However, currently memcpy would copy (8 + 1) bytes.

ii)
If ext = "abcdefghijklmnopqrst", then we need to copy (9 + 1) bytes.
However, currently memcpy would copy (8 + 1) bytes.


> Yes, but please remember that mmc-utils is mainly used for embedded
> platforms, they are not easy/inconvenient to update to the latest
> library to support these two APIs(strlcpy needs libbsd-dev, and strscpy
> needs some one else.).  If we use strlcpy or strscpy, mmc-utils will
> not be portable. Do you know any other API that can be used and make
> code more portable and simpler?
>

Hmm, you can always start adding code locally in your codebase.
Anyways, if you *must* use only "already available code", snprintf is
an alternative.

snprintf(lbuf, sizeof(lbuf), (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
