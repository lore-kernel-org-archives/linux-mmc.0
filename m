From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3 v2] dts: Add sdhci,auto-cmd12 field for p4080 device
	tree
Date: Wed, 4 Aug 2010 18:08:13 -0600
Message-ID: <AANLkTinUj=wUhk9qns8X2aUHHv3UpYhoE1yMMr2eMLD+@mail.gmail.com>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
	<1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50257 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811Ab0HEAIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2010 20:08:34 -0400
Received: by gyg10 with SMTP id 10so2236070gyg.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2010 17:08:33 -0700 (PDT)
In-Reply-To: <1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

On Mon, Aug 2, 2010 at 9:11 PM, Roy Zang <tie-fei.zang@freescale.com> w=
rote:
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> =A0Documentation/powerpc/dts-bindings/fsl/esdhc.txt | =A0 =A02 ++
> =A0arch/powerpc/boot/dts/p4080ds.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A01 +
> =A02 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt b/Docum=
entation/powerpc/dts-bindings/fsl/esdhc.txt
> index 8a00407..64bcb8b 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> @@ -14,6 +14,8 @@ Required properties:
> =A0 =A0 reports inverted write-protect state;
> =A0 - sdhci,1-bit-only : (optional) specifies that a controller can
> =A0 =A0 only handle 1-bit data transfers.
> + =A0- sdhci,auto-cmd12: (optional) specifies that a controller can
> + =A0 =A0only handle auto CMD12.

I read this, but I still don't understand what it means.  What does
"auto CMD12" mean?  Are there other kinds of CMD12?  Part of this
might be my ignorance about how eSDHC works, but it could be clearer.

Also, you can feel free to merge this patch with patch 1 in your
series.  I makes sense to update the documentation and the driver at
the same time.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
