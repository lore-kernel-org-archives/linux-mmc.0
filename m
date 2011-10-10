From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
Date: Mon, 10 Oct 2011 10:23:02 +0200
Message-ID: <4E92AB66.1030406@stericsson.com>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com>	<20111001160937.GF11710@n2100.arm.linux.org.uk>	<4E8F028C.10102@stericsson.com>	<20111008091036.GF25689@n2100.arm.linux.org.uk> <CACRpkdY=DFW+J_pQetK38mPqic2iBuDWCx5QZTo-NkL1L37Fuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:33177 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752897Ab1JJIYG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Oct 2011 04:24:06 -0400
In-Reply-To: <CACRpkdY=DFW+J_pQetK38mPqic2iBuDWCx5QZTo-NkL1L37Fuw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>, Stefan NILSSON9 <stefan.xk.nilsson@stericsson.com>

Linus Walleij wrote:
> On Sat, Oct 8, 2011 at 11:10 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Oct 07, 2011 at 03:45:48PM +0200, Ulf Hansson wrote:
>>
>> Well, the patch system says that each one depends on the previous one,
>> and the first one in the series contains the PIO read thing.
>>
>> Do 7108/1 onwards depend on 7106/1 and 7107/1 ?
> 
> Probably my fault, since I was helping Ulf out with the patch tracker
> introduction.
> 
> The patches should be pretty much semantically orthogonal as
> far as I can tell, the only reason dependency was stated that way
> was that I couldn't tell from head-parsing whether there were
> syntactical dependencies. (And wanted to avoid the annoyance
> of non-applying patches...)
> 
> So if they apply, they are independent AFAICT.

7108/1 and 7109/1, have real dependencies. Otherwise there none.

BR
Ulf Hansson
