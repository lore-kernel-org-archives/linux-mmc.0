From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 05/11] ARM: add generic PrimeCell interface to COH 901 318
	v5
Date: Wed, 14 Apr 2010 15:40:02 -0700
Message-ID: <r2re9c3a7c21004141540o90fcbb07ja92dffcd71364f8b@mail.gmail.com>
References: <1270681973-5763-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50847 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756070Ab0DNWkC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2010 18:40:02 -0400
In-Reply-To: <1270681973-5763-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: akpm@linux-foundation.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Apr 7, 2010 at 4:12 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This extends the DMA engine driver for the COH 901 318 used in the
> U300 platform with the generic PrimeCell interface.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> =A0drivers/dma/coh901318.c =A0 =A0 | =A0146 +++++++++++++++++++++++++=
++++++++++++++++++
> =A0drivers/dma/coh901318_lli.c | =A0 78 ++++++++++++++++++++++-
> =A02 files changed, 221 insertions(+), 3 deletions(-)
>
[..]
> diff --git a/drivers/dma/coh901318_lli.c b/drivers/dma/coh901318_lli.=
c
> index 9f7e0e6..f37db49 100644
> --- a/drivers/dma/coh901318_lli.c
> +++ b/drivers/dma/coh901318_lli.c
> @@ -153,6 +153,39 @@ coh901318_lli_fill_memcpy(struct coh901318_pool =
*pool,
> =A0 =A0 =A0 =A0lli->src_addr =3D src;
> =A0 =A0 =A0 =A0lli->dst_addr =3D dst;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The DMA hardware will increase its pointer by 1,
> + =A0 =A0 =A0 =A0* 2 or 4 bytes at a time depending on configuration.
> + =A0 =A0 =A0 =A0* If using som oddly-aligned buffer this will cause

s/som/some/

> + =A0 =A0 =A0 =A0* performance problems.
> + =A0 =A0 =A0 =A0*/
> +#if 0
> + =A0 =A0 =A0 ctrl_chained &=3D ~COH901318_CX_CTRL_SRC_BUS_SIZE_MASK;
> + =A0 =A0 =A0 ctrl_eom &=3D ~COH901318_CX_CTRL_SRC_BUS_SIZE_MASK;
> + =A0 =A0 =A0 ctrl_chained &=3D ~COH901318_CX_CTRL_DST_BUS_SIZE_MASK;
> + =A0 =A0 =A0 ctrl_eom &=3D ~COH901318_CX_CTRL_DST_BUS_SIZE_MASK;
> + =A0 =A0 =A0 if (src & 0x01) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_chained |=3D COH901318_CX_CTRL_SRC=
_BUS_SIZE_8_BITS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_eom |=3D COH901318_CX_CTRL_SRC_BUS=
_SIZE_8_BITS;
> + =A0 =A0 =A0 } else if (src & 0x02) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_chained |=3D COH901318_CX_CTRL_SRC=
_BUS_SIZE_16_BITS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_eom |=3D COH901318_CX_CTRL_SRC_BUS=
_SIZE_16_BITS;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_chained |=3D COH901318_CX_CTRL_SRC=
_BUS_SIZE_32_BITS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_eom |=3D COH901318_CX_CTRL_SRC_BUS=
_SIZE_32_BITS;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (dst & 0x01) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_chained |=3D COH901318_CX_CTRL_DST=
_BUS_SIZE_8_BITS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_eom |=3D COH901318_CX_CTRL_SRC_DST=
_SIZE_8_BITS;
> + =A0 =A0 =A0 } else if (dst & 0x02) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_chained |=3D COH901318_CX_CTRL_DST=
_BUS_SIZE_16_BITS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_eom |=3D COH901318_CX_CTRL_DST_BUS=
_SIZE_16_BITS;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_chained |=3D COH901318_CX_CTRL_DST=
_BUS_SIZE_32_BITS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_eom |=3D COH901318_CX_CTRL_DST_BUS=
_SIZE_32_BITS;
> + =A0 =A0 =A0 }
> +#endif

It looks like this bit twiddling code is duplicated three times.  Can
it be moved to a static inline in a header file and hide the #if 0
there as well.  I assume you want it for documentation purposes in
case someone in the future has an unaligned usage model?

--
Dan
