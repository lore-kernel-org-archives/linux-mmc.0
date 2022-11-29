Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975ACC4321E
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 12:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiK2Mym (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiK2Myl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 07:54:41 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4B260E8A
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:54:39 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q1so12892591pgl.11
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zHJtTzaFLX6ofD+/NiRHkEzuNp9VdRYHtRRZa+mw5zg=;
        b=J3lc5U9UawdedrKxvO6foM+se+Hdnwj1FkQeqAGC5/VBa8ti+BAB+Ws+tyj2pyxU4S
         /4CaGl0KEvx6iVZKMSgqXiXLp1xzUVkOfsfi0dS468MztsyU0W3BaPlrA/U3EX7czdr8
         iQQRN5UAPKhmEXuGeqYU9K1X6GiTkeME/rj6KDmumo7ppHPs667JLVpph9lKVeuGNxzw
         6R5yKfzMVjk8DrW48t1nS/P2oStuEnjWNI76NrIi2d6OVvX3teBiYi/uiAyY65d6SFus
         Dk7Kxau7SChDxOFgTDdtfyPXjGybyFo21nqOC13rFeLMHy9zoakA6HY3Fd/lxeE5/Gt9
         U8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHJtTzaFLX6ofD+/NiRHkEzuNp9VdRYHtRRZa+mw5zg=;
        b=FGJX17lkwj1C85eLH87hmBKVcxbokgrYQhIqHCuhIGnq9cG9klbZ2MmkikJFGbizdx
         f2BiKGs0vorWnReg2vaNjxUxC+zMuAIAon1aQ3m843g085pjOQm54oCZ5wIxDdno5agh
         1V+HtZUiFBfUF3uZBRs9LZrUhrn9nNoePFznlUaaVIkAXB+PzC3s4txyR/EJuePdph/z
         u2wU5zAnK9pfUQ3sRu320DratRlQVMDD7Kls73PqOS80mn/6q4pK/7R8jVKioLnGN3N7
         fBHfaR53wAZz/fbZ6g8sJTyHC39ctOdSgzJDNYqDJ9dbQCdilfo3BWeb1E+yC5Zg8HgD
         lFHQ==
X-Gm-Message-State: ANoB5pnVkfv3CZ/JfTxXGMTBe0f33x1qX93NcZUOXeFHwu/A0Ch0qETg
        mh0Ti2/6aZxzWjtUOtt/tmpH2eB5sjQi/cKxFVE8dQ==
X-Google-Smtp-Source: AA0mqf6jBiO2Uwf+P77xMfYQu/HDmnoLvThm7Xv6DfpoSUqp9iWV5JNZQCrEsqy7CJQQ0I5ZBI/08gOyptbY58Ckaqc=
X-Received: by 2002:a63:501c:0:b0:477:650a:c29a with SMTP id
 e28-20020a63501c000000b00477650ac29amr31158504pgb.541.1669726479384; Tue, 29
 Nov 2022 04:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20221123095506.1965691-1-yebin@huaweicloud.com>
In-Reply-To: <20221123095506.1965691-1-yebin@huaweicloud.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:54:03 +0100
Message-ID: <CAPDyKFrRKkNjswGrDS+Uts1qYToQnV_ACXe_zNrqDJXkjjqv-g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: fix missing assignment of 'file' when
 register debugfs file
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     wsa+renesas@sang-engineering.com, kvalo@kernel.org,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, yebin10@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Nov 2022 at 10:34, Ye Bin <yebin@huaweicloud.com> wrote:
>
> From: Ye Bin <yebin10@huawei.com>
>
> Now, 'file' is always NULL. obviously, 'file' is used to store return value of
> 'debugfs_create_file()'.
>
> Fixes: a04c50aaa916 ("mmc: core: no need to check return value of debugfs_create functions")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Applied for fixes, by amending the commit message and by adding a
stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 6cd6f8a94a71..156d34b2ed4d 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3174,7 +3174,8 @@ static int __mmc_test_register_dbgfs_file(struct mmc_card *card,
>         struct mmc_test_dbgfs_file *df;
>
>         if (card->debugfs_root)
> -               debugfs_create_file(name, mode, card->debugfs_root, card, fops);
> +               file = debugfs_create_file(name, mode, card->debugfs_root,
> +                                          card, fops);
>
>         df = kmalloc(sizeof(*df), GFP_KERNEL);
>         if (!df) {
> --
> 2.31.1
>
