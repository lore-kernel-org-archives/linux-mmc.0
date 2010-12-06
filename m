From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: reference implementation of runtime PM
Date: Mon, 6 Dec 2010 18:56:15 +0000
Message-ID: <20101206185615.GK2495@trinity.fluff.org>
References: <AANLkTikK-SvvDHfeNHXP4tw_e3p3gZ4XaT8Ta5YpuDar@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:50777 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab0LFS4Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Dec 2010 13:56:25 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikK-SvvDHfeNHXP4tw_e3p3gZ4XaT8Ta5YpuDar@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Mon, Dec 06, 2010 at 05:57:22PM +0000, Daniel Drake wrote:
> Hi,
> 
> I'm working on getting runtime pm working on the XO-1.5 laptop
> (sdhci-pci) in case it is related to some other power-related issues
> we have been having.
> 
> Right now, when runtime is enabled, the card cannot be brought back
> online again after it has been powered off.
> 
> I've dug down and I think that runtime PM is doing basically nothing.
> i.e. when the system decides to runtime-suspend my SD card, nothing
> actually happens to the SD card. It remains fully powered and
> untouched. I'm basing this assumption on mmc_power_save_host() which
> relies entirely on host->bus_ops->power_save() doing the actual
> power-down work. On sdhci this method does not exist.

you might want to add the linux-pm list to this.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

