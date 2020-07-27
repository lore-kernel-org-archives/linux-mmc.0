Return-Path: <SRS0=9Cpo=BG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9EEC433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 13:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B9E2075D
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 13:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvOvj+Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgG0NHR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgG0NHQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jul 2020 09:07:16 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5FCC061794;
        Mon, 27 Jul 2020 06:07:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id t15so7906676iob.3;
        Mon, 27 Jul 2020 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZMT77cXyIf8o3Kv5pnkOiKLA7QiIyOJPRSG8N3FczU=;
        b=VvOvj+Kr5KkS5Nt3JgT0QY7/b5IhqGYps36VKH7Io4LT0OPWTHX1mo8bUjRIY1IVjm
         8RoZ+m54ZTEVnt448MWZV8tyhCXnBTn/0pEKELJhPWRx52Gyk/h4z6/QL+s2If9KQM1b
         1Wy24Sx/+ZyXaMfuLaus3MD98zhHMMyCdOF6My3PQ1hw8kZjqHdTLIY5nTUSEwhtaxhG
         AeM/i5vP9xyrfpv9wZUkC1A3XldEIt8SV5RzgpBjNTIjSMOipfHmmCs+CV+aunLvithJ
         Pd7Y5tMXyb7vaic3UjS4EmpDNyVly4QMp+ZU9gvX19X/8aIK2s8S/STNlG4HMNSiYyXr
         RV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZMT77cXyIf8o3Kv5pnkOiKLA7QiIyOJPRSG8N3FczU=;
        b=ncJimWlTGv8xBkZyUInhvD6nhJOkjh9ClWl8N8piqMIikamZFviVSb16lCvZQTKRnR
         dmUBzaR/cZj6i0xtn6rlOkrDWPXCEjU8jezONxYvD3/zV3VIMDnL+CyV4mQMXp7HfsSJ
         Eq4P4+DnzRMZWmetBsu3YRfe6Kzi7epgOaPelDKMdJEnYtj4uhA4RD8gpXmJ7jelLTDE
         xT1p7x8hN7rqK0nWqWjmn7ax1MYSOM8+8bMftfA2HUfiz5x1xEDyAEl1bAhiZI1Hi4OB
         8m595HNdgJDt311xiqawjjOsl5KVSkjSn3FJStYsCuw2w7w13fCODnAIBMY4Al5H1O8a
         ez3g==
X-Gm-Message-State: AOAM530mAiZFbjenZ9cT4yCd8gOVxwVHrpcdAQ03Jkq7R90J3BjyDFub
        1GgcFzQ+S62nuA4TxeIMU/7JGVgmAzIJDD1VtcM=
X-Google-Smtp-Source: ABdhPJxhk4CJU4kBGdqd7bmOvbbBBHwyqnEzNjMSwIuJLqX68UmkOEjkksIx1pQRISL2y+rRKikjezzOp19eClvEYBg=
X-Received: by 2002:a5d:9d11:: with SMTP id j17mr13689385ioj.140.1595855235827;
 Mon, 27 Jul 2020 06:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200721191718.29414-1-alcooperx@gmail.com> <CAPDyKFqLX8TvZHZ+0Ytu9BO_56vuPQ+9cvFQCez+mEG-AJWkqQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqLX8TvZHZ+0Ytu9BO_56vuPQ+9cvFQCez+mEG-AJWkqQ@mail.gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Mon, 27 Jul 2020 09:07:04 -0400
Message-ID: <CAOGqxeX=E6WrBUoy3cicFP-=uuxJZRTmyk_qODR=7Chzt9ixTw@mail.gmail.com>
Subject: Re: [PATCH] mmc: Some Micron eMMC devices cause reboot to hang
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bradley Bolen <bradleybolen@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jul 24, 2020 at 7:03 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 21 Jul 2020 at 21:18, Al Cooper <alcooperx@gmail.com> wrote:
> >
> > When using eMMC as the boot device, some Micron eMMC devices will
> > cause reboot to hang. This is a result of the eMMC device not going
> > into boot mode after the hardware sends CMD0 to reset the eMMC
> > device. This only happens if the kernel driver sends CMD5 (SLEEP_WAKE),
> > to put the device into sleep state, before restarting the system.
>
> What do you mean by "boot mode"?

I'm referring to the "Boot operation mode" described in Section 6.3 of
the JEDEC spec.
Our hardware will send a CMD0 with 0xf0f0f0f0 argument at powerup or
when the SoC is reset, and then hold the CLK signal low for 74 clock
cycles. This should put the eMMC device into boot mode where it
streams consecutive blocks without additional commands. With this
Micron device I find that if I send a CMD5 before trying to restart
the system by resetting the SoC, that the system hangs. I worked with
Micron on the issue and they finally said to either avoid sending the
CMD5 on restart or use a newer version of the Micron eMMC device.


>
> When the kernel sends the CMD0 to wake up the eMMC from sleep, at
> system resume for example, it all works fine, I guess. What is the
> difference?

On system resume the hardware will not try to put the eMMC device back
into boot mode.

Al

>
> > The fix is to add a quirk that avoids sending the SLEEP command
> > and to use MMC_FIXUP to set the quirk for these Micron devices.
>
> I am not sure this is Micron device specific, but rather some it's a
> driver/platform bug. Maybe on the kernel side or in the bootloader
> code.
>
> But, let's see where the discussion leads us.
>
> Kind regards
> Uffe
>
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >  drivers/mmc/core/mmc.c    | 3 ++-
> >  drivers/mmc/core/quirks.h | 8 ++++++++
> >  include/linux/mmc/card.h  | 1 +
> >  3 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 4203303f946a..4d69e8f8fe59 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1895,7 +1895,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >
> >  static int mmc_can_sleep(struct mmc_card *card)
> >  {
> > -       return (card && card->ext_csd.rev >= 3);
> > +       return card && card->ext_csd.rev >= 3 &&
> > +               ((card->quirks & MMC_QUIRK_BROKEN_SLEEP) == 0);
> >  }
> >
> >  static int mmc_sleep(struct mmc_host *host)
> > diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> > index 472fa2fdcf13..7263187b6323 100644
> > --- a/drivers/mmc/core/quirks.h
> > +++ b/drivers/mmc/core/quirks.h
> > @@ -99,6 +99,14 @@ static const struct mmc_fixup mmc_blk_fixups[] = {
> >         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
> >                   MMC_QUIRK_TRIM_BROKEN),
> >
> > +       /*
> > +        * Some Micron eMMC devices will not go into boot mode on
> > +        * CMD0 arg: 0XF0F0F0F0 after going into SLEEP state.
> > +        * This will hang a reboot.
> > +        */
> > +       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_NUMONYX, 0x014e, add_quirk_mmc,
> > +                 MMC_QUIRK_BROKEN_SLEEP),
> > +
> >         END_FIXUP
> >  };
> >
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index 7d46411ffaa2..0cdddcb5e17d 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -270,6 +270,7 @@ struct mmc_card {
> >  #define MMC_QUIRK_BROKEN_IRQ_POLLING   (1<<11) /* Polling SDIO_CCCR_INTx could create a fake interrupt */
> >  #define MMC_QUIRK_TRIM_BROKEN  (1<<12)         /* Skip trim */
> >  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
> > +#define MMC_QUIRK_BROKEN_SLEEP (1<<14)         /* Broken sleep mode */
> >
> >         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> >
> > --
> > 2.17.1
> >
