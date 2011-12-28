From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 1/1] mmc: Check to disable IOCTL when card is mounted
Date: Wed, 28 Dec 2011 06:11:58 -0500
Message-ID: <CAF=Qhp278yeSx3Ev5Zr9cCUb7xZ2JZmr5CjV=EWjfvrmRP35Qw@mail.gmail.com>
References: <1325069180-16319-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45197 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab1L1LMU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Dec 2011 06:12:20 -0500
Received: by yenm11 with SMTP id m11so7038641yen.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Dec 2011 03:12:19 -0800 (PST)
In-Reply-To: <1325069180-16319-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar hiremath <shashidharh@vayavyalabs.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <awarkentin@vmware.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org

On Wed, Dec 28, 2011 at 5:46 AM, Shashidhar hiremath
<shashidharh@vayavyalabs.com> wrote:
> From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>
> The Patch adds a check to disable the IOCTL from running when the car=
d is mounted
> or device is opened elsewhere.
>
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
> =A0drivers/mmc/card/block.c | =A0 =A06 ++++++
> =A01 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 0cad48a..e680929 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -387,6 +387,12 @@ static int mmc_blk_ioctl_cmd(struct block_device=
 *bdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto cmd_done;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 /* Disallow the IOCTL run if card is already mounted or=
 device is
> + =A0 =A0 =A0 =A0* opened elsewhere */

=46ix multi line comment
Can refer : Documentation/kernel-doc-nano-HOWTO.txt

> + =A0 =A0 =A0 if (md->usage > 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto cmd_done;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0card =3D md->queue.card;
> =A0 =A0 =A0 =A0if (IS_ERR(card)) {
> --
> 1.7.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
