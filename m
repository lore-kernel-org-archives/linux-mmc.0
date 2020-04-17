Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75369C38A2B
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 11:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E98B21D94
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 11:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtOmtytk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgDQL3v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730384AbgDQL3v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2020 07:29:51 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA50C061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 04:29:50 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id v24so529523uak.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 04:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nu9WgdeKxKQdkeH1gR18VhD9u3Adn8tTkCVWam9LK94=;
        b=GtOmtytk18kW8KTUJNTrqweEWV6cr1cr3C/OhLizV4J+D5OdrUqwJejcrqB2FP9K8z
         PYBUxtD/ra0CuRjTRXYgtVHfo19zN25JtaWCwInr9o/VTm9a5UGDMuza4i1fm62ScXS9
         rN1UfE+7fOrtV1M57/CovyL0iOHcIkByEFdhx60rxFxssfOvvpNEKzg+qeZ77hKtk4Ox
         xVt/5BJUoLV64O9x2cO7jFh37MK9xhaDQ72/xf0AE4gyMTDGUKjJ1Y4uzvUspMGAIM2M
         NyxlwU3fs+7X0QoBLrFQ2Cfq7u4S9qvjghwsf+EDLrQziUAaZuBQiycPE80POwx0JOgZ
         b4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nu9WgdeKxKQdkeH1gR18VhD9u3Adn8tTkCVWam9LK94=;
        b=eNV+d4OnwwORia9BKrdOATitBU+75Fsrflkrb+kAG4hM9nckUME4NjsQZYT6IWRWif
         RmQbGhk5tIzdyN9HJPWnb87DNr7Q2aoPKkQAU2yUJG3AuJNor8C0MUWpzoEmWk41KMv5
         /jCgdZS9VWtRA/MydJRY2tVusdWjW62rvU7VmH3MGaQqYr8PtcLCwAAMNkyQvfGyum0n
         2nTf9+1aOpqnRHdvljjdvw7AILLo31kq04qQLZAoMvVI4Z0BVzQfBOAg/hRtbs2w9tib
         ShZxdNlc2wwB1N7kHHmlsXV86pPF3D4xPLEaC9gfyEmQ+TrGEAW+2C4fAKjFq3PyNoM1
         X6fg==
X-Gm-Message-State: AGi0Pua6GiuZbh7MBQx4rvhp+++lEv1z7F7aC4JJkcFmFmWNKKEWlYUO
        MwN3AgbJ7Gvc9uzRt4CkFYDGv4oHt3vKhuEtM/cYYg==
X-Google-Smtp-Source: APiQypI99jsnL4mvQY9oQzsMieBqtAo29Y/8grH2oglO8FAd30vRx2tQcJkBygaMr5+Hv/S1jdj3f1P6K2qyFqAhHug=
X-Received: by 2002:a9f:25af:: with SMTP id 44mr1989461uaf.104.1587122990039;
 Fri, 17 Apr 2020 04:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586744073.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586744073.git.baolin.wang7@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 13:29:14 +0200
Message-ID: <CAPDyKFqfq_UMNfgdu8HioAa6+qy+JYrNkVDg8ARu1BpNKx9hgw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Introduce the request_atomic() for the host
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Apr 2020 at 04:46, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> This patch set introduces a new request_atomic() interface for the
> MMC host controller, which is used to submit a request to host in
> the atomic context, such as in the irq hard handler, to reduce the
> request latency.
>
> Note, this patch set is based on Adrian's patch set:
> https://www.spinics.net/lists/linux-mmc/msg58529.html
>
> Any comments are welcome. Thanks.
>
> Changes from v4:
>  - Remove redundant checking when warning the return value of request_atomic().
>  - Add acked tag from Adrian for patch 1.
>  - Re-implement the request_atomic() based on the Adrian's patch set.
>
> Changes from v3:
>  - Move patch 3 of V3 patch set into patch 1.
>  - Add a warning for unexpected return value of request_atomic().
>  - Remove redundant checking of ops->request().
>
> Changes from v2:
>  - Return busy flag if encountering unusual card busy state
>  instead of polling in interrupt context.
>  - Add a work for HSQ to try again in non-atomic context if the host
>  returns busy flag.
>
> Changes from v1:
>  - Re-split the changes to make them more clear suggested by Ulf.
>  - Factor out the auto CMD23 checking into a separate function.
>
> Baolin Wang (3):
>   mmc: host: Introduce the request_atomic() for the host
>   mmc: host: sdhci: Implement the request_atomic() API
>   mmc: host: sdhci-sprd: Implement the request_atomic() API
>
>  drivers/mmc/host/mmc_hsq.c    | 29 ++++++++++++++++++++++++++++-
>  drivers/mmc/host/mmc_hsq.h    |  1 +
>  drivers/mmc/host/sdhci-sprd.c | 23 ++++++++++++++++++++---
>  drivers/mmc/host/sdhci.c      | 34 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h      |  1 +
>  include/linux/mmc/host.h      |  3 +++
>  6 files changed, 87 insertions(+), 4 deletions(-)
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
