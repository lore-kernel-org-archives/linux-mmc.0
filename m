From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v4 3/4] mmc: dw_mmc: Always setup the bus after
 suspend/resume
Date: Mon, 12 Aug 2013 16:20:30 +0900
Message-ID: <000d01ce972c$6cf14730$46d3d590$%jun@samsung.com>
References: <1373470926-19314-1-git-send-email-dianders@chromium.org>
 <1375825071-20922-1-git-send-email-dianders@chromium.org>
 <1375825071-20922-4-git-send-email-dianders@chromium.org>
 <001a01ce9505$59c28b20$0d47a160$%jun@samsung.com>
 <CAD=FV=VO=50uMXfwY5iNa+xiamRiHTSpTMXs+EdMeUTawkeyqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18947 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab3HLHUd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2013 03:20:33 -0400
In-reply-to: <CAD=FV=VO=50uMXfwY5iNa+xiamRiHTSpTMXs+EdMeUTawkeyqw@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Olof Johansson' <olof@lixom.net>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Grant Grundler' <grundler@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, August 10, 2013,Doug Anderson wrote:
> Seungwon,
> 
> On Fri, Aug 9, 2013 at 6:35 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > On Wed, August 07, 2013, Doug Anderson wrote:
> >> After suspend/resume all of the dw_mmc registers are reset to
> >> defaults.  We restore most of them, but specifically don't setup the
> >> clock registers after resume unless we've got a powered card.  Things
> >> still work because the core will eventually call set_ios() and we'll
> >> set things up.
> >
> > Hmm, I didn't get the need of this call during resume.
> > I think set_ios is only valid where core layer calls.
> > Besides, important things is ios's parameters.
> > If suspend has finished successfully, last call of set_ios() is from mmc_power_off().
> > On seeing fields of 'mmc->ios' stored last, these values aren't proper in resume phase.
> > Please check mmc_power_off() function.
> > In case MMC_PM_KEEP_POWER it could be kept.
> 
> Most of my reasoning has to do with the fact that the state of the
> system after suspend/resume should not be significantly different than
> the state of the system before suspend/resume.  If the state of the
> system is different in the two cases it points out potential problems
> or inefficiencies.
> 
> To make this more concrete:
> 
> 1. Boot up a system with no card in the SD Card slot.
> 2. Note down the value of registers like CLKDIV, CLKENA, etc.
> 3. Suspend / resume (S2R)
> 4. Check the values of CLKDIV, CLKENA, etc.
> 
> You will notice that they are different.  This is a bad sign and can
> be a source of bugs (though I don't know of any).  ...or it could mean
> that power draw is different (could be better, could be worse) after a
> suspend/resume cycle.
> 
> 
> Said another way, if the value of CLKDIV, CLKENA, etc is not important
> when a card is not inserted, why do they get initialized at boot time?
> 
> 
> In general, I think that the mmc core code makes the assumption that
> it's up to the driver to make sure that its state is preserved across
> S2R.  For dw_mmc the driver doesn't do the "brute force" that some
> drivers do of just saving and restoring all registers using a copy
> loop.  Instead, the dw_mmc driver runs code that tries to set the
> state back to something reasonable.  Without my patch the dw_mmc
> driver doesn't run any code that restores these registers.
> dw_mci_set_ios() will do so.

This seems pretty associated with [1/4 patch]. (Anyway continued, ...)
Basically, both CLKDIV and CLKENA will be set with the reset value of zero. This means clock is disabled.
While resume of dw_mmc is completed, initial configuration registers will be set except for runtime registers.
I think registers related to clock are close to runtime.
Core layer knows the correct clock rate for current device mode and will actually request it by set_ios.
If core layer requests set_ios no more after dw_mmc resume is completed, dw_mmc will keep the clock to be disabled.
Then, dw_mmc doesn't need self call of dw_mci_set_ios.

Thanks,
Seungwon Jeon
> 
> Another option would be to forcibly save/restore registers in suspend/resume.
> 
> -Doug

