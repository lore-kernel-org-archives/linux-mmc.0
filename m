From: Loic pallardy <loic.pallardy@gmail.com>
Subject: Re: [PATCH v1 5/5] mmc: card: Add RPMB support in IOCTL interface
Date: Tue, 10 Jul 2012 14:28:46 +0200
Message-ID: <CAKGveeYiwWWVaxcm0HnJi3cLuFFYVrDZMdbNt2V96he_TGwPog@mail.gmail.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
	<1341564244-6178-6-git-send-email-loic.pallardy@stericsson.com>
	<CAKYAXd_EPPvC4tRLjugMxy09_2Hd8bsGmkmYrzf_k3L621rPSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45036 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab2GJM2r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jul 2012 08:28:47 -0400
Received: by obbuo13 with SMTP id uo13so22094108obb.19
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jul 2012 05:28:46 -0700 (PDT)
In-Reply-To: <CAKYAXd_EPPvC4tRLjugMxy09_2Hd8bsGmkmYrzf_k3L621rPSw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Loic Pallardy <loic.pallardy@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Alex Macro <alex.macro@stericsson.com>

Repost in text format

2012/7/10 Namjae Jeon <linkinjeon@gmail.com>
>
> >
> > +     err = mmc_blk_part_switch(card, md);
> > +     if (err)
> > +             goto cmd_rel_host;
> > +
> Should it wrapped by if (is_rpbm) condition ? It can be called in other
> ioctl.
It was my first implementation, but in that case you have to manage a
session, switching on RPMB partition at the begining of the IOCTL and
restore previous partition at the end. (because RPMB partition doesn't
support all commands).

Having a look to how mmc driver manages partition selection, I saw
that mmc_blk_issue_rq for instance calls mmc_blk_part_switch in the
beginning to be sure it's on the right partition, but never restores

The proposal is to use same way and to make it compliant with Boot and
GP partitions if there are any special commands supported by them.
>
> >       if (idata->ic.is_acmd) {
> >               err = mmc_app_cmd(card->host, card);
> >               if (err)
> >                       goto cmd_rel_host;
> >       }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
