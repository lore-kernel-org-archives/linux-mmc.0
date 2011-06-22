From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v7 03/11] mmci: implement pre_req() and post_req()
Date: Wed, 22 Jun 2011 12:01:56 +0200
Message-ID: <BANLkTikU_gToOwzVrb3jUpJX9-XucLsNoQ@mail.gmail.com>
References: <1308699521-20556-1-git-send-email-per.forlin@linaro.org>
	<1308699521-20556-4-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42028 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab1FVKB4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2011 06:01:56 -0400
In-Reply-To: <1308699521-20556-4-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Venkatraman S <sv>
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

On 22 June 2011 01:38, Per Forlin <per.forlin@linaro.org> wrote:
> pre_req() runs dma_map_sg() and prepares the dma descriptor
> for the next mmc data transfer. post_req() runs dma_unmap_sg.
> If not calling pre_req() before mmci_request(), mmci_request()
> will prepare the cache and dma just like it did it before.
> It is optional to use pre_req() and post_req() for mmci.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> =A0drivers/mmc/host/mmci.c | =A0146 +++++++++++++++++++++++++++++++++=
+++++++++----
> =A0drivers/mmc/host/mmci.h | =A0 =A08 +++
> =A02 files changed, 141 insertions(+), 13 deletions(-)
>
=2E..
> @@ -1005,6 +1123,8 @@ static int __devinit mmci_probe(struct amba_dev=
ice *dev,
> =A0 =A0 =A0 =A0host->gpio_cd =3D -ENOSYS;
> =A0 =A0 =A0 =A0host->gpio_cd_irq =3D -1;
>
> + =A0 =A0 =A0 host->next_data.cookie =3D 1;
> +
Doesn't compile without DMA_ENGINE. Issue reported by Nickolay.

I simply move the initialization to mmci_dma_setup. I will update in
the next patchset.

@@ -215,6 +215,9 @@ static void __devinit mmci_dma_setup(struct mmci_ho=
st *host)
+       /* initialize pre request cookie */
+       host->next_data.cookie =3D 1;
+
@@ -1121,8 +1124,6 @@ static int __devinit mmci_probe(struct amba_devic=
e *dev,
-       host->next_data.cookie =3D 1;
