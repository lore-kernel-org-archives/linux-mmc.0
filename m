From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 0/5] mmc: mvsdio: use devm_ API to simplify/correct
 error paths.
Date: Tue, 22 Jan 2013 20:44:48 -0500
Message-ID: <20130123014447.GE1758@titan.lakedaemon.net>
References: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61600 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752729Ab3AWBoz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jan 2013 20:44:55 -0500
Content-Disposition: inline
In-Reply-To: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux@arm.linux.org.uk, linux-mmc@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 16, 2013 at 02:13:55PM +0100, Andrew Lunn wrote:
> Russell King pointed out a number of issues with the probe code in the
> mvsdio driver and supplied a patch. This patchset uses a modified
> version, converting resource allocations to devm API calls, and fixes
> the error paths. The patches that then follow are from Thomas
> Petazzoni making other cleanups and adding device tree. These patches
> needed some changes after the swap to devm. The patches here replace
> the earlier submitted patches with the same Subject.
> 
> Andrew Lunn (1):
>   mmc: mvsdio: use devm_ API to simplify/correct error paths.

Applied to mvebu/fixes.

> Thomas Petazzoni (4):
>   mmc: mvsdio: use slot-gpio infrastructure for write protect gpio
>   mmc: mvsdio: use slot-gpio for card detect gpio
>   mmc: mvsdio: implement a Device Tree binding
>   mmc: mvsdio: add pinctrl integration

Re-applied to mvebu/drivers

>  .../devicetree/bindings/mmc/orion-sdio.txt         |   17 ++
>  drivers/mmc/host/mvsdio.c                          |  187 ++++++++------------
>  2 files changed, 93 insertions(+), 111 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt

thx,

Jason.
