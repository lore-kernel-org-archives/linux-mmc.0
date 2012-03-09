From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/1] mmc: core: hs200 fixes
Date: Thu, 08 Mar 2012 23:46:05 -0500
Message-ID: <m2pqcmpek2.fsf@bob.laptop.org>
References: <1331036952-18211-1-git-send-email-subhashj@codeaurora.org>
	<CAGxe1ZGxxLV8=w32Ka3aoTmwCkrK2yNNLj+W=mgqZG+epab56w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAGxe1ZGxxLV8=w32Ka3aoTmwCkrK2yNNLj+W=mgqZG+epab56w@mail.gmail.com>
	(Girish K. S.'s message of "Tue, 6 Mar 2012 18:37:31 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Mar 06 2012, Girish K S wrote:
> On 6 March 2012 17:59, Subhash Jadavani <subhashj@codeaurora.org> wro=
te:
>> This patch fixes following issues when HS200 is enabled:
>>
>> 1. If executing_tuning() host ops is called without mmc_host_clk_hol=
d(),
>> =C2=A0 card clocks might get turned off (if MMC_CLK_GATING is enable=
d)
>> =C2=A0 while execute_tuning() is in progress. So this patch makes su=
re
>> =C2=A0 that execute_tuning() is called with mmc_host_clk_hold().
>>
>> 2. If host timing mode is set to HS200 mode, there should not be
>> =C2=A0 any communication with the card until execute_tuning() is com=
pleted.
>> =C2=A0 But there is a chance that CMD6 might be sent to enable set H=
PI_EN
>> =C2=A0 (of HPI_MGMT field in EXT_CSD) before execute_tuning() is cal=
led.
>> =C2=A0 So this patch moves this operation after execute_tuning() is =
completed.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> ---
>> =C2=A0drivers/mmc/core/mmc.c | =C2=A0 38 +++++++++++++++++++++------=
-----------
>> =C2=A01 files changed, 21 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index a480663..d36d2c4 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1030,22 +1030,6 @@ static int mmc_init_card(struct mmc_host
>> *host, u32 ocr,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* Enable HPI feature (if supported)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> - =C2=A0 =C2=A0 =C2=A0 if (card->ext_csd.hpi) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D mmc_switc=
h(card, EXT_CSD_CMD_SET_NORMAL,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 EXT_CSD_HPI_MGMT, 1, 0);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err && err !=3D=
 -EBADMSG)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto free_card;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pr_warning("%s: Enabling HPI failed\n",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_hostname(card->=
host));
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 err =3D 0;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 card->ext_csd.hpi_en =3D 1;
>> - =C2=A0 =C2=A0 =C2=A0 }
>> -
>> - =C2=A0 =C2=A0 =C2=A0 /*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Compute bus speed.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0max_dtr =3D (unsigned int)-1;
>> @@ -1094,9 +1078,12 @@ static int mmc_init_card(struct mmc_host
>> *host, u32 ocr,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 4. execute=
 tuning for HS200
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((host->ca=
ps2 & MMC_CAP2_HS200) &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 car=
d->host->ops->execute_tuning)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 car=
d->host->ops->execute_tuning) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mmc_host_clk_hold(card->host);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0err =3D card->host->ops->execute_tuning(card->host,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMC_SEND_TUNING_BLOCK_HS200);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mmc_host_clk_release(card->host);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pr_warning("%s: tuning execution failed\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_hostname(card->ho=
st));
>> @@ -1216,6 +1203,23 @@ static int mmc_init_card(struct mmc_host
>> *host, u32 ocr,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Enable HPI feature (if supported)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 if (card->ext_csd.hpi) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D mmc_switc=
h(card, EXT_CSD_CMD_SET_NORMAL,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EXT_CSD_HPI_MGMT, 1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->ext_csd.generic_cmd6_time)=
;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err && err !=3D=
 -EBADMSG)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto free_card;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pr_warning("%s: Enabling HPI failed\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_hostname(card->=
host));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 err =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 card->ext_csd.hpi_en =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If cache size is higher than 0, this i=
ndicates
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the existence of cache and it can be t=
urned on.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>
> Reviewed-By: girish.shivananjappa@linaro.org

Thanks, pushed to mmc-next for 3.4.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
