From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: asdf
Date: Tue, 6 Dec 2011 17:48:09 +0900
Message-ID: <CAH9JG2VSKUSkiN78bPnGym908UeH+P7r+6WRroRWqt7ubrNahg@mail.gmail.com>
References: <20111206080842.GA10021@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45911 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933014Ab1LFIsJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 03:48:09 -0500
Received: by dadv6 with SMTP id v6so4970588dad.19
        for <linux-mmc@vger.kernel.org>; Tue, 06 Dec 2011 00:48:09 -0800 (PST)
In-Reply-To: <20111206080842.GA10021@elgon.mountain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org

Hi

Yes possible scenario, it should be changed like this.

out:
        if (err =3D=3D -EIO) {
                int ret =3D !mmc_blk_reset(md, card->host, type);
                if (ret && !mmc_can_sanitize(card))
                        goto retry;
        }

anyway, I will find the more fancy way.

Thank you for pointing out.

BR,
Kyungmin Park

On 12/6/11, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> There is a new gcc warning in this function:
>
> drivers/mmc/card/block.c:836:18: warning: =91arg=92 may be used unini=
tialized in
> this function [-Wuninitialized]
>
>    810          /* The sanitize operation is supported at v4.5 only *=
/
>    811          if (mmc_can_sanitize(card)) {
>    812                  err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORM=
AL,
>    813                                  EXT_CSD_SANITIZE_START, 1, 0)=
;
>
> 1) arg is uninitialized here.  mmc_switch() can return -EIO.
>
>    814                  goto out;
>    815          }
>    816
>    817          from =3D blk_rq_pos(req);
>    818          nr =3D blk_rq_sectors(req);
>    819
>    820          if (mmc_can_trim(card) && !mmc_erase_group_aligned(ca=
rd,
> from, nr))
>    821                  arg =3D MMC_SECURE_TRIM1_ARG;
>    822          else
>    823                  arg =3D MMC_SECURE_ERASE_ARG;
>    824  retry:
>    825          if (card->quirks & MMC_QUIRK_INAND_CMD38) {
>    826                  err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORM=
AL,
>    827                                   INAND_CMD38_ARG_EXT_CSD,
>    828                                   arg =3D=3D MMC_SECURE_TRIM1_=
ARG ?
>                                          ^^^
>
> 3) uninitialized.
>
>    829                                   INAND_CMD38_ARG_SECTRIM1 :
>    830                                   INAND_CMD38_ARG_SECERASE,
>    831                                   0);
>    832                  if (err)
>    833                          goto out;
>    834          }
>    835          err =3D mmc_erase(card, from, nr, arg);
>    836          if (!err && arg =3D=3D MMC_SECURE_TRIM1_ARG) {
>    837                  if (card->quirks & MMC_QUIRK_INAND_CMD38) {
>    838                          err =3D mmc_switch(card,
> EXT_CSD_CMD_SET_NORMAL,
>    839                                           INAND_CMD38_ARG_EXT_=
CSD,
>    840                                           INAND_CMD38_ARG_SECT=
RIM2,
>    841                                           0);
>    842                          if (err)
>    843                                  goto out;
>    844                  }
>    845                  err =3D mmc_erase(card, from, nr,
> MMC_SECURE_TRIM2_ARG);
>    846          }
>    847  out:
>    848          if (err =3D=3D -EIO && !mmc_blk_reset(md, card->host,=
 type))
>    849                  goto retry;
>
> 2) We could maybe hit the goto retry here if the reset works.
>
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
