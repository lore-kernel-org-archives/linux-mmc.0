From: =?UTF-8?B?TWljaGFsIMWgbXVjcg==?= <msmucr@gmail.com>
Subject: Re: [RT PATCH] mmc: sdhci: don't provide hard irq handler
Date: Fri, 27 Feb 2015 10:33:15 +0100
Message-ID: <54F039DB.6020008@gmail.com>
References: <54EC487F.8020109@gmail.com> <20150226112925.GC12992@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:41535 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbbB0JdO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 04:33:14 -0500
In-Reply-To: <20150226112925.GC12992@linutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

On 26.2.2015 12:29, Sebastian Andrzej Siewior wrote:
> the sdhci code provides both irq handlers: the primary and the thread
> handler. Initially it was meant for the primary handler to be very
> short.
> The result is not that on -RT we have the primrary handler grabing lo=
cks
> and this isn't really working. As a hack for now I just push both
> handler into the threaded mode.
>
> Reported-By: Michal =C5=A0mucr <msmucr@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> The "same thing" was reported against the iwlwifi driver
> (request_threaded_irq(=E2=80=A6, iwl_pcie_isr, iwl_pcie_irq_handler, =
=E2=80=A6) and they
> managed to rework it and not do anything that would break -RT in thei=
r
> primary handler. Besides sdhci there are a few others drivers in the
> same tree doing similar things.
> I'm not sure what to do here in general. Motivating upstream maintain=
er
> to rework their code or introducing IRQF_RT_SAFE and for others doing
> the conversation like in the patch below.
>
> Michal: This is untested but should fix the issue, reported.
>

Sebastian,

thank you very much for the patch and explanation of what's going on. I=
t=20
is very handy to know for possible similar issues with other modules.=20
The trick with forced threaded handlers seems to be working well and I=20
haven't been able to crash it again during all of my tests.

Michal


