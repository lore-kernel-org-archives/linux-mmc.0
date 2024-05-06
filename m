Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B212BAE5
	for <linux-mmc@vger.kernel.org>; Mon,  6 May 2024 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020787; cv=none; b=K7Ed7kPfTx9gMpqPb0qDZ5TtnmG89rYfPiCvYiCz9RwTgbE5FfllzcAyBJNSvTqDPa40BjpKjjC+dWVJy3RPTS+q94tm/cd02Oq2sUecmikU2O0griWGvlsCH9X+q2nFoqmHo/rAifGcUjYY/qEj3V7Np92sVQRSe39BcB9k/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020787; c=relaxed/simple;
	bh=g97jIsxsk7/LEPTKCbpw8aKrGzgA5th7P6EMvsNLQvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=airOEoVCfD8JNawRspKHUXVVLXx+0aT5i0bJOBHIbKdk1B8AIp9Ut3m1+a2S7wlP43ZNE9s/xDuY0Wu4B3Z8oUacPXmBFPC82LCt0l7tr8yxAW4atKfyKyF8NL4DqtlRgnvgmv90iIoO6QWkR+i8kHK2CFhZ3n97hrAdvcPfcEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fz3IkDfd; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fz3IkDfd"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23d38cd0df6so1424837fac.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 May 2024 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715020784; x=1715625584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xK3xTjQWGeugW6L3l8BGsjpoQBPWGrCvOsOEi6vk2hM=;
        b=Fz3IkDfdpaudobmSIRQ2EJQORIkQIwMjwNLsHq+a9RQj9NSFtKu7feojJCs21HmdKq
         CeRJGwOuRGAXtGRYmpOFm40VWSZ9SMkDPToP1cso9hmbVCQvwAL4dK64k2YM2I6b/KA/
         10Dzf8NmZa78wn1CFOOWAAf2jMBfj6KgI3Gh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715020784; x=1715625584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xK3xTjQWGeugW6L3l8BGsjpoQBPWGrCvOsOEi6vk2hM=;
        b=pMyP5v9MMh7ThOOpvnjDOts1wN7Yf7yshCqFEPv3C9f2eFnVe0KT60zuwHgB7Z9Gh1
         O7m1G9ERuxOJCHXi9Se5X/vfHCHxRRBEJPtNulYcvI8KJiWUVO61tRUmUFpTOK67wC1Y
         2779vXlxJ71tocFtyrYsTxrYRdjuxrF6ChijMVImRpyj7J2vMcI7mHwooiqSHloNXI4Y
         +lbuuPabm3PQkUfSA6Unyc3GPRNvKvXyQv7TA/gZcdH/Pr+fHZgoWR/WwCmCLzrDAE1x
         GSXCMBQPVZH/P7vYRwFE2ELxnwCrTgwGEt882a6L4b9/YOiCVjcQOId5l8jblK6h78tt
         0G/w==
X-Forwarded-Encrypted: i=1; AJvYcCUmz27a38Z2bU4TTmsI282J22buSgqpkRX5FOZQIHDPfVf938xkon+V5dijvrs826ZF+3rIrsDIBcnUfx2nztbijG8NVDsDjxRU
X-Gm-Message-State: AOJu0Yx9R0aACgZH71tx9ljVZ29quni2QxP3ENNq3SLIfzNkUEbtxys+
	QnzIKvXLt9LO0vqTGyjEO/UUmRXqNJF2VJWTKst3L7KVmy+TqCS/ZcIOYuo7+/orcKHsfFJlBf1
	hgD9JAx9xmijU3ZHKbdh8TtO0mp1K2xpZ2o6c
X-Google-Smtp-Source: AGHT+IH7dQIN4oFHv8bwAD0nUZjVI8HVAnHl9wAm/rFIRxxyF2+VinqaF+o2Za4Ki7WyYkTz+FHwW3lfyOwFpoolRFY=
X-Received: by 2002:a05:6870:b023:b0:233:b5dd:471c with SMTP id
 y35-20020a056870b02300b00233b5dd471cmr11426298oae.51.1715020783659; Mon, 06
 May 2024 11:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423200234.21480-1-kamal.dasu@broadcom.com>
 <CAPDyKFqLqbRx3gWCqT4G6mUVeMDWyA_f8T2_iYt07r_Ffqaaow@mail.gmail.com>
 <3f69d64e-7c41-48de-a7a0-42ab99cd7e7d@intel.com> <CAKekbev6YG+yVnX-n9tsQSwujj5mD-vpJXrd+xwcF-K=z45q+w@mail.gmail.com>
 <CAPDyKFoE4+sQ3D-9SKtFcksQQ88GyYd_P88dVOj9SYyVFqLxig@mail.gmail.com> <a55e1bdc-7c6a-4720-b941-0ddfd764b87e@arm.com>
In-Reply-To: <a55e1bdc-7c6a-4720-b941-0ddfd764b87e@arm.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Mon, 6 May 2024 14:39:06 -0400
Message-ID: <CAKekbes-X-nnksQLjrGaZJOXZ7dCYos0_2cd1GukBc2KWh0KJg@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: core: check R1_STATUS for erase/trim/discard
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ludovic.barre@st.com, 
	f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009fdecd0617cd6466"

--0000000000009fdecd0617cd6466
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I was testing with different.

On Fri, May 3, 2024 at 9:55=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 03/05/2024 14:09, Ulf Hansson wrote:
> > On Fri, 26 Apr 2024 at 17:11, Kamal Dasu <kamal.dasu@broadcom.com> wrot=
e:
> >>
> >> On Fri, Apr 26, 2024 at 2:17=E2=80=AFAM Adrian Hunter <adrian.hunter@i=
ntel.com> wrote:
> >>>
> >>> On 25/04/24 19:18, Ulf Hansson wrote:
> >>>> + Wolfram, Adrian (to see if they have some input)
> >>>>
> >>>> On Tue, 23 Apr 2024 at 22:02, Kamal Dasu <kamal.dasu@broadcom.com> w=
rote:
> >>>>>
> >>>>> When erase/trim/discard completion was converted to mmc_poll_for_bu=
sy(),
> >>>>> optional ->card_busy() host ops support was added. sdhci card->busy=
()
> >>>>> could return busy for long periods to cause mmc_do_erase() to block=
 during
> >>>>> discard operation as shown below during mkfs.f2fs :
> >>>>>
> >>>>> Info: [/dev/mmcblk1p9] Discarding device
> >>>>> [   39.597258] sysrq: Show Blocked State
> >>>>> [   39.601183] task:mkfs.f2fs       state:D stack:0     pid:1561  t=
gid:1561  ppid:1542   flags:0x0000000d
> >>>>> [   39.610609] Call trace:
> >>>>> [   39.613098]  __switch_to+0xd8/0xf4
> >>>>> [   39.616582]  __schedule+0x440/0x4f4
> >>>>> [   39.620137]  schedule+0x2c/0x48
> >>>>> [   39.623341]  schedule_hrtimeout_range_clock+0xe0/0x114
> >>>>> [   39.628562]  schedule_hrtimeout_range+0x10/0x18
> >>>>> [   39.633169]  usleep_range_state+0x5c/0x90
> >>>>> [   39.637253]  __mmc_poll_for_busy+0xec/0x128
> >>>>> [   39.641514]  mmc_poll_for_busy+0x48/0x70
> >>>>> [   39.645511]  mmc_do_erase+0x1ec/0x210
> >>>>> [   39.649237]  mmc_erase+0x1b4/0x1d4
> >>>>> [   39.652701]  mmc_blk_mq_issue_rq+0x35c/0x6ac
> >>>>> [   39.657037]  mmc_mq_queue_rq+0x18c/0x214
> >>>>> [   39.661022]  blk_mq_dispatch_rq_list+0x3a8/0x528
> >>>>> [   39.665722]  __blk_mq_sched_dispatch_requests+0x3a0/0x4ac
> >>>>> [   39.671198]  blk_mq_sched_dispatch_requests+0x28/0x5c
> >>>>> [   39.676322]  blk_mq_run_hw_queue+0x11c/0x12c
> >>>>> [   39.680668]  blk_mq_flush_plug_list+0x200/0x33c
> >>>>> [   39.685278]  blk_add_rq_to_plug+0x68/0xd8
> >>>>> [   39.689365]  blk_mq_submit_bio+0x3a4/0x458
> >>>>> [   39.693539]  __submit_bio+0x1c/0x80
> >>>>> [   39.697096]  submit_bio_noacct_nocheck+0x94/0x174
> >>>>> [   39.701875]  submit_bio_noacct+0x1b0/0x22c
> >>>>> [   39.706042]  submit_bio+0xac/0xe8
> >>>>> [   39.709424]  blk_next_bio+0x4c/0x5c
> >>>>> [   39.712973]  blkdev_issue_secure_erase+0x118/0x170
> >>>>> [   39.717835]  blkdev_common_ioctl+0x374/0x728
> >>>>> [   39.722175]  blkdev_ioctl+0x8c/0x2b0
> >>>>> [   39.725816]  vfs_ioctl+0x24/0x40
> >>>>> [   39.729117]  __arm64_sys_ioctl+0x5c/0x8c
> >>>>> [   39.733114]  invoke_syscall+0x68/0xec
> >>>>> [   39.736839]  el0_svc_common.constprop.0+0x70/0xd8
> >>>>> [   39.741609]  do_el0_svc+0x18/0x20
> >>>>> [   39.744981]  el0_svc+0x68/0x94
> >>>>> [   39.748107]  el0t_64_sync_handler+0x88/0x124
> >>>>> [   39.752455]  el0t_64_sync+0x168/0x16c
> >>>>
> >>>> Thanks for the detailed log!
> >>>>
> >>>>>
> >>>>> Fix skips the card->busy() and uses MMC_SEND_STATUS and R1_STATUS
> >>>>> check for MMC_ERASE_BUSY busy_cmd case in the mmc_busy_cb() functio=
n.
> >>>>>
> >>>>> Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for=
 erase/trim/discard")
> >>>>> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> >>>>> ---
> >>>>>  drivers/mmc/core/mmc_ops.c | 3 ++-
> >>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.=
c
> >>>>> index 3b3adbddf664..603fbd78c342 100644
> >>>>> --- a/drivers/mmc/core/mmc_ops.c
> >>>>> +++ b/drivers/mmc/core/mmc_ops.c
> >>>>> @@ -464,7 +464,8 @@ static int mmc_busy_cb(void *cb_data, bool *bus=
y)
> >>>>>         u32 status =3D 0;
> >>>>>         int err;
> >>>>>
> >>>>> -       if (data->busy_cmd !=3D MMC_BUSY_IO && host->ops->card_busy=
) {
> >>>>> +       if (data->busy_cmd !=3D MMC_BUSY_IO &&
> >>>>> +           data->busy_cmd !=3D MMC_BUSY_ERASE && host->ops->card_b=
usy) {
> >>>>>                 *busy =3D host->ops->card_busy(host);
> >>>>>                 return 0;
> >>>>>         }
> >>>>
> >>>> So it seems like the ->card_busy() callback is broken in for your mm=
c
> >>>> host-driver and platform. Can you perhaps provide the information
> >>>> about what HW/driver you are using?
> >>>>
> >>
> >> Using the sdhci-brcmstb driver on a Broadcom Settop based SoC.
> >>
> >>>> The point with using the ->card_busy() callback, is to avoid sending
> >>>> the CMD13. Ideally it should be cheaper/faster and in most cases it
> >>>> translates to a read of a register. For larger erases, we would
> >>>> probably end up sending the CMD13 periodically every 32-64 ms, which
> >>>> shouldn't be a problem. However, for smaller erases and discards, we
> >>>> may want the benefit the ->card_busy() callback provides us.
> >>>>
> >>
> >> I have tested two scenarios. One is like the mkfs.f2fs app that calls =
:
> >> ioctl(fd, BLKSECDISCARD, &range);
> >>
> >> This has the following CMD and completion sequence:
> >> {CMD35->CMD36->CMD38} and poll for  DAT0  signal via card->busy .
> >> CMD38 has a response of R1b. The DAT0 (Busy line) will be driven by th=
e device.
> >> Busy (DAT0  =3D 0) is asserted by a device for  erasing blocks. Stays
> >> busy in brcmstb sdhci controller.
> >
> > How big is the "range"?
> >

The task just blocks here. I have attached the stack.

> > Just so I get this right, it stays busy and we are waiting for the
> > timeout to fire? And ideally you think we should not be busy for that
> > long, right?
> >
The timeout does not fire.

> >>
> >> With the additional change followed by CMD13 (response of R1), which
> >> returns the device status, the
> >> DAT0 will be pulled-up and next time we read the BUSY status it will
> >> indicate it is not busy.
> >
> > So you are referring to read the BUSY status with you ->card_busy()
> > callback? Or did you actually verify that this is true from an
> > electrical point of view, by monitoring the DAT0 signal?
> >
> > If the latter, perhaps it's the card that is failing and simply
> > requires CMD13 to be used to poll for busy. What card is this?
> >
> > Have you tried different cards with the same platform/driver?
> >
Yes, I have tried Micron and Sandisk 8GB cards with the same platform
with the same results.

> >>
> >> Also I tried the mmc util and that does not show the same issue with
> >> exactly the same ranges, however in that case there are some
> >> differences in the way the CMD sequence is sent for the entire discard
> >> operation.
> >> # mmc erase discard 0x000087a4 0x002effff /dev/mmcblk1
> >> /* send erase cmd with multi-cmd */
> >> ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> >>
> >> CMD35->CMD13->CMD36->CMD13->CMD38->CMD13
> >> I do not see any hang in all the erase options discard, legacy, trim, =
trim2,
> >> secure-trim used here with mmc util .
> >
> > So CMD13 seems to do the trick for you. Although, I think we need to
> > figure out if this a special "broken" card or if the problem is with
> > the ->card_busy() implementation for your platform.
> >
> >>
> >> Also looking at JEDEC Standard No. 84-B51 Page 276, 277
> >> "Once the erase groups are selected the host will send an ERASE
> >> (CMD38) command. It is recom-
> >> mended that the host terminates the sequence with a SEND_STATUS
> >> (CMD13) to poll any additional
> >> status information the Device may have (e.g., WP_ERASE_SKIP, etc.)."
> >
> > Isn't that exactly what is being done? After the card has stopped
> > signaling busy, we send a CMD13 in mmc_busy_cb() to read the
> > additional status information.
>
Yes, that is what the fix does. However in the original if
->card->busy() is being used we do not send the CMD13.

> Agreed with your interpretation FWIW.
>
> >
> > I don't get it, why should the card stop signal busy, just because we
> > send a CMD13. If so, the card should probably be considered broken.
> > For broken cards, we can try to use a card-quirk instead - to enforce
> > CMD13 polling.
>
Yes  would be one of the solutions that can be considered. Would open
to any suggestion on what card-quirk to use.

> I'll mention it here, I've seen some broken IP out there where the card's
> FSM (including busy-signalling) was dependent on the host providing the
> CLK, can't remember which one it was, though.
> Anyway for Kamal, it might be interesting to know if your host controller
> autostops the CLK (which it is allowed to) during the busy-signalling and
> if not stopping it also works around the problem.
>
The host controller is not stopping the clock. Also stopping the clock
does not work around the problem. host is expecting the device FSM
pull up the busy line.

At this point I can either do this when  adding host:
+       /* we dont use busy signal */
+       host->mmc_host_ops.card_busy =3D NULL;

Or introduce a card-quirk for this situation.

Kamal

--0000000000009fdecd0617cd6466
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DxuNuBlySpn/GYqPcDcRZd8EENWqnZrjtjHMk0j7ZfrPGXq8sQkbG3OX+DOwSaefPRq1pLGWBZaZ
YuUo5O7CNHo7h7Hc9GgjiW+6X9BjKAzSaDy8jwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdrYW1hbC5kYXN1QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUcRYSWvAVyA3hgTrQ2c4AFquBsG0wDQYJ
KoZIhvcNAQELBQADggEBAIKB2IOweF2sIYGBZTDm+Hwmhga+sjekM167Sk/KwxxvQFwZYP6i0SnR
7aR59vbfVQVaAiZH/a+35EYxP/sXaIM4+E3bFykBuXwcGEnYyEn6MceiOCkjkWQq1Co2JyOdNvkP
nAxyPoWlsJtr+N/MF1EYKGpYMdPM7S2T/gujjO9N56BCGu9yJElszWcXHmBl5IsaQqMS36vhsV0b
NxffjNkeAdgfN/SS9S9Rj4WXD7pF1M0Xq8gPLCLyXrx1i2KkYOYJsj0PWlC6VRg6E1xXkYDte0VL
fAAG4QsETU27E1HBNQyp5zF1PoPCPvq3EnWQnbLgYk+Jz2iwIUwiqwr/bDgxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw89WX2Pp7ue922QVkwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMJ4o86d39d2G+RvuqiXyjFI9dAj8AQSPaJ7P5a6
K4Z0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUwNjE4Mzk0
NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQArh0hJtUPSoYQ4PRIqNj68kwqsx60/Or9LNUchn54gC8YcLrp3SAZGcF1K
jzUTba1PPalqsnCGATQ7AZT8u625zRrL0EE7naQkq0KpdcHGYgThMPAESYm0Sh/+vHeuBMovBKdG
/y0ZqrMkmOZj8bDVJufnM/u8brJAdlWNunIpZfg1lNjIjFeWhKWk44hjEN/91izb6hRkmNYGNdM3
GyZy+qoIG1bRM1pXfTMikDZqSMgD99b9WcwzxEtAppYaTLg3W5ltoW86zXPfDKvcW7ifUfMogPIY
t9fDKL1IQTSwhjUHppz1Xl3waT7vvpup670Nrd0TUlBzLlw58+7gBezZ
--0000000000009fdecd0617cd6466--
