From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: SET_BLOCK_COUNT-bounded multiblock transfers
Date: Thu, 14 Apr 2011 17:58:45 -0500
Message-ID: <BANLkTikDaPq56UBkNtmKApBXZ6dgMKgo6Q@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<BANLkTikFWhDhCjGKBBE4PP9sNa2ynVEOtg@mail.gmail.com>
	<CE761E84DADF2947A4AF22FB8D97A473571F5610@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og107.obsmtp.com ([64.18.0.184]:60288 "EHLO
	exprod5og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab1DNW6s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2011 18:58:48 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3EMutwL025026
	for <linux-mmc@vger.kernel.org>; Thu, 14 Apr 2011 18:56:55 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3EMuadp024957
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 14 Apr 2011 18:56:55 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so2459620wwb.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Apr 2011 15:58:45 -0700 (PDT)
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A473571F5610@shsmsx501.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "cjb@laptop.org" <cjb@laptop.org>

On Thu, Apr 14, 2011 at 4:05 AM, Gao, Yunpeng <yunpeng.gao@intel.com> wrote:
>
> Thanks for add me in the loop. I'm fine with the 3 patches.
>
> And just think that maybe it's not necessary to enable the Auto-CMD23 for SDHCI,
> because I have an impression that some Silicon bugs related to Auto-CMD12/Auto-CMD23
> existed in some vendor's SDHCI host controller IP, and I'm not sure they have been fixed or not by now.
>

That's why I didn't send a patch for that :-). When I get some SDHCI
silicon with working Auto-CMD12/Auto-CMD23 I'll come back to that
code path.

I actually thought about this some more and I decided to decouple
CMD23 support and CMD23 use for multiblock writes. Will add a new
md->flags bit.
This will allow cards where for whatever reason CMD23-bounded
transfers are slower to use CMD12 instead, while retaining CMD23 use
for things like reliable writes and all those other features you've
mentioned that are in the still not public eMMC 4.5.

The question to Arnd and Chris - should by default use of CMD23 for
multiblock writes be disabled, and enabled per known-good card using
add_flag quirk support? Or should CMD23 for multiblock writes be
enabled by default, and then disabled for known-bad cards?

First approach is safer from the point of view of regressions. People
who upgrade to 2.6.40 won't suddenly see worse I/O performance if they
have some silicon bugs or if use of CMD23 nullifies some internal
optimizations for sequential writes. On the other hand, at some point
hopefully everybody fixes their silicon such that CMD23 always means
better performance.

Thoughts?
A
