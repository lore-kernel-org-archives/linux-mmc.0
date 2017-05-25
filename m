From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] mmc: host: fix potential null pointer dereference
Date: Thu, 25 May 2017 11:46:38 -0500
Message-ID: <20170525114638.Horde.wq7PLKWCg8CwLM5WiWj1Obm@gator4166.hostgator.com>
References: <20170523234227.GA13018@embeddedgus>
 <746018130.108142.1495703528403@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <746018130.108142.1495703528403@email.1und1.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Stefan,

Quoting Stefan Wahren <stefan.wahren@i2se.com>:

> Hi Gustavo,
>
>> "Gustavo A. R. Silva" <garsilva@embeddedor.com> hat am 24. Mai 2017  
>> um 01:42 geschrieben:
>>
>>
>> Null check at line 1165: if (mrq->cmd), implies that mrq->cmd might
>> be NULL.
>> Add null checks before dereferencing pointer mrq->cmd in order to avoid
>> any potential NULL pointer dereference.
>>
>> Addresses-Coverity-ID: 1408740
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
>
> with a Raspberry Pi Zero.
>
> But please change the subject to make sure it's bcm2835 related:
>
> mmc: bcm2835: fix potential null pointer dereferences
>

OK, I'll send v2 shortly.

Thank you
--
Gustavo A. R. Silva
