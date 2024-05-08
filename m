Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D23A1BE
	for <linux-mmc@vger.kernel.org>; Wed,  8 May 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715158322; cv=none; b=IJS+/Af+IUByLvc168ltIEJFyI1I5Um4dtjO8ljStyhygdp/euievD3R5Rc93SYIHBgHPiDRA/kiss0dwxFvwtIo/EWRFmL6wVK1SJ4Ddt+rIiNHVZMp1SfxOXRqyw7MYPPlXfC6VjuTbrZI+UM0GpSV95fYFMcZDTA8qB5vpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715158322; c=relaxed/simple;
	bh=HYXrsynpcK3FfS90LJUxK131eceRUH60ncTBYzhRG/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rup6/qf2ZgtUiBDUgf8yvuGof5pAjwfLPCspYWkgcOxdCnJaBPM+ULA8/4AaJ6jvikoJso/WwhMjPA1+c+iejsHeT6S7cTb7/gAsmjQSXdJjablL5Jb4zkgDzZ6VwCY4iezRRV0mdmiorUASAQgqWnbewqB/knzZwBy17WJhats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nf3H4UFo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nf3H4UFo"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc71031680so4324894276.2
        for <linux-mmc@vger.kernel.org>; Wed, 08 May 2024 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715158318; x=1715763118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=in3B+Ik46blXOXrKxuDpO2qCSaCcioDyNF0gWPJLAiA=;
        b=Nf3H4UFoBQ1WAmEVKExG48LdK0jQkC2Dkc8Q1BpaUykOofG5uW9BIAp6LATVisiJF2
         Q0EVm+dKR7azlwrPnCCN7Jm6Ud9d4/XfDn5FrWo3FKBvQC7v2kD7XIBjEyElAQrCrPsQ
         WkDcWvSe7Wx9JpSsnscB7dp55SzKhQUfu2QdzFDWBDVaBgvhcevfkmWGj/JPAdX23Ywo
         twIZmRf/+616iyrsick3MUKZYAfjKO4GnUnb4biv5GyGeEFuJu9BDwDUYkOLI0tQT3T4
         wWI5OvzpqvZVKMPtgtQC5Y4nb7gTf1Jha3Rog0xt2NpwZIu4PI6v3u0GDQufZ/g6JocW
         u0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715158318; x=1715763118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=in3B+Ik46blXOXrKxuDpO2qCSaCcioDyNF0gWPJLAiA=;
        b=JS1u4RZ7GvVnRAH0jPjRBbdM+LXxH6sZ6ewHj02anqFwxY1xAaiKcGolzZIPgwBHyB
         zDDVcTOOM2nljR4hlx7T6tEmLBnTydPZhymgCTUZdKhhdvKf1YZfoHfIbLX3Lyv//nOW
         Z7Qjp/qUTisufdl49u/CJyNqUIaGhRop2/WiuEntppUIE8+mD971SCkDxVD9kZ6x2kEm
         CeVba8jv5LFt6g6FCMjiojZiLxRgKE32GFOvy7AUu/JFJMfaKZkaJksD79NJHQih/mI6
         9uSWXk8yUT9NJtePbFax9Xczir2GrUmNUZrAYYLW3cInHyOd9lRM+GDyA6S7NppV8nxs
         YzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW85s2kz6VibgcG8uZk4AadM/APrahJGl12XQmhrHMWRBYaeG6gotIjTy0kJmbKP2yOc1tQUjIlLNN3PrDWtFNxzjFKDU5UG3MR
X-Gm-Message-State: AOJu0YxpbYu3S6V9hcRgUxQ8RtuIRr9SIbh3ccS+BBcVTV/2pCpIv18t
	iEFFmzA/BOYJAqnhnGg8kpo6oVqhJtOr9EiUANOhZkq9Wl0oiA8dsCILCa7mgDYgcqp2Y+nX7es
	IPpwx1mmlern/5pbEUh8KKuUU5ExnovBb3vlMzg==
X-Google-Smtp-Source: AGHT+IGp6X2BhJs6wlRjN0lKnBeuPzHxeGy1JNrO+idMaCicMZwZ+qafrVrFGUQyhDqFhR8iHEcNxFj2A7rIXMXNbRc=
X-Received: by 2002:a25:ac56:0:b0:de5:5706:b958 with SMTP id
 3f1490d57ef6-debb9dbc831mr2100582276.38.1715158318252; Wed, 08 May 2024
 01:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423200234.21480-1-kamal.dasu@broadcom.com>
 <CAPDyKFqLqbRx3gWCqT4G6mUVeMDWyA_f8T2_iYt07r_Ffqaaow@mail.gmail.com>
 <3f69d64e-7c41-48de-a7a0-42ab99cd7e7d@intel.com> <CAKekbev6YG+yVnX-n9tsQSwujj5mD-vpJXrd+xwcF-K=z45q+w@mail.gmail.com>
 <CAPDyKFoE4+sQ3D-9SKtFcksQQ88GyYd_P88dVOj9SYyVFqLxig@mail.gmail.com>
 <a55e1bdc-7c6a-4720-b941-0ddfd764b87e@arm.com> <CAKekbes-X-nnksQLjrGaZJOXZ7dCYos0_2cd1GukBc2KWh0KJg@mail.gmail.com>
In-Reply-To: <CAKekbes-X-nnksQLjrGaZJOXZ7dCYos0_2cd1GukBc2KWh0KJg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 8 May 2024 10:51:21 +0200
Message-ID: <CAPDyKFpBPMxrt7T5UTZzjtco_41FPToztGqWgWTRNQd4YAn-ZQ@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: core: check R1_STATUS for erase/trim/discard
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ludovic.barre@st.com, 
	f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 May 2024 at 20:39, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> I was testing with different.
>
> On Fri, May 3, 2024 at 9:55=E2=80=AFAM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 03/05/2024 14:09, Ulf Hansson wrote:
> > > On Fri, 26 Apr 2024 at 17:11, Kamal Dasu <kamal.dasu@broadcom.com> wr=
ote:
> > >>
> > >> On Fri, Apr 26, 2024 at 2:17=E2=80=AFAM Adrian Hunter <adrian.hunter=
@intel.com> wrote:
> > >>>
> > >>> On 25/04/24 19:18, Ulf Hansson wrote:
> > >>>> + Wolfram, Adrian (to see if they have some input)
> > >>>>
> > >>>> On Tue, 23 Apr 2024 at 22:02, Kamal Dasu <kamal.dasu@broadcom.com>=
 wrote:
> > >>>>>
> > >>>>> When erase/trim/discard completion was converted to mmc_poll_for_=
busy(),
> > >>>>> optional ->card_busy() host ops support was added. sdhci card->bu=
sy()
> > >>>>> could return busy for long periods to cause mmc_do_erase() to blo=
ck during
> > >>>>> discard operation as shown below during mkfs.f2fs :
> > >>>>>
> > >>>>> Info: [/dev/mmcblk1p9] Discarding device
> > >>>>> [   39.597258] sysrq: Show Blocked State
> > >>>>> [   39.601183] task:mkfs.f2fs       state:D stack:0     pid:1561 =
 tgid:1561  ppid:1542   flags:0x0000000d
> > >>>>> [   39.610609] Call trace:
> > >>>>> [   39.613098]  __switch_to+0xd8/0xf4
> > >>>>> [   39.616582]  __schedule+0x440/0x4f4
> > >>>>> [   39.620137]  schedule+0x2c/0x48
> > >>>>> [   39.623341]  schedule_hrtimeout_range_clock+0xe0/0x114
> > >>>>> [   39.628562]  schedule_hrtimeout_range+0x10/0x18
> > >>>>> [   39.633169]  usleep_range_state+0x5c/0x90
> > >>>>> [   39.637253]  __mmc_poll_for_busy+0xec/0x128
> > >>>>> [   39.641514]  mmc_poll_for_busy+0x48/0x70
> > >>>>> [   39.645511]  mmc_do_erase+0x1ec/0x210
> > >>>>> [   39.649237]  mmc_erase+0x1b4/0x1d4
> > >>>>> [   39.652701]  mmc_blk_mq_issue_rq+0x35c/0x6ac
> > >>>>> [   39.657037]  mmc_mq_queue_rq+0x18c/0x214
> > >>>>> [   39.661022]  blk_mq_dispatch_rq_list+0x3a8/0x528
> > >>>>> [   39.665722]  __blk_mq_sched_dispatch_requests+0x3a0/0x4ac
> > >>>>> [   39.671198]  blk_mq_sched_dispatch_requests+0x28/0x5c
> > >>>>> [   39.676322]  blk_mq_run_hw_queue+0x11c/0x12c
> > >>>>> [   39.680668]  blk_mq_flush_plug_list+0x200/0x33c
> > >>>>> [   39.685278]  blk_add_rq_to_plug+0x68/0xd8
> > >>>>> [   39.689365]  blk_mq_submit_bio+0x3a4/0x458
> > >>>>> [   39.693539]  __submit_bio+0x1c/0x80
> > >>>>> [   39.697096]  submit_bio_noacct_nocheck+0x94/0x174
> > >>>>> [   39.701875]  submit_bio_noacct+0x1b0/0x22c
> > >>>>> [   39.706042]  submit_bio+0xac/0xe8
> > >>>>> [   39.709424]  blk_next_bio+0x4c/0x5c
> > >>>>> [   39.712973]  blkdev_issue_secure_erase+0x118/0x170
> > >>>>> [   39.717835]  blkdev_common_ioctl+0x374/0x728
> > >>>>> [   39.722175]  blkdev_ioctl+0x8c/0x2b0
> > >>>>> [   39.725816]  vfs_ioctl+0x24/0x40
> > >>>>> [   39.729117]  __arm64_sys_ioctl+0x5c/0x8c
> > >>>>> [   39.733114]  invoke_syscall+0x68/0xec
> > >>>>> [   39.736839]  el0_svc_common.constprop.0+0x70/0xd8
> > >>>>> [   39.741609]  do_el0_svc+0x18/0x20
> > >>>>> [   39.744981]  el0_svc+0x68/0x94
> > >>>>> [   39.748107]  el0t_64_sync_handler+0x88/0x124
> > >>>>> [   39.752455]  el0t_64_sync+0x168/0x16c
> > >>>>
> > >>>> Thanks for the detailed log!
> > >>>>
> > >>>>>
> > >>>>> Fix skips the card->busy() and uses MMC_SEND_STATUS and R1_STATUS
> > >>>>> check for MMC_ERASE_BUSY busy_cmd case in the mmc_busy_cb() funct=
ion.
> > >>>>>
> > >>>>> Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() f=
or erase/trim/discard")
> > >>>>> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> > >>>>> ---
> > >>>>>  drivers/mmc/core/mmc_ops.c | 3 ++-
> > >>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>>>
> > >>>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_op=
s.c
> > >>>>> index 3b3adbddf664..603fbd78c342 100644
> > >>>>> --- a/drivers/mmc/core/mmc_ops.c
> > >>>>> +++ b/drivers/mmc/core/mmc_ops.c
> > >>>>> @@ -464,7 +464,8 @@ static int mmc_busy_cb(void *cb_data, bool *b=
usy)
> > >>>>>         u32 status =3D 0;
> > >>>>>         int err;
> > >>>>>
> > >>>>> -       if (data->busy_cmd !=3D MMC_BUSY_IO && host->ops->card_bu=
sy) {
> > >>>>> +       if (data->busy_cmd !=3D MMC_BUSY_IO &&
> > >>>>> +           data->busy_cmd !=3D MMC_BUSY_ERASE && host->ops->card=
_busy) {
> > >>>>>                 *busy =3D host->ops->card_busy(host);
> > >>>>>                 return 0;
> > >>>>>         }
> > >>>>
> > >>>> So it seems like the ->card_busy() callback is broken in for your =
mmc
> > >>>> host-driver and platform. Can you perhaps provide the information
> > >>>> about what HW/driver you are using?
> > >>>>
> > >>
> > >> Using the sdhci-brcmstb driver on a Broadcom Settop based SoC.
> > >>
> > >>>> The point with using the ->card_busy() callback, is to avoid sendi=
ng
> > >>>> the CMD13. Ideally it should be cheaper/faster and in most cases i=
t
> > >>>> translates to a read of a register. For larger erases, we would
> > >>>> probably end up sending the CMD13 periodically every 32-64 ms, whi=
ch
> > >>>> shouldn't be a problem. However, for smaller erases and discards, =
we
> > >>>> may want the benefit the ->card_busy() callback provides us.
> > >>>>
> > >>
> > >> I have tested two scenarios. One is like the mkfs.f2fs app that call=
s :
> > >> ioctl(fd, BLKSECDISCARD, &range);
> > >>
> > >> This has the following CMD and completion sequence:
> > >> {CMD35->CMD36->CMD38} and poll for  DAT0  signal via card->busy .
> > >> CMD38 has a response of R1b. The DAT0 (Busy line) will be driven by =
the device.
> > >> Busy (DAT0  =3D 0) is asserted by a device for  erasing blocks. Stay=
s
> > >> busy in brcmstb sdhci controller.
> > >
> > > How big is the "range"?
> > >
>
> The task just blocks here. I have attached the stack.
>
> > > Just so I get this right, it stays busy and we are waiting for the
> > > timeout to fire? And ideally you think we should not be busy for that
> > > long, right?
> > >
> The timeout does not fire.
>
> > >>
> > >> With the additional change followed by CMD13 (response of R1), which
> > >> returns the device status, the
> > >> DAT0 will be pulled-up and next time we read the BUSY status it will
> > >> indicate it is not busy.
> > >
> > > So you are referring to read the BUSY status with you ->card_busy()
> > > callback? Or did you actually verify that this is true from an
> > > electrical point of view, by monitoring the DAT0 signal?
> > >
> > > If the latter, perhaps it's the card that is failing and simply
> > > requires CMD13 to be used to poll for busy. What card is this?
> > >
> > > Have you tried different cards with the same platform/driver?
> > >
> Yes, I have tried Micron and Sandisk 8GB cards with the same platform
> with the same results.

Okay, so it sounds like it's the ->card_busy() callback that may not
work as expected after all.

Do we have an SD card slot on this platform that we can try to run
similar tests for but with an SD card instead?

>
> > >>
> > >> Also I tried the mmc util and that does not show the same issue with
> > >> exactly the same ranges, however in that case there are some
> > >> differences in the way the CMD sequence is sent for the entire disca=
rd
> > >> operation.
> > >> # mmc erase discard 0x000087a4 0x002effff /dev/mmcblk1
> > >> /* send erase cmd with multi-cmd */
> > >> ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> > >>
> > >> CMD35->CMD13->CMD36->CMD13->CMD38->CMD13
> > >> I do not see any hang in all the erase options discard, legacy, trim=
, trim2,
> > >> secure-trim used here with mmc util .
> > >
> > > So CMD13 seems to do the trick for you. Although, I think we need to
> > > figure out if this a special "broken" card or if the problem is with
> > > the ->card_busy() implementation for your platform.
> > >
> > >>
> > >> Also looking at JEDEC Standard No. 84-B51 Page 276, 277
> > >> "Once the erase groups are selected the host will send an ERASE
> > >> (CMD38) command. It is recom-
> > >> mended that the host terminates the sequence with a SEND_STATUS
> > >> (CMD13) to poll any additional
> > >> status information the Device may have (e.g., WP_ERASE_SKIP, etc.)."
> > >
> > > Isn't that exactly what is being done? After the card has stopped
> > > signaling busy, we send a CMD13 in mmc_busy_cb() to read the
> > > additional status information.
> >
> Yes, that is what the fix does. However in the original if
> ->card->busy() is being used we do not send the CMD13.

We are not sending CMD13 to poll for busy, but we are indeed sending a
CMD13 *after* the card has stopped signal busy, to read the additional
status information.

This seems to be according to the spec.

>
> > Agreed with your interpretation FWIW.
> >
> > >
> > > I don't get it, why should the card stop signal busy, just because we
> > > send a CMD13. If so, the card should probably be considered broken.
> > > For broken cards, we can try to use a card-quirk instead - to enforce
> > > CMD13 polling.
> >
> Yes  would be one of the solutions that can be considered. Would open
> to any suggestion on what card-quirk to use.

As you have tested different cards, it's more likely to be a problem
with the platform/HW and the ->card_busy() callback.

>
> > I'll mention it here, I've seen some broken IP out there where the card=
's
> > FSM (including busy-signalling) was dependent on the host providing the
> > CLK, can't remember which one it was, though.
> > Anyway for Kamal, it might be interesting to know if your host controll=
er
> > autostops the CLK (which it is allowed to) during the busy-signalling a=
nd
> > if not stopping it also works around the problem.
> >
> The host controller is not stopping the clock. Also stopping the clock
> does not work around the problem. host is expecting the device FSM
> pull up the busy line.
>
> At this point I can either do this when  adding host:
> +       /* we dont use busy signal */
> +       host->mmc_host_ops.card_busy =3D NULL;

Looks like this is the best option, unless we can figure out why the
->card_busy() callback doesn't work as expected.

>
> Or introduce a card-quirk for this situation.
>
> Kamal

Kind regards
Uffe
