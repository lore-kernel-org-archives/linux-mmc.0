From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: working around a Marvell wifi SDIO bug
Date: Tue, 7 Dec 2010 16:13:27 +0200
Message-ID: <AANLkTim3mt=Xcqw1d15bFJ78FM1kRHYAmvNp-=CoYLAW@mail.gmail.com>
References: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com> <AANLkTi=2gcr_5uSQtu+5_35xG4ZhsLRCwWCW+Me-QSLb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58968 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab0LGONt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 09:13:49 -0500
Received: by iwn9 with SMTP id 9so1608978iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 07 Dec 2010 06:13:49 -0800 (PST)
In-Reply-To: <AANLkTi=2gcr_5uSQtu+5_35xG4ZhsLRCwWCW+Me-QSLb@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org, njun@marvell.com, binw@marvell.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Philip Rakity <prakity@marvell.com>

On Tue, Dec 7, 2010 at 4:52 AM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> In marvell platfrom, we handle gpio related behavior via rfkill,
> 1. platfrom transfer gpio pin via platfrom data, so different platform
> could have different gpio
> 2. rfkill block/unblock wifi/bt etc, to pull up/down gpio.
> 3. using rfkill to handle power saving mode

SDIO core is designed to have full control over the card's power, and
manipulates it upon boot (/card insertion), system suspend/resume
(unless told not to), and when enabled, upon relevant runtime pm
changes (driver loading/unloading/pm_runtime_* requests).

If you require an external intervention to power on/off your card, how
is this all going to work ?

that's both cumbersome and error prone:
1. This external intervention might not always be there when you need it
2. This external intervention can possibly happen when you _don't_ need it

In addition, it sounds like something you better off not having to
maintain.. A solution that would just work within the MMC core is IMHO
much better.
