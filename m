From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v4 2/3]mmc: enable TRIM/ERASE caps for SDHCI host
Date: Sun, 3 Apr 2011 23:06:09 -0500
Message-ID: <BANLkTikGW3sYjW1HjSJfdBV22DK+Y0zi1Q@mail.gmail.com>
References: <20110212062220.GC25519@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:33579 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab1DDEGN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 00:06:13 -0400
In-Reply-To: <20110212062220.GC25519@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, adrian.hunter@nokia.com

On Sat, Feb 12, 2011 at 12:22 AM, Chuanxiao Dong
<chuanxiao.dong@intel.com> wrote:
> SDHCI host controller has TRIM/ERASE capability, enable these caps for erasing
> purpose.
>
> ERASE command needs R1B response. So for such command with busy signal, before
> sending command, SDHCI host driver will simply set a maximum value for timeout
> control register which is safe to use.
>

Awesome. I took a look at the eMMC spec, and the following commands
also have R1B responses:

1) CMD5 (SLEEP_AWAKE)
2) CMD6 (SWITCH)
3) CMD7 (Select/Deselect - for Disconnected->Programming transitions)
4) CMD12 (STOP_TRANSMISSION - for write case)
5) CMD28 (SET_WRITE_PROT)
6) CMD29 (CLR_WRITE_PROT)

...so this should help with timeouts for those commands as well. Thanks!

A
