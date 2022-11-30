Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F7BC352A1
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 11:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiK3LdX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 06:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiK3Lcr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 06:32:47 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319A4391FC
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 03:31:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id io19so16367852plb.8
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 03:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+MFn9EqoTO715RsdG/dw77tBFL0tg/wFnql/WPEf6g=;
        b=TDoAe2+Qol62DxOVkqu1vsEIN0uu7xzHmLf2REFEQ0xRRg7N6d2OfwwPSFYxoXEnmc
         kDnLsiIT3TppJ6TWmJ42TXW6FAmvf3jhSZ9dS6a/J4M7jTmpI8/6X0BHIiCJ7gt5FJ5F
         qgrtZCbYokUSMyql/YmqjxhIXej0ocXt8UPwJPmKdNGnex678OxzoXzUQ4JJxhXEdwjO
         rPg+CEA9X8G+vHXiVVMGMtc3Hk88aAnMjfv3b1eYyZr1TIGfllHD+tOsBZXWNoDopmJV
         qe0WGovwaYnDpruLN1sUrF5WB5Ny9MLlOvdc5Nk8XjW5Ka2yLB5ojXiwSYQVbCbShTT5
         CzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+MFn9EqoTO715RsdG/dw77tBFL0tg/wFnql/WPEf6g=;
        b=gIBI/lZ9kyvN20AWhca6xfo9VOS2r0GZn9M2y484zgCAL/fQbrw1FyoWWPehhiLmOq
         YZ6ZH0MKvM3OCx4YSF/efxEyEcvlcEijDsoBcQRiZvM5s1w8IoiqFMQTDqNoTlDH+Ffr
         2cmP8NgIoSsbizPWM55ZaqrtEhM+W3iRTB4Q/Od0M13bk4tzfxEke7Z71ZX3qjV3bLAW
         nCO0fM/scwy6L8/AFUhxdnNo306xIC5h3Emz5JvCQrzDXD8DCPS+q2pzWmj1k5aPU7Kh
         C7NVYSr2Gnrk28PuOl+ab3zPLgG+LZyj4fcCPMfkxNsTcWVHVDvb4Brx/iEg4RkIhvze
         nDqg==
X-Gm-Message-State: ANoB5pnnALeN9KZFaB+8IP00UO5suXNKyH9vyXLgjGpAgK+gh9aEGYGj
        UVOqkpaiGo1jp3vZcaasovN8vii1xFf45uzXOzB7XA==
X-Google-Smtp-Source: AA0mqf5VLjOzpI+KF3B7UhwvG2StO9Ych2BQTZ4mOapkyXldhkpzEwJtkXmFHUZ1aJrvFYCmENX+mGCR2swqeBUl09Q=
X-Received: by 2002:a17:902:a503:b0:188:6baf:2011 with SMTP id
 s3-20020a170902a50300b001886baf2011mr39945283plq.165.1669807872496; Wed, 30
 Nov 2022 03:31:12 -0800 (PST)
MIME-Version: 1.0
References: <Y4V/+jJxnQur4M9s@shikoro>
In-Reply-To: <Y4V/+jJxnQur4M9s@shikoro>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Nov 2022 12:30:36 +0100
Message-ID: <CAPDyKFrX8pzDDs6k+TBmDhrrgLSkORfmGdiGX4Mbuvjg-Xhmrg@mail.gmail.com>
Subject: Re: Q: mmc: core: Issue power off notification in mmc_remove()
To:     Wolfram Sang <wsa@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 29 Nov 2022 at 04:44, Wolfram Sang <wsa@kernel.org> wrote:
>
> Hi Ulf,
>
> sorry for bringing up this 2 year old topic again, but we still carry
> this patch from Shimoda-san in our BSP:
>
> "[v3] mmc: core: Issue power off notification in mmc_remove()" [1]
>
> You said you wanted to try some alternative solutions. Did this happen?
> I was digging in the MMC core trying to find it but to no avail. But I
> simply might have missed it?

It's been a while since that.

If I recall correctly, when I started looking into a solution I
stumbled upon other generic card removal issues that triggered various
splats. Some of those issues have been fixed [2], but beyond that
point I simply haven't been able to look into this again, my
apologies.

>
> All the best,
>
>    Wolfram
>
>
> [1] https://patchwork.kernel.org/project/linux-mmc/patch/1605005330-7178-1-git-send-email-yoshihiro.shimoda.uh@renesas.com/
>

Kind regards
Uffe

[2]
commit edb25572fc70 ("mmc: core: Use kref in place of struct
mmc_blk_data::usage")
