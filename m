From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/5] mmc: identify available device type to select
Date: Fri, 28 Mar 2014 09:31:18 +0100
Message-ID: <CAPDyKFoEgaYqAhNURO9byQ2sYHWzBWuhATkYnCpNY02FwLMDSA@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<006901cf2a58$d844f440$88cedcc0$%jun@samsung.com>
	<003c01cf3a12$9b58e3b0$d20aab10$%jun@samsung.com>
	<CAPDyKFqieNnPBEM5W1LZmvsQKbT-Fz2wqb9dW4_kc9qdqTxFBQ@mail.gmail.com>
	<002101cf3f2f$faca79e0$f05f6da0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:38942 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbaC1IbT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Mar 2014 04:31:19 -0400
Received: by mail-qg0-f44.google.com with SMTP id a108so3987341qge.17
        for <linux-mmc@vger.kernel.org>; Fri, 28 Mar 2014 01:31:19 -0700 (PDT)
In-Reply-To: <002101cf3f2f$faca79e0$f05f6da0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Jackey Shen <jackey.shen@amd.com>, Alim Akhtar <alim.akhtar@samsung.com>

On 14 March 2014 03:49, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Thu, March 13, 2014, Ulf Hansson wrote:
>> On 7 March 2014 15:36, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> > Device types which are supported by both host and device
>> > can be identified when EXT_CSD is read. There is no need to
>> > check host's capability anymore.
>> >
>> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> > ---
>> > Changes in v2:
>> >         Just rebased with latest one.
>> >
>> >  drivers/mmc/core/mmc.c   |   77 ++++++++++++++++++++++++++-------------------
>> >  include/linux/mmc/card.h |    6 ++-
>> >  include/linux/mmc/host.h |    6 ---
>> >  include/linux/mmc/mmc.h  |   12 +++++--
>> >  4 files changed, 56 insertions(+), 45 deletions(-)
>> >
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index db9655f..0abece0 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -243,28 +243,46 @@ static void mmc_select_card_type(struct mmc_card *card)
>> >         u8 card_type = card->ext_csd.raw_card_type & EXT_CSD_CARD_TYPE_MASK;
>> >         u32 caps = host->caps, caps2 = host->caps2;
>> >         unsigned int hs_max_dtr = 0;
>> > +       unsigned int avail_type = 0;
>> >
>> > -       if (card_type & EXT_CSD_CARD_TYPE_26)
>> > +       if (caps & MMC_CAP_MMC_HIGHSPEED &&
>> > +           card_type & EXT_CSD_CARD_TYPE_HS_26) {
>> >                 hs_max_dtr = MMC_HIGH_26_MAX_DTR;
>> > +               avail_type |= EXT_CSD_CARD_TYPE_HS_26;
>> > +       }
>> >
>> >         if (caps & MMC_CAP_MMC_HIGHSPEED &&
>> > -                       card_type & EXT_CSD_CARD_TYPE_52)
>> > +           card_type & EXT_CSD_CARD_TYPE_HS_52) {
>> >                 hs_max_dtr = MMC_HIGH_52_MAX_DTR;
>> > +               avail_type |= EXT_CSD_CARD_TYPE_HS_52;
>> > +       }
>> >
>> > -       if ((caps & MMC_CAP_1_8V_DDR &&
>> > -                       card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) ||
>> > -           (caps & MMC_CAP_1_2V_DDR &&
>> > -                       card_type & EXT_CSD_CARD_TYPE_DDR_1_2V))
>> > +       if (caps & MMC_CAP_1_8V_DDR &&
>> > +           card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
>> >                 hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
>> > +               avail_type |= EXT_CSD_CARD_TYPE_DDR_1_8V;
>> > +       }
>> >
>> > -       if ((caps2 & MMC_CAP2_HS200_1_8V_SDR &&
>> > -                       card_type & EXT_CSD_CARD_TYPE_SDR_1_8V) ||
>> > -           (caps2 & MMC_CAP2_HS200_1_2V_SDR &&
>> > -                       card_type & EXT_CSD_CARD_TYPE_SDR_1_2V))
>> > +       if (caps & MMC_CAP_1_2V_DDR &&
>> > +           card_type & EXT_CSD_CARD_TYPE_DDR_1_2V) {
>> > +               hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
>> > +               avail_type |= EXT_CSD_CARD_TYPE_DDR_1_2V;
>> > +       }
>> > +
>> > +       if (caps2 & MMC_CAP2_HS200_1_8V_SDR &&
>> > +           card_type & EXT_CSD_CARD_TYPE_HS200_1_8V) {
>> >                 hs_max_dtr = MMC_HS200_MAX_DTR;
>> > +               avail_type |= EXT_CSD_CARD_TYPE_HS200_1_8V;
>> > +       }
>> > +
>> > +       if (caps2 & MMC_CAP2_HS200_1_2V_SDR &&
>> > +           card_type & EXT_CSD_CARD_TYPE_HS200_1_2V) {
>> > +               hs_max_dtr = MMC_HS200_MAX_DTR;
>> > +               avail_type |= EXT_CSD_CARD_TYPE_HS200_1_2V;
>> > +       }
>> >
>> >         card->ext_csd.hs_max_dtr = hs_max_dtr;
>> > -       card->ext_csd.card_type = card_type;
>> > +       card->mmc_avail_type = avail_type;
>> >  }
>> >
>> >  /*
>> > @@ -708,6 +726,11 @@ static struct device_type mmc_type = {
>> >         .groups = mmc_attr_groups,
>> >  };
>> >
>> > +static inline unsigned int mmc_snoop_ddr(struct mmc_card *card)
>> > +{
>> > +       return card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_52;
>> > +}
>> > +
>>
>> Having a separate function for this seem a bit silly. Similar checks
>> is performed all over the code. I suggest you remove this.
> I understand your meaning.
> Yes, actually similar checking card type is done.
> But checking DDR type is required several times unlike other type case.
> I considered for that. I think it's pretty useful in terms of avoiding duplication and enhancement of readability.
>
>>
>> >  /*
>> >   * Select the PowerClass for the current bus width
>> >   * If power class is defined for 4/8 bit bus in the
>> > @@ -808,12 +831,10 @@ static int mmc_select_hs200(struct mmc_card *card)
>> >
>> >         host = card->host;
>> >
>> > -       if (card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_2V &&
>> > -                       host->caps2 & MMC_CAP2_HS200_1_2V_SDR)
>> > +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)
>> >                 err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
>> >
>> > -       if (err && card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V &&
>> > -                       host->caps2 & MMC_CAP2_HS200_1_8V_SDR)
>> > +       if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V)
>> >                 err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
>> >
>> >         /* If fails try again during next card power cycle */
>> > @@ -1072,10 +1093,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>> >          */
>> >         if (card->ext_csd.hs_max_dtr != 0) {
>> >                 err = 0;
>> > -               if (card->ext_csd.hs_max_dtr > 52000000 &&
>> > -                   host->caps2 & MMC_CAP2_HS200)
>> > +               if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>> >                         err = mmc_select_hs200(card);
>> > -               else if (host->caps & MMC_CAP_MMC_HIGHSPEED)
>> > +               else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>> >                         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> >                                         EXT_CSD_HS_TIMING, 1,
>> >                                         card->ext_csd.generic_cmd6_time,
>> > @@ -1089,13 +1109,11 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>> >                                mmc_hostname(card->host));
>> >                         err = 0;
>> >                 } else {
>> > -                       if (card->ext_csd.hs_max_dtr > 52000000 &&
>> > -                           host->caps2 & MMC_CAP2_HS200) {
>> > +                       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>> >                                 mmc_set_timing(card->host,
>> >                                                MMC_TIMING_MMC_HS200);
>> > -                       } else {
>> > +                       else
>> >                                 mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>> > -                       }
>> >                 }
>> >         }
>> >
>> > @@ -1118,14 +1136,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>> >         /*
>> >          * Indicate DDR mode (if supported).
>> >          */
>> > -       if (mmc_card_hs(card)) {
>> > -               if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
>> > -                       && (host->caps & MMC_CAP_1_8V_DDR))
>> > -                               ddr = MMC_1_8V_DDR_MODE;
>> > -               else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
>> > -                       && (host->caps & MMC_CAP_1_2V_DDR))
>> > -                               ddr = MMC_1_2V_DDR_MODE;
>> > -       }
>> > +       if (mmc_card_hs(card))
>> > +               ddr = mmc_snoop_ddr(card);
>> >
>> >         /*
>> >          * Indicate HS200 SDR mode (if supported).
>> > @@ -1145,8 +1157,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>> >                  * 3. set the clock to > 52Mhz <=200MHz and
>> >                  * 4. execute tuning for HS200
>> >                  */
>> > -               if ((host->caps2 & MMC_CAP2_HS200) &&
>> > -                   card->host->ops->execute_tuning) {
>> > +               if (card->host->ops->execute_tuning) {
>> >                         mmc_host_clk_hold(card->host);
>> >                         err = card->host->ops->execute_tuning(card->host,
>> >                                 MMC_SEND_TUNING_BLOCK_HS200);
>> > @@ -1255,7 +1266,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>> >                          *
>> >                          * WARNING: eMMC rules are NOT the same as SD DDR
>> >                          */
>> > -                       if (ddr == MMC_1_2V_DDR_MODE) {
>> > +                       if (ddr & EXT_CSD_CARD_TYPE_DDR_1_2V) {
>> >                                 err = __mmc_set_signal_voltage(host,
>> >                                         MMC_SIGNAL_VOLTAGE_120);
>> >                                 if (err)
>> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> > index 5473133..c232b10 100644
>> > --- a/include/linux/mmc/card.h
>> > +++ b/include/linux/mmc/card.h
>> > @@ -68,7 +68,6 @@ struct mmc_ext_csd {
>> >  #define MMC_HIGH_DDR_MAX_DTR   52000000
>> >  #define MMC_HS200_MAX_DTR      200000000
>> >         unsigned int            sectors;
>> > -       unsigned int            card_type;
>> >         unsigned int            hc_erase_size;          /* In sectors */
>> >         unsigned int            hc_erase_timeout;       /* In milliseconds */
>> >         unsigned int            sec_trim_mult;  /* Secure trim multiplier  */
>> > @@ -297,7 +296,10 @@ struct mmc_card {
>> >         const char              **info;         /* info strings */
>> >         struct sdio_func_tuple  *tuples;        /* unknown common tuples */
>> >
>> > -       unsigned int            sd_bus_speed;   /* Bus Speed Mode set for the card */
>> > +       union {
>> > +               unsigned int            sd_bus_speed;   /* Bus Speed Mode set for the card */
>> > +               unsigned int            mmc_avail_type; /* supported device type by both host and card */
>>
>> Using a union here won't be that much of a gain since there are only
>> few instances of the struct. Please remove.
> Yes, you're right. It's not much in gain.
> I intended to distinguish these two similar members respectively.
> It's used only in each specific type domain and not used at the same time.
> If no meaningful, I can remove as your suggestion.

Hi Seungwon,

I noticed in your latest version if this patch the "union" declaration
is still there. Could you please update and send a new version.

Kind regards
Ulf Hansson

>
> Thanks,
> Seungwon Jeon
>
>>
>> > +       };
>> >
>> >         struct dentry           *debugfs_root;
>> >         struct mmc_part part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
>> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> > index 2f263ae..1ee3c10 100644
>> > --- a/include/linux/mmc/host.h
>> > +++ b/include/linux/mmc/host.h
>> > @@ -62,12 +62,6 @@ struct mmc_ios {
>> >  #define MMC_TIMING_MMC_DDR52   8
>> >  #define MMC_TIMING_MMC_HS200   9
>> >
>> > -#define MMC_SDR_MODE           0
>> > -#define MMC_1_2V_DDR_MODE      1
>> > -#define MMC_1_8V_DDR_MODE      2
>> > -#define MMC_1_2V_SDR_MODE      3
>> > -#define MMC_1_8V_SDR_MODE      4
>> > -
>> >         unsigned char   signal_voltage;         /* signalling voltage (1.8V or 3.3V) */
>> >
>> >  #define MMC_SIGNAL_VOLTAGE_330 0
>> > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> > index 50bcde3..f734c0c 100644
>> > --- a/include/linux/mmc/mmc.h
>> > +++ b/include/linux/mmc/mmc.h
>> > @@ -354,18 +354,22 @@ struct _mmc_csd {
>> >  #define EXT_CSD_CMD_SET_SECURE         (1<<1)
>> >  #define EXT_CSD_CMD_SET_CPSECURE       (1<<2)
>> >
>> > -#define EXT_CSD_CARD_TYPE_26   (1<<0)  /* Card can run at 26MHz */
>> > -#define EXT_CSD_CARD_TYPE_52   (1<<1)  /* Card can run at 52MHz */
>> >  #define EXT_CSD_CARD_TYPE_MASK 0x3F    /* Mask out reserved bits */
>> > +#define EXT_CSD_CARD_TYPE_HS_26        (1<<0)  /* Card can run at 26MHz */
>> > +#define EXT_CSD_CARD_TYPE_HS_52        (1<<1)  /* Card can run at 52MHz */
>> > +#define EXT_CSD_CARD_TYPE_HS   (EXT_CSD_CARD_TYPE_HS_26 | \
>> > +                                EXT_CSD_CARD_TYPE_HS_52)
>> >  #define EXT_CSD_CARD_TYPE_DDR_1_8V  (1<<2)   /* Card can run at 52MHz */
>> >                                              /* DDR mode @1.8V or 3V I/O */
>> >  #define EXT_CSD_CARD_TYPE_DDR_1_2V  (1<<3)   /* Card can run at 52MHz */
>> >                                              /* DDR mode @1.2V I/O */
>> >  #define EXT_CSD_CARD_TYPE_DDR_52       (EXT_CSD_CARD_TYPE_DDR_1_8V  \
>> >                                         | EXT_CSD_CARD_TYPE_DDR_1_2V)
>> > -#define EXT_CSD_CARD_TYPE_SDR_1_8V     (1<<4)  /* Card can run at 200MHz */
>> > -#define EXT_CSD_CARD_TYPE_SDR_1_2V     (1<<5)  /* Card can run at 200MHz */
>> > +#define EXT_CSD_CARD_TYPE_HS200_1_8V   (1<<4)  /* Card can run at 200MHz */
>> > +#define EXT_CSD_CARD_TYPE_HS200_1_2V   (1<<5)  /* Card can run at 200MHz */
>> >                                                 /* SDR mode @1.2V I/O */
>> > +#define EXT_CSD_CARD_TYPE_HS200                (EXT_CSD_CARD_TYPE_HS200_1_8V | \
>> > +                                        EXT_CSD_CARD_TYPE_HS200_1_2V)
>> >
>> >  #define EXT_CSD_BUS_WIDTH_1    0       /* Card is in 1 bit mode */
>> >  #define EXT_CSD_BUS_WIDTH_4    1       /* Card is in 4 bit mode */
>> > --
>> > 1.7.0.4
>> >
>> >
>>
>> Besides the minor stuff, looks good.
>>
>> Kind regards
>> Ulf Hansson
>
