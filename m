From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: Warnings for invalid VDD (sdhci-s3c)
Date: Thu, 24 Mar 2016 15:58:40 +0800
Message-ID: <20160324155840.50474b98@xhacker>
References: <CAJKOXPcGDnPm-Ykh6wHqV1YxfTaov5E8iVqBoBn4OJc7BnhgEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35321 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751419AbcCXICg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 04:02:36 -0400
In-Reply-To: <CAJKOXPcGDnPm-Ykh6wHqV1YxfTaov5E8iVqBoBn4OJc7BnhgEQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, ludovic.desroches@atmel.com
Cc: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

On Thu, 24 Mar 2016 16:28:56 +0900 Krzysztof Kozlowski wrote:

> Hi,
> 
> After 918f4cbd4340 ("mmc: sdhci: restore behavior when setting VDD via
> external regulator") On Trats2 board I see warnings for invalid VDD
> value (2.8V):
> 
> [    3.119656] ------------[ cut here ]------------
> [    3.119666] WARNING: CPU: 3 PID: 90 at
> ../drivers/mmc/host/sdhci.c:1234 sdhci_do_set_ios+0x4cc/0x5e0
> [    3.119669] mmc0: Invalid vdd 0x10

Per my understanding, the wrong vdd indicates a wrong ocr, what's the voltage of
this host's vmmc regulator?

Thanks,
Jisheng
