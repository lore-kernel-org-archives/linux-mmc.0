From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 09/11] mmc: sh_mobile_sdhi: do not manage PM clocks
 manually on ARM
Date: Fri, 6 Jan 2012 11:40:04 +0900
Message-ID: <CANqRtoRqSFMmC4VySM-Aczd7AFxZrC8nzjPwaffa+=3VtWZK0g@mail.gmail.com>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
	<1325686636-23905-10-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41567 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758246Ab2AFCkG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2012 21:40:06 -0500
In-Reply-To: <1325686636-23905-10-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>

Hi Guennadi,

On Wed, Jan 4, 2012 at 11:17 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On ARM the same clock is used by the PM subsystem and by the driver
> directly. This leads to the clock staying permanently on, independent=
 of
> the runtime PM state. This patch makes clock enable and disable calls=
 in
> the driver SuperH-specific.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0drivers/mmc/host/sh_mobile_sdhi.c | =A0 =A06 ++++++
> =A01 files changed, 6 insertions(+), 0 deletions(-)

Thanks for your patch.

=46rom my point of view there is very little difference between SH and
SH-Mobile ARM, so I don't understand the special treatment. Also, is
this change really needed for SH with your recent Runtime PM patches?

I believe we need to make use of the clock framework to get the clock
rate configuration in the SDHI driver. At the same time we want to
stop the clock as frequently as possible. I believe we should disable
and enable the clock together with the Runtime PM get/put operations -
pretty much exactly like our I2C master driver does. The only problem
is, while the clock is disabled the clock rate may be changed. So we
need to be able to notify the MMC subsystem about the new clock rate.

Any ideas on how to make this happen?

Thanks,

/ magnus
