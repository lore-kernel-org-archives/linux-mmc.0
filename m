Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B29EB64D8
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 15:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjFTPuM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjFTPuA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 11:50:00 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8862FE72
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 08:49:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bcc29cdcdc9so4901972276.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687276172; x=1689868172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7hSwWr4ilbhNVRAbZ4VQSJviq6a2rgWHoZh27c9gZiM=;
        b=BsRT4IKL1+abd2TIQLoG3oZy7f74BTePBHX5gGyvOK/V//QFzEWc3ZRhCG5b+ZsBPS
         u19EJ1GGmXNj9WNdhG9MD0QvsHUjH9QohfzIXtZOJXuQzQ02vMuPQVEas3nRm3w0XT0n
         iu1pXNYPFv07C7b+NNMl25E1VtM4ipS1cQOaagdUhBQFtDhv38qbQJNXmOWN800uhRfZ
         tJVFugYtU86OgqSRnLo0lMP+wCCicS8G3f/7+ExGtyeJRC5hDlJ//bhZlyVdQaEq/xw0
         YahNIp6njhAIa5e7yU5RdU2XrIEfNMf76ZOAZ8fnYxu0qewSlAjByLTQiaZFBEU9gYya
         BD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687276172; x=1689868172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hSwWr4ilbhNVRAbZ4VQSJviq6a2rgWHoZh27c9gZiM=;
        b=FwzzdySvSLeBLpra+5tp5laX7KvH4qnAJKHiyPMbFQBD8cUJKhWxCFPdKCKLW3t8CM
         fVGTBwQq+e7+oNUIFR+bjNXcZe4t6qGUGzqg9ztM2efLYl4r2w/pjY+kCPMFrVOzXzQe
         RZBIAL85N++/wVJYABMY+Jj/fryameX7wNguj1GITw7cIHQ+ao7kTYRTELa0n0tQkZNV
         J3/dMiUOR8fm1Rfd7gec0FKNBq5edK0XuNvIxq7iWfLB6gvLOMtVp9qQbe0LP5LL/Wpg
         3R8zVGCcnnTCPHdbfjHYzY5xtS3aS7+C2RldYiK2WJBFmgIeULBUAizvolu9n32Gxh+f
         cTqA==
X-Gm-Message-State: AC+VfDxVeJDcJOJI6KhG46isnPEjsPFJIYv5MFY5nOdkQs+3fTVdSoqf
        d+tRpbyYyF7WfHq0mepL6doyhPEjOEvoCuPUMJZW6Q==
X-Google-Smtp-Source: ACHHUZ65UwmZUZ02+o6V2mSvQ1sXOCKh789ZbmRzYwoK0LX0SaJAmg4+EimQIu1LAouSz0leUPYNQNWCFRNjtXM+w98=
X-Received: by 2002:a25:a2cb:0:b0:bf5:76c:d654 with SMTP id
 c11-20020a25a2cb000000b00bf5076cd654mr4012673ybn.14.1687276172420; Tue, 20
 Jun 2023 08:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <461dba105f644867a6687858d51324e8@hyperstone.com>
 <CAPDyKFr7=z5RyeOOBiSaGrtHRxCrTHqwYvMsUjgGmn7cvLa3ZA@mail.gmail.com> <0bb75439f50b4e3e99b31956a6f43c45@hyperstone.com>
In-Reply-To: <0bb75439f50b4e3e99b31956a6f43c45@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Jun 2023 17:48:56 +0200
Message-ID: <CAPDyKFq=x4M1o6dVr-op_zZuiJB00TOCMsUcwFoz0Y6e4DJL5Q@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] mmc: block: ioctl: Add PROG-error aggregation
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Jun 2023 at 13:23, Christian Loehle <CLoehle@hyperstone.com> wrote:
>
> >>
> >> Userspace currently has no way of checking for error bits of detection
> >> mode X. These are error bits that are only detected by the card when
> >> executing the command. For e.g. a sanitize operation this may be
> >> minutes after the RSP was seen by the host.
> >>
> >> Currently userspace programs cannot see these error bits reliably.
> >> They could issue a multi ioctl cmd with a CMD13 immediately following
> >> it, but since errors of detection mode X are automatically cleared
> >> (they are all clear condition B).
> >> mmc_poll_for_busy of the first ioctl may have already hidden such an
> >> error flag.
> >>
> >> In case of the security operations: sanitize, secure erases and RPMB
> >> writes, this could lead to the operation not being performed
> >> successfully by the card with the user not knowing.
> >> If the user trusts that this operation is completed (e.g. their data
> >> is sanitized), this could be a security issue.
> >> An attacker could e.g. provoke a eMMC (VCC) flash fail, where a
> >> successful sanitize of a card is not possible. A card may move out of
> >> PROG state but issue a bit 19 R1 error.
> >>
> >> This patch therefore will also have the consequence of a mmc-utils
> >> patch, which enables the bit for the security-sensitive operations.
> >>
> >> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> >> ---
> >>  drivers/mmc/core/block.c   | 17 ++++++-----------
> >>  drivers/mmc/core/mmc_ops.c | 25 ++++++++++++++++++++++++-
> >> drivers/mmc/core/mmc_ops.h |  3 +++
> >>  3 files changed, 33 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> >> e46330815484..44c1b2825032 100644
> >> --- a/drivers/mmc/core/block.c
> >> +++ b/drivers/mmc/core/block.c
> >> @@ -470,7 +470,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> >>         struct mmc_data data = {};
> >>         struct mmc_request mrq = {};
> >>         struct scatterlist sg;
> >> -       bool r1b_resp, use_r1b_resp = false;
> >> +       bool r1b_resp;
> >>         unsigned int busy_timeout_ms;
> >>         int err;
> >>         unsigned int target_part;
> >> @@ -551,8 +551,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> >>         busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
> >>         r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
> >>         if (r1b_resp)
> >> -               use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
> >> -                                                   busy_timeout_ms);
> >> +               mmc_prepare_busy_cmd(card->host, &cmd,
> >> + busy_timeout_ms);
> >>
> >>         mmc_wait_for_req(card->host, &mrq);
> >>         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp)); @@
> >> -605,19 +604,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> >>         if (idata->ic.postsleep_min_us)
> >>                 usleep_range(idata->ic.postsleep_min_us,
> >> idata->ic.postsleep_max_us);
> >>
> >> -       /* No need to poll when using HW busy detection. */
> >> -       if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
> >> -               return 0;
> >> -
> >>         if (mmc_host_is_spi(card->host)) {
> >>                 if (idata->ic.write_flag || r1b_resp || cmd.flags & MMC_RSP_SPI_BUSY)
> >>                         return mmc_spi_err_check(card);
> >>                 return err;
> >>         }
> >> -       /* Ensure RPMB/R1B command has completed by polling with CMD13. */
> >> -       if (idata->rpmb || r1b_resp)
> >> -               err = mmc_poll_for_busy(card, busy_timeout_ms, false,
> >> -                                       MMC_BUSY_IO);
> >> +       /* Poll for write/R1B execution errors */
> >> +       if (idata->ic.write_flag || r1b_resp)
> >
> > Earlier we polled for requests that were targeted to rpmb, no matter if they were write or reads. Are you intentionally changing this? If so, can you explain why?
> >
> Will re-introduce. I cant really think of a reason right now to do this after rpmb reads, but thats a different story.

Okay, good.

My main point is, if we want to change that, let's do that as a separate patch.

>
> >> +               err = mmc_poll_for_busy_err_flags(card, busy_timeout_ms, false,
> >> +                                       MMC_BUSY_IO,
> >> + &idata->ic.response[0]);
> >
> > I think it's better to extend the mmc_blk_busy_cb, rather than introducing an entirely new polling function.
> >
> > Then you can call __mmc_poll_for_busy() here instead.
>
> Not sure if I understood you right, but I will send a new version with __mmc_poll_for_busy call directly.
> It does feel a bit more awkward, at least to me, because both mmc_blk_busy_cb nor mmc_busy_data are currently only in mmc_ops.c
>
> Anyway, both versions "extend the mmc_blk_busy_cb", so I'm not sure if I understood you correctly, we will see.
> I may also just send both and you pick whichever you prefer.

I was thinking that mmc_blk_card_busy() calls __mmc_poll_for_busy().
While doing that, it uses the mmc_blk_busy_cb() - which seems to be
almost what we want to do here too.

Did that make sense?

Kind regards
Uffe
