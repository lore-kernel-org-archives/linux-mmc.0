From: "Torne (Richard Coles)" <torne@google.com>
Subject: Re: [PATCH] MMC: sdhci: remove too large timeout warning
Date: Thu, 22 Mar 2012 13:42:03 +0000
Message-ID: <CAEV-rjcyk6wTLRiwDiErUk5XM7jt8VNH4Hk2CRrx5AzmP_Df+A@mail.gmail.com>
References: <1331029648-29175-1-git-send-email-torne@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49627 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481Ab2CVNmE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Mar 2012 09:42:04 -0400
Received: by iagz16 with SMTP id z16so3131026iag.19
        for <linux-mmc@vger.kernel.org>; Thu, 22 Mar 2012 06:42:04 -0700 (PDT)
In-Reply-To: <1331029648-29175-1-git-send-email-torne@google.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Torne (Richard Coles)" <torne@google.com>

Ping.. anyone interested in this patch? :) It's been a couple weeks
with no response.

It still applies cleanly to the current tree.

On 6 March 2012 10:27, Torne (Richard Coles) <torne@google.com> wrote:
> From: "Torne (Richard Coles)" <torne@google.com>
>
> Some MMC cards specify timeouts that are larger than the highest
> possible timeout in the host controller. sdhci is the only host
> controller driver which complains about this; remove the warning to
> match the behaviour of the other drivers.
>
> Signed-off-by: Torne (Richard Coles) <torne@google.com>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 =A02 --
> =A01 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8d66706..85d4d05 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -680,8 +680,6 @@ static u8 sdhci_calc_timeout(struct sdhci_host *h=
ost, struct mmc_command *cmd)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (count >=3D 0xF) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Too large timeout reque=
sted for CMD%d!\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(host->mmc),=
 cmd->opcode);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count =3D 0xE;
> =A0 =A0 =A0 =A0}
>
> --
> 1.7.7.3
>



--=20
Torne (Richard Coles)
torne@google.com
