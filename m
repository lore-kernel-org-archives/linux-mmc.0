Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B0BC636D4
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 23:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBMXsg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBMXsf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 18:48:35 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFBB126C7
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:48:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d2so13446483pjd.5
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676332114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A4/KLmeiyzkFaWHLQHMIS71Qo+cLPHUap+RacncgWAU=;
        b=SIy1ijPL6cxdum5Lcgqw4W1EHfIXd043r3kFS1ysk5ncuzH1jYr+7OmLt5uelv5+hO
         945IpKXKTSughA8ITuh/VVjAhFJh7EU1sGJEn5PiztiL7f3GlpNIy8ULolDu8TQkg4B2
         Ux4raNlv1mBJ0xGCnxN3+0q2NM2leX7L0ZKOXQuQPrAVvUGDDIE5kGswxjVF+31jFScm
         hwF8FF032i51W7f85h8liLCWCZXqS1MCAzkMDgy40pD41BfT/q6rwfuswIL8S5uZxSXf
         /bEKg0zqzfiwZz90jyQ/XbryjYTAamSd24rufQQSQ2gysIVjcN9fJi7JI9H20YF3QEpu
         gaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676332114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4/KLmeiyzkFaWHLQHMIS71Qo+cLPHUap+RacncgWAU=;
        b=J4UJsD4PvfSGdR+e+Brwi9HXHRGBEQYk9KYZKtdwLjDW4bbswhhYx0OrLOfAM5N4QI
         IK5HVErtoqEBQ3+Bu92n6IoImt/uTTG51jL4pE1jdrQgBW0nX4HZYGALnz2jAQneJ5pl
         2IDG3wBOLrvLV0oJG+qV2s9bnq2YCc1Uwi007jfH/pxLEBuR4OJD+I6ciecLZBbwiKUd
         FU/N4sOfMapnmbIcQRQM9S4VghCmLzuicQzz9ZgIGZHGneM/PGQoziySuFc9XTSN3lb7
         NDdXXnDxI2lGeMEnPfvXt5ZS2OofSHguI68SHPxzvHQMytroj01wy2CeVHOsmKJmj/5c
         eC2g==
X-Gm-Message-State: AO0yUKVDcHeI3Z4k87sBmF7naqADPT4AphoURf1/lYX8/wTXnzHigGD2
        iOnHc+c/4ba6YoME7PiZRe3tLfYmeFE7qHCs17u0HQ==
X-Google-Smtp-Source: AK7set8NrfoDWyLvgVsdmI12G/+XDZGTYBU4S49iMKrs6M1v5fPz1MotcMn2Hh8ji8y/s1zil+e6QxDtDAnegcw9+xw=
X-Received: by 2002:a17:902:d506:b0:198:99b5:cabf with SMTP id
 b6-20020a170902d50600b0019899b5cabfmr169759plg.25.1676332114545; Mon, 13 Feb
 2023 15:48:34 -0800 (PST)
MIME-Version: 1.0
References: <e7880df5-43ab-d6b5-0ac3-440adfb12808@gmail.com>
In-Reply-To: <e7880df5-43ab-d6b5-0ac3-440adfb12808@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 00:47:58 +0100
Message-ID: <CAPDyKFo75bm2NwCJfGU0QKDEQkROk-Rv5oh_ZE3YgW2AhNhUEg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: add and use devm_mmc_alloc_host
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 4 Feb 2023 at 00:50, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Add and use a device-managed version of mmc_alloc_host.
>
> Heiner Kallweit (2):
>   mmc: core: add devm_mmc_alloc_host
>   mmc: meson-gx: use devm_mmc_alloc_host
>
>  drivers/mmc/core/host.c         | 26 +++++++++++++++++
>  drivers/mmc/host/meson-gx-mmc.c | 52 +++++++++++----------------------
>  include/linux/mmc/host.h        |  1 +
>  3 files changed, 44 insertions(+), 35 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
