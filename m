Return-Path: <SRS0=+AiC=5Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B659C43331
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Mar 2020 21:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F26420784
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Mar 2020 21:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYSIeVuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgCaVLw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:11:52 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35904 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaVLw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Mar 2020 17:11:52 -0400
Received: by mail-il1-f193.google.com with SMTP id p13so20889580ilp.3
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2020 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agk2H7S5kZXCkfCYjKPpnf0IbYk2HxsH2aP8Knqb264=;
        b=LYSIeVuQBKUiKcEjhUqzJ0OfBklDSyPHM4bF6SrI3s9JZafKQ0uGkK8XLsumBqBLPn
         V+gukHklrNpC+QYx4RjKgCJBlrH+Vie08ST1HTv51OJzr6Z0hDMUzEx/DGpbgaFdn7sw
         seT2t0M1MyV2xps5SJI0BKDlqL+Zqj818R6QFxBG160a97TTh0AS6ifjTI3nAeC/JH1u
         tL1I1m1w9a4Z6xGhucU6Qe9CtXYqrFjWQ/wESbEHsf6HbjPiyE2Y+knmx9g59x3w96ZI
         Kqbrj2x+oPc+D1DouQA7E64eUALO0Rdq9WbCDWFrGFKdtt34RzShsuEGMgCSnbamomkN
         cPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agk2H7S5kZXCkfCYjKPpnf0IbYk2HxsH2aP8Knqb264=;
        b=EyabLDMjcuw47WmEkl2bkurfz0RNGE50Sv5r1SaBEzQsBPhDx3Ey+z4iBPaCzWLlV3
         R6QMhpvv5H6vaY0VMGMytL5s2SNudDtSNmp5+CMJNDqpjp9xjbnn49SYw8b0YsE25NQM
         jaOqjpV9nCmTWCOjOzo42u1eS6wY6NMNthJezXCWGwFmLeE2XXkDdbr+rfGsL8EDw1ok
         CIjYn0+5tlXATC3MHfZtmnXQP/9mRGQVYe2xzAhgF9l1icPXWoxTgaq8P7n5tZeTVsZ+
         sT5shP8ETUef/SwT/s6lGZWO85VHMuie+kiMEOflRZ68UK3+0Vb+CHb5OeW1553N0EXD
         h4LA==
X-Gm-Message-State: ANhLgQ0pyR1Mc5eUIE5wMzJuj0SIDQLqnpdeMZvaTREsiURxoJKIp3d4
        fGTe0zN3wZcn58u6cD156omcQSLY2JQuc7ZG9wM70Q==
X-Google-Smtp-Source: ADFU+vsXabSTPyagF+SFo6zJwJlGkOe7RZVB+e2mVMH1I7dXPiGJiBTsXSMS63JBGW/ysVzLFaU8clZOcPemEfKOMH0=
X-Received: by 2002:a92:3b11:: with SMTP id i17mr18850078ila.161.1585689111933;
 Tue, 31 Mar 2020 14:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200213221332.2228810-1-patrick.oppenlander@gmail.com> <MN2PR04MB69915A49A1F17BD2DBBD5C29FC170@MN2PR04MB6991.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB69915A49A1F17BD2DBBD5C29FC170@MN2PR04MB6991.namprd04.prod.outlook.com>
From:   Patrick Oppenlander <patrick.oppenlander@gmail.com>
Date:   Wed, 1 Apr 2020 08:11:41 +1100
Message-ID: <CAEg67GnUcAeM=XZteE7YjrchnUjNkZofXZ8oAeekEGxZFdgHsw@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Fix scaling of cache size
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Feb 16, 2020 at 6:18 PM Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
> >
> > JESD84-B51 7.4.30 CACHE_SIZE [252:249] states that "the size is
> > indicated as multiple of kilobits". This is also supported by Table 39,
> > "e.MMC internal sizes and related Units / Granularities" which lists
> > "32Kb (=4KB)" as the cache size granularity for 4KiB native devices.
> >
> > Signed-off-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
>

Does anything else need to happen to get this applied?

Thanks,

Patrick
