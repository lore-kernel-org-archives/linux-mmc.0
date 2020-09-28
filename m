Return-Path: <SRS0=Afy4=DF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4D8C2D0A8
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 04:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BC523A04
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 04:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbgI1Ep0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Sep 2020 00:45:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:5611 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgI1Ep0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 28 Sep 2020 00:45:26 -0400
IronPort-SDR: i/BiZ+JGWykzoQGaogWbOOAwAX30g2YNJxo6Pe+txDlvWYG4QNvov8gNl+Q+mVCVQKiTf+z6Qa
 AhLIIGg4fqAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="246679434"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="246679434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 21:45:25 -0700
IronPort-SDR: UCc8cpJld9j1FpmEDnccPMgkwXEwA6G0dzU/H0L8Mk0W+U29jp2BrUaG1NeS1L6Qc+jxi4sLCQ
 T+GgkxtDLJqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="456681001"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2020 21:45:23 -0700
Subject: Re: [PATCH] mmc: sdhci: Workaround broken command queuing on Intel
 GLK based IRBIS models
To:     Hans de Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     RussianNeuroMancer <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
References: <20200927104821.5676-1-hdegoede@redhat.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3a863b6a-b628-0c8c-f2f1-146e1565e533@intel.com>
Date:   Mon, 28 Sep 2020 07:44:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200927104821.5676-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/09/20 1:48 pm, Hans de Goede wrote:
> Commit bedf9fc01ff1 ("mmc: sdhci: Workaround broken command queuing on
> Intel GLK"), disabled command-queuing on Intel GLK based LENOVO models
> because of it being broken due to what is believed to be a bug in
> the BIOS.
> 
> It seems that the BIOS of some IRBIS models, including the IRBIS NB111
> model has the same issue, so disable command queuing there too.
> 
> Fixes: bedf9fc01ff1 ("mmc: sdhci: Workaround broken command queuing on Intel GLK")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209397
> Reported-and-tested-by: RussianNeuroMancer <russianneuromancer@ya.ru>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks Hans!

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index af413805bbf1..914f5184295f 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -794,7 +794,8 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
>  {
>  	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
> -	       dmi_match(DMI_BIOS_VENDOR, "LENOVO");
> +	       (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
> +		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
>  }
>  
>  static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
> 

