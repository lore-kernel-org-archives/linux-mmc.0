Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6764C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Apr 2022 20:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbiDYUTB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Apr 2022 16:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245144AbiDYUTA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Apr 2022 16:19:00 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE2B2182D
        for <linux-mmc@vger.kernel.org>; Mon, 25 Apr 2022 13:15:55 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f38so29156421ybi.3
        for <linux-mmc@vger.kernel.org>; Mon, 25 Apr 2022 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNNCkvh8dcc6hUGxKVprGL47ZUmLyygiOa73jLPnlLg=;
        b=jLNnkzTL5R0lZLMYhpEDo1Q7NZUxdIfaMwzaJzpsZMqg0QgMjX0bok4gRVUsWAIwYS
         bd34/nPLwF6v4t16ZR4x2DTuFrrY8csWIufWjB19v6bouk3Tth9siRfS2EOds71gT42O
         rxYUga+YLd7iofncKdbSlJaBSZEVnsSyph5L4/6wqA8qHQf8CcF/aTg812wgF5HN5IZ/
         Q6W61gOIAyv3FjtLweV+AufRF1Cdtv3JGzrtCbWd5U98jn8bbfx1iLqkHTvnBxdcyKb4
         fQ12X7EgHyuUHPLw0qlIRXwAhZqJ038oK0CHIzzHrjHfvObXgHuZyKH2oxn8Labud2Ji
         Ga5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNNCkvh8dcc6hUGxKVprGL47ZUmLyygiOa73jLPnlLg=;
        b=DMsE+MWGPPA29niftLS9uaxaa2gog2a50fpyP6RDNK5/78PG77aVOBrJ45dZoQbSrd
         VMGE72KEnJE0qEmvv3PGL/ucwTArJi8bW4XQKPYRBWyTnF8dVGsGgh0kIJSL8rMTHQ4n
         A36cqoV9C3fVY4pPVJ++IkHC1kAPvWDohjuJ4v+0mGbOkgwdATn3N+rH8zQ9hZxflFaA
         VY6xftKQhr6eSLKaHp2d1xpf5SC9vDcFgnkOkECBVM6gMTYp9ooAKgYIGl3UOao5Htcw
         bYly0Thuyhkf29jM8GMcxhtsjo9uswl/5QHu5vp/daD0EB60HuikFha9exdtEgPllyW8
         7tLw==
X-Gm-Message-State: AOAM531aGcE79yVzgv/kM5aILEmcJOmgqJDcKV/tBpCRbpAPzBXLX7d5
        17IsfneumqzVVz5wApknGFFeb6MrhXHXnO9gZPLGXg==
X-Google-Smtp-Source: ABdhPJxTefhTsWUQiB1iBqYOVZdlEBrHq9xcBRO/3+BEyVu/xCOhggCNj9IiQFyaIzKUyZjw0RZLzJFEwz/8qbCmQAw=
X-Received: by 2002:a25:a12a:0:b0:644:e94e:5844 with SMTP id
 z39-20020a25a12a000000b00644e94e5844mr17430478ybh.492.1650917754756; Mon, 25
 Apr 2022 13:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220423221623.1074556-1-huobean@gmail.com> <20220423221623.1074556-3-huobean@gmail.com>
 <CACRpkdahf5QhUJ-vG6Qs7i0VYbSS02zBrQOtN8EVFu9SyHZA1Q@mail.gmail.com> <89845bec6c827d7012cda916ee50b16c8eb08755.camel@gmail.com>
In-Reply-To: <89845bec6c827d7012cda916ee50b16c8eb08755.camel@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Apr 2022 22:15:43 +0200
Message-ID: <CACRpkdbM_qhwmFhwJNx0J_r2jUHoSsE6B=bKhGwKG=dXtX7uEg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: core: Allows to override the timeout value
 for ioctl() path
To:     Bean Huo <huobean@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 25, 2022 at 10:02 PM Bean Huo <huobean@gmail.com> wrote:

> I think the current solution is the most flexible way, if the customer
> wants to override the kernel default timeout, they know how to initiate
> the correct timeout value in ioctl() based on their specific
> hardware/software system. I don't know how to convince every maintainer
> and reviewer if we don't want to give this permission or want to
> maintain a unified timeout value in the kernel driver. Given that we
> already have eMMC ioctl() support, and we've opened the door to allow
> users to specify specific cmd_timeout_ms in struct mmc_ioc_cmd{},
> please consider my change.

The patch is fine, I'm just saying we should put another patch on
top that defines a RPMB default timeout and set it to something
high, such as a minute.

Yours,
Linus Walleij
