Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0DDEB64DD
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Jun 2023 13:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjF0NXe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Jun 2023 09:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjF0NXd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jun 2023 09:23:33 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2781BCB
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jun 2023 06:23:26 -0700 (PDT)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E3D813FFF2
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jun 2023 13:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687872203;
        bh=kGUYnE5kbOca9vEprcX/3t5yld25R/LWby9O3ADDzRg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NQQ2UZ5zuY6d6jqa1i2uJnKNC49TtzegKZrRaisQhUbWNavJKVu0gc6gGOvfAuRnk
         u+YsEfm56TFDWnPnauLpCxxl7hkP/qb5Bi54toHYdCt6kfeB7brpuapD5DTar97P2x
         4aqgupC850JL/s5z5lKgv/YGqN7cWHeiMFLFTnLw1cU/19wWdfjG5Er05Z2+EcFiua
         5bz44zH3SRFK53A3YiuXVU9BaChTsh3o6rSsAE52X9K2eyRGEH4O9nl0PlQMT0GqgW
         zKfO6b9DKE7jX2ot4BtWmnsrURdjTaf5sA9qtVWMWoNC3SiuhBGg0aOum3JxCUPSrs
         FW4EVyOW8zwCw==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1b03916c318so1978710fac.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jun 2023 06:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687872201; x=1690464201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGUYnE5kbOca9vEprcX/3t5yld25R/LWby9O3ADDzRg=;
        b=g2uaLnT6wqDWD81CZ98herNgkNit8RT10mVW/rd5mEzBIzfL85q7BXLI+pGLaM1GZ8
         nSEI9mbiphH3SCCrHSSVqXDiYdKJhHvYW37jHt5yMmRlDg3YSk6Eb0WfeNl7IA52C0z6
         Sr7Dl1yPPrP9GTtM/aDRbpkVXahU811gNYeizFMQKb+GBmBbK55il59ShNhtFuaUDjYG
         Dac36RQLYl1Ra2Tav/acNDCjYzIF95biau0ijOd3yary5nrlkWOdyCbNEDMvDK9CMp9V
         nvvvpngeMjN9PLecgQqvlmxQ+i9oJbu8pnz4/cJ6IVKBC8W1r2n3xeBlOnec7je/ZeMZ
         yS6w==
X-Gm-Message-State: AC+VfDxoYuceDBNctD5GOzVbrGp+2YLlkl8aFIJjPnRk0rwsvvSKejxm
        BfO8p1OI3071k0rzlpbUUNtchMZY07CGTdwg7NTNB6rjAg+fCyuN1T+nfp/NYSRJgTYu22orpP0
        bImEuoi/Vk+JV8It96M8Wby/sgc/fxWFbt6GXegjiszm01D/t79Fumg==
X-Received: by 2002:a05:6870:c78a:b0:1b0:2506:8d21 with SMTP id dy10-20020a056870c78a00b001b025068d21mr7964597oab.24.1687872201576;
        Tue, 27 Jun 2023 06:23:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6klQnDP05O6BeE2DX0RY76kLAjDdfaYcIZmBFRQRyLEgTtrGdlN0AHgTf9P9UjvdT73IDh07FtXl/emNvkQvE=
X-Received: by 2002:a05:6870:c78a:b0:1b0:2506:8d21 with SMTP id
 dy10-20020a056870c78a00b001b025068d21mr7964581oab.24.1687872201309; Tue, 27
 Jun 2023 06:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CX+bjcvbtW2Wto1XF1dKcAbpGGisdyHAGHX12v3TchhLbKtg@mail.gmail.com>
 <CAPDyKFoTH0j1uVSKvY_d7boMdG0kt_WvmLEKenYG22ZJR=UmvA@mail.gmail.com>
In-Reply-To: <CAPDyKFoTH0j1uVSKvY_d7boMdG0kt_WvmLEKenYG22ZJR=UmvA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 27 Jun 2023 21:23:10 +0800
Message-ID: <CAAd53p4NPr7t2ykOVLfjRRSiO5oatMu-Kx6p=O=cTn239XY+Vw@mail.gmail.com>
Subject: Re: rtsx_usb_sdmmc not detecting card insertion anymore
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Pascal Terjan <pterjan@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 27, 2023 at 7:01=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> + Ricky WU, Kai Heng Feng, Oleksandr Natalenko
>
> On Sat, 24 Jun 2023 at 22:39, Pascal Terjan <pterjan@gmail.com> wrote:
> >
> > Hi,
> > I have an ASUS PN50 machine with a 0bda:0129 card reader. The card is
> > not seen unless I reload the rtsx_usb_sdmmc module.
>
> Thanks for reporting, let's see how we can move this forward.
>
> I have looped in some of the people that has been involved in the
> relevant changes for rtsx_usb. Let's see if they can help too.
>
> >
> > I found a Debian bug report for the same regression
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D993068 but nothing
> > to see there.
> >
> > Trying to understand things I found
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D4dad599b8b5d1ffc5ef12a2edb13d15d537202ba
> > which seemed related, so I first tried to revert it and that worked.
>
> Okay! That's certainly good information. Are you willing to help
> running further debug testings?
>
> Unless I mistaken, I think we should avoid doing a plain revert
> (assuming we can find another option) as it will cause us to waste a
> lot of energy instead.
>
> >
> > Assuming the description is correct and the rtsx USB driver runtime
> > resumes the rtsx_usb_sdmmc device when it detects that a new card has
> > been inserted, I assume this means it doesn't detect that a card was
> > inserted and the problem would be in rtsx_usb rather than
> > rtsx_usb_sdmmc.
>
> There is also another interesting commit, which was also part of the
> re-work of the rtsx_usb_sdmmc driver that you pointed to above.
>
> commit 883a87ddf2f1 (misc: rtsx_usb: Use USB remote wakeup signaling
> for card insertion detection")
>
> >
> > I am not sure how to debug this further, usbmon doesn't see anything
> > when I insert the card.
>
> If you are willing to run some tests, I suggest to add some debug prints =
in:
> drivers/mmc/host/rtsx_usb_sdmmc.c
>   sdmmc_get_cd()
>   rtsx_usb_sdmmc_runtime_resume()
>   rtsx_usb_sdmmc_runtime_suspend()
>
> sdmmc_get_cd() should be returning 1 when it finds that there is card
> inserted, but of course the error path would be interesting too.
>
> rtsx_usb_sdmmc_runtime_resume() may be called during probing of the
> rtsx_usb_sdmmc driver. Beyond that point, it should also be called
> when you insert an SD card. Just having a debug print in there should
> help answer if that actually happens.

Adding kernel parameter "usbcore.dyndbg" can also help, it will print
out what's going on at USB side.

Kai-Heng

>
> Kind regards
> Uffe
