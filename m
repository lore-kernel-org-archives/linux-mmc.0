From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: Huge regression caused by "mmc: Fix sd/sdio/mmc initialization
 frequency retries"
Date: Mon, 18 Jul 2011 21:22:23 +0200
Message-ID: <CAMJBoFNoZ2wVtr1kyF2uFhr5LQDRTsGLsiyvWMWf50eUkEaBMg@mail.gmail.com>
References: <CAMJBoFMyoY9-Y8XEWKYua6UPaFWA2LH3FgP0fK9TpB6JgbQWXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42537 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1GRTWY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2011 15:22:24 -0400
Received: by qyk29 with SMTP id 29so1674741qyk.19
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2011 12:22:23 -0700 (PDT)
In-Reply-To: <CAMJBoFMyoY9-Y8XEWKYua6UPaFWA2LH3FgP0fK9TpB6JgbQWXQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi again,

On Mon, Jul 18, 2011 at 1:08 PM, Vitaly Wool <vitalywool@gmail.com> wrote:
> Hi,
>
> the patch mentioned in subject is bound to break the functionality of
> some SDIO cards' drivers. In fact, it will fail for any card probing
> that requires an interrupt to consider itself complete.

please disregard this, it's surely been fixed by
34497913f2936fd43c86b007da7224bb8e77fd15.

I don't know why it's nit in the stable series we use internally but
anyway... Sorry for the noise :)

Thanks,
   Vitaly
