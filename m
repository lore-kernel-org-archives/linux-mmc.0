Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EB4C352A1
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Dec 2022 10:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLGKhH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 05:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiLGKgn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 05:36:43 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB824AF1E
        for <linux-mmc@vger.kernel.org>; Wed,  7 Dec 2022 02:36:31 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w23so16615167ply.12
        for <linux-mmc@vger.kernel.org>; Wed, 07 Dec 2022 02:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BXDt43WcxRi0yEl4LUCrE6EiS048gbigVAfotYTXWMA=;
        b=OfSidZZyzHwOccnkBhJr31EUDTd0aqwPIP2Vy/2s64q3/hYi2Cj9nhU6X4OXnM9kj8
         cQk/Sc2/UcvAJR0ySTJ52FJIBDWbBfNWy0RjyUPgwLQt/ogm3pY2AmsIHPwcK6x4kOlS
         3iGTfY/9iJ7W3ZFSgE28u9R6mSyzxBmb2YERT2AslNmqSlU2rniGfwDviVxrAjzokS1R
         gybmuvaODSUe6TU/7pIfG3IvMTn4GTtJ+TvkJfoB93SgnNm3mxEz3y5eaGbamFMhjcT0
         LbfFb+olIQfp2rVKtrpE38IK2+py5xywcKPP+xbQGFSyBFNl821c4Io5TvIaenR2Xh9z
         ML+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXDt43WcxRi0yEl4LUCrE6EiS048gbigVAfotYTXWMA=;
        b=4TAQ/td0ikSAgwcesrIY8Yix4kJXbgng81PJC5AgjT+5ckBf68ApMZ3No3JKgDyiLw
         ektLJrP30b2IZ1nxaxnb7zAp1+YtHI679Ad/QUFpHMyGiqHm0l0sk1Mx9+f8/V0afBoR
         9CXinh7ypOP/T4d99agmTZoZf/BGfmPuv8xAYRI793R4z2ntW3jQyPKTbtYYhsDxP2t3
         kbGhGMTtK9YIn5ZqD6ndL6/FdYhmNTd6vwy+3ms3M5I43Yk3lhabvHOW+GEWbjCPNaUD
         ScrYCCotuF4yCKuq4RUMfnVc7ni4qyUPeT4yIEJhUBhqpLMIzA9qUky+tr3Yuus81vnF
         rIqw==
X-Gm-Message-State: ANoB5pld44hG6ET427PlKDD3v5f2C6E5MN9xhvgG5JNIwM96FooQ0Lg1
        P/QUBEduYj1DLilIqvadWuqnqE636RKnUNVwiXYp7w==
X-Google-Smtp-Source: AA0mqf6POyxwbgYFsLY6UGBqsMViLNvBcr1ewyhVLGs8qFhj4QOL8HVd374Y0hYDeyCuP7dK9zIMkn3CGStA+VYOKYM=
X-Received: by 2002:a17:90a:7485:b0:219:ef02:a5eb with SMTP id
 p5-20020a17090a748500b00219ef02a5ebmr10202121pjk.84.1670409391243; Wed, 07
 Dec 2022 02:36:31 -0800 (PST)
MIME-Version: 1.0
References: <202212011950119139713@zte.com.cn>
In-Reply-To: <202212011950119139713@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 11:35:55 +0100
Message-ID: <CAPDyKFpEqKUaqoJhD4xQYXaG-fmsG_XgqD3AJV=DjftiGbW1bA@mail.gmail.com>
Subject: Re: [PATCH] memstick/mspro_block: use sysfs_emit() to instead of scnprintf()
To:     ye.xingchen@zte.com.cn
Cc:     maximlevitsky@gmail.com, oakad@yahoo.com, axboe@kernel.dk,
        hare@suse.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 1 Dec 2022 at 12:50, <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.

There are plenty of other conversions that can be done using
sysfs_emit_at() in drivers/memstick/core/mspro_block.c. Would you mind
doing that too, as part of the $subject patch?

Kind regards
Uffe

>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/memstick/core/mspro_block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index 61cf75d4a01e..ae3a5dc00344 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -356,7 +356,7 @@ static ssize_t mspro_block_attr_show_modelname(struct device *dev,
>                                                      struct mspro_sys_attr,
>                                                      dev_attr);
>
> -       return scnprintf(buffer, PAGE_SIZE, "%s", (char *)s_attr->data);
> +       return sysfs_emit(buffer, "%s\n", (char *)s_attr->data);
>  }
>
>  static ssize_t mspro_block_attr_show_mbr(struct device *dev,
> --
> 2.25.1
