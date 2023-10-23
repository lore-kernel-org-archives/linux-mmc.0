Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B0FC001E0
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Oct 2023 11:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjJWLnO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Oct 2023 07:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjJWLnG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Oct 2023 07:43:06 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C064B10E5
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 04:42:57 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7b91faf40so31648717b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698061377; x=1698666177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SHpOrdrjUq/RCpEv0rxQXUbu6fq2w6SkA9rTlRoXwdQ=;
        b=M+qe/nZOuAFgg4z2E81XWD/9yNz10ufKCHIU6ggwE4UTwrnm3xPhxVaguo9i9ToDb5
         o5ScsvGEEBlNRa3w5gptS/yVRB9YAJPeSCBWVa1F486/UhrvAjj9d5y+TFCu35ogRmFq
         ATPCyxMfxAm9HLP+A3K6A4CLsNNYdnz+s5o+RxIYzgh5hs4BI7D+lp/h251yh3xQgpOO
         WK+p+bPHuMlGJqj9T8Yhn6mrYdyshq4KWM5bzhF+CDE6KM6RhtlwOHMcY/Zy/1mm+L8s
         NfdXfQ9mMd3Be/4njrLl4cLENidIkgSsYtsgrRnTJyx8TLiSXxwD197tBJvqxG5u5tux
         tUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061377; x=1698666177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHpOrdrjUq/RCpEv0rxQXUbu6fq2w6SkA9rTlRoXwdQ=;
        b=ErOWruZSTE7S9f3DZDNiyVFs20zfOAQh7l3A5uH4IPCnTJ8snMYxKm9oJZ+HZmdSqb
         zwxRLX7DyVuOQ30yz4dX+suKsDPsUtYEs885R/eDKaH8YX5fbSTaGVjMpfYlQY85rsnq
         NyqH6vmDkctRu9H10QAPNrHXABuR5Mi/FHXn/82Jvc/KEEasx7B1HleKN9KHWdH1BkOJ
         ++9E5Nrj4Jk0tkwgN1llLkfpQwtBXSWlSa9XgYUew/OZnVBmy8VqImT6Mb+vHx1TQnhd
         jaYQCS75dzt1E+PtaUArhtMPvCXgMHUuoAGN/JZofS+/SOzKUOcYrsdgp+FlIC+4t+8h
         lcmw==
X-Gm-Message-State: AOJu0YwiuPk2FhTT+DO1YKEq+mElQcfEPmSSTiiMFqDBjHzdX18btBCJ
        3Q+fTJqzVofHkqA2Xe+wUHHWiqX3OkR+8XHkNDoRHQ==
X-Google-Smtp-Source: AGHT+IE3/2ZI0BAAgKeahHy0bltN+bgn69act0vLj5jmqXpHgASUMtPiWCTt97Rumz+LhvcD4bX6c/AKBBiunSB2yA0=
X-Received: by 2002:a81:8943:0:b0:5a8:1058:5d97 with SMTP id
 z64-20020a818943000000b005a810585d97mr8762458ywf.45.1698061376807; Mon, 23
 Oct 2023 04:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231019195752.62692-1-edson.drosdeck@gmail.com>
In-Reply-To: <20231019195752.62692-1-edson.drosdeck@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Oct 2023 13:42:20 +0200
Message-ID: <CAPDyKFoeuVHu+Rt7kg1zbz1oFW8aCkQJ5swCbmSnA_Xrhx0eYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Use octal for file permissions
To:     Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc:     adrian.hunter@intel.com, CLoehle@hyperstone.com,
        brauner@kernel.org, axboe@kernel.dk,
        victor.shih@genesyslogic.com.tw, f.fainelli@gmail.com,
        asuk4.q@gmail.com, yibin.ding@unisoc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Oct 2023 at 21:58, Edson Juliano Drosdeck
<edson.drosdeck@gmail.com> wrote:
>
> Octal permissions are preferred as stated in
> Documentation/dev-tools/checkpatch.rst. Replace symbolic permissions
> with octal permissions when creating the files.
>
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Thanks for your patch!

Replacing symbolic permissions with octal permissions makes sense to
me. However, I don't want one patch per line that needs to be changed.

Instead, please go over all the files in drivers/mmc/core and fix all
of them in one patch. Another patch can be done for
drivers/mmc/hosts/*

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b5b414a71e0b..edb653d8fbfa 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2916,7 +2916,7 @@ static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>
>         if (mmc_card_mmc(card)) {
>                 md->ext_csd_dentry =
> -                       debugfs_create_file("ext_csd", S_IRUSR, root, card,
> +                       debugfs_create_file("ext_csd", 0400, root, card,
>                                             &mmc_dbg_ext_csd_fops);
>         }
>  }
> --
> 2.39.2
>
