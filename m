Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DD1C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 22:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B8A20729
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 22:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595282817;
	bh=78BdF/HR6s7qSjh/SH8MXr7/WJ4eMmExO0xS180B/h8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=ppolP17PLTe4WgDULB6ovk+5PqhtCPebd+iQ1H6BpoVwPwQYfpIRJOi+uutRYaTPJ
	 jK8Q9DhhuNUR5zy6bt2w9R0fzHr081KEmZQ14QGW+q1imKqo3H1yTnRUgF+MFIQLKt
	 pxaX7/L1jOnAFbrvE696RP/FveAibd+9yXCV5ZqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgGTWG4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGTWGy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Jul 2020 18:06:54 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE5C2073A;
        Mon, 20 Jul 2020 22:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595282813;
        bh=78BdF/HR6s7qSjh/SH8MXr7/WJ4eMmExO0xS180B/h8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Wp0hVRJHHRmiSwwTStGNUkQO8nKQV3GvxlL/+Yl6CcnItiPNE2UPJ3GquBbGaLHrD
         lIz+NYuJufRZa8YxDjkw53fgIH/V08rtzV7ztEx9NWHApo4AlrTz6Ibb/Lip5dTRrf
         AuanM1RI7uQ/IrAFaLihcTON45oNGcNH/4FCif6c=
Date:   Mon, 20 Jul 2020 17:06:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org,
        rui_feng@realsil.com.cn, bhelgaas@google.com, kdlnx@doth.eu,
        linus.walleij@linaro.org, rmfrfs@gmail.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH] misc: rtsx: Add support new chip rts5228 mmc:  rtsx: Add
 support MMC_CAP2_NO_MMC
Message-ID: <20200720220651.GA1035857@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706070259.32565-1-ricky_wu@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[+cc Puranjay, for LTR issues, original posting at
https://lore.kernel.org/r/20200706070259.32565-1-ricky_wu@realtek.com]

I've complained about some of this stuff before, but we haven't really
made any progress yet:

  https://lore.kernel.org/lkml/20171214222522.GL30595@bhelgaas-glaptop.roam.corp.google.com/

On Mon, Jul 06, 2020 at 03:02:59PM +0800, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> In order to support new chip rts5228, the definitions of some internal
> registers and workflow have to be modified.
> Added rts5228.c rts5228.h for independent functions of the new chip rts5228

> +static void rts5228_init_from_cfg(struct rtsx_pcr *pcr)
> +{
> +	u32 lval;
> +	struct rtsx_cr_option *option = &pcr->option;
> +
> +	rtsx_pci_read_config_dword(pcr, PCR_ASPM_SETTING_REG1, &lval);
> +
> +
> +	if (0 == (lval & 0x0F))
> +		rtsx_pci_enable_oobs_polling(pcr);
> +	else
> +		rtsx_pci_disable_oobs_polling(pcr);
> +
> +	if (lval & ASPM_L1_1_EN_MASK)
> +		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
> +	else
> +		rtsx_clear_dev_flag(pcr, ASPM_L1_1_EN);
> +
> +	if (lval & ASPM_L1_2_EN_MASK)
> +		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
> +	else
> +		rtsx_clear_dev_flag(pcr, ASPM_L1_2_EN);
> +
> +	if (lval & PM_L1_1_EN_MASK)
> +		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
> +	else
> +		rtsx_clear_dev_flag(pcr, PM_L1_1_EN);
> +
> +	if (lval & PM_L1_2_EN_MASK)
> +		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
> +	else
> +		rtsx_clear_dev_flag(pcr, PM_L1_2_EN);

This looks like a bunch of driver-specific #defines that should be
using the PCI core #defines instead (PCI_L1SS_CTL1_ASPM_L1_1,
PCI_L1SS_CTL1_ASPM_L1_2, etc).

rtsx_pci_read_config_dword() adds very little value and obscures the
code unnecessarily.

PCR_ASPM_SETTING_REG1 probably should be removed and replaced with
something like pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS).

> +	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0xFF, 0);
> +	if (option->ltr_en) {
> +		u16 val;
> +
> +		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
> +		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
> +			option->ltr_enabled = true;
> +			option->ltr_active = true;
> +			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);

I do not believe this LTR programming is correct.  But I'd be glad to
be corrected with specific references to the spec.

One reason I don't think it's correct is because PCIe r5.0, sec 6.18,
says LTR must not be enabled unless the Root Complex and all
intermediate Switches indicate support for LTR.  I don't see any
checking for that here.

I *assume* that rtsx_set_ltr_latency() sets values in the LTR
Extended Capability.  That should be done with
pci_write_config_word(), not with rtsx_pci_write_register() as is done
in rtsx_comm_set_ltr_latency().  But maybe rtsx_set_ltr_latency()
isn't doing what I think it is.

I think the values programmed into the LTR Capability depend on some
platform-specific values that can only be learned from an ACPI _DSM;
see the PCI Firmware spec, v3.2, sec 4.6.6.

It looks like option->ltr_active_latency is always
LTR_ACTIVE_LATENCY_DEF (0x883C).  How did you derive that value?

All the LTR programming should be done by the PCI core.  The PCI core
does some of that, but not all.  We should work on getting support
done instead of spreading it around in drivers.

> +static void rts5228_enable_aspm(struct rtsx_pcr *pcr, bool enable)
> +{
> +	u8 mask, val;
> +
> +	if (pcr->aspm_enabled == enable)
> +		return;
> +
> +	mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
> +	val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
> +	val |= (pcr->aspm_en & 0x02);
> +	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
> +	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
> +					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
> +	pcr->aspm_enabled = enable;

ASPM configuration should also be done by the PCI core.

Correct ASPM configuration can only be done by looking at *both* ends
of the link.  The PCI core is in a position to do that, but individual
drivers really are not.

Bjorn
