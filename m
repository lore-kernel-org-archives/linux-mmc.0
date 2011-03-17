From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] arm: mmci: Add ARM variant with extended FIFO
Date: Thu, 17 Mar 2011 10:07:18 +0000
Message-ID: <1300356438.19700.23.camel@hornet.cambridge.arm.com>
References: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
	 <AANLkTimV7eqzRNwoJ8Hoc_dvMKpsOPwW7d9TvNJ2SMR9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:54503 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751689Ab1CQKHZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 06:07:25 -0400
In-Reply-To: <AANLkTimV7eqzRNwoJ8Hoc_dvMKpsOPwW7d9TvNJ2SMR9@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> If your hardware engineers are listening, I suggest that hardware clo=
ck
> gating (as suggested in some earlier mail)

I've discussed this idea with our FPGA magician at the very beginning,
but for some reason we wasn't very happy about this... I can't really
blame him - it's not really his job to maintain individual components.
And the original cell authors are long time... em, not dead probably ;-=
)
just not available.

> plus DMA engine support will
> yet improve this by orders of magnitude and

Some of future test chips will have DMA330 (aka PL330), some won't. It'=
s
all about size, and as most of those chips are some kind of ASIC or
semi-FPGA designs, the area is scarce...

>  also bring you less errors.

One thing is not to generate the errors, second thing is to handle them
correctly. And I must agree with Russell that error handling in the MMC
stack is far from ideal.

Cheers!

Pawe=C5=82



