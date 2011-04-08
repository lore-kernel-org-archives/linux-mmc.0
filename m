From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: Boot partition support patch set.
Date: Fri, 8 Apr 2011 01:58:38 -0500
Message-ID: <BANLkTikw2E8P5FEhJuM1H3eqTtrMdb1Xuw@mail.gmail.com>
References: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
	<BANLkTik7nDHvNbYRMEpyOvh71pXHuVgUTg@mail.gmail.com>
	<m339ltpxg6.fsf@pullcord.laptop.org>
	<201104080547.34130.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:49966 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab1DHG6l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 02:58:41 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p386x1Tk005753
	for <linux-mmc@vger.kernel.org>; Fri, 8 Apr 2011 02:59:01 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p386w992005532
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 8 Apr 2011 02:59:01 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so4407585wyb.15
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2011 23:58:39 -0700 (PDT)
In-Reply-To: <201104080547.34130.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hi Arnd,

On Thu, Apr 7, 2011 at 10:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 07 April 2011, Chris Ball wrote:
>> On Wed, Apr 06 2011, Andrei Warkentin wrote:
>> >> This is the latest version of the MMC device partition support.
>> >> It relies on a few other changes that were discussed recently.
>> >>
>> >> Thanks,
>> >> A
>> >>
>> >> TOC:
>> >> [PATCH 1/4] MMC: Rename erase_timeout to cmd_timeout.
>> >> [PATCH 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
>> >> [PATCH 3/4] MMC: Allow setting CMD timeout for CMD6 (SWITCH).
>> >> [PATCH 4/4] MMC: MMC boot partitions support.
>> >
>> > Any problems, comments?
>>
>> Looks good to me -- Arnd, did you want to add your Reviewed/Acked-by
>> to this?
>>
>
> I haven't done an in-depth review, but please add my Acked-by to the last
> patch. For the other three, I have no idea what they do, but they all
> seem harmless to me ;-)
>
>

Thanks for the Ack.

Patch 1 paves the way for using erase timeout (which is otherwise dead code).

Patch 2 enables proper handling of R1B-response type commands in SDHCI
host. R1B commands use the DAT line as busy, hence DAT timeout
applies. Previously, DAT timeout is only calculated for data-bearing
commands. Now for non-data commands with a cmd_timeout, the timeout is
honored. This allows proper handling of CMD38 (erase). This also
allows proper handling of CMD6 (SWITCH) writes to EXT_CSD register
offsets, as certain operations invoked via this command (such as
partition switch times) have different timeouts associated with them.
Since erase timeout is now honored, the erase cap is turned on.

Please note that all the work in Patch 2 applies only to SDHCI. I'm
not familiar with other hosts, but a cursory glance revealed that they
all have similar issues (no handling of R1B timeouts). I could roll
patches, but I'd have no way of verifying (unless someone wants to
volunteer and help out). If you (as a Linaro person) are interested,
this is something you could add under (Write performance drop -
https://wiki.linaro.org/WorkingGroups/Kernel/Specs/StoragePerfEMMC).

Patch 3 exposes mmc_switch to block driver, and lets a timeout
parameter be passed, as writes to different fields of EXT_CSD can have
differerent timeouts.

Thanks,
A
