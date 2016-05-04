From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 2/6] mmc: core: add mmc-hs400-enhanced-strobe support
Date: Wed, 4 May 2016 17:19:30 +0800
Message-ID: <2c73521e-7734-7438-06ef-065722130036@rock-chips.com>
References: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
 <1461897995-28903-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFrPhBKA3g+_NMBGfw4kqonpgQzbdTSo-A5sRwqio268xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:49924 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbcEDJTw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 05:19:52 -0400
In-Reply-To: <CAPDyKFrPhBKA3g+_NMBGfw4kqonpgQzbdTSo-A5sRwqio268xw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 2016/5/4 16:12, Ulf Hansson =E5=86=99=E9=81=93:
> On 29 April 2016 at 04:46, Shawn Lin <shawn.lin@rock-chips.com> wrote=
:
>> This patch introduce mmc-hs400-enhanced-strobe for platforms
>> which want to enable enhanced strobe function from DT if the
>> mmc host controller claims to support enhanced strobe.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v2:
>> - switch to HS400ES from Highspeed mode directly
>>
>>  drivers/mmc/core/host.c  | 2 ++
>>  include/linux/mmc/host.h | 6 ++++++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index e0a3ee1..eb1530a 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -289,6 +289,8 @@ int mmc_of_parse(struct mmc_host *host)
>>                 host->caps2 |=3D MMC_CAP2_HS400_1_8V | MMC_CAP2_HS20=
0_1_8V_SDR;
>>         if (of_property_read_bool(np, "mmc-hs400-1_2v"))
>>                 host->caps2 |=3D MMC_CAP2_HS400_1_2V | MMC_CAP2_HS20=
0_1_2V_SDR;
>> +       if (of_property_read_bool(np, "mmc-hs400-enhanced-strobe"))
>> +               host->caps2 |=3D MMC_CAP2_HS400_ENHANCED_STROBE;
>
> How about MMC_CAP2_HS400_ES instead?

MMC_CAP2_HS400_ES is fine to me.

>
>>
>>         host->dsr_req =3D !of_property_read_u32(np, "dsr", &host->ds=
r);
>>         if (host->dsr_req && (host->dsr & ~0xffff)) {
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 85800b4..11e89d3 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -302,6 +302,7 @@ struct mmc_host {
>>  #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
>>  #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)    /* No physical write=
 protect pin, assume that card is always read-write */
>>  #define MMC_CAP2_NO_SDIO       (1 << 19)       /* Do not send SDIO =
commands during initialization */
>> +#define MMC_CAP2_HS400_ENHANCED_STROBE (1 << 20) /* Host supports e=
nhanced strobe */
>>
>>         mmc_pm_flag_t           pm_caps;        /* supported pm feat=
ures */
>>
>> @@ -480,6 +481,11 @@ static inline int mmc_host_uhs(struct mmc_host =
*host)
>>                  MMC_CAP_UHS_DDR50);
>>  }
>>
>> +static inline int mmc_host_hs400_enhanced_strobe(struct mmc_host *h=
ost)
>> +{
>> +       return host->caps2 & MMC_CAP2_HS400_ENHANCED_STROBE;
>> +}
>> +
>
> This helper function is to me a bit unnecessary, can you please just
> check the MMC_CAP2_* when needed instead!?

okay, I will deal with these two comments above.

Thanks.

>
>>  static inline int mmc_host_packed_wr(struct mmc_host *host)
>>  {
>>         return host->caps2 & MMC_CAP2_PACKED_WR;
>
> Kind regards
> Uffe
>
>
>


--=20
Best Regards
Shawn Lin

