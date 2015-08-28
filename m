From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH] mmc: core: fix race condition in mmc_wait_data_done
Date: Fri, 28 Aug 2015 12:09:13 +0200
Message-ID: <CAPDyKFqYDdwvTCw3oKhkxqu9zmTAC8osLgd6eC4zDY7JOMGGPQ@mail.gmail.com>
References: <1440731589-22241-1-git-send-email-shawn.lin@rock-chips.com>
	<55DFD4B7.3070601@rock-chips.com>
	<CAPDyKFqZXx11qsnPH_uTDptfkUFfDykNKPgVcH6AW5CbH6Fi8g@mail.gmail.com>
	<55E02F7C.1020204@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38770 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbH1KJP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2015 06:09:15 -0400
Received: by wibgu7 with SMTP id gu7so4624834wib.1
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2015 03:09:13 -0700 (PDT)
In-Reply-To: <55E02F7C.1020204@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jialing Fu <jlfu@marvell.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

[...]

>>> Hi, ulf
>>>
>>> We find this bug on Intel-C3230RK platform for very small probability.
>>>
>>> Whereas I can easily reproduce this case if I add a mdelay(1) or  longer
>>> delay as Jialing did.
>>>
>>> This patch seems useful to me. Should we push it forward? :)
>>
>>
>> It seems like a very good idea!
>>
>> Should we add a fixes tag to it?
>
>
> That's cool, but how to add a fixes tag?
>
> [Fixes] mmc: core: fix race condition in mmc_wait_data_done ?   :)
>

A fixes tag points to an old commit which introduced the bug. If we
can't find one, we can add a Cc tag to "stable". Just search the git
log and you will find examples.

Kind regards
Uffe
