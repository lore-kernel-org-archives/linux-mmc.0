Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC3BC433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 09:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD6D6192A
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 09:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVJvm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 05:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCVJvV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Mar 2021 05:51:21 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46127C061574
        for <linux-mmc@vger.kernel.org>; Mon, 22 Mar 2021 02:51:21 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id b5so7109219vsl.9
        for <linux-mmc@vger.kernel.org>; Mon, 22 Mar 2021 02:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5tfs4RKe7DyMwZ1/CPo5NhF9TOT1gu2YypsLp/MLgM=;
        b=jZZakAEjYi6mGXYPe0pKVcHGkM6m9obfR4McVCvd1b8MDvhbComsZMn2j9W3A1uPUB
         xbFxhnWbBDtCIMzbFR9DylYiJoQhglwob5eYglSrvATADskf/+PtWLTuFiGDbnWbCWhz
         gfvbZD33GhPFnR3OVw1Ane+UhOnOpQ2dkt2yMtrbDRz8SIpDYOFM+G9YUaIsv6KmSY8m
         ep3coz3/NEt+bwNT+kM8Otxf+IVjVirPfiTuz2K0hy0PX+Y2gwSkNUdarA+Y/cUULyHd
         MmMStPABEqN40vuNsLCSmxb38hr86z8n06ROg8K4AV2WEG0wg4ANLGuzDpnsrhJAe1kb
         m24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5tfs4RKe7DyMwZ1/CPo5NhF9TOT1gu2YypsLp/MLgM=;
        b=pL7ZAk3F8j2ZTZQ2q8MTXeE9cA4gDyOCVVGYNvLUIqG+oKLw6bzx3B567A+k45wmg2
         uzbSC3Z1HhZKhdx/p54H3ueSjPkp50lN8BGUtYwRIUzjyHJFi4cUnX/Ops3C4BYUUaYU
         8nRRfaKegWSgJAwTVzmvdpYuxXyZTJqDEqr9B86DMr9Ei8IMITrJeYyO5LOJOTpXR6iD
         y30Fsn0xvgv5oZXIiAvZtRHyeYsmimLcHj4Gev66Y4Bgzdc9WwneNzYCjbS8HgJRpD0b
         8exWwBdZFcOC8NejetRpOqe2P0QaIbEZ+5STClf2HMzEiL32B4S0BWPtiQXaW0HOp4fo
         9PaQ==
X-Gm-Message-State: AOAM532O/cKxKRW08Nh+K/SOlP80i0PtULQSLjjW2gXa2yyDRRxECfjk
        1b6zl7i9DiR5WBCYgFQG7w8jsiKnlHNOIKvsC16Ibg==
X-Google-Smtp-Source: ABdhPJxSmVWQ+VNhvjr6kPnEiAv0MfbblHS8tcCuFWZqQUooRb9bxb7ZDa9Mq0coPqO9X5cqHB3AsAG3JqeXC5dQPns=
X-Received: by 2002:a67:77c1:: with SMTP id s184mr8018900vsc.55.1616406680551;
 Mon, 22 Mar 2021 02:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
 <1615936797-245197-1-git-send-email-limings@nvidia.com> <CAPDyKFpvuKU50T1UXfo-H5=gesOwqH4rW4sok4sYOZBgFijt2g@mail.gmail.com>
 <BN8PR12MB3556CA0C1635FFFD50390CDED3689@BN8PR12MB3556.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB3556CA0C1635FFFD50390CDED3689@BN8PR12MB3556.namprd12.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Mar 2021 10:50:44 +0100
Message-ID: <CAPDyKFqnUDCOmJe0aH7USXrAwktB1-GYz-MAr04dHF7iEG10DA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: add ACPI support for
 BlueField-3 SoC
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 19 Mar 2021 at 21:23, Liming Sun <limings@nvidia.com> wrote:
>
> Uffe,
>
> Can I confirm whether you meant the 'master' branch or some other branch?
> I did a rebase of master and didn't see Shawn Lin's changes in the sdhci-of-dwcmshc.c

git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next

[...]

Kind regards
Uffe
