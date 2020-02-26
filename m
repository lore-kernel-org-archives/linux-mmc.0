Return-Path: <SRS0=M0wQ=4O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFECC4BA15
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7496124688
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 15:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXNFScEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgBZPWV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:22:21 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35072 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgBZPWU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2020 10:22:20 -0500
Received: by mail-vk1-f193.google.com with SMTP id r5so355266vkf.2
        for <linux-mmc@vger.kernel.org>; Wed, 26 Feb 2020 07:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8nWkCMD00cXwz4vSIcrFn9i/BES9/eV0AoGbar9kSU=;
        b=mXNFScEPEXTZ4Y03CyiK+/TjkHLqnAjQPcxs+JNs+IyUVBpbdLw2mdhfel0dmuKPLk
         W6OvSj/o0zdvXzCB9K+9m7F8SiVe1l183/R1TUoJcArgKBRRhoXq5crK7CUujf6EiXTA
         PsnQ/ubtPHHwkYOhMOt3/D+OFo4vIsqkU3GrZh1Flo4rA1OijEUNJkjPl9z2qKTlgJIY
         IE2tSomRkCv2tDlzf/anAOXlsMg+7A1wtK1hh+B9hCIcDrfBTNAYKxrpI8TS0hwqSio9
         IQm2G/+ObyhefUuHtvD2xH8EEmoVoXNzjYR+CAhxeyhSzbk4rOgw2gQu8bs0ueut8kML
         IoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8nWkCMD00cXwz4vSIcrFn9i/BES9/eV0AoGbar9kSU=;
        b=s3TiU08YirUVxMMhiMSAt1QKDNzbYi6YO7FJNOkz3dixTZnEotoNR2tMx7mIax73AM
         3+Cib6IetVCAUM6VDq7A3m4cnrSEcLAcXfp3Dc2Sy5s/XLHMOrOWTs7TtXG1KlgZYqTG
         bG18nHglV4M8QnZcGfHEvyE4FpE8zu48fC3Y+johW+nfitkv4nksiQ7OZlb9ulUQLwW+
         /qyPfyXf5zi8lAGPlfk4uuMOkvjf+ZD1lymBxCZtsnQPrTlzNSW5R6i6l9GcRIqQOdq/
         fsVtyv428nUfYpmzMUebF5iRlms1VlxADerOoLPs7URJnNMuj4jQ9IWdW5+0cdSMfy0E
         +rgQ==
X-Gm-Message-State: APjAAAWe1fE3OV4jZbZTJeUIHeafIYl7Uig2E8+q+eawf6MyqZkpqAcv
        24ht/X0ZoyLa/aUEVWvj9bcnKzli92nfJb074hk+vw==
X-Google-Smtp-Source: APXvYqzF0V4RB8Y6fLHFPX/60gGn0XuOow45OeMPm8jjcH+gHUPO3SKB/DseAxYeF3stegFkmAxKJF8fZ82SZIMQzZc=
X-Received: by 2002:a1f:914b:: with SMTP id t72mr4120155vkd.101.1582730538102;
 Wed, 26 Feb 2020 07:22:18 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
 <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com> <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com> <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com> <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com>
In-Reply-To: <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Feb 2020 16:21:42 +0100
Message-ID: <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Jon Hunter <jonathanh@nvidia.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Bitan Biswas <bbiswas@nvidia.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Anders, Kishon

On Tue, 25 Feb 2020 at 17:24, Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 25/02/2020 14:26, Ulf Hansson wrote:
>
> ...
>
> > However, from the core point of view, the response is still requested,
> > only that we don't want the driver to wait for the card to stop
> > signaling busy. Instead we want to deal with that via "polling" from
> > the core.
> >
> > This is a rather worrying behaviour, as it seems like the host driver
> > doesn't really follow this expectations from the core point of view.
> > And mmc_flush_cache() is not the only case, as we have erase, bkops,
> > sanitize, etc. Are all these working or not really well tested?
>
> I don't believe that they are well tested. We have a simple test to
> mount an eMMC partition, create a file, check the contents, remove the
> file and unmount. The timeouts always occur during unmounting.
>
> > Earlier, before my three patches, if the provided timeout_ms parameter
> > to __mmc_switch() was zero, which was the case for
> > mmc_mmc_flush_cache() - this lead to that __mmc_switch() simply
> > ignored validating host->max_busy_timeout, which was wrong. In any
> > case, this also meant that an R1B response was always used for
> > mmc_flush_cache(), as you also indicated above. Perhaps this is the
> > critical part where things can go wrong.
> >
> > BTW, have you tried erase commands for sdhci tegra driver? If those
> > are working fine, do you have any special treatments for these?
>
> That I am not sure, but I will check.

Great, thanks. Looking forward to your report.

So, from my side, me and Anders Roxell, have been collaborating on
testing the behaviour on a TI Beagleboard x15 (remotely with limited
debug options), which is using the sdhci-omap variant. I am trying to
get hold of an Nvidia jetson-TX2, but not found one yet. These are the
conclusions from the observed behaviour on the Beagleboard for the
CMD6 cache flush command.

First, the reported host->max_busy_timeout is 2581 (ms) for the
sdhci-omap driver in this configuration.

1. As we all know by now, the cache flush command (CMD6) fails with
-110 currently. This is when MMC_CACHE_FLUSH_TIMEOUT_MS is set to 30 *
1000 (30s), which means __mmc_switch() drops the MMC_RSP_BUSY flag
from the command.

2. Changing the MMC_CACHE_FLUSH_TIMEOUT_MS to 2000 (2s), means that
the MMC_RSP_BUSY flag becomes set by __mmc_switch, because of the
timeout_ms parameter is less than max_busy_timeout (2000 <  2581).
Then everything works fine.

3. Updating the code to again use 30s as the
MMC_CACHE_FLUSH_TIMEOUT_MS, but instead forcing the MMC_RSP_BUSY to be
set, even when the timeout_ms becomes greater than max_busy_timeout.
This also works fine.

Clearly this indicates a problem that I think needs to be addressed in
the sdhci driver. However, of course I can revert the three discussed
patches to fix the problem, but that would only hide the issues and I
am sure we would then get back to this issue, sooner or later.

To fix the problem in the sdhci driver, I would appreciate if someone
from TI and Nvidia can step in to help, as I don't have the HW on my
desk.

Comments or other ideas of how to move forward?

Kind regards
Uffe
