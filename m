From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [CFT 02/11] mmc: omap_hsmmc: add DMA engine support
Date: Fri, 8 Jun 2012 10:53:17 +0200
Message-ID: <CACRpkdaq5AYZapS-YSTXa4atJQESiqKvmpnXBYE_aOD4+PkigQ@mail.gmail.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
	<E1ScaYH-0003tV-Bn@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38370 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212Ab2FHIxS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jun 2012 04:53:18 -0400
Received: by eeit10 with SMTP id t10so911525eei.19
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jun 2012 01:53:17 -0700 (PDT)
In-Reply-To: <E1ScaYH-0003tV-Bn@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thu, Jun 7, 2012 at 1:06 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add DMA engine support to the OMAP HSMMC driver. =A0This supplements =
the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
>
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looks good:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
