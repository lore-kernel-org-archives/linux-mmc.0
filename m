Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE559C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 10:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA9D64F72
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 10:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhCJK34 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Mar 2021 05:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbhCJK3j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2021 05:29:39 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDFFC061762
        for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2021 02:29:38 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 18so32547376lff.6
        for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2021 02:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZu8kYWcUsjJZQZLgu1XKiWKVJDy+c+Bw7NCUyMv0Bc=;
        b=RJH9YJ4ctf1i7yh5gwJmVZ6iIZEtaOi4hcZsPJS+3fHl6JJRW9vQcHUJuIbxI7ELPW
         4WWZ7RYqXaZCBUAmpCBQibq4rGpusj9qpj7lq4rIsorl11VcXQWfGJ/1U8KC/nXVH0lC
         X5enEIdvBbbV7lC+KCEhzTEZxen86rsiL5tYoCOGGj56VETxgkV3iU/jxhh+EA3a9RPu
         3rzJnssS2eVBVNTlQRd/h34engsUMq7A63Zn5Va3+VeF/B5tGfVPWLfn5WR4G2Mtxn0I
         9Ry+cNgqM6c5mrkJFQS4CxtCLc91eV+wfOLKMTeAdLbtGmTT4WDXeKYQ2R9eZ1bsyD1g
         Y35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZu8kYWcUsjJZQZLgu1XKiWKVJDy+c+Bw7NCUyMv0Bc=;
        b=bwJLrsb6R9i8JhvUk72v81ya1hKKjQ72SO0IFvcdlHFzXfjbDztVkUfeo+tZ2lsppD
         VouU60e2VLos84tBdMxJMwMA98DNpVWgYJ04/TmwqyhfslTN/KYPXtfim1C5K7mCznH9
         czp5nccoNdWGc+wHcfbrDZOlYKhkefCctibyOx1r6VLpjafAMEU4NfdNi8ve2Fnh+Vlj
         zdzf5/cY+ahfP0/SYtm9hIcfY9B6jYXyNl0zYEStT06RIfkvBGQBrTBwf5cxUbjGhhhq
         9JijV0tVuxdZlo1oLmZCtmvOAPRFzhxaCnKo6iUugP+QNL0gQaJ9TamOISp8mUU1292y
         /FDw==
X-Gm-Message-State: AOAM5326ZJKqMd+VhOf/rMKJID9nrGKxLC/nsXSuau93ywcSwoHqq15N
        UC+LFkFsRNCiGC4Na8uBzQDNV1ObR9dbzMQNWYt69Q==
X-Google-Smtp-Source: ABdhPJzV5rCJIjqxQ3LiucCut2xv+IIf2U8hV+WxjX4O6mNhhvyogQZlfhPtOtXXp1t/ll9omuk+MAkZGnu5Q6bJfH0=
X-Received: by 2002:ac2:46db:: with SMTP id p27mr1639785lfo.396.1615372177245;
 Wed, 10 Mar 2021 02:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20210303135500.24673-1-alex.bennee@linaro.org>
 <20210303135500.24673-2-alex.bennee@linaro.org> <CAK8P3a0W5X8Mvq0tDrz7d67SfQA=PqthpnGDhn8w1Xhwa030-A@mail.gmail.com>
 <20210305075131.GA15940@goby> <CAK8P3a0qtByN4Fnutr1yetdVZkPJn87yK+w+_DAUXOMif-13aA@mail.gmail.com>
 <CACRpkdb4RkQvDBgTMW_+7yYBsHNRyJZiT5bn04uQJgk7tKGDOA@mail.gmail.com>
 <6c542548-cc16-af68-c755-df52bd13b209@marcan.st> <CAFA6WYOYmTgguVDwpyjnt3gLssqW48qzAkRD_nyPYg0nNhxT2A@mail.gmail.com>
 <beca6bc8-8970-bd01-8de0-6ded1fb69be2@marcan.st>
In-Reply-To: <beca6bc8-8970-bd01-8de0-6ded1fb69be2@marcan.st>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 10 Mar 2021 15:59:25 +0530
Message-ID: <CAFA6WYMSJxK2CjmoLJ6mdNNEfOQOMVXZPbbFRfah7KLeZNfguw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To:     Hector Martin <marcan@marcan.st>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@linaro.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Joakim Bech <joakim.bech@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ruchika Gupta <ruchika.gupta@linaro.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>, yang.huang@intel.com,
        bing.zhu@intel.com, Matti.Moell@opensynergy.com,
        hmo@opensynergy.com, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 10 Mar 2021 at 14:17, Hector Martin <marcan@marcan.st> wrote:
>
> On 10/03/2021 14.14, Sumit Garg wrote:
> > On Wed, 10 Mar 2021 at 02:47, Hector Martin <marcan@marcan.st> wrote:
> >>
> >> On 09/03/2021 01.20, Linus Walleij wrote:
> >>> I suppose it would be a bit brutal if the kernel would just go in and
> >>> appropriate any empty RPMB it finds, but I suspect it is the right way
> >>> to make use of this facility given that so many of them are just sitting
> >>> there unused. Noone will run $CUSTOM_UTILITY any more than they
> >>> run the current RPMB tools in mmc-tools.
> >>
> >> AIUI the entire thing relies on a shared key that is programmed once
> >> into the RPMB device, which is a permanent operation. This key has to be
> >> secure, usually stored on CPU fuses or derived based on such a root of
> >> trust. To me it would seem ill-advised to attempt to automate this
> >> process and have the kernel do a permanent take-over of any RPMBs it
> >> finds (with what key, for one?) :)
> >>
> >
> > Wouldn't it be a good idea to use DT here to represent whether a
> > particular RPMB is used as a TEE backup or is available for normal
> > kernel usage?
> >
> > In case of normal kernel usage, I think the RPMB key can come from
> > trusted and encrypted keys subsystem.
>
> Remember that if the key is ever lost, the RPMB is now completely
> useless forever.
>
> This is why, as far as I know, most sane platforms will use hard fused
> values to derive this kind of thing, not any kind of key stored in
> erasable storage.

AFAIK, trusted and encrypted keys are generally loaded from initramfs
(as an encrypted blob) which happens during boot and if an attacker is
able to erase initramfs then it's already able to make the device
non-bootable (DoS attack which is hard to prevent against).

Although, I agree with you that fuses are the preferred way to store
RPMB key but not every platform may possess it and vendors may decide
to re-flash a bricked device via recovery image.

>
> Also, newly provisioned keys are sent in plain text, which means that
> any kind of "if the RPMB is blank, take it over" automation equates to
> handing over your key who an attacker who removes the RPMB and replaces
> it with a blank one, and then they can go access anything they want on
> the old RPMB device (assuming the key hasn't changed; and if it has
> changed that's conversely a recipe for data loss if something goes wrong).
>
> I really think trying to automate any kind of "default" usage of an RPMB
> is a terrible idea. It needs to be a conscious decision on a
> per-platform basis.
>

Agree and via DT method I only meant to assign already provisioned
RPMB device/s either to TEE or Linux kernel. And RPMB key provisioning
being a one time process should be carried out carefully during device
manufacturing only.

-Sumit

> --
> Hector Martin (marcan@marcan.st)
> Public Key: https://mrcn.st/pub
