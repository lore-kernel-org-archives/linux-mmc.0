From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH v2] mmc-utils: add eMMC 5.0 FFU support
Date: Mon, 3 Feb 2014 09:21:15 -0800
Message-ID: <CANEJEGvgy4jD8vPmpMecjyqgEk6-oYFmiWhDfiefXy4_Tn-DKA@mail.gmail.com>
References: <1390506264-17107-1-git-send-email-grundler@chromium.org>
	<86wqhdxv02.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:40702 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbaBCRVQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Feb 2014 12:21:16 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so8113880obc.39
        for <linux-mmc@vger.kernel.org>; Mon, 03 Feb 2014 09:21:16 -0800 (PST)
In-Reply-To: <86wqhdxv02.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Grant Grundler <grundler@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

On Sun, Feb 2, 2014 at 9:52 AM, Chris Ball <chris@printf.net> wrote:
> Hi Grant,
>
> Still waiting on the remaining warning/error,

Sorry - was out thurs/fri. I'm wondering why I didn't see that warning before.

> and also noticed a trivial typo:

Typo fixed (locally).

I got good feedback from one of the HW vendors and I'm missing two
parts of the eMMC 5.0 spec:
1) send ext_cad[FFU_ARG] as the parameter to CMD25 (not 0x0000ffff)
2) follow the description of MODE_OPERATION_CODES instead of just sending CMD0.

I was also told sending CMD0 might confuse the kernel state. Do you
know if that's true?

What state does the kernel expect the device to be in after FFU?

cheers,
grant
