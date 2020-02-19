Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92E0C34050
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 16:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F25124676
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 16:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oxowl+Lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBSQYB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:24:01 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:38251 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgBSQYA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Feb 2020 11:24:00 -0500
Received: by mail-vk1-f193.google.com with SMTP id w4so292568vkd.5
        for <linux-mmc@vger.kernel.org>; Wed, 19 Feb 2020 08:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUCnssO5MQUtUphe3hr1D6XyGMraXMVzCxN86p9qtZo=;
        b=oxowl+Lvvz80ew5XyDzHOY3VfNaXuD4u1IDJe6f1JzqlkFeuwsorfRQP3fnbE7VDpz
         yyfS/nWnrEjmJ5E4IJUJJsfN5sdEfbbb9RfjIn95wuc023N8lncxStdFYi3ULDAdUYzE
         OWOb+qMoEZd20Zm4mVW1Xfx68HirDjV8yf4IMYEe6qgtWrwbvNzsQUbqVkFo0Gk/GrPF
         1MdclO/xBI41rn2B/PytPsC/Pt3jupFfGO73X9K6TUwxw/kSfwP5sFMF+HJkcgZ5oSbW
         OpMn18vIiLQu0TkPat8wY2pqsIMo3Pr/DNnnoMX6wEsAqcrNIR0Ic0A+Qx6bihhSmZuh
         XOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUCnssO5MQUtUphe3hr1D6XyGMraXMVzCxN86p9qtZo=;
        b=H5YeqTYKIuTA/55mbCwGeJO2dBWMZuCAeUElP+gQbPxST3YnAvbnkgnYrghIbq5JmX
         nELYADaWXPPRT2v+TZ1xXe5rZNXWdyxf8pLPPEffWs2LKjgd1pQFiUN4MNxVRnnSE/pP
         qLOGRfnkHT6A3IgOTtPXlTzRQ+1/G4sAoP8z1vzjn42CqtcKdWOlCTQILHXbigbq9t/T
         DcdtAtN6OkobvSY1+ob41rwSIvqETCaucOLApR0orQGWvBWVjNs7WBkObTCtk8GbDK/b
         xzIOOsnMh2pbWP7hfl0SPX8NJM7YZt/1hv1Y7Dwss+a9SGWqck8jEYKpvmNhevjeR1qp
         q7cQ==
X-Gm-Message-State: APjAAAU8PRlntgCbbAf1gTU9C+EjUNCGRp3g8CSxQVGn6HeGAtuLDfw8
        CUvcVjRsGNV3hEFjEZ1WY7Gb9WaYgevsgONWagLAbg==
X-Google-Smtp-Source: APXvYqzyh9yyZ5QkoRBBnXRGTTWzKcqCjGW/k3Lkb+t+GXzqJPCTsA6Ga1EtjzJdVzfC+ekGLGASGI7AaSfdBeOHzt8=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr11622389vka.59.1582129439617;
 Wed, 19 Feb 2020 08:23:59 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
In-Reply-To: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Feb 2020 17:23:23 +0100
Message-ID: <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Feb 2020 at 16:43, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> arm beagleboard x15 device failed to boot Linux mainline and
> linux-next kernel due
> to below error.
> This error occurred across all x15 device for these kernel version.
>
> This regression started happening on x15 from this commit onwards (27th Jan)
>   git branch: master
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   git commit: aae1464f46a2403565f75717438118691d31ccf1
>   git describe: v5.5-489-gaae1464f46a2
>
>
> Test output log,
> [   37.606241] mmc1: Card stuck being busy! mmc_poll_for_busy
> [   37.611850] mmc1: cache flush error -110
> [   37.615883] blk_update_request: I/O error, dev mmcblk1, sector
> 4302400 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
> [   37.627387] Aborting journal on device mmcblk1p9-8.
> [   37.635448] systemd[1]: Installed transient /etc/machine-id file.
> [   37.659283] systemd[1]: Couldn't move remaining userspace
> processes, ignoring: Input/output error
> [   37.744027] EXT4-fs error (device mmcblk1p9):
> ext4_journal_check_start:61: Detected aborted journal
> [   37.753322] EXT4-fs (mmcblk1p9): Remounting filesystem read-only
> [   37.917486] systemd-gpt-auto-generator[108]: Failed to dissect:
> Input/output error
> [   37.927825] systemd[104]:
> /lib/systemd/system-generators/systemd-gpt-auto-generator failed with
> exit status 1.
> <>

Try to restore the value for the cache flush timeout, by updating the
define MMC_CACHE_FLUSH_TIMEOUT_MS to 10 * 60 * 1000".

The offending commit could perhaps be this one.

commit 24ed3bd01d6a844fd5e8a75f48d0a3d10ed71bf9
Author: Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed Jan 22 15:27:45 2020 +0100
mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC

[...]

Kind regards
Uffe
