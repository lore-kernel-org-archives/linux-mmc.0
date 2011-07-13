From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Added quirks for Ricoh 1180:e823 lower base clock frequency
Date: Wed, 13 Jul 2011 12:50:56 -0400
Message-ID: <m262n62kgf.fsf@bob.laptop.org>
References: <1310419715-13254-1-git-send-email-manoj.iyer@canonical.com>
	<m2sjqa2q93.fsf@bob.laptop.org>
	<alpine.DEB.2.02.1107131031360.3174@lazy>
	<201107131835.25217.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201107131835.25217.arnd@arndb.de> (Arnd Bergmann's message of
	"Wed, 13 Jul 2011 18:35:25 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Manoj Iyer <manoj.iyer@canonical.com>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, matsumur@nts.ricoh.co.jp, linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jul 13 2011, Arnd Bergmann wrote:
> Not much. This card only has a 6MB/s write speed, which is well below
> what a 50 MHz bus can do. It mgiht be different on a fast eMMC device
> or a Sandisk Extreme Pro UHS-1 card.

Okay, I see.  I think we're good for now, then -- hopefully anyone using
a UHS card on their laptop will see the printk when wondering why their
performance isn't great and get in touch with us, and we can investigate
more then.

I've pushed Manoj's patch to mmc-next for 3.1 now, with the printk
changes and a stable@ tag.

Thanks again,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
