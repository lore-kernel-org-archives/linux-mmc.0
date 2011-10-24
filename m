From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: core: Assemble the codes of related to eMMC4.5
Date: Mon, 24 Oct 2011 17:02:51 +0530
Message-ID: <CAGxe1ZGer3KyWtGKwAsKfcfOA87McG5tfeEn=V-E=oUbtRFJdg@mail.gmail.com>
References: <001b01cc9238$156a65a0$403f30e0$%jun@samsung.com>
	<m2obx64pes.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <m2obx64pes.fsf@bob.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

On 24 October 2011 16:39, Chris Ball <cjb@laptop.org> wrote:
> Hi Seungwon,
>
> On Mon, Oct 24 2011, Seungwon Jeon wrote:
>> Code cleanup. The codes of related to eMMC4.5 are scattered.
>> This patch removes a duplicate if-statement and assembles all.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>> =A0drivers/mmc/core/mmc.c | =A0 20 +++++++++-----------
>> =A01 files changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index fb5bf01..3627044 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -467,29 +467,27 @@ static int mmc_read_ext_csd(struct mmc_card *c=
ard, u8 *ext_csd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rst_n_function =3D ext_csd=
[EXT_CSD_RST_N_FUNCTION];
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 /* eMMC v4.5 or later */
>> - =A0 =A0 if (card->ext_csd.rev >=3D 6)
>> - =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.feature_support |=3D MMC_DIS=
CARD_FEATURE;
>> -
>> =A0 =A0 =A0 card->ext_csd.raw_erased_mem_count =3D ext_csd[EXT_CSD_E=
RASED_MEM_CONT];
>> =A0 =A0 =A0 if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0xFF;
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0x0;
>>
>> + =A0 =A0 /* eMMC v4.5 or later */
>> =A0 =A0 =A0 if (card->ext_csd.rev >=3D 6) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.feature_support |=3D MMC_DIS=
CARD_FEATURE;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.generic_cmd6_time =3D 10 *
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_GENERIC_=
CMD6_TIME];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.power_off_longtime =3D 10 =
*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_POWER_OF=
=46_LONG_TIME];
>> - =A0 =A0 } else
>> - =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.generic_cmd6_time =3D 0;
>
> Your patch removes this line completely. =A0Why is that? =A0You shoul=
d
> explain it in the commit message.
By tracing the code what i understand is  mmc_read_ext_csd is called
from mmc_card_init. In the init function the card instance is created.
When the card instance is created kzalloc is used. This will
initialize all the card structure members to 0.
So the deleted line is implicit.
>
>>
>> - =A0 =A0 card->ext_csd.cache_size =3D
>> - =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_CACHE_SIZE + 0] << 0 |
>> - =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_CACHE_SIZE + 1] << 8 |
>> - =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_CACHE_SIZE + 2] << 16 |
>> - =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_CACHE_SIZE + 3] << 24;
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.cache_size =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_CACHE_SIZE=
 + 0] << 0 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_CACHE_SIZE=
 + 1] << 8 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_CACHE_SIZE=
 + 2] << 16 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_CACHE_SIZE=
 + 3] << 24;
>> + =A0 =A0 }
>>
>> =A0out:
>> =A0 =A0 =A0 return err;
>
> The rest looks good, thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
