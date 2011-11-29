From: Daniel Drake <dsd@laptop.org>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Tue, 29 Nov 2011 15:42:22 -0600
Message-ID: <CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
References: <WC20111118085327.010279@terrafix.co.uk>
	<CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
	<WC20111118100011.2902A2@terrafix.co.uk>
	<CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
	<WC20111129111750.470087@terrafix.co.uk>
	<CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35103 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab1K2VmX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2011 16:42:23 -0500
Received: by ghrr1 with SMTP id r1so6867883ghr.19
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2011 13:42:22 -0800 (PST)
In-Reply-To: <CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Nov 29, 2011 at 6:43 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Tue, Nov 29, 2011 at 1:17 PM, Joe Woodward <jw@terrafix.co.uk> wrote:
>> Any more feedback on this?
>
> Daniel, can you please take a look ?

Even though I have the pleasure of working with 8686 quite a bit, I'm
blind to how it works on the inside, so I don't have any expert
insight.

So first thing to do is to investigate the source of this error, as before:
[   34.637481] libertas_sdio: probe of mmc1:0001:1 failed with error -16

which is likely bubbling up from somewhere inside the mmc/sdio layer.

Daniel
