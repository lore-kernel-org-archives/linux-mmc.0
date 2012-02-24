From: Will Newton <will.newton@gmail.com>
Subject: Re: [RFC] mmc: dw_mmc: Fix the max_blk_count in IDMAC
Date: Fri, 24 Feb 2012 11:34:53 +0000
Message-ID: <CAFbHwiRagAH7Hp6V6367CRfAxCBtC26OO19tAhCe6jUtAxb4Jw@mail.gmail.com>
References: <000301ccf1fc$64e5dbe0$2eb193a0$%jun@samsung.com>
	<CAFbHwiT_KTWBLUSDbfMvuK0UEa_RrVqVF5V1WBqm+5c39Rtnqg@mail.gmail.com>
	<000c01ccf287$0868bb90$193a32b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63979 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab2BXLex convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Feb 2012 06:34:53 -0500
Received: by pbcun15 with SMTP id un15so2555702pbc.19
        for <linux-mmc@vger.kernel.org>; Fri, 24 Feb 2012 03:34:53 -0800 (PST)
In-Reply-To: <000c01ccf287$0868bb90$193a32b0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, James Hogan <james.hogan@imgtec.com>

On Thu, Feb 23, 2012 at 11:58 PM, Seungwon Jeon <tgih.jun@samsung.com> =
wrote:
> Will Newton <will.newton@gmail.com> wrote:
>> 2012/2/23 Seungwon Jeon <tgih.jun@samsung.com>:
>> > Hi all,
>> >
>> > Even though 1MB is reserved for descriptor table in IDMAC,
>> > the dw_mmc host driver is allowed to receive only maximum
>> > 128KB block length in one request. This is caused by setting
>> > improper max_blk_count. It needs to be e adjusted so that
>> > descriptor table is used fully.
>> >
>> > It is found that the performance is improved with the increased th=
e
>> > max_blk_count. In my case, there is 82%(6%) improvement in sequent=
ial
>> > write(read). Is there anybody who knows the reason about the old s=
etting?
>> >
>> > Best regards,
>> > Seungwon Jeon.
>> >
>> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> > ---
>> > =A0drivers/mmc/host/dw_mmc.c | =A0 =A04 ++--
>> > =A01 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> > index bf3c9b4..af2b901 100644
>> > --- a/drivers/mmc/host/dw_mmc.c
>> > +++ b/drivers/mmc/host/dw_mmc.c
>> > @@ -1804,9 +1804,9 @@ static int __init dw_mci_init_slot(struct dw=
_mci *host, unsigned int id)
>> > =A0#ifdef CONFIG_MMC_DW_IDMAC
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_segs =3D host->ring_size;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_blk_size =3D 65536;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_count =3D host->ring_si=
ze;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_seg_size =3D 0x1000;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_req_size =3D mmc->max_seg_s=
ize * mmc->max_blk_count;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_req_size =3D mmc->max_seg_s=
ize * host->ring_size;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_count =3D mmc->max_req_=
size / 512;
>>
>> I am not sure this is correct, it seems like most drivers calculate
>> max_req_size like this:
>>
>> mmc->max_req_size =3D mmc->max_blk_size * mmc->max_blk_count;
>
> Could you explain the following origin code in dw_mmc?
> We need to change like most other drivers?
> =A0mmc->max_req_size =3D mmc->max_seg_size * mmc->max_blk_count;

All the other drivers seem to set max_req_size based on blk_size and
blk_count not seg_size so the current code looks like it may be wrong.

> =A0- mmc->max_blk_count is set as host->ring_size.
> =A0- max_seg_size seems to represent max_blk_size.

I believe max_seg_size should be set to a higher value as it appears
to be only relevant for IOMMU-based drivers, possibly the same as
max_req_size.
