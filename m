From: Daniel Drake <dsd@laptop.org>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Wed, 30 Nov 2011 08:57:06 -0600
Message-ID: <CAMLZHHRmsd4VL-iuWqOcqYQBpqzYLm7JfjMyzFyXJQbQUpdUjg@mail.gmail.com>
References: <WC20111118085327.010279@terrafix.co.uk>
	<CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
	<WC20111118100011.2902A2@terrafix.co.uk>
	<CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
	<WC20111129111750.470087@terrafix.co.uk>
	<CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
	<CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
	<CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com>
	<CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com>
	<CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38058 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357Ab1K3O5I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 09:57:08 -0500
Received: by yenl6 with SMTP id l6so569988yen.19
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2011 06:57:07 -0800 (PST)
In-Reply-To: <CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Nov 30, 2011 at 8:29 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Let's revert 08da834 then.

Sounds fine to me, although it may make sense to wait and see if Joe
is able to perform further diagnosis, which may raise some clues.

If we go ahead with the revert, can you help me come up with a way to
whitelist it for OLPC? Would a DMI-based quirk in sdhci be acceptable
for you?

Thanks,
Daniel
