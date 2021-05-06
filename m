Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19247C433ED
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 12:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EAF610E9
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 12:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhEFM6T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 08:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhEFM6T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 08:58:19 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46068C061761
        for <linux-mmc@vger.kernel.org>; Thu,  6 May 2021 05:57:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u20so6871524lja.13
        for <linux-mmc@vger.kernel.org>; Thu, 06 May 2021 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9tWSVGqAxyrmuhU0qEueft/17Ve4hq5jQObsYsqKAo=;
        b=kDtQg2xdKGkWOf0VeyihTIH8uqxMlaYNjyGMUGrtha6n1HTfjcr8AzrA0yAwBaJk65
         tj2MF4ZHSAKqplZKiv1MnEkn49gLYQOwBvbwHIe3762SW3NODwUlqxgVS9mvXY2tzCSx
         Caex0Q17aEZWe65Wf69eLMsbY8pkM6FwNlRbuXZDqz4tJy39IXhQ8ucLS0hkbAEG7/lZ
         4X3+zxj3+Mgd58oIwRsoflsZGmZkfJ3LXXTmax8mke3qVjuqvpaOoBCjRzxVSvbuySs9
         kujqmiUUv9s3mPhxlPXQgaWFBX7A6pL/OXi0XPYZj+QWzuBlCNeNN9Mvh9L1D+0ZYqaj
         yBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9tWSVGqAxyrmuhU0qEueft/17Ve4hq5jQObsYsqKAo=;
        b=Q6ldllhfEu0jQonbXydObTP9vJgVNH1e+lZ0/JlQcBcz5T0//8GX97EtUZDN4by8Ff
         8ud7aePP+CaGVbPckDB9ITLnsAr9R1jdB7ymCD4da/RQVMd1gozfsK9kNaFfcMYYBcJ2
         XnYNEnsYEJQsx73Qp9f20JJpZtJwB5ZVFrUGkjhSpPpmEnMuy08VSRHwOcslKlAfkJLi
         PYv765zSdNsoUKNkZc6xzDkzllUMWfvNloHK8l+tqJtRrDEmel7C8B2fZ3wFWXRTD3X8
         JvhHQxU+o36G4/vR8dpwLYM2Sa/9rph8QVKI6mQW4AYrjp9Qyq+UiHa0gZSimn94+fsF
         oESw==
X-Gm-Message-State: AOAM533bIsvOszkrN3tG92MvMtHZ30/0SLCbyo2mQoimBh3X1iXIk2uX
        C/z/JrYdjdYQoS028Pp1obV1KPeCNnfCYQo/tq/mwQ==
X-Google-Smtp-Source: ABdhPJzRLocly4lInuLR47A3QjZv308cEaSCErmH7JGkDvbfFfBa8Bfssy1vMvOkZRrd7PWcrDEoc5Xv1VfahSzp81E=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr3396554ljg.74.1620305839834;
 Thu, 06 May 2021 05:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-8-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-8-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:57:08 +0200
Message-ID: <CACRpkdYVqA35th9a4j6CTcOE2A16jamrWiOOQitEbz0iXq=7HQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] mmc: core: Drop open coding in mmc_sd_switch()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The SD_SWITCH (CMD6) is an ADTC type of command with an R1 response, which
> can be sent by using the mmc_send_adtc_data(). Let's do that and drop the
> open coding in mmc_sd_switch().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
