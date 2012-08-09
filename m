From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH RESEND v5 0/4] atmel-mci device tree support
Date: Thu, 9 Aug 2012 08:32:04 +0200
Message-ID: <50235964.2080409@atmel.com>
References: <1343136606-8874-1-git-send-email-ludovic.desroches@atmel.com>
 <87hasexegg.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87hasexegg.fsf@octavius.laptop.org>
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

Le 08/08/2012 05:14 AM, Chris Ball a =E9crit :
> Hi,
>
> On Tue, Jul 24 2012, ludovic.desroches@atmel.com wrote:
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> Hello,
>>
>> I resend this set of patches because patches 2, 3 and 4 were acked by
>> Jean-Christophe. Patch 1 was also acked by Jean-Christophe excepted for
>> cd-inverted property since it was redundant with gpio bindings.
>
> In future, it's helpful for me if you can add the Acked-by lines you
> receive into the patches when you resend them.  Thanks!
>

Ok.

>> I thought we were agree to go ahead since it was a common binding already
>> documented and it will concern all drivers.
>
> Agreed.  It's a documented core MMC binding, it's fine to use it.
>
>> Chris are you agree to take patch 1/4? Others patches may go to at91 tre=
e,
>> isn't it?
>
> Yes, let's do that.  I've applied patch 1/4 to mmc-next for 3.7, and you
> can send the others via the at91 tree with the ACK that Arnd gave.

Thanks Chris.

Ludovic

>
> Thanks,
>
> - Chris.
>
