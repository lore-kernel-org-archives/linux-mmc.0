From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC] mmc: core: add the capability for broken voltage
Date: Sat, 04 Feb 2012 18:24:31 -0500
Message-ID: <m2aa4y9o7k.fsf@bob.laptop.org>
References: <4F13E47D.8040505@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46123 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444Ab2BDXYo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 18:24:44 -0500
In-Reply-To: <4F13E47D.8040505@samsung.com> (Jaehoon Chung's message of "Mon,
	16 Jan 2012 17:49:01 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Hi,

On Mon, Jan 16 2012, Jaehoon Chung wrote:
> This patch is added the MMC_CAP2_BROKEN_VOLTAGE.
>
> if the voltage didn't satisfy between min_uV and max_uV,
> try to change the voltage in core.c.
> When change the voltage, maybe use the regulator_set_voltage().

Thanks, pushed to mmc-next for 3.3 with Adrian's ACK.  Marek, does this
work for you?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
