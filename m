From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v8 06/12] mmc: mmc_test: test to measure how sg_len affect performance
Date: Fri, 1 Jul 2011 15:33:19 +0200
Message-ID: <BANLkTimuvUcJyrO0S+Odmz2Vz0YDwyY9Mw@mail.gmail.com>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
	<1309248717-14606-7-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38979 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554Ab1GANdU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 09:33:20 -0400
In-Reply-To: <1309248717-14606-7-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Nickolay
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

On 28 June 2011 10:11, Per Forlin <per.forlin@linaro.org> wrote:
> test that measures how the mmc bandwidth depends on the numbers of sg=
 elements
> in the sg list. The transfer size if fixed and sg length goes from a =
few up
> to 512. The purpose is to measure overhead caused by multiple sg elem=
ents.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> =A0drivers/mmc/card/mmc_test.c | =A0151 +++++++++++++++++++++++++++++=
++++++++++----
> =A01 files changed, 139 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.=
c
> -static int mmc_test_map_sg(struct mmc_test_mem *mem, unsigned long s=
z,
> +static int mmc_test_map_sg(struct mmc_test_mem *mem, unsigned long s=
ize,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct scatterlis=
t *sglist, int repeat,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int max_=
segs, unsigned int max_seg_sz,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int *sg=
_len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int *sg=
_len, int min_sg_len)
> =A0{
> =A0 =A0 =A0 =A0struct scatterlist *sg =3D NULL;
> =A0 =A0 =A0 =A0unsigned int i;
> + =A0 =A0 =A0 unsigned long sz =3D size;
>
> =A0 =A0 =A0 =A0sg_init_table(sglist, max_segs);
> + =A0 =A0 =A0 if (min_sg_len > max_segs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_sg_len =3D max_segs;
>
> =A0 =A0 =A0 =A0*sg_len =3D 0;
> =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < mem->cnt; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long len =3D =
PAGE_SIZE << mem->arr[i].order;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (min_sg_len && (size=
 / min_sg_len < len))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D=
 size / min_sg_len;
Make aligned to 512
len =3D ALIGN(size / min_sg_len, 512);

I run into this issue running on arm realview with max test size 128k
instead of 128M.

/Per
