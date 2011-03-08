From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[RFC] 2/5] MMC: Add block quirks support.
Date: Tue, 8 Mar 2011 14:27:40 -0600
Message-ID: <AANLkTimSPQuxH_M4hVFNncyoN_ij0dWFTigD0-87uDNs@mail.gmail.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<AANLkTimZW-aHC1e0hJAsGTibM6uV2cF3+3NwYr3ppOCa@mail.gmail.com>
	<AANLkTi=DhG+yBESfGdFrc7gox2Z_VW-rOfhezsVyeitO@mail.gmail.com>
	<201103081542.46831.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:39752 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab1CHU2b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 15:28:31 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p28KQNJp004341
	for <linux-mmc@vger.kernel.org>; Tue, 8 Mar 2011 15:26:23 -0500 (EST)
Received: from mail-qy0-f170.google.com (mail-qy0-f170.google.com [209.85.216.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p28KPx1p004188
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 8 Mar 2011 15:26:23 -0500 (EST)
Received: by mail-qy0-f170.google.com with SMTP id 32so3310825qyk.15
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2011 12:27:40 -0800 (PST)
In-Reply-To: <201103081542.46831.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, tardyp@gmail.com, linux-mmc@vger.kernel.org

On Tue, Mar 8, 2011 at 8:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I'm still not comfortable with having the blk_adjust method. I think it
> would be much better to encode that behavior in an abstract way in
> the block driver and set a flag to enable it in the quirks file.

Ok, will encode the behavior abstractly and enable it with a flag. No more
adjust method.

Thanks,
A
