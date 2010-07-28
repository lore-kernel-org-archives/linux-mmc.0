From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH v2 03/20] mmc: support embedded data field in mmc_host
Date: Wed, 28 Jul 2010 21:47:41 +0200
Message-ID: <AANLkTimzA_JJ-byTDWznbL3YzeJ8LAP4M50onf2_3fBF@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-4-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38532 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab0G1Trn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jul 2010 15:47:43 -0400
In-Reply-To: <1279733634-21974-4-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Kalle Valo <kalle.valo@iki.fi>, Pandita Vikram <vikram.pandita@ti.com>, linux@arm.linux.org.uk, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Roger Quadros <roger.quadros@nokia.com>, San Mehat <san@google.com>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

Hi Ohad,

On Wed, Jul 21, 2010 at 7:33 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Add support to set/get mmc_host private embedded
> data.
>
> This is needed to allow software to dynamically
> create (and remove) SDIO functions which represents
> embedded SDIO devices.
>
<snip>
> @@ -209,6 +209,8 @@ struct mmc_host {
> =A0 =A0 =A0 =A0struct led_trigger =A0 =A0 =A0*led; =A0 =A0 =A0 =A0 =A0=
 /* activity led */
> =A0#endif
>
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*embedded_d=
ata;
> +

To my understanding, this data doesn't belong to mmc_host. It's not a
host data at all. E. g. imagine a GPIO IRQ for some SDIO chip -- it's
totally unrelated to host.

I think a cleaner way would be to introduce something similar to what
we have for SPI, e. g. struct sdio_board_info. This board info will
contain platform-specific stuff and vendor id/chip id for each onboard
SDIO device. Then the SDIO core will pick up the appropriate data
basing on vendor id/chip id.

~Vitaly
