From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH 2/2] mmc: bcm2835: print some informational messages
 during reset
Date: Wed, 14 Feb 2018 20:47:33 +0100
Message-ID: <20180214204733.7987d16c@naga.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
        <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
        <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
        <F404E9C8-AE64-4B36-AD1B-911BD3C33946@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56915 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162873AbeBNTrj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Feb 2018 14:47:39 -0500
In-Reply-To: <F404E9C8-AE64-4B36-AD1B-911BD3C33946@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Michal Suchanek <msuchanek@suse.de>, Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Gerd Hoffmann <kraxel@redhat.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018 08:50:16 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On February 14, 2018 6:38:58 AM PST, Michal Suchanek
> <msuchanek@suse.de> wrote:
> >The previous patch does reset during hardware error so make the reset
> >progress more visible.  
> 
> Based on your previous email it looks like this can happen quite
> frequently so we might be spamming the kernel log with such reset
> messages. Turning this into a debug print would not be great either,
> how about a custom sysfs attribute counting the number of times a
> reset was done?

Since every such message happens when the system stalls for like half a
minute I don't think there will be that many until somebody notices
something is amiss. It might be also helpful in diagnosing if other
cards lock up in different way - for me the DMA shutdown is short so I
guess it's the mmc host that is locked up and the DMA engine is fine.
It might look differently on different systems, though.

I understand that adding messages it somewhat controversial so I added
them in separate patch.

Thanks

Michal
