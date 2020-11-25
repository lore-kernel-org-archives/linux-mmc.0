Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E81C63777
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337FD20857
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7tdyw54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgKYKnz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 05:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbgKYKnz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2020 05:43:55 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D51C0613D4
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2020 02:43:55 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id s135so386443vkh.6
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2020 02:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6QslX1mNSHdund1C0gsdAdrG6mQg5nN7ZNoGTAqo6LI=;
        b=o7tdyw54aCLhVU+iic7R3POubn349Bpx3CuuOc2f4wZCl6WoGo1s6qwMb34XVgx+NZ
         Nk0aFpkMvxjoy1jVACkLBcg+2JL+XH5A+G5d0Y7hJgRkCM4s52bfa/HV4PnWz/ow0Dwq
         vOD9yjbArBcLs4Ngnhbss+5dn183jveH7X4WsMAP44n5ybNcstCi5nRJLDfSbVHxF/uc
         F036X9ORN/lUqAvgYHn3qgSUyNoiob6KDF4N9QZl+qBNNSFXvLPp4TgI+I8+OvZMoOph
         B84G4V8hAgkjhFatUHF637aBL079qoPLer/fN8e41BmezXS8X6oVL2W/fn4jSll1zsi7
         3F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6QslX1mNSHdund1C0gsdAdrG6mQg5nN7ZNoGTAqo6LI=;
        b=XHku6K5LEvG5a4MmICEH2PELHFyIQ/sgDMikqVLNe2PzmydZQhSfut1Zsgum0QrBdq
         GSXQ8e+Eb4cnuEKM7OaApqi2vbxhCz6VMJo6TVpygRvqahEBnzUCyUVWbtChDvb6Ev6e
         A7ZRsMIIVk5WXjh5gWcgS6Hn1xxRXcGf9YWCaejIX7+SDAZlnjD1V4nixE3MzDOdeqpS
         8WNV7DVMq8KuJ9+809C9KIBhL7xJlg2rAQjWjAdbEIEAgD4J6TvbUIF7MZYNOTFPLw6z
         3ScaPw2ft8LoDq9G7Djb+jufJZiMVHQqNk2hPV1LWfR7B0zEFkoTMfu0NoVe8JWvzJ7p
         vM7A==
X-Gm-Message-State: AOAM533dhCL1Hz49Js3tvHSVRDdQktwUrKtkvQ+QqA8M84MR8PbMYHf9
        6QK2BnJHrQ5nr5mYBWHKGGfJp2WZmxBE7Hm79pqC5g==
X-Google-Smtp-Source: ABdhPJwyfbOqz8FDPkic+2J4DYD3aO4jVMdTJWgdndHlqXgc+y8739KN4jBFTTsEgfdjntgOWu0VEhXokakvoqIHHHM=
X-Received: by 2002:a1f:9889:: with SMTP id a131mr1577072vke.15.1606301034394;
 Wed, 25 Nov 2020 02:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20201106022726.19831-1-takahiro.akashi@linaro.org> <20201125074125.GC62993@laputa>
In-Reply-To: <20201125074125.GC62993@laputa>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Nov 2020 11:43:18 +0100
Message-ID: <CAPDyKFo_DjqTzaPhhBCKEj7axDU-4hMBnd1sw_hwP8nmp8xmTg@mail.gmail.com>
Subject: Re: [RFC PATCH v3.1 00/27] Add support UHS-II for GL9755
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Nov 2020 at 08:41, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Gentle ping;
>
> On Fri, Nov 06, 2020 at 11:26:59AM +0900, AKASHI Takahiro wrote:
> > This is an interim snapshot of our next version, v4, for enabling
> > UHS-II on MMC/SD.
> >
> > It is focused on 'sdhci' side to address Adrian's comments regarding
> > "modularising" sdhci-uhs2.c.
> > The whole aim of this version is to get early feedback from Adrian (and
> > others) on this issue. Without any consensus about the code structure,
>
> Any comments so far?

I haven't been able to look at sdhci parts (I will try to), but as you
know, I am relying on Adrian's help with this.

When it comes to the core part, I am planning to help to put some of
the foundation in place for the mmc core changes. Although,
unfortunately I haven't been able to post patches, yet. I will keep
you in the loop, when I get to it.

[...]

Kind regards
Uffe
