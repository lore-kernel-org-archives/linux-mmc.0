Return-Path: <SRS0=rM9+=DT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40A0C433E7
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 10:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B632076D
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 10:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpeAaQE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgJLKZw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Oct 2020 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgJLKZs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2020 06:25:48 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44937C0613CE
        for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2020 03:25:46 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id j15so5296941uaa.8
        for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2020 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GNvkFgdLXDpcfWvKEkv73QYFM9xMPNMDp+xRNimMAgE=;
        b=LpeAaQE650BQqklbSHLv2Z6xJrQs0Qovh8tsFCu9b9qA7JkCMs22nZlLnXA3K7N40i
         M97wedrLVMvuepRTbOMUXWtAVci+cldAdywwLor67r47xJKs5ua7al0YSAPvVPjdy3JI
         wPLP0a8f7OQfD8L5oOy4FjFUVvzbW+2btpdHtsSEWLs8AQQL1HTQmFyKFb4aFEOjcqSJ
         saSU/UwhPg3kCbzVxyKhqTI0EeGDg60cgwR3qxI5kD2zBdpOj35UD+8J+DSg7GqLHgSp
         O39rGncW4S4sMudb8bYPyt4aOyALFo6o5wKguelMIM3taqkp2xtauVOlu/JdPRldZKSI
         uuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GNvkFgdLXDpcfWvKEkv73QYFM9xMPNMDp+xRNimMAgE=;
        b=nkzSv4EANZYSpy3JbM0SuJ6UfYzro3o/9608ta6yzGOOea8eLRDrGpEloSf2cnFeST
         bFvsg1zNkHmoLX7FoQDFinbKM0wjVgiAWxUnE6Oa0DdkviF0hXeLXXmlv42h0lIEh6Cn
         32a8P/fXqiu9tshvRrj6D8nJiWk4PevU2T+mnft6sC9w3D5N66IO/Rt0g8KtzzfP0CjP
         jdpMxHwPF/VCxqvRdjQ4VYj2u30ea+kAsgRz9KsBuRFHD8H0KxIF16R9pXG2HAI+XQOf
         k0Y3nj0cDHz8tN4Tbl5mt1MmV+M5bLc9T3VRRp6C98elXaOwAdpW2olxBm1kHDXBgZaD
         6jQg==
X-Gm-Message-State: AOAM530jviBB0rStWebSXXaaUqLMwzy6qjGwF9m8h4cPZzkdticqdZo6
        S+Gppoh65KJXm4BJKGxExZ4dKt1OGT+CWJuC/2lGgg==
X-Google-Smtp-Source: ABdhPJwHw/rPM9GbZKUkpgzjrld/wPjs3AcYKe2gy0ttqFI2wKiBif4+nXfNA2ziyPOYvCzyaXZ6O9srMtMfWGs/SmY=
X-Received: by 2002:ab0:4425:: with SMTP id m34mr11902243uam.19.1602498345316;
 Mon, 12 Oct 2020 03:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200717033350.13006-1-benchuanggli@gmail.com>
 <CAPDyKFpp54tNRiQ+or-3o9dUJ=CB+PpsRc=fkxc10dAUY-x_SQ@mail.gmail.com> <CACT4zj-Z0yiuYF9KVyvTM+0nvk__YnBh=c7MHuB1XOFVpTtmHw@mail.gmail.com>
In-Reply-To: <CACT4zj-Z0yiuYF9KVyvTM+0nvk__YnBh=c7MHuB1XOFVpTtmHw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Oct 2020 12:25:09 +0200
Message-ID: <CAPDyKFrWO_x2wBjKRaoS9ypEszuQ+RWMr5Vej0uBOVV3=AAD-w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and
 enable SSC for GL975x
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 12 Oct 2020 at 10:41, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Hi Ulf,
>
> Regarding this patch, we also want to fix the EMI of one hardware
> using the old version(such as v5.4).
> Is there a chance to append a Fixes tag on this patch ?

Unfortunately no. $subject patch is a part of the pull request with
mmc updates for v5.10, that I just sent to Linus.

> Or what should I do ?

If you think that $subject patch should be included into an LTS
kernel, please send a manual backport to stable@vger.kernel.org. For
more information about the process, please have a look at
Documentation/process/stable-kernel-rules.rst

[...]

Kind regards
Uffe
