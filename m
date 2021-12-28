Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E161C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Dec 2021 17:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhL1RHY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Dec 2021 12:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbhL1RHY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2021 12:07:24 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC2EC061574
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 09:07:23 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id i11so19225446ljm.13
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99T/DzDeAoRKFL/9h5yQJkVqThx1LN+AQmuFq6NJhWo=;
        b=N6ZLwd0zof+OYL4/wWJ6U2EFYTcEAtXpQmmYUP6sy4OgOLJlHdmEPlAIvwtatW9ADg
         7LR7YSgkWJbOXNFDHRma1ysUCjtmEMAWBE/zd9wSzTYnzwwwEc8OryTGyMUY/Jq5Kg9n
         12E5mjNUHMVn07xyVupeebJVbVavggcDWzDz0ywIhZ1UDjz/mBXOhmQhHkuQT0RUK6jF
         MaSMCo/X0C5U/muueG/aeg1RTbf5gEke+xjk7kUxFxJy2yYBhZ9G3pbTeIYUrIpXlSvl
         XiWazCCGkUkn/5RaYLr1cdX0POjfsYofjB2Jj1tgRB7mICuVguXgb/kP+NlpFhaOyrof
         x5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99T/DzDeAoRKFL/9h5yQJkVqThx1LN+AQmuFq6NJhWo=;
        b=I0L/4owoWCzP+Ph43+kRv8PJQeGDoClXucw9IBWh6OEP0QH+46rd/9Nqr+/xDDdbyI
         kH0yqUG9sLEEyn9FTG0dGcKkK5cOTkeDGorUEsSstxi6NuKzspnv3umhu51IzUGl8/DP
         qet+gexCcy51fLjWSUMzk3awRDiV68Z+/xVSJVI0c1dQOIYfe+qqdZQIlpF2X5BBcj+T
         7/c0Gf/yI4SBUmb6SS3ESqoCyUJBNgmkF4RLAGOAfLHrskQfyXdfsNszePAR1IvJHigT
         clGvZ5MwqsQ7hFI0ldQ4JvoqbnCKKcV1F8/Voux2vzp5LEy2H62+1kn8qGfHd0EVz3aJ
         DZZA==
X-Gm-Message-State: AOAM533+wYtX74Kc8hTkUKLWX/JXVbMPRLXAEwCpqzdiM40iM92HNlHV
        BwN+9Zfv03fGmQ03e+THZlJsr2VJdHqUb6vlrWwAvA==
X-Google-Smtp-Source: ABdhPJwrzYp+3AgtaKZt6PTu34W4MSjtFEGIoIndpok5uTqOXhsgqPh2P0UcVK+t+BgNRi6Aw0UP8nFX1/RUabBJO6E=
X-Received: by 2002:a2e:968d:: with SMTP id q13mr18266787lji.463.1640711240745;
 Tue, 28 Dec 2021 09:07:20 -0800 (PST)
MIME-Version: 1.0
References: <sq6sp6$cs9$1@ciao.gmane.io>
In-Reply-To: <sq6sp6$cs9$1@ciao.gmane.io>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 18:06:44 +0100
Message-ID: <CAPDyKFon=yS81Nxyx30s4sgtMT8VdurRNOCSzM3pzZTWTBThyw@mail.gmail.com>
Subject: Re: nothing happens upon SD card insertion (Asus Zenbook UM425IA, RTS522A)
To:     Julian Sikorski <belegdol@gmail.com>,
        =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>,
        Rui Feng <rui_feng@realsil.com.cn>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Ricky and Rui,

On Sat, 25 Dec 2021 at 11:50, Julian Sikorski <belegdol@gmail.com> wrote:
>
> Hello,
>
> I have an Asus Zenbook UM425IA laptop with Realtek RTS522A card reader:
>
> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A
> PCI Express Card Reader (rev 01)

Hi Julian,

I assume that means you are using the
drivers/mmc/host/rtsx_pci_sdmmc.c. So, I have looped in some of the
main authors to this mmc/sd driver. Let's see if they can help in some
way.

Kind regards
Uffe

>
>
> Almost every time when I insert a card into it, nothing happens - no
> dmesg message or anything.
>
> echo 1 | sudo tee -a /sys/kernel/debug/tracing/events/mmc/enable
>
> sudo cat /sys/kernel/debug/tracing/trace_pipe > mmc_trace.txt
>
> also results in an empty file. If I am lucky, the card will be detected
> after some delay and the following will appear in the log:
>
> Dez 25 11:34:41 snowball3 kernel: mmc0: cannot verify signal voltage switch
>
> Dez 25 11:34:41 snowball3 kernel: mmc0: new ultra high speed SDR50 SDHC
> card at address aaaa
>
> Dez 25 11:34:41 snowball3 kernel: mmcblk0: mmc0:aaaa SL32G 29.7 GiB
>
> Dez 25 11:34:41 snowball3 kernel:  mmcblk0: p1
>
>
> How can I investigate this further? As things stand now, the reader is
> almost unusable. I am using 5.15.11-200.s0ix01.fc35.x86_64 kernel. Thank
> you in advance.
>
> Best regards,
> Julian
>
