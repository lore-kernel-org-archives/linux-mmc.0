From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: change to use recommended reset procedure
Date: Fri, 11 Jul 2014 19:20:48 +0900
Message-ID: <001301cf9cf1$c91c7310$5b555930$%jun@samsung.com>
References: <CAPz6YkUzGWnOznZ4UXNsLbe=ehDwfMJwUSjahUKVnVz8w9OcsA@mail.gmail.com>
 <1402351255-7423-1-git-send-email-sonnyrao@chromium.org>
 <002201cf9c3a$6de4a150$49ade3f0$%jun@samsung.com>
 <CAPz6YkXgoKPSQEdNOwAQDhEnFGFVArr_0obbVR_okAEOvLxtzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAPz6YkXgoKPSQEdNOwAQDhEnFGFVArr_0obbVR_okAEOvLxtzA@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Sonny Rao' <sonnyrao@chromium.org>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Grant Grundler' <grundler@chromium.org>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'sunil joshi' <joshi@samsung.com>, 'Tomasz Figa' <t.figa@samsung.com>, 'Douglas Anderson' <dianders@chromium.org>, 'Yuvaraj Kumar C D' <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, July 11, 2014, Sonny Rao wrote:
> On Thu, Jul 10, 2014 at 5:28 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Hi Sonny,
> >
> > I have missed this patch.
> >
> > You finally choose to take extra interrupt handling.
> > If it is not harm, it's fine.
> 
> Hi, thanks for coming back to it.  Based on my tracing, the interrupt
> seems to be okay and is just ignored.
> 
> >> -static inline bool dw_mci_fifo_reset(struct dw_mci *host)
> >> +static inline bool dw_mci_reset(struct dw_mci *host)
"inline" is no needed anymore.

> >>  {
> >> +     u32 flags = SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET;
> >> +     bool ret = false;
> >> +
> >>       /*
> >>        * Reseting generates a block interrupt, hence setting
> >>        * the scatter-gather pointer to NULL.
> >> @@ -2334,15 +2330,59 @@ static inline bool dw_mci_fifo_reset(struct dw_mci *host)
> >>               host->sg = NULL;
> >>       }
> >>
> >> -     return dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET);
> >> -}
> >> +     if (host->use_dma)
> >> +             flags |= SDMMC_CTRL_DMA_RESET;
> >>
> >> -static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host)
> >> -{
> >> -     return dw_mci_ctrl_reset(host,
> >> -                              SDMMC_CTRL_FIFO_RESET |
> >> -                              SDMMC_CTRL_RESET |
> >> -                              SDMMC_CTRL_DMA_RESET);
> >> +     if (dw_mci_ctrl_reset(host, flags)) {
> >> +             /*
> >> +              * In all cases we clear the RAWINTS register to clear any
> >> +              * interrupts.
> >> +              */
> >> +             mci_writel(host, RINTSTS, 0xFFFFFFFF);
> >> +
> >> +             /* if using dma we wait for dma_req to clear */
> >> +             if (host->use_dma) {
> >> +                     unsigned long timeout = jiffies + msecs_to_jiffies(500);
> >> +                     u32 status;
> >> +                     do {
> >> +                             status = mci_readl(host, STATUS);
> >> +                             if (!(status & SDMMC_STATUS_DMA_REQ))
> >> +                                     break;
> >> +                             cpu_relax();
> >> +                     } while (time_before(jiffies, timeout));
> >> +
> >> +                     if (status & SDMMC_STATUS_DMA_REQ) {
> >> +                             dev_err(host->dev,
> >> +                                     "%s: Timeout waiting for dma_req to "
> >> +                                     "clear during reset", __func__);
> >> +                             goto ciu_out;
> >> +                     }
> >> +
> >> +                     /* when using DMA next we reset the fifo again */
> >> +                     if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET))
> >> +                             goto ciu_out;
> >> +             }
> >> +     } else {
> >> +             /* if the controller reset bit did clear, then set clock regs */
> >> +             if (!(mci_readl(host, CTRL) & SDMMC_CTRL_RESET)) {
> >> +                     dev_err(host->dev, "%s: fifo/dma reset bits didn't "
> >> +                             "clear but ciu was reset, doing clock update.",
> >> +                             __func__);
> >> +                     goto ciu_out;
> >> +             }
> >> +     }
> >> +
> >> +     if (IS_ENABLED(CONFIG_MMC_DW_IDMAC))
> >> +             /* It is also recommended that we reset and reprogram idmac */
> >> +             dw_mci_idmac_reset(host);
> >> +
> >> +     ret = true;
> >> +
> >> +ciu_out:
> >> +     /* After a CTRL reset we need to have CIU set clock registers  */
> >> +     mci_send_cmd(host->cur_slot, SDMMC_CMD_UPD_CLK, 0);
> >> +
> >> +     return ret;
> >>  }
> >>
> >>  #ifdef CONFIG_OF
> >> @@ -2555,7 +2595,7 @@ int dw_mci_probe(struct dw_mci *host)
> >>       }
> >>
> >>       /* Reset all blocks */
> >> -     if (!dw_mci_ctrl_all_reset(host))
> >> +     if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS))
> >>               return -ENODEV;
> >>
> >>       host->dma_ops = host->pdata->dma_ops;
> >> @@ -2744,7 +2784,7 @@ int dw_mci_resume(struct dw_mci *host)
> >>               }
> >>       }
> >>
> >> -     if (!dw_mci_ctrl_all_reset(host)) {
> >> +     if (!dw_mci_reset(host)) {
> > Do you have any reason to use dw_mci_reset() unlike doing on probing?
> 
> I really wanted to use dw_mci_reset() everwhere, including probe,
> because that would be simplest, where there is just one reset function
> always, but the host structure is not completely set up at probe time,
> so the code in dw_mci_reset() where we try to send a command to update
> clock fails, so that's why I had to just do a reset.

Yes, if we can keep one interface, it would be good.
But can you check below?
Did you see the kernel panic on probing with "host->cur_slot" is NULL?
If right, resume seems not different from probe in case of removable type.
And dw_mci_idmac_reset() is redundant when dw_mci_reset() is used at resume.

I think dw_mci_ctrl_reset() can be also used at resume like at probe for simple way.
For safety's sake, "host->cur_slot" should be guaranteed it's not NULL.

Thanks,
Seungwon Jeon
