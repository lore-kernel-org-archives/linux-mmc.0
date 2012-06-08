From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [CFT 04/11] mmc: omap: add DMA engine support
Date: Fri, 8 Jun 2012 10:52:11 +0200
Message-ID: <CACRpkdYVSuH_hFcwkqo-i6-aTZrmFx5GP80RC8b3xdu=SWHeEg@mail.gmail.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
	<E1ScaYw-0003th-6i@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44055 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933917Ab2FHIwM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jun 2012 04:52:12 -0400
Received: by eaak11 with SMTP id k11so900492eaa.19
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jun 2012 01:52:11 -0700 (PDT)
In-Reply-To: <E1ScaYw-0003th-6i@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thu, Jun 7, 2012 at 1:07 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add DMA engine support to the OMAP driver. =A0This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This looks good as well:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
