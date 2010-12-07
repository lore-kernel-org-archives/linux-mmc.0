From: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Subject: Re: OMAP HSMMC problems with off-mode
Date: Tue, 7 Dec 2010 12:45:59 -0600
Message-ID: <AANLkTin=w0E0==XDg_H57h0V-kH3qy5JXvA=-DyLpndr@mail.gmail.com>
References: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:35682 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753685Ab0LGSqB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Dec 2010 13:46:01 -0500
In-Reply-To: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, sawant@ti.com, linux-mmc@vger.kernel.org

Paul,

Last I tested OFF mode was after Adrian's power saving series was merge=
d. I
tested it on Kevin PM branch then and it was functional on my omap3 boa=
rd.

I need to check on the latest commit.

Did you see this problem in suspend/resume path or the cpuidle path?

Regards,
Madhu
On Tue, Dec 7, 2010 at 12:21 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Madhusudhan,
>
> On my OMAP35xx BeagleBoard here, HSMMC is non-functional after return=
ing
> from dynamic off-mode. =A0The MMC LED turns on and stays on, and the =
process
> hangs, although the rest of the system still seems to run. =A0Looks l=
ike
> you're listed as the maintainer for this code. =A0Do you know why thi=
s is,
> and what can be done to fix it?
>
> This is using linux-omap master at commit
> a04fd22204b13ce34a3f8a8157f83c44d64f8da9, using omap2plus_defconfig w=
ith
> DSS configured in. =A0My boot and root partitions are on MMC. =A0Foll=
owing are
> the commands I used to reproduce this problem.
>
>
> regards
>
> - Paul
>
> echo 1 > /debug/pm_debug/sleep_while_idle
> echo 1 > /debug/pm_debug/enable_off_mode
> echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
>
