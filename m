From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: use mmc_of_parse and remove the card_tasklet
Date: Mon, 2 Jun 2014 11:07:58 +0200
Message-ID: <CAPDyKFrgRbEGyDiUTDfmXX+FXHLiED7J62h1YetaHnac20oi5g@mail.gmail.com>
References: <1401080308-19974-1-git-send-email-jh80.chung@samsung.com>
	<CAPDyKFqQHGRfiVgOK1qezUFYpvzK199dsM2Yk4w11Rie_EnfNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:61005 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbaFBJH7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jun 2014 05:07:59 -0400
Received: by mail-qa0-f51.google.com with SMTP id w8so2273383qac.38
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jun 2014 02:07:58 -0700 (PDT)
In-Reply-To: <CAPDyKFqQHGRfiVgOK1qezUFYpvzK199dsM2Yk4w11Rie_EnfNw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 26 May 2014 10:28, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 26 May 2014 06:58, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Fix the compile error.
>> (Removed the card_tasklet at "mmc: sdhci: push card_tasklet into tre=
aded irq handler")
>>
>> drivers/mmc/host/sdhci-s3c.c: In function =E2=80=98sdhci_s3c_notify_=
change=E2=80=99:
>> drivers/mmc/host/sdhci-s3c.c:402:25: error: =E2=80=98struct sdhci_ho=
st=E2=80=99 has no member named =E2=80=98card_tasklet=E2=80=99
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> Hi Jaehoon,
>
> Thanks for fixing this issue, it looks good to me!
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Chris, can you pick this up?

Chris, ping!

Please make sure to include this one in the PR for 3.16 to Linus.

Kind regards
Uffe
