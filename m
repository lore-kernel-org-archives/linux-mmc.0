Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB1FC48BDF
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 20:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C536613B6
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 20:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhFOUTN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Jun 2021 16:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFOUTM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jun 2021 16:19:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132EEC06175F
        for <linux-mmc@vger.kernel.org>; Tue, 15 Jun 2021 13:17:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id i11-20020a17090a2acbb029016f0cce7c3fso148165pjg.3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Jun 2021 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkGQnLmVwW4qA0ssOBwk6WCJvW1pndNBd0scdSFPh0I=;
        b=MruOia1n3SSDfMAy6SgZPc8gOiJ2KYRHg1TFB985qFOtyVkwkkmkCTLTgcrvX6tPYe
         LBQxQBXRaYE+gZTN63vld9MyCL6PNNcyL29jtnYOv1uq6lMc/661M6IPWOwaTX332CU4
         EcdZvHlViiMjujNmoBFX79dUIXWtOhGtgC0y5g5yMKWXYXmOErXjZlIoC0XaXhKS4ys5
         OwjCeVAymTQcae9cU/cXcHtp1HgOh6OUny8v2aXp+wPTLg5kBolbDcmScKUwpayrBOMY
         PyYpY4sQX7rUYW0CHvKXRp1yKTj+VVZI6Zo2pSwj+DnpkcMxN0tLz8bdID+ks2vS3WNo
         8/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkGQnLmVwW4qA0ssOBwk6WCJvW1pndNBd0scdSFPh0I=;
        b=KmK/QboTSs4uHCvIOsOWiKvgmfrqz+XA/DP8Y+VH1cUwNruf/iizE59EzvLG7uQPhT
         8eMPmPqITcdV1pRvNkb2g3dpC9lS24sxbdXUsE0pkrVBY7vsJOI4fjUVARJsrnUAfiTl
         F5wM79HcOLHktTZ0KFA2tjjRVMWm7Yge5Ky0Bq4COVZ1m04+2pPIz5X6XucU7wjp0Rwr
         j6XvSWIZOcFsaEl0eZFa81o9Difkw+Serpyigdeq8AexAfd4QMUDR39DhPlpZMmlnnU5
         NN6Q5xCl3PVftJEolm3cbNVhEwH8IMytqMUAJMLOORsFf6sRRs2vS4UFmGguNedkEtnK
         p/fA==
X-Gm-Message-State: AOAM530PNpMV6QkiwfskiHPwuasFx576VeJXulXg3D0h2RaCK7dmVMBI
        KZuCUc9r5x5LelMfDrXgfFrTweN7tkU/aOa0Qk0uZg==
X-Google-Smtp-Source: ABdhPJx9P6F6n477bRva9mz30K3tjhbcE6hC9AMxPX01zFv8+yjRUVzQJlRxqjIr9o9+vC0QlqUiP2GEn324NMHYB3Y=
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr6812484pjh.217.1623788227394;
 Tue, 15 Jun 2021 13:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-6-davidgow@google.com>
In-Reply-To: <20210513193204.816681-6-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 13:16:56 -0700
Message-ID: <CAFd5g44OdWFTcj5T0e8uPX-HkT3Dm_X3axJV0bza1SE3BvURmg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] mmc: sdhci-of-aspeed: Remove some unnecessary
 casts from KUnit tests
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> With KUnit's EXPECT macros no longer typechecking arguments as strictly,
> get rid of a number of now unnecessary casts.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
