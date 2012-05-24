From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 1/3] mmc: atmel-mci: add device tree support
Date: Thu, 24 May 2012 10:40:07 -0400
Message-ID: <878vghfxrs.fsf@laptop.org>
References: <1337681352-18521-2-git-send-email-ludovic.desroches@atmel.com>
	<1337757830-19361-1-git-send-email-ludovic.desroches@atmel.com>
	<20120524094304.GH3377@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53831 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932287Ab2EXOkR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 May 2012 10:40:17 -0400
In-Reply-To: <20120524094304.GH3377@game.jcrosoft.org> (Jean-Christophe
	PLAGNIOL-VILLARD's message of "Thu, 24 May 2012 11:43:04 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, devicetree-discuss@lists.ozlabs.org

Hi,

On Thu, May 24 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> +
>> +		pdata->slot[slot_id].detect_is_active_high =
>> +			of_property_read_bool(cnp, "cd-inverted");
> 
> I really this this is redondant with gpio binding
>
> Chris??

Hm, I think go ahead and add it for now -- I agree it's redundant, but
we should go through and remove the redundancy from all drivers (and the
binding document, which is in 3.5-rc1 now) at once later.  Since it's in
the bindings doc, best to implement it until that changes.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
