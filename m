From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] of_mmc_spi: fix little endian support
Date: Mon, 30 Jan 2012 10:30:42 -0500
Message-ID: <m239axcin1.fsf@bob.laptop.org>
References: <1327896929-16274-1-git-send-email-plagnioj@jcrosoft.com>
	<20120130131430.GA28397@ponder.secretlab.ca>
	<CACxGe6vY5Es4S_2Q1KWVyHitOuee8XekarGBuxjuJNDbAQrtHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53600 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864Ab2A3PbA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Jan 2012 10:31:00 -0500
In-Reply-To: <CACxGe6vY5Es4S_2Q1KWVyHitOuee8XekarGBuxjuJNDbAQrtHA@mail.gmail.com>
	(Grant Likely's message of "Mon, 30 Jan 2012 08:18:08 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi,

On Mon, Jan 30 2012, Grant Likely wrote:
> On Mon, Jan 30, 2012 at 6:14 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Mon, Jan 30, 2012 at 05:15:29AM +0100, Jean-Christophe
>> PLAGNIOL-VILLARD wrote:
>>> the voltage_ranges is supposed to switch from big endian to little endian
>>>
>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> Cc: Grant Likely <grant.likely@secretlab.ca>
>>> Cc: linux-mmc@vger.kernel.org
>>
>> Applied, thanks.
>
> Actually, this one should go via Chris' tree since it is part of
> drivers/mmc.  So I've dropped it from my tree and change that s-o-b of
> mine to an a-b.

Thanks, done that, and removed the extra/incorrect punctuation change
from the patch.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
