From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: core: Do not pre-claim host in suspend
Date: Fri, 20 Apr 2012 10:55:33 +0200
Message-ID: <4F912485.2020906@stericsson.com>
References: <1334829325-3464-1-git-send-email-ulf.hansson@stericsson.com>	<CAMJBoFNO7aKge9BqawRJdr=k_HxOOaeoPaif1sed_vN7kSF35g@mail.gmail.com> <CAMLZHHQVrog2srUhOjH5T3bQN4DjjP04x0ko3Bv9CXYyo_8i9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:45199 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751266Ab2DTI5Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Apr 2012 04:57:16 -0400
In-Reply-To: <CAMLZHHQVrog2srUhOjH5T3bQN4DjjP04x0ko3Bv9CXYyo_8i9Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Vitaly Wool <vitalywool@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 04/19/2012 05:48 PM, Daniel Drake wrote:
> On Thu, Apr 19, 2012 at 4:02 AM, Vitaly Wool<vitalywool@gmail.com>  wrote:
>> I think it looks like a hack. Can you provide a better description of
>> where this deadlock actually happens?
>>
>> If libertas_sdio claims host as a part of its suspend operation from a
>> context different from the suspend context, isn't it libertas_sdio
>> that has to be fixed?
>
> libertas_sdio performs work in a workqueue during the suspend routine.
> It doesn't take long, but it is essential.
>
> Technically it would be possible to do the same work from the suspend
> thread without changing context. However, implementation-wise this is
> quite difficult. We cannot simply blast commands off to the card
> directly, we have to obey various rules and keep things in sync. This
> is done with an abstraction layer in the driver which is also shared
> with equivalent devices that connect over USB, SPI, etc. Sometimes we
> send commands from atomic context, or asynchronously, so thats why we
> do things in a workqueue.
>
> Breaking this abstraction for the suspend corner-case would be a pain,
> and I don't agree with the strange requirement that SDIO drivers can't
> communicate from other contexts in the suspend routine. My thoughts
> are here: http://article.gmane.org/gmane.linux.kernel.mmc/13899
>
> Ulf, you have understood the problem correctly and your patch solves
> the issue. Thanks for the fast response.
>
> Daniel

Thanks Daniel for testing, could we add your "Tested-by" to this patch then?

Myself, would like to do some more testing for MMC/SD, before adding 
mine Tested-by tag... get back to this soon..

Kind regards
Uffe

