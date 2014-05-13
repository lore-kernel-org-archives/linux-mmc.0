From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 02/11] mmc: mmci: Add Qualcomm Id to amba id table
Date: Tue, 13 May 2014 09:17:42 +0200
Message-ID: <CACRpkdZr1MP2CL-609iJnv=MRHDhK554Hui5U77_SSUf7ARUqg@mail.gmail.com>
References: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1398759556-13056-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:41628 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbaEMHRm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 May 2014 03:17:42 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so9531231oac.11
        for <linux-mmc@vger.kernel.org>; Tue, 13 May 2014 00:17:42 -0700 (PDT)
In-Reply-To: <1398759556-13056-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, agross@quicinc.com, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Tue, Apr 29, 2014 at 10:19 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds a fake Qualcomm ID 0x00051180 to the amba_ids, as Qualcomm
> SDCC controller is pl180, but amba id registers read 0x0's.
> The plan is to remove SDCC driver totally and use mmci as the main SD
> controller driver for Qualcomm SOCs.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
