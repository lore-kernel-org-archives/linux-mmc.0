From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V2] mmc: core: eMMC4.5 Add the timeout for switch
Date: Thu, 1 Sep 2011 11:58:16 +0530
Message-ID: <CAGxe1ZE--PoWiLmJstoyxJ+SpLdH9KzY3zPtC=PDEjdsg6Ot6g@mail.gmail.com>
References: <1314854861-2430-1-git-send-email-girish.shivananjappa@linaro.org>
	<001901cc686f$4be243c0$e3a6cb40$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001901cc686f$4be243c0$e3a6cb40$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Mr Jeon,
                      In case if the timeout is specified by the
calling function, the code in this patch will not be executed. But if
some command other than the three are called with 0, then this code
will make sure that atleast the default value is used to timeout.

regards
Girish K S

On 1 September 2011 11:50, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Hi Girish,
>
> Girish K S wrote:
>>
>> V2- The datatype of the cmd6_timeout is changed from u8 to unsigned =
int,
>> as it can hold a value upto 255*10=3D2550.
>> =A0 =A0 =A0 This patch adds the code to handle the default timeout
>> for switch command.
>> For eMMC 4.5 devices if timeout is not specified for the switch
>> command while accessing a specific field,then the default timeout
>> shall be used to timeout. Specification says there is no timeout
>> defined while accessing BKOPS_START, SANITIZE_START, FLUSH_CACHE
>> field(so these fields are excluded).
>>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> ---
>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 =A05 +++++
>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A08 ++++++++
>> =A0include/linux/mmc/card.h =A0 | =A0 =A01 +
>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 =A04 ++++
>> =A04 files changed, 18 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 5700b1c..5b9fb6a 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -405,6 +405,11 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd, u8
>> *ext_csd)
>> =A0 =A0 =A0 if (card->ext_csd.rev >=3D 5)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rel_param =3D ext_csd[EXT_=
CSD_WR_REL_PARAM];
>>
>> + =A0 =A0 if (card->ext_csd.rev > 5) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* (eMMC 4.5)timeout is expressed in units=
 of 10 ms*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.cmd6_timeout =3D ext_csd[EXT=
_CSD_CMD6_TIME]*10;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0xFF;
>> =A0 =A0 =A0 else
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 770c3d0..c4d82f4 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -394,6 +394,14 @@ int mmc_switch(struct mmc_card *card, u8 set, u=
8
>> index, u8 value,
>> =A0 =A0 =A0 cmd.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC=
;
>> =A0 =A0 =A0 cmd.cmd_timeout_ms =3D timeout_ms;
>>
>> + =A0 =A0 /* timeout is not defined for below command indexes (eMMC =
4.5) */
>> + =A0 =A0 if ((timeout_ms =3D=3D 0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd->rev > 5) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (index !=3D EXT_CSD_BKOPS_START) =A0 =A0 =A0=
 =A0 =A0&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (index !=3D EXT_CSD_SANITIZE_START) =A0 =A0=
 =A0 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (index !=3D EXT_CSD_FLUSH_CACHE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.cmd_timeout_ms =3D car=
d->ext_csd->cmd6_timeout;
>> +
> mmc_switch doesn't need to take over '0' value for timeout_ms except =
for undefined timeout(Background operation, sanitize, etc)
> It is possible and good to pass the argument of specific timeout_ms(i=
ncluding default cmd6 timeout) explicitly rather than '0',
> if timeout value for cmd6 is defined.
> Then, mmc_switch maybe doesn't need to handle timeout for some except=
ion case.
>
>> =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRI=
ES);
>> =A0 =A0 =A0 if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index b460fc2..ef88412 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -50,6 +50,7 @@ struct mmc_ext_csd {
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rel_sector=
s;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rel_param;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0part_confi=
g;
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0cmd6_timeout; =A0 /* t=
imeout in ms */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0part_time; =A0 =A0 =A0=
 =A0 =A0 =A0 =A0/* Units: ms */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0 =A0 =
=A0 =A0 =A0 =A0 /* Units: 100ns */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 5a794cb..a23f836 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -270,8 +270,11 @@ struct _mmc_csd {
>> =A0 * EXT_CSD fields
>> =A0 */
>>
>> +#define EXT_CSD_FLUSH_CACHE =A0 =A0 =A0 =A0 =A032 =A0 =A0 =A0/* R/W=
 */
>> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0156 =A0 =A0 /* R/W */
>> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0160 =A0 =A0 /* RO */
>> +#define EXT_CSD_BKOPS_START =A0 =A0 =A0 =A0 =A0164 =A0 =A0 /* R/W *=
/
>> +#define EXT_CSD_SANITIZE_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 165 =A0 =
=A0 /* R/W */
>> =A0#define EXT_CSD_WR_REL_PARAM =A0 =A0 =A0 =A0 166 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_ERASE_GROUP_DEF =A0 =A0 =A0 =A0 =A0 =A0 =A0175 =A0=
 =A0 /* R/W */
>> =A0#define EXT_CSD_PART_CONFIG =A0 =A0 =A0 =A0 =A0179 =A0 =A0 /* R/W=
 */
>> @@ -293,6 +296,7 @@ struct _mmc_csd {
>> =A0#define EXT_CSD_SEC_ERASE_MULT =A0 =A0 =A0 =A0 =A0 =A0 =A0 230 =A0=
 =A0 /* RO */
>> =A0#define EXT_CSD_SEC_FEATURE_SUPPORT =A0231 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_TRIM_MULT =A0 =A0 =A0 =A0 =A0 =A0232 =A0 =A0 /* R=
O */
>> +#define EXT_CSD_CMD6_TIME =A0 =A0 =A0 =A0 =A0 =A0248 =A0 =A0 /* RO =
*/
>>
>> =A0/*
>> =A0 * EXT_CSD field definitions
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
