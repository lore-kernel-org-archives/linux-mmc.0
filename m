From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: Increase cmd11 timeout to 500ms
Date: Tue, 07 Apr 2015 11:00:04 +0900
Message-ID: <55233A24.1000803@samsung.com>
References: <1428084787-8710-1-git-send-email-dianders@chromium.org>
 <55226411.2060806@samsung.com>
 <CAD=FV=XwC8Pc-cA3434XBwXOSPk1MXmCd0Az41afc5-4+==+LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35679 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbbDGCAH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Apr 2015 22:00:07 -0400
In-reply-to: <CAD=FV=XwC8Pc-cA3434XBwXOSPk1MXmCd0Az41afc5-4+==+LA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Doug.

On 04/07/2015 04:32 AM, Doug Anderson wrote:
> Jaehoon,
> 
> On Mon, Apr 6, 2015 at 3:46 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi, Doug.
>>
>> On 04/04/2015 03:13 AM, Doug Anderson wrote:
>>> The Designware databook claims that cmd11 should be finished in 2ms,
>>> but my testing showed that not to be the case in some situations.
>>> I've seen cmd11 timeouts of up to 130ms (!) during reboot tests.
>>> Let's bump the timeout way up so that we're absolutely sure.  CMD11 is
>>> only sent during card insertion, so this extra timeout shouldn't be
>>> terrible.
>>
>> Is it h/w problem? Could you explain to me about "some situations"?
>> As you said, this timeout only used during card inserting. So, it's not critical..
>> But there is much different between 2ms and 500ms(or 130ms).
> 
> Very good question, and it makes sense to dig into this...
> 
> OK, I think I've got it.  Dang printk bites me again.  I have serial
> console enabled and my printouts were actually causing these delays.
> With serial console turned off I reliably get ~280us for the interrupt
> to fire (tested across SD and WiFi across 137 + 128 + 111 + 127 = 503
> reboots)

Oh..agreed. I also think printouts can be caused the delay.
Thanks for your explanation.

> 
> I think it makes sense to land this patch anyway, but with an updated
> description.  I'm happy to repost this or happy if you just want to
> update the description when applying.

To save your time, when applying, i will do the updating description.

Best Regards,
Jaehoon Chung

> 
> ---
> 
> Although the cmd11 interrupt should come within 2ms, that's a very
> short time.  Let's increase the timeout to be really sure that we
> don't get an accidnetal timeout.  One case in particular this is
> useful is if you've got a serial console and printk in just the right
> places.  Under that scenario I've seen delays of up to 130ms before
> the interrupt fired.
> 
> CMD11 is only sent during card insertion, so this extra timeout
> shouldn't be terrible.
> 
> ---
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

