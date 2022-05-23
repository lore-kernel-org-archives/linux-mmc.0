Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7243C43217
	for <linux-mmc@archiver.kernel.org>; Mon, 23 May 2022 12:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiEWMgi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 May 2022 08:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiEWMfy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2022 08:35:54 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6A4B40F
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2022 05:35:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id d137so25068159ybc.13
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2022 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZl/fl0qeIvUdvyZE0jXdpw2d7CYxFND/Aqlck8hL7Y=;
        b=g3QNKrPTU1y3Hrxty3WEbBcbkZxQCGaVdrI1t7cV6FoIHEh9ApyTyjigXadNjRuARd
         WBsyRpJpm6CvGeg1/msOeMA1GJYcN27fAsKFCV4xQO/fRhTP2iDjT8bYzY93h8B+Nkib
         JBFdE0ll5yFBll//1q9Be7OjXIdJe0O6nC8fDo1eIINQWobSNLsforLswaDJNel/hmwD
         Xxsc/+qAQBGThqbn8YkDwke51gsJsgLlfeZCIUnuT3kh9WjLDs6WokwERf93TXAelLDt
         q3Wjw0yC1wU1SCETaIoppFY5Mcn/wYzsfVrKegm6WRuj5DoO4cSBLYLOlXX6z/jtENFg
         +g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZl/fl0qeIvUdvyZE0jXdpw2d7CYxFND/Aqlck8hL7Y=;
        b=rVMm0rjzI6cub0n56Btkc1XR5V41XVyAVsVqnOCcqJF14m+VXzWn66GKHRH+3gFUPz
         NTuuRq/Ln+4fl+hqixzQW1sKSjA9iR+8o6b/5eapQcY2aUML3PWVDDYuSsvqohV5LEgE
         Yor/2OzsHWoIoC530odsxMBn+RqvK00N053pHF3rUGqzOYkV5uckyUigzVMCIRl0Jbxq
         dmijXaGEqlAkT3LfhtbCevJ98lFRmXNiGOXyF4DtTnFdiLFJaKlT1XXzZKlyazVb4kxF
         J3WnKz0CxKGsOf5wO73KihfE4vdjA4idI6oTB1ez3qwAerf7VD4A20zMv3cAJ3Cz25RE
         P1Vg==
X-Gm-Message-State: AOAM531fAPZ/gyBjm4nCJhH1u9qE9yVR5r/Td4cP+MMThnLYUxwvnrn7
        87S2DmRJFK1vv9pzI0+rBrAG8uBUeZ1xwzSrhLRIdA==
X-Google-Smtp-Source: ABdhPJxe/lvuePKCeGxuB9+ABxg16S0q/9rDILB02Ubcpk7fvZjoqmGGH2zyZ9//gkOuI4bTXW0IMEtSpS2nkzeORqg=
X-Received: by 2002:a05:6902:2c6:b0:64f:5b77:6869 with SMTP id
 w6-20020a05690202c600b0064f5b776869mr15492879ybh.494.1653309332081; Mon, 23
 May 2022 05:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt4+47GzfEYT1nV3dqbGa1YCwFm9XwC668D4PkK4BHFgQ@mail.gmail.com>
 <55d49dea-1a67-d857-218e-ef2343251361@i2se.com>
In-Reply-To: <55d49dea-1a67-d857-218e-ef2343251361@i2se.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 23 May 2022 18:05:20 +0530
Message-ID: <CA+G9fYvF7HGmJQtk7ktmakwQNjjraK3EoBeiMr+3NuEvsixi6Q@mail.gmail.com>
Subject: Re: WARNING: CPU: 2 PID: 3331 at drivers/firmware/raspberrypi.c:63 rpi_firmware_property_list
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 23 May 2022 at 16:43, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi Naresh,
>
> Am 23.05.22 um 11:04 schrieb Naresh Kamboju:
> > The following kernel warning was noticed on raspberrypi4 device while
> > running LTP controllers with Linus mainline kernel tree.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > metadata:
> >    git_ref: master
> >    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >    git_sha: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
> >    git_describe: v5.18
> >    kernel_version: 5.18.0
> >    kernel-config: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/config
> >    artifact-location: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu
> >    toolchain: gcc-11
> >    System.map: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/System.map
> >    vmlinux.xz: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/vmlinux.xz
>
> thanks for your report.
>
> Do you know this worked before (e.g. 5.17)?

Yes. it worked before.

> Am I correct that you are using GPU firmware 2021-02-25T12:10:40?

Correct.

- Naresh
