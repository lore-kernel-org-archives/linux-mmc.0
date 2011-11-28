From: Eliad Peller <eliad@wizery.com>
Subject: Re: [PATCH 3/3] omap: board-sdp4430: declare support for MMC_PM_KEEP_POWER
Date: Mon, 28 Nov 2011 10:26:42 +0200
Message-ID: <CAB3XZEenx7L07BYmrHGt0h9ZAY-LOpWXL+in0vs7XOoeBf_LUw@mail.gmail.com>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
	<1321970539-7104-3-git-send-email-eliad@wizery.com>
	<CAKd1q9pv5hMSpazYiZpmoowV52GvE7gFK5zUJSGpKhNkDZGuVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37871 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab1K1I0m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2011 03:26:42 -0500
In-Reply-To: <CAKd1q9pv5hMSpazYiZpmoowV52GvE7gFK5zUJSGpKhNkDZGuVg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Coelho, Luciano" <coelho@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>

On Mon, Nov 28, 2011 at 9:50 AM, Coelho, Luciano <coelho@ti.com> wrote:
> On Tue, Nov 22, 2011 at 4:02 PM, Eliad Peller <eliad@wizery.com> wrot=
e:
>> Declare support for keeping the power of the wlan chip
>> while suspended. this is needed for Wakeup-On-Wireless.
>>
>> Signed-off-by: Eliad Peller <eliad@wizery.com>
>> ---
>> =A0arch/arm/mach-omap2/board-4430sdp.c | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> What about all the other board files that also have this structure?
> For example board-omap4panda.c? I think they should all be changed an=
d
> the change should also be communicated more broadly for those board
> files which (unfortunately) are not upstream (or which are upstream
> but without the wl12xx-specific definitions on it, such as Beagle).
>
i preferred adding this capability only for boards i can test.
unfortunately, i don't a panda/beagle setup.
anyway, i don't think we have to add it all at once.
let's just do it one board at a time... i'll add support for zoom as
well. any volunteers for panda/beagle? ;)

Eliad.
