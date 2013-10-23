From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/2] mmc: dw_mmc: Cleanup disable of low power mode w/ SDIO
 interrupts
Date: Wed, 23 Oct 2013 20:25:36 +0900
Message-ID: <001701cecfe2$9831eb90$c895c2b0$%jun@samsung.com>
References: <1381876762-10892-1-git-send-email-dianders@chromium.org>
 <1381876762-10892-2-git-send-email-dianders@chromium.org>
 <52610273.3080005@samsung.com>
 <CAD=FV=UiUxoqbAeq+3iUChqksHd_NpJs2rM83=ng3fprMj0E-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46370 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab3JWLZi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Oct 2013 07:25:38 -0400
In-reply-to: <CAD=FV=UiUxoqbAeq+3iUChqksHd_NpJs2rM83=ng3fprMj0E-A@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: 'Chris Ball' <cjb@laptop.org>, 'James Hogan' <james.hogan@imgtec.com>, 'Grant Grundler' <grundler@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Olof Johansson' <olof@lixom.net>, 'Sonny Rao' <sonnyrao@chromium.org>, 'Bing Zhao' <bzhao@marvell.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Doug,

This change looks good.
There's comment below.

On Sat, October 19, 2013, Doug Anderson wrote:
> Jaehoon,
> 
> On Fri, Oct 18, 2013 at 2:42 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> >> -     clk_en_a = mci_readl(host, CLKENA);
> >> +     /*
> >> +      * Low power mode will stop the card clock when idle.  According to the
> >> +      * description of the CLKENA register we should disable low power mode
> >> +      * for SDIO cards if we need SDIO interrupts to work.
> >> +      */
> >> +     if (mmc->caps | MMC_CAP_SDIO_IRQ) {
> > mmc->caps & MMC_CAP_SDIO_IRQ?
> 
> Wow, that was an embarrassing one.  Thanks.
> 
> >> +             const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR << slot->id;
> >> +             u32 clk_en_a_old;
> >> +             u32 clk_en_a;
> >>
> >> -     if (clk_en_a & clken_low_pwr) {
> >> -             mci_writel(host, CLKENA, clk_en_a & ~clken_low_pwr);
> >> -             mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
> >> -                          SDMMC_CMD_PRV_DAT_WAIT, 0);
> >> +             clk_en_a_old = mci_readl(host, CLKENA);
> >> +
> >> +             if (card->type == MMC_TYPE_SDIO ||
> >> +                 card->type == MMC_TYPE_SD_COMBO) {
&& card->quirks & MMC_QUIRK_BROKEN_CLK_GATING
How about considering MMC_QUIRK_BROKEN_CLK_GATING?
Some sdio device can work with gating clock.
For this, mmc_fixup_device() should be called prior to init_card() in core(sdio.c).
I guess you found that.

Thanks,
Seungwon Jeon

> >> +                     set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
> >> +                     clk_en_a = clk_en_a_old & ~clken_low_pwr;
> >> +             } else {
> >> +                     clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
> >> +                     clk_en_a = clk_en_a_old | clken_low_pwr;
> > When this condition is entered? card->type is always MMC_TYPE_SDIO or MMC_TYPE_SD_COMBO, isn't?
> 
> Ugh, that's not intuitive.  This callback is only called for SDIO
> cards and not MMC/SD cards?  That means if you plug in an SDIO card
> and then eject it and plug in an SD card you won't get to low power.
> Hrm.
> 
> I dug around a bit and couldn't find a better way to do this and then
> I realized that the other user of the init_card() callback has the
> same bug, so for the next version of the series I'm proposing a fix
> for mmc core to add this for all types.  If you have a better
> suggestion, I'm all ears.
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

