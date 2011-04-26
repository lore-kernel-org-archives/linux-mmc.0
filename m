From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH v2 01/12] mmc: add none blocking mmc request function
Date: Tue, 26 Apr 2011 14:29:03 +0100
Message-ID: <4DB6C89F.10903@csr.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>	<1302116833-24540-2-git-send-email-per.forlin@linaro.org>	<4DA81F42.3070208@csr.com> <BANLkTimaTe0qD5sbEJj88YRv2DZv=1oxTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:36605 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab1DZNaa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 09:30:30 -0400
In-Reply-To: <BANLkTimaTe0qD5sbEJj88YRv2DZv=1oxTQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>

On 20/04/11 08:17, Per Forlin wrote:
> 
>> Using a MMC request queue has other benefits -- it allows multiple users
>> without having to claim/release the host.  This would be useful for
>> (especially multi-function) SDIO.
>
> You mean claim and release would be done only within the mmc core. The
> timed saved here would equal the time it takes to release and claim
> the host.
> Claim and release can also be used for power management to indicate if
> any client is using the host, if not the power can be switched off.

Isn't there a separate runtime power management API that different from
claim/release?

> I just want to make sure I understand the multi-function SDIO case, I
> haven't done any work with SDIO.
> Can the SDIO functions compete over the same claim_host at the same time?
> Example: if function 1 claims the host, function 2 and function 3 also
> want to claim the host but have to wait for function 1 to release the
> host.

This is the case.   Each function driver has to claim exclusive access
to the host.

> What is the extra benefit of having the internal request queue for
> multi function SDIO?

It reduces the delays between commands if multiple drivers are sending
commands.  I estimated performance improvements with 2-3% from just
removing the need to claim/release in one particular SDIO function
driver.  Performance improvements for multi-function cards would be a
bit more (5% perhaps?).

The more important benefit is the simplification of the API.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
