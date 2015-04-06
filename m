From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: Increase cmd11 timeout to 500ms
Date: Mon, 6 Apr 2015 12:32:49 -0700
Message-ID: <CAD=FV=XwC8Pc-cA3434XBwXOSPk1MXmCd0Az41afc5-4+==+LA@mail.gmail.com>
References: <1428084787-8710-1-git-send-email-dianders@chromium.org>
	<55226411.2060806@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55226411.2060806@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Jaehoon,

On Mon, Apr 6, 2015 at 3:46 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi, Doug.
>
> On 04/04/2015 03:13 AM, Doug Anderson wrote:
>> The Designware databook claims that cmd11 should be finished in 2ms,
>> but my testing showed that not to be the case in some situations.
>> I've seen cmd11 timeouts of up to 130ms (!) during reboot tests.
>> Let's bump the timeout way up so that we're absolutely sure.  CMD11 is
>> only sent during card insertion, so this extra timeout shouldn't be
>> terrible.
>
> Is it h/w problem? Could you explain to me about "some situations"?
> As you said, this timeout only used during card inserting. So, it's not critical..
> But there is much different between 2ms and 500ms(or 130ms).

Very good question, and it makes sense to dig into this...

OK, I think I've got it.  Dang printk bites me again.  I have serial
console enabled and my printouts were actually causing these delays.
With serial console turned off I reliably get ~280us for the interrupt
to fire (tested across SD and WiFi across 137 + 128 + 111 + 127 = 503
reboots)

I think it makes sense to land this patch anyway, but with an updated
description.  I'm happy to repost this or happy if you just want to
update the description when applying.

---

Although the cmd11 interrupt should come within 2ms, that's a very
short time.  Let's increase the timeout to be really sure that we
don't get an accidnetal timeout.  One case in particular this is
useful is if you've got a serial console and printk in just the right
places.  Under that scenario I've seen delays of up to 130ms before
the interrupt fired.

CMD11 is only sent during card insertion, so this extra timeout
shouldn't be terrible.

---

-Doug
