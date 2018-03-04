From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
Date: Sun, 4 Mar 2018 19:44:05 +0100
Message-ID: <20180304194405.442ef90d@naga.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
        <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
        <20180214163649.3a0c9476@kitsune.suse.cz>
        <20180214165827.386b9bb1@kitsune.suse.cz>
        <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
        <20180214202454.6e7ebeaf@naga.suse.cz>
        <431948292.48734.1518640216077@email.1und1.de>
        <20180304165717.6d4d8e68@naga.suse.cz>
        <46261671.179357.1520187109844@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <46261671.179357.1520187109844@email.1und1.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, Phil Elwell <phil@raspberrypi.org>, Gerd Hoffmann <kraxel@redhat.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Julia Lawall <Julia.Lawall@lip6.fr>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Sun, 4 Mar 2018 19:11:49 +0100 (CET)
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi Michal,
> 
> > Michal Suchánek <msuchanek@suse.de> hat am 4. März 2018 um 16:57
> > geschrieben:
> > 
> > 
> > On Wed, 14 Feb 2018 21:30:16 +0100 (CET)
> > Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >   
> > > Hi Michal,
> > >   
> > > > Michal Suchánek <msuchanek@suse.de> hat am 14. Februar 2018 um
> > > > 20:24 geschrieben:
> > > > 
> > > > 
> > > > On Wed, 14 Feb 2018 17:49:31 +0100
> > > > Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > > >     
> > > > > Hi Michal,
> > > > > 
> > > > > [add Phil]
> > > > > 
> > > > > Am 14.02.2018 um 17:13 schrieb Michal Suchánek:    
> > > > > > On Wed, 14 Feb 2018 16:36:49 +0100
> > > > > > Michal Suchánek <msuchanek@suse.de> wrote:
> > > > > >      
> > > > > >> On Wed, 14 Feb 2018 15:58:31 +0100
> > > > > >> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > > > > >>      
> > > > > >>> Hi Michal,
> > > > > >>>
> > > > > >>> Am 14.02.2018 um 15:38 schrieb Michal Suchanek:        
> > > > > >>>> The bcm2835 mmc host tends to lock up for unknown reason
> > > > > >>>> so reset it on timeout. The upper mmc block layer tries
> > > > > >>>> retransimitting with single blocks which tends to work
> > > > > >>>> out after a long wait.
> > > > > >>>>
> > > > > >>>> This is better than giving up and leaving the machine
> > > > > >>>> broken for no obvious reason.          
> > > > > >>> could you please provide more information about this issue
> > > > > >>> (affected hardware, kernel config, version, dmesg,
> > > > > >>> reproducible scenario)?     
> > > > > > It tends to reproduce when upgrading a few packages with
> > > > > > zypper and otherwise at random during system operation. It
> > > > > > seems that for my card it worsens with age to some degree
> > > > > > so perhaps it depends on the fragmentation of the internal
> > > > > > card flash.
> > > > > >
> > > > > > Attaching dmesg and kernel config.      
> > > > > 
> > > > > do you noticed this issue before 4.15-rc4?    
> > > > 
> > > > I initially noticed it with 4.4 kernel with some backports to
> > > > make it bootable on RPi.    
> > > 
> > > this confuses me. Gerd and i ported this driver from downstream
> > > and finally it's got merged in 4.12. 
> > > 
> > > So do you mean that you backported the mainline version to 4.4 or
> > > the downstream version of 4.4?  
> > 
> > I did not backport it but looking at the changelog it is backport of
> > the 4.12 driver. It does not look as the 4.15 driver though. Looks
> > like there was some reorganization of the bcm mmc since then.
> >   
> > > 
> > > On a quick look they seems identical, but they aren't.
> > >   
> > > > > 
> > > > > Could you please test with 4.15 final again?    
> > > >  
> > 
> > I tried upgrading to the current master (4.16-rc3+) and the issue is
> > still reproducible although less frequent. I did full upgrade from
> > the install image which installs over 300 packages and the issue
> > triggered somewhere around 200th while before installing a half
> > dozen packages would usually trigger it.
> >   
> 
> this is the same what i did during my stress tests. The step
> installed 475 packages. The timeout never occured.

First off, you did your testing with Tumbleweed image which probably
uses btrfs for / while I use Leap 42.3 image which uses ext4.

I was not able to reproduce the issue with installing packages so far -
installed GNOME which is over 700 packages and the issue did not
trigger. However, the upgrades also unlink the old files as does
removing packages - removing GNOME removed over 200 packages and the
issue triggered. However, re-installing and removing GNOME again did
not trigger the issue. So nothing so far reproduces the issue reliably.
With the new kernel the issue even reproduces less frequently than the
4.4 and 4.15 kernel - probably some i/o scheduler change affects the
disk i/o patterns.

Thanks

Michal
