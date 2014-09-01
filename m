From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: mmc: mmci: Add qcom dml support to the driver.
Date: Mon, 01 Sep 2014 10:02:18 +0100
Message-ID: <5404361A.1080001@linaro.org>
References: <20140828132106.GB24477@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:43312 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbaIAJCV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Sep 2014 05:02:21 -0400
Received: by mail-we0-f178.google.com with SMTP id u57so5136867wes.37
        for <linux-mmc@vger.kernel.org>; Mon, 01 Sep 2014 02:02:20 -0700 (PDT)
In-Reply-To: <20140828132106.GB24477@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-mmc@vger.kernel.org

Hi Dan,

Thankyou for reporting this warning.

Both consumer_id and producer_id are supposed to be int instead of u32.
I will fix this.

Thanks,
srini

On 28/08/14 14:21, Dan Carpenter wrote:
> Hello Srinivas Kandagatla,
>
> The patch 4dd5a1e6dd12: "mmc: mmci: Add qcom dml support to the
> driver." from Jul 29, 2014, leads to the following static checker
> warning:
>
> 	drivers/mmc/host/mmci_qcom_dml.c:131 dml_hw_init()
> 	warn: unsigned 'producer_id' is never less than zero.
>
> drivers/mmc/host/mmci_qcom_dml.c
>     121  /* Initialize the dml hardware connected to SD Card controller */
>     122  int dml_hw_init(struct mmci_host *host, struct device_node *np)
>     123  {
>     124          u32 config;
>     125          void __iomem *base;
>     126          u32 consumer_id, producer_id;
>     127
>     128          consumer_id = of_get_dml_pipe_index(np, "tx");
>     129          producer_id = of_get_dml_pipe_index(np, "rx");
>     130
>     131          if (producer_id < 0 || consumer_id < 0)
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     132                  return -ENODEV;
>     133
>
> regards,
> dan carpenter
>
