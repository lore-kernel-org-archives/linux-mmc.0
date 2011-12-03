From: Daniel Drake <dsd@laptop.org>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Sat, 3 Dec 2011 10:45:58 -0600
Message-ID: <CAMLZHHQsFgRoVPhO0+VqOLXfRS=oaENoiS4cLU6hZ1G=6nGLoA@mail.gmail.com>
References: <CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
	<CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com>
	<CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com>
	<CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com>
	<WC20111130150051.910209@terrafix.co.uk>
	<CAK=WgbbBF1=YJyc2MF2fgNtPbbqF=-9L53=LKoEmkgA43PjSdw@mail.gmail.com>
	<WC20111201112805.3502EA@terrafix.co.uk>
	<CAMLZHHSGL20vr7E1rMO47RsxOmO-UPRyOdnqq=DUie3FVzNcaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36519 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab1LCQp6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 3 Dec 2011 11:45:58 -0500
Received: by vbbfc26 with SMTP id fc26so3011963vbb.19
        for <linux-mmc@vger.kernel.org>; Sat, 03 Dec 2011 08:45:58 -0800 (PST)
In-Reply-To: <CAMLZHHSGL20vr7E1rMO47RsxOmO-UPRyOdnqq=DUie3FVzNcaQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Sat, Dec 3, 2011 at 10:44 AM, Daniel Drake <dsd@laptop.org> wrote:
> On Thu, Dec 1, 2011 at 5:28 AM, Joe Woodward <jw@terrafix.co.uk> wrote:
>> I've had a play with the nRESET line (as far as I can tell it is the only pin I have access to), and no joy.

The card is being reset and powered up successfully during boot, then
powered down, then it fails to power up again.
Can you confirm that the reset line is definitely being fiddled during
the second and failing power up?

Thanks
Daniel
