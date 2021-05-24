Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA74C04FF3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 16:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB5861400
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 16:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhEXQUw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 12:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhEXQUo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 12:20:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C809C061574;
        Mon, 24 May 2021 09:19:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c10so20436048lfm.0;
        Mon, 24 May 2021 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0kf2yWdVbkRqs+bMEO1NKGIdlMUWGm1xOLGvrOPLjt4=;
        b=siVLuUrX2iJDjIMKj11QkDrVbWD20O3bdeKafOY4Az+kzj0cBcXYB8DAMH5SBwI5f3
         LmJMXv9s7WrxOUsLH27BlMFNbEuZ6VYvsBrOvpK3/m3Kv8iw4v+REp2WXAUWKqtfkT6o
         Ewju3QXK0AzIg/3jJkH+yyFiA/e2rsddFysAzGxUtJOtnkgK6LGWTvPOk9YABQ+DVStC
         iScj5C9rWLjQz7xhRab/zDUudP+wkXODJeP598uowFDAWo50TsGC5OnqZ8P47EkWclvS
         /ysFJLZ5EF5o09PQQAoGNjufttsAyPxDx6lYIG7Xj1mUeuc8EF7lH/IQEfxY1fsyJZdr
         p2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kf2yWdVbkRqs+bMEO1NKGIdlMUWGm1xOLGvrOPLjt4=;
        b=SzM3e73XO0M7tXfPmE9b4/5VAFYifFPRF4uJfny7a9GvWsfxJQ6CD2cQG+suEzyd/P
         KfTVsabbHLrLqMmydXfaqxR9ZmWd4U6Gcmh+APvCwPXiPy6lGCwjR6etApHHLRVxYIal
         UrcRIc3AAdRNZQ8j5J9KxpgPgNLCf0sLlqG5ZJwoso12bqzBMAIZx3RHmhVNrYpvbit5
         gRnTbjr+gDIxZkGeVsxBAcT3YVpEh9BNgihles/cc6fm6awhJ/rx1YW5KypHZRvsfrVo
         7AVj+daBfA4BgU32aLMeLlTFq9K9xdJ/zDEKlQrcy9djECP/Q7FW40Ly1Q9WfiSjFjQl
         SBZA==
X-Gm-Message-State: AOAM530YDsP3YXvlhvC2JGnrDXifqWS/08O9vcSpcvk0MsI/3hydpbhn
        74HEwYjDaoret6rkt7KyqOA=
X-Google-Smtp-Source: ABdhPJyZEJVfnEdg1e0qu8e7bfG527tsGB0W+iXPgJL+SX9msLyAqMJQSNuhz/x2ZO3OEGpKa/1ILw==
X-Received: by 2002:a05:6512:3587:: with SMTP id m7mr11429149lfr.282.1621873152704;
        Mon, 24 May 2021 09:19:12 -0700 (PDT)
Received: from localhost.localdomain ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id u23sm1459860lfq.287.2021.05.24.09.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:19:12 -0700 (PDT)
Date:   Mon, 24 May 2021 19:19:07 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Aviral Gupta <shiv14112001@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com, axboe@kernel.dk,
        beanhuo@micron.com, satyat@google.com, avri.altman@wdc.com,
        richard.peng@oppo.com, guoqing.jiang@cloud.ionos.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] This patch fixes the warning generated due to use of
 symbolic
Message-ID: <20210524191907.034efdd6@gmail.com>
In-Reply-To: <20210524155705.5138-1-shiv14112001@gmail.com>
References: <20210524155705.5138-1-shiv14112001@gmail.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 24 May 2021 21:27:06 +0530
Aviral Gupta <shiv14112001@gmail.com> wrote:

> It's better to use octal permissons instead of symbolic ones because
> peoples are more familiar with octal permissons.
> WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred.
> Consider using octal permissions '0644'.
> +	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
> 
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider
> using octal permissions '0444'.
> +			mode = S_IRUGO;
> 
> WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred.
> Consider using octal permissions '0644'.
> +			mode = S_IRUGO | S_IWUSR;
> 
> WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider
> using octal permissions '0400'.
> +			debugfs_create_file("ext_csd", S_IRUSR,
> root, card,
> 
> Signed-off-by: Aviral Gupta <shiv14112001@gmail.com>
> ---
>  drivers/mmc/core/block.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Hi, Aviral!

I guess, you missed my and Greg's mails last time... 

Anyway, subject line is strange, it should be smth like "mmc: core:
fix symbolic permissions".

Please, refer to
https://www.kernel.org/doc/html/latest/process/submitting-patches.html.


With regards,
Pavel Skripkin
