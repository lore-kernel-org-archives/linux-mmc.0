Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632FBC07E96
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 09:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B97561999
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 09:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhGFJhz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Jul 2021 05:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhGFJhy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2021 05:37:54 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9499C061574
        for <linux-mmc@vger.kernel.org>; Tue,  6 Jul 2021 02:35:12 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id r9so8025135ual.7
        for <linux-mmc@vger.kernel.org>; Tue, 06 Jul 2021 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SXqwOn58K4bez2IaGk1hVoc+0xrkve7opqyDbkX7Ms4=;
        b=tymmw5VmQEBCE986F9OJ8F5dTtj4590Z3nqXzjYUTNo0Tiyb9C0sFF9kHTledf4evn
         6PvenrC7i/9tWPieXAgP01bkaOFWMgsUJ1SYzBofhVD8bcpx4zJYhHYUCTKqWXbOR0Fi
         4eK7mun6PtvclC4AWKToLEbHW2bRCZAHnkQ8ucAJ91f8dMgqlHWX8s57THckO4ldr7+F
         OKIKeC4SoKNkxPK2tbVVh3k0XQqsiTdXBNl7eE39n/5M86wVMd+h2ONL2dPQvPgAomaP
         ALaS4gamp5uI+WYhUhtT7By5ceqQs3zpaLE+1ZHlIL4EYiUPbuXYwbrZKKQ+Kc5Jsbso
         Lqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SXqwOn58K4bez2IaGk1hVoc+0xrkve7opqyDbkX7Ms4=;
        b=oZ5JQQix4Zfab0dAoVOlapjH6dSoqPbGM1s80L1vzMHaeHMxhJx/rizyTSjnwRcl2c
         EZP15POK5uaAGeFPLeSKUceCoTYbZY1eNieDTbF3wdMOB47ZpYmgOU4iizh+BrF6luPM
         qjWncLnHsESddOb1R/ATBmMo3rQ2kYrGSm9K2pp00SENVB2XAPqNQ2nJgcKVRf0EOfa8
         SYw5YQI8iQRLbHOGWLyqgFxXfRTrN04lo94mSrZkhPhkXjGpXiRr6ErckeSubMeBWdHJ
         tjg8dfoSDYIVW7MafBNtsSDI/gK033bV4CQW1ewT0cfgxtUc5vGO3uuydmqieAoU3piE
         W4TQ==
X-Gm-Message-State: AOAM533beOnkXH0j/aKyLPIAgflONgbUefgJr09lL/mbKoRbefyF1j0x
        wWVCGFr/1X2Jr0yzhMXPkO7hCDqBNzfzt2yGhcbJ6w==
X-Google-Smtp-Source: ABdhPJzYZij73W64wi+SYiXYynJ/JRSXn6bM612f+3l4Wpzg6H2eDk4zuUvR7jGIZsYLPRAbMGvp1xqPWbqYjQSO1a4=
X-Received: by 2002:ab0:76d0:: with SMTP id w16mr5882760uaq.15.1625564111999;
 Tue, 06 Jul 2021 02:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com> <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 6 Jul 2021 11:34:35 +0200
Message-ID: <CAPDyKFpAULWZTfWGutpJY+qrRJP1+XpKwsjFUXGG7+xyrKsvxg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Differentiate busy and non-TRAN state
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 6 Jul 2021 at 11:09, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Hey Uffe,
>
> >> +static int is_return_to_tran_cmd(struct mmc_command *cmd)
> >> +{
> >> +       /*
> >> +        * Cards will never return to TRAN after completing
> >> +        * identification commands or MMC_SEND_STATUS if they are not =
selected.
> >> +        */
> >> +       switch (cmd->opcode) {
> >> +       case MMC_GO_IDLE_STATE:
> >> +       case MMC_SEND_OP_COND:
> >> +       case MMC_ALL_SEND_CID:
> >> +       case MMC_SET_RELATIVE_ADDR:
> >> +       case MMC_SET_DSR:
> >> +       case MMC_SLEEP_AWAKE:
> >> +       case MMC_SELECT_CARD:
> >> +       case MMC_SEND_CSD:
> >> +       case MMC_SEND_CID:
> >> +       case MMC_SEND_STATUS:
> >> +       case MMC_GO_INACTIVE_STATE:
> >> +       case MMC_APP_CMD:
> >> +               return false;
> >> +       default:
> >> +               return true;
> >> +       }
> >> +}
> >>
> >What exactly are you trying to do with the user space program through
> >the mmc ioctl with all these commands? The mmc ioctl interface is not
> >designed to be used like that.
> >
> >In principle, it looks like we should support a complete
> >re-initialization of the card. I am sorry, but no thanks! This doesn't
> >work, but more importantly, this should be managed solely by the
> >kernel, in my opinion.
>
> Doing initialization itself through ioctl is silly, I agree, and does
> not work on other ends. This patch is not about that. it just explicitly =
disables
> any CMD13 polling for TRAN for some of those commands. the behavior
> for such commands thus is the same as without the patch.

You are right.

But, what I think is bothering me with the approach, is that it looks
like we are starting to add special treatment of a whole bunch of
different commands.

> The reason for this patch is to not run into the race condition that a
> following (ioctl) command will be rejected because the card is in e.g. PR=
OG state
> of a previous ioctl command. As stated earlier, I encountered this a lot =
when
> doing a unlock force erase -> lock/set, in both scenarios, issued as two =
single
> ioctl commands and bundled together.

I understand. I would rather see a patch that adds support, explicitly
for this case.

> But this race condition exists on any (non-R1b/ RPBM) currently. As there=
 is
> no CMD13 polling happening after the response (or whenever the driver mar=
ks
> the request as done), the card's status is therefore generally unknown.

So the commands to unlock/lock, etc, don't have R1B, but can still
cause the card to become busy after the response has been delivered,
right?

As I said, then please add this as an explicit check to do polling,
then I would be happy. :-)

>
> So in short I don;t want to do anything too crazy from userspace, but the
> alternative now is to do like 100ms sleeps in the hope that the card is
> actually finished with the issued command (not just the host driver so to=
 say).

Yeah, that sounds suboptimal, we can do better than that.

Kind regards
Uffe
