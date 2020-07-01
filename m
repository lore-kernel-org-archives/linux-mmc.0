Return-Path: <SRS0=joLi=AM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E17C433E1
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 09:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A0120722
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 09:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgGAJTl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:19:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:15460 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGAJTk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Jul 2020 05:19:40 -0400
IronPort-SDR: KyJ/H281TakdL+Tq4c1tQ6WkhIBqc63+9+lfbxgydPgS6X4jBHfsAxobp+UYu7Wo/s2Ol+6yiq
 7RicGGW1PY7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="148077340"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="148077340"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 02:19:40 -0700
IronPort-SDR: 2dcJ90JTQ4G75aBU6wtnpsQrZYs7a4rpxYeViL1qL5k+VlnDXw2EZFD4sJZhBSFUgiI5GrASC5
 hJbfbtBNB0dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="425522448"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga004.jf.intel.com with ESMTP; 01 Jul 2020 02:19:38 -0700
Subject: Re: [PATCH 1/1] mmc: host: sdhci-msm: fix spelling mistake
To:     Flavio Suligoi <f.suligoi@asem.it>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200617151938.30217-1-f.suligoi@asem.it>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a43236c1-437b-ee72-f21e-b9687512ed48@intel.com>
Date:   Wed, 1 Jul 2020 12:19:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200617151938.30217-1-f.suligoi@asem.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/06/20 6:19 pm, Flavio Suligoi wrote:
> Fix typo: "trigered" --> "triggered"
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index b277dd7fbdb5..3f615d0ccb61 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1362,7 +1362,7 @@ static inline void sdhci_msm_complete_pwr_irq_wait(
>   * To what state the register writes will change the IO lines should be passed
>   * as the argument req_type. This API will check whether the IO line's state
>   * is already the expected state and will wait for power irq only if
> - * power irq is expected to be trigerred based on the current IO line state
> + * power irq is expected to be triggered based on the current IO line state
>   * and expected IO line state.
>   */
>  static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
> 

