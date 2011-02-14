From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: mmc_rescan failure in case of CONFIG_MMC_UNSAFE_RESUME
Date: Mon, 14 Feb 2011 13:54:27 -0800
Message-ID: <AANLkTin0e=wUR_WXMaVcX1U1Ln6WGHCx-836nv7Rn1Sd@mail.gmail.com>
References: <loom.20110212T012758-658@post.gmane.org>
	<20110212172205.GA9608@void.printf.net>
	<AANLkTimkW0JDUT-8ERrGTimLUpqWvgNd5jYLfuXodL==@mail.gmail.com>
	<20110214194013.GA3145@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55279 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab1BNVy2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 16:54:28 -0500
Received: by iyj8 with SMTP id 8so5280570iyj.19
        for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2011 13:54:27 -0800 (PST)
In-Reply-To: <20110214194013.GA3145@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>

Hi Chris,

On Mon, Feb 14, 2011 at 11:40 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Dmitry,
>
> [Cc +=3D Nico]
>
> On Mon, Feb 14, 2011 at 11:04:13AM -0800, Dmitry Shmidt wrote:
>> MMC_UNSAFE_RESUME is affecting mmc_sdio_resume() sequence. If it is
>> not defined then sdio card will be considered
>> "removable" and on resume mmc_sdio_init_card() will be always called=
=2E
>>
>> static int mmc_sdio_resume(struct mmc_host *host)
>> {
>> =A0 =A0 =A0...
>> =A0 =A0 =A0if (mmc_card_is_removable(host) || !mmc_card_is_powered_r=
esumed(host))
>> =A0 =A0 =A0 =A0 =A0 err =3D mmc_sdio_init_card(host, host->ocr, host=
->card,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->pm_flags & MM=
C_PM_KEEP_POWER));
>
> mmc_sdio_init_card() is supposed to be called if your card is removab=
le,
> because the card might have changed. =A0It has a fast path that's ena=
bled
> by MMC_PM_KEEP_POWER. =A0(Nicolas explained this back in October.)
>
> You absolutely should not enable MMC_UNSAFE_RESUME if your host has a
> removable card. =A0It's an awful hack, and you just found an example =
of
> where it breaks.

My main concern was that here we are mixing two things: removable
cards and cards that stay powered and need quick resume.
It is possible to assume that last ones are not removable, but I feel
it is not 100% correct. For example you may have
removable wlan sdio adaptor.

> If you need mmc_sdio_resume() to have an even faster path for you, we=
 can
> talk about that and see if it makes sense. =A0Misusing MMC_UNSAFE_RES=
UME to
> get a powered SDIO resume is just wrong.

So what can we do to suppress resume for removable sdio card ?

>
> Thanks,
>
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>

Thanks,

Dmitry
