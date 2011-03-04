From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 00/12] add support for host controller v3.00
Date: Fri, 04 Mar 2011 10:16:50 -0500
Message-ID: <m3vczyncf1.fsf@pullcord.laptop.org>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38822 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab1CDPSv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2011 10:18:51 -0500
In-Reply-To: <1299238369-1768-1-git-send-email-arindam.nath@amd.com> (Arindam
	Nath's message of "Fri, 4 Mar 2011 17:02:37 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: zhangfei.gao@gmail.com, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

Hi Arindam,

On Fri, Mar 04 2011, Arindam Nath wrote:
> V2

Thanks very much for sending this!  Since you mentioned you aren't
seeing compiler warnings, here's the set I see here:

drivers/mmc/core/sd.c: In function =E2=80=98mmc_sd_init_card=E2=80=99:
drivers/mmc/core/sd.c:584:21: warning: =E2=80=98current_limit=E2=80=99 =
may be used
uninitialized in this function [-Wuninitialized]
drivers/mmc/core/sd.c:558:32: note: =E2=80=98current_limit=E2=80=99 was=
 declared here

drivers/mmc/core/sd.c:547:18: warning: =E2=80=98timing=E2=80=99 may be =
used
uninitialized in this function [-Wuninitialized]
drivers/mmc/core/sd.c:471:26: note: =E2=80=98timing=E2=80=99 was declar=
ed here

drivers/mmc/core/sd.c:538:21: warning: =E2=80=98bus_speed=E2=80=99 may =
be used
uninitialized in this function [-Wuninitialized]
drivers/mmc/core/sd.c:471:15: note: =E2=80=98bus_speed=E2=80=99 was dec=
lared here

drivers/mmc/core/sd.c:456:21: warning: =E2=80=98card_set_drv_type=E2=80=
=99 may be used
uninitialized in this function [-Wuninitialized]
drivers/mmc/core/sd.c:433:25: note: =E2=80=98card_set_drv_type=E2=80=99=
 was declared here

drivers/mmc/core/sd.c:464:22: warning: =E2=80=98host_set_drv_type=E2=80=
=99 may be used
uninitialized in this function [-Wuninitialized]
drivers/mmc/core/sd.c:433:6: note: =E2=80=98host_set_drv_type=E2=80=99 =
was declared here

drivers/mmc/host/sdhci.c: In function =E2=80=98sdhci_add_host=E2=80=99:
drivers/mmc/host/sdhci.c:2366:27: warning: =E2=80=98caps[1]=E2=80=99 ma=
y be used
uninitialized in this function [-Wuninitialized]

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
