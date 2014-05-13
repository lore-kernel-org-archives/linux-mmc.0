From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 07/11] mmc: mmci: move ST specific register extensions
 access under condition.
Date: Tue, 13 May 2014 10:08:40 +0200
Message-ID: <CACRpkdbgScfdLUc64a0r4Jxq9UHCbmMiAwD_G1-LZq8B58sX7g@mail.gmail.com>
References: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1398759627-13256-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:58154 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbaEMIIl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 May 2014 04:08:41 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so9586731oag.13
        for <linux-mmc@vger.kernel.org>; Tue, 13 May 2014 01:08:40 -0700 (PDT)
In-Reply-To: <1398759627-13256-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, agross@quicinc.com, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Tue, Apr 29, 2014 at 10:20 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch moves some of the ST specific register extensions access under
> condition, so that other SOCs like Qualcomm or ARM would not a side effect of
> writing to those reserved/different purpose bits.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
(...)

>         /* Keep ST Micro busy mode if enabled */
> -       datactrl |= host->datactrl_reg & MCI_ST_DPSM_BUSYMODE;
> +       if (host->hw_designer == AMBA_VENDOR_ST)
> +               datactrl |= host->datactrl_reg & MCI_ST_DPSM_BUSYMODE;

Do not hard-check the hw_designer everywhere, follow the pattern
if storing special stuff in the variant data.

struct variant_data {
        u32 datactrl_mask_busymode;
(...)

static struct variant_data variant_u300 = {
        .datactrl_mask_busymode = MCI_ST_DPSM_BUSYMODE,
(...)
static struct variant_data variant_nomadik = {
        .datactrl_mask_busymode = MCI_ST_DPSM_BUSYMODE,
(...)
static struct variant_data variant_ux500 = {
        .datactrl_mask_busymode = MCI_ST_DPSM_BUSYMODE,
(...)
static struct variant_data variant_ux500v2 = {
        .datactrl_mask_busymode = MCI_ST_DPSM_BUSYMODE,
(...)

Then end up like this:

>         /* Keep ST Micro busy mode if enabled */
> -       datactrl |= host->datactrl_reg & MCI_ST_DPSM_BUSYMODE;
> +      datactrl |= host->datactrl_reg & host->vendor->datactrl_mask_busymode;

OK we know this should have been done like this from the beginning
but that is not an excuse not to fix it up now.

> -       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
> +       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 &&
> +           host->hw_designer == AMBA_VENDOR_ST)
>                 datactrl |= MCI_ST_DPSM_DDRMODE;

Same pattern here.

Actually I think this is only available on Ux500v2 (Ulf? Can you verify
this) so it is probably plain wrong to do it for other variants.

struct variant_data {
        u32 datactrl_ddrmode;
(...)
static struct variant_data variant_ux500v2 = {
        .datactrl_ddrmode = MCI_ST_DPSM_DDRMODE,
(...)

Then end up like this:

>        if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
> -                datactrl |= MCI_ST_DPSM_DDRMODE;
> +               datactrl |= host->vendor->datactrl_ddrmode;

Yours,
Linus Walleij
