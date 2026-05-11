Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2743F0767
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508554; cv=pass; b=SnIU/VLN76/hOnwRChpjtucZsPw4L57noUX/VPKrzdzvOJfyVAMlYsj1xzu7EnUnDBnoVb56ZnL+JtTGMqi/oy7j3po89kmRbP5r4RHimb9dJB67tCCf+b5GhrOqsqR3kp89OOIjcTAuxd6bb2c98QdckjKfRbBMjhvynCM66Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508554; c=relaxed/simple;
	bh=o3hTOgFC3Xg3xbSbR2y0ZKdKO1E4JwWLfRg59/VY3e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VD6xTv9d+rKx/ygAimI86B3DH8AD0fg2/HJHRNJHMMgmyn79UW6XFaZ+cPKsjfHr091Vy74s1atxtjdSVrkkngHg/o2bDUr6mZad3gU0LCZgf0MclD5iPX12L2t5xd34kSg9UzUX02VrSV5HjnzzudZeSmy0yB4pGYHfWGZRuaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mSglcoMP; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSglcoMP"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd4c61765dso46544677b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 07:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778508552; cv=none;
        d=google.com; s=arc-20240605;
        b=QfIrsUz6nJNkQ+AfYnExMla4MBPfBSxRcigsuE8XZ3Dw+ZAWGn5qLASb5ErTSjvWec
         uoF0CT2D73VNC9sqWq719aA0NdmAqmcRuXOfQTvvK3uXptK1OfVtHZFa6qpB/mMJIdvS
         phTyUhWGNFO2x897ZD1JmGSt3IBd9utNDf9ewUdVrVhTSNAEk/zH07DudiQBYiCsVjX4
         6N0N38p4lIU3HPwOG9pRVxSdZ5nwp9pD3fvnIrjnMKp4KqKvQ2o+RI1Sqz2vFp5mTblx
         bUTRHrAmDaC0DrFEhDtlm/VXDj9Gtk9KbaI8+hXjembBIu9cAVb5VWX/mXHdipsJ+ZyJ
         6SGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DyBf2aROphTDNMTnUQ3BZ0PU/EWtqPJFjHWR12tB38o=;
        fh=aJ+D/JUt8a7oyWJIkSqMuKdyrRTXQJbIjOXpzBAQJVY=;
        b=FIa7yGO2ugaVikXT2mIwsN2DClYJ2Hafl3eESYqFcmUPpqOPBt1iW+wpAiLse/do+L
         NoTubxQKHxosXqrP6caW+Om5XC77IrCPivWkwGTPYG3rIVp/4Q1b10RZiWY92huw7tTl
         stPhHVSSvR+SUaofT576o3CpBnbkrY+KJfSx+kvtVqtbZY6b4I3j2Mlux2Of//isTuCa
         Qd5pqo4+imXul8m+9YhQ/WaysggScwMk5eXLHW+p9OWE+jhoHcmDsvy8YgnhJ0K4h9Ip
         CwD7PPhdn92XgEkYlXi/AoSo8kI8YqDgvNrIrBQmzuuHYubBNAnQPAb8BX+JHAeEy8GW
         JN/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778508552; x=1779113352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyBf2aROphTDNMTnUQ3BZ0PU/EWtqPJFjHWR12tB38o=;
        b=mSglcoMP5N8Ttg9Wl7f/jwbDT8nyLrqvd1dfukXHqEOb5qaDvDaZ81QljCM0KYeLAO
         5k0FRapgh1lpNZzIL21yDBtx4cMdxb/9TmyUNCwvRLQXWnIngaVFt6UBcpThK1QUJDxI
         K6UKoeDaJswAZyrS0ryY5mgQAx959o8eAViodXofNiHaeTqV6DpITvh8xKSyN+djQ4BV
         W5qW/WK0z1h58CtK+XFrH0u/+QEUCkYwj8U5sslDp3Dq0y0IA0P65S1BRa1MG1balUOj
         lOa91shukfT78neQQxEnvqgmW1M5/UL87TGx2Px+YpxFBU6l7/xGnX9OWXuYqwiNTWWo
         yGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508552; x=1779113352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DyBf2aROphTDNMTnUQ3BZ0PU/EWtqPJFjHWR12tB38o=;
        b=XCKsVumkSsw6pe0RwaofHBb3ejFKE7p51ThZIfxtiK2OAwL9vRbDICbSB5wgXPspkx
         v+2yA0zuZ9v7A34884UiJNft6Xf+/wKhP6TJ6BLfAiKjyCHJoFFROEtwqMCA0PT1/bNS
         4TPCqxx9WbkomMIePVOemHH9Ivfw3COEH0MDW+7KYvRgV0i7ycmDxra6Es22kWAp6i1D
         hKXCtPi+d5kxemnvd3UL3wFo5bkOH2Xa2WXui8aILXZjpn6Le49bWTfD5sOjgBlSZmEl
         tLmOi+ofIRwEGpFZnzSm9XbZKuDDpKwec2a3/2eKTlRvKu6/6l6LT5ZtT7FyCaTv8du6
         Rsvw==
X-Gm-Message-State: AOJu0YyjZUNiHBc0MmHbme+K9Htzk75FsPjDUWLaenbz5RbDgE5nuMWm
	mOt2JcyXjeoxQLsRujsVbR+xDzaFl0uESdXVAJ3e4EhayHAV41aV0v5ItOiNBgYDYsA7B5xZCS4
	xWDkj+J5xFbHNTzkQ3IPdf/RBs40qutrrouzoHFnTkw==
X-Gm-Gg: Acq92OGTBMT80PYV3R9LnGkf/DPHpzifIE1XrWtd33KrkJ5K0S7O/Km2qU9huKbxsOS
	4oMMp9v+W2e0upj70ObW8gzPCpoCMyJl793jr3hlf64KD3I7OKCXe5xTZamO0oDAWGe6SS1LU4o
	BV0wjaHrUahs3q6bTxaGDmR+BITj6iD4+vaIEysGOp8Jhxg2l0hDJFqlMgAj96HVHOYRGak4fqA
	WzVelswGwND2gCXmgatPn6foJuS62R4gIOGehdgKyqhKG7z98gkrqMoXmiW3VCzGP2nIZb62VNH
	YmpZdKNy
X-Received: by 2002:a05:690c:6106:b0:7b3:a5ae:4232 with SMTP id
 00721157ae682-7c106148405mr91948417b3.50.1778508551491; Mon, 11 May 2026
 07:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <964d54a3-90ce-475e-952f-342bb383f878@gmail.com>
 <CAPDyKFoPjwBeaQKMDf7zrW8hQDZjD89=ChJ_TPf51BG4yonz6w@mail.gmail.com> <9e52c51d-c358-47ad-a2b1-763a348f6c7d@gmail.com>
In-Reply-To: <9e52c51d-c358-47ad-a2b1-763a348f6c7d@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 16:08:33 +0200
X-Gm-Features: AVHnY4LK3mBxhaMAmehqNr3XG86Rccaqhd3sKHhwUFcxhnFndojFHXOY5dsnkJY
Message-ID: <CAPDyKFrCH+x=K+SMCVZuk8TdxhMv5xq49yVT0GSwrSxM68MxrA@mail.gmail.com>
Subject: Re: [PATCH v2] misc: rtsx_usb: reset chip on resume to re-detect card
 after S3
To: Greg S <grigoryya@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rogerable@realtek.com, Ricky Wu <ricky_wu@realtek.com>, 
	Sean Rhodes <sean@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Apr 2026 at 21:42, Greg S <grigoryya@gmail.com> wrote:
>
> On Tue, 7 Apr 2026 at XX:XX, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>  > The patch looks reasonable to me, but perhaps we also need a fixes tag=
?
>
> Good point, thanks. Here is v2 with the Fixes tag added.
>
> ---
>
> [PATCH v2] misc: rtsx_usb: reset chip on resume to re-detect card after S=
3
>
> After S3 suspend the Realtek RTS5129 USB card reader loses its internal
> state, but rtsx_usb_resume() does not reinitialize it =E2=80=94 it only w=
akes up
> child devices.  As a result, the first command sent to the chip after
> resume times out with -ETIMEDOUT and the mmc subsystem never re-detects
> the card.  The SD card (mmcblk0) disappears and does not come back until
> the next full reboot.
>
> rtsx_usb_reset_resume() already handles this correctly by calling
> rtsx_usb_reset_chip() before waking children.  Apply the same logic to
> the regular resume path.
>
> Tested on a laptop with an RTS5129 (0x0bda:0x0129) built-in card reader
> and a 128 GB SDXC card.  Before the patch, mmcblk0 was lost after every
> S3 cycle; after the patch, the card is reliably re-detected on resume.
>
> Fixes: 730876be2566 ("mfd: Add realtek USB card reader driver")
> Signed-off-by: Greg S <grigoryya@gmail.com>

Please re-submit and to add char/misc maintainers so they can pick up
or ack this patch.

Kind regards
Uffe

> ---
> Changes in v2:
>   - Added Fixes tag (Ulf Hansson)
>
>   drivers/misc/cardreader/rtsx_usb.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
>
> diff --git a/drivers/misc/cardreader/rtsx_usb.c
> b/drivers/misc/cardreader/rtsx_usb.c
> index 2b3ae2914ec8..f1a3b5c7e912 100644
> --- a/drivers/misc/cardreader/rtsx_usb.c
> +++ b/drivers/misc/cardreader/rtsx_usb.c
> @@ -732,6 +732,18 @@ static int rtsx_usb_resume_child(struct device
> *dev, void *data)
>
>   static int rtsx_usb_resume(struct usb_interface *intf)
>   {
> +    struct rtsx_ucr *ucr =3D
> +        (struct rtsx_ucr *)usb_get_intfdata(intf);
> +
> +    /* After S3 suspend the chip loses its internal state and needs a fu=
ll
> +     * reset, identical to what reset_resume already does. Without this
> +     * the first command sent to the chip after resume times out
> +     * (-ETIMEDOUT) and the mmc subsystem never re-detects the card
> +     * (mmcblk0 disappears until the next reboot).
> +     *
> +     * Affected: at least RTS5129 on several laptop models.
> +     */
> +    rtsx_usb_reset_chip(ucr);
>       device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
>       return 0;
>   }
> --
> 2.43.0
>
