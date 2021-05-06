Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DB3C433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 13:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846B0610FC
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 13:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhEFNGO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhEFNGN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 09:06:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D58EC061574
        for <linux-mmc@vger.kernel.org>; Thu,  6 May 2021 06:05:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 124so7689842lff.5
        for <linux-mmc@vger.kernel.org>; Thu, 06 May 2021 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuRMg/p3XcDliVBSgwL/6V4gjxClpTJd4DW+g4l8Xng=;
        b=tY+IThXQYOpe6FQ492ndMN8tzQu2mNCijbG2rwp5heuJDJq5LUmUtVtReXzJpH+u7F
         p//mzGeN8KObivJXyDIhwX04m3RygLMWCBcV3bL04diWQjaKe5uDGfWjQlVQ/3qg1rMV
         Gd2kZhwaJIzAwLAMLSpY1dl54VDQymjcVxOvD2QWyHTiRueiwbz9cO6cbPPKXkSqtFZp
         iVK8Q3/btQM5gDAy6LlvIT9swLzP+qARz3ioMeduP3rMplhFgP7c80zm5Woclb0+7BcQ
         TT/vKeT+F/0svsfArijPMxaGvAlBTlVN01DMxcl2qh9LyPH0ovQ91xgI1nySphIM1z1u
         oicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuRMg/p3XcDliVBSgwL/6V4gjxClpTJd4DW+g4l8Xng=;
        b=fvEC7Us2zAEB39jtd73V5m2ieAF/KLSJW0t5c2cihI7vGAcOp5MwbHm7fH8Ng9V1pt
         BPDccO7h1Oq6O50VWFAVnBlUspGnb/CAHjTIE3MYyUG/jKCXdoFS6nTHASCpvFWteIB5
         X/s9APAaqPb204ayR3MdYbrREoesz5XnzN1LEVnicnAiCd4tZiqh9DdGuvDueZfwBkIk
         +HkVNfa9HugdMsEpbHA9m/icCoX5TWMgM75eKkQiDqQqmmE7eltSTfP9Xmu/d/ev16ah
         ZmFXWo/uHGKNThXaZRvXjvzq1ZUNeSAHUPrTzAUHjyoA+3Dz/U4BSLSB1IXzbVbvG5SE
         TwJw==
X-Gm-Message-State: AOAM533rAits8030qo0v/3zg9cnQisnbyg0k/1dlD4j8nskTnGg2fpm1
        q86RzbgiyNfN1PIFqjgAv1pKZlBdHEjjgObDNXTgXw==
X-Google-Smtp-Source: ABdhPJyUGRSu7ce4hdQJtL6n62WTj9npsWK0hdYAHjTMtnVkF0ZjJGViA4xhHzR1vUmUsDTkrNKtph4dSkX1R94xwPg=
X-Received: by 2002:a05:6512:6d5:: with SMTP id u21mr2857313lff.586.1620306313768;
 Thu, 06 May 2021 06:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-11-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-11-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 15:05:02 +0200
Message-ID: <CACRpkdaUVx3mRkTbRki1vXDpP7Cjvj_tYiR0iefjjX6=uGeDfA@mail.gmail.com>
Subject: Re: [PATCH 10/11] mmc: core: Read performance enhancements registers
 for SD cards
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

> In SD spec v6.x the SD function extension registers for performance
> enhancements were introduced. These registers let the SD card announce
> supports for various performance related features, like "self-maintenance",
> "cache" and "command queuing".
>
> Let's extend the parsing of SD function extension registers and store the
> information in the struct mmc_card. This prepares for subsequent changes to
> implement the complete support for new the performance enhancement
> features.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
