From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v9 00/12] use nonblock mmc requests to minimize latency
Date: Sun, 28 Aug 2011 14:13:54 +0200
Message-ID: <CAJ0pr1_uiE-nyz5LrsgXaEQXwb5h27E=nfZNUSwRZyOGhVrDRw@mail.gmail.com>
References: <1309539333-2606-1-git-send-email-per.forlin@linaro.org>
	<20110826161951.GA26197@n2100.arm.linux.org.uk>
	<4E57C9A3.8000208@ti.com>
	<CAJ0pr18vZkQop29_ReNU6rP+nMORaz2+FOa4P0rLTfihfDd6=w@mail.gmail.com>
	<20110828111158.GA26917@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46112 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab1H1MNz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Aug 2011 08:13:55 -0400
In-Reply-To: <20110828111158.GA26917@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Chris Ball <cjb@laptop.org>, linaro-dev@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Sourav Poddar <sourav.poddar@ti.com>, linux-arm-kernel@lists.infradead.org, Balaji T Krishnamoorthy <balajitk@ti.com>

On 28 August 2011 13:11, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Aug 28, 2011 at 12:50:54PM +0200, Per Forlin wrote:
>> On 26 August 2011 18:28, Santosh <santosh.shilimkar@ti.com> wrote:
>> > + Balaji,
>> >
>> > On Friday 26 August 2011 09:49 PM, Russell King - ARM Linux wrote:
>> >>
>> >> I'm not sure who's responsible for this, but the nonblocking MMC =
stuff is
>> >> broken on OMAPs HSMMC:
>> >>
>> >> mmcblk0: error -84 transferring data, sector 149201, nr 64, cmd r=
esponse
>> >> 0x900, card status 0xb00
>> >> mmcblk0: retrying using single block read
>> >> ------------[ cut here ]------------
>> >> WARNING: at /home/rmk/git/linux-2.6-rmk/lib/dma-debug.c:811
>> >> check_unmap+0x1ac/0x764()
>> >> omap_hsmmc omap_hsmmc.0: DMA-API: device driver tries to free DMA=
 memory
>> >> it has not allocated [device address=3D0x0000000080933000] [size=3D=
20480 bytes]
>> >> Modules linked in:
>> >> Backtrace:
>> >> [<c0017874>] (dump_backtrace+0x0/0x10c) from [<c02ce8ac>]
>> >> (dump_stack+0x18/0x1c)
>> >> =A0r7:c1abfcb8 r6:c0186248 r5:c037de51 r4:0000032b
>> >> [<c02ce894>] (dump_stack+0x0/0x1c) from [<c0039ed4>]
>> >> (warn_slowpath_common+0x58/0x70)
>> >> [<c0039e7c>] (warn_slowpath_common+0x0/0x70) from [<c0039f90>]
>> >> (warn_slowpath_fmt+0x38/0x40)
>> >> =A0r8:c1abfd50 r7:00000000 r6:00005000 r5:00000000 r4:80933000
>> >> [<c0039f58>] (warn_slowpath_fmt+0x0/0x40) from [<c0186248>]
>> >> (check_unmap+0x1ac/0x764)
>> >> =A0r3:c0367d55 r2:c037e24d
>> >> [<c018609c>] (check_unmap+0x0/0x764) from [<c0186978>]
>> >> (debug_dma_unmap_sg+0x100/0x134)
>> >> [<c0186878>] (debug_dma_unmap_sg+0x0/0x134) from [<c0019770>]
>> >> (dma_unmap_sg+0x24/0x7c)
>> >> [<c001974c>] (dma_unmap_sg+0x0/0x7c) from [<c0207220>]
>> >> (omap_hsmmc_post_req+0x48/0x54)
>> >> [<c02071d8>] (omap_hsmmc_post_req+0x0/0x54) from [<c01fb644>]
>> >> (mmc_start_req+0x9c/0x128)
>> >> =A0r4:c1a76000
>> >> [<c01fb5a8>] (mmc_start_req+0x0/0x128) from [<c02049fc>]
>> >> (mmc_blk_issue_rw_rq+0x80/0x460)
>> >> =A0r8:c1ab5c00 r7:00000001 r6:c1ab5824 r5:c1ab5824 r4:c1ab5c00
>> >> [<c020497c>] (mmc_blk_issue_rw_rq+0x0/0x460) from [<c02050a8>]
>> >> (mmc_blk_issue_rq+0x2cc/0x2fc)
>> >> [<c0204ddc>] (mmc_blk_issue_rq+0x0/0x2fc) from [<c02056c4>]
>> >> (mmc_queue_thread+0xa0/0x104)
>> >> [<c0205624>] (mmc_queue_thread+0x0/0x104) from [<c0054f8c>]
>> >> (kthread+0x88/0x90)
>> >> [<c0054f04>] (kthread+0x0/0x90) from [<c003d9a4>] (do_exit+0x0/0x=
618)
>> >> =A0r7:00000013 r6:c003d9a4 r5:c0054f04 r4:c1a7bc7c
>> >> ---[ end trace 3314ad56daf5d14f ]---
>> >>
>> >> Luckily thinks continue to work, but clearly releasing DMA mappin=
gs which
>> >> drivers don't own is bad news. =A0Unfortunately, I don't have the=
 bandwidth
>> >> to be able to investigate this at present - well, I could do but =
then I'd
>> >> have to drop working on the OMAP4 vs generic suspend/resume code =
and learn
>> >> about something I've no current clue about.
>> >>
>> > Please continue your help on generic suspend.
>> >
>> >> Can someone please investigate and fix whatever is broken.
>> >>
>> > Will find somebody to look at this issue.
>> >
>> I had a look at this and my guess is that the same mapped DMA memory
>> is unmapped twice. First the memory is unmapped in
>> omap_hsmmc_dma_cleanup() due to the mmc error, then later in
>> omap_hsmmc_post_req(). Here is a patch to resolve that. I haven't ha=
d
>> the chance to test it yet though.
>>
>> ---
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A07 +++++--
>> =A01 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 21e4a79..7f40767 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1011,6 +1011,7 @@ static void omap_hsmmc_dma_cleanup(struct
>> omap_hsmmc_host *host, int errno)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data->sg_len,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_get_dma_d=
ir(host, host->data));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(dma_ch);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->host_cookie =3D 0;
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 host->data =3D NULL;
>> =A0}
>> @@ -1576,8 +1577,10 @@ static void omap_hsmmc_post_req(struct mmc_ho=
st
>> *mmc, struct mmc_request *mrq,
>> =A0 =A0 =A0 =A0 struct mmc_data *data =3D mrq->data;
>>
>> =A0 =A0 =A0 =A0 if (host->use_dma) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data-=
>sg, data->sg_len,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_=
get_dma_dir(host, data));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->host_cookie)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(h=
ost->mmc), data->sg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0data->sg_len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0omap_hsmmc_get_dma_dir(host, data));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->host_cookie =3D 0;
>>
>>
>> I also checked the mmci code for this same issue and mmci doesn't ha=
ve
>> the same bug.
>> MMCI works fine in 3.1-rc2 even though the code is "wrong". I propos=
e
>> this change.
>> @@ -529,7 +529,7 @@ static void mmci_post_request(struct mmc_host
>> *mmc, struct mmc_request *mrq,
>> =A0 =A0 =A0 =A0 if (chan) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmaengine_terminate_=
all(chan);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err || data->host_cookie)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->host_cookie)
>>
>> I'll post these patches as soon as I have managed to test them or
>> sooner if I get a tested-by.
>
> Looking at MMCI, are you sure all those DMA engine terminate calls ar=
e
> correct?
>
I should probably do so together with adding better descriptions on
what happens and what the intention is.

> For example, why are we terminating all DMA engine transfers in the
> post request function?
The reason for calling DMA terminate here is to handle the case of
cleaning up an MMC request that has only been prepared in
mmci_pre_request(), and not been passed to mmci_request().
The if (err) is only true if that scenario has happened. The variable
err may need to be better defined. I can think of three states:
1. err =3D=3D no error
2. err =3D=3D mmc request failed
3. err =3D=3D mmc request is prepared but not started
Currently "err" is only set if #3 occurs.

The parts to clean up in post_request() if #3 happens (err =3D=3D true)=
:
in mmci: DMA mapped memory and prepared DMA descriptors
in omap_hsmmc: DMA mapped memory

Now when I think more about I need to check the DMA drivers more
closely if dma_terminate_all() will free resources for prepared but
not submitted descriptors. I will have to add this support to the dma
drivers if it's missing.

> of by the driver before it told the core that the request was complet=
ed.
> If the post request function is called for the previous request, mean=
while
> the next request is in flight, terminating the DMA engine transfer wi=
ll
> cause invalid state in the driver.
>
> Basically, this looks completely buggered. =A0I think you need to rev=
iew
> your changes with a thought to what happens logically with DMA and th=
e
> MMC host drivers whenever an error occurs.
>
I agree, I need to look more closely on the error handling.

Regards,
Per
