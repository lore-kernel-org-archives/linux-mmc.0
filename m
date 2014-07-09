From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH v2 08/10] ARM: STi: DT: Enable second sdhci controller
 for stih416 b2020 boards.
Date: Wed, 9 Jul 2014 11:30:16 +0100
Message-ID: <20140709103016.GA5042@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1401898054-686-1-git-send-email-peter.griffin@linaro.org>
 <1401898054-686-9-git-send-email-peter.griffin@linaro.org>
 <CAPDyKFor1LqgAcJZc14iSY6D8RYm4w7sysRR3c2inSr4LVYt8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:48507 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbaGIKaX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jul 2014 06:30:23 -0400
Received: by mail-wi0-f176.google.com with SMTP id n3so2458801wiv.9
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jul 2014 03:30:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFor1LqgAcJZc14iSY6D8RYm4w7sysRR3c2inSr4LVYt8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice CHOTARD <patrice.chotard@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Ulf,

Many thanks for looking at this.

> > +
> > +               mmc1: sdhci@fe81f000 {
> > +                       status       = "okay";
> > +                       bus-width    = <8>;
> > +                       non-removable;
> > +               };
> >         };
> 
> Hi Peter,
> 
> I was trying to apply this patchset on my next branch, but the above
> file /arch/arm/boot/dts/stih416-b2020-revE.dts does not exist. And I
> don't see it in linux-next either.
> 
> What tree/patch are this based upon?

The patchset was on top of v3.15-rc1, however since then that file got renamed
to stih416-b2020e.dts, which went into 3.16 fixes.

See here for more details https://lkml.org/lkml/2014/6/18/241

Would you like me to re-send or can you up fixup?

regards,

Peter.
