From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Mon, 30 May 2011 09:52:48 +0300
Message-ID: <BANLkTikQC+u5yyU+YBAZ5JpFDRFHrHNOoA@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
 <AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
 <AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
 <AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
 <AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
 <AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>
 <AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com>
 <AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com>
 <AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>
 <AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com>
 <AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com>
 <AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com> <BANLkTikpciJnTudOeSLM_O7AAD4GGkbbOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36191 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab1E3GxL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 02:53:11 -0400
Received: by wya21 with SMTP id 21so2409701wya.19
        for <linux-mmc@vger.kernel.org>; Sun, 29 May 2011 23:53:10 -0700 (PDT)
In-Reply-To: <BANLkTikpciJnTudOeSLM_O7AAD4GGkbbOw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Daniel,

On Sun, May 29, 2011 at 7:21 PM, Daniel Drake <dsd@laptop.org> wrote:
> It's certainly possible that there's something weird about the
> hardware in question, but we *are* able to successfully power down an=
d
> up the card with a hacky rfkill driver that calls mmc_stop_host /
> mmc_start_host.

Are we talking about the XO-1.5 and the sd8686 ?

Last we talked, we found out runtime PM didn't work because the sd8686
required an additional manipulation of an external reset gpio line,
and that the only reason OLPC could power it down/up was this patch:

http://dev.laptop.org/git/olpc-2.6/commit/?h=3Dolpc-2.6.35&id=3De9bee72=
1fb0cc303286d1fe5df4930ce79b0b1e0

One of the suggested solutions back then was to use a regulator for thi=
s.

Has anything changed since then ? does mmc_stop_host+mmc_start_host
work for you without manipulating that reset gpio ?

> =A0 =A0 =A0 =A0err =3D mmc_send_io_op_cond(host, 0, &ocr);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;

This part actually makes sense.

While sending a CMD5 arg=3D0 is not mandatory when initializing embedde=
d
SDIO cards (like the wl12xx is), some cards might still require it,
and it is actually anyway required by the spec for removal cards.

I just tried it briefly with the wl12xx, and things seems ok.

>     printk(KERN_WARNING "%s: card claims to support voltages "
>                      "below the defined range. These will be ignored.=
\n",
>                      mmc_hostname(host));

Please drop this warning though. It was already displayed when
mmc_attach_sdio() executed, so the user already knows his card has
this thing. With the wl12xx, you'd see this everytime you bring up the
interface, so it's really unnecessarily too noisy.

> Any thoughts?

One other thing to consider is system resume. when wol is disabled,
and your chip is powered off during system suspend, you'd need this
CMD5 arg=3D0 in the resume path as well.

Some code refactoring should be considered to avoid duplicating this
snippet three times though.

Otherwise, submit :)

Thanks,
Ohad.
