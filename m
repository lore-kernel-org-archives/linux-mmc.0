From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0002/0003] mmc: Replace "enhanced_area_en" attribute by "partition_setting_completed"
Date: Thu, 11 Sep 2014 11:46:08 +0200
Message-ID: <CAPDyKFpj_c+9boHTQZo1Mr0OEv+7rd4m9LXVDKdj7quL-LMa1A@mail.gmail.com>
References: <53C7E45E.2060102@neotion.com>
	<CAPDyKFoRpQBHGGCMPvEKdeVGjTO-rnyYVostLZGCV3dudD1rmA@mail.gmail.com>
	<53EB2DC3.2080002@neotion.com>
	<CAPDyKFpjYqVUZ8GHB76gD8pOx_eMg9ecvbWrMEfbhEd5ffk7mw@mail.gmail.com>
	<53ECB95F.2030207@neotion.com>
	<CAPDyKFp2ekmucHVzMWxeKfyTmuFKTXAYwUEpL5QxvEh8AjFopg@mail.gmail.com>
	<53F1FBA3.6060108@neotion.com>
	<54114362.2080709@neotion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:54461 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbaIKJqJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Sep 2014 05:46:09 -0400
Received: by mail-qa0-f54.google.com with SMTP id v10so7814qac.13
        for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2014 02:46:08 -0700 (PDT)
In-Reply-To: <54114362.2080709@neotion.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?R3LDqWdvcnkgU291dGFkw6k=?= <gsoutade@neotion.com>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 11 September 2014 08:38, Gr=C3=A9gory Soutad=C3=A9 <gsoutade@neotion=
=2Ecom> wrote:
> Replace ext_csd "enhanced_area_en" attribute by
>  "partition_setting_completed". It was used whether or
>  not enhanced user area is defined and without checks of
>  EXT_CSD_PARTITION_SETTING_COMPLETED bit.
>
> Signed-off-by: Gr=C3=A9gory Soutad=C3=A9 <gsoutade@neotion.com>

This patch doesn't compile.

I also think you could work a bit on the commit messages in this
patchset. Try to describe what the patches do and why. I may help you
- if you like.

> ---
>  drivers/mmc/core/mmc.c   |    9 ++++++++-
>  include/linux/mmc/card.h |    2 +-
>  include/linux/mmc/mmc.h  |    2 ++
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 77b4cf3..3578e35 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -488,6 +488,13 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d, u8 *ext_csd)
>                 ext_csd[EXT_CSD_TRIM_MULT];
>         card->ext_csd.raw_partition_support =3D ext_csd[EXT_CSD_PARTI=
TION_SUPPORT];
>         if (card->ext_csd.rev >=3D 4) {
> +               if (ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED] &
> +                   EXT_CSD_PART_SETTING_COMPLETED) {

No need for brackets if this if-else, please remove.

> +                       card->ext_csd.partition_setting_completed =3D=
 1;
> +               } else {
> +                       card->ext_csd.partition_setting_completed =3D=
 0;
> +               }
> +
>                 mmc_manage_enhanced_area(card, ext_csd);
>
>                 mmc_manage_gp_partitions(card, ext_csd);

[...]

Kind regards
Uffe
