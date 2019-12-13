Return-Path: <SRS0=qhCx=2D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF17C43603
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Dec 2019 09:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D94624658
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Dec 2019 09:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLMJlB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:41:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:13865 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfLMJk7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 13 Dec 2019 04:40:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 01:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="265487330"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.169]) ([10.237.72.169])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2019 01:40:56 -0800
Subject: Re: [PATCH v3 4/7] mmc: sdhci: Add quirk for disabling DTO during
 erase command
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, zhang.chunyan@linaro.org, tony@atomide.com
References: <20191210095151.15441-1-faiz_abbas@ti.com>
 <20191210095151.15441-5-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <003f7e7a-a762-5355-9404-4a6655754fb0@intel.com>
Date:   Fri, 13 Dec 2019 11:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210095151.15441-5-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/12/19 11:51 am, Faiz Abbas wrote:
> Some controllers might prematurely issue a data timeout during an erase
> command. Add a quirk to disable the interrupt when an erase command is
> issued.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 5 +++++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6f3d4991bee1..b8934c50b9c4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1532,6 +1532,11 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	/* Initially, a command has no error */
>  	cmd->error = 0;
>  
> +	if (cmd->opcode == MMC_ERASE &&
> +	    (host->quirks2 & SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE)) {
> +		sdhci_set_data_timeout_irq(host, false);
> +	}

If you factor out __sdhci_set_timeout() like below then
you could implement ->set_timeout() to do this.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ad6d2f93aa0b..389e3239eadc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1002,27 +1002,28 @@ static void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
-static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
-	u8 count;
-
-	if (host->ops->set_timeout) {
-		host->ops->set_timeout(host, cmd);
-	} else {
-		bool too_big = false;
-
-		count = sdhci_calc_timeout(host, cmd, &too_big);
+	bool too_big = false;
+	u8 count = sdhci_calc_timeout(host, cmd, &too_big);
+
+	if (too_big && host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
+		sdhci_calc_sw_timeout(host, cmd);
+		sdhci_set_data_timeout_irq(host, false);
+	} else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
+		sdhci_set_data_timeout_irq(host, true);
+	}
 
-		if (too_big &&
-		    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
-			sdhci_calc_sw_timeout(host, cmd);
-			sdhci_set_data_timeout_irq(host, false);
-		} else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
-			sdhci_set_data_timeout_irq(host, true);
-		}
+	sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
+}
+EXPORT_SYMBOL_GPL(__sdhci_set_timeout);
 
-		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
-	}
+static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	if (host->ops->set_timeout)
+		host->ops->set_timeout(host, cmd);
+	else
+		__sdhci_set_timeout(host, cmd);
 }
 
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)



> +
>  	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
>  	    cmd->opcode == MMC_STOP_TRANSMISSION)
>  		cmd->flags |= MMC_RSP_BUSY;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b28706a1bc6f..beda9afba3a6 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -482,6 +482,8 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/* Controller needs to disable DTO for erase command */
> +#define SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE		(1<<19)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 

