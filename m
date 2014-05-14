From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH 2/3] drivers/mmc/host/mmc_spi.c: Use get/put_unaligned_be32
Date: 14 May 2014 08:23:57 -0400
Message-ID: <20140514122357.11052.qmail@ns.horizon.com>
References: <CAPDyKFo9xZ-z6eM0zG2A+=Bwj0EVyGxm=m28Lh9cHPSB+8qq1w@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo9xZ-z6eM0zG2A+=Bwj0EVyGxm=m28Lh9cHPSB+8qq1w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@horizon.com, ulf.hansson@linaro.org
Cc: arik@wizery.com, david.gnedt@davizone.at, eliad@wizery.com, jan.nikitenko@gmail.com, laurent.pinchart+renesas@ideasonboard.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, linux-wireless@vger.kernel.org, linville@tuxdriver.com, luca@coelho.fi, pavel@ucw.cz, tony@atomide.com
List-Id: linux-mmc@vger.kernel.org

Ulf Hansson wrote:
> Feel free to take this through the wireless tree as well. I assumes
> it's that same patchset as the other spi related fixes?

I'd like to answer, but I'm not sure which "other spi related fixes"
you're referring to.  If you mean patches 1 and 3 of this series, then
obviously.  If you mean something else then probably not.

[PATCH 1/3] lib/crc7: Shift crc7() output left 1 bit
[PATCH 3/3] drivers/net/wireless/ti/wl*/spi.c: Simplify CRC computation


As there seems to be no objection to sending the mmc change via the
wireless tree, are they ready to be queued there?

The additional reviews are:
All 3: Reviewed-by: Pavel Machek <pavel@ucw.cz>
2/3: Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
2/3: Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

I can resend everything with the additional signoff lines
if that's easier for you.
