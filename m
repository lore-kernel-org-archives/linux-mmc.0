From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: use mmc_of_parse and remove the card_tasklet
Date: Mon, 26 May 2014 10:28:06 +0200
Message-ID: <CAPDyKFqQHGRfiVgOK1qezUFYpvzK199dsM2Yk4w11Rie_EnfNw@mail.gmail.com>
References: <1401080308-19974-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:45132 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbaEZI2H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 04:28:07 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so11480583qgd.41
        for <linux-mmc@vger.kernel.org>; Mon, 26 May 2014 01:28:06 -0700 (PDT)
In-Reply-To: <1401080308-19974-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 26 May 2014 06:58, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Fix the compile error.
> (Removed the card_tasklet at "mmc: sdhci: push card_tasklet into trea=
ded irq handler")
>
> drivers/mmc/host/sdhci-s3c.c: In function =E2=80=98sdhci_s3c_notify_c=
hange=E2=80=99:
> drivers/mmc/host/sdhci-s3c.c:402:25: error: =E2=80=98struct sdhci_hos=
t=E2=80=99 has no member named =E2=80=98card_tasklet=E2=80=99
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Hi Jaehoon,

Thanks for fixing this issue, it looks good to me!

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Chris, can you pick this up?

Kind regards
Ulf Hansson
