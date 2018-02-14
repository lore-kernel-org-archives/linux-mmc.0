From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
Date: Wed, 14 Feb 2018 16:36:49 +0100
Message-ID: <20180214163649.3a0c9476@kitsune.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
        <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Michal Suchanek <msuchanek@suse.de>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 14 Feb 2018 15:58:31 +0100
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi Michal,
> 
> Am 14.02.2018 um 15:38 schrieb Michal Suchanek:
> > The bcm2835 mmc host tends to lock up for unknown reason so reset
> > it on timeout. The upper mmc block layer tries retransimitting with
> > single blocks which tends to work out after a long wait.
> >
> > This is better than giving up and leaving the machine broken for no
> > obvious reason.  
> 
> could you please provide more information about this issue (affected
> hardware, kernel config, version, dmesg, reproducible scenario)?
> 

The RPi3 is known to not work with some SD cards. You can find some
wiki pages with large tables of known-working and known-broken cards. I
have a couple of RPi3 boards and a card that works and card that does
not. I tried debugging the issue but did not find anything I can do
about it - AFAICT the issue happens somewhere inside the MMC controller
IP. 

I have no inside knowledge of the controller in question but during
testing I tried to reset the controller whenever the issue happens so I
can continue running the test system for a longer time until it gets
unusable. While I did not find any solution to the problem the
workaround with resetting the controller works quite reliably for me.

So I am posting it in the hope that people with the wrong combination
of RPi3 and SD card will not get a blank screen but rather a system
that boots but tends to lock up for half a minute occasionally.

Thanks

Michal
