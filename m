From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sd: Fix sd current limit setting
Date: Tue, 17 Jul 2012 11:43:26 -0400
Message-ID: <87fw8qieap.fsf@octavius.laptop.org>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
	<1341296172-10645-3-git-send-email-aaron.lu@amd.com>
	<CAGxe1ZF=T7GL6ZcyV-=MEd5WVWexNrUbrEZDsYGdFD+KPH4XfA@mail.gmail.com>
	<20120717134325.GA2567@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50053 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855Ab2GQPnc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Jul 2012 11:43:32 -0400
In-Reply-To: <20120717134325.GA2567@localhost.localdomain> (Aaron Lu's message
	of "Tue, 17 Jul 2012 21:43:28 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Tue, Jul 17 2012, Aaron Lu wrote:
>> sorry for seeing this late.
>> The macro name should be **_CAP2_***.
>
> Chris, please let me know how you want to deal with this and I'll be
> glad to do whatever I can to fix this. Sorry for the trouble.

No worries, I can rebase it in.  Mind sending a patch on top of current
mmc-next for me to squash on top of the previous one?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
