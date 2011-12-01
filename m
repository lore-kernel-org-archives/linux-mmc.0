From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Thu, 1 Dec 2011 09:50:01 +0200
Message-ID: <CAK=WgbZ88U2_-ub9jSYf+jJOtr3W1d_3fkhT+PHeLrjA-accRg@mail.gmail.com>
References: <WC20111118085327.010279@terrafix.co.uk> <CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
 <WC20111118100011.2902A2@terrafix.co.uk> <CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
 <WC20111129111750.470087@terrafix.co.uk> <CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
 <CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
 <CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com>
 <CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com>
 <CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com> <CAMLZHHRmsd4VL-iuWqOcqYQBpqzYLm7JfjMyzFyXJQbQUpdUjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52658 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab1LAHuY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2011 02:50:24 -0500
Received: by ggnr5 with SMTP id r5so1535641ggn.19
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2011 23:50:24 -0800 (PST)
In-Reply-To: <CAMLZHHRmsd4VL-iuWqOcqYQBpqzYLm7JfjMyzFyXJQbQUpdUjg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Nov 30, 2011 at 4:57 PM, Daniel Drake <dsd@laptop.org> wrote:
> If we go ahead with the revert, can you help me come up with a way to
> whitelist it for OLPC?

Sure thing.

> Would a DMI-based quirk in sdhci be acceptable for you?

I wasn't following sdhci development so much as I'm not developing on
such hardware, so I'll have to take a look. AFAIK though sdhci is
maintained by Wolfram, so you need his consent. Whatever approach
Wolfram and you will agree on is of course fine with me.

Thanks,
Ohad.
