From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: core: eMMC4.5 Add the timeout for switch
Date: Thu, 1 Sep 2011 10:45:43 +0530
Message-ID: <CAGxe1ZFVbhEL1_Ozw049u+HF06jyDfkp5-ZxEX22kkkAJJAEhA@mail.gmail.com>
References: <1314699770-17120-1-git-send-email-girish.shivananjappa@linaro.org>
	<001601cc684c$ce571b00$6b055100$%kim@samsung.com>
	<CAGxe1ZFZehTs+xt3a5zWwiJ+=GBLy8VGPHMF7GUnpcF_wKeQKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAGxe1ZFZehTs+xt3a5zWwiJ+=GBLy8VGPHMF7GUnpcF_wKeQKw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "patches@linaro.org" <patches@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hello Mr Kukjin,
          I checked this link
"http://www.spinics.net/lists/linux-mmc/msg09770.html"
given by you,but this link has the patch only to extract the timeout
value from the
extended CSD register of the eMMC 4.5 device. Whereas if you review my =
patch
you can actually see the implementation of the timeout handling in the
mmc_switch
function in the mmc_ops.c

Sorry my previous mails were with ricj text enabled.
Thanks and regards
Girish K S


On 1 September 2011 09:20, Girish K S <girish.shivananjappa@linaro.org>=
 wrote:
> hi kukjin,
> but I cannot see its handling in the mmc_ops.c file which also update=
s the
> switch function.
> regards
> girish
>
> On Thursday, 1 September 2011, Kukjin Kim <kgene.kim@samsung.com> wro=
te:
>> Girish K S wrote:
>>>
>>> This patch adds the code to handle the default timeout
>>> for switch command.
>>> For eMMC 4.5 devices if timeout is not specified for the switch
>>> command while accessing a specific field,then the default timeout
>>> shall be used to timeout. Specification says there is no timeout
>>> defined while accessing BKOPS_START, SANITIZE_START, FLUSH_CACHE
>>> field(so these fields are excluded).
>>>
>>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>>> ---
>>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 =A05 +++++
>>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A08 ++++++++
>>> =A0include/linux/mmc/card.h =A0 | =A0 =A01 +
>>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 =A04 ++++
>>> =A04 files changed, 18 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 5700b1c..5b9fb6a 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -405,6 +405,11 @@ static int mmc_read_ext_csd(struct mmc_card *c=
ard,
>>> u8
>>> *ext_csd)
>>> =A0 =A0 =A0 if (card->ext_csd.rev >=3D 5)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rel_param =3D
>>> ext_csd[EXT_CSD_WR_REL_PARAM];
>>>
>>> + =A0 =A0 if (card->ext_csd.rev > 5) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 /* (eMMC 4.5)timeout is expressed in unit=
s of 10 ms*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.cmd6_timeout =3D
>>> ext_csd[EXT_CSD_CMD6_TIME]*10;
>>> + =A0 =A0 }
>>> +
>>> =A0 =A0 =A0 if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0xFF;
>>> =A0 =A0 =A0 else
>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.=
c
>>> index 770c3d0..c4d82f4 100644
>>> --- a/drivers/mmc/core/mmc_ops.c
>>> +++ b/drivers/mmc/core/mmc_ops.c
>>> @@ -394,6 +394,14 @@ int mmc_switch(struct mmc_card *card, u8 set, =
u8
>> index,
>>> u8 value,
>>> =A0 =A0 =A0 cmd.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_A=
C;
>>> =A0 =A0 =A0 cmd.cmd_timeout_ms =3D timeout_ms;
>>>
>>> + =A0 =A0 /* timeout is not defined for below command indexes (eMMC=
 4.5) */
>>> + =A0 =A0 if ((timeout_ms =3D=3D 0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd->rev > 5) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 (index !=3D EXT_CSD_BKOPS_START) =A0 =A0 =
=A0 =A0 =A0&&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 (index !=3D EXT_CSD_SANITIZE_START) =A0 =A0=
 =A0 &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 (index !=3D EXT_CSD_FLUSH_CACHE))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.cmd_timeout_ms =3D ca=
rd->ext_csd->cmd6_timeout;
>>> +
>>> =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETR=
IES);
>>> =A0 =A0 =A0 if (err)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>> index b460fc2..ef88412 100644
>>> --- a/include/linux/mmc/card.h
>>> +++ b/include/linux/mmc/card.h
>>> @@ -50,6 +50,7 @@ struct mmc_ext_csd {
>>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rel_secto=
rs;
>>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rel_param=
;
>>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0part_conf=
ig;
>>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd6_timeou=
t; =A0 /* timeout in ms */
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0part_time; =A0 =A0 =
=A0 =A0 =A0 =A0 =A0/* Units: ms */
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0 =A0=
 =A0 =A0 =A0 =A0 /* Units: 100ns */
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
>>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>>> index 5a794cb..a23f836 100644
>>> --- a/include/linux/mmc/mmc.h
>>> +++ b/include/linux/mmc/mmc.hHi Girish,
>>
>> (Cc'ed Seungwon Jeon)
>>
>> As I know, Seungwon Jeon has been submitted same/similar patch befor=
e
>> this.
>> http://www.spinics.net/lists/linux-mmc/msg09770.html
>>
>> Chris,
>> I cannot find your review on that...
>>
>> Thanks.
>>
>> Best regards,
>> Kgene.
>> --
>> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
>> SW Solution Development Team, Samsung Electronics Co., Ltd.
>>
>>
