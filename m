From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Wed, 19 Sep 2012 21:35:06 -0400
Message-ID: <m3sjadfpdh.fsf@pullcord.laptop.org>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
	<CAGxe1ZFJhc-c8rS0KGdfTvejs27jjpz7T4Z2AVwoB-=7QOMemg@mail.gmail.com>
	<CACRpkdaV_PDaYH+RgM2pa9f9Gp97-D9xbxfDkPUBfXSR+-csAg@mail.gmail.com>
	<201209141504.14658.arnd@arndb.de>
	<CAGxe1ZEYgs3va6SR83UeN02Lnjr4Wd-dGWsPqTputcaiSJW6mA@mail.gmail.com>
	<CAPDyKFoJn=NrzxXsLyp_ygQj=09faa_p0Q8i7M+MEypF7Y_ACQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48931 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab2ITBep (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Sep 2012 21:34:45 -0400
In-Reply-To: <CAPDyKFoJn=NrzxXsLyp_ygQj=09faa_p0Q8i7M+MEypF7Y_ACQ@mail.gmail.com>
	(Ulf Hansson's message of "Wed, 19 Sep 2012 18:06:08 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Saugata Das <saugata.das@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

Hi,

On Wed, Sep 19 2012, Ulf Hansson wrote:
> Just pinging you to see if you have an opinion in merging this without
> full testing on eMMC4.5 device?
>
> I am kind of eager to fixup the broken suspend for eMMC with sleep,
> which this does. :-)

Well, we don't need "full testing", but I don't think it's a good idea
to merge this without any testing at all on eMMC 4.5.  Might as well
just wait a little longer and send it as a 3.7 fix with a stable@ tag?
Do we have any ETA on when someone will be able to test?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
