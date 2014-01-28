From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] mmc-utils: add eMMC 5.0 FFU support
Date: Mon, 27 Jan 2014 16:38:31 -0800
Message-ID: <CANEJEGuT+ZJHcJpZpB0DvV0V1C=kNzHZ+yi9_PVHjvmyyCdzHw@mail.gmail.com>
References: <1390501260-8730-1-git-send-email-grundler@chromium.org>
	<86ob321qw0.fsf@void.printf.net>
	<CANEJEGvpr3TB4PyfSOViy1D6avZQuKL7Km0DhnA5BiXDkYPV1w@mail.gmail.com>
	<86fvoe1ose.fsf@void.printf.net>
	<CANEJEGsYEF7pyWDHf2014hmJhEjJCYEfe1k+xso26tPY9cocEg@mail.gmail.com>
	<CANEJEGvTDtTG-VLD6=Lu0oz3BX-wq9y9zg96DYNGgTHEUgfVgg@mail.gmail.com>
	<86bnyz1pl0.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:49323 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbaA1Aib (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jan 2014 19:38:31 -0500
Received: by mail-ob0-f175.google.com with SMTP id wn1so7340316obc.34
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jan 2014 16:38:31 -0800 (PST)
In-Reply-To: <86bnyz1pl0.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Grant Grundler <grundler@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

On Sat, Jan 25, 2014 at 5:47 PM, Chris Ball <chris@printf.net> wrote:
> Hi Grant,
>
> On Thu, Jan 23 2014, Grant Grundler wrote:
>> respin sent with "v2" in subject line and includes the '\0' assignment change.
>>
>> Apologies again.
>
> Thanks, no worries.  Would you like me to take this now, or wait for
> testing?

Hi Chris!
If you are happy with the command line option, take it now.

We can fix up vendor specific stuff as vendors publish that
information. I am encumbered with NDAs through my employer.

I have asked the HW vendors to respond publicly with technical details
describing which FFU options need to be set for the update to work
with their parts. So I expect we will need some sort of vendor
id/model look up to select those options as those details become
available.

cheers
grant
