From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH 3/5] mmc: dw_mmc: Add exynos resume callback to clear WAKEUP_INT
Date: Wed, 10 Jul 2013 17:43:58 -0700
Message-ID: <CANEJEGt4r==VD1gUrTGr=uooFQ-_Odayr3Yv=6i3dwDpf1Y+cg@mail.gmail.com>
References: <1373391071-6312-1-git-send-email-dianders@chromium.org>
	<1373391071-6312-4-git-send-email-dianders@chromium.org>
	<CAD=FV=XLp_2t83JfUBryaSvqLZr5OHEZeFZDRmQ1T=XA1MRkHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=XLp_2t83JfUBryaSvqLZr5OHEZeFZDRmQ1T=XA1MRkHg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 9, 2013 at 12:09 PM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Tue, Jul 9, 2013 at 10:31 AM, Doug Anderson <dianders@chromium.org> wrote:
>> If the WAKEUP_INT is asserted at wakeup and not cleared, we'll end up
>> looping around forever.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> ---
>>  drivers/mmc/host/dw_mmc-exynos.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>
> Grant just pointed out that the WAKEUP_INT is supposed to only be
> enabled if bits 8, 9, or 10 are 1.  Our driver never sets those so we
> _should_ never get a WAKEUP_INT.  Bits 8-10 are marked as RESERVED on
> the exynos5420 manual, so the current guess is that they're broken on
> that silicon but that sometimes the interrupt fires anyway.
>
> In any case, it is still a reasonable thing to clear this interrupt at
> wakeup if it has fired, even if we're on an exynos device without any
> problems.

I agree. Can add:
  Reviewed-by: Grant Grundler <grundler@chromium.org>

thanks,
grant

>
> -Doug
