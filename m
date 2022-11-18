Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F74CC4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 09:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbiKRJrd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiKRJqa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 04:46:30 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D08FFB4
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:46:07 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m14so4079964pji.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAGhoUsMxs2sC8md2MBnH6lAKU536ruw0p1wXnUnqx8=;
        b=hB1z4Zq0cIGj5xqEbdIc9Try6UeRi5TufQA1V2870JTTuXhMytdkZBgtLsVW4/mm90
         b5JensghdKiQ5bPX/tHoY5+NsD/b8rIYzV94Ti+k+22nbZeFcK9dmmnyXxCYU5eiCuIe
         fuWWkkBLef5QyWm+wgzumd1knfj1/34NMnMbkm0zLYqDB/qVOQavBImaRAxWlVieSU01
         7S4AFEzjmk7w8UHqv6L26Jez+Z9HTAxaCHgKpQe8OGo8Ypl62O4hxkUsBxJ2UooIhaNX
         RBHXn4zXwQLqW13vTrb8Xa3eXShyTL3wJn1+hdcIebYMsyo5AZNcTTaHSAVsfs1jf0+x
         aG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAGhoUsMxs2sC8md2MBnH6lAKU536ruw0p1wXnUnqx8=;
        b=dQI55eAxBh9UnTvLPuMwKU7+iGIa9R4r1OQ/UBqjtM4Tbw6MYNFNOmkV3V/PI4vP89
         Ga2lD3QQVZIkCtUMl/tXdYAJ+KuNxN+IBnkV5/da+cgppF2Ec7X/0I0m3GWhtFCnVuiJ
         HysP5px0biHYmTQK6G763VYx9c+KyYk3tyFBSbscoPQM8VD8P7ryGHXkLPlWF4VvnT97
         GT4BE6b/EG7RZogvkGwnT710s7VbzRYG/Frotzof3U54kLvA1a4n6T0eTIBDMsyY45cx
         gHjTF24S6bRCaNIw54C0hUKfuZBP946RRMlJqMeY9w1fqgx1mNtvWmCp8KO8UIjqaPJX
         yzQw==
X-Gm-Message-State: ANoB5pnzM7A5IEvE17shUyXplRDgy3Noi6JrOMgGt2q2XURiTQF8ZMHT
        OEpIymSKciHurG4ELs36CUsObe46vQPxizoxh6g9KnjPVig=
X-Google-Smtp-Source: AA0mqf7KvjqnKLTejxVMCRk1Ye4pVlzsupzUISR3rd9uxhXAzl/ggV5YOiheX933yJDBN2D5T1bQ4V2baF5bN6PRWAE=
X-Received: by 2002:a17:902:6bc5:b0:188:6baf:2011 with SMTP id
 m5-20020a1709026bc500b001886baf2011mr6456815plt.165.1668764766612; Fri, 18
 Nov 2022 01:46:06 -0800 (PST)
MIME-Version: 1.0
References: <202211171524116446204@zte.com.cn>
In-Reply-To: <202211171524116446204@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 10:45:30 +0100
Message-ID: <CAPDyKFqbbcwyf9YUAPBZdfA4ujM6EcvcujQ9Skr7x_q571-CqQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] mmc: pwrseq: Use device_match_of_node()
To:     ye.xingchen@zte.com.cn
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Nov 2022 at 08:24, <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with device_match_of_node().
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/pwrseq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
> index ef675f364bf0..2374669b588a 100644
> --- a/drivers/mmc/core/pwrseq.c
> +++ b/drivers/mmc/core/pwrseq.c
> @@ -29,7 +29,7 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
>
>         mutex_lock(&pwrseq_list_mutex);
>         list_for_each_entry(p, &pwrseq_list, pwrseq_node) {
> -               if (p->dev->of_node == np) {
> +               if (device_match_of_node(p->dev, np)) {
>                         if (!try_module_get(p->owner))
>                                 dev_err(host->parent,
>                                         "increasing module refcount failed\n");
> --
> 2.25.1
