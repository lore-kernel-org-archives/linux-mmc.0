Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4A8C3815B
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 07:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F942078C
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="us20jd4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTHmq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTHmq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2020 03:42:46 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3A2C061A0C
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 00:42:46 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id g184so5394521vsc.0
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YFFBj/1xERWjOMlC3nkYnoyo51S/FgamFo7YoGP+uyI=;
        b=us20jd4XIQ0yRq1vWJqi3LDoNQDyrKZlzd6IuKSAZXCC4xmQg/jU3phMXOWlpvmOS4
         x69M6yOzvU4pEfRGN1CZ+ZY4J327kIkj0vH06S/Rq/YtWW1MWr5CQrX6YU2rdZfqrdKP
         66hCZJlcaCtboj9a2DbXRTMbkVcX8xzxxI3ur3dL32XNBTsu2SxnwRqh9BxuxMxtP+Bh
         HorOxVIMXGKaTnlZ3f9XOHwUDLsT+DXC/ofs6He1xIzo4tlAhjCPc8jBi8hyx02YzDKX
         r2D3Muk1bSa32mXlVR3JWcCL+YjViedI/mznGQmDia1S7PnwFmisMkh1a3P6V1plnWz0
         Li+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YFFBj/1xERWjOMlC3nkYnoyo51S/FgamFo7YoGP+uyI=;
        b=TbBsbNy6DJpvCCK4z9Xt5g0u/REEOLlXnoY/tOHoOir0UZtJfHWNW4Y15o2nLSy5KT
         bV7Ek8wcfLIFAYAjdRz530S92PaKrafneRvjnLlKK3APm1X9da2G4lMp+zdgmIut/gvl
         M+8IhmEab3f7i8pa9Cp86OIZTLqAyh4tF5AxCtzqQARHHsrznugDMPwF2WVn1OB1TovX
         ZVNo5TFDm0+ir0WUwGrXox2szgrE4NnyCqzmcLRJYKAWls+8TTXsZrK2/05GCvRCnc6y
         mvGAl/sAwXf//dnYMP6eWHy7H78E3ZBI87ZNkxVhv6mJMOajplt9Gi1NpgflPxu9EwaH
         ptaQ==
X-Gm-Message-State: AGi0PuZuVI5zVLfZxtMUHYIrnnBA29uMkrfZRUfnVTUJ7bofnD6jVHbQ
        9kiPHRAVPqeCOzHUGkH+W7Kjdw6m2Qu91SOWpgK5sw==
X-Google-Smtp-Source: APiQypLQ4wZu8D939obAG3/kDZdmpqPi1WT4WPHcBKy6pw0vFH16Ixnlk/LKJsv3M60oZvJzv+FQs4e9RwKb7hTDdQc=
X-Received: by 2002:a67:f24b:: with SMTP id y11mr10041594vsm.165.1587368564652;
 Mon, 20 Apr 2020 00:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200419053746.22443-1-marek.behun@nic.cz> <20200420075743.3b6ed229@nic.cz>
In-Reply-To: <20200420075743.3b6ed229@nic.cz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Apr 2020 09:42:08 +0200
Message-ID: <CAPDyKFpZseW9JxXNE1fqGUfrm-j0DT2c0YEWoqJu_JmqQ7g8NQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: fix annoying 1.8V regulator warning
To:     Marek Behun <marek.behun@nic.cz>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Zhoujie Wu <zjwu@marvell.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Apr 2020 at 07:57, Marek Behun <marek.behun@nic.cz> wrote:
>
> On Sun, 19 Apr 2020 07:37:46 +0200
> Marek Beh=C3=BAn <marek.behun@nic.cz> wrote:
>
> > For some reason the Host Control2 register of the Xenon SDHCI controlle=
r
> > sometimes reports the bit representing 1.8V signaling as 0 when read
> > after it was written as 1. Subsequent read reports 1.
> >
> > This causes the sdhci_start_signal_voltage_switch function to report
> >   1.8V regulator output did not become stable
> >
> > When CONFIG_PM is enabled, the host is suspended and resumend many
> > times, and in each resume the switch to 1.8V is called, and so the
> > kernel log reports this message annoyingly often.
> >
> > Do an empty read of the Host Control2 register in Xenon's
> > .voltage_switch method to circumvent this.
> >
> > Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
>
> I should probably add a Fixes tag here so that it gets backported to
> stable versions.

Yes, please do.

In regards to the comment in the code you added in $subject patch, I
would suggest to slim down that quite a bit. More details are
available in the commit message, so a few lines should be sufficient,
in my opinion.

> BTW this happens on Turris Mox.

Perhaps add that in the commit message, too.

Kind regards
Uffe
