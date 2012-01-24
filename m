From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: core: Ensure clocks are always enabled before host
 interaction
Date: Tue, 24 Jan 2012 09:14:51 +0530
Message-ID: <4F1E2933.8030708@codeaurora.org>
References: <1323678104-28854-1-git-send-email-sthumma@codeaurora.org> <CACRpkdbZS7TxKSpKR0DV4TC4dOzO_q83U1bd0HonKC2GBDBOgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:11628 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab2AXDoz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2012 22:44:55 -0500
In-Reply-To: <CACRpkdbZS7TxKSpKR0DV4TC4dOzO_q83U1bd0HonKC2GBDBOgA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Per Forlin <per.friden@stericsson.com>, linux-mmc@vger.kernel.org, cjb@laptop.org

Hi Linus Walleij,

On 12/30/2011 7:44 AM, Linus Walleij wrote:
> On Mon, Dec 12, 2011 at 9:21 AM, Sujit Reddy Thumma
> <sthumma@codeaurora.org>  wrote:
>
>> Ensure clocks are always enabled before any interaction with the
>> host controller driver. This makes sure that there is no race
>> between host execution and the core layer turning off clocks
>> in different context with clock gating framework.
>>
>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>
> I guess Per F=F6rlin may not be available, but would have preferred t=
o
> have his view on this as well, since he knows the semantics of
> pre/post-req.

I have checked the implementation for pre-req and post-req in mmc host=20
drivers. There is no interaction to the controller or card registers in=
=20
these functions, but in future if drivers appeal to configure their=20
controller in these functions then we must have clocks enabled.

Per, if you are available can you comment on this?

>
> However from my PoV it looks nice and clean, and you surely have
> done some serious testing on things like SDIO so:
> Acked-by: Linus Walleij<linus.walleij@linaro.org>

Thanks. Tested with SD3.0, eMMC4.4 and SDIO2.0 cards.


Thanks,
Sujit
