Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865CFEB64D8
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jun 2023 09:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjFVJWH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Jun 2023 05:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjFVJVh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jun 2023 05:21:37 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A85D4209
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jun 2023 02:12:08 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5702116762fso73826777b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jun 2023 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687425127; x=1690017127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wgQ5NZ37+lO0vpak9yIlryZrXj8cUqWlWgr+TXC62Q=;
        b=opHjtYthU4vBRbRd1kGwIYIZa17pmdsYcYeZvhDm/63Pmy/kYJhLzilfcAI9zDPisF
         J4x4QDW66vDzXjzgE05+/oJDZqPkDBxmU6dYZrQpWp5wma8gmc71G1Q5J1jT8s+qJ8Jb
         BXnTH7PaErMrPABvHITfKStNy+V/nvkYc6ns6jQTzczAchrsftItiCFhOGJi1+2BKlvN
         5exNUUcU9fXZLVVaFuaUh3z4y5BAYc+gMLWUcM3uoiR8WIPq8g15i+1G+LvEetkj2loN
         fBz+YRlf1ujFCZ6CCm7Xe6ChMB7vMLn+DKjFqYk9Pk61HkEEhIDXUs0HocnYoXTFev+m
         VfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687425127; x=1690017127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wgQ5NZ37+lO0vpak9yIlryZrXj8cUqWlWgr+TXC62Q=;
        b=PWWhCA97+sFNaPXG7KYgZ9cSnnFXIK5zP0rmjqPD+GktQWpThA3dmwsGJHdfVMJy1j
         W7cHVI0Xa2Jq5z6HVzBKj1EMJZJmAgKlFPsT6V18sDA6GsnH7ge+o+YeBE69737WddkA
         Uk8Sf8/6z7JOL7a6yYq54XwuJ+sDda17NkLdVNqcuaoyyrzwYLy1q1pb4sYhdA8DpUx+
         fq+aztajMjz5PIfwWOpIutJ7khiNIVcA+bI8tQV/RFKfTqk3/QQBOCpKcRkV1ve3MfnS
         LOgRYZV5UzncfJKtCMqPYMpDFxIqtylRRzKD/n8ah/TaIr3YmJ4SnRtI0T2KNA6loBXg
         AC9A==
X-Gm-Message-State: AC+VfDzhDU1KxizZ5meOjVONIEZtnwS0IjHVPVmzJnOdkhSgU+7921+P
        7ZLfXOVxIdMfwgFuRqxMVfPahHEJ+/uz5fsV6hj1Lc1amKGpU1Of
X-Google-Smtp-Source: ACHHUZ5czDqSg3nWq1jTHyHs0WhmJlv6yntqWA6UyY91hesVVFgY58NxJsPmyYbC7HJx6jCUL6AojMnKhTYMswAVdrw=
X-Received: by 2002:a25:b199:0:b0:bcc:a9b4:c1f8 with SMTP id
 h25-20020a25b199000000b00bcca9b4c1f8mr13689030ybj.33.1687425127628; Thu, 22
 Jun 2023 02:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230620091113.33393-1-ulf.hansson@linaro.org>
 <CACRpkdZfhPxFZhjiU9k5fjM9v9VOuZwu16eyn_qHL4Jm+CyhBg@mail.gmail.com>
 <CAPDyKFqXu9R=+281Ovt=ZR6VHYAv96LEvP+DgaZo2aHJB8_dgw@mail.gmail.com>
 <CAPDyKFrwBWrdMmwqJeTothwmLFiPmZy0+CreZu5cUMKpxiuXjQ@mail.gmail.com> <CACRpkdYMjwnBv9kGxMcUpx0-Ogpc6E2jcqBaZbwj195c5mtUxQ@mail.gmail.com>
In-Reply-To: <CACRpkdYMjwnBv9kGxMcUpx0-Ogpc6E2jcqBaZbwj195c5mtUxQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Jun 2023 11:11:30 +0200
Message-ID: <CAPDyKFr-eVXAtwu1h0iSORO-cmRwH1v1ceZq3psw1KKB55xX2Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Add support for SW busy-end timeouts
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>,
        Yann Gautier <yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 21 Jun 2023 at 23:13, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Wed, Jun 21, 2023 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
>
> > > More importantly, the busy timeout work never gets to run, which
> > > indicates that we are no longer hanging and waiting for an IRQ to be
> > > raised. Is that correct?
> >
> > Ehh, I should have looked more closely at the log. Indeed there is one
> > case where the timeout work kicks in.
>
> Yeah...
>
> It wasn't until I added the timeout that I could get the whole
> thing to work, both are needed: handling lost IRQs and then
> an occasional timeout.
>
> > Maybe we should log the information about the current ->busy_state at
> > that point too, so understand under what condition we are hanging? I
> > think we should also log the actual used timeout in this case.
>
> Sure thing, please merge this patch as-is (solves a problem!) and I try
> to make a debug improvement patch on top with what I have (like
> printing the command) and add in the busy state as well.

Okay, I have applied the patch for next, thanks!

Yann, feel free to provide your tested-by tag too, I can amend the
patch after I have applied it.

Kind regards
Uffe
