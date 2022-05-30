Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A91C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 30 May 2022 03:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiE3DLN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 May 2022 23:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiE3DLM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 May 2022 23:11:12 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A0A23BF1
        for <linux-mmc@vger.kernel.org>; Sun, 29 May 2022 20:11:11 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v106so9975014ybi.0
        for <linux-mmc@vger.kernel.org>; Sun, 29 May 2022 20:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TA7cJB9mIlKS3N9knM9B3N3EuM81rc0VQLY78xpw6nU=;
        b=XKYQSjrpQe4NJURFmZb1aKEdCrCEOBMYCMc+3n6Yc0g0fZHuIKHHz0TT0mokuVeJGm
         rsgEX8UDvke+U8qTeMdT9OSR1fmvHc7uQhaQyGWp7Qmg7JAgkowLRLnBEhgq8CXe3eUv
         s6h6cArz5zUBcsMKCAU7qpzPcjyr7lvSW8sQeuBYfGp4OBgJfztA1HADKY4TG2f/yzWY
         w2e5TSt+Kt98EwPylBG43/T7ZN/2YayvaLn/XNcCAkI6fqY98GfsS7HCE2sH+pAHDU2Q
         Iq2jRdSXiDAfILkoKXGg9x0JUa+OdcvbCHo3gGJCpp+nLN4faraxo0FT4t7Cde8OlEiS
         0fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TA7cJB9mIlKS3N9knM9B3N3EuM81rc0VQLY78xpw6nU=;
        b=F5vqAh5/Vkd3O5P9AQNo3FxR2ReuUMLS1DS5jFkPLXwJ7Xz7YY09yKouZOCtP0X4rm
         7l6/uyb0NIL25VpXJZwlHRiH7X0KQd29BzR3e5WP2Tj1rPQ4NuulxSzmq/0KFmeBOrQ5
         pzcbhFRp3OUqKxRWhzMw5AltjFETK9yt62kgMMRWPZNAnTVjL7WVjf7oFzcQX25bNZEj
         FUMj4exUUPLgrDv9Da/FNhAhpL3NiukdmlGb+kla+EwM5FxOUIP46+xzMROnfnK24fl1
         PAlJY8EQRKV5z18azKtYcLvVxZ0Xi4SrZxUGN/DDINWHMzph5ddhQikaeqgXaEuaOoEM
         8zQg==
X-Gm-Message-State: AOAM531lR/IbkEHvZU9kynVvVBpuTVOsLn+/2UwFhinv+E3/uRK9XbC3
        2kjenGkz2QBvZ4QKQJjlrn08x4chlmzvNlbO108SX+1QBM4=
X-Google-Smtp-Source: ABdhPJyhBUi5RXeU7pVkBjVShATM2dmutigDTLdPe+gS6yjVyv4n15V7yF+8GsYTnxVqiFzPGJLZoyKr6UXD3utzPaU=
X-Received: by 2002:a05:6902:1102:b0:64f:37a3:6b9e with SMTP id
 o2-20020a056902110200b0064f37a36b9emr50433777ybu.21.1653880270985; Sun, 29
 May 2022 20:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220526070819.22151-1-jason.lai@genesyslogic.com.tw> <e1e83c5e-2c73-baa6-16fa-ddadbc278aec@intel.com>
In-Reply-To: <e1e83c5e-2c73-baa6-16fa-ddadbc278aec@intel.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Mon, 30 May 2022 11:11:00 +0800
Message-ID: <CAG0XXUHCd=fsR37KRbDjh4O+zn7bZfyQ0syDZvR7-Hk3RZH4EA@mail.gmail.com>
Subject: Re: [RESEND] mmc: sdhci-pci-gli: Improve Random 4K Read Performance
 of GL9763E
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        SeanHY.chen@genesyslogic.com.tw,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        victor.shih@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

Please see my reply below.

On Fri, May 27, 2022 at 4:54 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 26/05/22 10:08, jasonlai.genesyslogic@gmail.com wrote:
> > From: Jason Lai <jasonlai.genesyslogic@gmail.com>
> >
> > Resend this patch due to code base updated to 5.18.0-rc3.
> >
> > This patch is based on patch [1] and remove data transfer length checking.
> >
> > Due to flaws in hardware design, GL9763E takes long time to exit from L1
> > state. The I/O performance will suffer severe impact if it often enter and
> > and exit L1 state.
> >
> > Unfortunately, entering and exiting L1 state is signal handshake in
> > physical layer, software knows nothiong about it. The only way to stop
> > entering L1 state is to disable hardware LPM negotiation on GL9763E.
> >
> > To improve read performance and take battery life into account, we reject
> > L1 negotiation while executing MMC_READ_MULTIPLE_BLOCK command and enable L1
> > negotiation again when receiving non-MMC_READ_MULTIPLE_BLOCK command.
> >
> > [1]
> > https://patchwork.kernel.org/project/linux-mmc/list/?series=510801&archive
> > =both
>
> Really needs Ulf's response, but a minor comment below.
>
> >
> > Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 60 +++++++++++++++++++++++++++++++-
> >  1 file changed, 59 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > index d09728c37d03..86200b73c0b0 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -95,9 +95,12 @@
> >  #define PCIE_GLI_9763E_SCR    0x8E0
> >  #define   GLI_9763E_SCR_AXI_REQ         BIT(9)
> >
> > +#define PCIE_GLI_9763E_CFG       0x8A0
> > +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
> > +
> >  #define PCIE_GLI_9763E_CFG2      0x8A4
> >  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> > -#define   GLI_9763E_CFG2_L1DLY_MID 0x54
> > +#define   GLI_9763E_CFG2_L1DLY_MID 0x54              // Set L1 entry delay time to 21us
> >
> >  #define PCIE_GLI_9763E_MMC_CTRL  0x960
> >  #define   GLI_9763E_HS400_SLOW     BIT(3)
> > @@ -144,6 +147,10 @@
> >
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> > +struct gli_host {
> > +     bool lpm_negotiation_enabled;
> > +};
> > +
> >  /* Genesys Logic chipset */
> >  static inline void gl9750_wt_on(struct sdhci_host *host)
> >  {
> > @@ -818,6 +825,53 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
> >       sdhci_dumpregs(mmc_priv(mmc));
> >  }
> >
> > +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
> > +{
> > +     struct pci_dev *pdev = slot->chip->pdev;
> > +     u32 value;
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> > +     value &= ~GLI_9763E_VHS_REV;
> > +     value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> > +
> > +     if (enable)
> > +             value &= ~GLI_9763E_CFG_LPSN_DIS;
> > +     else
> > +             value |= GLI_9763E_CFG_LPSN_DIS;
> > +
> > +     pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> > +     value &= ~GLI_9763E_VHS_REV;
> > +     value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > +}
> > +
> > +static void gl9763e_request(struct mmc_host *mmc, struct mmc_request *mrq)
> > +{
> > +     struct sdhci_host *host = mmc_priv(mmc);
> > +     struct mmc_command *cmd;
> > +     struct sdhci_pci_slot *slot = sdhci_priv(host);
> > +     struct gli_host *gli_host = sdhci_pci_priv(slot);
> > +
> > +     cmd = mrq->cmd;
> > +
> > +     if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK) && gli_host->lpm_negotiation_enabled) {
> > +             gl9763e_set_low_power_negotiation(slot, false);
> > +             gli_host->lpm_negotiation_enabled = false;
> > +     } else {
> > +             if (gli_host->lpm_negotiation_enabled == false) {
>
> Is this logic right?  Wouldn't it also get here with

No, the logic is wrong. The original intention of my design is keeping LPM
negotiation disabled from arriving of READ_MULTIPLE_BLOCK command to
arriving of non-READ_MULTIPLE_BLOCK command. So The piece of code should be
written as below:
if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK)) {
        if (gli_host->lpm_negotiation_enabled) {
                gl9763e_set_low_power_negotiation(slot, false);
                gli_host->lpm_negotiation_enabled = false;
        }
} else {
        if (gli_host->lpm_negotiation_enabled == false) {
                gl9763e_set_low_power_negotiation(slot, true);
                gli_host->lpm_negotiation_enabled = true;
        }
}

Am I correct?

regards,
Jason Lai

>         cmd->opcode == MMC_READ_MULTIPLE_BLOCK &&
>         gli_host->lpm_negotiation_enabled == false
>
> and then you don't want the following?
>
> > +                     gl9763e_set_low_power_negotiation(slot, true);
> > +                     gli_host->lpm_negotiation_enabled = true;
> > +             }
> > +     }
> > +
> > +     sdhci_request(mmc, mrq);
> > +}
> > +
> >  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
> >  {
> >       struct cqhci_host *cq_host = mmc->cqe_private;
> > @@ -1016,6 +1070,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
> >       gli_pcie_enable_msi(slot);
> >       host->mmc_host_ops.hs400_enhanced_strobe =
> >                                       gl9763e_hs400_enhanced_strobe;
> > +
> > +     host->mmc_host_ops.request = gl9763e_request;
> > +
> >       gli_set_gl9763e(slot);
> >       sdhci_enable_v4_mode(host);
> >
> > @@ -1109,4 +1166,5 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
> >       .allow_runtime_pm = true,
> >  #endif
> >       .add_host       = gl9763e_add_host,
> > +     .priv_size      = sizeof(struct gli_host),
> >  };
>
