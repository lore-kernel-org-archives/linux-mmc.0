Return-Path: <SRS0=8dup=3Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0123C2D0DB
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 11:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6947421739
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 11:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXRSyhOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgA0Li0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:38:26 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45014 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgA0LiZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jan 2020 06:38:25 -0500
Received: by mail-vk1-f195.google.com with SMTP id y184so2442645vkc.11
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jan 2020 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pvQd5k3S0vefTdIk1WMaCQGsRnAi8F4TO0mianp6scU=;
        b=dXRSyhOi+Nzw6VtqVbukbxevmDRYRSUDmc2M7EphLbRYVO9q4XRP5C5dE6cIh/tOny
         eSGmCNbwPjT21/6b5bYjZ4pYowyUJl5/DEUyRDt2VDMo7OCIuc5O8BDsQ2D1MNwXrbtg
         CBaMSIoOK1J+hZ5RD+rPHALnc8S7YmleKjxfRL/7lH/0V0YwD1gOZJ3IWH5Z8u0GrKqn
         QQHWcRssBoI4rDbedIKiaALJHrlem6Y55/G4bKD1xf0/JLA4lGwbwJORQzM8vJPAoHhW
         pXx3ygtnZPa3Pph7vG0UqOKRtk7Y4hnoBrMIQD5P+GfoUvC1Gh3vLACAiWRNI748q4i7
         9QPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pvQd5k3S0vefTdIk1WMaCQGsRnAi8F4TO0mianp6scU=;
        b=qa2EW3jDhujt/6VEIkgcHWCspzNZkBrfmDTdgzHaQOWPMXnBIiwJKbL26/TxeB1RHr
         6/ym6OkDUkGer3Y5F2nhmpyJw8OTXeRiNWv4Dz+bZ04LpfcWal84qyClp3fpAfrk7FC0
         ZXxlpYSD1oxOYAhclLQOa2umEFIhZEf/2FnBdB0ZRv6Nh3W6+buN4MOGe9PYL6AFkeXV
         j1X3fOnjicp3RKeXD9Su1rMt9MvXrssUM3OrU7fygC6zSKuCr8639CdATa92TDKPJXFQ
         IhQSKt3UcdnTt3snwbtleMc3w4TR3zkTakW3agkYlrNPAX7ut0MJ2alBUSy7wRkCd3Rz
         0zWA==
X-Gm-Message-State: APjAAAU4Xf/zZwRFM+ThP7jHK683fxspXOMBCbgMfeSsgN7zdTftKpkc
        iJkkr3x+Cn47GF5JauimcD9nwinEurTpDl5FSv8gZQ==
X-Google-Smtp-Source: APXvYqysl9H+UZn4ysQ+Qi1ZuynZA2qdNWPKVORR+2foXcAa58/rKBqFr1B+5nrHM//yAOko4TmConwsbpQeZNDFWhA=
X-Received: by 2002:a1f:434b:: with SMTP id q72mr8927513vka.53.1580125104141;
 Mon, 27 Jan 2020 03:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20190905200138.GA19037@impa.localdomain> <CAPDyKFqo-LecRE5R4T+vrGgNs83WFmQr84oaieEUTCjLFOLXoA@mail.gmail.com>
 <20200123104047.GA1254@impa>
In-Reply-To: <20200123104047.GA1254@impa>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Jan 2020 12:37:48 +0100
Message-ID: <CAPDyKFqOC8OTZZ+emKNr44yBoFnkRjW6Wd0Osgw-k4d+mJK5zw@mail.gmail.com>
Subject: Re: Black screen while resuming a SDXC (UHS) card (_mmc_sd_resume)
To:     Tim Schumacher <tim@timakro.de>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        pher1989@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Adrian

On Thu, 23 Jan 2020 at 11:40, Tim Schumacher <tim@timakro.de> wrote:
>
> On 2019-09-06, Ulf Hansson wrote:
> > On Thu, 5 Sep 2019 at 22:01, Tim Schumacher <tim@timakro.de> wrote:
> > >
> > > Hi,
> > >
> > > I'm sending this old bug by mail since a lot of developers don't use
> > > bugzilla.
> > >
> > > Original bug report on bugzilla by Pedro Rodrigues from 2019-01-30:
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D202459
> > >
> > > > This bug can be found on a Lenovo Miix 320-10ICR
> > > >
> > > > When using a SDXC (UHS) card, the screen becomes black if
> > > > _mmc_sd_resume() is called. After some investigation, I found that =
an
> > > > UHS card uses 1.8 V for signalling while a normal SD card uses 3.3 =
V. By
> > > > forcing the SDXC to use 3.3 V the black screen does not appear. It =
seems
> > > > that during a _mmc_sd_resume function call, while claiming the host=
, an
> > > > I2C resume function is called based on an existing supplier link be=
tween
> > > > the I2C bus and the card device.  The problem is that if the signal=
ling
> > > > voltage is configured to 1.8 V, during the I2C resume call, the scr=
een
> > > > turns black.  I was able to fix this issue by setting the initial s=
ignal
> > > > voltage (3.3 V) before suspending the card, so that when the card i=
s
> > > > resumed, the voltage is in the original state. To do this I added a
> > > > function call to mmc_set_initial_signal_voltage() during mmc_power_=
off
> > > > routine (drivers/mmc/core/core.c).  As I=E2=80=99m not an expert on=
 Linux,  I=E2=80=99m
> > > > posting the issue and possible solution so that it could be impleme=
nted
> > > > on a future release.
> > > >
> > > > Please, share your thoughts :)
> > >
> > > I can't provide further insight but I'm interested if this is possibl=
y
> > > the cause for the general issues people are having with the SD card
> > > reader on Lenovo Miix 320 devices.
> > >
> > > Those issues described in posts like
> > >
> > > https://vincent-ventures.com/2018/12/arch-linux-on-lenovo-ideapad-mii=
x-320/
> > > https://esc.sh/blog/linux-on-lenovo-miix-320/
> > >
> > > are (1) black screen when booting with an SD card installed and (2) w=
hen
> > > inserting an SD card after booting it shows up but upon trying to acc=
ess
> > > it the screen turns black until the card is removed again.
> > >
> > > I can confirm (1) on my Lenovo Miix 320-10ICR with kernel version
> > > 5.2.11. I can also confirm that only SDXC cards are affected, SD and
> > > SDHC cards work as expected.
> >
> > For the mmc community to help, you need to provide some kernel logs,
> > output from lspci, figure out what mmc host driver that is being used,
> > etc - in general collect more data. Then re-post the data to
> > linux-mmc, me and a potential mmc host driver maintainer (if there is
> > one). Yes, we can look into bugzilla as well, but first we need some
> > more overall info in an email.
> >
> > Most likely, if there is any response, you will be asked to test
> > patches. So you need to be able build and boot a new kernel, but I
> > guess you already know that part.
> >
> > Kind regards
> > Uffe
> >
>
> Hi, I'm coming back to this issue now. The issue is still present in
> kernel version 5.4.8.
>
> Kernel logs from boot with SD card and black screen: https://termbin.com/=
outp
> Kernel logs from boot without SD card: https://termbin.com/dc2y
>
> I couldn't find anything conspicuous in there, the card is working as
> expected. Only issue is the black screen (I'm doing these tests via SSH).
>
> lspci output: https://termbin.com/x452
>
> How do I figure out which mmc host driver is in use? I assume I'm
> looking for one of these https://github.com/torvalds/linux/tree/master/dr=
ivers/mmc/host
> I couldn't find anything like it in the kernel logs or from lsmod.
>
> Please read the original bug report by Pedro Rodrigues quoted above.
> He got to the technical core of the problem already and proposed a fix
> I assume could be understood, sanity checked and implemented by a mmc
> maintainer.

I have read the reports and browsed the data you provided. It seems
like this is an sdhci-acpi mmc/sd controller, Adrian Hunter (Intel
maintains this variant). There is one eMMC, which seems to work fine
and then the SD-card that you have inserted. The SD card looks like it
gets detected properly.

I don't see anything in the logs that stands out. However, I would try
a couple of different SD-cards, just to see what happens (if you have
more then one at hand). From that and going forward, I think I will
need to defer to Adrian's help. Perhaps we can put together some debug
patch for you to test, or so.

I will keep monitoring the discussion and fold in if there is anything
more I can help with.

Kind regards
Uffe
