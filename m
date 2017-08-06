From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] mmc: mmci_qcom_dml: include mmci_qcom_dml.h and fix
 #ifdef
Date: Sun, 6 Aug 2017 11:26:53 +0100
Message-ID: <3b5755df-b94b-741e-81d1-9a13c6f18fd1@linaro.org>
References: <1501853664-10752-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a0r7jPBF_eAMrm7u-3N224zPsd4k=SeAqXFVViXBUOhnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33961 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdHFK05 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Aug 2017 06:26:57 -0400
Received: by mail-wr0-f181.google.com with SMTP id 12so30096852wrb.1
        for <linux-mmc@vger.kernel.org>; Sun, 06 Aug 2017 03:26:56 -0700 (PDT)
In-Reply-To: <CAK8P3a0r7jPBF_eAMrm7u-3N224zPsd4k=SeAqXFVViXBUOhnw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Russell King - ARM Linux <linux@armlinux.org.uk>



On 04/08/17 23:10, Arnd Bergmann wrote:
> How about linking the DML code into the mmci module and making that
> Kconfig option a 'bool'?


Yes, I think making this bool and exporting the two symbols should fix 
this. It does not make sense to make dml helpers a module anyway.

If it sounds okay, I can send a proper patch to fix this.

------------------------>cut<-----------------------------------

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5755b69..3345384 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -15,7 +15,7 @@ config MMC_ARMMMCI
           If unsure, say N.

  config MMC_QCOM_DML
-       tristate "Qualcomm Data Mover for SD Card Controller"
+       bool "Qualcomm Data Mover for SD Card Controller"
         depends on MMC_ARMMMCI && QCOM_BAM_DMA
         default y
         help
diff --git a/drivers/mmc/host/mmci_qcom_dml.c 
b/drivers/mmc/host/mmci_qcom_dml.c
index 00750c9..e7d9c74 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -97,6 +97,7 @@ void dml_start_xfer(struct mmci_host *host, struct 
mmc_data *data)
         /* make sure the dml is configured before dma is triggered */
         wmb();
  }
+EXPORT_SYMBOL_GPL(dml_start_xfer);

  static int of_get_dml_pipe_index(struct device_node *np, const char *name)
  {
@@ -175,3 +176,4 @@ int dml_hw_init(struct mmci_host *host, struct 
device_node *np)

         return 0;
------------------------>cut<-----------------------------------


thanks,
srini
