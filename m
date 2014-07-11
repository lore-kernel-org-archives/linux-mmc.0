From: Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: change to use recommended reset procedure
Date: Fri, 11 Jul 2014 12:48:17 -0700
Message-ID: <CAPz6YkUKWUuQrSjPbdhwwZ57kkzJ7tLGpue=mvw6+31kkBhauw@mail.gmail.com>
References: <CAPz6YkUzGWnOznZ4UXNsLbe=ehDwfMJwUSjahUKVnVz8w9OcsA@mail.gmail.com>
 <1402351255-7423-1-git-send-email-sonnyrao@chromium.org> <002201cf9c3a$6de4a150$49ade3f0$%jun@samsung.com>
 <CAPz6YkXgoKPSQEdNOwAQDhEnFGFVArr_0obbVR_okAEOvLxtzA@mail.gmail.com> <001301cf9cf1$c91c7310$5b555930$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:44249 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbaGKTsj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jul 2014 15:48:39 -0400
Received: by mail-qg0-f49.google.com with SMTP id 63so1342153qgz.22
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jul 2014 12:48:38 -0700 (PDT)
In-Reply-To: <001301cf9cf1$c91c7310$5b555930$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Grant Grundler <grundler@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Douglas Anderson <dianders@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

On Fri, Jul 11, 2014 at 3:20 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Fri, July 11, 2014, Sonny Rao wrote:
>> On Thu, Jul 10, 2014 at 5:28 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> > Hi Sonny,
>> >
>> > I have missed this patch.
>> >
>> > You finally choose to take extra interrupt handling.
>> > If it is not harm, it's fine.
>>
>> Hi, thanks for coming back to it.  Based on my tracing, the interrupt
>> seems to be okay and is just ignored.
>>
>> >> -static inline bool dw_mci_fifo_reset(struct dw_mci *host)
>> >> +static inline bool dw_mci_reset(struct dw_mci *host)
> "inline" is no needed anymore.
>
>> >>  {
>> >> +     u32 flags = SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET;
>> >> +     bool ret = false;
>> >> +
>> >>       /*
>> >>        * Reseting generates a block interrupt, hence setting
>> >>        * the scatter-gather pointer to NULL.
>> >> @@ -2334,15 +2330,59 @@ static inline bool dw_mci_fifo_reset(struct dw_mci *host)
>> >>               host->sg = NULL;
>> >>       }
>> >>
>> >> -     return dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET);
>> >> -}
>> >> +     if (host->use_dma)
>> >> +             flags |= SDMMC_CTRL_DMA_RESET;
>> >>
>> >> -static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host)
>> >> -{
>> >> -     return dw_mci_ctrl_reset(host,
>> >> -                              SDMMC_CTRL_FIFO_RESET |
>> >> -                              SDMMC_CTRL_RESET |
>> >> -                              SDMMC_CTRL_DMA_RESET);
>> >> +     if (dw_mci_ctrl_reset(host, flags)) {
>> >> +             /*
>> >> +              * In all cases we clear the RAWINTS register to clear any
>> >> +              * interrupts.
>> >> +              */
>> >> +             mci_writel(host, RINTSTS, 0xFFFFFFFF);
>> >> +
>> >> +             /* if using dma we wait for dma_req to clear */
>> >> +             if (host->use_dma) {
>> >> +                     unsigned long timeout = jiffies + msecs_to_jiffies(500);
>> >> +                     u32 status;
>> >> +                     do {
>> >> +                             status = mci_readl(host, STATUS);
>> >> +                             if (!(status & SDMMC_STATUS_DMA_REQ))
>> >> +                                     break;
>> >> +                             cpu_relax();
>> >> +                     } while (time_before(jiffies, timeout));
>> >> +
>> >> +                     if (status & SDMMC_STATUS_DMA_REQ) {
>> >> +                             dev_err(host->dev,
>> >> +                                     "%s: Timeout waiting for dma_req to "
>> >> +                                     "clear during reset", __func__);
>> >> +                             goto ciu_out;
>> >> +                     }
>> >> +
>> >> +                     /* when using DMA next we reset the fifo again */
>> >> +                     if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET))
>> >> +                             goto ciu_out;
>> >> +             }
>> >> +     } else {
>> >> +             /* if the controller reset bit did clear, then set clock regs */
>> >> +             if (!(mci_readl(host, CTRL) & SDMMC_CTRL_RESET)) {
>> >> +                     dev_err(host->dev, "%s: fifo/dma reset bits didn't "
>> >> +                             "clear but ciu was reset, doing clock update.",
>> >> +                             __func__);
>> >> +                     goto ciu_out;
>> >> +             }
>> >> +     }
>> >> +
>> >> +     if (IS_ENABLED(CONFIG_MMC_DW_IDMAC))
>> >> +             /* It is also recommended that we reset and reprogram idmac */
>> >> +             dw_mci_idmac_reset(host);
>> >> +
>> >> +     ret = true;
>> >> +
>> >> +ciu_out:
>> >> +     /* After a CTRL reset we need to have CIU set clock registers  */
>> >> +     mci_send_cmd(host->cur_slot, SDMMC_CMD_UPD_CLK, 0);
>> >> +
>> >> +     return ret;
>> >>  }
>> >>
>> >>  #ifdef CONFIG_OF
>> >> @@ -2555,7 +2595,7 @@ int dw_mci_probe(struct dw_mci *host)
>> >>       }
>> >>
>> >>       /* Reset all blocks */
>> >> -     if (!dw_mci_ctrl_all_reset(host))
>> >> +     if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS))
>> >>               return -ENODEV;
>> >>
>> >>       host->dma_ops = host->pdata->dma_ops;
>> >> @@ -2744,7 +2784,7 @@ int dw_mci_resume(struct dw_mci *host)
>> >>               }
>> >>       }
>> >>
>> >> -     if (!dw_mci_ctrl_all_reset(host)) {
>> >> +     if (!dw_mci_reset(host)) {
>> > Do you have any reason to use dw_mci_reset() unlike doing on probing?
>>
>> I really wanted to use dw_mci_reset() everwhere, including probe,
>> because that would be simplest, where there is just one reset function
>> always, but the host structure is not completely set up at probe time,
>> so the code in dw_mci_reset() where we try to send a command to update
>> clock fails, so that's why I had to just do a reset.
>
> Yes, if we can keep one interface, it would be good.
> But can you check below?
> Did you see the kernel panic on probing with "host->cur_slot" is NULL?

Yes, I think that was the one.

> If right, resume seems not different from probe in case of removable type.
> And dw_mci_idmac_reset() is redundant when dw_mci_reset() is used at resume.
>
> I think dw_mci_ctrl_reset() can be also used at resume like at probe for simple way.
> For safety's sake, "host->cur_slot" should be guaranteed it's not NULL.

Ok, I didn't try on removable, but I can change it to match probe,
thanks for looking at this.

>
> Thanks,
> Seungwon Jeon
>
