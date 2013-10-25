From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/2] mmc: dw_mmc: Cleanup disable of low power mode w/ SDIO
 interrupts
Date: Fri, 25 Oct 2013 18:29:08 +0900
Message-ID: <000f01ced164$a8181b50$f84851f0$%jun@samsung.com>
References: <1381876762-10892-1-git-send-email-dianders@chromium.org>
 <1381876762-10892-2-git-send-email-dianders@chromium.org>
 <52610273.3080005@samsung.com>
 <CAD=FV=UiUxoqbAeq+3iUChqksHd_NpJs2rM83=ng3fprMj0E-A@mail.gmail.com>
 <001701cecfe2$9831eb90$c895c2b0$%jun@samsung.com>
 <CAD=FV=WL0K4qiRGsQxG7vfp41dV9fp=7d6d6i5qomJd7jbLEPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50978 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab3JYJ3L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Oct 2013 05:29:11 -0400
In-reply-to: <CAD=FV=WL0K4qiRGsQxG7vfp41dV9fp=7d6d6i5qomJd7jbLEPg@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'James Hogan' <james.hogan@imgtec.com>, 'Grant Grundler' <grundler@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Olof Johansson' <olof@lixom.net>, 'Sonny Rao' <sonnyrao@chromium.org>, 'Bing Zhao' <bzhao@marvell.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, October 24, 2013, Doug Anderson wrote:
> Seungwon,
> 
> On Wed, Oct 23, 2013 at 12:25 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> >> +             if (card->type == MMC_TYPE_SDIO ||
> >> >> +                 card->type == MMC_TYPE_SD_COMBO) {
> > && card->quirks & MMC_QUIRK_BROKEN_CLK_GATING
> > How about considering MMC_QUIRK_BROKEN_CLK_GATING?
> > Some sdio device can work with gating clock.
> > For this, mmc_fixup_device() should be called prior to init_card() in core(sdio.c).
> > I guess you found that.
> 
> By SDIO devices, are you referring to actual SDIO cards or some
> implementations of dw_mmc?
> 
> As far as I understand in the CLKENA description in the generic
> documentation from Synopsys it say that for SDIO cards you must not
> stop the clock if interrupts must be detected.  To me, that means that
> all dw_mmc implementations require this change if they support SDIO
> interrupts (hence checking for MMC_CAP_SDIO_IRQ).

CLKENA description in manual means that host controller can't detect the SDIO interrupt signal
or wifi device can't generate the interrupt without clock?
Host controller based on Synopsys supports asynchronous interrupts. It seems to depend on wifi Device.
If host can do and  wifi device can also work with clock gating, we may enable low-power mode.

For MMC_QUIRK_BROKEN_CLK_GATING, I referred the code in 'mmc/core/quirks.c'
In addition, although host can support MMC_CAP_SDIO_IRQ, some wifi drivers use
OOB(Out-of-band) interrupt. That means host can apply clock gating to reduce
power consumption.

Thanks,
Seungwon Jeon

> 
> I guess I did make the assumption in this change that all (reasonable)
> SDIO cards would be using SDIO interrupts if they are available.  If
> we could find out ahead of time if a given SDIO driver was planning to
> use interrupts we could do better.  The old solution did better in
> this way and we could probably make it work (and still fix the
> read-modify-write race) if we thought this was really important.  The
> code gets a little more twisted to try to avoid holding the IRQ-safe
> spinlock while updating the clock, but I could attempt it...
> 
> 
> NOTE: We've recently found that there are still occasions when we lose
> SDIO interrupts with dw_mmc and our Marvell WiFi driver, especially
> when those interrupts happen back-to-back.  That problem appears
> unrelated to this one (it's what Bing was investigating when he found
> the original race).  Anyone that has any thoughts, please let me
> know...
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

