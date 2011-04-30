From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: Conditionalize regulator_get() on CONFIG_REGULATOR
Date: Sat, 30 Apr 2011 12:03:01 -0400
Message-ID: <m3mxj720cq.fsf@pullcord.laptop.org>
References: <m3r58k1hlc.fsf@pullcord.laptop.org> <4DBC2586.1080201@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46991 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778Ab1D3P7m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 30 Apr 2011 11:59:42 -0400
In-Reply-To: <4DBC2586.1080201@metafoo.de> (Lars-Peter Clausen's message of
	"Sat, 30 Apr 2011 17:06:46 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

Hi Lars,

On Sat, Apr 30 2011, Lars-Peter Clausen wrote:
> On 04/30/2011 06:35 AM, Chris Ball wrote:
>> The regulator subsystem provides stubbed out versions of its calls that
>> are always present (so that they can be used without needing #ifdefs).
>> But the regulator_get() stub always returns an error value according
>> to IS_ERR(), which leads sdhci to print messages like "mmc0: no vmmc
>> regulator found" on every boot, even if CONFIG_REGULATOR is not set.
>> 
>> This patch fixes that (and removes the unwanted message) by having
>> the regulator_get() call occur inside an #ifdef CONFIG_REGULATOR.
>
> Shouldn't the stubbed version of regulator_get return NULL, which is not
> treated as an error by IS_ERR?

Oops, thanks -- you're right, of course.  I withdraw the patch.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
