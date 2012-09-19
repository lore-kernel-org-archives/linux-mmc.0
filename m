From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2 2/2] mmc: atmel-mci: AP700x PDC is not connected to MCI
Date: Wed, 19 Sep 2012 08:59:14 +0200
Message-ID: <50596D42.3070709@atmel.com>
References: <503F9613.5060007@yahoo.es> <m3d31ik2p0.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <m3d31ik2p0.fsf@pullcord.laptop.org>
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
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Havard Skinnemoen <havard@skinnemoen.net>, Hein Tibosch <hein_tibosch@yahoo.es>, "ludovic.desroches" <ludovic.desroches@atmel.com>, linux-arm-kernel@lists.infradead.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Le 09/19/2012 07:21 AM, Chris Ball a =E9crit :
> Hi,
>
> On Thu, Aug 30 2012, Hein Tibosch wrote:
>> Earlier, atmel-mci was adapted to make use of the peripheral DMA
>> controller (PDC), in case normal DMA wouldn't work.
>> ( http://comments.gmane.org/gmane.linux.kernel.mmc/9403 )
>> This works OK on ARM platforms (AT91), but it broke the driver
>> for AVR32, the AP700x.
>> Although the MCI has PDC support, the connection is not done for
>> AVR chips
>>
>> This patch makes the use of PDC depend on CONFIG_AVR32
>>
>> Signed-off-by: Hein Tibosch <hein_tibosch@yahoo.es>
>>
>> ---
>>   drivers/mmc/host/atmel-mci-regs.h |    7 +++++++
>>   drivers/mmc/host/atmel-mci.c      |    2 +-
>>   2 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-=
mci-regs.h
>> index ab56f7d..c97001e 100644
>> --- a/drivers/mmc/host/atmel-mci-regs.h
>> +++ b/drivers/mmc/host/atmel-mci-regs.h
>> @@ -140,6 +140,13 @@
>>   #define atmci_writel(port,reg,value)			\
>>   	__raw_writel((value), (port)->regs + reg)
>>
>> +/* On AVR chips the Peripheral DMA Controller is not connected to MCI. =
*/
>> +#ifdef CONFIG_AVR32
>> +#	define ATMCI_PDC_CONNECTED	0
>> +#else
>> +#	define ATMCI_PDC_CONNECTED	1
>> +#endif
>> +
>>   /*
>>    * Fix sconfig's burst size according to atmel MCI. We need to convert=
 them as:
>>    * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
>> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
>> index a6a5593..b8de891 100644
>> --- a/drivers/mmc/host/atmel-mci.c
>> +++ b/drivers/mmc/host/atmel-mci.c
>> @@ -2208,7 +2208,7 @@ static void __init atmci_get_cap(struct atmel_mci =
*host)
>>   			"version: 0x%x\n", version);
>>
>>   	host->caps.has_dma_conf_reg =3D 0;
>> -	host->caps.has_pdc =3D 1;
>> +	host->caps.has_pdc =3D ATMCI_PDC_CONNECTED;
>>   	host->caps.has_cfg_reg =3D 0;
>>   	host->caps.has_cstor_reg =3D 0;
>>   	host->caps.has_highspeed =3D 0;
>
> Thanks, pushed to mmc-next for 3.7.
>
> I changed the commit message text to reflect my understanding of what
> the patch does better, from:
>    This patch makes the use of PDC depend on CONFIG_AVR32.
> to:
>    This patch makes the use of PDC depend on !CONFIG_AVR32.
>

You're right.

> (Ludovic, perhaps you could give an ACK for this patch?)
>

It was given for the first version but not reported in the second =

version. So yes you can add

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>


Thanks

Ludovic

> - Chris.
>
