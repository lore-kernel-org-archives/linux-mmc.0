Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AFBECAAA1
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Oct 2022 10:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiJ1KSO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Oct 2022 06:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ1KSM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2022 06:18:12 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362201C209C
        for <linux-mmc@vger.kernel.org>; Fri, 28 Oct 2022 03:18:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h185so4430910pgc.10
        for <linux-mmc@vger.kernel.org>; Fri, 28 Oct 2022 03:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=viy+kdLmrgnYyhO3BtLbDG8jxARgZsjjdX8poRBhrzk=;
        b=jylc11ExTgaSXZ4vmtQkiHyKml/LCNBP6oMrbc/hh38IiT/I8lqsAnvXbl6soZ0j+L
         p6YA8rh6/eVt7+JjpJo1G4VygFGcLR9jaWrSTRiZ4FtVqr11BnAzKdqQg0DkPRw/IdkB
         pJbj8Zsb+o0poytSSiyaP5e3sfk3P/b/W7hA+Drp4Bn4JgNKJKrmpQgb+aEM3yeuxLOc
         6zWiXdI6FIPtGKrZzdYve1vrPnZNgaX6bHxYTGOr+5cDFUqadhdS6wsUtrKE5H8y+/UP
         bWxIap0ZJpQf75PuaeF5a4MAaJbxyg1bAmu1WldeNxzuxjG9WVIhEcj/xW0JhyH4lRU6
         Ubeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=viy+kdLmrgnYyhO3BtLbDG8jxARgZsjjdX8poRBhrzk=;
        b=MILTOXVFRbylQ9hSroV9SHXgupsXMN8x7L8tS391DnQEc5lVpvTwlyeXyj1UosO6Cq
         0+GrMQ9wy4U7ltNtE8wh4XLvyppg3hetee4FUD2HaFWoTp0pMbOpzkVrbYAGKTRL28cd
         Udoie4D1UKe+AJRiQXLDIqikvKSFG1ykYfytZV23J5uaPVR8c+C5XYjbnte1TbyKm2j2
         uGn5mR9ru42uxJyj0VbrK39OjWa5jouPPO+9YgMBARX7L/l5er1D7umCGhZ1MekT5VE2
         5hlrabETL0YvmDQSO/t3JEpeuxvXJOVGyYKYkgkKgGjGgTo6LR+/KINysSPB/89CeQwz
         qQ+w==
X-Gm-Message-State: ACrzQf1CCEIzrAqNT8r8PgSIAi1gfh4yVL6n7e8JugSwfJgu9cQr9H7x
        0rBOa8Tp8mHP9EF2SmeRRUK4vw1+RN3csSs7n1o=
X-Google-Smtp-Source: AMsMyM5vg+786aviDcgv8FQXmTAWRFwjiHEp6WKbdgNTSLOWnj9wzvE+Ps7alZgdUO8b01xo8eQozeKdjANA2w2i94M=
X-Received: by 2002:a62:ea0d:0:b0:55f:8624:4d8b with SMTP id
 t13-20020a62ea0d000000b0055f86244d8bmr53953686pfh.74.1666952290692; Fri, 28
 Oct 2022 03:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <1666947869-7904-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1666947869-7904-1-git-send-email-haibo.chen@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 28 Oct 2022 07:17:58 -0300
Message-ID: <CAOMZO5AVcnvSwwKhnnbBKVJiJPOd1fTTt_PSNsZY4539c-oZ2g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: reset the tuning logic before
 execute tuning
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, sherry.sun@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Haibo,

On Fri, Oct 28, 2022 at 6:25 AM <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> For standard tuning method on usdhc, the previous tuning result can
> impact current tuning result, let current tuning can't set the correct
> delay cell. And from the logic, this is also reasonable for manual
> tuning method. So reset the tuning logic before execute tuning.
> To avoid compile issue, this patch also move the esdhc_reset_tuning()
> upper.
>
> Find this issue when support SDIO WiFi in band wakeup feature. After
> system resume back, will do re-tuning, but then meet data CRC error.
>
> Do not meet this issue on SD/eMMC, because we already call
> esdhc_reset_tuning() when config the legency ios, and SD/eMMC need
> to re-init when system resume back, but SDIO device don't do re-init
> if it has MMC_PM_KEEP_POWER pm_flags.

Fixes tag missing?
