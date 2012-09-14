From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Fri, 14 Sep 2012 15:04:14 +0000
Message-ID: <201209141504.14658.arnd@arndb.de>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com> <CAGxe1ZFJhc-c8rS0KGdfTvejs27jjpz7T4Z2AVwoB-=7QOMemg@mail.gmail.com> <CACRpkdaV_PDaYH+RgM2pa9f9Gp97-D9xbxfDkPUBfXSR+-csAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61845 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab2INPES (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Sep 2012 11:04:18 -0400
In-Reply-To: <CACRpkdaV_PDaYH+RgM2pa9f9Gp97-D9xbxfDkPUBfXSR+-csAg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Saugata Das <saugata.das@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

On Friday 14 September 2012, Linus Walleij wrote:
> On Fri, Sep 14, 2012 at 10:25 AM, Girish K S
> <girish.shivananjappa@linaro.org> wrote:
> > On 14 September 2012 12:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> Hi Girish,
> >>
> >> I should also have stated that this patch has not been tested with an
> >> eMMC 4.5 device, thus the power off notification is not fully tested.
> >> Unfortunate I don't have such a device available right now. What I did
> >> test was that patch must not break anything and tested that the
> >> suspend/resume sequence is fixed for eMMC with sleep support. I also
> >> tested this with MMC_CAP2_POWEROFF_NOTIFY enabled.
> >>
> >> Are you able to help out in testing with a eMMC 4.5 device with
> >> POWER_OFF_NOTIFY support?
> >
> > I am also facing the same  problem. The board that i used earlier to
> > upstream 4.5 patches is not functioning. Thats the reason for the
> > delay in upstreaming or sending the patch. Once i get it repaired i ll
> > definitely do it.
> > It would be helpful if somebody in the list can do this in the mean time.
> 
> Let's page Arnd, I was under the impression that he has a eMMC 4.5
> board so maybe he can test it?

I have a few eMMC samples but am only using them with my (slow) thinkpad
SD card reader. I also don't know which eMMC-4.5 features they implement,
as some may be early prototypes.

What exactly do you need tested?

	Arnd
