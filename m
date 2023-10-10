Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C51CD8C9B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Oct 2023 14:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjJJOtD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjJJOtD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2023 10:49:03 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985639E
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 07:49:01 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d81f079fe73so6677089276.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696949341; x=1697554141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BuFn9yXwnK5LmobjzB+R4p1+xYD0I1+gE3eBXNW3fUI=;
        b=h7zZmpWQANCfcfvOw2WYACo33H78W+prRJxbf5gO+neZEcGnNGffQRsMM5RWIZxuFD
         eo4W0OnOE9D8RCXm4vsIYRvBTPqihHx1HpGeUCTQY/VgY+xQ4v3TojIX/yK0sqR6nq1K
         zPXMVlNc1bMM9EP1dpo8kfCf0PpmjhXGB7gVQZlLaPKQXwMCn6zXdXPly10rWKrf31+0
         gdO0kHUZy1Kajpi8mwWEj9+taoIVEXNhi2lM22SnBU+A8jV9Jp269ZvN+r2IqLL8/oW2
         HjducN5xeju25nPNsrqMt5uW4QcgXqQS2lXbptsDIsV1dyYxXeLb7ll21T88UqMJrpfG
         h2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696949341; x=1697554141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuFn9yXwnK5LmobjzB+R4p1+xYD0I1+gE3eBXNW3fUI=;
        b=ogTB4wtFRTb3tkm/MmeZ0NAx4YjezP/G/HQnkZho9vlWN19srbULVx84ckqReeuoHk
         sZrQKoj/5F3au2aSLBX9hS3Gx1OE981rImKO/vtobAdyrvkS+5ImfwExxXXfRRVb+Cnc
         +CUZLmDI8nccnL3q4MUMLf7shU2OcSECLXfEK7yzEeuqNDrlr9fLVmbPtGS+Yoa6rYJU
         c1rQJRWbPWSSaM7Vqm1Zt1kBsKEfPIilyb1R1sKM7BnRD4gYOy+DmjpSku87LI+dzU4p
         2w1ig+s9v/XHvbwujWxpk02y182ULYmOxjQuOLuRdkUV9915LGTjKG+ytpxEbCXIVAfC
         WFig==
X-Gm-Message-State: AOJu0YxG938EKxVyN5Q32raap6zB4WJO/m4LUyT0beoLH8m2Iil5IUTb
        LBPzr8jT7JQj6FhuYLOAay0DDoWEKRj7cY7v4iIvWA==
X-Google-Smtp-Source: AGHT+IEUMSqwDVf48GHHQdHgXzcyyJV2FDwdH2jM5zUBcp2qwZ3ehn93cejKmluRu1DfBJi2XhaTWkpv2IKJSAbvMWY=
X-Received: by 2002:a5b:1c8:0:b0:d9a:54c2:1b92 with SMTP id
 f8-20020a5b01c8000000b00d9a54c21b92mr2059431ybp.14.1696949340839; Tue, 10 Oct
 2023 07:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230929130028.GB2825985@pengutronix.de>
In-Reply-To: <20230929130028.GB2825985@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:48:24 +0200
Message-ID: <CAPDyKFqUtNEbK2tzD+qOK+dFcDyBxvcNwOHWPJDLhTWGGkoHQw@mail.gmail.com>
Subject: Re: mmc: handling of Under-Voltage Events in eMMC
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Ye Bin <yebin10@huawei.com>, linux-mmc@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 29 Sept 2023 at 15:00, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Hi,
>
> I'm working on a project aiming to protect eMMC during power loss. Our
> hardware setup includes an under-voltage detector, circuits to disable
> non-critical components, and enough capacitance to allow the CPU to run
> for 100ms.
>
> I've added an interrupt handler to the fixed regulator to emit
> REGULATOR_EVENT_UNDER_VOLTAGE events, and modified
> drivers/mmc/host/sdhci.c to receive these events. Currently, the handler
> only produces debug output.
>
> What is the recommended approach for handling under-voltage situations?
> Should the driver finish ongoing write commands, block new ones, and
> shut down the eMMC? I'm looking for direction here.

That's indeed a very good question. From a general point of view, I
think the best we can do is to stop any new I/O requests from being
managed - and try to complete only the last ongoing one, if any.
Exactly how to do that can be a bit tricky though.

Beyond that, we should probably try to send the eMMC specific commands
that allow us to inform the eMMC that it's about to be powered-off.
Although, I am not sure that we actually will be able to complete
these operations within 100ms, so maybe it's not really worth trying?
See mmc_poweroff_notify(), for example.

Kind regards
Uffe
