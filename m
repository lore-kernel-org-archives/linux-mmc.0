From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 11/12] mmc: mmci: Add Qcom specific rx_fifocnt logic.
Date: Wed, 11 Jun 2014 14:52:02 +0200
Message-ID: <CACRpkdZ-gjoJxnAWNHFzkaRWGvrC0nePBQyBhZ41oWYv1tRxAw@mail.gmail.com>
References: <1401699818-11329-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1401700204-11876-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:54179 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbaFKMwD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jun 2014 08:52:03 -0400
Received: by mail-ob0-f180.google.com with SMTP id vb8so5078785obc.39
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jun 2014 05:52:02 -0700 (PDT)
In-Reply-To: <1401700204-11876-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Mon, Jun 2, 2014 at 11:10 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> MCIFIFOCNT register behaviour on Qcom chips is very different than the other
> pl180 integrations. MCIFIFOCNT register contains the number of
> words that are still waiting to be transferred through the FIFO. It keeps
> decrementing once the host CPU reads the MCIFIFO. With the existing logic and
> the MCIFIFOCNT behaviour, mmci_pio_read will loop forever, as the FIFOCNT
> register will always return transfer size before reading the FIFO.
>
> Also the data sheet states that "This register is only useful for debug
> purposes and should not be used for normal operation since it does not reflect
> data which may or may not be in the pipeline".
>
> This patch implements a qcom specific get_rx_fifocnt function which is
> implemented based on status register flags. Based on qcom_fifo flag in
> variant data structure, the corresponding get_rx_fifocnt function is selected.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
