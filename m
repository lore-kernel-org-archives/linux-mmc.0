From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 07:56:15 -0400
Message-ID: <87k3ws5uhs.fsf@octavius.laptop.org>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<201208211101.21612.arnd@arndb.de>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60532 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653Ab2HUL4X (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Aug 2012 07:56:23 -0400
In-Reply-To: <CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	(Thomas Abraham's message of "Tue, 21 Aug 2012 16:44:49 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, patches@linaro.org

Hi,

On Tue, Aug 21 2012, Thomas Abraham wrote:
> I am trying to have a way to represent a gpio line as card detect line
> that is not connected to the card-detect pad of the mmc controller but
> instead used as a gpio interrupt line or polled gpio line.
>
> 'broken-cd' would imply that the card-detect pad of the mmc controller
> is not connected to the card-detect pin at the slot. The 'cd-gpios'
> property in that case would let the driver code to use the 'cd-gpios'
> line as the external gpio interrupt or poll it.

How about this?

broken-cd: No CD available, use polling.

cd-gpios: The CD pin on the host is working and brought out to a GPIO.

external-cd-gpios: The CD pin on the host is broken, but there's an
                   independent external GPIO available.


(Each host should only have one of these properties.)
                   
Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
