From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH 1/2] MMC: Extends card quicks with MMC/SD quirks matching
 the CID.
Date: Mon, 11 Apr 2011 16:25:09 -0500
Message-ID: <BANLkTikvme91RUPKBcGVMs3zyREaqK803w@mail.gmail.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<1300024118-23771-2-git-send-email-andreiw@motorola.com>
	<m339lobj8j.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:34995 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab1DKVZL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 17:25:11 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BLNNcN014810
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:23:23 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BLB9rj009398
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:23:22 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so8488072wyb.15
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 14:25:09 -0700 (PDT)
In-Reply-To: <m339lobj8j.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, tardyp@gmail.com, linus.walleij@linaro.org, arnd@arndb.de

On Mon, Apr 11, 2011 at 3:55 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Andrei,
>
> I've rebased this patch to include Ohad's recent wl1271 quirks, and w=
as
> about to apply it, but have one question -- would you mind resubmitti=
ng
> with your use of strcmp() switched over to strncmp()? =A0It looks saf=
e in
> this case, but the less code that has to be audited for safety the
> better.
>

Ok. Just did. Thanks for looking at this. I have a SanDisk TRIM bug
workaround using
this that  I was about to send, I guess I'll send it now.

A
