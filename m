From: David Haworth <dave@fen-net.de>
Subject: Re: How to print CMD18 read data
Date: Wed, 1 Feb 2017 19:00:21 +0100
Message-ID: <20170201180021.GA3189@fen-net.de>
References: <CGME20170201072351epcas2p4b40fc91e204153ce57d510622ab021cc@epcas2p4.samsung.com>
 <CAMGZvfKXGwmrOSD-z_4F5aM5S7TPENmPkLKQ3ArQxJ+rEruhtg@mail.gmail.com>
 <e0fcedc7-58f4-7ee3-e182-db684c8748d6@samsung.com>
 <CAMGZvfJsuHFkRJVdp9npeUMP53vsCh4G4=Py1pZphZkaowsT9A@mail.gmail.com>
 <0f96cf1e-cd58-c02c-5746-11d52fe9bb7e@samsung.com>
 <CAMGZvfLeERvi5eavPc4gcoJr2dOpAe7XSe+zs9K9yOKv=eOoow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hermes.f3n.de ([212.204.115.44]:60450 "EHLO hermes.f3n.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbdBASAd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Feb 2017 13:00:33 -0500
Content-Disposition: inline
In-Reply-To: <CAMGZvfLeERvi5eavPc4gcoJr2dOpAe7XSe+zs9K9yOKv=eOoow@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: amit mahadik <amitmaddy@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org

Hi Amit,

I'm trying to access an SD card/reader using SPI on a
Raspberry Pi. I've had a little success - some of my cards
work, some don't. I get errors from time to time, but they
appear harmless. I seem to have cured a spurious timeout
problem.

I'm using pr_info() to dump debug messages into /var/log/syslog.

Maybe we can compare notes and come up with a solution.
Contact me off-list of you prefer.

Cheers,
Dave


On Wed, Feb 01, 2017 at 05:46:34PM +0530, amit mahadik wrote:
> Hi Jaehoon,
>                       I tried the use_spi_crc=0 option too. However,
> if the data read is incorrect the block layer has no way of knowing
> the contents of partition table. That is the reason it fails to detect
> partitions of the connected SDMMC card.
> 
> Regards,
> Amit.

-- 
David Haworth
Baiersdorf, Germany
dave@fen-net.de                PGP key at https://keyserver.pgp.com/
http://thelancashireman.org
