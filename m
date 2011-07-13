From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Added quirks for Ricoh 1180:e823 lower base clock frequency
Date: Wed, 13 Jul 2011 12:55:17 -0400
Message-ID: <m21uxu2k96.fsf@bob.laptop.org>
References: <1310419715-13254-1-git-send-email-manoj.iyer@canonical.com>
	<m2sjqa2q93.fsf@bob.laptop.org>
	<alpine.DEB.2.02.1107131031360.3174@lazy>
	<201107131835.25217.arnd@arndb.de>
	<alpine.DEB.2.02.1107131144250.3174@lazy>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1107131144250.3174@lazy> (Manoj Iyer's message
	of "Wed, 13 Jul 2011 11:46:27 -0500 (CDT)")
Sender: linux-pci-owner@vger.kernel.org
To: Manoj Iyer <manoj.iyer@canonical.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, matsumur@nts.ricoh.co.jp, linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jul 13 2011, Manoj Iyer wrote:
> Do you think that lowering the controller speed to 50Mhz in case we
> have a failure is a better idea than reducing the speed for all e823
> ricoh controllers? I can send a V2 of the patch. What do you think ?

It could be better.  Do you think you could get hold of a UHS-1 card for
testing with?  (I don't think it's worth doing if there's no appreciable
performance difference either way.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
