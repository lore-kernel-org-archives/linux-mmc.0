From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pxa: Add device tree support
Date: Thu, 21 Jun 2012 11:03:25 +0800
Message-ID: <CAN1soZxVEu5dO8ZuRZ241a+0x0X+tC-DaO+QiLzS4=Knyym7PA@mail.gmail.com>
References: <8762aw1hcw.fsf@octavius.laptop.org>
	<874nq65y8x.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51667 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758105Ab2FUDD0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jun 2012 23:03:26 -0400
Received: by bkcji2 with SMTP id ji2so107501bkc.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jun 2012 20:03:25 -0700 (PDT)
In-Reply-To: <874nq65y8x.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Philip Rakity <prakity@marvell.com>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, wmb@laptop.org

On Wed, Jun 20, 2012 at 1:49 PM, Chris Ball <cjb@laptop.org> wrote:
> Tested on an OLPC XO-1.75. =A0(MMP2, sdhci-pxav3, CONFIG_MACH_MMP2_DT=
=3Dy)
>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
> Changes since v1:
>
> * Add CONFIG_OF guard around of_match_table, per Zhangfei.
> * Fix function prototypes under !CONFIG_OF, per Zhangfei.
> * Change "clk-delay-cycles" to "mrvl,clk-delay-cycles", per Haojian.
>
> =A0.../devicetree/bindings/mmc/sdhci-pxa.txt =A0 =A0 =A0 =A0 =A0| =A0=
 21 ++++++++
> =A0drivers/mmc/host/sdhci-pxav2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 54 ++++++++++++++++++++
> =A0drivers/mmc/host/sdhci-pxav3.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 52 +++++++++++++++++++
> =A03 files changed, 127 insertions(+)

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
