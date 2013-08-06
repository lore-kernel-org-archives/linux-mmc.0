From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/5] mmc: dw_mmc: Add suspend_noirq/resume_noirq
 callbacks for dw_mmc-pltfm
Date: Tue, 6 Aug 2013 14:32:23 -0700
Message-ID: <CAD=FV=XJeXF6qeewAyFT_C1ssaU3HjtPr6aso9cjQ9s3=k=Z_A@mail.gmail.com>
References: <1373411961-23812-1-git-send-email-dianders@chromium.org>
	<1373470926-19314-1-git-send-email-dianders@chromium.org>
	<1373470926-19314-3-git-send-email-dianders@chromium.org>
	<004001ce8154$36753510$a35f9f30$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <004001ce8154$36753510$a35f9f30$%jun@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Seungwon Jeon,

On Mon, Jul 15, 2013 at 5:09 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Thu, July 11, 2013, Doug Anderson wrote:
>> On some devices (like exynos5420) the dw_mmc controller may be in a
>> strange state after we wake up from sleep.  Add callbacks to allow for
>> dealing with these quirks.  We use the "_noirq" versions of the
>> callbacks since in the case of exynos5420 the strange state caused
>> interrupts to fire so we need to deal with it while interrupts are
>> still off.
>>
>> At the moment this support is only added to dw_mmc-pltfm which calls
>> straight to the callback, since nobody but exynos needs it.  We can
>> add some levels of indirection (a call into the generic dw_mmc code)
>> when someone finds a need.
> I think It would be better to add _noirq only to dw_mmc-exynos.
> That is we can add dev_pm_ops for dw_mmc-exynos's own.
> As you recognize, there is no common routine which is not introduced for dw_mmc xxx_noirq now.
> I feel like it is for handling quirk.
> If we meet use case for that in some day, it could be added commonly.
> How do you think?
>
> Thanks,
> Seungwon Jeon

Sorry for the long delay in responding.

I originally didn't do what you proposed since dw_mmc-exynos uses the
dw_mci_pltfm_pmops directly.  ...but I agree that it is cleaner, so
I've switched the code to do as you say.  New patch coming shortly.
Thank you for your review.

-Doug
