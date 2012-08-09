From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: not busy flag has also to be used for
 read operations
Date: Thu, 9 Aug 2012 08:29:15 +0200
Message-ID: <502358BB.8010801@atmel.com>
References: <1343122924-7799-1-git-send-email-ludovic.desroches@atmel.com>
 <87lihqxev6.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87lihqxev6.fsf@octavius.laptop.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Le 08/08/2012 05:05 AM, Chris Ball a =E9crit :
> Hi,
>
> On Tue, Jul 24 2012, ludovic.desroches@atmel.com wrote:
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> Even if the datasheet says that the not busy flag has to be used only for
>> write operations, it's false excepted for version lesser than v2xx.
>> Not waiting the not busy flag for read operations can cause the controll=
er to
>> hang-up during the initialization of some SD cards.
>>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> Cc: stable@vger.kernel.org
>>
>>
>> Hello,
>>
>> This is a fix for 3.5 and later.
>>
>> Due to the big changes into atmel-mci driver to support all atmel mci ve=
rsions,
>> a bug was introduced.
>> With some SD cards (mainly micro) when using DMA, the controller hangs-u=
p after
>> the first CMD6 command because the next command is sent too early.
>>
>> Regards
>>
>> Ludovic
>>
>>
>> ---
>>   drivers/mmc/host/atmel-mci.c |    6 +++++-
>>   1 files changed, 5 insertions(+), 1 deletions(-)
>
> Thanks.  I've applied this for mmc-next now, but please put your patch
> commentary *underneath* the "---" lines, so that it doesn't end up in
> the git history itself.  I've rewritten the commit message to be:

Sorry for this error.

Thanks

Ludovic

>
>
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Even if the datasheet says that the not busy flag has to be used only
> for write operations, it's false except for version lesser than v2xx.
>
> Not waiting on the not busy flag for read operations can cause the
> controller to hang-up during the initialization of some SD cards
> with DMA after the first CMD6 -- the next command is sent too early.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: stable <stable@vger.kernel.org> [3.5, 3.6]
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
> <patch commentary can go here>
>
>   drivers/mmc/host/atmel-mci.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
