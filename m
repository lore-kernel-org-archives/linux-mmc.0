From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] mmc: host: pxamci: switch over to dmaengine use
Date: Mon, 08 Jun 2015 19:14:47 +0200
Message-ID: <87bngq3ywo.fsf@belgarion.home>
References: <1433625322-28449-1-git-send-email-robert.jarzmik@free.fr>
	<CAPDyKFpWaRdwHAFAjmnWXC5=H989uANafd_HtFmSJLVgTvAiKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:41327 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbbFHRQ3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2015 13:16:29 -0400
In-Reply-To: <CAPDyKFpWaRdwHAFAjmnWXC5=H989uANafd_HtFmSJLVgTvAiKQ@mail.gmail.com>
	(Ulf Hansson's message of "Mon, 8 Jun 2015 10:17:38 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Mack <zonque@gmail.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 6 June 2015 at 23:15, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> +#include <linux/dma/pxa-dma.h>
>
> I can't find this header file in my tree, but apparantly it's in
> linux-next. Probably it went through Vinod's dma tree, right?
Right.

> Anyway, I can pick it up for the next-next release cycle or you may
> ask Vinod to pick it up right now. Please tell me what you prefer.
> Here's my ack.
I'd rather have it through your tree, next-next is perfectly fine by me.

Thanks.

--
Robert
