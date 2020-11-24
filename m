Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE60FC63798
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E54420674
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wv37v5rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbgKXOXR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388843AbgKXOXQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 09:23:16 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C35EC0613D6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:23:16 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id n5so5862418uao.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9aWE8uwLcST815ETGDNopl3X1aPGXP5aK+bslaDOm0=;
        b=Wv37v5rpVApnirYnmz6Tp42C5v0zC+3iYfUaLhkm76QUTu19zaID9N6U+CDCqI+ZV6
         c5iDUiqlwJ+xG0K5BLygeByAkjP9aKWB+Gm6LDkMNu+TfQ+Ce7VFKxvv55G0hWl/Gc80
         MWmnXrdMvX3104nS6o5LnldzFrXdHD6CCTgrunH2QXLPRv2YkQVaQmv0Qq/2yWT2Mkrz
         TmRdkZQOfGHO7UEIMAUcWkUGOgJ0vrIZsxvDSoUvhnDHtRp0XDzZaQGXgocirvAGkK//
         f7CAWRau63bwEXPROMW3Yi6mzQibY7hFY62BSibmiJ9S0tWVHssYFMyHtmDS9T9kBW43
         uD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9aWE8uwLcST815ETGDNopl3X1aPGXP5aK+bslaDOm0=;
        b=ZssUD2O3cGDowFWzn94lnyKbVNqqCq9MUEMsvLNQbS1vapKH5Ac+oDoPUZ0ApnqvbZ
         LLQDTxxB59AeNeNddU8s1FyG/gx+wfi3tvRanyiQwDgQaF+nzRYczOhM/iQgVxFv/sI2
         b0pR4F+JOABngoQz678t/7foo8t8OoHiWhLBhUZiIMbG7VU21Cw5Tc50ic1UKgPmw3cc
         6Np8D9I6azKWTBWk5wKAseWNTKirKT1jBEiTPy7BJImKnvDObw2H/bnvj06WzvWyQYCy
         xbUnm2lBgd91kFeYsxWifHZC7ylhkNMYdTGkeWwHw2ZYWEPG0TJRUe70k1t3KZeZLDmF
         Fz7g==
X-Gm-Message-State: AOAM532iQOHamO5Ze48iMxbeDciLAUa+EMIe0t/kpLtgHi396MvJs3P3
        E67UFDZn0M9DD0rJ/etz5RSJxB+pQesn1G823e7m4A==
X-Google-Smtp-Source: ABdhPJwBdd8AJ+i2pqoufDRPkyhArvXhuBYL4RfsrY0amm3+GeefYPdvSQa6YNvxG9RbeERNB5mkMtl9vfaJfWAxqXU=
X-Received: by 2002:ab0:60b1:: with SMTP id f17mr2910153uam.104.1606227795487;
 Tue, 24 Nov 2020 06:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20201123111925.28999-1-bbudiredla@marvell.com> <20201124113720.GA30440@infradead.org>
In-Reply-To: <20201124113720.GA30440@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:22:38 +0100
Message-ID: <CAPDyKFrmdGQ4--Ng_Thf2yb5py=XvAhf027j4pq++Z-djfUoJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on pstore/blk
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        outgoing2/0000-cover-letter.patch@mx0b-0016f401.pphosted.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 24 Nov 2020 at 12:37, Christoph Hellwig <hch@infradead.org> wrote:
>
> Please hold this off for now.  I have a major rewrite of the pstore/blk
> interface pending..

Sure, thanks for letting us know!

Kind regards
Uffe
