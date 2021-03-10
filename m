Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8A5C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 09:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E7B64FC9
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 09:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhCJJtj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Mar 2021 04:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhCJJtH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2021 04:49:07 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBA2C061762
        for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2021 01:48:50 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id i26so13125288ljn.1
        for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2021 01:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtHA2WDlEgIkr4gPC6h7Fo/UqIYBpPKwlhK+eaqepyw=;
        b=tY/zIW4Jt+MrodIYY2WZdIiCNb/lU3TrDkCWVH1GC0ZPyU8Fx0CiEb9Y0y6cWNwv7U
         3+UQ4tj0HCbX1WI9IIyo1VQinhXuWm4yZ4/FrglyModxavmcD8ic3hi8VDuL0mu7sjvO
         r5E3kNoy61v/83xcWywtQVUii/xoonAa4J0vcuc4IIrtgr+1XAGhb6OW3Mi4t5bvbWxc
         GIgozN4dt2GxWFomJxp6BI7YoAy/xPboNJQTdjjKnrHxVFj4+9L5cBB9ed/Szln9egGk
         D9vT9z4k3NfBlpCqmdhXbTHzIRr2dVJNtXzUNIocr7litDYcpUQG9qfLgvf2bTY4K7bC
         /Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtHA2WDlEgIkr4gPC6h7Fo/UqIYBpPKwlhK+eaqepyw=;
        b=LFyXyzrEOd1U8Z/HYIcbDAbiuqmYJvNmzcdFd4MdzK/SSIggUJ1gt5RXyYadSwqkuz
         jPZQXJGxoeg5ZWWF7oMIbDwSbT4Iz/y4n3tQh01WkigVaiRmNEclKEqzySib/66E4sqD
         UH3dc3sV9rhsDX8JaVzljfjtnZg5iatwSe87EDo6c2aZbyRoTLXhRZJbqFdyKOPvjHGB
         3ZmRYK5kmP1lTkKcjGwiZvSfWQt/LXki8XmPmXjwKPHQbAolQo9Fn+zPgTk7o53QsTT/
         aPRV75XcDfYrZi52z5Ch9LL28q1IbFMsQimQQPVrWKLtZF9MjTjlR8DLkd692HwDyqEX
         FCfA==
X-Gm-Message-State: AOAM533OEhtJFfJtExUYnZRGCjwuwGCEUW3NB59f15KsCUSMB9QQJFMB
        7MkivSPP3lDUO2schx/jDuURoDrPRLahjJ4inrcV5g==
X-Google-Smtp-Source: ABdhPJy+6iVKLlhEs9ytjE2yJ6jzfWyAjkcYGwRmlv2dADiCXewf+sSTgUSixyA6cjqoVwsnHGvaAVVLYVVNGU7AOWM=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr1268524ljj.467.1615369729068;
 Wed, 10 Mar 2021 01:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20210303135500.24673-1-alex.bennee@linaro.org>
 <20210303135500.24673-2-alex.bennee@linaro.org> <CAK8P3a0W5X8Mvq0tDrz7d67SfQA=PqthpnGDhn8w1Xhwa030-A@mail.gmail.com>
 <20210305075131.GA15940@goby> <CAK8P3a0qtByN4Fnutr1yetdVZkPJn87yK+w+_DAUXOMif-13aA@mail.gmail.com>
 <CACRpkdb4RkQvDBgTMW_+7yYBsHNRyJZiT5bn04uQJgk7tKGDOA@mail.gmail.com>
 <6c542548-cc16-af68-c755-df52bd13b209@marcan.st> <CAFA6WYOYmTgguVDwpyjnt3gLssqW48qzAkRD_nyPYg0nNhxT2A@mail.gmail.com>
 <beca6bc8-8970-bd01-8de0-6ded1fb69be2@marcan.st>
In-Reply-To: <beca6bc8-8970-bd01-8de0-6ded1fb69be2@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Mar 2021 10:48:38 +0100
Message-ID: <CACRpkdbQks5pRFNHkNLVvLHCBhh0XCv7pHYq25EVAbU60PcwsA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To:     Hector Martin <marcan@marcan.st>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Arnd Bergmann <arnd@linaro.org>,
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

On Wed, Mar 10, 2021 at 9:47 AM Hector Martin <marcan@marcan.st> wrote:

> Remember that if the key is ever lost, the RPMB is now completely
> useless forever.
>
> This is why, as far as I know, most sane platforms will use hard fused
> values to derive this kind of thing, not any kind of key stored in
> erasable storage.

You're right. In the mobile phone world this is a given fact.

If we are thinking devices are to be repurposed or reinstalled
from scratch for example, like ordinary desktops or servers,
RPMB does not make generic sense: it is not for
"generic computing" but rather for protecting devices that you
carry around and can be lost: mobile phones, chromebooks,
maybe laptops.

If and only if the user so desires, I would say, but sometimes
the vendors decide policy...

(+/- the fact that some recent supply chain attacks for server
software may actually make cloud people start thinking like this
about their servers integrity, what do I know.)

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

OK sorry for my bad ideas, what was I thinking :D

For a laptop or so, I would say, a user who is paranoid that their
device gets stolen and used by someone else, should be able to
set their device up, with some tool, such that a secret key from
somewhere and RPMB is used to lock down the machine so that
attackers cannot get into it and get the data out.

Disk is encrypted, and RPMB is there to block any exhaustive
password or other authentication token search.

Ideally: the only way to make use of the hardware again would
be to solder off the eMMC, if eMMC is used for RPMB.
If we have RPMB on an NVME or UFS drive, the idea is
to lock that thing such that it becomes useless and need to
be replaced with a new part in this scenario.

In practice: make it hard, because we know no such jail is
perfect. Make it not worth the effort, make it cheaper for thieves
to just buy a new harddrive to use a stolen laptop, locking
the data that was in it away forever by making the drive
useless for any practical attacks.

Maybe it will be possible to blank the drive and use without
RPMB since that is now locked with a key they can no longer
acces: the end result is the same: RPMB protected the data
of the original user. So a one-time user protection such
as a seal, once broken this seal cannot be reused to seal
anything again and that is OK.

Yours,
Linus Walleij
