From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/7] DMAENGINE: add generic PrimeCell interface to COH 901
	318 v6
Date: Tue, 11 May 2010 09:37:42 -0700
Message-ID: <AANLkTinAVhnpjgVTtbZYYKb1t_DInVwTKkkJRzcO97RX@mail.gmail.com>
References: <1272848076-28315-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:65338 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab0EKQhm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2010 12:37:42 -0400
In-Reply-To: <1272848076-28315-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 2, 2010 at 5:54 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This extends the DMA engine driver for the COH 901 318 used in the
> U300 platform with the generic PrimeCell interface.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> =A0drivers/dma/coh901318.c | =A0146 +++++++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 146 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
> index 4233440..1d5ed16 100644
> --- a/drivers/dma/coh901318.c
> +++ b/drivers/dma/coh901318.c
[..]
> +void dma_set_ambaconfig(struct dma_chan *chan,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct amba_dma_channel=
_config *config)

What happens when two primecell dma devices are present on one soc?
Can that happen?  In that case we'll have conflicting providers of
dma_set_ambaconfig().

--
Dan
