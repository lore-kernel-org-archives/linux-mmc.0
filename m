Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48EAC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 14:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FBB61076
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 14:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbhKHOcV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 09:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbhKHOcE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 09:32:04 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AD0C061746;
        Mon,  8 Nov 2021 06:29:20 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q124so27826788oig.3;
        Mon, 08 Nov 2021 06:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=68r1lgwXM3RG0RRJc0xxy8x2Y9oUDOK8ImS4lcfjZPI=;
        b=U2nd9MHWQlajh8UZYZKwbQoxDazN+Sbi8zVp10acdFOt1qqkVCuoLJ+1z6tvfcz01v
         DrPvPUxsQFbRMNOWvRN9FfnBGHKh7T9/trfcZjVYj7mhRyiFCb1cnzzhg3R+3dlhgMTM
         Y5WE0QwMlR6rSd6LTSHb6qs71E1fKIhADfYc+ur24qLbZ62yNo7k98axBlYW/G8pCdFZ
         5UtkTvLbXDsaSjEUTvQhb8KY6P4OTcWIMSDUOaQ1wsaa4VglkZYPeTyWuPXJ0D/Hhbgi
         6JIJU5MZQ/EMU0/SdoIk894bywXIBlKP0AfDLmCYwINgwMlGmxW6ctOK8FkKvDpYBZY4
         DZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=68r1lgwXM3RG0RRJc0xxy8x2Y9oUDOK8ImS4lcfjZPI=;
        b=307fHy1T/QHos5gBOhWf1zM33VuPkfEBiwrHgTxSxjKcYKrZbUy+apwgN8GG3nnFXl
         WBFalsdHfBbaw1pMyAZ8NK0SChvRiXJWnc+2TyLby32IsZSpDwhKRtOFn3/2dg93U6Xm
         KmmOwyorIjvs0fubpU4MtA0cM/Pc3/Lp2YEYPMiC632mGX1cJW8YZwKKy3cFAWn+B3HM
         m4iYntlTXFhMGi30jbO55VkhWKUerBQU8gidTCp62Qcl4qADD5oX2qApEopqODiz4ei/
         3LKWgHWoyK/8UgtxuODX9CktcZya8i4YvfzMm0Rg8es3V7Rd1aXd7P6OnLmVEjTXQiqL
         3Bxg==
X-Gm-Message-State: AOAM531yifLJUcTHr78hTP0ft82eroTzyo6bBTBDt1CjMaoQzQ7j0Dyt
        JrMu2lcIzONe7ro5hFwIplIENnDjDuViH+3ir8w8vOIGDis=
X-Google-Smtp-Source: ABdhPJzIpu6Yvoy0DvvwJP7+eYWIe6lu7afU6tSgrGh5o1XD/JtM6lSrT2uVGax6Q2tL58IShFlsSLq8T4cR6LrxpXw=
X-Received: by 2002:a05:6808:f09:: with SMTP id m9mr37656930oiw.68.1636381759469;
 Mon, 08 Nov 2021 06:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20211104063231.2115-1-huijin.park@samsung.com>
 <CGME20211104063250epcas1p36056caad956e599300146bae77f799d6@epcas1p3.samsung.com>
 <20211104063231.2115-3-huijin.park@samsung.com> <DM6PR04MB657559D2E25D4FF21689116CFC8D9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657559D2E25D4FF21689116CFC8D9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Huijin Park <bbanghj.park@gmail.com>
Date:   Mon, 8 Nov 2021 23:29:07 +0900
Message-ID: <CAMy0x0mUO3Sv-87MTvkn+hpYtKeWW7bEWSrjMopqupFytpOCpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: core: adjust polling interval for CMD1
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Huijin Park <huijin.park@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

2021=EB=85=84 11=EC=9B=94 4=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 4:27, A=
vri Altman <Avri.Altman@wdc.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> > In mmc_send_op_cond(), loops are continuously performed at the same
> > interval of 10 ms.  However the behaviour is not good for some eMMC whi=
ch
> > can be out from a busy state earlier than 10 ms if normal.
> >
> > Rather than fixing about the interval time in mmc_send_op_cond(), let's
> > instead convert into using the common __mmc_poll_for_busy().
> >
> > The reason for adjusting the interval time is that it is important to r=
educe the
> > eMMC initialization time, especially in devices that use eMMC as rootfs=
.
> That's an impressive improvement.
> Can you share some of the use-cases in which 10ms reduction in boot time =
is required?

It can be used as one of the improvements and tuning items that
can make rootfs preparation faster for cold booting.
(e.g. if it is delayed, it outputs "Waiting for root device.." log.)
Above all, I think it is not desirable to delay even though mmc
initialization is done.

Thanks,

>
> Thanks,
> Avri
