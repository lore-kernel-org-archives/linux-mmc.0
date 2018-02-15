From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/2] mmc: bcm2835: print some informational messages
 during reset
Date: Thu, 15 Feb 2018 19:22:00 +0100 (CET)
Message-ID: <1950058855.86123.1518718920111@email.1und1.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
 <F404E9C8-AE64-4B36-AD1B-911BD3C33946@gmail.com>
 <20180214204733.7987d16c@naga.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180214204733.7987d16c@naga.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Scott Branden <sbranden@broadcom.com>, linux-rpi-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com, Gerd Hoffmann <kraxel@redhat.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Michal,

> Michal Suchánek <msuchanek@suse.de> hat am 14. Februar 2018 um 20:47 geschrieben:
> 
> 
> On Wed, 14 Feb 2018 08:50:16 -0800
> Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> > On February 14, 2018 6:38:58 AM PST, Michal Suchanek
> > <msuchanek@suse.de> wrote:
> > >The previous patch does reset during hardware error so make the reset
> > >progress more visible.  
> > 
> > Based on your previous email it looks like this can happen quite
> > frequently so we might be spamming the kernel log with such reset
> > messages. Turning this into a debug print would not be great either,
> > how about a custom sysfs attribute counting the number of times a
> > reset was done?
> 
> Since every such message happens when the system stalls for like half a
> minute I don't think there will be that many until somebody notices
> something is amiss. It might be also helpful in diagnosing if other
> cards lock up in different way - for me the DMA shutdown is short so I
> guess it's the mmc host that is locked up and the DMA engine is fine.
> It might look differently on different systems, though.

FWIW according to your dmesg your RPi doesn't use the DMA engine:

[ 5.004609] sdhost-bcm2835 3f202000.sdhost: unable to initialise DMA channel. Falling back to PIO
[ 5.154518] sdhost-bcm2835 3f202000.sdhost: loaded - DMA disabled

For me it's a chicken and egg problem if the DMA driver is build as a kernel module.

Stefan

> 
> I understand that adding messages it somewhat controversial so I added
> them in separate patch.
> 
> Thanks
> 
> Michal
