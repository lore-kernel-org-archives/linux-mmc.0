Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8CBC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Mar 2022 10:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbiCBKfO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Mar 2022 05:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbiCBKfK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2022 05:35:10 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CA0BECC8
        for <linux-mmc@vger.kernel.org>; Wed,  2 Mar 2022 02:34:27 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id s25so1631481lji.5
        for <linux-mmc@vger.kernel.org>; Wed, 02 Mar 2022 02:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNE5Fuk1S7VXvQWbBVtfenLyBK3DknXKrcGn5hcrC6I=;
        b=SRlP8dzJ0rC/EvoM4tj7g6i/4vbgCbZIyewg7h8zVcIb2lmEwGdvnZcP8pWUGiYDCp
         Etcac9xOik3FU78hmVWyTqvbHSl9EwWfZrnE9irY3NYFYfjdESKx1h619SVLYlfwb/Kt
         LNIc91aCRs6r2aI+4VCV4d0ooPE5dpzxe/f2cwQ0hVULcWdVehAeboiKH6elxoDi2iqi
         OSon0gGaZBKrtdIHLGRmMyEmWRiMGjrrMUwIXZVMsRL1cqtnbb2/KpmFddMLGqhOLxuq
         s127+/dG0TQ0mCDQ3UNtAhPKEEqkbv8QTT2FOf72w5/Pm/RPHyU1CLBqNem4Y8Z3oHFo
         p6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNE5Fuk1S7VXvQWbBVtfenLyBK3DknXKrcGn5hcrC6I=;
        b=lBvlttre5i6AduywBHPq9Klc/BPm484Nz0CRe+JOGcoAq31OxL89caEFQZwmdiJb7D
         NQI/jB2FgiZ7fBRKOsMFyXZUvRzciJWZ0OfZmUu+9yg56hQ7VW81jZoA2ONAPj5+Dzls
         M0mig4opc+oyV3h0uQ1KAPyFgRqtnte/OtrwzxLqqSFL4n8FA6/gx8FNFzSwMnddwJJ9
         XpkmQkH3XRhzwkVlISVayBNxwJU6u6gqs0nn8JjYzrV60UaaxCjCCQpn3e7szz84L1pL
         0AO9L/U5yyexw8sNwRPK19filo6FtO4bU7B7pvs8QcMjQLUfdAPpb7ARdU7fIIwoC5JR
         XqEw==
X-Gm-Message-State: AOAM533beN40/u3c1xFL8qaWF+xwIenDfHa/AM0H0Hqc/hbadHTwEDIW
        L3bg0gUvp0t67GpVNula3TC8MkDKgMIRkoVmSUZcng==
X-Google-Smtp-Source: ABdhPJxy/8lfE+WWmK9cypiL6fx/Xc5LX8PSSehEJwhnWoXNJqHnm6TstUokNOEm6UeTIjZ2qTAxSuM7EQsHKF1Vq7I=
X-Received: by 2002:a05:651c:201b:b0:246:34b5:155e with SMTP id
 s27-20020a05651c201b00b0024634b5155emr18829620ljo.273.1646217265345; Wed, 02
 Mar 2022 02:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20220301115300.64332-1-ulf.hansson@linaro.org> <Yh6PjZ9/HAiyZ09M@kroah.com>
In-Reply-To: <Yh6PjZ9/HAiyZ09M@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Mar 2022 11:33:49 +0100
Message-ID: <CAPDyKFrWHvK2+o8vg27v2NWRe0JZ3vTk111djpM2fJ8X3Oqgtg@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Fix build errors/warnings for unused variable
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 1 Mar 2022 at 22:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 01, 2022 at 12:53:00PM +0100, Ulf Hansson wrote:
> > The struct device *dev, is no longer needed at various functions, let's
> > therefore drop it to fix the build errors/warnings.
> >
> > Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Fixes: 7570fb41e450 ("mmc: rtsx: Let MMC core handle runtime PM"
>
> Forgot the trailing ')' character :(

Ohh, checkpatch should have spotted that, I thought.

Anyway, sorry and thanks for fixing!

>
> I've fixed this up and ignored the obviously incorrect kbuild
> warnings...
>
> thanks,
>
> greg k-h

Kind regards
Uffe
