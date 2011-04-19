From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver Re-Resubmission
Date: Tue, 19 Apr 2011 14:10:41 +0200
Message-ID: <201104191410.42177.arnd@arndb.de>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536> <201103151723.32942.arnd@arndb.de> <1303203952.1622.19.camel@apple-mac>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:52279 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab1DSMKr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 08:10:47 -0400
In-Reply-To: <1303203952.1622.19.camel@apple-mac>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Tuesday 19 April 2011, Tony Olech wrote:
> The purpose of this read-only interface is for VUB300 support
> staff to obtain information from our customers. Our customers
> are not like the people on this list. If you have ever tried
> to do telephone support you would appreciate the difficulty
> of getting a non-technical person to first of all find the
> log files and then to extract the correct lines. It therefore
> follows that if the 1 or 4 bit mode is useful info for the 
> VUB300 support staff, then this read-only interface is the
> appropriate single place for it to be provided. The overhead
> of providing such an interface is negligible and the existance
> of such an interface demonstrates that linux is no longer
> designed only for geeks.

Wrong answer.

You are missing the point. Sysfs is not the place where you can
put random interfaces you want for you own needs. By adding
files there, you create a support burden for everyone who now
has to maintain backwards-compatibility.

You cannot seriously ask for inclusion of a kernel interface
just to fit the use of your support team at the expense of
everyone else.

Please remove the sysfs attributes from the driver before resubmitting.
We can have a separate discussion about core interfaces that will
help everyone and that are consistent with how Linux kernels are
supported.

	Arnd
