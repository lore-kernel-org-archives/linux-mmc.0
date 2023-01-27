Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83727C61DA4
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Jan 2023 10:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjA0K5o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Jan 2023 05:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjA0K5j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jan 2023 05:57:39 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED7C22A2D
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jan 2023 02:57:37 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c124so2986119pfb.8
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jan 2023 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NRNxC7t9AaAGI/XYMONVgmLZnSBjQemSUmZVeQIyo2w=;
        b=syw4ai7K3pU3EOeNBmBDGNaQXP7UWQZaegLh1mKdYcM+eSWNJBYxKcq4dDxWxvSb/A
         G74WzN4GGC5D8zEY45aJb4XSCxYXij+2O8R6aYopCKnQTqdLpxcf0Q2QwbnNTf8NzatJ
         VmCREB+yGiPGwI47ETI+dFi5Dsrk+sVEkqPrDDYTi4uEudqg7zfb1KySnGGoaxQsPWeX
         14Ho6CCUckrSanx5EBcaWokSoGKwaoIkgTlDhkrdg9d1R5e8Un5crqIJvuINkvCJ6RwY
         3G772zDEzVO/4AbcZZxenFnWsA54gZEHLoWbRfUOPsPOxMVDndtwmt81vI23PwLl2oeF
         hzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRNxC7t9AaAGI/XYMONVgmLZnSBjQemSUmZVeQIyo2w=;
        b=M94Gov7ej+zJGAnJNu6GVDDlUK/GnUNG+snx6vE3Xm0MPkxlvLDXilcV8uIFmFhgy+
         SrEV/vV4qfoSSHRZlpzZ1QVJ8bk7VZSNI9vQspZA52FjD5Zlxb0Ay45HJRJQsC4J+IXq
         IvTlZmeVJIgUKzp10Rbj7Oh3p7k022+a5scLdIBYGTiBGPEH1063c0b342HMfG2PJX5r
         M53phBQI9jM3PAe8H9M5QdQnf3kAWwgRK1biZTciTrZwxvgbYatbchA5l8rTMPmtpeLp
         XMVnG+nKT72W0GKuGgei4+ePdrYe/nt0GdiJoAWg4w1ZPPL0cx3/NifS031hp/KxL0uR
         b7TA==
X-Gm-Message-State: AO0yUKX1/uJ4Gt2kUqq072HOMfk5lcxXdKthanolGH5zGLUv+VwjY3Ae
        e7RidkHzwI6Nu0mp0At/bf6yziwq7VDnJWuQMKFY3VK/c0og7Q==
X-Google-Smtp-Source: AK7set8OklhYkTPyqrhcVOZGeyesQoR2GAMjPTL1p0zZ+I/x4vQQ2k5hpuv6igjSA4ImWtFLC/E0gNwWk1i3kvXs1sU=
X-Received: by 2002:a63:e612:0:b0:4da:6c3c:74cf with SMTP id
 g18-20020a63e612000000b004da6c3c74cfmr1050269pgh.10.1674817057044; Fri, 27
 Jan 2023 02:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20221230194315.809903-1-t.schramm@manjaro.org>
 <20221230194315.809903-2-t.schramm@manjaro.org> <54b0dcc0-5083-3ee9-6536-e58b8c01e96c@microchip.com>
In-Reply-To: <54b0dcc0-5083-3ee9-6536-e58b8c01e96c@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Jan 2023 11:57:00 +0100
Message-ID: <CAPDyKFpEuMnfrwCZ74P_zW-Bh3ZB3175aDbVAY1nL=SxWSud-w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: atmel-mci: fix race between stop command and
 start of next command
To:     Ludovic.Desroches@microchip.com, t.schramm@manjaro.org
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Jan 2023 at 15:44, <Ludovic.Desroches@microchip.com> wrote:
>
> On 30/12/2022 20:43, Tobias Schramm wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > This commit fixes a race between completion of stop command and start of a
> > new command.
> > Previously the command ready interrupt was enabled before stop command
> > was written to the command register. This caused the command ready
> > interrupt to fire immediately since the CMDRDY flag is asserted constantly
> > while there is no command in progress.
> > Consequently the command state machine will immediately advance to the
> > next state when the tasklet function is executed again, no matter
> > actual completion state of the stop command.
> > Thus a new command can then be dispatched immediately, interrupting and
> > corrupting the stop command on the CMD line.
> > Fix that by dropping the command ready interrupt enable before calling
> > atmci_send_stop_cmd. atmci_send_stop_cmd does already enable the
> > command ready interrupt, no further writes to ATMCI_IER are necessary.
> >
> > Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
>
> Hi,
>
> In theory this changes make sense. I'm always afraid when something is
> changed in this driver which handles many version of the IP...
>
> As we never encountered this issue until now, I can't really test this
> fix. I checked on an old board at91sam9m10g45-ek that mmc is still
> working and it's okay.
>
> So
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
>
> Regards,
> Ludovic

Thanks for your ack and thoughts!

It's not clear to me whether the problem is hypothetical or in fact a
real problem. Tobias can you help to fill in here?

Nevertheless I have applied this for next, to allow more testing to be
done. In the meantime, we can discuss whether we should add a stable
tag or leave that to later as manual backports.

[...]

Kind regards
Uffe
