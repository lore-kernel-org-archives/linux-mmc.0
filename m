From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCHv2 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 15:52:09 +0530
Message-ID: <BANLkTimWocMSCAxMf2ruLBzqdTOi0d2OLg@mail.gmail.com>
References: <1309282049-23739-1-git-send-email-balajitk@ti.com>
	<1309282049-23739-3-git-send-email-balajitk@ti.com>
	<87mxh1v8f3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:49280 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752672Ab1F2KWK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2011 06:22:10 -0400
In-Reply-To: <87mxh1v8f3.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com, svenkatr@ti.com, "Nayak, Rajendra" <rnayak@ti.com>

On Wed, Jun 29, 2011 at 5:02 AM, Kevin Hilman <khilman@ti.com> wrote:
> +Rajendra
>
> Balaji T K <balajitk@ti.com> writes:
>
>> add runtime pm support to HSMMC host controller
>> Use runtime pm API to enable/disable HSMMC clock
>> Use runtime autosuspend APIs to enable auto suspend delay
>>
>> Based on OMAP HSMMC runtime implementation by Kevin Hilman, Kishore =
Kadiyala
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>
> I tried to test this series along with Benoit's clkdm/modulemode/hwmo=
d
> cleanups and something strange is happening on OMAP4.
>
> First, this series by itself is working as I would expect, but testin=
g
> in combination with Benoit's series, it's different...
>
> First, I'm using Benoit's branch:
>
> =A0 =A0 =A0 git://gitorious.org/omap-pm/linux.git for_3.0.1/7_hwmod_m=
odulemode
>
> in combination with your series.
>
> I've also reverted these two commits:
>
> =A0 OMAP4: PM: TEMP: Prevent l3init from idling/force sleep
> =A0 OMAP3+: hwmod data: TEMP: Do not idle MMC1 & MMC2 after boot
>
> which are temporary workarounds for not having MMC runtime PM.
>
> I turned the dev_dbg calls in the runtime PM callbacks into dev_info
> callbacks to see exactly when the device is enabled/disabled via runt=
ime
> PM.
>
> To my surprise, I didn't see the device being enabled/disabled when
> writing do the device.

I tried for_3.0.1/7_hwmod_modulemode as you mentioned above,
changing dev_dbg to dev_err and I am not observing the delayed write
during umount. Can you let me know if the files are there in MMC after
remounting ?

> Any ideas why the same isn't happening when used with Benoit's series=
?
>
> Kevin
>
> P.S. note that the debug messages don't quite match. =A0One says 'hos=
t:
> enabled' the other says 'disabled' (without the host: prefix.) =A0mak=
ing
> the prefixes match would be more readable.

Ok, Will align dev_dbg prints.
