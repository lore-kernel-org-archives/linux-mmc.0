From: Will Newton <will.newton@gmail.com>
Subject: Re: [RFC PATCH 1/1] dw_mmc: add quirk about using only one slot
Date: Fri, 25 Mar 2011 10:00:10 +0000
Message-ID: <AANLkTimEsgDF+4j0d_UccyqjsbgriFW4AqBfmE5rPrRH@mail.gmail.com>
References: <4D8C2F83.4040403@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38205 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148Ab1CYKAL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 06:00:11 -0400
Received: by iyb14 with SMTP id 14so338272iyb.19
        for <linux-mmc@vger.kernel.org>; Fri, 25 Mar 2011 03:00:11 -0700 (PDT)
In-Reply-To: <4D8C2F83.4040403@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Fri, Mar 25, 2011 at 6:00 AM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> If assume only using one slot, i think that dw_mci_queue_request() ne=
ed not.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com
> ---
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0 =A09 +++++++--
> =A0include/linux/mmc/dw_mmc.h | =A0 =A03 ++-
> =A02 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 882d004..e3f26ea 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -673,8 +673,13 @@ static void dw_mci_request(struct mmc_host *mmc,=
 struct mmc_request *mrq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* We don't support multiple blocks of weird lengths. *=
/
> - =A0 =A0 =A0 dw_mci_queue_request(host, slot, mrq);
> + =A0 =A0 =A0 if (host->quirks & DW_MCI_QUIRK_FORCE_ONE_SLOT) {

Do we really need a quirk for this? Why not use host->num_slots?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 slot->mrq =3D mrq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->state =3D STATE_SENDING_CMD;

I don't think it is safe to manipulate these structures without taking
the host->lock. If we are to do this then I think I would like to know
why (e.g. do we have performance numbers to support this change) and
some analysis of what is protected by host->lock and which functions
need the lock to be held. For example I do not think it is safe to
call dw_mci_start_request without taking the lock.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_start_request(host, slot);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We don't support multiple blocks of =
weird lengths. */

This comment is obsolete I think and can be removed.
