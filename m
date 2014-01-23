From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] mmc-utils: add eMMC 5.0 FFU support
Date: Thu, 23 Jan 2014 11:26:54 -0800
Message-ID: <CANEJEGsE1N=zzCDODz+4xUNZf3Ti9_FOthe8b+SM+5qv9fh2LQ@mail.gmail.com>
References: <1390501260-8730-1-git-send-email-grundler@chromium.org>
	<86k3dq1qqx.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:64132 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbaAWT0z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jan 2014 14:26:55 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so2694555oag.9
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jan 2014 11:26:55 -0800 (PST)
In-Reply-To: <86k3dq1qqx.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Grant Grundler <grundler@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

On Thu, Jan 23, 2014 at 10:45 AM, Chris Ball <chris@printf.net> wrote:
> Hi,
>
> On Thu, Jan 23 2014, Grant Grundler wrote:
>> +     cid[13] = 0;    /* make sure string is NULL terminated */
>
> Ah, and if you're respinning the patch anyway, would you object to
> using '\0' here?  Just a style preference, either way is okay.

Hi Chris!
Adjusting the coding style is no problem. But I'd prefer to wait a day
or two before respinning this patch.

I want to see if anyone can commit to testing this code first.
Prodding people off-list now that the patch is posted and I can point
them at this forum.

cheers,
grant

>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <chris@printf.net>   <http://printf.net/>
