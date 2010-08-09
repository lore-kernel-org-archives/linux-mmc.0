From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Mon, 9 Aug 2010 18:24:49 +0000
Message-ID: <AANLkTikUypKobPAHsE+tz-Py-XvvJhbcj7Syj3rX_ej0@mail.gmail.com>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35047 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab0HISYu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2010 14:24:50 -0400
Received: by qwh6 with SMTP id 6so7484545qwh.19
        for <linux-mmc@vger.kernel.org>; Mon, 09 Aug 2010 11:24:49 -0700 (PDT)
In-Reply-To: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

2010/8/3 Roy Zang <tie-fei.zang@freescale.com>:
[...]
> @@ -240,6 +240,8 @@ struct sdhci_host {
> =A0#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1<<25)
> =A0/* Controller cannot support End Attribute in NOP ADMA descriptor =
*/
> =A0#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1<<26)
> +/* Controller uses Auto CMD12 command to stop the transfer */
> +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 =A0 =A0 =A0 =A0 =A0 =A0 (=
1<<27)
>
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq; =A0 =A0=
 =A0 =A0 =A0 =A0/* Device IRQ */
> =A0 =A0 =A0 =A0void __iomem * =A0 =A0 =A0 =A0 =A0ioaddr; =A0 =A0 =A0 =
=A0 /* Mapped address */

Just a cosmetic hint: I suggest SDHCI_QUIRK_MULTIBLOCK_READ_AUTO_CMD12
or something for the quirk name, because ACMD12 part might be confused
with MMC/SD App CMD 12 (CMD55+CMD12 combo) if/whenever that gets used.

Best Regards,
Micha=B3 Miros=B3aw
