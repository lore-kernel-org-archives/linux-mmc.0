From: Romain Perier <romain.perier@collabora.com>
Subject: Re: [PATCH] mmc: core: Fix power sequence ordering in mmc_power_up
Date: Wed, 1 Mar 2017 11:00:12 +0100
Message-ID: <44646f74-6260-6c0e-3726-60f90fd57149@collabora.com>
References: <20170301085902.7388-1-romain.perier@collabora.com>
 <ef8580d1-989f-c9ab-abc7-034eb8cad7d0@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ef8580d1-989f-c9ab-abc7-034eb8cad7d0@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arend Van Spriel <arend.vanspriel@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,


Le 01/03/2017 =E0 10:53, Arend Van Spriel a =E9crit :
> On 1-3-2017 9:59, Romain Perier wrote:
>> Currently, mmc_power_up calls the pre_power_on callback, enables the
>> power supply of the mmc by calling mmc_set_ios() and then call
>> post_power_on. WiFi chipsets like the AP6335 require a specific power
>> sequence ordering before being used. You must enable the power supply
>> and wait until it reaches its minimum voltage, gate the clock and wait
>> at least two cycles and then assert the reset line.
> Hi Romain,
>
> You have to be more clear. What power supply, ie. vmmc or the supply for
> the wifi chipset. Without knowing much of the details to me this sounds
> like a new powerseq variant.

That's for vqmmc. vqmmc has to be power on, then the clock must be
enabled and then the reset line
must be toggled.

>
>> This commit prevents regulators to be enabled in the middle of or after
>> the power sequencing. We this fix, mmc_set_ios is first call, the
>> underlying regulators are enabled, then pre_power_on and post_power_on
>> are called, so clock and reset line are enabled in the right order,
>> after the regulator.
> It feels counter intuitive and maybe even wrong to change a setup
> pattern like this. Can you be sure this will not cause any regressions?

Well, I could keep the current pattern as it was currently working, and
propose another one for this case (as an RFC).

What do you think ?

Regards,
Romain

>
> Regards,
> Arend
>
>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
>> ---
>>  drivers/mmc/core/core.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 1076b9d..36df24f 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1798,8 +1798,6 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>>  	if (host->ios.power_mode =3D=3D MMC_POWER_ON)
>>  		return;
>>  =

>> -	mmc_pwrseq_pre_power_on(host);
>> -
>>  	host->ios.vdd =3D fls(ocr) - 1;
>>  	host->ios.power_mode =3D MMC_POWER_UP;
>>  	/* Set initial state and call mmc_set_ios */
>> @@ -1819,13 +1817,20 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>>  	 */
>>  	mmc_delay(10);
>>  =

>> -	mmc_pwrseq_post_power_on(host);
>> -
>>  	host->ios.clock =3D host->f_init;
>>  =

>>  	host->ios.power_mode =3D MMC_POWER_ON;
>>  	mmc_set_ios(host);
>>  =

>> +	mmc_pwrseq_pre_power_on(host);
>> +
>> +	/*
>> +	 * This delay should be sufficient to wait at least two cycles of clock
>> +	 * gated by pre_power_on
>> +	 */
>> +	mmc_delay(1);
>> +	mmc_pwrseq_post_power_on(host);
>> +
>>  	/*
>>  	 * This delay must be at least 74 clock sizes, or 1 ms, or the
>>  	 * time required to reach a stable voltage.
>>
