From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] mmc: subtract boot sectors from disk size for eMMC 4.3+ devices
Date: Sun, 6 Mar 2011 08:00:45 -0800
Message-ID: <AANLkTikOD3oqGAG9vgbhsX3dGnnop3qXoLSZ-QxhD=h_@mail.gmail.com>
References: <1299327344-12462-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTikeQs_eVHYc8vA8+m5tSHRDLnE3Xf9b5yWRj4p=@mail.gmail.com>
	<AANLkTinkwRM3YPwJ7omOdxRjgcnDa3FuriN3UsRsR-tB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:3929 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab1CFQAs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Mar 2011 11:00:48 -0500
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
	by smtp-out.google.com with ESMTP id p26G0lSN017193
	for <linux-mmc@vger.kernel.org>; Sun, 6 Mar 2011 08:00:47 -0800
Received: from yxt33 (yxt33.prod.google.com [10.190.5.225])
	by hpaq12.eem.corp.google.com with ESMTP id p26G0c3J013092
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 6 Mar 2011 08:00:46 -0800
Received: by yxt33 with SMTP id 33so1748281yxt.14
        for <linux-mmc@vger.kernel.org>; Sun, 06 Mar 2011 08:00:45 -0800 (PST)
In-Reply-To: <AANLkTinkwRM3YPwJ7omOdxRjgcnDa3FuriN3UsRsR-tB@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org

On Sun, Mar 6, 2011 at 4:22 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/3/6 Andrei Warkentin <andreiw@motorola.com>:
>
>> I think Colin mentioned the emmc spec doesn't subtract the boot
>> sectors, just that some out of spec devices do... (sounds like another
>> use for mmc blk quirks)
>
> In which case it sounds like it will be the majority of them deviating from
> the spec right now given that there aren't very many of them around :-(
>
> Details on this Colin?
>
> Certainly we can come up with some card quirks for this.
>
> Yours,
> Linus Walleij
>

I don't know how this is supposed to work.  I was told by one person
(Gary King) that the subtraction was necessary, and by another person
(drambo) that it was not correct according to the manufacturer of
their eMMC device.  See
http://www.mail-archive.com/linux-tegra@vger.kernel.org/msg00079.html
for the previous discussion.

Have you verified that the area of the eMMC device between CSD_SECTORS
- BOOT_SECTORS and CSD_SECTORS is not accessible on your device?
