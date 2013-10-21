From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 2/7] mmc: sdhci-esdhc-imx: add SDHCI_TRANSFER_MODE read function
Date: Tue, 22 Oct 2013 00:29:04 +0800
Message-ID: <CAA+hA=R8OWsMABcN66N48M+EuULqLgsbx9g+pELmcXVCMGEN2g@mail.gmail.com>
References: <1382365627-26816-1-git-send-email-b29396@freescale.com>
	<1382365627-26816-3-git-send-email-b29396@freescale.com>
	<CACUGKYPo2zWDTbmyksiwmJY8tghkYjr=dKD8pDzxugeOoojCNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:52809 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3JUQ3G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2013 12:29:06 -0400
Received: by mail-ie0-f178.google.com with SMTP id to1so15859994ieb.37
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2013 09:29:05 -0700 (PDT)
In-Reply-To: <CACUGKYPo2zWDTbmyksiwmJY8tghkYjr=dKD8pDzxugeOoojCNQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: Dong Aisheng <b29396@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, wsa@the-dreams.de, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi John,

You need apply this patch series first which introduced esdhc_is_usdhc.
http://permalink.gmane.org/gmane.linux.kernel.mmc/23074

Please refer to Chris tree:
https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc.git/log/?h=mmc-next

Regards
Dong Aisheng

On Tue, Oct 22, 2013 at 12:01 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Dong,
>
> I compiled my kernel after applying your patch but it didn't compile
> it correctly due to esdhc_is_usdhc function. It should be
> is_imx6_usdhc?
>
> Regards,
>
> john
>
> On Mon, Oct 21, 2013 at 7:27 AM, Dong Aisheng <b29396@freescale.com> wrote:
>> Used to read out the correct value of SDHCI_TRANSFER_MODE register
>> for upper layer.
>>
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c |   16 ++++++++++++++++
>>  1 files changed, 16 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 461a4c3..2be77e0 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -385,6 +385,22 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
>>                 return ret;
>>         }
>>
>> +       if (unlikely(reg == SDHCI_TRANSFER_MODE)) {
>> +               if (esdhc_is_usdhc(imx_data)) {
>> +                       u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
>> +                       ret = m & ESDHC_MIX_CTRL_SDHCI_MASK;
>> +                       /* Swap AC23 bit */
>> +                       if (m & ESDHC_MIX_CTRL_AC23EN) {
>> +                               ret &= ~ESDHC_MIX_CTRL_AC23EN;
>> +                               ret |= SDHCI_TRNS_AUTO_CMD23;
>> +                       }
>> +               } else {
>> +                       ret = readw(host->ioaddr + SDHCI_TRANSFER_MODE);
>> +               }
>> +
>> +               return ret;
>> +       }
>> +
>>         return readw(host->ioaddr + reg);
>>  }
>>
>> --
>> 1.7.2.rc3
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
