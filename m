From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: core: Ensure clocks are always enabled before host interaction
Date: Mon, 30 Jan 2012 13:48:43 +0100
Message-ID: <CAFEEs1=SoPvTSoBFybVLVC8ZHi8fuUNy0ZLAjXn2jYV0T5Lv3g@mail.gmail.com>
References: <1323678104-28854-1-git-send-email-sthumma@codeaurora.org>
	<CACRpkdbZS7TxKSpKR0DV4TC4dOzO_q83U1bd0HonKC2GBDBOgA@mail.gmail.com>
	<4F1E2933.8030708@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:53403 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751102Ab2A3Mso convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Jan 2012 07:48:44 -0500
Received: by obcva7 with SMTP id va7so3856190obc.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2012 04:48:43 -0800 (PST)
In-Reply-To: <4F1E2933.8030708@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Per Forlin <per.friden@stericsson.com>, linux-mmc@vger.kernel.org, cjb@laptop.org

On Tue, Jan 24, 2012 at 4:44 AM, Sujit Reddy Thumma
<sthumma@codeaurora.org> wrote:
> Hi Linus Walleij,
>
>
> On 12/30/2011 7:44 AM, Linus Walleij wrote:
>>
>> On Mon, Dec 12, 2011 at 9:21 AM, Sujit Reddy Thumma
>> <sthumma@codeaurora.org> =A0wrote:
>>
>>> Ensure clocks are always enabled before any interaction with the
>>> host controller driver. This makes sure that there is no race
>>> between host execution and the core layer turning off clocks
>>> in different context with clock gating framework.
>>>
>>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>
>>
>> I guess Per F=F6rlin may not be available, but would have preferred =
to
>> have his view on this as well, since he knows the semantics of
>> pre/post-req.
>
>
> I have checked the implementation for pre-req and post-req in mmc hos=
t
> drivers. There is no interaction to the controller or card registers =
in
> these functions, but in future if drivers appeal to configure their
> controller in these functions then we must have clocks enabled.
>
> Per, if you are available can you comment on this?
>
I just got back from 2 months of leave so I apologize for not being up =
to date.

It makes sense to ensure clocking in pre-req() and post-req()
implemented by this patch.
My only concern from a throughput point of view is if the clocking
adds an overhead, but AFAIK the clocking doesn't add an overhead (that
would increase the prepare time).

Currently the pre-req() and post-req() only prepares DMA for next
transfer without interacting with the controller. The intention is to
increase throughput by minimizing start latency for the next transfer.
It's perfectly ok to do other useful preparations in these hooks as
well. The hooks are generic. It should be possible to do clock
dependent stuff in these hooks too, it's up to the host driver to do
what's best.

Acked-by: Per Forlin <per.forlin@stericsson.com>

Thanks,
Per
