From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: stalled mmc patches
Date: Tue, 29 Sep 2009 23:45:17 +0100
Message-ID: <c09aa50a0909291545i6545e82s9e83a38dd79c36f9@mail.gmail.com>
References: <20090929131540.27d72d52.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:39660 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbZI2Wpe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2009 18:45:34 -0400
Received: by fxm18 with SMTP id 18so4895509fxm.17
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2009 15:45:37 -0700 (PDT)
In-Reply-To: <20090929131540.27d72d52.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <damm@opensource.se>, Paul Mundt <lethal@linux-sh.org>, Albert Herranz <albert_herranz@yahoo.es>

Please drop the tmio patches - I have a better method finished up more
or less and will be rready for submission soon.

2009/9/29 Andrew Morton <akpm@linux-foundation.org>:
>
> Guys, I'm still sitting on four patches which varius people have (or
> had) objections to.
>
> Could we please revisit these and provide advice on how to proceed?
> Thanks.
>
> http://userweb.kernel.org/~akpm/mmotm/broken-out/mmc-make-the-configu=
ration-memory-resource-optional.patch
> http://userweb.kernel.org/~akpm/mmotm/broken-out/tmio_mmc-optionally-=
support-using-platform-clock.patch
> http://userweb.kernel.org/~akpm/mmotm/broken-out/sh-switch-migo-r-to-=
use-the-tmio-mmc-driver-instead-of-spi.patch
>
> and
>
> http://userweb.kernel.org/~akpm/mmotm/broken-out/sdio-recognize-io-ca=
rd-without-powercycle.patch
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
