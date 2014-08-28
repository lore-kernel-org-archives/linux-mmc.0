From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: mmci: Add qcom dml support to the driver.
Date: Thu, 28 Aug 2014 16:21:06 +0300
Message-ID: <20140828132106.GB24477@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42474 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbaH1NVH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Aug 2014 09:21:07 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: linux-mmc@vger.kernel.org

Hello Srinivas Kandagatla,

The patch 4dd5a1e6dd12: "mmc: mmci: Add qcom dml support to the
driver." from Jul 29, 2014, leads to the following static checker
warning:

	drivers/mmc/host/mmci_qcom_dml.c:131 dml_hw_init()
	warn: unsigned 'producer_id' is never less than zero.

drivers/mmc/host/mmci_qcom_dml.c
   121  /* Initialize the dml hardware connected to SD Card controller */
   122  int dml_hw_init(struct mmci_host *host, struct device_node *np)
   123  {
   124          u32 config;
   125          void __iomem *base;
   126          u32 consumer_id, producer_id;
   127  
   128          consumer_id = of_get_dml_pipe_index(np, "tx");
   129          producer_id = of_get_dml_pipe_index(np, "rx");
   130  
   131          if (producer_id < 0 || consumer_id < 0)
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   132                  return -ENODEV;
   133  

regards,
dan carpenter
