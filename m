Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7136AC4708C
	for <linux-mmc@archiver.kernel.org>; Fri, 28 May 2021 08:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C28613DA
	for <linux-mmc@archiver.kernel.org>; Fri, 28 May 2021 08:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbhE1IVq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 May 2021 04:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbhE1IVq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 May 2021 04:21:46 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47635C061574
        for <linux-mmc@vger.kernel.org>; Fri, 28 May 2021 01:20:12 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id m9so1763247vsq.5
        for <linux-mmc@vger.kernel.org>; Fri, 28 May 2021 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vs/Z8cNbN6rWZZUIzFqk73JuH21yhbQgClQlKiTvuGY=;
        b=CKtdTHl8gbhSMIXkTgN4lcdrM6NQhqQPQpCklHFeh543j6cXWTJdGVHYC3DwRAGjvv
         ROXucRimHXFRm0e9eNyGcIdIGBzuelvNDwH3VG1yt6mcJxjrEXdNGb1i5PrWKrZrcq4d
         UDXinkdYf5iYpTWjRHxrdnRvcoLiGvf3LEG3lvM1w5o1IQKbETHmKo2kmecPNGMk5eaP
         PJSvqLr0Kx2YbokPtFxnD0d7Krz59rfEt0zgmt3HUMOcwNL1xbLc1w38v7a4081/ve3C
         GRcGwW8KXRTNntOH0rAivJdnbBFarAF4gSrHLsWUXxyyq5hf/8o/zHgvpKMJCVd51I4u
         7oSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vs/Z8cNbN6rWZZUIzFqk73JuH21yhbQgClQlKiTvuGY=;
        b=puq36jUAw85TOI+2WMCq20YBrd6tS+yRaTg5vyY/505boXn5zlJv0ZPBJmCYSbk8de
         1+XdLniO4Ma/OjU1rC4XUorWnaGFUuMc9Dwh8SpbU8fJnHYSG/LrMwblx1xqJ/RK1u5I
         wtDR4vG36pIRstHoajhK6byKz9c7IyVDy3uVfrCS7mLMQYyi+cFFFT9DW+ij9GWvjmnW
         HOmr+h2O2SIz4Y6+llTyAKPyDPZQHj4BUI+L2nTAseMZVzfJaasrT7jvVrHEHedBoRJJ
         oA+RMcABt7WBBWfQbJ/dehKr0aXm+lQ4P20Aeon332zwPWscf3y+s14E6TmJbSrQ7sxX
         KAUA==
X-Gm-Message-State: AOAM531PHyhyvRq1qLvNHul+FVk7ZMIWoqnbdk9ez6/JlQ+Vk267WwJI
        tCdMofsOdMbS4V9GpdRloc5NNxl36owGZ6bMZAJj6Q==
X-Google-Smtp-Source: ABdhPJzbuGFwuc5Ut1yyEp5cG5pF3fEgtZEbdI1jzAJS2eVGM/kGNkv9LjpgUuxpUacltLgz4xJHBLjmwcmn4oLW/8c=
X-Received: by 2002:a67:42c6:: with SMTP id p189mr5608029vsa.55.1622190011348;
 Fri, 28 May 2021 01:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210514171233.qerhkjn3redivien@pali> <20210528002111.wei44qtoptgj6mlo@pali>
In-Reply-To: <20210528002111.wei44qtoptgj6mlo@pali>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 May 2021 10:19:35 +0200
Message-ID: <CAPDyKFoBaSFSrFFPkYaChcAGHBnxpe=74TbKNqNH6_sh=47ooQ@mail.gmail.com>
Subject: Re: Who assigns SDIO vendor IDs?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 28 May 2021 at 02:21, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello Ulf! Do you know something about SDIO vendor ID assignment?

I am sorry, but I don't know.

If you have a contact at the SD Association (sdcard.org), I would
start to ask there to see if that can be a way forward.

I have looped in Avri as well, may he can help in some way.

Kind regards
Uffe

>
> On Friday 14 May 2021 19:12:33 Pali Roh=C3=A1r wrote:
> > Hello!
> >
> > I would like to ask if somebody knows who assigns SDIO vendor IDs?
> >
> > In SDIO Simplified Specification Version 3.00 available from website
> > https://www.sdcard.org/downloads/pls/ in section 16.6 CISTPL_MANFID is:
> >
> >   The TPLMID_MANF field identifies the SDIO Card's manufacturer. New
> >   codes are assigned by both PCMCIA and JEIDA. The first 256 identifier=
s
> >   (0000h through 00FFh) are reserved for manufacturers who have JEDEC
> >   IDs assigned by JEDEC Publication 106. Manufacturers with JEDEC IDs
> >   may use their eight-bit JEDEC manufacturer code as the least
> >   significant eight bits of their SDIO Card manufacturer code. In this
> >   case, the most significant eight bits shall be zero (0).  For example=
,
> >   if a JEDEC manufacturer code is 89h, their SDIO Card manufacturer cod=
e
> >   is 0089h. If a SDIO card manufacturer does not currently have a
> >   TPLMID_MANF assigned, one can be obtained at little or no cost from
> >   the PCMCIA.
> >
> > So IDs 0x0000 - 0x00FF are assigned by JEDEC 106 and because JEDEC 106
> > contains one parity bit, it means that only 128-reserved IDs are
> > available for SDIO vendor ids and they were already assigned. This is
> > basically clear and list of these (id, vendor) tuples can be find in
> > JEDEC 106 publication.
> >
> > But who assigns remaining SDIO vendor IDs 0x0100 - 0xFFFF? PCMCIA
> > website http://www.pcmcia.org/ is already down and according to USB-IF
> > press information found in document USB_IF_01212010.pdf from archive
> > https://web.archive.org/web/20160304121938if_/http://www.usb.org/press/=
USB_IF_01212010.pdf
> > USB-IF acquired PCMCIA assets which probably means also assigning PCMCI=
A
> > vendor IDs.
> >
> > In archive of www.pcmcia.org is available very old list of vendor IDs:
> > https://web.archive.org/web/20051202104141/http://www.pcmcia.org/tuplei=
d.htm
> >
> > I have tried to find some information about PCMCIA or SDIO vendors and
> > IDs assignment on USB-IF website https://www.usb.org/ but there is
> > absolutely nothing.
> >
> > So has somebody any clue what happened with PCMCIA and its relation wit=
h
> > SDIO vendor IDs?
