Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E646C2BB85
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 07:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA1B206D9
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 07:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ok0tuz3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635246AbgDOHmi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635239AbgDOHmb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 03:42:31 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667F0C061A0C
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 00:42:31 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b5so1666140vsb.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F87yBcIyKSu0nxfuCM86OGVmr1k2pDPg6h+KbZkI4sg=;
        b=Ok0tuz3IlQaaErx44IFkG4f1V2uWE46e9qEO4JxDa9F+yJcz/pAiof57JdA6yxKsGR
         eAmyfe6ymGsL1OJVspBrT9WRlhnbWTT12gxesnBUzmfpVsXpD1D4C3SDId/rQszweIzv
         BsaJyX/HuoJpL3skBU4523jn+Y8kZKsMjD2a47tksueOVFDbcPZngKMk2N3Ep9jn7ape
         mUBPBpEwsIRaBas41wy6lacjb4j2VG3tsJuhJLgmep0T/5tAM5InwYX3E4XNJM2YjqRm
         jbZCRYg5bnAp/xXg2N4oZ2vnsUOE1JOXYpLjoROkUSlHw+9P+4e77iiufok23k+GPr0G
         rXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F87yBcIyKSu0nxfuCM86OGVmr1k2pDPg6h+KbZkI4sg=;
        b=opakjfPTSwHT300dmDk4/CXYiu7CfWLXxhW6CXcSuiWStsd8UWfOPrvKxJ543Jav9b
         /a/Au8tVflnrrUycOlOCY9jgy6WrTBON49/WkChSiv1ckilzoUP9A8w8Suhm446yoNQb
         sowjLvodUOsfJFuDC4gOgusy2NS5stDNilTH7aJp3DHxmPTPEcz/pzFxxd0fRquswNQN
         LJTVH3pcLJQwAIcKkSx2x1sIKMmn7iZp953Y/rUcGLGs16LHtGPeWSFd/DOrXCNWcg3h
         4hJ1p3TJTjToc2A5uzwToeMbnIaVlWWDDguTh+4H7C3tHDqSA00x/V07VKKh2JohOXWz
         TrSA==
X-Gm-Message-State: AGi0PuZ3rR4EsEiOdHLQP1X7RiHRTXTBqXDqhloTyYhrRvZKlksV+xUY
        VHgxq+0+HCo5XAYAuNiXZgoQSaRyPJrbtqaLD4uf5w==
X-Google-Smtp-Source: APiQypKSeQiuRW3friCpKlcav2dVTHHPTcQrWmJ1N1ivhLvzy+OEgpRc77BhBcM2mU1lR6UjUBXPnrFaYvaZ8MPf8Ho=
X-Received: by 2002:a05:6102:4a7:: with SMTP id r7mr3166437vsa.200.1586936550466;
 Wed, 15 Apr 2020 00:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200414161413.3036-1-ulf.hansson@linaro.org> <20200414161413.3036-7-ulf.hansson@linaro.org>
 <20200414183959.GA15141@qmqm.qmqm.pl>
In-Reply-To: <20200414183959.GA15141@qmqm.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 09:41:54 +0200
Message-ID: <CAPDyKFr6yq+xA_dcRTDrZ_ek8Jjmiep+Fp_RYfozPdv7FFaW+Q@mail.gmail.com>
Subject: Re: [PATCH 06/19] mmc: cb710: Inform the mmc core about the maximum
 busy timeout
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Apr 2020 at 20:40, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qm=
qm.pl> wrote:
>
> On Tue, Apr 14, 2020 at 06:14:00PM +0200, Ulf Hansson wrote:
> > Some commands uses R1B responses, which means the card may assert the D=
AT0
> > line to signal busy for a period of time, after it has received the
> > command. The mmc core normally specifies the busy period for the comman=
d in
> > the cmd->busy_timeout. Ideally the driver should respect it, but that
> > requires quite some update of the code, so let's defer that to someone =
with
> > the HW at hand.
> >
> > Instead, let's inform the mmc core about the maximum supported busy tim=
eout
> > in ->max_busy_timeout during ->probe(). This value corresponds to the f=
ixed
> > ~2s timeout of the polling loop, implemented in cb710_wait_for_event().=
 In
> > this way, we let the mmc core validate the needed timeout, which may le=
ad
> > to that it converts from a R1B into a R1 response and then use CMD13 to
> > poll for busy completion.
> >
> > In other words, this change enables support for commands with longer bu=
sy
> > periods than 2s, like erase (CMD38) for example.
> [...]
> > +     /*
> > +      * In cb710_wait_for_event() we use a fixed timeout of ~2s, hence=
 let's
> > +      * inform the core about it. A future improvement should instead =
make
> > +      * use of the cmd->busy_timeout.
> > +      */
> [...]
>
> I'm not sure whether the controller limits busy signalling time.
> Since this is rare HW now, I would just pass the timeout to
> cb710_wait_for_event() and see if someone reports a bug.

Alright, let me try something like that. Thanks for your suggestion.

Kind regards
Uffe
