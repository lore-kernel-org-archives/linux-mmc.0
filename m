From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 2/2] mmc: at91-mci: this driver is now deprecated
Date: Thu, 17 May 2012 20:28:54 +0200
Message-ID: <4FB54366.80409@atmel.com>
References: <1337183519-25459-1-git-send-email-ludovic.desroches@atmel.com>
 <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
 <87k40b3ris.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87k40b3ris.fsf@laptop.org>
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

Hi Chris,

Le 05/17/2012 02:45 PM, Chris Ball a =E9crit :
> Hi,
>
> On Wed, May 16 2012, ludovic.desroches@atmel.com wrote:
>> From: Ludovic Desroches<ludovic.desroches@atmel.com>
>>
>> at91-mci is deprecated since atmel-mci can deal with all chips.
>>
>> Signed-off-by: Ludovic Desroches<ludovic.desroches@atmel.com>
>> ---
>>   Documentation/feature-removal-schedule.txt |   11 +++++++++++
>>   drivers/mmc/host/Kconfig                   |    7 +++++--
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/=
feature-removal-schedule.txt
>> index 03ca210..8b4aef2 100644
>> --- a/Documentation/feature-removal-schedule.txt
>> +++ b/Documentation/feature-removal-schedule.txt
>> @@ -539,3 +539,14 @@ When:	3.6
>>   Why:	setitimer is not returning -EFAULT if user pointer is NULL. This
>>   	violates the spec.
>>   Who:	Sasikantha Babu<sasikanth.v19@gmail.com>
>> +
>> +----------------------------
>> +
>> +What:	at91-mci driver ("CONFIG_MMC_AT91")
>> +When:	3.7
>> +Why:	There two mci drivers: at91-mci and atmel-mci. The PDC support was
>               ^ are
>
>> +	added to atmel-mci as a first step to support more chips. Then
>> +	at91-mci was kept only for old IP versions (on at91rm9200 and
>> +	at91sam9261). The support of these IP versions has just been added
>> +	so atmel-mci can be used for all chips.
>> +Who:	Ludovic Desroches<ludovic.desroches@atmel.com>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 2bc06e7..f150591 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -278,10 +278,13 @@ choice
>>   	  Choose which driver to use for the Atmel MCI Silicon
>>
>>   config MMC_AT91
>> -	tristate "AT91 SD/MMC Card Interface support"
>> +	tristate "AT91 SD/MMC Card Interface support (DEPRECATED)"
>>   	depends on ARCH_AT91
>>   	help
>> -	  This selects the AT91 MCI controller.
>> +	  This selects the AT91 MCI controller. This driver will be
>> +	  remove soon (for more information have a look to
>            ^ removed
>> +	  Documentation/feature-removal-schedule.txt). Please use
>> +	  MMC_ATMEL_MCI.
>>
>>   	  If unsure, say N.

Sorry for the typo, do you want a new patch or is ok?

>
> Seems like I should take this patch 2/2, and then someone else should
> merge 1/2?

Yes, Nicolas would probably take patch 2/2.

Regards

Ludovic
