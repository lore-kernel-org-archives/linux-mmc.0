From: Chris Ball <cjb@laptop.org>
Subject: Re: SanDisk 4.3+ iNAND eMMC devices TRIM bug workaround.
Date: Tue, 12 Apr 2011 12:57:46 -0400
Message-ID: <m34o631k6t.fsf@pullcord.laptop.org>
References: <1302560441-10565-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33275 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754684Ab1DLQwz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 12:52:55 -0400
In-Reply-To: <1302560441-10565-1-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Mon, 11 Apr 2011 17:20:39 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

Hi Andrei,

On Mon, Apr 11 2011, Andrei Warkentin wrote:
> This fixes the out-of-spec erase/trim support. CMD38 argument
> is passed through an EXT_CSD byte instead of as the command
> argument. This has the effect that trims act as group erases,
> erasing more data than necessary. Secure trims/erases were also affec=
ted.
>
> N.B. This depends on the mmc_switch patch from the earlier boot parti=
tion
> patchset (MMC: Allow setting CMD timeout for CMD6 (SWITCH)). This als=
o
> depends on the update core/quirks.c code.
>
> ToC:
> [PATCH 1/2] MMC: Support for block quirks.
> [PATCH 2/2] MMC: Fix erase/trim for certain SanDisk cards.

Looks like these are missing your new timeout arg to mmc_switch():

drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_issue_discard_rq=
=E2=80=99:
drivers/mmc/card/block.c:371:6: error: too few arguments to function =E2=
=80=98mmc_switch=E2=80=99
include/linux/mmc/core.h:138:12: note: declared here
drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_issue_secdiscard=
_rq=E2=80=99:
drivers/mmc/card/block.c:410:6: error: too few arguments to function =E2=
=80=98mmc_switch=E2=80=99
include/linux/mmc/core.h:138:12: note: declared here
drivers/mmc/card/block.c:419:7: error: too few arguments to function =E2=
=80=98mmc_switch=E2=80=99

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
