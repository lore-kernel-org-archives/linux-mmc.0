From: Stephen Warren <swarren@nvidia.com>
Subject: RE: Dynamic MMC device naming vs. bootloaders
Date: Wed, 6 Apr 2011 10:32:49 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0493EB36DB@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0493EB33AE@HQMAIL01.nvidia.com>
	<BANLkTik7fbz+QLZY8RH9wCkGQdU3hUNfNA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0493EB3599@HQMAIL01.nvidia.com>
	<BANLkTimDbPkgHDuERqJ-qRe9Ji2RyzAvXA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0493EB36C7@HQMAIL01.nvidia.com>
 <BANLkTik8fti=o1+NRCUALFGYMiFzbRy+Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:13261 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab1DFRce convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 13:32:34 -0400
In-Reply-To: <BANLkTik8fti=o1+NRCUALFGYMiFzbRy+Jg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Kishore Kadiyala <kishorek.kadiyala@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Andrei Warkentin wrote at Wednesday, April 06, 2011 11:19 AM:
> On Wed, Apr 6, 2011 at 11:59 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > However, isn't it just a fluke that this will work; registering the internal
> > host controller first will I assume start probing of any attached devices on
> > that controller first, but does it actually guarantee that such probing will
> > also complete first, which I believe is the necessary condition for the mmcblk
> > device to be assigned ID 0?
> >
> 
> The device index is only assigned if the mmc block driver is started
> on a detected card. ...
> 
> > Equally, if there were two controllers with fixed/internal MMC and/or two
> > controllers which supported pluggable SD cards, the race issue would still
> > exist?
> 
> I think if you had two controllers and you plugged two cards in at the
> "same time", then you would have  a race condition, as both would
> mmc_detect_change (effectively schedule_work to an ordered wq), and it
> would depend on which card change IRQ occured first. It seems like
> different hosts use different delays for when the work will be done,
> so if you have different hosts, you can make this even more obvious.
> You'd have to really try, though, I think. I guess if you are never
> going to support multiple cards on one host, you might as well tie the
> block index to host index.

The case I care about most right now is a cold kernel boot. This is
basically the same as plugging two SD cards in at (exactly) the same time;
the time being when the SD platform driver is registered. The fact that
that on my board, one is actually eMMC and one really an SD card that's
already plugged in pre-boot isn't really that relevant.

So, if I interpret your statements correctly, you're agreeing that simply
registering the host controller for eMMC first doesn't guarantee that
the eMMC will be block device ID 0, albeit in practice that does seem to
be true a large enough percentage of the time not to notice any problem.

Am I correct?

Thanks.

-- 
nvpublic

