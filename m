From: "Tanya Brokhman" <tlinder@codeaurora.org>
Subject: RE: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Sun, 30 Sep 2012 08:48:56 +0200
Message-ID: <005901cd9ed7$aca95c30$05fc1490$@codeaurora.org>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>	<CAGxe1ZFJhc-c8rS0KGdfTvejs27jjpz7T4Z2AVwoB-=7QOMemg@mail.gmail.com>	<CACRpkdaV_PDaYH+RgM2pa9f9Gp97-D9xbxfDkPUBfXSR+-csAg@mail.gmail.com>	<201209141504.14658.arnd@arndb.de>	<003301cd9705$c874a250$595de6f0$@codeaurora.org>	<CAPDyKFr0guahzweekZrmY3EQ2KyBev9OKbyF88CeOiaH5JtJYg@mail.gmail.com>	<005801cd9ca3$0c539920$24facb60$@codeaurora.org> <CAPDyKFqJRvuTA61m+SyOR4HV8sMdRGmbj46rmeLsVTMN6GSD+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:6008 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab2I3GtR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 30 Sep 2012 02:49:17 -0400
In-Reply-To: <CAPDyKFqJRvuTA61m+SyOR4HV8sMdRGmbj46rmeLsVTMN6GSD+g@mail.gmail.com>
Content-language: he
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'Arnd Bergmann' <arnd@arndb.de>, 'Linus Walleij' <linus.walleij@linaro.org>, 'Girish K S' <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Per Forlin' <per.forlin@stericsson.com>, 'Johan Rudholm' <johan.rudholm@stericsson.com>, 'Lee Jones' <lee.jones@linaro.org>, 'Saugata Das' <saugata.das@linaro.org>, 'Asutosh Das' <asutoshd@codeaurora.org>

Hi Ulf,

> 
> Hi Tanya,
> 
> Thanks a lot for helping out!!!

NP. 
> 
> Testing suspend to ram, and then resuming back again is the key use case
to
> test.


Is there a special scenario to trigger suspend or just leaving the system
idle? I did that. Added prints in the code to verify that the PON was sent
to the card.... It feels a bit superficial to me that's why I'm asking if
there is a specific scenario I can try.
Other than that, as I already mentioned we ran our test suit that includes
various user-use cases such as playing a game, reading a web page, email
etc. And of course I tried lmdd both ways.

> 
> Kind regards
> Ulf Hansson
> 


Thanks,
Tanya Brokhman
---
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


