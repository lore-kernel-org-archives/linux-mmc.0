From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix card read threshold for PIO mode
Date: Mon, 24 Nov 2014 08:25:09 +0800
Message-ID: <20141124002508.GI11253@dragon>
References: <1416551950-8277-1-git-send-email-shawn.guo@linaro.org>
 <20141121233155.GC11253@dragon>
 <CAGOxZ51DPL+6HTSG6yeCqqRxtq7XBuWki7gdB-ieamVUKixCDQ@mail.gmail.com>
 <20141123153012.GH11253@dragon>
 <CAGOxZ50+k3Z5gHrRasveM=7V+GS+1dRmcz0u5WSyo=XBE9iT3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGOxZ50+k3Z5gHrRasveM=7V+GS+1dRmcz0u5WSyo=XBE9iT3g@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, stable@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 24, 2014 at 03:36:13AM +0530, Alim Akhtar wrote:
> Hi Shawn,
> 
> On Sun, Nov 23, 2014 at 9:00 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > One thing I need to check with hardware vendor is whether register
> > CDTHRCTL is available on my dwmmc controller.  From my testing, even
> > reading this register every time dw_mci_submit_data() is called causes
> > problem for me.
> >
> yes, your guess is right, did you tested with ulf's -next branch?
> Recently patch [1] is merged, that most likely to solve your platform
> issue. Have a try.
> 
> [1] http://www.spinics.net/lists/stable/msg69884.html

Yeah, the patch fixes my problem.  Thanks a lot for the pointer, Alim.

Shawn
