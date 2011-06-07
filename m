From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v2 0/2] sdio: add quirk for spurious SDIO IRQ
Date: Tue, 7 Jun 2011 08:41:20 +0200
Message-ID: <BANLkTimnZ=SDbrNiHL8+pHjjbQ-UrzCYpQ@mail.gmail.com>
References: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
	<alpine.LFD.2.00.1106011157000.30544@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:51121 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab1FGGlV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 02:41:21 -0400
Received: by qyg14 with SMTP id 14so2329576qyg.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2011 23:41:20 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1106011157000.30544@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Per Forlin <per.forlin@stericsson.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Daniel Drake <dsd@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>

On 1 June 2011 17:59, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 1 Jun 2011, Per Forlin wrote:
>
>> From: Per Forlin <per.forlin@linaro.org>
>>
>> Daniel Drake reported an issue in the libertas sdio client that was
>> triggered by the sdio_single_irq functionality. His SDIO device seems to
>> raise an interrupt even though there are no bits set in the CCCR_INTx
>> register. This behaviour is not supported by the sdio_single_irq feature nor
>> the SDIO spec. The purpose of the sdio_single_irq feature is to avoid the
>> overhead of checking the CCCR_INTx registers, this result in no error
>> handling of the case if there is a pending IRQ with none CCCR_INTx bits set.
>>
>> This patchset adds a quirk to support this spurious IRQ issue and also report
>> a warning if an SDIO interrupt is raised but none CCCR_INTx bits are set.
>
> Given that the issue can be fixed locally to the libertas driver, I'd
> suggest not merging this series until truly unfixable issues come up, as
> Daniel said.
>
I agree too.

Thanks,
Per
