From: Daniel Drake <dsd@laptop.org>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Wed, 30 Nov 2011 08:12:13 -0600
Message-ID: <CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com>
References: <WC20111118085327.010279@terrafix.co.uk>
	<CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
	<WC20111118100011.2902A2@terrafix.co.uk>
	<CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
	<WC20111129111750.470087@terrafix.co.uk>
	<CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
	<CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
	<CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45301 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab1K3OMN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 09:12:13 -0500
Received: by yenl6 with SMTP id l6so526458yen.19
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2011 06:12:13 -0800 (PST)
In-Reply-To: <CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Nov 30, 2011 at 4:36 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Hi Daniel,
>
> On Tue, Nov 29, 2011 at 11:42 PM, Daniel Drake <dsd@laptop.org> wrote=
:
>> Even though I have the pleasure of working with 8686 quite a bit
>
> (Is there a subtle cynicism here ? :)
>
>> So first thing to do is to investigate the source of this error, as =
before:
>> [ =A0 34.637481] libertas_sdio: probe of mmc1:0001:1 failed with err=
or -16
>>
>> which is likely bubbling up from somewhere inside the mmc/sdio layer=
=2E
>
> Well, it sounds like Joe might need a hand here.

I can't reproduce it.

My suggestion is to follow the debugging steps from previous threads
on this topic such as
MMC runtime PM patches break libertas probe
The goal is to identify the line of code that is causing this error.
Use printk debugging in the codepaths mentioned earlier until the
point of failure is known. Let me know if further direction is needed.

> Since this regression is directly caused by commit 08da834 "mmc:
> enable runtime PM by default", which you authored and have interest
> in, it does make sense that you help Joe here. In case you're short o=
f
> time, then I suggest to revert 08da834 (which anyway was
> experimental), and get back to it later, when you're more available.

My patch simply sets a flag to enable a whole load of code written by
you - code which I understand little about. I am now available to
help, but given that my understanding of mmc is limited, I didn't
write the code in question, and I also lack expert insight into 8686
powerup, I'm not sure how useful I can be.

Daniel
