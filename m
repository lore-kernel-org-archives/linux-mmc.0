From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 14/14] mmc: mmci: Add Qcom specific pio_read function.
Date: Fri, 23 May 2014 12:53:07 +0100
Message-ID: <537F36A3.7020006@linaro.org>
References: <1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400146684-30384-1-git-send-email-srinivas.kandagatla@linaro.org> <CACRpkdbQ_uNoZpW9w7Yf==wt44wun4e+P7WzMp_t0tuCVeUX_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:50746 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbaEWLxM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 07:53:12 -0400
Received: by mail-wi0-f175.google.com with SMTP id f8so704695wiw.8
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2014 04:53:10 -0700 (PDT)
In-Reply-To: <CACRpkdbQ_uNoZpW9w7Yf==wt44wun4e+P7WzMp_t0tuCVeUX_g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

Hi Linus W,

On 23/05/14 10:31, Linus Walleij wrote:
> static int mmci_qcom_pio_read(struct mmci_host *host, char *buffer,
>                          unsigned int remain)
> {
>         u32 *ptr = (u32*) buffer;
>         unsigned int count = 0;
>         unsigned int words;
>         unsigned int fifo_size = host->variant->fifosize;
>
>         words = DIV_ROUND_UP(remain, 4);
>         while (readl(host->base + MMCISTATUS) & MCI_RXDATAAVLBL) {
>                 *ptr = readl(host->base + MMCIFIFO + (count % fifo_size));
>                 ptr++;
>                 count += 4;
>                 remain--;
>                 if (!remain)
>                         break;
>         }
>         return count;
> }
>
> I guess you will run into additional problems when you come to doing
> SDIO. This function can return*more*  bytes than asked for, as it rounds
> up. It won't happen with MMC/SD transfers since these are always
> divisible by 8, but it*will*  happen on SDIO!
That's a good point,

Qualcomm will need SDIO support in future, so I have slightly modified 
the  code to address this. Other thing I tried was to fit in this in 
mmci_pio_read, It became very ugly, as the FIFOCNT register behaviour is 
totally different and there is no way to tell how many bytes are ready 
to be consumed. So finally I think having a separate pio read for 
qualcomm looks much neater.

final mmci_qcom_pio_read looks like:


static int mmci_qcom_pio_read(struct mmci_host *host, char *buffer,
             unsigned int remain)
{
     u32 *ptr = (u32*) buffer;
     unsigned int count = 0;
     unsigned int words, bytes;
     unsigned int fifo_size = host->variant->fifosize;

     words = remain >> 2;
     bytes = remain % 4;
     /* read full words followed by leftover bytes */
     if (words) {
         while (readl(host->base + MMCISTATUS) & MCI_RXDATAAVLBL) {
             *ptr = readl(host->base + MMCIFIFO + (count % fifo_size));
             ptr++;
             count += 4;
             words--;
             if (!words)
                 break;
          }
     }

     /* read leftover bytes */
     if (unlikely(bytes)) {
         unsigned char buf[4];
         if (readl(host->base + MMCISTATUS) & MCI_RXDATAAVLBL) {
             *buf = readl(host->base + MMCIFIFO + (count % fifo_size));
             memcpy(ptr, buf, bytes);
              count += bytes;
         }
     }

     return count;
}

Thanks,
srini

