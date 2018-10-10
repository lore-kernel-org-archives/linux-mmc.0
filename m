From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 1/2] mmc: tmio: move MFD variant reset to a platform hook
Date: Wed, 10 Oct 2018 12:47:34 +0900
Message-ID: <CAK7LNAQ7RfwTKS=_KZPKC568h8mUMVhijecLWYY38wsJ6uwNEQ@mail.gmail.com>
References: <1538566587-29452-1-git-send-email-yamada.masahiro@socionext.com>
 <1538566587-29452-2-git-send-email-yamada.masahiro@socionext.com> <20181009234830.v7yzhnrtqcfwmm45@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009234830.v7yzhnrtqcfwmm45@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 10, 2018 at 8:49 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > +static void tmio_mmc_reset(struct tmio_mmc_host *host)
> > +{
> > +     /* FIXME - should we set stop clock reg here */
> > +     sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
> > +     sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
> > +     usleep_range(10000, 11000);
> > +     sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
> > +     sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
> > +     usleep_range(10000, 11000);
> > +
> > +     if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
> > +             sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
> > +             sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
> > +     }
> > +}
>
> Yes, looks much safer now.
>
> > +     host->reset = tmio_mmc_reset;
>
> So, you populate the new pointer here...
>
> > +     if (!_host->reset)
> > +             _host->reset = tmio_mmc_reset;
>
> ... and here. But it seems never used anywhere? Or am I missing
> something?
>

Bummer. I am totally screwed up.

V3 is right away.


Thanks!


-- 
Best Regards
Masahiro Yamada
