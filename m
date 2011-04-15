From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: SET_BLOCK_COUNT-bounded multiblock transfers
Date: Fri, 15 Apr 2011 02:10:45 -0500
Message-ID: <BANLkTinuUXnhqCRrGyiyv7hdA1SBHVFbLw@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<BANLkTikFWhDhCjGKBBE4PP9sNa2ynVEOtg@mail.gmail.com>
	<CE761E84DADF2947A4AF22FB8D97A473571F5610@shsmsx501.ccr.corp.intel.com>
	<BANLkTikDaPq56UBkNtmKApBXZ6dgMKgo6Q@mail.gmail.com>
	<m3k4ewto9t.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:53398 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab1DOHKr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2011 03:10:47 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3F78s5A026148
	for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 03:08:55 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3F7840d025834
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 03:08:54 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so3279816wyb.15
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 00:10:45 -0700 (PDT)
In-Reply-To: <m3k4ewto9t.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "Gao, Yunpeng" <yunpeng.gao@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>

On Thu, Apr 14, 2011 at 6:18 PM, Chris Ball <cjb@laptop.org> wrote:
>
> If we've seen a card that freaks out and loses significant bandwidth,=
 that
> would be a good reason to start with a whitelist. =A0If all the data =
we have
> suggests that it's performance-wise either a win or a no-op, that's a=
 fine
> reason to push it to mmc-next with a blacklist approach and change ou=
r
> minds later if our knowledge gets updated. =A0Does that help?
>

Yes, it does, thanks! Basically so far -

(a) amazing boost for Sandisk eMMCs
(b) synthetic tests showed no-op for Toshiba (a derivative of Arnd's
flashbench, I'll put it up on GitHub as soon as my hands get to it),
but more realistic test (via SQLite transactions on top of fs) showed
slight deterioration. I'm bringing it up with the vendor to get a
clear picture why and if they are doing anything to address it.
(c) I am going to try to dig up some discrete MMCs (hard beasts to
come by these days) and try with that.
(d) I am going to dig up a few SDXCs and try them out.

My current theory is that the CMD23 for multiblock should have no
effect on the really braindead cards, and could have deterioration on
cards that somehow optimize the CMD12 path (for example, the T eMMC
optimize consecutive multiblock writes).

At any rate, I'll decouple CMD23 support from multiblock CMD23 use...

Yunpeng, I'm curious, what vendors did you have in mind when you
suggested in your original email to use the CMD23 multiblock stuff?

Thanks again,
A
