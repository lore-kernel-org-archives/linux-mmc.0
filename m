Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA22C433FE
	for <linux-mmc@archiver.kernel.org>; Sat,  5 Dec 2020 23:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53DE52310E
	for <linux-mmc@archiver.kernel.org>; Sat,  5 Dec 2020 23:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgLEXCZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 5 Dec 2020 18:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgLEXCZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Dec 2020 18:02:25 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94409C0613D1
        for <linux-mmc@vger.kernel.org>; Sat,  5 Dec 2020 15:01:44 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id o24so10856171ljj.6
        for <linux-mmc@vger.kernel.org>; Sat, 05 Dec 2020 15:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCSFQKcvlFjkvLCpcBuUUtC1CDOf71V8SqchdVnabE4=;
        b=Zg823BvS2desl9AuzFGxccRF6I1+rDCSbCAg0dMS3yYYBcDdSiUrTdZRltaYtobKYV
         pM2hVbsdl991GGaQz6VM18Nvri8NDwPXpysns07Piqi5VB0wZGn68+ZiXN9OuNvuGV0W
         1kKaZhQA7Kugk4TrHxBwxJPMqz4Pg3n/D61rrnw9eDczzBZ7/FJuzlF0fiAaCOY9OJVR
         xo+4zlm88h+ebljPJzS+lBfBKrdwGonz5xyTzB+LHd5ouviPApjhlP4tiXEAaEw93Quw
         74PWLAUEgsLbkKB6tzUMloWKUZZcjA+cDkt0ZaWsxlpRkEoh7lWxcvcY01rEhfqQMUja
         D5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCSFQKcvlFjkvLCpcBuUUtC1CDOf71V8SqchdVnabE4=;
        b=YBXguserAmM4XYV2vohZQxmHV5to73NwI0j8hmEszozaHlDXYOu+P0XZZ2pYQxMdPa
         0DTuidpZLZqulWbapxmTWt8rUc1CaeiKx7yfOwBf1EjKRl0swE6hXfUsax8fpJ5XKALl
         wpEbkBmeqNpEB2MAGIEOpFyofDsGSSF+NTEoM1AzIsKAWwTc1ACRyLOSeZ7hQmAab459
         ZC5XkO4S85KLixc2BZFRImguVxNTCjTPp68jWxgB0+WjzmO3veg4K97PK/srW5SCfGjN
         6YqTLEObszamBcZwI+yFuG2GjWVdKuG/Bjm9BmBXI0w3Usvbwm0PaNyuqpItaG1T0Boh
         cNbA==
X-Gm-Message-State: AOAM532cg99cptkihPvEwJPi98lYYGe42SZR6SG/6wV57ehUOJQ5wg+e
        p5S78ABk+aZJXLWp4Y3MKO3FXJG6Gg1tQaj1XWQ/oA==
X-Google-Smtp-Source: ABdhPJynyKDo2PXUU2VopTAfxDCvs+UnAN5Rm8GKFqYK8TEgnkXG0hfZ5PVsr0IlUZ50Nxnlm1KyV77sUyQFQ5Kq5yo=
X-Received: by 2002:a05:651c:c2:: with SMTP id 2mr5761217ljr.104.1607209302955;
 Sat, 05 Dec 2020 15:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
 <20201202150205.20150-5-muhammad.husaini.zulkifli@intel.com>
 <CACRpkdZznKd4NYk8whBtq1sUAj9uhasn3+ykrh50A2XKokp=Aw@mail.gmail.com> <DM6PR11MB28767ED32E97BF93C5F3C7B4B8F20@DM6PR11MB2876.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB28767ED32E97BF93C5F3C7B4B8F20@DM6PR11MB2876.namprd11.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 6 Dec 2020 00:01:32 +0100
Message-ID: <CACRpkda9TfKnKSJ+yBEn6uqvAEoTFXy-g-6GqJaUQ0FYHLP3iw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Mark Gross <mgross@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Dec 3, 2020 at 8:10 AM Zulkifli, Muhammad Husaini
<muhammad.husaini.zulkifli@intel.com> wrote:

> >Yeah it has to be called from somewhere, if you want an abstraction to make
> >the driver neutral to any machine, then use a selector regulator. It can be
> >placed anywhere in the kernel as long as you can reference it.
>
> Sorry. I am not really aware of selector regulator. Can you point me to any references
> for this?

It is part of the regulator subsystem and the standard framework
there to handle regulators with an enumerable number of
specific voltage levels.

> IMHO, we do not need to overengineered it to add custom selector
> regulator just to suit this Keem Bay HW design.

That can be said about a lot of things we model with vqmmc.
Using standard abstractions makes things easier for maintainers.
We mostly design abstractions for maintenance not for the simplest way
to set bits in registers.

Yours,
Linus Walleij
