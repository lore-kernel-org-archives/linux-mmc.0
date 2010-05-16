From: Sascha Sommer <saschasommer@freenet.de>
Subject: Re: [PATCH] mmc: drop the "state" argument to mmc_suspend_host()
Date: Sun, 16 May 2010 20:20:18 +0200
Message-ID: <201005162020.18511.saschasommer@freenet.de>
References: <d071c94414fc069d9360ae62a37fd2ad0b68110f.1273777159.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d071c94414fc069d9360ae62a37fd2ad0b68110f.1273777159.git.matt@console-pimps.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Manuel Lauss <manuel.lauss@gmail.com>, Cliff Cai <cliff.cai@analog.com>, =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Pavel Pisa <ppisa@pikron.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Ben Dooks <ben-linux@fluff.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Alex Dubov <oakad@yahoo.com>, Ian Molton <ian@mnementh.co.uk>, Joseph Chan <JosephChan@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, Pierre Ossman <pierre@ossman.eu>
List-Id: linux-mmc@vger.kernel.org

Hi,

Am Donnerstag 13 Mai 2010 21:01:45 schrieb Matt Fleming:
> Even though many mmc host drivers pass a pm_message_t argument to
> mmc_suspend_host() that argument isn't used the by MMC core. As host
> drivers are converted to dev_pm_ops they'll have to construct
> pm_message_t's (as they won't be passed by the PM subsystem any more)
> just to appease the mmc suspend interface.
> 
> We might as well just delete the unused paramter.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Acked-by: Sascha Sommer <saschasommer@freenet.de>

(for sdricoh_cs)

Regards

Sascha
