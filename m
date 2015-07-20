From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] mmc: host: pxamci: switch over to dmaengine use
Date: Mon, 20 Jul 2015 21:22:05 +0200
Message-ID: <871tg2hbxe.fsf@belgarion.home>
References: <1433625322-28449-1-git-send-email-robert.jarzmik@free.fr>
	<CAPDyKFpm5Vf=vzVFyhrmjZ61FE-JbMm=+xhF=6AMX96cKF5BXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpm5Vf=vzVFyhrmjZ61FE-JbMm=+xhF=6AMX96cKF5BXg@mail.gmail.com>
	(Ulf Hansson's message of "Mon, 20 Jul 2015 13:19:22 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Mack <zonque@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 6 June 2015 at 23:15, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> From: Daniel Mack <zonque@gmail.com>
>>
>> Switch over pxamci to dmaengine. This prepares the devicetree full
>> support of pxamci.
>>
>> This was successfully tested on a PXA3xx board, as well as PXA27x.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> [adapted to pxa-dma]
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Thanks, applied!
Great, thanks Ulf.

Cheers.

--
Robert
