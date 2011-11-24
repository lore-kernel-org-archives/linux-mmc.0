From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: sanitize for eMMC v4.5
Date: Thu, 24 Nov 2011 09:06:45 +0900
Message-ID: <CAH9JG2UpWNaR5cTt+ws-fmD-QjH0x+mkmjN=xXKVtteMZ3=tcg@mail.gmail.com>
References: <806ca0964234cf284f0b5ca61ee8df3e.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40823 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab1KXAGq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2011 19:06:46 -0500
Received: by ghrr1 with SMTP id r1so1960460ghr.19
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2011 16:06:45 -0800 (PST)
In-Reply-To: <806ca0964234cf284f0b5ca61ee8df3e.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ygardi@codeaurora.org
Cc: linux-mmc@vger.kernel.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

Hi,

On 11/23/11, ygardi@codeaurora.org <ygardi@codeaurora.org> wrote:
> sorry for sending it again...(changed the mailing-list)
>
> hello,
>
> i have a few questions regarding the sanitize capability that was added in
> v4.5.
>
> 1. how often this operation should take place ?
>    a. any advantages to perform sanitize in power-up, power-down, or every
> X hours when the card in idle ?
It's not normally used at runtime. in our case, it's used at factory reset only
>
> 2. how this operation should be triggered?
> is it external adb command, or is part of the driver operation ?
it can trigger at block with BLKSECDISCARD
>
> 3. does anyone have a speculated time duration for that operation
> according to a card size / vendor ?
there's no timeout value at eMMC v4.5 spec. it takes long time depends
on chip status. the only way to stop is using HPI.
If you start the sanitize and there's user request then it call the
HPI. and it's not yet implemented at mmc code.

Thank you,
Kyungmin Park

>
> thanks,
> Yaniv
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
