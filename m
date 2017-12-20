From: Kalle Valo <kvalo@qca.qualcomm.com>
Subject: Re: [PATCH v6 2/4] ath6kl: change to use mmc api for accessing host
 supported maximum segment count and size
Date: Wed, 20 Dec 2017 15:40:11 +0000
Message-ID: <87d139h0h0.fsf@kamboji.qca.qualcomm.com>
References: <1513685211-640-1-git-send-email-huxm@marvell.com>
        <1513685211-640-2-git-send-email-huxm@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sabertooth01.qualcomm.com ([65.197.215.72]:13366 "EHLO
        sabertooth01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755271AbdLTPkU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Dec 2017 10:40:20 -0500
In-Reply-To: <1513685211-640-2-git-send-email-huxm@marvell.com> (Xinming Hu's
        message of "Tue, 19 Dec 2017 20:06:48 +0800")
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Xinming Hu <huxm@marvell.com>
Cc: Linux MMC <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Wright Feng <wright.feng@cypress.com>, Zhiyuan Yang <yangzy@marvell.com>, Tim Song <songtao@marvell.com>, Cathy Luo <cluo@marvell.com>, James Cao <jcao@marvell.com>, Ganapathi Bhat <gbhat@marvell.com>, Xu Wang <xwang4@marvell.com>, Bob Tan <tanbo@marvell.com>

Xinming Hu <huxm@marvell.com> writes:

> Using mmc standard api to get the host sg capability.
>
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> ---
> v6: separate driver patch from patch 1/4.
> ---
>  drivers/net/wireless/ath/ath6kl/sdio.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

I assume this will go via some other tree and I should not take this.
So:

Acked-by: Kalle Valo <kvalo@qca.qualcomm.com>

--=20
Kalle Valo=
