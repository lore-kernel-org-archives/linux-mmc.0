Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD9AC678D5
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Mar 2023 10:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCGKil (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Mar 2023 05:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCGKik (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Mar 2023 05:38:40 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEAD4FF18
        for <linux-mmc@vger.kernel.org>; Tue,  7 Mar 2023 02:38:37 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s18so7312984pgq.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Mar 2023 02:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678185517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDexXck4bh5DKeMj4fG4O109a2LyI6xm508mlJUmF9Y=;
        b=KvuB8DJsC+5C5jWCIkXZ6KrLXxXoa5S0sTloRq1VMOj3MthCvGMN0NIN8+cLDpduqN
         ZrrixNOcmaygtQJFhlQS4TXLmqQH3VjiVvT5ISHJPdH3eEs9PuuzLiNxAAKMRCT5Bllq
         zUBVpKOabRs9IkT7HcYJq6WC0JImZJwArpDhKjJnPV6hVoHvkKjGNQUv4ULFfOFQJNvG
         yzPQWdKBqJ4UDNV4npuE4ilCI+664vkVQOBOawhrVvtB6DFRhDxWgiMgYKiDxKIz44BL
         sZatKGyl0WrnrqsZUBLnqOXq3WX9D5uaXa6JDsu946UN5CRySMVZPhFz+Wd4ccb5X3FO
         6PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678185517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDexXck4bh5DKeMj4fG4O109a2LyI6xm508mlJUmF9Y=;
        b=LnZ5ipf0nx/F2GwhU+3XCUT5+fg1tY/BVrMByhExrltOl9uP8F3TNJ/YuCSRPROFOM
         LMvcrJqaXlXN92izKrVriufKs7tFBcQCMqVRFxrNnY4fxg69sOyMKGPui2kjVjhF6YSO
         csyF1+QLQ1owavx3bEb8GLeHkmoRmOr86l8MFCBQlM7oTRIKpWCfZ+BPtbldybZKLuL4
         nY4u0fAv7j9hiZJrxI+UitqpT4d1FUASSLogCReav614DMchMBbnTHMaC4rG5X2uZOlv
         jwD8vvllacJ4cQjs2uhVLeH76vHcEIvSHzzE1WFS9OpIVErqO6PNT2aisYaka/RFjrY7
         AZZg==
X-Gm-Message-State: AO0yUKXn55E6at2hBK5kjEhNq6KQ7S3ppSCV6/uLumQP2lelaWX/uk5W
        c6obgSo1pBjuuuBchpcudvWMuze3XxsTe8mDQ60w1w==
X-Google-Smtp-Source: AK7set8wtrUJcqgnJEzYoyGkweibimJ/39GNdI+meJSm27cDmMqf+8DAJSr9+eiST4RwOqNVMYbAczEinR9CE9rg5tk=
X-Received: by 2002:a63:bc02:0:b0:4fb:d6b9:abea with SMTP id
 q2-20020a63bc02000000b004fbd6b9abeamr4909071pge.5.1678185517200; Tue, 07 Mar
 2023 02:38:37 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2SC_Q3RWdeO9-mKDYC_TK8_vzefvGz_++O8StJer_h3Q@mail.gmail.com>
 <CAPDyKFq23_vCunapQ=OHFFGXs5a8_cr8w7hBUP=HQ5f2zaTBUg@mail.gmail.com> <CAJ+vNU3RU_hM=H4Efh4WP7+d5LRJ7JeLsoSEfJeikXXE-pnH1w@mail.gmail.com>
In-Reply-To: <CAJ+vNU3RU_hM=H4Efh4WP7+d5LRJ7JeLsoSEfJeikXXE-pnH1w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Mar 2023 11:38:00 +0100
Message-ID: <CAPDyKFpo_kz6btamMvqcoO10-ZkJMYnnc5gppJpX9yHiXq3UkA@mail.gmail.com>
Subject: Re: mmc: core: Disable card detect during shutdown
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Robert Richter <rric@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Jan Glauber <jan.glauber@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 4 Mar 2023 at 00:38, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Thu, Mar 2, 2023 at 2:37=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > + Robert
> >
> > On Thu, 2 Mar 2023 at 00:32, Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > Greetings,
> > >
> > > I've encountered a hang on shutdown on octeontx (CN8030 SoC, THUNDERX
> > > architecture) that I bisected to commit 66c915d09b94 ("mmc: core:
> > > Disable card detect during shutdown").
> > >
> > > It looks like the OMP5 Pyra ran into this as well related to a
> > > malfunctioning driver [1]
> > >
> > > In the case of MMC_CAVIUM_THUNDERX the host controller supports
> > > multiple slots each having their own CMD signal but shared clk/data
> > > via the following dt:
> > >
> > > mmc@1,4 {
> > >         compatible =3D "cavium,thunder-8890-mmc";
> > >         reg =3D <0xc00 0x00 0x00 0x00 0x00>;
> > >         #address-cells =3D <0x01>;
> > >         #size-cells =3D <0x00>;
> > >         clocks =3D <0x0b>;
> > >
> > >         /* eMMC */
> > >         mmc-slot@0 {
> > >                 compatible =3D "mmc-slot";
> > >                 reg =3D <0>;
> > >                 vmmc-supply =3D <&mmc_supply_3v3>;
> > >                 max-frequency =3D <35000000>;
> > >                 no-1-8-v;
> > >                 bus-width =3D <8>;
> > >                 no-sdio;
> > >                 no-sd;
> > >                 mmc-ddr-3_3v;
> > >                 cap-mmc-highspeed;
> > >         };
> > >
> > >         /* microSD */
> > >         mmc-slot@1 {
> > >                 compatible =3D "mmc-slot";
> > >                 reg =3D <1>;
> > >                 vmmc-supply =3D <&mmc_supply_3v3>;
> > >                 max-frequency =3D <35000000>;
> > >                 no-1-8-v;
> > >                 broken-cd;
> > >                 bus-width =3D <4>;
> > >                 cap-sd-highspeed;
> > >         };
> > > };
> > >
> > > mmc_add_host is only called once for mmc0 and I can't see any printk
> >
> > That looks wrong. There needs to be one mmc host registered per slot,
> > otherwise things will, for sure, not work.
> >
> > I suggest you have a closer look to see what goes on in thunder_mmc_pro=
be().
> >
>
> Ulf,
>
> Sorry, I was mistaken. Each slot does get its own mmc host.
>
> I find that with thunderx_mmc I can reproduce this hang on shutdown
> even if I just have a single slot with broken-cd defined.

Okay, that's a step in the right direction to narrow down the problem!

>
> I wonder if it has to do with thunder_mmc_probe getting called
> multiple times because it defers due to gpio/regulator not yet being
> available:
> [    6.846262] thunderx_mmc 0000:01:01.4: Adding to iommu group 1
> [    6.852143] thunder_mmc_probe
> [    6.855622] thunder_mmc_probe scanning slots
> [    6.860137] mmc_alloc_host: mmc0 init delayed work
> [    6.864938] cvm_mmc_of_slot_probe mmc0
> [    6.868695] cvm_mmc_of_slot_probe mmc0 Failed: EPROBE_DEFER
> [    6.874269] mmc_free_host: mmc0
> [    6.877481] thunder_mmc_probe Failed: EPROBE_DEFER
> ...
> [    7.737536] gpio_thunderx 0000:00:06.0: Adding to iommu group 16
> [    7.745252] gpio gpiochip0: (gpio_thunderx): not an immutable chip,
> please consider fixing it!
> [    7.754096] gpio_thunderx 0000:00:06.0: ThunderX GPIO: 48 lines
> with base 512.
> ...
> [    7.946636] thunder_mmc_probe
> [    7.950125] thunder_mmc_probe scanning slots
> [    7.954597] mmc_alloc_host: mmc0 init delayed work
> [    7.959399] cvm_mmc_of_slot_probe mmc0
> [    7.963158] cvm_mmc_of_slot_probe mmc0 Failed: EPROBE_DEFER
> [    7.968732] mmc_free_host: mmc0
> [    7.971963] thunder_mmc_probe Failed: EPROBE_DEFER
> ...
> [    7.998271] reg_fixed_voltage_probe
> [    8.001773] reg-fixed-voltage mmc_supply_3v3: reg_fixed_voltage_probe
> [    8.008360] reg-fixed-voltage mmc_supply_3v3: mmc_supply_3v3
> supplying 3300000uV
> [    8.015851] thunder_mmc_probe
> [    8.019318] thunder_mmc_probe scanning slots
> [    8.023794] mmc_alloc_host: mmc0 init delayed work
> [    8.028596] cvm_mmc_of_slot_probe mmc0
> [    8.032488] mmc_add_host: mmc0
> [    8.060655] cvm_mmc_of_slot_probe mmc0 ok
> [    8.064678] thunderx_mmc 0000:01:01.4: probed
> [    8.069041] mmc_rescan: mmc0 irq=3D-22

I can't really tell from the above log whether the error path in
->probe(), is working correctly. I don't see any obvious problem here.

>
> > > debugging added to __mmc_stop_host (maybe because serial/console has
> > > been disabled by that point?).
> >
> > The serial console should work fine at this point, at least on those
> > systems that I have tested this code with.
> >
> > Perhaps you added the debug print too late in the function, if the
> > calls to disable_irq() or cancel_delayed_work_sync() are hanging?
> >
>
> This was something to do with busybox reboot. I switched to using
> sysrq (echo o > /proc/sysrq-trigger) to reboot and now I can see my
> printk's

Okay.

>
> > >
> > > It appears that what causes this hang is the 'broken-cd' which enable=
s
> > > the detect change polling on mmc1. I have the ability to flip the CMD
> > > signal routing thus making mmc0 the microSD and mmc1 the eMMC and whe=
n
> > > I do that there isn't an issue so I think what happens is in the case
> > > where mmc polling is enabled on mmc1 but not mmc0 (as above) the
> > > polling causes a hang after __mmc_stop_host() is called for mmc0.
> >
> > The code in __mmc_stop_host() has been tested for both polling and
> > gpio card detections. That said, it looks to me that there is
> > something weird going on in the cavium mmc driver.
> >
> > What makes this even tricker, is that it's uncommon and not
> > recommended to use more than one mmc slot per host instance.
> >
>
> that was my mistake... there is one host instance per slot and I see
> this even if I only have 1 slot as long as polling is enabled.

Okay.

>
> now that I can see my printk's I can confirm it hangs when
> _mmc_stop_host calls the cancel_delayed_work_sync:
> # echo o > /proc/sysrq-trigger
> [  210.370200] sysrq: Power Off
> [  210.373147] kernel_shutdown_prepare
> [  210.896927] mmc_rescan: mmc0 irq=3D-22
> [  213.038191] mmc_host_classdev_shutdown mmc0
> [  213.042384] __mmc_stop_host: mmc0 cd_irq=3D-22
> [  213.046658] __mmc_stop_host: mmc0 calling cancel_delayed_work_sync
> ^^^ never comes back

Unless I am missing something, that should mean that mmc_rescan() is
hanging somewhere. Before the shutdown, did you try to insert an SD
card to verify that it was detected properly?

I suggest you debug mmmc_rescan() to try to understand where exactly it han=
gs.

>
> If I comment out the call to cancel_delayed_work_sync in
> __mmc_stop_host then shutdown does not hang so I think it has
> something to do with mmc_alloc_host setting up the polling multiple
> times.

I am not so sure, the error path in ->probe() doesn't look that broken
to me. At least it's difficult to say, by reading the logs that you
have provided.

[...]

Kind regards
Uffe
