Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464A1C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 22:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E93E221E2
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 22:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbhAOWtC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 17:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbhAOWtB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2021 17:49:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771C0C061757
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 14:48:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x20so15471892lfe.12
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 14:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0KsXg4M0TSgcfgr9q1Aup9OVbSWH5qsGP6P1HJnqQI=;
        b=nr+3FESaeWSQDMXMqoTYe9Bk9PtqoTIrwf9XdcUu2x0sINiKCaKFTzjbG+rygAShu9
         btbasOZbysR+2vTTnVZCzcjqMPbRwMGZxQqpnM6FWD757/yRz6x05YQPCORUcVS/uZpL
         bRRLFEg11+tXzId0tQhEFlR8cUi6dUYwy9MFCgYCl2W2gutZFdAvlb9bRL4SdFiCJdEH
         A6PWXiGgyBgo95Ya0y12+vmmEWCWauKvrWGhwdxsVxT6vaJFHyUDSDCqyhlBV3tyUOtg
         JCo9qeCGt2CVPYMUWkRwLdb+Hik/oz+7Ooct+MuBUTuFGZlq4n1/cdyLzx7b3xiINmey
         rdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0KsXg4M0TSgcfgr9q1Aup9OVbSWH5qsGP6P1HJnqQI=;
        b=c+jVPnSJKK3DmSCejYK29EOTZoQl404EKnw4fHhLjGgqG+T754W5TgorFuTiR4LL6d
         6fq/LR3iBtdf7VH5I7+I1ZjSmANMCVjypJZDY6J+WduvV6vFzHPWJXhiu8RLbZHo9pcW
         +IGwPGER4yOpG9A3pkaUdiY692UXdIKGkqw6mdusJhmnQ4ML8sXFTYqR+bU8HXgUeztH
         6ClVv8KDNAUETDBbnSzUItJ/4jnGHLD39wYkUOUCyNNpRSeN2VZczT8KIn7uCdU+V3+X
         l29yDB7u7dED8qDZkU/nxopOfRNFdcX6gcLgtcAMf1JNtYGzgT1zYZfJZw1+Xe+z7s7l
         v4fw==
X-Gm-Message-State: AOAM533a/F0/5xnjwSbl/5T3g9iqPM8EKMFKg2x3QSOLTBK2fis/zDRl
        yeTqF94snhe8XoU9VUJrpke6Xqxt0X0haW1AEK7Yjg==
X-Google-Smtp-Source: ABdhPJz2hZxTvU/zr8AHqrJtJDbXDHkTHS35avmmlk+VmFA/9HJluc++NkALp2tU5yeYzH51QeLr2kgVYf70798dJbk=
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr6198270lfd.291.1610750900040;
 Fri, 15 Jan 2021 14:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20210105140718.122752-1-marex@denx.de> <CAPDyKFoQfm2ZtPdsZSZtOCDH-FJqNzihYqZny-vUdK4Q4tWTzQ@mail.gmail.com>
 <b83c1112-010b-a40f-319f-84c755424b0f@denx.de>
In-Reply-To: <b83c1112-010b-a40f-319f-84c755424b0f@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Jan 2021 23:48:09 +0100
Message-ID: <CACRpkdarRZ=pFna5BWAqVdS4-ik1diKuXwMa_t9WwG23=pX_3g@mail.gmail.com>
Subject: Re: [PATCH] [RFC] mmc: mmci: Add support for probing bus voltage
 level translator
To:     Marek Vasut <marex@denx.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jan 13, 2021 at 12:34 PM Marek Vasut <marex@denx.de> wrote:

> My understanding is that "init" is the way pins are configured before
> the driver reconfigures them to whatever the driver needs to configure
> them to. The "default" state is the normal operational state of the
> hardware, which often is the same as "init".

This is correct. "init" is optional and especially for situations like
this one.

Yours,
Linus Walleij
