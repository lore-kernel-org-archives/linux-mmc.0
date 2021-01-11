Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BD7C433E9
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 08:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A208622581
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 08:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbhAKIqi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:46:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbhAKIqh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 11 Jan 2021 03:46:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 184A222AB0;
        Mon, 11 Jan 2021 08:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610354757;
        bh=3m/pirjaLolCItAn89wEfp9ds3Kuziz1XS2fYzL6XSw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p8htGpLE4r02ekjhcmKBlFQWm1dbXuE9qtvjWF2xyScp72/uklkY+VP1rDJXxb/EL
         eIFpvz3bJhXs11bSjVyZRbDNc3gUYH4yRtShlcvf+Waasd9OTvYX4OS9TjE5FsdieB
         +c7UqOAHrYiL6ecR6nNL3QVtKOC9r7AgqDoaNsKxr0KBmlA4fdP8KSBOkCf6hfC9FU
         TpGyZml6WBVuJg0cADT8+rOAjc8I++Z3wdUlUIzqrkkkmHXeNAXS0thCNhrefu0qI7
         esF2Vi1Zu4yvK8C0bcQ3vbUdXZyXZ+vgwtlxpTCLTM9EKlyLHWYRlIwL2wmKR+EfPy
         BTgQyW0B5gkpQ==
Received: by mail-ot1-f43.google.com with SMTP id b24so16253242otj.0;
        Mon, 11 Jan 2021 00:45:57 -0800 (PST)
X-Gm-Message-State: AOAM530puF/C4xozySOj2qD/lpy94usHmPVDaTbzaS0touRGIprK44dZ
        S8K3MqKmi4A7IWN5n2A0mHw+tggbajn6NrW3PSA=
X-Google-Smtp-Source: ABdhPJzRP/mDvKkh8pUUn+o7ynd71Lby9VvGAAY/A+GR7cG9mR+lZ5EXMPWlGNlZcYnwG6pj6FARfqelEIUqhDhIIos=
X-Received: by 2002:a05:6830:1c24:: with SMTP id f4mr9959749ote.108.1610354756304;
 Mon, 11 Jan 2021 00:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20210108211339.1724769-1-jeremy.linton@arm.com>
 <ab3b5788-1148-636a-751f-0a31c87dda33@i2se.com> <cd7c5d78-af92-84b9-8bbf-f480f63005e0@arm.com>
In-Reply-To: <cd7c5d78-af92-84b9-8bbf-f480f63005e0@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 11 Jan 2021 09:45:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEKWsnEzswx-=cA3QO6rKB0OWLGRpsnJg7JsyiJj1vYqA@mail.gmail.com>
Message-ID: <CAMj1kXEKWsnEzswx-=cA3QO6rKB0OWLGRpsnJg7JsyiJj1vYqA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-iproc: Add ACPI bindings for the rpi4
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, linux-mmc@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        ulf.hansson@linaro.org, Florian Fainelli <f.fainelli@gmail.com>,
        sbranden@broadcom.com, rjui@broadcom.com, adrian.hunter@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 Jan 2021 at 04:40, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Hi,
>
> On 1/9/21 5:07 AM, Stefan Wahren wrote:
> > Hi Jeremy,
> >
> > +add Nicolas
> >
> > Am 08.01.21 um 22:13 schrieb Jeremy Linton:
> >> The rpi4 has a Arasan controller it carries over
...
> >> @@ -299,6 +311,8 @@ MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
> >>   static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
> >>      { .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
> >>      { .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
> >> +    { .id = "BCM2847",  .driver_data = (kernel_ulong_t)&bcm_arasan_data },
> >
> > Sorry, i don't have deeper knowledge about ACPI, but BCM2837 is the
> > official naming of the SoC on the RPi 3.
> >
> > Is this a typo in the id?
>
> Not really.
>
> Some background: The PFTF is basically the custodian of the combined
> rpi3 port done by Microsoft and a few other peoples/organizations ports.
> That merged code base was upstreamed a couple years ago to edk2 for the
> rpi3 and is the official port. On the rpi3+uefi platform, linux is just
> using DT, but windows and possibly other OSs are using the ACPI tables.
> For the Rpi4, the intentions is to be an ACPI first platform, but we are
> inheriting the rpi3 legacy peripheral descriptions.

I wouldn't say ACPI first - Linux will likely always have far better
DT coverage for these platforms, with DT overlays etc. However, there
is a strong pull from the industry to support Windows, VMware,
RHEL/Centos and the BSDs on these systems, which is why the ACPI
firmware port is important.

RPi4 is also the most easily obtained Linux/arm64 machine with a
proper and fairly complete implementation of standards-based rich
firmware, which is why it makes sense to support both ACPI and DT boot
on it in Linux.

> So, for the past
> year+ everyone has been basing their rpi4 ACPI OS ports on those tables
> and only adjusting them in backwards compatible ways.
>
> Meaning, that a few years back someone put that ID in the rpi3 ACPI
> tables, and now we are stuck with it unless we are willing to break
> other OSs.
>

Note that most of the ACPI tables were contributed by Microsoft in
order to boot Windows for IOT (or whatever it was called at the time)
on the RPi3; they weren't just pulled out of thin air.


>
> >
> >> +    { .id = "BRCME88C", .driver_data = (kernel_ulong_t)&bcm2711_data },
> >>      { /* sentinel */ }
> >>   };
> >>   MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
> >
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
