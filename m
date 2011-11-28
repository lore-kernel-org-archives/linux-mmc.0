From: "Coelho, Luciano" <coelho@ti.com>
Subject: Re: [PATCH 3/3] omap: board-sdp4430: declare support for MMC_PM_KEEP_POWER
Date: Mon, 28 Nov 2011 09:50:18 +0200
Message-ID: <CAKd1q9pv5hMSpazYiZpmoowV52GvE7gFK5zUJSGpKhNkDZGuVg@mail.gmail.com>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
	<1321970539-7104-3-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51631 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751823Ab1K1HuU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Nov 2011 02:50:20 -0500
In-Reply-To: <1321970539-7104-3-git-send-email-eliad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eliad Peller <eliad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>

Hi Eliad,

On Tue, Nov 22, 2011 at 4:02 PM, Eliad Peller <eliad@wizery.com> wrote:
> Declare support for keeping the power of the wlan chip
> while suspended. this is needed for Wakeup-On-Wireless.
>
> Signed-off-by: Eliad Peller <eliad@wizery.com>
> ---
> =C2=A0arch/arm/mach-omap2/board-4430sdp.c | =C2=A0 =C2=A01 +
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)

What about all the other board files that also have this structure?
=46or example board-omap4panda.c? I think they should all be changed an=
d
the change should also be communicated more broadly for those board
files which (unfortunately) are not upstream (or which are upstream
but without the wl12xx-specific definitions on it, such as Beagle).


--=20
Cheers,
Luca.
