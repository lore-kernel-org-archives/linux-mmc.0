From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH 00/13] mmc: Improve busy detection for
 MMC_CAP_WAIT_WHILE_BUSY
Date: Wed, 3 Sep 2014 15:24:57 +0800
Message-ID: <20140903072452.GA6799@shlinux1.ap.freescale.net>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
 <CAA+hA=QaCcFt8fm9xohnAhcH5T4RmASNte542jDs6v7-q-6bdw@mail.gmail.com>
 <CAPDyKFp55i7cMJ2jNnoLPzLFdkHfW7F_-86y0P1wb94usec3nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1blp0187.outbound.protection.outlook.com ([207.46.163.187]:13343
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751109AbaICHq0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Sep 2014 03:46:26 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFp55i7cMJ2jNnoLPzLFdkHfW7F_-86y0P1wb94usec3nA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dong Aisheng <dongas86@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, b51421@freescale.com

On Wed, Sep 03, 2014 at 09:32:35AM +0200, Ulf Hansson wrote:
> On 3 September 2014 08:51, Dong Aisheng <dongas86@gmail.com> wrote:
> > Hi Ulf,
> >
> > On Thu, Jan 30, 2014 at 6:37 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> This patchset improves the handling around busy detection in the mmc core layer
> >> while operating on host supporting MMC_CAP_WAIT_WHILE_BUSY.
> >>
> >> A R1B response is for an mmc command, specified as and R1 but with an optional
> >> busy assertion on the DAT0 line. Hosts supporting MMC_CAP_WAIT_WHILE_BUSY,
> >> normally has a busy detection mechanism build in it's controller HW.
> >>
> >> Using such a feature decreases the need for polling of the card's status using
> >> CMD13, which is the fallback method used by the mmc core for hosts that don't
> >> support MMC_CAP_WAIT_WHILE_BUSY.
> >>
> >> Typcial commands that expects R1B responses are CMD6 (SWITCH), CMD12 (STOP),
> >> CMD38 (ERASE) and CMD5 (SLEEP). This patchset adresses CMD6, CMD5 and improves
> >> some parts where CMD12 are used. If the implemented approach becomes accepted,
> >> a future patchset for CMD38 can be based on top if this patchset.
> >>
> >> Do note, the final two patches implements support for busy detection for the
> >> mmci host driver, since some of it's HW variants do supports busy detection.
> >>
> >> Future suggested improvements related to this patchset: (Please, feel free to
> >> implement any of them :-) ).
> >>
> >> a) For CMD38, select a fixed number maximum blocks to accept for
> >> erase/discard/trim operations. Compute the needed timeout depending on each
> >> card's erase information provided through it's CSD/EXT_CSD registers. Then
> >> follow the same principle as for sending a CMD6.
> >>
> >> b) At least for CMD38, but likely for other commands as well, we could benefit
> >> from doing a _periodic_ CMD13 polling to handle the busy completion. This will
> >> also be useful for hosts supporting MMC_CAP_WAIT_WHILE_BUSY, in particular for
> >> cases where the host are unable to support the needed busy timeout.
> >>
> >
> > Do you have the plan to implement above two items?
> 
> Yes, it's on top of my TODO list for MMC. I really need to get this
> done asap. Thanks for pinging me about this.
> 

Great!

> > Since currently the max_discard_sectors is still calculated based on
> > max_busy_timeout of host,
> > it is possible that for some eMMC chips, the max_discard_sectors is 1,
> > which then cause the erase operation terribly slow.
> 
> Yes!
> 
> Another issue to fix is get MMC_CAP_ERASE removed - and that should be
> possible once the above described problem has been solved.
> 

Yes, seems MMC_CAP_ERASE is not needed anymore.

Regards
Dong Aisheng

> Kind regards
> Uffe
