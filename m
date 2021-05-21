Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E77C433ED
	for <linux-mmc@archiver.kernel.org>; Fri, 21 May 2021 01:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EE561355
	for <linux-mmc@archiver.kernel.org>; Fri, 21 May 2021 01:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhEUBFN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 May 2021 21:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbhEUBFN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2021 21:05:13 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142D7C061574;
        Thu, 20 May 2021 18:03:51 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x8so18249384qkl.2;
        Thu, 20 May 2021 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftgW/ZD8hun6+efsEtYDnA9Z/1i+HqiNXuFWOiDlQFo=;
        b=QPKFh7XF+JNfRZNGyb2vQYDAF3gVeLGE3CxuxR50/IxP9jDGhwd6wrNZ2S5UI9MLZc
         6bcHkedpFoUp2IJ8MYtf/hN0W2LGsDJVOqEAJbxOOwkaHwvRyMlkXZchrvJhjn/7mFrg
         A6lIdiAz7aNseKSQyxyGK9ReNFcWd9Wzh3wZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftgW/ZD8hun6+efsEtYDnA9Z/1i+HqiNXuFWOiDlQFo=;
        b=OfHy+SiSHyvStlIkQWDnR93dhsr23B+eQPai7JwXYiXkI4z+krMTjZ0/VlNgflAmJ0
         MxCD/YF/G79UKD0T9kQVp6DuWFSMLtsltJzFh5Q1z8/8IjSi4RYHhZvzo5waqxMZ0NPy
         ioCdSRn5+sAmt+0PHYnF6v/9TFegyzlCKYvdfvVfQmH3OcTb/8aL1ZTCARhM8ABPPAJn
         OpoaJSlCJJihRElFNTth5U2Fc6PzzKQJUKzD59IjhgST0pM9QC+nSeTxazHv2IpfUNLa
         XQqkIGba9Q6HSOqB9u4veAoa4OiFzPX50FilOqB5CpSVA6yCLKN8JDlJQV26POh5CKpL
         paiQ==
X-Gm-Message-State: AOAM531g9VwbRiwhsxqfrcjW1oynx5aZIjIBTUbF06yiUkKsGv4xe5Ha
        QEHMUqmPCkksOfEZsniSvggJiY5vLqOqIMIMB9c=
X-Google-Smtp-Source: ABdhPJyaSVhXFsyvFeOh0RKA2a79cq/wrF4SvXOaYGZXtEvafHPjqPwFM7IFU8bTSbbb0lHxfL58adnE2J7TQcDbKe0=
X-Received: by 2002:a05:620a:704:: with SMTP id 4mr7844434qkc.66.1621559030068;
 Thu, 20 May 2021 18:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210520101346.16772-1-steven_lee@aspeedtech.com> <20210520101346.16772-3-steven_lee@aspeedtech.com>
In-Reply-To: <20210520101346.16772-3-steven_lee@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 21 May 2021 01:03:38 +0000
Message-ID: <CACPK8Xfw8UH-4-oVqcFFMQmfrLqDbdYuACT9Rij62SBLU0+56Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] ARM: dts: aspeed: ast2600evb: Add phase correction
 for emmc controller.
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 May 2021 at 10:16, Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> Set MMC timing-phase register by adding the phase correction binding in the
> device tree.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

As the aspeed maintainer:

Reviewed-by: Joel Stanley <joel@jms.id.au>

I don't mind if this gets applied directly by the mmc maintainers (I
do not anticpiate any conflicts).

Cheers,

Joel
