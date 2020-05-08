Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CB1C38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 08:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBDAE208DB
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 08:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOYhnpQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEHIiq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 04:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgEHIip (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 04:38:45 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD49C05BD43
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 01:38:45 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id r2so367193uam.7
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rP7Qz76iRLxaCx4sjpHDWwQ1yELEtUAlCDt+pz+OBdY=;
        b=sOYhnpQwa1YRJVLSJKmuSW4yl3KOW6d8BusdT0JT9eK5DLIFUcN7lbrmppX7+HORcq
         yXxZd9fQuqaLHVO9iSWW3YU3FOGs0jSoBCcDFxEIshM/3RcjTH1IeISfp+aa7SpCifQo
         0Tlx7x785yIs3lGSChY73pwe9+GAQDwrbETtJDedgZTqI5qvf19hksiTpmeVipODbUSv
         zdnZjUUeWwbe8hNEttc+NVbjPVkHxLGK9MnAY/t6Iw+FQLdSkZ990MvNUEW4pV9xe1xd
         kSlm+9gwuqVBK6bk+y+2YQ+f6MvCp/ODDAXefacIXJBMBnp/44LJAgtftqwt0vP8VLhQ
         iq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rP7Qz76iRLxaCx4sjpHDWwQ1yELEtUAlCDt+pz+OBdY=;
        b=A0q/JwcecOzEiTQiAIfLKsVYrXi8LOgQkco6LxLKt8SuF6pxwHYkeOdvSVUCRdIq2R
         PzRK+Y2anKIbRW25l68yZuLXjahuza9vM6QN1facq10Kkk3+X+Eivllgc31EE6x9/x3R
         Y4PNbRMjkVRo+aGQPvdvcgrpaMRYFCQnbnKRqrCEHepAzQ/U1tfV29psihB1T1XM0vDq
         didEOBC4bXjhrhPYBTf04smFA0EEaSbEOuAk4oOnHHYO6/GCd+CUYibS5LXaB5wl5dd5
         E5c9lyZJdxSPBNWFq9Zo5Ix+0LEk4VKPzqETAYHvn2f7jmbwMp/2euFravrKRhHa0zQ0
         BR2w==
X-Gm-Message-State: AGi0PuYRy5zfdqKnbOkQQnR1vqvjHLoMBhJXjRcSLOxdyS0AFXZBcTps
        LuxAtQbrIzqJ4T6vo1KfbDYpFapU/YlHn6Nosjz9JQ==
X-Google-Smtp-Source: APiQypJ0/WlSG3eW70DWZpc0tIfMXSMtW9EcN1RHD5NeGsS1DmOjiYIqYifsNY+6GtgWXu190/b+J9iiJTJU+dqN0Cg=
X-Received: by 2002:ab0:5ca:: with SMTP id e68mr941260uae.19.1588927124020;
 Fri, 08 May 2020 01:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200414161413.3036-1-ulf.hansson@linaro.org> <20200414161413.3036-7-ulf.hansson@linaro.org>
 <20200414183959.GA15141@qmqm.qmqm.pl> <CAPDyKFr6yq+xA_dcRTDrZ_ek8Jjmiep+Fp_RYfozPdv7FFaW+Q@mail.gmail.com>
In-Reply-To: <CAPDyKFr6yq+xA_dcRTDrZ_ek8Jjmiep+Fp_RYfozPdv7FFaW+Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 May 2020 10:38:07 +0200
Message-ID: <CAPDyKFqoe4goNa-K9gmRujgwL-_Hff0MRPvpod7etkj0L8wmzQ@mail.gmail.com>
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

On Wed, 15 Apr 2020 at 09:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 14 Apr 2020 at 20:40, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.=
qmqm.pl> wrote:
> >
> > On Tue, Apr 14, 2020 at 06:14:00PM +0200, Ulf Hansson wrote:
> > > Some commands uses R1B responses, which means the card may assert the=
 DAT0
> > > line to signal busy for a period of time, after it has received the
> > > command. The mmc core normally specifies the busy period for the comm=
and in
> > > the cmd->busy_timeout. Ideally the driver should respect it, but that
> > > requires quite some update of the code, so let's defer that to someon=
e with
> > > the HW at hand.
> > >
> > > Instead, let's inform the mmc core about the maximum supported busy t=
imeout
> > > in ->max_busy_timeout during ->probe(). This value corresponds to the=
 fixed
> > > ~2s timeout of the polling loop, implemented in cb710_wait_for_event(=
). In
> > > this way, we let the mmc core validate the needed timeout, which may =
lead
> > > to that it converts from a R1B into a R1 response and then use CMD13 =
to
> > > poll for busy completion.
> > >
> > > In other words, this change enables support for commands with longer =
busy
> > > periods than 2s, like erase (CMD38) for example.
> > [...]
> > > +     /*
> > > +      * In cb710_wait_for_event() we use a fixed timeout of ~2s, hen=
ce let's
> > > +      * inform the core about it. A future improvement should instea=
d make
> > > +      * use of the cmd->busy_timeout.
> > > +      */
> > [...]
> >
> > I'm not sure whether the controller limits busy signalling time.
> > Since this is rare HW now, I would just pass the timeout to
> > cb710_wait_for_event() and see if someone reports a bug.
>
> Alright, let me try something like that. Thanks for your suggestion.

I looked a bit more closely at your suggestion, but unfortunately it
requires quite some changes to the code.

To pass a timeout and need to move cb710_wait_for_event() from using a
fixed number of polling loops into using "timeout_ms" value instead.
Although, rather than open coding yet another new polling loop and
perhaps introduce new errors, I prefer moving to readx_poll_timeout().
However, to do that, even more changes are needed around
cb710_check_event().

Once that is done, we also have cb710_wait_while_busy(), that uses a
similar polling loop as cb710_wait_for_event(). So then it seems
reasonable to convert this one too.

To conclude, for now, I am going to apply $subject patch as is. Then
we can always do the above conversion later on, if we see that there
is a need for it.

Kind regards
Uffe
