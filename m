From: boris brezillon <b.brezillon@overkiz.com>
Subject: Re: [PATCH v4 2/5] mmc: atmel-mci: prepare clk before calling enable
Date: Sun, 25 Aug 2013 07:35:18 +0200
Message-ID: <52199796.4080800@overkiz.com>
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com> <1374133132-17556-1-git-send-email-b.brezillon@overkiz.com> <87li3qsbk9.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87li3qsbk9.fsf@octavius.laptop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Chris,

On 25/08/2013 05:18, Chris Ball wrote:
> Hi,
>
> On Thu, Jul 18 2013, Boris BREZILLON wrote:
>> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
>> avoid common clk framework warnings.
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Okay, pushed to mmc-next for 3.12.

Thanks.

>
> Boris, you got feedback from Thomas Petazzoni and Russell King, but
> you didn't CC either of them on the patch v4

I didn't knew I had to add the reviewers of a patch in the cc list
of the future versions. I'll do it next time.

> , and you didn't write a
> changelog explaining the differences between patches v3 and v4 --
> please do both of those next time.

The changelog is in the cover letter ("Changes since v3").
But I didn't send you this cover letter.

> Also, it looks like the Ack from Ludovic happened away from the MMC
> list, since I don't see a message from Ludovic on the thread here.
> It would be better if the Ack happened somewhere I can see it.

The 'Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>' was added
in the 2nd version of this patch series.
But I don't know if I should have kept it in this version since this 
patch has evolved.


Thanks for these feebacks, I'm still learning the good practices of the 
kernel
submission process.
I'll check these points next time.

Best Regards,

Boris
> Thanks,
>
> - Chris.
