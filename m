From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sd: Fix sd current limit setting
Date: Wed, 18 Jul 2012 01:28:40 -0400
Message-ID: <87liihocxj.fsf@octavius.laptop.org>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
	<1341296172-10645-3-git-send-email-aaron.lu@amd.com>
	<CAGxe1ZF=T7GL6ZcyV-=MEd5WVWexNrUbrEZDsYGdFD+KPH4XfA@mail.gmail.com>
	<20120717134325.GA2567@localhost.localdomain>
	<87fw8qieap.fsf@octavius.laptop.org>
	<20120718050939.GA30490@srdclcs1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43965 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582Ab2GRF2x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Jul 2012 01:28:53 -0400
In-Reply-To: <20120718050939.GA30490@srdclcs1.amd.com> (Aaron Lu's message of
	"Wed, 18 Jul 2012 13:09:39 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi Aaron,

On Wed, Jul 18 2012, Aaron Lu wrote:
> Is the following patch OK? This is based on top of current mmc-next with
> the previous one in tree. Not sure if this is what you want though.

Yes, that's perfect; squashed into the original patch and pushed out
to mmc-next.  Thanks!

Having there be so many MAX_CURRENT defines -- and having them be
split in the middle between CAP_ and CAP2_ -- is starting to feel
a bit awkward.  Does anyone have ideas on how that might be tidied
up, since we have an opportunity to come up with a better plan
before this gets merged soon?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
