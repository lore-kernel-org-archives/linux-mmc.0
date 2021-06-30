Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46599C11F68
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 11:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261D06186A
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 11:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhF3LxA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 07:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhF3LxA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2021 07:53:00 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97012C061766
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 04:50:30 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id e7so902940uaj.11
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNjOFC42dVTuRLbeEDNPw5/FJjb9ILqGXXwyu4K01jQ=;
        b=W5EfTCzR+yhg5BoUx+Iw0ifsBcWqI2f6ubGP5nu69+zVn4HU7Dv9ZhnIZfvaUrALW9
         /jweodx+dgq9E303vgtUZGfxbIXfMS2AfnJNG1yYc17uHbJADlmtwGaozr/bEoohfc4q
         HJ9IqHTYir7QIzdOz6aO/uVd/Cp70zB7llEn+HHSvGtYyKQ7luF5HVynp6UB4xAPtEno
         oYrGVisKN2l8M5bR71izkg83bEgekrDEZs69utNGm6SMBd4GP1fpIOTv0auosrelkQ4h
         GO5SE5Ai7iAmXwoWKp1rvUcdBgTwt9jSxT7MgKXXdpuNbgnnjyQAmpGdCsj7OoElszYA
         Yr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNjOFC42dVTuRLbeEDNPw5/FJjb9ILqGXXwyu4K01jQ=;
        b=Xb59YVDUEBymBLS8wbkSulHpubnx8SQyJrlsAS1m52tH5H7zEgmkoZSwLKrd6TnKmj
         ejl/ueuXdUO2ijtNuXKgZ87bb3kv4JoilV0BU8PI0VIlg3nLE4hkk5G1jw9pSqGwVBYW
         JQlzXweS7Z02PsR7YK/cVGBQfK47WGqxf9Mf0QDZYMwnYnU0aszEQ9XSWnh5nz3aO4rB
         0yGRBJDl1wiN5Pc7zDavY1QrSaaw2E2VQ4b8aKoKXsjL6lEz+6Ng7ThS7gcTiM3eFOQu
         8cdAHxunL61eOeIi5fT2392koiMw9Nlz65J4Tr21mqpdGQNRKxuqi+o1FzzkszRNnu43
         gX8Q==
X-Gm-Message-State: AOAM532tY+W5RX4KgqIAY3hKXtnDK0ppq072o1Pabv9phOU9I81MSUGY
        ChMfJepGyqz5fbpfkJAIsUjoZEsQC4B6kTWuxh7+Xw==
X-Google-Smtp-Source: ABdhPJxoZ6CQOc+5kbzZKErZ4ocRcQG8KmEcK9oqc/iJTeXoqvusCBZUajIThZnhpQViRowNdrH6TiKQl61uOMVAm10=
X-Received: by 2002:ab0:6296:: with SMTP id z22mr8659820uao.129.1625053829627;
 Wed, 30 Jun 2021 04:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210628232955.3327484-1-linus.walleij@linaro.org>
 <CAPDyKFpfJC=KAZ5dGAso2zcgBic4uCkOiDFQ0ZA5Zi7UDUeEug@mail.gmail.com> <CACRpkdY4kegTzeqPHNEd3=hOdqSXAvJq+LehLbf09mUybU0VfA@mail.gmail.com>
In-Reply-To: <CACRpkdY4kegTzeqPHNEd3=hOdqSXAvJq+LehLbf09mUybU0VfA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jun 2021 13:49:52 +0200
Message-ID: <CAPDyKFoj47-4XuKbV6jYkJ2pesAfHK999vudWDGTQA-J5eQXrg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add a card quirk for broken boot partitions
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>, phone-devel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>, newbyte@disroot.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 29 Jun 2021 at 19:23, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Jun 29, 2021 at 3:56 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > I would
> > prefer some more details before I am ready to apply this. For example,
> > more exactly, what happens when the stall is triggered? Can you
> > provide some more debug info, perhaps with the sequence of commands
> > that triggers the error?
>
> I have added debug prints and it looks like this, first tons of normal
> traffick switching between the different partitions with CMD6,
> both 0 (main), 1 (boot0) and 2 (boot1) are investigated before
> results. At the end of the trail this happens:
>
> [   54.171173] mmc_host mmc2: start CMD18 arg 00005010
> [   54.171478] mmc_host mmc2: start CMD18 arg 00005028
> [   54.172058] mmc_host mmc2: start CMD18 arg 00005048
> [   54.172790] mmc_host mmc2: start CMD18 arg 00005088
> [   54.174926] mmc_host mmc2: start CMD18 arg 00005108
> [   54.177581] mmc_host mmc2: start CMD18 arg 00015038
> [   54.178039] mmc_host mmc2: start CMD18 arg 00066400
> [   54.178222] mmc_host mmc2: start CMD18 arg 00004880
> [   54.178497] mmc_host mmc2: start CMD18 arg 00000040
> [   54.178649] mmc_host mmc2: start CMD18 arg 00015078
> [   54.178894] mmc_host mmc2: start CMD18 arg 00066800
> [   54.179382] mmc2: modify EXT_CSD, index 179, value: 1, set 1, timing 0
> [   54.179412] mmc_host mmc2: start CMD6 arg 03b30101
> [   54.180145] mmc2 modify EXT_CSD completed (0)
> [   54.180175] mmc_host mmc2: start CMD13 arg 00010000
> [   54.180267] mmc_host mmc2: start CMD18 arg 00001ff0
> [   54.180755] mmc2: modify EXT_CSD, index 179, value: 0, set 1, timing 0
> [   54.180786] mmc_host mmc2: start CMD6 arg 03b30001
> [   54.180847] mmc2 modify EXT_CSD completed (0)
> [   54.180847] mmc_host mmc2: start CMD13 arg 00010000
> [   54.180938] mmc_host mmc2: start CMD18 arg 00015010
> [   54.181121] mmc_host mmc2: start CMD18 arg 00015028
> [   54.181365] mmc_host mmc2: start CMD18 arg 00015048
> [   54.182312] mmc_host mmc2: start CMD18 arg 00015088
> [   54.183654] mmc_host mmc2: start CMD18 arg 00015108
> [   54.186187] mmc_host mmc2: start CMD18 arg 00066018
> [   54.186767] mmc_host mmc2: start CMD18 arg 00004900
> [   54.186950] mmc_host mmc2: start CMD18 arg 00000080
> [   54.187225] mmc_host mmc2: start CMD18 arg 00066038
> [   54.187469] mmc_host mmc2: start CMD18 arg 00004a00
> [   54.187713] mmc_host mmc2: start CMD18 arg 00066078
> [   54.187988] mmc_host mmc2: start CMD18 arg 00004c00
> [   54.188293] mmc2: modify EXT_CSD, index 179, value: 1, set 1, timing 0
> [   54.188323] mmc_host mmc2: start CMD6 arg 03b30101
> [   54.188354] mmc2 modify EXT_CSD completed (0)
> [   54.188385] mmc_host mmc2: start CMD13 arg 00010000
> [   54.188446] mmc_host mmc2: start CMD18 arg 00000000
> [   54.189300] mmc2: modify EXT_CSD, index 179, value: 0, set 1, timing 0
> [   54.189331] mmc_host mmc2: start CMD6 arg 03b30001
>
> After this CMD6 just hangs there. Nothing proceeds on mmc2 (the eMMC)
> ever again.
>
> > Moreover, it would be nice to know exactly where in the code the stall
> > happens. Could it be that it's the mmc_wait_for_cmd() that never
> > returns in __mmc_switch(), when sending the CMD6 to switch the
> > partition?
>
> __mmc_switch() initiates a partition switch, then
> issues CMD6. Then:
>
> __mmc_switch()
>   mmc_wait_for_cmd()
>     mmc_wait_for_req()
>     __mmc_start_req()
>       mmc_wait_for_req_done()
>
> We wait forever in mmc_wait_for_req_done() since the completion
> never arrives.

Thanks for sharing these details. It looks like the mmci driver is
waiting for the busy completion IRQ, forever.

>
> > My main worry is that we should not set a card quirk for an eMMC that
> > could be working fine (on some other platforms), that's why I want us
> > to be sure.
>
> Yes we need to get to the bottom of this.
>
> One theory as we discussed on chat is that the busy detect
> for the previous command isn't working as it should leading us
> to prematurely start CMD6 while the previous CMD18 is actually still
> busy.
>
> After testing, this appears to be true!
>
> I disabled hardware busy detect in mmci.c like this:
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 984d35055156..cffe95e32b9a 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -180,10 +180,10 @@ static struct variant_data variant_ux500 = {
>         .f_max                  = 100000000,
>         .signal_direction       = true,
>         .pwrreg_clkgate         = true,
> -       .busy_detect            = true,
> -       .busy_dpsm_flag         = MCI_DPSM_ST_BUSYMODE,
> -       .busy_detect_flag       = MCI_ST_CARDBUSY,
> -       .busy_detect_mask       = MCI_ST_BUSYENDMASK,
> +       //.busy_detect          = true,
> +       //.busy_dpsm_flag               = MCI_DPSM_ST_BUSYMODE,
> +       //.busy_detect_flag     = MCI_ST_CARDBUSY,
> +       //.busy_detect_mask     = MCI_ST_BUSYENDMASK,
>         .pwrreg_nopower         = true,
>         .mmcimask1              = true,
>         .irq_pio_mask           = MCI_IRQ_PIO_MASK,
> @@ -215,10 +215,10 @@ static struct variant_data variant_ux500v2 = {
>         .f_max                  = 100000000,
>         .signal_direction       = true,
>         .pwrreg_clkgate         = true,
> -       .busy_detect            = true,
> -       .busy_dpsm_flag         = MCI_DPSM_ST_BUSYMODE,
> -       .busy_detect_flag       = MCI_ST_CARDBUSY,
> -       .busy_detect_mask       = MCI_ST_BUSYENDMASK,
> +       // .busy_detect         = true,
> +       //.busy_dpsm_flag               = MCI_DPSM_ST_BUSYMODE,
> +       //.busy_detect_flag     = MCI_ST_CARDBUSY,
> +       //.busy_detect_mask     = MCI_ST_BUSYENDMASK,
>         .pwrreg_nopower         = true,
>         .mmcimask1              = true,
>         .irq_pio_mask           = MCI_IRQ_PIO_MASK,
>
> Now it works.

Alright, this certainly brings us a bit closer to a fix.

Either the HW busy detection isn't working properly in mmci or the
eMMC card is behaving a bit odd (continues to deassert the DAT0 line
forever).

What certainly is missing in the mmci driver, is a software based
timeout for cases like these. The mmci driver should better complete
the request with -ETIMEDOUT error for the cmd, rather than hanging
forever and waiting for the busy completion IRQ.

>
> So now I am thinking about a quirk that disables hardware busy
> detect on some older eMMC cards instead, my current
> assumption is that the hardware busy detect on these eMMCs
> is glitchy. It works a bit but not good enough.
>
> I think you also mentioned the timeout in EXT_CSD maybe not being
> long enough? How do I play around with this?
> MMC_QUIRK_LONG_READ_TIME?

As mmci doesn't care about busy timeouts, but waits forever, this is
likely not the problem.

However, I would like to try to narrow down the problem even further.
Would you mind try the below debug patch?

--

Subject: [PATCH] mmc: mmci: HACK/DEBUG: Drop IRQ based HW busy detect

This change make MMC_CAP_WAIT_WHILE_BUSY to become unset, but keeps the
->card_busy ops. In this way, the core will sometimes (for CMD6 for
example), use this callback rather than polling with CMD13.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 984d35055156..cbc67c0e64b1 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -180,7 +180,7 @@ static struct variant_data variant_ux500 = {
        .f_max                  = 100000000,
        .signal_direction       = true,
        .pwrreg_clkgate         = true,
-       .busy_detect            = true,
+       .busy_detect            = false,
        .busy_dpsm_flag         = MCI_DPSM_ST_BUSYMODE,
        .busy_detect_flag       = MCI_ST_CARDBUSY,
        .busy_detect_mask       = MCI_ST_BUSYENDMASK,
@@ -215,7 +215,7 @@ static struct variant_data variant_ux500v2 = {
        .f_max                  = 100000000,
        .signal_direction       = true,
        .pwrreg_clkgate         = true,
-       .busy_detect            = true,
+       .busy_detect            = false,
        .busy_dpsm_flag         = MCI_DPSM_ST_BUSYMODE,
        .busy_detect_flag       = MCI_ST_CARDBUSY,
        .busy_detect_mask       = MCI_ST_BUSYENDMASK,
@@ -2143,7 +2143,7 @@ static int mmci_probe(struct amba_device *dev,
        /*
         * Enable busy detection.
         */
-       if (variant->busy_detect) {
+//     if (variant->busy_detect) {
                mmci_ops.card_busy = mmci_card_busy;
                /*
                 * Not all variants have a flag to enable busy detection
@@ -2152,8 +2152,8 @@ static int mmci_probe(struct amba_device *dev,
                if (variant->busy_dpsm_flag)
                        mmci_write_datactrlreg(host,
                                               host->variant->busy_dpsm_flag);
-               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
-       }
+//             mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+//     }

        /* Variants with mandatory busy timeout in HW needs R1B responses. */
        if (variant->busy_timeout)
-- 

Kind regards
Uffe
