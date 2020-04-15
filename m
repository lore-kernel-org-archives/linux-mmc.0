Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C44BC2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 08:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA39206F9
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 08:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ut9RWSaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895172AbgDOIw5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895165AbgDOIwr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 04:52:47 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11604C061A0C
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 01:52:47 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id i22so1044365uak.6
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 01:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GffN4wdV1b8/+GP7bB7msfOG3SsTk4D9FpQBELdB7UQ=;
        b=Ut9RWSaOq1yupMZbWU33o+RQiJm1VcNInX3xL0Qg2Yu12twvk6t/92Wf0Py1JaXBW7
         seiwUhSnzZDeqIFK/o6vdQ1KzM/lWT9y7RRQNWbGx64yLdbrPQxDTAnsOWWnqXGKMOLL
         GxFZhp0BptUY2s68S0lWCLTgEsrSz3e0BRd8KcU7xFSdUMqzK1yrr+JlURONDWZBNJZq
         w1+L9MVjy0l/BwMUarAgZKemDe7WXlv7abAiHz9Kl9N7XQ5JE8Hcjk59ti4cK4THNy9D
         HnotyGjdAwHUGgJi+IjmHnkpf/cHvijf63dA3kf0GXIeof5uub5vU+szxsj3JT1mQVlA
         65jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GffN4wdV1b8/+GP7bB7msfOG3SsTk4D9FpQBELdB7UQ=;
        b=bNrYTnqgHOutCRVTTGPo8MszdBXdQy5dJbSEzartwk5axqHUnTTHn9vdirNnahwyf+
         2Pb2i0bCG3WHT0Wgq+uGU90t5GIk8Tl53lJkacECfysTWuQdnc+NqRTzdi1+ESdsfgIy
         auXkJ5gl/5ZciHacCdsxFSlJtlZCt0OcAYO0xy/ZDoyegXcvSlbEUGU+ayuzABP09+X7
         Nx3xwFMNCzHPCcezG5BXKwWD8vomgYuXZg8LltbTEth1ALXc2sZBJ130YS+qoRkRMv4T
         5Hz73SxU9g+A3JXjg0dQ19VGZ8VciWda8myrNuhinH5XvmYYtlu5YfDvFFBG28DmGg1G
         vg4Q==
X-Gm-Message-State: AGi0PuY9xt7qAHC50ekkJ7pVvAbvIv5gfUsiRZhyl/YrgUHPPOUURRoL
        78DU+Ry+hcq4ywak1l91w5DtLHf70eqLompGIv8+8w==
X-Google-Smtp-Source: APiQypIR6ai89vFmGqUSNQjlgJoCsLY70k1gj1lY6weiIV/qNYMav0X7PqbmVlV4sZKnwV/apxkl2A0RgEkql85Izu8=
X-Received: by 2002:a9f:20c6:: with SMTP id 64mr3823674uaa.100.1586940766283;
 Wed, 15 Apr 2020 01:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 10:52:10 +0200
Message-ID: <CAPDyKFrWZN2pwdaJ3ctMP9Mb3W6d5Di5jt4F9u1AmqxSKFzboQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] SDHCI clock handling fixes and cleanups
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2 Apr 2020 at 13:54, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmq=
m.pl> wrote:
>
> This patch set combines a few of code improvements for SDHCI clock handli=
ng.
> Besides small fixes, most value comes from simplifying the code, so it's
> easier to understand.
>
> Micha=C5=82 Miros=C5=82aw (7):
>   mmc: sdhci: fix base clock usage in preset value
>   mmc: sdhci: fix programmable clock config from preset value
>   mmc: sdhci: fix SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
>   mmc: sdhci: move SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN frequency limit
>   mmc: sdhci: simplify clock frequency calculation
>   mmc: sdhci: squash v2/v3+ clock calculation differences
>   mmc: sdhci: respect non-zero div quirk in programmable clock mode
>
>  drivers/mmc/host/sdhci-of-arasan.c |   7 +-
>  drivers/mmc/host/sdhci.c           | 126 +++++++++++++----------------
>  drivers/mmc/host/sdhci.h           |   4 +-
>  3 files changed, 64 insertions(+), 73 deletions(-)
>
> --
> 2.20.1
>

Adrian, whenever you get the time, I would like to get your feedback
on these, especially on patch1->patch3 as those may be targeted for
fixes.

Kind regards
Uffe
