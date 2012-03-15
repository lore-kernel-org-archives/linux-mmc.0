From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
Date: Thu, 15 Mar 2012 17:37:14 +0000
Message-ID: <20120315173714.GF15988@n2100.arm.linux.org.uk>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <1331734803-17954-3-git-send-email-lee.jones@linaro.org> <20120315173256.GD15988@n2100.arm.linux.org.uk> <4F622884.6060807@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44030 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030464Ab2CORhi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 13:37:38 -0400
Content-Disposition: inline
In-Reply-To: <4F622884.6060807@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org, arnd@arndb.de

On Thu, Mar 15, 2012 at 05:36:04PM +0000, Lee Jones wrote:
> On 15/03/12 17:32, Russell King - ARM Linux wrote:
> > On Wed, Mar 14, 2012 at 02:20:00PM +0000, Lee Jones wrote:
> >> This is a step in the right direction for future Device
> >> Tree support. It will allow variant specific attributes
> >> to be collected from a Device Tree without overloading
> >> the MMCI core. It will also provide additional future
> >> variants a cleaner way to add support.
> > 
> > NAK.  You can't have two driver structures with the same name.  The names
> > are sysfs object names.
> 
> Well spotted.
> 
> I've already changed this in v2. :)

I'm not in favour of splitting the two variants either btw.
