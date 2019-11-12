From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] mmc: Fixup HW reset for SDIO cards
Date: Tue, 12 Nov 2019 10:00:30 -0800
Message-ID: <20191112180030.GA43123@atomide.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <20191111220812.GX43123@atomide.com>
 <CAPDyKFq03X0hd5B6h6fuNht5OjSEWe6Ap4hH4a+0nVZsS4r3hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFq03X0hd5B6h6fuNht5OjSEWe6Ap4hH4a+0nVZsS4r3hw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

* Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [191112 12:24]:
> On Mon, 11 Nov 2019 at 23:08, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > Looks good to me. I tried testing this, but looks like at least on duovero
> > mwifiex_sdio is broken in v5.4-rc7:
> >
> > # dmesg | grep mwifi
> > mwifiex_sdio mmc1:0001:1: poll card status failed, tries = 100
> > mwifiex_sdio mmc1:0001:1: FW download with helper:       poll status timeout @ 0
> > mwifiex_sdio mmc1:0001:1: prog_fw failed ret=0xffffffff
> > mwifiex_sdio mmc1:0001:1: info: _mwifiex_fw_dpc: unregister device
> >
> > No idea when it broke and what might be the issue this time around.
> > Any ideas?
> 
> Sorry, no good idea.
> 
> Perhaps something on the mmc host level that has changed?

No idea, not even v4.19 is not behaving properly. I guess another
victim of eternal ongoing regressions.

Regards,

Tony
