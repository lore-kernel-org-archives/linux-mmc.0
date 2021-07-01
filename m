Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C291C11F67
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F9661405
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 14:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhGAO3b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhGAO3a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jul 2021 10:29:30 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEB3C061762
        for <linux-mmc@vger.kernel.org>; Thu,  1 Jul 2021 07:27:00 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id j8so3948212vsd.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Jul 2021 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKb2oHuQtCvr34mVmTyYe9ky7YLvpZxG+hc+eutVly4=;
        b=Vt7A98F42l3XzjBVe5ztEsvfLiMgYLNvCaiO/qKdvbcM0zWs/XGsIsZuwAgZqgOklw
         7xFRG83syZF30OeyVUfjW1ni7Nq7KWQJs6kIrpi07yKDaxj1nAsD499riaJSQBpBRrrP
         4T2S8xoCBHlh0zR0ORstFWcqY1GUxZIpYFkQs7MkTbD2b1EjrCXhoe+xUrnk3+sZm502
         nAjJ5w/fyYhJX9bVwh4ZBezUxO+aIpcj3fa6k6OIyxdpal/MKqDVICz0w9yXXPiHqWV6
         g71putydqhfp6DG3MdrOxYwFrJAsYM4TLpxKNBe8dgVE1mxpNOueTuFOD7PTswP/htKD
         VsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKb2oHuQtCvr34mVmTyYe9ky7YLvpZxG+hc+eutVly4=;
        b=MuTqRMewkdF5Xny4aQ1KS1w1t+yG2KSx/HFL/r6iN2gGdGf4T56ZEPxlp/PhuVZdsX
         Kb4F462uWCjX1Ht+LkI63WYZT+Hoq66pBtCOzdwVvXC72/MsHw+EUUlp5ng75ezWTsRK
         LApUbZj4klIo929rVN1QeIc5yoVmmn4PqopYaO6B0al7C0qMLzYMdzparmpNCp+TfjXr
         3zFApSC212pN3ZxA8cVbPBJdYzSD7mLrVTmMiTQ+dEhHslWUXjR0wQizDauJRNSJN1DN
         ZH86BMQN2CkbbUvtsQsWdHVem6fO0IOJlS3AqBcbuPpfAzNJrHkTRR3eHhLj/rfWHLuA
         Q1sw==
X-Gm-Message-State: AOAM532whZkjH+U67MyRGqLFBA84gTEeh4Eb3e4AEYbZGoN23hPToozz
        QvPPPgi2FDYgm+74DCrAV3qsQfSuSfZk+wNCRywb8Q==
X-Google-Smtp-Source: ABdhPJw2qr1UaeUQ4Cg/StVKeNkNBv115OPSju/bwFZjI+VwBWFkQHzeoCWEAGjur7XcRWUJ0rUl1/PhUDB+UFkb6rY=
X-Received: by 2002:a67:8783:: with SMTP id j125mr436256vsd.42.1625149619142;
 Thu, 01 Jul 2021 07:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210628232955.3327484-1-linus.walleij@linaro.org>
 <CAPDyKFpfJC=KAZ5dGAso2zcgBic4uCkOiDFQ0ZA5Zi7UDUeEug@mail.gmail.com>
 <CACRpkdY4kegTzeqPHNEd3=hOdqSXAvJq+LehLbf09mUybU0VfA@mail.gmail.com>
 <CAPDyKFoj47-4XuKbV6jYkJ2pesAfHK999vudWDGTQA-J5eQXrg@mail.gmail.com>
 <CACRpkdYX5RiUy7u_SeCqhytbyL1Ta9iVmx500uwAq8sNmW+3Ug@mail.gmail.com>
 <CAPDyKForEi09uyXL4nDn27bth+btEYAhzd6+YusMrRBygCdtEA@mail.gmail.com> <CACRpkda7m6HnA7y9coYoXd9YFNjSzAfuYiLNURHe1geb8rF++Q@mail.gmail.com>
In-Reply-To: <CACRpkda7m6HnA7y9coYoXd9YFNjSzAfuYiLNURHe1geb8rF++Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Jul 2021 16:26:22 +0200
Message-ID: <CAPDyKFrK85hCTQwSy114JUqx+As_y6Z567a-Gvqdji7iN1=A-A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add a card quirk for broken boot partitions
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ludovic Barre <ludovic.Barre@st.com>,
        Jean-Nicolas Graux <jean-nicolas.graux@st.com>,
        phone-devel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        newbyte@disroot.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Jean, Ludovic

On Thu, 1 Jul 2021 at 00:33, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jun 30, 2021 at 5:28 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > >         /* Handle busy detection on DAT0 if the variant supports it. */
> > >         if (busy_resp && host->variant->busy_detect)
> > >                 if (!host->ops->busy_complete(host, status, err_msk))
> > >                         return;
> > >
> > > These seemed to be especially problematic to me.
> >
> > Yes, exactly. The IRQ based busy detection code gets disabled with my
> > debug patch.
> >
> > It looks like there are some race conditions in the HW busy detection
> > path for mmci, which gets triggered by this eMMC card.
> (...)
> > Although, it's more optimal to receive an IRQ when busy on DAT0 is
> > de-asserted, rather than polling with ->card_busy(). Hence we also
> > have MMC_CAP_WAIT_WHILE_BUSY.
>
> Hmmmmm it kind of assumes that DAT0 will be de-asserted *before*
> we get a command response, never after. I think that is what the card
> is doing. If that is out-of-spec then we need to have a quirk like
> this but if it is legal behaviour, we rather need to fix the mmci driver.

That's correct and this could very well be the reason why polling
works better for this case.

On the other hand, I am still a bit puzzled why the mmci driver hangs,
waiting for the busy completion IRQ to be raised.

I did some more inspection of the code in ux500_busy_complete() and
found that there may be a potential race condition. I tried to fix it
up, but I don't know if it really makes any difference. Can you please
test the below patch and see if it helps.

---

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Jul 2021 13:12:48 +0200
Subject: [PATCH] mmc: mmci: Fix busy detect completion

One of the pre-conditions to set the ->busy_detect_mask in the MMCIMASK0
register, is to first re-read the MMCISTATUS register to verify that the
->busy_detect_flag is set. The intent is to avoid enabling IRQ based busy
completion if the card does not signal busy.

Assuming the busy_detect_flag is set, we enter a small window before the
actual write of the ->busy_detect_mask hits the HW. In this window, the
->busy_detect_flag in the MMCISTATUS register may change to not indicate
busy any more. This could lead to that we end up waiting for a busy
completion IRQ forever.

Fix this, by writing the ->busy_detect_mask to the MMCIMASK0 first, but
clear it if it turns out that the card wasn't signaling busy.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 984d35055156..122de99759a5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -671,14 +671,20 @@ static bool ux500_busy_complete(struct mmci_host
*host, u32 status, u32 err_msk)
         * while, to allow it to be set, but tests indicates that it
         * isn't needed.
         */
-       if (!host->busy_status && !(status & err_msk) &&
-           (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
-               writel(readl(base + MMCIMASK0) |
-                      host->variant->busy_detect_mask,
+       if (!host->busy_status && !(status & err_msk)) {
+               u32 mask0 = readl(base + MMCIMASK0);
+
+               writel(mask0 | host->variant->busy_detect_mask,
                       base + MMCIMASK0);
+               wmb();

-               host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
-               return false;
+               if (readl(base + MMCISTATUS) &
+                   host->variant->busy_detect_flag) {
+                       host->busy_status = status &
+                                           (MCI_CMDSENT | MCI_CMDRESPEND);
+                       return false;
+               }
+               writel(mask0, base + MMCIMASK0);
        }

        /*
-- 


Kind regards
Uffe
