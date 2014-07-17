From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1] mmc: mmci: Add qcom dml support to the driver.
Date: Thu, 17 Jul 2014 20:41:05 +0100
Message-ID: <53C826D1.1020609@linaro.org>
References: <1405079306-1406-1-git-send-email-srinivas.kandagatla@linaro.org> <1405625780-13503-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:39381 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897AbaGQTlJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jul 2014 15:41:09 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so126954wiw.3
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jul 2014 12:41:07 -0700 (PDT)
In-Reply-To: <1405625780-13503-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org


On 17/07/14 20:36, Srinivas Kandagatla wrote:
> On Qualcomm APQ8064 SOCs, SD card controller has an additional glue
> called DML (Data Mover Local/Lite) to assist dma transfers.
> This hardware needs to be setup before any dma transfer is requested.
> DML itself is not a DMA engine, its just a gule between the SD card
> controller and dma controller.
>
> Most of this code has been ported from qualcomm's 3.4 kernel.
>
> This patch adds the code necessary to intialize the hardware and setup
> before doing any dma transfers.
>
> Tested-by: Prakash Burla <prakash.burla@smartplayin.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Here is the change log which I forgot in the original patch

Changes since RFC:
	- Moved	qcom_dml.* to mmci_qcom_dml.* as suggested by Linus W.
	- added BAM DMA dependency in Kconfig as suggested by Linus W
	


>   drivers/mmc/host/Kconfig         |  11 +++
>   drivers/mmc/host/Makefile        |   1 +
>   drivers/mmc/host/mmci.c          |  19 ++++-
>   drivers/mmc/host/mmci_qcom_dml.c | 171 +++++++++++++++++++++++++++++++++++++++
>   drivers/mmc/host/mmci_qcom_dml.h |  17 ++++
>   5 files changed, 218 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/mmc/host/mmci_qcom_dml.c
>   create mode 100644 drivers/mmc/host/mmci_qcom_dml.h
>


thanks,
srini
