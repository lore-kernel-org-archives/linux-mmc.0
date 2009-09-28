From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Mon, 28 Sep 2009 22:02:27 +0200
Message-ID: <da15981b0909281302y59011a63h9d999c7ba94bf63f@mail.gmail.com>
References: <1254160269.10634.15.camel@localhost> <4AC0FBF0.6090007@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:65273 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbZI1UCo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2009 16:02:44 -0400
Received: by bwz6 with SMTP id 6so1538131bwz.37
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2009 13:02:47 -0700 (PDT)
In-Reply-To: <4AC0FBF0.6090007@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>, akpm@linux-foundation.org
Cc: philipl@overt.org, ian@mnementh.co.uk, matt@console-pimps.org, pierre@ossman.eu, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

Hi David,

On Mon, Sep 28, 2009 at 8:09 PM, David Vrabel <david.vrabel@csr.com> wr=
ote:

=2E..

> That's a fair amount of work so perhaps in the interim something like=
 this:
>
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -494,6 +494,9 @@ int mmc_attach_sdio(struct mmc_host *host, u32 oc=
r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr &=3D ~0x7F;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (ocr & MMC_VDD_165_195)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: warning: card =
claims non-standard 1.65-1.95
> V support"
> +
> =A0 =A0 =A0 =A0host->ocr =3D mmc_select_voltage(host, ocr);
>
> =A0 =A0 =A0 =A0/*


Thanks, that would work for us just fine.

=46WIW,

Ack-by: Ohad Ben-Cohen <ohad@wizery.com>


Regards,
Ohad.
