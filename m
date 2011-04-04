From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v4 2/3]mmc: enable TRIM/ERASE caps for SDHCI host
Date: Sun, 3 Apr 2011 23:33:52 -0500
Message-ID: <BANLkTik0ijdeccTgqxf8Mu87s8jxevaOhA@mail.gmail.com>
References: <20110212062220.GC25519@intel.com>
	<BANLkTikGW3sYjW1HjSJfdBV22DK+Y0zi1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:40916 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab1DDEdz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 00:33:55 -0400
In-Reply-To: <BANLkTikGW3sYjW1HjSJfdBV22DK+Y0zi1Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, adrian.hunter@nokia.com

On Sun, Apr 3, 2011 at 11:06 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Sat, Feb 12, 2011 at 12:22 AM, Chuanxiao Dong
> <chuanxiao.dong@intel.com> wrote:
>> SDHCI host controller has TRIM/ERASE capability, enable these caps for erasing
>> purpose.
>>
>> ERASE command needs R1B response. So for such command with busy signal, before
>> sending command, SDHCI host driver will simply set a maximum value for timeout
>> control register which is safe to use.
>>
>
> Awesome. I took a look at the eMMC spec, and the following commands
> also have R1B responses:
>
> 1) CMD5 (SLEEP_AWAKE)
> 2) CMD6 (SWITCH)
> 3) CMD7 (Select/Deselect - for Disconnected->Programming transitions)
> 4) CMD12 (STOP_TRANSMISSION - for write case)
> 5) CMD28 (SET_WRITE_PROT)
> 6) CMD29 (CLR_WRITE_PROT)
>
> ...so this should help with timeouts for those commands as well. Thanks!
>
> A
>

On a second thought (and look), I see the following problems with this
patch, which are otherwise going to make the MMC code confusing (and
invalid).

1) Erase timeout value is defined by spec (eMMC or SD) and already
calculated in mmc_set_erase_timeout within core/core.c. You should
honor that value instead of picking the max timeout.
2) The trim/erase commands are not the only commands with variable
timeouts. For example, certain CMD6 operations take different amounts
of time (Partition switch takes ext_csd:PARTITION_SWITCH_TIME) Right
now the command structure contains the field "erase_timeout", which
curiously enough is used nowhere other than getting set in
core/core.c. I propose renaming it to cmd_timeout. If cmd.data is
NULL, then cmd_timeout is used to set timeout for busy-type commands.

A
