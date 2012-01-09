From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 10/14] mmc: mmci: Cache MMCICLOCK and MMCIPOWER register
Date: Mon, 9 Jan 2012 12:46:09 +0100
Message-ID: <4F0AD381.9020105@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com> <1323106560-5218-11-git-send-email-ulf.hansson@stericsson.com> <20120108102533.GA21765@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:38105 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754188Ab2AILqv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2012 06:46:51 -0500
In-Reply-To: <20120108102533.GA21765@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

Russell King - ARM Linux wrote:
> On Mon, Dec 05, 2011 at 06:35:56PM +0100, Ulf Hansson wrote:
>> Instead of reading a register value everytime we need to
>> apply a new value for it, maintain a cached copy for it.
>> This also means we are able to skip writes that are not
>> needed.
> 
> I'm not sure this is a good idea.  The ARM Primecells require a certain
> number of bus clocks and MCLK periods between writes to both these
> registers, and reading them back helps to ensure that we conform to
> that requirement.  Maintaining a cached copy of them allows faster
> writes to these registers which could cause that requirement to be
> violated.

You are definitely right. But how do we know that reading the register 
value is enough?

> 
> What you could do is read the register, modify, and check whether the
> modification has had any effect before writing it back.  That will
> allow unnecessary writes to still be skipped.
> 

That could work. Do you want me to fixup the patch to include this "read 
before write" mechanism then?

BR
Ulf Hansson
