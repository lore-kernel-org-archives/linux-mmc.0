From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: mmc_rescan failure in case of CONFIG_MMC_UNSAFE_RESUME
Date: Mon, 14 Feb 2011 11:04:13 -0800
Message-ID: <AANLkTimkW0JDUT-8ERrGTimLUpqWvgNd5jYLfuXodL==@mail.gmail.com>
References: <loom.20110212T012758-658@post.gmane.org>
	<20110212172205.GA9608@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45901 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab1BNTEP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 14:04:15 -0500
Received: by iyj8 with SMTP id 8so5123389iyj.19
        for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2011 11:04:14 -0800 (PST)
In-Reply-To: <20110212172205.GA9608@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Chris,

On Sat, Feb 12, 2011 at 9:22 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Dmitry,
>
> On Sat, Feb 12, 2011 at 12:33:33AM +0000, Dmitry Shmidt wrote:
>> Recently new check was added to core.c function mmc_rescan():
>> =A0 =A0 if (host->bus_ops && host->bus_ops->detect && !host->bus_dea=
d
>> =A0 =A0 =A0 =A0 && mmc_card_is_removable(host)) <<<< This one
>> =A0 =A0 =A0 =A0 host->bus_ops->detect(host);
>> mmc_card_is_removable() is checking
>> =A0!(host->caps & MMC_CAP_NONREMOVABLE) && mmc_assume_removable;
>>
>> If we use CONFIG_MMC_UNSAFE_RESUME then
>> =A0 mmc_assume_removable will be 0 and any card will be always consi=
dered
>> as non-removable. And host->bus_ops->detect() will not be called on =
card
>> removal.
>
> I agree that we've changed the behavior to avoid running ->detect
> in this case, but that was intentional -- you should not be using
> CONFIG_MMC_UNSAFE_RESUME on a card that is physically removable.
> Why are you trying to?

MMC_UNSAFE_RESUME is affecting mmc_sdio_resume() sequence. If it is
not defined then sdio card will be considered
"removable" and on resume mmc_sdio_init_card() will be always called.

static int mmc_sdio_resume(struct mmc_host *host)
{
     ...
     if (mmc_card_is_removable(host) || !mmc_card_is_powered_resumed(ho=
st))
          err =3D mmc_sdio_init_card(host, host->ocr, host->card,
                        (host->pm_flags & MMC_PM_KEEP_POWER));


>
> config MMC_UNSAFE_RESUME
> =A0 =A0 =A0 =A0bool "Assume MMC/SD cards are non-removable (DANGEROUS=
)"
> =A0 =A0 =A0 =A0...
>
> Thanks,
>
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>

Thanks,
Dmitry
