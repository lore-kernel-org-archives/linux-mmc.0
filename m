From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 3/4] mmc: dw_mmc: Always setup the bus after suspend/resume
Date: Fri, 9 Aug 2013 08:43:13 -0700
Message-ID: <CAD=FV=VO=50uMXfwY5iNa+xiamRiHTSpTMXs+EdMeUTawkeyqw@mail.gmail.com>
References: <1373470926-19314-1-git-send-email-dianders@chromium.org>
	<1375825071-20922-1-git-send-email-dianders@chromium.org>
	<1375825071-20922-4-git-send-email-dianders@chromium.org>
	<001a01ce9505$59c28b20$0d47a160$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:55735 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965333Ab3HIPnO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 11:43:14 -0400
Received: by mail-qc0-f179.google.com with SMTP id n10so438724qcx.38
        for <linux-mmc@vger.kernel.org>; Fri, 09 Aug 2013 08:43:13 -0700 (PDT)
In-Reply-To: <001a01ce9505$59c28b20$0d47a160$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Seungwon,

On Fri, Aug 9, 2013 at 6:35 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Wed, August 07, 2013, Doug Anderson wrote:
>> After suspend/resume all of the dw_mmc registers are reset to
>> defaults.  We restore most of them, but specifically don't setup the
>> clock registers after resume unless we've got a powered card.  Things
>> still work because the core will eventually call set_ios() and we'll
>> set things up.
>
> Hmm, I didn't get the need of this call during resume.
> I think set_ios is only valid where core layer calls.
> Besides, important things is ios's parameters.
> If suspend has finished successfully, last call of set_ios() is from mmc_power_off().
> On seeing fields of 'mmc->ios' stored last, these values aren't proper in resume phase.
> Please check mmc_power_off() function.
> In case MMC_PM_KEEP_POWER it could be kept.

Most of my reasoning has to do with the fact that the state of the
system after suspend/resume should not be significantly different than
the state of the system before suspend/resume.  If the state of the
system is different in the two cases it points out potential problems
or inefficiencies.

To make this more concrete:

1. Boot up a system with no card in the SD Card slot.
2. Note down the value of registers like CLKDIV, CLKENA, etc.
3. Suspend / resume (S2R)
4. Check the values of CLKDIV, CLKENA, etc.

You will notice that they are different.  This is a bad sign and can
be a source of bugs (though I don't know of any).  ...or it could mean
that power draw is different (could be better, could be worse) after a
suspend/resume cycle.


Said another way, if the value of CLKDIV, CLKENA, etc is not important
when a card is not inserted, why do they get initialized at boot time?


In general, I think that the mmc core code makes the assumption that
it's up to the driver to make sure that its state is preserved across
S2R.  For dw_mmc the driver doesn't do the "brute force" that some
drivers do of just saving and restoring all registers using a copy
loop.  Instead, the dw_mmc driver runs code that tries to set the
state back to something reasonable.  Without my patch the dw_mmc
driver doesn't run any code that restores these registers.
dw_mci_set_ios() will do so.

Another option would be to forcibly save/restore registers in suspend/resume.

-Doug
