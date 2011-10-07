From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
Date: Fri, 7 Oct 2011 15:45:48 +0200
Message-ID: <4E8F028C.10102@stericsson.com>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com> <20111001160937.GF11710@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:60285 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760028Ab1JGNqJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2011 09:46:09 -0400
In-Reply-To: <20111001160937.GF11710@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>, Stefan NILSSON9 <stefan.xk.nilsson@stericsson.com>

Russell King - ARM Linux wrote:
> On Tue, Sep 27, 2011 at 09:46:08AM +0200, Ulf Hansson wrote:
>> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>>
>> Corrects a bug in pio read when reading packets < 4 bytes. These
>> small packets are only relevant for SDIO transfers.
> 
> Does this even work?  From the MMCI spec, I see no way for the MMCI
> peripheral to know the size of the read/write on the APB bus.
> 

Hi Russel,

My feeling is that since discussing this patch, the rest of the patches 
in this serie and are kind of "put on hold". The reason for keeping them 
together is more of functional purpose. I hope you can have a look at 
them anyway, they shall be possible to apply without this one.

If you prefer we can split up this patchserie...

BR
Ulf Hansson
